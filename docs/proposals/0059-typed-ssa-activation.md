---
sfep: 59
title: Typed SSA Activation — Making the Metadata IR Load-Bearing
status: Accepted
type: tooling
created: 2026-07-25
updated: 2026-08-05
author: "agent:compiler-architect; project owner (design gate 2026-07-25); agent:implementer (2026-08-05 contract relocation)"
tracking: "SFN-508, SFN-509, SFN-511, SFN-512, SFN-514, SFN-517, SFN-519; structured types: SFN-585, SFN-588–SFN-606"
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0059 — Typed SSA Activation

## 1. Summary

§10 below is the normative Typed SSA v0 contract; SFN-454 landed its
data model, verifier, and canonical renderer (`compiler/src/typed_ssa.sfn`,
`typed_ssa_verify.sfn`, `typed_ssa_render.sfn`, ~2,360 lines). **Nothing
produces a typed-SSA module and nothing consumes one.** The subtree is not
imported from `compiler/src/main.sfn`, so it is `sfn check`-clean and
self-hostable but never lowered, never exercised on real input, and never
covered by the differential oracle §10.9 requires. Every §10.5
metadata-preservation guarantee is therefore unverified in practice.

This proposal fixes **how** a deliberately partial IR becomes load-bearing
without destabilising the self-hosting build, and names the two contract gaps
(§10.4 conversions, §10.5 capability provenance) that block the producer from
representing even trivial real functions.

## 2. Motivation

`docs/backend-independence.md`'s Stage 1.5 narrative (originally SFEP-0015
§8) calls typed SSA *"likely the single most valuable piece of work in this
whole arc even if Stage 3 never ships"*. Its value is entirely
contingent on being **reached**: an IR that no pass produces is a data model,
not a seam. Three concrete failures follow from the current state.

1. **The metadata contract is untested.** §10.5 requires that a call's
   effect/capability sets be supersets of the callee's, and that a defined
   function's sets be supersets of every call in its body. `verify_module`
   implements those checks, but no module is ever built from real Sailfin code
   to run them against. The capability seal (SFEP-0016 §3) depends on exactly
   this property surviving lowering.
2. **There is no differential oracle.** §10.9 designates the existing LLVM
   backend as the correctness oracle for each construct ported to typed SSA.
   With no producer, there is nothing to differentiate.
3. **The subtree is not even lowered.** Because `main.sfn` does not import it,
   `typed_ssa*.sfn` never reaches `llvm/lowering/`. Any latent #1389-class
   build-only defect (the `.push`-on-struct-field and struct-method-body
   lowering hazards its own header comments cite) is undetected. The first
   import is therefore a real, and currently unbudgeted, risk.

The honest tension this proposal resolves: **v0 cannot represent any
substantial Sailfin function.** §10.10 excludes aggregates, closures, memory,
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
  silent skip, never an escape hatch that injects backend text (§10.9 seam 3).
- **Explicit selection.** The path is reached through a CLI verb
  (`sfn emit typed-ssa`) and a `sfn dev` sweep, never by default on the
  self-host build.

The three consumers, in order of increasing authority:

| Layer | Consumer | What it proves | Authority |
|---|---|---|---|
| **L1** | `sfn emit typed-ssa <file>` → canonical renderer output | The producer exists, is reachable, self-hosts, and its output verifies | None — observation only |
| **L2** | `sfn dev typed-ssa-sweep` over staged `.sfn-asm` for all of `compiler/src` | Determinism (§10.7), effect-set parity against `.meta effects`, verifier survival at corpus scale | None — a regression guard |
| **L3** | typed SSA → `.sfn-asm` round-trip, spliced and built through the existing lowering | Producer fidelity proven by *executed behaviour*, not by inspection | Real: a shipped binary's code came from typed SSA |

**Why L3 renders back to `.sfn-asm` rather than to LLVM text.** The repo
already proves this pattern: `compiler/src/tensor_ir_link_harness.sfn` lowers
a shape-typed tensor-IR module to a `.fn … .endfn` native-IR block, splices it
into a driver program's native text, and reuses `lower_to_llvm_ir_from_text`
plus the ordinary runtime-capsule link to produce a runnable, timeable binary.
A typed-SSA → LLVM-text adapter would instead have to re-implement type
mapping, symbol mangling, the module preamble, runtime `declare`s, and the
import-context plumbing that §10.10 explicitly puts outside v0 — thousands of
lines of duplicated backend surface to prove a property the round-trip proves
for a fraction of the cost.

The direct typed-SSA → LLVM adapter (§10.9 seam 4) remains the eventual proof of
the backend boundary. Its entry condition is concrete and stated here so it is
not mistaken for an open-ended intention: **it becomes fileable once the subset
gate accepts a program containing control flow and mutable scalar locals, and
the L3 round-trip builds and runs that program with behaviour identical to the
direct build.** Before that condition, the adapter has nothing non-trivial to
lower and no oracle to be checked against.

### 3.2 Producer boundary and staging of coverage

The producer input is `.sfn-asm`, per §10.7 (IDs assigned in
`.sfn-asm` declaration order after the deterministic module merge) and §10.9
seam 3 (`NativeFunction` and the string-expression model). This is the right
boundary for a second reason the SFEP does not state: `.sfn-asm` is the artifact
that survives the build's per-module subprocess emit and the SFEP-0043 arena
rewind in `compile_to_llvm_file_with_module_imports`. An AST-sourced producer
would require the front end to be resident in the same process and phase as
codegen, which the build architecture deliberately separates.

The cost of that boundary, which §10.9 understates: `.sfn-asm`
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
   design in §10.3 earns its keep.

Type mapping at the boundary is direct: `.sfn-asm` already spells scalar types
as `i8`/`i16`/`i32`/`i64`/`u*`/`usize`/`bool`/`f32`/`f64`/`*T`. Anything else —
`string`, `T[]`, a struct or enum name, an interface, a function type — is
outside the subset and rejects the module.

### 3.3 Contract gap A — §10.4 has no conversion operation

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

**Proposed amendment to §10.4:** add a single instruction with an explicit,
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
requires a pointer operand and an integer result, and so on. Following the §10.4
discipline that "overflow and floating-point behavior must not be inferred from
a backend default," no kind is permitted to be selected implicitly by a
consumer: a producer that cannot name the exact kind must reject the construct.

### 3.4 Contract gap B — §10.5 capability atoms have no producer input

§10.5 requires that a function declaration record "its transitive effect summary
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
`CapabilitySetId` in a produced module is the empty set, §10.6 invariant 6 is
vacuous, and the manifest in §10.1 is never populated — which is precisely the
metadata the capability seal exists to carry.

**Proposed rule.** Capability atoms are derived, not invented:

- A function's capability summary is the image of its effect set under the
  canonical effect→capability kind mapping, intersected with the capsule
  manifest's declared grants. `CapabilityAtom.arguments` carry the manifest's
  scoping arguments (e.g. a path prefix) as `MetadataValue`s when the manifest
  provides them, and are empty when the grant is unscoped.
- The module manifest (§10.1) is populated from the module's exported entry
  points, with `effects` and `capabilities` the union over those entry points.
- A capsule with no manifest in scope (the standalone-file and unit-test case,
  which the effect gate already handles by passing an empty capability list)
  produces empty capability sets — an explicitly valid interned set per §10.5,
  not a silent gap.

**This derivation is a v0 approximation and must be labelled as one.** Deriving
capabilities as the image of the effect set makes them a pure *function* of
effects, which collapses the distinction SFEP-0016 §5 rests on — *effects say
what, capabilities say how much*. Under this rule capabilities carry no
information effects do not already carry, and the seal's novel claim degrades to
"effects, renamed." That is an acceptable v0 (it beats every `CapabilitySetId`
being empty, and it populates the §10.1 manifest so the carrier is exercised) but
it is **not** the end state, and nothing downstream may treat a derived
capability set as evidence that capability attenuation works.

*gated on: per-task capability context (SFEP-0016 §5) supplying scoped grants
that are not recoverable from the effect set.* When that lands, the derivation
becomes the default for functions with no explicit grant, not the rule for all
of them.

**Grant mismatch is a diagnostic, not an intersection.** The rule above says
"intersected with the capsule manifest's declared grants," which silently drops
an effect-implied capability the manifest does not grant. That is inconsistent
with this proposal's own fail-closed discipline (§3.1) and it discards exactly
the signal the seal exists to raise: a function whose effects require an
authority its capsule was never granted is an error, not an empty set. The
producer must emit a diagnostic and reject the module. The intersection stands
only where the manifest *narrows* a grant it does in fact make — scoping a
granted `io` to a path prefix, say — never where it is absent altogether.

### 3.5 Structured type expansion and string-seam retirement

§10.2.1 fixes the post-v0 structural representation and the single
source-resolution boundary. This section fixes how that boundary coexists with
the activation strategy here.

The L1 producer's `_map_scalar_type` is a bounded bootstrap seam, not the
template for aggregate support. It may parse scalar spellings while typed-SSA
v0 remains declaration-only, but no new function, generic, channel, or closure
case may be added to it. The structured-type migration retires it by making the
producer consume the versioned type table serialized in `.sfn-asm`. The
producer then structurally remaps module-local IDs into its merged module;
source type parsing remains exclusively in `resolve_program_types` before
typecheck.

During migration, a record may temporarily carry both `type_id` and retained
text only within one dependency-ordered leaf. The ID is authoritative, every
temporary bridge asserts that the ID is the same resolver-produced identity
carried by the source site's finalized `TypeSlot`, and the leaf names the
deletion that closes the bridge. It does **not** compare canonical rendering
byte-for-byte with source spelling: aliases intentionally collapse while the
original text remains diagnostic provenance. No bridge may choose semantics
from text when an ID is present. There is no permanent "prefer ID, fall back to
text" mode and no indefinite dual source of truth.

#### Current semantic sites and named retirement seams

The inventory below is grouped by semantic responsibility rather than by every
copy helper. A mechanical carrier that only preserves text retires with its
owning row.

| Order | Current semantic site | Risk carried by text today | Retirement seam |
|---:|---|---|---|
| 1 | `ast.sfn::TypeAnnotation.text`; `parser/token_utils.sfn::collect_type_annotation_until` | Parsed spelling is the only annotated-type carrier, including raw-pointer permission and union membership. | Add qualified declaration identities, module `TypeTable`/`TypeSlot`/`TypeRef`, and `resolve_program_types`; resolve `*`/`*const`/`*mut` and canonical unions structurally, keeping text/span only as source provenance. |
| 2 | Unannotated lets, HOF/lambda parameters, loop targets, and empty arrays in `typecheck_captures.sfn`, `typecheck.sfn`, and `emit_native_format.sfn` | Local inference produces ad-hoc type strings or `empty_array`/empty sentinels after the proposed resolution boundary. | Allocate inference slots, constrain them with structural IDs, intern inferred nodes, default/reject explicitly, and finalize every slot before native emission. |
| 3 | `typecheck_types.sfn::SymbolEntry.element_kind` / `declared_prim`; `typecheck.sfn` channel, future, task-array, primitive, and generic helpers | Sentinel equality and substring parsing decide assignability, channel sends, await results, and generic construction. | Store finalized IDs on symbols and query `Type`/`Applied` nodes; delete `element_kind`, `taskarr:*`, and primitive-string classifiers. |
| 4 | `ownership_checker.sfn::{is_owned_type,is_linear_type}` and ownership propagation for annotated/unannotated bindings | `OwnedBuf`, `Affine<T>`, and `Linear<T>` obligations are selected by spelling and separately re-inferred across moves. | Query constructor ownership descriptors plus structural `Reference` nodes; propagate finalized slots/IDs through ownership bindings. |
| 5 | `typecheck_import_loader.sfn::_native_function_is_tier1_decorator`, `typecheck_imports.sfn::_type_annotation_or_null_from_text`, and imported interface/function signature conversion | Imported parameter/return validity strips spaces, converts annotation text independently, and compares raw native strings. | Import the serialized type/declaration tables; convert and validate every imported signature from structural IDs/constructors, with source text retained only for diagnostics. |
| 6 | `emit_native_state.sfn`, `emit_native*.sfn`, `native_ir.sfn`, `native_ir_utils_parse.sfn`, and `native_ir_parser*.sfn` | `.sfn-asm` serializes raw annotations on parameters, lets, fields, and layouts, forcing every later consumer to parse again. | Define the versioned `.types` codec, then migrate declarations/instructions/layout carriers to IDs in a separate leaf. Retained debug spelling is non-semantic. |
| 7 | `llvm/monomorphize.sfn` and type-substitution helpers in `typecheck_types.sfn` | Generic applications are found, substituted, keyed, and mangled with strings. | Key specializations by `(QualifiedDeclarationId, TypeId[])`; substitute `TypeParameter` nodes and render linker names only after specialization identity is fixed. |
| 8 | `typed_ssa_produce.sfn::_map_scalar_type` and v0 `TssaType` | The producer reparses `.sfn-asm` spelling and cannot represent functions or applications. | Import/remap declarations, constructors, symbols, effect sets, type parameters, and child IDs; extend the model/renderer/verifier before widening the subset gate. |
| 9 | `llvm/types.sfn::{ParameterBinding, LocalBinding, StructFieldInfo}.type_annotation`; globals and member-resolution carriers | Binding identity, copying, and member resolution repeatedly inspect text. | Thread finalized `TypeId`s through LLVM-side carriers; keep `llvm_type` only as backend output. |
| 10 | `llvm/type_mapping.sfn::map_type_annotation`, `llvm/type_context*.sfn`, `emit_native_layout.sfn`, and member/literal layout queries | Source parsing and target layout decisions are interleaved and repeated in hot paths. | Add a distinct ABI adapter/cache keyed by `(TargetProfile, TypeId)`; it owns offsets, widths, pointer permissions/backend spellings, tagged-union payloads, and closure/channel layouts. |
| 11 | `llvm/expression_lowering/native/statement_suspension.sfn::is_mutable_borrow_annotation` | Suspension safety reconstructs `&mut` by stripping annotation text. | Read `Reference.mutable` from the parameter/local `TypeId`; raw pointers remain structurally distinct. |
| 12 | `emit_native_format.sfn` spawn/channel formatting, `typecheck_types.sfn` task-array markers, `llvm/lowering/{instructions_let,module_globals,emission}.sfn`, and `llvm/expression_lowering/native/{core_scopes,core_concurrency_lowering,core_call_resolution}.sfn` | `channel`, `channel:<kind>`, `spawn:<kind>`, and `taskarr:<kind>` encode identity, element/result width, and dispatch in strings. SFN-434 showed formatter spelling can change behavior. | Migrate channels in one leaf; separately add structural `Spawn`/`Await`/`JoinAll`/`Parallel` carriers over `Task<T>` and function IDs. Ask the ABI adapter for representation and delete every encoded sentinel. |
| 13 | `typecheck_captures.sfn`, `llvm/expression_lowering/native/{lambda_param_inference,core_call_resolution,core_call_lowering}.sfn`, `llvm/closures.sfn`, and the `__closure__` sentinel | Function and typed-pointer call signatures are inferred/balanced-parsed in several places; closure layout is mistaken for type identity. | First migrate expected-type/effect/call-kind checking to `Function` and `Pointer(Function)` IDs; separately add `MakeClosure`/`IndirectCall` carriers and ABI environment layout. |
| 14 | Union compatibility in `typecheck*.sfn` and `llvm/type_mapping.sfn::map_union_type` | Top-level `|` splitting separately decides membership and tagged payload layout. | Resolve a canonical flattened/deduplicated/ordered `Union` node; typecheck member IDs structurally and ask the ABI adapter for discriminant/payload layout. |

`symbols_index.sfn`, diagnostics, the formatter, and canonical debug renderers
may continue to output readable type text. They are projection consumers: they
must render from the resolved graph or retain source provenance, and their
output must not flow back into semantic passes.

#### Migration order and activation gates

The implementation leaves follow the table order with four gates:

1. **Resolve text once; infer structurally.** Land qualified identities, the
   graph/interner, explicit-annotation resolver, and inference slots as separate
   leaves before migrating a semantic consumer. Formatter variants of the same
   annotation resolve to the same node/ID; unannotated sites constrain slots
   with IDs and finalize without synthesizing type text.
2. **Transport without parsing.** Version `.sfn-asm`, serialize the table, and
   make the native parser reject missing or malformed IDs. Only then may the
   typed-SSA producer replace `_map_scalar_type`.
3. **Move semantic consumers.** Migrate typecheck, captures, ownership/import
   checks, unions, and generics first; then LLVM carriers, ABI layout,
   suspension safety, channels, function typing, and closure dispatch. Each
   slice deletes its local classifier or sentinel and adds a
   formatter-invariance regression.
4. **Delete the text lane.** Remove remaining semantic `type_annotation:
   string` fields, `_map_scalar_type`, channel/task sentinels, duplicate
   function-type splitters, and type-text substitution. A repository check
   prevents those names from returning outside parser/provenance/rendering
   allowlists.

The groomed implementation leaves are dependency-ordered as follows. `Ready`
means immediately pickable; `Blocked` means fully scoped but held by the named
predecessor relation, as required by `docs/conventions/linear-templates.md`.

| Issue | Estimate | Initial state | Depends on | Outcome |
|---|---:|---|---|---|
| SFN-588 | M | Ready | — | Add the qualified structural type graph, constructor ownership metadata, union node, and deterministic interner. |
| SFN-597 | M | Blocked | SFN-588 | Resolve explicit annotations, pointer permissions, and unions into `TypeRef`s once. |
| SFN-598 | M | Blocked | SFN-597 | Constrain and finalize inferred sites to structural IDs. |
| SFN-589 | M | Blocked | SFN-597, SFN-598 | Carry finalized IDs through typecheck symbols, expression metadata, and union compatibility. |
| SFN-599 | M | Blocked | SFN-589 | Carry IDs through captures and expected-type state. |
| SFN-600 | M | Blocked | SFN-589 | Classify ownership, linearity, and references structurally. |
| SFN-590 | M | Blocked | SFN-588 | Define and validate the versioned structural type-table codec. |
| SFN-601 | M | Blocked | SFN-590, SFN-597, SFN-598 | Migrate native-IR declarations, instructions, fields, and layouts to IDs. |
| SFN-605 | M | Blocked | SFN-601 | Convert and validate all imported function/interface signatures by structural identity. |
| SFN-591 | M | Blocked | SFN-589, SFN-601 | Key generic specialization and substitution by qualified IDs. |
| SFN-592 | M | Blocked | SFN-601 | Import/remap the graph into typed SSA and extend verifier ownership. |
| SFN-593 | M | Blocked | SFN-601 | Carry IDs through LLVM bindings and field carriers. |
| SFN-602 | M | Blocked | SFN-593 | Cache target ABI types, pointer forms, and union layouts by `(TargetProfile, TypeId)`. |
| SFN-603 | S | Blocked | SFN-593, SFN-600 | Check suspension borrows from structural reference IDs. |
| SFN-594 | M | Blocked | SFN-589, SFN-599 | Enforce function-value expected types by signature ID. |
| SFN-604 | M | Blocked | SFN-592, SFN-594, SFN-602 | Lower closure and indirect-call carriers through the ABI adapter. |
| SFN-595 | M | Blocked | SFN-589, SFN-592, SFN-602 | Remove channel element sentinels and lower admitted channel carriers. |
| SFN-606 | M | Blocked | SFN-589, SFN-592, SFN-595, SFN-602, SFN-604 | Replace spawn/task/join/parallel sentinels with structural concurrency carriers. |
| SFN-596 | S | Blocked | SFN-591, SFN-592, SFN-595, SFN-600, SFN-602–SFN-606 | Delete the text lane and enforce the formatter-invariance ratchet. |

The L1/L2/L3 activation layers remain ordered as §3.1 defines. Structured type
transport widens what the producer can accept, but does not authorize
per-function fallback, backend text injection, or a mixed typed-SSA/legacy
module. A widened subset must still produce and verify the whole selected
module or reject it.

#### Verifier and compile-time contract

`finalize_type_slots` and the versioned native-IR verifier run before any
structured module reaches a backend. They require:

- every slot is resolved, and every type ID, qualified declaration,
  constructor, type parameter, and effect row resolves in the correct owner;
  every closed application satisfies constructor arity;
- direct calls match the structural function signature; exact canonical effect
  sets define function-type identity, SFEP-0030 subsumption governs
  materialization/assignment, and a call site must cover the actual value row;
- generic specialization keys contain concrete IDs and substitutions leave no
  unresolved type parameter in a closed body; and
- imported signature checks, constructor ownership/linearity, raw-pointer
  permission, union membership, and mutable-reference suspension safety query
  structural IDs, never retained spelling.

For closures, indirect calls, channels, and structured concurrency, verifier
ownership follows §10.2.2. The native-IR verifier checks the structural
carriers while typed SSA rejects them as outside its subset. When a later
typed-SSA version admits `MakeClosure`, `IndirectCall`, `ChannelCreate`,
`ChannelSend`, `ChannelReceive`, `Spawn`, `Await`, `JoinAll`, or `Parallel`,
the producer emits that carrier and the typed-SSA verifier takes over exact
signature, element, task, and result checks. The target adapter separately owns
ABI/layout validation; layout compatibility never substitutes for semantic
equality.

Source text is resolved once per annotation. The module interner remains open
through type inference, but interns each distinct structural definition once.
After finalization, phases compare IDs in O(1), and target adapters memoize
layout/type lowering by `(TargetProfile, TypeId)`. Lowering hot paths must not
call source-type parsers, split generic arguments, normalize formatter
whitespace, or render a type and parse it back. L2 records resolution count,
unique intern count, inference-finalization count, and ABI-cache hits so a
corpus sweep can detect accidental per-use reparsing or reinterning before
wall-clock noise becomes the only signal.

## 4. Effect & capability impact

This is the mechanism by which effect and capability metadata first survives
past the front end as *data* rather than as strings consumed and discarded by
the effect gate. It adds no effect to the language and changes no effect-checking
rule. §3.4 is the point where the capability side of pillar 2 acquires a
machine-readable carrier; until it lands, typed SSA carries effects only.

The producer itself is `![io]`-free at its core (pure `.sfn-asm` text in,
`Module` out); only the CLI verb and the sweep command take `![io]`.

## 5. Self-hosting impact

Neither the original L1–L3 activation arc nor the structured-type migration
adds language syntax or requires a seed cut. Every slice is an ordinary
`compiler/src` change compiled by the currently pinned seed — the seed must
compile the new source, not contain the new capability. This is worth stating
explicitly because both arcs are dependency-ordered and could otherwise be
mistaken for seed-gated chains (`.claude/rules/seed-dependency.md`).

The original activation arc's first self-hosting risk comes from importing
`typed_ssa*.sfn` from `main.sfn`, which causes those ~2,360 lines to be lowered
to LLVM IR for the first time. The subtree's own header comments document two
#1389-class hazards it was written to avoid (`.push` on a struct-field array;
`.push` inside a struct-method body). `sfn check` cannot detect a recurrence —
only `make compile` can. The first slice must therefore budget for fixing
lowering failures in already-merged code, and `make compile` is a hard
acceptance criterion for it.

For that original arc, pipeline stages touched are **`.sfn-asm` consumption**
(new `typed_ssa_produce`), **CLI** (`cli/commands/emit.sfn`, a new
`cli/commands/dev_typed_ssa.sfn`), and **module wiring** (`main.sfn`). Its LLVM
lowering path is untouched until L3, and even then only through the existing
`lower_to_llvm_ir_from_text` entry point.

The structured-type migration in §3.5 has a broader but leaf-bounded
self-hosting surface: AST type carriers and post-import resolution, inference
and typecheck state, ownership/import checks, native-IR serialization and
verification, typed-SSA import, and LLVM binding/ABI consumers. Its principal
risks are a partially migrated dual source of truth, unresolved inference slots
crossing native emission, owner-ID remap collisions, and target layouts being
cached under the wrong type. The dependency gates and per-leaf `make compile`
checks keep each risk out of downstream phases until its authoritative carrier
and verifier are present.

## 6. Alternatives considered

**Per-function opt-in inside production modules.** Lower subset-passing
functions through typed SSA and fall back to the string path for the rest,
within one `.ll`. Rejected: it puts two lowering strategies inside one module,
so a defect in the new path can corrupt the self-hosting build even when the
feature is nominally off; and it forces the new path to reproduce the
module-level plumbing (globals, decorators, imports, runtime declares) that
§10.10 puts outside v0. All of the regression risk, none of the isolation.

**Shadow-only, permanently.** Produce and verify alongside the real lowering,
always discarding the result. Rejected as a terminal state — it never makes the
IR load-bearing and never builds the §10.9 oracle. Accepted as the *first* slice
(L1), because it is the cheapest way to force the producer to exist, be
imported, and self-host.

**Producing from the AST instead of `.sfn-asm`.** Avoids re-parsing opaque
expression strings, which is the single largest cost in the producer.
Rejected: it contradicts the §10.7 determinism rule and the §10.9 seam-3
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
- `compiler/tests/unit/type_resolution_test.sfn` — compact/canonical formatter
  variants, nested function/generic/channel applications, nominal identity,
  effect-row identity, immutable/mutable references, ownership wrappers,
  read-only/mutable raw pointers, `String`/`Dynamic`/`Null`, canonical unions,
  `T?` identity with `T | null`, aliases retained as provenance,
  unannotated/inferred slots, and deterministic interning.
- `compiler/tests/e2e/typed_ssa_structured_types_test.sfn` — `.sfn-asm`
  type-table round-trip, malformed-ID rejection, generic substitution, channel
  element equality, structural spawn/task/await/join-all/parallel carriers,
  post-v0 carrier gating, and closure-signature ABI verification.
- `compiler/tests/e2e/type_formatter_invariance_test.sfn` — compile the same
  function/generic/channel/closure fixture before and after `sfn fmt`; compare
  canonical type tables and observable behavior.
- Multi-module fixtures give two same-named declarations distinct qualified
  identities and round-trip imported decorator signatures structurally.
- Capture/ownership fixtures cover unannotated lets, HOF parameters, loop
  targets, empty-array defaulting, `OwnedBuf`/`Affine<T>`/`Linear<T>`, and an
  `&mut T` parameter live across suspension.
- Union fixtures cover reordered/duplicated/nested members, aliases,
  same-named imported members, compatibility, and tagged ABI layout.
- A repository check rejects new semantic reads of annotation text and encoded
  `channel:` / `spawn:` / `taskarr:` sentinels outside the temporary migration
  allowlist.

## 9. References

- §10 below (Typed SSA v0 normative contract, relocated from the retired
  SFEP-0015 §9): §10.5 (metadata), §10.2.1 (structured type expansion), §10.7
  (determinism), §10.9 (implementation and differential seams), §10.10 (v0
  non-goals).
- `docs/backend-independence.md` — staged roadmap and axis/track taxonomy
  (originally SFEP-0015 §8, §12).
- SFEP-0066 — the codegen-provider seam (originally the retired SFEP-0015
  `Backend` seam material).
- SFEP-0016 §3.2, §3.7 (why metadata must survive lowering — auditability, which
  SFEP-0066 §3.3 distinguishes from enforcement).
- SFEP-0030 §3.5 / §4 (function-value effect-row identity and closure ABI).
- SFN-452 (contract), SFN-454 (core + verifier + renderer).
- SFN-434 / PR #2681 (formatter spelling changed typed-channel lowering).
- `compiler/src/tensor_ir_link_harness.sfn` — prior art for making a partial IR
  execute through the existing lowering path.
- `.claude/rules/seed-dependency.md` — why this arc's ordering is not seed-gated.

## 10. Typed SSA v0 contract (normative)

This section fixes the typed-SSA handoff between `.sfn-asm` and backend
lowering. It was originally locked as SFEP-0015 §9 and relocated here when that
proposal was retired; the subsection numbers map one-for-one (`§9.N` → `§10.N`)
so existing citations rewrite mechanically.

§3.3 and §3.4 above identified and closed two gaps in this contract — the
missing conversion operation and the absent capability-atom producer input — and
those amendments are already folded into the normative text below (the `Convert`
instruction in §10.4 and the derived `CapabilityAtom` rule in §10.5). §10.2.1 is
the structured-type expansion that §3.5 governs.

In this section, **must** and **must not** are requirements on every producer,
verifier, transformation, renderer, and backend that claims typed-SSA v0
support.

Typed SSA sits between parsed `.sfn-asm` and backend-specific lowering:

```text
.sfn-asm -> typed-SSA producer -> verifier -> LLVM or native backend
```

The contract is deliberately smaller than either Sailfin source or LLVM IR. It
represents scalar computation and control flow, carries the security metadata
needed by the capability seal, and leaves target layout and machine operations
to a backend ABI adapter. It contains no LLVM type names, opcodes, attributes,
data-layout strings, or textual instruction fragments.

### 10.1 Ownership and identities

A `Module` owns, directly or through intern tables:

- a module identity and source-capsule identity;
- `Symbol`, `Type`, `EffectSet`, and `CapabilitySet` tables;
- external declarations and defined functions; and
- an optional module capability manifest derived from its entry points:
  `Manifest { entry_points: FunctionId[], effects: EffectSetId,
  capabilities: CapabilitySetId }`.

The following identities are unsigned integer handles, not source names:

| Identity | Scope | Meaning |
|---|---|---|
| `SymbolId` | module | One interned Sailfin semantic name. |
| `DeclarationId` | origin module | One declaration identity assigned during the deterministic declaration-collection pass. |
| `QualifiedDeclarationId` | consuming module | One interned reference to `(origin module identity, DeclarationId)` for a local or imported declaration. |
| `TypeConstructorId` | module | One nominal or compiler-intrinsic type constructor; introduced by the post-v0 structured-type extension in §10.2.1. |
| `TypeId` | module | One structurally interned type. |
| `EffectSetId` | module | One canonical set of effect atoms. |
| `CapabilitySetId` | module | One canonical set of capability atoms. |
| `FunctionId` | module | One declaration or definition. |
| `BlockId` | function | One basic block. |
| `ValueId` | function | One function parameter, block parameter, instruction result, or constant result. |

An identity must resolve in its owning scope and must not be reused for a
different entity. A backend must not infer semantics from the numeric value of
an identity. Moving an entity between modules or functions therefore requires
remapping every identity it owns or references.

Symbols are canonical UTF-8 strings interned by exact byte equality. They name
Sailfin semantics such as effects and capability kinds; they are not mangled
linker symbols or fragments of backend syntax.

The module, function, block, and instruction containers are ordered sequences.
Maps may accelerate lookup, but are not the semantic owner and must not decide
rendering or traversal order.

### 10.2 Target-neutral v0 types

Each `TypeId` names exactly one of:

```text
Unit
Bool
Int { width: 8 | 16 | 32 | 64, signed: boolean }
Float { width: 32 | 64 }
Pointer { pointee: TypeId?, address_space: integer }
```

`Unit` has no runtime value. `Bool` is a logical truth value; its storage width
is selected by the ABI adapter. Integer widths and signedness are semantic.
Floating-point values use IEEE-754 binary32 or binary64 semantics. A null
`pointee` denotes an opaque pointer. Address space zero is the ordinary Sailfin
process address space; other address spaces are reserved until a later contract
defines them.

Types are interned structurally: equal definitions in one module must have the
same `TypeId`, and unequal definitions must have different IDs. Source aliases
such as `int` are resolved before typed SSA and do not create distinct types.
Backend spellings such as `i64`, `double`, or `ptr` are not valid type
definitions in this IR.

Aggregates, slices, closures, function values, memory operations, exceptions,
and ownership operations are outside v0. A later version may add them without
changing the identity, block, metadata, or verifier rules defined here.

### 10.2.1 Structured type expansion (accepted post-v0 contract)

The next type expansion must not extend the scalar mapper with more source-text
classifiers. It adds structural nodes to the module-owned type graph:

```text
Type =
    Unit | Null | Bool | Int | Float | String | Dynamic
  | Pointer {
        pointee: TypeId?,
        permission: ReadOnly | Mutable,
        address_space: integer
    }
  | Reference { referent: TypeId, mutable: boolean }
  | TypeParameter { owner: QualifiedDeclarationId, index: integer }
  | Applied { constructor: TypeConstructorId, arguments: TypeId[] }
  | Union { members: TypeId[] }
  | Function {
        parameters: TypeId[],
        result: TypeId,
        effects: EffectSetId,
        call_kind: SailfinValue | CFunction
    }
```

`Null` is the absence-value type; it is distinct from `Unit`, which represents
`void`/no result. `String` is the semantic UTF-8 string type, independent of
its runtime pointer/length representation. `Dynamic` is the structural carrier
for the compiler and standard library's transitional `any` surface; it is a
top/interop type with explicit compatibility rules, not an opaque pointer
spelling. The ABI adapter owns its erased or boxed representation.

`Pointer` expands the v0 raw machine-address contract with source permission:
`*T` and accepted `*const T` spellings resolve to `ReadOnly`, while `*mut T`
resolves to `Mutable`. Its optional pointee remains semantic until the target
ABI deliberately erases it, and its address space follows §10.2. `Reference` is
a checked borrow and preserves the semantic distinction between `&T` and
`&mut T`; neither may be collapsed into `Pointer` merely because all four
forms are pointer-shaped in a target ABI.

`Applied` is the one representation for nominal and parametric types. A
non-generic struct, enum, or interface is an application with zero arguments.
`Array`, `Channel`, `Task`, `Affine`, `Linear`, `PII`, and `Secret` are
compiler-intrinsic constructors; `Channel<T>` therefore carries `T` as
`arguments[0]`, never as an `element_kind` string or a `channel:<kind>`
sentinel. A source alias resolves to its target before interning and does not
create a distinct `TypeId`. A nominal declaration remains distinct from another
declaration with the same fields: its `TypeConstructorId`, not its source
spelling or structural layout, owns that identity. A `TypeConstructorId`
resolves to either a fixed intrinsic constructor tag or a
`QualifiedDeclarationId`; a source name is never its identity.

Each constructor descriptor carries an ownership class:
`Copyable | Affine | Linear`. The intrinsic `Affine<T>` and `Linear<T>`
wrappers select their corresponding class. To preserve the shipped ownership
surface, declaration resolution assigns `Affine` to every nominal `OwnedBuf`
declaration currently recognized by the checker, records its
`QualifiedDeclarationId` in a bounded compatibility registry, and serializes
that class with imported declaration metadata. The registry audit covers the
runtime, capsule, and test declarations that currently rely on name-based
classification. All other constructors default to `Copyable` unless a later
language contract adds declaration syntax for ownership. This is the only
compatibility read of the resolved `OwnedBuf` declaration symbol; ownership
analysis queries the descriptor after alias resolution and must not recognize
`OwnedBuf`, `Affine`, or `Linear` from binding annotation text.

`Union` is the structural representation for shipped `A | B` value types.
Interning flattens nested unions, removes duplicate members, and orders the
remaining members by canonical structural encoding before hashing. A union
with one distinct member resolves to that member's `TypeId`; an empty union is
invalid. Source member order remains available only through provenance.
Optional syntax `T?` resolves to the same canonical `Union { T, Null }` node as
the explicit spelling `T | null`; it is not a distinct `Optional<T>`
constructor.
Intersection syntax is rejected in value-type resolution as specified by the
language reference and does not create a structural node.

A generic declaration owns its `TypeParameter` identities by declaration
identity and zero-based parameter index. A closed specialization is keyed by
the `QualifiedDeclarationId` plus an ordered `TypeId[]` argument vector.
Substitution produces structural nodes; it must not rewrite annotation text or
use a rendered type as a monomorphization key. Bounds constrain which
applications are admitted but are not part of the identity of a closed
application.

`Function` owns the semantic callable signature. Parameter and result IDs,
canonical effect row, and call kind participate in identity. This preserves
SFEP-0030's rule that two function-value types with unequal effect rows are not
identical, while effect-row subsumption remains an assignability rule rather
than identity equality. Capability grants are contextual authority and do not
participate in function-type identity.

`SailfinValue` denotes the ordinary `fn (A) -> R ![E]` value surface.
`CFunction` denotes an explicitly C-ABI callable signature. A source
`* fn (A) -> R` is a `Pointer` whose pointee is a `Function`, but the pointee's
call kind comes from the resolved declaration/context: ordinary typed Sailfin
function pointers use `SailfinValue`, while extern/C surfaces use `CFunction`.
The target adapter selects the platform calling-convention spelling. It must
not infer the distinction from an LLVM pointer type or merely from the
presence of a leading `*` in retained source text.

A closure does **not** introduce a distinct semantic type. Named functions and
capturing or non-capturing closures with the same `SailfinValue` signature have
the same `TypeId`. A closure value separately records its code `FunctionId` and
an optional environment-layout identity whose captured fields carry `TypeId`s.
The hidden environment parameter, uniform `{fn_ptr, env*}` pair, trampoline,
capture offsets, and environment allocation strategy are ABI/layout data, not
type identity.

The semantic/ABI ownership line is therefore fixed:

| Semantic type graph | Target ABI/layout adapter |
|---|---|
| Nominal constructor and ordered generic arguments | Mangled linker spelling for a specialization |
| `String`, `Dynamic`, and `Null` semantics | String storage, dynamic boxing/erasure, and null representation |
| Function parameters, result, effect row, and Sailfin-vs-C call kind | Register classes, hidden environment parameter, trampoline, and LLVM function type |
| Channel constructor and exact element `TypeId` | Element size/alignment, by-value vs by-reference transfer, and ownership flag |
| Read-only/mutable raw pointer vs immutable/mutable reference; pointee and address space | Target pointer width and backend spelling |
| Canonical union member IDs | Tagged-union discriminant and payload layout |
| Closure's function-value signature | `{fn_ptr, env*}` storage and capture-environment layout |

No target layout fact may create a new semantic `TypeId`, and no backend may
recover a semantic distinction from a layout fact.

#### Resolution and transport boundary

There is exactly one source-text resolution boundary:

```text
tokens -> AST TypeAnnotation{text, span}
       -> resolve_program_types(imported declarations)
       -> TypeRef{slot, source_span, source_spelling?}
       -> typecheck/inference -> finalize_type_slots
       -> .sfn-asm -> typed SSA -> backend
```

`resolve_program_types` runs after imports and declaration identities are known
and before any semantic typecheck. It resolves aliases, nominal names, generic
arguments, unions, raw-pointer permissions, function signatures/effect rows,
and compiler-intrinsic constructors, interns the result in the source module's
type table, and attaches `TypeRef`s to every declaration, parameter, binding
annotation, cast, and type-argument site. Each annotated reference starts with
`TypeSlot.Resolved(TypeId)`. `source_spelling` is optional diagnostic data. It
may be rendered in a message, source index, or formatter output; it must never
decide equality, assignability, dispatch, layout, mangling, or lowering.

Unannotated sites use the same carrier:

```text
TypeSlot =
    Resolved(TypeId)
  | Inference(InferenceVarId)
  | Error(DiagnosticId)
```

Typecheck creates an `InferenceVarId` for an unannotated binding, lambda/HOF
parameter, loop target, empty collection element, or other supported inference
site, accumulates structural constraints, and resolves the slot by interning
the inferred structural node in the same module table. This is not a second
source-text resolution boundary: inference consumes expression/type IDs, never
annotation spelling. A truly unknown or contradictory slot becomes `Error`;
it is not a semantic `TypeId`. `finalize_type_slots` runs before `.sfn-asm`
emission and rejects every live unresolved/error slot that would reach a
semantic consumer or backend. Existing defaulting (for example an unconstrained
empty numeric array) is represented as an explicit inference/default rule plus
provenance, never an `empty_array` string sentinel.

The shipped bare `channel(capacity)` surface likewise starts with an inferred
element slot. Constraints from a `Channel<T>` target, send, or receive resolve
it to `T`; if the currently permitted untyped surface remains unconstrained,
finalization applies the explicit compatibility default `Dynamic`, preserving
its pointer-width behavior without an empty `element_kind`. A later strict
channel proposal may remove that default, but this representation migration
must not silently change the shipped behavior.

The module interner is a service shared by resolution and inference. Each
distinct structural definition is interned once; the compile-time requirement
is not that the table is closed before typecheck, but that no later phase
reparses text or creates duplicate definitions. `LocalBinding`, capture
records, ownership analysis, and layout all receive the finalized slot/ID.

`.sfn-asm` carries a versioned structural type-table section and refers to its
entries by ID from functions, parameters, `let` instructions, fields, and
generic specialization records. Parsing that section reconstructs definitions;
it does not invoke a source-type parser. The typed-SSA producer may remap
module-local IDs into the merged module owner by structural interning in
deterministic module/declaration order. The remap covers qualified
declarations/type constructors, symbols, effect sets, type parameters, and
child type IDs before interning the parent. Remapping is not a second
resolution boundary: it consumes structural definitions and never source text.

Every serialized module records its canonical module/capsule identity and
declaration table. An import interns a `QualifiedDeclarationId` from the
origin-module identity and origin `DeclarationId`; same-named declarations from
different modules therefore remain distinct. Intrinsic constructors use fixed
tags shared by every module. Merge order can change local numeric handles only
after a complete owner-aware remap; it cannot change structural equality or
canonical rendering.

Interning keys use a canonical tagged encoding of the node and the canonical
identities of its children. Lookup may use a hash table, while the owned table
and deterministic walk remain the rendering order. A producer visits imported
modules in the existing deterministic merge order, declarations in source
order, and child types left-to-right. Equal definitions in one owner receive
one ID, so equality in typecheck and lowering is an O(1) integer comparison.
Serialization includes the structural definitions and canonical debug
renderings, never process addresses or hash-map iteration order.

### 10.2.2 Post-v0 semantic value and operation carriers

The type graph makes structured identities representable; it does not by itself
give a verifier values or operations to inspect. The post-v0 expansion therefore
adds these target-neutral carriers before typed SSA claims their verification:

```text
MakeClosure {
    signature: TypeId,
    code: FunctionId,
    captures: ValueId[]
} -> Function

IndirectCall {
    callee: ValueId,
    signature: TypeId,
    arguments: ValueId[],
    effects: EffectSetId,
    capabilities: CapabilitySetId
} -> result-or-Unit

ChannelCreate { channel_type: TypeId, capacity: ValueId? } -> Applied(Channel,T)
ChannelSend { channel: ValueId, value: ValueId } -> Unit
ChannelReceive { channel: ValueId } -> T
Spawn {
    worker: ValueId,
    signature: TypeId,
    task_type: TypeId
} -> Applied(Task,T)
Await { task_or_receive: ValueId, result_type: TypeId } -> T
JoinAll { tasks: ValueId, task_array_type: TypeId } -> Applied(Array,T)
Parallel {
    workers: ValueId[],
    signatures: TypeId[],
    result_type: TypeId
} -> Dynamic
```

`MakeClosure.captures` records semantic capture values and their existing
`ValueId -> TypeId` mapping. It does not record offsets or a target environment
struct. The ABI adapter derives a separate environment layout and the hidden
environment parameter from those types. `IndirectCall.signature` must resolve
to a `Function` whose call kind matches the callee representation. A closure
pair or ordinary Sailfin function value requires `SailfinValue`; a raw
`Pointer` may point to either a typed Sailfin signature or `CFunction`, and its
permission/pointee must agree with the callee's `TypeId`. The target adapter
then selects the corresponding indirect-call ABI.

`Spawn.task_type` must be `Applied(Task, [T])`, and its worker signature must
return `T`; the carrier replaces every `spawn:<kind>` encoding. `Await` checks
`Task<T>` or a channel receive against its explicit result `T`. `JoinAll`
accepts exactly `Applied(Array, [Applied(Task, [T])])` and returns
`Applied(Array, [T])`, replacing `taskarr:<kind>`. The currently shipped
`parallel [...]` surface exposes only an opaque joined-results handle, so its
carrier result is the explicit transitional `Dynamic` type; each worker
signature is nevertheless structural, and a later typed result surface must
replace `Dynamic` with a specified constructor rather than another sentinel.

Until a typed-SSA version admits one of these operations, the versioned
native-IR type-table verifier owns its structural checks and the typed-SSA
subset gate rejects that operation. Once admitted, the typed-SSA producer emits
the carrier and the typed-SSA verifier assumes ownership. There is never a rule
requiring the v0 verifier to inspect an operation v0 cannot represent.

### 10.3 Functions, blocks, and values

A function declaration contains:

```text
Function {
    id: FunctionId
    symbol: SymbolId
    parameters: TypeId[]
    result: TypeId
    effects: EffectSetId
    capabilities: CapabilitySetId
    linkage: Internal | Exported | External
}
```

A definition adds an ordered, non-empty block sequence. Its first block is the
entry block. The entry block parameters are the function parameters, in
signature order; their `ValueId`s are the function's parameter values. An
external function has a declaration and no blocks.

Every non-entry block has zero or more typed block parameters. Branch operands
supply those parameters, replacing backend-specific phi nodes. Block
parameters are defined simultaneously at block entry. Instruction results are
defined after their operands and each result has exactly one `TypeId`. Values
are immutable and have exactly one definition.

### 10.4 Instructions and terminators

The v0 instruction set is:

```text
ConstBool(value) -> Bool
ConstInt(value) -> Int
ConstFloat(bits) -> Float
Unary(op, value) -> scalar
Binary(op, left, right) -> scalar
Compare(predicate, left, right) -> Bool
Convert(kind, value) -> scalar
Call(function, arguments, effects, capabilities) -> scalar-or-Unit
```

`Unary`, `Binary`, and `Compare` use typed-SSA op and predicate enums, not
backend strings. `UnaryOp` contains `Negate`, `BooleanNot`, and `BitwiseNot`;
`BinaryOp` contains `Add`, `Subtract`, `Multiply`, `Divide`, `Remainder`,
`BooleanAnd`, `BooleanOr`, `BitwiseAnd`, `BitwiseOr`, `BitwiseXor`,
`ShiftLeft`, and `ShiftRight`; `ComparePredicate` contains `Equal`, `NotEqual`,
`Less`, `LessEqual`, `Greater`, and `GreaterEqual`. Each case has Sailfin
language semantics for its operand type. v0 adds neither wrapping integer nor
relaxed floating-point operations; either requires a distinct enum case in a
later contract. The verifier rejects an operation whose operand or result types
are not admitted by that enum case. Overflow and floating-point behavior must
not be inferred from a backend default.

`ConvertKind` contains `IntTruncate`, `IntSignExtend`, `IntZeroExtend`,
`IntToFloat`, `UnsignedIntToFloat`, `FloatToInt`, `FloatToUnsignedInt`,
`FloatTruncate`, `FloatExtend`, `PointerToInt`, `IntToPointer`, and
`PointerCast`. Integer truncation requires a strictly narrower integer result.
Sign and zero extension require a strictly wider signed or unsigned pair,
respectively. The integer/float cases encode signedness in their kind and admit
only the corresponding signed or unsigned integer type. Float truncation and
extension require a strictly narrower or wider float result. Pointer/integer
conversions require the source and result categories named by the kind;
`PointerCast` requires two pointer types. Consumers must never select a
conversion kind implicitly. As with arithmetic behavior, a consumer may not
infer conversion behavior from a backend default.

`Call` is direct in v0: `function` is a `FunctionId`. Its arguments match the
callee signature exactly. A non-`Unit` call produces one result; a `Unit` call
produces none. Indirect calls and variadic calls require a later IR version.

Every block ends with exactly one of:

```text
Branch(target, arguments)
CondBranch(condition, then_target, then_arguments, else_target, else_arguments)
Return(value?)
Unreachable
```

A terminator is not an instruction and produces no value. No instruction may
follow it. `CondBranch.condition` has type `Bool`. Each branch argument list
matches its target block parameters in arity and type. `Return` has no value
for a `Unit` result and exactly one value of the declared result type otherwise.
`Unreachable` asserts that control cannot continue; it does not excuse invalid
instructions earlier in the block.

### 10.5 Effect, capability, and provenance metadata

Effects and capabilities are semantic data, not comments or backend
attributes. Both are interned canonical sets:

```text
EffectAtom { name: SymbolId }
CapabilityAtom { kind: SymbolId, arguments: MetadataValue[] }
MetadataValue = Bool | Int | String | Symbol
```

Atoms and their arguments use Sailfin semantic names. They must not contain
LLVM syntax or target instruction names. Sets contain no duplicates and are
ordered by the canonical byte encoding of their atoms. An empty set is a valid
interned set.

Metadata attaches at these exact points:

- a function declaration or definition records its transitive effect summary
  and required capability summary;
- every `Call` records the callee effects and required capabilities visible at
  that call site; and
- the optional module manifest records the union selected from designated
  entry points.

Pure scalar instructions and control-flow terminators do not carry effect or
capability sets. Source spans and a producer-defined provenance card may attach
to any function, block, instruction, or terminator for diagnostics, but are
non-semantic and must not affect verification or code generation.

A call's effect and capability sets must be supersets of the referenced
callee's declared sets. A defined function's sets must be supersets of every
call in its body. This permits a producer to carry a conservative summary while
forbidding a backend from seeing less authority than the program requires.

Transformations must preserve security metadata monotonically:

- cloning or moving a call preserves its sets;
- replacing a call preserves supersets of the original sets unless a verified
  analysis recomputes an equal or smaller summary from the new callee;
- merging call paths uses set union;
- splitting a function copies the relevant call metadata and recomputes both
  function summaries before verification; and
- deleting unreachable code may remove its metadata only when the associated
  call is deleted.

No renderer or backend may silently drop these sets. A backend that cannot
consume them must reject the module rather than treating it as unannotated.

### 10.6 Verifier invariants

The typed-SSA verifier runs before any backend and must reject a module unless
all of the following hold:

1. Every ID resolves in the correct owner, all module symbols are unique, and
   all interned types and metadata sets are structurally canonical.
2. Every definition has a valid type; every use refers to one definition in
   the same function; and that definition dominates the use. Block parameters
   dominate their block, including all instructions and its terminator.
3. The entry parameters exactly match the function signature. Every branch
   target exists and every branch argument matches the corresponding block
   parameter in arity and type.
4. Every block has exactly one final terminator and no earlier terminator.
   Every block other than the entry is reachable from a named predecessor;
   unreachable regions are represented with an `Unreachable` terminator, not
   orphan blocks.
5. Each instruction satisfies its operation-specific arity and typing rules.
   Constants fit their declared width, calls match the callee signature, and
   returns match the function result.
6. Call and function effect/capability summaries satisfy the superset rules in
   §10.5, and the module manifest, when present, covers every designated entry
   point.
7. The ordered containers and assigned IDs satisfy the deterministic
   construction rules in §10.7.

The post-v0 structured-type extension adds these fail-closed rules:

8. Every qualified declaration/type constructor and `TypeParameter` owner/index
   resolves, every `Applied` node satisfies constructor arity, and every
   `Union` is non-empty and canonically flattened/ordered/deduplicated, and every
   function signature references valid type and effect-set IDs. A serialized
   or typed-SSA module contains no inference/error slot; a closed application
   contains no unresolved type parameter.
9. Direct calls match the referenced declaration's exact function signature.
   When the IR version admits `IndirectCall`/`MakeClosure`, those carriers match
   a `Function` type and preserve its exact canonical effect set. Type identity
   uses exact effect-set equality; materialization/assignment may apply
   SFEP-0030 subsumption; a call site is checked against the actual function
   value row. A closure's code signature matches after the ABI adapter accounts
   for the hidden environment parameter.
10. When the IR version admits the channel/concurrency carriers in §10.2.2,
    construction, send, receive, spawn, await, join-all, and parallel agree on
    exact channel/task/function/result `TypeId`s. Backend layout compatibility
    is checked separately and cannot substitute for semantic identity.
11. A verifier or backend receiving unresolved source type text, an unversioned
    type-table reference, or a missing type ID rejects the module. There is no
    text-reparse fallback.

Verification is fail-closed and side-effect free. Diagnostics identify the
module, function, block, offending ID, and violated invariant. A failed module
must not reach LLVM rendering, native instruction selection, object emission,
or linking.

### 10.7 Determinism and textual rendering

The producer assigns IDs in one deterministic walk:

1. intern types and metadata by canonical structural encoding;
2. visit functions in `.sfn-asm` declaration order after the existing
   deterministic module merge;
3. visit blocks in structured-lowering order, with the entry first and branch
   successors in source order; and
4. assign `ValueId`s to entry parameters, then block parameters and instruction
   results in block order.

Intern tables render in canonical structural order. Functions, blocks, and
instructions render in their owned sequence. Hash-map iteration, filesystem
enumeration, addresses, thread completion order, and backend-generated names
must not affect IDs or output.

For the post-v0 nodes in §10.2.1, the renderer spells constructors by qualified
declaration identity, type parameters by qualified owner and index,
applications with ordered child IDs, and function types with the canonical
effect-set ID and call kind. Closure environment layouts render in a separate
ABI/debug section and never alter the function type's rendering.

Every implementation provides a canonical UTF-8 debug renderer. It is not an
input language in v0, but identical verified modules must render byte-for-byte
identically, including one `\n` line ending after the final line. The renderer
uses typed-SSA names (`t0`, `v0`, `b0`) and semantic op names, never LLVM
sigils or instruction text. For example:

```text
module demo
type t0 = bool
type t1 = int(signed,64)
effects e0 = {}
capabilities c0 = {}
fn choose(v0:t0, v1:t1, v2:t1) -> t1 effects=e0 capabilities=c0 {
  b0(v0:t0, v1:t1, v2:t1):
    cond_branch v0, b1(v1), b2(v2)
  b1(v3:t1):
    return v3
  b2(v4:t1):
    return v4
}
```

Metadata values use JSON escaping in the renderer. Floating constants render
their exact bit pattern, not a locale-dependent decimal. Rendered IDs follow
the deterministic assignments above and are dense from zero within their
scope.

### 10.8 Target boundary and first target

Typed SSA is target-neutral. It does not contain a target triple, register
class, calling-convention spelling, object format, relocation, or data-layout
string. A backend combines a verified module with a separate target profile and
the runtime ABI.

The first supported native profile is **Linux x86-64, little-endian, SysV
AMD64**. Its ABI adapter maps logical `Bool`, fixed-width scalars, pointers,
function parameters, calls, and returns to the layouts and symbol contracts in
`site/src/content/docs/docs/reference/runtime-abi.md`. That mapping must not
rewrite the typed-SSA module. LLVM lowering is another adapter over the same
contract; LLVM spellings begin only after the verified handoff.

### 10.9 Implementation and differential-testing seams

The next implementation leaf owns four independently testable seams:

1. **Core model and renderer:** module-owned identities, intern tables, scalar
   instructions, terminators, metadata, and canonical debug snapshots.
2. **Verifier:** focused negative tests for every invariant in §10.6, plus
   positive scalar branch/call/return fixtures.
3. **Producer boundary:** a lowering pass from the existing `NativeFunction`
   and string-expression `.sfn-asm` model into verified typed SSA. Unsupported
   constructs fail with a diagnostic; they do not bypass typed SSA or inject
   backend text.
4. **Backend boundary:** LLVM and native consumers accept only a verified
   module plus a target profile. Backend-specific operands, types, and
   instructions are created on the consumer side of this boundary.

The structured-type expansion adds four ordered seams:

5. **Front-end resolution boundary:** source annotations resolve once into a
   module type graph before semantic typecheck.
6. **Artifact transport:** `.sfn-asm` serializes the graph and references IDs;
   the native-IR parser reconstructs and validates it without source parsing.
7. **Semantic consumers:** typecheck symbols, generic specialization, channels,
   function values, and closures use IDs exclusively.
8. **ABI consumers:** layout and backend adapters cache target representations
   by `(TargetProfile, TypeId)` and reject unresolved IDs.

The existing LLVM backend remains the differential oracle. Each construct
ported to typed SSA uses the same source fixture to produce:

- canonical typed-SSA output;
- verified LLVM output and program behavior; and
- on Linux x86-64, native output with the same exit status, stdout, stderr, and
  externally visible state.

Tests also compare normalized function and call effect/capability sets before
backend lowering. Backend-specific object bytes, symbol ordering not fixed by
the runtime ABI, debug addresses, timing, and optimization quality are not
differential-equality requirements.

### 10.10 v0 non-goals

Typed-SSA v0 does not:

- replace `.sfn-asm` as the compiler's serialized high-level artifact;
- model aggregates, closures, memory, ownership, exceptions, concurrency,
  indirect calls, or variadics;
- define optimization passes, register allocation, instruction selection,
  object emission, linking, or a textual parser;
- expose LLVM types, attributes, intrinsics, or instruction strings; or
- claim the native backend, capability seal, or typed-SSA implementation has
  shipped.

The accepted post-v0 shape in §10.2.1 does not change those v0 claims. It fixes
the next representation and migration boundary so implementation leaves cannot
grow another textual type channel while the v0 activation work proceeds.
