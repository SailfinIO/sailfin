# Sailfin-Native Runtime Architecture

**Date:** 2026-04-15 (last reviewed 2026-05-02 — see "Status delta" below)
**Author:** Compiler architect (design review)
**Companion docs:** `docs/runtime_audit.md` (current C runtime state),
`site/src/content/docs/docs/reference/runtime-abi.md` (target ABI), `docs/build-performance.md` (perf analysis)

> **Status delta.** Track milestone progress here so the body
> below stays consistent with the tree:
>
> - M0.5 arena-in-C: **shipped, default-on** (PRs #249, #251, #252).
> - M0 hard prerequisite #7 (`extern fn` typed linker-resolved symbols):
>   **shipped 2026-05-01** (parser + typecheck + native-IR + LLVM `declare`).
>   Cross-module call-site resolution is the remaining sub-step; see §3.6.
> - First `runtime/sfn/platform/libc.sfn` skeleton: **shipped 2026-05-01**
>   (12 extern declarations, typecheck + fmt + LLVM `declare` emission
>   verified by `compiler/tests/e2e/test_runtime_libc_skeleton.sh`). The
>   file is not yet imported anywhere — the runtime continues to reach
>   libc through the C runtime until M2.
> - **`int` (i64) / `float` (f64) numeric type annotations: shipped 2026-05-02**
>   (Phase 1 #2, Slice A — see §3.7). Annotated locals/parameters/return
>   types lower correctly to `i64` / `double` and feed the existing
>   integer-vs-float arithmetic dispatch. `extern fn` accept-list extended
>   to admit `int` / `float`. Slices B–E (bitwise ops, additional widths,
>   `as` casts, bare-literal defaulting + `number` retirement) are
>   sequenced follow-ups.
> - Other M0 items (`Result<T, E>` + `?`, closures with capture, atomic
>   intrinsics) remain planned.

This document is the architectural blueprint for the Sailfin-native runtime that
will replace the C runtime (`runtime/native/`) before the 1.0 release. It
describes system structure, subsystem designs, compiler integration requirements,
a sequenced milestone plan, and open decisions. It is intended to be
implementation-ready: someone picking up M1 should be able to read this doc and
know what to build, in what order, and what tests to write.

**Invariant: zero C source code in the 1.0 toolchain.** The shipped artifact is
a Sailfin compiler linked against a Sailfin runtime linked against platform
shared libraries (libc, libpthread). Every line of source code we author is
Sailfin. Platform syscalls are reached via `extern fn` declarations in `.sfn`
modules — the compiler emits LLVM `declare` directives, the linker resolves
them against platform libraries at link time. This is the Rust `std` model:
extern declarations in the language, not a hand-written C bridge.

The sole exception is the M0.5 arena-in-C (`runtime/native/src/sailfin_arena.c`),
which is an explicitly disposable temporary deleted at M3. No other C source file
is created at any phase.

---

## 1. System Overview

### 1.1 What the Runtime Is

The Sailfin-native runtime is a library linked into every compiled Sailfin
program. It provides:

- **Memory management** — arena allocation and reference counting.
- **Core data operations** — strings, arrays, slices.
- **Exception handling** — structured unwind with deterministic cleanup.
- **Type metadata** — descriptors for reflection and dynamic dispatch.
- **Concurrency primitives** — spawn, channels, parallel, serve.
- **Capability adapters** — filesystem, HTTP, model invocation, clock, process.
- **I/O primitives** — print, sleep, environment, timing.

### 1.2 What the Runtime Is Not

The runtime is not a virtual machine, not a garbage collector, not an operating
system abstraction layer. It does not interpret Sailfin source or bytecode. It
does not manage its own event loop in v0 (see §2.6 for the simple scheduler
design). It does not expose a user-facing `extern fn` mechanism in v0 — the
platform extern declarations are runtime-internal.

### 1.3 Layer Diagram

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

### 1.4 The Platform Syscall Boundary

The runtime reaches OS services through `extern fn` declarations in Sailfin
source files. These declarations produce LLVM `declare` directives; the linker
resolves them against platform shared libraries (libc, libpthread, etc.) at link
time. **No C source code is authored.** The boundary is a set of Sailfin type
signatures over externally-linked symbols — the same model Rust uses to reach
libc.

**Platform functions reached via `extern fn`:**

- **Memory:** `malloc`, `free`, `realloc`, `memcpy`, `memcmp`, `memchr`.
- **Threads:** `pthread_create`, `pthread_join`, `pthread_mutex_init/lock/unlock/destroy`, `pthread_cond_init/wait/signal/broadcast/destroy`.
- **Filesystem:** `fopen`, `fread`, `fwrite`, `fclose`, `stat`, `opendir`, `readdir`, `closedir`, `unlink`, `mkdir`.
- **Process:** `posix_spawnp`, `waitpid`.
- **I/O:** `write` (fd-based), `read` (fd-based).
- **Time:** `clock_gettime`, `nanosleep`.
- **Network:** `socket`, `connect`, `send`, `recv`, `bind`, `listen`, `accept`, `close`, `setsockopt`.
- **Environment:** `getenv`.
- **Exception support:** `setjmp`, `longjmp`.
- **String conversion:** `strtod`, `snprintf`.

**Types permitted across the extern boundary:** Only C-ABI-compatible layouts:
`i64`, `i32`, `i8`, `f64`, `bool`, raw pointers (`*u8`, `*File`,
`*PthreadMutex`), function pointers. Sailfin aggregate types (`SfnString`,
`SfnArray<T>`) do **not** cross the boundary — the adapter layer decomposes them.

**Opaque platform types:** Types whose internal layout is unknown to Sailfin
(e.g., `pthread_mutex_t`, `jmp_buf`) are declared as opaque structs with
platform-specific size constants (`struct PthreadMutex { _opaque: i8[PTHREAD_MUTEX_SIZE] }`).
The build system selects the correct sizes per target platform.

### 1.5 Source Layout (Target)

```
runtime/
  prelude.sfn                   # User-facing facade (exists today, evolves)
  sfn/
    memory/
      arena.sfn                 # Arena allocator
      rc.sfn                    # Reference counting
    string.sfn                  # SfnString operations
    array.sfn                   # SfnArray<T> operations
    slice.sfn                   # SfnSlice<T> operations
    exception.sfn               # Exception frames, throw, try/catch plumbing
    type_meta.sfn               # Type descriptors, registry, reflection
    io.sfn                      # Print, sleep, timing, env
    process.sfn                 # Process spawn
    scheduler.sfn               # Task scheduler (M4)
    channel.sfn                 # Channel<T> (M4)
    crypto.sfn                  # SHA-256, base64 (pure Sailfin)
    adapters/
      filesystem.sfn            # fs.readFile, writeFile, etc.
      http.sfn                  # HTTP client
      model.sfn                 # Model invocation adapter
      clock.sfn                 # Clock/timing adapter
    platform/
      libc.sfn                  # extern fn: malloc, free, fopen, write, memcpy, setjmp, etc.
      pthread.sfn               # extern fn: pthread_create, mutex, cond, etc.
      posix.sfn                 # extern fn: posix_spawnp, waitpid, clock_gettime, nanosleep
      net.sfn                   # extern fn: socket, connect, send, recv, etc.
```

Every file in this tree is a `.sfn` module. There is no `.c` or `.h` file.

---

## 2. Subsystem Designs

### 2.1 Memory Management (Arena + RC Hybrid)

This is the central subsystem. The audit's call for a hybrid arena+RC model is
**confirmed**, with specific design decisions below.

#### 2.1.1 Arenas

An arena is a bump allocator backed by a linked list of memory pages. Allocation
is a pointer bump; deallocation is bulk reset of the entire arena.

```
struct ArenaPage {
    data: i8*       // Backing memory (malloc'd)
    capacity: i64   // Page size in bytes
    used: i64       // Current bump offset
    next: ArenaPage* // Next page in chain (null for last)
}

struct Arena {
    current: ArenaPage*    // Active page (bump target)
    first: ArenaPage*      // Head of page list (for reset/destroy)
    default_page_size: i64 // Default page size (e.g. 64 KiB for user, 1 MiB for compiler)
}
```

**API:**
- `sfn_arena_create(page_size: i64) -> Arena*` — allocate a new arena.
- `sfn_arena_alloc(arena: Arena*, size: i64, align: i64) -> i8*` — bump-allocate
  `size` bytes aligned to `align`. If the current page cannot fit the request,
  allocate a new page (max of `default_page_size` and `size + align`).
- `sfn_arena_reset(arena: Arena*) -> void` — reset all pages to `used = 0`.
  Does **not** free backing pages; retains them for reuse.
- `sfn_arena_destroy(arena: Arena*) -> void` — free all backing pages and the
  arena itself.

**Grow-if-at-tip realloc.** The M0.5 C arena supports a limited realloc
(`sfn_arena_realloc`) optimized for the `string_append` hot path: if the
pointer being reallocated is the last allocation on the current page and the
page has room, the bump pointer is simply extended in place (no copy). Otherwise
a new region is allocated and data is copied. The planned Sailfin-native arena
(M2+) may drop realloc in favor of a simpler alloc-only API if profiling shows
the tip-growth optimization is not worth the complexity.

The rationale:
1. Arena allocations are O(1) bump operations — the copy cost dominates, which
   is the same as `realloc` when it can't grow in place.
2. The "wasted" old buffer is reclaimed in bulk at arena reset.
3. Grow-if-at-tip adds minimal complexity (~15 lines) and eliminates copies in
   the common `string_append` loop pattern.

**Compiler arena vs. user-program arena:**

The compiler runs as a batch process that compiles one module per invocation.
It gets a single process-level arena created at startup and destroyed at exit.
All compiler-internal allocations (AST nodes, IR strings, lowering intermediates)
go through this arena. The arena is never reset mid-process in the current
per-process-per-module model. When the long-lived compiler process lands (build-
performance Phase 5), the arena resets between modules.

User programs can create explicit arenas via `Arena.create()` for request-scoped
or batch-scoped allocation. The prelude does not expose arenas implicitly — they
are an opt-in performance tool, not a default allocation strategy. User-program
allocations that don't use an explicit arena go through the default RC path.

**Compiler emission requirements:**
- The compiler must thread an arena pointer through functions that allocate into
  it. For the compiler's own compilation (self-hosting), this is a single global
  arena passed implicitly. For user programs, the compiler emits arena parameters
  only for functions explicitly annotated or inferred to use arena allocation.
- The **minimal viable approach** (M1): the compiler emits a global
  `@sfn_default_arena` that is initialized at program startup and destroyed at
  exit. All string and array allocations route through this arena unless the
  function is annotated to use a specific arena. This avoids threading arena
  parameters through every function signature during the initial transition.
- The **target approach** (post-M2): escape analysis marks values that can be
  arena-allocated vs. values that must be RC'd. Functions that accept arena-
  allocated parameters receive an implicit arena handle.

#### 2.1.2 Reference Counting

RC is used for values that outlive their originating scope or arena — values
captured by closures, sent to channels, stored in long-lived collections, or
returned from functions where the caller's lifetime is unknown.

```
// RC header prepended to heap-allocated values
struct RcHeader {
    refcount: i64    // Atomic for thread safety
    drop_fn: fn(i8*) -> void  // Destructor (calls element drops, then frees)
}
```

**Atomic operations for RC:** The `refcount` field is modified using LLVM
atomic intrinsics emitted directly by the compiler — not through a C helper
and not through platform `pthread_mutex` calls. `sfn_rc_retain` emits
`atomicrmw add`, `sfn_rc_release` emits `atomicrmw sub` (see §3.5).
This requires the compiler to expose atomic intrinsics as Sailfin builtins
(`runtime_audit.md` soft prerequisite #12, hard for M2).

**API:**
- `sfn_rc_alloc(size: i64, drop_fn: fn(i8*) -> void) -> i8*` — allocate a
  new RC'd value with refcount = 1. Returns a pointer to the payload (header
  is at `ptr - sizeof(RcHeader)`).
- `sfn_rc_retain(ptr: i8*) -> void` — atomic increment refcount.
- `sfn_rc_release(ptr: i8*) -> void` — atomic decrement; if refcount reaches
  zero, call `drop_fn(ptr)` then free the header+payload.

**When the compiler emits RC vs. arena:**

In the absence of full escape analysis (which is not a hard prerequisite —
see §4), the compiler uses a conservative rule:

1. **Arena by default** for all local allocations within a function scope.
2. **RC at boundaries**: any value that crosses one of these boundaries gets
   `sfn_rc_alloc` instead of `sfn_arena_alloc`:
   - Returned from a function (caller's lifetime is unknown).
   - Captured by a closure.
   - Sent to a channel.
   - Stored in a heap-allocated collection that outlives the current scope.
3. **Static** for string literals and global constants (no RC, no arena —
   they live in `.rodata`).

This conservative rule over-counts RC allocations (some returned values could
stay in the caller's arena), but it is correct without escape analysis and
matches the existing compiler's capability to track "this is a return value."

**Cycle handling:** None in v0. The type system discourages cycles (no raw
pointers in safe code, no self-referential structs without explicit indirection).
If cycles become a problem post-1.0, the options are weak references or a
cycle-detecting tracing pass — but designing for this now would be premature.

#### 2.1.3 Drop Emission

The compiler must emit explicit `drop` calls at scope exit for every value that
owns heap state. This is the critical compiler prerequisite.

**Scope exit points where drops are emitted:**
1. End of a function body (before the `ret` instruction).
2. End of a block scope (`if`/`else` body, `for` body, `loop` body, `match`
   arm body).
3. Before a `return` in the middle of a function.
4. Before a `break` or `continue` that exits a scope containing owned values.
5. In exception unwind paths (between the raise site and the catch landing pad).

**What the compiler emits:**
```llvm
; For an arena-allocated value:
; Nothing — arena reset handles bulk deallocation.

; For an RC-allocated value:
call void @sfn_rc_release(i8* %my_value)

; For a value with a custom drop (e.g. an SfnArray<T> whose elements need dropping):
call void @sfn_drop_SfnArray_SfnString(i8* %my_array)
; (where sfn_drop_SfnArray_SfnString iterates elements, calls sfn_rc_release on each,
;  then calls sfn_rc_release on the array itself)
```

**Interaction with the current lifetime tracking:** The compiler already has
`LifetimeRegionMetadata`, `LifetimeReleaseEvent`, `ScopeMetadata`, and
`OwnershipInfo` types in `compiler/src/llvm/types.sfn`. The current lifetime
system tracks borrow regions and detects use-after-move. Drop emission extends
this: at each `LifetimeReleaseEvent`, the compiler emits the appropriate drop
call based on the value's ownership kind (arena → nothing, RC → release, custom
→ generated drop function).

**Critical correctness constraint:** The compiler must not emit drops for
borrowed values (`&T`, `&mut T`). Borrows are non-owning; the owner drops.
The existing `OwnershipInfo.variant` field (which distinguishes "owned", "borrow",
"borrow_mut") provides the information needed. If the variant is a borrow, no
drop is emitted.

### 2.2 String Subsystem

#### 2.2.1 Representation

```
struct SfnString {
    data: u8*    // UTF-8 bytes, NOT NUL-terminated, may be null when len == 0
    len: i64     // Byte length
}
```

This matches `runtime_abi.md` Part B. The immediate-codepoint tagged-pointer
hack, the owned-string hash table, the persistent-pointer set, and the
`_safe_strlen_asan` scan all disappear.

#### 2.2.2 Operations

| Operation | Signature | Notes |
|---|---|---|
| `sfn_str_len` | `(SfnString) -> i64` | Returns `len` field directly |
| `sfn_str_concat` | `(SfnString, SfnString, Arena*) -> SfnString` | Allocates `a.len + b.len` in arena, memcpy both |
| `sfn_str_append` | `(SfnString*, SfnString, Arena*) -> void` | Arena-incompatible realloc is avoided; concat into arena and update pointer |
| `sfn_str_slice` | `(SfnString, i64, i64) -> SfnSlice_u8` | Non-allocating; returns `{data+start, end-start}` |
| `sfn_str_eq` | `(SfnString, SfnString) -> bool` | `len` compare then `memcmp` |
| `sfn_str_grapheme_count` | `(SfnString) -> i64` | UTF-8 walk counting grapheme clusters |
| `sfn_str_grapheme_at` | `(SfnString, i64, Arena*) -> SfnString` | Returns a new SfnString for the N-th grapheme |
| `sfn_str_byte_at` | `(SfnString, i64) -> i64` | Direct index into `data` |
| `sfn_str_find_byte` | `(SfnString, i64, i64) -> i64` | memchr-backed |
| `sfn_str_codepoint` | `(SfnString) -> i64` | First codepoint as integer |
| `sfn_str_from_codepoint` | `(i64, Arena*) -> SfnString` | 1-4 byte UTF-8 encode |
| `sfn_str_to_number` | `(SfnString) -> f64` | `strtod` on a stack-buffered NUL-terminated copy |
| `sfn_number_to_str` | `(f64, Arena*) -> SfnString` | `snprintf` into arena |
| `sfn_int_to_str` | `(i64, Arena*) -> SfnString` | `snprintf` into arena |

#### 2.2.3 UTF-8 vs. Graphemes

Sailfin strings are **UTF-8 byte sequences**. The `len` field is byte length.
Indexing with `grapheme_at` is an O(n) walk from the start — there is no
grapheme-indexed random access. This is the same tradeoff Rust and Go make.

The prelude exposes `grapheme_at` and `grapheme_count` for user code. The
compiler's internal hot paths (lexer, parser) use byte-level operations
(`byte_at`, `find_byte`) for performance, which is correct because compiler
source is ASCII-dominated.

**No interning/pooling in v0.** String interning adds a global table, locking
on concurrent paths, and hash overhead per allocation. The compiler's hot path
does not benefit — it creates unique strings (IR lines, mangled names) far more
often than it reuses them. If profiling post-M2 shows interning would help
(e.g., identifier lookup in the parser), it can be added as a subsystem of the
arena (deduplicated arena region) without changing the string ABI.

#### 2.2.4 NUL-Termination for Extern Boundary

`extern fn` calls into libc that accept or return C strings (e.g., `fopen`
takes a `const char*`) need NUL-terminated byte buffers. The runtime provides:

- `sfn_str_to_cstr(SfnString, *Arena) -> *u8` — copies the string into the
  arena with a trailing NUL byte. Used internally by capability adapters, never
  exposed to user code.
- `sfn_str_from_cstr(*u8) -> SfnString` — wraps a NUL-terminated byte buffer
  by scanning for NUL to determine length. Used to marshal extern return
  values back into `SfnString` form.

### 2.3 Array/Slice Subsystem

#### 2.3.1 Owned Array

```
struct SfnArray<T> {
    data: T*     // Element storage
    len: i64     // Number of live elements
    cap: i64     // Allocated capacity
}
```

This replaces both `SailfinPtrArray` and the byte-addressed array with their
hidden headers, canaries, and ring buffer guards. There is one layout for all
element types.

**Growth policy:** Double capacity up to 1024 elements, then grow by 25%.
Same as the current C runtime policy, which has been empirically validated
during self-hosting.

**API:**
- `sfn_array_create(cap: i64, elem_size: i64, Arena*) -> SfnArray<T>` —
  allocate initial capacity.
- `sfn_array_push(arr: SfnArray<T>*, elem: T, elem_size: i64, Arena*) -> void`
  — append an element, growing if needed. Growth allocates a new buffer in the
  arena and copies (no realloc in arena mode).
- `sfn_array_concat(a: SfnArray<T>, b: SfnArray<T>, elem_size: i64, Arena*) -> SfnArray<T>`
  — allocate a new array containing both.
- `sfn_array_slice(arr: SfnArray<T>, start: i64, end: i64) -> SfnSlice<T>` —
  non-allocating view.

#### 2.3.2 Borrowed Slice

```
struct SfnSlice<T> {
    data: T*     // Non-owning pointer into an array or string
    len: i64
}
```

Slices are the primary way to pass read-only views. `SfnSlice<u8>` is the
canonical borrowed-string type. Slices are never freed (they don't own their
data).

#### 2.3.3 Map/Filter/Reduce

Unlike the current C stubs that return input unchanged, the Sailfin-native
implementations accept typed closures:

- `sfn_array_map(arr: SfnArray<T>, f: fn(T) -> U, elem_size_in: i64, elem_size_out: i64, Arena*) -> SfnArray<U>`
- `sfn_array_filter(arr: SfnArray<T>, f: fn(T) -> bool, elem_size: i64, Arena*) -> SfnArray<T>`
- `sfn_array_reduce(arr: SfnArray<T>, init: U, f: fn(U, T) -> U, elem_size: i64, Arena*) -> U`

These require **closures with capture** (roadmap §0 item 5) and **generic
constraints** (roadmap §2). Until those land, the prelude versions remain stubs.
This is acceptable — map/filter/reduce are not on the compiler's self-hosting
critical path.

### 2.4 Exception/Unwind Subsystem

**Decision: explicit exception frames, not LLVM landing pads.**

Rationale:
1. LLVM landing pads (`invoke` + `landingpad` + personality function) require
   implementing a full Itanium C++ ABI unwind personality or SJLJ personality.
   This is a massive implementation surface for a v0 runtime.
2. The current compiler already emits exception handling as branching logic
   (`has_exception` polling after calls). Moving to explicit frames (which are
   a lighter version of what `setjmp`/`longjmp` provides) is a smaller step.
3. The performance cost of frame setup/teardown is one stack allocation and one
   pointer write per `try` block on the happy path. The unhappy path (throw)
   walks the frame chain — which is fast because throws are exceptional.
4. LLVM landing pads can be adopted post-1.0 as a performance optimization if
   profiling shows the frame overhead matters. The runtime API stays the same.

#### 2.4.1 Frame Structure

```
struct SfnExceptionFrame {
    prev: SfnExceptionFrame*   // Previous frame in chain
    jmp_buf: i8[JMPBUF_SIZE]   // Platform-specific setjmp buffer
    message: SfnString          // Exception message (populated on throw)
}
```

The frame is stack-allocated by the compiler at `try` entry. Thread-local
storage holds a pointer to the current frame head.

**setjmp/longjmp access:** `setjmp` and `longjmp` are libc functions, reached
via `extern fn` declarations in `runtime/sfn/platform/libc.sfn`. The `jmp_buf`
is declared as an opaque byte array sized to the platform's `_JMPBUF_SIZE`
(typically 200 bytes on Linux x86_64, 192 on macOS arm64). The Sailfin runtime
never interprets the contents — it passes a pointer to the extern functions.

#### 2.4.2 API

- `sfn_try_enter(frame: SfnExceptionFrame*) -> i32` — push frame onto the
  TLS chain, call `setjmp`. Returns 0 on first entry, non-zero on throw.
- `sfn_try_leave(frame: SfnExceptionFrame*) -> void` — pop frame from chain.
- `sfn_throw(message: SfnString) -> noreturn` — write message into the top
  frame, pop it, `longjmp` back.
- `sfn_take_exception(frame: SfnExceptionFrame*) -> SfnString` — read the
  message from a frame after catching.

#### 2.4.3 Drop-on-Unwind

When a `throw` fires, the runtime must run drops for values allocated between
the `try_enter` and the throw site. Two approaches:

**Option A (recommended for v0): Compiler emits cleanup at catch entry.**
The compiler knows which locals are live at each `try` block scope. At the catch
entry point, the compiler emits drops for all owned locals that were in scope.
This is conservative (some locals might not have been initialized before the
throw), so the compiler also emits a "was this local initialized?" sentinel
check (a null/zero check on the local's pointer).

**Option B (future): Cleanup handlers in the frame chain.** Each frame carries
a cleanup callback list. The runtime iterates them on throw. This is cleaner but
requires more machinery. Defer to post-1.0.

#### 2.4.4 Migration from TLS Polling

The current compiler emits `call @sfn_has_exception()` / `br i1` after every
function call. The new frame-based system replaces this with `setjmp`/`longjmp`,
which means:

- The `has_exception` polling disappears (removing two instructions per call
  site on the happy path).
- The `try_enter`/`try_leave` frame management adds cost only at `try`/`catch`
  boundaries, not at every call.
- The migration is a compiler-lowering change: `instructions_try.sfn` emits
  frame setup instead of polling; call emission in
  `core_call_emission.sfn` stops emitting the `has_exception` check.
- **During migration**, both paths can coexist: the compiler emits frame-based
  handling for new `try` blocks while legacy code paths continue polling. The
  runtime supports both APIs.

### 2.5 Type Metadata and Reflection

#### 2.5.1 Type Descriptors

The compiler emits a `SfnTypeDescriptor` global constant for each named type
(struct, enum, interface) in the module:

```
struct SfnTypeDescriptor {
    id: i64                // Unique within an ABI version
    name: SfnString        // Human-readable name
    kind: i32              // PRIMITIVE=0, STRUCT=1, ENUM=2, INTERFACE=3, ARRAY=4, FUNCTION=5
    field_count: i32
    fields: SfnFieldDescriptor*  // null when kind != STRUCT/ENUM
}

struct SfnFieldDescriptor {
    name: SfnString
    type_id: i64           // References another SfnTypeDescriptor.id
    offset: i32            // Byte offset within the struct layout
}
```

#### 2.5.2 Runtime Registry

A global type registry (populated at module init) maps type IDs to descriptor
pointers. The registry is a simple hash map (open addressing, power-of-two
capacity).

**API:**
- `sfn_type_register(desc: SfnTypeDescriptor*) -> void` — called per type at
  module init.
- `sfn_type_of(ptr: i8*, type_id_hint: i64) -> SfnTypeDescriptor*` — if the
  compiler knows the static type, it passes the hint directly (constant-folded).
  For dynamic dispatch, the value carries a type-ID tag in its first field.
- `sfn_instance_of(ptr: i8*, type_id: i64) -> bool` — check if the value's type
  matches or implements the given type.
- `sfn_field_of(ptr: i8*, field_name: SfnString, desc: SfnTypeDescriptor*) -> i8*`
  — dynamic field access using the descriptor's offset table.

#### 2.5.3 Minimum Viable vs. Full

For v0, emit **id + name + kind** only. Skip field descriptors unless the test
suite requires `get_field` or `instance_of` with structural checks. Add field
descriptors incrementally as the prelude's reflection surface demands them.
Rationale: full descriptors with field offsets require the compiler to emit
layout information it doesn't currently compute per-type.

### 2.6 Scheduler and Concurrency

#### 2.6.1 Design Decision: Fixed Thread Pool, Not Work-Stealing

A work-stealing scheduler (like Tokio or Go's goroutine scheduler) is
architecturally complex: per-thread deques, atomic work stealing, timer wheels,
I/O reactor integration. This is inappropriate for v0 where the concurrency
surface (`spawn`, `channel`, `parallel`, `serve`) is being implemented for the
first time.

**v0 design: fixed thread pool with a shared MPMC task queue.**

```
struct Scheduler {
    threads: *Pthread        // Via extern fn pthread_create
    thread_count: i64
    queue: TaskQueue*        // Lock-free (or mutex-guarded) MPMC queue
    shutdown: i64            // Atomic flag (via LLVM atomic intrinsics)
}

struct Task {
    fn_ptr: fn(i8*) -> i8*  // Task function
    ctx: i8*                 // Captured environment
    result: i8*              // Written by worker, read by awaiter
    done: i64                // Atomic flag (via LLVM atomic intrinsics)
    cond: PthreadCond        // Via extern fn pthread_cond_*
    mutex: PthreadMutex      // Via extern fn pthread_mutex_*
}
```

All thread and synchronization primitives are reached via `extern fn`
declarations in `runtime/sfn/platform/pthread.sfn`. No C wrapper is involved.
`PthreadMutex` and `PthreadCond` are declared as opaque byte arrays sized to
the target platform's `sizeof(pthread_mutex_t)` / `sizeof(pthread_cond_t)`.

**Pool size:** `min(available_cores, 4)` by default, overridable with
`SAILFIN_THREADS=N`.

#### 2.6.2 Spawn

`sfn_spawn(fn_ptr, ctx, result_size) -> SfnFuture*` — enqueue a task. Returns
a future handle.

#### 2.6.3 Await

`sfn_await(future: SfnFuture*) -> i8*` — block on the future's condition
variable until `done` is set. Returns the result pointer.

#### 2.6.4 Channel

```
struct Channel<T> {
    buffer: SfnArray<T>       // Circular buffer
    capacity: i64
    head: i64                 // Read position (atomic)
    tail: i64                 // Write position (atomic)
    mutex: PthreadMutex       // Via extern fn pthread_mutex_*
    not_empty: PthreadCond    // Via extern fn pthread_cond_*
    not_full: PthreadCond     // Via extern fn pthread_cond_*
    closed: i64               // Atomic flag (via LLVM atomic intrinsics)
}
```

- `sfn_channel_create(capacity: i64, elem_size: i64) -> Channel<T>*`
- `sfn_channel_send(ch: Channel<T>*, elem: T) -> bool` — blocks if full,
  returns false if closed.
- `sfn_channel_recv(ch: Channel<T>*) -> T` — blocks if empty; throws if closed
  and empty.
- `sfn_channel_close(ch: Channel<T>*) -> void`

#### 2.6.5 Parallel

`sfn_parallel(tasks: SfnArray<fn() -> T>, Arena*) -> SfnArray<T>` — spawn all
tasks, await all, return results in order. This is a convenience built on
spawn+await.

#### 2.6.6 Serve

`sfn_serve(handler: fn(Request) -> Response, port: i32)` — accept loop on a
listening socket, dispatching each connection to the thread pool. Blocking
accept, thread-pool dispatch. No async I/O in v0.

#### 2.6.7 Future Considerations for Concurrency

Post-1.0, the scheduler can evolve toward work-stealing, and `routine` blocks
can introduce structured concurrency with cancellation and nurseries. The v0
thread pool + mutex design does not preclude this — it is a simpler starting
point that validates the API surface.

### 2.7 Capability Adapters

Capability adapters are the bridge between the effect system and OS resources.
Each adapter is gated by a capability grant: calling a filesystem adapter
function without an `![io]` effect annotation on the call chain is a
compile-time error (enforced by the effect checker, which already exists).

#### 2.7.1 Filesystem Adapter

Calls libc filesystem functions via `extern fn` declarations in
`runtime/sfn/platform/libc.sfn`. Handles NUL-termination of paths internally
(see §2.2.4):

- `sfn_fs_read_file(path: SfnString, Arena*) -> SfnString` (or `Result<SfnString, Error>` once `Result` lands)
- `sfn_fs_write_file(path: SfnString, contents: SfnString) -> void`
- `sfn_fs_append_file(path: SfnString, contents: SfnString) -> void`
- `sfn_fs_exists(path: SfnString) -> bool`
- `sfn_fs_list_dir(path: SfnString, Arena*) -> SfnArray<SfnString>`
- `sfn_fs_delete(path: SfnString) -> bool`
- `sfn_fs_mkdir(path: SfnString, recursive: bool) -> bool`

All functions that return allocated data take an `Arena*` parameter. If
`Result<T, E>` is available, error returns replace thrown exceptions.

#### 2.7.2 HTTP Adapter

Calls socket functions via `extern fn` declarations in
`runtime/sfn/platform/net.sfn`:

- `sfn_http_get(url: SfnString, Arena*) -> SfnString`
- `sfn_http_post(url: SfnString, body: SfnString, headers: SfnArray<SfnString>, Arena*) -> SfnString`

For v0, HTTP/1.1 only. TLS support requires linking OpenSSL or similar — this
is an explicit trade-off. The curl-subprocess fallback can remain as a
capability adapter option until a TLS story is decided.

#### 2.7.3 Model Adapter

Remains a stub in v0. The `![model]` effect is enforced at compile time, but
runtime model invocation is post-1.0 (per roadmap).

#### 2.7.4 Clock Adapter

- `sfn_clock_millis() -> i64` — via `extern fn clock_gettime` in `platform/posix.sfn`.
- `sfn_sleep(ms: i64) -> void` — via `extern fn nanosleep` in `platform/posix.sfn`.

### 2.8 I/O and Timing Primitives

- `sfn_print(msg: SfnString) -> void` — calls `extern fn write` with fd=1, buf=msg.data, len=msg.len.
- `sfn_print_err(msg: SfnString) -> void` — calls `extern fn write` with fd=2.
- `sfn_print_info/warn/error(msg: SfnString) -> void` — prepend prefix, delegate
  to `sfn_print` or `sfn_print_err`.
- `sfn_getenv(name: SfnString, *Arena) -> SfnString` — NUL-terminates name, calls `extern fn getenv`, wraps result.
- `sfn_home_dir(*Arena) -> SfnString` — calls `sfn_getenv("HOME", arena)`.

### 2.9 Platform Extern Declarations

Platform syscalls are declared in `runtime/sfn/platform/*.sfn` as `extern fn`
declarations — pure Sailfin source, no C. The compiler emits LLVM `declare`
directives for each extern; the linker resolves them against libc/libpthread at
link time.

**`runtime/sfn/platform/libc.sfn`** — selected entries from the
*design target* are listed below. The actually-shipped 2026-05-01
skeleton is a subset of this list: the 12 declarations covering
`malloc`/`free`/`realloc`/`memcpy`/`memcmp`, `write`/`read`,
`fopen`/`fclose`/`fread`/`fwrite`, and `getenv`. `memchr`,
`setjmp`, and `longjmp` (commented `// (deferred)` below) are part
of the long-term shape but wait on follow-up PRs that land their
dependencies — `memchr` needs the LLVM mapper to learn `i32`-byte
parameters cleanly through opaque pointers, and `setjmp`/`longjmp`
need the exception subsystem plus opaque `JmpBuf` size constants.
Once those land, drop the `// (deferred)` markers and the
declarations move into the live skeleton.

```sailfin
// Memory
extern fn malloc(size: usize) -> *u8;
extern fn free(ptr: *u8) -> void;
extern fn realloc(ptr: *u8, new_size: usize) -> *u8;
extern fn memcpy(dst: *u8, src: *u8, n: usize) -> *u8;
extern fn memcmp(a: *u8, b: *u8, n: usize) -> i32;
extern fn memchr(haystack: *u8, byte: i32, n: usize) -> *u8; // (deferred)

// I/O (fd-based)
extern fn write(fd: i32, buf: *u8, count: usize) -> i64;
extern fn read(fd: i32, buf: *u8, count: usize) -> i64;

// Stdio filesystem
extern fn fopen(path: *u8, mode: *u8) -> *File;
extern fn fread(buf: *u8, size: usize, nmemb: usize, f: *File) -> usize;
extern fn fwrite(buf: *u8, size: usize, nmemb: usize, f: *File) -> usize;
extern fn fclose(f: *File) -> i32;

// Environment + exception support
extern fn getenv(name: *u8) -> *u8;
extern fn setjmp(env: *JmpBuf) -> i32;                       // (deferred)
extern fn longjmp(env: *JmpBuf, val: i32) -> void;           // (deferred)

// String conversion (variadic — see open question Q6)
extern fn strtod(nptr: *u8, endptr: **u8) -> f64;
```

**`runtime/sfn/platform/pthread.sfn`** (selected):

```sailfin
extern fn pthread_create(thread: *Pthread, attr: *PthreadAttr, start: fn(*u8) -> *u8, arg: *u8) -> i32;
extern fn pthread_join(thread: *Pthread, result: **u8) -> i32;
extern fn pthread_mutex_init(m: *PthreadMutex, attr: *PthreadMutexAttr) -> i32;
extern fn pthread_mutex_lock(m: *PthreadMutex) -> i32;
extern fn pthread_mutex_unlock(m: *PthreadMutex) -> i32;
extern fn pthread_cond_wait(c: *PthreadCond, m: *PthreadMutex) -> i32;
extern fn pthread_cond_signal(c: *PthreadCond) -> i32;
```

**`runtime/sfn/platform/posix.sfn`** (selected):

```sailfin
extern fn posix_spawnp(pid: *i32, path: *u8, file_actions: *u8, attrp: *u8, argv: **u8, envp: **u8) -> i32;
extern fn waitpid(pid: i32, status: *i32, options: i32) -> i32;
extern fn clock_gettime(clk_id: i32, ts: *Timespec) -> i32;
extern fn nanosleep(req: *Timespec, rem: *Timespec) -> i32;
```

**`runtime/sfn/platform/net.sfn`** (selected):

```sailfin
extern fn socket(domain: i32, ty: i32, protocol: i32) -> i32;
extern fn connect(sockfd: i32, addr: *SockAddr, addrlen: i32) -> i32;
extern fn send(sockfd: i32, buf: *u8, len: i64, flags: i32) -> i64;
extern fn recv(sockfd: i32, buf: *u8, len: i64, flags: i32) -> i64;
extern fn bind(sockfd: i32, addr: *SockAddr, addrlen: i32) -> i32;
extern fn listen(sockfd: i32, backlog: i32) -> i32;
extern fn accept(sockfd: i32, addr: *SockAddr, addrlen: *i32) -> i32;
extern fn close(fd: i32) -> i32;
```

**Rules for `extern fn` signatures:**

1. **Only C-ABI-compatible types cross the boundary.** `i32`, `i64`, `f64`,
   `bool`, raw pointers (`*u8`, `*File`), function pointers. No `SfnString`,
   no `SfnArray<T>`, no RC'd types. The adapter layer decomposes Sailfin
   aggregates into pointer+length pairs before the call.
2. **NUL-termination is the caller's job** for any pointer that POSIX treats
   as a C string. String adapters allocate a NUL-terminated copy in the arena
   before calling.
3. **Lifetime stays on the Sailfin side.** Memory passed to an extern must
   outlive the call; memory returned from an extern is not auto-tracked by
   RC. Adapters immediately wrap return values into arena or RC-managed
   Sailfin types.
4. **No effect checking on externs.** `extern fn` declarations are raw
   syscall surfaces; effect enforcement happens at the adapter layer above
   them (the adapter function is annotated `![io]` or `![net]`).

**Platform-conditional compilation.** Opaque struct sizes
(`PthreadMutex`, `PthreadCond`, `JmpBuf`) vary by platform. In v0, the build
system selects one of several `.sfn` files per target (e.g.
`platform/pthread_linux_x86_64.sfn`, `platform/pthread_macos_arm64.sfn`). This
is explicit over-specification rather than introducing compile-time target
constants into the compiler — simpler for v0. See open question Q7.

**Variadic externs (`snprintf`).** Deferred. See Q6 in open questions.

---

## 3. Compiler Integration

### 3.1 Drop Emission at Scope Exit

**Current state:** The compiler tracks lifetime regions in
`compiler/src/llvm/types.sfn` (`LifetimeRegionMetadata`, `LifetimeReleaseEvent`)
and has scope tracking (`ScopeMetadata`, `scope_id`, `scope_depth` on
`LocalBinding`). It does **not** emit any drop calls.

**Required changes:**

1. **`compiler/src/llvm/lowering/instructions.sfn`** — at the end of each scope
   (function body, block body, loop body), insert `call void @sfn_rc_release`
   for each owned RC local that was initialized in that scope. Use
   `OwnershipInfo.variant` to skip borrows.

2. **`compiler/src/llvm/lowering/instructions_try.sfn`** — at catch entry,
   emit cleanup calls for all owned locals in the `try` scope that may have been
   initialized. Guard each with a null-check (`icmp ne ptr %local, null`).

3. **`compiler/src/llvm/expression_lowering/native/core_scopes.sfn`** — extend
   `append_local_binding` to record whether the binding is arena-allocated or
   RC-allocated. Add an `allocation_kind` field to `LocalBinding`:
   `"arena" | "rc" | "static" | "stack"`.

4. **`compiler/src/llvm/lowering/instructions_helpers.sfn`** — add a helper
   `emit_scope_drops(locals: LocalBinding[], scope_id: string) -> string[]`
   that generates the drop IR lines for all owned locals in the given scope.

### 3.2 Escape Analysis Encoding

**What the compiler must decide at each point:**

| Point | Decision | Encoding |
|---|---|---|
| Local variable assignment (`let x = ...`) | Arena or RC? | `LocalBinding.allocation_kind` |
| Function return (`return x`) | If x was arena, must promote to RC | Emit `sfn_rc_alloc` + copy before return |
| Closure capture (`\|x\| ...` where x is from outer scope) | Must be RC | Emit `sfn_rc_retain` when closure is constructed |
| Channel send (`ch.send(x)`) | Must be RC | Emit `sfn_rc_retain` before send |
| Collection store (`arr.push(x)`) | Must match collection's allocation kind | Emit retain if collection is RC |

**Minimal viable escape analysis (M1):** No analysis. All heap allocations go
through the global arena. No RC in v0. This works for the compiler (batch
process) and for short-lived user programs. Long-lived programs will need RC
(M2+).

**Conservative escape analysis (M2):** As described in §2.1.2: arena by default,
RC at function return boundaries and closure captures. The compiler already
knows which values are returned (it emits `ret` instructions) and which are
captured (once closures-with-capture lands). This is a local analysis — no
interprocedural reasoning needed.

### 3.3 ABI Version Metadata

The compiler must emit an ABI version marker so the runtime can detect
mismatches at load time.

**Implementation:**

In `compiler/src/llvm/lowering/module_globals.sfn`, emit a module-level global:

```llvm
@sfn_abi_version = constant i32 1
@sfn_abi_hash = constant [8 x i8] c"a1b2c3d4"
```

The runtime's init function checks these against its compiled-in values and
aborts with a diagnostic if they don't match.

**Bump policy:** The ABI version increments whenever a struct layout changes
(e.g., `SfnString` gains a field, `SfnArray` field order changes). The hash
is derived from the concatenation of all runtime struct layouts.

### 3.4 Typed Closures

**Current state:** The compiler represents closures as `i8*` function pointers
with an optional `i8*` context. This works for thunks but not for closures that
capture typed state.

**Required for spawn, channel, map/filter/reduce:**

A closure is lowered to a struct:

```llvm
%closure.env.123 = type { i64, i8*, %SfnString }  ; captured variables
%closure.123 = type { %closure.env.123*, i8* (*)(i8*) }  ; env + fn pointer
```

The function pointer takes the environment struct as its argument. The compiler:
1. Allocates the environment struct (arena or RC depending on context).
2. Copies captured values into the environment (with `sfn_rc_retain` for RC
   values).
3. Passes the `{env*, fn*}` pair to `sfn_spawn` / `sfn_channel_send` / etc.

This is blocked on **closures with capture** (roadmap §0 item 5). Without it,
concurrency primitives continue using the per-type spawn/await pattern
(`spawn_number`, `spawn_string`, etc.) that exists in the C runtime today.

### 3.5 Atomic Intrinsics

**Current state:** The compiler has no atomic operation support. RC's
`refcount` field, the scheduler's `shutdown` flag, and channel state flags all
need atomic increment/decrement and fences.

**Required Sailfin builtins (compiler emits LLVM intrinsics directly):**

| Sailfin builtin | LLVM intrinsic | Use |
|---|---|---|
| `atomic_add(ptr: *i64, delta: i64) -> i64` | `atomicrmw add` | RC retain, counters |
| `atomic_sub(ptr: *i64, delta: i64) -> i64` | `atomicrmw sub` | RC release, counters |
| `atomic_load(ptr: *i64) -> i64` | `load atomic` | Flag reads |
| `atomic_store(ptr: *i64, value: i64) -> void` | `store atomic` | Flag writes |
| `atomic_cas(ptr: *i64, expected: i64, new: i64) -> bool` | `cmpxchg` | Lock-free queues, futures |
| `atomic_fence() -> void` | `fence seq_cst` | Memory ordering barriers |

These are **compiler intrinsics** — builtins with dedicated LLVM lowering, not
library functions. The user cannot define them in Sailfin; the compiler
recognizes the name and emits the intrinsic directly. Memory ordering is
`seq_cst` for v0 (simple, correct); relaxed/acquire/release variants can be
added post-1.0 if profiling shows contention.

**Prerequisite status:** Hard for M2 (RC correctness) and M4 (scheduler
correctness). Soft prerequisite #12 in `runtime_audit.md`, but functionally
blocking for M2.

**Fast-fail criterion:** A Sailfin test `let r = atomic_add(&counter, 1)` from
two threads produces the expected sum (no races, no lost increments).

### 3.6 Extern Function Lowering

**Status (2026-05-01): Shipped end-to-end.** Parser, typechecker, native-IR
emitter, and LLVM `declare` lowering are all in place. The remaining
sub-step is cross-module call-site resolution against the typecheck symbol
table (see "Open follow-up" below).

**What ships today:**

1. **Parser/AST:** `extern fn` (optionally prefixed with `unsafe`) produces
   `Statement.ExternFunctionDeclaration { signature, unsafe, decorators }`
   in `compiler/src/ast.sfn:198`.
2. **Typechecker:** registers extern functions in the same symbol table as
   regular fns with `kind: "extern function"` (so duplicate-name detection
   works across `extern fn` and `fn` of the same name) and runs
   `check_extern_signature` (`compiler/src/typecheck_types.sfn`) to validate
   C-ABI compatibility:

   | Code | Meaning |
   |---|---|
   | `E0801` | parameter or return uses Sailfin `string` aggregate |
   | `E0802` | parameter or return uses `T[]` array |
   | `E0803` | extern declares type parameters (generic externs forbidden) |
   | `E0804` | extern declares effects (effects belong on the wrapping adapter) |
   | `E0805` | unrecognized type name (catch-all; rejects legacy `number`) |

   Accept-list (intersection of "valid C-ABI" and "what
   `compiler/src/llvm/type_mapping.sfn:map_primitive_type` lowers
   today"): `i8`, `i32`, `i64`, `u8`, `usize`, `bool`, `void` (return
   only), `*T` (recursively, with `const` / `mut` permitted, including
   `*void` ≡ `*opaque`), `*<UpperCamelStruct>` opaque pointers, and
   `fn(A, B) -> C` function pointers whose argument types are c-abi
   parameter types and whose return type is a c-abi return type.

   Wider integer/float types (`i16`, `u16`, `u32`, `u64`, `isize`,
   `f32`, `f64`) are intentionally **not** on the accept-list yet.
   They are valid C-ABI but the LLVM lowering has no mapping for
   them today; admitting them at typecheck would let an extern lower
   silently to `i8*` and produce ABI-mismatched IR. Extend
   `map_primitive_type` first, then add them here.

3. **Native-IR emitter:** `compiler/src/emit_native.sfn:317` emits
   `.fn <name>` + `.meta extern` (and `.meta unsafe` when applicable),
   serialising the C-ABI signature into the `.sfn-asm` artifact.

4. **LLVM lowering:** `compiler/src/llvm/lowering/emission.sfn:332` emits a
   top-level `declare <ret> @<name>(<args>)` directive for each extern;
   call sites emit `call @fname(args...)` with direct argument passing —
   no wrapper, no marshalling.

**Open follow-up: cross-module call-site resolution.** Today the typecheck
symbol table is duplicate-detection-only — the compiler does not resolve
`Call` expressions against it (in-module or cross-module). When that
resolver lands:

- `typecheck_import_loader.sfn` will gain a parallel `imported_externs`
  channel keyed off `kind == "extern function"` so externs declared in
  `runtime/sfn/platform/*.sfn` resolve from importer modules.
- `interfaces_from_native_artifact` will *not* need to change — it
  already correctly skips externs from the *function-effects* table
  (externs carry no effects per E0804).

**Type mapping (Sailfin → LLVM IR):**

| Sailfin | LLVM IR |
|---|---|
| `i32`, `i64`, `f64`, `bool` | same (`i32`, `i64`, `double`, `i1`) |
| `*T` (raw pointer) | `i8*` (opaque pointer post-LLVM 15) |
| `fn(A, B) -> C` | `C (A, B)*` function pointer |
| `*OpaqueStruct` (e.g. `*PthreadMutex`) | `i8*` |

**Constraints:**

- No `SfnString` / `SfnArray<T>` / RC'd types across the boundary — rejected
  at typecheck time.
- No effect annotations on `extern fn` declarations — effects are enforced by
  the adapter wrapping the extern call.
- `extern fn` declarations are runtime-internal in v0 (non-goal: user-facing
  externs).

**Self-hosting note:** `extern fn` is additive — no `compiler/src/*.sfn`
file declares an extern, so the new typecheck branch is a no-op on the
existing tree. The seed binary doesn't run the new code; the freshly-built
compiler does, and it finds zero externs in its own source.

**Fast-fail criterion (verified):** `extern fn write(fd: i32, buf: *u8,
count: i64) -> i64;` in a `.sfn` file produces `declare i64 @write(i32,
i8*, i64)` in emitted LLVM IR, and the source typechecks with zero
diagnostics. Coverage:
- `compiler/tests/unit/typecheck_extern_test.sfn` — 12 tests covering
  accept paths, every reject diagnostic (E0801–E0805), and same-name
  duplicate detection across `extern fn` and `fn`.
- `compiler/tests/unit/emit_native_extern_test.sfn` — 3 tests pinning
  the parser → native-IR → `.meta extern` round trip for the
  `runtime/sfn/platform/libc.sfn`-shaped libc skeleton.

### 3.7 Numeric Types (`int` / `float`)

**Status (2026-05-02): Slice A shipped.** Annotated locals,
parameters, and return types of type `int` and `float` lower
correctly through the LLVM backend. Slices B–E (sequenced below)
remain.

**What ships in Slice A:**

1. **Type mapping.** `int` → `i64`, `float` → `double` in both
   `compiler/src/llvm/type_mapping.sfn:map_primitive_type` and
   `compiler/src/llvm/expression_lowering/native/statement_type_mapping.sfn:map_primitive_type`
   (the latter is the path the let-instruction lowering takes via
   `_map_type_core`). Pre-fix, `let x: float = 3.14` silently
   lowered as `i8*` (string pointer) and `+` became
   `sailfin_runtime_string_concat` — a catastrophic, undiagnosed
   misbehaviour. The fix adds three lines (one each in
   `map_primitive_type` × 2 and `layout_annotation_represents_user_value`).

2. **Extern accept-list.** `is_extern_primitive_type` in
   `compiler/src/typecheck_types.sfn` now admits `int` and `float`
   alongside `i8/i32/i64/u8/usize/bool`. The accept-list remains
   the intersection of "valid C-ABI" and "what the LLVM backend
   actually maps today" — `int`/`float` are aliases for
   already-mapped primitives, so admitting them is purely
   additive.

3. **Existing dispatch was already correct.** The LLVM lowering
   already had:
   - `operation_name_for_symbol` (`core_helpers.sfn:36`) branching
     on `llvm_type == "double"` to emit `fadd`/`fsub`/... vs
     `add`/`sub`/`sdiv`/...
   - `comparison_predicate_for_symbol` (`core_operands.sfn:147`)
     branching between `fcmp` and `icmp slt/sgt/...`.
   - `dominant_type` (`core_operands.sfn:1487`) ranking `double`
     over `i64` over `i8` over `i1`.
   - The integer-literal short-circuit at `core.sfn:460-491` —
     when `expected_type == "i64"` or `"i32"` and the literal is
     integer-shaped, the operand is emitted as that exact type.

   So `let x: int = 42; let y: int = 1; let z = x + y;` already
   emitted `alloca i64`, `store i64 42`, `add i64` end-to-end. The
   slice mostly closes the gap for `float` and the extern surface;
   tests in `compiler/tests/unit/numeric_int_float_test.sfn` and
   `compiler/tests/e2e/test_numeric_int_float.sh` pin all the
   newly-working paths so a regression surfaces here.

**Known limitations (deferred to follow-up slices):**

| # | Limitation | Consequence | Slice |
|---|---|---|---|
| L1 | Bare numeric literals default to `number` (i.e. `double`) | `let x = 42` produces `alloca double`, not `alloca i64` | E |
| L2 | Mixed `int` + `float` silently coerces to `double` | `let x: int = 1; let y: float = 2.0; x + y` lowers to `fadd double` after silent fpext on the integer side. Truncates above 2^53. | D |
| L3 | Comparison with un-annotated literal coerces to `double` | `let x: int = 42; x > 0` lowers to `fcmp ogt double` because `0` defaults to `double` and `dominant_type` widens both sides. Workaround: annotate the literal (`x > 0 as int` once `as` casts ship) or compare against an annotated local. | D + E |
| L4 | Bitwise operators (`&`, `|`, `^`, `>>`, `<<`) on `int` | Required for SHA-256 / Base64 / flag manipulation in the pure-Sailfin runtime (M3 crypto port). Not yet parsed. | B |
| L5 | Additional widths (`i16`, `u16`, `u32`, `u64`, `isize`, `f32`) rejected at extern | Restricts what libc surface the skeleton (`runtime/sfn/platform/libc.sfn`) can name. The smaller widths (`i16`, `u16`, `u32`, `f32`) and the platform-sized ones (`u64`, `isize`) all need their own `map_primitive_type` entries; `isize` in particular is pointer-sized and matches `i64` on every platform Sailfin targets today, but the typecheck-vs-lowering contract requires an explicit entry before it can be admitted. | C |
| L6 | `number` keyword still exists | Pre-1.0 alias for `double`; the compiler source still uses it everywhere. Migrating compiler source from `number` → `int`/`float` and retiring `number` entirely is the prerequisite for L1. | E |

**Follow-up slices in dependency order:**

- **Slice B — Bitwise operators on `int`.** Needs lexer additions
  (some operators may already lex as their text form) plus parser
  recognition (precedence tables for `<<`/`>>`/`&`/`|`/`^`) plus
  lowering branches in `core_ops_lowering.sfn` to emit `and`/`or`/
  `xor`/`shl`/`ashr` against `i64` operands. Required before the
  M3 crypto port (SHA-256, Base64) can leave the C runtime.

- **Slice C — Wider integer / float widths.** Add `i16`/`u16`/`u32`/
  `u64`/`isize`/`f32` entries to `map_primitive_type` (both copies)
  and to `is_extern_primitive_type`. Mostly mechanical once the
  pattern is set; admit each width only after verifying clang
  emits clean IR for the test fixture. Unblocks more of the libc
  surface (`memchr`'s `int` byte parameter, `clock_gettime`'s
  `i32` clk_id, etc.).

- **Slice D — `as` casts + reject silent int↔float coercion.**
  Parser/lexer addition for `expr as Type`. Lowering: emit `fpext`
  / `fptosi` / `sitofp` / `trunc` / `zext` per the source/target
  pair. Tighten `dominant_type` to refuse coercion between integer
  and float without an explicit `as`. This closes L2 and L3 cleanly
  — but only after Slice E (or in lockstep with it) so the compiler
  source can be migrated off `number` first.

- **Slice E — Bare-literal defaulting + `number` retirement.**
  Per `CLAUDE.md` Pre-1.0 Syntax Reform §3, `number` becomes an
  alias for `float` and bare integer literals default to `int`.
  Pre-1.0 we don't need user backwards-compat — once a release
  cycle passes after this slice ships, the `number` keyword and
  every supporting branch in `map_primitive_type` /
  `dominant_type` / etc. can be deleted. Migration order:
    1. Add `int` as the bare-literal default.
    2. Audit-and-migrate every `: number` annotation in
       `compiler/src/*.sfn` and `runtime/prelude.sfn` to
       `: int` or `: float` based on actual usage.
    3. Cut a release.
    4. Delete `number` everywhere.

**Self-hosting safety (Slice A):** The compiler source uses
`number` throughout; nothing in `compiler/src/*.sfn` uses `: float`
or `: int` for control-flow loop counters. Adding `float` →
`double` to `map_primitive_type` and admitting `int`/`float` in
the extern accept-list is purely additive — no existing code path
changes behaviour. Verified via `make compile && make test-unit
&& make test-integration && make test-e2e` (all green).

### 3.8 Runtime Helper Registry Migration

`compiler/src/llvm/runtime_helpers.sfn` must be updated in lockstep with the
runtime migration. The migration path:

1. **M1 (ABI switch):** Update all helper descriptors to use native types.
   `i8*` for strings becomes `{i8*, i64}` (SfnString). `{i8**, i64}*` for
   pointer arrays becomes `{i8*, i64, i64}*` (SfnArray). `double` for indices
   becomes `i64`. This is a one-time bulk update.

2. **M2-M3:** Replace C symbol names (`sailfin_runtime_*`) with Sailfin-native
   symbol names (`sfn_*`). The registry is the single point of change — all
   call emission goes through `find_runtime_helper`.

3. **Cleanup:** Delete the dead declared helpers identified in `runtime_audit.md`
   §"Helpers the compiler declares but never emits." Either define them in the
   new runtime or remove them from the registry.

---

## 4. Sequencing Plan

### 4.1 Milestone Overview

```
M0: Compiler Prerequisites (ongoing, parallel with perf work)
 ↓
M0.5: Arena in C (temporary — YES, do it)
 ↓
M1: ABI Lock + Codegen Switch
 ↓
M2: Core Runtime in Sailfin
 ↓
M3: Capability Adapters in Sailfin + Delete C Runtime
 ↓
M4: Scheduler and Concurrency
 ↓
M5: Native CLI + Driver
```

### 4.2 Should M0.5 Happen? YES.

**Position: ship the arena in C as a temporary unblocker. Delete it at M3.**

Rationale:
1. **The perf work cannot wait for M0.** The build is 13-16 minutes. Further
   IPC removal (the primary perf lever, expected 40-60% reduction) is blocked
   on memory management. M0 (integer types, `Result<T, E>`, closures, etc.)
   is months of compiler work. Waiting means the 13-minute build persists for
   months, slowing every other workstream including M0 itself.

2. **The arena in C is small and disposable.** A bump allocator is ~200 lines
   of C. It replaces `malloc` for strings and arrays during compilation, adds
   `arena_reset` at process exit, and removes the owned-string hash table
   overhead. It does not need to be elegant — it needs to unblock IPC removal.

3. **The arena in C validates the arena design.** Writing the arena in C first
   proves the API shape (`create`, `alloc`, `reset`, `destroy`) before
   implementing it in Sailfin. If the design is wrong, it's cheaper to learn
   that in 200 lines of C than in a Sailfin module that must self-host.

4. **It is deleted at M3, not maintained long-term.** The C arena lives in
   `runtime/native/src/sailfin_arena.c` alongside the existing runtime. When
   the Sailfin-native runtime subsumes it (M2-M3), the C file is deleted. No
   ongoing maintenance burden.

**Risk:** The C arena makes the `string_append` realloc optimization
incompatible (arenas don't support realloc). Mitigation: implement "grow-if-at-
tip" in the C arena — if the allocation being "realloc'd" is the last
allocation in the current page, just bump the used pointer. This covers the
common case of `string_append` in a loop (each append is the most recent
allocation). If not at tip, allocate new and copy. This is a 20-line addition
to the arena.

### 4.3 M0 — Compiler Prerequisites

**Status:** Ongoing (roadmap §0). Not gated on runtime work.

**What must ship before M1 can begin:**
- Integer types (`int` / `float`). Without this, the runtime ABI cannot express
  `len`, `cap`, `index` as integers — they'd still be f64.
- `Result<T, E>` and `?`. Without this, every runtime function that can fail
  must use `try`/`catch`, which is both slow and ergonomically wrong.
- Closures with capture. Without this, `spawn`, `channel`, and map/filter/reduce
  cannot accept user-provided callbacks that close over local state.
- **`extern fn` with typed linker-resolved symbols.** Without this, the runtime
  cannot reach platform syscalls from Sailfin source — the entire pure-Sailfin
  runtime architecture depends on this feature. This is hard prerequisite #7
  in `runtime_audit.md`.

**What must ship before M2 can begin:**
- Atomic intrinsics (§3.5). Required for sound RC and the scheduler. Soft
  prereq #12 in `runtime_audit.md`, but hard for M2.

**What can ship after M1 (soft prereqs — desirable but not blocking):**
- Generic trait/interface constraints. Needed for fully typed `Channel<T>` and
  `Array<T>` in the prelude but not for the runtime internals.
- Affine/Linear enforcement. The runtime can operate correctly with the
  conservative "arena by default, RC at boundaries" model without the compiler
  enforcing move semantics. Enforcement improves safety guarantees but doesn't
  change runtime correctness.

**Fast-fail criteria:**
1. Integer literals compile to `i64`, not `double`: `let x: int = 42; assert x + 1 == 43;`
   compiles and runs with `i64` arithmetic.
2. `extern fn write(fd: i32, buf: *u8, count: i64) -> i64;` in a `.sfn` file
   produces `declare i64 @write(i32, i8*, i64)` in emitted LLVM IR, and a call
   `write(1, msg_data, msg_len)` links against libc and writes to stdout.
3. `atomic_add(&counter, 1)` from two threads produces the expected sum with no
   lost increments.

### 4.4 M0.5 — Arena in C (Temporary Unblocker)

**Compiler prereqs:** None. This is pure C runtime work.

**Deliverables:**
1. `runtime/native/src/sailfin_arena.c` + `.h` (~200-300 lines).
2. Integration into `sailfin_runtime.c`: route `string_concat`, `string_append`,
   `append_string` (array push), `array_push_slot`, and `sailfin_runtime_concat`
   through the arena when `SAILFIN_USE_ARENA=1` (env var for rollback safety).
3. Remove the owned-string hash table (`_sailfin_owned_table`) and persistent-
   pointer set (`_sailfin_persistent_table`) when arena mode is active.
4. Implement grow-if-at-tip for arena realloc to preserve `string_append`
   optimization.

**Unblocks:**
- Phase 2 of build-performance.md (IPC removal) — expected 40-60% build time
  reduction.
- Phase 1b (aliasing-blocked O(n^2) sites) — arena makes copies cheap.

**Fast-fail criteria:**
1. `make compile` succeeds with `SAILFIN_USE_ARENA=1`.
2. Per-module peak RAM drops below 512 MB (from 0.5-1.5 GB).
3. `make check` passes with arena enabled.

### 4.5 M1 — ABI Lock + Codegen Switch

**Compiler prereqs:** M0 (integer types, `Result<T, E>`, closures, `extern fn`).

**Deliverables:**
1. Finalize all struct layouts in `runtime_abi.md` — freeze field order, sizes,
   alignment for `SfnString`, `SfnArray<T>`, `SfnSlice<T>`,
   `SfnExceptionFrame`, `SfnTypeDescriptor`.
2. Emit `@sfn_abi_version` and `@sfn_abi_hash` in
   `compiler/src/llvm/lowering/module_globals.sfn`.
3. Switch string lowering: the compiler emits `{i8*, i64}` for `SfnString`
   instead of `i8*` for C strings. String literals become
   `{ data: @.Lstr, len: N }` constants.
4. Switch array lowering: the compiler emits `{T*, i64, i64}` for `SfnArray<T>`
   instead of `{i8**, i64}` with hidden headers.
5. Update `runtime_helpers.sfn` to reflect native types and symbols.
6. During transition, the C runtime carries a compatibility layer that accepts
   both old and new layouts (detected via ABI version tag). This layer is
   deleted at M3.

**Unblocks:** M2 (Sailfin-native runtime implementation).

**Fast-fail criteria:**
1. `make compile` and `make check` pass with the new ABI.
2. String length is read from the struct field, not computed by `strlen`.
3. Array push does not involve hidden headers or canary writes.

### 4.6 M2 — Core Runtime in Sailfin

**Compiler prereqs:** M1 (ABI lock). Soft: drop emission (§3.1).

**Deliverables:**
1. `runtime/sfn/memory/arena.sfn` — arena allocator (port from C M0.5 +
   enhancements for typed allocation).
2. `runtime/sfn/string.sfn` — all string operations from §2.2.
3. `runtime/sfn/array.sfn` — all array operations from §2.3.
4. `runtime/sfn/exception.sfn` — exception frame management from §2.4.
5. `runtime/sfn/io.sfn` — print, sleep, timing, env from §2.8.
6. `runtime/sfn/process.sfn` — process spawn.
7. `runtime/sfn/type_meta.sfn` — minimal type descriptors (id + name + kind).
8. `runtime/sfn/platform/libc.sfn` — `extern fn` declarations for libc
   (malloc, free, write, fopen, memcpy, setjmp, etc.).
9. `runtime/sfn/platform/pthread.sfn` — `extern fn` declarations for pthreads.
10. `runtime/sfn/platform/posix.sfn` — `extern fn` declarations for POSIX
    (posix_spawnp, clock_gettime, nanosleep).
11. Updated `runtime/prelude.sfn` — delegates to Sailfin-native functions instead
    of `runtime.*` C bindings.

**This milestone proves the runtime can self-host.** The compiler compiles
itself using the Sailfin-native runtime. `hello-world.sfn` and the test suite
run without the C runtime linked.

**Unblocks:** M3 (adapter migration), deletion of most of `sailfin_runtime.c`.

**Fast-fail criteria:**
1. `make compile` produces a working compiler with the Sailfin-native runtime.
2. `make check` passes (seedcheck compiles hello-world, full test suite passes).
3. `runtime/native/src/sailfin_runtime.c` is no longer linked (or linked only
   for adapter stubs awaiting M3).

### 4.7 M3 — Capability Adapters in Sailfin

**Compiler prereqs:** M2. Soft: `Result<T, E>` for error returns.

**Deliverables:**
1. `runtime/sfn/adapters/filesystem.sfn` — filesystem adapter.
2. `runtime/sfn/adapters/http.sfn` — HTTP client adapter.
3. `runtime/sfn/adapters/clock.sfn` — clock/timing adapter.
4. `runtime/sfn/adapters/model.sfn` — model adapter (stub, post-1.0 real).
5. Delete `runtime/native/src/sailfin_runtime.c`.
6. Delete `runtime/native/src/sailfin_sha256.c`, `sailfin_base64.c`.
7. Delete `runtime/native/include/sailfin_runtime.h`.
8. Delete C arena from M0.5 (`sailfin_arena.c`).
9. Move crypto helpers (SHA-256, base64) into a Sailfin capsule or inline in
   the runtime.

**Unblocks:** Clean runtime — every runtime source file is Sailfin.

**Fast-fail criteria:**
1. `find runtime/ -name '*.c' -o -name '*.h'` returns only `native_driver.c`
   (deleted at M5).
2. `make check` passes.
3. `sfn/fs`, `sfn/http`, `sfn/crypto`, `sfn/os` capsules pass their tests.

### 4.8 M4 — Scheduler and Concurrency

**Compiler prereqs:** Closures with capture (M0). Soft: generic constraints for
typed `Channel<T>`.

**Deliverables:**
1. `runtime/sfn/scheduler.sfn` — thread pool scheduler from §2.6.
2. `runtime/sfn/channel.sfn` — typed channels from §2.6.4.
3. Prelude updates: `spawn`, `channel`, `parallel`, `serve` delegate to the
   Sailfin-native scheduler.
4. `sfn/sync` capsule transitions from "stubbed" to "shipped."

**Unblocks:** Structured concurrency features (`routine`, `await`).

**Fast-fail criteria:**
1. `spawn` + `await` integration test runs a function on a worker thread and
   retrieves the result.
2. `channel` test sends and receives 1000 messages between two tasks.
3. `parallel` test runs 4 tasks concurrently and collects results.
4. `serve` test handles 10 concurrent HTTP requests on a test port.

### 4.9 M5 — Native CLI and Driver

**Compiler prereqs:** M2 (core runtime), M3 (adapters).

**Deliverables:**
1. Sailfin-native CLI entrypoint replaces `native_driver.c`.
2. Subcommand dispatch (`run`, `emit`, `test`, `build`, `init`, etc.) is
   implemented in Sailfin.
3. Delete `runtime/native/src/native_driver.c`.
4. Delete `runtime/native/ir/runtime_globals.ll`.
5. `runtime/native/` directory is empty or removed entirely.

**Fast-fail criteria:**
1. `build/native/sailfin run examples/basics/hello-world.sfn` works without any
   C runtime files.
2. `make check` passes using a compiler built with zero C runtime.

---

## 5. Risks and Open Questions

### 5.1 Decisions Needed Before Implementation

**Q1: Is `SfnValue` needed at all in v0?**

The `SfnValue` tagged union in `runtime_abi.md` is reserved but not required if
all prelude runtime calls can be monomorphized. **Recommendation: do not
implement `SfnValue` in v0.** The current prelude uses `any` extensively (see
`runtime/prelude.sfn` — `check_type`, `to_debug_string`, `format_interpolated`
all take `any`), but these are lowered to `i8*` by the compiler today. For v0,
continue using `i8*` for dynamic dispatch paths. Introduce `SfnValue` only if
a concrete use case requires it (e.g., serialization/deserialization round-trips
that need type preservation).

**Q2: How does `string_append` work with arenas?**

`string_append` is a critical optimization for the compiler (eliminates O(n^2)
string building in LLVM IR generation). Arenas don't support realloc.
**Recommendation: grow-if-at-tip** (§4.2). If the string being appended is the
last allocation in the arena's current page, just extend it in place. If not,
allocate-and-copy. This preserves the optimization for the common case (chained
appends in a loop) with no API change. The compiler's lowering in
`core_strings.sfn` continues to emit `string_append` calls; the runtime
implementation changes from `realloc` to `arena_grow_or_copy`.

**Q3: LLVM landing pads vs. explicit frames?**

**Recommendation: explicit frames for v0** (§2.4). LLVM landing pads are
strictly better for happy-path performance (zero cost when no exception is
thrown) but require implementing a full unwind personality, which is a large
surface with platform-specific behavior. The explicit frame approach has a small
per-`try` cost (one stack allocation + one TLS write) but is implementable in a
few hundred lines. Revisit for 1.1 if benchmarks show exception overhead matters.

**Q4: Where does the arena live at runtime?**

For the compiler: one process-global arena, created at startup, destroyed at
exit. For user programs: one default thread-local arena per thread, plus
explicit arenas creatable via `Arena.create()`. **Recommendation: start with a
single process-global arena (M0.5 and M1). Add thread-local arenas in M4 when
the scheduler lands.** This avoids premature thread-safety complexity.

**Q5: Can M1 land without full drop emission?**

**Yes.** M1 changes the data layouts but not the ownership model. The compiler
continues to not emit drops; the global arena handles bulk deallocation at
process exit, same as today (but intentionally instead of accidentally). Drop
emission is needed for M2 (Sailfin-native runtime) to handle RC'd values that
escape arenas. M1 without drops is already a massive improvement over the
current C-string ABI.

**Q6: Variadic `extern fn` for `snprintf` (and similar).**

`snprintf` is variadic in C (`int snprintf(char *, size_t, const char *, ...)`).
The compiler must either support variadic `extern fn` declarations (emitting
LLVM's variadic `declare` syntax with `...`) or the runtime must avoid
variadic externs entirely.

**Recommendation: avoid variadic externs in v0.** Number-to-string formatting
can be hand-rolled in Sailfin (integer and float formatting are ~100 lines
each). This is also how Rust's `std::fmt` works — no reliance on libc
`snprintf`. Variadic extern support can be added post-1.0 if third-party C
libraries need it.

Decision needed: accept the hand-rolled formatting path? (Yes recommended.)

**Q7: Platform-specific opaque struct sizes.**

`PthreadMutex`, `PthreadCond`, `JmpBuf` sizes vary across Linux x86_64 (e.g.,
`pthread_mutex_t` = 40 bytes), macOS arm64 (64 bytes), and other platforms.
Three approaches:

1. **Platform-conditional `.sfn` files.** Ship `platform/pthread_linux_x86_64.sfn`,
   `platform/pthread_macos_arm64.sfn`, etc. The build system selects one per
   target. Simple, no new compiler feature required.
2. **Compile-time target constants.** Add `@target.pthread_mutex_size` etc. as
   compiler-provided constants, accessible from Sailfin source via a
   `@platform_const(...)` intrinsic. More elegant but requires a new compiler
   feature.
3. **Over-allocation.** Use a conservative upper bound (e.g., 128 bytes for
   any mutex). Works but wastes memory and ignores alignment.

**Recommendation: (1) for v0.** Platform-conditional modules are explicit and
require no compiler feature. Revisit in 1.1 if the maintenance cost grows.

### 5.2 Risk Matrix

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| M0 takes longer than expected (integer types, Result, closures are hard) | High | High — delays M1-M5 | M0.5 unblocks perf work independently; M0 items can ship incrementally (int first, then Result, then closures) |
| Arena grow-if-at-tip doesn't cover enough cases for string_append | Medium | Medium — perf regression | Measure: if <80% of appends hit the fast path, implement a separate string builder that uses its own mini-arena |
| ABI switch (M1) breaks self-hosting in subtle ways | Medium | High — compiler can't compile itself | Dual-ABI support during transition: the C runtime accepts both old and new layouts keyed on the `sfn_abi_version` global. Remove dual support at M3. |
| Sailfin-native runtime (M2) is slower than C runtime | Low | Medium — morale/credibility | The C runtime has heavy defensive overhead (hash table lookups, pointer plausibility checks, strlen scans). The native runtime eliminates all of this. Profile continuously. |
| Thread pool scheduler (M4) has correctness bugs under load | Medium | Medium — blocks concurrency features | Start with mutex-guarded queue (simple, correct). Optimize to lock-free only after correctness is proven. |
| The compiler's existing lifetime/ownership tracking is insufficient for drop emission | Medium | High — delays M2 | The conservative approach (arena for everything, no drops, bulk reset at exit) works for the compiler and short-lived programs. RC + drops are needed only for long-lived programs and can be deferred to late M2 or M3. |

---

## 6. Non-Goals (v0)

The following are explicitly **not** in scope for the 1.0 runtime:

- **SIMD-friendly array layouts.** Baseline `{data, len, cap}` is sufficient.
  SIMD intrinsics can be added post-1.0 without ABI changes (data is already
  contiguous and alignable).
- **GPU dispatch.** The `gpu` effect is parsed but unimplemented; the runtime
  does not include GPU primitives.
- **Distributed scheduling.** The scheduler is local to a single process.
- **Hot code reload.** No mechanism for replacing compiled modules at runtime.
- **User-facing `extern fn`.** The `extern fn` mechanism is used by the runtime
  to reach platform libraries. User programs cannot declare `extern fn` in v0 —
  the mechanism is runtime-internal. (User-facing extern is post-1.0.)
- **Tracing GC.** Not needed with arena + RC. If cycles become a problem
  post-1.0, add weak references.
- **Async I/O / epoll / io_uring.** The v0 scheduler uses blocking I/O with
  thread-per-connection. Non-blocking I/O is a post-1.0 optimization.
- **String interning.** No global intern table. Can be added as an arena
  subsystem if profiling justifies it.
- **Full type descriptor emission with field offsets.** Minimum viable is
  id + name + kind. Field descriptors are added incrementally.
- **Stable external ABI.** The ABI is versioned for internal compatibility
  checking, not for third-party binary compatibility.

---

## Appendix A: Mapping from Current C Symbols to Native Symbols

| Current C symbol | Native replacement | Milestone |
|---|---|---|
| `sailfin_runtime_print_raw` | `sfn_print` | M2 |
| `sailfin_runtime_print_err` | `sfn_print_err` | M2 |
| `sailfin_runtime_print_info/warn/error` | `sfn_print_info/warn/error` | M2 |
| `sailfin_runtime_sleep` | `sfn_sleep` | M2 |
| `sailfin_runtime_monotonic_millis` | `sfn_clock_millis` | M2 |
| `sailfin_runtime_string_length` | `SfnString.len` (field access) | M1 |
| `sailfin_runtime_string_concat` | `sfn_str_concat` | M2 |
| `sailfin_runtime_string_append` | `sfn_str_concat` (arena) | M2 |
| `sailfin_runtime_string_drop` | `sfn_rc_release` or arena bulk | M2 |
| `sailfin_runtime_substring` | `sfn_str_slice` | M2 |
| `sailfin_runtime_grapheme_at` | `sfn_str_grapheme_at` | M2 |
| `sailfin_runtime_grapheme_count` | `sfn_str_grapheme_count` | M2 |
| `sailfin_runtime_char_code` | `sfn_str_codepoint` | M2 |
| `sailfin_runtime_string_to_number` | `sfn_str_to_number` | M2 |
| `sailfin_runtime_number_to_string` | `sfn_number_to_str` | M2 |
| `sailfin_runtime_concat` (array) | `sfn_array_concat` | M2 |
| `sailfin_runtime_append_string` | `sfn_array_push` | M2 |
| `sailfin_runtime_array_push` | `sfn_array_push` | M2 |
| `sailfin_runtime_array_push_slot` | `sfn_array_push` (monomorphic) | M2 |
| `sailfin_runtime_process_run` | `sfn_process_run` | M2 |
| `sailfin_adapter_fs_read_file` | `sfn_fs_read_file` | M3 |
| `sailfin_adapter_fs_write_file` | `sfn_fs_write_file` | M3 |
| `sailfin_runtime_set/has/clear/take_exception` | `sfn_try_enter/leave/throw/take` | M2 |
| `sailfin_runtime_spawn_*` | `sfn_spawn` | M4 |
| `sailfin_runtime_await_*` | `sfn_await` | M4 |
| `sailfin_runtime_channel` | `sfn_channel_create` | M4 |
| `sailfin_runtime_serve` | `sfn_serve` | M4 |
| `sailfin_runtime_is_string/number/boolean/...` | `sfn_type_of` (compile-time fold or registry) | M2 |
| `sailfin_runtime_sha256_hex` | `sfn/crypto` capsule | M3 |
| `sailfin_runtime_base64_encode` | `sfn/crypto` capsule | M3 |
| `sailfin_runtime_http_get/post_json/download` | `sfn_http_get/post` | M3 |

## Appendix B: Compiler Files Affected by Milestone

### M0.5 (Arena in C)
- `runtime/native/src/sailfin_arena.c` (new)
- `runtime/native/include/sailfin_arena.h` (new)
- `runtime/native/src/sailfin_runtime.c` (route allocations through arena)

### M1 (ABI Lock + Codegen Switch)
- `compiler/src/llvm/runtime_helpers.sfn` (update all descriptors)
- `compiler/src/llvm/lowering/module_globals.sfn` (emit ABI version)
- `compiler/src/llvm/lowering/emission.sfn` (string literal layout change)
- `compiler/src/llvm/expression_lowering/native/core_strings.sfn` (SfnString ops)
- `compiler/src/llvm/expression_lowering/native/core_ops_lowering.sfn` (array ops)
- `compiler/src/llvm/expression_lowering/native/core_scopes.sfn` (allocation_kind)
- `compiler/src/llvm/types.sfn` (add allocation_kind to LocalBinding)
- `compiler/src/llvm/lowering/lowering_phase_types.sfn` (struct layout emission)
- `site/src/content/docs/docs/reference/runtime-abi.md` (lock to v0)

### M2 (Core Runtime in Sailfin)
- `runtime/sfn/` (all new files per §1.5)
- `runtime/sfn/platform/*.sfn` (new — `extern fn` declarations, no C)
- `runtime/prelude.sfn` (rewrite delegates)
- `compiler/src/llvm/lowering/instructions.sfn` (scope drop emission)
- `compiler/src/llvm/lowering/instructions_try.sfn` (catch cleanup)
- `compiler/src/llvm/lowering/instructions_helpers.sfn` (emit_scope_drops)
- `compiler/src/llvm/expression_lowering/native/core_scopes.sfn` (drop tracking)
- `Makefile` (link Sailfin-native runtime instead of C runtime)
- `scripts/build.sh` (compile runtime modules alongside compiler)

### M3 (Adapters + Delete C Runtime)
- `runtime/sfn/adapters/` (new adapter files)
- `runtime/native/src/sailfin_runtime.c` (delete)
- `runtime/native/src/sailfin_sha256.c` (delete)
- `runtime/native/src/sailfin_base64.c` (delete)
- `runtime/native/include/sailfin_runtime.h` (delete)
- `runtime/native/src/sailfin_arena.c` (delete — M0.5 temporary)
- `capsules/sfn/crypto/` (absorb SHA-256 and base64)

### M4 (Scheduler + Concurrency)
- `runtime/sfn/scheduler.sfn` (new)
- `runtime/sfn/channel.sfn` (new)
- `runtime/prelude.sfn` (update spawn/channel/parallel/serve)
- `capsules/sfn/sync/` (unstub)
- `compiler/src/llvm/runtime_helpers.sfn` (add scheduler symbols)

### M5 (Native CLI + Driver)
- `runtime/native/src/native_driver.c` (delete)
- `runtime/native/ir/runtime_globals.ll` (delete)
- `compiler/src/cli_main.sfn` (becomes the true entrypoint)
- `scripts/build.sh` (remove C driver compilation step)

---

## Appendix C: Subsystem C-Authoring Audit

This table confirms that no runtime subsystem depends on C-authored code. The
sole exception is the M0.5 arena in C, which is explicitly disposable.

| Subsystem | Authored C code? | How platform is reached |
|---|---|---|
| Arena allocator (§2.1.1) | No (except M0.5 disposable) | `extern fn malloc` / `free` in `platform/libc.sfn` |
| Reference counting (§2.1.2) | No | LLVM atomic intrinsics via §3.5 builtins |
| Strings (§2.2) | No | Uses arena + `extern fn memcpy` |
| Arrays/slices (§2.3) | No | Uses arena + `extern fn memcpy` |
| Exceptions (§2.4) | No | `extern fn setjmp` / `longjmp` in `platform/libc.sfn`; opaque `JmpBuf` |
| Type metadata (§2.5) | No | Pure Sailfin structs + hash map |
| Scheduler / tasks (§2.6) | No | `extern fn pthread_*` in `platform/pthread.sfn`; LLVM atomics for flags |
| Channels (§2.6.4) | No | `extern fn pthread_mutex_*` + atomics |
| Filesystem adapter (§2.7.1) | No | `extern fn fopen` / `fread` / `stat` in `platform/libc.sfn` |
| HTTP adapter (§2.7.2) | No | `extern fn socket` / `connect` / etc. in `platform/net.sfn` |
| Clock adapter (§2.7.4) | No | `extern fn clock_gettime` / `nanosleep` in `platform/posix.sfn` |
| I/O primitives (§2.8) | No | `extern fn write` / `getenv` in `platform/libc.sfn` |
| Process (§2.8 / runtime) | No | `extern fn posix_spawnp` / `waitpid` in `platform/posix.sfn` |
| CLI / driver (M5) | No | Pure Sailfin; argv is handed in as `SfnArray<SfnString>` |
| Crypto (SHA-256, base64) | No | Pure Sailfin in `runtime/sfn/crypto.sfn` |

**Temporary exceptions (deleted by M3 / M5):**

| File | Purpose | Deleted at |
|---|---|---|
| `runtime/native/src/sailfin_arena.c` | M0.5 disposable arena | M3 |
| `runtime/native/src/sailfin_runtime.c` | Existing C runtime | M3 |
| `runtime/native/src/sailfin_sha256.c` | SHA-256 helper | M3 (moved to `runtime/sfn/crypto.sfn`) |
| `runtime/native/src/sailfin_base64.c` | Base64 helper | M3 (moved to `runtime/sfn/crypto.sfn`) |
| `runtime/native/include/sailfin_runtime.h` | Current C runtime header | M3 |
| `runtime/native/src/native_driver.c` | CLI entrypoint | M5 |
| `runtime/native/ir/runtime_globals.ll` | LLVM stub | M5 |

At end-of-M5, `runtime/native/` is empty and removed. Every line of
Sailfin toolchain source is `.sfn`.

---

## Cross-references

- `docs/runtime_audit.md` — current C runtime state and compiler prerequisites.
- `site/src/content/docs/docs/reference/runtime-abi.md` — target ABI contract (this architecture references and
  confirms its layouts).
- `docs/build-performance.md` — perf analysis; M0.5 directly addresses its
  Phase 0.
- [sailfin.dev/roadmap](https://sailfin.dev/roadmap) — 1.0 priorities (syntax reform, runtime rewrite).
- `compiler/src/llvm/runtime_helpers.sfn` — runtime helper registry (updated
  at M1).
- `compiler/src/llvm/types.sfn` — compiler-internal types (extended at M1 for
  allocation_kind).
