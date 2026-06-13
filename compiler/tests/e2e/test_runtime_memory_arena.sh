#!/usr/bin/env bash
# End-to-end test for runtime/sfn/memory/arena.sfn — the Sailfin-defined
# bump allocator shipped into the compiler binary alongside the C arena
# (issues #394 M2.1 + #477 M2.2, epic #389).
#
# Phases:
#
#   1. typecheck — `sfn check runtime/sfn/memory/arena.sfn` reports `ok`.
#   2. fmt       — `sfn fmt --check runtime/sfn/memory/arena.sfn` is canonical.
#   3. emit shape — emitted IR contains a `define` for each of the five
#                   `sfn_arena_sfn_*` exports plus `declare`s for the
#                   inlined `malloc` / `free` / `realloc` externs the
#                   bodies route through.
#   4. coexistence — the Sailfin-emitted symbols use the `sfn_arena_sfn_*`
#                    namespace so the C arena's `sfn_arena_*` exports
#                    survive side-by-side at link time. Any future patch
#                    that flips a Sailfin export to a bare `sfn_arena_*`
#                    name (which would collide with the C arena) trips
#                    this assertion.
#   5. lifecycle roundtrip — link the emitted `.ll` against a clang
#                            harness that exercises create → alloc →
#                            realloc (grow-in-place + copy-on-overflow)
#                            → page-overflow → reset → re-alloc → destroy
#                            and asserts: alloc returns writable memory,
#                            realloc grow-in-place keeps the same
#                            pointer, copy-on-overflow preserves bytes,
#                            reset reuses pages instead of growing the
#                            chain, destroy frees exactly the count of
#                            backing allocations that matches the page
#                            chain length. Mirrors
#                            `test_runtime_memory_rc.sh`'s functional
#                            cherry on top of the IR-shape assertions.
#
# When M3 retires `runtime/native/src/sailfin_arena.c` and renames the
# Sailfin exports from `sfn_arena_sfn_*` to bare `sfn_arena_*`, the
# coexistence assertion in step 4 retires and the IR-shape and
# lifecycle assertions migrate to the new symbol names in a single
# rollback-safe PR.

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
    # The libc primitives the arena bodies route through must each
    # produce a `declare` line. Anchored at line start so a `call`
    # site does not satisfy the assertion. `memcpy` rides because
    # the realloc copy-on-overflow path uses it; libc `realloc` is
    # deliberately NOT in this set — the arena's `realloc` body
    # falls back to fresh-alloc + memcpy and never calls libc
    # realloc (see the arena.sfn file header for rationale).
    local missing=0
    for sym in malloc free memcpy; do
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
    # Coexistence regression (post-#1309). The arena *core* —
    # `sfn_arena_create` / `sfn_arena_alloc` / `sfn_arena_global` /
    # `sfn_arena_enabled` — is now Sailfin-owned (those C definitions
    # were removed from `sailfin_arena.c`), so arena.sfn MUST emit bare
    # `define`s for them (asserted positively below). The remaining
    # still-C entry points — `sfn_arena_reset` / `sfn_arena_destroy` /
    # `sfn_arena_realloc` (and `print_stats` / `mark` / `rewind`) —
    # keep their C definitions, so arena.sfn must NOT emit bare
    # `define`s for those names or `make compile` fails at link with a
    # duplicate symbol. #822 retires the rest of the C arena and this
    # split collapses.
    local found=0
    for sym in sfn_arena_reset sfn_arena_destroy sfn_arena_realloc; do
        if grep -qE "^define .* @${sym}\(" "$ll"; then
            echo "[test]   collision risk: arena.sfn emits 'define ... @${sym}(', conflicts with C arena"
            found=$((found + 1))
        fi
    done
    return "$found"
}

test_bare_core_defines() {
    # #1309: the four bare arena-core exports must be DEFINED by
    # arena.sfn now that their C namesakes are gone — this is the link
    # ownership the whole refactor turns on. Anchored at line start so
    # a `call` site does not satisfy the assertion.
    local ll="$SCRATCH/arena.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi
    local missing=0
    if ! grep -qE "^define i8\* @sfn_arena_create\(i64 " "$ll"; then
        echo "[test]   missing 'define i8* @sfn_arena_create(i64 ...)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE "^define i8\* @sfn_arena_alloc\(i8\* " "$ll"; then
        echo "[test]   missing 'define i8* @sfn_arena_alloc(i8* ...)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE "^define i8\* @sfn_arena_global\(" "$ll"; then
        echo "[test]   missing 'define i8* @sfn_arena_global()'"
        missing=$((missing + 1))
    fi
    if ! grep -qE "^define i1 @sfn_arena_enabled\(" "$ll"; then
        echo "[test]   missing 'define i1 @sfn_arena_enabled()'"
        missing=$((missing + 1))
    fi
    return "$missing"
}

test_arena_struct_is_40_bytes() {
    # #1309 deciding constraint: the Sailfin `Arena` must be
    # byte-identical to the C `SfnArena` (40 bytes / five i64 slots,
    # `total_allocated@24` / `total_pages@32`) so the still-C
    # `sfn_arena_realloc` / `print_stats` writing those offsets on the
    # shared global handle stay in bounds. A regression that drops the
    # two transition counters (24-byte handle) is a #1205-class heap
    # corruption — caught here as an IR-shape mismatch before it can
    # corrupt the heap.
    local ll="$SCRATCH/arena.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi
    if ! grep -qE "^%Arena = type \{ i64, i64, i64, i64, i64 \}" "$ll"; then
        echo "[test]   Arena is not the 40-byte 5×i64 layout the C SfnArena requires:"
        grep -E "^%Arena = type" "$ll" || echo "   (no %Arena type definition emitted)"
        return 1
    fi
    return 0
}

test_lifecycle_roundtrip() {
    # Functional roundtrip: link the emitted `.ll` against a clang
    # harness that exercises every public entry point and asserts
    # the contract documented in `docs/runtime_architecture.md`
    # §2.1.1. Mirrors `test_runtime_memory_rc.sh`'s
    # `test_roundtrip_frees_once` interposition pattern — the
    # harness intercepts libc `free` via a counter shim so the
    # destroy-frees-every-allocation assertion can verify that
    # reset retains pages (a regression that re-allocates instead
    # of reusing the chain would surface as an inflated free count
    # at destroy time).
    local ll="$SCRATCH/arena.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi

    local harness="$SCRATCH/harness.c"
    cat > "$harness" <<'CHARNESS'
/* Lifecycle harness for runtime/sfn/memory/arena.sfn. Counts libc
 * free() calls via link-time interposition (same pattern as
 * test_runtime_memory_rc.sh): the harness defines its own `free`
 * that bumps a counter, and the linker binds the emitted IR's
 * `declare void @free(i8*)` references to this shim instead of the
 * system free. The shim intentionally leaks (the process exits
 * within milliseconds; the kernel reclaims). `malloc` is NOT
 * interposed — the arena needs real backing memory to write into,
 * and the lifecycle assertions verify behavior end-to-end rather
 * than counting individual mallocs.
 */
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static long free_count = 0;

void free(void *ptr) {
    if (ptr) {
        free_count++;
    }
    /* Intentionally leak — see file header. */
}

extern void *sfn_arena_sfn_create(size_t default_page_size);
extern void *sfn_arena_sfn_alloc(void *arena, size_t size, size_t align);
extern void sfn_arena_sfn_reset(void *arena);
extern void sfn_arena_sfn_destroy(void *arena);
extern void *sfn_arena_sfn_realloc(void *arena, void *ptr, size_t old_size,
                                   size_t new_size, size_t align);

/* Stub the persistent-pointer bookkeeping hook the seed compiler
 * installs on every heap return. The full implementation lives in
 * `runtime/native/src/sailfin_runtime.c`; the lifecycle harness
 * binds only the arena symbols it exercises, so we provide a no-op
 * stub for everything else the IR references. */
void sailfin_runtime_mark_persistent(void *ptr) {
    (void)ptr;
}

/* Stub `sfn_type_register` so the harness is self-contained.
 * `runtime/sfn/memory/arena.sfn` defines named structs (`ArenaPage`,
 * `Arena`), which makes the compiler emit a
 * `@__sfn_module_type_init__*` constructor that calls
 * `@sfn_type_register` via `@llvm.global_ctors`. The full
 * implementation lives in `runtime/sfn/type_meta.sfn`, but linking
 * the harness against `type_meta.o` would require a built compiler
 * tree — a no-op stub here lets the roundtrip link cleanly against
 * the bare emitted `.ll` regardless of whether `type_meta.o` is
 * staged. */
void sfn_type_register(void *desc) {
    (void)desc;
}

/* #1309: arena.sfn now DEFINES `sfn_arena_enabled` and
 * `sfn_arena_global` (they replaced the removed C namesakes), so the
 * emitted arena.ll carries their bodies — providing stubs here would be
 * a duplicate-symbol link error. This lifecycle harness exercises only
 * the five `sfn_arena_sfn_*` infix entry points (which never reach the
 * global handle or the arena-mode probe), so the real Sailfin
 * definitions sit unused in the link; they pull in libc
 * getenv/strcmp/write/abort, all resolved by the system C library. */

/* #1309: those two functions build their probe literals (the env-var
 * name; the OOM diagnostic) as SfnStrings via `sfn_alloc_struct`, so
 * arena.ll now references it even though this harness never calls the
 * functions. A calloc-backed stub satisfies the link (the
 * interposed-`free` counter is unaffected — the infix entry points the
 * harness exercises never call `sfn_alloc_struct`). */
void *sfn_alloc_struct(long size_bytes) {
    return calloc(1, (size_t)size_bytes);
}

int main(void) {
    /* Phase 1: create + small alloc + write-read roundtrip.
     * 4096-byte pages so subsequent assertions can cross the page
     * boundary deterministically. */
    void *arena = sfn_arena_sfn_create(4096);
    if (!arena) {
        fprintf(stderr, "create returned NULL\n");
        return 1;
    }

    uint8_t *p1 = (uint8_t *)sfn_arena_sfn_alloc(arena, 128, 8);
    if (!p1) {
        fprintf(stderr, "alloc(128) returned NULL\n");
        return 2;
    }
    memset(p1, 0xAB, 128);
    for (size_t i = 0; i < 128; i++) {
        if (p1[i] != 0xAB) {
            fprintf(stderr, "alloc roundtrip: p1[%zu] = 0x%02x\n", i, p1[i]);
            return 3;
        }
    }

    /* Phase 2: realloc grow-in-place. p1 is at the tip of page 1 so
     * extending its size from 128 to 256 must keep the same pointer
     * (no copy). Bytes [0, 128) must still hold the 0xAB pattern. */
    uint8_t *p2 = (uint8_t *)sfn_arena_sfn_realloc(arena, p1, 128, 256, 8);
    if (p2 != p1) {
        fprintf(stderr, "grow-in-place: expected p2 == p1, got %p vs %p\n",
                (void *)p2, (void *)p1);
        return 4;
    }
    for (size_t i = 0; i < 128; i++) {
        if (p2[i] != 0xAB) {
            fprintf(stderr, "grow-in-place: p2[%zu] = 0x%02x\n", i, p2[i]);
            return 5;
        }
    }

    /* Phase 3: realloc copy-on-overflow. Allocate after p2 so p2 is
     * no longer at the tip, then realloc p2 — the allocator must
     * return a fresh pointer and memcpy the old contents. */
    uint8_t *p3 = (uint8_t *)sfn_arena_sfn_alloc(arena, 64, 8);
    if (!p3) {
        fprintf(stderr, "alloc(64) after p2 returned NULL\n");
        return 6;
    }
    memset(p3, 0xCD, 64);

    uint8_t *p4 = (uint8_t *)sfn_arena_sfn_realloc(arena, p2, 256, 512, 8);
    if (!p4) {
        fprintf(stderr, "copy-on-overflow realloc returned NULL\n");
        return 7;
    }
    if (p4 == p2) {
        fprintf(stderr, "copy-on-overflow: expected fresh pointer, got same %p\n",
                (void *)p4);
        return 8;
    }
    for (size_t i = 0; i < 128; i++) {
        if (p4[i] != 0xAB) {
            fprintf(stderr, "copy-on-overflow: p4[%zu] = 0x%02x (expected 0xAB)\n",
                    i, p4[i]);
            return 9;
        }
    }
    /* p3's bytes must be untouched by the copy. */
    for (size_t i = 0; i < 64; i++) {
        if (p3[i] != 0xCD) {
            fprintf(stderr, "phase 3: p3[%zu] = 0x%02x (expected 0xCD)\n",
                    i, p3[i]);
            return 10;
        }
    }

    /* Phase 4: force a new page allocation. Page 1 is 4096 bytes
     * with ~896 used (128 + 64 + 512 + alignment); a request for
     * 8192 bytes overflows and must trigger _sfn_arena_page_create
     * for page 2. The harness verifies this indirectly through the
     * destroy free-count: a one-page arena destroys with 3 frees
     * (1 header + 1 data + 1 arena handle); a two-page arena
     * destroys with 5 frees. */
    uint8_t *p5 = (uint8_t *)sfn_arena_sfn_alloc(arena, 8192, 8);
    if (!p5) {
        fprintf(stderr, "alloc(8192) returned NULL\n");
        return 11;
    }
    memset(p5, 0xEF, 8192);
    /* Spot-check the head and tail of the large allocation. */
    if (p5[0] != 0xEF || p5[8191] != 0xEF) {
        fprintf(stderr, "phase 4: large alloc roundtrip failed\n");
        return 12;
    }

    /* Phase 5: reset must keep both pages attached (zero `used` on
     * each, park current on page 1) so the next alloc reuses
     * existing capacity instead of growing the chain. Verify by
     * snapshotting free_count before reset+alloc, then asserting it
     * doesn't change until destroy. */
    long pre_reset_frees = free_count;
    sfn_arena_sfn_reset(arena);

    uint8_t *p6 = (uint8_t *)sfn_arena_sfn_alloc(arena, 64, 8);
    if (!p6) {
        fprintf(stderr, "alloc after reset returned NULL\n");
        return 13;
    }
    memset(p6, 0x12, 64);
    for (size_t i = 0; i < 64; i++) {
        if (p6[i] != 0x12) {
            fprintf(stderr, "post-reset roundtrip: p6[%zu] = 0x%02x\n", i, p6[i]);
            return 14;
        }
    }
    if (free_count != pre_reset_frees) {
        fprintf(stderr, "reset+alloc inflated free count (%ld -> %ld)\n",
                pre_reset_frees, free_count);
        return 15;
    }

    /* Phase 6: destroy must release every page (header + data
     * buffer) plus the arena handle itself. After phase 4 the
     * chain has exactly 2 pages, so destroy must produce 5 frees:
     *   2 page headers + 2 page data buffers + 1 arena handle.
     * Reset (phase 5) keeps both pages, so this count is stable
     * across the reset+alloc cycle. */
    long pre_destroy_frees = free_count;
    sfn_arena_sfn_destroy(arena);
    long destroy_delta = free_count - pre_destroy_frees;
    if (destroy_delta != 5) {
        fprintf(stderr, "destroy: expected 5 frees (2 pages × (header+data) + arena), got %ld\n",
                destroy_delta);
        return 16;
    }

    /* Phase 7: a fresh arena built with default_page_size = 0 must
     * select the 1 MiB compiler default (not abort, not return
     * NULL). Destroy immediately to keep the harness short-lived. */
    void *arena2 = sfn_arena_sfn_create(0);
    if (!arena2) {
        fprintf(stderr, "create(0) returned NULL — default-page-size fallback broken\n");
        return 17;
    }
    sfn_arena_sfn_destroy(arena2);

    /* Phase 8: null-arena no-ops. Reset and destroy on NULL must
     * not crash; alloc on a NULL arena (or with zero size on a
     * live arena) must return NULL. */
    sfn_arena_sfn_reset(NULL);
    sfn_arena_sfn_destroy(NULL);
    if (sfn_arena_sfn_alloc(NULL, 16, 8) != NULL) {
        fprintf(stderr, "alloc(NULL arena) did not return NULL\n");
        return 18;
    }

    void *arena3 = sfn_arena_sfn_create(4096);
    if (!arena3) {
        return 19;
    }
    if (sfn_arena_sfn_alloc(arena3, 0, 8) != NULL) {
        fprintf(stderr, "alloc(arena, 0) did not return NULL\n");
        return 20;
    }
    sfn_arena_sfn_destroy(arena3);

    return 0;
}
CHARNESS

    local clang_bin
    clang_bin="${CLANG:-clang}"
    if ! command -v "$clang_bin" >/dev/null 2>&1; then
        echo "[test]   clang not available — skipping lifecycle roundtrip"
        # Skip rather than fail so the test passes on systems without
        # clang. The IR-shape assertions above still pin the contract;
        # the roundtrip is the functional cherry on top.
        return 0
    fi
    # `Wno-override-module` because the .ll emitted by the Sailfin
    # compiler carries a target triple that may not match the host
    # clang's default (see Makefile.CLANG_WARN_SUPPRESS).
    # `-lm` because the seed compiler lowers integer literals through
    # `round(double)` + `fptosi`, leaving libm references in the
    # emitted `.ll`. The harness stubs `sfn_type_register` directly
    # so the link is self-contained — no dependency on a staged
    # `build/native/obj/runtime/type_meta.o` (which would tie this
    # test to having a built compiler tree on hand, breaking
    # invocation against an installed binary).
    local bin="$SCRATCH/roundtrip"
    if ! "$clang_bin" -Wno-override-module "$harness" "$ll" -o "$bin" -lm 2>"$SCRATCH/clang.log"; then
        echo "[test]   clang failed to link lifecycle harness:"
        cat "$SCRATCH/clang.log"
        return 1
    fi
    if ! "$bin"; then
        local rc=$?
        echo "[test]   lifecycle binary exited non-zero (rc=$rc)"
        return 1
    fi
    return 0
}

test_asan_no_corruption() {
    # #1309 deciding constraint, end-to-end. Links the Sailfin arena
    # (arena.ll: bare `sfn_arena_create` / `sfn_arena_alloc` that own
    # the 40-byte handle) against the still-C `sailfin_arena.c`
    # (`sfn_arena_realloc` / `sfn_arena_print_stats`) and exercises the
    # cross-runtime path on a SHARED handle under AddressSanitizer. If
    # the Sailfin `Arena` were the old 24-byte layout, the C side's
    # instrumented reads/writes of `total_allocated@24` /
    # `total_pages@32` would land in the malloc redzone and ASAN would
    # report a heap-buffer-overflow. With the 40-byte match the run is
    # clean. The IR-shape gate (test_arena_struct_is_40_bytes) catches
    # the same regression statically; this is the dynamic proof.
    local ll="$SCRATCH/arena.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi

    local clang_bin
    clang_bin="${CLANG:-clang}"
    if ! command -v "$clang_bin" >/dev/null 2>&1; then
        echo "[test]   clang not available — skipping ASAN no-corruption gate"
        return 0
    fi

    # ASAN reserves ~16 TB of virtual address space for its shadow at
    # startup; any finite `ulimit -v` (or the compiler self-cap) aborts
    # that reservation before main(). Skip — not fail — when capped; the
    # static IR-shape gate still pins the layout. See
    # `.claude/rules/compiler-safety.md`.
    local vmem_cap
    vmem_cap="$(ulimit -v 2>/dev/null || echo unlimited)"
    if [ "$vmem_cap" != "unlimited" ]; then
        echo "[test]   virtual-memory cap active (ulimit -v ${vmem_cap}) — ASAN shadow reservation cannot run; static 40-byte gate still passed"
        return 0
    fi

    # Probe that the ASAN runtime (compiler-rt archives) is actually
    # installed — many minimal toolchains ship clang without it. A
    # missing sanitizer runtime is a SKIP, not a failure (the static
    # 40-byte IR-shape gate already pins the layout); only a genuine
    # `ERROR: AddressSanitizer` report below may fail the test. See
    # `.claude/rules/compiler-safety.md`.
    local probe="$SCRATCH/asan_probe.c"
    echo 'int main(void){return 0;}' > "$probe"
    if ! "$clang_bin" -fsanitize=address "$probe" -o "$SCRATCH/asan_probe" 2>"$SCRATCH/asan_probe.log"; then
        echo "[test]   AddressSanitizer runtime unavailable (compiler-rt archives missing) — skipping; static 40-byte gate still passed"
        return 0
    fi

    local harness="$SCRATCH/asan_harness.c"
    cat > "$harness" <<'CHARNESS'
/* Cross-runtime no-corruption harness for #1309. The Sailfin arena
 * owns create/alloc (40-byte handle); the C arena owns realloc/
 * print_stats. Both touch the SAME handle. Under ASAN, a layout
 * mismatch surfaces as a heap-buffer-overflow on the C side's access
 * to total_allocated@24 / total_pages@32. */
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Sailfin-defined (arena.ll). */
extern void *sfn_arena_create(size_t default_page_size);
extern void *sfn_arena_alloc(void *arena, size_t size, size_t align);
/* C-defined (sailfin_arena.c) — operate on the shared handle. */
extern void *sfn_arena_realloc(void *arena, void *ptr, size_t old_size,
                               size_t new_size, size_t align);
extern void sfn_arena_print_stats(void *arena);

/* Stubs the emitted arena.ll references (see lifecycle harness). The
 * Sailfin arena-mode probe / global builds SfnString literals via
 * sfn_alloc_struct; a calloc-backed stub satisfies the link. */
void sailfin_runtime_mark_persistent(void *ptr) { (void)ptr; }
void sfn_type_register(void *desc) { (void)desc; }
void *sfn_alloc_struct(long size_bytes) { return calloc(1, (size_t)size_bytes); }

int main(void) {
    /* Sailfin create → 40-byte handle, total_allocated@24=0,
     * total_pages@32=1. */
    void *arena = sfn_arena_create(4096);
    if (!arena) {
        fprintf(stderr, "create returned NULL\n");
        return 1;
    }

    /* Sailfin alloc bumps total_allocated@24 on the shared handle. */
    uint8_t *p = (uint8_t *)sfn_arena_alloc(arena, 128, 8);
    if (!p) {
        fprintf(stderr, "alloc(128) returned NULL\n");
        return 2;
    }
    memset(p, 0xAB, 128);

    /* C realloc reads ptr/used and writes total_allocated@24 (grow-in-
     * place: p is at the tip). C-instrumented access to offset 24 must
     * be in-bounds → no ASAN report. */
    uint8_t *p2 = (uint8_t *)sfn_arena_realloc(arena, p, 128, 256, 8);
    if (!p2) {
        fprintf(stderr, "realloc returned NULL\n");
        return 3;
    }
    for (size_t i = 0; i < 128; i++) {
        if (p2[i] != 0xAB) {
            fprintf(stderr, "realloc lost bytes at %zu\n", i);
            return 4;
        }
    }

    /* C realloc copy-on-overflow path calls Sailfin sfn_arena_alloc
     * (allocates a fresh page → writes total_pages@32 + total_allocated
     * @24). Force it by allocating past the tip first. */
    uint8_t *q = (uint8_t *)sfn_arena_alloc(arena, 64, 8);
    if (!q) { return 5; }
    uint8_t *p3 = (uint8_t *)sfn_arena_realloc(arena, p2, 256, 8192, 8);
    if (!p3) { return 6; }

    /* C print_stats reads total_allocated@24 and walks the page chain —
     * the canonical cross-runtime read of the transition counters. */
    sfn_arena_print_stats(arena);

    return 0;
}
CHARNESS

    local arena_c="$REPO_ROOT/runtime/native/src/sailfin_arena.c"
    local inc="$REPO_ROOT/runtime/native/include"
    local arena_obj="$SCRATCH/arena_ll.o"
    local bin="$SCRATCH/asan_roundtrip"
    local log="$SCRATCH/asan.log"
    # Compile the Sailfin IR to a plain object first (no ASAN pass over
    # machine-generated IR — the deciding access is the C side's read of
    # the transition counters). ASAN interposes malloc globally, so the
    # Sailfin-allocated 40-byte handle still gets redzones the
    # instrumented C reads are checked against. -Wno-override-module:
    # the .ll triple may not match the host.
    if ! "$clang_bin" -Wno-override-module -c "$ll" -o "$arena_obj" 2>"$log"; then
        echo "[test]   clang failed to compile arena.ll:"
        cat "$log"
        return 1
    fi
    # ASAN-instrument the C harness + the still-C arena; link the plain
    # Sailfin object. SAILFIN_MEM_LIMIT=unlimited so the linked binary's
    # own self-cap does not abort the shadow reservation.
    if ! "$clang_bin" -fsanitize=address -Wno-override-module \
        -I"$inc" "$harness" "$arena_c" "$arena_obj" -o "$bin" -lm 2>"$log"; then
        echo "[test]   clang failed to build ASAN harness:"
        cat "$log"
        return 1
    fi
    if ! SAILFIN_MEM_LIMIT=unlimited ASAN_OPTIONS=detect_leaks=0 "$bin" >"$log" 2>&1; then
        echo "[test]   ASAN no-corruption harness failed:"
        cat "$log"
        return 1
    fi
    if grep -q "ERROR: AddressSanitizer" "$log"; then
        echo "[test]   AddressSanitizer reported a violation on the shared handle:"
        cat "$log"
        return 1
    fi
    return 0
}

test_arena_enabled_env_semantics() {
    # #1309 regression coverage for the two subtlest fixes in the port:
    #   (1) the re-entrancy guard — `sfn_arena_enabled` builds its
    #       `SAILFIN_USE_ARENA` probe literals via `sfn_alloc_struct`,
    #       which (like `mem.sfn`) calls back into `sfn_arena_enabled`;
    #       without the provisional-state guard the very first call
    #       recurses to a stack overflow. The harness's `sfn_alloc_struct`
    #       below deliberately re-enters `sfn_arena_enabled` to reproduce
    #       that path — a regression that drops the guard CRASHES here.
    #   (2) the getenv-not-elided fix — the inline `getenv("…" as * u8)`
    #       form miscompiles (call elided, result lowered to null), making
    #       every env value read as "unset" (→ enabled). Asserting the
    #       off-values flip to disabled pins the `string`-local form.
    local ll="$SCRATCH/arena.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi
    local clang_bin
    clang_bin="${CLANG:-clang}"
    if ! command -v "$clang_bin" >/dev/null 2>&1; then
        echo "[test]   clang not available — skipping env-semantics gate"
        return 0
    fi

    local harness="$SCRATCH/env_harness.c"
    cat > "$harness" <<'CHARNESS'
#include <stddef.h>
#include <stdlib.h>
#include <stdio.h>
/* i1 return → declare _Bool so the upper bits of the return register
 * are not read as garbage (an `int` decl makes every value read as
 * nonzero/true). */
extern _Bool sfn_arena_enabled(void);
void sailfin_runtime_mark_persistent(void *p) { (void)p; }
void sfn_type_register(void *d) { (void)d; }
/* Mirror mem.sfn's sfn_alloc_struct: it consults sfn_arena_enabled to
 * route arena-vs-calloc — exactly the re-entrancy the probe's
 * provisional-state guard must survive. calloc keeps the harness
 * self-contained; the point is to re-enter sfn_arena_enabled during its
 * own first-call probe. Without the guard this recurses forever. */
void *sfn_alloc_struct(long n) { (void)sfn_arena_enabled(); return calloc(1, (size_t)n); }
int main(void) { printf("%d\n", sfn_arena_enabled() ? 1 : 0); return 0; }
CHARNESS

    local bin="$SCRATCH/env_probe"
    if ! "$clang_bin" -Wno-override-module "$harness" "$ll" -o "$bin" -lm 2>"$SCRATCH/env.log"; then
        echo "[test]   clang failed to build env-semantics harness:"
        cat "$SCRATCH/env.log"
        return 1
    fi

    # Each row: "<label>|<env-spec>|<expected>". An empty env-spec means
    # unset; "VAR=" means set-but-empty. A crash (no output / nonzero rc)
    # is the recursion-guard regression signal.
    local fails=0
    _probe() { # $1=expected  $2.. = env assignment(s) (may be empty)
        local expected="$1"; shift
        local got
        got="$(env -u SAILFIN_USE_ARENA "$@" "$bin" 2>/dev/null)" || {
            echo "[test]   sfn_arena_enabled crashed (rc=$?) with [$*] — re-entrancy guard regression?"
            fails=$((fails + 1)); return
        }
        if [ "$got" != "$expected" ]; then
            echo "[test]   SAILFIN_USE_ARENA [$*]: got '$got', expected '$expected'"
            fails=$((fails + 1))
        fi
    }
    _probe 1                              # unset → on (default)
    _probe 1 SAILFIN_USE_ARENA=1          # explicit on
    _probe 1 SAILFIN_USE_ARENA=yes        # any other value → on
    _probe 0 SAILFIN_USE_ARENA=           # empty → off
    _probe 0 SAILFIN_USE_ARENA=0          # "0" → off
    _probe 0 SAILFIN_USE_ARENA=false      # "false" → off
    return "$fails"
}

run_test "sfn check runtime/sfn/memory/arena.sfn passes" test_check_clean
run_test "sfn fmt --check runtime/sfn/memory/arena.sfn is canonical" test_fmt_clean
run_test "sfn emit llvm produces define for every sfn_arena_sfn_* export" test_emit_define_shape
run_test "sfn emit llvm declares libc malloc/free/memcpy trampolines" test_emit_libc_declares
run_test "sfn emit llvm defines bare arena-core exports (create/alloc/global/enabled)" test_bare_core_defines
run_test "sfn emit llvm keeps Arena byte-identical to C SfnArena (40 bytes)" test_arena_struct_is_40_bytes
run_test "sfn emit llvm does not collide with still-C sfn_arena_* exports" test_no_bare_sfn_arena_define
run_test "create → alloc → realloc → reset → destroy exercises every entry point" test_lifecycle_roundtrip
run_test "SAILFIN_USE_ARENA env semantics + probe recursion guard" test_arena_enabled_env_semantics
run_test "ASAN: C realloc/print_stats on a Sailfin-created handle is corruption-free" test_asan_no_corruption

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
