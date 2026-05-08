#!/usr/bin/env bash
# End-to-end test for the M1.A string-literal ABI lock (issue #391)
# and the M1.2 `sfn_str_concat` registry flip (issue #461).
#
# Pins the emitted LLVM IR contract for string literals:
#   - Literals lower to `{i8*, i64}` aggregates (data ptr + byte length).
#   - `s.length` resolves to a direct `extractvalue ..., 1` (no
#     `sailfin_runtime_string_length` call).
#   - `+` on strings emits
#     `call i8* @sfn_str_concat({i8*, i64} ..., {i8*, i64} ...)`.
#     The `sfn_str_concat` C trampoline forwards to
#     `sailfin_runtime_string_concat_v2` (kept link-stable for seed-
#     compiled IR until the floor seed bumps); the legacy
#     `sailfin_runtime_string_concat(char*, char*)` entrypoint stays
#     exported so seed-compiled IR with the legacy ABI links too.
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

# A2 — Each literal builds the aggregate via two `insertvalue` ops.
# The fixture writes "hello".length, "world".length, "hello" + "world", and
# `print.info(combined)` — four string literals total (.length on a literal
# still constructs the aggregate, then extracts slot 1).
test_literal_uses_insertvalue() {
    emit_ir_once || return 1
    local data_inserts
    data_inserts="$(grep -cE '= insertvalue \{i8\*, i64\} undef, i8\*' "$LL" || true)"
    if [ "${data_inserts:-0}" -ne 4 ]; then
        echo "[test]   expected 4 'insertvalue {i8*, i64} undef, i8*' lines, got ${data_inserts:-0}"
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

# A6 — `string.concat` declared with aggregate parameter shape and called
# the same way. The new compiler routes through `sfn_str_concat` (the
# canonical Sailfin-native name from the M1.2 registry flip, #461),
# whose C trampoline forwards to `sailfin_runtime_string_concat_v2`
# (SfnString-by-value). The legacy `sailfin_runtime_string_concat_v2`
# symbol stays exported so seed-compiled IR keeps linking until the
# floor seed bumps and both retire together.
test_string_concat_uses_aggregate_abi() {
    emit_ir_once || return 1
    local declared
    declared="$(grep -cE '^declare i8\* @sfn_str_concat\(\{i8\*, i64\}, \{i8\*, i64\}\)' "$LL" || true)"
    if [ "${declared:-0}" -ne 1 ]; then
        echo "[test]   expected exactly one aggregate-shape declare for sfn_str_concat, got ${declared:-0}"
        return 1
    fi
    local called
    called="$(grep -cE 'call i8\* @sfn_str_concat\(\{i8\*, i64\} ' "$LL" || true)"
    if [ "${called:-0}" -lt 1 ]; then
        echo "[test]   expected at least one aggregate-shape call to sfn_str_concat, got ${called:-0}"
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
