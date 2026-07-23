---
title: "The Capability Seal"
description: "Sailfin's 1.0 thesis: type-proven and runtime-enforced capabilities, at native speed, on a runtime Sailfin owns."
date: "2026-06-26T12:00:00"
author: "The Sailfin Team"
---

The hardest security problem in the agent era is not that models sometimes write
bad code. It is that we keep running generated code, third-party tools, plugins,
and dependencies with ambient authority.

A build script can read secrets. A test helper can open a socket. A transitive
package can spawn a process. An agent can generate a small utility that happens
to inherit the same filesystem and network authority as the developer running it.
Most platforms answer this with a boundary outside the language: a container, a
microVM, a policy service, or a WebAssembly runtime. Those boundaries matter, but
they usually arrive after the program has already lost the semantic information
that would explain what it intended to do.

Sailfin is taking a different path for 1.0: make authority part of the language,
then carry that authority all the way down to the runtime boundary.

That target is the **capability seal**: a native Sailfin binary whose declared
effects and capsule capabilities are not just checked by the compiler, but
enforced by the runtime Sailfin owns. The design is tracked in the internal
[capability-sealed runtime proposal](https://github.com/SailfinIO/sailfin/blob/main/docs/proposals/0016-capability-sealed-runtime.md)
and its market framing in the
[strategic decision brief](https://github.com/SailfinIO/sailfin/blob/main/docs/strategy/decision-brief.md).
It is now a hard 1.0 gate, not a post-1.0 aspiration.

It is also not shipped yet.

That distinction matters. Sailfin already has real compile-time capability
enforcement. The runtime seal is the 1.0 work that turns that static proof into
an end-to-end boundary.

## What ships today

Sailfin's effect system is live in the compiler. A function that performs I/O,
network access, or clock access must say so in its signature:

```sfn
fn fetch_index(url: string) -> string ![net, io] {
    // ...
}
```

Those effects are not comments. The compiler rejects undeclared effectful calls,
propagates effects across module boundaries, and cross-checks a capsule's code
against the capability surface declared in `capsule.toml`. This is useful today:
you can audit a capsule and see whether it reaches for `io`, `net`, or `clock`,
and the compiler rejects declarations that exceed a non-empty manifest surface.
An absent or empty surface skips that compatibility check; it is not a runtime
deny-all policy.

The compiler is self-hosted. The runtime source is now Sailfin, with externs used
to call into platform facilities such as libc while the project finishes the
owned syscall layer. The produced binaries are native, not VM bytecode.

The honest current limit is equally important: after compilation, the effect and
capability proof is not yet a runtime cage. Sailfin still lowers through LLVM and
links through the platform toolchain. A manifest violation is caught by the
compiler, but the emitted binary does not yet carry a sealed capability context
that gates every syscall.

That is the gap 1.0 closes.

## The three pillars meet at runtime

Sailfin's language bet has three pillars:

- **Effects** say what a function may do.
- **Capabilities** say how much authority a capsule or task receives.
- **Concurrency** says for how long that authority exists, and who inherits it.

Individually, each pillar is useful. Together, they become a runtime security
model.

The capability seal makes effects the static policy, capabilities the executable
manifest, and structured concurrency the lifetime boundary. A task spawned inside
a nursery should be able to inherit a subset of its parent's authority, run with
that authority while the scope is alive, and lose it when the scope ends. That is
the shape Sailfin is aiming for: scoped, inherited, revocable capabilities per
task.

In the common case, the compiler proves a call graph stays within its declared
surface, so no dynamic gate is needed on every ordinary operation. At the
boundaries static analysis cannot see through, such as FFI, linked native code,
plugins, and generated code, the owned runtime becomes the backstop. If code
tries to open a file, connect to the network, or spawn a process outside the live
grant, the runtime refuses.

The manifest stops being advice. It becomes the boundary.

## Why existing approaches leave a lane open

WASI is the closest spiritual neighbor. The
[WebAssembly System Interface](https://wasi.dev/) is explicitly designed as a
secure standard interface for programs compiled to Wasm, and the WASI ecosystem
uses capability-oriented host APIs to control what a module can access. That is
valuable, especially for portable sandboxed execution. Its boundary, however, is
the Wasm host boundary. Sailfin's target is different: native binaries with
language-level effects and capabilities preserved into the runtime that executes
them.

Static capability analysis points in another useful direction. Google's
[Capslock](https://security.googleblog.com/2023/09/capslock-what-is-your-code-really.html)
for Go analyzes packages and reports privileged operations available through a
package and its dependencies. That is the right question to ask of a dependency:
what is this code capable of? But it is an analysis tool over an existing
language and runtime, not a language contract enforced by the executing binary.

Effect languages such as [Koka](https://koka-lang.github.io/),
[Flix](https://doc.flix.dev/effect-system.html), and
[Effekt](https://effekt-lang.org/) show how powerful type-and-effect systems can
be. They make effects visible to the type checker and give programmers a more
precise way to reason about purity and control flow. Sailfin borrows that
discipline, but aims it at production native systems code and pairs it with a
runtime seal. Static rigor alone is not enough when authority can leak through
FFI, dynamic loading, generated code, or the final system-call path.

The AI guardrail market is converging from the opposite direction. Tools such as
[Open Policy Agent](https://openpolicyagent.org/docs) and
[Cerbos](https://www.cerbos.dev/faq) externalize authorization decisions into
policy engines. Agent infrastructure such as
[E2B](https://e2b.dev/docs) gives AI-generated code isolated sandboxes, and
[Firecracker](https://firecracker-microvm.github.io/) provides fast microVMs for
secure multi-tenant workloads. These are runtime enforcement stories. They are
valuable, but they are not language-level proofs carried into the native
runtime.

The open lane is the combination: type-proven and runtime-enforced capabilities,
at native speed, on a runtime the language owns.

## Why owning the stack is part of the feature

You cannot seal a binary you do not own.

Today Sailfin still depends on LLVM/clang for the last mile. The 1.0 path does
not require beating LLVM's optimizer. It requires a **seal-sufficient backend**:
one that is correct, preserves effect and capability metadata, and emits code
that routes effectful operations through Sailfin's owned enforcement layer.

That distinction matters for scheduling. A performance-parity native backend is
a long tail and remains post-1.0 work. The 1.0 gate is narrower: own enough of
the backend and syscall layer to make the capability seal true. The existing
LLVM path remains a correctness oracle while that backend matures.

The runtime side has the same shape. Sailfin source now owns the runtime logic,
but platform effects still reach the operating system through externs. To seal a
binary, Sailfin needs the syscall layer too: one enforcement chokepoint for file,
network, process, clock, and other effectful operations. Without that chokepoint,
the compiler can prove intent, but the running process can still escape through
the platform.

## What this will and will not claim

When the capability seal ships, the claim should be concrete:

```sfn
// A capsule that declares file access but no network access.
// If linked code tries to connect, the sealed runtime refuses.
```

That does not mean Sailfin will magically solve every security problem. A
capability seal is not a side-channel defense. It does not protect against a
compromised kernel. It does not make the runtime outside the trusted computing
base; the runtime becomes the trusted enforcement component. It also requires
link-time discipline so malicious native objects cannot bypass the gated syscall
path with raw system instructions.

Those constraints are not fine print. They are the difference between a security
claim and marketing fog.

Until the seal is implemented end to end, the public claim remains:

- Sailfin enforces declared effects and capsule capability surfaces at compile
  time today.
- Sailfin's 1.0 runtime seal is being built to enforce those capabilities at the
  syscall boundary.
- The seal is a 1.0 requirement because capability security is one of the
  language's pillars, not an optional hardening pass.

## The thesis

The agent era makes ambient authority untenable. Generated code, dependency
trees, tools, and plugins need a substrate where authority is explicit,
auditable, and enforced.

Sailfin's bet is that the substrate should be the language and runtime together:
effects for what code can do, capabilities for the authority it receives, and
structured concurrency for scope, inheritance, and revocation. Static proof for
the code the compiler understands. Runtime enforcement for the boundaries it
cannot.

That is the capability seal. It is the center of Sailfin's 1.0 story.
