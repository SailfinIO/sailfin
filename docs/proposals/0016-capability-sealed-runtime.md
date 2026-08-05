---
sfep: 16
title: The Capability-Sealed Runtime — Claim Ladder and Link-Time Admission
status: Accepted
type: runtime
created: 2026-06-07
updated: 2026-08-05
author: "agent:compiler-architect; project owner (repositioning 2026-06-26, admission rule 2026-07-26); agent:Sailbot (2026-08-05 rewrite)"
tracking:
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0016 — The Capability-Sealed Runtime

> **Nothing in this document is enforced today.** It is the design target for
> pillar 2 (capability security), scheduled as a 1.0 hard GA blocker. The
> discipline in CLAUDE.md — *never market or document an unenforced feature* —
> applies with full force: the claim ladder in §3.1 exists precisely so that
> partial progress cannot be reported as a seal.
>
> **This is a rewrite** of the 2026-06-07 original, which was ~75% vision prose
> competing with `docs/strategy/decision-brief.md` for the positioning job. That
> prose moved to the brief; the normative content — the claim ladder, the
> enforcement points, the link-time admission rule, and the manifest schema —
> stayed and is now the whole document. §10 maps old section numbers to new for
> anyone following an existing citation.

## 1. Summary

Sailfin's effect system is a compile-time promise that is **erased at codegen**.
`![net]` is checked, and then the binary becomes an ordinary native executable
that can call anything libc exposes. The capability manifest in `capsule.toml` is
a lint, not a cage. This proposal specifies the cage: a **claim ladder** with
three precisely-bounded tiers, the enforcement points that move a program up it, a
**link-time provenance admission rule** that makes the boundary decidable, and the
`vetted-link-inputs` manifest schema that carries it. The design's distinguishing
property is not that effects exist — several languages have those — but that
capability grants become **scoped, inherited, and revocable per task**, enforced
at a syscall chokepoint the toolchain owns.

## 2. Motivation

Static effect checking fails at exactly the boundaries that matter. The type
system cannot see through FFI, dynamically loaded plugins, or generated code, so
`![net]`-free capsules can reach the network by any of those routes. This is not
hypothetical in the current tree — §4.2 names three concrete paths, each defeating
the seal by a different mechanism.

The prior art leaves the lane open. The static effect systems (Koka, Flix,
Effekt) stop at the type level and are defeated by FFI. Go's Capslock and the
Rust ecosystem's efforts are static-only and defeated by `unsafe`. WASI enforces
genuinely, but at a coarse VM boundary with the performance and interop cost that
implies. Nobody offers native-speed execution with compile-time effect proofs
*and* runtime capability enforcement.

The application is timeless by CLAUDE.md's own test: capability security matters
in 20 years, whereas AI API wrappers churn every six months. The positioning
argument for *why this is worth being a GA blocker* lives in
`docs/strategy/decision-brief.md` §4 (Pillar 1 — Reach) and is deliberately not
restated here; this document specifies the mechanism.

## 3. Design

### 3.1 The claim ladder (normative)

Every Sailfin artifact sits at exactly one of three tiers. The tier is a property
of the artifact and its link inputs, decidable at link time by §3.4. **No tier may
be claimed by a stronger name than it earns**, and the ladder exists so that
progress can be reported honestly while the top tier is unreachable.

| Tier | What it means | What it requires |
|---|---|---|
| **Unsealed** | The manifest is a lint. Declared effects are checked and erased. | The state of every Sailfin binary today. |
| **Provenance-sealed** | Sailfin-authored code cannot make an un-gated syscall. Declared foreign code is trusted, may issue un-gated syscalls, and is part of the TCB. | Owned syscall layer; every executable input either build-produced or digest-declared (§3.4). |
| **Fully sealed** | The *process* cannot perform a syscall class outside its manifest. | Provenance-sealed, plus `-nostdlib`, plus no foreign executable input, plus runtime loading of undeclared executable code disabled. |

Two rules bind the ladder:

1. **Only *fully sealed* supports a process-wide claim.** A provenance-sealed
   artifact must never be described with language implying confinement of foreign
   code. The honest sentence for provenance-sealed is: *"Sailfin-authored code
   cannot make an un-gated syscall; declared foreign code, including libc and
   OpenSSL, is trusted and is not confined by the seal."*
2. **Tier is reported, not assumed.** The build records the achieved tier and the
   reason it is not higher, in the provenance card. An artifact whose tier cannot
   be determined is Unsealed.

### 3.2 Enforcement points

The shift is one of enforcement *locus*, defended in depth across three points.

1. **Static proof — zero cost, the common case.** The effect checker proves the
   call graph stays within the manifest. Proven-safe code emits no gate and runs
   at full native speed. This is the existing effect system, extended to flow
   capability *grants* and not merely effect kinds.
2. **Runtime gate — the backstop.** FFI calls, dynamically loaded plugins,
   generated code, and reflective paths route through the owned syscall layer,
   which consults the live capability context. This is the half that turns a lint
   into a cage; SFEP-0060 is its design.
3. **Capability context — the carrier.** A per-process and, via the scheduler,
   per-task record of the live grant, which the syscall stubs consult. This is the
   runtime object-capability model.

The zero-overhead property depends on point 1 proving away as much as possible so
the gate is rare — see §4.4 Q2.

**Worked example.** A thumbnailer capsule declares what it needs, in the manifest
syntax that ships today:

```toml
[capsule]
name = "image-thumbnailer"

[capabilities]
required = ["io"]
```

`required = ["io"]` is the shipped granularity: a coarse effect atom. The
compiler already rejects a `![net]` call from this capsule at compile time
(`E0402`/`E0403`), and today that is the whole story — the linked binary can
still `connect(2)`.

Under the seal, three things change. The resolved manifest is sealed into the
artifact; the syscall stubs consult the derived mask, so a `connect(2)` reached
from *any* Sailfin-authored path — including one the type system could not see —
**traps with a capability violation rather than succeeding**; and the link refuses
any executable input not admitted by §3.4.

What this example deliberately does *not* show is path-scoped authority — a grant
of read-only `/in` and write-only `/out` rather than blanket `io`. That
granularity is unresolved (§4.4 Q1) and would need a manifest schema beyond
`required = [...]`, most plausibly via hierarchical sub-effects (SFEP-0017). No
part of this document should be read as implying path scoping exists.

### 3.3 The per-task capability context

This is where the three pillars multiply rather than merely coexist. The scheduler
(`runtime/sfn/concurrency/scheduler.sfn`) is the natural home for the capability
context, and three properties fall out once both the scheduler and the syscall
layer are owned:

- **Scoped.** A structured-concurrency scope defines the lifetime of a grant.
  When the scope exits, the grant is gone.
- **Inherited and attenuated.** A child task inherits a *subset* of its parent's
  capabilities — never more, often deliberately less. A worker handling untrusted
  input can be spawned with `net` stripped.
- **Revocable.** Because the context is a live runtime object, a capability can be
  revoked mid-flight; the next gated syscall in that task's subtree fails.

"Scoped, inherited, revocable capabilities per task" has no mainstream-language
implementation. It is the synthesis: **effects say what, capabilities say how
much, structured concurrency says for how long and to whom.**

### 3.4 Link-time admission rule (normative; owner decision 2026-07-26)

The owned Linux x86-64 link accepts an executable input only when it falls into
one of four provenance classes:

1. an object emitted during this build by the Sailfin backend from a source in
   the resolved capsule graph;
2. an object emitted during this build from the owned Sailfin runtime sources;
3. the single compiler-owned syscall-stub object, whose raw syscall instructions
   are expected and whose entry points enforce the sealed capability mask; or
4. a foreign object, archive member, shared library, CRT object, interpreter, or
   transitive shared-library dependency whose exact bytes match an explicit
   digest in the resolved capsule manifest.

Everything else is rejected before `ld.lld` runs. In particular, a path, a
`-lfoo` name, a SONAME, a signature, or successful symbol resolution **is not
provenance**: the driver must resolve archives to selected members and shared
libraries through their transitive `DT_NEEDED` closure, hash the exact files it
will pass to the linker or record for the loader, and reject a missing or
mismatched declaration. An arbitrary `.o` fixture added to the link without a
matching declaration fails regardless of its instruction bytes.

The same rule applies to executable code requested at runtime: a fully sealed
binary rejects dynamic loading, while a provenance-sealed loader may map only a
digest-declared object and must verify it before execution.

### 3.5 The `vetted-link-inputs` manifest key (normative)

Capsule manifests gain a single-line `[build]` string array named
`vetted-link-inputs`. Each entry has the canonical form:

```toml
[build]
vetted-link-inputs = [
  "shared-library:libssl.so.3:sha256:<64-lowercase-hex>",
  "crt:Scrt1.o:sha256:<64-lowercase-hex>",
]
```

`<kind>` is one of `object`, `archive`, `shared-library`, `crt`, or `interpreter`.
The logical name is for diagnostics; **the digest is the authority.** Dependency
manifests contribute their entries to the resolved link plan, provenance cards
record the resolved path and digest, and duplicate logical names with different
digests are an error. Wildcards, bare linker flags, directories, SONAME-only
entries, and an "all system libraries" escape hatch are invalid.

Three coordination requirements, none of which existed when this key was first
specified:

- **Manifest schema ownership.** SFEP-0020 §3.6 establishes `[capsule] publish`
  as the precedent for adding a manifest key: strict typing, an explicit
  malformed-value error rather than a coerced default, and a seed that tolerates
  the key before any manifest adopts it. `vetted-link-inputs` follows that
  precedent exactly, including the rule that an older compiler cannot be
  retroactively constrained by the field.
- **Workspace inheritance.** Under SFEP-0051, vetted inputs for a shared runtime
  dependency should be declarable once at the workspace level rather than copied
  into every member manifest. The resolved link plan is the union of workspace and
  member declarations; a member may add entries but must not shadow a workspace
  entry with a different digest for the same logical name.
- **The digest must be computable without a shell.** See §4.2 hole 4 — this is
  currently a circular dependency, not a detail.

### 3.6 The syscall-instruction scan is a tripwire, not proof

An instruction-aware scan of executable sections may ship as defense in depth. It
reports decoded raw syscall instructions outside the compiler-owned stub.
Normatively:

- For **Sailfin-produced** objects, such an instruction is a hard internal-error
  rejection — the backend should not emit it.
- For **digest-vetted foreign** inputs it is a prominent diagnostic and a
  provenance-card finding, **not** a hard rejection. False positives or an
  expected vendor implementation must not tempt the linker to replace the
  decidable provenance rule with opcode policy.
- Undecodable executable bytes are diagnosed the same way.

A byte-level `0f 05` scan is **neither sound nor complete**: false positives from
immediates that happen to encode the opcode, false negatives from instructions
constructed at runtime. The scan cannot detect runtime instruction construction or
other routes foreign code takes to libc, which is why **it never upgrades a
provenance-sealed artifact to fully sealed.**

### 3.7 Dependency order (corrected 2026-08-05)

The original chain asserted: finish the runtime → own the backend → own the
syscall layer → land the object-capability model → carry capabilities through the
scheduler → seal. **The second step is not a prerequisite of the third**, and
asserting it scheduled the longest pole in front of the shortest.

`compiler/src/llvm/syscall.sfn` (156 lines) already lowers `syscall1`..`syscall6`
to register-constrained `call i64 asm sideeffect "syscall"` per the SysV AMD64 ABI
on Linux x86-64, contract-gated by `syscall_contract_error` to exactly one
permitted caller: `runtime/sfn/platform/syscall_linux.sfn` — **which does not
exist.** The enforcement chokepoint is therefore reachable on the existing LLVM
path, and Axis 3 is blocked on writing a runtime body, not on owning code
generation. The full argument and its gate are SFEP-0066 §3.5.

What the seal actually requires, in dependency order:

| # | Requirement | Owner | Reaches which tier |
|---|---|---|---|
| 1 | C→Sailfin runtime | SFEP-0025 — **done** | — |
| 2 | Owned link on tier-1 | SFEP-0066 — **done, Linux x86-64/aarch64** | gives the admission rule a home |
| 3 | Owned syscall layer | SFEP-0060 | **provenance-sealed** |
| 4 | Link-time admission + `vetted-link-inputs` | this SFEP §3.4–3.5 | **provenance-sealed** |
| 5 | Runtime object-capability model | the `sfn/capability` work | policy enforcement |
| 6 | Per-task capability context | extends the scheduler | scoped/inherited/revocable |
| 7 | Remove every foreign executable input | SFEP-0048 (OpenSSL), DNS, `-nostdlib` | **fully sealed** |

A seal-sufficient native backend is an **enhancement** — it makes a sealed binary
*auditable* by carrying capability metadata into the object file, which is a real
Reach-pillar claim — but it is not on the enforcement critical path.

## 4. Threat model, current holes, and open questions

### 4.1 In and out of scope

**In scope**, per the tier claimed (§3.1): the syscall-class boundary for a fully
sealed process; the Sailfin-authored-code boundary for a provenance-sealed
process; and scoped, attenuated, revocable grants per task.

**Explicitly out of scope — do not over-promise:**

- **Side channels** (timing, cache, Spectre-class). A capability model is not a
  microarchitectural defense.
- **The runtime itself is TCB.** The syscall layer enforcing the gate is trusted;
  a bug there is a full bypass. This is the cost of owning the boundary.
- **Vetted foreign code.** Its digest establishes identity, not confinement. It
  remains TCB and may bypass the gate.
- **Kernel or hardware compromise** — out of any language's scope.

### 4.2 Named un-gated paths in the current tree

Each of these defeats the seal by a different mechanism, and each **bounds what
may honestly be claimed** rather than merely naming a task.

1. **`getaddrinfo` resolves DNS inside libc.** `runtime/sfn/adapters/net.sfn:119`
   declares it and line 221 calls it for real resolution. It opens its own UDP
   socket and talks to port 53 without passing any Sailfin stub. Routing
   `connect(2)` through an owned gate while resolution stays in libc means a
   `![net]`-free capsule that resolves a hostname **has already made a network
   syscall the gate never saw.** `![net]` is not enforceable to the syscall until
   DNS is Sailfin source.
2. **Shell-out spawns `/bin/sh` with ambient authority.** A sealed process that
   can spawn a shell has no seal — and the toolchain that must *produce* sealed
   binaries currently relies on the path it must forbid
   (`compiler/src/build/fs.sfn`, `compiler/src/cli_selfhost.sfn`).
3. **OpenSSL is linked native code with its own syscall paths.**
   `runtime/capsule.toml:88` carries `link-libs = ["-lm", "-lpthread", "-lssl",
   "-lcrypto"]` into **every** Sailfin binary, including the compiler. This makes
   the link-time rule and the OpenSSL removal **the same decision**: a byte-level
   "no raw syscall opcode" rule rejects OpenSSL, and any rule permissive enough to
   admit OpenSSL admits everything. SFEP-0048 removes the exception; until then
   the runtime manifest must digest-declare the resolved OpenSSL libraries and
   their full transitive closure, and such a binary is provenance-sealed.
4. **The digest mechanism currently depends on hole 2.** §3.5 makes sha256 the
   authority for `vetted-link-inputs`, and the compiler computes sha256 by
   spawning a shell (`compiler/src/build/fs.sfn`,
   `compiler/src/cli_selfhost.sfn:45`). The seal's provenance mechanism therefore
   depends on the exact hole the seal must close. **§3.5 has a hard prerequisite
   on SFEP-0048's native hashing**, independent of OpenSSL removal — closing hole
   3 does not close this one.

Holes 1, 2, and 4 are removable by owning the corresponding surface. Hole 3 is
the one that forces the link-time rule to be *specified* rather than deferred,
since no rule can be written while an exception the size of a TLS stack is linked
into every binary.

### 4.3 The reachable claim today, and the one not to make

libc remains **dynamically linked** after every conversion in the owned-syscall
work, so `connect(2)` stays one PLT entry away until a `-nostdlib` static link
exists — itself gated on the allocator, unwind, `environ`, and threads. The
runtime also still reaches libc through **528 `extern fn` declarations across 46
files**; SFEP-0060 finds only ~30 are effect-bearing kernel entries, which is what
makes the chokepoint tractable, but the rest are still ambient today.

Therefore the honest boundary at the end of the owned-syscall work is
**provenance-sealed** (§3.1), and the stronger process-wide sentence — that a
sealed process cannot perform a syscall class outside its manifest *even via FFI
or dynamically loaded native code* — **must not be marketed, quoted, or repeated
in external material** until a `-nostdlib` link exists and every executable input
meets the fully sealed rule. This is the same discipline that keeps `![gpu]` from
implying an accelerator exists.

### 4.4 Open questions

1. **Granularity.** Capabilities at syscall-class level (`net`, `fs-read`) or
   finer (host:port, path-prefix)? Finer is more useful and more expensive.
2. **Static/dynamic split.** How much can the effect checker prove away so the
   runtime gate is rare? Effect polymorphism plus capability-flow analysis is the
   lever; the more it proves, the closer to zero overhead.
3. **FFI boundary semantics.** Does an `extern fn` call inherit the caller's
   capability context automatically, or must FFI be explicitly capability-typed?
   Unresolved; owner-level design gate (`docs/strategy/decision-brief.md` §7).
4. **Link-time sealing — resolved** by §3.4. Vetted foreign code remains TCB, so
   only a `-nostdlib` artifact with no foreign executable input earns the
   process-wide fully sealed claim. Opcode inspection cannot establish it (§3.6).
5. **Capability forgery via memory corruption.** If the context is a live runtime
   object, what prevents code from fabricating or widening its own grant by
   corrupting it? §4.1 concedes the runtime is TCB, but that concession covers
   *bugs in the gate*, not *reachability of the grant's representation from
   ordinary code*. This connects directly to SFEP-0018: while ownership and
   aliasing enforcement is incomplete, a memory-safety defect is a
   capability-forgery vector, and the seal has no written threat model saying so.
   Unresolved, and flagged as such in `docs/strategy/decision-brief.md` §10.

## 5. Effect & capability impact

This proposal is the capability system's enforcement half, so the impact is total
rather than incidental. Specifically:

- **No new effect atom.** `canonical_effects()` is unchanged. The seal enforces
  the existing taxonomy rather than extending it; hierarchical sub-effects
  (SFEP-0017) are the mechanism if finer granularity wins §4.4 Q1.
- **Effects gain a runtime denotation.** Today `![net]` has no meaning after
  codegen. Under the seal it names a syscall class the gate consults, which makes
  the effect checker's proof load-bearing at runtime rather than advisory.
- **Capability grants become values with lifetimes.** §3.3 makes a grant a live
  runtime object owned by a task scope, which is a genuinely new obligation on the
  scheduler and interacts with the reclamation seam (SFEP-0064): a grant's
  lifetime must end deterministically at scope exit, not at collection.
- **The toolchain's own authority becomes the counterexample.** The compiler
  currently needs shell-out and ambient `![io]` (§4.2 holes 2 and 4). A toolchain
  that cannot produce a sealed build of itself is the sharpest available test of
  the design, and §9 makes it one.

## 6. Self-hosting impact

The seal touches the runtime, the build driver, and the manifest schema — not the
language front end. No lexer, parser, or AST change; the effect checker changes
only if §4.4 Q1 selects finer granularity.

**The seed carve-out governs the syscall layer.** Per
`.claude/rules/seed-dependency.md`, the pinned seed compiles the working-tree
runtime, so a compiler capability that *runtime source calls* must exist in the
**seed**, not merely in the freshly built compiler. `syscall_linux.sfn` calling
`syscall1`..`syscall6` is exactly that case. It is **already satisfied**: the
builtins landed 2026-07-30 and are contained in `v0.9.0`/`v0.9.1`, and
`bootstrap.toml [seed].version` is `0.9.1` — so writing the runtime consumer needs
no seed cut. Any *change* to the syscall builtins does, and lands alone as a
`seed-blocker` with the complete capability family in one PR.

**The manifest key follows SFEP-0020 §3.6's sequence:** implement and test strict
parsing of `vetted-link-inputs` first, pin a seed that tolerates the key, and only
then have any manifest declare it. A seed that rejects the key would fail to build
the workspace that uses it.

**Bootstrapping the seal is the hard case.** A fully sealed compiler cannot spawn
a shell, but the current build driver does (§4.2 hole 2). The compiler must
therefore reach the point where it can build itself without shell-out *before* the
seal can be applied to the toolchain, and `make check`'s triple-pass fixed point
must stay green through every conversion.

## 7. Alternatives considered

**Static enforcement only — no runtime gate.** Rejected: this is the status quo
and the state of the prior art. It is defeated by FFI, `unsafe`, plugins, and
generated code — precisely the paths that carry untrusted code.

**Enforce at a VM boundary (the WASI model).** Rejected as the primary mechanism.
It works, and it is the honest comparison point, but it surrenders native speed
and native interop, which are the reasons to choose Sailfin at all. The seal is
complementary to OS sandboxing, not a replacement for it.

**Opcode policy instead of provenance.** Rejected as the decidable rule, retained
as defense in depth (§3.6). A byte scan is neither sound nor complete, and the
OpenSSL case proves any opcode rule permissive enough to admit real vendor code
admits everything.

**Trust the linker's symbol resolution as provenance.** Rejected explicitly in
§3.4. Successful resolution proves a symbol was found, not which bytes provide
it. Paths, `-lfoo` names, and SONAMEs are all forgeable or ambiguous; only a
digest over the exact file passed to the linker or recorded for the loader is
authority.

**Ship the seal only when fully sealed is reachable.** Rejected. It would mean
years with nothing reportable and a strong incentive to overclaim in the interim.
The three-tier ladder lets provenance-sealed ship as a real, testable property
with an explicitly bounded claim.

**Enforce per-process only, not per-task.** Rejected. Per-process grants cannot
attenuate a worker handling untrusted input, which is the central use case, and
they forfeit the differentiator in §3.3.

## 8. Stage1 readiness mapping

Nothing here is shipped. Every item is pending, and the SFEP stays `Accepted`
until the whole ladder is enforced end-to-end.

- [ ] Parses — pending the `vetted-link-inputs` manifest schema.
- [ ] Type-checks / effect-checks — capability-grant flow does not exist.
- [ ] Emits valid `.sfn-asm` — no manifest-sealing section is emitted.
- [ ] Lowers to LLVM IR — the syscall primitive lowers; no consumer exists.
- [ ] Regression coverage — §9.
- [ ] Self-hosts — blocked on §6's bootstrapping case.
- [ ] `sfn fmt --check` clean — n/a until code lands.
- [ ] Documented in `docs/status.md` + spec — **must remain absent until
      enforced.** A partial entry is the failure mode this section guards.

**The `Implemented` bar for this SFEP specifically:** a provenance-sealed tier-1
artifact whose gate is proven by a negative test — an undeclared capability's
syscall is refused at runtime — plus the claim in `docs/status.md` naming its tier
and its holes. "Parsed but not enforced" stays `Accepted`.

## 9. Test plan

**Admission rule** (`compiler/tests/{unit,e2e}/`):

- Unit: each of §3.4's four provenance classes admits; an undeclared `.o` is
  rejected *regardless of instruction bytes*; a digest mismatch is rejected; a
  duplicate logical name with a differing digest errors.
- Unit: archive inputs resolve to selected members and shared libraries to their
  transitive `DT_NEEDED` closure, each hashed — a SONAME-only or path-only
  declaration is rejected.
- E2E: a build declaring OpenSSL by digest reports **provenance-sealed** and names
  OpenSSL as TCB in the provenance card; removing the declaration fails the link.

**Manifest schema:** omitted, well-formed, and malformed `vetted-link-inputs`
values, following SFEP-0020 §3.6's `[capsule] publish` test shape — a malformed
value is a manifest error, never a coerced default. Workspace-plus-member union
and the shadowing prohibition from §3.5.

**Claim ladder:** a test per tier asserting the *reported* tier and the reason it
is not higher. A fully sealed claim must fail while any foreign executable input
or dynamic libc remains — this is the guard against §4.3 drift.

**The gate itself:** a negative test where a capsule declaring no `![net]` calls a
gated stub and is refused at runtime with a capability violation, not a segfault.
A per-task test that a child spawned with `net` stripped is refused while its
parent succeeds, and that revocation mid-flight fails the next gated syscall in
the subtree.

**Syscall contract:** a guard that `syscall1`..`syscall6` stay rejected outside
`runtime/sfn/platform/syscall_linux.sfn`, so §3.7's chokepoint cannot erode once
that module exists.

**Scan:** a Sailfin-produced object containing a raw syscall is a hard internal
error; a digest-vetted foreign input containing one is a diagnostic and a
provenance-card finding that does **not** fail the link (§3.6).

Per `.claude/rules/no-bash-e2e.md` all E2E coverage is `*_test.sfn` using
`sfn/test`, driving subprocesses via `process.run_capture` with
`clean_runner_env(nested_runner_scratch(...))`.

## 10. References

- **SFEP-0060** — The Owned Syscall Layer (the enforcement chokepoint; the ~30
  effect-bearing entries)
- **SFEP-0066** — Codegen Provider Ownership (role ownership; the §3.7 dependency
  correction and its design gate)
- **SFEP-0048** — Native crypto + TLS (closes §4.2 holes 3 and 4)
- **SFEP-0025** — Native Runtime Architecture (the `extern fn` model this bounds)
- **SFEP-0020** — Role-Oriented Compiler Capsules (§3.6 manifest-key precedent)
- **SFEP-0051** — Workspace Manifest (declaration inheritance for §3.5)
- **SFEP-0017** — Hierarchical Effects (the mechanism if §4.4 Q1 chooses finer
  granularity)
- **SFEP-0064** — Reclamation seam (grant lifetimes, §5)
- **SFEP-0002** — Capsule Distribution (manifests as lint, not guarantee)
- `docs/backend-independence.md` — the axis taxonomy and what each conquest buys
- `docs/strategy/decision-brief.md` — positioning, safety-claim discipline, and
  the open FFI question
- Prior art: WASI (coarse but real enforcement), Koka / Flix / Effekt (static,
  FFI-defeated), Go Capslock, capability-based OS lineage (KeyKOS, EROS, seL4)

### Section map from the pre-2026-08-05 revision

| Old | New |
|---|---|
| §1 TL;DR | §1, §2 |
| §2 The dream | `docs/strategy/decision-brief.md` |
| §3 The convergence | §3.7 |
| §4 From lint to cage | §3.2 |
| §5 Structured concurrency as the bridge | §3.3 |
| §6 Why now | `docs/strategy/decision-brief.md` |
| §7 The dependency chain | §3.7 (corrected) |
| §8 Threat model | §4.1 |
| §8.1 Named un-gated paths | §4.2 |
| §8.2 Claim stronger than reachable | §4.3 |
| §8.3 Link-time admission rule | §3.4, §3.5, §3.6 |
| §9 Open questions (Q1–Q5 numbering retained) | §4.4 |
| §10 Non-goals | §7 |
| §11 The one-line version | `docs/strategy/decision-brief.md` |
