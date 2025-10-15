# Sailfin Status

Updated: October 15, 2025

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
  record size, alignment, and per-field offsets for LLVM consumption. Array
  literals embed `#element:<type>` metadata so Stage2 can skip per-element
  inference and prepare typed iteration over richer aggregates. Interface
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
  Ownership consumption now survives merges across loops, `if`/`else`, and `match`
  blocks, so use-after-move checks on locals and parameters fire when those
  values are reused after being consumed; the execution suite in
  `compiler/tests/test_native_llvm_execution.py` exercises these control-flow
  paths while ensuring legitimate reassignments clear the consumed state.
  Borrowed references still introduce internal effects (`!read`, `!mut`) that
  compose with capability-driven effects, and the lowering pipeline now records
  those requirements per function (`LoweredLLVMResult.function_effects`) while
  annotating the emitted LLVM IR with effect comments so downstream capability
  manifests can surface composite requirements. Future enforcement will block `!mut`
  across suspension points and require manifests to authorise any routine that
  touches unsafe capabilities. Raw pointer access remains gated behind `unsafe extern`
  declarations and lexical `unsafe { ... }` blocks so Stage2 can target LLVM/WASM
  without exposing unchecked pointer mutation to safe code.
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
  teams can annotate signatures faster.

- Stage0 (legacy): Performs symbol collection and effect validation inside the
  Python pipeline; deeper type checking remains future work.
- Stage1: `compiler/src/typecheck.sfn` now walks top-level and
  scoped blocks, builds symbol tables for functions/tests, and reports duplicate
  declarations (including parameter and local name clashes). The pass also
  enforces unique struct fields, struct methods, enum variants, interface
  members, model properties, and type parameters so Sailfin sources surface the
  same duplicate errors surfaced by the Python implementation. Regression
  coverage now includes `compiler/tests/test_stage1_typecheck_duplicates.py`
  to lock the duplicate-detection diagnostics. Diagnostics flow through
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
  `llvmlite` as a smoke guard.

**Package Manager (`sfn`)**
- Bootstrap: Not implemented yet.
- Self-hosted prototype: Not implemented; behaviour lives in
  `docs/proposals/package-management.md`.

## Validation Coverage

- `make test` runs the stage1-focused pytest suite (`compiler/tests/`), covering
  the end-to-end self-host check (`test_stage1_artifact.py`) and native lowering
  validation.
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
