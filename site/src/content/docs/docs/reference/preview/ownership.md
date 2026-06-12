---
title: "Ownership & Aliasing"
description: "Design preview — Sailfin's bounded ownership model: a runtime-enforced memory-safety floor for 1.0, and the deliberately extensible path beyond it."
sidebar:
  order: 3.5
---

Sailfin enforces a **bounded ownership / aliasing analysis** that proves the
native runtime cannot corrupt memory through aliased in-place mutation or
use-after-free. This page describes the *model* and its **intended expansion
path**; for the precise per-phase enforcement status and worked diagnostic
examples, see [Ownership Enforcement](/docs/reference/preview/ownership-enforcement/).

## What it is — and what it is not

Ownership checking is a **soundness floor on the implementation**, in the same
category as type checking: the compiler rejects a use-after-move for the same
reason it rejects passing a `string` where an `int` is expected. It is **not a
fourth pillar.** Sailfin's three differentiators are unchanged:

1. **Effect types** — compile-time capability enforcement.
2. **Capability-based security** — capsule manifests + dependency auditing.
3. **Structured concurrency** — planned (M4).

We never describe Sailfin as "a borrow-checked language like Rust." We describe
it as "a language whose runtime is memory-safe by construction." The analysis is
enforced on the native runtime today; **user-facing ownership and full borrow
checking are post-1.0** (Phase U, below).

> **Why it exists.** A recurring, nondeterministic IR-corruption class
> (issue #1205) traces to a single structural cause: an in-place buffer
> mutation — the `grow-if-at-tip` `string_append` optimization — that assumes
> a buffer is uniquely owned when a live alias may still exist. Patching each
> aliasing call-site failed three times. Proving uniqueness fixes it
> structurally: grow-at-tip stays, but only on values the compiler has proven
> unique, so the corruption becomes *unrepresentable* rather than *patched*.

## The 1.0 enforced subset (Option C)

For values of a designated **uniquely-owned buffer type** and for affine values,
the compiler proves there is **no live alias** at the point of in-place mutation
or disposal. Concretely, a standalone `ownership_checker.sfn` pass — after
effect-check, mirroring the effect checker's scope walk — tracks an **ownership
state** per binding through the control-flow graph:

- `Owned` — the binding uniquely owns its value; in-place mutation and drop are
  legal here.
- `Moved` — ownership transferred out (by rebinding, by passing to a call, by
  `return`); any subsequent use is an error.
- `Borrowed(shared)` — **reserved extension point** (not 1.0 surface; see
  *Expansion path*).

A value of an owned type (`OwnedBuf`, `Affine<T>`, `Linear<T>`) is *moved* when
it is rebound (`let y = x;`), passed to a call (`f(x)`), or returned. The pass
establishes three theorems: **unique ownership at mutation**, **no
use-after-move**, and **no use-after-free**.

### `OwnedBuf` / `Slice`

The owned-buffer type family lives in `runtime/sfn/memory/ownedbuf.sfn`:

- **`OwnedBuf`** — a unique, growable byte buffer. Assigning it moves it; taking
  a second live reference is an error. In-place mutators (`append`, `grow`,
  `set`) consume `self` and return the (possibly relocated) buffer, so
  grow-at-tip is *sound by construction* — there is no other live binding to
  stomp. Raw-pointer interior stays behind `unsafe { }`.
- **`Slice`** — a non-owning, read-only byte view over an `OwnedBuf`. Views
  cannot mutate or free; in the 1.0 subset their lifetimes are kept trivial
  (function-local, no escape).

```sfn
fn consume(b: OwnedBuf) -> int { return 1; }

fn ok(buf: OwnedBuf) -> int {
    let inner = buf;        // moves buf into inner
    return consume(inner);  // consumes inner; neither is used again
}

fn bad(buf: OwnedBuf) -> int {
    let n = consume(buf);   // moves buf
    return buf.length;      // E0901: use of moved value `buf`
}
```

### `Affine<T>` / `Linear<T>`

The existing `Affine<T>` / `Linear<T>` parse surface is now **load-bearing**
where used:

- `Affine<T>` is **at-most-once**: using it zero times is fine; a second use
  after the move is `E0901`.
- `Linear<T>` is **exactly-once**: in addition to the at-most-once rule, a
  linear value **must be consumed** (moved, returned, passed to a call, or
  freed) before it leaves scope. A linear value never consumed raises `E0907`.

```sfn
fn drop_it(v: Linear<int>) -> int { return 0; }          // E0907: linear `v` never consumed
fn keep_it(v: Linear<int>) -> int { return drop_it(v); } // ok: `v` consumed by the call
```

Ordinary copyable values are unaffected, and **user code is unaffected at 1.0** —
enforcement is runtime-scoped. Code that never names `OwnedBuf` / `unsafe` /
enforced `Affine` compiles exactly as before.

## The `unsafe` boundary

Runtime code needs raw pointers and FFI (`malloc`/`free`/`memcpy`,
`memcmp`/`strtod`, the libc/pthread surface). Constructing, dereferencing, doing
pointer arithmetic on, or freeing a raw pointer is permitted **only** inside an
`extern fn` body, an explicit `unsafe { … }` block, or an `unsafe fn`. The
ownership checker does **not** analyze the interior of an `unsafe` region — that
is the author's asserted responsibility. What it *does* enforce is the
**boundary**: a raw pointer may not silently escape into safe code as an
aliasable mutable handle (`E0906`). The unsound assumptions live in named,
auditable `unsafe` regions, not diffused across every raw pointer.

## Diagnostics — the `E09xx` family

Each diagnostic carries the span of the offending use **plus** the span of the
move/free that invalidated it (the two-span shape that makes use-after-move
diagnostics actionable).

| Code | Condition | Fix-it hint |
|---|---|---|
| `E0901` | Use of a moved value | *value moved here at `<span>`; clone it before the move, or restructure so the second use precedes the move* |
| `E0902` | In-place mutation of a possibly-aliased buffer | *`<name>` may be aliased by `<other>` (created at `<span>`); take a unique `OwnedBuf`, or use the copying concat path* |
| `E0903` | Use after free / after drop | *`<name>` was freed at `<span>`; do not use it after disposal* |
| `E0904` | Second live reference to a unique value | *`<name>` is uniquely owned; this creates a second live binding — move it or take an explicit copy* |
| `E0905` | Returning a reference that does not outlive the caller | *`<name>` is local to this function; return an owned value or copy into the caller's buffer* (Phase U) |
| `E0906` | Raw-pointer escape into safe code outside an `unsafe` region | *raw-pointer escape requires the call site to be inside an `unsafe` block / the buffer to be released to FFI* |
| `E0907` | Linear value never consumed | *`<name>` is `Linear<T>`; a linear value must be used exactly once — move it, return it, pass it to a call, or free it before it goes out of scope* |

`E0901`–`E0904`, `E0906`, and `E0907` are enforced today on the runtime surface;
`E0905` (return-of-local-reference) lands with borrowed-view lifetimes in
Phase U. See [Ownership Enforcement](/docs/reference/preview/ownership-enforcement/)
for the current per-phase status.

## Expansion path (the model is a floor, not a ceiling)

The 1.0 subset is the **first rung of a deliberately extensible model** — Sailfin
will grow its ownership/borrowing story over time as a modern,
agentic-development-era exploration of memory safety. **Sailfin does not have to
be Rust.** The following are not "post-1.0 maybe"; they are the **named forward
path**, and the type family and diagnostic surface are designed to widen
*without a rewrite*:

- **The `Borrowed` lattice state** and shared-borrow semantics are the planned
  next widening — read-only sharing of an owned buffer without copying.
- **`Slice` / view lifetimes** deepen toward borrowed-view lifetimes, at which
  point `E0905` (return-of-local-reference) becomes enforceable for user code.
- **Phase U — user-facing ownership.** `Affine<T>` / `Linear<T>` become enforced
  for user code on opt-in; ordinary code stays unaffected unless it opts in.
  Whole-language enforcement, shared `&T` / unique `&mut T` borrows, and any
  lifetime syntax are all Phase U. When Phase U enforcement ships, this preview
  is promoted to a numbered chapter in the
  [Language Specification](/docs/reference/spec/).

What the 1.0 subset deliberately does **not** do: no lifetime variables (`'a`),
no lifetime elision, no shared `&` / unique `&mut` borrow syntax for arbitrary
user types, no whole-program alias analysis, and no enforcement on raw pointers
themselves (those stay in the `unsafe` / `extern` escape hatch). The
unique-ownership guarantee comes from the *type*, not from inferring aliasing on
raw pointers.

## Relationship to the effect system

The ownership checker and the effect checker are **orthogonal and
complementary**, running back-to-back over the same scope structure. The effect
checker answers *"is this code allowed to perform this capability?"*; the
ownership checker answers *"is this memory access sound?"* Ownership introduces
**no new effect atom** — the taxonomy stays locked at the canonical six
(`clock`, `gpu`, `io`, `model`, `net`, `rand`). Ownership is a separate axis, not
a seventh effect and not a fourth pillar.
