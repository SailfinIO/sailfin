---
title: Runtime ABI
description: Sailfin's native runtime ABI specification.
section: reference
order: 7
---

> Canonical source: [`docs/runtime_abi.md`](https://github.com/SailfinIO/sailfin/blob/main/docs/runtime_abi.md)

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

## Exception / Unwind ABI

Structured frames with deterministic unwind. Currently implemented via C runtime's `setjmp`/`longjmp`, planned to move to native structured exceptions.

---

*The runtime is actively migrating from C to Sailfin. See the [runtime audit](https://github.com/SailfinIO/sailfin/blob/main/docs/runtime_audit.md) for current status.*
