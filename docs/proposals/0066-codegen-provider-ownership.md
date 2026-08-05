---
sfep: 66
title: Codegen Provider Ownership — Which Toolchain Roles Sailfin Owns
status: Draft
type: tooling
created: 2026-08-05
updated: 2026-08-05
author: "agent:Sailbot (drafted); project owner (redistribution decision 2026-08-05)"
tracking:
supersedes: 15
superseded-by:
graduates-to:
---

# SFEP-0066 — Codegen Provider Ownership

> **Provenance.** This proposal is the normative successor to the retired
> SFEP-0015 ("Toolchain Independence — Sailfin-Native Backend"), which mixed a
> strategy survey, a roadmap, and a 660-line IR contract in one document and
> never conformed to SFEP-0001 §6. Its survey moved to
> `docs/backend-independence.md`; its Typed SSA v0 contract moved to SFEP-0059
> §10. What remains — and what this proposal decides — is the **provider
> boundary**: which roles Sailfin owns, where a replacement code generator
> plugs in, and what may honestly be claimed at each step.
>
> The *direction* here was accepted as SFEP-0015. Three things are **new and
> require a design gate**: the seam rescoping in §3.2, the `llc` disclosure rule
> in §3.4, and the dependency correction in §3.5.

## 1. Summary

Sailfin's path from source to running process has five distinct roles — emit,
select, assemble, link, and load — and "do we own the backend?" is not answerable
about any of them. This proposal makes **the role, not the toolchain, the unit of
account**: it fixes a normative role table with a named owner for each, requires
every independence claim to name the role it concerns, and locates the seam where
a replacement code generator plugs in. That seam is the **capsule boundary**
established by SFEP-0020, not the `Backend` interface in
`compiler/src/backend.sfn` — which is an external-tool invocation seam and cannot
carry a native code generator in its present shape. The proposal also records two
disclosures that prevent overclaiming: dropping clang from the assemble role does
not remove the LLVM toolchain, and owning the syscall layer does not depend on
owning code generation.

## 2. Motivation

Three concrete failures, all traceable to the missing role distinction.

**Claims drift from the tree.** SFEP-0015 asserted through its final revision
that Sailfin "shells out to `clang` to turn `.ll` into a binary" and listed
"remove clang as the Linux x86-64 linker driver" as the recommended next step.
Both were already false: `compiler/src/build/direct_link.sfn` (339 lines) builds a
bare `ld.lld` invocation with no clang in the argv, and `LlvmTextBackend.link`
tries it *first* on Linux x86-64 and aarch64. Meanwhile `docs/status.md:416`
still describes the seam as "every codegen/link `clang` invocation." Without a
role table, the shipped state and the design record drifted in opposite
directions and neither noticed.

**The named seam cannot hold the thing it was built for.** SFEP-0015 §6 presented
the provider interface as:

```sfn
interface Backend {
    fn lower(module: NativeModule) -> ObjectArtifact ![io];
    fn link(objects: ObjectArtifact[], out: string, libs: string[]) -> int ![io];
}
```

The shipped interface (`compiler/src/backend.sfn:106-111`) is:

```sfn
interface Backend {
    fn assemble(self, src: string, out: string, opt_flag: string, include_flags: string[]) -> int ![io];
    fn link(self, plan: LinkPlan) -> int ![io];
}
```

`assemble` takes **a string of LLVM IR text**. A native code generator has no
meaningful implementation of that signature — it does not consume `.ll`. The seam
that was documented as "where a native backend plugs in" is shaped so that a
native backend cannot. Compounding it, the driver constructs `LlvmTextBackend {}`
concretely and calls methods on the concrete type; `compiler/src` does not yet
self-host interface-typed values, so the interface is conformance documentation
rather than dispatch. "Stage 0 shipped" overstated what exists.

**The longest pole was scheduled in front of the shortest.** SFEP-0015 and
SFEP-0016 both asserted that owning the syscall layer depends on owning the
backend. `compiler/src/llvm/syscall.sfn` (156 lines) already emits raw,
register-constrained `syscall` instructions via LLVM inline asm, contract-gated to
one permitted caller. The dependency does not exist, and asserting it deferred a
tractable piece of work behind an intractable one.

## 3. Design

### 3.1 The normative role table

Five roles. Each has exactly one owner at a given target and version. This table
is the accounting unit; `docs/status.md` reports movement in it, and
`docs/backend-independence.md` tracks the arc.

| Role | Input → output | Owner (2026-08-05, tier-1 Linux x86-64) |
|---|---|---|
| **Emit** | analyzed program → target-neutral IR | Sailfin (`.sfn-asm`; typed SSA per SFEP-0059) |
| **Select** | target-neutral IR → machine instructions | **LLVM** |
| **Assemble** | machine instructions → object file | **clang** (`clang -c`) |
| **Link** | objects → executable image | **Sailfin** (`ld.lld` direct; clang fallback) |
| **Load** | executable image → process | OS loader (dynamic libc) |

Three normative rules follow:

1. **An independence claim must name its role.** "Sailfin owns the link on Linux
   x86-64" is a claim. "Sailfin is toolchain-independent" is not, and must not
   appear in `docs/status.md`, release notes, or external material.
2. **A role's owner is per-target.** macOS and Windows own no role beyond Emit.
   A tier-1 advance is never reported as a general one.
3. **Fallback is not ownership.** `direct_link.sfn` falls back to clang when any
   precondition misses. A role is owned at a target only when the owned path is
   the one that executes, and the fallback must trace its reason
   (`trace_direct_link_fallback`) rather than degrade silently.

### 3.2 The provider seam is a capsule boundary

**Decision: `Backend` in `compiler/src/backend.sfn` is the external-tool
invocation seam, not the code-generation provider seam. A replacement code
generator plugs in at the capsule boundary defined by SFEP-0020.**

SFEP-0020 §3.4 already places `llvm/` in `sfn/codegen-llvm`, target-neutral
lowering in `sfn/codegen`, the IR data models in `sfn/ir`, and `backend.sfn` in
`sfn/compiler` — explicitly because "generating LLVM and invoking a host linker
are separate responsibilities." That is the correct decomposition, and it gives
the provider boundary three properties the interface never had:

- **It is enforced.** SFEP-0020 §3.3 makes the dependency rules build/test
  invariants, including "`sfn/codegen-llvm` never reparses source or invokes
  semantic analysis." A static import-boundary test can fail a violation; an
  interface the driver does not dispatch on cannot.
- **It is provider-neutral by construction.** `sfn/codegen-llvm` depends only on
  `sfn/ir`. A future `sfn/codegen-native` capsule takes the same dependency and
  sits beside it, consuming verified Sailfin IR rather than a string of `.ll`.
- **It keeps authority honest.** Per SFEP-0020 §4 the codegen capsules target
  `required = []`; only `sfn/compiler` holds `![io]`. A code generator returns
  bytes and diagnostics; the driver writes them.

Accordingly, **SFEP-0020 gains a named empty slot**: `sfn/codegen-native`, peer
to `sfn/codegen-llvm`, same `sfn/ir`-only dependency, created when it owns a
usable contract and a real consumer (SFEP-0020 §3.7's no-placeholder rule).

`Backend`'s own shape is corrected rather than removed, since something must own
argv construction and `process.run`:

- `assemble` must stop taking provider-specific text. Its input becomes a
  provider-produced artifact reference; whether that artifact is LLVM IR text,
  textual assembly, or an object is the provider's business, and the driver's job
  is to invoke the right external tool for it or none at all.
- The interface becomes real dispatch when `compiler/src` self-hosts
  interface-typed values. Until then it is documented as a conformance contract,
  and `docs/status.md` must not describe it as pluggable dispatch.
- Renaming it to name its actual job (external toolchain invocation and link
  planning) is endorsed and left to the SFEP-0020 migration, which already
  anticipates a "driver-oriented name."

### 3.3 What ownership of each remaining role buys

| Advance | Buys |
|---|---|
| Own **Link** (done, tier-1) | hermeticity; a place for the seal's link-time admission rule (SFEP-0016 §3.4) |
| Own **Assemble** | assembler/object-format muscle; removes the clang driver — see §3.4 |
| Own **Select** (seal-sufficient) | capability metadata survives lowering: **auditability** |
| Own **Select** (perf-parity) | general-purpose competitiveness; nothing for the seal |
| Own **Load** (`-nostdlib`) | the *fully sealed* claim (SFEP-0016) |

### 3.4 Disclosure: dropping clang from Assemble does not drop LLVM

What Sailfin owns in the Select role is a textual-IR **printer**, not a code
generator. Because LLVM's MC layer performs encoding *and* object writing, an ELF
writer cannot slot underneath LLVM's instruction selection with nothing in
between. Without linking LLVM as a library, the only seam that exists is
**textual assembly** — which means an owned assembler consumes the output of
`llc -S`.

**Normative:** owning the Assemble role while Select remains LLVM's replaces the
clang *driver* with another LLVM *tool*. It is a real gain in hermeticity and it
builds the assembler and object-format capability that Select ownership later
needs. It is **not** toolchain independence, and reporting it as such is
prohibited by §3.1 rule 1. The alternative reading — replacing LLVM's
`MCObjectWriter` in-process — requires the LLVM C-API binding, which deepens the
dependency this arc exists to reduce.

### 3.5 Correction: the syscall layer does not depend on code generation

**Decision: owning the syscall layer (Axis 3, SFEP-0060) has no dependency on
owning the Select role.** The evidence is in the tree.
`compiler/src/llvm/syscall.sfn` recognises `syscall1`..`syscall6` and lowers them
to a register-constrained `call i64 asm sideeffect "syscall"` per the SysV AMD64
ABI on Linux x86-64. `syscall_contract_error` restricts these builtins to exactly
one caller module, `runtime/sfn/platform/syscall_linux.sfn` — **which does not
exist.** The primitive ships and self-hosts; the consumer is unwritten.

Two consequences are normative:

1. SFEP-0016's dependency chain is corrected: the seal's enforcement chokepoint
   is reachable on the LLVM Select path. A seal-sufficient native backend is an
   **enhancement** to the seal (auditability), not a prerequisite of it.
2. No proposal, issue, or status entry may cite "we do not own the backend" as
   the reason Axis 3 is unstarted. The reason is that
   `runtime/sfn/platform/syscall_linux.sfn` has not been written.

This does not weaken the case for owning Select — see
`docs/backend-independence.md` §3, where concurrency (safepoints, stack maps,
growable stacks) is the load-bearing long-term argument. It re-paces it.

## 4. Effect & capability impact

No change to Sailfin's effect semantics — no new effect, no change to
`effect_taxonomy.sfn::canonical_effects()`, no change to how `![io]` is checked.

The capability impact is structural and favourable. Concentrating external-tool
invocation in `backend.sfn` inside `sfn/compiler` means a code-generation provider
never needs `![io]`: it accepts verified IR and returns bytes plus diagnostics,
and the driver performs the effectful write. Under SFEP-0020 §4 that keeps
`sfn/codegen`, `sfn/codegen-llvm`, and a future `sfn/codegen-native` at
`required = []`, so importing a code generator does not implicitly grant the
authority to execute a linker.

For the capability seal specifically, this proposal's contribution is
**auditability, not enforcement** (§3.3). Enforcement lives in the syscall layer
(SFEP-0060), the link-time admission rule (SFEP-0016 §3.4), and the `-nostdlib`
link. Metadata surviving lowering is what makes a sealed binary *inspectable* by
a third party — which is the Reach pillar's actual claim, and worth having — but
it is not what makes the gate hold. Conflating the two is what produced the
scheduling error in §3.5.

## 5. Self-hosting impact

No language surface changes, so the lexer, parser, AST, typechecker, and effect
checker are untouched. The affected surface is the build driver and the codegen
capsule graph:

- `compiler/src/backend.sfn` — the `assemble` signature rescoping in §3.2.
- `compiler/src/build/{clang_argv,direct_link}.sfn` — role-owner reporting.
- The SFEP-0020 migration — adding the `sfn/codegen-native` slot to the accepted
  capsule set and its dependency rules.

The self-hosting invariant is preserved by the ordinary path: `make compile`
before targeted tests, and `make clean-build` first for any structural capsule
move, per SFEP-0020 §5. Two specific hazards:

**Seed dependency.** A change to the Select or Assemble role alters the compiler
binary's behaviour, so per `.claude/rules/seed-dependency.md` it bundles with its
consumer by default: `make compile` builds the new compiler from the old seed and
that fresh compiler compiles the consumer in one pass, with no seed cut. The
carve-out applies if and when the syscall layer lands — a compiler capability
that **runtime source calls** must exist in the pinned seed, because the seed
compiles the working-tree runtime. `runtime/sfn/platform/syscall_linux.sfn`
calling `syscall1`..`syscall6` is exactly that case. **It is already satisfied:**
the builtins landed 2026-07-30 and are contained in `v0.9.0`/`v0.9.1`, and
`bootstrap.toml [seed].version` is `0.9.1` — so writing the runtime consumer
needs no seed cut. Any *change* to the syscall builtins does, and lands alone as
a `seed-blocker` per `.claude/rules/seed-dependency.md`.

**Determinism.** Capsule and module names affect symbol mangling and artifact
paths (SFEP-0020 §5), so adding a codegen provider capsule requires the
determinism checks before and after, with mechanical renames explained.

## 6. Alternatives considered

**Keep SFEP-0015 and fact-correct it in place.** Rejected. It failed SFEP-0001
§6 on five required sections, and 65% of its body was an IR contract belonging to
SFEP-0059. Correcting the facts would have left a document whose genre still
mismatched its filing and whose length hid its normative content — the exact
condition that let the seam mismatch in §2 go unnoticed through several
revisions.

**Make `Backend` the real provider seam by widening it.** Rejected. Widening
`assemble` to accept either LLVM text or a native module makes the interface a
tagged union of two providers' internals, which is how LLVM assumptions smeared
across 137 files in the first place. SFEP-0020's capsule boundary is enforced by
import tests and requires no such union. Keeping `Backend` narrow — external tool
invocation only — is what lets both providers exist without either knowing about
the other.

**Bind the LLVM C-API now as the provider.** Rejected as a priority, not as a
design. Under §3.2 it is simply a second provider behind `sfn/codegen-llvm` and
conflicts with nothing, but it pins Sailfin's ABI to a specific LLVM version and
deepens the dependency being reduced. It should not precede the Assemble and
syscall work.

**Bind Cranelift instead of building a native provider.** Rejected for the
tier-1 sealed path. SFEP-0016 §3.4 makes Cranelift's output a digest-vetted
foreign object — permanently part of the trusted computing base and permanently
incapable of yielding a *fully sealed* binary. It also trades LLVM-dependence for
Cranelift-dependence plus an FFI surface. It remains a legitimate design
reference.

**Drop the role table and track "percent independent."** Rejected. A single
scalar is what allowed a shipped tier-1 link advance to coexist with a design
record claiming clang still drove the link. Per-role, per-target accounting is
the smallest structure that makes drift visible.

## 7. Stage1 readiness mapping

This proposal changes toolchain structure and reporting discipline, not language
behaviour. The checklist is interpreted as preservation, following SFEP-0020 §7.

- [x] Parses — no language surface change.
- [x] Type-checks / effect-checks — no effect semantics change (§4).
- [x] Emits valid `.sfn-asm` — unchanged.
- [x] Lowers to LLVM IR — unchanged; LLVM remains the Select owner.
- [ ] Regression coverage — §8; the role-claim and provider-boundary guards do
      not exist yet.
- [x] Self-hosts — the shipped direct-link path self-hosts today.
- [ ] `sfn fmt --check` clean — pending the `backend.sfn` rescoping in §3.2.
- [ ] Documented in `docs/status.md` — pending; the seam description at
      `docs/status.md:416` is currently stale per §2.

The proposal stays `Draft` until the owner gates §3.2, §3.4, and §3.5, and
`Accepted` does not become `Implemented` until the role table is the reported
accounting unit and its guards are green.

## 8. Test plan

**Already covered** — the direct-link path has real regression coverage:
`compiler/tests/e2e/direct_link_test.sfn`,
`compiler/tests/unit/direct_link_argv_test.sfn`, and
`compiler/tests/e2e/sailfin_trace_link_test.sfn` (asserts the final link is a
direct `ld.lld` invocation).

**To add:**

- **Role-owner reporting.** A unit test that the resolved owner of each role is
  reported per target, and an e2e test that a fallback to clang emits its traced
  reason rather than degrading silently (§3.1 rule 3).
- **Provider boundary.** Under SFEP-0020's boundary-test family, assert that a
  codegen capsule imports no driver, filesystem, or process module, and that
  `sfn/codegen-native`'s slot — once populated — takes no dependency
  `sfn/codegen-llvm` does not.
- **`assemble` input neutrality.** A unit guard that `Backend.assemble` receives
  an artifact reference and not provider-specific text, so a second provider
  cannot be blocked by the signature again (§3.2).
- **Differential oracle.** Per SFEP-0059 §10.9, any construct handled by a second
  provider is compared against the LLVM path on the same source fixture: same
  exit status, stdout, stderr, and externally visible state on Linux x86-64.
  Object bytes, symbol ordering not fixed by the runtime ABI, and optimization
  quality are not equality requirements.
- **Syscall contract.** A guard that `syscall1`..`syscall6` remain rejected
  outside `runtime/sfn/platform/syscall_linux.sfn`, so §3.5's chokepoint claim
  cannot erode once that module exists.

## 9. References

- **SFEP-0020** — Role-Oriented Compiler Capsules (the provider seam; gains the
  `sfn/codegen-native` slot per §3.2)
- **SFEP-0059** — Typed SSA Activation, incl. the normative v0 contract (§10) and
  the differential-testing seams (§10.9)
- **SFEP-0060** — The Owned Syscall Layer (Axis 3; the consumer of the shipped
  primitive in §3.5)
- **SFEP-0016** — The Capability-Sealed Runtime (the link-time admission rule;
  dependency order corrected by §3.5)
- **SFEP-0025** — Native Runtime Architecture (the `extern fn` contract)
- **SFEP-0006** — Unified Build Architecture (build-cost analysis)
- **SFEP-0003** — The Toolchain Surface (`sfn emit` output contracts)
- `docs/backend-independence.md` — the axis taxonomy, cost argument, and staging
- `docs/proposals/design-notes/1112-backend-interface-seam.md` — the original
  seam design note
- Retired: `docs/proposals/archive/0015-llvm-independence.md`
- Prior art: Go's owned backend (safepoints and stack maps as the motivation),
  Zig's self-hosted backend, Cranelift (fast-tier philosophy)
