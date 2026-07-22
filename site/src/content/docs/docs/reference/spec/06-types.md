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

**Interfaces are method-only contracts**: an interface member must be a method
signature (`fn name(...) -> T`). A data-field-shaped member (`name: Type`) is
a typecheck error (`E0827`); data fields belong on a concrete `struct` that
implements the interface:

```sfn
interface Named {
    fn name() -> string;   // OK — method-only contract
    // isAdmin: boolean;   // E0827 — declare a struct for data fields
}
```

**Object literals require a concrete `struct` target**: data is constructed
only through a `struct`. A bare object literal `{ ... }` resolves its shape
against the annotation or contextual type it targets; if that target is an
**interface**, or the binding is unannotated and no concrete struct can be
inferred, the literal is a typecheck error (`E0828`). The sanctioned path is
a `struct` annotation:

```sfn
struct Person { name: string; }
interface Named { fn name() -> string; }

let p: Person = { name: "Alice" };   // OK — concrete struct target
let n: Named  = { name: "Alice" };   // E0828 — Named is an interface, not a struct
let u         = { name: "Alice" };   // E0828 — no inferable struct target
```

**Optional types**: `T?` — the value is `T` or `null`

**Union types**: `A | B` — the value is either type; matched with `match`

**Intersection types (`A & B`) are not a data type**: the grammar accepts
`A & B` as a `Type`, but using it as a **data/value type** — a variable,
parameter, struct/enum field, or return-type annotation, or the RHS of a
`type X = A & B` alias — is a typecheck error (`E0829`). It is never
decomposed into a structural record of both interfaces' members; the nominal
object model has no such structural type. `A & B` is *reserved* for generic
trait-bound composition — a bound is written `+`-separated (`<T: A + B>`, per
SFEP-0038), not with `&` — and stays undiagnosed in bound position; only
data/value-type uses are rejected. See SFEP-0039 for the full rationale.

```sfn
interface Named  { fn name() -> string; }
interface Scoped { fn is_admin() -> boolean; }

type AdminUser = Named & Scoped;         // E0829 — intersection at the alias definition
let x: Named & Scoped = get_admin();     // E0829 — intersection in annotation position
```

**Generic types**: user-declared generics (`fn first<T>(items: T[]) -> T?`) and
the prelude `Result<T, E>` enum. Postfix `?` propagation also ships; see
[§12 Result and the `?` Operator](/docs/reference/spec/12-result-and-errors/).

**Wrapper types**:

| Type | Semantics |
|------|-----------|
| `Affine<T>` | May be dropped, cannot be duplicated; move enforcement ships for owned/affine bindings |
| `Linear<T>` | Must be consumed exactly once; move and scope-exit consumption enforcement ship |
| `PII<T>` | Personally identifiable information — egress guards planned |
| `Secret<T>` | Secret value — logging/serialization guards planned |

**Reference types** (syntax accepted; borrow checking planned):
- `&T` — shared (read-only) borrow
- `&mut T` — exclusive mutable borrow

**Raw pointer types** (FFI, `unsafe` only):
- `*T` — read-only raw pointer
- `*mut T` — mutable raw pointer
- `*opaque` — opaque foreign pointer (`void*`)
