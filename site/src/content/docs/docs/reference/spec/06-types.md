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
> deprecated alias for `float` retained for source compatibility. The
> compiler source and runtime prelude completed their migration to the
> explicit `int` / `float` spellings in Slice E.3a (May 2026); the alias
> itself is scheduled for removal in Slice E.4 after the strict-refusal
> reapply (E.3b) ships — tracked on the [roadmap](/roadmap).

**Scalar coercion rules**:

Scalar primitives fall into three *kinds* — `int` (`i8`/`i16`/`i32`/`i64`),
`float` (`f32`/`f64`), and `boolean` (`i1`). Coercion is permitted *within* a
kind (e.g. `i32 → i64` widening) but rejected *across* kinds at value
boundaries — bindings, call arguments, struct fields, and arithmetic operands:

- **`int ↔ float`** mismatches are rejected; spell the conversion with
  `as int` or `as float`.
- **`boolean → int` / `boolean → float`** mismatches are rejected. A boolean
  flowing into a numeric context (`let n: int = b`, `b + 1`, passing `b` to a
  numeric parameter) is **not** silently widened to `0`/`1`; the compiler emits
  an ABI primitive mismatch diagnostic with an `as int` / `as float` fix-it.
  Convert explicitly — `let n: int = b as int` (`zext`) or `let x: float = b
  as float` (`uitofp`) — when the numeric value of the boolean is intended.
  (`as bool` is **not** a valid cast — to derive a boolean from a number, use a
  comparison such as `n != 0`.) Boolean-to-string interpolation (`"flag: ${b}"`)
  is unaffected: it renders `"true"`/`"false"`, not a numeric widening.

> Booleans are a distinct scalar kind, not narrow integers. This prevents the
> accidental, silent `bool → number` widening that earlier partial-migration
> tooling tolerated. The `as int` escape valve remains available where the
> 0/1 mapping is deliberate.

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
