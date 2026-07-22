---
title: "Concurrency"
description: "Concurrency (v0) — `routine`, bounded channels, `spawn`/`await` on spawned tasks, `parallel`, and typed channel binding checks work today; full `async fn` semantics and a generic channel constructor remain planned."
sidebar:
  order: 1
---

```sfn
// Shipped v0 structured concurrency: a routine nursery joins its spawned task.
fn main() ![io] {
    routine {
        let task = spawn fn () -> int { return 40 + 2; };
        let result: int = await task;
        print("Result: {{result}}");
    }
}
```

This checked example is maintained at
[`examples/concurrency/routine-spawn-await.sfn`](https://github.com/SailfinIO/sailfin/blob/main/examples/concurrency/routine-spawn-await.sfn)
and prints `Result: 42`.

## What ships today (v0)

`routine { }` lowers to a real structured-concurrency nursery
(`sfn_nursery_enter`/`sfn_nursery_exit`), `channel(N)` runs end-to-end as a
bounded MPMC channel, `spawn fn() -> T { ... }` runs tasks on the thread pool
and `await` joins them returning the typed result, and `parallel [...]` fans
tasks out across the pool and joins them. The worker pool floors at two workers;
use `SAILFIN_THREADS=N` to override. See
[docs/status.md](https://github.com/SailfinIO/sailfin/blob/main/docs/status.md)
for per-feature detail.

`routine` is the nursery boundary; there is no separate `scope { ... }`
construct. Nursery exit joins every child, and non-local exits (`return`,
`throw`, `break`, or `continue`) from the body are rejected. The v0 nursery is
per-thread, joins without destroying its state, and does not cancel sibling
tasks when one fails.

### Capture-env ownership for `spawn` / `parallel` (#1475, epic #1466)

A task lambda that captures variables from the enclosing scope owns its heap environment across the thread boundary and frees it exactly once after the task body completes. The mechanics:

- The captured env is allocated with `sfn_env_alloc` (unconditional libc `calloc`, never arena-routed), so it is individually freeable after crossing the thread boundary.
- The spawn/parallel trampoline calls `sfn_env_free(ctx)` after the worker body returns (null-safe; non-capturing tasks are unaffected).
- The sender's binding is statically marked `Moved` at the spawn site; reusing it after `spawn`/`parallel` raises `E0901` (use-after-move).
- Synchronous (non-spawned) closures are unchanged — they keep the arena fast-path.

**Boundary.** This covers the env-container lifetime for value and pointer-identity captures. `OwnedBuf`/string capture-buffer ownership across the thread boundary (result-aliases, length-carrying buffers) is deferred to #1476.

### Effect transparency (SFEP-0049)

`spawn`, `parallel`, and channel `send`/`receive` are **effect-transparent**: the in-process primitive contributes no effect of its own, and the caller inherits exactly the effects of the body it spawns/sends. A concurrency op over a **pure** body requires no effect; over an effectful body (e.g. one that calls `print`), that body's effects (`io`, …) propagate. The requirement is derived from a single source of truth — the runtime-helper descriptor registry (#1655), whose concurrency rows now carry no effect — so the checker and the registry can never disagree.

This is principled, not conservative: the v0 scheduler primitives are pure in-process pthread mutex/condvar/MPMC-queue and touch no filesystem, network, console, or clock, so under the canonical taxonomy (`io, net, model, gpu, rand, clock`) none genuinely exercises `io` — as Go treats goroutine spawn as effect-free. The **join-side** counterpart (`await` and `routine {}` nursery-exit effect propagation) is out of scope here and tracked with the concurrency-maturity work (SFN-124).

**Remaining work**: full `async fn` return-value `await` wired into the live
typecheck walk, a generic `channel<T>(...)` constructor, typed result-array
collection from `parallel`, cancellation, async I/O, and the `OwnedBuf`
capture-buffer ABI across the thread boundary (#1476).
See the [roadmap](/roadmap).
