# Sailfin Roadmap

Updated: October 2025  
Owners: Sailfin Core Team

This roadmap pairs with `docs/status.md`. Update status first, then record
strategy changes here. Each section is designed so an agent can pull the next
actionable item, mark it complete, and move to the following bucket; creating new items as needed.

## Active Workstreams (Do Now)

1. **Bootstrap Reliability**
   - [ ] Parser parity — Close remaining gaps between the Python and Sailfin-native parsers (control-flow expressions, pattern matching, decorator arguments). Source: `compiler/src/parser.sfn`.
   - [ ] Effect enforcement — Extend stage0 effect checks to cover broader runtime helpers (`fs`, `http`, `websocket`, `serve`, `spawn`). Source: `bootstrap/effect_checker.py`, `bootstrap/runtime_support.py`.
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

## Coordination Notes

- Every roadmap item should cite its status source (tests, docs, or prototypes).
- When a task moves from roadmap to implementation, update `docs/status.md` and
  prune “planned” callouts in the spec / examples.
- Proposals live under `docs/proposals/`; reference them instead of duplicating
  detail here.
