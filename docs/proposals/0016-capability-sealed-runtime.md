---
sfep: 16
title: The Capability-Sealed Runtime
status: Accepted
type: runtime
created: 2026-06-07
updated: 2026-07-26
author: "agent:compiler-architect; project owner (repositioning)"
tracking: "#1639, #934, #1642, #1643"
supersedes:
superseded-by:
graduates-to:
---

# Proposal: The Capability-Sealed Runtime — Effects Enforced to the Syscall

**Date:** 2026-06-07 (repositioned 2026-06-26)
**Author:** Compiler architect (design); repositioned by project-owner decision
**Status:** **1.0 hallmark feature — hard GA blocker.** This delivers pillar 2
(capability security) end-to-end; a compile-time-only capability check that is
erased at codegen does not deliver the pillar. Scheduled as the umbrella tracking
epic **#1639** with five child epics (see §7). Depends on owning the backend
(Axis 2) and the syscall layer (Axis 3), which this decision pulls onto the 1.0
critical path. **Not yet implemented or enforced** — the design below is the
target, not a shipped claim (see the threat-model discipline in §8).
**Companion docs:** `docs/proposals/0015-llvm-independence.md` (the *how* — owning the
backend + syscall layer), `docs/proposals/0025-native-runtime-architecture.md` (scheduler,
extern-fn syscall model, C→Sailfin migration and architecture),
`site/src/content/docs/docs/reference/runtime-abi.md` (target ABI).

> **Why this doc exists.** `llvm-independence.md` answers *how* Sailfin stops
> being dependent on someone else's toolchain. This doc answers *what that
> independence is for*. It is the capstone that unifies Sailfin's three pillars
> — effects, capabilities, concurrency — into a single capability none of them
> delivers alone: a native binary whose declared effects are enforced at
> runtime, down to the syscall boundary. As of 2026-06-26 this is a **1.0
> hallmark feature and a hard GA blocker**, scheduled as epic #1639 — not a
> post-1.0 dream. The scheduling changed; the engineering honesty does not:
> **nothing here is enforced today** (see the threat model in §8 — this is the
> opposite of a shipped safety claim, and stays unmarketed until enforced
> end-to-end).

---

## 1. TL;DR

- Today the effect system is a **compile-time promise that is erased at
  codegen**. `![net]` is checked, then the binary becomes an ordinary native
  executable that can call anything libc exposes. The capability manifest is a
  *lint*, not a *cage*.
- The dream: a **capability-sealed binary** that physically cannot make a
  syscall it didn't declare — not because the compiler said so, but because the
  runtime it is built on refuses to issue the syscall.
- This is the **convergence** of four threads, not a new pillar:
  effects = *policy*, capabilities = *manifest*, owning the backend (Track 8) =
  *metadata survives lowering*, owning the syscall layer (Axis 3) = *one
  enforcement chokepoint*.
- **Structured concurrency (pillar 3) is the secret bridge.** The scheduler
  Sailfin is already growing (`runtime/sfn/concurrency/scheduler.sfn`, epic
  #965) is where *per-task capability contexts* live, giving capabilities a
  **scope, a lifetime, and revocation** — "scoped, inherited, revocable
  capabilities per task," which is genuinely new.
- **Why now:** the agent era is a capability-security crisis. Sailfin can be the
  trustworthy substrate for running untrusted and AI-generated code at native
  speed with proofs *and* enforcement.
- **The open lane:** WASI does this through a coarse VM boundary; Go's Capslock
  and Rust's efforts are static-only and defeated by FFI/`unsafe`. Nobody offers
  "WASI-grade sandboxing, native speed, proven by the type system, enforced by a
  runtime you own." That is the differentiator.

---

## 2. The dream

> A Sailfin binary carries its capability manifest into the executable itself.
> Its runtime — Sailfin-native, syscall-owning — gates every effectful operation
> against that manifest. Code that the compiler proved safe runs with zero
> overhead; code the type system can't see (FFI, plugins, generated code) hits
> the same runtime gate and is refused if it exceeds the grant. The manifest is
> not advice. It is the boundary of what the process can do.

A concrete picture of the end state:

```sfn
// A capsule that declares exactly what it needs.
capsule "image-thumbnailer" {
    capabilities { fs: read-only("/in"), fs: write-only("/out") }
    // No net. No process spawn. No arbitrary fs.
}
```

When this links, the manifest is sealed into the binary. At runtime the owned
syscall layer holds a capability context derived from it: `connect(2)` traps —
not segfaults, *traps* with a capability violation — even if a transitively
linked C dependency tries it, because the dependency's `connect` resolves to the
Sailfin runtime's gated stub, not libc's.

---

## 3. The convergence — why each existing thread is necessary

| Thread | Role in the seal | Status |
|---|---|---|
| **Effects (pillar 1)** | The *policy*: what a function is permitted to touch (`![net]`, `![io]`, …) | Enforced at compile time (partial on macOS arm64, #613) |
| **Capabilities (pillar 2)** | The *manifest*: what a capsule + its dependency tree are granted | Manifests exist (`capsule.toml`); runtime model is post-1.0 (#934) |
| **Backend ownership (Track 8)** | Carry effect/capability metadata *through* codegen instead of erasing it; emit gated call sites | Vision — `llvm-independence.md` |
| **Syscall-layer ownership (Axis 3)** | The single *enforcement chokepoint*: every `write`/`connect`/`open` passes through Sailfin code | Vision — `llvm-independence.md` §8 Stage 4 (deepest, last) |

The load-bearing insight: **you cannot seal a binary you don't fully own.** As
long as the final mile is `clang` + libc, there is no place to put the gate —
libc will happily issue any syscall. The capability seal is *only* reachable
after toolchain + runtime independence. This is why `llvm-independence.md` is the
prerequisite and this doc is the payoff: independence is not the goal, it is the
thing that makes the goal *possible*.

---

## 4. From compile-time lint to runtime cage

The shift is one of *enforcement locus*, defended in depth:

1. **Static proof (zero cost, the common case).** The effect checker proves the
   call graph stays within the manifest. Proven-safe code emits no gate — full
   native speed. This is the existing effect system, extended to flow capability
   grants, not just effect kinds.
2. **Runtime gate (the backstop, for what static analysis can't see).** FFI
   calls, dynamically loaded plugins, generated/`eval`'d code, and reflective
   paths route through the owned syscall layer, which checks the live capability
   context. This is the half that turns a lint into a cage.
3. **Capability context (the carrier).** A per-process — and, via the scheduler,
   per-task — record of the live grant. The syscall stubs consult it. This is
   the runtime object-capability model already sketched as epic #934.

The defense-in-depth framing matters for the safety-claim discipline
(`CLAUDE.md`): static proof handles the bulk with no overhead; the runtime gate
exists precisely so the guarantee does not evaporate at the boundaries the type
system cannot reason about.

---

## 5. Structured concurrency as the bridge

This is the part that makes the three pillars *multiply* rather than merely
coexist. Sailfin is already building the scheduler:
`runtime/sfn/concurrency/scheduler.sfn` (epic #965, v0 fixed thread pool per
`docs/proposals/0025-native-runtime-architecture.md` `#37-scheduler-and-concurrency`; spawn/await/channel emit landed in #1153). That
scheduler is the natural home for the capability context, which yields three
properties that fall out *for free* once you own both the scheduler and the
syscall layer:

- **Scoped.** A structured-concurrency scope (`spawn`/nursery) defines the
  lifetime of a capability grant. When the scope exits, the grant is gone.
- **Inherited & attenuated.** A child task inherits a *subset* of its parent's
  capabilities — never more, often deliberately less. A worker handling
  untrusted input can be spawned with `net` stripped.
- **Revocable.** Because the context is a live runtime object, a capability can
  be revoked mid-flight; the next gated syscall in that task's subtree fails.

"Scoped, inherited, revocable capabilities per task" is a research-grade idea
with no mainstream-language implementation. It is the synthesis: **effects say
what, capabilities say how much, structured concurrency says for how long and to
whom.**

---

## 6. Why now — the application

The agent era is a capability-security crisis wearing a productivity costume.
Teams routinely run LLM-generated code, third-party MCP tools, and plugins with
full ambient authority — the exact thing capability security was invented to
prevent. `CLAUDE.md` already names the premise: *"AI agents are users."*

The capability-sealed runtime makes Sailfin **the substrate for executing
untrusted and AI-generated code**: native speed, compile-time effect proofs,
runtime capability enforcement. You hand an agent a Sailfin runtime and say
"generate whatever you want — it runs in exactly the box the manifest allows,
enforced at the metal." That is the natural endgame of the `sfn/ai` capsule
direction, and crucially it is a **timeless** problem by `CLAUDE.md`'s own test:
capability security matters in 20 years; AI API wrappers churn every 6 months.
Language-level capability sealing is permanent infrastructure.

---

## 7. The dependency chain (honest distance)

This *depends* on `llvm-independence.md` — and because the seal is now a 1.0 GA
blocker (#1639), that dependency pulls Axes 2 and 3 onto the 1.0 critical path
with it. The chain, in order:

1. **Finish C→Sailfin runtime** (Axis 1; M3 #390, M4 #965) — **done** (`runtime/native/` deleted, #822).
2. **Own the backend — the *seal-sufficient* one** (Track 8; `llvm-independence.md`;
   epic **#1640**) — on the 1.0 critical path. Note the timeline correction in
   `llvm-independence.md` §5: the seal needs a *correct, metadata-carrying,
   syscall-gating* backend, **not** the perf-parity optimizer that is the genuine
   long tail. The seal-sufficient target is agent-amenable and de-riskable by
   differential testing against the existing LLVM backend, so this dependency is
   plausibly quarters-scale, not the decade-scale arc the pre-LLM literature
   assumed.
3. **Own the syscall layer** (Axis 3; `llvm-independence.md` §8 Stage 4; epic
   **#1641**) — deepest piece; now GA-blocking, not "optional and last."
4. **Land the runtime object-capability model** (**#934**) — re-scoped from
   `priority:low`/post-1.0 to `priority:critical`, the seal's policy-enforcement
   keystone.
5. **Carry capabilities through the scheduler** (extends #965; epic **#1642**) —
   the per-task context (scoped / inherited / revocable).
6. **Then** the capability seal is buildable end-to-end (**#1643**).

Every step is now an `epic`-labeled child of #1639 on the board — this doc names
the destination so the steps read as a journey rather than a pile. The agentic
era compresses the long pole (step 2): the perf tail is off this critical path;
only correctness + metadata + the gate are.

---

## 8. Threat model — what it would and wouldn't guarantee

A capability seal is a security claim, so be explicit (and note again: **none of
this is implemented**). For the dream to be honest when it ships, it must state:

**In scope (what the seal aims to guarantee):**
- A **fully sealed** process cannot perform a *syscall class* outside its
  manifest. This claim applies only when every executable input is
  Sailfin-produced or part of the owned runtime, the final link is `-nostdlib`,
  and runtime loading of undeclared executable code is disabled. The linker
  admission rule in §8.3 makes that boundary decidable.
- A **provenance-sealed** process may include explicitly vetted foreign code.
  Sailfin-authored call paths still reach only gated stubs, but the foreign code
  is part of the trusted computing base (TCB) and may issue un-gated syscalls.
  This is the only claim available while libc or OpenSSL remains linked.
- Capability grants are scoped/attenuated/revocable per task.

**Explicitly out of scope (do not over-promise):**
- **Side channels** (timing, cache, Spectre-class) — a capability model is not a
  microarchitectural defense.
- **The runtime itself is TCB.** The syscall layer that enforces the gate is
  trusted; a bug there is a full bypass. This is the cost of owning the boundary.
- **Vetted foreign code in a provenance-sealed binary.** Its review and digest
  establish identity, not confinement; it remains TCB and may bypass the gate.
- **Kernel/hardware compromise** — out of any language's scope.

### 8.1 Named un-gated paths in the current tree (added 2026-07-25)

The "direct syscall instructions" bullet above is abstract. Surveying the ~170
`extern fn` runtime surface (SFEP-0060 §2.2) turned up three
*concrete* paths in the tree today, each of which defeats the seal by a
different mechanism. They are recorded here because each bounds what the seal
may honestly claim, and none was previously named.

1. **`getaddrinfo` resolves DNS inside libc.** It opens its own UDP socket and
   talks to port 53 without passing any Sailfin stub. Routing `connect(2)`
   through an owned gate while resolution stays in libc means a `![net]`-free
   capsule that resolves a hostname has *already made a network syscall the gate
   never saw*. **`![net]` is not enforceable to the syscall until DNS is Sailfin
   source** — this is a bound on the claim, not merely a task.
2. **`popen` forks `/bin/sh`.** `runtime/sfn/io.sfn::sailfin_runtime_shell_capture`
   spawns a shell with full ambient authority, and the compiler's own build
   driver uses it (`compiler/src/emit_helpers.sfn`, `compiler/src/build/fs.sfn`).
   A sealed process that can spawn a shell has no seal, and the toolchain that
   must *produce* sealed binaries currently relies on the path it must forbid.
3. **OpenSSL is linked native code with its own syscall paths.**
   `runtime/capsule.toml` links `-lssl -lcrypto` into every Sailfin binary
   (SFEP-0048). This makes open question 4 concrete rather than hypothetical: a
   byte-level "no raw `syscall` opcode in linked objects" rule **rejects
   OpenSSL**, and any rule permissive enough to admit OpenSSL admits everything.
   The link-time rule and the OpenSSL removal are therefore the same decision,
   not two independent ones.

Holes 1 and 2 are removable by owning the corresponding surface; hole 3 is the
one that forces the link-time rule to be *specified* rather than deferred, since
no rule can be written while an exception the size of a TLS stack is linked into
every binary.

### 8.2 The in-scope claim is currently stronger than anything reachable

The first "in scope" bullet above claims a sealed process cannot perform a
syscall class outside its manifest **"even via FFI or dynamically loaded native
code."** That is not decidable in the tree as it stands, and it will not become
decidable merely by owning the syscall layer:

- libc remains **dynamically linked** after every conversion in the owned-syscall
  work, so `connect(2)` stays one PLT entry away until a `-nostdlib` static link
  exists — itself gated on the whole Class C list (allocator, unwind, `environ`,
  threads).
- A byte-level `0f 05` scan of linked objects is **neither sound nor complete**:
  false positives from immediates that happen to encode the opcode, false
  negatives from instructions constructed at runtime. It is a tripwire, and this
  section must say which of the two it is claiming.

The honest enforced boundary at the end of the owned-syscall work is therefore
**"In a provenance-sealed binary, Sailfin-authored code cannot make an un-gated
syscall; declared foreign code, including libc and OpenSSL, is trusted and is
not confined by the seal."** That is real, testable, and suitable for
`docs/status.md`. It is *not* a process-wide FFI-and-loaded-code claim. Until a
`-nostdlib` link exists and every executable input meets the fully sealed rule,
the stronger sentence must not be marketed, quoted, or repeated in external
material — the same discipline that keeps `![gpu]` from implying an
accelerator exists.

### 8.3 Link-time admission rule (decision, 2026-07-26)

The owned Linux x86-64 link accepts an executable input only when it falls into
one of these provenance classes:

1. an object emitted during this build by the Sailfin backend from a source in
   the resolved capsule graph;
2. an object emitted during this build from the owned Sailfin runtime sources;
3. the single compiler-owned syscall-stub object, whose raw syscall instructions
   are expected and whose entry points enforce the sealed capability mask; or
4. a foreign object, archive member, shared library, CRT object, interpreter, or
   transitive shared-library dependency whose exact bytes match an explicit
   digest in the resolved capsule manifest.

Everything else is rejected before `ld.lld` runs. In particular, a path,
`-lfoo` name, SONAME, signature, or successful symbol resolution is not
provenance: the driver must resolve archives to selected members and shared
libraries through their transitive `DT_NEEDED` closure, hash the exact files it
will pass to the linker or record for the loader, and reject a missing or
mismatched declaration. An arbitrary `.o` fixture added to the link without a
matching declaration must therefore fail regardless of its instruction bytes.
The same rule applies to executable code requested at runtime: a fully sealed
binary rejects dynamic loading, while a provenance-sealed loader may map only a
digest-declared object and must verify it before execution.

Capsule manifests gain a single-line `[build]` string array named
`vetted-link-inputs`. Each entry has the canonical form
`"<kind>:<logical-name>:sha256:<64-lowercase-hex>"`, where `<kind>` is `object`,
`archive`, `shared-library`, `crt`, or `interpreter`. The logical name is for
diagnostics; the digest is the authority. Dependency manifests contribute their
entries to the resolved link plan, provenance cards record the resolved path
and digest, and duplicate logical names with different digests are an error.
Wildcards, bare linker flags, directories, SONAME-only entries, and an
"all system libraries" escape hatch are invalid.

OpenSSL's disposition is consequently explicit: while `-lssl -lcrypto` remain
in the default runtime link, the runtime manifest must declare the exact
resolved OpenSSL shared libraries and every executable member of their
transitive dependency closure. Such a binary is **provenance-sealed**, not fully
sealed, and OpenSSL remains TCB. SFEP-0048's native TLS implementation removes
that exception; silently treating the current `link-libs` entries as vetted is
forbidden. Dynamic libc, its CRT/loader, and its transitive dependencies receive
the same treatment until the `-nostdlib` milestone.

An instruction-aware scan of executable sections may ship as defense in depth,
but it is a **tripwire, not proof**. The scan reports decoded raw syscall
instructions outside the compiler-owned stub. For Sailfin-produced objects such
an instruction is a hard internal-error rejection because the backend should
not emit it. For digest-vetted foreign inputs it is a prominent diagnostic and
provenance-card finding, not a hard rejection: false positives or an expected
vendor implementation must not tempt the linker to replace the decidable
provenance rule with opcode policy. Undecodable executable bytes are diagnosed
the same way. The scan cannot detect runtime instruction construction or other
ways foreign code reaches libc, which is why it never upgrades a
provenance-sealed artifact to fully sealed.

**What this does not cover:**

- implementing admission or scanning in `compiler/src/build/direct_link.sfn`;
- proving that digest-vetted foreign code obeys the capability manifest;
- detecting self-modifying, generated, or otherwise runtime-constructed syscall
  instructions;
- a process-wide no-un-gated-syscall claim while libc, OpenSSL, another foreign
  executable input, or an unrestricted dynamic loader remains;
- macOS or Windows sealing; their vendor-shim rules follow this tier-1 rule
  after the Linux implementation is reviewed.

The discipline line (`CLAUDE.md`: *"don't ship unfinished safety claims"*)
applies with full force here: this must never be marketed as enforced until it is
enforced end-to-end and the threat model above is honestly tested. Until then it
is a vision, labeled as one.

---

## 9. Open questions

1. **Granularity.** Capabilities at syscall-class level (`net`, `fs-read`) or
   finer (host:port, path-prefix)? Finer is more useful and more expensive; the
   `image-thumbnailer` example assumes path-scoped `fs`.
2. **Static/dynamic split.** How much can the effect checker prove away so the
   runtime gate is rare? Effect polymorphism + capability flow analysis is the
   lever; the more it proves, the closer to zero-overhead.
3. **FFI boundary semantics.** Does an `extern fn` call inherit the caller's
   capability context automatically, or must FFI be explicitly capability-typed?
4. **Link-time sealing — resolved.** The linker uses the provenance admission
   rule in §8.3: build-produced Sailfin/owned-runtime objects and the designated
   syscall stub are admitted; every other executable input and transitive
   dependency requires an exact manifest digest. Undeclared or mismatched input
   is rejected. Vetted foreign code remains TCB, so only a `-nostdlib` artifact
   with no foreign executable input earns the process-wide fully sealed claim.
   Opcode inspection is defense-in-depth and cannot establish that claim.
5. **Relationship to #934.** Is #934 (runtime object-capability model) the
   policy-enforcement half of this dream, to be re-scoped as its keystone? Likely
   yes — worth a forward note on #934 if/when this graduates.

---

## 10. Non-goals

- **Not** a replacement for the effect system — it is the effect system *enforced
  at runtime where static proof can't reach*.
- **Not** a sandbox VM / container substitute for all threats — it is
  language-level capability sealing, complementary to OS sandboxing.
- **Not** a safety claim to market until enforced end-to-end (§8) — repositioning
  it as a 1.0 GA blocker raises its *priority*, not its *readiness*.
- **Not** off the 1.0 critical path. As of 2026-06-26 it *is* the 1.0 critical
  path's capstone (epic #1639): GA does not ship until the seal is enforced
  end-to-end on all tier-1 platforms.

---

## 11. The one-line version

`llvm-independence.md` is *how Sailfin stops being a Rust that happens to use
LLVM*. This is *what Sailfin is for once it's independent*: the language where
your effect annotations are not a promise the compiler keeps and then forgets,
but a boundary the binary cannot cross — the trustworthy native runtime for the
age of code written by machines.
