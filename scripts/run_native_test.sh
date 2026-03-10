#!/usr/bin/env bash
# Run a single Sailfin native test file.
#
# The compiler binary must be able to run tests directly.
# No fallbacks — if the binary can't run the test, it fails.
#
# Usage:
#   scripts/run_native_test.sh <compiler-binary> <test-file.sfn>

set -euo pipefail

COMPILER="$1"
TEST_FILE="$2"
BASENAME="$(basename "$TEST_FILE")"

# 60s timeout — if the binary hangs, something is fundamentally broken
TIMEOUT=60

if timeout "$TIMEOUT" "$COMPILER" test "$TEST_FILE" > /dev/null 2>&1; then
    echo "[test] PASS: $BASENAME"
    exit 0
fi

echo "[test] FAIL: $BASENAME"
exit 1
