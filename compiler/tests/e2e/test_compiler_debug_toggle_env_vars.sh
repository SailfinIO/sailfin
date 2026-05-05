#!/usr/bin/env bash
# Issue #312: the four trailing internal compiler-diagnostic flag-file
# probes (`build/sailfin/.trace_lowering`, `.trace_call_lowering`,
# `.skip_module_globals`, `.trace_argv`) migrated from `fs.exists` to
# env-var reads. The first three flow through cached probes in
# `compiler/src/llvm/lowering_debug_state.sfn`; `.trace_argv` reads
# `_env_flag` directly at CLI entry.
#
# This test pins three contracts:
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

# Run `emit ... llvm <probe.sfn>`, capturing stderr separately.
emit_llvm() {
    local out_ll="$SCRATCH/probe.ll"
    local stderr_log="$1"
    shift
    "$@" "$BINARY" emit -o "$out_ll" llvm "$SCRATCH/probe.sfn" > /dev/null 2> "$stderr_log"
}

# ─────────────────────────────────────────────────────────────────
# 1. SAILFIN_TRACE_LOWERING — the highest-volume flag (11 hot sites)
# ─────────────────────────────────────────────────────────────────

test_trace_lowering_on_via_env() {
    local log="$SCRATCH/trace_on.log"
    if ! emit_llvm "$log" env SAILFIN_TRACE_LOWERING=1; then
        echo "[test]   emit failed under SAILFIN_TRACE_LOWERING=1:"
        cat "$log"; return 1
    fi
    if ! grep -q "emit-llvm: phase=start" "$log"; then
        echo "[test]   expected 'emit-llvm: phase=start' under SAILFIN_TRACE_LOWERING=1:"
        head -20 "$log"
        return 1
    fi
    return 0
}

test_trace_lowering_off_by_default() {
    local log="$SCRATCH/trace_off.log"
    if ! emit_llvm "$log" env -u SAILFIN_TRACE_LOWERING; then
        cat "$log"; return 1
    fi
    if grep -q "emit-llvm: phase=start" "$log"; then
        echo "[test]   trace fired with env unset:"
        head -20 "$log"; return 1
    fi
    # "0" and "false" must also be off.
    if ! emit_llvm "$log" env SAILFIN_TRACE_LOWERING=0; then
        cat "$log"; return 1
    fi
    if grep -q "emit-llvm: phase=start" "$log"; then
        echo "[test]   trace fired with env='0':"
        head -20 "$log"; return 1
    fi
    if ! emit_llvm "$log" env SAILFIN_TRACE_LOWERING=false; then
        cat "$log"; return 1
    fi
    if grep -q "emit-llvm: phase=start" "$log"; then
        echo "[test]   trace fired with env='false':"
        head -20 "$log"; return 1
    fi
    return 0
}

# Back-compat: legacy file probe still honours `touch build/sailfin/.X`.
# Drop when the shim is removed in the post-#312 release.
test_trace_lowering_legacy_file_probe() {
    mkdir -p build/sailfin
    local marker="build/sailfin/.trace_lowering"
    local pre_existed=0
    if [ -f "$marker" ]; then pre_existed=1; fi
    touch "$marker"
    local log="$SCRATCH/trace_legacy.log"
    set +e
    emit_llvm "$log" env -u SAILFIN_TRACE_LOWERING
    local rc=$?
    set -e
    if [ "$pre_existed" = "0" ]; then rm -f "$marker"; fi
    if [ "$rc" -ne 0 ]; then
        echo "[test]   emit failed under legacy file probe:"
        cat "$log"; return 1
    fi
    if ! grep -q "emit-llvm: phase=start" "$log"; then
        echo "[test]   legacy file probe didn't trigger trace:"
        head -20 "$log"; return 1
    fi
    return 0
}

# ─────────────────────────────────────────────────────────────────
# 2. SAILFIN_TRACE_CALL_LOWERING — call-lowering path
# ─────────────────────────────────────────────────────────────────

test_trace_call_lowering_on_via_env() {
    local log="$SCRATCH/call_trace_on.log"
    if ! emit_llvm "$log" env SAILFIN_TRACE_CALL_LOWERING=1; then
        echo "[test]   emit failed under SAILFIN_TRACE_CALL_LOWERING=1:"
        cat "$log"; return 1
    fi
    if ! grep -q "call_lowering: target=" "$log"; then
        echo "[test]   expected 'call_lowering: target=' line:"
        head -20 "$log"; return 1
    fi
    return 0
}

test_trace_call_lowering_off_by_default() {
    local log="$SCRATCH/call_trace_off.log"
    if ! emit_llvm "$log" env -u SAILFIN_TRACE_CALL_LOWERING; then
        cat "$log"; return 1
    fi
    if grep -q "call_lowering: target=" "$log"; then
        echo "[test]   call trace fired with env unset:"
        head -20 "$log"; return 1
    fi
    return 0
}

# ─────────────────────────────────────────────────────────────────
# 3. SAILFIN_SKIP_MODULE_GLOBALS — behavior-changing toggle
# ─────────────────────────────────────────────────────────────────

test_skip_module_globals_on_via_env() {
    # The skip notice is gated on `debug_lowering`, so we set both
    # SAILFIN_SKIP_MODULE_GLOBALS and SAILFIN_TRACE_LOWERING and
    # look for the skip stderr line.
    local log="$SCRATCH/skip_globals.log"
    if ! emit_llvm "$log" env SAILFIN_SKIP_MODULE_GLOBALS=1 SAILFIN_TRACE_LOWERING=1; then
        echo "[test]   emit failed under SAILFIN_SKIP_MODULE_GLOBALS=1:"
        cat "$log"; return 1
    fi
    if ! grep -q "skipping module globals" "$log"; then
        echo "[test]   expected 'skipping module globals' notice:"
        head -40 "$log"; return 1
    fi
    return 0
}

test_skip_module_globals_off_by_default() {
    local log="$SCRATCH/skip_off.log"
    if ! emit_llvm "$log" env -u SAILFIN_SKIP_MODULE_GLOBALS SAILFIN_TRACE_LOWERING=1; then
        cat "$log"; return 1
    fi
    if grep -q "skipping module globals" "$log"; then
        echo "[test]   skip fired with env unset:"
        head -20 "$log"; return 1
    fi
    return 0
}

# ─────────────────────────────────────────────────────────────────
# 4. SAILFIN_TRACE_ARGV — cold-path direct _env_flag read at CLI entry
# ─────────────────────────────────────────────────────────────────

test_trace_argv_on_via_env() {
    local log="$SCRATCH/argv_on.log"
    set +e
    SAILFIN_TRACE_ARGV=1 "$BINARY" --version > /dev/null 2> "$log"
    local rc=$?
    set -e
    # `--version` succeeds without dispatching a subcommand; we only
    # need stderr to contain the argv trace.
    if [ "$rc" -ne 0 ] && [ "$rc" -ne 2 ]; then
        echo "[test]   --version exited with unexpected rc=$rc:"
        cat "$log"; return 1
    fi
    if ! grep -q "^cli: argv.len=" "$log"; then
        echo "[test]   expected 'cli: argv.len=' under SAILFIN_TRACE_ARGV=1:"
        head -10 "$log"; return 1
    fi
    return 0
}

test_trace_argv_off_by_default() {
    local log="$SCRATCH/argv_off.log"
    set +e
    env -u SAILFIN_TRACE_ARGV "$BINARY" --version > /dev/null 2> "$log"
    set -e
    if grep -q "^cli: argv.len=" "$log"; then
        echo "[test]   argv trace fired with env unset:"
        head -10 "$log"; return 1
    fi
    return 0
}

# ─────────────────────────────────────────────────────────────────
# 5. Acceptance grep — the issue's exit criterion: zero remaining
#    fs.exists("build/sailfin/.X") probes for the migrated flags.
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

run_test "SAILFIN_TRACE_LOWERING=1 fires the trace"        test_trace_lowering_on_via_env
run_test "SAILFIN_TRACE_LOWERING off (unset/0/false)"      test_trace_lowering_off_by_default
run_test "legacy .trace_lowering file probe (back-compat)" test_trace_lowering_legacy_file_probe
run_test "SAILFIN_TRACE_CALL_LOWERING=1 fires the trace"   test_trace_call_lowering_on_via_env
run_test "SAILFIN_TRACE_CALL_LOWERING off by default"      test_trace_call_lowering_off_by_default
run_test "SAILFIN_SKIP_MODULE_GLOBALS=1 skips emission"    test_skip_module_globals_on_via_env
run_test "SAILFIN_SKIP_MODULE_GLOBALS off by default"      test_skip_module_globals_off_by_default
run_test "SAILFIN_TRACE_ARGV=1 prints argv at entry"       test_trace_argv_on_via_env
run_test "SAILFIN_TRACE_ARGV off by default"               test_trace_argv_off_by_default
run_test "no remaining fs.exists flag-file probes"         test_no_remaining_fs_exists_probes

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
