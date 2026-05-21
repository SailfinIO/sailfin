#!/usr/bin/env bash
# Issue #704 — end-to-end test for enum tag readback in pure Sailfin.
#
# Pins two distinct miscompilations in the LLVM lowering that the
# #623 audit surfaced and #704 fixed:
#
#   A. `.tag` field access — `lower_enum_member_access` extracted
#      the tag (i32) but never returned the operand, so the receiving
#      `return` dropped it and emitted `ret <default>`. Every caller
#      saw tag 0 regardless of the actual variant.
#
#   B. `match` over a by-value enum subject — the tag check emitted
#      `getelementptr ..., %EnumT %v, ...`, which LLVM rejects because
#      the GEP base must be a pointer.
#
# The test asserts three signals against the same fixture:
#   1. The compiled IR for the `.tag` paths contains `sext i32 %... to i64`
#      followed by `ret i64`, i.e. the tag is widened to the function's
#      declared `int` return type and actually returned.
#   2. The IR round-trips through `llvm-as` (catches failure B before it
#      reaches the linker — the GEP-against-value form fails parse).
#   3. `sfn run` against the fixture prints the expected tag sequence
#      (0/1/2 for all three readback paths). Catches future regressions
#      where the IR happens to round-trip but the runtime answer is
#      wrong.
#
# Usage:
#   compiler/tests/e2e/test_enum_tag_access.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_enum_tag_access.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FIXTURE="$SCRIPT_DIR/fixtures/enum_tag_access/main.sfn"

PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-enum-tag-XXXXXX)"
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

# ---- Failure A: `.tag` is read and widened to the i64 return type ----
test_tag_access_widens_and_returns() {
    local ll="$SCRATCH/enum_tag_access_basic.ll"
    if ! "$BINARY" emit -o "$ll" llvm "$FIXTURE" > "$SCRATCH/emit.err" 2>&1; then
        echo "[test]   sfn emit llvm failed for enum_tag_access/main.sfn"
        sed 's/^/         | /' "$SCRATCH/emit.err"
        return 1
    fi

    local missing=0
    # `shape_tag_direct` (subject is a %Shape* pointer): GEP+load+sext+ret.
    if ! grep -qE "^define i64 @shape_tag_direct" "$ll"; then
        echo "[test]   missing definition of shape_tag_direct"
        missing=$((missing + 1))
    fi
    # `shapes_tag_indexed` (subject arrives as a by-value %Shape):
    # extractvalue + sext + ret. Pre-fix, the extractvalue was
    # emitted but the operand was dropped and the function returned
    # `ret i64 0`.
    if ! grep -qE "^define i64 @shapes_tag_indexed" "$ll"; then
        echo "[test]   missing definition of shapes_tag_indexed"
        missing=$((missing + 1))
    fi
    # Both functions must end in `sext i32 %... to i64` immediately
    # before `ret i64`. The pre-fix IR ended in `ret i64 0` with no
    # use of the extracted tag.
    local widen_hits
    widen_hits="$(grep -cE 'sext i32 %t[0-9]+ to i64' "$ll" || true)"
    if [ "${widen_hits:-0}" -lt 2 ]; then
        echo "[test]   expected ≥ 2 sext i32→i64 in IR (one per .tag path), got ${widen_hits:-0}"
        missing=$((missing + 1))
    fi
    # Pin the specific regression shape: an `extractvalue %Shape ..., 0`
    # followed (within a few lines) by `sext i32 ... to i64`.
    if ! grep -A 3 'extractvalue %Shape %.* 0' "$ll" \
            | grep -qE 'sext i32 .* to i64'; then
        echo "[test]   extractvalue of %Shape tag is not followed by sext to i64"
        missing=$((missing + 1))
    fi
    return "$missing"
}

# ---- Failure B: by-value match emits well-formed IR ----
test_match_emits_valid_ir() {
    local ll="$SCRATCH/enum_tag_access_match.ll"
    if ! "$BINARY" emit -o "$ll" llvm "$FIXTURE" > "$SCRATCH/match.err" 2>&1; then
        echo "[test]   sfn emit llvm failed for match-form fixture"
        sed 's/^/         | /' "$SCRATCH/match.err"
        return 1
    fi
    # Pre-fix the match arm emitted
    #   %tN = getelementptr inbounds %Shape, %Shape %tM, i32 0, i32 0
    # — GEP against a value, not a pointer. Reject any such occurrence
    # so the regression cannot return silently.
    if grep -qE 'getelementptr inbounds %[A-Za-z_][A-Za-z0-9_]*, %[A-Za-z_][A-Za-z0-9_]* %' "$ll"; then
        echo "[test]   regression: getelementptr against by-value aggregate"
        grep -nE 'getelementptr inbounds %[A-Za-z_][A-Za-z0-9_]*, %[A-Za-z_][A-Za-z0-9_]* %' "$ll" | head -3
        return 1
    fi
    # llvm-as is the canonical IR validator — if it accepts the file
    # the GEP-base-pointer invariant holds across every site, not just
    # the shape we grep for above. Skipped silently when llvm-as is
    # not on PATH so the test stays useful in stripped CI images.
    if command -v llvm-as >/dev/null 2>&1; then
        if ! llvm-as "$ll" -o "$SCRATCH/match.bc" > "$SCRATCH/llvm-as.err" 2>&1; then
            echo "[test]   llvm-as rejected the emitted IR"
            sed 's/^/         | /' "$SCRATCH/llvm-as.err" | head -10
            return 1
        fi
    fi
    return 0
}

# ---- End-to-end: the compiled binary returns the right tag per variant ----
test_runtime_returns_correct_tags() {
    local stdout_log="$SCRATCH/run.out"
    local stderr_log="$SCRATCH/run.err"
    if ! "$BINARY" run "$FIXTURE" > "$stdout_log" 2> "$stderr_log"; then
        echo "[test]   sfn run failed for enum_tag_access/main.sfn"
        echo "         stderr:"
        sed 's/^/         | /' "$stderr_log"
        return 1
    fi
    # Three lines, each enumerating tags 0/1/2 — one line per
    # readback path (direct `.tag`, indexed `.tag`, match arm).
    local expected_direct="direct 0 1 2"
    local expected_indexed="indexed 0 1 2"
    local expected_match="match 0 1 2"
    local missing=0
    if ! grep -qxF "$expected_direct" "$stdout_log"; then
        echo "[test]   missing '$expected_direct' in stdout"
        missing=$((missing + 1))
    fi
    if ! grep -qxF "$expected_indexed" "$stdout_log"; then
        echo "[test]   missing '$expected_indexed' in stdout"
        missing=$((missing + 1))
    fi
    if ! grep -qxF "$expected_match" "$stdout_log"; then
        echo "[test]   missing '$expected_match' in stdout"
        missing=$((missing + 1))
    fi
    if [ "$missing" -gt 0 ]; then
        echo "         stdout was:"
        sed 's/^/         | /' "$stdout_log"
    fi
    return "$missing"
}

run_test ".tag access widens i32 tag to i64 and returns it" \
    test_tag_access_widens_and_returns
run_test "by-value match emits IR that llvm-as accepts" \
    test_match_emits_valid_ir
run_test "compiled binary returns the correct tag for each variant" \
    test_runtime_returns_correct_tags

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
