---
title: Concurrency
description: Structured concurrency in Sailfin — async functions today, routines and channels coming in 1.0.
section: learn
order: 7
---

Sailfin is designed for structured, effect-safe concurrency. The design goal is to make it impossible to accidentally share mutable state across concurrent tasks, and to ensure that concurrent code carries the same capability annotations as any other code.

> **Current status:** The `async fn` declaration syntax is parsed and recorded by the compiler today. `routine { }` blocks and `await` are not yet parsed. `channel()` and `spawn()` are exposed as prelude functions but are stubs in the native runtime — they parse, but do not yet execute. All of these are being implemented as part of the 1.0 work. This page covers what works today and what the planned syntax looks like.

---

## `async fn` — Available Today

The `async` keyword on function declarations is parsed and recorded by the compiler. You can declare async functions today:

```sfn
async fn fetch_data(url: string) -> string ![net] {
    // await is not yet implemented — call synchronously for now
    return http.get(url);
}

async fn read_config(path: string) -> string ![io] {
    return fs.read(path);
}
```

The `async` flag is recorded in the function's AST node and emitted into the `.sfn-asm` IR. However, `await` is not yet parsed. If you write `await expr`, the compiler will produce a parse error. For now, call async-style functions synchronously — the `async` annotation is future-compatible with the 1.0 runtime scheduler.

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

## Planned: `routine { }` Blocks

> **Planned for 1.0.** The `routine` keyword is not yet parsed by the current compiler.

Routines are Sailfin's lightweight concurrent tasks. A `routine { }` block spawns a task that runs concurrently with the enclosing function. Routines are _structured_: the parent scope waits for all child routines to complete before continuing past the enclosing `scope { }` block.

```sfn
// PLANNED — not yet available
fn main() ![io, clock] {
    routine {
        print("Running in background");
        sleep(500);
        print("Background done");
    }

    print("Main continues while routine runs");
}
```

Routines are mapped to the runtime's lightweight scheduler — they are not OS threads. The scheduler is cooperative and effect-aware.

### Routines inherit parent effects

A `routine { }` block inherits the declared effects of its enclosing function. You cannot use an effect inside a routine that the parent function has not declared:

```sfn
// PLANNED — not yet available
fn process_batch(items: Vec<Item>) ![io] {
    for item in items {
        routine {
            // io is available because the parent declared ![io]
            print("Processing: " + item.id);
            save(item);
        }
    }
}
```

---

## Planned: `scope { }` — Structured Scopes

> **Planned for 1.0.** `scope { }` blocks are not yet parsed.

A `scope { }` block is a structured concurrency boundary. All routines spawned inside a scope are guaranteed to complete before execution continues past the closing brace. This eliminates the class of bugs where background work outlives its context.

```sfn
// PLANNED — not yet available
fn process_batch(items: Vec<Item>) ![io] {
    scope {
        for item in items {
            routine {
                process(item);
            }
        }
    }
    // All routines are complete here — safe to read results
    print("Batch complete");
}
```

The structured scope guarantee is enforced by the runtime, not just by convention. Routines cannot escape their enclosing scope.

### Scopes with timeout

For operations that must complete within a time bound:

```sfn
// PLANNED — not yet available
fn fetch_with_deadline(urls: Array<string>) ![net, clock] {
    scope.with_timeout(5000) {
        for url in urls {
            routine {
                let resp = http.get(url);
                store(resp);
            }
        }
    }
    // If the timeout fires, remaining routines are cancelled
}
```

---

## Planned: Channels

> **Planned for 1.0.** `channel()` and channel operations are not yet parsed.

Channels are typed message-passing primitives for communication between routines. They are the primary way routines share data — rather than sharing mutable memory, routines communicate by sending values through channels.

### Declaring a channel

```sfn
// PLANNED — not yet available
let ch = channel(capacity: 16);  // bounded channel, capacity 16 messages
let unbounded = channel();       // unbounded channel
```

### Sending and receiving

```sfn
// PLANNED — not yet available
fn main() ![io] {
    let ch = channel(capacity: 4);

    routine {
        ch.send("hello from routine");
        ch.send("second message");
    }

    let first = ch.recv();
    let second = ch.recv();
    print("Got: " + first);
    print("Got: " + second);
}
```

### Typed channels

Channels are typed. The type is inferred from the first sent value or can be declared explicitly:

```sfn
// PLANNED — not yet available
let results: Channel<number> = channel(capacity: 8);

routine {
    results.send(compute_heavy_thing());
}

let value = results.recv();
```

### Channels and effects

Channels do not carry effect permissions on their own. The routine that _calls_ `ch.send()` or `ch.recv()` must have the appropriate effects declared on its enclosing function:

```sfn
// PLANNED — not yet available
fn pipeline_worker(input: Channel<String>, output: Channel<String>) ![io] {
    let msg = input.recv();
    let processed = transform(msg);
    print("Processed: " + processed);
    output.send(processed);
}
```

---

## Planned: `await`

> **Planned for 1.0.** `await` is not yet parsed by the current compiler.

Once `await` is implemented, async functions will be able to suspend execution and resume when a result is ready:

```sfn
// PLANNED — not yet available
async fn fetch_and_parse(url: string) -> Document ![net] {
    let body = await http.get(url);
    return parse_html(body);
}
```

`await` will be valid only inside `async fn` declarations. Using `await` in a non-async function will be a compile error.

Async functions can be called from synchronous contexts using a scope block:

```sfn
// PLANNED — not yet available
fn main() ![net, io] {
    scope {
        routine {
            let doc = await fetch_and_parse("https://example.com");
            print("Title: " + doc.title);
        }
    }
}
```

---

## Effect Safety in Concurrent Code

Effect enforcement is part of the concurrency design from the start. The effect system prevents several classes of concurrency bugs at compile time:

**Capability containment:** A routine cannot use a network API unless the enclosing function declared `![net]`. This means the full capability surface of a concurrent task is visible in the function signature.

**No hidden IO in routines:** A background routine cannot silently write to disk or open a socket if the parent didn't declare those capabilities.

```sfn
// PLANNED — illustrates how effect checking will work with routines
fn handle_request(req: Request) ![net] {
    routine {
        let resp = http.get(req.url);   // OK: net is declared
        // fs.write("log.txt", resp);   // ERROR: io not declared
    }
}
```

Effects do not change the semantics of data sharing — channels are still the right tool for passing values between routines. But the effect system ensures that the _side effects_ of concurrent code are always accounted for in the enclosing function's signature.

---

## Working Today: Sequential Patterns

Since `routine`, `channel`, and `await` are not yet available, here are practical patterns that work in the current compiler for structuring concurrent-style workloads sequentially.

### Sequential computation with `for`

```sfn
fn process_all(items: Vec<Item>) ![io] {
    for item in items {
        let result = process(item);
        print("Done: " + item.id);
        save(result);
    }
}
```

### Functional patterns with `map`

The prelude provides `map`, `filter`, and `reduce` for collection transformations:

```sfn
fn score_all(texts: Array<string>) -> Array<number> {
    return texts.map(fn(t: string) -> number {
        return score(t);
    });
}
```

### Pipeline via function composition

Without the `|>` operator (planned for 1.0), chain operations with intermediate bindings:

```sfn
fn index_corpus(docs: Array<string>) ![io] {
    let chunks   = chunk(docs);
    let embedded = embed(chunks);
    let filtered = embedded.filter(fn(v: Vec) -> boolean { return v.norm > 0.1; });
    upsert(filtered, "docs_idx");
}
```

### Batched processing

For workloads that logically want parallelism, process in batches and collect results:

```sfn
fn run_batch(jobs: Array<Job>) -> Array<Result> ![io] {
    let mut results: Array<Result> = [];
    for job in jobs {
        let r = run_job(job);
        results = results.append(r);
    }
    return results;
}
```

These patterns will compose naturally with `routine { }` and `channel()` once those are available — the surrounding function signatures and effect annotations won't need to change.

---

## Roadmap

Concurrency primitives (`routine`, `channel`, `await`, structured scopes) are part of the 1.0 release milestone. The `async fn` declaration syntax is already in place. The runtime scheduler and channel implementation are being built on top of the stable self-hosted LLVM backend.

See [`docs/roadmap.md`](/docs/roadmap) for the current timeline and sequencing.

---

## Next Steps

- [AI Constructs](/docs/learn/ai-constructs) — Models, prompts, pipelines, and tools
- [Testing](/docs/learn/testing) — Testing your Sailfin code
- [The Effect System](/docs/learn/effects) — How effects govern what code is allowed to do
