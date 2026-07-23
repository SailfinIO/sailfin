---
title: Effect System Reference
description: Complete reference for Sailfin's capability-based effect system.
section: reference
sidebar:
  order: 4
---

## Overview

The 0.8 effect system is a compile-time capability mechanism. It checks direct use of registered effectful operations and propagates declared effects through statically resolved callees, including imported free functions and aliased imports. Missing declarations are compile errors by default. Unresolved or dynamic callees yield no guessed effect, and the emitted binary is not yet confined by a runtime syscall seal.

---

## Canonical Effects

| Effect | Token | Grants Access To | Enforced Today | Examples |
|--------|-------|-----------------|----------------|---------|
| IO | `io` | Filesystem, console output, logging, decorators like `@logExecution` | Yes | `print()`, `print.err()`, `fs.readFile()`, `fs.writeFile()`, `console.*` |
| Network | `net` | HTTP, WebSocket, serve | Yes | `http.get()`, `http.post()`, `websocket.*`, `serve` |
| Model | `model` | Future AI library invocation (`sfn/ai`, post-1.0) | Reserved | Declarable and propagated from signatures; no shipped detector/runtime API |
| GPU | `gpu` | Future accelerator operations | Parsed/reserved | No effect-gated GPU runtime API or detector |
| Random | `rand` | OS entropy | Enforced at the shipped entropy boundary | `sfn/crypto::random_bytes`; no general RNG-name detector |
| Clock | `clock` | Sleep and registered clock operations | Yes for registered operations | `sleep()`, `runtime.sleep()`, clock helpers |

The tokens `unsafe`, `read`, and `mut` are also recognized by the parser for FFI and ownership annotations but are not part of the capability-surface set enforced by the effect checker today.

---

## Syntax

Effect annotations appear after the parameter list and optional return type, before the function body.

```sfn
// No recognized effects declared
fn pure_fn(x: int) -> int {
    return x * 2;
}

// Single effect
fn log_value(x: int) ![io] {
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

1. A direct call to an operation registered with requirement `E` must be covered by the enclosing function's declared grants (`E0400`).
2. A call to a statically resolved function inherits that function's declared effects. Imported free functions, aliases, statically resolved member callees, and imported decorator effects are covered (`E0402`); unresolved or dynamic callees yield no guessed effect.
3. Tests follow the same effect rules as functions.
4. Immediately used closures are checked in their enclosing effect scope; general effect polymorphism is not shipped.
5. A function's declared effects must fit a non-empty capsule `[capabilities] required` surface (`E0403`). An absent or empty surface skips this compatibility cross-check rather than acting as deny-all.
6. Workspace capability envelopes enforce member manifests' **declared** surfaces. Inferring and auditing the complete source effect surface at workspace level is still planned.
7. Missing effects are errors by default and carry source spans and structured fix suggestions. `SAILFIN_EFFECT_ENFORCE=warning|off` is a transitional build-path escape hatch; `sfn check` still validates.

These rules prove only what the 0.8 compiler recognizes and resolves. They do not confine FFI/native code at runtime. A syscall-gating capability seal is a 1.0 target.

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
| `websocket.connect(url)` | Open a `ws://` client connection (#1876) |
| `websocket.send(handle, msg)` | Send a masked TEXT frame on a connection (#1876); also requires `io` — see note below |
| `websocket.close(handle)` | Send a CLOSE frame and close the connection (#1876) |
| `websocket.serve(port)` | Bind/listen/accept a v0 single-connection `ws://` echo server (#1877) |
| `serve(handler)` | Bind and serve an HTTP handler |

Client-side message *receive* (`websocket.recv`) is not yet implemented — a
follow-up under epic #1180 (see `docs/status.md`).

`websocket.send(handle, msg)` needs `![io, net]`, not `![net]` alone: any
`.send(...)` member call, regardless of receiver, trips the effect checker's
conservative receiver-agnostic channel-op rule (shared with `channel.send`),
which adds `io` on top of the registry's `net` requirement for
`websocket.send` itself.

### `model` effect

Reserved for library functions such as those planned for the post-1.0 `sfn/ai`
capsule. A declared `![model]` effect propagates through resolved calls like any
other declared effect, but 0.8 has no shipped model detector or runtime API. The `model`, `prompt`, `tool`, and `pipeline` block
keywords have been removed from the language; the `![model]` effect remains
as the capability gate.

| API | Notes |
|-----|-------|
| Library functions carrying `![model]` | Any function that calls into AI library code must declare `![model]` |
| `sfn/ai` capsule | Post-1.0 library providing model invocation, tool dispatch, and provider adapters |

```sfn
// A library function that carries ![model] in its signature
fn ai_call(model_name: string, input: string) -> string ![model] {
    // implemented in sfn/ai capsule (post-1.0)
    return "";
}

// Any caller must also declare ![model]
fn summarize(text: string) -> string ![model] {
    return ai_call("summarizer", text);
}
```

### `clock` effect

Registered sleep and clock operations are enforced today.

| API | Notes |
|-----|-------|
| `sleep(ms)` | Suspend for `ms` milliseconds — enforced |
| `runtime.sleep(ms)` | Alias for `sleep` — enforced |
| Registered clock helpers | Enforced; consult the standard-library reference for the shipped API |

### `gpu` effect (parsed, not yet enforced)

Declared in signatures and parsed by the compiler but not yet checked at call sites.

| API | Notes |
|-----|-------|
| Tensor operations | Element-wise ops, matmul, reductions |
| `@gpu` accelerator blocks | Blocks targeting GPU execution |
| GPU memory operations | Allocation and transfer |

### `rand` effect

The shipped entropy boundary is enforced; arbitrary RNG-like call names are not auto-detected.

| API | Notes |
|-----|-------|
| `sfn/crypto::random_bytes(n)` | Shipped OS-entropy API; carries and propagates `![rand]` |
| General `rand.*` helpers | No shipped general-purpose runtime surface or name detector |

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
fn compute_total(items: Item[]) -> float {
    return array_reduce(items, 0.0, fn(acc: float, i: Item) -> float {
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

## Dotted Sub-effects

Four refinements ship in 0.8:

| Sub-effect | Parent | Detected operations |
|------------|--------|---------------------|
| `io.fs` | `io` | `fs.*` |
| `io.console` | `io` | `print.*`, `console.*` |
| `net.http` | `net` | `http.*` |
| `net.ws` | `net` | `websocket.*` |

A parent grant subsumes its children: `![io]` satisfies an `io.fs` requirement. A narrow grant such as `![io.fs]` does not satisfy sibling `io.console`. Capsule manifests apply the same rule, so `required = ["io.fs"]` is a real compile-time tightening, while `required = ["io"]` permits both shipped `io` refinements.

Deeper refinements such as `io.fs.read` and additional detected families remain preview work. Unrecognized roots are rejected; dotted refinements never increase the locked count of six canonical root effects.

---

## Cross-References

- Tutorial: [The Effect System](/docs/learn/effects)
- Language Specification: [§7 Effect System](/docs/reference/spec/07-effects/)
- Capsule capability grants: [Capsules & Packages](/docs/advanced/capsules)
