---
sfep: 0028
title: Typed / Generic-Element Array Higher-Order Functions (map / filter / reduce)
status: Draft
type: language
created: 2026-06-26
updated: 2026-06-26
author: "agent:compiler-architect; human review"
tracking: "#766"
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0028 — Typed / Generic-Element Array Higher-Order Functions (map / filter / reduce)

> Design record for the residual gap left open after the pointer-width array
> higher-order functions shipped (#1507 / #1508, epic #1118, closing the
> implementable scope of #766). See
> [`0001-sfep-process.md`](./0001-sfep-process.md) for the process.

## 1. Summary

`arr.map` / `arr.filter` / `arr.reduce` (and the prelude `array_map` /
`array_filter` / `array_reduce` free functions) work **today only for
pointer-width `int` (`i64`) elements and accumulators**. The runtime-callable
closure-apply seam landed in #1507 and the real `sfn_array_sfn_{map,filter,reduce}`
bodies in `runtime/sfn/array.sfn` (#1508) are sound and self-host, but their
callback ABI is fixed at `iN(i8* env, i64 …)`, so every element rides the helper
as a raw `i64`. Arrays of any other shape — `float[]` (f64), `string[]` (`i8*`
with boxing concerns), and value/struct arrays of arbitrary width — are
**rejected with a diagnostic** rather than mis-mapped. This SFEP designs the path
to typed, generic-element higher-order functions so `[1.5, 2.5].map(…)`,
`["a","b"].filter(…)`, and `points.reduce(origin, …)` work end-to-end with the
same closure-dispatch ergonomics `int[]` already enjoys.

This proposal records the design and tradeoffs only. It does **not** commit to a
release window (pre- or post-1.0); sequencing is decided at grooming once its
upstream dependency — generic type constraints — has a plan.

## 2. Motivation

Array transformation over non-integer data is table stakes for a production
language. The current sharp edge:

```sfn
let prices: float[] = [1.5, 2.5, 3.5];
let taxed = prices.map(fn (p: float) -> float { return p * 1.08; });
// rejected: the callback ABI is iN(i8* env, i64 …); f64 elements do not fit
// the pointer-width seam and the typechecker emits a diagnostic.

let names: string[] = ["ada", "grace"];
let kept = names.filter(fn (n: string) -> bool { return n.length > 3; });
// rejected for the same reason: i8* string elements are not pointer-width i64.
```

Who hits it: anyone processing floats, strings, or structs — i.e. most real
programs, and the compiler itself once it wants to fold over typed collections
without hand-rolling `loop`. Today the workaround is a manual `loop` (see
`docs/perf/runtime-performance.md`: `array_map_filter` uses manual loops). The
status quo is insufficient because the method form silently narrows to `int[]`:
a user who writes `float[].map(…)` gets a diagnostic, not a result, and the
prelude `array_map`'s advertised `(any) -> any` signature is a promise the
lowering cannot keep.

The *enabling* foundation — closures with capture and a runtime-callable
closure-apply seam — already exists (#699, #1507). The remaining gap is purely
the **element type discipline**: the seam threads one pointer-width word; typed
elements need either monomorphization or a width-aware ABI.

## 3. Design

The gating capability is **generic type constraints + monomorphization** — the
same foundation `Result<T, E>` (SFEP-0012) and a typed `SfnArray<T>` /
`SfnSlice<T>` (SFEP-0025 §3.4) depend on. Three shapes were weighed; the
recommended end state is (A), with (C) available as an interim that does not
require full generics.

### (A) Monomorphized typed bodies — recommended end state

Make `SfnArray<T>` and the callbacks genuinely generic and **monomorphize** the
higher-order helpers per element/result type at the call site:

```sfn
fn sfn_array_map<T, U>(arr: SfnArray<T>, mapper: fn (T) -> U) -> SfnArray<U> { … }
fn sfn_array_filter<T>(arr: SfnArray<T>, predicate: fn (T) -> bool) -> SfnArray<T> { … }
fn sfn_array_reduce<T, A>(arr: SfnArray<T>, initial: A, reducer: fn (A, T) -> A) -> A { … }
```

The monomorphizer emits a specialized body (or inlines the element loop) for each
concrete `(T, U)` actually used. The callback ABI becomes the **natural** ABI for
`T` — `f64(i8* env, double)` for `float`, `i8*(i8* env, i8*)` for `string`,
by-value struct passing for value types — so no boxing and no width tagging. The
closure-dispatch seam (#1507) already reconstructs the typed function-pointer
signature from the call site's resolved closure types; under monomorphization the
"resolved type" is simply the concrete `T`, so the seam generalizes without a new
mechanism. Element loads use the element's `elem_size` (already threaded through
`_sfn_array_alloc_v2`) rather than a hard-coded `* 8`.

This is the principled, allocation-free, fully-general answer. It is also the
heaviest: it requires generic constraints in typecheck and a monomorphization
pass in lowering that the compiler does not have yet.

### (B) Uniform boxed representation — rejected

Box every element to `i8*`, thread it through the existing pointer-width seam,
and unbox inside the callback. No generics required, but: (1) it forces a heap
box per element (allocation storm on hot paths), (2) boxing an `f64`/struct into
an `i8*` slot and back is exactly the number-boxing hazard #1508's `reduce` body
already had to avoid for its accumulator (a scalar in an `any` slot is stringified
— see `runtime/sfn/array.sfn` reduce comment), and (3) it is unsound for value
types without a precise drop/lifetime story. Rejected as a primary path.

### (C) Width-tagged descriptors — viable interim

Extend the runtime-helper descriptors (`runtime_array_map_fn` etc. in
`compiler/src/llvm/runtime_helpers.sfn`) to carry an element **width/kind tag**
(e.g. `i64`, `f64`, `i8*`) alongside `elem_size`, and provide a small fixed set
of runtime body specializations that switch on the tag. This covers `float[]`
and `string[]` — the two highest-demand cases — **without** full generics, at the
cost of an explicit, bounded ABI per supported width. It does not scale to
arbitrary structs (those still wait for (A)), and the tag set must move in
lockstep across the descriptor, the runtime fn signature, and the registered
helper declare (the same lockstep discipline #1507/#1508 enforced). Recommended
only if demand for `float[]`/`string[]` outruns the generics timeline.

### Surface (unchanged regardless of shape)

The user-facing spelling does not change — `arr.map(closure)` /
`arr.filter(closure)` / `arr.reduce(init, closure)` and the prelude
`array_map`/`array_filter`/`array_reduce` keep their signatures. The diagnostic
that today rejects non-`int[]` element types is **removed** as each width becomes
supported; until then it stays (rejecting is better than mis-mapping).

## 4. Effect & capability impact

None. Array primitives live below the I/O layer (the same discipline as
`runtime/sfn/memory/arena.sfn` and `runtime/sfn/string.sfn`); the
`sfn_array_sfn_*` bodies are effect-free. `![io]` annotations attach to the
*adapters* that wrap these primitives, never to the primitives themselves. The
user-supplied callback carries whatever effects its own body requires, propagated
by the existing effect checker through the closure call — unchanged by element
type. No new capability surface.

## 5. Self-hosting impact

Passes touched depend on the chosen shape:

- **(A) monomorphization:** `typecheck.sfn` (generic constraint solving for
  `<T, U>` callbacks and typed `SfnArray<T>`), a monomorphization step in
  `compiler/src/llvm/` lowering, and generic / width-aware bodies in
  `runtime/sfn/array.sfn`. The closure-dispatch seam
  (`core_call_emission.sfn`, `core_call_lowering.sfn`) generalizes rather than
  changes. This is a large, cross-pass change and **must** land bundled with its
  consumer per `.claude/rules/seed-dependency.md` (a runtime body that uses a new
  lowering capability only self-hosts once that capability is in the pinned seed).
- **(C) width tags:** `runtime_helpers.sfn` descriptor ABI + the registered-helper
  declares (`lowering_helpers.sfn`) + the runtime fn signatures, all in lockstep;
  no generics. Smaller blast radius.

The self-hosting invariant is preserved the same way #1507/#1508 preserved it:
`make compile` builds the new compiler from the old seed, and that compiler
compiles the new `array.sfn` body in the same pass when capability and consumer
are bundled. The compiler itself currently folds typed collections with manual
`loop`s, so it does not regress if this lands incrementally.

## 6. Alternatives considered

- **(B) uniform boxing** — rejected (allocation storm, number-boxing hazard,
  value-type unsoundness; §3 (B)).
- **Keep pointer-width-only forever** — rejected: it permanently strands
  `float[]`/`string[]`/struct arrays on manual loops and leaves the prelude
  `(any) -> any` signature a lie.
- **Special-case `float[]` and `string[]` by hand without a tag system** —
  rejected: it scatters element-type logic across emission instead of behind the
  one descriptor seam #1507 deliberately centralized, re-incurring the
  maintenance cost that seam removed.
- **(C) as the permanent answer** — rejected as the *end state* (does not cover
  structs) but accepted as a possible *interim* if demand precedes generics.

## 7. Stage1 readiness mapping

Nothing here is built yet — this is a Draft design record.

- [ ] Parses (no new syntax; typed `T[]` literals + closures already parse)
- [ ] Type-checks / effect-checks (generic constraint solving — the gap)
- [ ] Emits valid `.sfn-asm`
- [ ] Lowers to LLVM IR (monomorphized or width-tagged callback ABI)
- [ ] Regression coverage (§8)
- [ ] Self-hosts
- [ ] `sfn fmt --check` clean
- [ ] Documented in `docs/status.md` + spec (flip the §3.4 / standard-library
      "pointer-width only" note as each width ships)

## 8. Test plan

E2e fixtures + tests mirroring the existing
`compiler/tests/e2e/array_{map,filter,reduce}_closure_test.sfn` pattern, one per
newly-supported width, each distinguishing the real typed body from the current
diagnostic / a stub:

- `float[]`: `[1.5, 2.5, 3.5].map(p => p * 2.0)` → sum `15.0`; a capturing
  reducer folding `f64`.
- `string[]`: `["ada","grace"].filter(n => n.length > 3)` keeps `["grace"]`;
  `.map` over string→string.
- struct/value arrays (shape (A) only): `points.map(p => p.x)` and a
  `.reduce(origin, …)` over a struct accumulator.
- A negative test asserting the **diagnostic** is emitted for any width not yet
  supported (so partial rollout never silently mis-maps).
- `make compile` self-hosts; `make check` triple-pass green.

## 9. References

- **#766** — original tracking issue (closed as completed; pointer-width scope
  shipped via #1507/#1508). This SFEP is the durable design record for its
  residual generic-element gap.
- **Epic #1118** — runtime-callable closure application primitive (closed); the
  foundation these bodies are built on.
- **#1507 / #1508** — the closure-apply seam + real pointer-width
  `map` / `filter` / `reduce` bodies.
- **SFEP-0025 §3.4** (`0025-native-runtime-architecture.md`) — the array / slice
  subsystem and the "pointer-width surface only" verdict this SFEP closes.
- **SFEP-0012** (`Result<T, E>` and `?`) — shares the generic-constraint
  dependency; sequencing should be coordinated.
- `runtime/sfn/array.sfn` — the `sfn_array_sfn_{map,filter,reduce}` bodies.
- `compiler/src/llvm/runtime_helpers.sfn` — the `runtime_array_*_fn` descriptors
  whose ABI shape (A)/(C) extend.
- `docs/perf/runtime-performance.md` — records the current manual-loop workaround.
