# Concurrency Examples

Illustrates Sailfin's structured concurrency surface: routines (lightweight tasks), channels for message passing, dynamic scheduling, and parallel evaluation. These map to §5 of `docs/spec.md`.

## Files

- **`routines.sfn`** – Launching named and unnamed `routine` blocks.
- **`channels.sfn`** – Asynchronous send/receive with a typed `Channel<T>`; `await` usage.
- **`producer-consumer.sfn`** – Bounded buffer with backpressure semantics (`channel(10)`).
- **`dynamic-task-scheduling.sfn`** – Worker routines pulling closures from a task channel.
- **`parallel.sfn`** – Embarrassingly parallel computation returning a result vector.

## Notes

- Effect declarations (`![io]`, `![net]`, etc.) are omitted here; concurrency primitives will later require explicit capability tokens for timing / randomness where applicable.
- `parallel [ ... ]` is a convenience construct; the bootstrap maps this to concurrent execution and collects results.
- Future work: cancellation scopes, deadlines (`scope.with_timeout`), deterministic seeds, structured error propagation.
