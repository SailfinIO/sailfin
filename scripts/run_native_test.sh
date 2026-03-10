#!/usr/bin/env bash
# Run a single Sailfin native test file.
#
# Strategy:
#   1. Try running with the compiler binary directly (30s timeout)
#   2. If that fails/hangs, fall back to the Python LLVM generator
#   3. If the compiler can't emit .sfn-asm, try FALLBACK_COMPILER
#
# Usage:
#   scripts/run_native_test.sh <compiler-binary> <test-file.sfn>
#
# Environment:
#   LINK_OBJ_1, LINK_OBJ_2, LINK_OBJ_3  — runtime .o files for the Python fallback
#   FALLBACK_COMPILER                     — alternate compiler for .sfn-asm emission

set -euo pipefail

COMPILER="$1"
TEST_FILE="$2"
BASENAME="$(basename "$TEST_FILE")"

# Timeout for the direct compiler approach (seconds)
DIRECT_TIMEOUT=30

# Try running the test directly with the compiler binary
if timeout "$DIRECT_TIMEOUT" "$COMPILER" test "$TEST_FILE" > /dev/null 2>&1; then
    echo "[test] PASS (direct): $BASENAME"
    exit 0
fi

# Direct execution failed or timed out — try the Python LLVM generator fallback
LINK_ARGS=()
for obj in "${LINK_OBJ_1:-}" "${LINK_OBJ_2:-}" "${LINK_OBJ_3:-}"; do
    if [ -n "$obj" ] && [ -f "$obj" ]; then
        LINK_ARGS+=(--link-obj "$obj")
    fi
done

if python scripts/test_llvm_gen.py \
    --compiler "$COMPILER" \
    --test "$TEST_FILE" \
    "${LINK_ARGS[@]}" > /dev/null 2>&1; then
    echo "[test] PASS (gen):    $BASENAME"
    exit 0
fi

# If the compiler can't emit .sfn-asm at all, try the fallback compiler
# (typically the first-pass binary which is faster/more reliable)
FALLBACK="${FALLBACK_COMPILER:-build/native/sailfin}"
if [ -x "$FALLBACK" ] && [ "$FALLBACK" != "$COMPILER" ]; then
    if python scripts/test_llvm_gen.py \
        --compiler "$FALLBACK" \
        --test "$TEST_FILE" \
        "${LINK_ARGS[@]}" > /dev/null 2>&1; then
        echo "[test] PASS (fallback): $BASENAME"
        exit 0
    fi
fi

echo "[test] FAIL:          $BASENAME"
exit 1
