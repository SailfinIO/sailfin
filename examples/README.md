# Sailfin Examples

This directory showcases the evolving Sailfin language surface implemented by the bootstrap compiler. Each subfolder groups small, focused programs illustrating syntax, type constructs, effects, and concurrency primitives described in the [language specification](https://sailfin.dev/docs/reference/spec/).

> **Syntax reform notice:** These examples use pre-reform syntax (`->` for type
> annotations, `{{ }}` for string interpolation). A pre-1.0 syntax reform is
> underway that will migrate to `:` for type annotations and `${ }` for
> interpolation. The parser already accepts `:` — see the [roadmap](https://sailfin.dev/roadmap) for
> the full plan. Examples will be migrated as each reform item lands.

Always check `docs/status.md` before relying on an example in production code. Examples stay limited to the bootstrap feature set unless noted; future-facing snippets include inline comments.

> **Undefined function calls are a compile error.** Calling a bare function name that resolves to no in-scope binding, builtin, runtime global, or imported function fails typecheck with `error[E0420]: undefined function \`name\`` — define or import the function before calling it. See [§5 Expressions](https://sailfin.dev/docs/reference/spec/05-expressions/) for the full resolution order.

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
| `borrowing.sfn`          | `io`          | **Design-stage** user-facing borrowing (`&`/`&mut` borrow expressions, `borrow(...)`, `![read]`/`![mut]`); planned form kept in comments, runnable `main` is a shipped-grammar stub (Phase U, post-1.0).            |
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
| `routine-spawn-await.sfn`     | `io`          | Checked v0 nursery, spawn, and typed-await surface.          |
| `routines.sfn`                | `io`          | Unnamed routine nursery writing to the console.              |

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
| `pointer-arithmetic.sfn`          | `io`                 | **Design-stage** pointer arithmetic with malloc/free (`unsafe` is a block/`extern` keyword, not an effect).              |
| `raw-pointers.sfn`                | `io`                 | **Design-stage** raw pointer creation/dereference with `&raw`; planned form kept in comments, runnable `main` is a shipped-grammar stub. |
| `unsafe-extern-interop.sfn`       | `io`                 | **Design-stage** extern function declarations and unsafe blocks (`unsafe` is a block/`extern` keyword, not an effect).   |
| `web-server-with-concurrency.sfn` | `clock`, `io`, `net` | HTTP handler spawning routines and throttled background work.      |

### `ai/`

| Example                    | Effects       | Notes                                                                                |
| -------------------------- | ------------- | ------------------------------------------------------------------------------------ |
| `effectful-model-call.sfn` | `io`, `model` | Demonstrates the `![model]` effect gating helper functions that perform model calls. |

### `io/`

| Example                  | Effects | Notes                                                         |
| ------------------------ | ------- | ------------------------------------------------------------- |
| `read-file.sfn`          | `io`    | Filesystem read via `fs.readFile`.                            |
| `write-file.sfn`         | `io`    | Filesystem write via `fs.writeFile`.                          |

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
- **Effect-sensitive**: `advanced`, `concurrency`, `io`, and `web` exercise **real** native-runtime capabilities (`print.*`, `fs.*`, `http.*`, `serve`, `sleep`, `channel`) gated behind effects — these are shipped runtime implementations under `runtime/sfn/`, not mocks (see the Runtime Migration table in `docs/status.md`). Declare the exact effects listed above before running them through the compiler. The exception is `ai/`: the `![model]` effect is declarable and propagates through resolved callers, but it is **not detector-enforced** — no operation triggers it and the model backend is metadata-only pending the post-1.0 `sfn/ai` capsule, so those samples annotate a reserved capability that does not yet execute.
- **Design-stage examples**: Some examples demonstrate planned features that parse but aren't fully enforced yet. These are marked with **Design-stage** in the notes column. Examples include:
  - `unsafe-extern-interop.sfn` — FFI interop with raw pointers and `unsafe` blocks. Parser accepts the syntax but unsafe semantics are not yet enforced. See [spec §6 Type System](https://sailfin.dev/docs/reference/spec/06-types/).
  - `borrowing.sfn` — **Design-stage** user-facing ownership/borrowing syntax (`&`/`&mut` borrow expressions, `borrow(...)`, `![read]`/`![mut]`). The planned form is kept in comments and the runnable `main` is a shipped-grammar stub, because a `&mut <value>` borrow expression has no parser arm yet (it would degrade to an unstructured node). The native LLVM backend enforces borrow conflicts on the runtime owned-buffer surface today (Phase R1); the user-facing grammar is previewed until Phase U.
- **Frontend-ahead-of-backend**: a subset of examples parses and type-checks (`sfn check` passes) but does **not** yet lower to a native binary (`sfn build`/`run` fails) because it exercises abstractions still pending in the backend — generic collection methods, interface method dispatch, first-class function values, and typed `Channel<T>` sends. These depend on generic constraints + monomorphization (`docs/proposals/draft-generic-constraints.md`) and first-class function values (epic #1609). Affected today: `basics/interfaces`, `basics/struct-composition`, `advanced/interface-polymorphism`, `advanced/generic-structures`, `functional/higher-order-functions`, `functional/map-reduce`, `concurrency/{channels,producer-consumer,dynamic-task-scheduling}`, and `web/websocket-chat`. Until a CI job compiles the full `examples/` set (only `basics/hello-world.sfn` is gated today), treat "parses" and "runs" as separate claims for these.
- **Forward-looking commentary**: Any future syntax remains inside comments—runnable code in this directory sticks to the shipped bootstrap grammar. Update the index whenever you add new examples or adjust their effects.

> Tip: Browse examples alongside the [grammar](https://sailfin.dev/docs/reference/grammar) and [spec](https://sailfin.dev/docs/reference/spec/) to see how planned features map onto the implemented subset.
