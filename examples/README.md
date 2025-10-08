# Sailfin Examples

This directory showcases the evolving Sailfin language surface implemented by the bootstrap compiler. Each subfolder groups small, focused programs illustrating syntax, type constructs, effects, concurrency primitives, and forthcoming AI-native features described in `docs/spec.md`.

Where you see effect lists (e.g. `![io,model]`) or model/pipeline declarations, remember these are partially stubbed in the current Python runtime: semantics (capability enforcement, provenance, determinism) will harden in the self‑hosted toolchain.

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

> Tip: Browse examples alongside the grammar (`docs/enbf.md`) and spec (`docs/spec.md`) to see how planned features map onto the implemented subset.
