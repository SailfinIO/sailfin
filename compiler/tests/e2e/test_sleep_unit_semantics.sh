#!/usr/bin/env bash
# E2E unit-semantics test for sleep() — issue #307.
#
# The pre-fix bug: prelude advertised `sleep(milliseconds: number)` while
# `sailfin_runtime_sleep(double seconds)` interpreted its input as
# seconds (multiplied by 1000 for `Sleep` ms / 1e6 for `usleep` µs).
# `sleep(50)` actually slept for 50 *seconds*, not 50 milliseconds.
#
# This test compiles and runs a small program that brackets a
# `sleep(75)` between two `monotonic_millis()` reads, then asserts the
# measured elapsed window is plausibly ~75 ms (lower bound) and well
# under the broken-seconds path (upper bound). Bracketing inside the
# user program isolates the sleep duration from compile/link/start
# overhead, so the test stays tight and non-flaky.
#
# Pinned end-to-end: prelude `sleep` / `runtime_sleep_fn`, the
# helper-registry rewire to `@sfn_sleep`, the Sailfin wrapper in
# `runtime/sfn/clock.sfn`, the C trampoline `sfn_sleep`, and
# `sailfin_runtime_sleep` itself. Any layer regressing the units (e.g.
# the pre-fix C runtime that multiplied input by 1000/1e6) causes
# the elapsed window to blow past the upper bound and the test
# fails loudly rather than silently overshooting wall-clock budgets
# in production.
#
# Usage:
#   compiler/tests/e2e/test_sleep_unit_semantics.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_sleep_unit_semantics.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-sleep-units-XXXXXX)"
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

# Sleep target in ms. Picked large enough to overcome scheduler jitter
# on loaded CI hardware (~10 ms is typical worst-case wakeup latency)
# and small enough that the pre-fix bug — which would interpret 75 as
# 75 *seconds* — overshoots the upper bound by ~1000x.
SLEEP_MS=75

# Lower bound: at least 50 ms must elapse. nanosleep guarantees ≥
# requested duration; if the test sees less than 50 ms, either the
# input was treated as a sub-millisecond value or the call returned
# without sleeping.
LOWER_MS=50

# Upper bound: 30 seconds. Comfortably above any plausible scheduler
# jitter / GC pause / CI-runner stall, but ~3 orders of magnitude
# below the 75-second wall time the seconds-interpretation bug would
# produce.
UPPER_MS=30000

test_sleep_window_is_milliseconds() {
    cat > "$SCRATCH/sleep_units.sfn" <<EOF
fn main() ![io, clock] {
    let start = monotonic_millis();
    sleep(${SLEEP_MS});
    let elapsed = monotonic_millis() - start;
    print("ELAPSED_MS={{elapsed}}");
}
EOF

    local log="$SCRATCH/run.log"
    if ! "$BINARY" run "$SCRATCH/sleep_units.sfn" > "$log" 2>&1; then
        echo "[test]   sfn run sleep_units.sfn failed:" >&2
        cat "$log" >&2
        return 1
    fi

    local line
    line="$(grep -E '^ELAPSED_MS=' "$log" || true)"
    if [ -z "$line" ]; then
        echo "[test]   program did not print ELAPSED_MS marker:" >&2
        cat "$log" >&2
        return 1
    fi

    local elapsed
    elapsed="${line#ELAPSED_MS=}"
    # monotonic_millis() returns a `number` (double) — strip any
    # trailing fractional/exponent component if the print path emits
    # one, so bash's integer compare stays valid.
    elapsed="${elapsed%%.*}"
    elapsed="${elapsed%%[eE]*}"
    if ! [[ "$elapsed" =~ ^[0-9]+$ ]]; then
        echo "[test]   ELAPSED_MS value is not an integer: '$elapsed'" >&2
        cat "$log" >&2
        return 1
    fi

    if [ "$elapsed" -lt "$LOWER_MS" ]; then
        echo "[test]   sleep(${SLEEP_MS}) returned after only ${elapsed} ms" >&2
        echo "[test]   expected ≥ ${LOWER_MS} ms — sleep may not be sleeping" >&2
        return 1
    fi
    if [ "$elapsed" -ge "$UPPER_MS" ]; then
        echo "[test]   sleep(${SLEEP_MS}) took ${elapsed} ms — units regression" >&2
        echo "[test]   the pre-#307 seconds-interpretation bug caused" >&2
        echo "[test]   sleep(N) to sleep N seconds; this looks like that." >&2
        return 1
    fi

    echo "[test]   sleep(${SLEEP_MS}) wall window: ${elapsed} ms (lower=${LOWER_MS}, upper=${UPPER_MS})"
    return 0
}

run_test "sleep(N) is N milliseconds end-to-end (issue #307)" test_sleep_window_is_milliseconds

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
