# Sailfin Roadmap

Updated: October 2025  
Owners: Sailfin Core Team

This roadmap pairs with `docs/status.md`. Update status first, then record
strategy changes here. Each section is designed so an agent can pull the next
actionable item, mark it complete, and move to the following bucket; creating new items as needed - this means that active workstreams need to be upated regularly.

## Active Workstreams (Do Now)

1. **Registry & Capsule Workflow**
   - [ ] Manifest schema — Finalise capsule (`sail.toml`) and fleet (`fleet.toml`) formats, aligning with `docs/proposals/package-management.md`.
   - [ ] CLI integration — Implement `sfn add`, `sfn run`, and `sfn publish` against `registry.sailfin.dev` using the bootstrap runtime.
   - [ ] Provenance channels — Surface model generation cards with cost / latency metadata in pipeline outputs.

2. **Self-Hosted Compiler**
   - [ ] AST + semantic passes — Introduce name resolution and effect propagation in Sailfin (`compiler/src/effect_checker.sfn`, forthcoming `typecheck.sfn`).
   - [ ] Self-hosted emitter — Expand the Sailfin emitter to cover full expression lowering and minimal runtime bindings.
   - [ ] Runtime prelude — Replace Python mock runtime with Sailfin-native implementations / FFI bridges.

## Ready Next (Pull When Active Stream Clears)

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
