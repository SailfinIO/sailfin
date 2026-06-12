# Runtime aliasing & manual-memory site inventory (`runtime/sfn/**`)

> **Status:** living migration checklist · **Epic:** #1209 (issue #1210, E1) ·
> **Motivated by:** #1205

This document is the **per-site refinement** of section 1.3 ("Quantifying the
surface") of the borrow-checking proposal
([docs/proposals/borrow-checking-1.0.md](proposals/borrow-checking-1.0.md)).
Where the proposal gives a structural census (which modules use the hazardous
raw-pointer / manual-lifetime dialect), this inventory enumerates **every
individual hazard site** with file, line range, symbol, and hazard class. It is
the migration checklist for epic #1209: the ownership-annotation and
alias-elimination work items (E8/E9) work row-by-row against these tables, and
a row is retired when the site is either proven uniquely-owned or rewritten to
a copying/owning form.

## Methodology

### Hazard rubric

Every site is classified into exactly one of three hazard classes:

- **`in-place-mutation`** — a write through a raw pointer (or computed
  ptr+offset) into a buffer that other live handles may reference: bump-cursor
  and length/capacity field updates, grow-at-tip realloc paths, `memcpy`/`memset`
  into existing buffers, and extern calls that write through a passed-in pointer
  (out-params, `recv`, `poll`, `waitpid`, etc.).
- **`use-after-free`** — every `free()` call (manual-free site), every
  relocating `realloc`, every *logical* free (arena reset/rewind that re-hands
  out bytes while stale payload pointers persist), and every dereference of a
  possibly-already-freed handle (e.g. i64-to-pointer reconstitution with no
  liveness tracking).
- **`shared-mutable-alias`** — two or more live handles to the same bytes with
  no tracked ownership: raw addresses parked in struct fields or module globals
  as `i64`, interior pointers returned to callers, identity-return "views",
  typed overlays manufactured by pointer arithmetic, and raw pointers handed
  across extern/thread boundaries where the callee retains them.

### How sites were identified

Each `runtime/sfn/**` module was audited line-by-line, function-by-function.
For trampolines whose behavior lives in the legacy C runtime, the C bodies in
`runtime/native/src/sailfin_runtime.c` were read and the verified C-side
behavior is cited in the row notes (e.g. `_rt_malloc` arena routing,
`_rt_realloc` relocation, shallow element copies). A second verification pass
re-walked every module against the first pass's findings; rows it added are
marked "missed by first pass" / "newly found", and rows whose first-pass
classification was wrong are marked "CORRECTED" with the reasoning preserved.

### Conservative-inclusion policy

The inventory deliberately over-approximates: a row's presence does **not**
mean the site is a live bug today, it means the type system cannot prove it
safe. Specifically:

- **Every `free()` call is a site**, even when the freed pointer is
  function-local and provably dead afterward.
- **Stores into freshly malloc'd buffers** through raw ptr+offset arithmetic
  are included (the buffer is exclusive today, but nothing tracks that).
- **Raw pointers crossing extern boundaries** are included even for read-only
  callees (`send`, `getenv`, pthread init), because retention by foreign code
  is not provable from the Sailfin side.
- Sites that are currently safe **by ordering or control-flow discipline only**
  (free-after-last-use, mutually exclusive error paths) are included, since
  nothing structural enforces the discipline.

## Summary

| Module | in-place-mutation | use-after-free | shared-mutable-alias | Total |
|---|---:|---:|---:|---:|
| memory/arena | 8 | 9 | 6 | 23 |
| string | 1 | 4 | 9 | 14 |
| memory/rc | 3 | 1 | 2 | 6 |
| memory/mem | 3 | 2 | 4 | 9 |
| array | 2 | 2 | 7 | 11 |
| concurrency/scheduler | 10 | 16 | 30 | 56 |
| concurrency/channel | 6 | 3 | 13 | 22 |
| concurrency/parallel | 2 | 2 | 5 | 9 |
| concurrency/serve | 9 | 12 | 7 | 28 |
| concurrency/future | 0 | 7 | 17 | 24 |
| process | 18 | 19 | 15 | 52 |
| adapters | 17 | 9 | 14 | 40 |
| platform | 4 | 4 | 7 | 15 |
| io | 0 | 0 | 1 | 1 |
| core misc | 11 | 7 | 18 | 36 |
| **Total** | **94** | **97** | **155** | **346** |

Modules with zero sites: `platform/libc.sfn`, `platform/net.sfn`,
`platform/posix.sfn`, `platform/pthread.sfn` (extern-declaration bindings, no
function bodies — see the platform section).

## Per-module inventory

### memory/arena

Source: `runtime/sfn/memory/arena.sfn` — 23 sites (8 in-place-mutation, 9 use-after-free, 6 shared-mutable-alias).

| File | Lines | Symbol | Hazard | Notes |
|---|---|---|---|---|
| `runtime/sfn/memory/arena.sfn` | 151-156 | `_sfn_arena_page_create` | shared-mutable-alias | Stores the malloc'd data buffer address as i64 into page.data_addr (line 152) and returns the raw header pointer (line 156); the buffer is now reachable via both the local data_ptr and the persisted struct field. |
| `runtime/sfn/memory/arena.sfn` | 148 | `_sfn_arena_page_create` | use-after-free | free(header_ptr) on the OOM bail path; header_ptr is function-local at this point so risk is low — included because every free call is a site per rubric. |
| `runtime/sfn/memory/arena.sfn` | 167 | `_sfn_arena_page_destroy` | use-after-free | Frees the page's backing byte buffer (free(data_addr as * u8)) while payload pointers previously handed out by alloc/realloc into that buffer may still be live in callers. |
| `runtime/sfn/memory/arena.sfn` | 168 | `_sfn_arena_page_destroy` | use-after-free | Frees the page header (free(page_addr as * u8)) while arena.current_addr, arena.first_addr, and the upstream page's next_addr may still hold this address as i64. |
| `runtime/sfn/memory/arena.sfn` | 187 | `sfn_arena_sfn_create` | use-after-free | free(arena_ptr) on the OOM bail path; arena_ptr is still function-local so risk is low — included because every free call is a site per rubric. |
| `runtime/sfn/memory/arena.sfn` | 191-195 | `sfn_arena_sfn_create` | shared-mutable-alias | Stores the same page address (first_ptr as i64) into both arena.current_addr (line 192) and arena.first_addr (line 193) — two live i64 handles to one page header — and returns the raw arena handle to the caller (line 195). |
| `runtime/sfn/memory/arena.sfn` | 223 | `sfn_arena_sfn_alloc` | in-place-mutation | Bump-cursor advance page.used = offset + size_i on the current page, whose buffer is aliased by every payload pointer previously returned from it. |
| `runtime/sfn/memory/arena.sfn` | 224-225 | `sfn_arena_sfn_alloc` | shared-mutable-alias | Returns an interior pointer (page.data_addr + offset cast to * u8) into the shared page buffer; all allocations on a page alias one malloc'd region. |
| `runtime/sfn/memory/arena.sfn` | 244-245 | `sfn_arena_sfn_alloc` | in-place-mutation | Advances candidate.used (line 244) and reparks a.current_addr (line 245) on a reused post-reset page — len/cursor field updates on a struct whose buffer may still be referenced by stale pre-reset pointers. |
| `runtime/sfn/memory/arena.sfn` | 246-247 | `sfn_arena_sfn_alloc` | shared-mutable-alias | Returns an interior pointer (candidate.data_addr + cand_offset) into a reused page buffer; the bytes may overlap regions still referenced by payload pointers handed out before the last reset. |
| `runtime/sfn/memory/arena.sfn` | 265-268 | `sfn_arena_sfn_alloc` | shared-mutable-alias | Publishes the fresh page's raw address into both page.next_addr (line 267) and a.current_addr (line 268), and copies the old next chain into new_page.next_addr (line 266) — multiple live i64 handles to the same page header. |
| `runtime/sfn/memory/arena.sfn` | 267 | `sfn_arena_sfn_alloc` | in-place-mutation | Chain-splice store page.next_addr = new_page_ptr as i64 rewrites a link field on a shared page header that reset/destroy/rewind walks also traverse. |
| `runtime/sfn/memory/arena.sfn` | 271 | `sfn_arena_sfn_alloc` | in-place-mutation | Bump-cursor advance new_page.used = new_offset + size_i on the freshly spliced page; by this line the page header is already aliased — its address was published into page.next_addr and a.current_addr at lines 267-268 — so this is a cursor write on a shared header, parallel to the sites at lines 223 and 244. Missed by the first pass. |
| `runtime/sfn/memory/arena.sfn` | 270-273 | `sfn_arena_sfn_alloc` | shared-mutable-alias | Bumps new_page.used and returns an interior pointer (new_page.data_addr + new_offset) into a page whose address was just published into the chain and arena handle. |
| `runtime/sfn/memory/arena.sfn` | 286-292 | `sfn_arena_sfn_reset` | in-place-mutation | Zeroes p.used on every page in the chain (line 289) and reparks a.current_addr to the chain head (line 292) — cursor-field writes on pages whose buffers are aliased by all outstanding payload pointers. |
| `runtime/sfn/memory/arena.sfn` | 286-292 | `sfn_arena_sfn_reset` | use-after-free | Logical free of every outstanding allocation: buffers are kept and re-handed out by later allocs, so stale pre-reset payload pointers can still read/write bytes that subsequent allocations now own. |
| `runtime/sfn/memory/arena.sfn` | 302-308 | `sfn_arena_sfn_destroy` | use-after-free | Walks the chain calling _sfn_arena_page_destroy on every page (line 306, freeing header + buffer) while caller-held payload pointers, and the arena's own current_addr/first_addr fields, still reference the freed addresses. |
| `runtime/sfn/memory/arena.sfn` | 309 | `sfn_arena_sfn_destroy` | use-after-free | free(arena) releases the handle; any retained copy of the raw * u8 handle (e.g. the process-global handle returned by sfn_arena_global) becomes dangling. |
| `runtime/sfn/memory/arena.sfn` | 345-349 | `sfn_arena_sfn_realloc` | in-place-mutation | Grow-at-tip realloc-in-place: extends page.used (line 347) so the caller's existing buffer grows under all aliases of ptr; the tip check is raw address equality (ptr_addr + old_size_i == tip_addr, line 345) with no containment check against [data_addr, data_addr+capacity], so a pointer from a different buffer that is coincidentally adjacent would be extended wrongly. |
| `runtime/sfn/memory/arena.sfn` | 354-357 | `sfn_arena_sfn_realloc` | use-after-free | Relocating path: fresh alloc + memcpy returns a new address while the old ptr is deliberately 'leaked' into the arena and stays readable until reset/destroy — classic realloc-relocates-while-old-addresses-persist; stale ptr bytes are later reused by new allocations. |
| `runtime/sfn/memory/arena.sfn` | 356 | `sfn_arena_sfn_realloc` | in-place-mutation | memcpy(new_ptr, ptr, old_size_i as usize) writes through a raw pointer into an arena page buffer that is also reachable via page.data_addr and other interior pointers (destination region is freshly bumped, so overlap risk is low — included conservatively per rubric's memcpy-into-existing-buffer rule). |
| `runtime/sfn/memory/arena.sfn` | 486-497 | `sfn_arena_sfn_rewind` | in-place-mutation | Zeroes after_page.used on every page after the marked page (line 490), rewinds mark_page.used to the snapshot (line 496), and reparks arena.current_addr (line 497) — cursor writes on the process-global arena (obtained via sfn_arena_global) whose buffers are aliased by all outstanding allocations. |
| `runtime/sfn/memory/arena.sfn` | 486-497 | `sfn_arena_sfn_rewind` | use-after-free | Every allocation made after the mark is logically freed while its payload pointers persist; rewound bytes are re-handed out by subsequent allocs, so stale pointers alias future allocations (a hardcoded mark of 0 on an enabled arena discards all page-0 allocations, per the module comment at lines 387-399). |

### string

Source: `runtime/sfn/string.sfn` — 14 sites (1 in-place-mutation, 4 use-after-free, 9 shared-mutable-alias).

| File | Lines | Symbol | Hazard | Notes |
|---|---|---|---|---|
| `runtime/sfn/string.sfn` | 159-161 | `sfn_str_sfn_slice` | use-after-free | **DEFERRED — #1283.** #1217 attempted `-> Slice` but a non-owning view over an immediate-codepoint pseudo-pointer (`(byte << 32)`, still produced in `sailfin_runtime.c`) is unsound; reverted to the allocating `* u8` / `substring_unchecked` body. A sound `slice -> Slice` is gated on retiring the immediate-pointer encoding (#822 / M1.A.2). The allocating body's arena-stranding hazard persists until then. |
| `runtime/sfn/string.sfn` | 170 | `sfn_str_sfn_to_cstr` | shared-mutable-alias | Identity return hands the string's own data pointer back as a C-string view — a second live raw handle to the same bytes, typically passed to externs that may retain it past the backing store's (arena) lifetime. |
| `runtime/sfn/string.sfn` | 179 | `sfn_str_sfn_from_cstr` | shared-mutable-alias | Adopts a foreign NUL-terminated C buffer as a Sailfin string without copying — the C-side owner and the Sailfin handle alias the same bytes with no ownership transfer. |
| `runtime/sfn/string.sfn` | 179 | `sfn_str_sfn_from_cstr` | use-after-free | The adopted buffer's lifetime stays with the foreign C caller; if the C side frees or reuses it, the Sailfin string handle reads freed memory. |
| `runtime/sfn/string.sfn` | 191-193 | `sfn_str_sfn_concat` | use-after-free | **RESOLVED — Phase R1 (#1217).** Migrated: `sfn_str_sfn_concat(a: *u8, b: *u8) -> OwnedBuf` now returns an `OwnedBuf` built via the global arena; the raw-* u8 strandable return is gone. Line numbers are stale (body rewritten). Hazard closed by ownership transfer. |
| `runtime/sfn/string.sfn` | 206-208 | `sfn_str_sfn_append` | in-place-mutation | **RESOLVED — Phase R1 (#1217).** Migrated: `sfn_str_sfn_append(buf: OwnedBuf, suffix_addr: i64, suffix_len: i64) -> OwnedBuf` is now a consume-and-return move; the grow-at-tip raw interior is behind `unsafe { }` in arena.sfn and reachable only through the unique `OwnedBuf` owner, so the in-place mutation is no longer reachable via an alias. Line numbers are stale. |
| `runtime/sfn/string.sfn` | 206-208 | `sfn_str_sfn_append` | use-after-free | **RESOLVED — Phase R1 (#1217).** The buf-is-CONSUMED contract is now enforced by the ownership checker (E5, #1214/#1215): the old binding is dead after the move-return; no caller-held stale copy can survive. Line numbers are stale. |
| `runtime/sfn/string.sfn` | 259-261 | `sfn_str_sfn_grapheme_at` | shared-mutable-alias | Verified: the C runtime returns the immediate-codepoint tagged pseudo-pointer itself for 1-byte clusters (sailfin_runtime.c comment 'returns the immediate pseudo-pointer itself at index 0') — a raw i8*-shaped value that is not a real allocation, so storing/dereferencing/freeing it as a pointer is unsound. |
| `runtime/sfn/string.sfn` | 306-308 | `sfn_str_sfn_from_codepoint` | shared-mutable-alias | Forwards a fresh _rt_malloc'd buffer (heap or global arena, per the C body) out as a raw * u8 with no tracked owner or free discipline at the Sailfin layer; callers cast/store it freely, so multiple untracked handles to one buffer can arise. |
| `runtime/sfn/string.sfn` | 319-321 | `sfn_str_sfn_from_byte` | shared-mutable-alias | Same pattern as from_codepoint — C-side _rt_malloc'd 1-byte NUL-terminated buffer returned as raw * u8 with untracked ownership; prelude's char_from_code casts and propagates it as string. |
| `runtime/sfn/string.sfn` | 330 | `sfn_str_sfn_to_number` | shared-mutable-alias | Newly found: hands the raw * u8 straight to libc strtod with no immediate-codepoint guard — the C runtime's own #716 audit comment flags this exact path as unguarded: a tagged (cp<<32) pseudo-pointer passes through and strtod dereferences an unrelated/unmapped address as if it owned those bytes. |
| `runtime/sfn/string.sfn` | 339-341 | `sfn_number_to_str_sfn` | shared-mutable-alias | Returns the legacy C number-to-string entrypoint's freshly allocated raw buffer (snprintf into stack buf then copy into a fresh _rt_malloc buffer) with no owner tracking at the Sailfin layer — same untracked raw-handle return pattern as the other allocating trampolines. |
| `runtime/sfn/string.sfn` | 351 | `sfn_int_to_str_sfn` | shared-mutable-alias | Forwards sfn_int_to_str's fresh NUL-terminated heap buffer (stack digit buffer copied into a fresh _rt_malloc allocation, per the C body) as a raw * u8 with untracked ownership across the extern boundary. |
| `runtime/sfn/string.sfn` | 396 | `sfn_to_debug_string` | shared-mutable-alias | Identity return gives the caller a second 'debug string' handle aliasing the input pointer's bytes — two live raw handles to the same buffer with divergent assumed lifetimes. |

### memory/rc

Source: `runtime/sfn/memory/rc.sfn` — 6 sites (3 in-place-mutation, 1 use-after-free, 2 shared-mutable-alias).

> **Phase R1 (#1218, E9 of #1209):** the raw allocation/header-init interior
> (`sfn_rc_sfn_alloc`) and the release-to-zero `free` (`sfn_rc_sfn_release`) are
> now wrapped in `unsafe { }` — the author-asserted raw region completing the
> memory-core migration after E8 (#1217). The release-to-zero `free` is bounded
> by the `prev == 1` last-reference proof (the structural analogue of the
> ownership checker's no-live-alias `E0903` proof). The atomic refcount header
> remains intentionally shared across handles by construction; `unsafe`
> acknowledges that raw region rather than eliminating the alias.

| File | Lines | Symbol | Hazard | Notes |
|---|---|---|---|---|
| `runtime/sfn/memory/rc.sfn` | 92-94 | `sfn_rc_sfn_alloc` | in-place-mutation | Initializes RcHeader fields (refcount=1 at line 93, drop_fn at line 94) by storing through the casted malloc pointer; buffer is fresh here but these same header bytes are later mutated through derived aliases by retain/release, so included conservatively. |
| `runtime/sfn/memory/rc.sfn` | 94 | `sfn_rc_sfn_alloc` | shared-mutable-alias | Stores the caller-supplied raw * u8 drop_fn address into the heap RcHeader struct — the header retains the pointer beyond the call, so caller and header are two live handles to the same code/data address. |
| `runtime/sfn/memory/rc.sfn` | 95 | `sfn_rc_sfn_alloc` | shared-mutable-alias | Returns the interior pointer header_ptr + 16 into the single malloc'd block; the bookkeeping header stays reachable from every payload handle via payload - 16 pointer arithmetic. |
| `runtime/sfn/memory/rc.sfn` | 107-109 | `sfn_rc_sfn_retain` | in-place-mutation | Derives an interior pointer (slots - 2, i.e. payload - 16) and atomic_add's the refcount word — a write through a header that is by construction referenced by every outstanding rc handle. |
| `runtime/sfn/memory/rc.sfn` | 121-123 | `sfn_rc_sfn_release` | in-place-mutation | Same derived interior pointer (slots - 2); atomic_sub mutates the shared refcount word in place while other handles to the allocation may be live. |
| `runtime/sfn/memory/rc.sfn` | 124 | `sfn_rc_sfn_release` | use-after-free | free(refcount_ptr as * u8) when prev == 1: the caller's payload pointer (and any miscounted alias) dangles after this call; drop_fn is stored but never invoked (confirmed — no call before free, deferred to M2.4/M2.6 per lines 34-39), so interior resources are stranded; freeing also assumes payload came from sfn_rc_sfn_alloc — an interior/foreign pointer corrupts the heap. |

### memory/mem

Source: `runtime/sfn/memory/mem.sfn` — 9 sites (3 in-place-mutation, 2 use-after-free, 4 shared-mutable-alias).

> **Phase R1 (#1218, E9 of #1209):** the raw interiors of `copy_bytes`
> (`memcpy`), `get_field` (safe-buffer `malloc` + zero-fill), `bounds_check`
> (`write`/`abort` failure path), `free` (libc `free`), and `sfn_alloc_struct`
> (arena `alloc`/`memset` + `calloc`) are now wrapped in `unsafe { }` — the
> author-asserted raw region completing the memory-core migration after E8
> (#1217). The fresh-allocation interiors (`get_field`, `sfn_alloc_struct`) are
> uniquely owned at the zero-fill, so the in-place writes are sound; the
> caller-supplied `copy_bytes`/`free` boundaries stay raw-by-contract under the
> descriptor ABI and `unsafe` marks them explicitly.

| File | Lines | Symbol | Hazard | Notes |
|---|---|---|---|---|
| `runtime/sfn/memory/mem.sfn` | 97-106 | `sfn_mem_get_field` | in-place-mutation | Zero-fill loop atomic_store's 8-byte words at buf + i (line 104, through a * i64 cast of ptr+offset into the lazily malloc'd 4096-byte safe buffer); buffer is fresh on first call but becomes the process-wide shared buffer, included conservatively (lazy init is also an unsynchronized check-then-write on the global: check at line 91, publish at line 107 — two racing first calls leak one buffer and publish the other). |
| `runtime/sfn/memory/mem.sfn` | 107 | `sfn_mem_get_field` | shared-mutable-alias | Stores the raw malloc'd buffer address into the mutable module global sfn_mem_get_field_buf_addr (i64-typed address, declared line 77), making the buffer reachable from global state for the process lifetime. |
| `runtime/sfn/memory/mem.sfn` | 109 | `sfn_mem_get_field` | shared-mutable-alias | Returns the same global safe-buffer pointer to every caller — all unresolved get_field results alias one mutable 4096-byte buffer; any write through one returned handle is visible through all others. |
| `runtime/sfn/memory/mem.sfn` | 120 | `sfn_mem_copy_bytes` | in-place-mutation | memcpy(dest, src, length) writes into the caller's existing dest buffer, which may be referenced elsewhere; no information about other live handles to dest. |
| `runtime/sfn/memory/mem.sfn` | 116-120 | `sfn_mem_copy_bytes` | shared-mutable-alias | dest and src are raw * u8 with only null/length guards (lines 117-119) and no overlap check — if the two ranges alias, memcpy is UB (memmove semantics needed); included conservatively since the descriptor ABI gives no aliasing guarantee. |
| `runtime/sfn/memory/mem.sfn` | 172 | `sfn_mem_free` | use-after-free | libc free(ptr) on a caller-supplied pointer (null-safe at line 170, arena-guarded at line 171); any alias retained by the caller or stored elsewhere dangles after this call. |
| `runtime/sfn/memory/mem.sfn` | 193-196 | `sfn_alloc_struct` | use-after-free | Arena path returns a slice of the process-global bump arena (sfn_arena_alloc on sfn_arena_global(), line 194); arena mark/rewind or bulk reclaim elsewhere invalidates the returned struct pointer while callers still hold it. |
| `runtime/sfn/memory/mem.sfn` | 195 | `sfn_alloc_struct` | in-place-mutation | memset(p, 0, size_bytes) writes into the uninitialised slice carved from a shared global arena page (buffer owned by the arena, not this function). |
| `runtime/sfn/memory/mem.sfn` | 194-196 | `sfn_alloc_struct` | shared-mutable-alias | Hands the global arena handle across the extern boundary (sfn_arena_alloc(sfn_arena_global(), ...) at line 194) and returns an interior pointer into arena-owned pages at line 196 — the same bytes are reachable both through the returned handle and through the arena (bulk reset/iteration); the descriptor's noalias return claim holds only for the calloc path (line 198). |

### array

Source: `runtime/sfn/array.sfn` — 11 sites (2 in-place-mutation, 2 use-after-free, 7 shared-mutable-alias).

> **Phase R1 (#1218, E9 of #1209):** the in-place push/grow and concat raw
> element-storage trampolines (`sfn_array_sfn_push_slot`,
> `sfn_array_sfn_push_string`, `sfn_array_sfn_concat`, routing through the `_v2`
> C entrypoints) are now wrapped in `unsafe { }` — the author-asserted raw
> region completing the memory-core migration after E8 (#1217). The in-place
> grow is sound under the caller's unique ownership of the array (no live
> alias — the #1205 hazard class). The remaining stubs (`create`/`push`/`slice`/
> `map`/`filter`/`reduce`) touch no raw storage. Element-storage soundness over
> aliased inputs lands with the arena-backed bodies (M3 per §2.1.1).

| File | Lines | Symbol | Hazard | Notes |
|---|---|---|---|---|
| `runtime/sfn/array.sfn` | 100-102 | `sfn_array_sfn_concat` | shared-mutable-alias | Hands raw array pointers a/b to extern sailfin_runtime_concat_v2; verified C body (sailfin_runtime.c:8722-8754) allocates a fresh SfnArray but shallow pointer-copies char* elements (buf[i]=adata[i]), so the result's elements alias the same string bytes as both inputs' elements; elem_size/arena params ignored until M3. |
| `runtime/sfn/array.sfn` | 111 | `sfn_array_sfn_slice` | shared-mutable-alias | Stub returns the input array pointer untouched as the 'slice' — caller gets a second live handle to the same SfnArray (full header, not a data view); the eventual SfnSlice contract is an interior-pointer view by design. |
| `runtime/sfn/array.sfn` | 128-130 | `sfn_array_sfn_push_string` | in-place-mutation | Trampolines to sailfin_runtime_append_string_v2; verified C body (sailfin_runtime.c:8808-8853) writes the new element into the existing backing buffer and bumps a->len/a->cap in place on an array whose buffer may be referenced elsewhere. |
| `runtime/sfn/array.sfn` | 128-130 | `sfn_array_sfn_push_string` | use-after-free | Grow path (max(cap*2, len+1, 8)) calls _rt_realloc(a->data, ...) at sailfin_runtime.c:8840; _rt_realloc (sailfin_runtime.c:784-790) is plain realloc in malloc mode, which frees/relocates the old block — any previously taken data/slot pointers into the old allocation go stale. |
| `runtime/sfn/array.sfn` | 128-130 | `sfn_array_sfn_push_string` | shared-mutable-alias | Callee retains the raw text pointer by storing it as the new char* element (((char**)a->data)[len] = text at sailfin_runtime.c:8850) — the array and the original holder of text now alias the same string bytes. |
| `runtime/sfn/array.sfn` | 142-144 | `sfn_array_sfn_push_slot` | in-place-mutation | Trampolines to sailfin_runtime_array_push_slot_v2; verified C body (sailfin_runtime.c:8855-8914) grows the buffer and writes new data/cap/len through *data_ptr/*cap_ptr/*len_ptr (8906-8912) — field updates on a struct whose buffer may be shared. |
| `runtime/sfn/array.sfn` | 142-144 | `sfn_array_sfn_push_slot` | use-after-free | Grow path calls _rt_realloc(*data_ptr, ...) at sailfin_runtime.c:8900 (plain realloc in malloc mode) and stores the new address through data_ptr — earlier slot/interior pointers into the old buffer, including slots returned by prior calls to this helper, go stale. |
| `runtime/sfn/array.sfn` | 142-144 | `sfn_array_sfn_push_slot` | shared-mutable-alias | Returns a raw interior pointer to the next writable slot (base + len*elem_size, sailfin_runtime.c:8910-8913); the caller stores through it while the array handle (data_ptr) also reaches the same bytes. |
| `runtime/sfn/array.sfn` | 165 | `sfn_array_sfn_map` | shared-mutable-alias | Stub returns the input array as the 'mapped' result — callers expecting a fresh array hold an alias of the input; mutating the result mutates the input (stub-by-design per #766, but the alias is real today). |
| `runtime/sfn/array.sfn` | 167 | `sfn_array_sfn_filter` | shared-mutable-alias | Stub returns the input array as the 'filtered' result — same aliasing as sfn_array_sfn_map: result handle and input handle reach the same bytes. |
| `runtime/sfn/array.sfn` | 169-171 | `sfn_array_sfn_reduce` | shared-mutable-alias | Stub returns the initial accumulator pointer unchanged as the fold result — caller binds the return as a second live handle aliasing its own accumulator (conservative include: weaker than map/filter since the caller already held the pointer). |

### concurrency/scheduler

Source: `runtime/sfn/concurrency/scheduler.sfn` — 56 sites (10 in-place-mutation, 16 use-after-free, 30 shared-mutable-alias).

| File | Lines | Symbol | Hazard | Notes |
|---|---|---|---|---|
| `runtime/sfn/concurrency/scheduler.sfn` | 271 | `sfn_taskqueue_create` | use-after-free | free(queue_ptr) on ring-alloc failure; local queue_ptr remains in scope (dangling) until the return on 272 |
| `runtime/sfn/concurrency/scheduler.sfn` | 275-276 | `sfn_taskqueue_create` | shared-mutable-alias | ring_ptr raw address stored into queue.tasks_addr (and queue_ptr/queue are two live typed views of the same handle) — ring reachable via local and struct field |
| `runtime/sfn/concurrency/scheduler.sfn` | 288-301 | `sfn_taskqueue_create` | shared-mutable-alias | interior pointers to embedded queue.mutex/not_empty/not_full fields handed across the pthread_*_init extern boundary (conservative: libpthread retention not provable) |
| `runtime/sfn/concurrency/scheduler.sfn` | 290-291 | `sfn_taskqueue_create` | use-after-free | free(ring_ptr); free(queue_ptr) on mutex-init failure while typed aliases queue/ring_ptr are still live in scope |
| `runtime/sfn/concurrency/scheduler.sfn` | 296-298 | `sfn_taskqueue_create` | use-after-free | pthread_mutex_destroy(queue.mutex) then free(ring_ptr)/free(queue_ptr) on not_empty cond-init failure (release + frees with live aliases) |
| `runtime/sfn/concurrency/scheduler.sfn` | 303-306 | `sfn_taskqueue_create` | use-after-free | cond/mutex destroy then free(ring_ptr)/free(queue_ptr) on not_full cond-init failure (release + frees with live aliases) |
| `runtime/sfn/concurrency/scheduler.sfn` | 320-322 | `sfn_taskqueue_destroy` | use-after-free | pthread_cond_destroy x2 + pthread_mutex_destroy release embedded handles; any producer/consumer still blocked on them is UAF (no guard beyond doc comment) |
| `runtime/sfn/concurrency/scheduler.sfn` | 324-325 | `sfn_taskqueue_destroy` | use-after-free | free of the ring buffer read back from q.tasks_addr; any task addresses still in undequeued slots are stranded and unreachable afterward |
| `runtime/sfn/concurrency/scheduler.sfn` | 326 | `sfn_taskqueue_destroy` | use-after-free | free(queue) — caller's handle plus any scheduler holding this address in queue_addr (see sfn_scheduler_create:693) dangles after this call |
| `runtime/sfn/concurrency/scheduler.sfn` | 338-360 | `sfn_taskqueue_enqueue` | shared-mutable-alias | interior pointers to embedded q.mutex/q.not_full/q.not_empty handed to pthread lock/wait/signal/unlock externs |
| `runtime/sfn/concurrency/scheduler.sfn` | 348-349 | `sfn_taskqueue_enqueue` | in-place-mutation | atomic_store through computed ptr+offset (q.tasks_addr + q.tail*8) into the shared MPMC ring buffer |
| `runtime/sfn/concurrency/scheduler.sfn` | 349 | `sfn_taskqueue_enqueue` | shared-mutable-alias | task raw address stored into a ring slot — task now reachable by the producer's handle, the ring, and any future consumer (three live handles) |
| `runtime/sfn/concurrency/scheduler.sfn` | 351-354 | `sfn_taskqueue_enqueue` | in-place-mutation | q.tail/q.count cursor field updates on the TaskQueue struct shared across producer and consumer threads (mutex-guarded) |
| `runtime/sfn/concurrency/scheduler.sfn` | 371-389 | `sfn_taskqueue_dequeue` | shared-mutable-alias | interior pointers to embedded q.mutex/q.not_empty/q.not_full handed to pthread lock/wait/signal/unlock externs |
| `runtime/sfn/concurrency/scheduler.sfn` | 380-381 | `sfn_taskqueue_dequeue` | shared-mutable-alias | ring slot is read but never cleared — a stale copy of the task address persists in the buffer after ownership moves to the consumer (dangling once the task is freed) |
| `runtime/sfn/concurrency/scheduler.sfn` | 383-386 | `sfn_taskqueue_dequeue` | in-place-mutation | q.head/q.count cursor field updates on the shared TaskQueue struct (mutex-guarded) |
| `runtime/sfn/concurrency/scheduler.sfn` | 391 | `sfn_taskqueue_dequeue` | shared-mutable-alias | returns the dequeued raw task address as * u8 while the producer that enqueued it still holds the same address (two live mutable handles) |
| `runtime/sfn/concurrency/scheduler.sfn` | 400-402 | `sfn_taskqueue_count` | shared-mutable-alias | interior pointer to embedded q.mutex handed to pthread_mutex_lock/unlock externs (conservative) |
| `runtime/sfn/concurrency/scheduler.sfn` | 454-457 | `sfn_scheduler_resolve_thread_count` | shared-mutable-alias | Sailfin string buffer cast to * u8 handed to getenv; returned raw pointer aliases libc-owned environ storage (invalidated by setenv) and is passed on to atoi |
| `runtime/sfn/concurrency/scheduler.sfn` | 512-513 | `sfn_task_create` | shared-mutable-alias | raw fn_ptr code address and raw ctx address stored into Task fields — ctx buffer now reachable via the producer's original handle and the Task, later via worker threads |
| `runtime/sfn/concurrency/scheduler.sfn` | 517-522 | `sfn_task_create` | shared-mutable-alias | interior pointers to embedded task.mutex/task.cond fields handed across the pthread_*_init extern boundary |
| `runtime/sfn/concurrency/scheduler.sfn` | 519 | `sfn_task_create` | use-after-free | free(task_ptr) on mutex-init failure while typed alias task is still live in scope |
| `runtime/sfn/concurrency/scheduler.sfn` | 524-525 | `sfn_task_create` | use-after-free | pthread_mutex_destroy(task.mutex) then free(task_ptr) on cond-init failure (release + free with live typed alias) |
| `runtime/sfn/concurrency/scheduler.sfn` | 537-538 | `sfn_task_destroy` | use-after-free | pthread_cond_destroy/pthread_mutex_destroy release embedded handles; UAF if a worker or joiner still touches the task — guarded only by a doc-comment obligation (532-533) |
| `runtime/sfn/concurrency/scheduler.sfn` | 539 | `sfn_task_destroy` | use-after-free | free(task) — producer handle, any worker copy, and the stale uncleaned ring-slot copy (dequeue:380) all dangle after this |
| `runtime/sfn/concurrency/scheduler.sfn` | 554-556 | `sfn_task_run` | shared-mutable-alias | t.fn_ptr cast from i64 to a C-ABI function pointer and invoked with t.ctx as raw * u8 — ctx crosses an indirect-call boundary where the callee may retain it |
| `runtime/sfn/concurrency/scheduler.sfn` | 564-566 | `sfn_task_run` | shared-mutable-alias | manufactures a second typed view (* i64 done_slot) into Task.done via ptrtoint+add+inttoptr while the * Task view t is simultaneously live |
| `runtime/sfn/concurrency/scheduler.sfn` | 568 | `sfn_task_run` | in-place-mutation | t.result store into the Task struct concurrently aliased by the producer parked in sfn_task_join (mutex-guarded) |
| `runtime/sfn/concurrency/scheduler.sfn` | 568 | `sfn_task_run` | shared-mutable-alias | raw worker-returned result pointer stored as i64 into Task.result — result buffer becomes reachable via worker local, the Task, and later the join caller |
| `runtime/sfn/concurrency/scheduler.sfn` | 569 | `sfn_task_run` | in-place-mutation | atomic_store(done_slot, 1) writes through the computed ptr+offset into the cross-thread shared Task |
| `runtime/sfn/concurrency/scheduler.sfn` | 567-571 | `sfn_task_run` | shared-mutable-alias | interior pointers to embedded t.mutex/t.cond handed to pthread lock/signal/unlock externs |
| `runtime/sfn/concurrency/scheduler.sfn` | 589-591 | `sfn_task_join` | shared-mutable-alias | manufactures a second typed view (* i64 done_slot) into Task.done via ptrtoint+add+inttoptr alongside the live * Task view t |
| `runtime/sfn/concurrency/scheduler.sfn` | 593-599 | `sfn_task_join` | shared-mutable-alias | interior pointers to embedded t.mutex/t.cond handed to pthread lock/wait/unlock externs |
| `runtime/sfn/concurrency/scheduler.sfn` | 598-600 | `sfn_task_join` | shared-mutable-alias | returns Task.result reconstituted as raw * u8 while the same address persists in Task.result — caller and Task alias the worker-produced buffer |
| `runtime/sfn/concurrency/scheduler.sfn` | 613-615 | `sfn_scheduler_worker` | shared-mutable-alias | worker thread uses a raw task address (pulled from the queue) that the spawning producer concurrently retains for sfn_task_join/sfn_task_destroy |
| `runtime/sfn/concurrency/scheduler.sfn` | 632-636 | `sfn_scheduler_next_task` | shared-mutable-alias | three live typed views of the scheduler bytes (* u8 arg, * Scheduler sched, * i64 shutdown_slot) plus a * TaskQueue alias re-materialized from raw sched.queue_addr |
| `runtime/sfn/concurrency/scheduler.sfn` | 638-663 | `sfn_scheduler_next_task` | shared-mutable-alias | interior pointers to embedded q.mutex/q.not_empty/q.not_full handed to pthread lock/wait/signal/unlock externs |
| `runtime/sfn/concurrency/scheduler.sfn` | 649-650 | `sfn_scheduler_next_task` | shared-mutable-alias | ring slot read but never cleared — stale copy of the task address persists in the buffer after the worker takes ownership (dangling once the task is freed) |
| `runtime/sfn/concurrency/scheduler.sfn` | 652-655 | `sfn_scheduler_next_task` | in-place-mutation | q.head/q.count cursor field updates on the TaskQueue shared by all workers and producers (mutex-guarded) |
| `runtime/sfn/concurrency/scheduler.sfn` | 658 | `sfn_scheduler_next_task` | in-place-mutation | plain read-modify-write of sched.processed on the Scheduler struct aliased by every worker thread (race-free only because it is under the queue mutex) |
| `runtime/sfn/concurrency/scheduler.sfn` | 665 | `sfn_scheduler_next_task` | shared-mutable-alias | returns the pulled raw task address as * u8 while the producer retains the same address for join/destroy (two live mutable handles) |
| `runtime/sfn/concurrency/scheduler.sfn` | 685 | `sfn_scheduler_create` | use-after-free | free(sched_ptr) on thread-array malloc failure; local sched_ptr stays in scope until the return on 686 |
| `runtime/sfn/concurrency/scheduler.sfn` | 691-693 | `sfn_scheduler_create` | shared-mutable-alias | threads_ptr and caller-owned queue raw addresses stored into Scheduler.threads_addr/queue_addr — queue becomes aliased by the caller, the scheduler, and every worker thread |
| `runtime/sfn/concurrency/scheduler.sfn` | 701 | `sfn_scheduler_create` | shared-mutable-alias | function reference sfn_scheduler_worker materialized as a raw * u8 data pointer, later retained by pthread_create as each thread's start_routine |
| `runtime/sfn/concurrency/scheduler.sfn` | 703-704 | `sfn_scheduler_create` | use-after-free | free(threads_ptr); free(sched_ptr) on the null-start guard while typed alias sched (with threads_addr already stored) is live in scope |
| `runtime/sfn/concurrency/scheduler.sfn` | 711-712 | `sfn_scheduler_create` | in-place-mutation | pthread_create writes a pthread_t through the computed tid_slot ptr+offset into the threads array the scheduler also aliases via threads_addr |
| `runtime/sfn/concurrency/scheduler.sfn` | 712 | `sfn_scheduler_create` | shared-mutable-alias | sched_ptr handed to pthread_create as the worker arg — each spawned thread retains the raw scheduler pointer for its lifetime (definite cross-boundary retention) |
| `runtime/sfn/concurrency/scheduler.sfn` | 718 | `sfn_scheduler_create` | in-place-mutation | sched.thread_count shrunk on partial spin-up failure while already-launched worker threads share the same Scheduler struct |
| `runtime/sfn/concurrency/scheduler.sfn` | 718-721 | `sfn_scheduler_create` | use-after-free | failure-path sfn_scheduler_shutdown + sfn_scheduler_destroy frees sched_ptr; locals sched/sched_ptr/threads_ptr remain in scope (dangling) until the return on 721 |
| `runtime/sfn/concurrency/scheduler.sfn` | 726 | `sfn_scheduler_create` | shared-mutable-alias | MISSED BY FIRST PASS: returns sched_ptr as * u8 while every spawned worker retains the identical raw scheduler address (pthread_create arg, 712) and concurrently mutates the struct — caller and workers hold live mutable handles |
| `runtime/sfn/concurrency/scheduler.sfn` | 743-745 | `sfn_scheduler_shutdown` | shared-mutable-alias | dual typed views of the scheduler (* Scheduler sched and * i64 shutdown_slot) plus a * TaskQueue alias re-materialized from raw sched.queue_addr |
| `runtime/sfn/concurrency/scheduler.sfn` | 747-751 | `sfn_scheduler_shutdown` | shared-mutable-alias | interior pointers to embedded q.mutex/q.not_empty/q.not_full handed to pthread lock/broadcast/unlock externs |
| `runtime/sfn/concurrency/scheduler.sfn` | 748 | `sfn_scheduler_shutdown` | in-place-mutation | atomic_store(shutdown_slot, 1) writes the Scheduler.shutdown flag through the aliased base pointer while worker threads concurrently atomic_load it |
| `runtime/sfn/concurrency/scheduler.sfn` | 756-757 | `sfn_scheduler_shutdown` | shared-mutable-alias | MISSED BY FIRST PASS: manufactures a * i64 tid_slot interior view into the pthread_t array via ptr+offset from raw sched.threads_addr (second live handle alongside the threads_addr field) and atomic_loads each tid for pthread_join |
| `runtime/sfn/concurrency/scheduler.sfn` | 772-773 | `sfn_scheduler_destroy` | use-after-free | free of the pthread_t array read back from sched.threads_addr; relies on caller having shutdown first — a running pool would UAF in pthread_join/worker paths |
| `runtime/sfn/concurrency/scheduler.sfn` | 774 | `sfn_scheduler_destroy` | use-after-free | free(scheduler) — caller handle and any not-yet-exited worker's retained arg pointer (create:712) dangle; the doc comment (766-768) itself flags the UAF if shutdown was skipped |

### concurrency/channel

Source: `runtime/sfn/concurrency/channel.sfn` — 22 sites (6 in-place-mutation, 3 use-after-free, 13 shared-mutable-alias).

| File | Lines | Symbol | Hazard | Notes |
|---|---|---|---|---|
| `runtime/sfn/concurrency/channel.sfn` | 132-139 | `sfn_channel_create` | shared-mutable-alias | Raw malloc'd buffer address stored as i64 into ch.buffer_addr (line 139) — buffer reachable via both the buf_ptr local and the channel struct field for the channel's lifetime |
| `runtime/sfn/concurrency/channel.sfn` | 133-136 | `sfn_channel_create` | use-after-free | free(ch_ptr) at line 134 on buffer-malloc failure; the ch_ptr local stays in scope as a stale handle (unused after, but unchecked) before returning the null buf_ptr |
| `runtime/sfn/concurrency/channel.sfn` | 148-151 | `sfn_channel_create` | in-place-mutation | atomic_store(closed_slot, 0) through a hand-computed offset pointer (ch_ptr + _sfn_channel_closed_offset() = +184) to initialize the closed flag |
| `runtime/sfn/concurrency/channel.sfn` | 148-151 | `sfn_channel_create` | shared-mutable-alias | closed_slot (* i64 at ch_ptr+184) aliases the declared Channel.closed field reachable via the typed `ch` view from line 138 — two typed views of the same bytes, offset constant hand-maintained against struct layout |
| `runtime/sfn/concurrency/channel.sfn` | 153-173 | `sfn_channel_create` | shared-mutable-alias | Interior pointers ch.mutex / ch.not_empty / ch.not_full handed across the extern boundary to pthread_mutex_init / pthread_cond_init (lines 153, 159, 166); libpthread writes through them and the addresses must stay stable for the channel lifetime |
| `runtime/sfn/concurrency/channel.sfn` | 153-173 | `sfn_channel_create` | use-after-free | Error-path free(buf_ptr)/free(ch_ptr) after partial pthread init (lines 155-156, 162-163, 170-171); the typed alias `ch` and closed_slot remain in scope pointing at freed memory (unused after, but unchecked) |
| `runtime/sfn/concurrency/channel.sfn` | 187-194 | `sfn_channel_send` | shared-mutable-alias | Re-derives closed_slot via offset arithmetic (ch+184, lines 187-189) aliasing the c.closed struct field for the atomic_load reads at lines 194 and 202 |
| `runtime/sfn/concurrency/channel.sfn` | 191-220 | `sfn_channel_send` | shared-mutable-alias | Interior pointers c.mutex / c.not_full / c.not_empty handed across the extern boundary to pthread_mutex_lock/cond_wait/cond_signal/unlock; pthread_cond_wait (line 206) parks the thread while libpthread retains and writes through both addresses (missed by first pass, which flagged only the init calls) |
| `runtime/sfn/concurrency/channel.sfn` | 210-212 | `sfn_channel_send` | in-place-mutation | memcpy of elem_size bytes into the tail slot of the shared circular buffer through the interior pointer (c.buffer_addr + slot_offset) |
| `runtime/sfn/concurrency/channel.sfn` | 210-211 | `sfn_channel_send` | shared-mutable-alias | Forms interior pointer slot_ptr into the shared element buffer from the raw i64 buffer_addr field — buffer simultaneously reachable from every thread holding the channel handle |
| `runtime/sfn/concurrency/channel.sfn` | 214-217 | `sfn_channel_send` | in-place-mutation | c.tail / c.count cursor and count updates on the shared Channel struct (mutex-guarded, visible to all handle holders) |
| `runtime/sfn/concurrency/channel.sfn` | 233-242 | `sfn_channel_recv` | shared-mutable-alias | Re-derives closed_slot via offset arithmetic (ch+184, lines 233-235) aliasing the c.closed struct field for the atomic_load read at line 242 |
| `runtime/sfn/concurrency/channel.sfn` | 237-263 | `sfn_channel_recv` | shared-mutable-alias | Interior pointers c.mutex / c.not_empty / c.not_full handed across the extern boundary to pthread_mutex_lock/cond_wait/cond_signal/unlock; pthread_cond_wait (line 246) parks while libpthread retains both addresses (missed by first pass) |
| `runtime/sfn/concurrency/channel.sfn` | 250-255 | `sfn_channel_recv` | shared-mutable-alias | Interior pointer slot_ptr into the shared buffer read by memcpy (line 254); the slot's bytes become re-writable by senders the moment head advances (safe only under the mutex contract) |
| `runtime/sfn/concurrency/channel.sfn` | 257-260 | `sfn_channel_recv` | in-place-mutation | c.head / c.count cursor and count updates on the shared Channel struct |
| `runtime/sfn/concurrency/channel.sfn` | 252-264 | `sfn_channel_recv` | shared-mutable-alias | Returns a freshly malloc'd raw * u8 element copy; the free obligation transfers untracked to the caller (manual-free surface; leak or double-free is unchecked). Included conservatively — fresh exclusive allocation, but raw ownership handoff across the return boundary |
| `runtime/sfn/concurrency/channel.sfn` | 275-277 | `sfn_channel_close` | shared-mutable-alias | Re-derives closed_slot via offset arithmetic (ch+184) aliasing the c.closed struct field — same hand-maintained offset alias pattern as send/recv (missed by first pass, which flagged only the store) |
| `runtime/sfn/concurrency/channel.sfn` | 280 | `sfn_channel_close` | in-place-mutation | atomic_store(closed_slot, 1) through the hand-computed offset alias of c.closed while concurrent senders/receivers read the same word via their own derived aliases |
| `runtime/sfn/concurrency/channel.sfn` | 279-283 | `sfn_channel_close` | shared-mutable-alias | Interior pointers c.mutex / c.not_empty / c.not_full handed across the extern boundary to pthread_mutex_lock/cond_broadcast/unlock; broadcasts wake parked threads that hold the same addresses (missed by first pass) |
| `runtime/sfn/concurrency/channel.sfn` | 293-298 | `sfn_channel_destroy` | use-after-free | Destroys conds/mutex through interior pointers (293-295) then free()s the element buffer via c.buffer_addr (297) and the channel handle (298); relies on a documentation-only contract that no thread still holds or is blocked on the handle — any concurrent send/recv/close dereferences freed memory; `c` and buf_addr locals stale after |
| `runtime/sfn/concurrency/channel.sfn` | 331-339 | `sfn_spawn_task` | in-place-mutation | atomic_store writes at base+0/8/16/24 into the Task allocation via hand-computed offsets that duplicate scheduler.sfn's 120-byte Task layout (silent corruption if layouts drift) |
| `runtime/sfn/concurrency/channel.sfn` | 325-341 | `sfn_spawn_task` | shared-mutable-alias | Stores raw fn_ptr address as i64 into the Task's fn slot (line 336) and returns the raw task handle with no ownership/free path; if a scheduler later enqueues it, scheduler and caller share the same mutable Task bytes (v0 code never enqueues — handle leaks unless caller frees) |

### concurrency/parallel

Source: `runtime/sfn/concurrency/parallel.sfn` — 9 sites (2 in-place-mutation, 2 use-after-free, 5 shared-mutable-alias).

| File | Lines | Symbol | Hazard | Notes |
|---|---|---|---|---|
| `runtime/sfn/concurrency/parallel.sfn` | 72-74 | `_sfn_parallel_drain` | shared-mutable-alias | Loads raw i64 task addresses from the futures array and rematerializes them as * u8 handles handed across the extern boundary to sfn_await. CORRECTED: first pass called this use-after-free claiming sfn_await frees the future — false; sfn_await is a thin wrapper over sfn_task_join (scheduler.sfn:581-601) which never frees. Real hazard: untracked handle ownership (sfn_task_destroy is never called — handles leak) |
| `runtime/sfn/concurrency/parallel.sfn` | 122-132 | `sfn_parallel` | shared-mutable-alias | Loads raw fn/ctx addresses from caller-owned i64 arrays and hands them to sfn_spawn; spawned workers retain ctx (stored into the Task, later invoked as fn_ptr(ctx)) and read caller memory concurrently for the duration of fan-out/join |
| `runtime/sfn/concurrency/parallel.sfn` | 132-135 | `sfn_parallel` | shared-mutable-alias | Raw future-handle address (future as i64) stored into the heap futures scratch array — handle reachable via both the local and the array slot |
| `runtime/sfn/concurrency/parallel.sfn` | 134-135 | `sfn_parallel` | in-place-mutation | atomic_store to (futures_base + i*8) — store through hand-computed ptr+offset into the scratch array (exclusive buffer; included conservatively since all access is raw address arithmetic) |
| `runtime/sfn/concurrency/parallel.sfn` | 142-149 | `sfn_parallel` | use-after-free | results-malloc failure path: drains futures then free(futures) at line 148; futures/futures_base locals go stale in scope. CORRECTED: sfn_await does NOT free the handles (first pass claimed it does) — the task handles themselves leak, and awaited worker results are discarded |
| `runtime/sfn/concurrency/parallel.sfn` | 158-161 | `sfn_parallel` | shared-mutable-alias | Join loop rematerializes raw i64 future addresses from the array as * u8 handles passed to sfn_await. CORRECTED: first pass classified this use-after-free on the premise that sfn_await consumes/frees each future — false (sfn_task_join only blocks and reads); the handles stay live and are never destroyed (leak), so the hazard is the untracked raw-handle aliasing, not UAF |
| `runtime/sfn/concurrency/parallel.sfn` | 163-164 | `sfn_parallel` | in-place-mutation | atomic_store of raw result addresses into the results array via hand-computed ptr+offset (results_base + j*8) |
| `runtime/sfn/concurrency/parallel.sfn` | 169 | `sfn_parallel` | use-after-free | free(futures) after the join; futures/futures_base locals remain in scope as dangling addresses (unused after, but unchecked), and the live task handles stored in the freed slots become unreachable (leak — sfn_task_destroy is never called) |
| `runtime/sfn/concurrency/parallel.sfn` | 161-170 | `sfn_parallel` | shared-mutable-alias | Returns the malloc'd results array of raw worker-result addresses; caller owns/frees the array and each slot aliases worker-allocated memory whose ownership is implicit and untracked |

### concurrency/serve

Source: `runtime/sfn/concurrency/serve.sfn` — 28 sites (9 in-place-mutation, 12 use-after-free, 7 shared-mutable-alias).

| File | Lines | Symbol | Hazard | Notes |
|---|---|---|---|---|
| `runtime/sfn/concurrency/serve.sfn` | 127-130 | `_serve_ptr_off` | shared-mutable-alias | Returns a raw interior pointer (base+off) into a caller-owned buffer; every call site materializes a second live handle to the same bytes |
| `runtime/sfn/concurrency/serve.sfn` | 140-141 | `_serve_uint_to_str` | in-place-mutation | memset stores through _serve_ptr_off interior pointers into the 2-byte zero-case buffer (fresh allocation, single owner — included conservatively as ptr+offset stores) |
| `runtime/sfn/concurrency/serve.sfn` | 153-159 | `_serve_uint_to_str` | in-place-mutation | NUL memset (153) and per-digit memset (159) at computed byte offsets into the freshly malloc'd decimal buffer (fresh allocation — conservative include) |
| `runtime/sfn/concurrency/serve.sfn` | 170-174 | `_serve_append` | in-place-mutation | memcpy (172) of NUL-terminated src into the existing caller-owned dst buffer at byte offset off (dst is aliased by the caller across repeated appends) |
| `runtime/sfn/concurrency/serve.sfn` | 183 | `_serve_send_all` | shared-mutable-alias | Hands the interior pointer buf+sent to extern send on every retry iteration — raw pointer across the libc boundary (kernel only reads; conservative include, missed by first pass) |
| `runtime/sfn/concurrency/serve.sfn` | 211-219 | `_serve_recv_request` | in-place-mutation | Grow-by-doubling realloc of the request buffer (grow-at-tip path with capacity bookkeeping in locals) |
| `runtime/sfn/concurrency/serve.sfn` | 213-218 | `_serve_recv_request` | use-after-free | realloc may relocate the buffer; the pre-realloc buf address is stale after success — rebound locally at 218, but any previously derived _serve_ptr_off interior pointer would dangle |
| `runtime/sfn/concurrency/serve.sfn` | 215 | `_serve_recv_request` | use-after-free | free(buf) on the realloc-OOM path (buf must not be touched afterward; function returns null) |
| `runtime/sfn/concurrency/serve.sfn` | 221 | `_serve_recv_request` | in-place-mutation | recv writes up to chunk bytes into the existing request buffer through the interior pointer buf+len |
| `runtime/sfn/concurrency/serve.sfn` | 223 | `_serve_recv_request` | use-after-free | free(buf) on the recv-error path (n < 0) |
| `runtime/sfn/concurrency/serve.sfn` | 228 | `_serve_recv_request` | in-place-mutation | Per-chunk NUL-terminator memset at buf+len into the live request buffer |
| `runtime/sfn/concurrency/serve.sfn` | 234 | `_serve_recv_request` | use-after-free | free(buf) on the 64 KiB header-cap rejection path (slow-loris guard) |
| `runtime/sfn/concurrency/serve.sfn` | 238 | `_serve_recv_request` | in-place-mutation | Final NUL memset at buf+len before transferring buffer ownership to the caller |
| `runtime/sfn/concurrency/serve.sfn` | 262 | `_serve_send_response` | use-after-free | free(clen) on the response-buffer malloc-OOM path |
| `runtime/sfn/concurrency/serve.sfn` | 266-270 | `_serve_send_response` | in-place-mutation | Assembles the HTTP response in the malloc'd resp buffer via four _serve_append memcpys at advancing offsets (266-269) plus a final NUL memset (270) |
| `runtime/sfn/concurrency/serve.sfn` | 271 | `_serve_send_response` | use-after-free | free(clen) after the Content-Length string is copied into resp |
| `runtime/sfn/concurrency/serve.sfn` | 274 | `_serve_send_response` | use-after-free | free(resp) after _serve_send_all; resp must not escape (it does not, but nothing enforces that) |
| `runtime/sfn/concurrency/serve.sfn` | 284-288 | `sfn_serve_handler_dispatch` | shared-mutable-alias | Casts the effect-erased i8* handler to a fn pointer (286) and hands the raw request buffer pointer to user code (287), which may retain it past the worker's later free(request) |
| `runtime/sfn/concurrency/serve.sfn` | 306-310 | `_serve_conn_worker` | shared-mutable-alias | Reinterprets the ctx bytes as two * i64 slots (fd_slot, handler_slot) — second and third typed handles to the same 16-byte heap pair |
| `runtime/sfn/concurrency/serve.sfn` | 311 | `_serve_conn_worker` | use-after-free | free(ctx) frees the pair malloc'd by sfn_serve on another thread; the Task.ctx field still holds its address, so any task re-run or later Task.ctx read dangles |
| `runtime/sfn/concurrency/serve.sfn` | 324 | `_serve_conn_worker` | use-after-free | free(request) after the user handler received the pointer at line 321; a handler that retained the request pointer beyond return is left with a dangling alias (an interior response pointer is only safe because send at 322 precedes the free) |
| `runtime/sfn/concurrency/serve.sfn` | 351-362 | `_serve_bind_listen` | in-place-mutation | memset stores building sockaddr_in fields at fixed byte offsets in the fresh 16-byte addr buffer (fresh allocation, single owner — conservative include) |
| `runtime/sfn/concurrency/serve.sfn` | 365 | `_serve_bind_listen` | use-after-free | free(addr) immediately after bind(fd, addr, 16) at 364; safe only because bind does not retain the sockaddr pointer |
| `runtime/sfn/concurrency/serve.sfn` | 392 | `sfn_serve` | shared-mutable-alias | sfn_scheduler_create(queue) retains the queue address internally while sfn_serve keeps its own live handle and mutates through it at the enqueue (422) — two live cross-thread handles to the queue (missed by first pass) |
| `runtime/sfn/concurrency/serve.sfn` | 395 | `sfn_serve` | use-after-free | sfn_taskqueue_destroy(queue) on the scheduler-create failure path; queue was already passed to sfn_scheduler_create (line 392), which may have partially retained it before failing |
| `runtime/sfn/concurrency/serve.sfn` | 410-413 | `sfn_serve` | shared-mutable-alias | Packs client_fd and the raw handler code-pointer address into the heap conn_ctx pair via recast * i64 slots, destined for another thread |
| `runtime/sfn/concurrency/serve.sfn` | 415-422 | `sfn_serve` | shared-mutable-alias | conn_ctx and task raw addresses handed to sfn_task_create / sfn_taskqueue_enqueue (callees retain them); ctx is freed later by the worker thread, and Task handles are fire-and-forget — never joined or destroyed (documented 120-byte leak per connection) |
| `runtime/sfn/concurrency/serve.sfn` | 418 | `sfn_serve` | use-after-free | free(conn_ctx) when sfn_task_create fails; conn_ctx's address was already passed as i64 to sfn_task_create at 416 — safe only if the failed create retained nothing (conservative include) |

### concurrency/future

Source: `runtime/sfn/concurrency/future.sfn` — 24 sites (0 in-place-mutation, 7 use-after-free, 17 shared-mutable-alias).

| File | Lines | Symbol | Hazard | Notes |
|---|---|---|---|---|
| `runtime/sfn/concurrency/future.sfn` | 99-111 | `_sfn_ensure_scheduler` | shared-mutable-alias | Stores raw queue/scheduler heap addresses into mutable module globals _sfn_g_queue_addr/_sfn_g_sched_addr (lines 104, 108) while sfn_scheduler_create (106) also retains the queue; unsynchronized lazy init relies on the first-spawn-before-pool argument |
| `runtime/sfn/concurrency/future.sfn` | 119-128 | `sfn_spawn` | shared-mutable-alias | Task address is both enqueued on the shared MPMC queue at 126 (a pool worker will mutate the Task) and returned to the caller as the future at 127 — two live mutable cross-thread handles to the same bytes |
| `runtime/sfn/concurrency/future.sfn` | 123 | `sfn_spawn` | shared-mutable-alias | Raw ctx address handed to sfn_task_create, which retains it in the Task.ctx struct field while the spawning caller (and every ctx-spawn wrapper's user ctx) still holds the same address — the single choke point storing all ctx pairs into Task state (missed by first pass) |
| `runtime/sfn/concurrency/future.sfn` | 132 | `sfn_await` | use-after-free | Conservative: sfn_task_join may consume/release Task state while the caller still holds the future pointer; a second await or later use of the future would touch released state (Task lifetime contract lives in scheduler.sfn, not visible here) |
| `runtime/sfn/concurrency/future.sfn` | 150-156 | `_sfn_trampoline_number_ctx` | shared-mutable-alias | Recasts the heap pair as two * i64 slots (151-152) and forwards the raw user_ctx pointer to the spawned fn (156) while the spawning thread may still hold it |
| `runtime/sfn/concurrency/future.sfn` | 158 | `_sfn_trampoline_number_ctx` | use-after-free | free(ctx) frees the [fn_ptr][user_ctx] pair whose address remains stored in Task.ctx; the never-destroyed Task carries a dangling ctx address afterward |
| `runtime/sfn/concurrency/future.sfn` | 168-175 | `sfn_spawn_number_ctx` | shared-mutable-alias | Stores raw fn_ptr and user ctx addresses into a malloc'd pair (atomic_store at 172-173) handed across the thread boundary via Task.ctx; user ctx becomes aliased by spawner and worker threads |
| `runtime/sfn/concurrency/future.sfn` | 195-201 | `_sfn_trampoline_int_ctx` | shared-mutable-alias | Recasts the heap pair as two * i64 slots (196-197) and forwards the raw user_ctx pointer to the spawned fn (201) while the spawning thread may still hold it |
| `runtime/sfn/concurrency/future.sfn` | 202 | `_sfn_trampoline_int_ctx` | use-after-free | free(ctx) frees the [fn_ptr][user_ctx] pair whose address remains stored in Task.ctx (dangling for the Task's remaining lifetime) |
| `runtime/sfn/concurrency/future.sfn` | 212-219 | `sfn_spawn_int_ctx` | shared-mutable-alias | Stores raw fn_ptr and user ctx addresses into a malloc'd pair (atomic_store at 216-217) handed across the thread boundary via Task.ctx; user ctx aliased by spawner and worker |
| `runtime/sfn/concurrency/future.sfn` | 239-245 | `_sfn_trampoline_bool_ctx` | shared-mutable-alias | Recasts the heap pair as two * i64 slots (240-241) and forwards the raw user_ctx pointer to the spawned fn (245) while the spawning thread may still hold it |
| `runtime/sfn/concurrency/future.sfn` | 246 | `_sfn_trampoline_bool_ctx` | use-after-free | free(ctx) frees the [fn_ptr][user_ctx] pair whose address remains stored in Task.ctx (dangling for the Task's remaining lifetime) |
| `runtime/sfn/concurrency/future.sfn` | 257-264 | `sfn_spawn_bool_ctx` | shared-mutable-alias | Stores raw fn_ptr and user ctx addresses into a malloc'd pair (atomic_store at 261-262) handed across the thread boundary via Task.ctx; user ctx aliased by spawner and worker |
| `runtime/sfn/concurrency/future.sfn` | 277-281 | `_sfn_trampoline_ptr` | shared-mutable-alias | Returns the user fn's raw * u8 result (280), which is stored in Task.result on the worker thread and later handed to the awaiting thread — producer and consumer alias the same bytes with no ownership contract |
| `runtime/sfn/concurrency/future.sfn` | 284-292 | `_sfn_trampoline_ptr_ctx` | shared-mutable-alias | Recasts the heap pair as two * i64 slots (285-286), forwards the raw user_ctx pointer to the spawned fn (290), and forwards the fn's raw pointer result across threads via Task.result (292) |
| `runtime/sfn/concurrency/future.sfn` | 291 | `_sfn_trampoline_ptr_ctx` | use-after-free | free(ctx) frees the [fn_ptr][user_ctx] pair whose address remains stored in Task.ctx (dangling for the Task's remaining lifetime) |
| `runtime/sfn/concurrency/future.sfn` | 301-308 | `sfn_spawn_ptr_ctx` | shared-mutable-alias | Stores raw fn_ptr and user ctx addresses into a malloc'd pair (atomic_store at 305-306) handed across the thread boundary via Task.ctx; user ctx aliased by spawner and worker |
| `runtime/sfn/concurrency/future.sfn` | 324-330 | `_sfn_trampoline_void_ctx` | shared-mutable-alias | Recasts the heap pair as two * i64 slots (325-326) and forwards the raw user_ctx pointer to the spawned fn (330) while the spawning thread may still hold it |
| `runtime/sfn/concurrency/future.sfn` | 331 | `_sfn_trampoline_void_ctx` | use-after-free | free(ctx) frees the [fn_ptr][user_ctx] pair whose address remains stored in Task.ctx (dangling for the Task's remaining lifetime) |
| `runtime/sfn/concurrency/future.sfn` | 341-348 | `sfn_spawn_void_ctx` | shared-mutable-alias | Stores raw fn_ptr and user ctx addresses into a malloc'd pair (atomic_store at 345-346) handed across the thread boundary via Task.ctx; user ctx aliased by spawner and worker |
| `runtime/sfn/concurrency/future.sfn` | 356-360 | `_sfn_trampoline_string` | shared-mutable-alias | Returns the user fn's raw * u8 string result (359), stored in Task.result on the worker thread and later handed to the awaiting thread — same cross-thread aliasing as the ptr family |
| `runtime/sfn/concurrency/future.sfn` | 363-371 | `_sfn_trampoline_string_ctx` | shared-mutable-alias | Recasts the heap pair as two * i64 slots (364-365), forwards the raw user_ctx pointer to the spawned fn (369), and forwards the fn's raw string-pointer result across threads via Task.result (371) |
| `runtime/sfn/concurrency/future.sfn` | 370 | `_sfn_trampoline_string_ctx` | use-after-free | free(ctx) frees the [fn_ptr][user_ctx] pair whose address remains stored in Task.ctx (dangling for the Task's remaining lifetime) |
| `runtime/sfn/concurrency/future.sfn` | 380-387 | `sfn_spawn_string_ctx` | shared-mutable-alias | Stores raw fn_ptr and user ctx addresses into a malloc'd pair (atomic_store at 384-385) handed across the thread boundary via Task.ctx; user ctx aliased by spawner and worker |

### process

Source: `runtime/sfn/process.sfn` — 52 sites (18 in-place-mutation, 19 use-after-free, 15 shared-mutable-alias).

| File | Lines | Symbol | Hazard | Notes |
|---|---|---|---|---|
| `runtime/sfn/process.sfn` | 159-172 | `sfn_process_run` | in-place-mutation | atomic_store writes argv string addresses plus NULL sentinel through raw * i64 slot pointers (slots + i at 165-167, slots + len at 170-172) into the malloc'd argv buffer |
| `runtime/sfn/process.sfn` | 163-185 | `sfn_process_run` | shared-mutable-alias | buffer slots hold borrowed sfn_str_to_cstr addresses aliasing live Sailfin string bytes (164); buf_pp (184), path (182), and the global environ pointer (183) handed across the extern boundary to posix_spawnp (185) |
| `runtime/sfn/process.sfn` | 179-185 | `sfn_process_run` | in-place-mutation | posix_spawnp writes the child pid back through pid_ptr = &pid (180) — extern write through a raw pointer aliasing the live stack local read again at 197 (included conservatively; missed by first pass) |
| `runtime/sfn/process.sfn` | 187-199 | `sfn_process_run` | use-after-free | manual free(buf) on spawn-failure (187) and post-wait (199) paths; slots/null_slot/buf_pp aliases of the freed buffer remain in scope (unused after, but live) |
| `runtime/sfn/process.sfn` | 195-197 | `sfn_process_run` | in-place-mutation | waitpid writes the wait status through status_ptr = &status (196) aliasing the live local decoded at 205-208 (included conservatively; missed by first pass) |
| `runtime/sfn/process.sfn` | 315-328 | `_process_build_cstr_argv` | in-place-mutation | atomic_store of element pointers (323) plus NULL terminator (328) into the malloc'd slot buffer via raw * i64 pointer arithmetic (321, 326) |
| `runtime/sfn/process.sfn` | 319-329 | `_process_build_cstr_argv` | shared-mutable-alias | returns malloc'd buffer (329) whose slots alias the bytes of the caller's Sailfin strings (sfn_str_to_cstr identity bridge at 320) — buffer lifetime decoupled from the string lifetimes |
| `runtime/sfn/process.sfn` | 349-353 | `_growbuf_read_from` | use-after-free | realloc(old, new_cap) at 350 may relocate and implicitly frees the old buffer; any other copy of the old address (e.g. the handle stash field viewed through a different overlay) goes stale |
| `runtime/sfn/process.sfn` | 352-353 | `_growbuf_read_from` | in-place-mutation | grow path updates addr/cap fields on a GrowBuf that may be an overlay onto the shared, C-producible SailfinProcessHandle stash |
| `runtime/sfn/process.sfn` | 355-365 | `_growbuf_read_from` | in-place-mutation | read(2) writes up to 4096 bytes through interior pointer dst = gb.addr + gb.len (355, 357) into the existing buffer, then bumps gb.len (364) on the possibly-shared struct |
| `runtime/sfn/process.sfn` | 382-383 | `_growbuf_take` | in-place-mutation | memset writes a NUL terminator at addr+len (382-383) into a buffer that may also be reachable via the handle's stdout_buf/stderr_buf fields through the overlay |
| `runtime/sfn/process.sfn` | 384-387 | `_growbuf_take` | shared-mutable-alias | returns the raw buffer address (387) while ownership transfer relies on manually zeroing gb.addr/len/cap (384-386); if zeroing is skipped, two owners (caller and handle stash) hold the same buffer |
| `runtime/sfn/process.sfn` | 417-418 | `_drain_two_pipes` | shared-mutable-alias | two typed PollSlot interior views (pbuf at 417, pbuf+8 at 418) alias the same 16-byte malloc'd buffer alongside the base * u8 — three live handles to the same bytes |
| `runtime/sfn/process.sfn` | 423-427 | `_drain_two_pipes` | in-place-mutation | stores fd/events through the PollSlot overlay pointers (423-426) and poll(2) writes revents back into the same live buffer across the extern boundary (427) |
| `runtime/sfn/process.sfn` | 463 | `_drain_two_pipes` | use-after-free | free(pbuf) while interior aliases p0/p1 are still in scope (stale after the free; not dereferenced afterward, included conservatively) |
| `runtime/sfn/process.sfn` | 483-490 | `sfn_process_run_capture` | use-after-free | frees buffers addressed by mutable module globals sfn_capture_stdout_addr/sfn_capture_stderr_addr (484, 488 — stale stash from a prior capture), then zeroes the globals (485, 489) |
| `runtime/sfn/process.sfn` | 495-593 | `sfn_process_run_capture` | use-after-free | manual frees of child_argv/child_envp duplicated across seven early-return error paths (499, 505-506, 511-512, 523-524, 532-533, 547-548, 557-558) plus spawn-failure (584-585) and success (592-593) paths — double-free risk if any path ever overlaps |
| `runtime/sfn/process.sfn` | 503-537 | `sfn_process_run_capture` | in-place-mutation | pipe(2) writes fd pairs into the malloc'd out_pipe/err_pipe buffers (509, 527) through a * i32 view that aliases the * PollSlot view of the same bytes |
| `runtime/sfn/process.sfn` | 510-539 | `sfn_process_run_capture` | use-after-free | frees of the out_pipe/err_pipe PollSlot buffers on four separate paths (510, 522, 530-531, 538-539) after extracting fds through the overlay |
| `runtime/sfn/process.sfn` | 541-578 | `sfn_process_run_capture` | use-after-free | free(actions) on the file_actions_init failure path (552) and again after posix_spawn_file_actions_destroy (577-578) — manual lifetime of the raw 256-byte actions buffer |
| `runtime/sfn/process.sfn` | 570-576 | `sfn_process_run_capture` | shared-mutable-alias | posix_spawnp (576) receives argv_pp/envp_pp slot buffers (574-575) holding borrowed Sailfin string addresses plus the raw actions buffer across the extern boundary |
| `runtime/sfn/process.sfn` | 570-576 | `sfn_process_run_capture` | in-place-mutation | posix_spawnp writes the child pid back through pid_ptr = &pid (571) aliasing the live local used at 601, 608, and 622 (included conservatively; missed by first pass) |
| `runtime/sfn/process.sfn` | 595-627 | `sfn_process_run_capture` | use-after-free | cross-frees of the gb_out/gb_err header structs on OOM (free(gb_err) at 600, free(gb_out) at 607) and after _growbuf_take hands off their buffers (626-627) |
| `runtime/sfn/process.sfn` | 620-622 | `sfn_process_run_capture` | in-place-mutation | waitpid writes the wait status through status_ptr = &status (621) aliasing the live local decoded at 638-641 (included conservatively; missed by first pass) |
| `runtime/sfn/process.sfn` | 629-633 | `sfn_process_run_capture` | use-after-free | frees the freshly taken out_cstr/err_cstr capture buffers on the waitpid-failure path (630-631) |
| `runtime/sfn/process.sfn` | 635-636 | `sfn_process_run_capture` | shared-mutable-alias | stores raw malloc'd capture-buffer addresses into mutable module globals as i64 — raw addresses parked in globals reachable from the capture_take_* helpers |
| `runtime/sfn/process.sfn` | 655-660 | `sfn_process_capture_take_stdout` | shared-mutable-alias | returns the raw buffer address parked in mutable global sfn_capture_stdout_addr (659); ownership transfer relies on manually zeroing the global (657) |
| `runtime/sfn/process.sfn` | 662-667 | `sfn_process_capture_take_stderr` | shared-mutable-alias | returns the raw buffer address parked in mutable global sfn_capture_stderr_addr (666); ownership transfer relies on manually zeroing the global (664) |
| `runtime/sfn/process.sfn` | 692-827 | `sfn_process_spawn_with_env` | use-after-free | manual frees of child_argv/child_envp duplicated across nine early-return error paths (696, 702-703, 708-709, 720-721, 729-730, 744-745, 756-757, 774-775, 786-787) plus spawn-failure (816-817) and success (826-827) paths — double-free risk if any path ever overlaps |
| `runtime/sfn/process.sfn` | 700-761 | `sfn_process_spawn_with_env` | in-place-mutation | pipe(2) writes fd pairs into three malloc'd PollSlot buffers (706, 724, 748) through * i32 views aliasing the * PollSlot views of the same bytes |
| `runtime/sfn/process.sfn` | 707-764 | `sfn_process_spawn_with_env` | use-after-free | frees of the in_pipe/out_pipe/err_pipe PollSlot buffers scattered across error paths (707, 719, 727-728, 742-743, 753-755) and the success path (762-764) |
| `runtime/sfn/process.sfn` | 766-808 | `sfn_process_spawn_with_env` | use-after-free | free(actions) on the file_actions_init failure path (779) and again after posix_spawn_file_actions_destroy (807-808) |
| `runtime/sfn/process.sfn` | 800-806 | `sfn_process_spawn_with_env` | shared-mutable-alias | posix_spawnp (806) receives argv_pp/envp_pp slot buffers (804-805) holding borrowed Sailfin string addresses plus the raw actions buffer across the extern boundary |
| `runtime/sfn/process.sfn` | 800-806 | `sfn_process_spawn_with_env` | in-place-mutation | posix_spawnp writes the child pid back through pid_ptr = &pid (801) aliasing the live local persisted into the handle at 837 (included conservatively; missed by first pass) |
| `runtime/sfn/process.sfn` | 829-847 | `sfn_process_spawn_with_env` | shared-mutable-alias | malloc'd SailfinProcessHandle address escapes to the caller cast to i64 (847) — an untracked integer alias whose lifetime is managed manually by sfn_process_handle_wait; layout also shared in lockstep with the C-side struct |
| `runtime/sfn/process.sfn` | 856-859 | `sfn_process_handle_write` | use-after-free | reconstitutes * SailfinProcessHandle from caller-supplied i64 with no liveness check (858) and reads h.stdin_fd (859) — reads freed memory if called after sfn_process_handle_wait freed the handle |
| `runtime/sfn/process.sfn` | 861-867 | `sfn_process_handle_write` | shared-mutable-alias | strlen(data) (861) and write(fd, dst, ...) (867) hand the caller-owned buffer and interior pointers dst = data + written (865) across the extern boundary (read-only use; included conservatively; missed by first pass) |
| `runtime/sfn/process.sfn` | 882-886 | `sfn_process_handle_close_stdin` | use-after-free | i64-to-pointer reconstitution of a possibly-freed handle (883) followed by field read (884) and close (886) — stale-handle deref if called after handle_wait |
| `runtime/sfn/process.sfn` | 887 | `sfn_process_handle_close_stdin` | in-place-mutation | persists h.stdin_fd = -1 sentinel into the shared, caller-aliased handle struct |
| `runtime/sfn/process.sfn` | 896-897 | `_handle_drain_one` | shared-mutable-alias | computes * GrowBuf overlays at h+16 and h+40 by address arithmetic — typed views aliasing the handle's stdout/stderr stash fields, which are simultaneously reachable as h.stdout_buf/h.stderr_buf etc. |
| `runtime/sfn/process.sfn` | 900-901 | `_handle_drain_one` | shared-mutable-alias | PollSlot interior views p0 (pbuf) and p1 (pbuf+8) alias the same malloc'd 16-byte buffer alongside the base * u8 |
| `runtime/sfn/process.sfn` | 915-919 | `_handle_drain_one` | in-place-mutation | stores fd/events through PollSlot overlay pointers (915-918) and poll(2) writes revents back into the same live buffer across the extern boundary (919) |
| `runtime/sfn/process.sfn` | 926-944 | `_handle_drain_one` | in-place-mutation | _growbuf_read_from mutates the handle's stash buffers/len/cap through the overlay views (929, 939), and -1 fd sentinels are persisted into the shared handle (h.stdout_fd at 932, h.stderr_fd at 942) |
| `runtime/sfn/process.sfn` | 948 | `_handle_drain_one` | use-after-free | free(pbuf) while interior aliases p0/p1 are still in scope (stale after the free; not dereferenced afterward, included conservatively) |
| `runtime/sfn/process.sfn` | 950-951 | `_handle_drain_one` | shared-mutable-alias | returns the raw buffer pointer extracted from the handle's stash via _growbuf_take — ownership handoff out of a struct the caller still aliases through handle_id |
| `runtime/sfn/process.sfn` | 955-958 | `sfn_process_handle_read_stdout` | use-after-free | i64-to-pointer reconstitution of a possibly-freed handle (957) before draining (958) — stale-handle deref if called after handle_wait |
| `runtime/sfn/process.sfn` | 961-964 | `sfn_process_handle_read_stderr` | use-after-free | i64-to-pointer reconstitution of a possibly-freed handle (963) before draining (964) — stale-handle deref if called after handle_wait |
| `runtime/sfn/process.sfn` | 973-994 | `sfn_process_handle_wait` | use-after-free | derefs caller-supplied i64 handle with no liveness tracking (cast at 974, field reads from 975); a second wait on the same handle_id reads freed memory before re-freeing it |
| `runtime/sfn/process.sfn` | 976-989 | `sfn_process_handle_wait` | in-place-mutation | persists -1 fd sentinels into the shared handle struct fields (h.stdin_fd at 978, h.stdout_fd at 983, h.stderr_fd at 988) |
| `runtime/sfn/process.sfn` | 992-994 | `sfn_process_handle_wait` | in-place-mutation | waitpid writes the wait status through status_ptr = &status (993) aliasing the live local decoded at 997-1000 (included conservatively; missed by first pass) |
| `runtime/sfn/process.sfn` | 1010-1011 | `sfn_process_handle_wait` | shared-mutable-alias | recomputes * GrowBuf overlays at h+16/h+40 aliasing the handle's stash fields for the teardown frees |
| `runtime/sfn/process.sfn` | 1012-1020 | `sfn_process_handle_wait` | use-after-free | frees the stdout/stderr stash buffers (1013, 1017) and then the handle struct itself (1020) while the caller still holds handle_id as an i64 — dangling integer handle; double-free on repeated wait |

### adapters

Source: `runtime/sfn/adapters/http.sfn`, `runtime/sfn/adapters/filesystem.sfn` — 40 sites (17 in-place-mutation, 9 use-after-free, 14 shared-mutable-alias).

| File | Lines | Symbol | Hazard | Notes |
|---|---|---|---|---|
| `runtime/sfn/adapters/http.sfn` | 140-143 | `_ptr_off` | shared-mutable-alias | Returns an interior pointer ((p as i64)+off cast back to * u8) into the caller's buffer; every call site creates a second live handle to the same bytes — the aliasing primitive the whole module is built on. |
| `runtime/sfn/adapters/http.sfn` | 149-152 | `_strdup_n` | in-place-mutation | memcpy of n bytes (line 151) plus NUL memset at buf+n (line 152) into a malloc'd buffer via _ptr_off; buffer is fresh (not yet aliased) — included conservatively as a stores-to-ptr+offset site whose raw result is handed to the caller. |
| `runtime/sfn/adapters/http.sfn` | 161-185 | `_uint_to_str` | in-place-mutation | Digit and NUL memset stores at computed offsets (_ptr_off(buf, idx/count) at 163-164, 176, 182) into a malloc'd buffer; fresh buffer, conservative include as ptr+offset stores. |
| `runtime/sfn/adapters/http.sfn` | 196-212 | `_host_ip4` | in-place-mutation | Writes 4 octet bytes via memset through the caller-supplied raw `out` pointer (offsets 0..3; localhost branch 196-199, octet loop 212) — `out` is an interior pointer into _connect_tcp's live sockaddr buffer, so this mutates memory also reachable through `addr`. |
| `runtime/sfn/adapters/http.sfn` | 202-216 | `_host_ip4` | shared-mutable-alias | NEW: `cursor` (init from host at 202, reassigned to _ptr_off(dot, 1) at 216) and `dot` (strchr at 214) are interior aliases into the caller's live `authority` buffer, walked across loop iterations while `out` is simultaneously written — read-only on the host side, conservative include matching the _http_send 384-407 standard. |
| `runtime/sfn/adapters/http.sfn` | 245-258 | `_connect_tcp` | in-place-mutation | memset stores at fixed offsets (zero-fill 247, family/len bytes 250 or 253-254, port bytes 257-258) into the malloc'd 16-byte sockaddr scratch; buffer is fresh per loop attempt — conservative include as ptr+offset stores. |
| `runtime/sfn/adapters/http.sfn` | 260 | `_connect_tcp` | shared-mutable-alias | Passes interior pointer _ptr_off(addr, 4) into _host_ip4, which writes through it while `addr` remains live — two simultaneous mutable handles into the sockaddr buffer. |
| `runtime/sfn/adapters/http.sfn` | 263-271 | `_connect_tcp` | use-after-free | Three manual free(addr) paths (socket-fail 263, post-connect 267, host-parse-fail 271); the interior alias created at line 260 dangles after each free (not read after today, but unprotected by any check). |
| `runtime/sfn/adapters/http.sfn` | 285 | `_send_all` | shared-mutable-alias | NEW: hands the derived interior pointer _ptr_off(buf, sent) across the extern boundary to send() on every retry iteration — a raw second handle into the caller's head/body buffer crossing into foreign code; read-only, conservative include. |
| `runtime/sfn/adapters/http.sfn` | 308-316 | `_recv_all` | use-after-free | Doubling realloc(buf, new_cap+1) at 310 may relocate the block; the pre-realloc address becomes stale — safe only because `buf` is immediately reassigned (315) and interior pointers are recomputed each iteration (canonical relocation hazard). |
| `runtime/sfn/adapters/http.sfn` | 308-316 | `_recv_all` | in-place-mutation | Grow-at-tip realloc append path with manual capacity bookkeeping (capacity doubled at 309/316, len carried) on the response buffer that is subsequently written at its tip. |
| `runtime/sfn/adapters/http.sfn` | 311-323 | `_recv_all` | use-after-free | Manual free(buf) on the realloc-OOM path (312) and the recv-error path (322); any outstanding alias to buf (e.g. a prior _ptr_off result) dangles after either free. |
| `runtime/sfn/adapters/http.sfn` | 318 | `_recv_all` | in-place-mutation | extern recv() writes up to `chunk` bytes into the live buffer through the interior pointer _ptr_off(buf, len) — mutation of an owned buffer through a derived raw pointer handed across the extern boundary. |
| `runtime/sfn/adapters/http.sfn` | 328-329 | `_recv_all` | in-place-mutation | NUL-terminator memset at buf+len (328) plus atomic_store(len_slot, len) (329) writing through the caller-provided raw * i64 out-param (the caller's stack slot). |
| `runtime/sfn/adapters/http.sfn` | 351-367 | `_extract_body` | in-place-mutation | atomic_store writes through the caller-supplied raw body_len_slot pointer at lines 351 (zeroing) and 367 (final length) — mutation of caller-owned memory via a raw out-param. |
| `runtime/sfn/adapters/http.sfn` | 354-365 | `_extract_body` | shared-mutable-alias | Derives interior pointers into resp (strchr `space` at 354, space+1 at 356, strstr header_end at 360, _ptr_off(resp, body_off) at 365) — multiple live handles into the response buffer; read-only and function-confined, included conservatively (they dangle once the caller frees resp). |
| `runtime/sfn/adapters/http.sfn` | 384-407 | `_http_send` | shared-mutable-alias | host_start/scheme/slash/path are strstr/strchr-derived interior pointers into the caller's url buffer (384-389); `path` (aliasing url's tail via slash, 407) stays live across the entire request build and send — long-lived raw aliases of caller-owned bytes, included conservatively (reads only). |
| `runtime/sfn/adapters/http.sfn` | 399-402 | `_http_send` | in-place-mutation | memset(colon, 0, 1) at 402 truncates the authority string in place ('terminate host in place at the colon') — a store through a derived pointer that changes what every other holder of `authority` observes (strlen at 419 measures the truncated host). |
| `runtime/sfn/adapters/http.sfn` | 399-402 | `_http_send` | shared-mutable-alias | `colon` (strchr at 399) is a derived interior alias into the live `authority` buffer and is written through (402) while `authority` is also live; it dangles after any of the later free(authority) sites. |
| `runtime/sfn/adapters/http.sfn` | 447-501 | `_http_send` | in-place-mutation | Request-head assembly: repeated _append (memcpy at running offset, 455-465 and 496-500) plus final NUL memset at head+off (466, 501) into the pre-sized malloc'd `head` buffer, in both the POST (447-466) and GET (489-501) branches; correctness depends entirely on the separately summed `total` matching the appended lengths — no bounds check. |
| `runtime/sfn/adapters/http.sfn` | 411-514 | `_http_send` | use-after-free | Manual free(authority) on every exit path — 8 sites verified (411, 427, 450, 475, 480, 491, 508, 514); the interior alias `colon` (and the truncated-host view) dangles after each. Paths are mutually exclusive today (no double-free found), but the invariant is enforced only by control-flow discipline. |
| `runtime/sfn/adapters/http.sfn` | 449-504 | `_http_send` | use-after-free | Manual frees of the transient request pieces: free(clen) at 449 and 467, free(head) at 470 and 504 — head is freed immediately after _send_all returns; a reorder would hand a freed buffer to send(). |
| `runtime/sfn/adapters/http.sfn` | 516-519 | `_http_send` | use-after-free | free(resp) at 519 after _extract_body has copied the body out; the resp address (and any interior pointer derived from it) is stale past this line — safe only because `result` is a fresh _strdup_n copy taken at 518 before the free. |
| `runtime/sfn/adapters/http.sfn` | 516 | `_http_send` | shared-mutable-alias | Passes the address of stack local total_len (& total_len) as a raw * i64 into _recv_all, which writes through it (atomic_store at 329) — a mutable borrow of a stack slot crossing a function boundary with no lifetime tracking. |
| `runtime/sfn/adapters/http.sfn` | 526-530 | `_append` | in-place-mutation | memcpy of strlen(src) bytes into the existing `dst` buffer at _ptr_off(dst, off) (528) — write into a caller-owned buffer at a caller-tracked offset with no capacity check (caller pre-sizes from summed lengths). |
| `runtime/sfn/adapters/http.sfn` | 539-540 | `sfn_http_get` | shared-mutable-alias | Passes & body_len (address of a stack local, a throwaway slot) as raw * i64 into _http_send, which writes through it transitively — conservative include: raw stack address crossing a function boundary. |
| `runtime/sfn/adapters/http.sfn` | 552-553 | `sfn_http_post` | shared-mutable-alias | Passes & body_len (stack-local address, throwaway slot) as raw * i64 into _http_send — same out-param aliasing shape as sfn_http_get; conservative include. |
| `runtime/sfn/adapters/http.sfn` | 571-572 | `sfn_http_download` | shared-mutable-alias | Passes & body_len as raw * i64 into _http_send; here the written-through value is actually consumed (fwrite length at 582), so the stack slot is a live mutable alias across the call. |
| `runtime/sfn/adapters/http.sfn` | 577-585 | `sfn_http_download` | use-after-free | Manual free(body) on the fopen-failure path (578) and after fwrite/fclose (585); body is handed to extern fwrite at 582 immediately before the success-path free — ordering-enforced only. |
| `runtime/sfn/adapters/http.sfn` | 587-591 | `sfn_http_download` | in-place-mutation | memset stores of 'o','k',NUL at offsets 0-2 (589-591) into the fresh 3-byte malloc'd `ok` buffer; fresh allocation, conservative include as ptr+offset stores. |
| `runtime/sfn/adapters/filesystem.sfn` | 264-274 | `sfn_fs_read_file` | use-after-free | Doubling realloc(buf, new_cap+1) at 266 may relocate the slurp buffer (old address stale, safe only via immediate reassignment at 272), plus manual free(buf) on the realloc-OOM path at 268. |
| `runtime/sfn/adapters/filesystem.sfn` | 264-274 | `sfn_fs_read_file` | in-place-mutation | Grow-at-tip realloc append path with manual capacity/len bookkeeping (capacity doubled, +1 NUL slack carried by convention only) on the file-slurp buffer. |
| `runtime/sfn/adapters/filesystem.sfn` | 275-277 | `sfn_fs_read_file` | in-place-mutation | extern fread() writes up to chunk_size bytes into the live buffer through `dst`, a raw interior pointer built by integer arithmetic ((buf as i64)+len cast back to * u8, 275-276) — also momentarily a second handle aliasing buf. |
| `runtime/sfn/adapters/filesystem.sfn` | 293-295 | `sfn_fs_read_file` | in-place-mutation | NUL-terminator memset at buf+len via the same raw address-arithmetic interior pointer (term_ptr); in-bounds only by the +1 capacity-slack convention maintained manually across every realloc. |
| `runtime/sfn/adapters/filesystem.sfn` | 396-398 | `sfn_fs_mkdir` | in-place-mutation | memcpy of path (n+1 bytes incl. NUL) into the fresh malloc'd `scratch` buffer — fresh allocation, conservative include; the copy exists precisely so the later in-place separator rewrites never touch read-only .rodata. |
| `runtime/sfn/adapters/filesystem.sfn` | 403-414 | `sfn_fs_mkdir` | shared-mutable-alias | `cursor` (scratch+1 at 403, then slash+1 at 410) and `slash` (strchr result, 405) are interior pointers into the live `scratch` buffer; writes go through `slash` (407, 409) while `scratch` is simultaneously passed to mkdir (408, 412) and sfn_fs_exists (414) — multiple live handles to the same bytes. (Range corrected from 403-410: the final mkdir is at 412 and the exists probe at 414.) |
| `runtime/sfn/adapters/filesystem.sfn` | 407-409 | `sfn_fs_mkdir` | in-place-mutation | Component-walk separator rewrite: memset(slash, 0, 1) at 407 temporarily NUL-terminates the prefix in place, mkdir reads scratch in the mutated state (408), then memset(slash, 47, 1) at 409 restores the '/' — classic transient in-place mutation observed through a second handle. |
| `runtime/sfn/adapters/filesystem.sfn` | 415 | `sfn_fs_mkdir` | use-after-free | Manual free(scratch) after the sfn_fs_exists probe; the interior aliases `cursor` and `slash` dangle past this point (unused after today, enforced only by ordering). |
| `runtime/sfn/adapters/filesystem.sfn` | 446 | `sfn_fs_read_bytes` | shared-mutable-alias | Forwards the raw `out_length` pointer (an int64_t* spelled * u8) across the extern boundary to C sailfin_runtime_read_file_bytes, which writes the binary length through it — raw mutable out-param handed to foreign code; also returns the C-malloc'd buffer as a raw * u8 the caller must free. |
| `runtime/sfn/adapters/filesystem.sfn` | 432 | `sfn_fs_list_dir` | shared-mutable-alias | Returns the C-built SfnArray ({ i8**, i64, i64 }*) as an opaque raw * u8 — a pointer to a C-owned aggregate whose interior i8** elements alias C-allocated strings, reachable from Sailfin with no ownership tracking; conservative include. |

### platform

Source: `runtime/sfn/platform/exec.sfn`, `runtime/sfn/platform/errno.sfn` — 15 sites (4 in-place-mutation, 4 use-after-free, 7 shared-mutable-alias).

The remaining platform modules — `runtime/sfn/platform/libc.sfn`, `runtime/sfn/platform/net.sfn`, `runtime/sfn/platform/posix.sfn`, and `runtime/sfn/platform/pthread.sfn` — are extern-declaration bindings with no function bodies: **no hazardous sites found**.

| File | Lines | Symbol | Hazard | Notes |
|---|---|---|---|---|
| `runtime/sfn/platform/exec.sfn` | 193-198 | `binary_dir` | shared-mutable-alias | Casts the live `exe` string to raw `* u8` (`p`, line 193) and derives an interior pointer (`slash`) into the same bytes via strrchr(p, 47) at line 195; three live handles (exe, p, slash) alias one buffer and feed address-difference arithmetic at line 198. |
| `runtime/sfn/platform/exec.sfn` | 201 | `binary_dir` | in-place-mutation | memcpy(buf, p, len) writes len bytes through a raw pointer into the malloc'd buf; src `p` is an alias of the caller's live `exe` string bytes (dst is fresh from line 199, so low risk — included conservatively as a raw-pointer bulk write). |
| `runtime/sfn/platform/exec.sfn` | 202-203 | `binary_dir` | in-place-mutation | Computes interior pointer `term = buf + len` (line 202) and stores a NUL through it via memset(term, 0, 1) (line 203) — a ptr+offset store with no bounds tie to the allocation length. |
| `runtime/sfn/platform/exec.sfn` | 194-208 | `binary_dir` | shared-mutable-alias | Mixed-ownership returns: "" / "." / "/" / "" paths (lines 194/196/197/200) return pointers to shared .rodata literals while line 208 returns a heap buf cast to string; callers cannot distinguish heap from static (header lines 176-181 admit this), so an unconditional free is invalid and every "." result aliases the same static bytes. |
| `runtime/sfn/platform/exec.sfn` | 243 | `exe_path` | in-place-mutation | memset(buf, 0, buf_size) zero-fills the freshly malloc'd 4096-byte buf through a raw pointer (fresh allocation from line 241, included conservatively as a raw bulk store the type system cannot see). |
| `runtime/sfn/platform/exec.sfn` | 253 | `exe_path` | in-place-mutation | Hands raw `buf` across the sailfin_intrinsic_exe_path extern/intrinsic boundary; the host primitive (readlink / _NSGetExecutablePath / GetModuleFileNameA) writes up to `usable` bytes into buf with no NUL-termination guarantee — correctness depends on the manual size-minus-one reservation at line 252. |
| `runtime/sfn/platform/exec.sfn` | 254-257 | `exe_path` | use-after-free | Manual free(buf) at line 255 on the lookup-failure path (n <= 0); buf is dead afterward today, but nothing prevents a future reference to the freed buffer in this function (manual-free site per rubric). |
| `runtime/sfn/platform/exec.sfn` | 264-267 | `exe_path` | use-after-free | Manual free(buf) at line 265 on the truncation path (n >= usable); same stale-pointer exposure class as the failure-path free. |
| `runtime/sfn/platform/exec.sfn` | 276-280 | `exe_path` | use-after-free | free(buf) at line 278 after realpath(buf, null) succeeds at line 276, while returning the separately malloc'd `canon` at line 279; any alias of buf taken between lines 253-276 (none today) would dangle past line 278. |
| `runtime/sfn/platform/exec.sfn` | 242-283 | `exe_path` | shared-mutable-alias | Mixed-ownership returns: failure paths (lines 242/256/266) return .rodata "" literals while success paths return heap canon (line 279) or heap buf (line 283) cast to string under a documented leak contract (lines 272-275); callers cannot distinguish freeable from static results. |
| `runtime/sfn/platform/exec.sfn` | 326-334 | `resolve_runtime_root` | shared-mutable-alias | Returns the getenv("SAILFIN_RUNTIME_ROOT") pointer (line 326) as a string without copying (line 334) — the bytes are owned by the live libc environ table (libc.sfn lines 155-158 explicitly require adapters to copy before storing), so the returned string and the environ table are two live handles to the same mutable bytes. |
| `runtime/sfn/platform/exec.sfn` | 326-334 | `resolve_runtime_root` | use-after-free | Same getenv result returned uncopied at line 334: a later setenv/putenv/unsetenv can free or relocate the env entry while the returned string is still live, making any subsequent read a stale read of freed memory. |
| `runtime/sfn/platform/exec.sfn` | 337-348 | `resolve_runtime_root` | shared-mutable-alias | Raw `* u8` views of exe_dir_str (cast at line 338) and the suffix pointer (line 342) are handed across extern boundaries (sailfin_runtime_string_concat at 343, sfn_fs_exists at 344, realpath at 345); the heap candidate/canon buffers are returned as string with leak-by-contract ownership (lines 346-347), and non-returned per-iteration candidate buffers are abandoned without free. |
| `runtime/sfn/platform/exec.sfn` | 363-377 | `_candidate_suffix` | shared-mutable-alias | Returns raw `* u8` pointers to .rodata string-literal bytes ("/runtime" / "/../runtime" / "/../../runtime" at lines 369/373/376); every call site aliases the same static data with no ownership marker — safe only while every consumer treats the bytes as immutable and never frees them (conservative include: returning a raw data pointer across the function boundary). |
| `runtime/sfn/platform/errno.sfn` | 58-60 | `errno` | shared-mutable-alias | Dereferences libc's thread-local errno slot through a raw i32* obtained from the sailfin_intrinsic_errno_location sentinel via sailfin_intrinsic_pointer_read_i32 (line 59); the slot is concurrently mutable by every libc call on the thread. Read-only immediate deref with no pointer escape — included conservatively as an untracked raw alias of libc-owned mutable state. |

### io

Source: `runtime/sfn/io.sfn` — 1 sites (0 in-place-mutation, 0 use-after-free, 1 shared-mutable-alias).

| File | Lines | Symbol | Hazard | Notes |
|---|---|---|---|---|
| `runtime/sfn/io.sfn` | 153-156 | `sfn_log_execution` | shared-mutable-alias | Returns the raw value pointer unchanged (line 155), so the @logExecution caller binds a second name to the same bytes as the argument (conservative include: the intervening sailfin_runtime_print_info call was audited — fputs-only, non-retaining — so the surviving hazard is the returned alias). |

### core misc

Source: `runtime/sfn/exception.sfn`, `runtime/sfn/type_meta.sfn`, `runtime/sfn/clock.sfn` — 36 sites (11 in-place-mutation, 7 use-after-free, 18 shared-mutable-alias).

| File | Lines | Symbol | Hazard | Notes |
|---|---|---|---|---|
| `runtime/sfn/exception.sfn` | 203-211 | `sfn_exception_alloc_frame` | in-place-mutation | Initializes prev/jmp_buf/message fields through raw pointers (203, 210, 211) and memsets the 256-byte jmp_buf (209); buffers are freshly malloc'd so low risk — included conservatively as stores through raw pointers. |
| `runtime/sfn/exception.sfn` | 206 | `sfn_exception_alloc_frame` | use-after-free | free(raw) on the jmp_buf-OOM path while local alias `frame` (= raw, cast at 202) is still live in scope; only null is returned afterward, but the free call is a site per the rubric. |
| `runtime/sfn/exception.sfn` | 210 | `sfn_exception_alloc_frame` | shared-mutable-alias | Stores the raw malloc'd `buf` address into frame.jmp_buf; local `buf` and the escaping frame both reach the same bytes once the frame is returned to the caller. |
| `runtime/sfn/exception.sfn` | 217-221 | `sfn_exception_free_frame` | use-after-free | free(frame.jmp_buf) at 219 and free(frame) at 220 with no unlink from the thread-local chain — freeing a still-linked frame leaves the chain head / prev pointers dangling; a repeated call on the same non-null frame is a double free (idempotence holds only for null). |
| `runtime/sfn/exception.sfn` | 228-230 | `sfn_exception_frame_head` | shared-mutable-alias | Returns the raw chain-head pointer from the thread_local global (229); the caller gains a mutable alias to a frame that remains reachable (and mutable) via the chain. |
| `runtime/sfn/exception.sfn` | 240 | `sfn_exception_push_frame` | in-place-mutation | Writes frame.prev through the caller-owned raw frame pointer (frame is referenced both by the caller and, after 241, by the chain). |
| `runtime/sfn/exception.sfn` | 241 | `sfn_exception_push_frame` | shared-mutable-alias | Stores the frame's raw address into thread_local global sfn_exception_frame_head_addr — caller and chain now hold two live handles to the same frame bytes. |
| `runtime/sfn/exception.sfn` | 256-271 | `sfn_exception_pop_frame` | in-place-mutation | Chain-unlink writes through raw shared pointers: head global reassigned from frame.prev / cur.prev (257, 267) and prev.prev = cur.prev (270) mutate frames owned by other try scopes. |
| `runtime/sfn/exception.sfn` | 260-276 | `sfn_exception_pop_frame` | use-after-free | Defensive linear walk dereferences cur.prev on every linked frame (265, 267, 270, 275); any frame freed via sfn_exception_free_frame without first being popped leaves this walk reading freed memory. Conservative-inclusive. |
| `runtime/sfn/exception.sfn` | 305 | `sfn_try_enter` | shared-mutable-alias | Hands the caller's raw frame pointer to sfn_exception_push_frame, which retains its address in the thread-local chain head — after sfn_try_enter returns, chain and caller alias the same frame bytes. Caller-level handoff-with-retention per rubric; the store site itself is reported at 241. Newly found. |
| `runtime/sfn/exception.sfn` | 306 | `sfn_try_enter` | in-place-mutation | Extern setjmp writes register/stack state into frame.jmp_buf, an existing heap buffer aliased by both the chain and the caller's frame handle. |
| `runtime/sfn/exception.sfn` | 304-307 | `sfn_try_enter` | use-after-free | The setjmp save point recorded in the heap jmp_buf goes stale once this function (or the setjmp-ing caller) returns; a later longjmp targets a dead stack frame — C11 UB explicitly documented in the file header (lines 72-87) and the function comment (294-303). |
| `runtime/sfn/exception.sfn` | 353 | `sfn_throw` | in-place-mutation | Writes head.message through the raw chain-head pointer into a frame owned by the try-entering caller. |
| `runtime/sfn/exception.sfn` | 353 | `sfn_throw` | shared-mutable-alias | Stores the thrower's raw message pointer into the frame; the message's owner (typically a string literal lowered to a persistent global, per the comment at 367-371) and the frame now alias the same bytes with no lifetime tie. |
| `runtime/sfn/exception.sfn` | 354-356 | `sfn_throw` | use-after-free | longjmp(buf, 1) to a save point that is stale if the setjmp-ing frame already returned (documented UB); buf is read from the frame at 354 and dereferenced (356) after the frame is popped off the chain at 355. |
| `runtime/sfn/exception.sfn` | 377-378 | `sfn_take_exception` | in-place-mutation | Clears frame.message (378) on a frame that sfn_throw has already popped from the chain — a write through a raw pointer to handler-owned memory that may be queued for sfn_exception_free_frame. |
| `runtime/sfn/exception.sfn` | 376-380 | `sfn_take_exception` | shared-mutable-alias | Returns the raw message pointer (379) while the allocation remains owned elsewhere (string literal lowered to a persistent global); caller and the original owner alias the same bytes. |
| `runtime/sfn/exception.sfn` | 424-425 | `_sfn_exception_empty` | in-place-mutation | memset zero-fill of the freshly malloc'd 1-byte empty-string buffer through a raw pointer (425); fresh allocation so low risk — included conservatively, same class as the alloc_frame memset row. Newly found. |
| `runtime/sfn/exception.sfn` | 422-429 | `_sfn_exception_empty` | shared-mutable-alias | Caches a raw malloc'd address in process-global sfn_exception_empty_addr (426) and returns it (428) — the global cache and every returned handle alias one never-freed shared buffer. |
| `runtime/sfn/exception.sfn` | 435-441 | `sfn_set_exception` | shared-mutable-alias | Stores the caller-owned raw message pointer (440) or the shared empty string (437) into process-global sfn_exception_message_addr; the slot can outlive the message allocation, leaving a dangling global readable via sfn_has_exception consumers. |
| `runtime/sfn/exception.sfn` | 473 | `sfn_raise_value_error` | shared-mutable-alias | Hands the caller-owned raw `message` pointer to sfn_set_exception, which retains it in process-global sfn_exception_message_addr — raw-pointer handoff where the callee retains, per rubric (store site reported at 435-441). Newly found. |
| `runtime/sfn/exception.sfn` | 475-480 | `sfn_raise_value_error` | use-after-free | malloc (475) / memset (477) / write (478) of the 1-byte newline buffer then free(nl) at 479; locally scoped and freed before abort() so currently safe — included per the every-free-call inclusion rule. |
| `runtime/sfn/type_meta.sfn` | 136-139 | `_registry_entries` | shared-mutable-alias | Returns an interior pointer (header + 16) into the shared registry heap buffer; every holder's alias is invalidated by the realloc in _registry_append. |
| `runtime/sfn/type_meta.sfn` | 154-163 | `_registry_init` | in-place-mutation | Writes header.length/capacity (154-155) and zero-fills 16 entry slots via atomic_store (161) through raw interior pointers; buffer is freshly malloc'd — included conservatively. |
| `runtime/sfn/type_meta.sfn` | 164-165 | `_registry_init` | shared-mutable-alias | Stores the buffer's raw address into process-global sfn_type_registry_addr (164) and also returns the header pointer (165) — two live handles to the same registry bytes. |
| `runtime/sfn/type_meta.sfn` | 179-182 | `_registry_append` | use-after-free | realloc(header, new_total) at 179 may relocate the registry; the pre-realloc `header` pointer and any earlier _registry_entries interior pointers become stale (reassigned locally at 181-182, but stale permanently in any outside holder). |
| `runtime/sfn/type_meta.sfn` | 176-191 | `_registry_append` | in-place-mutation | Grow path: realloc growth of the shared registry buffer (179), zero-fill of the new slot tail via atomic_store (185-190), and capacity field update (191) on a buffer reachable through the process global. |
| `runtime/sfn/type_meta.sfn` | 193-197 | `_registry_append` | in-place-mutation | Append-at-tip: atomic_store of the descriptor into entries[length] (195) plus header.length bump (196) on the globally shared registry buffer. |
| `runtime/sfn/type_meta.sfn` | 195 | `_registry_append` | shared-mutable-alias | Stores the raw descriptor address into the entries array; the descriptor remains reachable via its compiler-emitted @__sfn_type_desc.* global, so registry and module data hold two live handles to the same bytes (duplicates multiply the aliases, per the comment at 211-218). |
| `runtime/sfn/type_meta.sfn` | 202-206 | `_descriptor_name` | shared-mutable-alias | Returns d.name_ptr as a raw * u8 (205) — an alias into the compiler-emitted name constant; included conservatively (target is an immutable global). |
| `runtime/sfn/type_meta.sfn` | 220 | `sfn_type_register` | shared-mutable-alias | Public API hands the raw `desc` pointer to _registry_append, which retains it in the process-global registry — raw-pointer handoff where the callee retains, per rubric (the retaining store is separately reported at 195). Newly found. |
| `runtime/sfn/type_meta.sfn` | 234-255 | `sfn_resolve_type` | shared-mutable-alias | Returns the raw descriptor pointer held in the registry (return at 249); caller and registry (and the emitting module's global) alias the same descriptor bytes. Conservative-inclusive — descriptors are effectively read-only. |
| `runtime/sfn/clock.sfn` | 111-138 | `sfn_clock_monotonic_nanos` | shared-mutable-alias | & ts stack address escapes across the extern clock_gettime boundary as an out-param (112, 129) and is re-derived as interior * i64 aliases sec_ptr / nsec_ptr via a +1 pointer step (135-136) — multiple live handles to one alloca. |
| `runtime/sfn/clock.sfn` | 129 | `sfn_clock_monotonic_nanos` | in-place-mutation | Extern clock_gettime (the kernel) writes tv_sec/tv_nsec through ts_ptr into the existing stack-allocated Timespec; subsequent reads at 137-138 depend on this write ordering (the stale-read hazard the module comments at 100-104). |
| `runtime/sfn/clock.sfn` | 195 | `sfn_sleep` | shared-mutable-alias | Passes `req` (Timespec, lowered to a pointer to the caller's stack value at the C ABI) across the extern nanosleep boundary each loop iteration; rem out-param is null so the callee performs no write — included conservatively as a raw-pointer extern handoff. |
| `runtime/sfn/clock.sfn` | 201 | `sfn_sleep` | shared-mutable-alias | Dereferences the raw pointer returned by the extern errno-locator sentinel — a transient alias into libc's thread-local errno slot, which libc/the kernel mutate on every syscall; not retained, read-only — included conservatively per the extern raw-pointer rule. Newly found. |

## #1205 anchor sites

Issue #1205 (the heap corruption that motivated the borrow-checking proposal)
was caused by exactly two of the rows above interacting — they are the anchor
sites for the whole epic and the first targets for E8/E9:

1. **Arena grow-at-tip realloc** — `runtime/sfn/memory/arena.sfn`,
   `sfn_arena_sfn_realloc`, lines 345-349 (`in-place-mutation`): the
   grow-if-at-tip path extends `page.used` so the caller's existing buffer is
   resized in place under **all** aliases of `ptr`, and the tip check is raw
   address equality with no containment check against the page. The companion
   rows at lines 354-357 (`use-after-free`, relocating path) and 356
   (`in-place-mutation`, the relocation `memcpy`) complete the realloc surface.
   **Phase R1 (#1217):** the grow-at-tip path inside `sfn_arena_sfn_realloc` is
   now wrapped in `unsafe { }` (author-asserted raw region). It remains reachable
   from safe Sailfin code only through a unique `OwnedBuf`; the ownership checker
   (E5, #1214/#1215) proves no live alias at the mutation site.
2. **String append over that realloc** — `runtime/sfn/string.sfn`,
   `sfn_str_sfn_append`, lines 206-208 (one `in-place-mutation` row, one
   `use-after-free` row): the C body (`sailfin_runtime_string_append`) rode
   `sfn_arena_realloc`'s grow-if-at-tip path and memcpy'd the suffix into
   `out+buf_len`, mutating `buf`'s existing allocation while other handles may
   reference those bytes (the #892 "stale in-place-append window" was this
   exact site), and the documented buf-is-CONSUMED contract meant caller-held
   copies of the old pointer go stale whenever the realloc relocates.
   **Phase R1 (#1217):** `sfn_str_sfn_append` is now a consume-and-return move
   (`OwnedBuf -> OwnedBuf`); the raw realloc interior is behind `unsafe { }` in
   arena.sfn; uniqueness is enforced by the ownership checker. Both rows are
   annotated RESOLVED above. The interim copy-on-alias fallback is tracked
   separately on #1205 and is out of scope for #1217.

The #1205 corruption class is **structurally closed** by Phase R1: the hazard
is eliminated by uniqueness enforcement rather than call-site whack-a-mole.
Every other row in this inventory is the same decision applied to a different
site, still pending later E8/E9 work.
