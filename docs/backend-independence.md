# Toolchain independence — architecture tracker

Updated: 2026-08-05.

This document is the **living tracker** for Sailfin's long arc away from a
borrowed toolchain: which parts of the path from source text to a running
process Sailfin owns, which it rents, and what owning each remaining piece
actually buys. It exists because that arc spans years and several SFEPs, and
because the vocabulary it introduced ("Axis 3", "seal-sufficient") is cited
across the repo and needs one definition site.

**It is not a proposal and not a schedule.** Three neighbours own those jobs:

| Question | Authority |
|---|---|
| What should we own, and what is the provider boundary? | **SFEP-0066** — Codegen Provider Ownership (normative) |
| What ships today? | `docs/status.md` |
| What is the runtime enforcement this enables? | **SFEP-0016** — the capability seal |
| When does any of it happen? | Linear Initiatives and Projects |

This file replaces the surveying half of the retired SFEP-0015. Its normative
content moved to SFEP-0066; its Typed SSA v0 contract moved to SFEP-0059 §10.

---

## 1. The three axes

"Make Sailfin self-sufficient" names three orthogonal conquests. Conflating them
produces confused roadmaps, so they are numbered and the numbers are load-bearing
in citations across the repo.

| Axis | Goal | State |
|---|---|---|
| **1 — C-source elimination** | No `.c` in the runtime; every line we author is Sailfin | **Done.** `runtime/native/` deleted (SFEP-0025) |
| **2 — Toolchain independence** | No borrowed toolchain in the codegen and link path | **Partial.** Link is owned on Linux; assemble is not (§2) |
| **3 — libc independence** | Reach the kernel directly, not through libc | **Primitive shipped, consumer unwritten** (§2) |

Axis 1 finished on its own terms and deliberately kept libc: SFEP-0025's contract
was "every line of source we author is Sailfin; platform syscalls are reached via
`extern fn`." That was the right call for getting off C, and it is **no longer
adequate as standing guidance.** The runtime now carries **528 `extern fn`
declarations across 46 files** under `runtime/`. SFEP-0060 partitions that surface
and finds only ~30 are effect-bearing kernel entries — so Axis 3 does not require
reimplementing libc, but it does require that those ~30 stop being ambient.

> **Terminology collision.** SFEP-0040 §38 uses "Axis 2" for a different thing
> (dependency dedup in the artifact cache). Axis numbers in this file always mean
> the table above. Cite them as "Axis 2 (toolchain independence)" where context
> is thin.

Two further terms are defined here because the rest of the repo cites them:

- **Track 8 — Native Backend.** The historical track label for Axis 2 work in
  the pre-Linear build-architecture registry (SFEP-0006). Retained only for
  reading old citations; new work is scoped by Linear Project.
- **Seal-sufficient** vs **perf-parity** backend. See §5 — this split is the
  single most important distinction in the whole arc, and §6 corrects what the
  seal-sufficient target is actually *sufficient for*.

---

## 2. Role ownership today

The honest unit of accounting is not "do we own the backend" but "who performs
each role." Measured against the tree on 2026-08-05:

| Role | Owner today | Evidence |
|---|---|---|
| Lex / parse / typecheck / effect-check | **Sailfin** | `compiler/src/` |
| Mid-level IR | **Split.** `.sfn-asm` is the live artifact; typed SSA exists but is off the build path | `native_ir.sfn` (342); `typed_ssa.sfn` (1160) + `_verify` (993) + `_render` (366) + `_produce` (284) |
| Instruction selection, register allocation, optimization | **LLVM** | `compiler/src/llvm/` — 137 files, 62,830 lines of textual-IR printer |
| Assemble (`.ll` → `.o`) | **clang, 100%** | `compiler/src/build/clang_argv.sfn` |
| Link | **Sailfin on Linux x86-64/aarch64**, clang elsewhere | `compiler/src/build/direct_link.sfn` (339) |
| Raw syscall emission | **Sailfin primitive, no consumer** | `compiler/src/llvm/syscall.sfn` (156) |
| Platform access | **libc/POSIX via `extern fn`** | 528 `extern fn` under `runtime/` |
| TLS / crypto | **Sailfin (native TLS 1.3, SFEP-0036/SFEP-0048, SFN-341)** | `runtime/sfn/platform/tls_record.sfn` |

Three entries in that table are routinely misread, so they are stated plainly:

**Link is already ours on tier-1.** `resolve_direct_ld_lld` builds a bare
`ld.lld` invocation — CRT objects, `-dynamic-linker`, search dirs, libc tail — with
no clang in the argv, and `LlvmTextBackend.link` tries it *first*. It is gated on
target OS, arch, `SAILFIN_LINKER`, `ld.lld` on `PATH`, and every CRT object being
present on disk; any miss falls back to clang with a traced reason, never
silently. This means the frequently repeated claim "Sailfin shells out to clang to
produce a binary" is now wrong for the tier-1 target.

**The remaining clang role is assemble, and dropping it does not drop LLVM.**
Every `.ll` → `.o` still goes through `clang -c`. Because what Sailfin owns is a
textual-IR *printer* and not a code generator, the only seam that exists without
linking LLVM as a library is textual assembly — which means the next step
consumes the output of `llc -S`. That trades the clang *driver* for another LLVM
*tool*. It is real progress on hermeticity and on the assembler/object-format
muscle; it is not toolchain independence, and SFEP-0066 records the distinction
so nobody reports it as one.

**The raw-syscall primitive already ships.** `llvm/syscall.sfn` recognises
`syscall1`..`syscall6` and emits a register-constrained
`call i64 asm sideeffect "syscall"` on Linux x86-64, contract-gated by
`syscall_contract_error` to exactly one permitted caller module:
`runtime/sfn/platform/syscall_linux.sfn`. **That file does not exist.** So Axis 3
is blocked on writing a runtime body, not on owning a backend — see §6.

---

## 3. Why own it at all

Compile speed is the shallow answer, and a real one: LLVM dominates build cost in
any Clang/Rust-shaped toolchain, and a bespoke fast path is how Go gets
sub-second iteration. But the durable reasons tie to the three pillars.

1. **Concurrency will eventually demand backend control.** Threads run fine on
   LLVM plus pthreads. Green threads, growable stacks, GC safepoints, and
   preemption points require codegen and scheduler to co-design stack maps and
   safepoint placement, which cannot be done cleanly through stock LLVM. Go owns
   its backend specifically for this. This is the load-bearing long-term
   argument: concurrency is what turns a native backend from "nice" into
   "structurally necessary."
2. **Auditability to the metal.** Effect and capability metadata currently stops
   at the `.ll` line and is handed to an opaque C++ toolchain. Owning lowering
   lets it survive into the object file — effect-tagged binaries,
   capability-aware linking. This is a genuine gap in the prior art: the static
   effect systems (Koka, Flix, Effekt) stop at the type level and are defeated by
   FFI, and WASI enforces at a coarse VM boundary rather than in the object file.
   Note carefully what this is worth: **auditability, not enforcement.** §6.
3. **Hermeticity and reproducibility.** Resolving whatever `clang` sits on `PATH`
   is a distribution and determinism liability. One self-contained binary with
   `GOOS/GOARCH`-style cross-compilation is a story we can sell, and it is what
   CLAUDE.md's "pure Sailfin toolchain" end-state actually requires.

---

## 4. Honest costs

1. **We have an IR printer, not a code generator.** Instruction selection,
   register allocation, and the optimizer are greenfield. "Drop LLVM" is mostly
   new code, not a refactor.
2. **Multi-arch, multi-format slog.** x86-64 and aarch64 each need isel, regalloc,
   and an ABI (SysV / AAPCS / Win64), plus ELF/Mach-O/COFF encoders, DWARF, and
   unwind tables.
3. **Lost for free:** LLVM's sanitizers, LTO, PGO, and the whole optimization
   pipeline. Keeping LLVM as the release-mode provider is what preserves these,
   which is why the end state is two providers rather than a migration.

---

## 5. Seal-sufficient vs perf-parity

The pre-LLM tooling literature (Go, Zig's self-hosted backend, Cranelift) treated
a native backend as one decade-scale arc. That framing conflates two targets with
very different risk profiles, and the split is the reason this work is
approachable at all:

- A **seal-sufficient** backend is correct, carries capability metadata through
  lowering, and emits no un-gated syscall. It is not perf-competitive. It has a
  cheap correctness oracle — differential testing against the existing LLVM
  backend on the same source fixtures — which makes it agent-amenable and
  plausibly a quarters-scale effort.
- A **perf-parity** backend matches LLVM's `-O2`. This is the genuine long tail
  and the part agentic work helps with least, because the wins are whole-program
  interaction effects with no per-unit oracle to iterate against
  (`docs/strategy/decision-brief.md` §6, oracle availability). It is a
  general-purpose-language competitiveness requirement, not a seal requirement.

LLVM stays the release-mode optimizer indefinitely. "Independence" means *not
dependent*, not *absent*.

---

## 6. What each conquest buys — and the correction

The retired SFEP-0015 and the pre-2026-08 text of SFEP-0016 both asserted a
strict chain: own the backend, *then* own the syscall layer, *then* the seal
becomes buildable. Grounded against the tree, **that ordering is wrong**, and the
error mattered because it put the longest pole in front of the shortest.

The seal's enforcement needs exactly three things:

1. no raw syscall reachable outside the compiler-owned stub — a **linker
   admission** concern (SFEP-0016 §3.4) plus a scan;
2. the manifest sealed into the artifact — a **section-writing** concern;
3. a `-nostdlib` link with no ambient libc — a **driver and runtime** concern.

None of the three requires Sailfin to perform instruction selection. And the
evidence is in the tree: `llvm/syscall.sfn` already emits raw syscalls **through
LLVM inline asm**, gated to a single permitted runtime module. The owned syscall
layer is therefore reachable on the LLVM backend today, and is blocked only on
`runtime/sfn/platform/syscall_linux.sfn` being written.

So the accurate accounting is:

| Conquest | Buys the seal | Buys otherwise |
|---|---|---|
| Owned link (Axis 2, done on tier-1) | the admission rule has somewhere to live | hermeticity, determinism |
| Owned syscall layer (Axis 3) | **the enforcement chokepoint** | static binaries |
| `-nostdlib` static link | the *fully sealed* claim | true hermeticity |
| Native backend, seal-sufficient | metadata survives lowering — **auditability** | independence from `llc` |
| Native backend, perf-parity | nothing | competitiveness |

The native backend is an **enhancement** to the seal, not a prerequisite of it.
It remains worth doing for §3's reasons — most durably concurrency — and it can
now be paced on compile-latency and hermeticity merits instead of being scheduled
as a blocker for something it does not block.

---

## 7. Remaining stages

Each is independently valuable and none needs a flag day. This is a dependency
sketch, not a schedule; Linear owns sequencing.

- **Own the link** — *done on Linux x86-64/aarch64.* macOS and Windows keep the
  clang path until their object/startup/library contracts have dedicated work.
- **Make typed SSA load-bearing** — the model, verifier, and renderer exist; the
  producer emits signatures only and nothing consumes it. SFEP-0059 owns this,
  including the normative contract (§10 there). Worth doing even if a native
  backend never ships: it de-strings the LLVM path and gives the effect and
  ownership analyses a real substrate.
- **Own the assembler and object emission** — an x86-64 encoder plus an ELF
  writer, consuming textual assembly. Establishes the assembler/object-format
  muscle without isel or regalloc risk. Note the `llc` wrinkle in §2.
- **Own the syscall layer** — write `runtime/sfn/platform/syscall_linux.sfn`
  against the shipped primitive. SFEP-0060 owns the design. Independent of the
  items above.
- **Native fast dev backend** — `typed SSA → naive-but-fast machine code → ELF`,
  debug builds only. Steal Cranelift's philosophy; do not compete with LLVM's
  optimizer. `--release` stays on LLVM.
- **Perf tail** — co-designed with the concurrency runtime (safepoints, stack
  maps, escape analysis feeding the arena allocator). Post-1.0.

### The Cranelift question, answered

Whether to bind Cranelift instead of building from scratch was an open question
in SFEP-0015 §11. SFEP-0016 §3.4 answers it: Cranelift is Rust, so its output is
a **digest-vetted foreign object** under the link-time admission rule — part of
the trusted computing base, and permanently incapable of yielding a *fully
sealed* binary. Binding it would also trade LLVM-dependence for
Cranelift-dependence plus an FFI surface. It is ruled out for the tier-1 sealed
path; it remains a legitimate reference for *design* philosophy.

### The LLVM C-API question

Binding the LLVM C-API to eliminate the textual round-trip is the marquee
near-term latency play, and it pins Sailfin to a specific LLVM version. Under
SFEP-0020's capsule graph it is simply a second provider behind
`sfn/codegen-llvm`, so it does not conflict with a native provider — but it
deepens the dependency this arc exists to remove, and it should not be
prioritised ahead of the items above. SFEP-0066 records the provider boundary
that keeps the option open.

---

## 8. References

- **SFEP-0066** — Codegen Provider Ownership (the normative successor to the
  retired SFEP-0015)
- **SFEP-0016** — The Capability-Sealed Runtime (what independence is *for*)
- **SFEP-0059** — Typed SSA Activation, including the normative v0 contract (§10)
- **SFEP-0060** — The Owned Syscall Layer (Axis 3)
- **SFEP-0020** — Role-Oriented Compiler Capsules (the provider seam)
- **SFEP-0025** — Native Runtime Architecture (Axis 1, and the `extern fn`
  contract this file amends as standing guidance)
- **SFEP-0048** — Native crypto + TLS (removes the OpenSSL link exception)
- **SFEP-0006** — Unified Build Architecture (the historical Track registry)
- `docs/strategy/decision-brief.md` — positioning and oracle availability
- `docs/status.md` — shipped state
- Retired: `docs/proposals/archive/0015-llvm-independence.md`
