#!/usr/bin/env bash
# End-to-end test for Slice E.1 (issue #488): default unsuffixed
# integer literals to `int` (i64) in LLVM lowering, while keeping
# `number` and `float` as aliases for `double`.
#
# This test pins three IR-level contracts:
#   1. Bare integer-literal arithmetic (`let a = 1; a + 2`) emits
#      `add i64` — no widening to `double`.
#   2. Decimal-literal arithmetic (`let a = 3.14; a + 0.5`) emits
#      `fadd double` — the float path is untouched.
#   3. `let x: float = 1; x + 2` keeps `fadd double` — the
#      explicit-`float` annotation pulls integer literals onto the
#      `double` side via the literal-coercion path in
#      `lower_binary_operation`.
#
# Usage:
#   compiler/tests/e2e/test_numeric_int_default.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_numeric_int_default.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"

PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-numeric-int-default-XXXXXX)"
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

emit_ir() {
    local src="$1"
    local ll="$2"
    if ! "$BINARY" emit -o "$ll" llvm "$src" > "$SCRATCH/emit.stdout" 2> "$SCRATCH/emit.stderr"; then
        echo "[test]   sfn emit llvm failed for $src"
        echo "[test]   stderr:"
        sed 's/^/[test]     /' "$SCRATCH/emit.stderr" | head -20
        return 1
    fi
    return 0
}

# Extract the body of a single user function from emitted IR. The
# emitted module always carries a trailing `add____<module>` helper
# (a synthesised binary-operator function lowered as `fadd double`)
# regardless of whether `main`'s body uses doubles, so naive
# whole-file greps can't distinguish "main uses fadd" from "the
# synthesised helper uses fadd". Returns the function body via stdout.
extract_main_body() {
    local ll="$1"
    awk '/^define (internal )?void @sailfin_user_main__/{flag=1; next} /^}/{if(flag){print; exit}} flag' "$ll"
}

# Acceptance criterion 1: `let a = 1; let b = a + 2` lowers to
# `add i64` with no `expected_type` annotation needed.
test_bare_integer_addition_emits_add_i64() {
    local src="$SCRATCH/int_default.sfn"
    local ll="$SCRATCH/int_default.ll"
    cat > "$src" <<'EOF'
fn main() ![io] {
    let a = 1;
    let b = a + 2;
    print.info(b);
}
EOF
    if ! emit_ir "$src" "$ll"; then return 1; fi
    local main_body
    main_body="$(extract_main_body "$ll")"
    if ! echo "$main_body" | grep -qE "add i64"; then
        echo "[test]   missing 'add i64' in main body for bare integer addition"
        echo "[test]   main body:"
        echo "$main_body" | sed 's/^/[test]     /' | head -20
        return 1
    fi
    if echo "$main_body" | grep -qE "fadd double"; then
        echo "[test]   regression: main body produced 'fadd double' for bare integer addition"
        echo "[test]   main body:"
        echo "$main_body" | sed 's/^/[test]     /' | head -20
        return 1
    fi
    return 0
}

# Acceptance criterion 2: `let a = 3.14; let b = a + 0.5` continues
# to lower to `fadd double` — decimal/exponent literals stay on the
# float path.
test_decimal_addition_emits_fadd_double() {
    local src="$SCRATCH/float_default.sfn"
    local ll="$SCRATCH/float_default.ll"
    cat > "$src" <<'EOF'
fn main() ![io] {
    let a = 3.14;
    let b = a + 0.5;
    print.info(b);
}
EOF
    if ! emit_ir "$src" "$ll"; then return 1; fi
    local main_body
    main_body="$(extract_main_body "$ll")"
    if ! echo "$main_body" | grep -qE "fadd double"; then
        echo "[test]   missing 'fadd double' in main body for decimal addition"
        echo "[test]   main body:"
        echo "$main_body" | sed 's/^/[test]     /' | head -20
        return 1
    fi
    return 0
}

# Acceptance criterion 3: `let x: float = 1; x + 2` keeps
# `fadd double` via the literal-coercion path. The `: float`
# annotation is the new spelling that maps to `double` (alongside
# the deprecated `: number` alias).
test_explicit_float_keeps_fadd_double() {
    local src="$SCRATCH/explicit_float.sfn"
    local ll="$SCRATCH/explicit_float.ll"
    cat > "$src" <<'EOF'
fn main() ![io] {
    let x: float = 1;
    let y = x + 2;
    print.info(y);
}
EOF
    if ! emit_ir "$src" "$ll"; then return 1; fi
    local main_body
    main_body="$(extract_main_body "$ll")"
    if ! echo "$main_body" | grep -qE "fadd double"; then
        echo "[test]   missing 'fadd double' in main body under '\: float' annotation"
        echo "[test]   main body:"
        echo "$main_body" | sed 's/^/[test]     /' | head -20
        return 1
    fi
    return 0
}

# Companion: `: number` is the deprecated alias and must continue
# to lower as `double`. Until E.2/E.3 migrate the compiler source,
# every existing `: number` annotation in the tree relies on this
# behaviour.
test_number_alias_still_lowers_as_double() {
    local src="$SCRATCH/number_alias.sfn"
    local ll="$SCRATCH/number_alias.ll"
    cat > "$src" <<'EOF'
fn main() ![io] {
    let x: number = 42;
    print.info(x);
}
EOF
    if ! emit_ir "$src" "$ll"; then return 1; fi
    local main_body
    main_body="$(extract_main_body "$ll")"
    # The integer literal `42` lowers as `double` because the
    # `: number` annotation pulls it onto the float path. Accept
    # every IEEE-754 spelling the LLVM frontend might emit:
    #   - `42`
    #   - `42.0` / `42.00...0`
    #   - `4.2e+01` / `4.2E+01`
    #   - `4.200000e+01` / `4.20000000e+01`
    # Two alternations cover the decimal forms (`42`/`42.0...`) and
    # the scientific forms (`4.2e+01`/`4.2000...e+01`).
    if ! echo "$main_body" | grep -qE "store double (42(\.0+)?|4\.2(0+)?[eE]\+0*1),"; then
        echo "[test]   missing 'store double 42(.0)|4.2e+01' for '\: number = 42'"
        echo "[test]   main body:"
        echo "$main_body" | sed 's/^/[test]     /' | head -20
        return 1
    fi
    if echo "$main_body" | grep -qE "store i64 42,"; then
        echo "[test]   regression: '\: number = 42' lowered as 'store i64 42'"
        return 1
    fi
    return 0
}

run_test "bare integer addition emits 'add i64'" \
    test_bare_integer_addition_emits_add_i64
run_test "decimal addition emits 'fadd double'" \
    test_decimal_addition_emits_fadd_double
run_test "'\: float' annotation keeps 'fadd double'" \
    test_explicit_float_keeps_fadd_double
run_test "'\: number' alias still lowers integer literals as 'double'" \
    test_number_alias_still_lowers_as_double

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
