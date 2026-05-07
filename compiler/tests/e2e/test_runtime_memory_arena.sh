#!/usr/bin/env bash
# End-to-end test for runtime/sfn/memory/arena.sfn — the first
# Sailfin-defined runtime module shipped into the compiler binary
# alongside the C arena (issue #394, epic #389 M2.1+M2.2).
#
# Mirrors test_runtime_io_skeleton.sh / test_runtime_clock_skeleton.sh:
#
#   1. typecheck — `sfn check runtime/sfn/memory/arena.sfn` reports `ok`.
#   2. fmt       — `sfn fmt --check runtime/sfn/memory/arena.sfn` is canonical.
#   3. emit shape — emitted IR contains a `define` for each of the five
#                   `sfn_arena_sfn_*` exports plus `declare`s for the
#                   inlined `malloc` / `free` / `realloc` externs the
#                   stub bodies trampoline through.
#   4. coexistence — the Sailfin-emitted symbols use the `sfn_arena_sfn_*`
#                    namespace so the C arena's `sfn_arena_*` exports
#                    survive side-by-side at link time. Any future patch
#                    that flips a Sailfin export to a bare `sfn_arena_*`
#                    name (which would collide with the C arena) trips
#                    this assertion.
#
# When M3 retires `runtime/native/src/sailfin_arena.c` and replaces the
# Sailfin stub bodies with a real page-chain bump allocator, the emit
# shape assertions stay — only the symbol-coexistence regression check
# in step 4 retires (replaced by the spec's main-API assertion).

set -euo pipefail

BINARY="${1:?usage: test_runtime_memory_arena.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
SKELETON="$REPO_ROOT/runtime/sfn/memory/arena.sfn"

SCRATCH="$(mktemp -d -t sfn-runtime-arena-XXXXXX)"
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
        echo "[test]   sfn check exited non-zero on arena.sfn:"
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
    local ll="$SCRATCH/arena.ll"
    local log="$SCRATCH/emit.log"
    if ! "$BINARY" emit -o "$ll" llvm "$SKELETON" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on runtime/sfn/memory/arena.sfn:"
        cat "$log"
        return 1
    fi

    local missing=0
    # Each `sfn_arena_sfn_*` export must produce exactly one `define`
    # in the emitted module — anchored at line start so a `call`
    # site does not satisfy the assertion. The signatures are pinned
    # so a regression that mangles parameter types (e.g. usize→i32)
    # surfaces here instead of at link time.
    if ! grep -qE "^define i8\* @sfn_arena_sfn_create\(i64 " "$ll"; then
        echo "[test]   missing 'define i8* @sfn_arena_sfn_create(i64 ...)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE "^define i8\* @sfn_arena_sfn_alloc\(i8\* " "$ll"; then
        echo "[test]   missing 'define i8* @sfn_arena_sfn_alloc(i8* ...)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE "^define void @sfn_arena_sfn_reset\(i8\* " "$ll"; then
        echo "[test]   missing 'define void @sfn_arena_sfn_reset(i8* ...)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE "^define void @sfn_arena_sfn_destroy\(i8\* " "$ll"; then
        echo "[test]   missing 'define void @sfn_arena_sfn_destroy(i8* ...)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE "^define i8\* @sfn_arena_sfn_realloc\(i8\* " "$ll"; then
        echo "[test]   missing 'define i8* @sfn_arena_sfn_realloc(i8* ...)'"
        missing=$((missing + 1))
    fi
    return "$missing"
}

test_emit_libc_declares() {
    local ll="$SCRATCH/arena.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi
    # The libc primitives the stubs trampoline through must each
    # produce a `declare` line. Anchored at line start so a `call`
    # site does not satisfy the assertion.
    local missing=0
    for sym in malloc free realloc; do
        if ! grep -qE "^declare .* @${sym}\(" "$ll"; then
            echo "[test]   missing 'declare ... @${sym}(' in arena.ll"
            missing=$((missing + 1))
        fi
    done
    return "$missing"
}

test_no_bare_sfn_arena_define() {
    local ll="$SCRATCH/arena.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi
    # Coexistence regression: the Sailfin module must NOT emit a
    # bare `define ... @sfn_arena_create(` etc. — that name belongs
    # to the C arena (`runtime/native/src/sailfin_arena.c`) and a
    # collision would fail `make compile` at link time. The
    # `sfn_arena_sfn_*` infix is the marker for Sailfin-emitted
    # symbols. When M3 retires the C arena, this assertion goes
    # away (the architect plan in #389 M2.2 calls this out).
    local found=0
    for sym in sfn_arena_create sfn_arena_alloc sfn_arena_reset sfn_arena_destroy sfn_arena_realloc; do
        if grep -qE "^define .* @${sym}\(" "$ll"; then
            echo "[test]   collision risk: arena.sfn emits 'define ... @${sym}(', conflicts with C arena"
            found=$((found + 1))
        fi
    done
    return "$found"
}

run_test "sfn check runtime/sfn/memory/arena.sfn passes" test_check_clean
run_test "sfn fmt --check runtime/sfn/memory/arena.sfn is canonical" test_fmt_clean
run_test "sfn emit llvm produces define for every sfn_arena_sfn_* export" test_emit_define_shape
run_test "sfn emit llvm declares libc malloc/free/realloc trampolines" test_emit_libc_declares
run_test "sfn emit llvm does not collide with C arena's sfn_arena_* exports" test_no_bare_sfn_arena_define

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
