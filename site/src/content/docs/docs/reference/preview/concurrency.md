---
title: "Concurrency"
description: "Design preview — Concurrency (v0). `routine`, `channel`, `spawn`/`await` on spawned tasks, and `parallel` work today. Full `async fn` semantics and typed `Channel<T>` are still planned."
sidebar:
  order: 1
---

```sfn
// v0: `routine { }`, channels, `spawn`/`await`, and `parallel` work today.
// `async fn` return-value `await` is not yet wired into the live typecheck walk.

fn process_batch(items: string[]) ![io] {
    let messages = channel(4);   // bounded MPMC channel, capacity 4

    routine {
        messages.send(42);       // runs inside the structured-concurrency nursery
    }

    let task = spawn fn() -> int { return 1 + 1; };
    let result: int = await task;   // runs on the thread pool; await joins
}
```

## What ships today (v0)

`routine { }` lowers to a real structured-concurrency nursery (`sfn_nursery_enter`/`sfn_nursery_exit`), `channel(N)` runs end-to-end as a bounded MPMC channel, `spawn fn() -> T { ... }` runs tasks on the thread pool and `await` joins them returning the typed result, and `parallel [...]` fans tasks out across the pool and joins them. The worker pool floors at two workers; use `SAILFIN_THREADS=N` to override. See [docs/status.md](/docs/status.md) for per-feature detail.

### Capture-env ownership for `spawn` / `parallel` (#1475, epic #1466)

A task lambda that captures variables from the enclosing scope owns its heap environment across the thread boundary and frees it exactly once after the task body completes. The mechanics:

- The captured env is allocated with `sfn_env_alloc` (unconditional libc `calloc`, never arena-routed), so it is individually freeable after crossing the thread boundary.
- The spawn/parallel trampoline calls `sfn_env_free(ctx)` after the worker body returns (null-safe; non-capturing tasks are unaffected).
- The sender's binding is statically marked `Moved` at the spawn site; reusing it after `spawn`/`parallel` raises `E0901` (use-after-move).
- Synchronous (non-spawned) closures are unchanged — they keep the arena fast-path.

**Boundary.** This covers the env-container lifetime for value and pointer-identity captures. `OwnedBuf`/string capture-buffer ownership across the thread boundary (result-aliases, length-carrying buffers) is deferred to #1476.

### Effect requirement (`![io]`, conservative — #1655)

`spawn`, `parallel`, and channel `send`/`receive` currently require the `![io]` effect. As of #1655 this requirement is derived from a single source of truth — the runtime-helper descriptor registry — rather than hardcoded in the effect checker, so the checker and the registry can never disagree.

`io` here is a deliberate **conservative placeholder**: the v0 scheduler primitives are pure in-process pthread mutex/condvar/MPMC-queue and touch no filesystem, network, console, or clock, so under the canonical taxonomy (`io, net, model, gpu, rand, clock`) none of them genuinely exercises `io`. The principled end state is **effect-transparency** — the spawned/joined body's own effects propagate and the primitive itself adds none — tracked as #1702 (gated on the structured-concurrency runtime settling, #1575). Until then, a function that uses any concurrency primitive must declare `![io]`.

**Remaining pre-1.0 work**: full `async fn` return-value `await` wired into the live typecheck walk (#1944), typed `Channel<T>` generic constructor (#1942), typed result-array collection from `parallel`, and `OwnedBuf` capture-buffer ABI across the thread boundary (#1476).
See the [roadmap](/roadmap).
