#!/usr/bin/env bash
# End-to-end test for issue #713 — pointer-typed struct fields survive
# into the struct's LLVM layout AND round-trip at runtime.
#
# Before the fix, `emit_native_layout.sfn` serialized a field's type into a
# single whitespace-delimited token (`.layout field <name> type=<T> ...`),
# but pointer annotations carry an internal space (`* u8`). The native-IR
# re-parser split that line on whitespace, the pointee became an
# unrecognized token, the field's parse failed, and the field was dropped
# from the struct's LLVM type. The downstream symptom was that field
# assignments to pointer fields emitted no `store`.
#
# This test pins two contracts on the same fixture:
#   1. IR shape (`emit llvm`): the self-referential `* Node` and raw
#      `* u8` fields are present in `%Node`, and the assignment to the
#      raw pointer field GEPs to its slot and emits a real `store i8*`.
#   2. Runtime round-trip (`run`): writing then reading the pointer/int
#      fields executes to exit 0. A pre-fix compiler would drop the
#      fields and the read-backs would diverge (exit 1/2/3).
#
# Usage:
#   compiler/tests/e2e/test_struct_field_pointer_roundtrip.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_struct_field_pointer_roundtrip.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FIXTURE="$SCRIPT_DIR/fixtures/struct_field_pointer_roundtrip.sfn"

PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-ptr-roundtrip-XXXXXX)"
trap 'rm -rf "$SCRATCH"' EXIT

LL="$SCRATCH/struct_field_pointer_roundtrip.ll"

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
        echo "[test]   sfn emit llvm failed for struct_field_pointer_roundtrip.sfn"
        sed 's/^/[test]     /' "$SCRATCH/emit.stderr" | head -20
        return 1
    fi
    return 0
}

# 1 — `%Node` keeps both pointer fields (self-ref `%Node*` + raw `i8*`)
# alongside the `i64`. Pre-fix this collapsed to `%Node = type { i64 }`.
# Accept opaque-pointer `ptr` equivalents for forward-compat.
test_node_layout_has_pointer_fields() {
    emit_ir_once || return 1
    if grep -qE '^%Node = type \{ (%Node\*|ptr), i64, (i8\*|ptr) \}' "$LL"; then
        return 0
    fi
    echo "[test]   expected %Node = type { %Node*, i64, i8* }, got:"
    grep -E '^%Node = type' "$LL" | sed 's/^/[test]     /'
    return 1
}

# 2 — Assigning the raw `* u8` field GEPs to slot 2 and emits a real
# `store i8*` (or `store ptr`). Pre-fix the store was silently dropped.
test_raw_pointer_field_emits_store() {
    emit_ir_once || return 1
    # Tie the store to the specific slot-2 GEP result rather than matching
    # any `store i8*` in the module: capture each `... i32 0, i32 2` GEP's
    # result register, then require a `store` whose destination pointer is
    # one of those registers. The GEP's pointer operand may be `%Node*`
    # (typed pointers) or `ptr` (opaque pointers) — the middle of the line
    # is left unconstrained so both forms match.
    if awk '
        /^[[:space:]]*%[A-Za-z_0-9.]+ = getelementptr %Node, .*i32 0, i32 2$/ {
            slot2[$1] = 1
            next
        }
        /^[[:space:]]*store (i8\*|ptr) / {
            if ($NF in slot2) { found = 1 }
        }
        END { exit found ? 0 : 1 }
    ' "$LL"; then
        return 0
    fi
    echo "[test]   expected a store (i8*/ptr) into the slot-2 GEP result for the raw pointer field"
    grep -nE 'getelementptr %Node, .*i32 0, i32 2$|store (i8\*|ptr) ' "$LL" | sed 's/^/[test]     /' | head -10
    return 1
}

# 3 — Runtime round-trip: write then read the pointer/int fields. Exit 0
# means every field survived the store/load; non-zero pinpoints which
# read-back diverged (1=self-ref *Node, 2=int, 3=raw *u8).
test_runtime_roundtrip_exits_zero() {
    local rc=0
    "$BINARY" run "$FIXTURE" > "$SCRATCH/run.stdout" 2> "$SCRATCH/run.stderr" || rc=$?
    if [ "$rc" -eq 0 ]; then
        return 0
    fi
    echo "[test]   round-trip program exited with $rc (expected 0)"
    echo "[test]     1=self-ref *Node, 2=i64 field, 3=raw *u8 field"
    tail -10 "$SCRATCH/run.stderr" | sed 's/^/[test]     /'
    return 1
}

run_test 'Node layout keeps self-ref %Node* and raw i8* pointer fields' \
    test_node_layout_has_pointer_fields
run_test 'raw *u8 field assignment emits a real store i8*' \
    test_raw_pointer_field_emits_store
run_test 'pointer/int field round-trip runs to exit 0' \
    test_runtime_roundtrip_exits_zero

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
