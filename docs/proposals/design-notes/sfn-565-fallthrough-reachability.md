# Design note — SFN-565: reachable function-body fallthrough

- **Issue:** SFN-565
- **Related:** SFN-526, SFN-527
- **Status:** Implemented
- **Date:** 2026-07-28

## Problem

`emit_llvm_function` must terminate every LLVM basic block. When body lowering
leaves the final block unterminated, emission appends `ret <default>`. The same
fallback covers two different cases:

1. a source body can genuinely reach its end, so the return value is fabricated;
2. lowering created an unreachable continuation block, such as the exit block
   of an infinite `loop` with no `break`, and LLVM still requires that dead
   block to have a terminator.

SFN-527 correctly left this consumer untagged because body lowering's
`terminated` flag does not distinguish those cases.

## Decision

Run reachability over the LLVM basic-block graph already emitted for the
function. The entry node is `block.entry`; branch successors are the canonical
`label %<name>` operands emitted by lowering; the candidate is the last emitted
block, which is where the fallback return will be appended.

The analysis computes the transitive closure of branch edges from the entry.
The missing-return diagnostic is fatal only when the candidate block is in that
closure. The fallback terminator is emitted in both cases.

This level is preferable to a second AST or native-IR flow model:

- it answers the exact question at the exact consumer that fabricates the
  value;
- loops, `if`, `match`, `try`, and expression-internal control flow need no
  duplicated semantic rules;
- an unreachable loop-exit block has no incoming reachable edge, while a real
  `if` merge does;
- only canonical, explicit branch operands create edges, so an unrecognised
  shape cannot manufacture proof of reachability.

The graph walk is deliberately local to function emission. It does not attempt
general condition feasibility, dominance, or LLVM verification. It recognizes
one lowering-generated constant condition: `unsafe { ... }` is represented in
native IR as an `if 1 > 0` wrapper and lowers to `icmp sgt i64 1, 0`. The graph
walk follows only that branch's true edge, preventing the synthetic false merge
from looking like source-level fallthrough. Other constant conditions remain
conservative: for example, `if true { return 1; }` still follows both emitted
successors and reports `E1002`. Broader condition feasibility is a future
precision improvement rather than part of this fallback-safety gate.

Exhaustive enum matches require one precision repair in the existing match
lowerer. Monomorphic enum operands may carry the boxed `%Enum*` form, while a
boxed generic enum such as `Result<T, E>` carries LLVM type `i8*`; exact
LLVM-type lookup could not identify their variants and left the merge block
live even when every variant arm returned. Match lowering now uses
pointer-tolerant LLVM lookup, then falls back to the subject's source type
annotation for opaque generic boxes, before applying its existing matched-tag
exhaustiveness check. The condition lowerer now returns enum/variant metadata
for unit variants as well as payload variants; previously all-unit enums could
never contribute their tags to that check. An exhaustive match therefore
terminates in an `unreachable` merge; guarded or incomplete matches keep their
real merge edge.

## Diagnostic

Reuse `E1002`, the established code for a lowering consumer that substitutes a
fabricated default value:

```text
llvm lowering [fatal] [E1002]: function `<name>` can reach the end without returning
```

## Verification

- The infinite-loop control remains successful and untagged.
- A value-returning function with an `if` and no trailing return fails closed
  with `E1002` and the function name.
- Unit coverage pins reachable and disconnected final-block graphs.
- The compiler self-hosts with the new gate.
