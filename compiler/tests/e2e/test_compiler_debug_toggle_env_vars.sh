#!/usr/bin/env bash
# Issue #312: the four trailing internal compiler-diagnostic flag-file
# probes (`build/sailfin/.trace_lowering`, `.trace_call_lowering`,
# `.skip_module_globals`, `.trace_argv`) migrated from `fs.exists` to
# env-var reads. The first three flow through cached probes in
# `compiler/src/llvm/lowering_debug_state.sfn`; `.trace_argv` reads
# `_env_flag` directly at CLI entry.
#
# This test pins three contracts, end-to-end, for every migrated flag:
#
#   1. Each `SAILFIN_*` env var triggers the same stderr signal the
#      legacy file probe did.
#   2. Each toggle is OFF when unset, "0", or "false".
#   3. The legacy `_legacy_flag_file` shim still honours
#      `touch build/sailfin/.X` for one release. Drop the legacy
#      cases when the shim is removed.

set -euo pipefail

BINARY="${1:?usage: test_compiler_debug_toggle_env_vars.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-debug-toggle-XXXXXX)"
trap 'rm -rf "$SCRATCH"' EXIT

# A trivial program that exercises both the lowering trace path
# (function body, expressions, calls) and module-globals lowering
# (module-level binding emits a global init).
cat > "$SCRATCH/probe.sfn" <<'EOF'
let greeting: string = "hi";

fn main() ![io] {
    print(greeting);
}
EOF

run_test() {
    local name="$1"
    shift
    if "$@"; then
        echo "[test] PASS: $name"
        PASS=$((PASS + 1))
    else
        echo "[test] FAIL: $name"
        FAIL=$((FAIL + 1))
    fi
}

# ─────────────────────────────────────────────────────────────────
# Exercise functions
#
# Each "exercise" function takes a stderr-log path as $1 and the
# remaining args as the env-var prefix (e.g. `env SAILFIN_X=1` or
# `env -u SAILFIN_X`). Different toggles trigger via different CLI
# entry points: lowering-side flags are exercised via `emit ... llvm`,
# the cold-path argv flag via any CLI invocation (`--version`).
# ─────────────────────────────────────────────────────────────────

exercise_emit_llvm() {
    local stderr_log="$1"
    shift
    "$@" "$BINARY" emit -o "$SCRATCH/probe.ll" llvm "$SCRATCH/probe.sfn" \
        > /dev/null 2> "$stderr_log"
}

exercise_version() {
    local stderr_log="$1"
    shift
    set +e
    "$@" "$BINARY" --version > /dev/null 2> "$stderr_log"
    local rc=$?
    set -e
    # `--version` exits 0; tolerate 2 in case the seed routes it
    # through the usage-printing path on edge inputs.
    if [ "$rc" -ne 0 ] && [ "$rc" -ne 2 ]; then return $rc; fi
    return 0
}

# ─────────────────────────────────────────────────────────────────
# Generic toggle-contract assertions
# ─────────────────────────────────────────────────────────────────

# Verify the stderr signal fires when the env var is set to "1".
# Optionally takes an extra env prefix (used by .skip_module_globals
# which needs SAILFIN_TRACE_LOWERING=1 to surface its diagnostic).
assert_env_on_fires() {
    local label="$1" env_var="$2" signal="$3" exercise="$4" extra="${5:-}"
    local log="$SCRATCH/${label}_on.log"
    if ! "$exercise" "$log" env $extra "${env_var}=1"; then
        echo "[test]   $label exercise failed under ${env_var}=1:"
        cat "$log"
        return 1
    fi
    if ! grep -q "$signal" "$log"; then
        echo "[test]   expected '$signal' under ${env_var}=1:"
        head -20 "$log"
        return 1
    fi
    return 0
}

# Verify the stderr signal does NOT fire when the env var is unset,
# "0", or "false". The contract per `_env_flag`: a toggle is on when
# the value is set to anything other than "", "0", or "false".
assert_env_off_matrix() {
    local label="$1" env_var="$2" signal="$3" exercise="$4" extra="${5:-}"
    for case in "unset" "zero" "false"; do
        local log="$SCRATCH/${label}_off_${case}.log"
        # GNU env parses options strictly before NAME=VALUE pairs, so
        # `-u VAR` must come before `$extra` (which holds NAME=VALUE
        # cases for the dependent flag). Likewise the under-test
        # `env_var=...` must come after `-u $env_var` (otherwise -u
        # would clear what we just set).
        local prefix
        case "$case" in
            unset) prefix="env -u $env_var $extra" ;;
            zero)  prefix="env -u $env_var $extra ${env_var}=0" ;;
            false) prefix="env -u $env_var $extra ${env_var}=false" ;;
        esac
        if ! "$exercise" "$log" $prefix; then
            echo "[test]   $label exercise failed in '$case' case:"
            cat "$log"
            return 1
        fi
        if grep -q "$signal" "$log"; then
            echo "[test]   $label fired in '$case' case (should be off):"
            head -20 "$log"
            return 1
        fi
    done
    return 0
}

# Verify `touch build/sailfin/.X` still triggers the toggle for the
# one-release back-compat window. Drop these when the shim is removed.
assert_legacy_file_works() {
    local label="$1" marker_path="$2" env_var="$3" signal="$4" exercise="$5" extra="${6:-}"
    mkdir -p build/sailfin
    local pre_existed=0
    if [ -f "$marker_path" ]; then pre_existed=1; fi
    touch "$marker_path"
    local log="$SCRATCH/${label}_legacy.log"
    local rc=0
    # `-u` before NAME=VALUE per GNU env option-parsing rules.
    if ! "$exercise" "$log" env -u "$env_var" $extra; then rc=1; fi
    if [ "$pre_existed" = "0" ]; then rm -f "$marker_path"; fi
    if [ "$rc" -ne 0 ]; then
        echo "[test]   exercise failed under legacy file probe ($marker_path):"
        cat "$log"
        return 1
    fi
    if ! grep -q "$signal" "$log"; then
        echo "[test]   legacy file probe ($marker_path) didn't trigger $label:"
        head -20 "$log"
        return 1
    fi
    return 0
}

# ─────────────────────────────────────────────────────────────────
# Per-flag binding: (label, env_var, marker, signal, exercise, extra_env_for_signal)
#
# `extra_env_for_signal` is used only when the diagnostic is gated
# on a second flag (today: `.skip_module_globals` requires
# `SAILFIN_TRACE_LOWERING=1` to surface the "skipping module globals"
# stderr line). Inert for the other three.
# ─────────────────────────────────────────────────────────────────

# 1. SAILFIN_TRACE_LOWERING — 11 hot probe sites
test_trace_lowering_env_on() {
    assert_env_on_fires \
        "trace_lowering" "SAILFIN_TRACE_LOWERING" "emit-llvm: phase=start" exercise_emit_llvm
}
test_trace_lowering_env_off_matrix() {
    assert_env_off_matrix \
        "trace_lowering" "SAILFIN_TRACE_LOWERING" "emit-llvm: phase=start" exercise_emit_llvm
}
test_trace_lowering_legacy_file() {
    assert_legacy_file_works \
        "trace_lowering" "build/sailfin/.trace_lowering" "SAILFIN_TRACE_LOWERING" \
        "emit-llvm: phase=start" exercise_emit_llvm
}

# 2. SAILFIN_TRACE_CALL_LOWERING — 2 hot probe sites
test_trace_call_lowering_env_on() {
    assert_env_on_fires \
        "trace_call_lowering" "SAILFIN_TRACE_CALL_LOWERING" "call_lowering: target=" exercise_emit_llvm
}
test_trace_call_lowering_env_off_matrix() {
    assert_env_off_matrix \
        "trace_call_lowering" "SAILFIN_TRACE_CALL_LOWERING" "call_lowering: target=" exercise_emit_llvm
}
test_trace_call_lowering_legacy_file() {
    assert_legacy_file_works \
        "trace_call_lowering" "build/sailfin/.trace_call_lowering" "SAILFIN_TRACE_CALL_LOWERING" \
        "call_lowering: target=" exercise_emit_llvm
}

# 3. SAILFIN_SKIP_MODULE_GLOBALS — behavior-changing, diagnostic
#    is gated on SAILFIN_TRACE_LOWERING=1 surfacing the message.
test_skip_module_globals_env_on() {
    assert_env_on_fires \
        "skip_module_globals" "SAILFIN_SKIP_MODULE_GLOBALS" "skipping module globals" \
        exercise_emit_llvm "SAILFIN_TRACE_LOWERING=1"
}
test_skip_module_globals_env_off_matrix() {
    assert_env_off_matrix \
        "skip_module_globals" "SAILFIN_SKIP_MODULE_GLOBALS" "skipping module globals" \
        exercise_emit_llvm "SAILFIN_TRACE_LOWERING=1"
}
test_skip_module_globals_legacy_file() {
    assert_legacy_file_works \
        "skip_module_globals" "build/sailfin/.skip_module_globals" "SAILFIN_SKIP_MODULE_GLOBALS" \
        "skipping module globals" exercise_emit_llvm "SAILFIN_TRACE_LOWERING=1"
}

# 4. SAILFIN_TRACE_ARGV — cold-path direct _env_flag read at CLI entry
test_trace_argv_env_on() {
    assert_env_on_fires \
        "trace_argv" "SAILFIN_TRACE_ARGV" "^cli: argv.len=" exercise_version
}
test_trace_argv_env_off_matrix() {
    assert_env_off_matrix \
        "trace_argv" "SAILFIN_TRACE_ARGV" "^cli: argv.len=" exercise_version
}
test_trace_argv_legacy_file() {
    assert_legacy_file_works \
        "trace_argv" "build/sailfin/.trace_argv" "SAILFIN_TRACE_ARGV" \
        "^cli: argv.len=" exercise_version
}

# ─────────────────────────────────────────────────────────────────
# Acceptance grep — the issue's exit criterion: zero remaining
# fs.exists("build/sailfin/.X") probes for the migrated flag families.
# ─────────────────────────────────────────────────────────────────

test_no_remaining_fs_exists_probes() {
    local matches
    matches="$(grep -rnE 'fs\.exists\("build/sailfin/\.(phase|skip|trace|dump)_' compiler/src/ \
        | grep -v '^[^:]*:[0-9]*://' \
        | grep -v _legacy_flag_file \
        || true)"
    if [ -n "$matches" ]; then
        echo "[test]   leftover fs.exists probes:"
        echo "$matches"
        return 1
    fi
    return 0
}

# ─────────────────────────────────────────────────────────────────
# Run matrix
# ─────────────────────────────────────────────────────────────────

run_test "SAILFIN_TRACE_LOWERING=1 fires"                    test_trace_lowering_env_on
run_test "SAILFIN_TRACE_LOWERING off (unset/0/false)"        test_trace_lowering_env_off_matrix
run_test ".trace_lowering legacy file probe (back-compat)"   test_trace_lowering_legacy_file

run_test "SAILFIN_TRACE_CALL_LOWERING=1 fires"               test_trace_call_lowering_env_on
run_test "SAILFIN_TRACE_CALL_LOWERING off (unset/0/false)"   test_trace_call_lowering_env_off_matrix
run_test ".trace_call_lowering legacy file (back-compat)"    test_trace_call_lowering_legacy_file

run_test "SAILFIN_SKIP_MODULE_GLOBALS=1 fires"               test_skip_module_globals_env_on
run_test "SAILFIN_SKIP_MODULE_GLOBALS off (unset/0/false)"   test_skip_module_globals_env_off_matrix
run_test ".skip_module_globals legacy file (back-compat)"    test_skip_module_globals_legacy_file

run_test "SAILFIN_TRACE_ARGV=1 fires"                        test_trace_argv_env_on
run_test "SAILFIN_TRACE_ARGV off (unset/0/false)"            test_trace_argv_env_off_matrix
run_test ".trace_argv legacy file (back-compat)"             test_trace_argv_legacy_file

run_test "no remaining fs.exists flag-file probes"           test_no_remaining_fs_exists_probes

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
