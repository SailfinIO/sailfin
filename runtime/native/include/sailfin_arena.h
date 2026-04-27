#pragma once

/*
 * sailfin_arena.h — M0.5 bump allocator for the Sailfin runtime.
 *
 * Temporary C implementation that will be replaced by a Sailfin-native
 * arena at M2/M3. See docs/runtime_architecture.md §4.4.
 *
 * When SAILFIN_USE_ARENA=1 is set in the environment, the runtime routes
 * all string and array allocations through a process-global arena. Memory
 * is freed in bulk at process exit (or per-module in a future long-lived
 * compiler process).
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

    /* Create a new arena with the given default page size. */
    SfnArena *sfn_arena_create(size_t default_page_size);

    /* Reset all pages to used=0. Does NOT free backing pages. */
    void sfn_arena_reset(SfnArena *arena);

    /* Free all backing pages and the arena struct itself. */
    void sfn_arena_destroy(SfnArena *arena);

    /* ---------- Mark / rewind ---------- */
    /*
     * Stack-discipline checkpoint into the arena. Phase 5a (see
     * `docs/proposals/phase-5a-arena-reset.md`) ships these so
     * in-process multi-module tools (`sfn check`, `sfn test`) can
     * reclaim per-iteration scratch without invalidating allocations
     * made before the loop.
     *
     * `sfn_arena_mark` snapshots the current page + used offset.
     * `sfn_arena_rewind` walks pages back to the snapshot and zeros
     * `used` on every page strictly after the marked page; the
     * marked page itself rewinds to its snapshot offset. Pages
     * allocated since the mark stay attached to the arena for reuse
     * on the next allocation burst.
     *
     * Mark/rewind is strictly LIFO. Caller is responsible for not
     * holding pointers to memory above the rewind target — same
     * contract as `sfn_arena_reset`.
     */
    typedef struct SfnArenaMark
    {
        SfnArenaPage *page; /* Page that was current at mark time */
        size_t used;        /* Used offset on that page at mark time */
    } SfnArenaMark;

    SfnArenaMark sfn_arena_mark(SfnArena *arena);
    void sfn_arena_rewind(SfnArena *arena, SfnArenaMark mark);

    /* ---------- Allocation ---------- */

    /*
     * Bump-allocate `size` bytes aligned to `align`.
     * If the current page cannot fit, a new page is allocated
     * (max of default_page_size and size+align).
     * Returns NULL only on malloc failure.
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

    /* Returns true if arena mode is active (SAILFIN_USE_ARENA=1). */
    bool sfn_arena_enabled(void);

    /* Get the process-global arena (lazily created on first call). */
    SfnArena *sfn_arena_global(void);

    /* Print arena statistics to stderr. */
    void sfn_arena_print_stats(SfnArena *arena);

#ifdef __cplusplus
}
#endif
