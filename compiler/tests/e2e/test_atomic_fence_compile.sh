#!/usr/bin/env bash
# End-to-end test for the `atomic_fence` builtin (M0-Atomics.4,
# issue #334). Drives `sfn emit llvm` against the fixture and
# asserts the emitted IR contains exactly one `fence seq_cst`
# line per call site, with no spurious operands or alignment
# clauses. Also pins the E0806 rejection on a deliberately broken
# call (`atomic_fence(0)`) so the diagnostic surface stays
# user-visible — sibling to the load/store rejection coverage in
# `test_atomic_load_store_compile.sh`.
#
# Usage:
#   compiler/tests/e2e/test_atomic_fence_compile.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_atomic_fence_compile.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FIXTURE="$SCRIPT_DIR/fixtures/atomic_fence_basic.sfn"

PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-atomic-fence-XXXXXX)"
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

# ---- Happy path: each atomic_fence() call site emits one `fence seq_cst` ----
test_atomic_fence_emits_expected_ir() {
    local ll="$SCRATCH/atomic_fence_basic.ll"
    if ! "$BINARY" emit -o "$ll" llvm "$FIXTURE" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed for atomic_fence_basic.sfn"
        return 1
    fi

    # Acceptance Criteria from issue #334:
    #   atomic_fence() → exactly one `fence seq_cst` line per call site,
    #   no operands, no alignment clause.
    local missing=0
    if ! grep -qE '^[[:space:]]*fence seq_cst$' "$ll"; then
        echo "[test]   missing 'fence seq_cst' line in emitted IR"
        missing=$((missing + 1))
    fi
    # Defence against a regression that adds an alignment clause or
    # an operand to the fence instruction (LLVM rejects both for
    # `fence`, but we also want a fast unit-style failure here).
    if grep -qE '^[[:space:]]*fence seq_cst.*align' "$ll"; then
        echo "[test]   regression: 'fence seq_cst' emitted with align clause"
        missing=$((missing + 1))
    fi
    if grep -qE '^[[:space:]]*fence seq_cst[[:space:]]+i' "$ll"; then
        echo "[test]   regression: 'fence seq_cst' emitted with an operand"
        missing=$((missing + 1))
    fi
    return "$missing"
}

# ---- Verification regex from the issue counts == call sites in fixture ----
# The fixture has two `atomic_fence()` call sites. The issue's verification
# block specifies `grep -c '^\s*fence seq_cst$'` should match the call-site
# count; we use the POSIX-portable `[[:space:]]*` form here so the test
# runs cleanly under BSD grep on the macos-arm64 CI matrix (BSD ERE
# does not honour the PCRE `\s` escape).
test_fence_count_matches_call_sites() {
    local ll="$SCRATCH/atomic_fence_count.ll"
    if ! "$BINARY" emit -o "$ll" llvm "$FIXTURE" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed for fence-count case"
        return 1
    fi
    local hits
    hits="$(grep -cE '^[[:space:]]*fence seq_cst$' "$ll" || true)"
    if [ "${hits:-0}" -ne 2 ]; then
        echo "[test]   expected 2 'fence seq_cst' lines, got ${hits:-0}"
        return 1
    fi
    return 0
}

# ---- E0806: type-error on extra-argument call is reported ----
test_atomic_fence_rejects_extra_argument() {
    local src="$SCRATCH/bad_fence.sfn"
    local ll="$SCRATCH/bad_fence.ll"
    cat > "$src" <<'EOF'
fn bad() {
    atomic_fence(0);
}
EOF
    # E0806 is emitted as a `[fatal]`-tagged lowering diagnostic and
    # printed to stderr from `_lower_atomic_fence`. Mirrors the
    # rejection-test pattern in `test_atomic_load_store_compile.sh`:
    # we don't gate on exit code (see that file's notes on the
    # `compile_to_llvm_file_with_module` fallback path) but we do
    # require the diagnostic on stderr and no `fence seq_cst` line
    # in any emitted IR.
    local stderr
    stderr="$("$BINARY" emit -o "$ll" llvm "$src" 2>&1 1>/dev/null || true)"
    if ! echo "$stderr" | grep -q "E0806"; then
        echo "[test]   missing E0806 for atomic_fence with extra argument"
        echo "         stderr was: $stderr" | head -5
        return 1
    fi
    if ! echo "$stderr" | grep -q "expects zero arguments"; then
        echo "[test]   E0806 missing the 'expects zero arguments' message"
        echo "         stderr was: $stderr" | head -5
        return 1
    fi
    if [ -f "$ll" ] && grep -qE '^[[:space:]]*fence seq_cst$' "$ll"; then
        echo "[test]   regression: emitted 'fence seq_cst' for bogus arity call"
        return 1
    fi
    return 0
}

run_test "atomic_fence emits 'fence seq_cst' with no operands" \
    test_atomic_fence_emits_expected_ir
run_test "atomic_fence emits one fence per call site (issue #334 verification regex)" \
    test_fence_count_matches_call_sites
run_test "atomic_fence with extra argument reports E0806" \
    test_atomic_fence_rejects_extra_argument

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
