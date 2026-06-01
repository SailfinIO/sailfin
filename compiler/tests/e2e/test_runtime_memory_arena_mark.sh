#!/usr/bin/env bash
# End-to-end test for the arena mark/rewind pair in
# runtime/sfn/memory/arena.sfn — the Sailfin port of the
# double-encoding global-arena wrappers
# `sailfin_intrinsic_runtime_arena_mark` /
# `sailfin_intrinsic_runtime_arena_rewind` (issue #927, sub-issue of
# #390, tracker #821). Companion to test_runtime_memory_arena.sh,
# which covers the five core `sfn_arena_sfn_*` allocator entry points;
# this file pins the mark/rewind pair specifically.
#
#   1. emit shape — emitted IR carries a `define` for
#                   `sfn_arena_sfn_mark` (→ double) and
#                   `sfn_arena_sfn_rewind` (double →) plus a `declare`
#                   for the C `sfn_arena_global` / `sfn_arena_enabled`
#                   the bodies read.
#   2. coexistence — the ported pair uses the module's `sfn_arena_sfn_*`
#                    infix; assert it does NOT emit bare
#                    `sfn_arena_mark` / `sfn_arena_rewind` (those names
#                    belong to the live C arena and would collide at
#                    link until M3 retires the C source).
#   3. encoding roundtrip — link the emitted `.ll` against the real C
#                    arena (`runtime/native/src/sailfin_arena.c`) and a
#                    harness that, with arena mode ON, runs
#                    mark → alloc → rewind and asserts the rewind
#                    reclaims the post-mark bump (a fresh alloc reuses
#                    the rewound offset). Also asserts mark on a
#                    on an enabled arena rewind(0) resets to the page-0
#                    head (a real partial reset, NOT a no-op). The
#                    disabled-arena no-op path (mark→0.0, rewind inert)
#                    is checked first, in a forked child that never
#                    enables the arena.

set -euo pipefail

BINARY="${1:?usage: test_runtime_memory_arena_mark.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
SKELETON="$REPO_ROOT/runtime/sfn/memory/arena.sfn"

SCRATCH="$(mktemp -d -t sfn-runtime-arena-mark-XXXXXX)"
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

test_emit_define_shape() {
    local ll="$SCRATCH/arena.ll"
    local log="$SCRATCH/emit.log"
    if ! "$BINARY" emit -o "$ll" llvm "$SKELETON" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on runtime/sfn/memory/arena.sfn:"
        cat "$log"
        return 1
    fi
    local missing=0
    # mark returns a Sailfin `number` (LLVM `double`); rewind takes one.
    if ! grep -qE "^define double @sfn_arena_sfn_mark\(\) " "$ll"; then
        echo "[test]   missing 'define double @sfn_arena_sfn_mark()'"
        missing=$((missing + 1))
    fi
    if ! grep -qE "^define void @sfn_arena_sfn_rewind\(double %encoded_mark\) " "$ll"; then
        echo "[test]   missing 'define void @sfn_arena_sfn_rewind(double %encoded_mark)'"
        missing=$((missing + 1))
    fi
    return "$missing"
}

test_emit_global_declares() {
    local ll="$SCRATCH/arena.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi
    local missing=0
    for sym in sfn_arena_enabled sfn_arena_global; do
        if ! grep -qE "^declare .* @${sym}\(" "$ll"; then
            echo "[test]   missing 'declare ... @${sym}(' in arena.ll"
            missing=$((missing + 1))
        fi
    done
    return "$missing"
}

test_no_bare_c_arena_collision() {
    local ll="$SCRATCH/arena.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi
    # The ported pair must NOT define the bare C names, which are live
    # exports of the C arena. Anchored at line start so the `declare`
    # of `sfn_arena_global` (a different symbol) cannot trip it, and
    # the `$` after `(` so `sfn_arena_mark` does not match
    # `sfn_arena_sfn_mark`.
    local found=0
    for sym in sfn_arena_mark sfn_arena_rewind; do
        if grep -qE "^define .* @${sym}\(" "$ll"; then
            echo "[test]   collision risk: arena.sfn emits 'define ... @${sym}(', conflicts with C arena"
            found=$((found + 1))
        fi
    done
    return "$found"
}

test_mark_rewind_roundtrip() {
    # Functional roundtrip against the REAL C arena. The Sailfin
    # mark/rewind bodies read the process-global arena via the C
    # `sfn_arena_global()` and walk its page chain by field offset, so
    # the harness links the actual `sailfin_arena.c` (not a stub) and
    # drives it with arena mode forced on.
    local ll="$SCRATCH/arena.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi

    local clang_bin
    clang_bin="${CLANG:-clang}"
    if ! command -v "$clang_bin" >/dev/null 2>&1; then
        echo "[test]   clang not available — skipping roundtrip"
        return 0
    fi

    local arena_c="$REPO_ROOT/runtime/native/src/sailfin_arena.c"
    local arena_inc="$REPO_ROOT/runtime/native/include"
    if [ ! -f "$arena_c" ]; then
        echo "[test]   C arena source missing at $arena_c"
        return 1
    fi

    local harness="$SCRATCH/harness.c"
    cat > "$harness" <<'CHARNESS'
#include <stddef.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>
#include "sailfin_arena.h"

/* The Sailfin mark/rewind bodies call these (declared in arena.ll). */
extern double sfn_arena_sfn_mark(void);
extern void   sfn_arena_sfn_rewind(double encoded_mark);

/* Runtime hooks the seed emits in arena.ll that the harness must
 * satisfy at link but does not exercise: `sailfin_runtime_mark_persistent`
 * (persistent-pointer bookkeeping on heap returns) and `sfn_type_register`
 * (the `@__sfn_module_type_init__` constructor for arena.sfn's named
 * `Arena`/`ArenaPage` structs). No-op stubs. */
void sailfin_runtime_mark_persistent(void *ptr) { (void)ptr; }
void sfn_type_register(void *meta) { (void)meta; }

/* The Sailfin allocator bodies also declared in arena.ll reference
 * `malloc`/`free`/`memcpy`/`realloc` — all satisfied by libc. The
 * arena globals (`sfn_arena_enabled` / `sfn_arena_global`) come from
 * the linked sailfin_arena.c. We force arena mode on by setting the
 * env var before the first `sfn_arena_global()` call. */
int main(void) {
    /* ---- DISABLED arena: mark→0.0, rewind inert (genuine no-op) ----
     * Run first, in a forked child that never enables the arena (the
     * `sfn_arena_global()` singleton is process-wide and persists once
     * created, so this must precede the enabled-arena section below).
     * With arena mode off, mark returns 0.0 and rewind early-returns
     * before decoding; the calls must simply not crash. */
    pid_t dpid = fork();
    if (dpid == 0) {
        unsetenv("SAILFIN_USE_ARENA");
        double dmark = sfn_arena_sfn_mark();
        sfn_arena_sfn_rewind(dmark);
        sfn_arena_sfn_rewind(123.0);
        _exit(dmark == 0.0 ? 0 : 1);
    } else if (dpid > 0) {
        int dstatus = 0;
        waitpid(dpid, &dstatus, 0);
        if (!WIFEXITED(dstatus) || WEXITSTATUS(dstatus) != 0) {
            fprintf(stderr, "disabled-arena mark/rewind no-op check failed (status=%d)\n", dstatus);
            return 9;
        }
    } else {
        fprintf(stderr, "fork failed\n");
        return 10;
    }

    /* ---- arena ON: mark/rewind reclaim post-mark bump ---- */
    setenv("SAILFIN_USE_ARENA", "1", 1);
    if (!sfn_arena_enabled()) {
        fprintf(stderr, "arena did not enable under SAILFIN_USE_ARENA=1\n");
        return 1;
    }
    SfnArena *arena = sfn_arena_global();
    if (!arena) {
        fprintf(stderr, "global arena is NULL\n");
        return 2;
    }

    /* Anchor allocation before the mark — must survive the rewind. */
    void *before = sfn_arena_alloc(arena, 64, 8);
    if (!before) { fprintf(stderr, "pre-mark alloc failed\n"); return 3; }

    double mark = sfn_arena_sfn_mark();

    /* Allocate after the mark; capture the offset it lands at. */
    void *post = sfn_arena_alloc(arena, 128, 8);
    if (!post) { fprintf(stderr, "post-mark alloc failed\n"); return 4; }

    /* Rewind: the post-mark bump must be reclaimed so the next alloc
     * of the same size lands back at `post`. */
    sfn_arena_sfn_rewind(mark);

    void *reused = sfn_arena_alloc(arena, 128, 8);
    if (reused != post) {
        fprintf(stderr, "rewind did not reclaim post-mark bump: post=%p reused=%p\n", post, reused);
        return 5;
    }

    /* The pre-mark allocation must be untouched (still distinct from
     * the reused region). */
    if (before == post) {
        fprintf(stderr, "pre-mark and post-mark allocations overlapped\n");
        return 6;
    }

    /* ---- rewind(0) on an ENABLED arena resets to page-0/used-0 ---- */
    /* Encoded `0` decodes to (page_index=0, used=0): a real partial
     * reset to the chain head, NOT a no-op (the no-op case is the
     * *disabled* arena, exercised separately below). After it, the
     * arena is still valid and the next alloc lands at the head of
     * page 0 — i.e. back at `before` (the first allocation made on
     * this freshly-created arena). */
    sfn_arena_sfn_rewind(0.0);
    void *after_zero = sfn_arena_alloc(arena, 16, 8);
    if (!after_zero) {
        fprintf(stderr, "alloc after rewind(0) failed\n");
        return 7;
    }
    if (after_zero != before) {
        fprintf(stderr, "rewind(0) did not reset to page-0 head: before=%p after_zero=%p\n", before, after_zero);
        return 8;
    }

    return 0;
}
CHARNESS

    local bin="$SCRATCH/roundtrip"
    # Link the emitted Sailfin arena IR + the real C arena. `-lm` for
    # the seed's libm literal-coercion references; `-Wno-override-module`
    # for the emitted target triple.
    if ! "$clang_bin" -Wno-override-module -I"$arena_inc" \
            "$harness" "$ll" "$arena_c" -o "$bin" -lm 2>"$SCRATCH/clang.log"; then
        echo "[test]   clang failed to link arena mark/rewind harness:"
        cat "$SCRATCH/clang.log"
        return 1
    fi
    if ! "$bin"; then
        local rc=$?
        echo "[test]   arena mark/rewind roundtrip exited non-zero (rc=$rc)"
        return 1
    fi
    return 0
}

run_test "sfn emit llvm produces define for sfn_arena_sfn_mark / _rewind" test_emit_define_shape
run_test "sfn emit llvm declares C arena globals (enabled/global)" test_emit_global_declares
run_test "ported pair does not collide with bare C arena mark/rewind" test_no_bare_c_arena_collision
run_test "mark → alloc → rewind reclaims post-mark bump (real C arena)" test_mark_rewind_roundtrip

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
