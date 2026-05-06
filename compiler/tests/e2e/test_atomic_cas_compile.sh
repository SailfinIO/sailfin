#!/usr/bin/env bash
# End-to-end test for the `atomic_cas` builtin (M0-Atomics.3,
# issue #333). Drives `sfn emit llvm` against the fixture and
# asserts the emitted IR contains both the `cmpxchg` aggregate
# instruction and the `extractvalue { i64, i1 } ..., 1` follow-up
# that unwraps the success bit. Also pins the E0806 rejection on
# deliberately broken calls (non-`*int` first arg, non-`int`
# second/third args) so the diagnostic surface stays user-visible
# — sibling to the load/store + add/sub rejection coverage in
# `test_atomic_load_store_compile.sh` /
# `test_atomic_add_sub_compile.sh`.
#
# Usage:
#   compiler/tests/e2e/test_atomic_cas_compile.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_atomic_cas_compile.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FIXTURE="$SCRIPT_DIR/fixtures/atomic_cas_basic.sfn"

PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-atomic-cas-XXXXXX)"
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

# ---- Happy path: atomic_cas emits the cmpxchg + extractvalue pair ----
test_cas_emits_expected_ir() {
    local ll="$SCRATCH/atomic_cas_basic.ll"
    if ! "$BINARY" emit -o "$ll" llvm "$FIXTURE" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed for atomic_cas_basic.sfn"
        return 1
    fi

    # Acceptance Criteria from issue #333:
    #   atomic_cas(ptr, expected, new) →
    #     %tA = cmpxchg ptr <ptr>, i64 <exp>, i64 <new> seq_cst seq_cst, align 8
    #     %tB = extractvalue { i64, i1 } %tA, 1
    local missing=0
    if ! grep -qE "cmpxchg ptr.*i64.*i64.*seq_cst seq_cst" "$ll"; then
        echo "[test]   missing 'cmpxchg ptr ... i64 ... i64 ... seq_cst seq_cst' in emitted IR"
        missing=$((missing + 1))
    fi
    if ! grep -qE "cmpxchg ptr.*align 8" "$ll"; then
        echo "[test]   cmpxchg missing 'align 8'"
        missing=$((missing + 1))
    fi
    if ! grep -qE "extractvalue \{ i64, i1 \}.*, 1" "$ll"; then
        echo "[test]   missing 'extractvalue { i64, i1 } ..., 1' (success-bit unwrap)"
        missing=$((missing + 1))
    fi
    return "$missing"
}

# ---- Verification regex from the issue counts ≥ 2 ----
# (one `cmpxchg ... seq_cst seq_cst` + one `extractvalue { i64, i1 }`
#  for the simple `try_set` callsite; the `try_acquire` callsite
#  inside the `if` condition pushes the count higher).
test_verification_regex_counts_at_least_two() {
    local ll="$SCRATCH/atomic_cas_count.ll"
    if ! "$BINARY" emit -o "$ll" llvm "$FIXTURE" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed for verification-regex case"
        return 1
    fi
    local hits
    hits="$(grep -cE 'cmpxchg ptr.*i64.*seq_cst seq_cst|extractvalue \{ i64, i1 \}' "$ll" || true)"
    if [ "${hits:-0}" -lt 2 ]; then
        echo "[test]   verification regex matched only $hits lines (expected ≥ 2)"
        return 1
    fi
    return 0
}

# ---- E0806: type-error on non-pointer first argument is reported ----
test_atomic_cas_rejects_non_pointer_arg() {
    local src="$SCRATCH/bad_cas_ptr.sfn"
    local ll="$SCRATCH/bad_cas_ptr.ll"
    cat > "$src" <<'EOF'
fn bad() -> boolean {
    return atomic_cas(42, 0, 1);
}
EOF
    # E0806 is emitted as a `[fatal]`-tagged lowering diagnostic and
    # printed to stderr from `_lower_atomic_cas`. We assert two
    # signals (mirroring `test_atomic_load_store_compile.sh`):
    #   1. the E0806 code is present on stderr
    #   2. the .ll file (if produced) does NOT contain a `cmpxchg`
    #      line — i.e. the bogus call was rejected before lowering
    #      would have emitted malformed IR
    #
    # We intentionally don't gate on the exit code — see the load/
    # store + add/sub sibling tests for the full background.
    local stderr
    stderr="$("$BINARY" emit -o "$ll" llvm "$src" 2>&1 1>/dev/null || true)"
    if ! echo "$stderr" | grep -q "E0806"; then
        echo "[test]   missing E0806 for non-pointer atomic_cas argument"
        echo "         stderr was: $stderr" | head -5
        return 1
    fi
    if [ -f "$ll" ] && grep -qE "cmpxchg ptr" "$ll"; then
        echo "[test]   regression: emitted 'cmpxchg ptr' for non-pointer arg"
        return 1
    fi
    return 0
}

# ---- E0806: type-error on non-int second arg (`expected`) ----
test_atomic_cas_rejects_non_int_expected() {
    local src="$SCRATCH/bad_cas_expected.sfn"
    local ll="$SCRATCH/bad_cas_expected.ll"
    cat > "$src" <<'EOF'
fn bad(p: *int) -> boolean {
    return atomic_cas(p, "hello", 1);
}
EOF
    local stderr
    stderr="$("$BINARY" emit -o "$ll" llvm "$src" 2>&1 1>/dev/null || true)"
    if ! echo "$stderr" | grep -q "E0806"; then
        echo "[test]   missing E0806 for non-int atomic_cas expected arg"
        echo "         stderr was: $stderr" | head -5
        return 1
    fi
    if [ -f "$ll" ] && grep -qE "cmpxchg ptr" "$ll"; then
        echo "[test]   regression: emitted 'cmpxchg ptr' for non-int expected arg"
        return 1
    fi
    return 0
}

# ---- E0806: type-error on non-int third arg (`new`) ----
test_atomic_cas_rejects_non_int_new() {
    local src="$SCRATCH/bad_cas_new.sfn"
    local ll="$SCRATCH/bad_cas_new.ll"
    cat > "$src" <<'EOF'
fn bad(p: *int) -> boolean {
    return atomic_cas(p, 0, "hello");
}
EOF
    local stderr
    stderr="$("$BINARY" emit -o "$ll" llvm "$src" 2>&1 1>/dev/null || true)"
    if ! echo "$stderr" | grep -q "E0806"; then
        echo "[test]   missing E0806 for non-int atomic_cas new arg"
        echo "         stderr was: $stderr" | head -5
        return 1
    fi
    if [ -f "$ll" ] && grep -qE "cmpxchg ptr" "$ll"; then
        echo "[test]   regression: emitted 'cmpxchg ptr' for non-int new arg"
        return 1
    fi
    return 0
}

run_test "atomic_cas emits cmpxchg + extractvalue with seq_cst seq_cst, align 8" \
    test_cas_emits_expected_ir
run_test "issue verification regex matches ≥ 2 cmpxchg/extractvalue lines" \
    test_verification_regex_counts_at_least_two
run_test "atomic_cas with non-pointer first argument reports E0806" \
    test_atomic_cas_rejects_non_pointer_arg
run_test "atomic_cas with non-int expected (arg 1) reports E0806" \
    test_atomic_cas_rejects_non_int_expected
run_test "atomic_cas with non-int new (arg 2) reports E0806" \
    test_atomic_cas_rejects_non_int_new

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
