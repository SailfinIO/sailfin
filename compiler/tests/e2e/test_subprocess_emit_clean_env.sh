#!/usr/bin/env bash
# Issue #308: when the parent compiler spawns a child compiler to
# emit a runtime sfn-source at link time, the child must NOT
# inherit the parent's debug-toggle env vars. Pre-#308 the toggles
# were `build/sailfin/.foo` flag files probed via `fs.exists()` —
# the child shared the parent's cwd and silently picked up parent
# state.
#
# Post-#308 the toggles live in env vars (`SAILFIN_TRACE_EMIT`,
# `SAILFIN_SKIP_TYPECHECK`, `SAILFIN_TRACE_TEST_RUNNER`,
# `SAILFIN_DUMP_TEST_SOURCES`), and `_compile_runtime_sfn_sources`
# in `compiler/src/cli_main.sfn` wraps the child invocation in
# `sh -c "VAR= <self> emit ..."` to clear each toggle for the
# child. This test pins that contract: when the parent runs with
# `SAILFIN_TRACE_EMIT=1`, the child it spawns emits silently.
#
# It also pins the env-var read-side contract for the toggles
# themselves (set, empty, unset all behave correctly through
# `_env_flag` → `_get_env_cmd` → `sailfin_runtime_shell_capture`).

set -euo pipefail

BINARY="${1:?usage: test_subprocess_emit_clean_env.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-env-isolation-XXXXXX)"
trap 'rm -rf "$SCRATCH"' EXIT

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

# 1. Reading env vars: the underlying mechanism must distinguish
#    set / empty / unset cleanly. Sailfin probes via popen on
#    `printf '%s' "$VAR"` so `unset` and `=""` both yield empty.
test_env_read_set_unset() {
    cat > "$SCRATCH/probe.sfn" <<'EOF'
extern fn sailfin_runtime_shell_capture(cmd: * u8) -> * u8;

fn read_env(name: string) -> string ![io] {
    return sailfin_runtime_shell_capture("printf '%s' \"$" + name + "\"");
}

fn main() ![io] {
    let v_set = read_env("SAILFIN_PROBE_SET");
    let v_empty = read_env("SAILFIN_PROBE_EMPTY");
    let v_unset = read_env("SAILFIN_PROBE_UNSET");
    print("set=" + v_set);
    print("empty.length=" + number_to_string(v_empty.length));
    print("unset.length=" + number_to_string(v_unset.length));
}
EOF
    local log="$SCRATCH/probe.log"
    if ! SAILFIN_PROBE_SET="hello" SAILFIN_PROBE_EMPTY="" "$BINARY" run "$SCRATCH/probe.sfn" > "$log" 2>&1; then
        echo "[test]   probe.sfn failed to run:"
        cat "$log"
        return 1
    fi
    if ! grep -q "^set=hello$" "$log"; then
        echo "[test]   set var not read correctly:"
        cat "$log"
        return 1
    fi
    if ! grep -q "^empty.length=0$" "$log"; then
        echo "[test]   empty var not distinguishable from unset:"
        cat "$log"
        return 1
    fi
    if ! grep -q "^unset.length=0$" "$log"; then
        echo "[test]   unset var not zero-length:"
        cat "$log"
        return 1
    fi
    return 0
}

# 2. Child env clearing: when a parent runs `sh -c "VAR= child"`,
#    the child sees the cleared value, not the parent's value.
#    This is the propagation primitive `_compile_runtime_sfn_sources`
#    relies on. Build a tiny Sailfin program that reads
#    SAILFIN_TRACE_EMIT and prints it, then a parent that spawns
#    that child via sh -c with the var explicitly cleared.
test_child_env_cleared_via_sh_c() {
    cat > "$SCRATCH/child.sfn" <<'EOF'
extern fn sailfin_runtime_shell_capture(cmd: * u8) -> * u8;

fn read_env(name: string) -> string ![io] {
    return sailfin_runtime_shell_capture("printf '%s' \"$" + name + "\"");
}

fn main() ![io] {
    let v = read_env("SAILFIN_TRACE_EMIT");
    if v.length == 0 { print("CHILD:cleared"); }
    else { print("CHILD:inherited=" + v); }
}
EOF
    if ! "$BINARY" build "$SCRATCH/child.sfn" -o "$SCRATCH/child_bin" > "$SCRATCH/child_build.log" 2>&1; then
        echo "[test]   failed to build child.sfn:"
        cat "$SCRATCH/child_build.log"
        return 1
    fi

    cat > "$SCRATCH/parent.sfn" <<EOF
fn main() ![io] {
    // Inherits parent's SAILFIN_TRACE_EMIT (should print "inherited=…").
    let rc1 = process.run(["$SCRATCH/child_bin"]);
    print("rc1=" + number_to_string(rc1));
    // Cleared via sh -c (post-#308 pattern, should print "cleared").
    let rc2 = process.run(["sh", "-c", "SAILFIN_TRACE_EMIT= $SCRATCH/child_bin"]);
    print("rc2=" + number_to_string(rc2));
}
EOF
    local log="$SCRATCH/parent.log"
    if ! SAILFIN_TRACE_EMIT="parent_val" "$BINARY" run "$SCRATCH/parent.sfn" > "$log" 2>&1; then
        echo "[test]   parent.sfn failed to run:"
        cat "$log"
        return 1
    fi
    # The first child invocation (argv only) inherits the parent's env.
    if ! grep -q "^CHILD:inherited=parent_val$" "$log"; then
        echo "[test]   first child should have inherited parent_val:"
        cat "$log"
        return 1
    fi
    # The second child invocation (sh -c with VAR=) sees it cleared.
    if ! grep -q "^CHILD:cleared$" "$log"; then
        echo "[test]   second child should have seen cleared SAILFIN_TRACE_EMIT:"
        cat "$log"
        return 1
    fi
    return 0
}

# 3. Toggle migration is end-to-end wired: setting the env var
#    triggers the same behavior the legacy file probe did. Use
#    SAILFIN_SKIP_TYPECHECK as the smoke target — when set, the
#    `emit-llvm` pipeline skips typecheck and prints the
#    `emit-llvm: skipping typecheck` notice from `main.sfn`.
test_skip_typecheck_via_env_var() {
    cat > "$SCRATCH/typed.sfn" <<'EOF'
fn main() ![io] {
    print.info("typed");
}
EOF
    local log="$SCRATCH/skip.log"
    if ! SAILFIN_SKIP_TYPECHECK=1 "$BINARY" emit -o "$SCRATCH/typed.ll" llvm "$SCRATCH/typed.sfn" > "$log" 2>&1; then
        echo "[test]   emit failed under SAILFIN_SKIP_TYPECHECK=1:"
        cat "$log"
        return 1
    fi
    if ! grep -q "skipping typecheck" "$log"; then
        echo "[test]   expected 'skipping typecheck' notice when SAILFIN_SKIP_TYPECHECK=1:"
        cat "$log"
        return 1
    fi
    return 0
}

# 4. Toggle is OFF by default and when set to "0" / "false".
test_skip_typecheck_off_default_and_falsey() {
    cat > "$SCRATCH/typed.sfn" <<'EOF'
fn main() ![io] {
    print.info("typed");
}
EOF
    # Unset.
    local log="$SCRATCH/off.log"
    if ! "$BINARY" emit -o "$SCRATCH/typed.ll" llvm "$SCRATCH/typed.sfn" > "$log" 2>&1; then
        cat "$log"; return 1
    fi
    if grep -q "skipping typecheck" "$log"; then
        echo "[test]   typecheck should NOT be skipped when env var unset:"
        cat "$log"
        return 1
    fi
    # "0".
    if ! SAILFIN_SKIP_TYPECHECK=0 "$BINARY" emit -o "$SCRATCH/typed.ll" llvm "$SCRATCH/typed.sfn" > "$log" 2>&1; then
        cat "$log"; return 1
    fi
    if grep -q "skipping typecheck" "$log"; then
        echo "[test]   typecheck should NOT be skipped when env var = '0':"
        cat "$log"
        return 1
    fi
    # "false".
    if ! SAILFIN_SKIP_TYPECHECK=false "$BINARY" emit -o "$SCRATCH/typed.ll" llvm "$SCRATCH/typed.sfn" > "$log" 2>&1; then
        cat "$log"; return 1
    fi
    if grep -q "skipping typecheck" "$log"; then
        echo "[test]   typecheck should NOT be skipped when env var = 'false':"
        cat "$log"
        return 1
    fi
    return 0
}

# 5. Back-compat: legacy file probe still triggers the toggle for
#    one release. Drop this test alongside the file shim removal.
test_legacy_file_probe_still_works() {
    cat > "$SCRATCH/typed.sfn" <<'EOF'
fn main() ![io] {
    print.info("typed");
}
EOF
    mkdir -p build/sailfin
    local marker="build/sailfin/.skip_typecheck"
    local pre_existed=0
    if [ -f "$marker" ]; then pre_existed=1; fi
    touch "$marker"
    local log="$SCRATCH/legacy.log"
    set +e
    "$BINARY" emit -o "$SCRATCH/typed.ll" llvm "$SCRATCH/typed.sfn" > "$log" 2>&1
    local rc=$?
    set -e
    if [ "$pre_existed" = "0" ]; then rm -f "$marker"; fi
    if [ "$rc" -ne 0 ]; then
        echo "[test]   emit failed under legacy file probe:"
        cat "$log"
        return 1
    fi
    if ! grep -q "skipping typecheck" "$log"; then
        echo "[test]   legacy file probe didn't trigger toggle:"
        cat "$log"
        return 1
    fi
    return 0
}

run_test "env reads distinguish set/empty/unset"           test_env_read_set_unset
run_test "child env can be cleared via sh -c"              test_child_env_cleared_via_sh_c
run_test "SAILFIN_SKIP_TYPECHECK=1 triggers the toggle"    test_skip_typecheck_via_env_var
run_test "toggle is off by default and on '0'/'false'"     test_skip_typecheck_off_default_and_falsey
run_test "legacy file probe still works (back-compat)"     test_legacy_file_probe_still_works

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
