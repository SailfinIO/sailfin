---
title: Effect System Reference
description: Complete reference for Sailfin's capability-based effect system.
section: reference
order: 4
---

## Overview

The effect system is a compile-time capability mechanism. Every function declares what side effects it may perform via `![effect, ...]` annotations on its signature, and the compiler currently enforces these declarations based on direct usage of effectful operations (e.g., filesystem, printing, HTTP, `prompt` blocks). A function that directly performs any operation requiring effect `E` must declare `E`; failing to do so is a compile error, not a warning. Call-graph–transitive enforcement based on callee signatures is planned but not yet implemented. This makes direct side effects explicit, auditable, and verifiable without runtime overhead.

---

## Canonical Effects

| Effect | Token | Grants Access To | Enforced Today | Examples |
|--------|-------|-----------------|----------------|---------|
| IO | `io` | Filesystem, console output, logging, decorators like `@logExecution` | Yes | `print()`, `print.err()`, `fs.readFile()`, `fs.writeFile()`, `console.*` |
| Network | `net` | HTTP, WebSocket, serve | Yes | `http.get()`, `http.post()`, `websocket.*`, `serve` |
| Model | `model` | AI model invocation | Yes (for `prompt` blocks) | `prompt` blocks; `.call()` execution is planned |
| GPU | `gpu` | Tensor and accelerator operations | No (parsed only) | Tensor ops, `@gpu` blocks, GPU memory |
| Random | `rand` | Random number generation | No (parsed only) | `rand.*` |
| Clock | `clock` | Time operations | Partial | `sleep()`, `runtime.sleep()` |

The tokens `unsafe`, `read`, and `mut` are also recognized by the parser for FFI and ownership annotations but are not part of the capability-surface set enforced by the effect checker today.

---

## Syntax

Effect annotations appear after the parameter list and optional return type, before the function body.

```sfn
// No effects declared — guaranteed pure
fn pure_fn(x: number) -> number {
    return x * 2;
}

// Single effect
fn log_value(x: number) ![io] {
    print("{{x}}");
}

// Multiple effects
fn fetch_and_log(url: string) ![io, net] {
    let response = http.get(url);
    print(response.body);
}

// Full signature with return type and multiple effects
fn fetch_order(url: string) -> string ![io, net, model] {
    // ...
    return "";
}
```

Effect tokens are comma-separated within `![...]`. Order within the list is not significant.

---

## Enforcement Rules

1. A function that directly calls an operation requiring effect `E` must declare `E`.
2. Call-graph–transitive enforcement (where calling function `A` must declare every effect that callee `B` declares) is **planned** but not yet implemented. The current checker enforces direct-usage rules only.
3. Test blocks follow the same rules as functions — a test that performs IO must declare `![io]`.
4. Closures inherit the effect scope of their enclosing function; a closure defined inside an `![io]` function may call IO operations without redeclaring the effect.
5. Missing effects are a **compile error**, not a warning. The build will not proceed.
6. The compiler emits missing-effect diagnostics with textual hints describing how to update the function signature; automatic signature rewrite fix-its are planned tooling.

---

## API Surface Per Effect

### `io` effect

Required for all filesystem access, console output, structured logging, and IO-dependent decorators.

| API | Notes |
|-----|-------|
| `print(value)` | Write to stdout |
| `print.err(value)` | Write to stderr |
| `print.warn(value)` | Write warning to stderr |
| `fs.readFile(path)` | Read file contents |
| `fs.writeFile(path, content)` | Write file contents |
| `fs.appendFile(path, content)` | Append to a file |
| `fs.exists(path)` | Check file existence |
| `fs.writeLines(path, lines)` | Write an array of lines |
| `log.info()`, `log.warn()`, `log.error()`, `log.debug()` | Structured logging via `sfn/log` |
| `console.info()`, `console.log()`, `console.error()` | Legacy console aliases |
| `@logExecution` | Decorator that emits IO |

### `net` effect

Required for all outbound network calls, WebSocket connections, and binding to a port.

| API | Notes |
|-----|-------|
| `http.get(url)` | HTTP GET request |
| `http.post(url, body)` | HTTP POST request |
| `websocket.connect(url)` | Open a WebSocket connection |
| `websocket.send(conn, msg)` | Send a message on a connection |
| `websocket.recv(conn)` | Receive a message from a connection |
| `serve(handler)` | Bind and serve an HTTP handler |

### `model` effect

Required for any function containing a `prompt` block. Model execution via `.call()` is designed and specified but not yet active.

| API | Notes |
|-----|-------|
| `prompt` blocks | Any function that contains a `prompt { }` block must declare `![model]` |
| `model.call()` | Planned — parses today, does not execute |

```sfn
fn summarize(text: string) -> string ![model] {
    prompt user {
        "Summarize the following: {{text}}"
    }
}
```

### `clock` effect

Partially enforced. Time-based suspension is enforced today; wall-clock reads are planned.

| API | Notes |
|-----|-------|
| `sleep(ms)` | Suspend for `ms` milliseconds — enforced |
| `runtime.sleep(ms)` | Alias for `sleep` — enforced |
| Wall-clock access | Planned — not yet enforced |

### `gpu` effect (parsed, not yet enforced)

Declared in signatures and parsed by the compiler but not yet checked at call sites.

| API | Notes |
|-----|-------|
| Tensor operations | Element-wise ops, matmul, reductions |
| `@gpu` accelerator blocks | Blocks targeting GPU execution |
| GPU memory operations | Allocation and transfer |

### `rand` effect (parsed, not yet enforced)

Declared in signatures and parsed by the compiler but not yet checked at call sites.

| API | Notes |
|-----|-------|
| `rand.int()` | Random integer |
| `rand.float()` | Random float in `[0, 1)` |
| `rand.choice(list)` | Random element from a list |
| `rand.shuffle(list)` | Shuffle a list in place |

---

## Diagnostic Format

When a required effect is missing, the compiler emits an error with a textual hint:

```
error[effects.missing]: function `process` uses `![net]` operation but does not declare net
  --> src/main.sfn:12:5
   |
   = hint: add `net` to the effect list of `process`
```

Diagnostic fields:

| Field | Description |
|-------|-------------|
| Error code | `effects.missing` — missing effect declaration |
| Calling function | The function whose signature is incomplete |
| Effect required | The specific effect token that must be added |
| Source location | File and approximate location of the diagnostic |
| Hint | Textual description of the required signature change (automatic rewrite fix-its are planned) |

---

## Effect Minimization

Declare the narrowest set of effects possible. Functions that mix pure computation with effectful operations are harder to test and reason about. The recommended pattern is to push effects toward the boundary of the program (entry points, request handlers, CLI commands) and keep domain logic pure.

```sfn
// Preferred: pure logic separated from IO
fn compute_total(items: Item[]) -> number {
    return array_reduce(items, 0, fn(acc: number, i: Item) -> number {
        return acc + i.price;
    });
}

fn print_total(items: Item[]) ![io] {
    let total = compute_total(items);
    print("{{total}}");
}
```

Pure functions with no effect annotations:

- Are eligible for memoization and inlining by the optimizer.
- Can be called from any context, including tests, without capability grants.
- Signal clearly to readers that no side effects occur.

---

## Future: Hierarchical Effects

**This feature is planned and not yet active.**

In a future release, effects will compose hierarchically. The top-level tokens (`io`, `net`, etc.) will become namespaces for fine-grained sub-effects:

| Planned Sub-effect | Parent | Meaning |
|-------------------|--------|---------|
| `io.fs.read` | `io` | Read-only filesystem access |
| `io.fs.write` | `io` | Write filesystem access |
| `io.console` | `io` | Console and terminal output |
| `net.http` | `net` | HTTP client and server |
| `net.ws` | `net` | WebSocket |
| `model.infer` | `model` | Model inference |
| `model.embed` | `model` | Embedding generation |

Until hierarchical effects ship, all sub-effects collapse to their parent token. A function requiring `io.fs.read` today must declare `io`. The syntax `![io.fs.read]` is reserved for the future and will be rejected by the current compiler.

---

## Cross-References

- Tutorial: [The Effect System](/docs/learn/effects)
- Language Specification: [Language Specification §7](/docs/reference/spec)
- Capsule capability grants: [Capsules & Packages](/docs/advanced/capsules)
