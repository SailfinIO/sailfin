---
title: "§13 Foreign Interface"
description: "Sailfin language specification — extern declarations, the C-ABI accept-list, raw pointer operations, and function addresses."
sidebar:
  order: 13
  label: "§13 Foreign Interface"
---

Sailfin reaches foreign code through `extern fn` declarations and raw pointers.
This chapter is normative for the surface that **ships today**. The broader
interop contract — guaranteed `@repr(C)` layout, a read-only `*const T`,
variadic externs, typed callback parameters, and effect-attested externs — is
designed in [SFEP-0079](/sfep/0079-systems-c-interop/) and is called out as
**designed, not shipped** wherever it appears below.

For the practical guide, see [Unsafe & FFI](/docs/advanced/ffi/).

## 13.1 Extern declarations

An extern declaration names a symbol resolved at link time:

```sfn
extern fn malloc(size: usize) -> *u8;
extern fn free(ptr: *u8) -> void;
extern fn strlen(s: *u8) -> usize;
```

The declaration is a signature only; it has no body. Parameters use the
ordinary `name: Type` form and the return type follows `->`.

`unsafe extern fn` is also accepted. The `unsafe` keyword on an extern is a
parsed marker: it is consumed by the parser and no analysis pass reads it back,
so `extern fn` and `unsafe extern fn` typecheck and lower identically. `unsafe`
is **not** an effect — see §13.5.

An extern declaring effects is rejected with `E0804`; effects belong on the
Sailfin wrapper that calls the extern, not on the extern itself.

## 13.2 The C-ABI accept-list

A type is admissible in extern parameter or return position when it is one of:

**Primitives**

| Sailfin | C | Notes |
|---|---|---|
| `i8`, `i16`, `i32`, `i64` | `int8_t` … `int64_t` | |
| `u8`, `u16`, `u32`, `u64` | `uint8_t` … `uint64_t` | |
| `usize`, `isize` | `size_t`, `ssize_t` | pointer-sized |
| `f32`, `f64` | `float`, `double` | |
| `f16`, `bf16` | `_Float16`, `__bf16` | accepted by the checker; no dedicated ABI handling |
| `bool` | `_Bool` | the extern spelling is `bool`, **not** `boolean` |
| `int` | `int64_t` | Sailfin's default integer, lowers to `i64` |
| `float` | `double` | Sailfin's default float |
| `void` | `void` | **return position only** — bare `void` as a parameter is `E0805` |

**Pointers.** `*T` where `T` is itself admissible, `void`, or an
UpperCamelCase identifier treated as an opaque foreign handle (`*File`,
`*PthreadMutex`). `**T` follows by recursion. `*void` is the untyped byte
pointer (C's `void*`); `*u8` is the conventional spelling for byte buffers and
C strings.

`*const T` and `*mut T` are accepted: the checker strips the `const ` or `mut `
prefix and applies the same rule to the pointee. Neither prefix carries meaning
today — see §13.3.

> **Not admissible:** `*opaque` is rejected with `E0805`. The opaque-pointee
> rule requires an uppercase initial, so the lowercase `opaque` matches nothing.
> Write `*void`.

**Function pointers.** `fn(A, B) -> C` is accepted, but only in the tight
spelling with no space before `(`. `sfn fmt` normalizes that to `fn (A, B) -> C`,
which the checker then rejects with `E0805`, so a formatted source file cannot
carry a typed function-pointer extern parameter. Typed callback parameters are
**designed, not shipped** (SFEP-0079 §3.4, leaf L5). Pass a callback as a raw
address instead — §13.4.

### Declaration diagnostics

| Code | Raised when |
|---|---|
| `E0801` | The type is, or contains, the Sailfin `string` aggregate. Use `*u8` plus a NUL-terminated copy. |
| `E0802` | The type contains `[]`. Sailfin arrays carry runtime metadata; use `*T` plus a length parameter. |
| `E0803` | The extern declares type parameters (`<...>`). Only concrete C-ABI types cross the boundary. |
| `E0804` | The extern declares effects (`![...]`). Move the clause onto the calling wrapper. |
| `E0805` | Any other inadmissible or missing type, including a missing parameter annotation and bare `void` in parameter position. |

## 13.3 Raw pointer operations

The following operate on any raw pointer and are specified here as shipped
behavior. None of them requires an `unsafe` block.

- **Load.** `*p` reads a `T`. Dereferencing a non-pointer is reported as
  `E1006`.
- **Store.** `*p = v` writes a `T`.
- **Member access.** `p.f`, where `p: *S` and `S` is a struct, loads or stores
  field `f` at its offset, auto-dereferencing.
- **Arithmetic.** `p + n` and `p - n` advance and retreat by `n` elements,
  scaled by the pointee's size, matching C. On `*u8` the step is one byte.
- **Casts.** `p as *U` reinterprets. `p as i64` and `n as *T` convert between
  an address and an integer. `0 as *T` and `null` are the null pointer, and
  `p == null` / `p != null` are the null tests.
- **Address of a struct binding.** `s as *S` yields the address of that
  struct's storage.
- **String data pointer.** `s as *u8` yields a string's data pointer. It is
  NUL-terminated **only for string literals**; any other string handed to a C
  `const char*` must first be copied with an explicit NUL, because slices are
  not NUL-terminated.

**Mutability is not enforced.** `*T`, `*const T`, and `*mut T` produce the same
pointer type and permit the same reads and writes. A read-only `*const T`, with
stores through it rejected as `E0852`, is **designed, not shipped**
(SFEP-0079 §3.2, leaf L3).

**Retention.** A pointer into Sailfin-managed storage is valid only for the
duration of the foreign call it is passed to; Sailfin storage may be
arena-backed and reclaimed at a phase boundary. Anything the foreign side
retains beyond the call must live in memory it owns, such as a `malloc`
allocation. This rule is **documented, not enforced**.

**Layout is not specified.** Structs lower to LLVM identified types in field
declaration order, which coincides with the C ABI for scalar fields on the
supported targets, but no part of that is a contract and no layout attribute is
honored. `@repr(C)` parses and is ignored, as is any other unrecognized
decorator. A validated layout contract with `size_of` / `align_of` /
`offset_of` is **designed, not shipped** (SFEP-0079 §3.1, leaf L2).

## 13.4 Function addresses

A named Sailfin function's address is taken with an explicit cast:

```sfn
extern fn pthread_create(t: *u8, attr: *u8, start: *u8, arg: *u8) -> i32;

fn worker(arg: *u8) -> *u8 { return arg; }

// `worker as *u8` is the code pointer C receives.
```

The cast lowers to a single code pointer, not a closure pair, so foreign code
can call the function directly. Two diagnostics guard the form:

| Code | Raised when |
|---|---|
| `E0808` | A function name is used as a value without the cast, or with a target other than `* u8` or a function-pointer type. |
| `E0809` | The named function is generic. Only concrete functions have a single address. |

This is the shipped C→Sailfin callback path. Defining a C-callable symbol under
an unmangled name (`extern fn … { body }`) is **designed, not shipped**
(SFEP-0079 §3.4, leaf L6). A Sailfin `throw` unwinding across a foreign frame
is undefined.

## 13.5 Effects and `unsafe`

Extern calls are invisible to the effect checker: `E0804` forbids effects on
the declaration, and no analysis pass attributes an effect to an extern call.
The capability surface of foreign code is therefore **not** derived — declare
the effects on the Sailfin wrapper that calls the extern, so that the wrapper's
callers propagate them normally.

`unsafe { }` has exactly one shipped meaning: it is the author-asserted region
the ownership checker recognizes. Passing a bare owned value to an extern
declared in the same compilation unit, outside such a block, raises `E0906`.
No pointer operation requires an `unsafe` block.

`![unsafe]` is **not** an effect and never was. The canonical effects are
`clock`, `gpu`, `io`, `model`, `net`, and `rand`; a function declaring
`![unsafe]` is rejected with `E0404`. The `![unsafe]` effect,
`[capabilities] required = ["unsafe"]`, and `[policies.unsafe]` are
**withdrawn** by SFEP-0079 §3.5: each was a restriction with no matching power,
and a derived record of the program's foreign edges supersedes the audit
purpose they were meant to serve. That record is **designed, not shipped**
(SFEP-0079 §3.5, leaf L8).

## 13.6 Linking

The foreign library providing an extern symbol must be linked into the final
binary. Link inputs are build inputs, not provenance: naming a library tells
the linker what to resolve against, and records nothing about what that
library does.
