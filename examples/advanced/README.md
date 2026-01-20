# Advanced Examples

Higher-level language features: generics, parametric polymorphism, closures, decorators, effectful interfaces, concurrency + networking integration, type guards, matrix math, and union/intersection typing. These illustrate directions described in `docs/spec.md` beyond the basic surface.

## Files

- **`decorators.sfn`** – Illustrates decorator syntax (`@logExecution`) parsed but currently ignored by the bootstrap backend.
- **`effectful-interface.sfn`** – Interface with effect‑annotated method (`![model]`) and a concrete implementation, plus an effectful `main`.
- **`encapsulation-struct.sfn`** – Struct with mutable state, validation, and `try/catch` error handling.
- **`futures.sfn`** – Basic `async` functions executed concurrently with `await` join semantics.
- **`generic-structures.sfn`** – Generic `List<T>` demonstrating type parameters, methods, and simple bounds checking.
- **`interface-polymorphism.sfn`** – Multiple concrete types satisfying a shared interface for dynamic dispatch.
- **`lambda-closure.sfn`** – Inline lambda / closure expression assigned to a variable.
- **`matrix-multiplication.sfn`** – Nested functional iteration (`map` + `reduce`) for numerical computation.
- **`multithreaded-task.sfn`** – Parallel task execution using `parallel [...]` with simulated latency.
- **`parametric-polymorphism.sfn`** – Generic identity function instantiation for multiple concrete types.
- **`type-guards.sfn`** – Runtime type discrimination with `is` plus match guards for struct destructuring.
- **`unions.sfn`** – Working with union types, intersection via combined interfaces, and structural access.
- **`web-server-with-concurrency.sfn`** – HTTP handler spawning a routine for background computation while continuing to serve requests.
- **`unions.sfn`** – (Also covers intersection types and narrowing.)
- **`type-guards.sfn`** – (Also covers pattern matching.)
- **`matrix-multiplication.sfn`** – (Also covers higher-order functions.)
- **`pointer-arithmetic.sfn`** – Low-level memory manipulation with pointers, offsets, and dereferencing.
- **`raw-pointers.sfn`** – Unsafe operations with raw pointers, including casting and manual memory management.
- **`unsafe-extern-interop.sfn`** – Calling external C functions with unsafe blocks and pointer handling.

## Notes

- Effect lists are illustrative; enforcement will strengthen in the self‑hosted compiler.
- Decorators & advanced type inference are currently metadata only—code generation is conservative.
- Intersection types (`Admin & User`) and union narrowing via `is` / pattern matching will gain exhaustiveness diagnostics later.
