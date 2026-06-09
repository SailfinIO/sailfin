#!/usr/bin/env bash
# Regression test for #1189: `(ptr as i64 + N) as * T` must keep the offset.
#
# A parenthesised pointer-arithmetic expression whose left operand is itself
# an ` as i64` cast — i.e. `(p as i64 + N) as * T` — used to drop the `+ N`
# offset entirely and collapse to a bare `bitcast <ptr> to T*`, aiming the
# result at the base address (offset 0) instead of `base + N`, with no
# diagnostic. The miscompile was fixed by the additive-precedence guard
# (`_cast_annotation_has_binary_continuation`, #1193): the inner ` as i64`
# is no longer the outermost operator, so the additive split peels `+ N`
# first and the full integer value is `inttoptr`'d.
#
# This test pins that IR shape so the composition cannot silently regress:
#
#   1. emit         — `sfn emit llvm <fixture>` produces IR.
#   2. ptrtoint     — the pointer operand is `ptrtoint`'d to i64.
#   3. add offset   — the offset survives as `add i64 …, 24`.
#   4. inttoptr     — the full i64 value is `inttoptr`'d to the target ptr.
#   5. no collapse  — NO `bitcast i8* %task to i64*` for the cast operand
#                     (the original bug signature).
#   6. mul offset   — a `+ i * 8` offset also survives (mul + add + inttoptr).

set -euo pipefail

BINARY="${1:?usage: test_ptr_arith_cast_offset.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-ptr-arith-cast-XXXXXX)"
trap 'rm -rf "$SCRATCH"' EXIT

FIXTURE="$SCRATCH/ptr_arith_cast.sfn"
# `inline_form` is the bug repro: the offset is packed inside the cast
# operand. `mul_form` exercises a computed offset (`i * 8`). `split_form`
# is the always-correct control (separate ptrtoint / add / inttoptr).
cat > "$FIXTURE" <<'EOF'
extern fn sink(p: * i64) -> void;

fn inline_form(task: * u8) -> void {
    let done_slot: * i64 = (task as i64 + 24) as * i64;
    sink(done_slot);
}

fn mul_form(task: * u8, i: i64) -> void {
    let slot: * i64 = (task as i64 + i * 8) as * i64;
    sink(slot);
}

fn split_form(task: * u8) -> void {
    let base: i64 = task as i64;
    let off: i64 = base + 24;
    let done_slot: * i64 = off as * i64;
    sink(done_slot);
}
EOF

LL="$SCRATCH/ptr_arith_cast.ll"

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

test_emit() {
    local log="$SCRATCH/emit.log"
    if ! "$BINARY" emit -o "$LL" llvm "$FIXTURE" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on fixture:"
        cat "$log"
        return 1
    fi
    return 0
}

# Isolate the `inline_form` function body so the assertions can't be
# satisfied by `split_form`'s (correct) IR elsewhere in the module.
_inline_body() {
    awk '/define void @inline_form/{f=1} f{print} f&&/^}/{exit}' "$LL"
}

test_ptrtoint() {
    if ! _inline_body | grep -qE 'ptrtoint i8\* %task to i64'; then
        echo "[test]   inline_form: missing 'ptrtoint i8* %task to i64'"
        _inline_body
        return 1
    fi
    return 0
}

test_add_offset() {
    if ! _inline_body | grep -qE 'add i64 %[a-zA-Z0-9._]+, 24'; then
        echo "[test]   inline_form: the '+ 24' offset did not survive as 'add i64 …, 24'"
        _inline_body
        return 1
    fi
    return 0
}

test_inttoptr() {
    if ! _inline_body | grep -qE 'inttoptr i64 %[a-zA-Z0-9._]+ to i64\*'; then
        echo "[test]   inline_form: missing 'inttoptr i64 … to i64*'"
        _inline_body
        return 1
    fi
    return 0
}

test_no_bitcast_collapse() {
    # The original bug: the whole expression collapsed to a single
    # `bitcast i8* %task to i64*`, discarding the ptrtoint/add/inttoptr.
    # Validate the extracted body is non-empty FIRST — otherwise this
    # negative assertion would pass vacuously if the function signature
    # drifts and `_inline_body` extracts nothing.
    local body
    body="$(_inline_body)"
    if [ -z "$body" ]; then
        echo "[test]   inline_form: could not extract function body (signature drift?)"
        return 1
    fi
    if printf '%s\n' "$body" | grep -qE 'bitcast i8\* %task to i64\*'; then
        echo "[test]   inline_form: offset dropped — collapsed to 'bitcast i8* %task to i64*':"
        printf '%s\n' "$body" | grep -nE 'bitcast i8\* %task to i64\*'
        return 1
    fi
    return 0
}

# Isolate `mul_form` for the computed-offset assertions.
_mul_body() {
    awk '/define void @mul_form/{f=1} f{print} f&&/^}/{exit}' "$LL"
}

test_mul_offset_survives() {
    # Validate the extracted body is non-empty FIRST so the negative
    # `bitcast` assertion below can't pass vacuously on signature drift.
    local body
    body="$(_mul_body)"
    if [ -z "$body" ]; then
        echo "[test]   mul_form: could not extract function body (signature drift?)"
        return 1
    fi
    # Documented shape: mul (i * 8) + add (base + offset) + inttoptr.
    if ! printf '%s\n' "$body" | grep -qE 'mul i64 '; then
        echo "[test]   mul_form: computed offset 'i * 8' did not survive as 'mul i64'"
        printf '%s\n' "$body"
        return 1
    fi
    if ! printf '%s\n' "$body" | grep -qE 'add i64 '; then
        echo "[test]   mul_form: base + offset did not survive as 'add i64'"
        printf '%s\n' "$body"
        return 1
    fi
    if ! printf '%s\n' "$body" | grep -qE 'inttoptr i64 %[a-zA-Z0-9._]+ to i64\*'; then
        echo "[test]   mul_form: missing 'inttoptr i64 … to i64*'"
        printf '%s\n' "$body"
        return 1
    fi
    if printf '%s\n' "$body" | grep -qE 'bitcast i8\* %task to i64\*'; then
        echo "[test]   mul_form: offset dropped — collapsed to 'bitcast i8* %task to i64*'"
        printf '%s\n' "$body"
        return 1
    fi
    return 0
}

run_test "sfn emit llvm produces IR" test_emit
run_test "inline_form: pointer operand is ptrtoint'd to i64" test_ptrtoint
run_test "inline_form: '+ 24' offset survives as 'add i64 …, 24'" test_add_offset
run_test "inline_form: full i64 value is inttoptr'd to i64*" test_inttoptr
run_test "inline_form: no collapse to 'bitcast i8* %task to i64*'" test_no_bitcast_collapse
run_test "mul_form: computed 'i * 8' offset survives to inttoptr" test_mul_offset_survives

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
