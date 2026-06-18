/*
 * sailfin_arena.c — bump allocator for the Sailfin runtime (transition).
 *
 * As of #1309 the arena *core* — the process-global handle plus the hot
 * bump path (`sfn_arena_create`, `sfn_arena_alloc`, `sfn_arena_global`,
 * `sfn_arena_enabled`) — is owned by the Sailfin module
 * `runtime/sfn/memory/arena.sfn`; those symbols are removed here so the
 * linker binds every caller (this file's siblings, `sailfin_runtime.c`,
 * and the `mem.sfn` externs) to the Sailfin definitions. What remains —
 * `sfn_arena_realloc`/`reset`/`destroy`/`print_stats`/`mark`/`rewind` —
 * operates on the *same* shared global handle, which is byte-compatible
 * across both runtimes (the Sailfin `Arena` mirrors `SfnArena`'s 40-byte
 * layout). The rest of this file retires in #822. See
 * docs/runtime_architecture.md §4.4.
 */

#include "sailfin_arena.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
 * `sfn_arena_alloc` is now defined in `runtime/sfn/memory/arena.sfn`
 * (#1309); `sfn_arena_realloc` below calls it through the prototype in
 * `sailfin_arena.h`, resolved at link time against the Sailfin object.
 */

/* ------------------------------------------------------------------ */
/* Internal helpers                                                    */
/* ------------------------------------------------------------------ */

static void _page_destroy(SfnArenaPage *page)
{
    if (!page)
        return;
    free(page->data);
    free(page);
}

/* ------------------------------------------------------------------ */
/* Lifecycle                                                           */
/* ------------------------------------------------------------------ */

/* sfn_arena_create: now defined in runtime/sfn/memory/arena.sfn (#1309). */

void sfn_arena_reset(SfnArena *arena)
{
    if (!arena)
        return;
    for (SfnArenaPage *p = arena->first; p; p = p->next)
        p->used = 0;
    arena->current = arena->first;
    arena->total_allocated = 0;
}

/* ------------------------------------------------------------------ */
/* Mark / rewind                                                       */
/* ------------------------------------------------------------------ */

SfnArenaMark sfn_arena_mark(SfnArena *arena)
{
    SfnArenaMark mark = {NULL, 0};
    if (!arena || !arena->current)
        return mark;
    mark.page = arena->current;
    mark.used = arena->current->used;
    return mark;
}

void sfn_arena_rewind(SfnArena *arena, SfnArenaMark mark)
{
    if (!arena)
        return;
    /* Null mark: equivalent to a no-op. Callers can safely pair
     * marks taken before the arena was initialized with a rewind. */
    if (!mark.page)
        return;

    /* Walk pages allocated after the marked page and zero their
     * `used` counters so subsequent allocations reuse them. */
    for (SfnArenaPage *p = mark.page->next; p; p = p->next)
        p->used = 0;

    /* Rewind the marked page itself to the snapshot offset and
     * make it the current allocation target. Pages strictly after
     * the marked one stay attached for reuse on the next burst —
     * we only release memory back to the OS at arena destruction. */
    mark.page->used = mark.used;
    arena->current = mark.page;
}

void sfn_arena_destroy(SfnArena *arena)
{
    if (!arena)
        return;
    SfnArenaPage *p = arena->first;
    while (p)
    {
        SfnArenaPage *next = p->next;
        _page_destroy(p);
        p = next;
    }
    free(arena);
}

/* ------------------------------------------------------------------ */
/* Allocation                                                          */
/* ------------------------------------------------------------------ */

/* sfn_arena_alloc: now defined in runtime/sfn/memory/arena.sfn (#1309). */

/*
 * sfn_arena_realloc: now defined in runtime/sfn/memory/arena.sfn (the bare
 * export forwards to `sfn_arena_sfn_realloc`); the prototype in
 * sailfin_arena.h stays so the C-internal callers in sailfin_runtime.c bind
 * to the Sailfin definition. sailfin_arena.c no longer defines it (#1308).
 */

/* ------------------------------------------------------------------ */
/* Global arena + arena-mode probe                                     */
/* ------------------------------------------------------------------ */
/*
 * `sfn_arena_enabled` (SAILFIN_USE_ARENA probe) and `sfn_arena_global`
 * (lazy process-global handle), along with their backing statics and
 * pthread_once init helpers, are now defined in
 * `runtime/sfn/memory/arena.sfn` (#1309). The Sailfin
 * `sfn_arena_enabled` preserves the exact env semantics documented
 * there: unset → on (default); empty / "0" / "false" → off; anything
 * else → on. `sfn_arena_global` creates a 4 MiB-page handle on first
 * call and `abort()`s (bare, no diagnostic — printing one would
 * re-enter sfn_alloc_struct → sfn_arena_global and recurse) on OOM.
 */

/* ------------------------------------------------------------------ */
/* Stats                                                               */
/* ------------------------------------------------------------------ */

void sfn_arena_print_stats(SfnArena *arena)
{
    if (!arena)
        return;

    size_t total_capacity = 0;
    size_t total_used = 0;
    size_t page_count = 0;

    for (SfnArenaPage *p = arena->first; p; p = p->next)
    {
        total_capacity += p->capacity;
        total_used += p->used;
        page_count++;
    }

    fprintf(stderr,
            "[sailfin-arena] pages=%zu capacity=%.2fMB used=%.2fMB "
            "allocated=%.2fMB utilization=%.1f%%\n",
            page_count,
            (double)total_capacity / (1024.0 * 1024.0),
            (double)total_used / (1024.0 * 1024.0),
            (double)arena->total_allocated / (1024.0 * 1024.0),
            total_capacity > 0
                ? 100.0 * (double)total_used / (double)total_capacity
                : 0.0);
}
