---
title: "§6 Type System"
description: "Sailfin language specification — Type System."
sidebar:
  order: 6
  label: "§6 Type System"
---

**Primitive types**:

| Type | Description | FFI C equivalent |
|------|-------------|-----------------|
| `int` | 64-bit signed integer (default for unsuffixed integer literals) | `int64_t` |
| `float` | 64-bit IEEE-754 float (default for decimal literals) | `double` |
| `number` | Deprecated alias for `float` (kept for migration) | `double` |
| `string` | UTF-8 string | — |
| `boolean` | Boolean | `_Bool` |
| `void` | No return value | `void` |
| `null` | Absence of a value | — |

**Integer and float types** (for FFI and low-level use):
`i8`, `i16`, `i32`, `i64`, `u8`, `u16`, `u32`, `u64`, `usize`, `f32`, `f64`

> Bare unsuffixed integer literals default to `int` (i64); decimal or
> exponent literals default to `float` (f64). The `number` keyword is a
> deprecated alias for `float` and will be removed once the compiler
> source completes its migration to the explicit `int` / `float`
> spellings — tracked on the [roadmap](/roadmap).

**Composite types**: structs, enums, arrays (`T[]`)

**Optional types**: `T?` — the value is `T` or `null`

**Union types**: `A | B` — the value is either type; matched with `match`

**Generic types**: user-declared generics (`fn first<T>(items: T[]) -> T?`).
`Result<T, E>` is on the [roadmap](/roadmap); use union return types
(`T | MyError`) today.

**Wrapper types** (syntax accepted; enforcement planned for 1.0+):

| Type | Semantics |
|------|-----------|
| `Affine<T>` | May be dropped, cannot be duplicated |
| `Linear<T>` | Must be consumed exactly once |
| `PII<T>` | Personally identifiable information — egress guards planned |
| `Secret<T>` | Secret value — logging/serialization guards planned |

**Reference types** (syntax accepted; borrow checking planned):
- `&T` — shared (read-only) borrow
- `&mut T` — exclusive mutable borrow

**Raw pointer types** (FFI, `unsafe` only):
- `*T` — read-only raw pointer
- `*mut T` — mutable raw pointer
- `*opaque` — opaque foreign pointer (`void*`)
