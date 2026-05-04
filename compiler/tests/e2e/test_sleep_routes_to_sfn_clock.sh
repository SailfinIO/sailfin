#!/usr/bin/env bash
# Migration sentinel: pin that user-program sleep(N) call sites
# lower to @sfn_sleep (the Sailfin-native wrapper in
# runtime/sfn/clock.sfn) and NOT to the C entrypoint
# @sailfin_runtime_sleep directly.
#
# This test exists so a future change to the runtime helper
# registry that accidentally reverts the symbol field for the
# `sleep` / `runtime_sleep_fn` descriptors fails immediately
# rather than silently moving the call path back into the C
# runtime.
#
# When the C trampoline is finally retired (PR 2 of the sleep
# migration, gated on Q7 — opaque-handle sizing), this test
# stays correct: the user-program call site is still
# `@sfn_sleep`, only the wrapper's body changes from
# `sailfin_runtime_sleep(...)` to `nanosleep(...)`.

set -euo pipefail

BINARY="${1:?usage: test_sleep_routes_to_sfn_clock.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-sleep-routing-XXXXXX)"
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

test_call_routes_to_sfn_sleep() {
    cat > "$SCRATCH/sleep_caller.sfn" <<'EOF'
fn main() ![io, clock] {
    sleep(0);
}
EOF
    local ll="$SCRATCH/sleep_caller.ll"
    local log="$SCRATCH/emit.log"
    if ! "$BINARY" emit -o "$ll" llvm "$SCRATCH/sleep_caller.sfn" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on sleep_caller.sfn:"
        cat "$log"
        return 1
    fi

    local missing=0
    if ! grep -qE "call void @sfn_sleep\(" "$ll"; then
        echo "[test]   user-program sleep(0) did NOT lower to @sfn_sleep"
        echo "[test]   IR snippet:"
        grep -E "@sfn_sleep|@sailfin_runtime_sleep" "$ll" || echo "[test]   (no sleep symbols at all)"
        missing=$((missing + 1))
    fi
    if grep -qE "call void @sailfin_runtime_sleep\(" "$ll"; then
        echo "[test]   user-program sleep(0) leaked through to direct @sailfin_runtime_sleep call"
        echo "[test]   the migration's call-path rewire has been reverted"
        missing=$((missing + 1))
    fi
    return "$missing"
}

run_test "user-program sleep(N) routes through @sfn_sleep, not direct C entrypoint" test_call_routes_to_sfn_sleep

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
