---
title: "Ownership Enforcement"
description: "Design preview — Ownership Enforcement. Planned, not yet shipped."
sidebar:
  order: 4
---

`Affine<T>` and `Linear<T>` wrappers are parsed today but move/consume rules
are not enforced. `&T`/`&mut T` borrows are parsed but exclusivity is not checked.
Full enforcement is a 1.0 requirement.

## OwnedBuf / Slice (surface only)

The owned-buffer type family ships as library types in
`runtime/sfn/memory/ownedbuf.sfn`: `OwnedBuf` is the unique, growable byte
buffer (`owned_buf_append` consumes it and returns the possibly-relocated
buffer) and `Slice` is the non-owning, read-only byte view over it. Today this
is the **surface only** — the types parse, typecheck, and lower, but the
ownership checker does not yet enforce moves on `OwnedBuf` or lifetimes on
`Slice`. Enforcement attaches to these names in later phases of the ownership
epic (moves in E5/E6, view lifetimes in E8). `Slice` is deliberately concrete
over bytes; a generic `Slice<T>` is deferred until generic struct bodies lower.
