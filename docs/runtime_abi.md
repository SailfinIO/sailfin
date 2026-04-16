# Sailfin Native Runtime ABI (Draft v0)

**Date:** 2026-04-15
**Previous revision:** pre-April 2026 (dated, superseded)
**Companion docs:** `docs/runtime_audit.md` (current state), `docs/build-performance.md`

This document describes the target ABI between the self-hosted compiler and the
future Sailfin-native runtime. It also captures what the **current** C-string
ABI looks like and the migration plan between the two.

The current toolchain is built on a legacy C-string ABI; the rewrite target is
a versioned native ABI with explicit layouts and ownership rules. The two
coexist only during migration.

## Goals

- Performance-first layouts for strings, arrays, and value passing.
- Stable, versioned ABI with explicit ownership rules.
- Zero-copy slices and predictable allocation behavior.
- Clear interop boundary between the runtime, compiler-emitted IR, and a
  narrow C-FFI surface for platform syscalls.
- No defensive pointer-tag hacks, hash tables, or ring buffers guarding
  per-helper entry.

## Non-Goals (v0)

- A stable external C FFI for user programs (runtime-internal only).
- A tracing GC; the ownership model is deterministic.
- Covering dynamic/reflective values beyond what the prelude needs — prefer
  monomorphic lowering.

---

## Part A — Current (C-string) ABI

This is what ships today in `runtime/native/src/sailfin_runtime.c` and what the
compiler emits calls against. Captured here so the migration is concrete, not
aspirational.

### String

- Representation: `char*` pointing at NUL-terminated UTF-8 bytes.
- Pointer types the runtime must accept:
  1. Static literals emitted into LLVM `.rodata`.
  2. Runtime-allocated strings tracked in the owned-string hash table.
  3. **Immediate-codepoint pseudo-strings**: tagged pointers where the value
     `(codepoint << 32)` is cast to `char*`. Used for ASCII single-byte
     graphemes to avoid per-byte allocation on hot paths. Every string helper
     must check `_is_immediate_codepoint_string` before dereferencing.
  4. Strings marked persistent (large strings, leak-for-process-lifetime).
- Length: discovered by `_safe_strlen_asan` scan on every call that needs it,
  capped by `SAILFIN_MAX_STRLEN_SCAN` (default 16 MiB).
- Ownership: opaque to the compiler. `string_drop` is opt-in and disabled by
  default (`SAILFIN_ENABLE_STRING_FREE=0`).

### Pointer array

- Representation: `SailfinPtrArray { char** data; int64_t len; }`, passed by
  pointer.
- Runtime-allocated arrays carry a hidden 2-word header (`magic`, `capacity`)
  **before** `data`, plus a 4-slot canary after the live region. Growth is
  in-place via `realloc`.
- Stack-allocated pointer arrays carry neither the header nor canaries; a
  recent-array ring buffer gates the unsafe `data[-2]` header read to prevent
  segfaults on stack arrays.

### Byte-addressed array

- Representation: `data_ptr**`, `len*`, passed as mutable out-pointers to
  `sailfin_runtime_array_push_slot`.
- Hidden 4-word header (`magic`, `capacity`, `elem_size`, reserved) before the
  live region plus 32 canary bytes.

### Number, boolean, void

- `double` (i.e. f64) for all numbers, including char codes, bytes, indices,
  lengths-as-result-of-count. This is why pointers get double-encoded in
  legacy fixup categories.
- `bool` (i1) for booleans.
- `void*` / `NULL` for `void`.

### Exceptions

- TLS string slot for the message, accessed via
  `sailfin_runtime_set_exception` / `has_exception` / `clear_exception` /
  `take_exception`. The compiler polls `has_exception` after every callable
  call to decide whether to branch to a catch region.
- A parallel `try_enter`/`throw`/`try_leave` setjmp/longjmp path exists in
  the runtime but is **not** used by current lowering.

### Futures

- Per-future typed structs (`SailfinFutureNumber`, `SailfinFutureBool`,
  `SailfinFuturePtr`, `SailfinFutureVoid`, `SailfinFutureString`) backed by a
  `pthread_t` created eagerly in `spawn_*`, joined by `await_*`. No scheduler,
  no pooling, no cancellation.

### Calling convention

- Inherits the platform C ABI. Small aggregates (`SailfinPtrArray*`) are
  passed as pointers. Futures are passed as opaque struct pointers.
- Every runtime entry calls `_runtime_enter()` to bump a global call-sequence
  counter that invalidates the concat-reuse cache.

---

## Part B — Target (Sailfin-native) ABI

This is the contract the runtime rewrite targets. All layouts here are
**versioned** and carry explicit ownership semantics.

### ABI versioning

- `sailfin_abi_version` is a `u32` monotonic counter plus a layout hash.
- The compiler emits the ABI version as IR metadata on module globals
  (`!sailfin.abi = !{i32 <version>, !"<layout-hash>"}`).
- The runtime rejects mismatched ABI versions at image load time.
- Breaking layout changes bump the major version; additive changes bump minor.
- Bump policy: once 1.0 ships, breaking ABI changes require explicit release-
  notes entries and a migration in `runtime_audit.md`.

### Core data layouts

#### String

```sailfin-abi
struct SfnString {
    u8* data;   // UTF-8 bytes; may be null when len == 0; NOT NUL-terminated
    i64 len;
}
```

- No hidden header. No tagged-pointer pseudo-strings.
- Static literals are emitted as `{ data: @.Lstr, len: N }` constants.
- Slicing into a borrowed region returns `SfnSlice<u8>` (see below).
- Hash is computed from `{data, len}`; never assume NUL termination.

#### Array (owned)

```sailfin-abi
struct SfnArray<T> {
    T*  data;
    i64 len;
    i64 cap;
}
```

- Owned by a single owner; dropping frees `data` (potentially after calling
  `T::drop` on each live element).
- Growth: runtime helper `sfn_array_grow<T>(&mut SfnArray<T>, i64 want)`; no
  hidden headers, no canaries.
- For `T = u8`, `SfnArray<u8>` **is** a byte buffer; no separate layout.

#### Slice (borrowed)

```sailfin-abi
struct SfnSlice<T> {
    T*  data;
    i64 len;
}
```

- Non-resizable, non-owning. Lifetime is tied to the owning array/region.
- `SfnSlice<u8>` is the canonical borrowed-string type for read-only passes.

#### Dynamic value (reserved, optional)

```sailfin-abi
struct SfnValue {
    i64 tag;
    union {
        i64       i;
        f64       f;
        bool      b;
        SfnString s;
        void*     ptr;
    } payload;
}
```

- Reserved for reflection and late-bound prelude surfaces only. Monomorphic
  lowering is strongly preferred; adding an `SfnValue` parameter is an
  explicit opt-in.
- Tag values are defined alongside the runtime type registry (see Reflection).

### Integer types

- `int` lowers to `i64` (signed).
- `float` lowers to `f64`.
- `index`, `len`, `cap`, `grapheme_count`, `byte_offset`, codepoint values,
  and char codes are **all `i64`**, not `f64`. This is the single biggest
  reason the `int`/`float` split is a runtime-rewrite prerequisite.

### Booleans

- `i1` with ABI-level zero-extension to `i8` at struct-field granularity.
  (Same as current, but now mandatory — no more `double`-encoded booleans.)

### Ownership and memory model

**Proposed (design call — confirmed by the runtime architect spawned after
M0 compiler prerequisites ship):** Hybrid arenas + RC, with arenas as the
primary mechanism.

- **Arenas / regions.** Bulk-reset allocation backing short-lived scopes.
  The compiler — a batch process — runs inside one top-level arena. User
  programs can open explicit `arena { ... }` regions for request-scoped
  allocations.
- **Reference counting** for values that escape their originating region or
  cross async boundaries. Emitted by the compiler from an explicit escape
  analysis; the runtime exposes `sfn_rc_retain` / `sfn_rc_release`.
- **No tracing GC** in v0.
- **No implicit persistent-pointer tables** and **no pointer tagging**.
  Immediate-codepoint pseudo-strings are retired.

ABI requirements the compiler must meet:

- Emit explicit `drop` calls at scope exit for every heap-owning value.
- Emit `retain` when a value is handed to an RC boundary (spawn, channel
  send, long-lived collection).
- Emit arena-handle arguments only where bulk reclamation is required
  (primarily compiler-internal APIs; user programs pass arenas implicitly
  via scope).

**Why not full RC everywhere.** Per-allocation refcount bookkeeping has real
cost on the compiler's allocation-heavy workload; arenas avoid the RC traffic
for transient values. See `docs/build-performance.md` Phase 0 for the
empirical motivation.

**Why not full arena everywhere.** User programs have long-lived state
(caches, in-memory databases, actor mailboxes) that cannot be pinned to a
scope. RC handles those without a tracing collector.

### Exceptions and unwind

```sailfin-abi
struct SfnExceptionFrame {
    SfnExceptionFrame* prev;
    void*              landing_pad;
    SfnString          message;
    // optional: captured value for typed exceptions
}
```

- Compiler emits frame setup/teardown intrinsics at `try`/`catch` boundaries.
- Runtime provides `sfn_throw`, `sfn_begin_try`, `sfn_end_try`,
  `sfn_take_exception` — no TLS message slot, no per-call `has_exception`
  polling.
- Unwind runs user-visible `drop` hooks for in-scope heap-owning values
  between the raise site and the landing pad.
- The setjmp/longjmp path in the current C runtime is **not** the target; the
  target is explicit landing-pad emission.

### Reflection and type metadata

- Emitted per-type `SfnTypeDescriptor` constants:
  ```sailfin-abi
  struct SfnTypeDescriptor {
      i64        id;        // stable within an ABI version
      SfnString  name;
      i32        kind;      // primitive | struct | enum | interface | array | function
      i32        field_count;
      SfnField*  fields;    // null when kind != struct/enum
  }
  ```
- Runtime type registry is populated at module load; `instance_of` /
  `resolve_type` / `get_field` operate on descriptor pointers, not strings.
- Static `is_string`/`is_number`/`is_boolean`/`is_callable` are lowered to
  constant-folded tag checks when the compiler knows the static type;
  reflection-level queries go through the registry.

### Runtime service ABI

Core runtime helpers accept native layouts directly (no C-string translation,
no `SailfinPtrArray` header convention):

- **String.** `sfn_str_len`, `sfn_str_slice`, `sfn_str_concat`,
  `sfn_str_append`, `sfn_str_grapheme_at`, `sfn_str_codepoint_count`.
- **Array.** `sfn_array_grow`, `sfn_array_push`, `sfn_array_concat`,
  `sfn_slice_of`.
- **Type metadata.** `sfn_type_of`, `sfn_instance_of`, `sfn_field_of`.
- **Effects / capabilities.** Filesystem, HTTP, model adapters and capability
  grants.
- **Futures / scheduler.** `sfn_spawn<T>`, `sfn_await<T>`, `sfn_channel<T>`,
  `sfn_channel_send<T>`, `sfn_channel_recv<T>`, `sfn_parallel<T>`,
  `sfn_serve<Req, Resp>`.
- **Arena / memory.** `sfn_arena_open`, `sfn_arena_close`,
  `sfn_arena_alloc<T>`, `sfn_rc_retain`, `sfn_rc_release`.

### Calling convention

- Scalars (`i1`, `i64`, `f64`) follow the platform ABI.
- Fixed-size aggregates up to two machine words (e.g., `SfnString`,
  `SfnSlice<T>`) are passed and returned by value where the platform ABI
  permits; larger aggregates use `sret`.
- `SfnArray<T>` is passed by pointer (opaque mutable handle) to keep `cap`
  mutations coherent across call boundaries.
- Exception frames are caller-owned, stack-allocated structs chained through
  the `prev` pointer — no heap allocation on the happy path.

---

## Part C — Migration Plan

The migration has three honest preconditions:

1. **Compiler prerequisites.** See `docs/runtime_audit.md` §"Compiler
   Prerequisites" — integer types, `Result<T, E>`, closures-with-capture,
   destructors, generic constraints, ownership enforcement.
2. **ABI version lock.** The field layouts above are final for v0 before
   codegen flips. Changes before lock are cheap; changes after lock require
   a version bump and a release-notes migration entry.
3. **Memory primitive availability.** Either an arena exists in the current
   C runtime (temporary unblocker — see `build-performance.md` Phase 0) or
   the rewrite begins with arena as its first runtime primitive.

### Steps

1. **Lock ABI v0** (this file). Emit `sailfin_abi_version` metadata into IR
   so even pre-rewrite compiler builds carry a version marker.
2. **Stabilize memory primitive.** Either (a) arena in C as Phase 0 of
   `build-performance.md`, which persists only until M3, or (b) arena as the
   first Sailfin-native runtime helper, which means M1 and Phase 0 collapse
   into the same work item.
3. **Native layouts alongside C ABI.** The runtime carries both string and
   array representations during migration; compiler lowering picks native
   layouts for newly-migrated modules and C layouts for legacy paths.
4. **Migrate lowering paths.** One pipeline stage at a time, following the
   ordering in roadmap §2 / §3. Each migrated stage emits native calls; the
   test suite gates at each step.
5. **Migrate runtime sources.** Strings and arrays first (most helpers),
   then exceptions, then adapters, then the scheduler, then the CLI.
6. **Retire C shims.** Delete `runtime/native/src/sailfin_runtime.c`,
   `native_driver.c`, `sailfin_sha256.c`, `sailfin_base64.c`. Delete
   pointer-tagging helpers and the owned/persistent hash tables.
7. **Retire defensive scaffolding.** Every `_is_corrupted_string_ptr`,
   `_safe_strlen_asan`, canary, and `SAILFIN_TRACE_*` env var disappears as
   its motivating hazard is removed by the native ABI.

### Items explicitly not on the ABI v0 surface

- **User-facing C FFI.** Runtime-internal only. User programs do not call C
  directly in v0.
- **SIMD-friendly array layouts.** Future ABI revision. v0 ships with the
  baseline `{data, len, cap}`.
- **Opaque handle types for OS resources.** Files, sockets, GPU contexts.
  Modeled through capability adapters, not ABI primitives.
- **Exception values beyond a message string.** Typed exceptions carrying a
  user value land post-ABI-lock if needed; v0 carries `SfnString` only.

---

## Open Questions

- **Do we need `SfnValue` at all in v0?** If every prelude-surfaced runtime
  call can be monomorphized, delete it from the ABI and force callers through
  specialized entry points. Current answer: keep it reserved but unused —
  cheap to add, costly to remove once shipped.
- **How rich is type metadata emission?** Full descriptors with fields are
  large; minimum-viable is id + name + kind. Pick based on what
  `instance_of` and `get_field` actually need once implemented on real types.
- **Where does the arena live at runtime?** Process-global for the compiler
  (one arena per module, reset between modules) vs. thread-local for user
  programs (one arena per task / request). Probably both, selected by
  context — but the API surface should make the choice explicit.
- **Is `SfnExceptionFrame` the right shape for zero-cost happy paths?** If
  LLVM's native landing-pad intrinsics produce better code, the ABI may
  define the frame layout as "whatever LLVM emits" and rely on the unwind
  tables rather than an explicit frame chain.

## Cross-references

- `docs/runtime_audit.md` — current runtime state and compiler prerequisites.
- `docs/build-performance.md` — perf analysis that motivated the memory
  model decision.
- [sailfin.dev/roadmap](https://sailfin.dev/roadmap) — 1.0 runtime rewrite workstream.
- `compiler/src/llvm/runtime_helpers.sfn` — current runtime helper registry
  (source of truth for the Part A surface).
