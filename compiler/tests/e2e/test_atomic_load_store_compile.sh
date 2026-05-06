#!/usr/bin/env bash
# End-to-end test for the `atomic_load` / `atomic_store` builtins
# (M0-Atomics.1, issue #331). Drives `sfn emit llvm` against the
# fixture and asserts the emitted IR contains the expected
# `load atomic` / `store atomic` shapes with `seq_cst` ordering and
# `align 8`. Also pins the E0806 rejection on a deliberately broken
# call so the diagnostic surface stays user-visible.
#
# Usage:
#   compiler/tests/e2e/test_atomic_load_store_compile.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_atomic_load_store_compile.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FIXTURE="$SCRIPT_DIR/fixtures/atomic_load_store_basic.sfn"

PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-atomics-XXXXXX)"
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

# ---- Happy path: both builtins emit the right LLVM atomic ops ----
test_load_and_store_emit_expected_ir() {
    local ll="$SCRATCH/atomics_basic.ll"
    if ! "$BINARY" emit -o "$ll" llvm "$FIXTURE" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed for atomic_load_store_basic.sfn"
        return 1
    fi

    # Acceptance Criteria from issue #331:
    #   atomic_load → `%temp = load atomic i64, ... seq_cst, align 8`
    #   atomic_store → `store atomic i64 ..., ... seq_cst, align 8`
    local missing=0
    if ! grep -qE "load atomic i64.*seq_cst" "$ll"; then
        echo "[test]   missing 'load atomic i64 ... seq_cst' in emitted IR"
        missing=$((missing + 1))
    fi
    if ! grep -qE "store atomic i64.*seq_cst" "$ll"; then
        echo "[test]   missing 'store atomic i64 ... seq_cst' in emitted IR"
        missing=$((missing + 1))
    fi
    if ! grep -qE "load atomic i64.*align 8" "$ll"; then
        echo "[test]   load atomic missing 'align 8'"
        missing=$((missing + 1))
    fi
    if ! grep -qE "store atomic i64.*align 8" "$ll"; then
        echo "[test]   store atomic missing 'align 8'"
        missing=$((missing + 1))
    fi
    return "$missing"
}

# ---- Smoke: the verification regex from the issue counts ≥ 2 ----
# (`load atomic ... seq_cst` + `store atomic ... seq_cst`).
test_verification_regex_counts_at_least_two() {
    local ll="$SCRATCH/atomics_count.ll"
    if ! "$BINARY" emit -o "$ll" llvm "$FIXTURE" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed for verification-regex case"
        return 1
    fi
    local hits
    hits="$(grep -cE 'load atomic i64.*seq_cst|store atomic i64.*seq_cst' "$ll" || true)"
    if [ "${hits:-0}" -lt 2 ]; then
        echo "[test]   verification regex matched only $hits lines (expected ≥ 2)"
        return 1
    fi
    return 0
}

# ---- E0806: type-error on non-pointer first argument is reported ----
test_atomic_load_rejects_non_pointer_arg() {
    local src="$SCRATCH/bad_load.sfn"
    local ll="$SCRATCH/bad_load.ll"
    cat > "$src" <<'EOF'
fn bad() -> int {
    return atomic_load(42);
}
EOF
    # E0806 is emitted as a `[fatal]`-tagged lowering diagnostic and
    # printed to stderr from `lower_atomic_builtin`. We assert two
    # signals:
    #   1. the E0806 code is present on stderr
    #   2. the .ll file (if produced) does NOT contain a `load atomic`
    #      line — i.e. the bogus call was rejected before lowering
    #      would have emitted malformed `load atomic i64 ... i64 ...`
    #      IR
    #
    # We intentionally don't gate on the exit code: today
    # `compile_to_llvm_file_with_module` falls back to the
    # `write_llvm_ir(NativeModule)` path when the primary text-mode
    # path returns false, so even fatal lowering diagnostics can end
    # up with exit 0 + a partial-but-valid-looking .ll file (the
    # `[fatal]` call site emits no instruction so the surrounding
    # function body simply ends with `ret <T> 0`). Wiring the fatal
    # gate cleanly through the fallback is out of scope for
    # M0-Atomics.1; the stderr + IR checks below are the durable
    # invariants for now.
    local stderr
    stderr="$("$BINARY" emit -o "$ll" llvm "$src" 2>&1 1>/dev/null || true)"
    if ! echo "$stderr" | grep -q "E0806"; then
        echo "[test]   missing E0806 for non-pointer atomic_load argument"
        echo "         stderr was: $stderr" | head -5
        return 1
    fi
    if [ -f "$ll" ] && grep -qE "load atomic i64" "$ll"; then
        echo "[test]   regression: emitted 'load atomic i64' for non-pointer arg"
        return 1
    fi
    return 0
}

# ---- E0806: type-error on non-int store value is reported ----
test_atomic_store_rejects_non_int_value() {
    local src="$SCRATCH/bad_store.sfn"
    local ll="$SCRATCH/bad_store.ll"
    cat > "$src" <<'EOF'
fn bad(p: *int) {
    atomic_store(p, "hello");
}
EOF
    # See test_atomic_load_rejects_non_pointer_arg above for the
    # rationale on why we don't gate on exit code.
    local stderr
    stderr="$("$BINARY" emit -o "$ll" llvm "$src" 2>&1 1>/dev/null || true)"
    if ! echo "$stderr" | grep -q "E0806"; then
        echo "[test]   missing E0806 for non-int atomic_store value"
        echo "         stderr was: $stderr" | head -5
        return 1
    fi
    if [ -f "$ll" ] && grep -qE "store atomic i64" "$ll"; then
        echo "[test]   regression: emitted 'store atomic i64' for non-int value"
        return 1
    fi
    return 0
}

run_test "atomic_load + atomic_store emit load/store atomic with seq_cst, align 8" \
    test_load_and_store_emit_expected_ir
run_test "issue verification regex matches ≥ 2 atomic ops" \
    test_verification_regex_counts_at_least_two
run_test "atomic_load with non-pointer argument reports E0806" \
    test_atomic_load_rejects_non_pointer_arg
run_test "atomic_store with non-int value reports E0806" \
    test_atomic_store_rejects_non_int_value

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
