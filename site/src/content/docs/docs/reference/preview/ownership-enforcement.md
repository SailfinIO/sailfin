---
title: "Ownership Enforcement"
description: "Design preview — Ownership Enforcement. Planned, not yet shipped."
sidebar:
  order: 4
---

`Affine<T>` and `Linear<T>` wrappers are parsed, and **move / use-after-move are
now enforced** on owned/affine-typed bindings (epic #1209, E5 / #1214). A value
of an owned type (`OwnedBuf`, `Affine<T>`, `Linear<T>`) is *moved* when it is
rebound (`let y = x;`), passed to a call (`f(x)`), or returned (`return x;`).
After the move the original binding is dead:

- reading, passing, or returning it again raises **`E0901`** (use of a moved
  value);
- binding it to a fresh name again (`let z = x;`) raises **`E0904`** (a second
  live binding to a value that is no longer uniquely owned).

Disposal and aliasing are also enforced (E6 / #1215): a use after `free(x)` /
`x.free()` raises **`E0903`**, an in-place mutation (`x.append(...)`) of a stale
(moved/freed) buffer raises **`E0902`**, and passing a bare owned value into an
`extern fn` outside an `unsafe` block raises **`E0906`**.

**Affine vs. linear (E7 / #1216).** `Affine<T>` is *at-most-once*: the move
rules above are its whole story — using it zero times is fine, using it twice is
`E0901`. `Linear<T>` is *exactly-once*: in addition to the at-most-once rules, a
linear value **must be consumed** (moved, returned, passed to a call, or freed)
before it leaves scope. A linear binding that is never consumed raises
**`E0907`**. (In the current narrow subset, consumption is recognised
straight-line within the declaring scope; consuming a linear value only inside a
nested branch is not yet lifted to the outer scope.)

Each diagnostic points at the offending use and, where applicable, notes the
move/free that invalidated it. Ordinary copyable values are unaffected. Still to
come: `&T`/`&mut T` borrow exclusivity and the return-of-local-reference rule
(`E0905`, Phase U). Full enforcement is a 1.0 requirement.

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

fn drop_it(v: Linear<int>) -> int { return 0; }    // E0907: linear `v` is never consumed

fn keep_it(v: Linear<int>) -> int { return drop_it(v); }  // ok: `v` is consumed by the call
```

## OwnedBuf / Slice (surface only)

The owned-buffer type family ships as library types in
`runtime/sfn/memory/ownedbuf.sfn`: `OwnedBuf` is the unique, growable byte
buffer (`owned_buf_append` consumes it and returns the possibly-relocated
buffer) and `Slice` is the non-owning, read-only byte view over it. Today this
is the **surface only** — the types parse, typecheck, and lower, but the
ownership checker does not yet enforce moves on `OwnedBuf` or lifetimes on
`Slice`. Enforcement attaches to these names in later phases of the ownership
epic (#1209): move semantics with the ownership-checker rules (#1214/#1215),
view lifetimes in a later phase (Phase U). `Slice` is deliberately concrete
over bytes; a generic `Slice<T>` is deferred until generic struct bodies lower.
