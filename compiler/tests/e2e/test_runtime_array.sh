#!/usr/bin/env bash
# End-to-end test for runtime/sfn/array.sfn — the unified Sailfin-native
# array primitive shipped under M2.6 (issue #399, epic #389).
#
# The Sailfin module exports `sfn_array_sfn_*` trampolines for proof-of-
# life. The bare canonical `sfn_array_*` symbols user emission calls
# come from C trampolines in `runtime/native/src/sailfin_runtime.c` —
# same coexistence pattern as the M2.4a string module
# (`runtime/sfn/string.sfn`'s `sfn_str_sfn_*` shadowing
# `sfn_str_*`). Both flavours forward to the M1.B `_v2` C entrypoints
# until M3 lands the arena-backed bodies.
#
# Mirrors test_runtime_memory_arena.sh / test_runtime_string_basic.sh:
#
#   1. typecheck — `sfn check runtime/sfn/array.sfn` reports `ok`.
#   2. fmt       — `sfn fmt --check runtime/sfn/array.sfn` is canonical.
#   3. emit shape — emitted IR contains a `define` for each of the nine
#                   `sfn_array_sfn_*` exports plus `declare`s for the
#                   legacy `_v2` entrypoints the trampoline bodies
#                   forward to.
#   4. coexistence — the Sailfin-emitted symbols use the
#                   `sfn_array_sfn_*` namespace so the C runtime's bare
#                   `sfn_array_*` trampolines survive side-by-side at
#                   link time. Any future patch that flips a Sailfin
#                   export to a bare `sfn_array_*` name (which would
#                   collide with the C trampoline) trips this assertion.
#   5. user-emission flip — emission of `examples/basics/hello-world.sfn`
#                   contains zero references to
#                   `sailfin_runtime_(concat|append_string|array_push)`,
#                   matching the issue's verification command (#399).
#   6. determinism — twenty back-to-back `emit llvm` runs on a heavy
#                   compiler module produce byte-identical IR (exercises
#                   the issue's "20× emit-sweep" criterion).
#
# When M3 retires the C trampolines and the spec-aligned arena-backed
# bodies in `runtime/sfn/array.sfn` light up, the coexistence check
# in step 4 retires (replaced by the spec's main-API assertion).

set -euo pipefail

BINARY="${1:?usage: test_runtime_array.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
SKELETON="$REPO_ROOT/runtime/sfn/array.sfn"
HELLO="$REPO_ROOT/examples/basics/hello-world.sfn"
HEAVY="$REPO_ROOT/compiler/src/parser/expressions.sfn"

SCRATCH="$(mktemp -d -t sfn-runtime-array-XXXXXX)"
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

test_check_clean() {
    local log="$SCRATCH/check.log"
    if ! "$BINARY" check "$SKELETON" > "$log" 2>&1; then
        echo "[test]   sfn check exited non-zero on array.sfn:"
        cat "$log"
        return 1
    fi
    if ! grep -q "checked .* ok" "$log"; then
        echo "[test]   sfn check did not report 'ok':"
        cat "$log"
        return 1
    fi
    return 0
}

test_fmt_clean() {
    if ! "$BINARY" fmt --check "$SKELETON" > /dev/null 2>&1; then
        echo "[test]   $SKELETON needs formatting (run: sfn fmt --write $SKELETON)"
        return 1
    fi
    return 0
}

test_emit_define_shape() {
    local ll="$SCRATCH/array.ll"
    local log="$SCRATCH/emit.log"
    if ! "$BINARY" emit -o "$ll" llvm "$SKELETON" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on runtime/sfn/array.sfn:"
        cat "$log"
        return 1
    fi

    local missing=0
    # Spec API per `docs/runtime_architecture.md` §2.3 — four exports
    # with the spec-aligned `(elem_size, *Arena)` signatures. Bodies
    # are stubs today, but the symbol shape is the migration unit so
    # we pin it here. Names carry the `_sfn_` infix mirroring the
    # arena/string proof-of-life modules; the bare `sfn_array_*` names
    # come from C trampolines in `runtime/native/src/sailfin_runtime.c`.
    if ! grep -qE '^define i8\* @sfn_array_sfn_create\(i64 ' "$ll"; then
        echo "[test]   missing 'define i8* @sfn_array_sfn_create(i64 ...)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE '^define void @sfn_array_sfn_push\(i8\* ' "$ll"; then
        echo "[test]   missing 'define void @sfn_array_sfn_push(i8* ...)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE '^define i8\* @sfn_array_sfn_concat\(i8\* ' "$ll"; then
        echo "[test]   missing 'define i8* @sfn_array_sfn_concat(i8* ...)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE '^define i8\* @sfn_array_sfn_slice\(i8\* ' "$ll"; then
        echo "[test]   missing 'define i8* @sfn_array_sfn_slice(i8* ...)'"
        missing=$((missing + 1))
    fi
    # Compiler-emission helpers — proof-of-life Sailfin twins for the
    # C trampolines `sfn_array_push_string` (i8*-element fast path)
    # and `sfn_array_push_slot` (typed-element slot helper) that
    # `compiler/src/llvm/expression_lowering/arrays.sfn` calls.
    if ! grep -qE '^define i8\* @sfn_array_sfn_push_string\(i8\* ' "$ll"; then
        echo "[test]   missing 'define i8* @sfn_array_sfn_push_string(i8* ...)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE '^define i8\* @sfn_array_sfn_push_slot\(' "$ll"; then
        echo "[test]   missing 'define i8* @sfn_array_sfn_push_slot(...)'"
        missing=$((missing + 1))
    fi
    # Closure-gated stubs (§2.3.3): map/filter/reduce land as
    # placeholder bodies until closures-with-capture (roadmap §0
    # item 5) lights up real implementations.
    if ! grep -qE '^define i8\* @sfn_array_sfn_map\(i8\* ' "$ll"; then
        echo "[test]   missing 'define i8* @sfn_array_sfn_map(i8* ...)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE '^define i8\* @sfn_array_sfn_filter\(i8\* ' "$ll"; then
        echo "[test]   missing 'define i8* @sfn_array_sfn_filter(i8* ...)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE '^define i8\* @sfn_array_sfn_reduce\(i8\* ' "$ll"; then
        echo "[test]   missing 'define i8* @sfn_array_sfn_reduce(i8* ...)'"
        missing=$((missing + 1))
    fi
    return "$missing"
}

test_no_bare_sfn_array_define() {
    local ll="$SCRATCH/array.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi
    # Coexistence regression: the Sailfin module must NOT emit a bare
    # `define ... @sfn_array_create(` etc. — those names belong to the
    # C trampolines in `runtime/native/src/sailfin_runtime.c` and a
    # collision would fail the runtime build at link time. The
    # `sfn_array_sfn_*` infix is the marker for Sailfin-emitted
    # symbols. When M3 retires the C trampolines, this assertion goes
    # away (the architect plan in #389 calls this out alongside the
    # arena module's matching coexistence retirement).
    local found=0
    for sym in sfn_array_create sfn_array_push sfn_array_concat sfn_array_slice sfn_array_push_string sfn_array_push_slot sfn_array_map sfn_array_filter sfn_array_reduce; do
        if grep -qE "^define .* @${sym}\(" "$ll"; then
            echo "[test]   collision risk: array.sfn emits 'define ... @${sym}(', conflicts with C trampoline"
            found=$((found + 1))
        fi
    done
    return "$found"
}

test_emit_legacy_declares() {
    local ll="$SCRATCH/array.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi
    # The trampoline bodies forward to the legacy `_v2` C entrypoints,
    # so the inlined externs must each produce a `declare` line. Once
    # M3 ships real arena-backed bodies these declares retire alongside
    # the C entrypoints they wrap.
    local missing=0
    for sym in sailfin_runtime_concat_v2 sailfin_runtime_append_string_v2 sailfin_runtime_array_push_slot_v2; do
        if ! grep -qE "^declare .* @${sym}\(" "$ll"; then
            echo "[test]   missing 'declare ... @${sym}(' in array.ll"
            missing=$((missing + 1))
        fi
    done
    return "$missing"
}

test_user_emission_flip() {
    # Acceptance criterion (issue #399): user emission must contain
    # zero references to `sailfin_runtime_(concat|append_string|
    # array_push)`. The verification command in the issue body uses
    # `examples/basics/hello-world.sfn` against the freshly-built
    # compiler — exact replica below.
    local ll="$SCRATCH/hello.ll"
    local log="$SCRATCH/hello-emit.log"
    if ! "$BINARY" emit -o "$ll" llvm "$HELLO" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on $HELLO:"
        cat "$log"
        return 1
    fi
    local hits
    hits="$(grep -cE 'sailfin_runtime_(concat|append_string|array_push)' "$ll" || true)"
    if [ "$hits" -ne 0 ]; then
        echo "[test]   user emission still references legacy array helpers:"
        grep -E 'sailfin_runtime_(concat|append_string|array_push)' "$ll" | head -5
        return 1
    fi
    # Same check on a heavier module that actually emits push_slot
    # call sites (parser/expressions.sfn). Hello-world has only the
    # vestigial declares from `seed_default_runtime_helpers`; the
    # heavy module exercises the full `lower_array_push_in_place`
    # path that this PR flipped to `@sfn_array_push_slot`.
    local heavy_ll="$SCRATCH/heavy.ll"
    local heavy_log="$SCRATCH/heavy-emit.log"
    if ! "$BINARY" emit -o "$heavy_ll" llvm "$HEAVY" > "$heavy_log" 2>&1; then
        echo "[test]   sfn emit llvm failed on $HEAVY:"
        cat "$heavy_log"
        return 1
    fi
    local heavy_hits
    heavy_hits="$(grep -cE 'sailfin_runtime_(concat|append_string|array_push)' "$heavy_ll" || true)"
    if [ "$heavy_hits" -ne 0 ]; then
        echo "[test]   heavy-module emission still references legacy array helpers:"
        grep -E 'sailfin_runtime_(concat|append_string|array_push)' "$heavy_ll" | head -5
        return 1
    fi
    # Conversely, the new canonical names must show up — otherwise the
    # flip silently dropped the calls instead of routing them.
    if ! grep -qE '@sfn_array_push_slot\(' "$heavy_ll"; then
        echo "[test]   heavy-module emission did not produce '@sfn_array_push_slot(' calls"
        return 1
    fi
    return 0
}

test_emit_determinism() {
    # Twenty back-to-back `emit llvm` runs on a heavy module must
    # produce byte-identical IR. This catches non-deterministic
    # ordering in the runtime helper declaration pass — a regression
    # mode the M2.6 flip could re-introduce if `native_signature` set
    # changes how `helper_descriptors` is iterated.
    local sweep_ll="$SCRATCH/sweep.ll"
    if ! "$BINARY" emit -o "$sweep_ll" llvm "$HEAVY" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed on $HEAVY (sweep baseline)"
        return 1
    fi
    local i=0
    while [ "$i" -lt 19 ]; do
        local next_ll="$SCRATCH/sweep_${i}.ll"
        if ! "$BINARY" emit -o "$next_ll" llvm "$HEAVY" > /dev/null 2>&1; then
            echo "[test]   sfn emit llvm failed on iteration $i"
            return 1
        fi
        if ! cmp -s "$sweep_ll" "$next_ll"; then
            echo "[test]   non-deterministic IR: iteration $i differs from baseline"
            diff "$sweep_ll" "$next_ll" | head -20
            return 1
        fi
        i=$((i + 1))
    done
    return 0
}

run_test "sfn check runtime/sfn/array.sfn passes" test_check_clean
run_test "sfn fmt --check runtime/sfn/array.sfn is canonical" test_fmt_clean
run_test "sfn emit llvm produces define for every sfn_array_sfn_* export" test_emit_define_shape
run_test "sfn emit llvm declares legacy _v2 trampolines" test_emit_legacy_declares
run_test "sfn emit llvm does not collide with C trampoline sfn_array_* exports" test_no_bare_sfn_array_define
run_test "user emission contains zero sailfin_runtime_(concat|append_string|array_push) references" test_user_emission_flip
run_test "20x emit-sweep on heavy module is byte-identical" test_emit_determinism

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
