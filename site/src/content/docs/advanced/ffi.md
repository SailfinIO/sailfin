---
title: Unsafe & FFI
description: Foreign function interface and unsafe operations.
section: advanced
order: 4
---

## Unsafe Blocks

Sailfin's safety guarantees can be bypassed in `unsafe` blocks for low-level operations:

```sfn
unsafe {
    let ptr: raw *mut Int = raw_alloc(size);
    raw_write(ptr, 42);
    let value = raw_read(ptr);
    raw_free(ptr);
}
```

## Extern Functions

Call C functions via `extern` declarations:

```sfn
extern fn malloc(size: Int) -> raw *mut Byte;
extern fn free(ptr: raw *mut Byte);
extern fn strlen(s: raw *Byte) -> Int;
```

## Raw Pointers

- `raw *T` — Raw immutable pointer
- `raw *mut T` — Raw mutable pointer
- `opaque` — Opaque foreign type

## Safety Rules

- Raw pointer operations require `unsafe` blocks
- `unsafe` blocks cannot be used inside pure (no-effect) functions without explicit `![io]`
- FFI calls are inherently unsafe — the compiler trusts `extern` declarations

---

*FFI is parsed and partially implemented. Full extern support is planned for the native runtime migration. See [Runtime ABI](/docs/reference/runtime-abi).*
