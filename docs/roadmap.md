# Sailfin Roadmap

Updated: October 15, 2025  
Owners: Sailfin Core Team

This roadmap pairs with `docs/status.md`. Update status first, then record
strategy changes here. Each section is designed so an agent can pull the next
actionable item, mark it complete, and move to the following bucket; creating new items as needed - this means that active workstreams need to be upated regularly.

## Active Workstreams (Do Now)

1. **Stage2 Backend Delivery**

_Near-term (unlock compiler parity & safety checks)_

- [x] Track borrow lifetimes across control-flow merges so Stage2 can release borrows at scope exits, accept reborrows that shorten lifetime regions, and reject borrows that would outlive their owners. Covered by `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_allows_scoped_reborrow` and `...::test_native_llvm_execution_reports_borrow_lifetime_violation`.
- [ ] Insert SSA merges / `phi` nodes for locals that span `if`/`match` merges and loop bodies to keep generated IR valid under aggressive optimisation.
  - [x] Mutation capture: extend `BlockLoweringResult` and `LocalBinding` plumbing in `compiler/src/native_llvm_lowering.sfn` to return a `LocalMutation` list (`{name, llvm_type, value_name, span, originating_label}`) from `lower_instruction_range`; populate it in `lower_let_instruction` and the reassignment path in `lower_expression_statement`. Add a lightweight stage2 lowering unit test that builds a synthetic block and asserts the recorded mutations without touching emitted IR.
  - [x] Metadata propagation: thread the mutation list through `lower_if_instruction`, `lower_loop_instruction`, `lower_for_instruction`, and `lower_match_instruction` so each structure advertises the locals it mutates and the label that last defined them. Ensure collectors (`collect_if_structure`, `collect_loop_structure`, `collect_match_structure`) leave the metadata intact. Validated by `compiler/tests/test_stage2_mutation_capture.py::test_mutations_propagate_through_if_then`, `test_mutations_propagate_through_if_else`, `test_mutations_propagate_through_loop`, and `test_mutations_propagate_through_match`.
  - [x] Straight-line `if` joins: introduce an `emit_phi_merges` helper invoked after the merge label when an `if` without `else` falls through. Generate `phi` nodes for each mutated local, using the base block and the `then` exit label recorded in metadata, then store the phi result back through the local pointer. Validated by `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_emits_phi_for_straight_line_if` which confirms phi nodes are emitted, LLVM IR verifies, and behavior is correct for both conditional branches.
  - [x] Full `if`/`else` merges: re-use the helper to union mutations from both arms, skip terminated branches, and emit two-input phis. Add coverage for a function where both arms mutate a shared local (and another unique local) before reconverging, confirming the right value is observed after the merge. Validated by `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_emits_phi_for_if_else` which exercises both shared mutations (where both branches modify the same local) and partial mutations (where each branch modifies unique locals), ensuring phi nodes correctly merge values from both branches.
  - [x] Loop header phis: restructured `lower_loop_instruction` to create explicit preheader, header, body, latch, and exit labels. For each local mutated in the body and live on exit, emit header phis fed by the preheader definition and the latch definition while ensuring `continue` jumps target the latch. The `lower_for_instruction` already had the proper structure (header, body, increment/latch, exit) and `continue` targeting. Regression coverage: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_runs_program` includes both `loop_and_match` (which mutates `total` and `current` accumulator locals) and `sum_for` (which mutates `total` accumulator local in a for loop with `continue`/`break`).
  - [x] Match merges: in `lower_match_instruction`, accumulate mutations per arm (including guards) with their terminating label, then emit a multi-input phi for each live-out local at the shared merge label. Terminated arms are ignored. Covered by `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_emits_phi_for_match` with match expressions where different arms assign distinct values before falling through (both shared mutations across all arms and partial mutations unique to specific arms).
  - [ ] Consolidation and docs: factor shared phi assembly helpers, re-run the Stage2 suite (`make test PYTEST_ARGS=-m stage2`) to gate the change, document the completed behaviour in `docs/status.md`, and call out the new execution fixtures added to `compiler/tests/test_native_llvm_execution.py`.
- [ ] Lower enum aggregates (including payload storage) into LLVM so runtime helpers can consume native values without Python bridges.
  - [ ] Define the tagged-union LLVM layout (tag + payload pointer/inline storage) and thread it through the type context.
  - [ ] Emit enum constructors/destructors that populate the canonical layout and surface helpers to native lowering.
  - [ ] Extend match lowering to destructure enum operands without falling back to Python, with execution coverage in `compiler/tests/test_native_llvm_execution.py`.
- [ ] Lower enum payload storage (including recursive variants) into LLVM so Stage2 can materialise compiler AST enums without Python fallbacks.
  - [ ] Support inline payload emission for primitives/struct references and validate via struct-enum fixtures.
  - [ ] Implement heap-indirected payload support for recursive/self-referential variants, reusing runtime allocators.
  - [ ] Add regression tests covering mixed recursive/non-recursive variants and ensure borrow tracking tolerates the new storage paths.
- [ ] Introduce interface trait objects (data pointer + vtable) and emit vtables for each `implements` pair so interface values can be passed to functions and stored in locals.
  - [ ] Define the trait-object ABI (data pointer layout + vtable schema) and emit descriptors during native lowering.
  - [ ] Generate vtable structs for every concrete `implements` declaration and write them into the module data section.
  - [ ] Add unit coverage ensuring interface locals round-trip through the runner and expose diagnostics for missing vtable entries.
- [ ] Lower method dispatch through interface values (boxing on assignment, indirect calls on `.method()`), with regression coverage using `examples/basics/interfaces.sfn` in the LLVM suite.
  - [ ] Box concrete values into trait objects when assigning to interface-typed locals/parameters.
  - [ ] Modify call lowering to route `.method()` through the vtable slot, passing the data pointer as the implicit receiver.
  - [ ] Extend the LLVM execution suite with the interface example to validate dynamic dispatch end-to-end.
- [ ] Surface enum array metadata in LLVM lowering once layout descriptors exist, enabling typed iteration over tagged aggregates.
  - [ ] Emit array element descriptors for enum element types during module lowering.
  - [ ] Teach the native runner to expose the metadata to runtime helpers without pointer fallbacks.
  - [ ] Add smoke tests iterating over enum arrays to verify metadata-driven access.
- [ ] Share layout descriptors across modules by emitting/importing per-unit layout manifests so Stage2 can resolve referenced structs/enums defined in dependencies without pointer fallbacks.
  - [ ] Emit layout manifests alongside each module artifact and persist them in the build output.
  - [ ] Load and merge dependency manifests during lowering so cross-module references have concrete layouts.
  - [ ] Cover cross-module struct/enum usage with a stage1 + stage2 regression harness.
- [x] Canonicalise ABI metadata for builtin/runtime types (`Token`, parser state, `runtime.StructField`, etc.) and surface it to the native emitter so bootstrap helpers stop returning pointer-layout warnings. Validation: `compiler/tests/test_stage1_pipeline.py::test_stage1_builtin_ast_layouts_do_not_warn`, `compiler/tests/test_runtime_prelude.py::test_runtime_prelude_collection_helpers`.
  - [x] Inventory builtin/runtime types used by the compiler and define canonical ABI descriptors.
  - [x] Teach the native emitter to consume the canonical descriptors before defaulting to pointer layouts.
  - [x] Update diagnostics/tests to assert the absence of pointer-layout fallbacks for the covered types.
- [ ] Add cross-module layout regression coverage (stage1 pipeline + stage2 LLVM execution) to lock the merged-manifest behaviour and guard against future pointer fallback regressions.
  - [ ] Build a minimal multi-module fixture that exercises shared structs/enums through both pipelines.
  - [ ] Wire the fixture into `make test` (stage1) and the native LLVM execution suite.
  - [ ] Document the coverage expectations in `docs/status.md` once the suite lands.

_Mid-term (runtime capabilities & effect enforcement)_

- [ ] Introduce capability-aware intrinsics (IO, model, net) for the native backend so effect enforcement survives codegen.
- [ ] Bridge capability adapters (`fs`, `http`, `serve`, `spawn`, channel primitives) into stage2 lowering with symbol declarations and smoke coverage in `compiler/tests/test_native_llvm_execution.py`.
- [ ] Extend the stage2 runner to register capability adapters (filesystem, HTTP, model, serve, spawn, channel primitives), enforcing capability manifests when delegates execute and adding runtime smoke tests that exercise each adapter via native LLVM binaries.
- [ ] Extend suspension-conflict tracking to coroutine lowering once `async fn`/generator support lands, ensuring resumable frames cannot hold mutable borrows across `yield`/resume boundaries.

_Final delivery (self-hosting, automation, distribution)_

- [ ] Bootstrap stage2 self-hosting: compile the Sailfin compiler with stage2 artifacts, execute the stage2-built binary end-to-end, and gate CI on the self-hosted pipeline as soon as the mid-term runtime work is passing.
- [ ] Wire CI to run the stage2 smoke binary and self-hosted compiler on every PR once the self-hosting milestone is green, promoting stage2 to the default gate while retaining stage1 as a fallback job.
- [ ] Package stage2 artifacts alongside stage1 in releases after CI is enforcing the self-hosted pipeline, ensuring downstream projects can install the native toolchain.

2. **Runtime & FFI Foundations**

- [ ] Capability adapter injection — Wire the new runtime capability bridges to host-provided adapters in the stage2 runner so filesystem, HTTP, and model calls no longer depend on `runtime_support.py`; ship adapter docs alongside samples.
- [ ] Runtime type metadata — Emit module descriptors so `check_type` no longer relies on `runtime.resolve_runtime_type`; update `docs/runtime_audit.md` once the bridge is removed.
- [ ] Port remaining Python-only helpers (async runtime glue, capability shims) into Sailfin modules now that enum/struct formatting is stable.
- [ ] Concurrency substrate — Prototype async scheduling / task primitives required by `spawn`, `serve`, and `pipeline` execution in self-hosted builds.
- [ ] Unicode normalization helpers — Expose NFC/NFD routines in the Sailfin runtime so locale-aware casing and future stage2 pipelines stay Python-free.

5. **Toolchain De-Pythonisation**

- [ ] Native emission milestone — Flip the default stage1 build to target the stage2 executable backend once minimal LLVM/WASM runners exist, keeping a Python fallback only for regression hunting.
- [ ] Sailfin-native CLI ("sfn") — Reimplement the `sailfin-stage1` launcher, installer, and packaging flow without invoking Python entrypoints; ship the CLI as a Sailfin binary that exercises the runtime prelude directly.
- [ ] Release pipeline guardrails — Update CI to build the compiler, runtime, and examples using only Sailfin-generated artifacts and fail if Python runtime shims (`runtime_support.py`, bootstrap scripts) are invoked.
- [ ] Test harness migration — Port the stage1 pytest coverage to an equivalent Sailfin-native smoke/integration suite so compiler regressions can be detected without Python tooling.

3. **Diagnostics Parity**

- [ ] Expand `typecheck.sfn` to cover type inference gaps (generics, interface conformance) and port the historical stage0 diagnostics.
  - [x] Locked regression coverage for duplicate symbol diagnostics across structs, enums, interfaces, models, and type parameters via `compiler/tests/test_stage1_typecheck_duplicates.py`.
  - [x] Implements clauses now enforce interface type argument counts, rejecting missing or extra generics with coverage in `compiler/tests/test_stage1_typecheck_interfaces.py::test_struct_missing_type_arguments_for_generic_interface_reports_diagnostic` and `compiler/tests/test_stage1_typecheck_interfaces.py::test_struct_mismatched_type_argument_count_reports_diagnostic`.
- [ ] Surface structured diagnostics with source snippets in the stage1 CLI and artifact logging path - if sfn stage2 cli has already landed, implement there instead.
- [ ] CLI effect fixer — Teach the stage1 CLI to apply suggested `![effect]` annotations automatically when developers accept fix prompts if sfn stage2 cli has already landed, implement there instead.

4. **Registry & Capsule Workflow**

- [ ] Manifest schema — Finalise capsule (`sail.toml`) and fleet (`fleet.toml`) formats, aligning with `docs/proposals/package-management.md`.
- [ ] CLI integration — Implement `sfn add`, `sfn run`, and `sfn publish` against `registry.sailfin.dev` using the Sailfin toolchain once native builds are viable.
- [ ] Provenance channels — Surface model generation cards with cost / latency metadata in pipeline outputs.

## Ready Next (Pull When Active Stream Clears)

- [ ] Stage1 release candidate — Criteria and staging plan for shipping the Sailfin compiler/runtime bundle as a supported release channel.
- [ ] `sfn` package manager release plan — Define rollout steps once CLI integration lands.
- [ ] Registry authentication & signing — Add capability manifests and signed provenance to registry flows.
- [ ] Prototype WebAssembly emission from `.sfn-asm` once the LLVM backend is feature-complete, reusing the existing smoke harness for validation.

## Exploration Backlog (Research / Design)

- [ ] Introduce an `unsafe` capability in the stage2 runtime, lowering `unsafe extern` declarations (e.g., `malloc`) and gating raw pointer dereference to lexical `unsafe {}` blocks.
- Model engines & training — Continue design in `docs/proposals/model-engines-and-training.md`; merge into Active once registry workflows exist.
- Tensor and GPU effects — Define `Tensor<T>` primitives and effect propagation for GPU workloads.
- Notebook & LSP tooling — Prototype interactive editing, effect-aware debugging, provenance overlays.

## Completed Items

Move checked tasks here with links to PRs / status updates for traceability.

- [x] Extend `.layout` inference to cover optional fields, nested enums, and recursive aggregates so Stage2 no longer defaults compiler AST structs to pointer layouts (silencing the `defaulting to pointer layout` warnings). Regression coverage: `compiler/tests/test_stage1_pipeline.py::test_native_backend_infers_recursive_layouts`.
- [x] Bridge Sailfin runtime helpers (console + `sleep`) as callable LLVM symbols so stage2 programs can invoke the existing runtime prelude. (Regression coverage: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_invokes_runtime_console`.)
- [x] Emit LLVM struct layouts and method bodies from the recorded descriptors, covering field access, struct literals, and method calls. (Regression coverage: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_calls_struct_methods`.)
- [x] Stage2 lifetime region metadata — LLVM lowering now publishes borrow lifetime scopes via `LoweredLLVMResult.lifetime_regions`, carrying binding names, mutability, scope identifiers, and source spans so diagnostics and future analyses can reason about scope exits without re-scanning `.sfn-asm`. Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_emits_lifetime_regions`; behaviour documented in `docs/status.md`.
- [x] Stage2 borrow lifetime enforcement — LLVM lowering now cross-checks recorded lifetime regions against their base scopes and emits `llvm lowering: borrow ... escapes lifetime ...` diagnostics when borrows would outlive their owners. Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_reports_borrow_lifetime_violation`; behaviour documented in `docs/status.md`.
- [x] Stage1 diagnostic snippets — Stage1 CLI output and native lowering diagnostics now render caret-highlighted source snippets alongside messages. Validation: `compiler/tests/test_stage1_diagnostics.py::test_missing_effect_diagnostic_includes_source_snippet`; behaviour documented in `docs/status.md`.
- [x] Struct interface conformance — Stage1 type checking now verifies that structs implement every interface member they claim, including generic instantiations. Validation: `compiler/tests/test_stage1_typecheck_interfaces.py::test_struct_missing_interface_member_reports_diagnostic`, `compiler/tests/test_stage1_typecheck_interfaces.py::test_struct_missing_generic_interface_member_reports_diagnostic`; behaviour documented in `docs/status.md`.
- [x] Stage2 move diagnostics spans — `.sfn-asm` now carries source-span metadata through the native IR and LLVM lowering so use-after-move errors surface line/column ranges in diagnostics. Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_reports_use_after_move` and `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_reports_use_after_move_for_affine_array` assert span strings.
- [x] Stage2 parameter span metadata — `.param` entries now emit source spans so suspension diagnostics cite mutable borrow parameters alongside suspension sites. Validation: `compiler/tests/test_stage1_pipeline.py::test_native_backend_emits_parameter_spans` locks emission, while `compiler/tests/test_native_llvm_execution.py::test_native_llvm_rejects_mutable_borrow_across_await` asserts the diagnostics. Behaviour documented in `docs/status.md`.
- [x] Stage2 suspension-conflict spans — LLVM lowering threads borrow initializer spans and suspension instruction spans into mutable-borrow suspension diagnostics so both sites show up in error messages. Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_rejects_mutable_borrow_across_await`; behaviour documented in `docs/status.md`.
- [x] Stage2 suspension conflict diagnostics — LLVM lowering now enforces the `!mut ⊄ !async` lattice rule by rejecting `await`/`yield` sites that keep mutable borrows or parameters alive. Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_rejects_mutable_borrow_across_await` and `compiler/tests/test_native_llvm_execution.py::test_native_llvm_allows_await_without_mutable_borrow`; behaviour documented in `docs/status.md` and `docs/spec.md`.
- [x] Stage2 capability manifest aggregation — Stage2 lowering now merges borrow effects with declared capabilities and publishes the combined requirements via `LoweredLLVMResult.capability_manifest`. Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_capability_manifest_propagates_composite_effects`; behaviour documented in `docs/status.md`.
- [x] Stage2 capability manifest enforcement — `runtime.stage2_runner.Stage2Runner` now consumes the manifest before executing entry points, issuing capability grants and raising `PermissionError` when native helpers exercise effects not present in the grant. Validation: `compiler/tests/test_native_llvm_execution.py::test_stage2_runner_applies_capability_manifest` and `compiler/tests/test_native_llvm_execution.py::test_stage2_runner_denies_missing_capabilities`; behaviour documented in `docs/status.md`.
- [x] Stage2 move-out diagnostics — Ownership metadata now ships use-after-move errors for locals and parameters, including non-copy aggregates; regression coverage lives in `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_reports_use_after_move` and `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_reports_use_after_move_for_affine_array`, with behaviour documented in `docs/status.md`.
- [x] Extend `.sfn-asm` lowering to emit runnable LLVM IR modules and execute smoke binaries via CI. (Coverage: `compiler/tests/test_native_llvm_execution.py` runs the emitted IR through `llvmlite`.)
- [x] Lower loops and `match` dispatch into LLVM branch/merge blocks so structured control flow executes under the stage2 backend. (Regression: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_runs_program` now covers loop + match execution.)
- [x] Lower `.for` loops over sequence iterables (arrays, comprehensions) into LLVM index loops so collection iteration executes without Python fallbacks. (Local bindings and inline literals without annotations now lower in `native_llvm_lowering.sfn`; validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_iterates_array_bindings_without_annotations`.)
- [x] Tag `.sfn-asm` array literals with element-type metadata so Stage2 lowering can skip per-literal inference and extend typed iteration to struct and enum aggregates. (Validation: `compiler/tests/test_stage1_pipeline.py::test_native_backend_tags_array_literals_with_metadata`.)
- [x] Extend primitive coverage beyond `number` so boolean and integer values lower into native LLVM types and flow through conditions without double coercions. (Covered by `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_supports_boolean_and_integer_primitives`.)
- [x] Emit struct and enum layout descriptors in `.sfn-asm` (field order, sizes, and payload encoding) so Stage2 lowering can materialise aggregate storage without guessing. Document the format in `docs/spec.md` and cover it with a regression in `compiler/tests/test_stage1_pipeline.py`.
- [x] Thread parsed interface metadata into `native_llvm_lowering.sfn`, emitting placeholder descriptors so upcoming trait-object work has concrete data; exercise the plumbing with a focused regression in `compiler/tests/test_native_llvm_execution.py`.
- [x] Lower borrow expressions (`&`, `&mut`, `borrow(...)`) and reference types into the native IR and LLVM backend, representing borrows as explicit pointer values and covering them with a regression in `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_lowers_borrow_expressions`.
- [x] Stage2 borrow conflict diagnostics — `.sfn-asm` now carries ownership metadata into LLVM lowering, rejecting conflicting borrows (mutable vs mutable/shared) during Stage2 codegen. Validation lives in `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_reports_conflicting_mut_borrows` and `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_reports_conflicting_shared_borrows`; the behaviour is documented in `docs/spec.md` and surfaced via `docs/status.md`.
- [x] Stage2 interface metadata — `native_ir.sfn` now records interface declarations and struct `implements` lists so trait membership is available to LLVM lowering. Validation: `compiler/tests/test_stage1_pipeline.py::test_native_backend_records_interface_metadata`.
- [x] Stage2 trait descriptors — `native_llvm_lowering.sfn` now threads interface metadata into `LoweredLLVMResult`, exposing structured descriptors for interfaces and their implementers. Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_reports_interface_metadata` asserts the metadata and comment emission.
- [x] Stage2 struct member access — LLVM lowering now maps `self.field` expressions through struct layout metadata so field loads emit without fallback diagnostics. Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_reports_interface_metadata`.
- [x] Stage2 struct literal lowering — LLVM lowering now assembles struct literals with `insertvalue`, so Stage2 functions can construct, return, and pass user-defined aggregates without Python fallbacks. Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_lowers_struct_literals`; behaviour documented in `docs/status.md`.
- [x] Stage2 loop & match lowering — Stage2 LLVM emission now handles `loop` (`break`/`continue`) and `match` dispatch. Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_runs_program` exercises loop control and case dispatch end-to-end.
- [x] Stage2 primitive array iteration — `.for` lowering now preserves element types for `boolean[]` and `int[]` literals and parameters, so non-number sequences execute without Python fallbacks. Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_iterates_non_number_arrays`.
- [x] Support `.for` range strides (descending and custom step) so Stage2 matches Stage1 range semantics. (Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_supports_range_strides`.)
- [x] Stage2 range `.for` lowering — Numeric range-driven `for` loops (with `break`/`continue`) now lower to LLVM without Python fallbacks. Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_runs_program` includes the `sum_for` iteration case.
- [x] Stage2 range stride lowering — Stage2 `.for` loops now honour explicit stride expressions (positive or negative) and flag zero literal steps. Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_supports_range_strides`.
- [x] Stage2 sequence `.for` locals — Inline `let` bindings and array literals without annotations now lower to LLVM index loops instead of falling back to Python. Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_iterates_array_bindings_without_annotations` covers both parameter aliases and literal bindings.
- [x] Stage2 array literal metadata — `.sfn-asm` now prefixes array literals with `#element:<type>` hints so Stage2 lowering can bypass runtime inference and prep struct/enum iteration. Validation: `compiler/tests/test_stage1_pipeline.py::test_native_backend_tags_array_literals_with_metadata` covers emission; existing native execution tests guard primitive iteration.
- [x] Stage2 struct array iteration — LLVM lowering now reads the embedded array metadata to recover struct element types, so `.for` loops can iterate over `Pair[]` (and other user-defined aggregates) without falling back to opaque pointer loads. Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_iterates_struct_arrays`; behaviour documented in `docs/status.md`.
- [x] Grapheme segmentation — Stage1 runtime prelude now embeds the Unicode extend tables so `grapheme_count` and `grapheme_at` execute without Python `unicodedata`. Validation: `compiler/tests/test_string_utils.py` covers combining-mark accents, regional-indicator flags, and the transgender flag sequence.
- [x] Effect annotation hints — Stage1 missing-effect diagnostics now surface `![effect]` signature suggestions and reference the CLI fix prompt. Validation: `compiler/tests/test_stage1_typecheck_effects.py::test_typecheck_reports_missing_effects_with_spans` asserts the new guidance.
- [x] Hierarchical effect propagation — Stage1 `effect_checker.sfn` now walks nested blocks, lambdas, and spawned thunks so capability requirements bubble up to the declaring routine. Validation: `compiler/tests/test_effect_checker.py::test_effect_checker_propagates_model_from_nested_lambda` and `compiler/tests/test_effect_checker.py::test_spawn_prompt_requires_io_and_model` lock the coverage.
- [x] Effect origin tracing — Stage1 effect diagnostics now attach prompt and helper call spans, and the typechecker surfaces missing-effect errors with structured context. Validation: `compiler/tests/test_effect_checker.py::test_effect_checker_propagates_model_from_nested_lambda`, `compiler/tests/test_effect_checker.py::test_spawn_prompt_requires_io_and_model`, and `compiler/tests/test_stage1_typecheck_effects.py::test_typecheck_reports_missing_effects_with_spans`.
- [x] Effect enforcement — Extended stage0 effect checks to cover runtime helpers (`fs`, `http`, `websocket`, `serve`, `spawn`, `print`, `sleep`). Validation: `bootstrap/tests/test_unit_effects.py` exercises missing-effect errors for `spawn`, `serve`, console IO, and timer usage.
- [x] Self-hosted control flow — Added structured `if`/`else`, `for`, and `match` support to the Sailfin parser and emitter. Validation: `bootstrap/tests/test_compiler_sources.py` asserts the new AST nodes and generated scaffolding.
- [x] Decorator parity — Self-hosted effect inference now recognises `@logExecution` alongside `@trace`. Validation: `bootstrap/tests/test_compiler_sources.py::test_self_hosted_decorator_logexecution_infers_io` ensures inferred `io` effects.
- [x] Runtime core parity — Moved collection/string helpers, enum & struct repr, descriptor-backed `check_type`, and interpolation lowering into Sailfin’s runtime prelude; regression coverage in `compiler/tests/test_runtime_prelude.py`, `compiler/tests/test_string_utils.py`, and `compiler/tests/test_string_interpolation.py`.
- [x] Self-hosted effect helpers — Added console IO, `sleep`, and `runtime.*` helper detection (`runtime.fs`, `runtime.http`, `runtime.spawn`, `runtime.serve`) to the Sailfin effect checker. Validation: `bootstrap/tests/test_compiler_sources.py` covers missing `io`/`net`/`clock` enforcement.
- [x] Literal coverage — Array, object, and struct literals now emit structured AST nodes and generate Python via `runtime.make_object`/type constructors. Validation: `bootstrap/tests/test_compiler_sources.py` exercises literal parsing and generation.
- [x] Expression normalisation — Pratt parser covers member access, calls, unary `!`/`-`, and common binary operators, replacing `Raw` placeholders. Validation: `bootstrap/tests/test_compiler_sources.py` asserts structured guard and inline match expressions, plus member-call lowering within loop bodies.
- [x] Parser parity — Self-hosted match arms now preserve guards and inline `=>` expression/`return` bodies, matching stage0 behaviour. Validation: `bootstrap/tests/test_compiler_sources.py` exercises guard, expression, and return cases.
- [x] Lambda lowering — Sailfin lambdas now produce structured AST nodes and round-trip through the self-hosted emitter with inlined Python lambdas. Validation: `bootstrap/tests/test_compiler_sources.py::test_compile_compiler_source` checks both Sailfin and Python outputs.
- [x] Postfix foundations — Indexing (`values[i]`) and range (`start..end`) expressions round-trip through the Sailfin parser and emitter. Validation: `bootstrap/tests/test_compiler_sources.py::test_compile_compiler_source` covers bracket access and `start..end` ranges.
- [x] Postfix expressions — Chained member/call/index sequences now round-trip through the Sailfin parser and emitter, and code generation rewrites `.map`, `.filter`, `.reduce`, `.concat`, and `.length` into runtime helpers. Validation: `bootstrap/tests/test_compiler_sources.py::test_compile_compiler_source` asserts Sailfin emission and Python lowering for the helper chain.
- [x] Example hardening — Annotated every runnable example with declared effects, wrapped ad-hoc top-level statements in `main`, and removed undefined helper stubs. Validation: `examples/README.md` capability index plus `make test` ensures samples compile and execute under the stage1 suite.
- [x] Stage1 closed loop — Stage1 now recompiles the compiler end-to-end, replaces stage0 in CI, and ships as the release artifact. Validation: `compiler/tests/test_stage1_artifact.py`, `.github/workflows/stage1-release.yml`.
- [x] Stage1 installer — Added `scripts/install_stage1.py` and README docs so releases can be fetched with a PAT and installed system-wide.
- [x] Runtime string helpers — Promoted `compiler/src/string_utils.sfn` into the shared runtime prelude so downstream projects and the stage1 compiler reference a single implementation. Validation: `compiler/tests/test_runtime_prelude.py`, `compiler/tests/test_string_utils.py`.
- [x] Module re-export support — Parser, emitter, native lowering, and Python bridge now preserve aliased `import`/`export` specifiers so runtime helpers can be re-exported directly. Validation: `compiler/tests/test_stage1_pipeline.py::test_import_export_alias_round_trip`.
- [x] Capability bridges — Introduced runtime capability grants and filesystem/HTTP/model bridge helpers that enforce permissions while delegating to bootstrap shims. Validation: `compiler/tests/test_runtime_prelude.py::test_runtime_capability_bridges`.
- [x] Stage2 conditionals — `native_llvm_lowering.sfn` now lowers local assignments and structured `if`/`else` blocks into LLVM IR. Validation: `compiler/tests/test_native_llvm_execution.py` exercises branching via `choose`.

## Coordination Notes

- Every roadmap item should cite its status source (tests, docs, or prototypes).
- When a task moves from roadmap to implementation, update `docs/status.md` and
  prune “planned” callouts in the spec / examples.
- Proposals live under `docs/proposals/`; reference them instead of duplicating
  detail here.
