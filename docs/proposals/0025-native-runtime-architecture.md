---
sfep: 0025
title: Native Runtime Architecture
status: Implemented
type: runtime
created: 2026-06-26
updated: 2026-07-24
author: "agent:compiler-architect"
tracking: "#321, #322, #451, #822, #1089, #1118, #1181, #1203, #1209"
supersedes:
superseded-by:
graduates-to: reference/runtime-abi.md
---

# SFEP-0025 — Native Runtime Architecture

> Durable architecture record for the Sailfin-native runtime that replaced the
> deleted C runtime (`runtime/native/`, removed in #822/#823). This SFEP captures
> the *system structure and subsystem designs* that are now in the tree. The
> dated milestone-sequencing plan, the C→native symbol map, and the per-milestone
> file-audit appendices that lived in the original `docs/runtime_architecture.md`
> were migration scaffolding and are intentionally **not** carried here — the
> migration is complete. For "what ships today" see `docs/status.md`.

## 1. Summary

The Sailfin-native runtime is the library linked into every compiled Sailfin
program. It provides memory management (arena + reference counting), core data
operations (strings, arrays, slices), structured exception unwind, type metadata
and reflection, structured concurrency (scheduler, tasks, channels, nurseries),
capability adapters (filesystem, HTTP, model, clock), and I/O primitives. Every
line of its source is Sailfin (`runtime/prelude.sfn` + `runtime/sfn/`); it reaches
the operating system exclusively through `extern fn` declarations in
`runtime/sfn/platform/*.sfn` that lower to LLVM `declare` directives resolved
against platform shared libraries (libc, libpthread, libm) at link time. This is
the Rust `std` model — extern declarations in the language, not a hand-written C
bridge.

The governing invariant is **zero C source code in the 1.0 toolchain.** The
shipped artifact is a Sailfin compiler linked against a Sailfin runtime linked
against platform shared libraries. The single historical exception — a temporary
bump allocator authored in C to unblock build-performance work — was deleted
alongside the rest of `runtime/native/`.

## 2. Motivation

The original runtime was C (`runtime/native/`) and carried heavy defensive
overhead: an owned-string hash table, a persistent-pointer plausibility set, NUL
scans (`_safe_strlen_asan`), per-array hidden headers, canaries, and ring-buffer
guards. That overhead cost build time and memory, and — more importantly — it
left a non-Sailfin component in the toolchain, contradicting the 1.0 goal of a
pure Sailfin toolchain (no Python, no C runtime, no downstream fixup scripts).

A pure-Sailfin runtime is a prerequisite for the project's three pillars actually
holding end-to-end: capability effects can only be enforced "to the syscall"
(SFEP-0016) if the syscall surface is itself Sailfin source the compiler can see
and gate; the ownership floor (SFEP-0018) is only meaningful if the allocator and
drop machinery it governs are emitted by the same compiler; and a Sailfin-native
backend (SFEP-0015) needs a runtime ABI it controls. The runtime rewrite was the
load-bearing structural change that made those possible.

This document records the resulting architecture so the *why* behind each
subsystem's shape — arena-by-default with RC at boundaries, explicit exception
frames over LLVM landing pads, a fixed thread pool over work-stealing, a
nursery-backed `routine` — is citable from the code that implements it.

## 3. Design

### 3.1 What the runtime is (and is not)

The runtime is a library linked into every compiled Sailfin program. It is **not**
a virtual machine, garbage collector, or OS-abstraction layer: it does not
interpret Sailfin source or bytecode, does not run a managed event loop in v0
(see §3.7), and does not expose a user-facing `extern fn` mechanism — the platform
extern declarations are runtime-internal.

#### 3.1.1 Layer diagram

```
┌──────────────────────────────────────────────────┐
│  User Sailfin Code                               │
│  (compiled to LLVM IR by the Sailfin compiler)   │
├──────────────────────────────────────────────────┤
│  Prelude  (runtime/prelude.sfn)                  │
│  Wraps runtime services in idiomatic Sailfin API │
├──────────────────────────────────────────────────┤
│  Runtime Services  (runtime/sfn/*.sfn)           │
│  Memory, strings, arrays, exceptions, type meta, │
│  concurrency, I/O                                │
├──────────────────────────────────────────────────┤
│  Capability Adapters  (runtime/sfn/adapters/)    │
│  Filesystem, HTTP, model, clock                  │
│  (gated by effect system + capability grants)    │
├──────────────────────────────────────────────────┤
│  Platform Declarations  (runtime/sfn/platform/)  │
│  extern fn declarations for libc, libpthread,    │
│  POSIX, network — pure Sailfin .sfn modules      │
│  that emit LLVM declare directives               │
├──────────────────────────────────────────────────┤
│  Platform Shared Libraries (not our source)      │
│  libc, libpthread, libm — linked at link time    │
└──────────────────────────────────────────────────┘
```

#### 3.1.2 The platform syscall boundary

The runtime reaches OS services through `extern fn` declarations in Sailfin source
files, which produce LLVM `declare` directives the linker resolves against platform
shared libraries. No C source is authored. Platform functions reached this way span
memory (`malloc`/`free`/`realloc`/`memcpy`/`memcmp`/`memchr`), threads
(`pthread_create`/`pthread_join`, mutex and cond lifecycle), filesystem
(`fopen`/`fread`/`fwrite`/`fclose`/`stat`/`opendir`/`readdir`/`closedir`/`unlink`/
`mkdir`), process (`posix_spawnp`/`waitpid`), fd I/O (`write`/`read`), time
(`clock_gettime`/`nanosleep`), network (`socket`/`connect`/`send`/`recv`/`bind`/
`listen`/`accept`/`close`/`setsockopt`), environment (`getenv`), exception support
(`setjmp`/`longjmp`), and string conversion (`strtod`/`snprintf`).

Only C-ABI-compatible layouts cross the boundary: `i64`, `i32`, `i8`, `f64`,
`bool`, raw pointers (`*u8`, `*File`, `*PthreadMutex`), and function pointers.
Sailfin aggregates (`SfnString`, `SfnArray<T>`) do **not** cross; the adapter layer
decomposes them. Platform types whose internal layout is unknown to Sailfin (e.g.
`pthread_mutex_t`, `jmp_buf`) are declared as opaque structs with platform-specific
size constants; the build selects the correct sizes per target.

#### 3.1.3 Source layout

```
runtime/
  prelude.sfn                   # User-facing facade
  sfn/
    memory/{arena.sfn, rc.sfn}  # Arena allocator, reference counting
    string.sfn                  # SfnString operations
    array.sfn                   # SfnArray<T> operations
    slice.sfn                   # SfnSlice<T> operations
    exception.sfn               # Exception frames, throw, try/catch
    type_meta.sfn               # Type descriptors, registry, reflection
    io.sfn                      # Print, sleep, timing, env
    process.sfn                 # Process spawn
    concurrency/{scheduler.sfn, future.sfn, nursery.sfn}
    channel.sfn                 # Channel<T>
    crypto.sfn                  # SHA-256, base64 (pure Sailfin)
    adapters/{filesystem.sfn, http.sfn, model.sfn, clock.sfn}
    platform/{libc.sfn, pthread.sfn, posix.sfn, net.sfn}
```

Every file in this tree is a `.sfn` module. There is no `.c` or `.h` file.

### 3.2 Memory management (arena + RC hybrid)

This is the central subsystem: a hybrid arena+RC model.

#### 3.2.1 Arenas

An arena is a bump allocator backed by a linked list of memory pages. Allocation is
a pointer bump; deallocation is a bulk reset of the whole arena.

```
struct ArenaPage { data: i8*; capacity: i64; used: i64; next: ArenaPage* }
struct Arena     { current: ArenaPage*; first: ArenaPage*; default_page_size: i64 }
```

API: `sfn_arena_create(page_size) -> Arena*`, `sfn_arena_alloc(arena, size, align)
-> i8*` (bump-allocate, allocating a new page when the current cannot fit),
`sfn_arena_reset(arena)` (reset all pages to `used = 0`, retaining backing pages
for reuse), `sfn_arena_destroy(arena)` (free all pages and the arena).

A limited **grow-if-at-tip realloc** (`sfn_arena_realloc`) optimizes the
`string_append` hot path: if the pointer being reallocated is the last allocation
on the current page and the page has room, the bump pointer is extended in place
(no copy); otherwise a new region is allocated and data copied. Rationale: arena
allocations are O(1) bumps so copy cost dominates (the same as `realloc` when it
cannot grow in place); the wasted old buffer is reclaimed in bulk at reset; and the
optimization is ~15-20 lines that eliminates copies in the common chained-append
loop.

**Compiler arena vs. user-program arena.** The compiler runs as a batch process
with a single process-level arena created at startup and destroyed at exit; all
compiler-internal allocations (AST nodes, IR strings, lowering intermediates) route
through it. (When a long-lived compiler process lands — build-performance Phase 5 —
the arena resets between modules.) User programs may create explicit arenas via
`Arena.create()` for request- or batch-scoped allocation; the prelude does not
expose arenas implicitly — they are an opt-in performance tool. Allocations not
using an explicit arena go through the default RC path.

#### 3.2.2 Reference counting

RC is used for values that outlive their originating scope or arena — values
captured by closures, sent to channels, stored in long-lived collections, or
returned where the caller's lifetime is unknown.

```
struct RcHeader { refcount: i64; drop_fn: fn(i8*) -> void }
```

The `refcount` field is modified with LLVM atomic intrinsics emitted directly by
the compiler (§3.9), not through a C helper or `pthread_mutex`: `sfn_rc_retain`
emits `atomicrmw add`, `sfn_rc_release` emits `atomicrmw sub`. API:
`sfn_rc_alloc(size, drop_fn) -> i8*` (refcount 1; returns a pointer to the payload,
header at `ptr - sizeof(RcHeader)`), `sfn_rc_retain(ptr)` (atomic increment),
`sfn_rc_release(ptr)` (atomic decrement; on zero, call `drop_fn` then free).

**When the compiler emits RC vs. arena** (conservative rule, no full escape
analysis required): arena by default for local allocations; RC at boundaries
(returned from a function, captured by a closure, sent to a channel, stored in a
heap collection that outlives the scope); static for string literals and global
constants (`.rodata`, no RC, no arena). This over-counts RC allocations but is
correct without interprocedural analysis and matches what the compiler can already
reason about (it knows which values flow into a `ret`).

**Cycle handling:** none in v0. The type system discourages cycles (no raw pointers
in safe code, no self-referential structs without explicit indirection). Weak
references or a cycle-detecting pass are post-1.0 options, not designed for now.

#### 3.2.3 Drop emission

The compiler emits explicit drop calls at scope exit for every value owning heap
state — the critical compiler-side prerequisite for the runtime. Drops are emitted
at: end of a function body (before `ret`); end of a block scope (`if`/`else`,
`for`/`loop` body, `match` arm); before a mid-function `return`; before a `break`/
`continue` exiting a scope with owned values; and in exception unwind paths between
the raise site and the catch landing. For an arena value the compiler emits
nothing (bulk reset handles it); for an RC value it emits
`call void @sfn_rc_release`; for a value with a custom drop (e.g. an
`SfnArray<SfnString>` whose elements need dropping) it emits a generated drop
function that iterates elements, releases each, then releases the array.

The compiler must **not** emit drops for borrowed values (`&T`, `&mut T`): borrows
are non-owning and the owner drops. The `OwnershipInfo.variant` field
("owned" / "borrow" / "borrow_mut") provides the signal; a borrow emits no drop.

The compiler integration details — the `LocalBinding.allocation_kind` seam, the
single `emit_scope_drops` funnel, the conservative function-return promotion, and
the lockstep widening rule that keeps `is_heap_type` and drop extraction in sync —
are in §3.8.1. The ownership model that governs which values may be promoted and
which aliases must never be released is specified by SFEP-0018; this document does
not restate it.

### 3.3 String subsystem

```
struct SfnString { data: u8*; len: i64 }   // UTF-8 bytes, NOT NUL-terminated; data may be null when len == 0
```

This matches `runtime-abi.md` Part B. The immediate-codepoint tagged-pointer hack,
the owned-string hash table, the persistent-pointer set, and the
`_safe_strlen_asan` scan are all gone.

Operations (selected): `sfn_str_len` (returns the `len` field), `sfn_str_concat`
(allocates `a.len + b.len` in arena, memcpy both), `sfn_str_append` (concat into
arena and update pointer — avoids arena-incompatible realloc), `sfn_str_slice`
(non-allocating `{data+start, end-start}` view), `sfn_str_eq` (length compare then
`memcmp`), `sfn_str_grapheme_count` / `sfn_str_grapheme_at` (UTF-8 walks),
`sfn_str_byte_at` / `sfn_str_find_byte` (memchr-backed), `sfn_str_codepoint`,
`sfn_str_from_codepoint` (1-4 byte UTF-8 encode), `sfn_str_to_number` (`strtod` on a
stack-buffered NUL copy), `sfn_number_to_str` / `sfn_int_to_str` (formatting into
arena).

**View-safety gap (SFN-42 / SFN-460).** The ABI above is the *target*: a
`{data, len}` aggregate whose `len` is always carried, so `sfn_str_slice` can be
a true non-owning view. The current lowering does not yet realize it — string
values are pervasively downgraded to bare `i8*` and re-recover length via a
`strnlen` scan (`sfn_str_len`), which **over-reads a non-NUL-terminated view**.
Making `sfn_str_slice` a real view therefore requires carrying length end-to-end
in lowering (no `{i8*,i64}→i8*→strnlen` round-trip), not a per-helper `_lv`
migration. Root-cause and options in
`docs/proposals/design-notes/sfn-460-string-view-consumer-surface.md`.

**UTF-8 vs. graphemes.** Strings are UTF-8 byte sequences; `len` is byte length.
`grapheme_at` is an O(n) walk from the start — no grapheme-indexed random access,
the same tradeoff as Rust and Go. The prelude exposes `grapheme_at` /
`grapheme_count` for user code; the compiler's hot paths (lexer, parser) use
byte-level operations (`byte_at`, `find_byte`), correct because compiler source is
ASCII-dominated.

**No interning/pooling in v0.** Interning adds a global table, concurrent locking,
and per-allocation hash overhead; the compiler's hot path creates unique strings
(IR lines, mangled names) far more often than it reuses them. If profiling later
justifies it (e.g. parser identifier lookup), interning can be added as a
deduplicated arena region without changing the string ABI.

**NUL-termination for the extern boundary.** libc calls that take/return C strings
need NUL-terminated buffers: `sfn_str_to_cstr(SfnString, *Arena) -> *u8` copies into
the arena with a trailing NUL (used internally by adapters, never exposed), and
`sfn_str_from_cstr(*u8) -> SfnString` wraps a NUL-terminated buffer by scanning for
NUL.

### 3.4 Array / slice subsystem

```
struct SfnArray<T> { data: T*; len: i64; cap: i64 }
struct SfnSlice<T> { data: T*; len: i64 }            // non-owning view, never freed
```

`SfnArray<T>` replaces both the pointer array and the byte-addressed array with
their hidden headers, canaries, and ring-buffer guards — one layout for all element
types. **Growth policy:** double capacity up to 1024 elements, then grow by 25%
(empirically validated during self-hosting). API: `sfn_array_create(cap, elem_size,
Arena*)`, `sfn_array_push(arr, elem, elem_size, Arena*)` (grows by allocating a new
arena buffer and copying — no realloc in arena mode), `sfn_array_concat`, and
`sfn_array_slice` (non-allocating view). `SfnSlice<u8>` is the canonical
borrowed-string type; slices never own their data and are never freed.

**Map / filter / reduce.** The Sailfin-native bodies (`sfn_array_sfn_map` /
`_filter` / `_reduce` in `runtime/sfn/array.sfn`) iterate the array and invoke a
typed closure per element over the runtime-callable closure-apply seam. The closure
arrives as the by-value `{i8*, i8*}` (fn-ptr + env) pair; the emitter extracts the
fn-ptr and prepends the env to the call — the same closure-dispatch path a
capturing lambda exercises. The method forms `arr.map` / `arr.filter` /
`arr.reduce(init, …)` route through these helpers. This is the **pointer-width
surface only**: callback ABIs are `iN(i8* env, i64 …)`, so element/accumulator types
are `i64` (`int[]`). Generic / non-pointer-width element types (`float[]`,
`string[]`, struct arrays) require generic constraints and are rejected with a
diagnostic rather than mis-mapped — designed in SFEP-0028. Closures with capture
(the gating prerequisite, epic #1118) are what unblocked these bodies.

### 3.5 Exception / unwind subsystem

**Decision: explicit exception frames, not LLVM landing pads.** Landing pads
(`invoke` + `landingpad` + personality) require a full Itanium C++ or SJLJ unwind
personality — a large surface for a v0 runtime. The compiler already emitted
exception handling as branching logic; moving to explicit frames (a lighter
`setjmp`/`longjmp`-backed mechanism) is a smaller step. The happy-path cost is one
stack allocation and one pointer write per `try` block; the throw path walks the
frame chain, which is fast because throws are exceptional. Landing pads can be
adopted post-1.0 as an optimization without changing the API.

```
struct SfnExceptionFrame { prev: SfnExceptionFrame*; jmp_buf: i8[JMPBUF_SIZE]; message: SfnString }
```

The frame is stack-allocated by the compiler at `try` entry; thread-local storage
holds a pointer to the current frame head. `setjmp`/`longjmp` are reached via
`extern fn` in `platform/libc.sfn`; the `jmp_buf` is an opaque byte array sized to
the platform's `_JMPBUF_SIZE` (≈200 bytes on Linux x86_64, 192 on macOS arm64) — the
runtime never interprets its contents.

API: `sfn_try_enter(frame) -> i32` (push frame onto the TLS chain, call `setjmp`; 0
on first entry, non-zero on throw), `sfn_try_leave(frame)` (pop), `sfn_throw(message)
-> noreturn` (write message into the top frame, pop, `longjmp`),
`sfn_take_exception(frame) -> SfnString` (read the caught message).

**Drop-on-unwind (v0):** the compiler emits cleanup at catch entry. It knows which
locals are live at each `try` scope and emits drops for all owned in-scope locals at
the catch entry point, each guarded by an init-sentinel (null/zero check) so partial
initialization on the throw path stays sound. A future alternative — per-frame
cleanup-handler lists iterated on throw — is cleaner but heavier and deferred
post-1.0.

This frame-based system replaced the prior TLS `has_exception` polling
(`call @sfn_has_exception()` / `br i1` after every call): polling disappears from the
happy path, and frame management adds cost only at `try`/`catch` boundaries.

### 3.6 Type metadata and reflection

The compiler emits an `SfnTypeDescriptor` global constant per named type:

```
struct SfnTypeDescriptor { id: i64; name: SfnString; kind: i32; field_count: i32; fields: SfnFieldDescriptor* }
struct SfnFieldDescriptor { name: SfnString; type_id: i64; offset: i32 }
```

`kind` enumerates PRIMITIVE=0, STRUCT=1, ENUM=2, INTERFACE=3, ARRAY=4, FUNCTION=5.
A global type registry, populated at module init, maps type IDs to descriptor
pointers (open-addressing hash map, power-of-two capacity). API:
`sfn_type_register(desc)` (per type at module init), `sfn_type_of(ptr,
type_id_hint)` (the compiler passes a constant-folded hint when the static type is
known; dynamic values carry a type-ID tag in their first field), `sfn_instance_of(ptr,
type_id)`, and `sfn_field_of(ptr, field_name, desc)` (dynamic field access via the
offset table).

**Minimum viable vs. full.** v0 emits **id + name + kind** only; field descriptors
are added incrementally as the prelude's reflection surface demands them, because
full descriptors require the compiler to emit per-type layout information it does not
currently compute everywhere.

### 3.7 Scheduler and concurrency

**Design decision: fixed thread pool with a shared MPMC task queue, not
work-stealing.** A work-stealing scheduler (per-thread deques, atomic stealing,
timer wheels, I/O reactor) is inappropriate for v0, where the concurrency surface
(`spawn`, `channel`, `parallel`, `serve`, `routine`) is implemented for the first
time. All thread and synchronization primitives are reached via `extern fn` in
`platform/pthread.sfn`; `PthreadMutex` / `PthreadCond` are opaque byte arrays sized
per target.

```
struct Scheduler { threads: *Pthread; thread_count: i64; queue: TaskQueue*; shutdown: i64 }
struct Task { fn_ptr: fn(i8*) -> i8*; ctx: i8*; result: i8*; done: i64; cond: PthreadCond; mutex: PthreadMutex }
```

**Pool size:** `min(available_cores, 32)` by default, overridable with
`SAILFIN_THREADS=N` (the 1024 explicit-override ceiling is unchanged; the cap was
raised from an earlier 4 so an I/O-bound proxy/server is not throttled — #1584).

**Task lifecycle** (in `runtime/sfn/concurrency/scheduler.sfn`, #1089):
`sfn_task_create(fn_ptr, ctx) -> *u8` (allocate + init a `Task`, mutex/cond
initialised, `result`/`done` zeroed); `sfn_task_run(task)` (the worker invokes
`fn_ptr(ctx)`, stores `result`, sets `done` via a seq_cst atomic store, signals
`cond`); `sfn_task_join(task) -> *u8` (block on `cond` under `mutex` until `done`
via a seq_cst atomic load, then return `result`); `sfn_task_destroy(task)`. The
worker reaches `fn_ptr` through the **plain C-ABI function-pointer indirect call**
primitive: `Task.fn_ptr` (a raw `i64` address) is cast to `* fn (* u8) -> * u8` and
called — a bare code pointer, the env-less sibling of the closure-application case,
lowering to a typed-fn-ptr `bitcast` + `call` with no hidden environment argument.
The public `sfn_spawn`/`sfn_await`/`SfnFuture` wrapper builds on this surface.

**Channel.**

```
struct Channel<T> { buffer: SfnArray<T>; capacity: i64; head: i64; tail: i64; mutex: PthreadMutex; not_empty: PthreadCond; not_full: PthreadCond; closed: i64 }
```

`sfn_channel_create(capacity, elem_size)`, `sfn_channel_send(ch, elem) -> bool`
(blocks if full, false if closed), `sfn_channel_recv(ch) -> T` (blocks if empty;
throws if closed and empty), `sfn_channel_close(ch)`.

**Parallel.** `sfn_parallel(tasks, Arena*) -> SfnArray<T>` — spawn all, await all,
return results in order; a convenience built on spawn+await.

**Serve.** `sfn_serve(handler, port)` — a blocking accept loop on a listening
socket dispatching each connection to the thread pool (no async I/O in v0).
Per-connection tasks are **detached** (fire-and-forget): the server never joins
them, so they are created via `sfn_task_create_detached` and the pool worker that
runs each one reclaims its `Task` after the body returns (`sfn_scheduler_worker`,
#1203) — without this the server leaked one `Task` per connection. The joinable
`spawn`/`await` path is unchanged (`detached = 0`, reclaimed by the joiner).

**Routine nursery (structured concurrency).** `routine { }` is a
structured-concurrency boundary, not a plain block. It lowers (#1181) to a real
nursery scope backed by `runtime/sfn/concurrency/nursery.sfn`:

- **Entry** emits `call i64 @sfn_nursery_enter()`, which allocates a `Nursery`, links
  it to the executing thread's previous current nursery as `parent`, and pushes it as
  current. The current nursery is a per-thread `thread_local`
  (`_sfn_g_current_nursery`) — two threads each inside their own `routine` must not
  clobber each other's nursery, so a process-global would be incorrect.
- **Registration:** every `spawn` funnels through `sfn_spawn`, which consults
  `sfn_nursery_current()` and calls `sfn_nursery_register(n, task)` before enqueueing,
  so the nursery owns tasks spawned anywhere in its *dynamic extent* (including in
  callees), not just lexically inside the block. The registration list is a
  mutex-guarded growable buffer of `Task` addresses.
- **Exit** emits `call i64 @sfn_nursery_exit(...)`, a structured-join barrier that
  `sfn_task_join`s every registered child, then pops the nursery (restoring `parent`).
  Control cannot leave the routine until all children complete: **no task spawned in
  a routine outlives its scope.**

Fail-closed stances: non-local exit (`return`/`throw`/`break`/`continue`) out of a
routine is rejected at lowering (it would branch past the join and leak tasks); a
registration that cannot grow its list sets the nursery's `faulted` flag (returned
by `sfn_nursery_exit`) rather than silently dropping the task. v0 deliberately
defers cancel-siblings-on-fault (it does join-all, not cancel-all), freeing joined
`Task` allocations (a user may also `await` the future), and cross-thread nursery
inheritance.

**Future considerations.** Post-1.0 the scheduler can evolve toward work-stealing,
and the nursery can grow cancellation tokens and cancel-on-fault propagation (the
`parent` link and `faulted` code are the forward-compatible seams). The v0 thread
pool + mutex design does not preclude this — it is a simpler starting point that
validates the API surface.

### 3.8 Capability adapters and I/O primitives

Capability adapters bridge the effect system and OS resources. Each is gated by a
capability grant: calling a filesystem adapter without an `![io]` effect on the call
chain is a compile-time error enforced by the existing effect checker (§4).

**Filesystem** (`adapters/filesystem.sfn`, libc via `platform/libc.sfn`, handles
path NUL-termination internally): `sfn_fs_read_file(path, Arena*)` — the ported form
returns `Result<SfnString, Error>` now that `Result<T, E>` + `?` ship (SFEP-0012,
spec §12) — plus `sfn_fs_write_file`, `sfn_fs_append_file`, `sfn_fs_exists`,
`sfn_fs_list_dir`, `sfn_fs_delete`, `sfn_fs_mkdir`. All functions returning allocated
data take an `Arena*`; `Result` error returns replace thrown exceptions as functions
are ported.

**HTTP** (`adapters/http.sfn`, sockets via `platform/net.sfn`): `sfn_http_get(url,
Arena*)`, `sfn_http_post(url, body, headers, Arena*)`. HTTP/1.1 only in v0; TLS
requires linking OpenSSL or similar (an explicit trade-off), and a curl-subprocess
fallback can remain as a capability-adapter option until a TLS story is decided.
(The typed user-facing surface is SFEP-0019.)

**Model** (`adapters/model.sfn`): a stub in v0. The `![model]` effect is enforced at
compile time, but runtime model invocation is post-1.0.

**Clock** (`adapters/clock.sfn`): `sfn_clock_millis() -> i64` via `extern fn
clock_gettime` in `platform/posix.sfn`; `sfn_sleep(milliseconds: float)` via
`extern fn nanosleep`. The unit (milliseconds) is the public contract end-to-end
across `runtime/sfn/clock.sfn`, the `sleep(ms)` prelude surface, and the
`sfn/time` capsule (audited and locked across all layers, #307).

**I/O and timing primitives** (`io.sfn`): `sfn_print(msg)` (calls `extern fn write`
with fd=1), `sfn_print_err` (fd=2), `sfn_print_info/warn/error` (prefix then
delegate), `sfn_getenv(name, *Arena)` (NUL-terminate, call `extern fn getenv`, wrap),
`sfn_home_dir(*Arena)` (`sfn_getenv("HOME")`).

**Platform extern declarations** (`platform/*.sfn`): pure Sailfin `extern fn`
declarations; the compiler emits LLVM `declare` directives the linker resolves
against libc/libpthread at link time. The shipped skeletons cover libc, pthread,
posix, and net. Rules for `extern fn` signatures: (1) only C-ABI-compatible types
cross the boundary — no `SfnString`/`SfnArray<T>`/RC'd types (the adapter decomposes
aggregates into pointer+length pairs); (2) NUL-termination is the caller's job for
any pointer POSIX treats as a C string; (3) lifetime stays on the Sailfin side —
memory passed to an extern must outlive the call, and memory returned is not
auto-tracked by RC (adapters immediately wrap return values into arena- or
RC-managed types); (4) no effect checking on externs — they are raw syscall
surfaces; effect enforcement happens at the adapter above them (§4).

Two shipped-form deviations from the original design target are worth noting because
they recur in the code: function-pointer parameters degrade to `* u8` because
`sfn fmt` rewrites `fn(...)` to `fn (...)` and the typechecker's
`is_c_abi_function_pointer` requires the literal `fn(` prefix (they lower identically
to `i8*`; only the type-discipline signal weakens), and `pthread_t` is modelled as
`usize` (out-param `* usize`, by-value bare `usize`) because libpthread passes it by
value and it is pointer-sized but not a struct pointer.

**Platform-conditional compilation.** Opaque struct sizes (`PthreadMutex`,
`PthreadCond`, `JmpBuf`) vary by platform. v0 selects one of several `.sfn` files per
target (e.g. `platform/pthread_linux_x86_64.sfn`, `platform/pthread_macos_arm64.sfn`)
rather than introducing compile-time target constants — explicit over compiler
machinery. Variadic externs (`snprintf`) are avoided: number-to-string formatting is
hand-rolled in Sailfin (the Rust `std::fmt` approach).

### 3.9 Compiler integration

The runtime's correctness depends on several compiler-side capabilities. These are
recorded here as the contract between the compiler and the runtime; the user-facing
ABI is the normative reference (`runtime-abi.md`).

#### 3.9.1 Drop emission at scope exit

The seam is `LocalBinding.allocation_kind: "arena" | "rc" | "static" | "stack"` on
`compiler/src/llvm/types.sfn`, plus a single `emit_scope_drops` funnel in
`instructions_helpers.sfn`. Arena bindings emit nothing at scope exit (bulk reset
handles them), `"rc"` bindings emit `call void @sfn_rc_release`, and `"static"` /
`"stack"` are no-ops. Every drop site funnels through `emit_scope_drops` so the
policy lives in one place and reviewers can audit it independently of the call sites;
`emit_scope_drops` reads `OwnershipInfo.variant` to skip borrows.

**Conservative escape rule (v0):** a `let x = ...` defaults to `"arena"`; promotion
to `"rc"` happens only at compiler-known boundaries — in v0, **function-return
promotion only** (the compiler already knows which values flow into a `ret`).
Closure-capture and channel-send promotion follow once those features land. The
function-return promotion (`lower_return_instruction`) covers exactly
`return <ident>;` where `<ident>` resolves to a heap-typed local, and `is_heap_type`
accepts only **pointer-suffixed** LLVM types (`i8*`, `%MyStruct*`, `i8**`) — the
shapes `emit_scope_drops` already knows how to release via load + bitcast +
`sfn_rc_release(i8*)`. By-value aggregate shapes (`{i8*, i64}` for SfnString,
`{T*, i64, i64}` for SfnArray, union payloads) are intentionally excluded: drop
emission cannot bitcast an aggregate to `i8*`, so promoting one would drop the wrong
pointer or produce invalid LLVM. **The predicate must widen in lockstep with drop
emission learning to extract the heap pointer field — never one without the other.**
`promote_local_to_rc` in `core_scopes.sfn` flips the matching binding from `"arena"`
to `"rc"`, mirroring `find_local_binding`'s "last match wins" semantics so a shadowed
inner binding does not promote its outer namesake. Borrows
(`OwnershipInfo.variant == "Borrow"`) are never promoted — releasing a borrowed alias
would double-free. The ownership model that makes these promotion/aliasing rules sound
is specified by SFEP-0018.

The required compiler changes touch `instructions.sfn` (scope-exit and
mid-function-exit emission), `instructions_try.sfn` (catch-entry cleanup with
init-sentinel null-checks), `core_scopes.sfn` (`append_local_binding` records
`allocation_kind`), and `instructions_helpers.sfn` (the `emit_scope_drops` helper).

#### 3.9.2 ABI version metadata

`module_globals.sfn` emits module-level globals so the runtime can detect mismatches
at load time:

```llvm
@sfn_abi_version = constant i32 1
@sfn_abi_hash = constant [8 x i8] c"a1b2c3d4"
```

The runtime's init checks these against its compiled-in values and aborts with a
diagnostic on mismatch. The version increments whenever a struct layout changes
(e.g. `SfnString` gains a field, `SfnArray` reorders); the hash is derived from the
concatenation of all runtime struct layouts.

#### 3.9.3 Typed closures

The canonical user-facing ABI is `runtime-abi.md` § Typed Closures (it supersedes
any sketch here). A closure lowers to a struct pair — an environment of captured
variables and a `{env*, fn*}` pair where the function pointer takes the environment
as its argument. The compiler allocates the environment (arena or RC by context),
copies captured values in (`sfn_rc_retain` for RC values), and passes the pair to
`sfn_spawn` / `sfn_channel_send` / map-filter-reduce. This is what closures with
capture (epic #1118) unblocked.

#### 3.9.4 Atomic intrinsics

Six compiler builtins lower directly to LLVM atomics (not library functions; the user
cannot define them):

| Sailfin builtin | LLVM | Use |
|---|---|---|
| `atomic_add(ptr: *i64, delta: i64) -> i64` | `atomicrmw add` | RC retain, counters |
| `atomic_sub(ptr: *i64, delta: i64) -> i64` | `atomicrmw sub` | RC release, counters |
| `atomic_load(ptr: *i64) -> i64` | `load atomic` | Flag reads |
| `atomic_store(ptr: *i64, value: i64) -> void` | `store atomic` | Flag writes |
| `atomic_cas(ptr: *i64, expected: i64, new: i64) -> bool` | `cmpxchg` | Lock-free queues, futures |
| `atomic_fence() -> void` | `fence seq_cst` | Memory ordering barriers |

Arity/type validation (E0806) is enforced during LLVM lowering in
`compiler/src/llvm/atomics.sfn`. Memory ordering is `seq_cst` in v0
(simple/correct); relaxed/acquire/release variants are post-1.0. These are the sound
substrate for RC (§3.2.2) and the scheduler (§3.7).

#### 3.9.5 Extern function lowering

`extern fn` (optionally `unsafe`-prefixed) produces
`Statement.ExternFunctionDeclaration { signature, unsafe, decorators }`. The
typechecker registers externs in the same symbol table as regular fns
(`kind: "extern function"`, so duplicate-name detection works across `extern fn` and
`fn`) and runs `check_extern_signature` (`typecheck_types.sfn`) for C-ABI
compatibility:

| Code | Meaning |
|---|---|
| `E0801` | parameter or return uses the Sailfin `string` aggregate |
| `E0802` | parameter or return uses a `T[]` array |
| `E0803` | extern declares type parameters (generic externs forbidden) |
| `E0804` | extern declares effects (effects belong on the wrapping adapter) |
| `E0805` | unrecognized type name (catch-all; rejects legacy `number`) |

The accept-list is the intersection of "valid C-ABI" and "what
`map_primitive_type` lowers today": `i8`, `i32`, `i64`, `u8`, `usize`, `bool`,
`void` (return only), `*T` recursively (with `const`/`mut`, including `*void`),
`*<UpperCamelStruct>` opaque pointers, and `fn(A, B) -> C` function pointers whose
argument/return types are themselves C-ABI. Wider numeric widths (`i16`/`u16`/`u32`/
`u64`/`isize`/`f32`/`f64`) lower at the extern boundary once added to
`map_primitive_type` (admitting them at typecheck before the mapping exists would let
an extern lower silently to `i8*` and produce ABI-mismatched IR). Native-IR emits
`.fn <name>` + `.meta extern`; LLVM lowering emits a top-level
`declare <ret> @<name>(<args>)` directive, and call sites emit `call @fname(args...)`
with direct argument passing — no wrapper, no marshalling. Type mapping: `i32`/`i64`/
`f64`/`bool` map to themselves; `*T` and `*OpaqueStruct` to `i8*` (opaque pointer
post-LLVM 15); `fn(A,B)->C` to `C (A, B)*`.

`extern fn` is **additive** to self-hosting: no `compiler/src/*.sfn` file declares an
extern, so the new typecheck branch is a no-op on the existing tree — the seed does
not run the new code, and the freshly-built compiler finds zero externs in its own
source.

#### 3.9.6 Numeric types (`int` / `float`)

The runtime ABI requires `len`, `cap`, and `index` to be true integers, which
required `int` (i64) / `float` (f64) annotations to lower correctly. They do:
annotated locals/parameters/returns lower `int` → `i64` and `float` → `double` in
`map_primitive_type` (both the `type_mapping.sfn` and the `statement_type_mapping.sfn`
copies); bitwise/shift operators on integer operands lower to `and`/`or`/`xor`/`shl`/
`ashr i64`; bare unsuffixed integer literals default to `int` at scalar context; and
`expr as Type` lowers through the cast matrix (`sitofp`/`fptosi`/`sext`/`zext`/`trunc`/
`fpext`/`fptrunc`, with `as bool` rejected, fix-it `x != 0`). Mixed int↔float
arithmetic is refused at the `dominant_type` chokepoint with a `[fatal]` diagnostic
carrying the fix-it `add \`as float\` or \`as int\` to disambiguate`; `as` casts are
the load-bearing escape valve. `number` survives as a deprecated alias for `float`
(both map to `double`) pending its eventual removal. The full slice history is
detailed in `docs/status.md` and SFEP-0005 (colon type annotations); the durable
point is that the runtime ABI's integer fields are real integers.

#### 3.9.7 Runtime helper registry

`compiler/src/llvm/runtime_helpers.sfn` is the single point where call emission
resolves a runtime operation to a backing symbol, via `find_runtime_helper`
(lowering resolves `native_signature ?? symbol`). Descriptors carry native types
(`{i8*, i64}` for SfnString, `{T*, i64, i64}*` for SfnArray, `i64` for indices) and
the canonical `sfn_*` symbol names. The audit invariant the registry enforces is that
**every replaced operation's emitted call lands on the canonical `sfn_*` symbol** —
achieved either through direct sfn import (the type-meta cluster) or through the
registry's `native_signature` routing. Because every drop/lowering decision funnels
through this registry, swapping a backing implementation is a registry edit, not a
sweep across call sites.

## 4. Effect & capability impact

This is the structural enabler for Sailfin's pillar 2 (capability-based security).
Because the runtime is pure Sailfin and reaches the OS only through `extern fn`
declarations the compiler can see, the effect checker can gate the syscall surface:
capability adapters (`adapters/*.sfn`) carry the effect annotation (`![io]`,
`![net]`, `![clock]`, `![model]`), and `extern fn` declarations carry **no** effects
(E0804 rejects them) — effect enforcement happens at the adapter that wraps the raw
syscall, never on the raw syscall itself. Calling a filesystem adapter without `![io]`
on the call chain is a compile-time error in the existing effect checker. This
arrangement is what SFEP-0016 (the capability-sealed runtime) builds on to enforce
effects "to the syscall" as a 1.0 GA hallmark; this SFEP supplies the runtime
structure that seal requires and does not restate the seal's enforcement design.

## 5. Self-hosting impact

The runtime rewrite touched every compiler pass, but each capability was designed to
be **additive to the seed** so the self-host invariant held at each step:

- **Parser / AST:** `extern fn` declarations parse to a new statement node; the seed
  ignores syntax it never emits, and no `compiler/src/*.sfn` file declares an extern,
  so the new branches are no-ops on the existing tree.
- **Typecheck / effects:** `check_extern_signature` (E0801–E0805) and the
  no-effects-on-externs rule (E0804) only fire on extern declarations, which the
  compiler source does not contain; the effect checker's adapter gating is unchanged
  for compiler source.
- **Native emitter:** `.meta extern` rows are emitted only for externs.
- **LLVM lowering:** the drop-emission seam (`allocation_kind` + `emit_scope_drops`),
  the ABI version globals, the atomic intrinsics, and the numeric-type mappings all
  default to behavior identical to the pre-rewrite tree until a feature is actually
  used; the conservative escape rule only promotes function-return idents whose LLVM
  type is pointer-suffixed, so it never produces invalid IR for the existing aggregate
  corpus.

The standard gate — `make compile` (self-host from the pinned seed) followed by
`make check` (triple-pass + suite) — pinned each PR, and a determinism sweep on the
lowering core confirmed byte-identical IR across runs (drop emission must be
deterministic). The historical milestone sequencing that staged these changes
(arena-in-C unblocker, ABI lock, drop emission, core runtime, adapters, scheduler,
native CLI) is complete; the runtime now self-hosts with zero C linked, and the
`runtime/native/` tree is deleted.

## 6. Alternatives considered

- **A hand-written C runtime bridge (the status quo ante).** Rejected: it leaves a
  non-Sailfin component in the toolchain, contradicting the 1.0 pure-Sailfin goal, and
  carried heavy defensive overhead (owned-string hash table, pointer plausibility
  set, strlen scans, per-array headers/canaries). The `extern fn` model reaches the
  same syscalls from Sailfin source.
- **Tracing garbage collection.** Rejected for v0: arena + RC is sufficient and
  predictable; a tracing GC is a large surface with pause-time concerns. Cycles are
  discouraged by the type system; weak references are a post-1.0 fallback if needed.
- **Full escape analysis before shipping RC.** Rejected as a blocker: the conservative
  rule (arena by default, RC at compiler-known boundaries, function-return promotion
  only in v0) is sound without interprocedural reasoning and matches what the compiler
  already tracks. Interprocedural escape analysis is post-1.0 polish.
- **LLVM landing pads for exceptions.** Rejected for v0 (§3.5): they require a full
  unwind personality with platform-specific behavior; explicit `setjmp`/`longjmp`
  frames are a few hundred lines and the API survives a later landing-pad swap.
- **Work-stealing scheduler.** Rejected for v0 (§3.7): too complex to introduce
  alongside a first-time concurrency surface; the fixed thread pool + MPMC queue
  validates the API and leaves a forward-compatible path (the `parent`/`faulted`
  nursery seams) to work-stealing post-1.0.
- **`SfnValue` tagged union for dynamic dispatch.** Rejected for v0: prelude `any`
  paths lower to `i8*` today; introduce `SfnValue` only if a concrete use case (e.g.
  type-preserving serialization round-trips) requires it.
- **Compile-time target constants for opaque struct sizes.** Rejected for v0 in favor
  of platform-conditional `.sfn` modules selected by the build — explicit, requiring
  no new compiler feature. Revisit if the maintenance cost grows.
- **Variadic `extern fn` (for `snprintf`).** Rejected for v0: number formatting is
  hand-rolled in Sailfin (the Rust `std::fmt` approach), avoiding variadic
  declarations entirely. Variadic externs are a post-1.0 addition if third-party C
  libraries need them.
- **String interning / pooling.** Rejected for v0: a global table with concurrent
  locking and per-allocation hashing does not help the compiler's unique-string hot
  path; it can be added later as an arena subsystem without an ABI change.

## 7. Stage1 readiness mapping

This SFEP records an architecture whose subsystems ship in the tree; per-subsystem
status is tracked in `docs/status.md`. Against the checklist:

- [x] Parses — `extern fn`, `as` casts, `int`/`float`, `routine`, concurrency syntax.
- [x] Type-checks / effect-checks — `check_extern_signature` (E0801–E0805), adapter
      effect gating, atomic arity (E0806).
- [x] Emits valid `.sfn-asm` — `.meta extern` rows; native-IR for all subsystems.
- [x] Lowers to LLVM IR — drop emission, ABI globals, atomics, extern `declare`s,
      numeric mappings, closure/task/channel/nursery lowering.
- [x] Regression coverage — see §8.
- [x] Self-hosts — the compiler self-hosts with zero C linked; `runtime/native/`
      deleted (#822).
- [x] `sfn fmt --check` clean — runtime `.sfn` modules are formatter-clean (CI gate).
- [x] Documented — `docs/status.md`, `runtime-abi.md`, and the spec/preview chapters
      for the user-facing surfaces (concurrency, effects).

Non-goals (v0) remain out of scope and unenforced: SIMD layouts, GPU dispatch,
distributed scheduling, hot reload, user-facing `extern fn`, tracing GC, async I/O
(epoll/io_uring), string interning, full field-offset type descriptors, and a stable
external ABI (the ABI is versioned for internal compatibility checking only).

## 8. Test plan

The runtime subsystems are pinned by `compiler/tests/{unit,integration,e2e}/`:

- **Extern lowering:** `typecheck_extern_test.sfn` (accept paths + every E0801–E0805
  reject + same-name duplicate detection), `emit_native_extern_test.sfn` (parser →
  native-IR → `.meta extern` round trip), and the platform skeleton smoke tests
  (`runtime_libc_skeleton_test.sfn`, `runtime_io_skeleton_test.sfn`,
  `runtime_pthread_skeleton_test.sfn`, `runtime_posix_skeleton_test.sfn`,
  `runtime_net_skeleton_test.sfn`).
- **Drop emission:** e2e pins that an allocated-and-discarded RC value emits a release
  call and that try/catch unwind emits guarded drops; a determinism sweep on
  `instructions.sfn` shows byte-identical IR across 20 runs.
- **Atomics:** a two-thread `atomic_add` test produces the expected sum with no lost
  increments.
- **Numerics:** `numeric_int_float_test.sfn`, `numeric_bitwise_test.sfn`,
  `numeric_cast_test.sfn`, `numeric_int_default_test.sfn`,
  `numeric_int_float_coercion_test.sfn`, and `numeric_abi_mismatch_test.sfn`.
- **Concurrency:** `spawn`+`await` retrieves a worker result; a channel test sends and
  receives 1000 messages; a `parallel` test runs 4 tasks and collects results; a
  `serve` test handles concurrent requests on a test port without leaking a `Task` per
  connection; the routine nursery joins all registered children and rejects non-local
  exit.
- **Memory arena / escape:** `runtime_memory_arena_test.sfn` and
  `escape_promotion_channel_send_test.sfn` (with their ASAN-gated legs per
  `.claude/rules/compiler-safety.md`).
- **Self-host gate:** `make compile` + `make check` (triple-pass + full suite) is the
  load-bearing end-to-end proof, plus
  `check_build_agree_module_global_test.sfn` guarding the check/build agreement.

## 9. References

- `site/src/content/docs/docs/reference/runtime-abi.md` — the normative user-facing
  ABI contract this architecture confirms (struct layouts, typed closures).
- `docs/status.md` — what ships today (per-subsystem status, the numeric slice
  history).
- `docs/status.md` (Runtime Migration table) — the C→Sailfin migration tracker.
- `docs/proposals/0006-build-architecture.md` — perf analysis; the arena directly addressed its
  early phases.
- `SFEP-0005` — Colon Type Annotations (the `int`/`float`/`as`/`number` reform that
  the runtime ABI's integer fields depend on).
- `SFEP-0012` — `Result<T, E>` and the `?` Operator (adapter error returns).
- `SFEP-0015` — Toolchain Independence: a Sailfin-Native Backend (the backend that
  consumes this runtime ABI).
- `SFEP-0016` — The Capability-Sealed Runtime (enforcing effects to the syscall;
  builds on the structure recorded here).
- `SFEP-0018` — Borrow / Ownership Checking for the Native Runtime (the ownership
  model governing drop/promotion soundness).
- `SFEP-0019` — `sfn/http` Typed HTTP Surface (the user-facing layer over the HTTP
  adapter).
- Epics: #321 (runtime-rewrite reassessment), #322 (drop emission), #451 (native
  CLI/driver), #822/#823 (`runtime/native/` deletion), #1089 (scheduler/tasks),
  #1118 (closures with capture), #1181 (routine nursery), #1203 (detached
  per-connection tasks), #1209 (ownership floor).
