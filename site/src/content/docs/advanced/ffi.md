---
title: Unsafe & FFI
description: Foreign function interface, unsafe blocks, raw pointers, and C interoperability.
section: advanced
order: 4
---

Sailfin's safety system — effect tracking, ownership, borrow checking — operates entirely within the language. When you need to call a C library, interact with OS APIs, or drop down to raw memory operations, you step outside those guarantees through the **FFI** (Foreign Function Interface). Sailfin makes this boundary explicit: you declare what you are doing, mark it unsafe, and the rest of your codebase remains provably clean.

This page documents Sailfin's FFI system as specified in §6.1.5 of the language specification.

**Bootstrap status:** The parser accepts `unsafe`, `extern`, and raw pointer syntax (`*T`, `*mut T`). The current compiler does not enforce unsafe semantics at runtime. The native compiler will enforce all rules described on this page. Code using these constructs should be written to the specification now, as the enforcement is actively being implemented.

## Overview

FFI enables:

- **Calling C libraries** — libc, system libraries, third-party native libraries
- **OS API access** — file descriptors, sockets, signals, platform-specific calls
- **Performance-critical code** — SIMD intrinsics, hardware interfaces, custom allocators
- **Embedding in C/C++ programs** — exposing Sailfin functions to a C host

The trade-off is clear: inside an `unsafe` block, the compiler cannot verify memory safety, null safety, or correct ownership. You are responsible for upholding those invariants. The design goal is to make the unsafe surface area as small and explicit as possible, so that auditors and security reviews can focus on a well-defined subset of the codebase.

## `unsafe` Blocks

An `unsafe { ... }` block is a lexical scope inside which raw pointer operations and calls to foreign functions are permitted. Outside this scope, none of those operations are legal — the compiler rejects them.

```sfn
fn allocate_buffer(bytes: Int) ![unsafe] -> *u8 {
    unsafe {
        let ptr = malloc(bytes);
        // Dereferencing raw pointers is only legal inside this block.
        return ptr;
    }
}
```

The `![unsafe]` effect on the function signature is the designed annotation for functions that contain unsafe blocks. Once fully enforced, the effect will propagate upward — callers of `allocate_buffer` must also declare `![unsafe]` unless they wrap the call in a safe abstraction that handles all unsafe invariants internally and returns a safe type.

> **Current enforcement status:** `unsafe` blocks are parsed by the compiler today. Full runtime enforcement of `![unsafe]` propagation — preventing calls to unsafe functions from safe contexts — is **planned for 1.0**. Write code to the specification now; enforcement will be activated as part of the 1.0 compiler hardening work.

The design goal is that `![unsafe]` in a call graph visibly marks every function that directly or indirectly performs unsafe operations. Auditors can grep for `![unsafe]` to find the full unsafe surface of a codebase.

### Operations restricted to `unsafe` blocks

| Operation | Syntax |
|---|---|
| Pointer dereference (read) | `*ptr` |
| Pointer dereference (write) | `*ptr = value` |
| Pointer arithmetic | `ptr + n`, `ptr - n` |
| Pointer casting | `ptr as *OtherType` |
| Calling unsafe extern functions | `malloc(n)`, `free(p)`, etc. |
| Taking a raw pointer from a value | `&raw value` |

## `unsafe extern fn` Declarations

External C functions are declared using `unsafe extern fn`. This tells the compiler:

- The function is defined in a foreign (C) library
- It follows the C ABI calling convention
- Calling it requires an active `![unsafe]` capability

```sfn
unsafe extern fn malloc(size -> usize) -> *u8;
unsafe extern fn free(ptr -> *u8) -> void;
unsafe extern fn memcpy(dest -> *u8, src -> *u8, n -> usize) -> *u8;
unsafe extern fn memset(dest -> *u8, val -> i32, n -> usize) -> *u8;
unsafe extern fn strlen(s -> *u8) -> usize;
```

Note the parameter syntax: `name -> Type` (with `->`) is the convention for struct fields and extern function parameters in Sailfin, matching the rest of the language's named-parameter style.

Key properties of `unsafe extern fn` declarations:

- **C ABI by default.** Parameters are passed using the platform C calling convention.
- **Cannot be called outside an `unsafe` block.** The compiler will enforce this once unsafe enforcement is fully active (planned for 1.0).
- **Raw pointer types are permitted.** The `*T`, `*mut T`, and `*opaque` types are only valid in extern declarations and unsafe blocks.
- **Must be linked.** The native library providing these functions must be linked into the final binary. Use `[build]` or linker flags to specify the library.
- **No safety guarantees.** The compiler trusts extern declarations. An incorrect declaration — wrong parameter types, wrong return type — is undefined behavior.

## Raw Pointer Types

Sailfin provides three raw pointer types for use in FFI:

| Type | C equivalent | Description |
|---|---|---|
| `*T` | `const T*` | Read-only raw pointer to type `T`. Dereferencing reads the value; writing is not permitted. |
| `*mut T` | `T*` | Mutable raw pointer to type `T`. Both read and write are permitted through dereference. |
| `*opaque` | `void*` | Opaque pointer to foreign-managed memory. Used when the pointed-to type is unknown or irrelevant. |

Raw pointers differ fundamentally from Sailfin references (`&T`, `&mut T`):

- **No lifetime tracking.** The compiler does not know when the pointed-to memory is valid.
- **No null safety.** A raw pointer may be null. You must check explicitly before dereferencing.
- **No borrow checking.** Multiple `*mut T` pointers to the same memory are permitted (though aliasing mutable pointers is a common source of bugs).
- **May be cast.** A `*T` may be cast to `*mut T`, `*opaque`, or `*OtherType` inside an unsafe block.
- **Arithmetic permitted.** Pointer arithmetic is allowed inside unsafe blocks.

Raw pointers do not appear in safe Sailfin code. They are only valid in `unsafe` blocks and in `unsafe extern fn` declarations.

## The `![unsafe]` Capability

`unsafe` is a capability effect, treated by the effect system the same way `io` or `net` are. This means:

1. Any function containing an `unsafe` block must declare `![unsafe]`.
2. Any function calling an `![unsafe]` function must itself declare `![unsafe]` (unless the callee's unsafe behavior is fully encapsulated behind a safe return type).
3. The capsule's `capsule.toml` must list `"unsafe"` in its `[capabilities] required` array.

```sfn
// Both callee and caller must declare ![unsafe]
fn read_word(ptr: *u32) ![unsafe] -> u32 {
    unsafe {
        return *ptr;
    }
}

fn inspect_memory(base: *u32, offset: usize) ![unsafe] -> u32 {
    let target_ptr = base + offset;  // pointer arithmetic — must be in unsafe block
    unsafe {
        return *target_ptr;
    }
}
```

The capsule manifest:

```toml
[capabilities]
required = ["unsafe"]
```

If `"unsafe"` is absent from the manifest, the compiler will reject capsule builds containing unsafe code once enforcement is active.

## Type Mappings: Sailfin, C, and LLVM

When writing extern declarations, use the Sailfin types that correspond to the C types in the library's header. Mismatched types cause undefined behavior.

| Sailfin | C | LLVM |
|---|---|---|
| `i8` | `int8_t` / `char` | `i8` |
| `i16` | `int16_t` | `i16` |
| `i32` | `int32_t` | `i32` |
| `i64` | `int64_t` | `i64` |
| `u8` | `uint8_t` | `i8` |
| `u16` | `uint16_t` | `i16` |
| `u32` | `uint32_t` | `i32` |
| `u64` | `uint64_t` | `i64` |
| `usize` | `size_t` | `i64` (platform-dependent) |
| `isize` | `ssize_t` | `i64` (platform-dependent) |
| `f32` | `float` | `float` |
| `f64` | `double` | `double` |
| `bool` | `_Bool` / `bool` | `i1` |
| `*T` | `const T*` | `T*` |
| `*mut T` | `T*` | `T*` |
| `*opaque` | `void*` | `i8*` |

**Important:** `usize` and `isize` are pointer-sized integers. On 64-bit platforms they are 64 bits; on 32-bit platforms they are 32 bits. The LLVM column above assumes a 64-bit target. Always use `usize` for sizes and counts that may be passed to C functions expecting `size_t`.

## `@repr(C)` Structs

When passing structs across FFI boundaries, Sailfin's default struct layout may not match C's. The `@repr(C)` decorator instructs the compiler to lay out the struct fields in declaration order, with C-compatible alignment and padding:

```sfn
@repr(C)
struct Point {
    x -> f64;
    y -> f64;
}

@repr(C)
struct Rectangle {
    top_left -> Point;
    bottom_right -> Point;
}

unsafe extern fn distance(p1 -> *Point, p2 -> *Point) -> f64;
unsafe extern fn rect_area(r -> *Rectangle) -> f64;
```

Without `@repr(C)`, the compiler may reorder or pack fields for Sailfin-native efficiency, which would produce an incorrect memory layout when the struct is passed to a C function.

**When to use `@repr(C)`:**

- Any struct passed to or returned from an `unsafe extern fn`
- Any struct whose in-memory layout must match a C header definition
- Any struct written to or read from a raw memory buffer shared with C code

Sailfin-internal structs that never cross the FFI boundary do not need `@repr(C)`.

## Pointer Arithmetic and Casting

Inside `unsafe` blocks, pointer arithmetic follows C semantics. Offsets are in units of the pointed-to type's size (not bytes), matching how C pointer arithmetic works.

```sfn
fn pointer_example() ![unsafe] -> void {
    unsafe {
        // Allocate 10 i32 values (40 bytes on a 32-bit i32)
        let arr = malloc(10 * 4) as *i32;  // Cast *u8 to *i32

        for i in 0..10 {
            let element_ptr = arr + i;  // Advance by i elements (i * sizeof(i32) bytes)
            *element_ptr = i * i;       // Write through pointer
        }

        let third = *(arr + 2);  // Read the third element (index 2)
        print(third);            // prints 4

        free(arr as *u8);  // Cast back to *u8 for free()
    }
}
```

Supported pointer operations inside `unsafe` blocks:

| Operation | Description |
|---|---|
| `ptr + n` | Advance pointer by `n` elements (scaled by `sizeof(T)`) |
| `ptr - n` | Retreat pointer by `n` elements |
| `ptr as *OtherType` | Reinterpret pointer as a different type |
| `ptr == null` | Null check |
| `ptr != null` | Non-null check |
| `&raw value` | Obtain a raw pointer to a stack or heap value |

## Safe Wrapper Pattern

The recommended practice for FFI is to keep `unsafe` contained within a small, well-tested module, and expose a completely safe public API to the rest of the codebase. This is the safe wrapper pattern.

The pattern:

1. Declare the `unsafe extern fn` bindings privately (not exported).
2. Write thin safe wrapper functions that handle all invariants: null checks, size validation, cleanup.
3. Export only the safe wrappers.
4. Use `Linear<T>` for resources that must be freed, so the type system enforces cleanup.

Here is the `ManagedBuffer` example from the specification:

```sfn
// Unsafe internals — not exported
unsafe extern fn malloc(size -> usize) -> *u8;
unsafe extern fn free(ptr -> *u8) -> void;
unsafe extern fn memset(dest -> *u8, val -> i32, n -> usize) -> *u8;

// Internal struct — not exported
struct ManagedBuffer {
    ptr -> *u8;
    capacity -> usize;
    length -> usize;
}

// Error type for unsafe operations
enum UnsafeResult<T> {
    Ok { value -> T },
    Err { code -> i32, message -> String },
}

// Safe allocation: wraps malloc, zero-initializes, returns Linear for cleanup enforcement
export fn allocate_buffer(size: usize) ![unsafe] -> UnsafeResult<Linear<ManagedBuffer>> {
    unsafe {
        let ptr = malloc(size);
        if ptr == null {
            return UnsafeResult.Err { code: -1, message: "allocation failed" };
        }
        memset(ptr, 0, size);
        return UnsafeResult.Ok {
            value: Linear(ManagedBuffer { ptr: ptr, capacity: size, length: 0 })
        };
    }
}

// Safe deallocation: consumes the Linear wrapper, preventing double-free
export fn free_buffer(buffer: Linear<ManagedBuffer>) ![unsafe] -> void {
    unsafe {
        let inner = consume(buffer);
        if inner.ptr != null {
            free(inner.ptr);
        }
    }
}
```

The `Linear<ManagedBuffer>` return type is the key safety mechanism. A `Linear<T>` value must be consumed exactly once — it cannot be dropped silently. This means:

- The caller cannot forget to call `free_buffer`. The compiler will reject the program if the buffer escapes its scope without being consumed.
- The caller cannot call `free_buffer` twice on the same buffer. `Linear<T>` is consumed on first use.

**Note:** `Linear<T>` enforcement is parsed but not yet enforced in the current compiler. The native compiler will enforce linear type consumption.

## Error Handling Across FFI

C functions do not have exceptions or Sailfin's type-safe results. They signal errors through:

- Return codes (`-1` for failure, non-negative for success)
- Global `errno` (POSIX)
- Out-parameters

The pattern is to translate these C conventions into Sailfin's type-safe `enum` results inside the wrapper:

```sfn
// Enum mirroring POSIX result conventions
enum PosixResult<T> {
    Ok { value -> T },
    Err { errno -> i32 },
}

// Extern declarations for POSIX open and errno
unsafe extern fn c_open(path -> *u8, flags -> i32) -> i32;
unsafe extern fn c_errno() -> i32;

// Safe wrapper: hides the unsafe internals, returns a typed result
fn open_file(path: String, flags: i32) ![unsafe, io] -> PosixResult<i32> {
    unsafe {
        let fd = c_open(path.as_c_str(), flags);
        if fd < 0 {
            return PosixResult.Err { errno: c_errno() };
        }
        return PosixResult.Ok { value: fd };
    }
}
```

After the wrapper, callers use idiomatic Sailfin pattern matching:

```sfn
fn read_config(path: String) ![unsafe, io] {
    match open_file(path, 0) {
        PosixResult.Ok { value: fd } => {
            // use fd
        },
        PosixResult.Err { errno } => {
            print.err("Failed to open file, errno: " + errno);
        },
    }
}
```

This keeps the `errno`-handling logic in one place, inside the wrapper. The rest of the codebase sees a clean `PosixResult<i32>`.

## Capability Manifest for Unsafe

Any capsule using `unsafe` must declare it in `capsule.toml`:

```toml
[capsule]
name = "native-bindings"
version = "0.1.0"
description = "Low-level native library bindings"

[capabilities]
required = ["io", "unsafe"]
```

If the capsule is part of a workspace, the workspace can restrict which capsules are permitted to declare `unsafe`:

```toml
# workspace.toml
[policies.unsafe]
allowed_capsules = ["native-bindings"]
require_annotation = "@security-reviewed"
```

With `require_annotation = "@security-reviewed"`, every function containing an `unsafe` block must carry the `@security-reviewed` decorator:

```sfn
@security-reviewed
fn allocate_buffer(size: usize) ![unsafe] -> *u8 {
    unsafe {
        return malloc(size);
    }
}
```

This creates an enforceable audit trail: every unsafe function in the codebase must have been explicitly reviewed and annotated. Missing the annotation is a build-time policy violation.

## When to Use FFI

FFI is powerful but carries real risk. Use it when:

- **A C library provides unique functionality** not available in the Sailfin standard library or registry (hardware drivers, OS-specific APIs, mature C libraries like `libsodium`, `libjpeg`, `sqlite`).
- **A performance-critical hot path** requires SIMD intrinsics, custom allocators, or zero-copy I/O that cannot be expressed efficiently in safe Sailfin.
- **Embedding in a C/C++ host** that calls into Sailfin code.

Do **not** use FFI when:

- A safe Sailfin implementation is available in the standard library or a registry capsule. Prefer the safe version even if it is slightly slower.
- The motivation is avoiding the effect system. Effect annotations are a feature, not a burden — they make your code's behavior explicit and auditable.
- You are early in development. Start with safe Sailfin; reach for FFI only when a concrete, measured need exists.

Always wrap unsafe internals behind a safe public API. The goal is to make `unsafe` a quarantined implementation detail, invisible to callers.

## Example Reference

The `examples/advanced/` directory in the Sailfin repository contains runnable examples:

- `examples/advanced/unsafe-extern-interop.sfn` — External function declarations and unsafe blocks
- `examples/advanced/pointer-arithmetic.sfn` — Pointer arithmetic with `malloc`/`free`
- `examples/advanced/raw-pointers.sfn` — Raw pointer creation with `&raw` and dereference

These examples require `![unsafe]` and the `"unsafe"` capability in their capsule manifest.

## Summary

| Concept | Quick reference |
|---|---|
| Declare a C function | `unsafe extern fn name(param -> Type) -> ReturnType;` |
| Unsafe block | `unsafe { ... }` — required for all pointer operations and extern calls |
| Required effect | `![unsafe]` on any function with an unsafe block |
| Read-only pointer | `*T` |
| Mutable pointer | `*mut T` |
| Opaque pointer | `*opaque` |
| C-layout struct | `@repr(C) struct Foo { field -> Type; }` |
| Pointer advance | `ptr + n` (scaled by element size) |
| Null check | `ptr == null` |
| Raw address of value | `&raw value` |
| Capsule manifest | `[capabilities] required = ["unsafe"]` |
| Workspace policy | `[policies.unsafe] allowed_capsules = [...]` |
| Status | Syntax parsed; enforcement planned in native compiler |
