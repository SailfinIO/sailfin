#!/usr/bin/env bash
# End-to-end test for the M1.A string-literal ABI lock (issue #391)
# and the M1.2 `sfn_str_concat` registry flip (issue #461).
#
# Pins the emitted LLVM IR contract for string literals:
#   - Literals lower to `{i8*, i64}` aggregates (data ptr + byte length).
#   - `s.length` resolves to a direct `extractvalue ..., 1` (no
#     `sailfin_runtime_string_length` call).
#   - `+` on strings emits the arena-aware aggregate call shape
#     (renamed in #715 to the bare canonical symbol):
#       call {i8*, i64} @sfn_str_concat({i8*, i64}, {i8*, i64}, ptr @sfn_default_arena)
#     followed by an `extractvalue {i8*, i64} %t, 0` that recovers
#     the legacy `i8*` operand. The C-side `sfn_str_concat_arena`
#     forwarder still exports (so seed-built IR keeps linking) but
#     fresh emission must reach the bare symbol.
#   - No consumer re-extracts a literal as `[N x i8]` (regression guard
#     against the legacy `bitcast i8* to [N x i8]*` consumer pattern).
#
# Usage:
#   compiler/tests/e2e/test_string_aggregate_shape.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_string_aggregate_shape.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FIXTURE="$SCRIPT_DIR/fixtures/string_aggregate_shape.sfn"

PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-string-shape-XXXXXX)"
trap 'rm -rf "$SCRATCH"' EXIT

LL="$SCRATCH/string_aggregate_shape.ll"

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

emit_ir_once() {
    if [ -s "$LL" ]; then
        return 0
    fi
    if ! "$BINARY" emit -o "$LL" llvm "$FIXTURE" > "$SCRATCH/emit.stderr" 2>&1; then
        echo "[test]   sfn emit llvm failed for string_aggregate_shape.sfn"
        sed 's/^/[test]     /' "$SCRATCH/emit.stderr" | head -20
        return 1
    fi
    return 0
}

# A1 — Aggregate type appears in the emitted IR.
test_aggregate_type_appears() {
    emit_ir_once || return 1
    local hits
    hits="$(grep -cE '\{i8\*, i64\}' "$LL" || true)"
    if [ "${hits:-0}" -lt 4 ]; then
        echo "[test]   expected at least 4 references to {i8*, i64}, got ${hits:-0}"
        return 1
    fi
    return 0
}

# A2 — Each literal builds the aggregate via two `insertvalue` ops,
# plus one `i8*`-to-aggregate coercion for the `combined` operand
# passed into `print.info` after M2.8 (#401) flipped print to the
# SfnString aggregate ABI. The fixture writes "hello".length,
# "world".length, "hello" + "world", and `print.info(combined)`:
#   - 4 string literals × 1 `undef, i8*` per literal = 4
#   - 1 coercion shim (concat result is still legacy `i8*`,
#     coerced to `{i8*, i64}` via `sfn_str_len` for the call) = 1
test_literal_uses_insertvalue() {
    emit_ir_once || return 1
    local data_inserts
    data_inserts="$(grep -cE '= insertvalue \{i8\*, i64\} undef, i8\*' "$LL" || true)"
    if [ "${data_inserts:-0}" -ne 5 ]; then
        echo "[test]   expected 5 'insertvalue {i8*, i64} undef, i8*' lines, got ${data_inserts:-0}"
        return 1
    fi
    return 0
}

# A3 — Literal byte length is encoded as `i64 5, 1` (both `"hello"` and
# `"world"` are 5 bytes; the fixture uses each twice).
test_literal_length_is_correct() {
    emit_ir_once || return 1
    local len_inserts
    len_inserts="$(grep -cE '= insertvalue \{i8\*, i64\} %[A-Za-z_0-9]+, i64 5, 1' "$LL" || true)"
    if [ "${len_inserts:-0}" -ne 4 ]; then
        echo "[test]   expected 4 length-slot inserts with 'i64 5, 1', got ${len_inserts:-0}"
        return 1
    fi
    return 0
}

# A4 — `s.length` resolves to direct `extractvalue` (no runtime call).
test_length_is_direct_extractvalue() {
    emit_ir_once || return 1
    local extracts
    extracts="$(grep -cE '= extractvalue \{i8\*, i64\} %[A-Za-z_0-9]+, 1' "$LL" || true)"
    if [ "${extracts:-0}" -lt 1 ]; then
        echo "[test]   expected at least one 'extractvalue {i8*, i64} ..., 1' line, got ${extracts:-0}"
        return 1
    fi
    local string_length_calls
    string_length_calls="$(grep -cE 'call .* @sailfin_runtime_string_length\(' "$LL" || true)"
    if [ "${string_length_calls:-0}" -ne 0 ]; then
        echo "[test]   regression: literal-only fixture should not call @sailfin_runtime_string_length"
        return 1
    fi
    return 0
}

# A5 — No consumer treats the literal as `[N x i8]*` after the aggregate flip.
# The literal lowering still does an internal `bitcast i8* %buf to [N x i8]*`
# for the byte-array store; that bitcast is scaffolding inside the literal,
# not a consumer pattern. The negative assertion targets `extractvalue` /
# `getelementptr` on `[N x i8]` types — which would only appear if a
# consumer reverted to treating the literal's *result* as an array pointer.
test_no_array_consumer_pattern() {
    emit_ir_once || return 1
    local array_extracts
    array_extracts="$(grep -cE 'extractvalue \[[0-9]+ x i8\]' "$LL" || true)"
    if [ "${array_extracts:-0}" -ne 0 ]; then
        echo "[test]   regression: found extractvalue on [N x i8] aggregate"
        return 1
    fi
    return 0
}

# A6 — `string.concat` declared with the arena-aware SfnString ABI
# and called the same way. M2.4b (#398) introduced the call shape
#   call {i8*, i64} @sfn_str_concat_arena({i8*, i64}, {i8*, i64}, ptr @sfn_default_arena)
# followed by an `extractvalue {i8*, i64} %t, 0` that recovers the
# legacy `i8*` operand for the rest of the lowering pipeline. #715
# retired the legacy 2-arg `sfn_str_concat` trampoline and promoted
# the arena-aware function to the bare canonical name, so the
# emitted shape is now
#   call {i8*, i64} @sfn_str_concat({i8*, i64}, {i8*, i64}, ptr @sfn_default_arena)
# Fresh emission must reach the bare `@sfn_str_concat` symbol — not
# the `_arena`-suffixed transitional forwarder, not the (now-deleted)
# 2-arg shape, and not the legacy `sailfin_runtime_string_concat_v2`
# entrypoint.
test_string_concat_uses_aggregate_abi() {
    emit_ir_once || return 1
    local declared
    declared="$(grep -cE '^declare \{i8\*, i64\} @sfn_str_concat\(\{i8\*, i64\}, \{i8\*, i64\}, ptr\)' "$LL" || true)"
    if [ "${declared:-0}" -ne 1 ]; then
        echo "[test]   expected exactly one arena-shape declare for sfn_str_concat, got ${declared:-0}"
        return 1
    fi
    local called
    called="$(grep -cE 'call \{i8\*, i64\} @sfn_str_concat\(\{i8\*, i64\} [^,]+, \{i8\*, i64\} [^,]+, ptr @sfn_default_arena\)' "$LL" || true)"
    if [ "${called:-0}" -lt 1 ]; then
        echo "[test]   expected at least one arena-shape call to sfn_str_concat, got ${called:-0}"
        return 1
    fi
    # The result extract that gives downstream `i8*` consumers the data ptr.
    local extracted
    extracted="$(grep -cE '= extractvalue \{i8\*, i64\} %[A-Za-z_][A-Za-z0-9_]*, 0' "$LL" || true)"
    if [ "${extracted:-0}" -lt 1 ]; then
        echo "[test]   expected at least one extractvalue following the arena call, got ${extracted:-0}"
        return 1
    fi
    local legacy_2arg_called
    legacy_2arg_called="$(grep -cE 'call i8\* @sfn_str_concat\(' "$LL" || true)"
    if [ "${legacy_2arg_called:-0}" -ne 0 ]; then
        echo "[test]   regression: fresh emission still calls the 2-arg @sfn_str_concat shape"
        return 1
    fi
    local legacy_arena_called
    legacy_arena_called="$(grep -cE '@sfn_str_concat_arena\b' "$LL" || true)"
    if [ "${legacy_arena_called:-0}" -ne 0 ]; then
        echo "[test]   regression: fresh emission still references @sfn_str_concat_arena (post-#715 transitional name)"
        return 1
    fi
    local legacy_v2_called
    legacy_v2_called="$(grep -cE 'call i8\* @sailfin_runtime_string_concat_v2\(' "$LL" || true)"
    if [ "${legacy_v2_called:-0}" -ne 0 ]; then
        echo "[test]   regression: fresh emission still calls sailfin_runtime_string_concat_v2 directly"
        return 1
    fi
    return 0
}

run_test "literal lowers to {i8*, i64} aggregate" \
    test_aggregate_type_appears
run_test "literal builds aggregate via two insertvalue ops" \
    test_literal_uses_insertvalue
run_test "literal byte-length is i64 N, not N+1" \
    test_literal_length_is_correct
run_test "s.length is a direct extractvalue, no string_length call" \
    test_length_is_direct_extractvalue
run_test "no consumer extracts the literal as [N x i8]" \
    test_no_array_consumer_pattern
run_test "string.concat uses {i8*, i64} aggregate ABI" \
    test_string_concat_uses_aggregate_abi

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
