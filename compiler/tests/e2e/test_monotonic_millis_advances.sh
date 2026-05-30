#!/usr/bin/env bash
# E2E test for monotonic_millis() — issue #819.
#
# Pins the Sailfin-native `monotonic_millis` backend. Before #819 the
# prelude's `monotonic_millis()` routed through the legacy C
# `sailfin_runtime_monotonic_millis` (a `double`-returning symbol that
# needed the `c_abi_return_type` coercion). #819 flips the helper
# registry rows in `compiler/src/llvm/runtime_helpers.sfn` to the
# Sailfin-native `@sfn_clock_millis` (defined in
# `runtime/sfn/clock.sfn`), which reads `CLOCK_MONOTONIC` through
# #878's `clock_gettime` field-reader and divides nanoseconds down to
# whole milliseconds.
#
# This test compiles and runs a small program that reads
# `monotonic_millis()` twice, bracketing a short `sleep`, then asserts:
#   1. the readings are non-zero (the clock is actually being read, not
#      a stubbed zero), and
#   2. the second reading is strictly greater than the first (the clock
#      advances across a real time interval — monotonic, non-decreasing,
#      and observably progressing).
#
# A regression that reverted the registry rewire (or broke the
# nanosecond→millisecond reduction, or returned a constant) fails this
# loudly rather than silently degrading every profiling bracket in the
# compiler (`cli_commands.sfn`, `lowering_core.sfn`, `main.sfn`).
#
# Usage:
#   compiler/tests/e2e/test_monotonic_millis_advances.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_monotonic_millis_advances.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-monotonic-XXXXXX)"
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

# Sleep between the two clock reads. Large enough to clear scheduler
# jitter and millisecond-truncation boundaries so the second reading is
# reliably strictly greater than the first, small enough to keep the
# test fast.
SLEEP_MS=25

# Minimum advance we require between the two reads. nanosleep guarantees
# ≥ requested duration, so the monotonic clock must advance by at least
# this much; a smaller margin than SLEEP_MS absorbs any truncation at
# the millisecond boundary.
MIN_ADVANCE_MS=5

extract_marker() {
    # $1 = marker name, $2 = log file. Echoes the integer value or
    # nothing. Strips any fractional/exponent component defensively.
    local marker="$1" log="$2" line value
    line="$(grep -E "^${marker}=" "$log" || true)"
    [ -z "$line" ] && return 1
    value="${line#${marker}=}"
    value="${value%%.*}"
    value="${value%%[eE]*}"
    [[ "$value" =~ ^[0-9]+$ ]] || return 1
    echo "$value"
}

test_monotonic_millis_advances_and_nonzero() {
    cat > "$SCRATCH/monotonic.sfn" <<EOF
fn main() ![io, clock] {
    let first = monotonic_millis();
    sleep(${SLEEP_MS});
    let second = monotonic_millis();
    print("FIRST_MS={{first}}");
    print("SECOND_MS={{second}}");
}
EOF

    local log="$SCRATCH/run.log"
    if ! "$BINARY" run "$SCRATCH/monotonic.sfn" > "$log" 2>&1; then
        echo "[test]   sfn run monotonic.sfn failed:" >&2
        cat "$log" >&2
        return 1
    fi

    local first second
    if ! first="$(extract_marker FIRST_MS "$log")"; then
        echo "[test]   program did not print a valid FIRST_MS marker:" >&2
        cat "$log" >&2
        return 1
    fi
    if ! second="$(extract_marker SECOND_MS "$log")"; then
        echo "[test]   program did not print a valid SECOND_MS marker:" >&2
        cat "$log" >&2
        return 1
    fi

    # Non-zero: a stubbed/zeroed clock read would fail here.
    if [ "$first" -le 0 ]; then
        echo "[test]   first monotonic_millis() reading was ${first} (expected > 0)" >&2
        return 1
    fi

    # Advances: monotonic, non-decreasing, and observably progressing
    # across the bracketed sleep.
    if [ "$second" -lt "$first" ]; then
        echo "[test]   monotonic_millis() went backwards: ${first} -> ${second}" >&2
        return 1
    fi
    local advance=$((second - first))
    if [ "$advance" -lt "$MIN_ADVANCE_MS" ]; then
        echo "[test]   monotonic_millis() advanced only ${advance} ms over a ${SLEEP_MS} ms sleep" >&2
        echo "[test]   expected ≥ ${MIN_ADVANCE_MS} ms — the clock may not be advancing" >&2
        return 1
    fi

    echo "[test]   monotonic_millis(): ${first} -> ${second} (advance ${advance} ms over ${SLEEP_MS} ms sleep)"
    return 0
}

run_test "monotonic_millis() is non-zero and advances (issue #819)" test_monotonic_millis_advances_and_nonzero

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
