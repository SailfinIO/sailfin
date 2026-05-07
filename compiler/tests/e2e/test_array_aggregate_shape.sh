#!/usr/bin/env bash
# End-to-end test for the M1.B array-literal ABI lock (issue #393).
#
# Pins the emitted LLVM IR contract for array literals and the runtime
# helper signatures that consume them:
#   - `let xs = [1, 2, 3]` materializes a `{ T*, i64, i64 }*` aggregate
#     (data, len, cap). Pointer arrays (`string[]`) widen the data slot
#     to `T**`; value arrays use `T*` directly. Both shapes carry the
#     extra cap field at offset 2.
#   - The literal lowering writes all three slots: a `getelementptr
#     ..., i32 0, i32 0` for data, `..., i32 0, i32 1` for len, and a
#     fresh `..., i32 0, i32 2` for cap. Cap is initialized to len so
#     callers that grow the buffer via the v2 push helpers see the
#     correct starting capacity.
#   - `xs.length` resolves to slot 1 of the array struct.
#   - The runtime registry routes `concat` / `append_string` /
#     `array_push_slot` / `process.run` / `fs.writeLines` /
#     `fs.listDirectory` to their `_v2` C entrypoints. Legacy
#     `sailfin_runtime_concat` / `sailfin_runtime_append_string` /
#     `sailfin_runtime_array_push_slot` symbols stay link-stable for
#     seed-compiled IR until the floor seed catches up.
#
# Usage:
#   compiler/tests/e2e/test_array_aggregate_shape.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_array_aggregate_shape.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FIXTURE="$SCRIPT_DIR/fixtures/array_aggregate_shape.sfn"

PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-array-shape-XXXXXX)"
trap 'rm -rf "$SCRATCH"' EXIT

LL="$SCRATCH/array_aggregate_shape.ll"

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
        echo "[test]   sfn emit llvm failed for array_aggregate_shape.sfn"
        sed 's/^/[test]     /' "$SCRATCH/emit.stderr" | head -20
        return 1
    fi
    return 0
}

# B1 — Three-field aggregate type appears in the emitted IR.
test_three_field_aggregate_appears() {
    emit_ir_once || return 1
    local hits
    hits="$(grep -cE '\{ [^}]*\*, i64, i64 \}' "$LL" || true)"
    if [ "${hits:-0}" -lt 4 ]; then
        echo "[test]   expected at least 4 references to { T*, i64, i64 }, got ${hits:-0}"
        return 1
    fi
    return 0
}

# B2 — `let xs = [1, 2, 3]` lowers to a `{ double*, i64, i64 }*` (numeric
# literals lower to double under the bootstrap number ABI).
test_numeric_literal_uses_value_typed_data_slot() {
    emit_ir_once || return 1
    local hits
    hits="$(grep -cE '\{ double\*, i64, i64 \}' "$LL" || true)"
    if [ "${hits:-0}" -lt 1 ]; then
        echo "[test]   expected the numeric array literal to surface as { double*, i64, i64 }"
        return 1
    fi
    return 0
}

# B3 — String-array literal `["one", "two"]` lowers to `{ i8**, i64, i64 }*`
# (pointer-typed data slot).
test_string_array_uses_pointer_typed_data_slot() {
    emit_ir_once || return 1
    local hits
    hits="$(grep -cE '\{ i8\*\*, i64, i64 \}' "$LL" || true)"
    if [ "${hits:-0}" -lt 1 ]; then
        echo "[test]   expected the string array literal to surface as { i8**, i64, i64 }"
        return 1
    fi
    return 0
}

# B4 — Cap slot (i32 0, i32 2) is written by the literal lowering.
# Without the M1.B flip the literal would only GEP slots 0 and 1; the
# presence of slot 2 access pins that cap is being initialized.
test_literal_writes_cap_slot() {
    emit_ir_once || return 1
    local cap_geps
    cap_geps="$(grep -cE '= getelementptr \{ [^}]*\*, i64, i64 \}, \{ [^}]*\*, i64, i64 \}\* %[A-Za-z_0-9]+, i32 0, i32 2' "$LL" || true)"
    if [ "${cap_geps:-0}" -lt 1 ]; then
        echo "[test]   expected at least one GEP to slot 2 (cap) on the new shape, got ${cap_geps:-0}"
        return 1
    fi
    return 0
}

# B5 — The cap value stored for a 3-element literal is `i64 3` (matches
# the literal length so post-literal grow goes through the v2 push
# helpers' realloc branch).
test_literal_cap_value_matches_length() {
    emit_ir_once || return 1
    # Find any `i32 0, i32 2` GEP and check the next-line store wrote
    # `i64 3`. Use awk to walk paired lines so we don't false-positive
    # on unrelated `i64 3` constants elsewhere.
    if ! awk '
        /= getelementptr \{ [^}]*\*, i64, i64 \},.*, i32 0, i32 2$/ {
            getline next_line
            if (next_line ~ /^[[:space:]]+store i64 3, i64\* /) {
                found = 1
            }
        }
        END { exit found ? 0 : 1 }
    ' "$LL"; then
        echo "[test]   expected at least one cap-slot store with i64 3 immediately after a slot-2 GEP"
        return 1
    fi
    return 0
}

# B6 — `xs.length` resolves to slot 1 of the array struct. Either GEP+load
# or whole-struct load + extractvalue is acceptable; both surface the
# value without a runtime call.
test_length_reads_slot_one() {
    emit_ir_once || return 1
    local gep_load
    gep_load="$(grep -cE '= getelementptr \{ [^}]*\*, i64, i64 \},.*, i32 0, i32 1' "$LL" || true)"
    local extract_one
    extract_one="$(grep -cE '= extractvalue \{ [^}]*\*, i64, i64 \} %[A-Za-z_0-9]+, 1' "$LL" || true)"
    local total=$((gep_load + extract_one))
    if [ "${total:-0}" -lt 1 ]; then
        echo "[test]   expected at least one slot-1 access (GEP or extractvalue) on the new shape"
        return 1
    fi
    return 0
}

# B7 — Runtime helpers route through their `_v2` symbols with the new
# 3-field signature. Legacy `sailfin_runtime_concat(i8**, i64)` /
# `_append_string(i8**, i64)` / `_array_push_slot(i8**, i64*, i64)`
# decls must not appear in new compiler output. (The C runtime keeps
# them exported for seed-compiled IR; this test only inspects the IR
# emitted by the *new* compiler.)
test_v2_runtime_helpers_in_registry() {
    emit_ir_once || return 1
    local concat_v2
    concat_v2="$(grep -cE '^declare \{ i8\*\*, i64, i64 \}\* @sailfin_runtime_concat_v2' "$LL" || true)"
    local append_v2
    append_v2="$(grep -cE '^declare \{ i8\*\*, i64, i64 \}\* @sailfin_runtime_append_string_v2' "$LL" || true)"
    if [ "${concat_v2:-0}" -lt 1 ] || [ "${append_v2:-0}" -lt 1 ]; then
        echo "[test]   expected v2 declares for concat and append_string"
        echo "[test]     concat_v2=${concat_v2}, append_v2=${append_v2}"
        return 1
    fi
    local legacy_concat
    legacy_concat="$(grep -cE '^declare \{ i8\*\*, i64 \}\* @sailfin_runtime_concat\(' "$LL" || true)"
    if [ "${legacy_concat:-0}" -ne 0 ]; then
        echo "[test]   regression: legacy 2-field concat declare emitted"
        return 1
    fi
    return 0
}

# B8 — `array_push_slot_v2` declare carries the cap pointer parameter
# (the legacy 3-arg form gains an `i64*` for cap).
test_array_push_slot_v2_signature() {
    emit_ir_once || return 1
    local hits
    hits="$(grep -cE '^declare i8\* @sailfin_runtime_array_push_slot_v2\(i8\*\*, i64\*, i64\*, i64\)' "$LL" || true)"
    if [ "${hits:-0}" -lt 1 ]; then
        echo "[test]   expected array_push_slot_v2 declare with (i8**, i64*, i64*, i64) signature"
        return 1
    fi
    return 0
}

# B9 — No legacy 2-field array shape leaks into the new IR. The seed-
# compiled first-pass binary still emits the legacy shape internally,
# but a fresh emit from the new compiler must be uniform.
test_no_legacy_two_field_array_shape() {
    emit_ir_once || return 1
    # Match `{ T*, i64 }` only when not followed by `, i64 }` (the cap
    # field). Use grep -P-style assertion (perl-compat) if available;
    # otherwise fall back to a stricter pattern that excludes the new
    # shape via a positive match for the trailing `}`.
    local legacy_count
    legacy_count="$(grep -cE '\{ [^{}]+\*, i64 \}[^*]' "$LL" || true)"
    if [ "${legacy_count:-0}" -gt 0 ]; then
        echo "[test]   regression: legacy 2-field array shape `{ T*, i64 }` survived into new IR (count=${legacy_count})"
        grep -nE '\{ [^{}]+\*, i64 \}[^*]' "$LL" | head -5 | sed 's/^/[test]     /'
        return 1
    fi
    return 0
}

run_test 'emitted IR contains the { T*, i64, i64 } aggregate type' \
    test_three_field_aggregate_appears
run_test 'numeric literal [1, 2, 3] lowers to { double*, i64, i64 }' \
    test_numeric_literal_uses_value_typed_data_slot
run_test 'string literal ["one", "two"] lowers to { i8**, i64, i64 }' \
    test_string_array_uses_pointer_typed_data_slot
run_test 'literal lowering writes the cap slot (i32 0, i32 2)' \
    test_literal_writes_cap_slot
run_test 'cap slot stores i64 3 for a 3-element literal' \
    test_literal_cap_value_matches_length
run_test 'xs.length reads slot 1 of the array struct' \
    test_length_reads_slot_one
run_test 'runtime helpers route through their _v2 symbols' \
    test_v2_runtime_helpers_in_registry
run_test 'array_push_slot_v2 declare carries the cap pointer parameter' \
    test_array_push_slot_v2_signature
run_test 'no legacy { T*, i64 } 2-field array shape leaks into new IR' \
    test_no_legacy_two_field_array_shape

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
