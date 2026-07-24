---
title: "§7 Effect System"
description: "Sailfin language specification — Effect System."
sidebar:
  order: 7
  label: "§7 Effect System"
---

Every function must declare the effects recognized directly in its body and inherited through statically resolved callees with `![...]`:

```sfn
fn pure(x: int) -> int { return x * 2; } // no recognized effects
fn read_file(path: string) ![io] { ... }       // requires io capability
fn fetch(url: string) ![net] { ... }           // requires net capability
fn analyze(text: string) ![io, model] { }      // multiple effects
```

**Canonical effects**:

| Effect | Token | Grants | Enforced Today |
|--------|-------|--------|----------------|
| IO | `io` | Filesystem, console, logging (sub-effects `io.fs`, `io.console` — see below) | Yes |
| Network | `net` | HTTP, WebSocket, serve (sub-effects `net.http`, `net.ws` — see below) | Yes |
| Clock | `clock` | `sleep`, wall-clock | Yes |
| Model | `model` | AI library invocation via `sfn/ai` (post-1.0) | Reserved (no detector yet) |
| GPU | `gpu` | Tensor operations | Reserved (no detector yet) |
| Random | `rand` | Random generation | Reserved (no detector yet) |

**Enforcement rules**:
1. Any function calling an effectful operation directly must declare that effect — violations produce diagnostics with fix-it hints and are errors by default
2. Enforcement runs on every build path (`make compile`, `sfn build`, `sfn run`, `sfn test`, `sfn check`); the `SAILFIN_EFFECT_ENFORCE` env var lets capsule authors opt into `=warning` (telemetry-only) or `=off` (build-path bypass; `sfn check` still validates)
3. Tests follow the same rules as functions
4. **Cross-module call-graph propagation** (Phase E, shipped): if A imports B and calls it, A must declare every effect B declares. Diagnostic code `E0402`. Aliased imports (`import { foo as bar }`) resolve under the local name. `Member`-callee resolution (`mod.fn()`) is a Phase E2 follow-up
5. **Capsule capability cross-check** (Phase F, shipped): every function's declared effects must be a subset of the capsule manifest's `[capabilities] required = [...]` surface. Diagnostic code `E0403`. Empty surface (no `[capabilities]` section, or standalone .sfn outside any capsule) skips the cross-check so pre-Phase-F projects keep building

**Sub-effect refinements** (SFEP-0017, shipped): sub-effects are dotted-name
refinements *within* the locked six roots — `io.fs ⊑ io` — never a seventh
canonical effect. The runtime-helper registry detects four families: `fs.*`
calls require `io.fs`, `print.*`/`console.*` calls require `io.console`,
`http.*` calls require `net.http`, and `websocket.*` calls require `net.ws`
(the `io`/`net` rows in the table above cover these sub-effects). A bare-root
grant (`![io]`, `![net]`) subsumes every requirement under that root, so
existing annotations are unaffected. A narrow grant is also sufficient on its
own: `![io.fs]` satisfies a detected `fs.*` call but not a sibling `console.*`
call (missing-effect diagnostic). At the capsule boundary, `[capabilities]
required = ["io.fs"]` tightens a capsule to filesystem-only and rejects a
sibling `![io.console]` function with `E0403`; `required = ["io"]` continues to
authorize every `io.*` sub-effect.

See [Effect System Reference](/docs/reference/effects) for the complete API surface per effect.

## 7.1 Guarantee boundary

An absent effect annotation proves only that the 0.8 checker found no registered direct operation or effect inherited through a resolved call. Unresolved or dynamic callees yield no guessed effect, and FFI/native code is not confined by the emitted binary. Capsule and workspace checks are compile-time declaration contracts; the runtime syscall seal is a 1.0 target.
