---
title: Effect System Reference
description: Complete reference for Sailfin's capability-based effect system.
section: reference
order: 4
---

## Overview

The effect system is Sailfin's compile-time capability mechanism. Every function declares what side effects it may perform, and the compiler enforces these declarations transitively across the call graph.

## Canonical Effects

| Effect | Token | Grants Access To |
|--------|-------|-----------------|
| IO | `io` | `print.*`, `console.*`, `fs.*`, decorators like `@logExecution` |
| Network | `net` | `http.*`, `websocket.*`, `serve` |
| Model | `model` | `prompt` blocks, model `.call()` invocations |
| GPU | `gpu` | Tensor operations, `@gpu` accelerator blocks |
| Random | `rand` | `rand.*` random number generation |
| Clock | `clock` | `sleep`, `runtime.sleep`, wall-clock access |

## Syntax

Effects are declared with the `![]` syntax after the parameter list:

```sfn
fn pure_function(x: Int) -> Int { ... }           // No effects
fn io_function() ![io] { ... }                      // IO only
fn multi_effect() ![io, net, model] { ... }         // Multiple effects
```

## Enforcement Rules

1. **Declaration required**: Any function calling an effectful operation must declare the effect
2. **Transitive**: If `A` calls `B`, `A` must declare at least `B`'s effects
3. **Tests included**: Test blocks must declare effects for effectful calls
4. **Lambdas**: Closures inherit the effect scope of their enclosing function
5. **Routines**: `routine` blocks inherit the declared effects of their parent scope

## Compiler Diagnostics

The effect checker (`compiler/src/effect_checker.sfn`) walks nested blocks, lambdas, and routine scopes. Missing effects produce diagnostics with:

- Source spans pointing to the offending call
- The effect(s) that are missing
- A fix-it hint suggesting the corrected signature

## Future: Hierarchical Effects

The design preview (spec Part B) describes a hierarchical effect system where effects can be composed and aliased. This is not yet implemented.

---

*For the learning-oriented guide, see [The Effect System](/docs/learn/effects).*
