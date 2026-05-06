#!/usr/bin/env bash
# End-to-end test for the `atomic_add` / `atomic_sub` builtins
# (M0-Atomics.2, issue #332). Drives `sfn emit llvm` against the
# fixture and asserts the emitted IR contains the expected
# `atomicrmw add` / `atomicrmw sub` shapes with `seq_cst` ordering
# and `align 8`. Also pins the E0806 rejection on a deliberately
# broken call so the diagnostic surface stays user-visible —
# sibling to the load/store rejection coverage in
# `test_atomic_load_store_compile.sh`.
#
# Usage:
#   compiler/tests/e2e/test_atomic_add_sub_compile.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_atomic_add_sub_compile.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FIXTURE="$SCRIPT_DIR/fixtures/atomic_add_sub_basic.sfn"

PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-atomic-add-sub-XXXXXX)"
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

# ---- Happy path: both builtins emit the right LLVM atomicrmw ops ----
test_add_and_sub_emit_expected_ir() {
    local ll="$SCRATCH/atomic_add_sub_basic.ll"
    if ! "$BINARY" emit -o "$ll" llvm "$FIXTURE" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed for atomic_add_sub_basic.sfn"
        return 1
    fi

    # Acceptance Criteria from issue #332:
    #   atomic_add → `%temp = atomicrmw add ptr %ptr, i64 %delta seq_cst, align 8`
    #   atomic_sub → `%temp = atomicrmw sub ptr %ptr, i64 %delta seq_cst, align 8`
    local missing=0
    if ! grep -qE "atomicrmw add ptr.*i64.*seq_cst" "$ll"; then
        echo "[test]   missing 'atomicrmw add ptr ... i64 ... seq_cst' in emitted IR"
        missing=$((missing + 1))
    fi
    if ! grep -qE "atomicrmw sub ptr.*i64.*seq_cst" "$ll"; then
        echo "[test]   missing 'atomicrmw sub ptr ... i64 ... seq_cst' in emitted IR"
        missing=$((missing + 1))
    fi
    if ! grep -qE "atomicrmw add ptr.*align 8" "$ll"; then
        echo "[test]   atomicrmw add missing 'align 8'"
        missing=$((missing + 1))
    fi
    if ! grep -qE "atomicrmw sub ptr.*align 8" "$ll"; then
        echo "[test]   atomicrmw sub missing 'align 8'"
        missing=$((missing + 1))
    fi
    return "$missing"
}

# ---- Verification regex from the issue counts ≥ 2 ----
# (`atomicrmw add ... seq_cst` + `atomicrmw sub ... seq_cst`).
test_verification_regex_counts_at_least_two() {
    local ll="$SCRATCH/atomic_add_sub_count.ll"
    if ! "$BINARY" emit -o "$ll" llvm "$FIXTURE" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed for verification-regex case"
        return 1
    fi
    local hits
    hits="$(grep -cE 'atomicrmw (add|sub) ptr.*i64.*seq_cst' "$ll" || true)"
    if [ "${hits:-0}" -lt 2 ]; then
        echo "[test]   verification regex matched only $hits lines (expected ≥ 2)"
        return 1
    fi
    return 0
}

# ---- E0806: type-error on non-pointer first argument is reported ----
test_atomic_add_rejects_non_pointer_arg() {
    local src="$SCRATCH/bad_add.sfn"
    local ll="$SCRATCH/bad_add.ll"
    cat > "$src" <<'EOF'
fn bad() -> int {
    return atomic_add(42, 1);
}
EOF
    # E0806 is emitted as a `[fatal]`-tagged lowering diagnostic and
    # printed to stderr from `_lower_atomic_rmw`. We assert two
    # signals (mirroring `test_atomic_load_store_compile.sh`):
    #   1. the E0806 code is present on stderr
    #   2. the .ll file (if produced) does NOT contain an
    #      `atomicrmw add` line — i.e. the bogus call was rejected
    #      before lowering would have emitted malformed IR
    #
    # We intentionally don't gate on the exit code: the
    # `compile_to_llvm_file_with_module` fallback path can still
    # produce a partial-but-valid-looking .ll even on fatal
    # lowering diagnostics. See the load/store sibling test for the
    # full background.
    local stderr
    stderr="$("$BINARY" emit -o "$ll" llvm "$src" 2>&1 1>/dev/null || true)"
    if ! echo "$stderr" | grep -q "E0806"; then
        echo "[test]   missing E0806 for non-pointer atomic_add argument"
        echo "         stderr was: $stderr" | head -5
        return 1
    fi
    if [ -f "$ll" ] && grep -qE "atomicrmw add ptr" "$ll"; then
        echo "[test]   regression: emitted 'atomicrmw add ptr' for non-pointer arg"
        return 1
    fi
    return 0
}

# ---- E0806: type-error on non-int delta is reported ----
test_atomic_sub_rejects_non_int_delta() {
    local src="$SCRATCH/bad_sub.sfn"
    local ll="$SCRATCH/bad_sub.ll"
    cat > "$src" <<'EOF'
fn bad(p: *int) -> int {
    return atomic_sub(p, "hello");
}
EOF
    # See test_atomic_add_rejects_non_pointer_arg above for the
    # rationale on why we don't gate on exit code.
    local stderr
    stderr="$("$BINARY" emit -o "$ll" llvm "$src" 2>&1 1>/dev/null || true)"
    if ! echo "$stderr" | grep -q "E0806"; then
        echo "[test]   missing E0806 for non-int atomic_sub delta"
        echo "         stderr was: $stderr" | head -5
        return 1
    fi
    if [ -f "$ll" ] && grep -qE "atomicrmw sub ptr" "$ll"; then
        echo "[test]   regression: emitted 'atomicrmw sub ptr' for non-int delta"
        return 1
    fi
    return 0
}

run_test "atomic_add + atomic_sub emit atomicrmw add/sub with seq_cst, align 8" \
    test_add_and_sub_emit_expected_ir
run_test "issue verification regex matches ≥ 2 atomicrmw ops" \
    test_verification_regex_counts_at_least_two
run_test "atomic_add with non-pointer argument reports E0806" \
    test_atomic_add_rejects_non_pointer_arg
run_test "atomic_sub with non-int delta reports E0806" \
    test_atomic_sub_rejects_non_int_delta

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
