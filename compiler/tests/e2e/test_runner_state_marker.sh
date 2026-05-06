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
#    verifying the mangling pass observed the import — i.e. it
#    computed at least one import substitution (`import_subs >= 1`).
#    A regression that flipped the default to true would set
#    `safe_imports = []`, the mangling pass would compute
#    `import_subs=0`, and this check would fail — catching the case
#    where timing prints stay off but import stripping fires anyway.
#
#    NOTE on signal choice: pre-issue #306, this assertion used to
#    pin the mangled IR call site (`@add_one__<slug>__sub__helper`).
#    That worked only because the lowering pipeline's silent `i8*`
#    fallback emitted a structurally-invalid `call i8* @add_one(...)`
#    instruction whose return type later became the synthesized
#    declare (a feedback loop on broken IR). Issue #306's Phase A
#    promoted that silent default to a hard error, so when standalone
#    `sfn emit llvm` runs without per-module-built imported function
#    bodies, the call is now intentionally not emitted (the user gets
#    a "cannot resolve return type" diagnostic instead of malformed
#    IR). The mangling pass's own `import_subs` count is the next
#    most direct, post-Phase A signal that the imports list survived
#    the `is_test_module` gate.
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
    if ! SAILFIN_TRACE_LOWERING=1 "$BINARY" emit -o "$SCRATCH/proj3/main.ll" llvm "$SCRATCH/proj3/main.sfn" > "$log" 2>&1; then
        echo "[test]   sfn emit failed:"
        cat "$log"
        return 1
    fi

    # Behavior-changing gate (the load-bearing assertion):
    # the mangling pass saw the import. If `is_test_module` had
    # silently defaulted to true, `safe_imports` would have been
    # cleared and `import_subs` would be 0.
    local import_subs_line
    import_subs_line=$(grep -E '^emit-llvm: mangle import_subs=' "$log" | tail -1 || true)
    if [ -z "$import_subs_line" ]; then
        echo "[test]   missing 'mangle import_subs=' trace line — lowering trace did not run:"
        cat "$log"
        return 1
    fi
    local subs="${import_subs_line##*=}"
    if [ "$subs" -lt 1 ]; then
        echo "[test]   import_subs=$subs (expected >= 1; is_test_module=true regression — imports were stripped):"
        cat "$log"
        return 1
    fi

    # Belt-and-suspenders: the test-runner-active timing prints
    # (gated on the in-process flag, not on SAILFIN_TRACE_LOWERING)
    # should still stay quiet.
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
