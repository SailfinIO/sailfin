#pragma once

/*
 * sailfin_arena.h — bump allocator for the Sailfin runtime (transition).
 *
 * As of #1309 the arena *core* — the process-global handle and the hot
 * bump path (`sfn_arena_create`, `sfn_arena_alloc`, `sfn_arena_global`,
 * `sfn_arena_enabled`) — lives in `runtime/sfn/memory/arena.sfn`. The
 * declarations for those four stay below so C callers link against the
 * Sailfin definitions; the C definitions here are
 * `sfn_arena_realloc`/`reset`/`destroy`/`print_stats`/`mark`/`rewind`,
 * which operate on the same shared handle and retire in #822. See
 * docs/runtime_architecture.md §4.4.
 *
 * When the arena is enabled (SAILFIN_USE_ARENA — unset/other → on;
 * empty/"0"/"false" → off), the runtime routes all string and array
 * allocations through a process-global arena. Memory is freed in bulk at
 * process exit (or per-module in a long-lived compiler process).
 */

#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>

#ifdef __cplusplus
extern "C"
{
#endif

    /* A single page in the arena's page chain. */
    typedef struct SfnArenaPage
    {
        uint8_t *data;             /* Backing memory (malloc'd) */
        size_t capacity;           /* Page size in bytes         */
        size_t used;               /* Current bump offset        */
        struct SfnArenaPage *next; /* Next page (NULL for last)  */
    } SfnArenaPage;

    /* Process-global arena. */
    typedef struct SfnArena
    {
        SfnArenaPage *current;    /* Active page (bump target)     */
        SfnArenaPage *first;      /* Head of page list (for reset) */
        size_t default_page_size; /* Default page size in bytes    */
        size_t total_allocated;   /* Total bytes allocated         */
        size_t total_pages;       /* Number of pages allocated     */
    } SfnArena;

    /* ---------- Lifecycle ---------- */

    /*
     * Create a new arena with the given default page size.
     *
     * #1309: defined in runtime/sfn/memory/arena.sfn — this prototype
     * stays so C callers (sailfin_runtime.c) link against the Sailfin
     * definition. sailfin_arena.c no longer defines it.
     */
    SfnArena *sfn_arena_create(size_t default_page_size);

    /*
     * #1309: `sfn_arena_reset` / `sfn_arena_destroy`, the
     * struct-returning `sfn_arena_mark` / `sfn_arena_rewind`, the
     * `SfnArenaMark` typedef, and `sfn_arena_print_stats` are retired.
     * `reset`/`destroy` had no callers; the live mark/rewind +
     * print-stats paths are the Sailfin `sfn_arena_sfn_mark` /
     * `sfn_arena_sfn_rewind` / `sfn_arena_sfn_print_stats` exports in
     * `runtime/sfn/memory/arena.sfn`. The bare `sfn_arena_print_stats`
     * the C atexit telemetry caller binds to is now a Sailfin export,
     * so no prototype lives here.
     */

    /* ---------- Allocation ---------- */

    /*
     * Bump-allocate `size` bytes aligned to `align`.
     * If the current page cannot fit, a new page is allocated
     * (max of default_page_size and size+align).
     * Returns NULL only on malloc failure.
     *
     * #1309: defined in runtime/sfn/memory/arena.sfn (the bare export
     * forwards to `sfn_arena_sfn_alloc`); this prototype stays for C
     * callers and for sfn_arena_realloc below. sailfin_arena.c no
     * longer defines it.
     */
    void *sfn_arena_alloc(SfnArena *arena, size_t size, size_t align);

    /*
     * Grow-if-at-tip realloc for arena allocations.
     *
     * If `ptr` is the last allocation in the current page AND the page has
     * room to grow to `new_size`, extends in place (no copy). Otherwise,
     * allocates a new region and copies `old_size` bytes.
     *
     * This preserves the string_append realloc optimization for the common
     * case of chained appends in a loop.
     */
    void *sfn_arena_realloc(SfnArena *arena, void *ptr, size_t old_size,
                            size_t new_size, size_t align);

    /* ---------- Global arena ---------- */
    /*
     * #1309: sfn_arena_enabled and sfn_arena_global are defined in
     * runtime/sfn/memory/arena.sfn. These prototypes stay so C callers
     * (sailfin_runtime.c) link against the Sailfin definitions;
     * sailfin_arena.c no longer defines them or the lazy-singleton
     * statics.
     */

    /* Returns true if arena mode is active (SAILFIN_USE_ARENA semantics). */
    bool sfn_arena_enabled(void);

    /* Get the process-global arena (lazily created on first call). */
    SfnArena *sfn_arena_global(void);

    /*
     * Print arena statistics to stderr.
     *
     * #1309: defined in runtime/sfn/memory/arena.sfn (the bare Sailfin
     * `sfn_arena_print_stats` export forwards to
     * `sfn_arena_sfn_print_stats`). This prototype stays so the
     * C-runtime atexit telemetry caller (sailfin_runtime.c) binds to
     * the Sailfin definition by name; sailfin_arena.c no longer defines
     * it.
     */
    void sfn_arena_print_stats(SfnArena *arena);

#ifdef __cplusplus
}
#endif
