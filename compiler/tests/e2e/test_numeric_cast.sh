#!/usr/bin/env bash
# End-to-end test for the numeric `as` cast LLVM lowering matrix
# (Slice D, docs/runtime_architecture.md §3.7 L2 + L3).
#
# PR #289 shipped the parser + AST + native-IR rendering for `as`
# casts but deferred the LLVM lowering matrix; numeric casts hit the
# generic "unsupported cast" diagnostic. Slice D adds the matrix on
# top of the existing pointer↔pointer / int↔pointer branches:
#
#   i*  → i*  (wider)   → sext (zext when source is i1)
#   i*  → i*  (narrower)→ trunc
#   i*  → double/float  → sitofp
#   double/float → i*   → fptosi
#   float → double      → fpext
#   double → float      → fptrunc
#   any  → i1 via `as`  → diagnostic ("use `x != 0`")
#
# Plus the dominant_type tightening: mixing int and float in a
# binary op without an explicit cast now bails the lowering (no
# silent fpext/sitofp widening) and emits a diagnostic.
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

# ---- Test: silent int + float coercion is rejected (dominant_type tightening) ----
# Pre-Slice-D, `let x: int = ...; x + (y: float)` would silently
# widen the integer side to double via sitofp, then `fadd double`.
# Slice D tightens `dominant_type` so the harmonise step bails with
# a diagnostic; the binary lowering returns a null operand and the
# function body falls back to `ret <type> <zero literal>`. Pin both
# the absence of a stealth `sitofp` and the absence of a `fadd
# double` over the parameter operands.
test_mixed_int_float_no_silent_widen() {
    local src="$SCRATCH/mixed.sfn"
    local ll="$SCRATCH/mixed.ll"
    cat > "$src" <<'EOF'
fn add_mixed(x: int, y: float) -> float { return x + y; }
EOF
    if ! "$BINARY" emit -o "$ll" llvm "$src" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed"
        return 1
    fi
    local body
    body="$(sed -n "/define double @add_mixed/,/^}/p" "$ll")"
    # The integer parameter `%x` (i64) must NOT have been silently
    # promoted via sitofp to feed a fadd against `%y` (double).
    if echo "$body" | grep -qE "sitofp i64 %x to double"; then
        echo "[test]   regression: silent int→float widening via sitofp survived dominant_type tightening"
        echo "$body"
        return 1
    fi
    if echo "$body" | grep -qE "fadd double %.*, %y"; then
        echo "[test]   regression: silent fadd over coerced int+float survived dominant_type tightening"
        echo "$body"
        return 1
    fi
    return 0
}

# ---- Test: explicit `as` cast threads through the cast lowering ----
# When the user writes the cast explicitly via a `let` binding
# (`let xf = x as float; return xf + y;`), the cast lowering fires
# and the binary lowering sees both sides as `double` — no sentinel.
# This locks in that the matrix is reachable through the cast
# recognizer's normal path.
test_explicit_cast_in_let_then_add() {
    local src="$SCRATCH/explicit.sfn"
    local ll="$SCRATCH/explicit.ll"
    cat > "$src" <<'EOF'
fn convert(x: int) -> float { return x as float; }
EOF
    if ! "$BINARY" emit -o "$ll" llvm "$src" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed"
        return 1
    fi
    if ! grep -qE "sitofp i64 %x to double" "$ll"; then
        echo "[test]   missing sitofp on convert(int) -> float as float"
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
run_test "f32 → double widening lowers as fpext" test_f32_to_double_fpext
run_test "double → f32 narrowing lowers as fptrunc" test_double_to_f32_fptrunc
run_test "mixing int + float in binary op no longer silently widens" test_mixed_int_float_no_silent_widen
run_test "explicit cast threads through cast lowering" test_explicit_cast_in_let_then_add

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
