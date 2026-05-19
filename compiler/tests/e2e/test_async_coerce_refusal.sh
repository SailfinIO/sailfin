#!/usr/bin/env bash
# Regression test for issue #675: the `[fatal]` ABI primitive mismatch
# diagnostic must halt test-mode compilation, not just print to stderr.
#
# Pre-fix, `write_llvm_ir_for_tests_from_text_with_context` (the
# entrypoint behind `sfn test`) skipped the `has_fatal_lowering_-
# diagnostic` gate that `write_llvm_ir` and
# `compile_native_text_to_llvm_file` honor. Result: a `number → int`
# coercion across an `await` boundary (e.g. `step1() -> number`
# followed by `step2(input: int)`) emitted the `[fatal]` diagnostic
# to stderr, then wrote partial IR that ran the corrupted call site
# anyway — the final assertion observed garbage. The picker for #673
# hit this and sidestepped by leaving the chain at uniform `number`.
#
# This test pins two behaviours:
#   1. The narrowing case (`number → int`) refuses to compile, exits
#      non-zero, and surfaces the canonical #556 fix-it phrasing.
#   2. The widening case (`int → number`) keeps the asymmetric silent
#      sitofp behaviour — the new gate must not over-refuse.
#
# Usage:
#   compiler/tests/e2e/test_async_coerce_refusal.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_async_coerce_refusal.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REFUSE_FIXTURE="$SCRIPT_DIR/fixtures/async_coerce_refusal_basic.sfn"
WIDEN_FIXTURE="$SCRIPT_DIR/fixtures/async_coerce_widen_basic.sfn"

if [ ! -f "$REFUSE_FIXTURE" ]; then
    echo "[test] FAIL: missing fixture $REFUSE_FIXTURE"
    exit 1
fi
if [ ! -f "$WIDEN_FIXTURE" ]; then
    echo "[test] FAIL: missing fixture $WIDEN_FIXTURE"
    exit 1
fi

PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-async-coerce-XXXXXX)"
trap 'rm -rf "$SCRATCH"' EXIT

ulimit -v 8388608 2>/dev/null || true

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

# ---- Narrowing direction (number → int across await): must refuse ----
test_number_to_int_emits_fatal_and_exits_nonzero() {
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
        echo "[test]   missing 'ABI primitive mismatch' in stderr"
        missing=$((missing + 1))
    fi
    if ! grep -qE "add \`as float\` or \`as int\` to disambiguate" "$out"; then
        echo "[test]   missing #556 fix-it phrasing in stderr"
        missing=$((missing + 1))
    fi
    if ! grep -qE "callee expects .*\(int\) but caller produced .*\(float\)" "$out"; then
        echo "[test]   missing int/float kind detail in stderr"
        missing=$((missing + 1))
    fi
    if ! grep -qE "compile failed for" "$out"; then
        echo "[test]   missing 'compile failed for' refusal marker"
        missing=$((missing + 1))
    fi
    # The assertion in the fixture must never run — if it did, the
    # gate is bypassed and the value clobber message would surface.
    if grep -qE "assertion failed" "$out"; then
        echo "[test]   assertion ran — gate bypassed, IR was written and executed"
        missing=$((missing + 1))
    fi
    return "$missing"
}

# ---- Widening direction (int → number across await): must compile ----
test_int_to_number_compiles_and_runs() {
    local out="$SCRATCH/widen.out"
    set +e
    "$BINARY" test "$WIDEN_FIXTURE" > "$out" 2>&1
    local rc=$?
    set -e
    if [ "$rc" -ne 0 ]; then
        echo "[test]   sfn test exited $rc — widening direction must remain silent"
        sed 's/^/[test]     /' "$out" | tail -20
        return 1
    fi
    # No fatal diagnostic should surface for the widening direction.
    if grep -qE "ABI primitive mismatch" "$out"; then
        echo "[test]   widening direction surfaced ABI mismatch (over-refusal)"
        return 1
    fi
    if ! grep -qE "PASS" "$out"; then
        echo "[test]   widening fixture did not report PASS"
        sed 's/^/[test]     /' "$out" | tail -20
        return 1
    fi
    return 0
}

run_test "number→int across await refuses with #556 fix-it" \
    test_number_to_int_emits_fatal_and_exits_nonzero
run_test "int→number across await keeps silent widening" \
    test_int_to_number_compiles_and_runs

echo "[summary] pass=$PASS fail=$FAIL"
if [ "$FAIL" -ne 0 ]; then
    exit 1
fi
exit 0
