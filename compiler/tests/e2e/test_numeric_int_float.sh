#!/usr/bin/env bash
# End-to-end test for the int/float numeric types Phase 1 #2 work.
#
# Pins the LLVM emission for `int` (i64), `float` (double), and the
# extern accept-list extensions. Pre-fix, `let x: float = 3.14` was
# silently lowered as a string pointer (i8*) — `+` then routed
# through `sailfin_runtime_string_concat`. This test makes sure the
# regression surfaces at `make test-e2e` before it can ship.
#
# Acceptance:
#   - `let x: int = 42; let y = x + 1;` emits `add i64`, no `fadd double`.
#   - `let x: float = 3.14; let y = x + 2.0;` emits `fadd double`, no
#     string_concat.
#   - `extern fn add_one(x: int) -> int;` lowers to
#     `declare i64 @add_one(i64)`.
#   - `extern fn double_it(x: float) -> float;` lowers to
#     `declare double @double_it(double)`.
#
# Usage:
#   compiler/tests/e2e/test_numeric_int_float.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_numeric_int_float.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

# Per-invocation scratch dir + named files. `mktemp -d -t prefix-XXXXXX`
# is portable across GNU and BSD; `--suffix=.ll` is GNU-only and would
# break on macOS (lesson from PR #283).
SCRATCH="$(mktemp -d -t sfn-numeric-XXXXXX)"
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

# ---- Test: int arithmetic emits add i64 ----
test_int_add_i64() {
    local src="$SCRATCH/int_add.sfn"
    local ll="$SCRATCH/int_add.ll"
    cat > "$src" <<'EOF'
fn main() {
    let x: int = 42;
    let y: int = 1;
    let z = x + y;
}
EOF
    if ! "$BINARY" emit -o "$ll" llvm "$src" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed for int arithmetic"
        return 1
    fi
    # Scope to the user main body (avoids matching `fadd double` in
    # the runtime's @add(double, double) helper that ships in every
    # IR file).
    local main_body
    main_body="$(sed -n "/define void @sailfin_user_main/,/^}/p" "$ll")"
    if ! echo "$main_body" | grep -qE "^[[:space:]]*%[a-zA-Z0-9_]+ = add i64 "; then
        echo "[test]   missing 'add i64' in user main"
        echo "$main_body" | head -20
        return 1
    fi
    if echo "$main_body" | grep -qE "^[[:space:]]*%[a-zA-Z0-9_]+ = fadd double "; then
        echo "[test]   unexpected 'fadd double' in user main (int should not coerce)"
        return 1
    fi
    return 0
}

# ---- Test: float arithmetic emits fadd double, NOT string_concat ----
test_float_fadd_double() {
    local src="$SCRATCH/float_add.sfn"
    local ll="$SCRATCH/float_add.ll"
    cat > "$src" <<'EOF'
fn main() {
    let x: float = 3.14;
    let y: float = 2.0;
    let z = x + y;
}
EOF
    if ! "$BINARY" emit -o "$ll" llvm "$src" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed for float arithmetic"
        return 1
    fi
    # The pre-fix bug routed `let x: float = ...` through string
    # lowering (i8* alloca + sailfin_runtime_string_concat). Assert
    # NEITHER appears in the float main.
    local main_body
    main_body="$(sed -n "/define void @sailfin_user_main/,/^}/p" "$ll")"
    if echo "$main_body" | grep -q "alloca i8\*"; then
        echo "[test]   pre-fix regression: float local lowered as i8* (string)"
        echo "$main_body" | head -20
        return 1
    fi
    if echo "$main_body" | grep -q "sailfin_runtime_string_concat"; then
        echo "[test]   pre-fix regression: float + float lowered to string_concat"
        return 1
    fi
    if ! echo "$main_body" | grep -qE "^[[:space:]]*%[a-zA-Z0-9_]+ = fadd double "; then
        echo "[test]   missing 'fadd double' in emitted float main"
        echo "$main_body" | head -20
        return 1
    fi
    return 0
}

# ---- Test: extern fn with int/float accepted + clean declare ----
test_extern_int_float_declare() {
    local src="$SCRATCH/extern_int_float.sfn"
    local ll="$SCRATCH/extern_int_float.ll"
    cat > "$src" <<'EOF'
extern fn add_one(x: int) -> int;
extern fn double_it(x: float) -> float;
extern fn scale(value: int, factor: float) -> float;
EOF
    if ! "$BINARY" check "$src" > /dev/null 2>&1; then
        echo "[test]   sfn check rejected int/float extern signatures"
        "$BINARY" check "$src" 2>&1 | tail -20
        return 1
    fi
    if ! "$BINARY" emit -o "$ll" llvm "$src" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed on int/float externs"
        return 1
    fi
    local missing=0
    if ! grep -qE "^declare i64 @add_one\(i64( |%)" "$ll"; then
        echo "[test]   missing 'declare i64 @add_one(i64)' in emitted IR"
        missing=$((missing + 1))
    fi
    if ! grep -qE "^declare double @double_it\(double( |%)" "$ll"; then
        echo "[test]   missing 'declare double @double_it(double)' in emitted IR"
        missing=$((missing + 1))
    fi
    if ! grep -qE "^declare double @scale\(i64( |%)" "$ll"; then
        echo "[test]   missing 'declare double @scale(i64, double)' in emitted IR"
        missing=$((missing + 1))
    fi
    return "$missing"
}

# ---- Test: float comparison (both sides annotated) emits fcmp ----
# Both operands are annotated `: float` so the harmonise step has
# matching types and doesn't fall back to `double`-by-default.
test_float_fcmp() {
    local src="$SCRATCH/float_cmp.sfn"
    local ll="$SCRATCH/float_cmp.ll"
    cat > "$src" <<'EOF'
fn cmp(x: float, y: float) -> bool {
    return x > y;
}
EOF
    if ! "$BINARY" emit -o "$ll" llvm "$src" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed for float comparison"
        return 1
    fi
    if ! grep -qE "fcmp ogt double " "$ll"; then
        echo "[test]   missing 'fcmp ogt double' in emitted IR"
        return 1
    fi
    return 0
}

# ---- Test: int comparison (both sides annotated) emits icmp ----
# Caveat: an unannotated int literal (e.g. `x > 0`) currently
# defaults to `double` and coerces both sides — that's a pre-
# existing limitation tied to the bare-literal defaulting work
# (slice E, deferred). When both operands are annotated `: int`,
# the integer comparison path lights up correctly.
test_int_icmp() {
    local src="$SCRATCH/int_cmp.sfn"
    local ll="$SCRATCH/int_cmp.ll"
    cat > "$src" <<'EOF'
fn cmp(x: int, y: int) -> bool {
    return x > y;
}
EOF
    if ! "$BINARY" emit -o "$ll" llvm "$src" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed for int comparison"
        return 1
    fi
    if ! grep -qE "icmp sgt i64 " "$ll"; then
        echo "[test]   missing 'icmp sgt i64' in emitted IR"
        return 1
    fi
    return 0
}

run_test "int + int emits add i64 (no fadd double)" test_int_add_i64
run_test "float + float emits fadd double (no string_concat)" test_float_fadd_double
run_test "extern fn with int/float emits clean declare directives" test_extern_int_float_declare
run_test "float comparison emits fcmp ogt double" test_float_fcmp
run_test "int comparison emits icmp sgt i64" test_int_icmp

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
