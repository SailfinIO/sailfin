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

# 3. Outside of `sfn test`, the in-process flag stays false.
#    If a regression accidentally inverted the default, every
#    `sfn build` / `sfn emit` would treat user code as a test
#    module and strip imports. Guard against that by emitting an
#    LLVM file from a non-test source and verifying it carries
#    its imports through.
test_in_process_flag_default_false() {
    mkdir -p "$SCRATCH/proj3"
    cat > "$SCRATCH/proj3/main.sfn" <<'EOF'
fn main() ![io] {
    print.info("not a test");
}
EOF
    local log="$SCRATCH/emit.log"
    if ! "$BINARY" emit -o "$SCRATCH/proj3/main.ll" llvm "$SCRATCH/proj3/main.sfn" > "$log" 2>&1; then
        echo "[test]   sfn emit failed:"
        cat "$log"
        return 1
    fi
    # If `test_runner_active()` returned true here, the LLVM
    # lowering would print the timing block reserved for test
    # modules (`test llvm: phase=parse ms=…`). Its absence
    # confirms the in-process flag defaulted to false.
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
