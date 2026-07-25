---
sfep: TBD
title: Typed SSA Activation — Making the Metadata IR Load-Bearing
status: Draft
type: tooling
created: 2026-07-25
updated: 2026-07-25
author: "agent:compiler-architect; human review"
tracking:
supersedes:
superseded-by:
graduates-to:
---

# SFEP-XXXX — Typed SSA Activation

## 1. Summary

SFEP-0015 §9 locked a normative Typed SSA v0 contract and SFN-454 landed its
data model, verifier, and canonical renderer (`compiler/src/typed_ssa.sfn`,
`typed_ssa_verify.sfn`, `typed_ssa_render.sfn`, ~2,360 lines). **Nothing
produces a typed-SSA module and nothing consumes one.** The subtree is not
imported from `compiler/src/main.sfn`, so it is `sfn check`-clean and
self-hostable but never lowered, never exercised on real input, and never
covered by the differential oracle SFEP-0015 §9.9 requires. Every §9.5
metadata-preservation guarantee is therefore unverified in practice.

This proposal fixes **how** a deliberately partial IR becomes load-bearing
without destabilising the self-hosting build, and names the two contract gaps
(§9.4 conversions, §9.5 capability provenance) that block the producer from
representing even trivial real functions.

## 2. Motivation

SFEP-0015 §8 Stage 1.5 calls typed SSA *"likely the single most valuable piece
of work in this whole arc even if Stage 3 never ships."* Its value is entirely
contingent on being **reached**: an IR that no pass produces is a data model,
not a seam. Three concrete failures follow from the current state.

1. **The metadata contract is untested.** §9.5 requires that a call's
   effect/capability sets be supersets of the callee's, and that a defined
   function's sets be supersets of every call in its body. `verify_module`
   implements those checks, but no module is ever built from real Sailfin code
   to run them against. The capability seal (SFEP-0016 §3) depends on exactly
   this property surviving lowering.
2. **There is no differential oracle.** §9.9 designates the existing LLVM
   backend as the correctness oracle for each construct ported to typed SSA.
   With no producer, there is nothing to differentiate.
3. **The subtree is not even lowered.** Because `main.sfn` does not import it,
   `typed_ssa*.sfn` never reaches `llvm/lowering/`. Any latent #1389-class
   build-only defect (the `.push`-on-struct-field and struct-method-body
   lowering hazards its own header comments cite) is undetected. The first
   import is therefore a real, and currently unbudgeted, risk.

The honest tension this proposal resolves: **v0 cannot represent any
substantial Sailfin function.** §9.10 excludes aggregates, closures, memory,
ownership, exceptions, concurrency, indirect calls, and variadics — which
excludes strings, arrays, structs, and enums, i.e. essentially all of
`compiler/src`. A wiring strategy that assumes gradual in-place replacement of
the LLVM string-template path is not implementable.

## 3. Design

### 3.1 The wiring strategy: fail-closed module-level subset gate, three
consumers of increasing authority

Typed SSA is wired as a **complete alternative path over the subset it can
represent**, selected explicitly, never as a partial replacement inside the
production lowering path.

```text
.sfn-asm text ──► parse_native_artifact ──► NativeFunction[]
                                              │
                                              ▼
                               typed_ssa_produce  (subset gate, fail-closed)
                                              │
                              ┌───────────────┼────────────────┐
                              ▼               ▼                ▼
                       verify_module    render_module    (consumers, staged)
```

Three properties define the gate:

- **Module granularity.** A module either produces a fully verified typed-SSA
  module or the producer returns diagnostics and produces nothing. There is no
  per-function mixing of typed-SSA-lowered and string-lowered functions inside
  one `.ll`.
- **Fail-closed.** An unsupported construct is a `TssaDiagnostic`, never a
  silent skip, never an escape hatch that injects backend text (§9.9 seam 3).
- **Explicit selection.** The path is reached through a CLI verb
  (`sfn emit typed-ssa`) and a `sfn dev` sweep, never by default on the
  self-host build.

The three consumers, in order of increasing authority:

| Layer | Consumer | What it proves | Authority |
|---|---|---|---|
| **L1** | `sfn emit typed-ssa <file>` → canonical renderer output | The producer exists, is reachable, self-hosts, and its output verifies | None — observation only |
| **L2** | `sfn dev typed-ssa-sweep` over staged `.sfn-asm` for all of `compiler/src` | Determinism (§9.7), effect-set parity against `.meta effects`, verifier survival at corpus scale | None — a regression guard |
| **L3** | typed SSA → `.sfn-asm` round-trip, spliced and built through the existing lowering | Producer fidelity proven by *executed behaviour*, not by inspection | Real: a shipped binary's code came from typed SSA |

**Why L3 renders back to `.sfn-asm` rather than to LLVM text.** The repo
already proves this pattern: `compiler/src/tensor_ir_link_harness.sfn` lowers
a shape-typed tensor-IR module to a `.fn … .endfn` native-IR block, splices it
into a driver program's native text, and reuses `lower_to_llvm_ir_from_text`
plus the ordinary runtime-capsule link to produce a runnable, timeable binary.
A typed-SSA → LLVM-text adapter would instead have to re-implement type
mapping, symbol mangling, the module preamble, runtime `declare`s, and the
import-context plumbing that §9.10 explicitly puts outside v0 — thousands of
lines of duplicated backend surface to prove a property the round-trip proves
for a fraction of the cost.

The direct typed-SSA → LLVM adapter (§9.9 seam 4) remains the eventual proof of
the backend boundary. Its entry condition is concrete and stated here so it is
not mistaken for an open-ended intention: **it becomes fileable once the subset
gate accepts a program containing control flow and mutable scalar locals, and
the L3 round-trip builds and runs that program with behaviour identical to the
direct build.** Before that condition, the adapter has nothing non-trivial to
lower and no oracle to be checked against.

### 3.2 Producer boundary and staging of coverage

The producer input is `.sfn-asm`, per SFEP-0015 §9.7 (IDs assigned in
`.sfn-asm` declaration order after the deterministic module merge) and §9.9
seam 3 (`NativeFunction` and the string-expression model). This is the right
boundary for a second reason the SFEP does not state: `.sfn-asm` is the artifact
that survives the build's per-module subprocess emit and the SFEP-0043 arena
rewind in `compile_to_llvm_file_with_module_imports`. An AST-sourced producer
would require the front end to be resident in the same process and phase as
codegen, which the build architecture deliberately separates.

The cost of that boundary, which SFEP-0015 §9.9 understates: `.sfn-asm`
expressions are **opaque strings**. `NativeInstruction.Let.value`,
`.Return.expression`, and `.If.condition` are text. The producer needs its own
small precedence-climbing expression parser for the scalar subset. It must not
reuse `compiler/src/llvm/expressions_parsing.sfn`, whose results are shaped for
LLVM text emission — that would reintroduce backend coupling on the producer
side of the boundary.

Coverage is staged so each step is independently verifiable:

1. **Declarations and signatures only.** Every function becomes a typed-SSA
   declaration (`is_defined: false`): symbol, parameter types, result type,
   linkage, and the effect set read from `.meta effects`. No bodies, no
   expression parsing. This alone yields verified, deterministically-rendered
   effect metadata for every module in `compiler/src`.
2. **Straight-line scalar bodies.** Literals, parameter and immutable-`let`
   references, unary/binary/compare, and direct calls, terminated by `Return`
   or `Unreachable`. One block.
3. **Control flow and mutable scalar locals.** `.if`/`.else`, `.loop`,
   `break`/`continue` become blocks; mutable scalar locals become block
   parameters via standard SSA construction. This is where the block-parameter
   design in §9.3 earns its keep.

Type mapping at the boundary is direct: `.sfn-asm` already spells scalar types
as `i8`/`i16`/`i32`/`i64`/`u*`/`usize`/`bool`/`f32`/`f64`/`*T`. Anything else —
`string`, `T[]`, a struct or enum name, an interface, a function type — is
outside the subset and rejects the module.

### 3.3 Contract gap A — §9.4 has no conversion operation

The v0 instruction set is `ConstBool`, `ConstInt`, `ConstFloat`, `Unary`,
`Binary`, `Compare`, `Call`. There is **no width conversion, no sign
conversion, no int↔float conversion, and no pointer↔integer conversion.**

This is not a corner case. A representative real function from
`runtime/sfn/platform/rand.sfn`, already fully scalar, is unrepresentable:

```text
.fn _rand_ptr_off(p: *u8, off: i64) -> *u8
    .let addr : i64 = ((p) as i64) + off
    ret (addr) as * u8
.endfn
```

Every pointer-offset helper, every mixed-width arithmetic site, and every
`usize`/`i64` boundary in the runtime hits this. Without conversions the subset
gate rejects nearly everything that is otherwise in-scope, and the producer's
coverage staging above stalls at step 2.

**Proposed amendment to §9.4:** add a single instruction with an explicit,
non-inferring kind enum.

```text
Convert(kind, value) -> scalar

ConvertKind =
    IntTruncate | IntSignExtend | IntZeroExtend
  | IntToFloat  | UnsignedIntToFloat
  | FloatToInt  | FloatToUnsignedInt
  | FloatTruncate | FloatExtend
  | PointerToInt | IntToPointer
  | PointerCast
```

The verifier admits each kind only for the operand/result type pair it names —
`IntTruncate` requires a strictly narrower integer result, `PointerToInt`
requires a pointer operand and an integer result, and so on. Following the §9.4
discipline that "overflow and floating-point behavior must not be inferred from
a backend default," no kind is permitted to be selected implicitly by a
consumer: a producer that cannot name the exact kind must reject the construct.

### 3.4 Contract gap B — §9.5 capability atoms have no producer input

§9.5 requires that a function declaration record "its transitive effect summary
and required capability summary," and that every `Call` record "the callee
effects and required capabilities visible at that call site." Effects are
available: `.sfn-asm` carries `.meta effects <list>` per function, and call-site
callee effects are resolvable through the same `ImportSymbolTable` the effect
gate already builds via `load_imported_interfaces_from_paths`.

**Capabilities have no source at this boundary.** `.sfn-asm` records no
capability data, `NativeFunction` has no capability field, and capsule
capability requirements live in `capsule.toml` and reach the compiler only as
the `imported_capabilities_required: string[]` list threaded into
`validate_and_render_effects_with_capabilities`. Left unaddressed, every
`CapabilitySetId` in a produced module is the empty set, §9.6 invariant 6 is
vacuous, and the manifest in §9.1 is never populated — which is precisely the
metadata the capability seal exists to carry.

**Proposed rule.** Capability atoms are derived, not invented:

- A function's capability summary is the image of its effect set under the
  canonical effect→capability kind mapping, intersected with the capsule
  manifest's declared grants. `CapabilityAtom.arguments` carry the manifest's
  scoping arguments (e.g. a path prefix) as `MetadataValue`s when the manifest
  provides them, and are empty when the grant is unscoped.
- The module manifest (§9.1) is populated from the module's exported entry
  points, with `effects` and `capabilities` the union over those entry points.
- A capsule with no manifest in scope (the standalone-file and unit-test case,
  which the effect gate already handles by passing an empty capability list)
  produces empty capability sets — an explicitly valid interned set per §9.5,
  not a silent gap.

## 4. Effect & capability impact

This is the mechanism by which effect and capability metadata first survives
past the front end as *data* rather than as strings consumed and discarded by
the effect gate. It adds no effect to the language and changes no effect-checking
rule. §3.4 is the point where the capability side of pillar 2 acquires a
machine-readable carrier; until it lands, typed SSA carries effects only.

The producer itself is `![io]`-free at its core (pure `.sfn-asm` text in,
`Module` out); only the CLI verb and the sweep command take `![io]`.

## 5. Self-hosting impact

No language feature changes, no syntax changes, no parser changes. Every slice
is an ordinary `compiler/src` change compiled by the currently pinned seed, so
**no step in this arc requires a seed cut** — the seed must compile the new
source, not contain the new capability. This is worth stating explicitly because
the arc has several ordered slices and the ordering could otherwise be
mistaken for a seed-gated chain (`.claude/rules/seed-dependency.md`).

The one real self-hosting risk is concentrated in the first slice: importing
`typed_ssa*.sfn` from `main.sfn` causes those ~2,360 lines to be lowered to
LLVM IR for the first time. The subtree's own header comments document two
#1389-class hazards it was written to avoid (`.push` on a struct-field array;
`.push` inside a struct-method body). `sfn check` cannot detect a recurrence —
only `make compile` can. The first slice must therefore budget for fixing
lowering failures in already-merged code, and `make compile` is a hard
acceptance criterion for it.

Pipeline stages touched: **`.sfn-asm` consumption** (new `typed_ssa_produce`),
**CLI** (`cli/commands/emit.sfn`, a new `cli/commands/dev_typed_ssa.sfn`), and
**module wiring** (`main.sfn`). The LLVM lowering path is untouched until L3,
and even then only through the existing `lower_to_llvm_ir_from_text` entry
point.

## 6. Alternatives considered

**Per-function opt-in inside production modules.** Lower subset-passing
functions through typed SSA and fall back to the string path for the rest,
within one `.ll`. Rejected: it puts two lowering strategies inside one module,
so a defect in the new path can corrupt the self-hosting build even when the
feature is nominally off; and it forces the new path to reproduce the
module-level plumbing (globals, decorators, imports, runtime declares) that
§9.10 puts outside v0. All of the regression risk, none of the isolation.

**Shadow-only, permanently.** Produce and verify alongside the real lowering,
always discarding the result. Rejected as a terminal state — it never makes the
IR load-bearing and never builds the §9.9 oracle. Accepted as the *first* slice
(L1), because it is the cheapest way to force the producer to exist, be
imported, and self-host.

**Producing from the AST instead of `.sfn-asm`.** Avoids re-parsing opaque
expression strings, which is the single largest cost in the producer.
Rejected: it contradicts the §9.7 determinism rule and the §9.9 seam-3
boundary, and it requires the front end to be co-resident with codegen, which
the per-module subprocess emit and the SFEP-0043 arena rewind deliberately
separate. The re-parse cost is real and is accepted as the price of the
serialized boundary.

**Whole-module subset gate with no staging (all of v0 at once).** Rejected as
an `L` with no intermediate verifiable state; the three-step coverage staging
in §3.2 gives each step its own oracle.

**A typed-SSA → LLVM-text adapter as the first real consumer.** Rejected on
cost: it duplicates type mapping, mangling, and module preamble surface to
prove a property the `.sfn-asm` round-trip proves with the already-proven
`tensor_ir_link_harness` pattern. It is retained as the eventual seam-4 proof
with the explicit entry condition in §3.1.

## 7. Stage1 readiness mapping

- [ ] Parses — n/a; no syntax change
- [ ] Type-checks / effect-checks — new modules must pass `sfn check`
- [ ] Emits valid `.sfn-asm` — n/a; consumes it
- [ ] Lowers to LLVM IR — **the load-bearing item**; first import of the
      `typed_ssa*` subtree must survive `make compile`
- [ ] Regression coverage — unit tests per slice plus the corpus sweep (L2)
- [ ] Self-hosts — `make compile` on every slice
- [ ] `sfn fmt --check` clean
- [ ] Documented in `docs/status.md`

## 8. Test plan

- `compiler/tests/unit/typed_ssa_produce_test.sfn` — declaration/signature
  production, effect-set derivation, and one fail-closed rejection per
  out-of-subset construct class (aggregate parameter, string return, closure,
  indirect call).
- `compiler/tests/unit/typed_ssa_convert_test.sfn` — one admitted and one
  rejected operand/result pair per `ConvertKind`.
- `compiler/tests/unit/typed_ssa_capability_test.sfn` — effect→capability
  derivation, manifest population from entry points, and the empty-manifest
  fallback.
- `compiler/tests/e2e/typed_ssa_sweep_test.sfn` — the corpus sweep: every
  staged `.sfn-asm` either verifies or reports a subset diagnostic, renders
  byte-identically across two runs, and its function effect sets match the
  `.meta effects` lines.
- `compiler/tests/e2e/typed_ssa_roundtrip_exec_test.sfn` — L3: a scalar fixture
  built through the round trip and run, compared against the direct build's
  exit status and stdout.

## 9. References

- SFEP-0015 §8 (staged roadmap), §9 (Typed SSA v0 normative contract), §9.5
  (metadata), §9.7 (determinism), §9.9 (implementation and differential seams),
  §9.10 (v0 non-goals), §12 (ordered workstreams).
- SFEP-0016 §3, §4 (why metadata must survive lowering).
- SFN-452 (contract), SFN-454 (core + verifier + renderer).
- `compiler/src/tensor_ir_link_harness.sfn` — prior art for making a partial IR
  execute through the existing lowering path.
- `.claude/rules/seed-dependency.md` — why this arc's ordering is not seed-gated.
