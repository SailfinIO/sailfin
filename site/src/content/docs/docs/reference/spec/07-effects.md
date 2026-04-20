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
| Model | `model` | AI library invocation via `sfn/ai` (post-1.0) | No (planned) |
| Clock | `clock` | `sleep`, wall-clock | Partial |
| GPU | `gpu` | Tensor operations | Parsed only |
| Random | `rand` | Random generation | Parsed only |

**Enforcement rules**:
1. Any function calling an effectful operation directly must declare that effect
2. Call-graph–transitive enforcement (A must declare B's effects when A calls B) is planned but not yet implemented
3. Tests follow the same rules as functions
4. Missing effects are compile errors with fix-it hints

See [Effect System Reference](/docs/reference/effects) for the complete API surface per effect.
