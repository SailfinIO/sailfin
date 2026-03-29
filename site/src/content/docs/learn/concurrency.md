---
title: Concurrency
description: Routines, channels, async/await, and parallel execution in Sailfin.
section: learn
order: 7
---

## Routines

Sailfin's lightweight concurrency primitive:

```sfn
fn main() ![io, clock] {
    routine {
        print.info("Running in background");
        sleep(1000);
        print.info("Done");
    }

    print.info("Main continues");
}
```

## Channels

Typed channels for communication between routines:

```sfn
fn main() ![io] {
    let ch = Channel<String>.new();

    routine {
        ch.send("hello from routine");
    }

    let msg = ch.recv();
    print.info("Got: {{msg}}");
}
```

## Async / Await

For IO-bound operations:

```sfn
async fn fetch_data(url: String) -> Response ![net] {
    return await http.get(url);
}
```

## Scoped Concurrency

```sfn
fn process_batch(items: Array<Item>) ![io] {
    scope {
        for item in items {
            routine {
                process(item);
            }
        }
    }
    // All routines complete before scope exits
    print.info("Batch complete");
}
```

## Next Steps

- [AI Constructs](/docs/learn/ai-constructs) — Models, prompts, and pipelines
- [Testing](/docs/learn/testing) — Testing concurrent code
