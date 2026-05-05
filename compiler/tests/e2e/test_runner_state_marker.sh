#!/usr/bin/env bash
# Issue #311: the test-runner marker that used to live at
# `build/sailfin/.test_runner_active` was migrated to in-process
# state in `compiler/src/test_runner_state.sfn`. This test pins
# three contracts of that migration:
#
#   1. `sfn test` no longer writes the legacy file marker.
#      A `.test_runner_active` file appearing at any point during
#      a test run would mean the migration regressed.
#   2. `SAILFIN_TRACE_TEST_RUNNER=1 sfn test ...` still produces
#      the orchestrator + LLVM lowering trace prints — that is the
#      observable behavior the file probes used to gate.
#   3. `sfn emit llvm` invoked from a clean shell is_test_module=
#      false. If `test_runner_active()` ever returned true outside
#      a `sfn test` invocation (e.g. because module-level mut state
#      was being initialised wrong), the lowering pipeline would
#      treat user code as a test module and silently strip imports.

set -euo pipefail

BINARY="${1:?usage: test_runner_state_marker.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-runner-state-XXXXXX)"
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

# 1. `sfn test` does not create a `.test_runner_active` file.
#    Pre-#311 the orchestrator wrote this marker on entry and
#    deleted it at every exit; post-#311 the marker is process-
#    local memory. If a regression re-introduces the file write,
#    this catches it.
test_no_legacy_marker_file() {
    mkdir -p "$SCRATCH/proj"
    cat > "$SCRATCH/proj/smoke_test.sfn" <<'EOF'
test "marker e2e smoke" {
    assert 1 + 1 == 2;
}
EOF
    # Remove any stale marker before the run so a leftover file
    # from a previous unrelated run can't pass this test.
    rm -f "$SCRATCH/proj/build/sailfin/.test_runner_active"

    local log="$SCRATCH/test.log"
    pushd "$SCRATCH/proj" >/dev/null
    if ! "$BINARY" test "$SCRATCH/proj" > "$log" 2>&1; then
        popd >/dev/null
        echo "[test]   sfn test failed:"
        cat "$log"
        return 1
    fi
    popd >/dev/null

    if [ -f "$SCRATCH/proj/build/sailfin/.test_runner_active" ]; then
        echo "[test]   .test_runner_active file should not exist after sfn test:"
        ls -la "$SCRATCH/proj/build/sailfin/.test_runner_active"
        return 1
    fi
    if ! grep -q "PASS" "$log"; then
        echo "[test]   sfn test should have run the test successfully:"
        cat "$log"
        return 1
    fi
    return 0
}

# 2. `SAILFIN_TRACE_TEST_RUNNER=1 sfn test ...` still produces
#    the orchestrator + LLVM lowering trace prints. The trace
#    flag is now read once by the orchestrator and threaded
#    through `enter_test_runner_mode(trace)`; both sides read
#    from the same in-process boolean. A regression where
#    `test_runner_trace()` returned false would silently swallow
#    the lowering-side trace lines.
test_trace_env_var_propagates_to_lowering() {
    mkdir -p "$SCRATCH/proj2"
    cat > "$SCRATCH/proj2/smoke_test.sfn" <<'EOF'
test "trace e2e smoke" {
    assert 2 + 2 == 4;
}
EOF
    local log="$SCRATCH/trace.log"
    pushd "$SCRATCH/proj2" >/dev/null
    if ! SAILFIN_TRACE_TEST_RUNNER=1 "$BINARY" test "$SCRATCH/proj2" > "$log" 2>&1; then
        popd >/dev/null
        echo "[test]   sfn test failed under SAILFIN_TRACE_TEST_RUNNER=1:"
        cat "$log"
        return 1
    fi
    popd >/dev/null

    # Orchestrator-side trace (cli_commands.sfn).
    if ! grep -q "test runner: compile start" "$log"; then
        echo "[test]   missing orchestrator-side trace 'test runner: compile start':"
        cat "$log"
        return 1
    fi
    # LLVM-lowering-side trace (lowering_core.sfn). This is the
    # signal that test_runner_trace() returned true on the lowering
    # hot path — i.e. the in-process boolean was set by the
    # orchestrator and observed by the lowering pipeline.
    if ! grep -q "test llvm:" "$log"; then
        echo "[test]   missing LLVM-lowering trace 'test llvm:' — in-process trace flag did not propagate:"
        cat "$log"
        return 1
    fi
    return 0
}

# 3. Outside of `sfn test`, the in-process flag stays false AND
#    the behavior-changing `is_test_module` gate that it controls
#    stays off. The gate's effect is `safe_imports = []` in
#    `lowering_core.sfn`, which strips cross-module symbol mangling
#    so imported function calls remain bare-named. Pin the gate by
#    emitting a non-test source that imports a sibling helper and
#    verifying the helper's call site uses the mangled cross-module
#    symbol. A regression that flipped the default to true would
#    leave the call unmangled (or drop the `declare` for the
#    imported function entirely), and this check would fail —
#    catching the case where timing prints stay off but import
#    stripping fires anyway.
test_in_process_flag_default_false() {
    mkdir -p "$SCRATCH/proj3/sub"
    cat > "$SCRATCH/proj3/sub/helper.sfn" <<'EOF'
fn add_one(x: number) -> number {
    return x + 1;
}
EOF
    cat > "$SCRATCH/proj3/main.sfn" <<'EOF'
import { add_one } from "./sub/helper";

fn main() ![io] {
    let result = add_one(41);
    print.info(number_to_string(result));
}
EOF
    local log="$SCRATCH/emit.log"
    if ! "$BINARY" emit -o "$SCRATCH/proj3/main.ll" llvm "$SCRATCH/proj3/main.sfn" > "$log" 2>&1; then
        echo "[test]   sfn emit failed:"
        cat "$log"
        return 1
    fi

    # Behavior-changing gate (the load-bearing assertion):
    # cross-module symbol mangling fired — the call to the imported
    # helper points at the mangled name, not the bare `add_one`.
    # We don't pin the LLVM return type here (the seed compiler
    # falls back to i8* when the helper module's layout manifest
    # isn't pre-staged); the mangled suffix `__sub__helper` is the
    # gate-firing signal we actually care about.
    if ! grep -qE '@add_one__[A-Za-z0-9_]*sub__helper' "$SCRATCH/proj3/main.ll"; then
        echo "[test]   imported helper call was not mangled (is_test_module=true regression — imports were stripped):"
        echo "[test]   --- emitted IR (lines containing 'add_one') ---"
        grep -nE 'add_one' "$SCRATCH/proj3/main.ll" || true
        return 1
    fi
    # The mangled `declare` for the imported helper must also be
    # present; without it, the bitcode would link with an undefined
    # reference. Stripped imports drop this declare entirely.
    if ! grep -qE '^declare [^@]*@add_one__[A-Za-z0-9_]*sub__helper' "$SCRATCH/proj3/main.ll"; then
        echo "[test]   imported helper declare missing from emitted IR:"
        grep -nE 'add_one|declare' "$SCRATCH/proj3/main.ll" | head -20 || true
        return 1
    fi

    # Belt-and-suspenders: the trace/timing prints reserved for
    # test-runner-active modules should also stay quiet.
    if grep -q "^test llvm: phase=" "$log"; then
        echo "[test]   in-process test-runner flag should be false outside sfn test:"
        cat "$log"
        return 1
    fi
    return 0
}

run_test "sfn test does not create .test_runner_active marker file" test_no_legacy_marker_file
run_test "SAILFIN_TRACE_TEST_RUNNER=1 propagates to LLVM lowering" test_trace_env_var_propagates_to_lowering
run_test "in-process flag defaults to false outside sfn test"      test_in_process_flag_default_false

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
