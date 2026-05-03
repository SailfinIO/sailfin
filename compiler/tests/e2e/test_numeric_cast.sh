#!/usr/bin/env bash
# End-to-end test for the numeric `as` cast LLVM lowering matrix
# (Slice D, docs/runtime_architecture.md §3.7).
#
# PR #289 shipped the parser + AST + native-IR rendering for `as`
# casts but deferred the LLVM lowering matrix; numeric casts hit the
# generic "unsupported cast" diagnostic. Slice D adds the matrix on
# top of the existing pointer↔pointer / int↔pointer branches:
#
#   i1  → int (wider)   → zext
#   i*  → int (wider)   → sext
#   i*  → int (narrower)→ trunc
#   i1  → double/float  → uitofp
#   i*  → double/float  → sitofp
#   double/float → i*   → fptosi
#   float → double      → fpext
#   double → float      → fptrunc
#   any  → i1 via `as`  → diagnostic ("use `x != 0`")
#
# L2/L3 silent-widening rejection (the architect's `dominant_type`
# tightening) is **deferred to Slice E** — see issue #296.
#
# Usage:
#   compiler/tests/e2e/test_numeric_cast.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_numeric_cast.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

# Per-invocation scratch (portable mktemp form, GNU + BSD).
SCRATCH="$(mktemp -d -t sfn-cast-XXXXXX)"
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

# ---- Test: int → float lowers as sitofp ----
test_int_to_float_sitofp() {
    local src="$SCRATCH/int_to_float.sfn"
    local ll="$SCRATCH/int_to_float.ll"
    cat > "$src" <<'EOF'
fn convert(x: int) -> float { return x as float; }
EOF
    if ! "$BINARY" emit -o "$ll" llvm "$src" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed"
        return 1
    fi
    local body
    body="$(sed -n "/define double @convert/,/^}/p" "$ll")"
    if ! echo "$body" | grep -qE "sitofp i64 %x to double"; then
        echo "[test]   missing 'sitofp i64 %x to double' in @convert body"
        echo "$body" | head -20
        return 1
    fi
    return 0
}

# ---- Test: float → int lowers as fptosi ----
test_float_to_int_fptosi() {
    local src="$SCRATCH/float_to_int.sfn"
    local ll="$SCRATCH/float_to_int.ll"
    cat > "$src" <<'EOF'
fn back(x: float) -> int { return x as int; }
EOF
    if ! "$BINARY" emit -o "$ll" llvm "$src" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed"
        return 1
    fi
    local body
    body="$(sed -n "/define i64 @back/,/^}/p" "$ll")"
    if ! echo "$body" | grep -qE "fptosi double %x to i64"; then
        echo "[test]   missing 'fptosi double %x to i64' in @back body"
        echo "$body" | head -20
        return 1
    fi
    return 0
}

# ---- Test: i32 → i64 lowers as sext ----
test_i32_to_i64_sext() {
    local src="$SCRATCH/i32_to_i64.sfn"
    local ll="$SCRATCH/i32_to_i64.ll"
    cat > "$src" <<'EOF'
fn widen(x: i32) -> i64 { return x as i64; }
EOF
    if ! "$BINARY" emit -o "$ll" llvm "$src" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed"
        return 1
    fi
    local body
    body="$(sed -n "/define i64 @widen/,/^}/p" "$ll")"
    if ! echo "$body" | grep -qE "sext i32 %x to i64"; then
        echo "[test]   missing 'sext i32 %x to i64' in @widen body"
        echo "$body" | head -20
        return 1
    fi
    return 0
}

# ---- Test: i8 → i64 lowers as sext ----
test_i8_to_i64_sext() {
    local src="$SCRATCH/i8_to_i64.sfn"
    local ll="$SCRATCH/i8_to_i64.ll"
    cat > "$src" <<'EOF'
fn widen(x: i8) -> i64 { return x as i64; }
EOF
    if ! "$BINARY" emit -o "$ll" llvm "$src" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed"
        return 1
    fi
    local body
    body="$(sed -n "/define i64 @widen/,/^}/p" "$ll")"
    if ! echo "$body" | grep -qE "sext i8 %x to i64"; then
        echo "[test]   missing 'sext i8 %x to i64' in @widen body"
        echo "$body" | head -20
        return 1
    fi
    return 0
}

# ---- Test: i64 → i32 lowers as trunc ----
test_i64_to_i32_trunc() {
    local src="$SCRATCH/i64_to_i32.sfn"
    local ll="$SCRATCH/i64_to_i32.ll"
    cat > "$src" <<'EOF'
fn narrow(x: i64) -> i32 { return x as i32; }
EOF
    if ! "$BINARY" emit -o "$ll" llvm "$src" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed"
        return 1
    fi
    local body
    body="$(sed -n "/define i32 @narrow/,/^}/p" "$ll")"
    if ! echo "$body" | grep -qE "trunc i64 %x to i32"; then
        echo "[test]   missing 'trunc i64 %x to i32' in @narrow body"
        echo "$body" | head -20
        return 1
    fi
    return 0
}

# ---- Test: bool (i1) → i64 lowers as zext ----
# Source-side `bool` maps to LLVM `i1`. Widening to i64 must use
# `zext` (not sext) so `true` becomes 1 (not -1).
test_i1_to_i64_zext() {
    local src="$SCRATCH/i1_to_i64.sfn"
    local ll="$SCRATCH/i1_to_i64.ll"
    cat > "$src" <<'EOF'
fn widen(x: bool) -> i64 { return x as i64; }
EOF
    if ! "$BINARY" emit -o "$ll" llvm "$src" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed"
        return 1
    fi
    local body
    body="$(sed -n "/define i64 @widen/,/^}/p" "$ll")"
    if ! echo "$body" | grep -qE "zext i1 %x to i64"; then
        echo "[test]   missing 'zext i1 %x to i64' in @widen body"
        echo "$body" | head -20
        return 1
    fi
    if echo "$body" | grep -qE "sext i1 "; then
        echo "[test]   regression: i1 widened with sext (sign-extends true to -1)"
        return 1
    fi
    return 0
}

# ---- Test: f32 (LLVM float) → double lowers as fpext ----
test_f32_to_double_fpext() {
    local src="$SCRATCH/f32_to_double.sfn"
    local ll="$SCRATCH/f32_to_double.ll"
    cat > "$src" <<'EOF'
fn widen(x: f32) -> float { return x as float; }
EOF
    if ! "$BINARY" emit -o "$ll" llvm "$src" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed"
        return 1
    fi
    local body
    body="$(sed -n "/define double @widen/,/^}/p" "$ll")"
    if ! echo "$body" | grep -qE "fpext float %x to double"; then
        echo "[test]   missing 'fpext float %x to double' in @widen body"
        echo "$body" | head -20
        return 1
    fi
    return 0
}

# ---- Test: double → f32 (LLVM float) lowers as fptrunc ----
test_double_to_f32_fptrunc() {
    local src="$SCRATCH/double_to_f32.sfn"
    local ll="$SCRATCH/double_to_f32.ll"
    cat > "$src" <<'EOF'
fn narrow(x: float) -> f32 { return x as f32; }
EOF
    if ! "$BINARY" emit -o "$ll" llvm "$src" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed"
        return 1
    fi
    local body
    body="$(sed -n "/define float @narrow/,/^}/p" "$ll")"
    if ! echo "$body" | grep -qE "fptrunc double %x to float"; then
        echo "[test]   missing 'fptrunc double %x to float' in @narrow body"
        echo "$body" | head -20
        return 1
    fi
    return 0
}

# ---- Test: bool → float uses uitofp (not sitofp) ----
# `sitofp i1 1` produces -1.0 because LLVM treats `i1` as signed
# where `true` = -1. For `bool as float`, the user expects `true`
# → 1.0, so the lowering must use `uitofp` for the i1 source.
test_i1_to_double_uitofp() {
    local src="$SCRATCH/i1_to_double.sfn"
    local ll="$SCRATCH/i1_to_double.ll"
    cat > "$src" <<'EOF'
fn promote(x: bool) -> float { return x as float; }
EOF
    if ! "$BINARY" emit -o "$ll" llvm "$src" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed"
        return 1
    fi
    local body
    body="$(sed -n "/define double @promote/,/^}/p" "$ll")"
    if ! echo "$body" | grep -qE "uitofp i1 %x to double"; then
        echo "[test]   missing 'uitofp i1 %x to double' (would produce -1.0 with sitofp)"
        echo "$body" | head -10
        return 1
    fi
    if echo "$body" | grep -qE "sitofp i1 "; then
        echo "[test]   regression: i1 source promoted via sitofp (true → -1.0)"
        return 1
    fi
    return 0
}

# ---- Test: pointer → bool is rejected (not ptrtoint) ----
# Without the early `as bool` check, `ptr as bool` would lower to
# `ptrtoint ptr to i1`, which is a low-bit reinterpretation, not
# the documented "is non-null" comparison the user wants. The
# rejection must run before the pointer→int branch.
test_ptr_to_bool_rejected() {
    local src="$SCRATCH/ptr_to_bool.sfn"
    local ll="$SCRATCH/ptr_to_bool.ll"
    cat > "$src" <<'EOF'
fn isset(x: *u8) -> bool { return x as bool; }
EOF
    if ! "$BINARY" emit -o "$ll" llvm "$src" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed"
        return 1
    fi
    local body
    body="$(sed -n "/define i1 @isset/,/^}/p" "$ll")"
    if echo "$body" | grep -qE "ptrtoint i8\* %x to i1"; then
        echo "[test]   regression: ptr → bool lowered via ptrtoint instead of being rejected"
        echo "$body"
        return 1
    fi
    # Cast lowering bails with null operand; lower_return falls back
    # to the default literal `false` for i1.
    if ! echo "$body" | grep -qE "^[[:space:]]*ret i1 false"; then
        echo "[test]   expected 'ret i1 false' fallback after rejected ptr→bool cast"
        echo "$body"
        return 1
    fi
    return 0
}

run_test "int → float lowers as sitofp i64 to double" test_int_to_float_sitofp
run_test "float → int lowers as fptosi double to i64" test_float_to_int_fptosi
run_test "i32 → i64 widening lowers as sext" test_i32_to_i64_sext
run_test "i8 → i64 widening lowers as sext" test_i8_to_i64_sext
run_test "i64 → i32 narrowing lowers as trunc" test_i64_to_i32_trunc
run_test "bool (i1) → i64 widening lowers as zext (not sext)" test_i1_to_i64_zext
run_test "bool → double uses uitofp (not sitofp; true → 1.0)" test_i1_to_double_uitofp
run_test "f32 → double widening lowers as fpext" test_f32_to_double_fpext
run_test "double → f32 narrowing lowers as fptrunc" test_double_to_f32_fptrunc
run_test "ptr → bool is rejected (not ptrtoint)" test_ptr_to_bool_rejected

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
