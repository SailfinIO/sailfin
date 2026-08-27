---
title: "Concurrency"
description: "Concurrency (v0) — `routine`, bounded channels, `spawn`/`await` on spawned tasks, `parallel`, typed channel binding checks, and typed `Task<T>` handles with ordered `join_all` work today; full `async fn` semantics and a generic channel constructor remain planned."
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
and `await` joins them returning the typed result, `parallel [...]` fans
tasks out across the pool and joins them, and a spawned task's handle can be
typed as `Task<T>` and collected/awaited in order with `join_all`. The worker
pool floors at two workers; use `SAILFIN_THREADS=N` to override. See
[docs/status.md](https://github.com/SailfinIO/sailfin/blob/main/docs/status.md)
for per-feature detail.

`routine` is the nursery boundary; there is no separate `scope { ... }`
construct. Nursery exit joins every child, and non-local exits (`return`,
`throw`, `break`, or `continue`) from the body are rejected. The v0 nursery is
per-thread, joins without destroying its state, and does not cancel sibling
tasks when one fails.

A channel created inside a `routine {}` is owned by that nursery. It may be
used and aliased within the block, but assigning the handle directly or through
an alias to a longer-lived scalar, aggregate field, indexed collection, or
module global raises `E0838`. Channels created outside a nursery—including the
module-global sharing pattern—remain ambient and are not flagged (SFN-694).

### Spawning a named function (SFN-1006)

`spawn <fn>()` — a call to a **zero-argument** declared or imported function
— is a second spawn shape alongside the inline `fn` literal:

```sfn
fn worker() -> int { return 7; }
fn main() -> int ![io] {
    let hs: Task<int>[] = [spawn worker()];
    let v: int = await hs[0];
    print("v = {{v}}");
    return 0;
}
```

The lowering resolves `worker`'s declared return type from the compiled
function table and dispatches through the same typed `sfn_spawn_<kind>`
family as the inline lambda form — no lifted lambda, no environment
allocation. Every other spawn operand is rejected at `sfn check` with
**E0842**: a call with arguments (`spawn worker(1)`), a method or computed
callee (`spawn obj.work()`), a call to a name that is not a declared
function, or any other expression that is not a call or an inline `fn`
literal. Argument marshalling needs a thunk the frontend does not synthesize
yet, so wrap it: `spawn fn() -> int { return worker(1, 2); }`.

### Capture-env ownership for `spawn` / `parallel` (#1475, epic #1466)

A task lambda that captures variables from the enclosing scope owns its heap environment across the thread boundary and frees it exactly once after the task body completes. The mechanics:

- The captured env is allocated with `sfn_env_alloc` (unconditional libc `calloc`, never arena-routed), so it is individually freeable after crossing the thread boundary.
- The spawn/parallel trampoline calls `sfn_env_free(ctx)` after the worker body returns (null-safe; non-capturing tasks are unaffected).
- The sender's binding is statically marked `Moved` at the spawn site; reusing it after `spawn`/`parallel` raises `E0901` (use-after-move).
- Synchronous (non-spawned) closures are unchanged — they keep the arena fast-path.

**Boundary.** This covers the env-container lifetime for value and pointer-identity captures. `OwnedBuf`/string capture-buffer ownership across the thread boundary (result-aliases, length-carrying buffers) is deferred to #1476.

### Effect transparency (SFEP-0049)

`spawn`, `parallel`, and channel `send`/`receive` are **effect-transparent**: the in-process primitive contributes no effect of its own, and the caller inherits exactly the effects of the body it spawns/sends. A concurrency op over a **pure** body requires no effect; over an effectful body (e.g. one that calls `print`), that body's effects (`io`, …) propagate. The requirement is derived from the target-neutral intrinsic registry (#1655); these concurrency targets have no semantic rows, so the checker treats the primitives themselves as pure.

This is principled, not conservative: the v0 scheduler primitives are pure in-process pthread mutex/condvar/MPMC-queue and touch no filesystem, network, console, or clock, so under the canonical taxonomy (`io, net, model, gpu, rand, clock`) none genuinely exercises `io` — as Go treats goroutine spawn as effect-free. The **join-side** counterpart (`await` and `routine {}` nursery-exit effect propagation) is out of scope here and tracked with the concurrency-maturity work (SFN-124).

### Typed task handles (`Task<T>`) and ordered multi-await (`join_all`)

`spawn fn() -> T { ... }` has type `Task<T>` — a nominal, single-use handle
type, so a dynamic collection of spawned tasks can now be typed and collected:

```sfn
// A dynamic fan-out/await-in-order shape, well-typed with Task<T>.
fn fetch_all(ids: int[]) -> int[] ![io] {
    let mut handles: Task<int>[] = [];
    for id in ids {
        handles.push(spawn fn() -> int ![io] { return fetch(id); });
    }
    return join_all(handles);   // input-ordered results
}
```

`join_all(handles: Task<T>[]) -> T[]` awaits every handle and returns results
in **input order**, regardless of the order in which the underlying tasks
actually complete — the tasks were already running concurrently from their
`spawn`; `join_all` only imposes a deterministic *result* ordering. Empty
input returns `[]` immediately; a singleton returns a one-element array.

`Task<T>` is a phantom-typed newtype over the existing future pointer — it
adds no new runtime representation and costs nothing at runtime. It stays
inside the same **pointer-width `T` ceiling** the rest of the concurrency
surface already lives under: `join_all` supports **int, number, string, ptr**
result kinds. `Task<void>` (a `void[]` result is meaningless) and `Task<bool>`
(would need a sub-word `i1` slot the pointer-width result buffer doesn't
model) are excluded from `join_all`. Pushing a handle of one kind into a
`Task<T>[]` of another kind (e.g. a `Task<string>` handle into a
`Task<int>[]`) is rejected at check with `E0836`.

`Task<T>` opens this **annotated** path additively — it does not weaken
`E0831`. An un-annotated `let mut hs = []` still fails closed with `E0831`
(its element slot has no type to bind a future pointer to); annotating the
array as `Task<int>[]` is now the documented remediation.

The ownership/lifetime side of `Task<T>` — rejecting a double-await
(use-after-move) and a handle escaping its `routine {}` nursery scope — is
enforced during checking. Direct `await`, movement into a task array, and
`join_all` consume their handles; indexed extraction consumes a task collection
as a whole. Declared local and imported Task-returning calls keep this identity
for inferred locals, with receiver-qualified method lookup and callable
shadowing. First-class Task-returning lambdas, moved function values, and
callable-typed parameters retain their declared Task result, while only bodies
whose Task returns are all proven fresh introduce nursery provenance.
Conservative joins retain possible consumption across mutually
exclusive branches, repeated loop iterations, and try/catch paths, so consuming
the same handle again raises `E0837`. A live nursery-origin handle
stored in an outer binding — including through a nested indexed or module-global
task collection, aggregate field, direct return, or locally proven fresh-Task
helper — must be awaited (or its collection passed to `join_all`) before the
`routine` ends, or checking raises `E0838`; assigning `[]` clears an outer task
collection and its nursery provenance. Ordinary closure capture and aggregate
construction move affine handles, and a closure that owns a Task capture is
itself affine and carries the captured handle's nursery provenance. Conditional
Task results preserve both identity and provenance, and declared struct-field
metadata—including generic field substitution—keeps empty-but-typed Task
collections, Task-bearing parameters/`self`, method receivers, and `for` targets
affine without treating sibling non-Task fields as handles. Provenance follows
explicit `spawn` and local helpers
whose every Task return is provably fresh; passing a nursery Task through an
opaque helper or method is rejected fail-closed unless the resolved operation is
the builtin `join_all` or a Task-collection push. A Task return annotation alone
does not make an ambient identity helper nursery-bound (SFN-446). Design record: SFEP-0055
(`docs/proposals/0055-typed-task-handles.md`).

**Remaining work**: full `async fn` return-value `await` wired into the live
typecheck walk, a generic `channel<T>(...)` constructor, `parallel`'s own raw
result handle staying untyped, cancellation,
async I/O, and the `OwnedBuf` capture-buffer ABI across the thread boundary
(#1476).
See the [roadmap](/roadmap).
