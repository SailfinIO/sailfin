# Sailfin Roadmap

Updated: October 2025  
Owners: Sailfin Core Team

This roadmap pairs with `docs/status.md`. Update status first, then record
strategy changes here. Each section is designed so an agent can pull the next
actionable item, mark it complete, and move to the following bucket; creating new items as needed.

## Active Workstreams (Do Now)

1. **Bootstrap Reliability**
   - [ ] Parser parity — Close remaining gaps between the Python and Sailfin-native parsers (block-level `if`/`else`, `for`, and `match` now parsed; pattern guards and rich expressions next). Source: `compiler/src/parser.sfn`.
   - [ ] Example hardening — Classify examples by capability usage and remove future-only syntax from runnable samples. Source: `examples/README.md`.

2. **Registry & Capsule Workflow**
   - [ ] Manifest schema — Finalise capsule (`sail.toml`) and fleet (`fleet.toml`) formats, aligning with `docs/proposals/package-management.md`.
   - [ ] CLI integration — Implement `sfn add`, `sfn run`, and `sfn publish` against `registry.sailfin.dev` using the bootstrap runtime.
   - [ ] Provenance channels — Surface model generation cards with cost / latency metadata in pipeline outputs.

3. **Self-Hosted Compiler**
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
- [x] Self-hosted effect helpers — Added console IO and `sleep` detection to the Sailfin effect checker. Validation: `bootstrap/tests/test_compiler_sources.py` covers missing `io`/`clock` enforcement.

## Coordination Notes

- Every roadmap item should cite its status source (tests, docs, or prototypes).
- When a task moves from roadmap to implementation, update `docs/status.md` and
  prune “planned” callouts in the spec / examples.
- Proposals live under `docs/proposals/`; reference them instead of duplicating
  detail here.
