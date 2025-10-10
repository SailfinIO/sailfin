# Sailfin Examples

This directory showcases the evolving Sailfin language surface implemented by the bootstrap compiler. Each subfolder groups small, focused programs illustrating syntax, type constructs, effects, concurrency primitives, and forthcoming AI-native features described in `docs/spec.md`.

Always check `docs/status.md` before relying on an example in production code. Examples stay limited to the bootstrap feature set unless noted; future-facing snippets include inline comments.

Where you see effect lists (e.g. `![io,model]`) or model/pipeline declarations, remember these are partially stubbed in the current Python runtime: semantics (capability enforcement, provenance, determinism) will harden in the self-hosted toolchain.

## Categories

- [Basics](./basics/) – Variables, functions, conditionals, pattern matching, enums, interfaces, tests, and error handling.
- [Concurrency](./concurrency/) – Routines, channels, dynamic scheduling, and parallel execution primitives.
- [Web](./web/) – HTTP & WebSocket server patterns plus async I/O examples.
- [Advanced](./advanced/) – Generics, polymorphism, closures, decorators, type guards, effectful interfaces, concurrency + web integration, matrix math, and more.
- [AI](./ai/) – Model declarations, prompt blocks, tools, pipelines, effect annotations, and deterministic scope helpers.
- [Algorithms](./algorithms/) – Classic algorithms expressed in Sailfin (currently `quicksort`).
- [Functional](./functional/) – Higher‑order functions, map/reduce, immutable style data transforms.
- [I/O](./io/) – File system read/write helpers (stubbed in bootstrap runtime).
- [Types](./types/) – Recursive types, tagged unions, ADTs & pattern matching examples.

## Capability Matrix

| Directory | Primary effects | Bootstrap readiness | Notes |
|-----------|-----------------|---------------------|-------|
| `basics/` | _none_ | ✅ Fully runnable | Syntax + control-flow exercises with no effectful helpers. |
| `algorithms/` | _none_ | ✅ Fully runnable | Pure computation demos (e.g. `quicksort`). |
| `functional/` | _none_ | ✅ Fully runnable | Higher-order utilities; relies only on standard expressions. |
| `types/` | _none_ | ✅ Fully runnable | Algebraic data types and pattern matching with no runtime calls. |
| `advanced/` | mixed (`io`, `net`) | ⚠️ Effect-sensitive | Individual files note required effects; all code stays within bootstrap syntax, but mocked helpers are involved (decorators, concurrency + web). |
| `concurrency/` | `io` (channels, `spawn`), optional `clock` | ⚠️ Effect-sensitive | Uses runtime scheduling helpers; relies on mocked concurrency adapters. |
| `web/` | `io`, `net` | ⚠️ Effect-sensitive | Demonstrates `serve`, `http`, and WebSocket APIs backed by the mocked runtime. |
| `io/` | `io` | ⚠️ Effect-sensitive | Uses `fs.*` helpers; no real filesystem writes occur. |
| `ai/` | `model`, `io`, `net` | ⚠️ Effect-sensitive | Prompt blocks and tool calls target the mocked model/runtime surface. |

## Runtime Notes

- **Bootstrap-friendly**: `basics`, `functional`, `types`, and `algorithms` avoid undeclared effects and run end-to-end with mocked runtime helpers.
- **Effect-sensitive**: `ai`, `web`, `concurrency`, and `io` rely on the mocked `http`, `websocket`, `fs`, and scheduling helpers in `bootstrap/runtime_support.py`. They validate syntax and effect enforcement but do not perform real network or file I/O.
- **Forward-looking**: Selected files in `advanced/` and `ai/` include comments that mark syntax planned for the self-hosted compiler (e.g., currency literals, pipeline operators). The executable code paths stay within the bootstrap grammar; if you introduce future syntax, gate it with comments and update this matrix.

> Tip: Browse examples alongside the grammar (`docs/enbf.md`) and spec (`docs/spec.md`) to see how planned features map onto the implemented subset.
