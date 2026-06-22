---
title: "Concurrency"
description: "Design preview — Concurrency. Partially shipped; `await` and full async semantics are still planned."
sidebar:
  order: 1
---

```sfn
// `routine { }`, channels, `spawn`, and `parallel` work today; `await` does not.

import { Channel, channel } from "sync";

async fn fetch(url: string) -> string ![net] {
    return await http.get(url);   // await not yet implemented
}

fn process_batch(items: Item[]) ![io] {
    let messages: Channel<string> = channel();

    routine {
        messages.send("hello");
    }

    let msg = await messages.receive();
}
```

## What ships today

`routine { }` lowers to a real structured-concurrency nursery (`sfn_nursery_enter`/`sfn_nursery_exit`), `channel(N)` runs end-to-end as a bounded MPMC channel, `spawn fn() -> T { ... }` runs tasks on the thread pool, and `parallel [...]` fans tasks out across the pool and joins them. See [docs/status.md](/docs/status.md) for per-feature detail.

### Capture-env ownership for `spawn` / `parallel` (#1475, epic #1466)

A task lambda that captures variables from the enclosing scope owns its heap environment across the thread boundary and frees it exactly once after the task body completes. The mechanics:

- The captured env is allocated with `sfn_env_alloc` (unconditional libc `calloc`, never arena-routed), so it is individually freeable after crossing the thread boundary.
- The spawn/parallel trampoline calls `sfn_env_free(ctx)` after the worker body returns (null-safe; non-capturing tasks are unaffected).
- The sender's binding is statically marked `Moved` at the spawn site; reusing it after `spawn`/`parallel` raises `E0901` (use-after-move).
- Synchronous (non-spawned) closures are unchanged — they keep the arena fast-path.

**Boundary.** This covers the env-container lifetime for value and pointer-identity captures. `OwnedBuf`/string capture-buffer ownership across the thread boundary (result-aliases, length-carrying buffers) is deferred to #1476.

**Planned for 1.0**: `await`, full async semantics, typed result-array collection from `parallel`, and `OwnedBuf` capture-buffer ABI (#1476).
See the [roadmap](/roadmap).
