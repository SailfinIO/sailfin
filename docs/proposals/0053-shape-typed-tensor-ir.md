---
sfep: 0053
title: Shape-Typed Tensor IR and Fusion
status: Accepted
type: tooling
created: 2026-07-19
updated: 2026-07-19
author: "agent:compiler-architect; project owner direction"
tracking: "#2485, SFN-424, SFN-427, SFN-429"
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0053 — Shape-Typed Tensor IR and Fusion

## 1. Summary

Sailfin will add a shape-typed, SSA-like tensor IR between successful frontend
checking and the scalar `native_ir`. Tensor values carry a dtype, static logical
shape, and layout; tensor operations cover elementwise computation, reductions,
contractions, broadcasting, and layout transforms. A verifier and a
producer-consumer fusion pass operate only at this tier. Tensor IR has two
exits: a scalar-reference lowering into `native_ir` for a deterministic CPU
oracle, and a version-pinned StableHLO emitter as the first production
accelerator boundary. Sailfin will not adopt a native MLIR middle-end initially.

## 2. Motivation

The current compiler lowers a checked AST directly into scalar `.sfn-asm`
described by `native_ir.sfn`. At that level, tensor identity, rank, broadcast
dimensions, reduction axes, and contraction structure have already become
scalar control flow and indexing. Recovering them is unreliable, and fusing
their scalar loops is too late to preserve the algebraic facts required for
accelerator lowering.

Conversely, placing tensor fusion in the AST or typechecker would mix execution
planning with source-language validation. It would also make transformations
depend on syntax rather than typed dataflow: two equivalent expressions could
receive different optimization simply because they were written differently.

The missing tier must therefore satisfy three needs at once:

- retain dtype, shape, layout, and source provenance after typechecking;
- provide a small, verified operation set on which fusion is semantics
  preserving; and
- preserve the existing CPU and self-host paths while accelerator substrate
  work proceeds independently.

This is the architectural fork identified by SFEP-0052 §3.1(2). Choosing the
IR boundary and its first exit now prevents the scalar backend, StableHLO work,
autodiff, and later device enforcement from growing incompatible tensor models.

## 3. Design

### 3.1 Pipeline and module boundary

The compiler pipeline becomes:

```text
parse -> typecheck/effect-check -+-> scalar declarations -> emit_native -> native_ir -> LLVM
                                 |
                                 +-> tensor functions -> build -> verify -> fuse -+-> StableHLO
                                                                                  |
                                                                                  +-> scalar-reference lower -> native_ir -> LLVM
```

The insertion point is after type and effect diagnostics have succeeded and
immediately before `emit_native`. Scalar-only declarations continue directly
to `emit_native`; tensor-bearing functions are first built and verified as
tensor IR. The selected tensor exit then either emits StableHLO or produces a
`NativeModule` that is combined with the ordinary scalar module before LLVM
lowering. No tensor analysis is reconstructed from `.sfn-asm`.

The implementation will introduce these modules above `native_ir.sfn`:

- `compiler/src/tensor_ir.sfn` — IR value, type, operation, region, attribute,
  and source-provenance definitions;
- `compiler/src/tensor_ir_build.sfn` — checked AST to tensor IR construction;
- `compiler/src/tensor_ir_verify.sfn` — dtype, rank, dimension, layout, and
  dominance verification;
- `compiler/src/tensor_ir_fusion.sfn` — fusion legality, grouping, and rewrite;
- `compiler/src/tensor_ir_lower_scalar.sfn` — reference lowering to
  `native_ir`; and
- `compiler/src/tensor_ir_emit_stablehlo.sfn` — the separately gated
  StableHLO exit.

The first implementation issue may stage only the core IR, verifier, and scalar
lowering. Module ownership and pass order are fixed here even when a later
module is initially an empty boundary.

### 3.2 Program and value model

Tensor IR is in-memory compiler state, not a new source syntax or a replacement
for `.sfn-asm`. A `TensorModule` owns typed functions. A `TensorFunction` owns
parameters, blocks, operations, return values, declared effects, and source
provenance. Values are immutable SSA results identified within their function;
operations explicitly name their operands and result types. Control-flow and
side-effecting scalar code remain outside the initial tensor graph.

Conceptually, the core records are:

```text
TensorType {
    dtype: TensorDType,
    shape: TensorDim[],
    layout: TensorLayout,
}

TensorDim = Static(positive integer)

TensorLayout = Dense {
    minor_to_major: integer[],
}

TensorOp {
    kind: TensorOpKind,
    operands: TensorValueId[],
    results: TensorType[],
    attributes: TensorAttributes,
    provenance: SourceSpan,
}
```

Rank-zero tensors are valid scalar tensors and have an empty shape. Static
dimensions are positive and must fit the compiler's checked dimension range;
zero-sized tensors are deferred until their reduction and runtime semantics are
specified. `minor_to_major` is a permutation of every rank dimension. Logical
shape is independent of physical order, so transpose and reshape rules do not
silently redefine a type's dimensions.

`TensorDType` initially contains `Pred`, `I8`, `I16`, `I32`, `I64`, `U8`,
`U16`, `U32`, `U64`, `F32`, and `F64`. Source `bool`, `int`, and `float`
normalize to `Pred`, `I64`, and `F64`; target-width `isize`/`usize` are excluded
because tensor artifacts must not change element width with the host. A dtype
is enabled only when the frontend, scalar oracle, and selected production exit
all support it. Low-precision variants become legal when their governing SFEP
is implemented. The enum is not a free-form string, so adding variants does
not change operation structure. Tensor values never contain pointer, string,
object, capsule, or function types.

Dynamic shape is an intentional extension point, not an implicit wildcard.
A later SFEP may add `TensorDim.Dynamic(symbol, bounds)` plus explicit shape
operands and guards. The initial verifier rejects every non-static dimension,
and no value may use an unknown sentinel such as `-1`. This keeps the first
fusion legality rules decidable from the IR alone.

### 3.3 Operation set

The first operation set is deliberately algebraic and closed. Each operation
has fully typed results; implicit broadcasting and implicit dtype promotion are
forbidden in the IR even if the source surface offers them.

| Family | Operations | Required invariants |
|---|---|---|
| Graph | `parameter`, `constant`, `return` | Constants match result dtype and element count; returns match the function signature. |
| Elementwise | unary, binary, compare, select, convert | Tensor operands have identical shapes; binary dtype rules are explicit; compare returns bool; convert names its destination dtype. |
| Reduction | `reduce` | Axes are unique and in range; identity and combiner are explicit; result shape removes or retains reduced axes as declared. |
| Contraction | `dot_general` | Batch and contracting dimensions are explicit, disjoint, and pairwise equal; result dimension order is canonical. |
| Broadcast | `broadcast_in_dim` | The dimension map is sorted, unique, in range, and maps equal source/result extents. |
| Layout | `reshape`, `transpose`, `slice`, `concatenate`, `pad`, `copy` | Element counts, permutations, bounds, join dimensions, padding, and destination layout verify statically. |

Unary and binary operation codes are enums with a per-dtype legality table,
not arbitrary callee names. `reduce` carries a closed combiner code in the
initial IR; arbitrary regions are deferred. `dot_general` is the single
contraction primitive and covers matrix multiplication, batched matrix
multiplication, and higher-rank contractions without adding source-shaped op
variants.

Operation attributes contain only semantic facts needed by all exits. Device,
stream, tiling, kernel-launch, StableHLO, or vendor-specific attributes do not
belong in the core IR. Exit-specific planning must either derive them or use a
separate backend representation.

### 3.4 Verification

Construction does not establish validity by itself. `tensor_ir_verify.sfn`
runs after construction and after every transforming pass. It rejects:

- values used before definition, cross-function value IDs, or result arity
  mismatches;
- unsupported dtypes, dynamic or invalid dimensions, and dimension-product
  overflow;
- malformed layouts or an operation whose declared result type does not follow
  its shape rule;
- implicit dtype conversion, broadcast, or layout change;
- tensor calls whose parameter or result types disagree; and
- fusion regions containing non-fusible operations or values that escape
  without being declared as region results.

Diagnostics retain the originating source span where one exists. Failures
introduced by a compiler transform are internal compiler errors with a printed
IR location; failures attributable to source typing remain frontend
diagnostics and must be caught before IR construction.

### 3.5 Fusion model

Fusion is a deterministic producer-consumer graph rewrite over verified tensor
IR. It forms a `FusionRegion` with explicit inputs and outputs; contained
operations retain their original types and provenance. Fusion changes where
intermediate values materialize, not the mathematical operation order, dtype,
rounding mode, reduction tree, or observable effects.

The initial pass proceeds in block order and grows regions from consumers toward
their producers. An edge is fusible only when all of these hold:

1. producer and consumer are pure tensor operations in the same block;
2. their shapes and layouts satisfy the operation-specific legality rule;
3. fusion does not duplicate a producer with another external consumer;
4. the producer is not a function parameter, constant requiring external
   storage, region result, or explicit `copy`; and
5. a deterministic cost guard does not predict greater live storage or code
   duplication than the unfused graph.

Elementwise chains and elementwise producers feeding a single reduction or
contraction are the first required patterns. Broadcasts, converts, reshapes,
and transposes may join a region only when they are view-like for the selected
layout or can be expressed as index maps without an intervening copy.
Reductions and contractions are fusion roots in the initial pass; two such
roots are not fused together. `copy`, non-view layout conversion, function
calls, control-flow boundaries, and every effectful operation are barriers.

The pass does not reassociate floating-point operations or invent fast-math
semantics. A later numerical-mode proposal may authorize those rewrites
explicitly. StableHLO consumers remain free to perform additional legal target
fusion and tiling; Sailfin's pass provides target-independent graph
canonicalization and a testable fusion contract, not a replacement for XLA or
IREE optimization.

Fusion profitability is policy, while fusion legality is semantics. The two
must be separate functions so tuning thresholds cannot make an invalid region
valid. Region ordering and printed form are stable for snapshot tests.

### 3.6 Scalar-reference lowering

Every core operation must have scalar-reference semantics before it may be
enabled for an accelerator exit. `tensor_ir_lower_scalar.sfn` expands verified
tensor operations into ordinary `native_ir` loops, indexing, scalar arithmetic,
and storage operations. It prioritizes clarity and determinism over performance
and is the CPU oracle for backend equivalence tests.

The reference lowering accepts fused and unfused IR but produces the same
observable result for both; it may expand a `FusionRegion` directly without
allocating internal intermediates, or conservatively lower its component
operations. This path is not the production CPU tensor optimizer.

Scalar and tensor code coexist per module. Existing scalar functions take the
unchanged AST-to-`native_ir` route. Tensor functions selected for reference
execution lower into a `NativeModule`, which is combined at the existing module
boundary before LLVM lowering. Calls across that boundary use one canonical
tensor buffer descriptor defined by the implementation SFEP or design gate;
the core tensor IR does not expose backend-owned pointers.

### 3.7 Substrate exit decision

Sailfin will emit version-pinned StableHLO as its first production tensor
substrate boundary. It will not embed MLIR as the compiler's native middle-end
in the first Track A implementation.

StableHLO is the narrower and more durable contract:

- its portable operation and compatibility model matches this IR's algebraic
  level without exposing Sailfin to MLIR pass-manager, dialect-registration,
  C++ ABI, or ownership details;
- one emitted artifact can be consumed by established XLA and IREE toolchains,
  preserving a CPU/GPU/TPU choice outside the self-hosted compiler;
- textual emission and golden verification can be implemented in Sailfin,
  while a pinned external validator catches dialect drift; and
- the boundary keeps MLIR and accelerator libraries out of compiler bootstrap.

StableHLO is an interchange dialect, not a complete optimizer or runtime.
Deployments still choose and pin a compatible consumer, and Sailfin must record
the StableHLO compatibility version in the artifact. Unsupported core
operations fail closed at emission rather than falling through to textual
custom calls. Vendor calls, when later approved, use an explicit typed escape
path and are not disguised as core StableHLO.

StableHLO receives logical tensor semantics, not Sailfin's physical-layout
promise. The emitter represents semantic transposes and reshapes explicitly,
then permits the downstream compiler to select physical layout. A Sailfin
layout constraint that cannot be preserved that way is rejected by this exit;
it must not be encoded as an undocumented StableHLO custom call. The scalar
oracle still honors `minor_to_major` when it computes element addresses.

A native MLIR middle-end may be reconsidered only when measured requirements
show that StableHLO cannot express a required transformation or that crossing
the boundary prevents material compile-time or runtime quality. That decision
requires a new SFEP covering dialect ownership, dependency distribution,
pass-version compatibility, diagnostics, and bootstrap isolation. It is not an
implementation detail of the StableHLO emitter.

### 3.8 Non-goals

This proposal fixes the representation, fusion contract, scalar oracle, and
first substrate boundary. It does not implement them. It also does not specify
autodiff, dynamic-shape execution, GPU code generation, device scheduling,
collectives, sharding, vendor kernels, or a user-facing tensor API. Those
features may build on this IR only through their own accepted designs and may
not weaken its verification or bootstrap boundaries implicitly.

## 4. Effect & capability impact

This proposal adds no effect name and changes no current capability rule. Core
tensor IR operations are pure. Fusion may operate only on pure operations and
may not move computation across an effectful boundary.

Later device execution will require enforcement of `![gpu]`, and model-engine
operations will require `![model]`, as sequenced by SFEP-0052. Those checks must
be complete before an accelerator exit is presented as shipped. Selecting a
CPU scalar-reference exit does not erase declared effects or authorize a
device operation without its capability. Taint, collectives, and device
placement are outside this proposal and must extend the IR through their own
accepted designs rather than opaque attributes.

## 5. Self-hosting impact

The compiler remains a scalar Sailfin program. Its source does not construct
source-language tensors, so self-compilation continues through the existing
AST-to-`native_ir`-to-LLVM path. Tensor IR modules are ordinary compiler data
structures compiled by that scalar path; creating the representation does not
make the compiler itself a tensor workload.

Neither StableHLO, MLIR, XLA, a GPU, nor vendor libraries may be required to
build or self-host `sfn`. The StableHLO emitter is inert unless user code selects
that exit, and external validation belongs to the targeted backend test gate.
The scalar-reference exit remains available on CPU and is the required oracle.
Implementation changes under `compiler/src/` still must pass `make compile`
before targeted tests, with `make clean-build` when the module graph changes.

## 6. Alternatives considered

### 6.1 Native MLIR middle-end

Rejected as the initial substrate. Operating directly on MLIR would expose a
larger optimization ecosystem and make dialect-to-dialect lowering convenient,
but it couples the self-hosted compiler to MLIR APIs, binary distribution,
version skew, and pass behavior before Sailfin has demonstrated that it needs
that control. StableHLO preserves the option to use MLIR downstream without
making it Sailfin's compiler architecture.

### 6.2 Lower tensors directly to scalar `native_ir`

Rejected as the sole representation. It preserves CPU execution but loses
tensor algebra before fusion and accelerator selection. Scalar lowering is
retained only as a reference exit from the tensor IR.

### 6.3 Emit StableHLO directly from the checked AST

Rejected. It would duplicate shape and operation legality inside the emitter,
leave no substrate-independent home for fusion or autodiff, and make the CPU
oracle validate a different program representation.

### 6.4 Rely entirely on downstream fusion

Rejected. A downstream compiler should perform target-specific fusion, tiling,
and scheduling, but Sailfin still needs a backend-independent contract for
materialization, effect barriers, reference equivalence, and later autodiff.
The deliberately conservative Sailfin pass complements rather than competes
with substrate optimization.

### 6.5 Start with dynamic shapes

Deferred. Dynamic dimensions require shape values, guards, specialization
policy, and failure semantics that would complicate every operation and fusion
rule. A static-only first IR is useful for the foundational workloads and leaves
an explicit, non-sentinel extension point.

## 7. Stage1 readiness mapping

SFEP-0053 is Accepted design, not an implementation claim. All Stage1 items
remain pending for the implementation issues:

- [ ] Parses — tensor source surface and static shapes are accepted.
- [ ] Type-checks / effect-checks — dtype, shape, and capability rules are
  enforced before IR construction.
- [ ] Emits valid `.sfn-asm` — scalar-reference lowering covers the core op set.
- [ ] Lowers to LLVM IR — reference programs execute through the CPU backend.
- [ ] Regression coverage — verifier, fusion, reference, and exit tests pass.
- [ ] Self-hosts — the compiler rebuilds without an accelerator dependency.
- [ ] `sfn fmt --check` clean — every added `.sfn` module is formatted.
- [ ] Documented in `docs/status.md` + spec — status changes only when behavior
  ships; any user-visible tensor surface graduates to preview/spec docs.

The SFEP remains `Accepted` until every applicable item is complete end to end.

## 8. Test plan

Implementation issues must add Sailfin-native tests at the narrowest layer:

- unit tests for every operation's dtype, shape, layout, and invalid-dimension
  verifier rules;
- deterministic IR snapshots before and after fusion, including multi-use,
  copy, layout, contraction, reduction, effect, and control-flow barriers;
- property-style equivalence cases that lower fused and unfused graphs through
  the scalar reference exit and compare exact integer/bool results plus
  tolerance-bounded floating results;
- integration tests that combine scalar functions and tensor functions in one
  module and exercise calls across their boundary;
- StableHLO golden output plus validation by the pinned StableHLO toolchain,
  including explicit rejection of unsupported operations and versions; and
- `make compile` without StableHLO, MLIR, XLA, GPU, or vendor libraries present.

Numerical equivalence tests must include broadcasting, all supported reduction
axes, batched contraction, transpose/reshape chains, conversion, and layouts.
Accelerator tests compare against the scalar oracle; they do not replace it.

## 9. References

- [SFEP-0052 — Accelerated ML strategy](./0052-ml-acceleration-strategy.md),
  especially §3.1(2) and Alternative 2.
- [SFEP-0001 — SFEP purpose and process](./0001-sfep-process.md).
- [SFEP-0015 — Toolchain independence](./0015-llvm-independence.md).
- [SFEP-0024 — Model engines and training](./0024-model-engines-and-training.md).
- Linear SFN-424 — this design gate.
- Linear SFN-427 — tensor IR skeleton and scalar-reference lowering.
- Linear SFN-429 — StableHLO emitter spike.
- OpenXLA StableHLO compatibility and specification documentation.
- Prior art: XLA HLO fusion, MLIR `tensor`/`linalg` dialects, JAX/XLA tracing,
  and IREE's StableHLO input pipeline.
