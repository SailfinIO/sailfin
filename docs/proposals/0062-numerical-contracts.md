---
sfep: 0062
title: Numerical and Behavioural Contracts (the Result Pillar)
status: Accepted
type: language
created: 2026-07-26
updated: 2026-07-26
author: "agent:compiler-architect; human review"
tracking:
supersedes:
superseded-by:
graduates-to: reference/preview/numerical-contracts.md
---

# SFEP-0062 — Numerical and Behavioural Contracts (the Result Pillar)

## 1. Summary

Sailfin will **derive** a machine-checked contract about what a function
computes, emit it as a versioned artifact, and fail the build when a declared
obligation exceeds what the derivation supports. A contract adopts the
eight-part vocabulary of *Kernel Contracts* (arXiv 2604.22032) — identifier,
scope, precondition, postcondition, tolerance, reference oracle, measurement
protocol, violation signature — and extends it with three fields that paper
leaves out (`provenance`, `derivation`, a promoted `determinism_class`). The
inversion is the design: in the paper a human writes the contract and a test
measures it; in Sailfin **the compiler writes the contract from facts it already
holds** (exact dtype, accumulator dtype, static op count, reduction order,
fusion decisions, effect row) and the human writes only the accuracy budget and
the claims the compiler cannot know. Surface syntax is the existing decorator
grammar — `@contract(determinism: bitwise, ...)` — so no keyword is spent and no
parser change is required. The artifact is JSON with a `schema_version`, written
beside the existing per-capsule sidecar, and is designed to be consumed by a
validator that does not use Sailfin.

## 2. Motivation

The *why* is `docs/strategy/decision-brief.md` §2 (proof, not binaries), §3
(restriction-vs-power), §4 Pillar 2, and §7.2–7.3; the evidence is
`docs/strategy/market-evidence-2026-07.md` §8. Neither is restated here. Three
consequences bind this design:

1. **The demand is revealed, not surveyed.** Practitioners surrender 34–61% of
   inference throughput for bit-identical output (evidence §8). A contract that
   states *and proves* a determinism class is a power, not a restriction: the
   payer receives the artifact.
2. **The specification already exists and nobody implemented it.** The window is
   months, not years. Adopting the published vocabulary is worth more than a
   better vocabulary of our own (§3.10, Alternative 6.5).
3. **The strongest claim in the repo is currently unenforced.** SFEP-0054 §3.2
   requires exact dtype identity — `f16 != bf16` — and
   `compiler/src/typecheck_types.sfn:1130-1135` returns the shared `"float"`
   kind for `f16`, `bf16`, `f32`, `f64`, and `number` alike. So `f16 + bf16`
   typechecks today. Two storage carriers shipped; the contract did not.

What makes this tractable rather than aspirational is that Sailfin already holds
the derivation inputs *structurally*, and holds several of them **more exactly
than the scalar tier does**:

| Derivation input | Where it already lives, exactly |
|---|---|
| dtype identity | `TensorDType` enum, `compiler/capsules/ir/src/tensor_ir.sfn:8-20` — a closed enum, not a coarse string |
| static op count | `TensorType.shape`, `tensor_shape_product` (`tensor_ir.sfn:145`) — static per SFEP-0053 §3.2 |
| reduction order | SFEP-0053 §3.5: fusion "does not reassociate floating-point operations"; the scalar exit is strictly ordered |
| no fast math | verified: no `-ffast-math`, `nnan`, `ninf`, `reassoc`, or `contract` flag is emitted anywhere in `compiler/src/` or `runtime/`; link uses plain `-O2` (`compiler/src/build/link.sfn:357`) |
| nondeterminism sources | the effect row — `clock`, `rand`, `net`, `io`, `gpu`, `model` — plus concurrency-primitive leaves (SFEP-0049) |
| a bit-exact CPU oracle | `tensor_ir_lower_scalar.sfn` + `tensor_ir_link_harness.sfn`, already verified to relative error ≤ 1e-12 (`docs/status.md`, SFN-447) |
| a versioned JSON sidecar | `capsule_artifact.sfn:246`, `schema_version: "1"` |

Nothing in the list requires a GPU, MLIR, StableHLO, or a vendor library.

## 3. Design

### 3.1 What a contract is

A contract is a record with two halves.

- **Derived facts.** Computed by the compiler from the program. The author
  writes nothing. Tolerance, reference-oracle identity, op count, dtype and
  accumulator chain, reduction order, denormal/NaN/out-of-bounds policy,
  determinism class, and provenance are all derived.
- **Declared obligations.** What the author *claims*. The compiler checks the
  claim against the derived facts. A claim weaker than the facts is legal
  (slack is intentional, per the paper's §3.3 note). A claim **stronger** than
  the derived facts can support is a compile-time error.

This asymmetry is the whole enforcement model, and it is what satisfies the
restriction-vs-power test: the power is the artifact you receive for free; the
only restriction is that you may not claim more than your program earns.

### 3.2 Surface syntax

The existing decorator grammar already parses named arguments
(`compiler/capsules/syntax/src/parser/declarations/syntax.sfn`; `Decorator` /
`DecoratorArgument` in `compiler/capsules/syntax/src/ast.sfn:302-310`). A contract attaches
there:

```sfn
// Declared obligation. Everything else in the record is derived.
@contract(determinism: bitwise)
fn score(logits: float[]) -> float {
    // ...
}

@contract(
    determinism: bitwise,
    tolerance: relative(1.0e-6),   // may only be LOOSER than the derived bound
    nan: ieee_propagate,
    oob: raise
)
fn attention_reference(q: float[], k: float[], v: float[]) -> float[] {
    // ...
}
```

Three deliberate choices:

- **Decorator, not a new keyword.** A `contract { }` block would match the
  paper's own grammar, but CLAUDE.md is explicit that a keyword can never become
  a variable name, and `contract` is a common identifier (it is already a local
  in `compiler/src/build/direct_link.sfn:263`). Rejected — see §6.2.
- **Attaches to a function.** A function is the unit that has a signature, a
  dtype chain, a body the compiler analyses, and a stable symbol identity for
  the record's `identifier`. Tensor *ops* are too fine (their contract is
  derived, never declared) and capsules too coarse.
- **Capsule-level defaults in `capsule.toml`.** A new `[capsule.numerics]`
  table carries `accuracy_budget` and `default_determinism`, because an accuracy
  budget is a project policy, not a per-function fact. Per-function `@contract`
  narrows it; it may not widen it (`E1104`).

`@contract` is a compiler-recognized builtin decorator name, registered
alongside the existing built-ins in `compiler/src/decorator_resolver.sfn:83-90`.
It contributes **no effect** (§4).

### 3.3 Contract fields

`ContractRecord` in a new `compiler/src/contract/` folder module. Types are
given as Sailfin shapes; `D` = derived, `A` = author-declared, `A→D` = declared
and checked against derived.

| # | Paper part | Sailfin field | Type | Origin |
|---|---|---|---|---|
| 1 | identifier | `id` | `string` — `<scope>/<name>::<module>::<fn>` | D |
| 1 | — | `class` | `ContractClass` enum — `CPrc01`…`CExc02` (§3.5) | D |
| 2 | scope | `scope` | `OpClass[]` enum — `Matmul`, `Reduction`, `Elementwise`, `Softmax`, `Indexing`, `Scalar` | D from op kinds |
| 3 | precondition | `pre` | `Precondition { dtypes: TensorDType[], shape: ShapeClass, value_range: ValueRange, env: EnvPredicate }` | D except `value_range` (A) |
| 4 | postcondition | `post` | `PostRelation` enum — `ElementwiseClose`, `BitwiseIdentical`, `DeclaredPolicy`, `Raises` | D |
| 5 | tolerance | `tolerance` | `Tolerance { rel: float, abs: float, ulp: int, denominator: DenomConvention }` | **D**, A→D only to loosen |
| 6 | reference oracle | `oracle` | `Oracle { kind: HigherPrecision \| Algebraic \| AlternateExit \| Spec, identity: string, build_hash: string }` | D |
| 7 | measurement protocol | `measure` | `Protocol { input_gen: InputGen, samples: int, statistic: Statistic, pass_rule: PassRule }` | D from class; `samples` A |
| 8 | violation signature | `violation` | `ViolationSignature { pattern: string, concentrates_at: string }` | D from the class table |
| **9** | *(extension)* | `provenance` | `Provenance { source_span, capsule_version, compiler_version, toolchain_pin, seed_version, target_triple }` | D |
| **10** | *(extension)* | `derivation` | `Derivation { formula_id: string, inputs: DerivationInput[], value: float }` | D |
| **11** | *(promoted)* | `determinism_class` | `Determinism` enum — `Bitwise`, `RunToRun(float)`, `None` | D, A→D |

Fields 9–11 are §3.10's extensions and are argued there.

### 3.4 Tolerance derivation

The tolerance is never a magic number. `compiler/src/contract/tolerance.sfn`
computes it, and `Derivation` records the computation so a reader can audit it.

**Unit roundoff** `u(P)` is a closed table over stored fraction bits — `f64`
2⁻⁵³, `f32` 2⁻²⁴, `tf32` 2⁻¹¹, `f16` 2⁻¹¹, `bf16` 2⁻⁸, `fp8e4m3fn` 2⁻⁴,
`fp8e5m2` 2⁻³ — matching SFEP-0054 §3.1.

**Reduction / contraction of length `N`**, input dtype `P`, accumulator dtype
`A`, sequential order:

```text
gamma(N, A) = N * u(A) / (1 - N * u(A))
tolerance.rel = gamma(N, A) + 2 * u(P)
formula_id    = "dot-backward-error-v1"
```

`N` comes from the static contracting-dimension product — this is where
SFEP-0053's static shapes are load-bearing (see §3.11, pushback 1). When the
reduction tree is pairwise rather than sequential, `N` is replaced by
`ceil(log2 N)` and `formula_id` becomes `dot-backward-error-pairwise-v1`; the
tree is a derived fact, not an assumption. If `N * u(A) >= 1/2` the derivation
is numerically meaningless and the build **fails closed** with `E1101` rather
than emitting a bound nobody should trust.

**Denominator convention is stated explicitly.** `tolerance.rel` is relative to
`sum |x_i * y_i|`, not to `|exact result|`. Relative-to-result is unusable under
cancellation, and a contract that silently picks the flattering denominator is
the circularity the paper's §3.3 warns about. Catastrophic cancellation is
therefore a *separate* contract class (`C-PRC-02`), exactly as in the paper.

**Elementwise** ops take `tolerance.rel = u(result_dtype)`, or `ulp = 0` when
the operation is exact in the destination format.

**Composition along a fused path** is computed by walking the tensor-IR DAG and
summing component bounds with their amplification factors. This is the
compiler's structural advantage: it knows the numerical path, so it does not
have to guess a blanket epsilon for the composite.

**Declared tolerance** may only be ≥ the derived value. A tighter declaration is
`E1104`: the program does not earn it. A declaration looser than
`[capsule.numerics] accuracy_budget` is also `E1104`.

### 3.5 The twelve classes, and where each is enforced

This table is the roadmap. It is deliberately honest about the four classes
Sailfin does not address.

| Class | Sailfin enforcement locus | Phase |
|---|---|---|
| `C-PRC-01` accumulator preservation | **Static.** Typecheck (`E0913`, SFEP-0054 §3.6: accumulator never narrower than `f32`) + tensor verifier asserts no pass narrows `accumulator_dtype` (`E1105`) | 4 |
| `C-PRC-02` cancellation avoidance | **Measured.** Library-level (`sfn/tensor` softmax/variance) against a stable-algorithm oracle | 3 |
| `C-PRC-03` denormal declaration | **Static.** SFEP-0054 §6.6 forbids FTZ as the portable default, so `denormals: preserve` is derived unconditionally; a backend that cannot honour it is `E0915` fail-closed | 2 |
| `C-PRC-04` mixed-precision scaling invariance | **Out of scope, named.** The paper itself marks its 10⁻³ tolerance a placeholder pending unperformed calibration. Recorded as `unsupported: uncalibrated upstream` | — |
| `C-ORD-01` reduction-order tolerance bound | **Derived bound + measured across exits.** The scalar exit is bitwise by construction | 2 |
| `C-ORD-02` atomic determinism class | **Static for the CPU path** — discharged from the effect row (§4). Measured for device exits | 1 (CPU), 5 (device) |
| `C-ORD-03` communication overlap | **Not applicable, recorded.** Sailfin has no collectives | — |
| `C-CMP-01` fused-operation equivalence | **Static.** The fusion pass must derive a *bit-identical record* pre- and post-fusion; otherwise the fusion is rejected (`E1106`). SFEP-0053 §3.5 already promises this; this SFEP makes it a checked invariant instead of a prose commitment | 2 |
| `C-CMP-02` autotune schedule invariance | **Vacuous by construction, recorded as such** — Sailfin has no schedule search in the semantic path. Becomes live the moment the Cost pillar adds one, and then this record is its gate | 2 (record) |
| `C-CMP-03` shape polymorphism | **Static but narrow.** Static shapes make the shape class a singleton, so the claim is true and small. Becomes the load-bearing class when dynamic shapes land | 2 (narrow) |
| `C-EXC-01` NaN/Inf propagation | **Partly static** (SFEP-0054 §3.1 fixes NaN canonicalization; `f32`/`f64` propagate per IEEE) + measured sparse injection | 2 + 3 |
| `C-EXC-02` out-of-bounds semantics | **Static** — the tensor lowering proves static extents once and uses unchecked loads only inside the verified extent (SFN-448, `docs/status.md`). Policy is derived as `proven_in_bounds`. **Unsound until the SFN-526 fatal-gate family lands** (§3.9) | 2, gated |

Eight of twelve are addressable now in some form. Say eight, not twelve.

### 3.6 Enforcement locus and failure mode

Three distinct gates, and the difference matters because CLAUDE.md's rule is
that an unenforced tolerance is not a tolerance.

**(a) Compile-time diagnostics** — `sfn check` and `sfn build`, coded, spanned,
fail-closed. These are the ones that make a contract real without running
anything:

| Code | Meaning |
|---|---|
| `E1100` | declared determinism class cannot be discharged (names the offending effect, callee, or concurrency primitive and its span) |
| `E1101` | tolerance derivation failed — `N*u(A) >= 1/2`, non-static extent, or an op with no derivation rule |
| `E1102` | a fast-math / reassociation / FP-contract flag would be emitted on a contract-bearing path |
| `E1103` | malformed `@contract` argument — unknown key, bad value, duplicate key |
| `E1104` | declared tolerance is tighter than the derived bound, or looser than the capsule accuracy budget |
| `E1105` | accumulator dtype narrower than declared, or narrowed by a compiler pass |
| `E1106` | a fusion would change the derived contract; the fusion is rejected |
| `E1107` | a contract-bearing operation has no scalar-reference oracle |
| `E1112` | declared NaN / denormal / out-of-bounds policy disagrees with the derived policy |
| `E1114` | integer-dtype contract requested while overflow semantics are undefined (SFEP-0058) |

**(b) Build-artifact gates** — emission failures, also fail-closed:
`E1108` (measurement protocol unsatisfiable: zero sample budget, or no oracle)
and `E1113` (`sfn contract verify` handed a record with an unsupported
`schema_version`).

**(c) Test-time conformance gates** — `sfn test`, coded so a failure is
attributable: `E1109` (residual exceeds the tolerance; the report names the
contract id, the residual, the bound, and the violation signature that matched)
and `E1110` (a shipped contract class has no committed violating implementation,
i.e. three-state calibration is missing — §8).

Every `E11xx` code lives in a new range with a new home,
`compiler/src/contract/` (§3.8).

### 3.7 The emitted artifact

Two files per capsule, beside the existing sidecar
(`build/capsules/<scope>/<name>/manifest.json`,
`compiler/src/capsule_artifact.sfn:246`), reusing that module's JSON emission
discipline and its `schema_version` convention:

- `build/capsules/<scope>/<name>/contracts.json` — the contract set.
- `build/capsules/<scope>/<name>/traces.jsonl` — one JSON object per
  conformance measurement, per the paper's §5.6 trace discipline: contract id,
  record version, implementation identity, target profile, input hash,
  residual, tolerance applied, verdict.

```json
{
  "schema_version": "1",
  "capsule": "sfn/tensor",
  "capsule_version": "0.3.1",
  "compiler_version": "0.7.0-alpha.43",
  "toolchain_pin": "clang-18.1.8",
  "target_triple": "x86_64-unknown-linux-gnu",
  "contracts": [
    {
      "id": "sfn/tensor::matmul::dot_f32",
      "class": "C-ORD-01",
      "scope": ["matmul"],
      "pre": { "dtypes": ["f32"], "shape": { "kind": "static", "dims": [128, 128, 128] },
               "value_range": "finite" },
      "post": { "kind": "elementwise_close", "against": "oracle" },
      "tolerance": { "rel": 7.6294e-6, "abs": 0.0, "ulp": 0,
                     "denominator": "sum_abs_products" },
      "oracle": { "kind": "higher_precision", "identity": "tensor_ir_lower_scalar/f64",
                  "build_hash": "sha256:..." },
      "measure": { "input_gen": "uniform_signed", "samples": 1024,
                   "statistic": "max_relative", "pass_rule": "max < tolerance.rel" },
      "violation": { "pattern": "residual > tolerance on > 1% of samples",
                     "concentrates_at": "large sum_abs_products" },
      "determinism_class": "bitwise",
      "derivation": {
        "formula_id": "dot-backward-error-v1",
        "inputs": { "N": 128, "u_P": 5.9604e-8, "u_A": 5.9604e-8, "order": "sequential" },
        "value": 7.6294e-6
      },
      "provenance": { "file": "src/matmul.sfn", "line": 42, "seed_version": "0.7.0-alpha.41" }
    }
  ]
}
```

**Can a non-Sailfin consumer validate a kernel against this? Yes, with one
caveat that must be closed in Phase 5.** The record is self-contained for
*grading*: `pre`, `post`, `tolerance`, `oracle`, `measure`, and `violation`
fully determine a pass/fail run that a Python harness can execute against a
Triton or CuTe kernel with no Sailfin installed. What a stranger cannot do from
the record alone is *re-derive* the tolerance — they must either trust our
`derivation.value` or reimplement `formula_id`. That gap is the difference
between "auditable" and "independently reproducible," and it is the honest limit
on the brief's §2 claim (§3.11, pushback 2).

**Recommendation: yes, ship the format as a standalone consumable
specification** — but in Phase 5, not Phase 1, and only after Sailfin itself has
consumed `schema_version: "1"` for two releases. The spec must contain three
things or the adoption claim is soft: (i) the JSON schema; (ii) the **derivation
formulas** with their `formula_id`s; (iii) a **derivation test-vector file** —
inputs to `(N, P, A, order)` and the exact expected bound — so an independent
implementation can prove it agrees with ours bit for bit. Without (ii) and (iii)
the format is a Sailfin log format wearing a standard's clothes. It answers
brief §10 Q1 in the affirmative with a named scope cost: one schema doc, one
vector file, and one `sfn contract verify` subcommand.

### 3.8 Module layout

New folder module, per the ~1,500-line budget rule and the `parser/` model:

| File | Role |
|---|---|
| `compiler/src/contract/mod.sfn` | re-exports; the `ContractRecord` type |
| `compiler/src/contract/classes.sfn` | the twelve-class table, violation signatures, per-class measurement protocols |
| `compiler/src/contract/tolerance.sfn` | unit-roundoff table, `gamma`, path composition, `formula_id` registry |
| `compiler/src/contract/derive.sfn` | walks the effect row / tensor IR and builds the derived half |
| `compiler/src/contract/declare.sfn` | parses `@contract` arguments, adjudicates declared vs derived, owns `E11xx` |
| `compiler/src/contract/emit_json.sfn` | `contracts.json` / `traces.jsonl` serialization |
| `compiler/src/cli/commands/contract.sfn` | `sfn contract show \| verify \| diff` |

`decorator_resolver.sfn`, `typecheck.sfn`, `tensor_ir_fusion.sfn`, and
`tensor_ir_verify.sfn` gain call sites; nothing else moves.

### 3.9 Phasing

Each phase is independently shippable and independently valuable. **Phase 1
needs no seal, no owned backend, no borrow checking, no tensor tier, and no
SFEP-0054 work.**

**Phase 1 — Determinism class, statically discharged.** `E1100`–`E1103`.
`@contract(determinism: bitwise)` on any function. The compiler discharges the
claim from the effect row (`clock`, `rand`, `net`, `io`, `gpu`, `model` are
disqualifying), the concurrency-primitive scan (SFEP-0049 leaves), and the
guarantee that no fast-math flag is emitted. Emits `contracts.json` with the
class, the discharge justification, and provenance. `sfn contract show`.
*Value:* the first machine-checked, externally consumable claim in the repo, and
`C-ORD-02` on the CPU path — the property the market is paying 34–61% throughput
for. *This is the phase that makes the pillar real, and it is reachable on
today's stack.*

**Phase 2 — Derived numerical tolerance over the tensor tier.**
`E1104`–`E1107`, `E1112`. `contract/tolerance.sfn`; `accumulator_dtype` added to
tensor reductions/contractions (a small SFEP-0053 amendment, §5); float dtypes
only; the fusion-invariant gate; `C-PRC-03`, `C-CMP-01`, `C-CMP-02` (recorded
vacuous), `C-CMP-03` (recorded narrow), `C-ORD-01`, `C-EXC-02`. *Value:*
SFEP-0053 §3.5's prose promise becomes a checked invariant, and the tolerance
stops being a per-test constant.

**Phase 3 — Measurement protocol, traces, three-state calibration.**
`E1108`–`E1110`. `sfn test` gains contract-conformance runs;
`assert_within_contract(actual, expected, contract_id, label)` replaces
hand-written epsilons in `capsules/sfn/test/src/mod.sfn:171`'s `assert_approx`
for contract-bearing code; `traces.jsonl`; every shipped class carries a
committed conforming *and* violating implementation. *Value:* a gate now fails
on a tolerance, which is the bar for calling it enforced. Also the direct answer
to the reward-hacking evidence (Sakana, KernelBench).

**Phase 4 — Low-precision contracts. Gated on SFEP-0054 §3.2.** `E1105`,
`E1111`. `C-PRC-01` accumulator preservation as a type rule; low-precision
`TensorDType` variants. **This is the flagship claim and it does not exist
before this phase.** Nothing in Phases 1–3 may be marketed as a low-precision
guarantee.

**Phase 5 — External consumability.** `E1113`. Schema v1 as a standalone spec +
derivation test vectors + `sfn contract verify --record <f> --impl <cmd>`
grading a non-Sailfin implementation. Plus the determinism-tax measurement that
brief §10 Q2 demands, and one external baseline per brief §5.

**Phase 6 — Integer contracts. Gated on SFEP-0058.** `E1114` is retired here.

### 3.10 Kernel Contracts: adopt, extend, do not supersede

**Adopt verbatim:** all eight part names; the four family prefixes (`PRC`,
`ORD`, `CMP`, `EXC`); the `C-FAM-NN` class identifiers and their twelve
definitions; the three-state calibration requirement; the trace-record concept;
the tolerance-derivation discipline of §3.3's note (which is the same discipline
SFEP-0054 §8 arrived at independently).

**Extend with three fields, argued:**

1. **`provenance`.** The paper's eight parts contain nothing that records *who
   built this and with what*. A contract without a compiler version, toolchain
   pin, seed version, and target triple is not attestable, and the paper's own
   §8.1 certification framing requires attestable artifacts. This is a genuine
   omission, not a Sailfin preference.
2. **`derivation`.** The paper *demands* non-circular derivation (§3.3) but
   provides no field to record it, so a conforming contract can state
   `relative 5e-3` with the reasoning in a prose footnote. Making the derivation
   machine-readable is what lets a third party audit the bound instead of
   accepting it. This is the single most important extension.
3. **`determinism_class` promoted to a top-level field.** In the paper it is
   buried inside `C-ORD-02`'s postcondition. Sailfin can *prove* it for the CPU
   path from the effect row rather than measure it over 100 invocations, so it
   deserves to be a field every record carries, not a class some records
   instantiate.

**Where Sailfin genuinely does better, and it is worth saying:** the paper's
§8.3 lists "adversarial contract verification" as open, concluding that for
numerical contracts, verification rather than sampling is impossible in general.
Sailfin answers a **restricted yes**. Because Sailfin owns the lowering, the
violations that require the compiler to narrow an accumulator, reassociate a
reduction, enable FTZ, or fuse illegally are *decided at compile time*, not
sampled — `C-PRC-01`, `C-PRC-03`, `C-CMP-01`, `C-CMP-02`, and the CPU half of
`C-ORD-02` move from "measured on 1024 samples" to "statically discharged." The
paper's §8.2 explicitly excludes compiler-side contracts as out of scope; that
exclusion is exactly the ground this SFEP occupies. Complement, not competition.

**Do not supersede.** Superseding would trade the positioning bet (being the
implementation of the specification the field just published) for a vocabulary
nobody cites, and the paper's twelve classes are a better empirically-grounded
checklist than one we would invent — including the four that tell us what *not*
to claim.

### 3.11 Pushback on the strategy brief

Four places where the brief is wrong or incomplete, recorded rather than
silently worked around.

1. **§7.5 demotes shape typing to ergonomics; that is right as positioning and
   wrong as engineering here.** Static shapes are the *derivation input* that
   makes `N` a compile-time constant, which is what makes the tolerance a closed
   form rather than a runtime quantity. Under dynamic shapes,
   `tolerance.rel = gamma(N, A) + 2u(P)` becomes symbolic in `N` and must be
   evaluated — or bounded — at runtime, which is a real and unpriced design cost
   the brief's demotion does not account for. Shape typing is not a
   differentiator; it *is* load-bearing for Result. The brief should say so.
2. **§2's "verifiable by someone who does not use Sailfin" overstates by one
   step.** The measurement protocol and the tolerance value are consumable
   without Sailfin. The *derivation* is auditable but not independently
   reproducible until the formulas and test vectors are published (§3.7). Until
   Phase 5, the honest claim is "gradeable by a stranger, trusting our
   arithmetic," not "verifiable by a stranger."
3. **§7.1 is right that the SFN-526 fatal-gate family precedes every pillar, and
   the consequence is sharper than stated.** `E1100`–`E1114` are all fail-closed
   diagnostics. Implementing them before the fatal-gate machinery exists would
   *create another instance of the same defect* — push a diagnostic, emit
   anyway, exit 0. Phase 1 must reuse whatever mechanism SFN-526 produces rather
   than inventing a second one. This is a sequencing constraint on Phase 1, not
   a blocker for it.
4. **"Result" collides with a shipped type.** `Result<T, E>` is SFEP-0012 and is
   everywhere in the source. "Result" must stay a positioning word only; no
   module, type, field, or CLI noun may use it. This SFEP names everything
   *numerical contract* / `contract` accordingly.

### 3.12 Non-goals

Autodiff contracts, collectives (`C-ORD-03`), training-run reproducibility
(`C-PRC-04`), within-SKU hardware variance, device codegen, schedule contracts
(the Cost pillar), a certification body, and `PII<T>`/taint interaction. None of
them may weaken the derivation or the self-hosting firewall implicitly.

## 4. Effect & capability impact

**No new effect, and no change to `canonical_effects()`.** `@contract` is
declarative; deriving and emitting a record happens in the build driver, which
is already `![io]`.

The interesting direction is the reverse one: **this SFEP makes the effect
system load-bearing for a numerical claim.** `determinism: bitwise` is
discharged by proving the function's transitive effect row excludes `clock`,
`rand`, `net`, `io`, `gpu`, and `model`, and that it contains no concurrency
primitive (SFEP-0049 leaves: `spawn`, `parallel`, channel send/receive). The
existing `![pure]` marker (`compiler/src/effect_taxonomy.sfn:57`) is the
strongest form of that proof and discharges it immediately.

That composition is Pillar 1 × Pillar 2, and it is the one move in this design
that no other stack can copy without an effect system. It is also why Phase 1 is
cheap: the analysis already exists in `effect_checker.sfn`; this SFEP only reads
its conclusion.

Contract emission does not declassify anything, does not grant `![gpu]`, and
does not let a device operation skip its capability.

## 5. Self-hosting impact

**The firewall holds.** Nothing here requires a GPU, XLA, MLIR, StableHLO, or a
vendor library to build or self-host `sfn`. The compiler is not a tensor program:
`contract/` is ordinary scalar Sailfin data-structure code compiled by the
existing AST → `native_ir` → LLVM path.

**The compiler source does not use `@contract`.** That makes every phase purely
additive with respect to bootstrapping: the pinned seed never needs to understand
the decorator, because no `compiler/src/*.sfn` or `runtime/` file carries one.
Per `.claude/rules/seed-dependency.md`, each phase therefore **bundles** its
capability with its consumer in one PR — no `seed-blocker`, no seed-cut gate.
The runtime-source carve-out does not apply: no runtime file calls a new builtin
or intrinsic.

Passes touched, by phase:

- **Phase 1** — `decorator_resolver.sfn` (recognize `@contract`),
  `typecheck.sfn` + new `contract/declare.sfn` (adjudicate), `effect_checker.sfn`
  (read-only consumer of the existing row), `capsule_artifact.sfn` sibling
  emission, new `cli/commands/contract.sfn`, `capsule.toml` schema for
  `[capsule.numerics]`.
- **Phase 2** — `tensor_ir.sfn` (`accumulator_dtype` on `TensorOp`),
  `tensor_ir_verify.sfn`, `tensor_ir_fusion.sfn` (the `E1106` invariant), new
  `contract/tolerance.sfn` + `contract/derive.sfn`.
- **Phase 3** — `cli/commands/test.sfn`, `capsules/sfn/test/src/mod.sfn`.
- **Phase 4** — `typecheck_types.sfn` (via SFEP-0054's exact-kind work),
  `llvm/type_mapping.sfn`.

Phase 2 adds a folder module, so it needs `make clean-build` once before
rebuilding. Every phase runs `make compile` before targeted tests.

## 6. Alternatives considered

### 6.1 Do nothing — keep SFEP-0054 as-is

Rejected. 0054 already derives per-test bounds from dtype, accumulator, op count
and unit roundoff (§8) — but *inside test files*, as constants a human typed
after reading the SFEP. Nothing emits an artifact, nothing checks a claim, and
the derivation is not code. The result is the exact condition CLAUDE.md forbids:
a tolerance nobody enforces. 0054 supplies the substrate; it cannot supply the
proof. **This SFEP builds on 0054 and replaces none of it.**

### 6.2 A `contract { }` block, matching the paper's grammar

Rejected. It spends a keyword on a common identifier, contradicting CLAUDE.md's
"libraries over keywords" and its corollary that a keyword can never become a
variable name (`contract` is already a local in
`compiler/src/build/direct_link.sfn`). It also requires lexer and parser work
that the decorator route gets for free, and a standalone block cannot see the
signature it constrains without a name-resolution step the decorator already
has. Fidelity to the paper's *vocabulary* is what matters for positioning; its
concrete syntax is not the asset.

### 6.3 Contracts entirely in `capsule.toml`

Rejected as the primary surface, adopted as the secondary one. A manifest cannot
name a function precisely, drifts from the code it constrains, and gives
diagnostics no span. But an *accuracy budget* genuinely is project policy rather
than a per-function fact, so `[capsule.numerics]` carries the budget and the
default determinism class, and `@contract` narrows it.

### 6.4 Hand-authored tolerances (the paper's own model)

Rejected. The paper's §3.3 note explains why: a tolerance copied from a measured
implementation is circular. It then leaves derivation to a human, which is where
every hand-authored capability manifest also failed (brief §4 Pillar 1;
evidence §3 — naive manifests block 27.3% of attacks, auto-generated ones are
80.9% accurate). Sailfin's whole claim is that the compiler is the only place
this can be *derived* rather than authored. Hand-authoring would reproduce the
retrofit's defect in a greenfield language.

### 6.5 Invent Sailfin's own contract vocabulary

Rejected. See §3.10. It trades the months-long positioning window for nothing,
and loses an empirically-calibrated twelve-class checklist.

### 6.6 Runtime-only checking (assert tolerances at execution)

Rejected as the primary locus, retained as Phase 3. A runtime check cannot
reject an illegal fusion, a narrowed accumulator, or a false determinism claim —
and those are precisely the silent-failure modes the evidence documents. Static
discharge where possible, measurement where not.

### 6.7 Full formal verification (Coq/Lean-checked numerical contracts)

Rejected. The paper explicitly designs for engineers rather than proof
assistants, and its §8.3 records numerical verification as open in general. The
restricted static discharge in §3.10 captures the tractable subset without a
proof-assistant dependency in the bootstrap.

### 6.8 Emit the record from the tensor tier only

Rejected as the *first* phase. It would make Phase 1 depend on
`tensor_ir_build.sfn` (which does not exist) and on a user-facing tensor surface
(which does not exist), delaying the first shippable artifact behind two
unrelated predecessors. The determinism class needs neither, so it goes first.

## 7. Stage1 readiness mapping

Draft design, not an implementation claim. Every item is pending, per phase:

- [ ] **Parses** — `@contract(...)` accepted in every decorator position (Phase 1;
      no grammar change expected — verify against
      `parser/declarations/syntax.sfn`).
- [ ] **Type-checks / effect-checks** — declared-vs-derived adjudication enforced;
      `E1100`–`E1114` at correct spans; effect row consumed read-only.
- [ ] **Emits valid `.sfn-asm`** — contract-bearing functions emit unchanged
      native IR; the record is a sidecar, never a code change.
- [ ] **Lowers to LLVM IR** — no fast-math flag on any contract-bearing path,
      asserted by an IR scan.
- [ ] **Regression coverage** — §8.
- [ ] **Self-hosts** — `make compile` with no accelerator, no MLIR, no GPU.
- [ ] **`sfn fmt --check` clean** — every added `.sfn` file.
- [ ] **Documented in `docs/status.md` + spec** — one row per phase; the preview
      chapter graduates only when a gate fails on a real contract.

The SFEP stays `Draft` until owner approval, and `Accepted` (never
`Implemented`) until Phase 4 clears end-to-end — a contract over `f32`/`f64`
alone is not the flagship claim.

## 8. Test plan

Inherit SFEP-0054 §8's discipline — table-driven bit patterns, a
format-independent reference encoder, per-test derived bounds, three-way
equivalence — and extend it in three ways.

**Unit** (`compiler/tests/unit/`):

- `contract_tolerance_test.sfn` — the unit-roundoff table for all seven formats;
  `gamma(N, A)` against hand-computed values; the `N*u(A) >= 1/2` fail-closed
  path (`E1101`); pairwise vs sequential `formula_id` selection; path
  composition over a three-op chain.
- `contract_declare_test.sfn` — negative tests for `E1100`, `E1103`, `E1104`
  (both directions), `E1112` at exact spans; `![pure]` discharges `bitwise`
  immediately; a `![clock]` callee three levels deep fails `E1100` and the
  message names the callee.
- `contract_record_json_test.sfn` — golden `contracts.json`, byte-stable field
  order, `schema_version` present, no host-dependent value leaks into the record.

**Integration** (`compiler/tests/integration/`):

- `contract_fusion_invariant_test.sfn` — a graph whose fusion would change the
  derived record is rejected with `E1106`; a legal fusion derives a
  byte-identical record pre- and post-fusion.
- `contract_no_fast_math_test.sfn` — scan emitted IR for `fast`, `nnan`, `ninf`,
  `nsz`, `arcp`, `contract`, `afn`, `reassoc` on any contract-bearing function;
  any hit is `E1102`. This is the guard that keeps a future optimization from
  silently invalidating every emitted record.

**E2E** (`compiler/tests/e2e/`, Sailfin `*_test.sfn` driving subprocesses per
`.claude/rules/no-bash-e2e.md` — no `.sh`, and thread
`clean_runner_env(nested_runner_scratch("contract"))` for any nested build):

- `contract_show_test.sfn` — `sfn contract show` output matches the record.
- `contract_conformance_test.sfn` — scalar-reference exit vs StableHLO exit vs
  the independent naive oracle, all three graded against the *derived* bound
  rather than a literal epsilon (extending `tensor_matmul_exec_test.sfn`).
- `contract_verify_external_test.sfn` (Phase 5) — a deliberately non-Sailfin
  implementation (a small C or Python kernel) graded from the record alone,
  proving the artifact is consumable without the compiler.

**Three-state calibration is a required repo artifact, not a test convention.**
For every contract class Sailfin claims to enforce, `compiler/tests/fixtures/contracts/`
holds three implementations:

- **baseline** — fails visible tests (e.g. returns zeros);
- **bad** — *passes* every functional test and violates the contract (e.g. a
  reduction that narrows its accumulator above a block-size threshold, or a
  matmul correct at benchmarked shapes only);
- **good** — passes both.

`E1110` fires when a shipped class has no committed **bad** implementation. The
bad implementation is the calibration anchor: if the measurement protocol cannot
separate bad from good, the contract is mis-specified, and we would rather learn
that from CI than from a user. This is also the repo's direct answer to the
reward-hacking evidence — an agent that games a contract is producing exactly
the "bad" artifact this fixture set is designed to catch.

**Phase acceptance.** Phase 1: `contract_declare_test.sfn` +
`contract_record_json_test.sfn` + `contract_show_test.sfn` + `make compile`.
Phase 2 adds the fusion and no-fast-math legs. Phase 3 adds the calibration
fixtures and `traces.jsonl` golden. Phase 4 adds exhaustive low-precision
accumulator cases. No GPU is required at any phase's gate.

## 9. References

- `docs/strategy/decision-brief.md` §2, §3, §4 Pillar 2, §7.1–7.3, §9, §10 —
  positioning; §3.11 records where this SFEP dissents.
- `docs/strategy/market-evidence-2026-07.md` §8 — the demand evidence and the
  *Kernel Contracts* summary. Not re-derived here.
- arXiv 2604.22032, Cooper Veit, "Kernel Contracts: A Specification Language for
  ML Kernel Correctness Across Heterogeneous Silicon," 2026-04-23 (CC BY 4.0) —
  the eight-part structure (§3.1), the abbreviated and full grammars (§3.2,
  App. A), the twelve classes (§4), three-state calibration (§3.4, §5.1), the
  tolerance-specification hierarchy (§5.3), trace discipline (§5.6), and the
  open problems this SFEP partially answers (§8.3).
- [SFEP-0054 — Low-Precision Numeric Substrate](./0054-low-precision-numerics.md)
  — the substrate this builds on; §3.2 (exact dtype identity), §3.6
  (accumulator rules), §3.8 (`E0910`–`E0915`), §6.6 (no FTZ), §8 (bound
  derivation). **Phase 4 is gated on §3.2.**
- [SFEP-0053 — Shape-Typed Tensor IR and Fusion](./0053-shape-typed-tensor-ir.md)
  — §3.2 (static shapes as the `N` source), §3.5 (the no-reassociation promise
  this SFEP turns into a checked invariant), §3.6 (the scalar oracle). Phase 2
  amends §3.2/§3.3 with `accumulator_dtype`.
- [SFEP-0052 — Accelerated ML strategy](./0052-ml-acceleration-strategy.md) —
  Track A stays capped at oracle-and-fallback duty (brief §7.4).
- [SFEP-0058 — Sized Integer Types and Overflow Semantics](./0058-sized-integer-types.md)
  — **Phase 6 is gated on it**; integer-dtype contracts are meaningless while
  overflow is silent wraparound and unsigned widths collapse onto signed LLVM
  twins.
- [SFEP-0012 — `Result<T, E>` and the `?` Operator](./0012-result-and-question-operator.md)
  — the naming collision recorded in §3.11.4.
- [SFEP-0023 — Capsule-Defined Decorators](./0023-capsule-decorators.md) — the
  decorator mechanism `@contract` reuses.
- [SFEP-0049 — Concurrency-effect transparency](./0049-concurrency-effect-transparency.md)
  — the concurrency leaves the determinism discharge must scan.
- [SFEP-0051 — Workspace Manifest](./0051-workspace-manifest.md) and
  `compiler/src/cli/commands/capabilities.sfn` — the Pillar-1 precedent for an
  emitted, audited artifact with a CLI surface.
- SFN-526 fatal-gate family — the fail-open lowering defect that `E11xx`
  fail-closed emission must not reproduce (brief §7.1).
- `compiler/src/typecheck_types.sfn:1096-1139`, `compiler/capsules/ir/src/tensor_ir.sfn:8-20`,
  `compiler/src/capsule_artifact.sfn:246`,
  `compiler/capsules/syntax/src/parser/declarations/syntax.sfn`,
  `compiler/src/effect_taxonomy.sfn:57`, `docs/status.md` (tensor IR /
  low-precision rows) — the in-tree reality this design is measured against.
- Higham, *Accuracy and Stability of Numerical Algorithms* (2nd ed.), §3.1 —
  the `gamma(n)` dot-product backward-error bound `formula_id`
  `dot-backward-error-v1` implements.
