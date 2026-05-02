#!/usr/bin/env bash
# End-to-end coverage for struct field declaration separators.
#
# Pre-fix shape (PR #289 follow-up): `parse_struct_field` only
# accepted `;` as a field terminator. A struct declared with
# Rust/TS-style commas — `struct Pair { name: string, age: number }` —
# silently parsed as an empty struct (no diagnostic), the LLVM
# rendering emitted `%Pair = type {}`, and downstream field reads
# all loaded the lowering's "default zero" (literal "0" through
# number→string) regardless of the actual struct contents.
#
# The agent on PR #289 hit this and misdiagnosed it as a "string-
# aliasing seed bug" that blocked the numeric `as` cast lowering.
# The actual fix is a 1-line parser change accepting `,` and `;`
# (and an implicit `}` for the last field), matching the existing
# `parse_enum_variant_field` precedent at declarations.sfn:1338.
#
# Acceptance:
#   - Comma-separated struct fields render as `%T = type { i8*, i8* }`,
#     not `%T = type {}`.
#   - The full pipeline (parse → emit-native → llvm-lowering → run)
#     reports the correct field value for a struct-string-field read.
#     Pre-fix this returned the empty string or the literal "0".
#   - Discriminating against literal strings (`if op.t == "i64"`)
#     reaches the matching branch instead of falling through.
#   - Trailing-terminator-omitted form keeps working (`a: T, b: U }`).
#
# Usage:
#   compiler/tests/e2e/test_struct_field_separator.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_struct_field_separator.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-struct-sep-XXXXXX)"
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

# ---- Test: comma-separated fields render as a non-empty LLVM type ---
test_comma_struct_renders_with_fields() {
    local src="$SCRATCH/comma.sfn"
    local ll="$SCRATCH/comma.ll"
    cat > "$src" <<'EOF'
struct Pair {
    name: string,
    age: number
}

fn main() {
    let p = Pair { name: "x", age: 1 };
}
EOF
    if ! "$BINARY" emit -o "$ll" llvm "$src" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed for comma-separated struct"
        return 1
    fi
    # Pre-fix output: `%Pair = type {}`. Post-fix: `%Pair = type { i8*, double }`.
    if grep -qE "^%Pair = type \{\}" "$ll"; then
        echo "[test]   pre-fix regression: %Pair lowered as empty struct"
        grep -E "^%Pair = type" "$ll" || true
        return 1
    fi
    if ! grep -qE "^%Pair = type \{ i8\*, double \}" "$ll"; then
        echo "[test]   missing '%Pair = type { i8*, double }' in emitted IR"
        grep -E "^%Pair = type" "$ll" || true
        return 1
    fi
    return 0
}

# ---- Test: struct-string-field read returns the literal value -------
test_struct_string_field_read_round_trips() {
    local src="$SCRATCH/string_read.sfn"
    cat > "$src" <<'EOF'
struct LLVMOperand {
    llvm_type: string,
    value: string
}

fn classify(operand: LLVMOperand) -> string {
    if operand.llvm_type == "i1" { return "boolean"; }
    if operand.llvm_type == "i64" { return "integer"; }
    if operand.llvm_type == "double" { return "float"; }
    return "other";
}

fn main() ![io] {
    let a = LLVMOperand { llvm_type: "i64", value: "%0" };
    let b = LLVMOperand { llvm_type: "double", value: "%1" };
    let c = LLVMOperand { llvm_type: "i1", value: "%2" };
    print.info(classify(a));
    print.info(classify(b));
    print.info(classify(c));
}
EOF
    local out
    if ! out="$("$BINARY" run "$src" 2>&1)"; then
        echo "[test]   sfn run failed"
        echo "$out" | tail -20
        return 1
    fi
    # Pre-fix the comma-separated struct collapsed to `type {}`,
    # operand.llvm_type read back as garbage / null, all three
    # branches missed and `classify` returned "other" (or worse,
    # the runtime crashed silently on null concat).
    if ! grep -q "^\[info\] integer$" <<< "$out"; then
        echo "[test]   missing '[info] integer' (i64 branch did not match)"
        echo "$out"
        return 1
    fi
    if ! grep -q "^\[info\] float$" <<< "$out"; then
        echo "[test]   missing '[info] float' (double branch did not match)"
        echo "$out"
        return 1
    fi
    if ! grep -q "^\[info\] boolean$" <<< "$out"; then
        echo "[test]   missing '[info] boolean' (i1 branch did not match)"
        echo "$out"
        return 1
    fi
    return 0
}

# ---- Test: trailing-terminator-omit + mixed separators --------------
test_mixed_and_trailing_separators() {
    local src="$SCRATCH/mixed.sfn"
    local ll="$SCRATCH/mixed.ll"
    cat > "$src" <<'EOF'
struct Trio {
    a: string,
    b: number;
    c: boolean
}

fn main() {
    let t = Trio { a: "hi", b: 2, c: true };
}
EOF
    if ! "$BINARY" emit -o "$ll" llvm "$src" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed for mixed-separator struct"
        return 1
    fi
    if ! grep -qE "^%Trio = type \{ i8\*, double, i1 \}" "$ll"; then
        echo "[test]   missing '%Trio = type { i8*, double, i1 }' in emitted IR"
        grep -E "^%Trio = type" "$ll" || true
        return 1
    fi
    return 0
}

# ---- Test: struct-string-field read survives function boundaries ----
# Pre-fix the value was lost twice: once because the constructor
# failed to write the field (empty struct layout) and once because
# `return p.name` had no GEP to lower from. Verify the round-trip
# through a function call.
test_struct_string_field_through_function() {
    local src="$SCRATCH/through_fn.sfn"
    cat > "$src" <<'EOF'
struct Pair {
    label: string,
    count: number
}

fn label_of(p: Pair) -> string {
    return p.label;
}

fn main() ![io] {
    let p = Pair { label: "alpha", count: 42 };
    print.info(label_of(p));
}
EOF
    local out
    if ! out="$("$BINARY" run "$src" 2>&1)"; then
        echo "[test]   sfn run failed"
        echo "$out" | tail -20
        return 1
    fi
    if ! grep -q "^\[info\] alpha$" <<< "$out"; then
        echo "[test]   expected '[info] alpha', got:"
        echo "$out"
        return 1
    fi
    return 0
}

run_test "comma-separated struct fields render as non-empty %T = type { ... }" \
    test_comma_struct_renders_with_fields
run_test "struct-string-field comparison reaches the matching branch" \
    test_struct_string_field_read_round_trips
run_test "mixed comma/semicolon and trailing-omit field separators accepted" \
    test_mixed_and_trailing_separators
run_test "struct-string-field read survives function boundary" \
    test_struct_string_field_through_function

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
