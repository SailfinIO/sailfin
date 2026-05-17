#!/usr/bin/env bash
# End-to-end regression test for the `c_abi_return_type` post-call
# coercion in the legacy `coerce_and_emit_call` path (extended under
# issue #639). User-written calls to helpers like `monotonic_millis()`
# flow through `core_call_lowering` → `core_call_emission.coerce_and_emit_call`,
# NOT through `emit_runtime_call`. That makes this path the *actual*
# fix surface for #634: the unit-level coverage in
# `compiler/tests/unit/runtime_int_helpers_test.sfn` and
# `compiler/tests/unit/runtime_helper_abi_coercion_test.sfn` exercises
# `emit_runtime_call` only, which would let a future refactor silently
# regress `coerce_and_emit_call`'s coercion logic — the regression
# would re-introduce the `%xmm0`/`%rax` register-class mismatch that
# crashed PR #637 (see #641 RCA).
#
# This shell test compiles a minimal program with `sfn emit llvm` and
# greps the emitted IR for the three landmarks of the post-call
# coercion sequence:
#
#   1. `call double @sailfin_runtime_monotonic_millis()` — the call
#      lands against the C ABI return type (`%xmm0`), not against the
#      caller-visible `i64`.
#   2. `call double @round(double ...)` — the canonical Sailfin
#      rounding step (`coerce_numeric_primitive`'s `double → i64`
#      lowering).
#   3. `fptosi double ... to i64` — the final conversion that hands
#      the caller an `i64`-typed operand.
#
# Also asserts the let-binding allocas are `i64`, and that NO ABI
# primitive mismatch warning fires (the headline #634 ask).
#
# Usage:
#   compiler/tests/e2e/test_runtime_int_helpers_legacy_path.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_runtime_int_helpers_legacy_path.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"

PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-int-helpers-XXXXXX)"
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

# The minimal #634 reproducer from the issue body. `monotonic_millis()`
# is the worked example; flowing it through `--emit llvm` exercises the
# legacy call-emission path because the call site is user-written
# (not an internally-synthesized lowering call that uses
# `emit_runtime_call` directly).
write_fixture() {
    local src="$1"
    cat > "$src" <<'EOF'
import { monotonic_millis } from "runtime/prelude";

fn _ms_since(start_ms: int) -> int {
    let end_ms = monotonic_millis();
    let delta = end_ms - start_ms;
    if delta < 0 { return 0; }
    return delta;
}

fn main() ![io, clock] {
    let t0 = monotonic_millis();
    let elapsed = _ms_since(t0);
    print.info("ok");
}
EOF
}

# ---- 1. The emitted IR exhibits the three-landmark coercion sequence ----
test_legacy_path_emits_call_double_then_round_then_fptosi() {
    local src="$SCRATCH/let_int_infer.sfn"
    local ll="$SCRATCH/let_int_infer.ll"
    write_fixture "$src"

    if ! "$BINARY" --emit llvm "$src" > "$ll" 2> "$SCRATCH/stderr.log"; then
        echo "[test]   sfn --emit llvm failed"
        cat "$SCRATCH/stderr.log" | head -10
        return 1
    fi

    local missing=0
    if ! grep -qE 'call double @sailfin_runtime_monotonic_millis\(\)' "$ll"; then
        echo "[test]   missing 'call double @sailfin_runtime_monotonic_millis()' in emitted IR"
        echo "         (registry flip not honored by coerce_and_emit_call — #637 register-class mismatch will return)"
        missing=$((missing + 1))
    fi
    if ! grep -qE 'call double @round\(double' "$ll"; then
        echo "[test]   missing 'call double @round(double ...)' coercion step in emitted IR"
        missing=$((missing + 1))
    fi
    if ! grep -qE 'fptosi double .* to i64' "$ll"; then
        echo "[test]   missing 'fptosi double ... to i64' final conversion in emitted IR"
        missing=$((missing + 1))
    fi
    return "$missing"
}

# ---- 2. The let-binding alloca is i64 (callers see the declared type) ----
test_let_binding_alloca_is_i64() {
    local src="$SCRATCH/let_int_infer.sfn"
    local ll="$SCRATCH/let_int_infer.ll"
    write_fixture "$src"

    if ! "$BINARY" --emit llvm "$src" > "$ll" 2> /dev/null; then
        echo "[test]   sfn --emit llvm failed"
        return 1
    fi

    # Both `let t0 = monotonic_millis()` in `main` and `let end_ms = monotonic_millis()`
    # in `_ms_since` allocate i64 locals. Two i64 functions × two i64 allocas
    # each gives ≥ 4 lines (the issue's headline assertion is `alloca i64`).
    local hits
    hits="$(grep -cE '^\s*%[a-zA-Z_][a-zA-Z0-9_]* = alloca i64' "$ll" || true)"
    if [ "${hits:-0}" -lt 4 ]; then
        echo "[test]   expected ≥ 4 'alloca i64' lines (let bindings for monotonic_millis()), found $hits"
        return 1
    fi
    return 0
}

# ---- 3. No ABI primitive mismatch warnings (#634 headline) ----
test_no_abi_primitive_mismatch_warning() {
    local src="$SCRATCH/let_int_infer.sfn"
    local ll="$SCRATCH/let_int_infer.ll"
    write_fixture "$src"

    # Capture both stdout and stderr — the ABI mismatch warning is
    # printed to stderr by the lowering, but capturing both makes the
    # assertion robust against future routing changes.
    local combined
    combined="$("$BINARY" --emit llvm "$src" 2>&1 > "$ll" || true)"
    local hits
    hits="$(echo "$combined" | grep -cE 'ABI primitive mismatch' || true)"
    if [ "${hits:-0}" -gt 0 ]; then
        echo "[test]   expected 0 'ABI primitive mismatch' warnings, found $hits"
        echo "         (#634 headline ask — monotonic_millis() → int should not warn)"
        return 1
    fi
    return 0
}

# ---- 4. The declare line matches the C ABI (not the caller-visible type) ----
test_declare_line_matches_c_abi() {
    local src="$SCRATCH/let_int_infer.sfn"
    local ll="$SCRATCH/let_int_infer.ll"
    write_fixture "$src"

    if ! "$BINARY" --emit llvm "$src" > "$ll" 2> /dev/null; then
        echo "[test]   sfn --emit llvm failed"
        return 1
    fi

    # `declare double` must match the C function body (linker resolves
    # to a `double`-returning symbol). A `declare i64` here would
    # produce the `%rax`-vs-`%xmm0` mismatch that crashed #637 even
    # though the call site itself uses `call double`.
    if ! grep -qE '^declare double @sailfin_runtime_monotonic_millis\(\)' "$ll"; then
        echo "[test]   missing 'declare double @sailfin_runtime_monotonic_millis()' — declare must match C ABI"
        return 1
    fi
    if grep -qE '^declare i64 @sailfin_runtime_monotonic_millis\(\)' "$ll"; then
        echo "[test]   regression: 'declare i64 @sailfin_runtime_monotonic_millis()' emitted — would mis-link"
        return 1
    fi
    return 0
}

run_test "legacy coerce_and_emit_call emits 'call double + round + fptosi to i64' for monotonic_millis()" \
    test_legacy_path_emits_call_double_then_round_then_fptosi
run_test "let bindings for monotonic_millis() lower to 'alloca i64'" \
    test_let_binding_alloca_is_i64
run_test "monotonic_millis() lowering emits zero 'ABI primitive mismatch' warnings" \
    test_no_abi_primitive_mismatch_warning
run_test "declare line for sailfin_runtime_monotonic_millis matches C ABI ('declare double')" \
    test_declare_line_matches_c_abi

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
