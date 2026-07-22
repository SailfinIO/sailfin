---
title: "Unsafe Enforcement"
description: "Unsafe enforcement status — locally declared extern escape boundaries ship; broader call-graph and implicit-runtime-extern coverage remain planned."
sidebar:
  order: 8
---

`unsafe { }`, `unsafe fn`, and `extern fn` syntax ship. The ownership checker
treats the boundary as load-bearing: passing a bare owned value to an `extern
fn` declared in the same compilation unit outside `unsafe` raises `E0906`, and
the checker skips author-asserted raw-pointer operations inside unsafe code.

The current enforcement is deliberately partial. Implicitly linked prelude and
runtime externs are not yet matched by the same-module boundary check, and full
`![unsafe]` call-graph propagation is not active. Code inside an unsafe region
therefore remains responsible for its raw-pointer invariants.
