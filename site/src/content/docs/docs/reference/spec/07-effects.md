---
title: "§7 Effect System"
description: "Sailfin language specification — Effect System."
sidebar:
  order: 7
  label: "§7 Effect System"
---

Every function that performs side effects must declare them with `![...]`:

```sfn
fn pure(x: number) -> number { return x * 2; } // no effects — guaranteed pure
fn read_file(path: string) ![io] { ... }       // requires io capability
fn fetch(url: string) ![net] { ... }           // requires net capability
fn analyze(text: string) ![io, model] { }      // multiple effects
```

**Canonical effects**:

| Effect | Token | Grants | Enforced Today |
|--------|-------|--------|----------------|
| IO | `io` | Filesystem, console, logging | Yes |
| Network | `net` | HTTP, WebSocket, serve | Yes |
| Clock | `clock` | `sleep`, wall-clock | Yes |
| Model | `model` | AI library invocation via `sfn/ai` (post-1.0) | Reserved (no detector yet) |
| GPU | `gpu` | Tensor operations | Reserved (no detector yet) |
| Random | `rand` | Random generation | Reserved (no detector yet) |

**Enforcement rules**:
1. Any function calling an effectful operation directly must declare that effect — violations produce diagnostics with fix-it hints and are errors by default
2. Enforcement runs on every build path (`make compile`, `sfn build`, `sfn run`, `sfn test`, `sfn check`); the `SAILFIN_EFFECT_ENFORCE` env var lets capsule authors opt into `=warning` (telemetry-only) or `=off` (build-path bypass; `sfn check` still validates)
3. Tests follow the same rules as functions
4. Call-graph–transitive enforcement (A must declare B's effects when A calls B) is planned for Phase E and not yet implemented

See [Effect System Reference](/docs/reference/effects) for the complete API surface per effect.
