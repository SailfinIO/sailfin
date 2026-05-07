#!/usr/bin/env bash
# End-to-end test for try/catch init-sentinel guarded drops (M1.5.4,
# issue #328).
#
# What the M1.5.4 PR ships, end-to-end:
#
#   1. Every heap-typed `let` inside a `try` body allocates an `i1`
#      init sentinel at function entry, zeroed in the entry block, and
#      set to `true` immediately after the let's value store. The
#      sentinel slot is named `<binding.pointer>.init`.
#   2. Primitive-typed lets in a `try` body (e.g. `int` -> `i64`) do
#      NOT allocate a sentinel — `is_heap_type` rejects scalars.
#   3. Lets outside any `try` body do NOT allocate a sentinel — the
#      detection is anchored on `scope_id_inside_try_body`, which only
#      matches `try<N>` ancestors created by `allocate_block_label`.
#   4. The catch handler emits a sentinel-gated `call void
#      @sfn_rc_release(i8* %t)` for every rc-eligible local descended
#      from the try scope. Today no path produces an rc-eligible
#      non-consumed try-body local — `lower_return_instruction`
#      promotes via `return ident` and simultaneously marks the local
#      consumed (see `compiler/src/llvm/expression_lowering/native/statement.sfn`,
#      §M1.5.3 + §M1.5.5 comments) so the predicate shared with
#      `emit_scope_drops` correctly skips it. The guarded-drop emission
#      machinery itself is exercised by `compiler/tests/unit/emit_guarded_scope_drops_test.sfn`,
#      which covers the IR shape on synthetic bindings; this script
#      pins the integration: sentinel allocation in the right places,
#      no sentinel in the wrong ones, and no regression in try/catch
#      lowering.
#
# Usage:
#   compiler/tests/e2e/test_drop_emission_try_catch.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_drop_emission_try_catch.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FIXTURE="$SCRIPT_DIR/fixtures/drop_emission_try_catch_basic.sfn"

PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-try-catch-drop-XXXXXX)"
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

# ---- (1) heap-typed try-body let allocates an init sentinel ----
test_heap_let_in_try_allocates_sentinel() {
    local ll="$SCRATCH/try_catch_basic.ll"
    if ! emit_ir "$ll"; then
        echo "[test]   sfn emit llvm failed for drop_emission_try_catch_basic.sfn"
        return 1
    fi
    # Carve out try_with_rc and confirm `<slot>.init = alloca i1` appears
    # exactly once (one heap-typed let inside the try body).
    local rc_block
    rc_block="$(awk '/^define i8\* @try_with_rc/{flag=1} flag{print} /^\}/{if(flag){flag=0}}' "$ll")"
    local sentinel_count
    sentinel_count="$(echo "$rc_block" | grep -cE '%[a-zA-Z0-9_]+\.init = alloca i1' || true)"
    if [ "${sentinel_count:-0}" -ne 1 ]; then
        echo "[test]   try_with_rc expected 1 'alloca i1' sentinel, got $sentinel_count"
        return 1
    fi
    return 0
}

# ---- (2) sentinel is zero-initialized in the entry block ----
test_sentinel_zero_initialized_in_entry() {
    local ll="$SCRATCH/try_catch_zero.ll"
    if ! emit_ir "$ll"; then
        echo "[test]   sfn emit llvm failed (zero-init case)"
        return 1
    fi
    local rc_block
    rc_block="$(awk '/^define i8\* @try_with_rc/{flag=1} flag{print} /^\}/{if(flag){flag=0}}' "$ll")"
    # The zero-init store must precede the `try0:` label (i.e., it lives
    # in `block.entry`, before any control-flow split).
    local entry_block
    entry_block="$(echo "$rc_block" | awk '/block\.entry:/{flag=1; next} /^[a-zA-Z0-9._]+:/{flag=0} flag{print}')"
    if ! echo "$entry_block" | grep -qE 'store i1 0, i1\* %[a-zA-Z0-9_]+\.init'; then
        echo "[test]   missing 'store i1 0' for sentinel in block.entry of try_with_rc"
        echo "[test]   entry block was:"
        echo "$entry_block" | sed 's/^/[test]     /'
        return 1
    fi
    return 0
}

# ---- (3) sentinel is set to true after the let's value store ----
test_sentinel_set_true_after_value_store() {
    local ll="$SCRATCH/try_catch_settrue.ll"
    if ! emit_ir "$ll"; then
        echo "[test]   sfn emit llvm failed (set-true case)"
        return 1
    fi
    local rc_block
    rc_block="$(awk '/^define i8\* @try_with_rc/{flag=1} flag{print} /^\}/{if(flag){flag=0}}' "$ll")"
    if ! echo "$rc_block" | grep -qE 'store i1 1, i1\* %[a-zA-Z0-9_]+\.init'; then
        echo "[test]   missing 'store i1 1' for sentinel in try_with_rc"
        return 1
    fi
    # The set-true must appear inside the try body (after `try0:` label).
    local try_body
    try_body="$(echo "$rc_block" | awk '/try0:/{flag=1; next} /^[a-zA-Z0-9._]+:/{flag=0} flag{print}')"
    if ! echo "$try_body" | grep -qE 'store i1 1, i1\* %[a-zA-Z0-9_]+\.init'; then
        echo "[test]   'store i1 1' must appear inside the try body, not before"
        return 1
    fi
    return 0
}

# ---- (4) primitive-typed try-body let does NOT get a sentinel ----
test_primitive_let_in_try_skips_sentinel() {
    local ll="$SCRATCH/try_catch_int.ll"
    if ! emit_ir "$ll"; then
        echo "[test]   sfn emit llvm failed (primitive case)"
        return 1
    fi
    # Carve out try_no_rc and confirm zero `alloca i1` for sentinel
    # purposes (the function uses i64 throughout, no booleans).
    local int_block
    int_block="$(awk '/^define i64 @try_no_rc/{flag=1} flag{print} /^\}/{if(flag){flag=0}}' "$ll")"
    local sentinel_count
    sentinel_count="$(echo "$int_block" | grep -cE 'alloca i1' || true)"
    if [ "${sentinel_count:-0}" -ne 0 ]; then
        echo "[test]   try_no_rc emitted $sentinel_count i1 alloca(s); expected 0"
        echo "[test]   is_heap_type must reject i64 to avoid spurious sentinels"
        return 1
    fi
    return 0
}

# ---- (5) outer-scope let does NOT get a sentinel ----
test_outer_let_skips_sentinel() {
    local ll="$SCRATCH/try_catch_outer.ll"
    if ! emit_ir "$ll"; then
        echo "[test]   sfn emit llvm failed (outer-scope case)"
        return 1
    fi
    # In `try_with_rc`, `result` is bound at the function root scope
    # (outside the try body). It must NOT get a sentinel.
    local rc_block
    rc_block="$(awk '/^define i8\* @try_with_rc/{flag=1} flag{print} /^\}/{if(flag){flag=0}}' "$ll")"
    # Exactly one sentinel total, for `s` in the try body. If `result`
    # also got one, we'd see two.
    local sentinel_count
    sentinel_count="$(echo "$rc_block" | grep -cE 'alloca i1' || true)"
    if [ "${sentinel_count:-0}" -ne 1 ]; then
        echo "[test]   try_with_rc has $sentinel_count i1 alloca(s); expected 1"
        echo "[test]   only the try-body let should allocate a sentinel"
        return 1
    fi
    return 0
}

# ---- (6) emit_guarded_scope_drops machinery is wired in catch handler ----
test_catch_entry_emission_path_present() {
    # The catch handler in `lower_try_instruction` calls
    # `emit_guarded_scope_drops(try_result.locals, try_scope_id, ...)`
    # unconditionally. When the helper emits no lines (no rc-eligible
    # bindings), the IR is unchanged from M1.5.3. When it emits lines,
    # they appear between the take-exception call and the catch
    # variable's store.
    #
    # Today no fixture produces an rc + non-consumed try-body local
    # (`return ident` promotes-and-consumes; nothing else flips
    # `allocation_kind` to `"rc"`), so the catch block in the fixture
    # contains no guarded drops. The unit test
    # `compiler/tests/unit/emit_guarded_scope_drops_test.sfn` exhausts
    # the IR-shape variants; here we just verify the catch handler
    # itself is still well-formed (one take-exception + one
    # exception-store inside `catch1:`).
    local ll="$SCRATCH/try_catch_machinery.ll"
    if ! emit_ir "$ll"; then
        echo "[test]   sfn emit llvm failed (machinery case)"
        return 1
    fi
    local rc_block
    rc_block="$(awk '/^define i8\* @try_with_rc/{flag=1} flag{print} /^\}/{if(flag){flag=0}}' "$ll")"
    local catch_body
    catch_body="$(echo "$rc_block" | awk '/^catch[0-9]+:/{flag=1; next} /^[a-zA-Z0-9._]+:/{flag=0} flag{print}')"
    if ! echo "$catch_body" | grep -qE 'call i8\* @sailfin_runtime_take_exception'; then
        echo "[test]   catch handler missing take_exception call"
        return 1
    fi
    if ! echo "$catch_body" | grep -qE 'store i8\* %t[0-9]+, i8\*\* %l[0-9]+'; then
        echo "[test]   catch handler missing exception slot store"
        return 1
    fi
    return 0
}

# ---- (7) fixture-wide: the runtime ABI declare line is still emitted ----
test_rc_release_declare_present() {
    local ll="$SCRATCH/try_catch_declare.ll"
    if ! emit_ir "$ll"; then
        echo "[test]   sfn emit llvm failed (declare case)"
        return 1
    fi
    if ! grep -qE '^declare void @sfn_rc_release\(i8\*\)' "$ll"; then
        echo "[test]   missing 'declare void @sfn_rc_release(i8*)' in emitted IR"
        return 1
    fi
    return 0
}

run_test "heap-typed try-body let allocates an init sentinel" \
    test_heap_let_in_try_allocates_sentinel
run_test "sentinel is zero-initialized in the entry block" \
    test_sentinel_zero_initialized_in_entry
run_test "sentinel is set to true after the let's value store" \
    test_sentinel_set_true_after_value_store
run_test "primitive-typed try-body let does not get a sentinel" \
    test_primitive_let_in_try_skips_sentinel
run_test "outer-scope let does not get a sentinel" \
    test_outer_let_skips_sentinel
run_test "catch handler is well-formed with M1.5.4 emission path wired in" \
    test_catch_entry_emission_path_present
run_test "compiler emits declare void @sfn_rc_release(i8*) for the fixture" \
    test_rc_release_declare_present

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
