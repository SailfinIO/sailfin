# Sailfin Examples

This directory showcases the evolving Sailfin language surface implemented by the bootstrap compiler. Each subfolder groups small, focused programs illustrating syntax, type constructs, effects, and concurrency primitives described in the [language specification](https://sailfin.dev/docs/reference/spec/).

> **Syntax reform notice:** These examples use pre-reform syntax (`->` for type
> annotations, `{{ }}` for string interpolation). A pre-1.0 syntax reform is
> underway that will migrate to `:` for type annotations and `${ }` for
> interpolation. The parser already accepts `:` — see the [roadmap](https://sailfin.dev/roadmap) for
> the full plan. Examples will be migrated as each reform item lands.

Always check `docs/status.md` before relying on an example in production code. Examples stay limited to the bootstrap feature set unless noted; future-facing snippets include inline comments.

Where you see effect lists (e.g. `![io, model]`), remember the runtime backing is partially stubbed: capability enforcement will harden through the self-hosted toolchain. Richer AI functionality (model declarations, prompt composition, tool dispatch) is being delivered as a post-1.0 `sfn/ai` library capsule rather than language syntax; the `![model]` effect is the only AI-specific construct that stays in the language.

## Categories

- [Basics](./basics/) – Variables, functions, conditionals, pattern matching, enums, interfaces, tests, and error handling.
- [Concurrency](./concurrency/) – Routines, channels, dynamic scheduling, and parallel execution primitives.
- [Web](./web/) – HTTP & WebSocket server patterns plus async I/O examples.
- [Advanced](./advanced/) – Generics, polymorphism, closures, decorators, type guards, effectful interfaces, concurrency + web integration, matrix math, and more.
- [AI](./ai/) – The `![model]` effect gating functions that perform model work.
- [Algorithms](./algorithms/) – Classic algorithms expressed in Sailfin (currently `quicksort`).
- [Functional](./functional/) – Higher‑order functions, map/reduce, immutable style data transforms.
- [I/O](./io/) – File system read/write helpers (stubbed in bootstrap runtime).
- [Types](./types/) – Recursive types, tagged unions, ADTs & pattern matching examples.

## Capability Index

Effect annotations (`![...]`) flag the runtime capabilities you need to declare before running each sample. The tables below list every runnable example, the effects it requires, and the mocked bootstrap helpers it touches.

### `basics/`

| Example                  | Effects       | Notes                                                                                                                                      |
| ------------------------ | ------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| `basic-enum.sfn`         | `io`          | Enum pattern matching with console logging.                                                                                                |
| `borrowing.sfn`          | `mut`, `read` | Native compiler borrowing design sample (legacy name: stage2); shows moves, shared borrows, and reborrows without runtime enforcement yet. |
| `conditionals.sfn`       | `io`          | Branching over values with `print.info`.                                                                                                   |
| `error-handling.sfn`     | `io`          | Struct-based error propagation matched with logging.                                                                                       |
| `functions.sfn`          | `io`          | Function defaults and overloading with console output.                                                                                     |
| `hello-world.sfn`        | `io`          | Minimal greeting emitted via `print.info`.                                                                                                 |
| `interfaces.sfn`         | `io`          | Trait-style dispatch routed through the console.                                                                                           |
| `loops.sfn`              | `io`          | `for` iteration and `loop`/`break`/`continue` control flow.                                                                                |
| `struct-composition.sfn` | `io`          | Interface composition exercised with `print.info`.                                                                                         |
| `structs.sfn`            | `io`          | Struct constructors and method calls with logging.                                                                                         |
| `tagged-enum.sfn`        | `io`          | Tagged union match executed inside `main`.                                                                                                 |
| `tests.sfn`              | `model`       | Bootstrap `test` block; effect mirrors the current harness expectations.                                                                   |
| `try-catch-finally.sfn`  | `io`          | Structured error handling with explicit failure stubs.                                                                                     |
| `variables.sfn`          | `io`          | Mutable vs. immutable bindings with console output.                                                                                        |

### `algorithms/`

| Example         | Effects | Notes                                                                  |
| --------------- | ------- | ---------------------------------------------------------------------- |
| `quicksort.sfn` | `io`    | Functional quicksort using `.map/.filter/.concat` helpers and logging. |

### `functional/`

| Example                      | Effects | Notes                                              |
| ---------------------------- | ------- | -------------------------------------------------- |
| `higher-order-functions.sfn` | `io`    | Function values and callbacks with console output. |
| `map-reduce.sfn`             | `io`    | Inline lambda transforms with chaining helpers.    |

### `types/`

| Example               | Effects | Notes                                           |
| --------------------- | ------- | ----------------------------------------------- |
| `recursive-types.sfn` | `io`    | Recursive shape matching with `print.info`.     |
| `tagged-unions.sfn`   | `io`    | Union intersection sample with runtime logging. |

### `concurrency/`

| Example                       | Effects       | Notes                                                       |
| ----------------------------- | ------------- | ----------------------------------------------------------- |
| `channels.sfn`                | `io`          | Channel send/receive with awaited reads.                    |
| `dynamic-task-scheduling.sfn` | `io`          | Work-stealing queue feeding background routines.            |
| `parallel.sfn`                | `io`          | `parallel [...]` execution returning aggregated results.    |
| `producer-consumer.sfn`       | `clock`, `io` | Bounded buffer with `sleep` pacing producers and consumers. |
| `routines.sfn`                | `io`          | Named and unnamed routines writing to the console.          |

### `advanced/`

| Example                           | Effects              | Notes                                                              |
| --------------------------------- | -------------------- | ------------------------------------------------------------------ |
| `decorators.sfn`                  | `io`                 | `@logExecution` decorator enforcing `io`.                          |
| `effectful-interface.sfn`         | `io`, `model`        | Interfaces with model-bound methods and console output.            |
| `encapsulation-struct.sfn`        | `io`                 | Mutable struct state with logging and error handling.              |
| `futures.sfn`                     | `io`                 | `async`/`await` fan-out joined with console logging.               |
| `generic-structures.sfn`          | `io`                 | Generic struct methods manipulating collections.                   |
| `interface-polymorphism.sfn`      | `io`                 | Interface-backed dispatch printing results.                        |
| `lambda-closure.sfn`              | `io`                 | Inline closure capturing arguments and logging outputs.            |
| `matrix-multiplication.sfn`       | `io`                 | Nested `.map/.reduce` over ranges with console output.             |
| `multithreaded-task.sfn`          | `clock`, `io`        | `parallel` tasks calling `sleep` and logging completion.           |
| `parametric-polymorphism.sfn`     | `io`                 | Generic identity function with logged values.                      |
| `type-guards.sfn`                 | `io`                 | Runtime type refinement and guarded matches within `main`.         |
| `unions.sfn`                      | `io`                 | Union + intersection typing with runtime checks.                   |
| `pointer-arithmetic.sfn`          | `io`, `unsafe`       | **Design-stage** pointer arithmetic with malloc/free.              |
| `raw-pointers.sfn`                | `io`, `unsafe`       | **Design-stage** raw pointer creation and dereference with `&raw`. |
| `unsafe-extern-interop.sfn`       | `io`, `unsafe`       | **Design-stage** extern function declarations and unsafe blocks.   |
| `web-server-with-concurrency.sfn` | `clock`, `io`, `net` | HTTP handler spawning routines and throttled background work.      |

### `ai/`

| Example                    | Effects       | Notes                                                                                |
| -------------------------- | ------------- | ------------------------------------------------------------------------------------ |
| `effectful-model-call.sfn` | `io`, `model` | Demonstrates the `![model]` effect gating helper functions that perform model calls. |

### `io/`

| Example                  | Effects | Notes                                                         |
| ------------------------ | ------- | ------------------------------------------------------------- |
| `capability_bridges.sfn` | `io`    | Uses runtime capability grants and filesystem bridge helpers. |
| `read-file.sfn`          | `io`    | Mocked filesystem read via `runtime.fs.read`.                 |
| `write-file.sfn`         | `io`    | Mocked filesystem write illustrating `fs.write`.              |

### `web/`

| Example              | Effects     | Notes                                        |
| -------------------- | ----------- | -------------------------------------------- |
| `async.sfn`          | `io`, `net` | Async handler returning JSON responses.      |
| `fetch-data.sfn`     | `io`, `net` | HTTP client fetch with logging.              |
| `http-server.sfn`    | `net`       | Minimal HTTP server responding to routes.    |
| `rest-api.sfn`       | `io`, `net` | REST-style routing with console diagnostics. |
| `websocket-chat.sfn` | `io`, `net` | WebSocket echo server broadcasting messages. |

## Runtime Notes

- **Bootstrap-friendly (legacy name: stage1)**: `basics`, `functional`, `types`, and `algorithms` only rely on console I/O and pure language constructs covered by the bootstrap pipeline.
- **Effect-sensitive**: `advanced`, `concurrency`, `ai`, `io`, and `web` rely on mocked helpers (`print.*`, `fs.*`, `http.*`, `serve`, `sleep`, `channel`). Declare the exact effects listed above before running them through the bootstrap compiler.
- **Design-stage examples**: Some examples demonstrate planned features that parse but aren't fully enforced yet. These are marked with **Design-stage** in the notes column. Examples include:
  - `unsafe-extern-interop.sfn` — FFI interop with raw pointers and `unsafe` blocks. Parser accepts the syntax but unsafe semantics are not yet enforced. See [spec §6 Type System](https://sailfin.dev/docs/reference/spec/06-types/).
  - `borrowing.sfn` — Ownership and borrowing syntax. Parser accepts but the bootstrap compiler does not enforce exclusivity. The native LLVM backend (legacy name: stage2) enforces borrow conflicts.
- **Forward-looking commentary**: Any future syntax remains inside comments—runnable code in this directory sticks to the shipped bootstrap grammar. Update the index whenever you add new examples or adjust their effects.

> Tip: Browse examples alongside the [grammar](https://sailfin.dev/docs/reference/grammar) and [spec](https://sailfin.dev/docs/reference/spec/) to see how planned features map onto the implemented subset.
