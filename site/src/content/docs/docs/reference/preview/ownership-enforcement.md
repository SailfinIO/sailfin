---
title: "Ownership Enforcement"
description: "Ownership enforcement status — move, mutation, use-after-free, extern escape, linear consumption, and spawn-capture checks ship; borrow lifetimes remain planned."
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

## OwnedBuf / Slice — Phase R1 landed (#1217)

The owned-buffer type family ships as library types in
`runtime/sfn/memory/ownedbuf.sfn`: `OwnedBuf` is the unique, growable byte
buffer and `Slice` is the non-owning, read-only byte view over it.

**Phase R1 (memory/string core — #1217, epic #1209 E8) has landed.** The
hot-path string functions in `runtime/sfn/string.sfn` are migrated onto these
types:

- `sfn_str_sfn_append(buf: OwnedBuf, suffix_addr: i64, suffix_len: i64) -> OwnedBuf`
  — consume-and-return move; raw grow-at-tip interior behind `unsafe { }` in arena.sfn.
- `sfn_str_sfn_concat(a: *u8, b: *u8) -> OwnedBuf` — returns owned buffer built
  via the global arena (gated on `sfn_arena_enabled()`, libc-backed when the arena
  is opted out); no arena-stranded raw `*u8` return.

`sfn_str_sfn_slice` is **not** migrated. It keeps its allocating `* u8` body
because a non-owning `Slice` view is not sound until the remaining
immediate-codepoint representation is retired and view lifetimes are tracked.
The runtime itself is Sailfin-native; there is no C-runtime fallback.

The grow-at-tip `unsafe { }` block in `sfn_arena_sfn_realloc` and the raw
extern alloc/realloc/memcpy interiors of `owned_buf_new` / `owned_buf_append`
are similarly wrapped. The unique-owner move-return stays in checked code.

The ownership checker (E5/E6, #1214/#1215) proves no live alias at the
mutation site, structurally closing the #1205 aliasing hazard class.

Still to come: `&T`/`&mut T` borrow exclusivity and lifetime enforcement on
`Slice` views (`E0905`, Phase U). The full `SfnString`-aggregate flip (concat/slice
operating over the aggregate end-state) is gated on M1.A.2. `Slice` is
deliberately concrete over bytes; a generic `Slice<T>` is deferred until generic
struct bodies lower.
