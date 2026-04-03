#!/usr/bin/env bash
# End-to-end test for the `sfn guillermo` easter egg.
#
# Usage:
#   compiler/tests/e2e/test_guillermo.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_guillermo.sh <compiler-binary>}"
PASS=0
FAIL=0

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

# ---- Test 1: sfn guillermo exits 0 ----
test_exit_code() {
    "$BINARY" guillermo > /dev/null 2>&1
}
run_test "guillermo exits 0" test_exit_code

# ---- Test 2: output contains the mascot greeting ----
test_output_contains_greeting() {
    local output
    output="$("$BINARY" guillermo 2>&1)"
    echo "$output" | grep -q "Guillermo"
}
run_test "guillermo output contains greeting" test_output_contains_greeting

# ---- Summary ----
echo ""
echo "[test] $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
