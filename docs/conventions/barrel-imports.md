# Barrel imports (`mod.sfn` re-export facades)

This is the canonical authoring rule for **importing from a `mod.sfn`
re-export barrel versus importing directly from the leaf module that
defines a symbol**. It exists because barrel re-exports silently inflate
compile graphs: the capsule resolver is *eager* on re-exports — loading a
`mod.sfn` compiles **every** leaf it re-exports, not just the leaves whose
symbols you actually imported.

It is the structural companion to
[`unit-test-import-envelope.md`](./unit-test-import-envelope.md) (#619):
that doc bounds *which* `compiler/src` modules a test may reach; this doc
bounds *how* you reach them so you don't drag a whole subtree for one or
two symbols.

---

## TL;DR

> **Import from the leaf module that defines the symbol. Reach for a
> barrel (`*/mod.sfn`) only when you genuinely need symbols spanning
> three or more distinct leaf modules.**

A single import from a barrel pulls the barrel's entire re-export surface
into your compile graph. If the symbols you need all live in one or two
leaves, name those leaves directly.

```sfn
// ❌ drags every leaf re-exported by native/mod.sfn (~11 files)
import {
    LiftResult,
    lift_non_capturing_lambdas,
    lifted_function_name
} from "../../src/llvm/expression_lowering/native/mod";

// ✅ pulls only lambda_lowering.sfn + its deps — all three symbols live there
import {
    LiftResult,
    lift_non_capturing_lambdas,
    lifted_function_name
} from "../../src/llvm/expression_lowering/native/lambda_lowering";
```

## Why this matters

The resolver compiles every transitively-referenced module to LLVM IR
before linking. A barrel's `export { ... } from "./leaf"` lines each force
`./leaf` to be compiled when the barrel is loaded — even if the consumer
imports nothing that originates in that leaf. So importing one symbol from
a ten-leaf barrel compiles all ten leaves (and their deps).

The motivating regression: `emit_native.sfn` imported a single AST-pass
symbol (`lift_non_capturing_lambdas`) from
`llvm/expression_lowering/native/mod.sfn`. That dragged the entire
lowering subtree into `emit_native`'s graph, so a test whose only job was
verifying `extern fn` → `.meta extern` cold-compiled every lowering file
on every CI run. Wall-clock crept 60s → 300s and tipped past the per-test
cap (#704, #709). The fix was a one-line switch to a direct leaf import.

## The "three or more leaves" threshold

The count that matters is **distinct leaf modules**, not symbols. Five
symbols that all live in one leaf → import the leaf (the barrel buys you
nothing but graph bloat). Three symbols spread across three leaves → the
barrel is a reasonable single import; record that as the reason it stays.

## When a barrel is the right call

- A consumer that legitimately needs the *facade* — symbols from many
  leaves — and where the full surface is on its compile path anyway.
- A symbol that is **defined in the `mod.sfn` itself** (not re-exported
  from a leaf). There is no leaf to point at; the barrel is the home
  module. Example: `parse_program` lives in `parser/mod.sfn`, so its
  consumers necessarily import the barrel.

## Out of scope (separate decisions)

- Deleting barrels. Some have genuine multi-leaf consumers.
- Teaching the resolver to compile only the reachable symbols from a
  re-export barrel (a `capsule_resolver.sfn` change).
- Relocating a symbol out of a barrel into a leaf so consumers *can* take
  the leaf path. That is a per-symbol re-org decision, tracked separately.
