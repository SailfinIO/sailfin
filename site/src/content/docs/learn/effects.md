---
title: The Effect System
description: Understanding Sailfin's capability-based effect system.
section: learn
order: 4
---

Sailfin's effect system is a compile-time capability mechanism. Functions declare what they're allowed to do, and the compiler enforces it.

## Canonical Effects

| Effect | Capability | Examples |
|--------|-----------|----------|
| `io` | Filesystem, console, logging | `print.*`, `fs.*`, `console.*` |
| `net` | Network access | `http.*`, `websocket.*`, `serve` |
| `model` | AI model invocation | `prompt` blocks, model `.call()` |
| `gpu` | GPU/accelerator access | Tensor operations, `@gpu` blocks |
| `rand` | Random number generation | `rand.*` |
| `clock` | Time operations | `sleep`, `runtime.sleep` |

## Declaring Effects

Effects are declared with the `![]` syntax after the parameter list:

```sfn
fn read_file(path: String) -> String ![io] {
    return fs.read(path);
}

fn fetch(url: String) -> Response ![net] {
    return http.get(url);
}

fn analyze(text: String) -> Analysis ![io, model] {
    let result = prompt gpt4o ![model] {
        system "Analyze the following text."
        user "{{text}}"
    };
    print.info("Analysis complete");
    return result;
}
```

## Pure Functions

Functions without effect annotations are pure — they can't perform IO, network calls, or any side effects:

```sfn
fn add(a: Int, b: Int) -> Int {
    return a + b;  // Pure computation — no effects needed
}
```

## Transitive Enforcement

If function `A` calls function `B`, then `A` must declare at least the effects that `B` declares:

```sfn
fn helper() ![io, net] {
    let data = http.get("https://api.example.com");
    print.info("Fetched data");
}

// ERROR: missing ![net] — helper() requires it
fn bad_caller() ![io] {
    helper();
}

// OK: declares both effects
fn good_caller() ![io, net] {
    helper();
}
```

## Effects in Tests

Tests also declare effects:

```sfn
test "reads config file" ![io] {
    let config = read_file("test.toml");
    assert config.length > 0;
}
```

## Diagnostics

The compiler produces detailed diagnostics when effects are violated, including source spans and suggested fixes:

```
error[E0301]: function `process` calls `fetch` which requires ![net],
              but `process` only declares ![io]
  --> src/main.sfn:12:5
   |
12 |     let data = fetch(url);
   |                ^^^^^ requires ![net]
   |
   = help: add `net` to the effect list: `fn process(url: String) ![io, net]`
```

## Next Steps

- [Ownership & Borrowing](/docs/learn/ownership) — Memory safety model
- [Effect System Reference](/docs/reference/effects) — Complete specification
