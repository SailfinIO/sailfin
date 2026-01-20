# Sailfin Native Runtime ABI (Draft v0)

This document defines the initial Sailfin-native ABI for the 1.0 runtime.
It is the contract between the self-hosted compiler and the native runtime.

The current toolchain still relies on a legacy C ABI for many helpers; this
spec captures the target state and the migration plan to get there.

## Goals

- Performance-first layouts for strings, arrays, and value passing.
- Stable, versioned ABI with explicit ownership rules.
- Zero-copy slices and predictable allocation behavior.
- Clear interop boundary for native runtime services and future FFI.

## Non-Goals (v0)

- A stable external C FFI for user programs (runtime-internal only).
- A tracing GC in v0; the ownership model is explicit and deterministic.

## ABI Versioning

- The ABI has a versioned header (`sailfin_abi_version`) and layout hash.
- The compiler emits the ABI version into generated IR metadata.
- The runtime rejects mismatched ABI versions at load time.

## Core Data Layouts

### String

Representation: UTF-8 bytes, not NUL-terminated.

```
struct SfnString {
    u8* data;
    i64 len;
}
```

Notes:
- `data` may be null when `len == 0`.
- String slicing returns `SfnSlice<u8>` or `SfnString` depending on ownership.

### Array (Owned)

```
struct SfnArray<T> {
    T* data;
    i64 len;
    i64 cap;
}
```

### Slice (Borrowed)

```
struct SfnSlice<T> {
    T* data;
    i64 len;
}
```

Notes:
- Slices do not own memory and are non-resizable.
- Array resizing is a runtime helper and follows the ownership model.

### Dynamic Value (Optional v0)

Prefer monomorphic lowering for performance. If dynamic values are required
by the prelude or reflection, use a tagged layout:

```
struct SfnValue {
    i64 tag;
    union {
        i64 i;
        f64 f;
        void* ptr;
        SfnString str;
    } payload;
}
```

If dynamic values are not required by the runtime surface, prefer monomorphic
lowering to avoid tag dispatch overhead.

## Ownership and Memory Model (v0)

### Selected model: Hybrid (RC + arenas)

Evidence from current behavior:

- The compiler generates large volumes of short-lived strings/arrays and
  currently relies on defensive "persistent" hacks in the C runtime to avoid
  use-after-free. This indicates a need for cheap, predictable allocation and
  bulk reclamation for short-lived data.
- Some values (runtime services, cached metadata, long-lived strings) must
  escape scopes safely, requiring deterministic lifetime management.

Design choice:

- **Arenas/regions** for short-lived allocations within compilation phases or
  runtime request scopes (fast alloc/free, minimal overhead).
- **Reference counting** for values that escape their originating region or
  cross async boundaries.

ABI requirements:

- Explicit `retain`/`release` for RC-managed values.
- Region/arena handle passed where bulk reclamation is required.
- Clear escape rules emitted by the compiler (when to bump refcount).
- No implicit "persistent pointer" tables or pointer tagging.

## Exceptions and Unwind ABI

Exceptions use structured frames with deterministic unwind (no global flags).

```
struct SfnExceptionFrame {
    void* prev;
    void* landing_pad;
    SfnString message;
}
```

Requirements:
- Compiler emits frame setup/teardown intrinsics.
- Runtime provides `throw`, `begin_try`, `end_try`, `take_exception`.
- Unwind must be compatible with ownership/drops for in-scope values.

## Runtime Service ABI

Core runtime helpers should accept native layouts:

- String: length, concat, substring, grapheme access.
- Arrays: concat, append, push/grow, map/filter/reduce.
- Type metadata: `is_*`, `resolve_type`, `instance_of`, `get_field`.
- Effects: filesystem, HTTP, model adapters, and capability grants.

## Calling Convention (v0)

- Scalars (`i1`, `i64`, `f64`) follow the platform ABI.
- Fixed-size aggregates up to two machine words (e.g., `SfnString`) are passed
  and returned by value where the platform ABI permits; larger aggregates use
  sret.
- `SfnArray<T>` is passed by pointer (opaque handle) to avoid large copies and
  to keep `cap` mutations coherent.

## Migration Plan (High-Level)

1. **Document ABI** (this file) and wire version metadata into codegen.
2. **Implement native layouts** in the runtime alongside C ABI shims.
3. **Update lowering** to emit native ABI types for strings/arrays.
4. **Replace ownership hacks** (persistent pointer tables, pointer tagging).
5. **Remove C ABI shims** and delete the legacy runtime.

## Open Questions

- Do we need a dynamic `SfnValue` in v0, or can all runtime surfaces be typed?
- How should type metadata be emitted to minimize compile-time overhead?
