---
title: "Unsafe Enforcement"
description: "Unsafe enforcement status — locally declared extern escape boundaries ship; the ![unsafe] effect and capability are withdrawn."
sidebar:
  order: 8
---

`unsafe { }`, `unsafe fn`, and `extern fn` syntax ship. The ownership checker
treats the boundary as load-bearing: passing a bare owned value to an `extern
fn` declared in the same compilation unit outside `unsafe` raises `E0906`.

Note what "author-asserted" costs. The checker does not walk an `unsafe { }`
interior, so statement-level findings there (a double consume that would be
`E0901`) are not raised; a routine-level `Linear<T>` obligation survives, but a
consumption inside the block is invisible to it and surfaces as `E0907`
instead. An `unsafe fn` body is skipped outright, so a `Linear<T>` parameter of
one carries no enforced obligation at all. Prefer a plain `fn` with a narrow
`unsafe { }` block.

The current enforcement is deliberately partial. Implicitly linked prelude and
runtime externs are not yet matched by the same-module boundary check, so code
inside an unsafe region remains responsible for its raw-pointer invariants.

**`![unsafe]` is withdrawn, not pending.** It is not a canonical effect — the
canonical set is `clock`, `gpu`, `io`, `model`, `net`, `rand` — and a function
declaring it is rejected with `E0404`. `[capabilities] required = ["unsafe"]`
and the `[policies.unsafe]` workspace policy are withdrawn with it
([SFEP-0079](/sfep/0079-systems-c-interop/) §3.5): the effect was a restriction
with no matching power, and a derived record of a program's foreign edges
replaces its audit purpose. No call-graph propagation for `unsafe` is planned.

No pointer operation requires an `unsafe` block, and SFEP-0079 §3.2 declines to
add such a rule. See [§13 Foreign Interface](/docs/reference/spec/13-foreign-interface/)
for the shipped extern and raw-pointer surface.
