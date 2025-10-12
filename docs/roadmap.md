# Sailfin Roadmap

Updated: October 2025  
Owners: Sailfin Core Team

This roadmap pairs with `docs/status.md`. Update status first, then record
strategy changes here. Each section is designed so an agent can pull the next
actionable item, mark it complete, and move to the following bucket; creating new items as needed - this means that active workstreams need to be upated regularly.

## Active Workstreams (Do Now)

1. **Stage2 Backend Delivery**
  - [ ] Extend `.sfn-asm` lowering to emit runnable LLVM IR / WASM modules and execute smoke binaries via CI.
  - [ ] Introduce capability-aware intrinsics (IO, model, net) for the native backend so effect enforcement survives codegen.
  - [ ] Package stage2 artifacts alongside stage1 in releases once basic programs execute end-to-end.

2. **Runtime & FFI Foundations**
  - [ ] Sailfin runtime core — Reimplement the bootstrap runtime helpers (`runtime_support.py`) in Sailfin under `runtime/`, preserving effect annotations.
    - [x] Ported collection helpers (`array_map`, `array_filter`, `array_reduce`) and the sequential `parallel` runner into `runtime/prelude.sfn`, covered by `compiler/tests/test_runtime_prelude.py`.
    - [x] Added string helpers (`substring`, `find_char`) to `runtime/prelude.sfn` with regression coverage in `compiler/tests/test_runtime_prelude.py`.
    - [x] Implemented ASCII-focused `char_code` in `runtime/prelude.sfn`, falling back to the bootstrap helper for other glyphs; regression coverage in `compiler/tests/test_runtime_prelude.py`.
    - [x] Wired stage1 compiler helpers (lexer, parser, emitter, native lowering) to consume Sailfin string utilities (`compiler/src/string_utils.sfn`) instead of `runtime_support.py` fallbacks.    
  - [ ] Document the runtime string helper surface (`substring`, `find_char`, `char_code`) in `docs/spec.md` once Unicode paths land so downstream consumers understand guarantees.
    - [ ] Replace the bootstrap fallback in `char_code` with a Sailfin-native Unicode path covering common UTF-8 ranges; expand coverage in `compiler/tests/test_string_utils.py`.
    - [ ] Audit remaining runtime helpers for Python dependencies (`match_exhaustive_failed`, enum utilities) and schedule Sailfin ports with paired tests.
  - [ ] Module system re-exports — Teach the Sailfin module loader to expose runtime helper bindings (e.g., `substring`, `find_char`, `char_code`) via compiler surface modules without duplicating implementations.
    - [ ] Extend import parsing to recognise `import { foo as bar } from "runtime/...";` and persist alias metadata through lowering.
    - [ ] Update the emitter and Python bridge to generate stable re-export stubs and ensure stage1 artifacts resolve runtime bindings correctly.
    - [ ] Add regression coverage in `compiler/tests/test_string_utils.py` (and a new Sailfin fixture) confirming re-exported helpers compile and execute without duplication.
  - [ ] Capability bridges — Provide minimal FFI shims for filesystem, HTTP, and model execution so native binaries can interact with external resources while respecting capability policies.
  - [x] Extend stage1 native lowering to support top-level aliases (`let console = runtime.console`) so the Sailfin prelude compiles cleanly (`compiler/tests/test_runtime_prelude.py`).
  - [ ] Teach the lowering pipeline to handle simple struct facades/method shims so `runtime/prelude.sfn` can expose richer wrappers without falling back to bootstrap warnings.
  - [ ] Concurrency substrate — Prototype async scheduling / task primitives required by `spawn`, `serve`, and `pipeline` execution in self-hosted builds.

  5. **Toolchain De-Pythonisation**
    - [ ] Native emission milestone — Flip the default stage1 build to target the stage2 executable backend once minimal LLVM/WASM runners exist, keeping a Python fallback only for regression hunting.
    - [ ] Sailfin-native CLI ("sfn") — Reimplement the `sailfin-stage1` launcher, installer, and packaging flow without invoking Python entrypoints; ship the CLI as a Sailfin binary that exercises the runtime prelude directly.
    - [ ] Release pipeline guardrails — Update CI to build the compiler, runtime, and examples using only Sailfin-generated artifacts and fail if Python runtime shims (`runtime_support.py`, bootstrap scripts) are invoked.
    - [ ] Test harness migration — Port the stage1 pytest coverage to an equivalent Sailfin-native smoke/integration suite so compiler regressions can be detected without Python tooling.

3. **Diagnostics Parity**
  - [ ] Land hierarchical effect propagation in `effect_checker.sfn` (nested prompts, async contexts).
  - [ ] Expand `typecheck.sfn` to cover type inference gaps (generics, interface conformance) and port the historical stage0 diagnostics.
    - [x] Locked regression coverage for duplicate symbol diagnostics across structs, enums, interfaces, models, and type parameters via `compiler/tests/test_stage1_typecheck_duplicates.py`.
  - [ ] Surface structured diagnostics with source snippets in the stage1 CLI and artifact logging path.

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
- [x] Example hardening — Annotated every runnable example with declared effects, wrapped ad-hoc top-level statements in `main`, and removed undefined helper stubs. Validation: `examples/README.md` capability index plus `make test` ensures samples compile and execute under the stage1 suite.
- [x] Stage1 closed loop — Stage1 now recompiles the compiler end-to-end, replaces stage0 in CI, and ships as the release artifact. Validation: `compiler/tests/test_stage1_artifact.py`, `.github/workflows/stage1-release.yml`.
- [x] Stage1 installer — Added `scripts/install_stage1.py` and README docs so releases can be fetched with a PAT and installed system-wide.
- [x] Runtime string helpers — Promoted `compiler/src/string_utils.sfn` into the shared runtime prelude so downstream projects and the stage1 compiler reference a single implementation. Validation: `compiler/tests/test_runtime_prelude.py`, `compiler/tests/test_string_utils.py`.

## Coordination Notes

- Every roadmap item should cite its status source (tests, docs, or prototypes).
- When a task moves from roadmap to implementation, update `docs/status.md` and
  prune “planned” callouts in the spec / examples.
- Proposals live under `docs/proposals/`; reference them instead of duplicating
  detail here.
