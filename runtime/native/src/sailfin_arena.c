/*
 * sailfin_arena.c — M0.5 bump allocator for the Sailfin runtime.
 *
 * Temporary C implementation (~200 lines). Will be replaced by a
 * Sailfin-native arena at M2/M3. See docs/runtime_architecture.md §4.4.
 */

#include "sailfin_arena.h"

#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* ------------------------------------------------------------------ */
/* Internal helpers                                                    */
/* ------------------------------------------------------------------ */

static inline size_t _align_up(size_t value, size_t align)
{
    /* align must be a non-zero power of two (all internal callers pass 8). */
    return (value + align - 1) & ~(align - 1);
}

static SfnArenaPage *_page_create(size_t capacity)
{
    SfnArenaPage *page = (SfnArenaPage *)malloc(sizeof(SfnArenaPage));
    if (!page)
        return NULL;

    page->data = (uint8_t *)malloc(capacity);
    if (!page->data)
    {
        free(page);
        return NULL;
    }

    page->capacity = capacity;
    page->used = 0;
    page->next = NULL;
    return page;
}

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

SfnArena *sfn_arena_create(size_t default_page_size)
{
    if (default_page_size == 0)
        default_page_size = 1024 * 1024; /* 1 MiB default for compiler */

    SfnArena *arena = (SfnArena *)malloc(sizeof(SfnArena));
    if (!arena)
        return NULL;

    SfnArenaPage *first = _page_create(default_page_size);
    if (!first)
    {
        free(arena);
        return NULL;
    }

    arena->current = first;
    arena->first = first;
    arena->default_page_size = default_page_size;
    arena->total_allocated = 0;
    arena->total_pages = 1;
    return arena;
}

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

void *sfn_arena_alloc(SfnArena *arena, size_t size, size_t align)
{
    if (!arena || size == 0)
        return NULL;
    if (align == 0)
        align = 8;

    SfnArenaPage *page = arena->current;
    size_t offset = _align_up(page->used, align);

    if (offset <= page->capacity && size <= page->capacity - offset)
    {
        page->used = offset + size;
        arena->total_allocated += size;
        return page->data + offset;
    }

    /* Current page too small — try to reuse downstream pages first.
     *
     * `sfn_arena_rewind` (Phase 5a) leaves zeroed pages attached
     * after the rewind target so subsequent allocations can reuse
     * the existing capacity instead of growing the page list. The
     * old behavior allocated a fresh page on every overflow,
     * leaking the rewound capacity behind the new page in the
     * linked list. Walking forward here makes mark/rewind a true
     * stack-discipline reuse. The walk is bounded by pages that
     * survived the most-recent rewind; in steady state it's
     * usually one hop. */
    SfnArenaPage *candidate = page->next;
    while (candidate)
    {
        size_t cand_offset = _align_up(candidate->used, align);
        if (cand_offset <= candidate->capacity && size <= candidate->capacity - cand_offset)
        {
            candidate->used = cand_offset + size;
            arena->current = candidate;
            arena->total_allocated += size;
            return candidate->data + cand_offset;
        }
        candidate = candidate->next;
    }

    /* No reusable downstream page — allocate a new one. */
    size_t needed = size + align; /* worst-case alignment padding */
    size_t page_size = arena->default_page_size;
    if (needed > page_size)
        page_size = needed;

    SfnArenaPage *new_page = _page_create(page_size);
    if (!new_page)
        return NULL;

    /* Insert new page after current and advance. */
    new_page->next = page->next;
    page->next = new_page;
    arena->current = new_page;
    arena->total_pages++;

    offset = _align_up(new_page->used, align);
    new_page->used = offset + size;
    arena->total_allocated += size;
    return new_page->data + offset;
}

void *sfn_arena_realloc(SfnArena *arena, void *ptr, size_t old_size,
                        size_t new_size, size_t align)
{
    if (!arena)
        return NULL;
    if (!ptr)
        return sfn_arena_alloc(arena, new_size, align);
    if (new_size <= old_size)
        return ptr;

    SfnArenaPage *page = arena->current;

    /*
     * Grow-if-at-tip: if `ptr` is the last allocation on the current page,
     * and the page has room, just extend in place.
     */
    uint8_t *ptr_u8 = (uint8_t *)ptr;
    uint8_t *tip = page->data + page->used;

    if (ptr_u8 + old_size == tip)
    {
        size_t extra = new_size - old_size;
        if (page->used + extra <= page->capacity)
        {
            page->used += extra;
            arena->total_allocated += extra;
            return ptr;
        }
    }

    /* Not at tip or no room — allocate fresh and copy. */
    void *new_ptr = sfn_arena_alloc(arena, new_size, align);
    if (!new_ptr)
        return NULL;
    memcpy(new_ptr, ptr, old_size);
    /* Old memory is "leaked" in the arena — reclaimed at reset/destroy. */
    return new_ptr;
}

/* ------------------------------------------------------------------ */
/* Global arena (lazy singleton)                                       */
/* ------------------------------------------------------------------ */

static SfnArena *_global_arena = NULL;
static int _arena_enabled = -1; /* -1 = unchecked */
static pthread_once_t _arena_enabled_once = PTHREAD_ONCE_INIT;
static pthread_once_t _arena_global_once = PTHREAD_ONCE_INIT;

static void _init_arena_enabled(void)
{
    const char *env = getenv("SAILFIN_USE_ARENA");
    _arena_enabled = (env && env[0] != '\0' && env[0] != '0') ? 1 : 0;
}

bool sfn_arena_enabled(void)
{
    pthread_once(&_arena_enabled_once, _init_arena_enabled);
    return _arena_enabled == 1;
}

static void _init_global_arena(void)
{
    /* 4 MiB pages for the compiler — modules can be large. */
    _global_arena = sfn_arena_create(4 * 1024 * 1024);
    if (!_global_arena)
    {
        fprintf(stderr, "[sailfin-arena] fatal: failed to create global arena\n");
        abort();
    }
}

SfnArena *sfn_arena_global(void)
{
    pthread_once(&_arena_global_once, _init_global_arena);
    return _global_arena;
}

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
