---
title: Unsafe & FFI
description: Foreign function interface, extern declarations, raw pointers, and C interoperability.
section: advanced
sidebar:
  order: 4
---

When you need to call a C library, reach an OS API, or work with raw memory,
you leave the region Sailfin's analysis covers. That boundary is an `extern fn`
declaration and a raw pointer.

This page is the practical guide. The normative rules are
[§13 Foreign Interface](/docs/reference/spec/13-foreign-interface/), and the
interop contract still being built is
[SFEP-0079](/sfep/0079-systems-c-interop/).

:::caution[Read this before porting C]
The interop surface that ships today is narrower than this page once claimed.
Four constructs documented here previously do **not** work, and are marked
inline below wherever they appear:

- **`@repr(C)`** parses and is silently ignored. So does any other unrecognized
  decorator. Struct layout is not a contract.
- **`![unsafe]`** is not an effect. A function declaring it is rejected with
  `E0404`. `[capabilities] required = ["unsafe"]` and `[policies.unsafe]` are
  **withdrawn** (SFEP-0079 §3.5).
- **`&raw value`** does not typecheck (`E0818`).
- **`*T` is not read-only.** Writes through `*T`, `*const T`, and `*mut T` are
  all accepted and all lower to a store.

Also: **`*opaque` is rejected** with `E0805` — write `*void`. And the extern
spelling of the boolean is **`bool`**, not `boolean`.
:::

**Current status.** `extern fn` declarations, their C-ABI validation
(`E0801`–`E0805`), native lowering, raw-pointer load/store/member/arithmetic,
and function addresses via `name as *u8` (guarded by `E0808`/`E0809`) all ship.
`unsafe { }` is meaningful to the ownership checker (`E0906`) and to nothing
else. Layout guarantees, pointer mutability enforcement, variadic externs,
typed callback parameters, and effect-attested externs are designed in
SFEP-0079 and are not shipped.

## Overview

FFI enables:

- **Calling C libraries** — libc, system libraries, third-party native libraries
- **OS API access** — file descriptors, sockets, signals, platform-specific calls
- **Performance-critical code** — SIMD intrinsics, hardware interfaces, custom allocators
- **Embedding in C/C++ programs** — exposing Sailfin functions to a C host

The trade-off is real: across an extern boundary the compiler verifies neither
memory safety, nor null safety, nor that your declaration matches the C header.
Keep the foreign surface small and wrap it.

## `extern fn` Declarations

External functions are declared with `extern fn`. The declaration is a
signature with no body, resolved at link time.

```sfn
extern fn malloc(size: usize) -> *u8;
extern fn free(ptr: *u8) -> void;
extern fn memcpy(dest: *u8, src: *u8, n: usize) -> *u8;
extern fn memset(dest: *u8, val: i32, n: usize) -> *u8;
extern fn strlen(s: *u8) -> usize;
```

`unsafe extern fn` is also accepted, and means the same thing. The `unsafe`
keyword on an extern is consumed by the parser and read back by nothing, so the
two spellings typecheck and lower identically. Prefer plain `extern fn`; use
`unsafe extern fn` only if you want the visual marker.

Key properties:

- **C ABI by default.** Parameters use the platform C calling convention.
  Narrow integers are passed without explicit `signext`/`zeroext` attributes,
  which is a known gap in calling-convention fidelity (SFEP-0079 §3.3).
- **No effects on the declaration.** `extern fn f() -> i32 ![io]` is rejected
  with `E0804`. Declare the effect on the Sailfin wrapper that calls it.
  Extern calls are invisible to the effect checker, so a wrapper's effect
  clause is an author's claim about the foreign function, not a derived fact.
- **Ownership boundary.** Passing a bare owned value to an extern declared in
  the same compilation unit, outside an `unsafe` block, raises `E0906`.
- **Must be linked.** The library providing the symbol has to reach the final
  link. A link input is a build input, not provenance: it says what the linker
  resolves against, and records nothing about what that library does.
- **No safety guarantees.** The compiler trusts the declaration. A wrong
  parameter or return type is undefined behavior.

### Extern type table

These are the types an extern signature admits today.

| Sailfin | C | LLVM | Notes |
|---|---|---|---|
| `i8` | `int8_t` / `char` | `i8` | |
| `i16` | `int16_t` | `i16` | |
| `i32` | `int32_t` | `i32` | |
| `i64` | `int64_t` | `i64` | |
| `u8` | `uint8_t` | `i8` | |
| `u16` | `uint16_t` | `i16` | |
| `u32` | `uint32_t` | `i32` | |
| `u64` | `uint64_t` | `i64` | |
| `usize` | `size_t` | `i64` on a 64-bit target | pointer-sized |
| `isize` | `ssize_t` | `i64` on a 64-bit target | pointer-sized |
| `f32` | `float` | `float` | |
| `f64` | `double` | `double` | |
| `f16` | `_Float16` | `half` | accepted; no dedicated ABI handling |
| `bf16` | `__bf16` | `bfloat` | accepted; no dedicated ABI handling |
| `bool` | `_Bool` | `i1` | **`boolean` is rejected** (`E0805`) — externs spell it `bool` |
| `int` | `int64_t` | `i64` | Sailfin's default integer |
| `float` | `double` | `double` | Sailfin's default float |
| `void` | `void` | `void` | **return position only**; a `void` parameter is `E0805` |
| `*T` | `T*` | `T*` | pointee must itself be admissible |
| `*void` | `void*` | `i8*` | the untyped pointer — **`*opaque` is rejected** |
| `*Handle` | `struct Handle*` | `i8*` | an UpperCamelCase pointee is taken as an opaque handle |

`*const T` and `*mut T` are also accepted — the checker strips the prefix and
checks the pointee — but neither prefix means anything yet. See
[Raw pointers](#raw-pointer-types).

`usize` and `isize` are pointer-sized: 64 bits on a 64-bit target, 32 on a
32-bit one. The LLVM column assumes a 64-bit target. Use `usize` for any
size or count crossing to a C `size_t`.

**Typed function-pointer parameters do not work in practice.** The checker
accepts the tight spelling `fn(A) -> B`, but `sfn fmt` rewrites it to
`fn (A) -> B`, which the same checker then rejects with `E0805`. A formatted
file cannot carry one. Pass callbacks as raw addresses instead — see
[Callbacks into Sailfin](#callbacks-into-sailfin). Typed callback parameters
are designed in SFEP-0079 §3.4 and not shipped.

### Declaration diagnostics

| Code | Raised when |
|---|---|
| `E0801` | The type is, or contains, the Sailfin `string` aggregate |
| `E0802` | The type contains `[]` — arrays carry runtime metadata that does not cross the boundary |
| `E0803` | The extern declares type parameters (`<...>`) |
| `E0804` | The extern declares effects (`![...]`) |
| `E0805` | Any other inadmissible or missing type |

Sailfin `string` needs an explicit conversion. A string *literal* is
NUL-terminated, so `literal as *u8` may be passed to a C `const char*`
directly; anything else must be copied into a NUL-terminated buffer first,
because slices are not NUL-terminated.

## `unsafe` Blocks

An `unsafe { ... }` block is a lexical region whose contents are
author-asserted for the ownership checker. That is its entire shipped meaning.

```sfn
extern fn malloc(size: usize) -> *u8;

fn allocate_buffer(bytes: usize) -> *u8 {
    unsafe {
        return malloc(bytes);
    }
}
```

**No pointer operation requires an `unsafe` block.** Dereference, stores,
member access, arithmetic, and casts all compile outside one — the runtime
itself does raw-pointer work outside `unsafe` throughout. A rule requiring
`unsafe` for them would be a restriction without a matching power, and
SFEP-0079 §3.2 explicitly declines to add one.

What the block *does* buy you: passing a bare owned value to an extern declared
in the same compilation unit outside a block raises `E0906`, and inside one it
does not.

:::danger[`![unsafe]` is not an effect]
`![unsafe]` was never implemented, and is now withdrawn. The canonical effects
are `clock`, `gpu`, `io`, `model`, `net`, and `rand`; anything else is rejected
with `E0404`:

```
error[E0404]: function `f` declares unrecognized effect ![unsafe]
```

`[capabilities] required = ["unsafe"]` and the `[policies.unsafe]` workspace
policy go with it (SFEP-0079 §3.5). As designed, the effect marked every caller
in a chain and proved nothing about any of them. A *derived* record of a
program's foreign edges replaces its audit purpose; that record is designed in
SFEP-0079 §3.5 and not shipped.
:::

## Raw Pointer Types

| Type | C equivalent | Description |
|---|---|---|
| `*T` | `T*` | Raw pointer to `T`. Reads and writes are both permitted. |
| `*const T` | `const T*` | Accepted spelling. **Not enforced** — writes through it compile. |
| `*mut T` | `T*` | Accepted spelling, identical to `*T`. |
| `*void` | `void*` | Untyped pointer. Use this where C uses `void*`. |
| `*Handle` | `struct Handle*` | Opaque foreign handle, by UpperCamelCase convention. |

:::caution[Mutability is not enforced]
`*T`, `*const T`, and `*mut T` all produce the same pointer type and permit the
same operations. A `*const T` that rejects stores with `E0852` is designed in
SFEP-0079 §3.2 and not shipped. Until it lands, `*const T` documents intent to
a human reader and nothing more.

`*opaque` is not a type. It is rejected with `E0805`, because the opaque-pointee
rule requires an uppercase initial. Write `*void`.
:::

Raw pointers differ fundamentally from Sailfin references (`&T`, `&mut T`):

- **No lifetime tracking.** The compiler does not know when the pointed-to
  memory is valid.
- **No null safety.** A raw pointer may be null; check before dereferencing.
- **No borrow checking.** Multiple pointers to the same memory are permitted.
- **Freely cast.** `p as *U` reinterprets with no check.

### Retention

A pointer into Sailfin-managed storage is valid **only for the duration of the
foreign call it is passed to**. Sailfin storage may be arena-backed and
reclaimed at a phase boundary, so a pointer the foreign side keeps can dangle.
Anything C retains — a `user_data` payload, an `epoll` data pointer — must live
in memory C owns, typically a `malloc` allocation.

This rule is **documented, not enforced.** Nothing rejects handing arena
storage to a retaining parameter.

## Pointer Operations

All of these work today, inside an `unsafe` block or outside one.

```sfn
extern fn malloc(size: usize) -> *u8;
extern fn free(ptr: *u8) -> void;

fn pointer_example() ![io] {
    let arr = malloc(40) as *i32;   // cast *u8 to *i32

    for i in 0..10 {
        let element_ptr = arr + i;  // advance by i elements
        *element_ptr = i * i;       // store through the pointer
    }

    let third = *(arr + 2);         // load the third element
    print("${ third }");            // prints 4

    free(arr as *u8);
}
```

| Operation | Description |
|---|---|
| `*p` | Load a `T`. Dereferencing a non-pointer reports `E1006`. |
| `*p = v` | Store a `T`. |
| `p.f` | Load or store field `f` of a struct through the pointer, auto-dereferencing. |
| `p + n`, `p - n` | Advance or retreat by `n` elements, scaled by the pointee's size. On `*u8` the step is one byte. |
| `p as *U` | Reinterpret as a different pointer type. |
| `p as i64`, `n as *T` | Convert between an address and an integer. |
| `s as *S` | Address of a struct binding's storage. |
| `s as *u8` | A string's data pointer — NUL-terminated only for literals. |
| `p == null`, `p != null` | Null tests. `0 as *T` is also the null pointer. |

:::note[`&raw` does not exist]
`&raw value` is documented in older material and in
`examples/advanced/raw-pointers.sfn`, where it is kept in comments as a design
sketch. It does not typecheck:

```
error[E0818]: unstructured expression cannot be analyzed; rewrite so the compiler can parse it
```

Use `s as *S` for a struct's address, and a `malloc`'d slot for a scalar.
:::

## Struct Layout

:::caution[`@repr(C)` is not implemented]
`@repr(C)` parses into the struct's decorator list and is never read. So does
`@anything_else(C)` — there is no decorator validation at all, so a typo is
silent.

Structs lower to LLVM identified types in field declaration order, which
coincides with the C ABI for scalar fields on the supported targets. That is an
accident of LLVM's default layout, not a guarantee, and it is not something to
build a port on: it can change, and the `.sfn-asm` layout table already
disagrees with it for narrow types.

A validated layout contract — `@repr(C)` with field checking, `packed`,
compile-time `size`/`align` assertions, and `size_of` / `align_of` /
`offset_of` — is designed in SFEP-0079 §3.1 and not shipped. Inline fixed-size
array fields (`[T; N]`) are rejected today with `E0830` and are designed in
SFEP-0079 §3.6.
:::

Until that lands, a struct shared with C is a hazard. The workable pattern is
to keep the foreign-facing shape as explicit scalar fields in declaration
order, verify the offsets against the C header on each target you ship, and
prefer passing scalars over passing structs.

## Callbacks into Sailfin

C calls back into Sailfin through a raw function address. Cast the function's
name:

```sfn
extern fn pthread_create(thread: *u8, attr: *u8, start: *u8, arg: *u8) -> i32;

fn worker(arg: *u8) -> *u8 {
    return arg;
}

fn spawn(thread: *u8, arg: *u8) -> i32 {
    return pthread_create(thread, 0 as *u8, worker as *u8, arg);
}
```

`worker as *u8` lowers to the function's code pointer, not a closure pair, so C
can call it directly. Two diagnostics guard the form:

- `E0808` — a function name used as a value without the cast, or cast to
  something other than `* u8` or a function-pointer type.
- `E0809` — the named function is generic; only a concrete function has one
  address.

This is the shipped path, and the runtime scheduler depends on it. Two caveats:
a Sailfin `throw` unwinding across a C frame is undefined, and there is no way
to define a symbol C can call *by name* — defined functions are module-mangled.
C-ABI definitions are designed in SFEP-0079 §3.4 and not shipped.

## Safe Wrapper Pattern

Keep the foreign surface in a small module and export only safe wrappers.

1. Declare the `extern fn` bindings privately.
2. Write wrappers that handle the invariants: null checks, size validation,
   NUL-termination, cleanup.
3. Export only the wrappers, carrying the effect clause the foreign call
   deserves.
4. Take a resource that must be released as `Linear<T>`, so the ownership
   checker enforces the release.

```sfn
// Foreign internals — not exported
extern fn malloc(size: usize) -> *u8;
extern fn memset(dest: *u8, val: i32, n: usize) -> *u8;

struct ManagedBuffer {
    ptr: *u8;
    capacity: usize;
}

// Zero-initialized allocation. A null return means the allocation failed.
export fn allocate_buffer(size: usize) -> *u8 {
    let ptr = malloc(size);
    if ptr == null {
        return ptr;
    }
    memset(ptr, 0, size);
    return ptr;
}

// Taking the buffer as `Linear<ManagedBuffer>` makes releasing it mandatory:
// a linear value must be consumed exactly once. `free(v)` is one of the
// consumption forms the ownership checker recognizes — it is that rule, not a
// call to libc `free`.
export fn release_buffer(buffer: Linear<ManagedBuffer>) -> i32 {
    free(buffer);
    return 0;
}

// Forwarding a linear value to another function that takes it also consumes it.
export fn release_all(buffer: Linear<ManagedBuffer>) -> i32 {
    return release_buffer(buffer);
}
```

Drop the `free(buffer)` and the compiler rejects the function:

```
error[E0907]: linear value `buffer` is never consumed at 2:20
```

> **What `Linear<T>` does and does not do today.** The ownership checker
> recognizes `Linear<T>` and `Affine<T>` on a binding or parameter and enforces
> single use: use-after-move and a second binding raise `E0901`/`E0904`, and a
> linear value still live at scope exit raises `E0907`. A linear value is
> consumed by returning it, by passing it to a function that takes it, or by
> `free(v)`.
>
> There is **no `Linear<T>` constructor and no `consume()` function.** A
> `Linear<T>` arrives as a parameter; you cannot wrap a value in one from
> source. Shared-borrow and view-lifetime checking are in progress.

## Error Handling Across FFI

C signals errors through return codes, a global `errno`, and out-parameters.
Translate them inside the wrapper:

```sfn
struct PosixError {
    errno: i32;
}

extern fn c_open(path: *u8, flags: i32) -> i32;
extern fn c_errno() -> i32;

// The effect clause is the wrapper's claim about the foreign call; the
// compiler derives nothing from the extern itself.
fn open_file(path: *u8, flags: i32) -> i32 | PosixError ![io] {
    let fd = c_open(path, flags);
    if fd < 0 {
        return PosixError { errno: c_errno() };
    }
    return fd;
}
```

Callers then use ordinary Sailfin pattern matching. A wrapper can also return
the shipped `Result<T, E>` and let callers propagate with postfix `?`; an
explicit union stays valid where it models the native outcomes better.

```sfn
fn read_config(path: *u8) ![io] {
    let result = open_file(path, 0);
    match result {
        PosixError { errno } => print.err("Failed to open file, errno: ${ errno }"),
        _ => { /* `result` is the file descriptor */ },
    }
}
```

## When to Use FFI

Use FFI when:

- **A C library provides unique functionality** not available in the standard
  library or registry — hardware drivers, OS-specific APIs, mature C libraries.
- **A measured hot path** needs SIMD intrinsics, a custom allocator, or
  zero-copy I/O that safe Sailfin cannot express.
- **You are embedding in a C/C++ host** that calls into Sailfin.

Do **not** use FFI when:

- A safe Sailfin implementation exists. Prefer it even if it is slower.
- The motivation is avoiding the effect system. An extern does not remove the
  capability — it removes the compiler's record of it.
- You are early in development and the need is not yet concrete.

Given that layout and pointer mutability are not yet contracts, weigh a port
that depends on either of them against waiting for the SFEP-0079 leaves that
specify them.

## Example Reference

The `examples/advanced/` directory contains:

- `examples/advanced/unsafe-extern-interop.sfn` — extern declarations and
  `unsafe` blocks
- `examples/advanced/pointer-arithmetic.sfn` — pointer arithmetic with
  `malloc`/`free`
- `examples/advanced/raw-pointers.sfn` — a design sketch: the `&raw` form is
  kept in comments, and the runnable body uses shipped grammar

None of them needs an `![unsafe]` effect or an `"unsafe"` capability, because
neither exists.

## Summary

| Concept | Quick reference |
|---|---|
| Declare a C function | `extern fn name(param: Type) -> ReturnType;` |
| `unsafe` keyword on an extern | Accepted, inert — same meaning as plain `extern fn` |
| `unsafe` block | Author-asserted region for the ownership checker (`E0906`). Not required for any pointer operation |
| Effects | On the calling wrapper, never on the extern (`E0804`) |
| Pointer | `*T` — reads **and writes** |
| `*const T` / `*mut T` | Accepted spellings, no enforcement |
| Untyped pointer | `*void` (**not** `*opaque`) |
| Boolean across the boundary | `bool` (**not** `boolean`) |
| Pointer advance | `ptr + n`, scaled by element size |
| Null check | `ptr == null` |
| Address of a struct | `s as *S` |
| Function address for C | `name as *u8` (`E0808`/`E0809`) |
| Layout control | None. `@repr(C)` is ignored — designed in SFEP-0079 §3.1 |
| Raw address operator | None. `&raw` fails `E0818` |
| Unsafe effect / capability / policy | Withdrawn (SFEP-0079 §3.5) |
| Normative reference | [§13 Foreign Interface](/docs/reference/spec/13-foreign-interface/) |
