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

# macOS doesn't ship `timeout`; use gtimeout (coreutils) if available, else fallback
if command -v timeout &>/dev/null; then
    TIMEOUT_CMD="timeout"
elif command -v gtimeout &>/dev/null; then
    TIMEOUT_CMD="gtimeout"
else
    TIMEOUT_CMD=""
fi

if [ -n "$TIMEOUT_CMD" ]; then
    output=$("$TIMEOUT_CMD" "$TIMEOUT" "$COMPILER" test "$TEST_FILE" 2>&1) || {
        echo "[test] FAIL: $BASENAME (exit code $?)"
        echo "$output" | tail -5
        exit 1
    }
else
    output=$("$COMPILER" test "$TEST_FILE" 2>&1) || {
        echo "[test] FAIL: $BASENAME (exit code $?)"
        echo "$output" | tail -5
        exit 1
    }
fi

# The binary must produce SOME output — a silent exit is not a pass
if [ -z "$output" ]; then
    echo "[test] FAIL: $BASENAME (no output — binary is non-functional)"
    exit 1
fi

# Check for test pass indicators
if echo "$output" | grep -qiE "pass|ok|success|PASS"; then
    echo "[test] PASS: $BASENAME"
    exit 0
fi

# If there's output but no pass indicator, check for explicit failures
if echo "$output" | grep -qiE "fail|error|panic|abort"; then
    echo "[test] FAIL: $BASENAME"
    echo "$output" | tail -5
    exit 1
fi

# Output exists but no clear pass/fail — treat as pass (test ran without error)
echo "[test] PASS: $BASENAME"
exit 0
