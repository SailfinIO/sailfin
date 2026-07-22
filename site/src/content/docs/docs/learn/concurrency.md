---
title: Concurrency
description: Structured concurrency in Sailfin — shipped v0 nurseries, spawn / await, channels, and parallel fan-out.
section: learn
sidebar:
  order: 7
---

Sailfin ships a v0 structured-concurrency runtime. `routine { }` nurseries,
`spawn fn() -> T { ... }`, `await` on spawned tasks, bounded channels, and
`parallel [ ... ]` execute end-to-end on the runtime scheduler.

The v0 surface is intentionally narrower than the full design. Cancellation,
async I/O, typed result-array collection, arbitrary-width channel elements, and
`await` on an `async fn` return value remain incomplete. Use the constructs on
this page for code that runs today.

---

## `routine { }` — a structured nursery

A `routine { }` block creates a nursery. Work spawned inside it cannot outlive
the block: nursery exit waits until every child completes.

```sfn
fn main() ![io] {
    routine {
        let task = spawn fn () -> int { return 40 + 2; };
        let result: int = await task;
        print("Result: {{result}}");
    }
}
```

There is no separate `scope { }` construct. `routine { }` is the shipped
supervisor boundary. Non-local `return`, `throw`, `break`, or `continue` out of
a routine is rejected so that control cannot bypass the join.

The v0 nursery joins all children but does not yet provide cancel-on-fault,
timeouts, or cross-thread nursery inheritance.

### Effects remain visible

Concurrent work follows the ordinary effect rules. The enclosing function must
declare every capability used by a spawned task:

```sfn
fn write_in_background(path: string, body: string) ![io] {
    routine {
        spawn fn () -> int ![io] {
            fs.write(path, body);
            return 0;
        };
    }
}
```

Concurrency constructs themselves are effect-transparent. A pure task adds no
effect; an effectful task contributes the effects of its body.

---

## `spawn` and `await`

`spawn` schedules a zero-argument function on the shared runtime pool and
returns a future handle. `await` retrieves the completed value:

```sfn
fn calculate() ![io] {
    routine {
        let left = spawn fn () -> int { return 20; };
        let right = spawn fn () -> int { return 22; };
        let a: int = await left;
        let b: int = await right;
        print("Total: {{a + b}}");
    }
}
```

Spawned tasks may capture enclosing bindings. Capturing an owned value moves it
into the task; using that binding again in the sender is a compile-time error.

`async fn` is a separate, partial surface. The compiler records async
declarations, but calling an `async fn` does not yet produce a live future for
full suspension/resumption. Use `spawn fn() -> T { ... }` and `await` for
executable asynchronous work today.

---

## Channels

`channel(capacity)` creates a bounded MPMC channel. It is a language builtin;
the typed `sfn/sync` capsule wrapper and generic `channel<T>(...)` constructor
do not ship yet.

```sfn
fn main() ![io] {
    let messages = channel(2);

    routine {
        spawn fn () -> int {
            messages.send(20);
            messages.send(22);
            return 0;
        };

        let first: int = messages.receive();
        let second: int = messages.receive();
        print("Total: {{first + second}}");
    }
}
```

`send` blocks while the bounded buffer is full; `receive` blocks while it is
empty; `close` closes the channel. `await ch.receive()` is accepted as channel
receive sugar, but a synchronous `ch.receive()` is sufficient.

The v0 element ABI is pointer-sized. A bare `channel(N)` receive needs an
`int`- or `float`-annotated target so lowering knows the element width. A
`Channel<T>` binding annotation can enforce the element kind, but the generic
constructor is not available yet.

```sfn
fn receive_one(ch: Channel<int>) -> int {
    let value: int = ch.receive();
    return value;
}
```

---

## `parallel [ ... ]` — fan-out and join

`parallel` runs an array literal of zero-argument functions concurrently and
joins them before continuing:

```sfn
fn main() ![io] {
    let results = parallel [
        fn () -> int { return 20; },
        fn () -> int { return 22; },
    ];

    print("Parallel work complete");
}
```

The runtime fans tasks out across its shared pool. Capturing task closures ship
and their environment containers are reclaimed after the worker completes.
Typed indexing and collection of the returned result array remain incomplete;
use channels when the caller needs each task's value today.

---

## Current boundaries

| Surface | Current status |
|---|---|
| `routine { }` | Shipped v0 nursery; joins all children |
| `spawn fn() -> T` + `await` | Shipped for runtime future kinds |
| `channel(N)` | Shipped bounded MPMC channel; pointer-sized elements |
| `parallel [ ... ]` | Shipped fan-out/join; typed result collection pending |
| `async fn` return values | Parsed/recorded; live future typing and suspension pending |
| Cancellation, timeouts, async I/O | Planned post-v0 work |
| Pipeline operator `|>` | Planned post-1.0 |

See the [roadmap](/roadmap) for future sequencing and the
[standard-library concurrency reference](/docs/reference/standard-library/#concurrency-and-async-utilities)
for the lower-level API details.

---

## Next steps

- [The Effect System](/docs/learn/effects) — capability tracking in task bodies
- [Ownership & Borrowing](/docs/learn/ownership) — moves into spawned tasks
- [Standard Library](/docs/reference/standard-library/) — runtime utilities and current limits
