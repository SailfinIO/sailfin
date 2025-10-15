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

## Capability Index

Effect annotations (`![...]`) flag the runtime capabilities you need to declare before running each sample. The tables below list every runnable example, the effects it requires, and the mocked bootstrap helpers it touches.

### `basics/`

| Example | Effects | Notes |
|---------|---------|-------|
| `basic-enum.sfn` | `io` | Enum pattern matching with console logging. |
| `borrowing.sfn` | `mut`, `read` | Stage2 borrowing design sample; shows moves, shared borrows, and reborrows without runtime enforcement yet. |
| `conditionals.sfn` | `io` | Branching over values with `print.info`. |
| `error-handling.sfn` | `io` | Struct-based error propagation matched with logging. |
| `functions.sfn` | `io` | Function defaults and overloading with console output. |
| `hello-world.sfn` | `io` | Minimal greeting emitted via `print.info`. |
| `interfaces.sfn` | `io` | Trait-style dispatch routed through the console. |
| `loops.sfn` | `io` | `for` iteration and `loop`/`break`/`continue` control flow. |
| `struct-composition.sfn` | `io` | Interface composition exercised with `print.info`. |
| `structs.sfn` | `io` | Struct constructors and method calls with logging. |
| `tagged-enum.sfn` | `io` | Tagged union match executed inside `main`. |
| `tests.sfn` | `model` | Bootstrap `test` block; effect mirrors the current harness expectations. |
| `try-catch-finally.sfn` | `io` | Structured error handling with explicit failure stubs. |
| `variables.sfn` | `io` | Mutable vs. immutable bindings with console output. |

### `algorithms/`

| Example | Effects | Notes |
|---------|---------|-------|
| `quicksort.sfn` | `io` | Functional quicksort using `.map/.filter/.concat` helpers and logging. |

### `functional/`

| Example | Effects | Notes |
|---------|---------|-------|
| `higher-order-functions.sfn` | `io` | Function values and callbacks with console output. |
| `map-reduce.sfn` | `io` | Inline lambda transforms with chaining helpers. |

### `types/`

| Example | Effects | Notes |
|---------|---------|-------|
| `recursive-types.sfn` | `io` | Recursive shape matching with `print.info`. |
| `tagged-unions.sfn` | `io` | Union intersection sample with runtime logging. |

### `concurrency/`

| Example | Effects | Notes |
|---------|---------|-------|
| `channels.sfn` | `io` | Channel send/receive with awaited reads. |
| `dynamic-task-scheduling.sfn` | `io` | Work-stealing queue feeding background routines. |
| `parallel.sfn` | `io` | `parallel [...]` execution returning aggregated results. |
| `producer-consumer.sfn` | `clock`, `io` | Bounded buffer with `sleep` pacing producers and consumers. |
| `routines.sfn` | `io` | Named and unnamed routines writing to the console. |

### `advanced/`

| Example | Effects | Notes |
|---------|---------|-------|
| `decorators.sfn` | `io` | `@logExecution` decorator enforcing `io`. |
| `effectful-interface.sfn` | `io`, `model` | Interfaces with model-bound methods and console output. |
| `encapsulation-struct.sfn` | `io` | Mutable struct state with logging and error handling. |
| `futures.sfn` | `io` | `async`/`await` fan-out joined with console logging. |
| `generic-structures.sfn` | `io` | Generic struct methods manipulating collections. |
| `interface-polymorphism.sfn` | `io` | Interface-backed dispatch printing results. |
| `lambda-closure.sfn` | `io` | Inline closure capturing arguments and logging outputs. |
| `matrix-multiplication.sfn` | `io` | Nested `.map/.reduce` over ranges with console output. |
| `multithreaded-task.sfn` | `clock`, `io` | `parallel` tasks calling `sleep` and logging completion. |
| `parametric-polymorphism.sfn` | `io` | Generic identity function with logged values. |
| `type-guards.sfn` | `io` | Runtime type refinement and guarded matches within `main`. |
| `unions.sfn` | `io` | Union + intersection typing with runtime checks. |
| `web-server-with-concurrency.sfn` | `clock`, `io`, `net` | HTTP handler spawning routines and throttled background work. |

### `ai/`

| Example | Effects | Notes |
|---------|---------|-------|
| `effectful-model-call.sfn` | `io`, `model` | Prompt-style helpers with mocked model calls and console logging. |
| `model-workflow.sfn` | `io`, `model`, `net` | Pipeline wiring a model invocation with auxiliary `net` tool use. |

### `io/`

| Example | Effects | Notes |
|---------|---------|-------|
| `capability_bridges.sfn` | `io` | Uses runtime capability grants and filesystem bridge helpers. |
| `read-file.sfn` | `io` | Mocked filesystem read via `runtime.fs.read`. |
| `write-file.sfn` | `io` | Mocked filesystem write illustrating `fs.write`. |

### `web/`

| Example | Effects | Notes |
|---------|---------|-------|
| `async.sfn` | `io`, `net` | Async handler returning JSON responses. |
| `fetch-data.sfn` | `io`, `net` | HTTP client fetch with logging. |
| `http-server.sfn` | `net` | Minimal HTTP server responding to routes. |
| `rest-api.sfn` | `io`, `net` | REST-style routing with console diagnostics. |
| `websocket-chat.sfn` | `io`, `net` | WebSocket echo server broadcasting messages. |

## Runtime Notes

- **Stage1-friendly**: `basics`, `functional`, `types`, and `algorithms` only rely on console I/O and pure language constructs covered by the stage1 pipeline.
- **Effect-sensitive**: `advanced`, `concurrency`, `ai`, `io`, and `web` rely on mocked helpers (`print.*`, `fs.*`, `http.*`, `serve`, `sleep`, `channel`, `model` prompts). Declare the exact effects listed above before running them through the bootstrap compiler.
- **Forward-looking commentary**: Any future syntax remains inside comments—runnable code in this directory sticks to the shipped bootstrap grammar. Update the index whenever you add new examples or adjust their effects.

> Tip: Browse examples alongside the grammar (`docs/enbf.md`) and spec (`docs/spec.md`) to see how planned features map onto the implemented subset.
