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

Each diagnostic points at the offending use and notes the move that invalidated
it. Ordinary copyable values are unaffected. Still to come: in-place-mutation /
use-after-free rules (`E0902`/`E0903`, E6), linear single-use enforcement on
user wrappers (E7), and `&T`/`&mut T` borrow exclusivity (Phase U). Full
enforcement is a 1.0 requirement.

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
