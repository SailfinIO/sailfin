# Sailfin Roadmap

Updated: October 2025  
Owners: Sailfin Core Team

This roadmap pairs with `docs/status.md`. Update status first, then record
strategy changes here. Each section is designed so an agent can pull the next
actionable item, mark it complete, and move to the following bucket; creating new items as needed - this means that active workstreams need to be upated regularly.

## Active Workstreams (Do Now)

1. **Self-Hosted Compiler Escape Velocity**
   - [ ] Closed-loop bootstrap — `compiler/src/main.sfn` parses, checks, and emits Sailfin that recompiles the entire compiler without stage0 assistance (tracked via `bootstrap/tests/test_compiler_sources.py`).
     - [ ] Replace `bootstrap/compile_self_host.py` with a Sailfin-native pipeline that emits the Python scaffolding for `compiler/src/**/*.sfn` using `compile_to_native_python`.
     - [ ] Integration test: run the Sailfin-built compiler end-to-end to regenerate `compiler/build/` and verify parity without invoking the bootstrap parser/generator.
     - [ ] Harden diagnostics/halting in `compile_to_sailfin`/`compile_to_native` so typecheck failures stop emission, matching the bootstrap CLI.
   - [ ] Semantic passes — Land name resolution, type analysis, and effect propagation in Sailfin (`compiler/src/typecheck.sfn`, updated `effect_checker.sfn`) so diagnostics match the Python implementation.
    - [x] Enforce unique struct fields/methods, enum variants, interface members, model properties, and type parameters in `typecheck.sfn` with targeted bootstrap coverage (`bootstrap/tests/test_unit_typecheck.py`).
   - [ ] Native backend spike — Stand up the first non-Python backend (`compiler/src/emit_native.sfn`) targeting LLVM IR or WASM as described in `compiler/README.md`, with smoke tests that execute compiled binaries for simple programs.
     - [x] Emit structured `.sfn-asm` textual IR with entry-point metadata and diagnostics surfaced through `compile_to_native`; coverage lives in `bootstrap/tests/test_compiler_codegen.py::test_emit_native_produces_artifact`.
       - [x] Bridge `.sfn-asm` into executable Python scaffolding via `native_lowering.sfn`, with smoke coverage in `bootstrap/tests/test_compiler_codegen.py::test_lower_native_pipeline_executes_function` and compiler integration in `compile_to_native_python`.
     - [ ] Lower `.sfn-asm` into executable LLVM IR / WASM modules and run end-to-end smoke tests for simple programs.
       - [x] Emit skeletal LLVM IR for return-only functions via `native_llvm_lowering.sfn`, validated by `bootstrap/tests/test_compiler_codegen.py::test_lower_native_to_llvm_emits_ir`.
         - [x] Capture parameter metadata in `native_ir.sfn` and emit numeric parameter signatures/returns in the LLVM prototype (`bootstrap/tests/test_compiler_codegen.py::test_lower_native_handles_parameter_round_trip`).
   - [ ] Bootstrap retirement plan — Define the cut-over checklist (tests, docs, release notes) for replacing the Python toolchain once the Sailfin pipeline stays green for multiple consecutive builds.

2. **Runtime & FFI Foundations**
   - [ ] Sailfin runtime core — Reimplement the bootstrap runtime helpers (`runtime_support.py`) in Sailfin under `compiler/runtime/`, ensuring effect annotations remain enforced.
   - [ ] Capability bridges — Provide minimal FFI shims for filesystem, HTTP, and model execution so native binaries can interact with external resources while respecting capability policies.
   - [ ] Concurrency substrate — Prototype async scheduling / task primitives required by `spawn`, `serve`, and `pipeline` execution in self-hosted builds.

3. **Registry & Capsule Workflow**
   - [ ] Manifest schema — Finalise capsule (`sail.toml`) and fleet (`fleet.toml`) formats, aligning with `docs/proposals/package-management.md`.
   - [ ] CLI integration — Implement `sfn add`, `sfn run`, and `sfn publish` against `registry.sailfin.dev` using the Sailfin toolchain once native builds are viable.
   - [ ] Provenance channels — Surface model generation cards with cost / latency metadata in pipeline outputs.

## Ready Next (Pull When Active Stream Clears)

- [ ] Self-hosted release candidate — Criteria and staging plan for shipping the Sailfin compiler/runtime bundle once the bootstrap dependency is removed.
- [ ] `sfn` package manager release plan — Define rollout steps once CLI integration lands.
- [ ] Registry authentication & signing — Add capability manifests and signed provenance to registry flows.

## Exploration Backlog (Research / Design)

- Model engines & training — Continue design in `docs/proposals/model-engines-and-training.md`; merge into Active once registry workflows exist.
- Tensor and GPU effects — Define `Tensor<T>` primitives and effect propagation for GPU workloads.
- Notebook & LSP tooling — Prototype interactive editing, effect-aware debugging, provenance overlays.

## Completed Items

Move checked tasks here with links to PRs / status updates for traceability.

- [x] Effect enforcement — Extended stage0 effect checks to cover runtime helpers (`fs`, `http`, `websocket`, `serve`, `spawn`, `print`, `sleep`). Validation: `bootstrap/tests/test_unit_effects.py` exercises missing-effect errors for `spawn`, `serve`, console IO, and timer usage.
- [x] Self-hosted control flow — Added structured `if`/`else`, `for`, and `match` support to the Sailfin parser and emitter. Validation: `bootstrap/tests/test_compiler_sources.py` asserts the new AST nodes and generated scaffolding.
- [x] Decorator parity — Self-hosted effect inference now recognises `@logExecution` alongside `@trace`. Validation: `bootstrap/tests/test_compiler_sources.py::test_self_hosted_decorator_logexecution_infers_io` ensures inferred `io` effects.
- [x] Self-hosted effect helpers — Added console IO, `sleep`, and `runtime.*` helper detection (`runtime.fs`, `runtime.http`, `runtime.spawn`, `runtime.serve`) to the Sailfin effect checker. Validation: `bootstrap/tests/test_compiler_sources.py` covers missing `io`/`net`/`clock` enforcement.
- [x] Literal coverage — Array, object, and struct literals now emit structured AST nodes and generate Python via `runtime.make_object`/type constructors. Validation: `bootstrap/tests/test_compiler_sources.py` exercises literal parsing and generation.
- [x] Expression normalisation — Pratt parser covers member access, calls, unary `!`/`-`, and common binary operators, replacing `Raw` placeholders. Validation: `bootstrap/tests/test_compiler_sources.py` asserts structured guard and inline match expressions, plus member-call lowering within loop bodies.
- [x] Parser parity — Self-hosted match arms now preserve guards and inline `=>` expression/`return` bodies, matching stage0 behaviour. Validation: `bootstrap/tests/test_compiler_sources.py` exercises guard, expression, and return cases.
- [x] Lambda lowering — Sailfin lambdas now produce structured AST nodes and round-trip through the self-hosted emitter with inlined Python lambdas. Validation: `bootstrap/tests/test_compiler_sources.py::test_compile_compiler_source` checks both Sailfin and Python outputs.
- [x] Postfix foundations — Indexing (`values[i]`) and range (`start..end`) expressions round-trip through the Sailfin parser and emitter. Validation: `bootstrap/tests/test_compiler_sources.py::test_compile_compiler_source` covers bracket access and `start..end` ranges.
- [x] Postfix expressions — Chained member/call/index sequences now round-trip through the Sailfin parser and emitter, and code generation rewrites `.map`, `.filter`, `.reduce`, `.concat`, and `.length` into runtime helpers. Validation: `bootstrap/tests/test_compiler_sources.py::test_compile_compiler_source` asserts Sailfin emission and Python lowering for the helper chain.
- [x] Example hardening — Annotated every runnable example with declared effects, wrapped ad-hoc top-level statements in `main`, and removed undefined helper stubs. Validation: `examples/README.md` capability index plus `make bootstrap-test` ensures samples compile and execute under the bootstrap suite.

## Coordination Notes

- Every roadmap item should cite its status source (tests, docs, or prototypes).
- When a task moves from roadmap to implementation, update `docs/status.md` and
  prune “planned” callouts in the spec / examples.
- Proposals live under `docs/proposals/`; reference them instead of duplicating
  detail here.
