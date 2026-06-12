#!/usr/bin/env bash
# Regression test for issue #537: a boolean (`i1`) flowing into a
# numeric (`int`/`float`) binding must refuse to compile with the
# `[fatal]` ABI primitive mismatch diagnostic and the `as int` /
# `as float` fix-it, instead of silently `zext`/`uitofp`-widening.
#
# This pins two behaviours:
#   1. `let n: int = b` (b: boolean) refuses, exits non-zero, and
#      surfaces the #537 bool fix-it phrasing.
#   2. `let n: int = b as int` keeps compiling — the explicit cast is
#      the supported escape valve and must not be over-refused.
#
# Usage:
#   compiler/tests/e2e/test_bool_numeric_coercion.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_bool_numeric_coercion.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REFUSE_FIXTURE="$SCRIPT_DIR/fixtures/bool_into_int_refusal.sfn"
CAST_FIXTURE="$SCRIPT_DIR/fixtures/bool_into_int_cast_ok.sfn"

for f in "$REFUSE_FIXTURE" "$CAST_FIXTURE"; do
    if [ ! -f "$f" ]; then
        echo "[test] FAIL: missing fixture $f"
        exit 1
    fi
done

PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-bool-coerce-XXXXXX)"
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

# ---- bool → int binding: must refuse ----
test_bool_into_int_refuses() {
    local out="$SCRATCH/refuse.out"
    set +e
    "$BINARY" test "$REFUSE_FIXTURE" > "$out" 2>&1
    local rc=$?
    set -e
    if [ "$rc" -eq 0 ]; then
        echo "[test]   sfn test exited 0 — compilation should have refused"
        sed 's/^/[test]     /' "$out" | tail -20
        return 1
    fi
    local missing=0
    if ! grep -qE "ABI primitive mismatch" "$out"; then
        echo "[test]   missing 'ABI primitive mismatch' in output"
        missing=$((missing + 1))
    fi
    if ! grep -qE "add \`as int\` or \`as float\` to disambiguate" "$out"; then
        echo "[test]   missing #537 bool fix-it phrasing in output"
        missing=$((missing + 1))
    fi
    if ! grep -qE "\(bool\)" "$out"; then
        echo "[test]   missing bool kind detail in output"
        missing=$((missing + 1))
    fi
    # The assertion in the fixture must never run — if it did, the gate
    # was bypassed and partial IR executed.
    if grep -qE "assertion failed" "$out"; then
        echo "[test]   assertion ran — gate bypassed, IR was written and executed"
        missing=$((missing + 1))
    fi
    return "$missing"
}

# ---- bool → int via explicit `as int`: must compile ----
test_bool_cast_compiles() {
    local out="$SCRATCH/cast.out"
    set +e
    "$BINARY" test "$CAST_FIXTURE" > "$out" 2>&1
    local rc=$?
    set -e
    if [ "$rc" -ne 0 ]; then
        echo "[test]   sfn test exited $rc — explicit cast must compile"
        sed 's/^/[test]     /' "$out" | tail -20
        return 1
    fi
    if grep -qE "ABI primitive mismatch" "$out"; then
        echo "[test]   explicit cast surfaced ABI mismatch (over-refusal)"
        return 1
    fi
    return 0
}

run_test "bool→int binding refuses with #537 fix-it" \
    test_bool_into_int_refuses
run_test "bool→int via explicit \`as int\` compiles" \
    test_bool_cast_compiles

echo "[summary] pass=$PASS fail=$FAIL"
if [ "$FAIL" -ne 0 ]; then
    exit 1
fi
exit 0
