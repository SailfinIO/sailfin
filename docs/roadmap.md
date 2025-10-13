# Sailfin Roadmap

Updated: October 12, 2025  
Owners: Sailfin Core Team

This roadmap pairs with `docs/status.md`. Update status first, then record
strategy changes here. Each section is designed so an agent can pull the next
actionable item, mark it complete, and move to the following bucket; creating new items as needed - this means that active workstreams need to be upated regularly.

## Active Workstreams (Do Now)

1. **Stage2 Backend Delivery**
  - [x] Extend `.sfn-asm` lowering to emit runnable LLVM IR / WASM modules and execute smoke binaries via CI. (Coverage: `compiler/tests/test_native_llvm_execution.py` runs the emitted IR through `llvmlite`.)
  - [ ] Lower loops and `match` dispatch into LLVM branch/merge blocks so structured control flow executes under the stage2 backend. (Conditional `if`/`else` lowering landed in `native_llvm_lowering.sfn` and is covered by `compiler/tests/test_native_llvm_execution.py`.)
  - [ ] Prototype WebAssembly emission from `.sfn-asm` so parity with the LLVM path can be validated via the same smoke harness.
  - [ ] Introduce capability-aware intrinsics (IO, model, net) for the native backend so effect enforcement survives codegen.
  - [ ] Package stage2 artifacts alongside stage1 in releases once basic programs execute end-to-end.

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
  - [ ] Surface structured diagnostics with source snippets in the stage1 CLI and artifact logging path.
  - [ ] CLI effect fixer — Teach the stage1 CLI to apply suggested `![effect]` annotations automatically when developers accept fix prompts.

4. **Registry & Capsule Workflow**
  - [ ] Manifest schema — Finalise capsule (`sail.toml`) and fleet (`fleet.toml`) formats, aligning with `docs/proposals/package-management.md`.
  - [ ] CLI integration — Implement `sfn add`, `sfn run`, and `sfn publish` against `registry.sailfin.dev` using the Sailfin toolchain once native builds are viable.
  - [ ] Provenance channels — Surface model generation cards with cost / latency metadata in pipeline outputs.

## Ready Next (Pull When Active Stream Clears)

- [ ] Stage1 release candidate — Criteria and staging plan for shipping the Sailfin compiler/runtime bundle as a supported release channel.
- [ ] `sfn` package manager release plan — Define rollout steps once CLI integration lands.
- [ ] Registry authentication & signing — Add capability manifests and signed provenance to registry flows.

## Exploration Backlog (Research / Design)

- Model engines & training — Continue design in `docs/proposals/model-engines-and-training.md`; merge into Active once registry workflows exist.
- Tensor and GPU effects — Define `Tensor<T>` primitives and effect propagation for GPU workloads.
- Notebook & LSP tooling — Prototype interactive editing, effect-aware debugging, provenance overlays.

## Completed Items

Move checked tasks here with links to PRs / status updates for traceability.

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
