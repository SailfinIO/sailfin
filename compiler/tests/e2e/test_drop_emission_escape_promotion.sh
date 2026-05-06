#!/usr/bin/env bash
# End-to-end test for the conservative escape-promotion rule (M1.5.5,
# issue #329).
#
# What the M1.5.5 PR ships, end-to-end:
#
#   1. The compiler still emits a `declare void @sfn_rc_release(i8*)`
#      preamble line for every module — the M1.5.2 runtime ABI seam is
#      preserved through the escape-promotion changes.
#   2. A heap-typed local that is the operand of a `return` is promoted
#      to `allocation_kind == "rc"` (the unit test
#      `compiler/tests/unit/escape_promotion_test.sfn` pins the
#      promotion logic itself).
#   3. A primitive-typed return (`int` -> `i64`) does NOT trigger any
#      `sfn_rc_release` call — `is_heap_type` excludes scalars, so the
#      runtime never sees a release on a non-pointer.
#   4. A parameter return (`fn forwarder(p: string) -> string { return p; }`)
#      does not promote `p` either — only locals are reached by the
#      `find_local_binding` step inside `lower_return_instruction`.
#
# Now that M1.5.3 (issue #327) ships explicit-return drop emission, the
# `make_string` function — whose returned local is escape-promoted to
# `kind == "rc"` — produces a real `call void @sfn_rc_release(...)` line
# at its return. The floor below is `>= 1` for that reason.
#
# Usage:
#   compiler/tests/e2e/test_drop_emission_escape_promotion.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_drop_emission_escape_promotion.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FIXTURE="$SCRIPT_DIR/fixtures/escape_promotion_basic.sfn"

# M1.5.3 (issue #327) made explicit `return` a real drop site. The
# escape-promoted heap-typed return in `make_string` now emits `>= 1`
# release call. `make_int` (primitive return) and `forwarder` (parameter
# return) still emit zero — the per-function tests below scope to those.
EXPECT_RELEASE_CALLS_GE=1

PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-escape-promotion-XXXXXX)"
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
    local out="$1"
    "$BINARY" emit -o "$out" llvm "$FIXTURE" > /dev/null 2>&1
}

# ---- (1) declare line is present in compiled IR ----
test_declare_line_present() {
    local ll="$SCRATCH/escape_promotion.ll"
    if ! emit_ir "$ll"; then
        echo "[test]   sfn emit llvm failed for escape_promotion_basic.sfn"
        return 1
    fi
    if ! grep -qE '^declare void @sfn_rc_release\(i8\*\)' "$ll"; then
        echo "[test]   missing 'declare void @sfn_rc_release(i8*)' in emitted IR"
        return 1
    fi
    return 0
}

# ---- (2) primitive return must NOT emit a release call ----
test_primitive_return_has_no_release() {
    local ll="$SCRATCH/escape_promotion_int.ll"
    if ! emit_ir "$ll"; then
        echo "[test]   sfn emit llvm failed (primitive return case)"
        return 1
    fi
    # Carve out the make_int function and confirm no release calls fire
    # inside its body. `awk` walks until the closing brace so we don't
    # accidentally count releases from sibling functions.
    local make_int_releases
    make_int_releases="$(awk '/^define i64 @make_int/{flag=1} flag{print} /^\}/{if(flag){flag=0}}' "$ll" \
        | grep -cE 'call void @sfn_rc_release' || true)"
    if [ "${make_int_releases:-0}" -ne 0 ]; then
        echo "[test]   make_int (primitive return) emitted $make_int_releases "
        echo "         release call(s); expected 0 — is_heap_type must reject i64"
        return 1
    fi
    return 0
}

# ---- (3) parameter return must NOT emit a release call ----
test_parameter_return_has_no_release() {
    local ll="$SCRATCH/escape_promotion_param.ll"
    if ! emit_ir "$ll"; then
        echo "[test]   sfn emit llvm failed (parameter return case)"
        return 1
    fi
    local fwd_releases
    fwd_releases="$(awk '/^define i8\* @forwarder/{flag=1} flag{print} /^\}/{if(flag){flag=0}}' "$ll" \
        | grep -cE 'call void @sfn_rc_release' || true)"
    if [ "${fwd_releases:-0}" -ne 0 ]; then
        echo "[test]   forwarder (parameter return) emitted $fwd_releases "
        echo "         release call(s); expected 0 — promotion targets locals only"
        return 1
    fi
    return 0
}

# ---- (4) total call-site count meets the current floor ----
test_release_call_count_meets_floor() {
    local ll="$SCRATCH/escape_promotion_total.ll"
    if ! emit_ir "$ll"; then
        echo "[test]   sfn emit llvm failed (release-count case)"
        return 1
    fi
    local total
    total="$(grep -cE 'call void @sfn_rc_release' "$ll" || true)"
    if [ "${total:-0}" -lt "$EXPECT_RELEASE_CALLS_GE" ]; then
        echo "[test]   expected >= $EXPECT_RELEASE_CALLS_GE 'call void @sfn_rc_release' "
        echo "         lines, got $total. Either M1.5.3 regressed the explicit-"
        echo "         return drop emission, or escape promotion stopped flipping"
        echo "         the heap-returned local."
        return 1
    fi
    return 0
}

run_test "compiler emits declare void @sfn_rc_release(i8*) for the fixture" \
    test_declare_line_present
run_test "primitive (i64) return does not emit a release call" \
    test_primitive_return_has_no_release
run_test "parameter return does not emit a release call" \
    test_parameter_return_has_no_release
run_test "total release-call count meets EXPECT_RELEASE_CALLS_GE=$EXPECT_RELEASE_CALLS_GE" \
    test_release_call_count_meets_floor

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
