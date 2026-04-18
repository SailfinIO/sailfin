---
title: Concurrency
description: Structured concurrency in Sailfin — async functions, routines, channels, and parallel fan-out. Syntax is stable today; the runtime scheduler lands with 1.0.
section: learn
order: 7
---

Sailfin is designed for structured, effect-safe concurrency. The design goal is to make it impossible to accidentally share mutable state across concurrent tasks, and to ensure that concurrent code carries the same capability annotations as any other code.

> **Current status:** `async fn`, `routine { }` blocks, `await`, and the `parallel [ ... ]` form are parsed by the compiler today, and channels (`Channel<T>` / `channel()` / `.send` / `.receive`) are available through the `sync` import. The underlying runtime scheduler is still being built — these constructs parse and type-check, but executable concurrency lands with the 1.0 runtime. This page shows the canonical syntax (matching `/examples/concurrency/*`) and flags anything that is not yet runnable end-to-end.

---

## `async fn` — Parsed Today

The `async` keyword on function declarations is parsed and recorded by the compiler. You can declare async functions today:

```sfn
async fn fetch_data(url: string) -> string ![net] {
    return http.get(url);
}

async fn read_config(path: string) -> string ![io] {
    return fs.read(path);
}
```

The `async` flag is recorded in the function's AST node and emitted into the `.sfn-asm` IR. `await` is also parsed — see below — but full suspension/resumption lands with the 1.0 runtime scheduler.

### Effect annotations still apply

Async functions follow the same effect rules as synchronous ones:

```sfn
// async functions must declare their effects just like sync functions
async fn send_notification(msg: string) -> boolean ![net, io] {
    print("Sending: " + msg);
    return http.post("https://notify.example.com", msg);
}
```

---

## `routine { }` Blocks

Routines are Sailfin's lightweight concurrent tasks. A `routine { }` block spawns a task that runs concurrently with the enclosing function. Routines can be named for diagnostics:

```sfn
import { sleep } from "time";

fn main() ![io, clock] {
    routine "background" {
        print("Running in background");
        sleep(500);
        print("Background done");
    }

    routine {
        print("Another unnamed routine");
    }

    print("Main continues while routines run");
}
```

Routines are mapped to the runtime's lightweight scheduler — they are not OS threads. The scheduler is cooperative and effect-aware.

> **Coming in 1.0:** Execution of `routine` blocks is wired into the runtime as part of the 1.0 milestone. The syntax is stable and matches `examples/concurrency/routines.sfn`; see the [roadmap](/roadmap) for scheduler progress.

### Routines inherit parent effects

A `routine { }` block inherits the declared effects of its enclosing function. You cannot use an effect inside a routine that the parent function has not declared:

```sfn
fn process_batch(items: Item[]) ![io] {
    for item in items {
        routine {
            // io is available because the parent declared ![io]
            print("Processing: {{item.id}}");
            save(item);
        }
    }
}
```

---

> **Coming in 1.0:** A structured concurrency boundary (working title `scope { }`) is on the [roadmap](/roadmap). It will guarantee that every routine spawned inside the block completes before execution continues past the closing brace, together with cancellation and timeout primitives. Today, the parent function acts as the de facto scope and the runtime waits for pending routines when it lands.

---

## Channels

Channels are typed message-passing primitives for communication between routines. They are imported from the `sync` module. Use channels rather than sharing mutable memory between routines.

### Declaring a channel

```sfn
import { Channel, channel } from "sync";

let bounded: Channel<number> = channel(16);   // bounded channel, capacity 16
let unbounded: Channel<number> = channel();   // unbounded channel
```

### Sending and receiving

```sfn
import { Channel, channel } from "sync";

async fn main() ![io] {
    let messages: Channel<string> = channel(4);

    routine {
        messages.send("hello from routine");
        messages.send("second message");
    }

    let first: string = await messages.receive();
    let second: string = await messages.receive();
    print("Got: {{first}}");
    print("Got: {{second}}");
}
```

`messages.send(x)` queues a value; `await messages.receive()` suspends until one is available.

### Typed channels

Channels are typed via `Channel<T>`. Declare the type at the binding site:

```sfn
import { Channel, channel } from "sync";

async fn main() ![io] {
    let results: Channel<number> = channel(8);

    routine {
        results.send(compute_heavy_thing());
    }

    let value: number = await results.receive();
    print("Value: {{value}}");
}
```

### Channels and effects

Channels do not carry effect permissions on their own. The routine that calls `ch.send()` or `await ch.receive()` must have the appropriate effects declared on its enclosing function:

```sfn
import { Channel } from "sync";

async fn pipeline_worker(input: Channel<string>, output: Channel<string>) ![io] {
    let msg: string = await input.receive();
    let processed = transform(msg);
    print("Processed: {{processed}}");
    output.send(processed);
}
```

---

## `await`

Inside an `async fn`, use `await` to suspend until a result is ready:

```sfn
async fn fetch_and_parse(url: string) -> Document ![net] {
    let body = await http.get(url);
    return parse_html(body);
}
```

`await` is only valid inside `async fn` declarations. Using `await` in a non-async function is a compile error.

Launching async work from a synchronous `main` is done with `routine { }`:

```sfn
fn main() ![net, io] {
    routine {
        let doc = await fetch_and_parse("https://example.com");
        print("Title: {{doc.title}}");
    }
}
```

---

## `parallel [ ... ]` — Fan-out

The `parallel` form takes an array of closures and runs them concurrently, collecting their return values into an array:

```sfn
fn computeTask1() -> number {
    return 21;
}

fn computeTask2() -> number {
    return 21;
}

fn main() ![io] {
    let results = parallel [
        fn() -> number { return computeTask1(); },
        fn() -> number { return computeTask2(); },
    ];

    print("Results: {{results}}");
}
```

The closures in the array must all return the same type.

---

## Effect Safety in Concurrent Code

Effect enforcement is part of the concurrency design from the start. The effect system prevents several classes of concurrency bugs at compile time:

**Capability containment:** A routine cannot use a network API unless the enclosing function declared `![net]`. This means the full capability surface of a concurrent task is visible in the function signature.

**No hidden IO in routines:** A background routine cannot silently write to disk or open a socket if the parent didn't declare those capabilities.

```sfn
fn handle_request(req: Request) ![net] {
    routine {
        let resp = http.get(req.url);   // OK: net is declared
        // fs.write("log.txt", resp);   // ERROR: io not declared
    }
}
```

Effects do not change the semantics of data sharing — channels are still the right tool for passing values between routines. But the effect system ensures that the _side effects_ of concurrent code are always accounted for in the enclosing function's signature.

---

## Sequential Patterns

Until the runtime scheduler lands, many workloads are best written sequentially. These patterns compose naturally with `routine` and channels — the surrounding function signatures and effect annotations won't need to change when you move to concurrent execution.

### Sequential computation with `for`

```sfn
fn process_all(items: Item[]) ![io] {
    for item in items {
        let result = process(item);
        print("Done: {{item.id}}");
        save(result);
    }
}
```

### Functional patterns with `map`

The prelude provides `map`, `filter`, and `reduce` for collection transformations:

```sfn
fn score_all(texts: string[]) -> number[] {
    return texts.map(fn(t: string) -> number {
        return score(t);
    });
}
```

### Pipeline via intermediate bindings

Without the `|>` operator (planned for 1.0), chain operations with intermediate bindings:

```sfn
fn index_corpus(docs: string[]) ![io] {
    let chunks   = chunk(docs);
    let embedded = embed(chunks);
    let filtered = embedded.filter(fn(v: Vector) -> boolean { return v.norm > 0.1; });
    upsert(filtered, "docs_idx");
}
```

### Batched processing

For workloads that logically want parallelism, process in batches and collect results:

```sfn
fn run_batch(jobs: Job[]) -> JobResult[] ![io] {
    let mut results: JobResult[] = [];
    for job in jobs {
        let r = run_job(job);
        results.push(r);
    }
    return results;
}
```

---

## Roadmap

Concurrency primitives (`async fn`, `routine`, `await`, `parallel`, channels) all parse today and match the examples under `examples/concurrency/`. The runtime scheduler that actually drives them — along with structured scopes, cancellation, and timeouts — is part of the 1.0 release milestone and is being built on top of the self-hosted LLVM backend.

See the [roadmap](/roadmap) for the current timeline and sequencing.

---

## Next Steps

- [AI Integration](/docs/learn/ai-constructs) — The `![model]` effect and the `sfn/ai` capsule
- [Testing](/docs/learn/testing) — Testing your Sailfin code
- [The Effect System](/docs/learn/effects) — How effects govern what code is allowed to do
