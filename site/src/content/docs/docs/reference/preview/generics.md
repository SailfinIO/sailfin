---
title: "Generic Constraints & Monomorphization"
description: "Design preview — generic type-parameter bounds and monomorphization. v1 shipped for pointer-width type arguments; generic collections and by-value aggregates deferred."
sidebar:
  order: 3.6
---

Sailfin generic type parameters now carry **enforced interface bounds** and
**monomorphized bodies** — the foundation the collections, typed higher-order
functions, and `Result` error-coercion work builds on. This page describes the
v1 surface (SFEP-0038) as it ships today, and marks the boundaries that remain
in preview.

## Interface bounds

A type parameter may declare a bound: a `+`-separated list of **interfaces** the
concrete type argument must implement.

```sfn
interface Comparable { fn compare(other: Self) -> int; }   // <0 / 0 / >0
interface Eq         { fn eq(other: Self) -> bool; }
interface Hashable   { fn hash() -> int; }

fn sort<T: Comparable>(items: T[]) -> T[] ![pure] { ... }
struct Map<K: Hashable + Eq, V> { ... }          // conjunctive: both required
```

A bound is checked, not decorative. Enforcement happens in two places:

- **Declaration time.** A bound must name a real interface of the correct
  arity. Naming a struct, enum, or unknown type raises **`E0821`**; a
  type-argument arity mismatch against a generic function raises **`E0822`**
  (#1868).
- **Instantiation site.** Every concrete type argument must implement each
  declared bound, verified against the same struct-implements-interface
  conformance machinery used for `implements` clauses. A type that does not
  satisfy a bound raises **`E0820`** (#1870):

  ```
  error[E0820]: type NotComparable does not satisfy bound Comparable
    --> src/main.sfn:9:14
     |
   9 | let bad = sort([NotComparable { x: 1 }]);
     |           ^^^^ required by type parameter T of fn sort<T: Comparable>
     = help: add `implements Comparable` to `struct NotComparable`
  ```

**Bound propagation.** A type parameter in scope satisfies a bound it already
declares: inside `fn sort<T: Comparable>`, `T` itself counts as `Comparable`,
so a bounded generic body may call another bounded generic with a `T`-typed
argument.

Bounds are **conjunctive** and **not** transitive supertrait chains in v1 — a
bound names only directly-required interfaces (`interface Ord: Eq` supertrait
declarations are deferred).

## Monomorphization

A generic function or struct is lowered by **generating one specialized copy per
distinct concrete instantiation** — the Rust/Swift zero-cost model: no boxing,
no per-call indirection, `T`-typed values stored inline at their real width, and
bound method calls resolved to a concrete method at emit time.

```sfn
fn id<T>(x: T) -> T { return x; }

let a = id(42);        // emits id$int
let b = id("hello");   // emits id$string  — two distinct specializations
```

The native-IR pass (`compiler/src/llvm/monomorphize.sfn`) collects the set of
concrete instantiations reached from `@main`, closes the worklist transitively
(a generic body instantiating another generic adds to it), and emits one
`$`-mangled specialization per instantiation. Specialized declarations flow
through the unchanged native emitter and LLVM backend as ordinary monomorphic
code.

- **Generic functions** monomorphize with higher-order-call return-type
  resolution, so a generic HOF `map_one(f, x)` returning `f(x)` yields the real
  value instead of the pre-SFEP-0038 garbage pointer (#1869).
- **Generic structs** monomorphize with inline field layout: `Box<T>`
  constructed as `Box{value: 42}` lowers to a concrete `%Box$int = type { i64 }`
  instead of the prior silent-empty / unsized-`%T` miscompile (#1871).
- **Bound interface-method calls** resolve inside each specialization: a
  `T: Comparable` call `a.compare(b)` becomes, in the `T = Widget`
  specialization, a direct static call to `Widget.compare` — not a vtable
  dispatch (#1872). Interface *values* (`let c: Comparable = widget`) keep the
  existing dynamic fat-pointer dispatch; bounds are the compile-time path.

## Standard-library bound interfaces

SFEP-0038 introduces the minimal interface set the immediate consumers name.
Each is an ordinary `interface` — no new language surface:

```sfn
interface Eq         { fn eq(other: Self) -> bool; }
interface Comparable { fn compare(other: Self) -> int; }
interface Hashable   { fn hash() -> int; }
interface Display    { fn to_string() -> string; }
interface From<T>    { fn from(value: T) -> Self; }
```

## v1 scope and what remains in preview

v1 is **monomorphize-only** (the dictionary-passing escape hatch for code-size /
compile-time is deferred) and covers **pointer-width type arguments** —
`int` / `float` / `bool` / `string` / `ptr` and boxed/pointer struct references,
the same set the enum-payload (#830) and channel monomorphization already handle.

Still in preview, gated on this foundation:

- **Arbitrary by-value aggregate `T`** — a struct/enum whose size ≠ 8 is not yet
  laid out inline; the generic layout manifest defaults an unresolved field type
  to pointer size/align 8. Shares the `>8-byte by-value payload` follow-up that
  gates enum payloads.
- **Generic collections** — real `Array<T>` / `HashMap<K: Hashable + Eq, V>` /
  `Set<T>`. `StrMap` remains the concrete-now string→string bridge until these
  land. See `draft-generic-collections.md`.
- **Typed higher-order array functions** — `float[]` / `string[]` / struct-array
  `.map` / `.filter` / `.reduce` (SFEP-0028); today only pointer-width `int[]`
  lowers.
- **`Result` `From<E>` coercion** — `?` coercing `E1` to `E2` where `E2: From<E1>`
  (SFEP-0012). This SFEP makes the bound checkable and monomorphizable; the
  coercion rule itself is SFEP-0012 follow-up.
- **Polymorphic recursion** and **supertrait bounds** (`interface Ord: Eq`).

## References

- **Design:** SFEP-0038 (`docs/proposals/0038-generic-constraints.md`).
- **Sub-tracks:** bound validation #1868 (`E0821`/`E0822`), function
  monomorphization #1869, instantiation-site satisfaction #1870 (`E0820`),
  struct monomorphization #1871, bound interface-method resolution #1872.
- **Prior art in-tree:** enum-payload per-instantiation substitution (#830), the
  precedent this SFEP generalizes from payload fields to whole bodies.
