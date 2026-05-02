#!/usr/bin/env bash
# End-to-end test for bitwise + shift operators on integer types
# (Slice B of the int/float numeric types migration —
# `docs/runtime_architecture.md` §3.7 L4).
#
# Pre-Slice-B, `x & y` parsed and typechecked cleanly but the
# LLVM lowering had no dispatch for `&`/`|`/`^` and the
# expression silently fell through to a default — the function's
# `return x & y;` emitted `ret i64 0` with no diagnostic.
# `x << y` was even worse: the comparison matcher matched the
# inner `<` of `<<` and tried to lower it as a comparison,
# producing nonsense.
#
# This script pins the LLVM emission for each bitwise + shift
# operator on integer-annotated operands. A regression where any
# one silently emits broken IR or a non-bitwise instruction
# surfaces here.
#
# Usage:
#   compiler/tests/e2e/test_numeric_bitwise.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_numeric_bitwise.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

# Per-invocation scratch (portable mktemp form, GNU + BSD).
SCRATCH="$(mktemp -d -t sfn-bitwise-XXXXXX)"
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

# ---- Test: each bitwise/shift op emits the right LLVM op ----
test_bitwise_ops_lower_correctly() {
    local src="$SCRATCH/bitwise_ops.sfn"
    local ll="$SCRATCH/bitwise_ops.ll"
    cat > "$src" <<'EOF'
fn test(x: int, y: int) -> int {
    let a = x & y;
    let b = x | y;
    let c = x ^ y;
    let d = x << 2;
    let e = x >> 1;
    return a + b + c + d + e;
}
EOF
    if ! "$BINARY" emit -o "$ll" llvm "$src" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed for bitwise ops"
        return 1
    fi
    local body
    body="$(sed -n "/define i64 @test/,/^}/p" "$ll")"
    local missing=0
    if ! echo "$body" | grep -qE "^[[:space:]]*%[a-zA-Z0-9_]+ = and i64 "; then
        echo "[test]   missing 'and i64' in user main"
        missing=$((missing + 1))
    fi
    if ! echo "$body" | grep -qE "^[[:space:]]*%[a-zA-Z0-9_]+ = or i64 "; then
        echo "[test]   missing 'or i64' in user main"
        missing=$((missing + 1))
    fi
    if ! echo "$body" | grep -qE "^[[:space:]]*%[a-zA-Z0-9_]+ = xor i64 "; then
        echo "[test]   missing 'xor i64' in user main"
        missing=$((missing + 1))
    fi
    if ! echo "$body" | grep -qE "^[[:space:]]*%[a-zA-Z0-9_]+ = shl i64 "; then
        echo "[test]   missing 'shl i64' in user main"
        missing=$((missing + 1))
    fi
    if ! echo "$body" | grep -qE "^[[:space:]]*%[a-zA-Z0-9_]+ = ashr i64 "; then
        echo "[test]   missing 'ashr i64' in user main (signed right shift)"
        missing=$((missing + 1))
    fi
    # Pre-Slice-B regression: the literal `2` on the RHS of a
    # shift defaulted to `double`, then `dominant_type` widened
    # both sides, then operation_name returned empty — causing
    # `sitofp` instructions and broken IR. Assert there are no
    # spurious sitofp/fadd in the user main.
    if echo "$body" | grep -qE "sitofp i64 .* to double"; then
        echo "[test]   regression: int operand sitofp'd to double inside bitwise/shift body"
        missing=$((missing + 1))
    fi
    return "$missing"
}

# ---- Test: bitwise + shift literals get integer-typed RHS ----
# Pre-fix, `x << 2` lowered the literal `2` as `double 2.0`;
# now the LHS-type-propagation in `lower_binary_operation`
# threads `i64` as the expected_type so the integer-literal
# short-circuit fires.
test_shift_literal_stays_i64() {
    local src="$SCRATCH/shift_lit.sfn"
    local ll="$SCRATCH/shift_lit.ll"
    cat > "$src" <<'EOF'
fn shift_lit(x: int) -> int {
    return x << 8;
}
EOF
    if ! "$BINARY" emit -o "$ll" llvm "$src" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed for shift-literal case"
        return 1
    fi
    if ! grep -qE "shl i64 %[a-zA-Z0-9_]+, 8" "$ll"; then
        echo "[test]   missing 'shl i64 %x, 8' — RHS literal may not have been typed as i64"
        return 1
    fi
    return 0
}

# ---- Test: precedence — flag-mask idiom parses correctly ----
# `(flags & mask) == mask` must lower as `icmp eq` over the
# bitwise-AND result, not as `flags & (mask == mask)`. The
# parser's binary_precedence change is what pins this.
test_flag_mask_precedence() {
    local src="$SCRATCH/flag_mask.sfn"
    local ll="$SCRATCH/flag_mask.ll"
    cat > "$src" <<'EOF'
fn has_flag(flags: int, mask: int) -> bool {
    return (flags & mask) == mask;
}
EOF
    if ! "$BINARY" emit -o "$ll" llvm "$src" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed for flag-mask case"
        return 1
    fi
    local body
    body="$(sed -n "/define i1 @has_flag/,/^}/p" "$ll")"
    if ! echo "$body" | grep -qE "and i64"; then
        echo "[test]   missing 'and i64' — bitwise-AND inside the parens didn't lower"
        return 1
    fi
    if ! echo "$body" | grep -qE "icmp eq i64"; then
        echo "[test]   missing 'icmp eq i64' — outer comparison didn't lower"
        return 1
    fi
    return 0
}

run_test "bitwise & | ^ << >> emit and/or/xor/shl/ashr i64" test_bitwise_ops_lower_correctly
run_test "shift with int literal RHS keeps i64 typing" test_shift_literal_stays_i64
run_test "(flags & mask) == mask precedence: bitwise-AND inside, comparison outside" test_flag_mask_precedence

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
