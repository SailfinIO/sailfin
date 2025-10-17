# Sailfin Status

Updated: October 16, 2025

This document is the source of truth for what ships today in the Python
bootstrap toolchain and what exists only in the Sailfin-native
experiments. Use it as the checklist before updating specs, examples, or
roadmaps.

## Stage Overview

- **Stage1 (production)** — Sailfin-written lexer, parser, semantic passes, and
  native lowering pipeline that compile the Sailfin compiler itself. The stage1
  artifact ships as a versioned release bundle (`sailfin-stage1-<version>.zip`)
  containing `compiler/build/`, the runtime prelude, and the `sailfin-stage1`
  launcher. All developer workflows (`make compile`, `make package`, CI) now go
  through this self-hosted pipeline. The emitted artifacts still target the
  Python runtime (`runtime_support.py`) and rely on the Python-flavoured
  installer scripts; removing those dependencies is tracked in the roadmap
  under the Stage2 backend and toolchain de-Pythonisation workstreams.
- **Stage0 (legacy)** — The Python bootstrap compiler (archived under
  `Legacy/stage0/`) is retained for reference and targeted regression
  hunting, but it no longer participates in packaging or CI. Expect the
  directory to freeze except for emergency diffs.
- **Stage2 (in design)** — Emits machine code via LLVM/WASM backends and a
  Sailfin-native runtime. The `.sfn-asm` intermediate plus `native_llvm_lowering`
  provide the initial scaffolding, now covering local assignments, structured
  `if`/`else` branching, `loop`/`break`/`continue`, range-based `.for` iteration with
  dynamic stride support, element-wise `.for` loops over primitive arrays (`number[]`,
  `int[]`, `boolean[]`), and `match` dispatch alongside
  boolean and integer primitives for parameters, locals, and returns in the LLVM
  prototype. Struct and enum declarations now emit `.layout` descriptors that
  record size, alignment, and per-field offsets for LLVM consumption. Member
  layout inference now recognises optional fields, nested enums, and recursive
  aggregates, so the compiler AST records concrete sizes without emitting the
  `defaulting to pointer layout` fallbacks (`compiler/tests/test_stage1_pipeline.py::test_native_backend_infers_recursive_layouts`).
  Member
  access expressions in the LLVM prototype now consult those layouts, so `self.field`
  lowers into `getelementptr`/`load` sequences instead of surfacing unsupported
  expression diagnostics. Struct literals now assemble aggregates directly in LLVM
  (`insertvalue` sequences) so Stage2 functions can construct, return, and consume
  user-defined structs without Python fallbacks; the behaviour is exercised by
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_lowers_struct_literals`.
  Builtin compiler and runtime aggregates (e.g. `Token`, parser result wrappers, `runtime.StructField`)
  now publish canonical pointer-based ABI descriptors so Stage1 emits consistent layouts without
  surfacing `defaulting to pointer layout` warnings when compiling dependent modules. Regression
  coverage: `compiler/tests/test_stage1_pipeline.py::test_stage1_builtin_ast_layouts_do_not_warn`
  and `compiler/tests/test_runtime_prelude.py::test_runtime_prelude_collection_helpers`.
  Array literals embed `#element:<type>` metadata so Stage2 can skip per-element
  inference and prepare typed iteration over richer aggregates. LLVM lowering
  now interprets that metadata for struct element types, so `.for` loops can
  walk `Pair[]` (and other user-defined aggregates) without defaulting to
  pointer fallbacks; regression coverage lives in
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_iterates_struct_arrays`.
  Struct method invocations now lower into `Struct::method` call sites with the
  receiver injected as the leading argument (loading pointers to match recorded
  layouts), removing the lingering `value.method` diagnostics; regression coverage
  lives in
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_calls_struct_methods`.
  Enum declarations now emit `.layout` descriptors that record tag type, size,
  alignment, and per-variant payload layouts, flowing through the native IR into
  LLVM type definitions. Enum types lower to tagged-union representations
  (`{ tag_type, [payload_bytes x payload_size] }`) where the tag identifies the
  active variant and the payload area stores variant-specific fields. Enum
  constructor expressions (both unit variants like `Color.Red` and payload variants
  like `Shape.Circle { radius: 5.0 }`) now fully lower into LLVM: unit variants use
  `insertvalue` to populate the tag field, while payload variants allocate the enum
  on the stack, store the tag, then use `getelementptr` and `bitcast` to store each
  payload field at its correct byte offset within the payload array before loading
  the complete enum value. Regression coverage lives in
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_lowers_basic_enum_types`,
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_constructs_simple_enum_variant`,
  and `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_stores_enum_payload_fields`.
  Recursive enum payloads now heap-box aggregate values when variant metadata
  describes pointer-shaped storage, so self-referential variants (e.g.,
  `Value.Pair { left -> Value, right -> Value }`) lower without Python fallbacks
  or coercion diagnostics. Coverage: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_allocates_recursive_enum_payloads`.
  Match expressions now destructure enum operands natively by extracting the tag
  field via `extractvalue` and comparing it against variant tag values, enabling
  Stage2 programs to dispatch on enum variants without Python fallbacks. Both unit
  variants (e.g., `Color.Red`, `Status.Pending`) and payload variants (e.g.,
  `Shape.Circle { radius }`) fully work in match arms. Field binding using shorthand
  syntax (e.g., `Shape.Circle { radius }` extracts the `radius` field into a local
  variable named `radius`) is now implemented, allowing match arms to access and
  compute with payload field values. The implementation uses GEP instructions to
  extract fields from the payload byte array at their correct byte offsets, accounting
  for variant layout metadata.
  Regression coverage lives in
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_matches_enum_variants`,
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_matches_mixed_enum_variants`,
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_matches_payload_enum_by_tag`,
  and `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_extracts_enum_payload_fields_in_match`.
  Interface
  declarations and struct `implements` clauses now flow through the native IR so
  the LLVM backend can reason about trait membership without inspecting source
  ASTs. The LLVM lowering pipeline surfaces this information via
  `LoweredLLVMResult.trait_metadata`, providing structured descriptors for each
  interface (name, generics, signatures) and every struct that implements them
  ahead of trait-object plumbing. Borrow expressions now lower into explicit
  LLVM pointer values so functions can accept and forward `&T` / `&mut T`
  parameters without falling back to the Python bridge (guarded by
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_lowers_borrow_expressions`).
  Ownership metadata now threads through `.sfn-asm`, and Stage2 flagging rejects
  conflicting borrows (mutable-with-mutable or mutable-with-shared) during LLVM
  lowering (`compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_reports_conflicting_mut_borrows`
  and `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_reports_conflicting_shared_borrows`).
  Lifetime regions now surface alongside those borrow checks; the LLVM pipeline
  records `LifetimeRegionMetadata` entries (binding, base, mutability, scope id,
  scope depth, and start span) on `LoweredLLVMResult.lifetime_regions` so
  diagnostics and follow-on tooling can reason about scope exits without
  re-parsing `.sfn-asm`. Regions now track release scopes when locals are
  reassigned in nested control flow, so reborrows that end before leaving a
  branch or loop no longer trigger false positives; regression coverage lives in
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_emits_lifetime_regions`
  and `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_allows_scoped_reborrow`.
  The recorded scope metadata now feeds borrow-release validation: assignments
  that bind a borrow whose base lives in a deeper scope emit
  `llvm lowering: borrow ... escapes lifetime ...` diagnostics, preventing
  escaped references from crossing scope boundaries. Regression coverage lives
  in
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_reports_borrow_lifetime_violation`.
  Ownership consumption now survives merges across loops, `if`/`else`, and `match`
  blocks, so use-after-move checks on locals and parameters fire when those
  values are reused after being consumed; the execution suite in
  `compiler/tests/test_native_llvm_execution.py` exercises these control-flow
  paths while ensuring legitimate reassignments clear the consumed state, with
  targeted coverage for non-copy aggregates such as `Affine<number[]>`
  (`compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_reports_use_after_move_for_affine_array`).
  Block lowering now records `LocalMutation` metadata for every `let` binding or
  reassignment lowered through `lower_instruction_range`, preserving the LLVM
  type, stored SSA value, span, and defining label for SSA phi node generation.
  Mutation metadata threads through all control-flow structures (`lower_if_instruction`,
  `lower_loop_instruction`, `lower_for_instruction`, and `lower_match_instruction`),
  accumulating mutations from nested blocks while preserving originating labels.
  For straight-line `if` statements (without `else`), the compiler now emits SSA
  phi nodes at merge points to select between the mutated value (from the `then` branch)
  and the original value (from the base block), storing the result back through the
  local pointer. For full `if`/`else` statements, the compiler emits phi nodes that
  union mutations from both branches, correctly handling cases where both arms mutate
  shared locals and cases where each arm mutates unique locals. Terminated branches are
  skipped during phi generation. For `loop` constructs, the lowering now creates explicit
  preheader, header, body, latch, and exit labels, emitting phi nodes in the header for
  locals mutated in the body (merging values from the preheader and latch), and ensuring
  `continue` targets the latch instead of jumping directly back to the header. For `for`
  loops (both range-based and array iteration), the proper structure (header with condition
  check, body, increment/latch, exit) was already in place with `continue` correctly
  targeting the increment label. For `match` statements, the compiler now emits multi-input
  phi nodes at the shared merge label for each local mutated in any arm, accumulating
  mutations per arm (including guards) with their terminating labels and skipping terminated
  arms during phi generation. All phi node emission functions share common helper logic:
  `find_preloaded_value` retrieves the initial value for a local before control flow diverges,
  `collect_mutation_names` builds a unique set of mutated local names from mutation lists,
  `find_mutation_for_name` looks up mutation metadata for a specific local, `join_strings`
  concatenates phi input strings, and `build_phi_and_store` generates paired phi and store
  instructions (ensuring LLVM's requirement that all phi nodes appear grouped at the top of
  each basic block before any other instructions). This enables LLVM's optimization passes to
  work more effectively with the generated IR. Regression coverage lives in
  `compiler/tests/test_stage2_mutation_capture.py::test_lower_instruction_range_records_local_mutations`
  plus propagation tests (`test_mutations_propagate_through_if_then`,
  `test_mutations_propagate_through_if_else`, `test_mutations_propagate_through_loop`,
  `test_mutations_propagate_through_match`) and execution validation via
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_emits_phi_for_straight_line_if`,
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_emits_phi_for_if_else`,
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_emits_phi_for_match`,
  and `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_runs_program`
  (which includes `loop_and_match` with loop accumulators and `sum_for` with for-loop accumulators).
  Move diagnostics now thread source spans from `.sfn-asm` through the native IR,
  so LLVM lowering reports use-after-move errors with line and column ranges
  (`compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_reports_use_after_move`
  and `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_reports_use_after_move_for_affine_array`).
  Borrowed references still introduce internal effects (`!read`, `!mut`) that
  compose with capability-driven effects. The lowering pipeline now records those
  requirements per function (`LoweredLLVMResult.function_effects`), annotates the
  emitted LLVM IR with effect comments, and wires them into the entry-point
  capability manifest (`LoweredLLVMResult.capability_manifest`) so callers see
  composite requirements. `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_capability_manifest_propagates_composite_effects`
  locks the manifest propagation behaviour, including borrow + capability
  combinations. The Stage2 runner now consumes those manifests: `runtime.stage2_runner.Stage2Runner`
  acquires a capability grant for each entry point before invoking native
  helpers and rejects runtime calls whose effects are absent from the grant
  (`compiler/tests/test_native_llvm_execution.py::test_stage2_runner_applies_capability_manifest`
  and `compiler/tests/test_native_llvm_execution.py::test_stage2_runner_denies_missing_capabilities`).
  Stage2 lowering now rejects suspension points (`await`, `yield`)
  that would keep a mutable borrow or mutable borrow parameter alive, enforcing
  the lattice rule `!mut ⊄ !async`. Diagnostics now attach source spans for both
  the active borrow and the suspension site so LLVM errors cross-link the borrow
  declaration with the offending `await`/`yield`; see
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_rejects_mutable_borrow_across_await`
  and `compiler/tests/test_native_llvm_execution.py::test_native_llvm_allows_await_without_mutable_borrow`
  for the rejection/acceptance coverage. Raw pointer access remains gated behind `unsafe extern`
  declarations and lexical `unsafe { ... }` blocks so Stage2 can target LLVM/WASM
  without exposing unchecked pointer mutation to safe code.
  Snapshot coverage now locks representative `.sfn-asm` and LLVM IR output via
  `compiler/tests/test_stage2_golden.py`, and the `stage2_environment` fixture
  caches Sailfin→LLVM compilations for the entire suite.
  Parameter declarations now emit `.param` span metadata inside `.sfn-asm`, so
  suspension diagnostics also highlight the mutable borrow parameter location;
  regression coverage lives in
  `compiler/tests/test_stage1_pipeline.py::test_native_backend_emits_parameter_spans`
  and still exercises `compiler/tests/test_native_llvm_execution.py::test_native_llvm_rejects_mutable_borrow_across_await`.
- **Registry** — `registry.sailfin.dev` serves capsule and model metadata.
  Integration with the self-hosted toolchain remains roadmap work; manifests
  and CLI flows are tracked separately.

## Feature Snapshot

**Parsing & Declarations**

- Stage0 (legacy): Parses `fn`, `struct`, `enum`, `interface`, `model`, `tool`,
  `pipeline`, `test`, `type`, and `match` declarations.
- Stage1: Mirrors the same surface and now recognises
  block-level `if`/`else`, `for` loops, and `match` statements with `case`
  guards captured as expressions plus inline `=>` expression or `return`
  bodies. Common expressions (member access, function calls, unary `!`/`-`,
  binary operators through `&&`/`||`, range operators (`start..end`),
  indexing (`target[index]`), lambda expressions (`fn (...) { ... }`), and
  literal forms like `[x, y]`, `{ key: value }`, and `Type { field: value }`)
  now lower into structured nodes instead of `Raw` placeholders.

- Stage0 (legacy): Enforces `model`, `io`, `net`, and `clock` via
  `bootstrap/effect_checker.py`, covering prompt blocks, effectful decorators
  (e.g. `@logExecution`), and runtime helpers such as `fs.*`, `http.*`,
  `websocket.*`, `serve`, `spawn`, `print.*`, and `sleep` (including their
  `runtime.*` aliases).
- Stage1: Infers `io` when decorators like `@trace` or
  `@logExecution` appear and scans blocks for prompts, console helpers
  (`print.*`, `console.*`, `runtime.console.*`), runtime timers
  (`sleep`, `runtime.sleep`), and capability helpers such as `fs.*`,
  `runtime.fs.*`, `http.*`, `runtime.http.*`, `websocket.*`,
  `runtime.websocket.*`, `serve`, `runtime.serve`, `spawn`, and
  `runtime.spawn`. The effect checker now walks nested blocks,
  lambdas, and spawned thunks so prompts and capability adapters in
  async contexts propagate their `model`/`io`/`net`/`clock`
  requirements to the enclosing routine. Missing-effect diagnostics now
  emit precise source spans for the originating prompt or helper call
  and flow through the stage1 typechecker as structured errors. Messages
  include `![effect]` fix-it hints and reference the CLI fix prompt so
  teams can annotate signatures faster. Stage1 CLI output and native
  artifact diagnostics now surface those spans with caret-highlighted
  source snippets so developers see the offending line immediately
  (`compiler/tests/test_stage1_diagnostics.py::test_missing_effect_diagnostic_includes_source_snippet`).

- Stage0 (legacy): Performs symbol collection and effect validation inside the
  Python pipeline; deeper type checking remains future work.
- Stage1: `compiler/src/typecheck.sfn` now walks top-level and
  scoped blocks, builds symbol tables for functions/tests, and reports duplicate
  declarations (including parameter and local name clashes). The pass also
  enforces unique struct fields, struct methods, enum variants, interface
  members, model properties, and type parameters so Sailfin sources surface the
  same duplicate errors surfaced by the Python implementation. Struct
  declarations now validate every interface listed in their `implements`
  clause, emitting diagnostics when a required member is missing — including
  generic interface instantiations. Implements clauses now enforce generic
  arity, rejecting missing or extra type arguments for interface instantiations.
  Regression coverage spans `compiler/tests/test_stage1_typecheck_duplicates.py`
  for duplicate detection and
  `compiler/tests/test_stage1_typecheck_interfaces.py` for interface
  conformance (including type argument enforcement). Diagnostics flow through
  `compiler/src/main.sfn` so the bootstrap pipeline surfaces issues during
  round-trips.
- Stage0 (legacy): Prompts require the `model` effect; interpolation is handled by the
  runtime helpers.
- Stage1: Prompt statements are preserved in the AST and emitted
  as comments; deterministic scopes (`with seed(...)`) parse but have stubbed
  semantics.

- Stage0 (legacy): Emits data holders and plain Python functions; no special pipeline
  operator yet.
- Stage1: Uses the same emission strategy while preserving
  properties and effects. The planned `|>` operator remains illustrative only.
  Collection helpers (`array_map`, `array_filter`, `array_reduce`) and the
  sequential `parallel` orchestration now live in `runtime/prelude.sfn`, letting
  the self-hosted runtime exercise native Sailfin loops; regression coverage
  lives in `compiler/tests/test_runtime_prelude.py`. String helpers (`substring`,
  `find_char`), grapheme-aware utilities (`grapheme_count`, `grapheme_at`), and
  ASCII-aware character codes (`char_code`) now share the canonical
  implementation in `runtime/prelude.sfn`, which `compiler/src/string_utils.sfn`
  simply re-exports for the stage1 compiler. Descriptor-driven `check_type`
  now lives in the Sailfin prelude, with unions/intersections/arrays parsed in
  Sailfin and only runtime type resolution delegated to Python bridges. String
  interpolation lowers into segment arrays that call `runtime.format_interpolated`
  so placeholders execute without Python `eval` in Stage1 outputs. Struct
  facades now round-trip their instance methods (`struct Pair { fn sum(self) }`)
  into Python class methods, letting the runtime prelude surface richer helper
  shims without bootstrap fallbacks; validated via
  `compiler/tests/test_stage1_pipeline.py::test_struct_method_lowering`.
  Grapheme helpers now inline the Unicode segmentation tables so
  `grapheme_count`/`grapheme_at` execute without touching
  `runtime_support.py`; regression coverage lives in
  `compiler/tests/test_string_utils.py` (flag, combining-mark fixtures).
  Module parsing, emission, and lowering recognise aliased
  `import`/`export` specifiers so Sailfin sources can re-export runtime helpers;
  regression coverage lives in `compiler/tests/test_stage1_pipeline.py::test_import_export_alias_round_trip`.
  Capability grants plus `fs`/`http`/`model` bridges now expose effect-aware
  shims from `runtime/prelude.sfn` while still delegating to the Python runtime;
  runtime permissions are enforced in
  `compiler/tests/test_runtime_prelude.py::test_runtime_capability_bridges`.
  Native lowering now
  recognises top-level `.let` bindings (e.g., `console = runtime.console`) so
  the prelude compiles without spurious diagnostics.

- Stage0 (legacy): Parses `Affine<T>` / `Linear<T>` without enforcement.
- Stage1: Carries ownership metadata for borrow checking and now emits the data
  needed for Stage2 to diagnose conflicting borrows.

- Stage0 (legacy): Lowers tests to Python functions executed in the `__main__`
  preamble, enforcing required effects.
- Stage1: Generates the same scaffolding.

**Code Generation**

- Bootstrap: Walks the full AST and emits runnable Python against
  `runtime_support.py`. Console helpers cover `print.info`, `print.error`, and
  `print.warn`, each flagged by the effect checker as `io`. (Frozen except for
  hotfixes.)
- Stage1: Lowers Sailfin sources through the native pipeline and prints Python
  scaffolding via `native_lowering.sfn`, rewiring postfix helpers (`.map`,
  `.filter`, `.reduce`, `.concat`, `.length`) into runtime shims and `len(...)`
  calls. Block emission preserves local `let` declarations, loops,
  `if`/`else if`/`else` chains, and `match` statements so compiler sources
  round-trip cleanly. The structured `.sfn-asm` output from `emit_native.sfn`
  feeds both Python and LLVM lowerings; `native_llvm_lowering.sfn` now lifts
  arithmetic routines with local `let`s, assignments, `if`/`else` control
  flow, `loop` blocks (`break`/`continue`), `match` dispatch, and `.for` loops
  over numeric ranges with dynamic stride expressions, inline primitive array
  literals, and locals bound to array expressions (even without explicit type
  annotations) into runnable LLVM IR, with
  `compiler/tests/test_native_llvm_execution.py` executing the emitted IR via
  `llvmlite` as a smoke guard. Runtime console helpers are surfaced as external
  LLVM calls so stage2 lowers `print.info` against the existing Python prelude,
  covered by
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_invokes_runtime_console`.

**Package Manager (`sfn`)**

- Bootstrap: Not implemented yet.
- Self-hosted prototype: Not implemented; behaviour lives in
  `docs/proposals/package-management.md`.

## Validation Coverage

- `make test` runs the stage1-focused pytest suite (`compiler/tests/`), covering
  the end-to-end self-host check (`test_stage1_artifact.py`) and native lowering
  validation.
- `make test-unit` targets fast Sailfin-specific checks (`pytest -m "unit and not stage2"`), while
  `make test-integration` isolates artifact packaging and self-hosting flows, and
  `make test-stage2` exercises the LLVM/native backend smoke suite.
- `compiler/tests/test_native_llvm_execution.py` lowers numeric, boolean,
  integer, and primitive-array-iterating samples (including `boolean[]` and
  `int[]` literals) to LLVM IR and executes them through `llvmlite` so Stage2
  regressions surface as standard test failures.
- `compiler/tests/test_stage1_pipeline.py::test_native_backend_emits_layout_descriptors`
  locks the `.layout` directives in `.sfn-asm` and the parsed layout metadata
  surfaced through the stage1 native IR parser.
- CI packages the stage1 artifact, uploads it, and semantic-release tags a
  GitHub release. The installer smoke test verifies the archive can rebuild
  stage1 (`scripts/install_stage1.py`).
- `examples/README.md` enumerates every runnable sample with declared effects;
  capability requirements stay in sync with the runtime helpers.
- Registry and CLI workflows remain manual; no automated coverage yet.

## Active Workstreams

1. **Stage2 backend** — Extend `.sfn-asm` lowering to emit runnable LLVM/WASM
   modules, bridge capability shims, and execute smoke binaries end-to-end.
2. **Runtime & FFI lift** — Replace Python runtime helpers with Sailfin
   implementations that surface the same effect guarantees and provide bridged
   access to filesystem, HTTP, model execution, and concurrency primitives.
3. **Diagnostics deepening** — Continue parity work in `typecheck.sfn` and
   `effect_checker.sfn` (hierarchical effects, richer messages) to match the
   historical stage0 behaviour without regressing stage1 self-hosting.
4. **Registry integration** — Wire manifest parsing and publish/resolve
   commands against `registry.sailfin.dev` once the self-host loop remains
   stable.

Track detailed milestones and sequencing in `docs/roadmap.md`. When a
feature graduates from prototype into the shipping stage1 toolchain, update the
table above and trim related “planned” callouts from the spec and examples.

## Test Harness

- Stage1 tests run via `make test` (pytest inside the `sailfin` Conda env). With
  the content-addressed Stage1 cache introduced in October 2025 the full suite
  now completes in **~82 seconds** on an M2 Mac Pro (previously ~11 minutes).
- Cached builds live under `.pytest-stage1/<hash>/compiler` and are derived from
  the contents of `compiler/src/**/*.sfn`, `runtime/**/*.sfn`, generated
  `compiler/build/**/*.py`, and the Python pipeline version. Cache hits and
  misses are logged when `PYTEST_STAGE1_DEBUG=1`.
- Developers can disable the cache with `PYTEST_STAGE1_NO_CACHE=1` or relocate it
  via `PYTEST_STAGE1_CACHE_DIR`. Remove the `.pytest-stage1/` directory to force
  recompilation if stale artefacts are suspected.
- `make warm-stage1-cache` pre-populates the cache (respects
  `PYTEST_STAGE1_CACHE_DIR`) so CI or fresh clones can avoid the first-run
  compile spike.
