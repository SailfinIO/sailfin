---
sfep: 0052
title: Accelerated ML — Substrate Interop and Capability-Typed Accelerator Programming
status: Accepted
type: informational          # strategy umbrella; child SFEPs will be runtime | language | tooling
created: 2026-07-19
updated: 2026-07-19
author: "agent:orchestrator (Sailbot); human review"
tracking:                    # child epics allocated when this is Accepted
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0052 — Accelerated ML: Substrate Interop and Capability-Typed Accelerator Programming

> Strategy umbrella. This SFEP fixes a *direction* and an *architecture spine*;
> each numbered track below graduates into its own runtime/language/tooling SFEP
> before implementation. It is deliberately not a single-PR design.

## 1. Summary

Sailfin should enter the modern AI-compiler arena, but **not** by reimplementing
XLA. This SFEP commits Sailfin to a two-track architecture:

- **Track A — reuse the substrate (interop-first backend).** Add a shape-typed
  tensor IR above the scalar `native_ir`, and lower it to an existing,
  battle-hardened accelerator substrate — StableHLO/MLIR and/or vendor libraries
  (cuBLAS, cuDNN, NCCL, and Triton-generated kernels) through a typed FFI —
  rather than hand-authoring tensor-core codegen and autotuning from scratch.
  This buys competitive FLOPS for a fraction of the engineering surface and keeps
  Sailfin *inside* the ecosystem where models are actually trained.

- **Track B — the defensible wedge (capability-typed accelerators).** Extend
  Sailfin's three pillars — effects, capabilities, structured concurrency —
  end-to-end through the tensor graph, the device, and the collective. Make
  `![gpu]` and `![model]` *enforced*; make `PII<T>`/`Secret<T>` taint provably
  bounded through a training/inference graph; make device and multi-node
  orchestration a structured-concurrency nursery with no orphaned kernels; and
  make a produced model artifact carry a capability-sealed record (SFEP-0016) of
  everything it touched. **No incumbent — Mojo, Triton, JAX/XLA, Bend — offers a
  type system that reaches through the accelerator.** That is the novel,
  timeless surface Sailfin can own.

Track A is how we become *fast*. Track B is why anyone *switches*.

## 2. Motivation

### 2.1 The market and the honest gap

Mojo (MLIR-based systems+kernel language), Triton (Python-embedded GPU kernel
DSL), JAX (composable `grad`/`vmap`/`jit` transforms), and XLA/StableHLO (the
tensor compiler underneath) do not compete on syntax. They compete as **array
compilers with three capabilities Sailfin has zero of today**: a shape-aware
tensor IR that *fuses and tiles*, accelerator codegen (GPU/TPU), and automatic
differentiation. A 2026-07 survey of the tree confirms the starting line:

- Backend emits **CPU only** — host default triple plus one Windows MSVC
  cross-triple (`compiler/src/build/target.sfn:55`). No NVPTX/AMDGPU/SPIR-V
  anywhere in `compiler/src/llvm/lowering/` or `emit_native.sfn`.
- `native_ir.sfn` is **scalar-only** — no vector/tensor types, no fusion pass.
- Floats are **f32/f64 only** (`typecheck_types.sfn:1747`). No bf16/fp16/fp8/tf32
  — the numeric substrate of modern training is absent.
- `![gpu]`/`![model]` are **inert taxonomy strings** — parsed, reserved, zero
  detectors (`effect_checker.sfn` has no gpu/model logic;
  `effect_taxonomy.sfn:29`).
- **No autodiff of any kind.**
- `nn`/`tensor`/`layers`/`losses` capsules are real but **CPU scalar-loop,
  forward-pass only** — `matmul` is a naive triple-nested O(n³) loop over
  `float[]` (`capsules/sfn/tensor/src/mod.sfn:224`); no BLAS, SIMD, or backward
  pass. `nn`'s own header states GPU dispatch and training are "planned."

### 2.2 Why the old cost priors do not bind us

The reflex objection is "XLA took a decade and hundreds of engineers." That prior
is measuring the *pre-agentic* cost of the labor-bound work: backend plumbing,
op-coverage breadth, lowering boilerplate, and the enormous test surface. A
disciplined agentic engineering pipeline compresses exactly that class of work by
a large factor — it is mechanical, spec-drivable, and verifiable. What it does
**not** compress is (a) picking the right architecture and (b) the correctness
bar: a miscompiled gradient is still a miscompiled gradient, and a capability
type-system hole is still a hole. So the binding constraints shift from *headcount
and time* to *design judgment and verification rigor* — which is a level playing
field, and one where a small team with a coherent thesis can now credibly ship
what previously required an org. This SFEP is written in that posture:
**ambitious on scope, uncompromising on correctness, and deliberately
architecture-first so the compressible work stays compressible.**

### 2.3 Why now, and why this is on-brand rather than a dilution

`CLAUDE.md` warns against diluting the three pillars with half-finished AI
features and against chasing 6-month-half-life API wrappers. Track B honors that
warning by construction: it is not an AI-syntax land-grab, it is the **existing
pillars pointed at ML**. And a key foundation is in place — **SFEP-0038 (generic
constraints + monomorphization) is `Implemented` for pointer-width `T`**
(int/float/bool/string/ptr and boxed struct references), which is enough to begin
a *typed* `Tensor<T, [dims]>` surface over existing scalar dtypes. Two generics
follow-ons remain and are on the critical path here — **by-value aggregate `T`
layout** and **generic collections** (`draft-generic-collections`) — but the
constraint/monomorphization machinery itself is no longer the blocker. This is the
moment the rest becomes buildable.

## 3. Design

The architecture spine is a new **tensor IR tier** inserted between typecheck and
the existing scalar `native_ir`, with two lowering exits (Track A) and a
type-system extension that spans it (Track B).

```
 AST → typecheck(+effects, +low-precision floats) → Tensor IR (shape-typed) ──┬─▶ StableHLO / MLIR  ─▶ XLA/vendor runtime   (Track A, primary)
                                                     [fusion, autodiff]        ├─▶ vendor-FFI kernels (cuBLAS/cuDNN/NCCL,   (Track A, pragmatic)
                                                                              │    Triton-emitted PTX) via typed extern
                                                                              └─▶ scalar native_ir ─▶ LLVM ─▶ CPU           (reference / self-host, exists today)
```

### 3.1 Track A — the interop backend (become fast without rebuilding XLA)

1. **Numeric substrate.** Add real `bf16`, `f16`, `fp8` (e4m3/e5m2), and `tf32`
   to the type system, lowering, and runtime, with explicit mixed-precision
   accumulation rules. (Own SFEP; extends the sized-int/float work.)
2. **Shape-typed Tensor IR.** A tier above `native_ir` carrying dtype + static
   (and later dynamic) shape, elementwise/reduction/contraction/broadcast ops,
   and layout. This is the *only* place a fusion pass can live — unfused scalar
   loops are 10–100× off, which is the entire reason XLA/Triton exist.
3. **Substrate lowering.** Emit **StableHLO** (portable, versioned) as the
   primary exit so we inherit XLA's fusion/tiling/layout and its CPU/GPU/TPU
   backends; provide a **vendor-FFI** exit (typed extern bindings to
   cuBLAS/cuDNN/NCCL and Triton-emitted kernels) for hot paths and for
   deployments that can't take an XLA dependency.
4. **Autodiff.** Reverse-mode AD as a transform over the Tensor IR (JAX/Enzyme
   shaped), composing with fusion. Training needs this; it must be an IR pass,
   not a runtime tape, to stay fast.
5. **Distribution.** Collectives (all-reduce/all-gather/reduce-scatter) and
   sharding annotations, lowered to NCCL/RCCL or StableHLO's collective ops.

```sfn
// Illustrative Track-A surface (typed tensors on the generics that already shipped)
fn attention(q: Tensor<bf16, [B, H, S, D]>,
             k: Tensor<bf16, [B, H, S, D]>,
             v: Tensor<bf16, [B, H, S, D]>) -> Tensor<bf16, [B, H, S, D]> ![gpu] {
    let scores = matmul(q, transpose(k)) |> scale(1.0 / sqrt(D as float));
    return matmul(softmax(scores), v);   // lowers to StableHLO; XLA fuses the chain
}
```

### 3.2 Track B — capability-typed accelerators (why anyone switches)

Track B is the differentiator, and each piece is a *real enforcement* upgrade of a
pillar that is currently inert for ML:

- **`![gpu]` / `![model]` become enforced.** Wire detectors in
  `effect_checker.sfn` so any tensor op that dispatches to a device requires
  `![gpu]`, and any model-engine call requires `![model]` — with spans and
  fix-its, exactly like the shipped `io`/`net` detectors. "Reserved string" → real
  capability gate.
- **Taint that reaches through the graph.** `PII<T>`/`Secret<T>` (today
  parsed-only) become enforced *along tensor dataflow*: a kernel or collective
  that would move tainted data off-device, into a log, or across a `![net]`
  boundary fails to compile. This is confidential-compute and data-governance as a
  *type error*, which no incumbent offers.
- **Structured concurrency over devices and nodes.** Extend the `routine {}`
  nursery (pillar 3) to GPU streams and multi-node ranks: join-all semantics, no
  orphaned kernels, cancel-on-fault across a collective. Distributed training as a
  structured-concurrency program rather than a pile of async callbacks.
- **Capability-sealed model artifacts.** A produced model carries a sealed record
  (SFEP-0016) of the effects/capabilities it exercised — an auditable,
  supply-chain-verifiable provenance manifest for the trained artifact.

```sfn
// Illustrative Track-B guarantee: taint is bounded through the accelerator
fn train_step(batch: PII<Tensor<bf16, [B, D]>>, w: Tensor<bf16, [D, D]>)
    -> Tensor<bf16, [D, D]> ![gpu, model] {
    let logits = matmul(declassify_for_training(batch), w);  // explicit, audited
    // print.info(batch)  // ← would be E-taint: PII may not cross ![io]
    return grad(loss)(w);
}
```

### 3.3 Sequencing (each is a child SFEP, gated independently)

`bf16/fp8 numerics` → `Tensor IR + fusion` → `StableHLO exit` (+ vendor-FFI exit)
→ `enforced ![gpu]/![model]` → `autodiff` → `taint-through-graph` → `collectives +
device nurseries` → `sealed artifacts`. The numeric and Tensor-IR tracks unblock
everything; enforcement (Track B) can proceed in parallel with autodiff once the
Tensor IR exists.

## 4. Effect & capability impact

This is the center of gravity, not an afterthought:

- **New enforcement, not new effects.** `gpu` and `model` stay in the canonical
  six (`effect_taxonomy.sfn`); this SFEP makes them *checked*. Effect lists stay
  alphabetical (`![gpu, model, net]`).
- **Taint enforcement extends to tensor dataflow.** `PII<T>`/`Secret<T>` gain
  real propagation and barrier diagnostics along the Tensor IR, with an explicit,
  audited `declassify_*` escape. New E-codes to be allocated from an unused range
  at child-SFEP time (grep the range first, per `code-style.md`).
- **Capability manifests gain a device/collective axis.** A capsule's
  `capabilities` may scope which devices/collectives it may touch, enforced at the
  workspace envelope (SFEP-0051).
- **Self-host invariant is untouched by design** (see §5).

## 5. Self-hosting impact

Passes touched (across child SFEPs): `typecheck_types.sfn` (low-precision
floats), a new Tensor IR module + fusion/autodiff passes, `effect_checker.sfn`
(gpu/model/taint detectors), and new lowering exits (StableHLO emitter +
vendor-FFI). **Crucially, self-hosting is not at risk: the Sailfin compiler is not
a tensor program.** The accelerator path exists for *user* code; the compiler
continues to compile itself through the existing scalar `native_ir` → LLVM → CPU
route. `make compile` remains the gate and does not require a GPU. Track A's
substrate dependency (XLA/vendor libs) is a *runtime* dependency of compiled ML
programs, never of the bootstrap — preserving `bootstrap.toml`/seed discipline and
the SFEP-0015 toolchain-independence trajectory for the compiler itself.

## 6. Alternatives considered

1. **Full from-scratch tensor compiler (the "beat XLA" path).** Rejected as the
   *primary* path: it re-opens tensor-core codegen and autotuning every hardware
   generation and is the exact dilution `CLAUDE.md` warns against. Track A's
   vendor-FFI exit keeps a *narrow* native-kernel option for hot paths without
   betting the strategy on it.
2. **MLIR-native middle-end (Mojo's bet) instead of StableHLO emit.** Deferred,
   not rejected — a heavier substrate coupling; StableHLO gives portability with a
   smaller surface first, and an MLIR exit can be added later.
3. **Do nothing — keep AI a pure post-1.0 library concern.** Honest and
   charter-compliant, but forfeits the one ML surface (capability-typed
   accelerators) that is *uniquely* Sailfin's and timeless. Track B is the reason
   to act now rather than later.
4. **Runtime-tape autodiff (PyTorch eager style).** Rejected for the compiled
   path: it doesn't compose with fusion and leaves performance on the table;
   IR-level AD is the correct altitude.

## 7. Stage1 readiness mapping

This is a strategy umbrella; readiness is tracked per child SFEP, not here. As of
this draft, the whole slate is pre-implementation:

- [ ] Parses — (typed-tensor surface builds on shipped generics, SFEP-0038)
- [ ] Type-checks / effect-checks — new floats, enforced `![gpu]`/`![model]`, taint
- [ ] Emits valid `.sfn-asm` — Tensor IR tier + scalar reference path
- [ ] Lowers to LLVM IR / StableHLO / vendor-FFI
- [ ] Regression coverage — see §8
- [ ] Self-hosts — preserved by construction (§5); compiler stays CPU
- [ ] `sfn fmt --check` clean
- [ ] Documented in `docs/status.md` + spec/preview

## 8. Test plan

Per child SFEP, but the shape: numeric-precision unit tests (bf16/fp8 round-trip,
mixed-precision accumulation); Tensor IR + fusion snapshot tests
(`expect_snapshot`); effect-enforcement negatives (`assert_does_not_compile` that
a device op without `![gpu]` and a `PII<T>` crossing `![io]` are rejected with the
right E-codes); autodiff correctness against finite-difference references; a
StableHLO golden-emit e2e; and a CPU-reference numerical-equivalence e2e so the
scalar path stays a trustworthy oracle. All native `*_test.sfn` (no bash e2e).

## 9. References

- Survey ground truth (2026-07-19): `compiler/src/build/target.sfn:55`,
  `compiler/src/native_ir.sfn`, `compiler/src/typecheck_types.sfn:1747`,
  `compiler/src/effect_taxonomy.sfn:29`, `compiler/src/effect_checker.sfn`,
  `capsules/sfn/{tensor,nn,layers,losses}/src/mod.sfn`, `docs/status.md`.
- SFEP-0038 — Generic Constraints and Monomorphization (`Implemented`; the
  unblocking foundation for typed tensors).
- SFEP-0024 — Model Engines, Adapters, Tensors, Training (`Draft`; the library
  surface this backend serves).
- SFEP-0016 — The Capability-Sealed Runtime (sealed model artifacts).
- SFEP-0015 — Toolchain Independence (compiler-side backend trajectory; Track A's
  substrate dependency is runtime-only, not bootstrap).
- SFEP-0051 — Workspace Manifest / capability envelope (device/collective axis).
- `CLAUDE.md` — three-pillars charter, "libraries over keywords," "chase timeless
  problems."
- Prior art: OpenXLA/StableHLO, JAX (`grad`/`vmap`/`pjit`), Triton, Mojo/MLIR,
  Enzyme (IR-level autodiff), NCCL/RCCL, GSPMD/`shard_map`.
