# Concurrency Examples

Illustrates Sailfin's shipped v0 structured concurrency surface: routine
nurseries, channels for message passing, spawn / await, dynamic scheduling, and
parallel evaluation. See the
[Concurrency status reference](https://sailfin.dev/docs/reference/preview/concurrency/)
for shipped behavior and current limitations.

## Files

- **`routines.sfn`** – Launching named and unnamed `routine` blocks.
- **`channels.sfn`** – Asynchronous send/receive with a typed `Channel<T>`; `await` usage.
- **`producer-consumer.sfn`** – Bounded buffer with backpressure semantics (`channel(10)`).
- **`dynamic-task-scheduling.sfn`** – Worker routines pulling closures from a task channel.
- **`parallel.sfn`** – Embarrassingly parallel computation returning a result vector.

## Notes

- Effect declarations cover the operations performed inside each task; the
  concurrency constructs themselves do not introduce a separate effect.
- `parallel [ ... ]` runs its entries concurrently on the v0 worker pool and
  collects results in source order.
- Future work includes cancellation scopes, deadlines, structured error
  propagation, and a non-blocking reactor/async-I/O runtime.
