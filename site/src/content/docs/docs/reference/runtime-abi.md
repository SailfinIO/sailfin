---
title: Runtime ABI
description: Sailfin's native runtime ABI specification.
section: reference
sidebar:
  order: 7
---

## Goals

- Performance-first data layouts
- Stable, versioned ABI
- Zero-copy slices
- Clear interop boundaries for FFI

## Core Data Layouts

### String

```
{ u8* data, i64 len }   // UTF-8, not NUL-terminated
```

### Array (Owned)

```
{ T* data, i64 len, i64 cap }
```

### Slice (Borrowed)

```
{ T* data, i64 len }    // Non-resizable view
```

### Dynamic Value

```
{ i64 tag, union{...} payload }   // Tagged union
```

## Ownership Model (v0)

Hybrid approach: reference counting + arenas.

- **Arenas** for short-lived allocations (within a scope)
- **Reference counting** for values that escape their scope
- **Explicit retain/release** for RC-managed values

## Allocation Helpers

The compiler emits calls to two arena-aware helpers for boxed allocations
that the bump-allocator arena (`runtime/native/src/sailfin_arena.c`) can
reclaim in bulk via `runtime.arena_mark` / `runtime.arena_rewind`.
Both fall through to libc `calloc` / `free` when the arena is disabled
(`SAILFIN_USE_ARENA=0`), so off-arena callers retain the original
malloc-based lifetime contract.

| Symbol | Signature | When emitted | Pairs with | Arena | Off-arena |
| --- | --- | --- | --- | --- | --- |
| `sailfin_runtime_alloc_struct` | `i8* (i64 size_bytes)` | string-literal materialization, struct/array literal boxing, scalar→`i8*` coercion | `sailfin_runtime_free` (or arena bulk reclaim) | `_rt_calloc` → arena | `calloc(1, size)` |
| `sailfin_runtime_free` | `void (i8*)` | await-unboxing of a boxed-struct future return | `sailfin_runtime_alloc_struct` | no-op (arena reclaims at rewind / exit) | `free(ptr)` |

Important: `sailfin_runtime_free` must only be paired with pointers from
`sailfin_runtime_alloc_struct` (or other `_rt_calloc`-routed allocations).
Calling it on a libc-`malloc`/`calloc` pointer while the arena is
enabled would leak that pointer; calling libc `free` on an arena-allocated
pointer corrupts glibc chunk metadata.

The async-context calloc/free pair in `compiler/src/llvm/lowering/emission_async.sfn`
intentionally stays on raw `@calloc` / `@free` because both ends of the
allocation are libc-resident regardless of arena state.

## Exception / Unwind ABI

Structured frames with deterministic unwind. Currently implemented via C runtime's `setjmp`/`longjmp`, planned to move to native structured exceptions.

---

*The runtime is actively migrating from C to Sailfin. See the [runtime audit](https://github.com/SailfinIO/sailfin/blob/main/docs/runtime_audit.md) for current status.*
