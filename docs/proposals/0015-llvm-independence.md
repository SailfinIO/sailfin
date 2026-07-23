---
sfep: 15
title: "Toolchain Independence — Sailfin-Native Backend"
status: Accepted
type: runtime
created: 2026-06-05
updated: 2026-07-23
author: "agent:compiler-architect"
tracking: "#1640, #1641"
supersedes:
superseded-by:
graduates-to: reference/runtime-abi.md
---

# Proposal: Toolchain Independence — A Sailfin-Native Backend

**Date:** 2026-06-05 (status updated 2026-07-23)
**Author:** Compiler architect (design)
**Status:** **Split status.** The *seal-sufficient* backend (Axis 2 — correct +
metadata-carrying + syscall-gating) is now on the **1.0 critical path** as a
prerequisite of the capability seal (epic #1640, child of #1639); the owned
syscall layer (Axis 3) likewise (epic #1641). The *perf-parity* backend (matching
LLVM's optimizer) remains a **post-1.0 long tail** — see §5. Stage 0 is shipped:
the compiler has a `Backend` seam, but `LlvmTextBackend` remains its sole
implementation. The seal-sufficient implementation work is prioritized in the
Linear project **Seal-Sufficient Native Backend**.
**Companion docs:** `docs/proposals/0016-capability-sealed-runtime.md` (the *why* —
what this independence is ultimately for), `docs/proposals/0006-build-architecture.md` (perf
analysis + Track registry, #339), `docs/proposals/0025-native-runtime-architecture.md`
(C→Sailfin runtime migration and architecture),
`site/src/content/docs/docs/reference/runtime-abi.md` (target ABI).

> **Why this doc exists.** Sailfin's self-hosting story currently stops at the
> `.ll` line: the compiler emits textual LLVM IR and shells out to `clang` to
> turn it into a binary. This proposal explores what it would take to own the
> last mile — codegen, assembly, and linking — so the toolchain is no longer
> dependent on LLVM/clang, the way Go owns its backend. It is a **long-term
> health and performance** bet, deliberately separate from the completed
> C-source runtime rewrite (which kept LLVM and libc). The accepted design is
> now an active planning direction: Stage 0 has shipped, while the remaining
> seal-sufficient work is tracked as a Linear Project. The rest is *not* the
> single decade-scale arc the pre-LLM tooling literature
> assumed — see §5, which splits a **seal-sufficient backend** (correct +
> metadata-carrying + syscall-gating, plausibly compressible to quarters with
> agent-assisted work and a differential-testing oracle) from a **perf-parity
> backend** (matching LLVM's optimizer — the genuine long tail, off the critical
> path for the capability seal).

---

## 1. TL;DR

- The LLVM/clang process boundary is centralized behind
  `compiler/src/backend.sfn`: `LlvmTextBackend` assembles textual `.ll` with
  `clang -c` and invokes `clang` as the final linker driver for both programs
  and tests. Stage 0 removed direct driver coupling, but it did not remove a
  toolchain dependency.
- What Sailfin *owns* today is an LLVM-IR **printer** (the ~61k-line
  `compiler/src/llvm/` subtree), not a code generator. Instruction selection,
  register allocation, and optimization are all LLVM's. The hard 80% of a
  backend is the part we have never written.
- **Independence is three independent conquests, not one:** (A) a native
  **codegen** backend, (B) **object emission + linking**, (C) optionally a
  **syscall layer** to drop libc. They can be tackled in any order and each is
  independently valuable.
- The winning architecture is **two backends behind one interface** — a
  cranelift-class fast backend for `sfn run`/debug builds (Go-speed iteration),
  LLVM retained for `sfn build --release` (max runtime perf). This is a strict
  superset: we never surrender LLVM's optimizer, we stop paying for it during
  iteration.
- This proposal is in **direct tension with #347 (Track 6 — LLVM C-API
  binding)**, which deepens LLVM coupling for a near-term perf win. §6 reconciles
  them: behind a `Backend` interface, Track 6 becomes "the optimized LLVM
  backend impl" and a native backend is a second impl. The tension is real but
  the abstraction dissolves it.

---

## 2. Three axes people conflate

"Make Sailfin self-sufficient" actually names three orthogonal axes. Conflating
them produces confused roadmaps. This proposal is **only** about Axis 2.

| Axis | Goal | Owner today | Status |
|---|---|---|---|
| **1. C-source elimination** | No `.c` in the runtime; every line we author is Sailfin | (was `runtime/native/src/*.c`) | **Done** — `runtime/native/` deleted (#390, #965, #822) |
| **2. Toolchain independence** | No LLVM/clang in the codegen + link path | `clang` + LLVM (the `.ll` printer feeds it) | **Seal-sufficient slice now 1.0-critical** (#1640); perf-parity stays post-1.0 |
| **3. libc independence** | Talk to the kernel directly, not through libc | libc/POSIX via `extern fn` | **Now 1.0-critical** for the seal's enforcement chokepoint (#1641) |

Two clarifications that matter for alignment:

- **The runtime rewrite (Axis 1) keeps LLVM and libc by design.**
  `docs/proposals/0025-native-runtime-architecture.md` states the contract explicitly: *"Every line of
  source code we author is Sailfin. Platform syscalls are reached via `extern fn`
  declarations … the compiler emits LLVM `declare` directives; the linker
  resolves them against libc, libpthread."* Porting the C runtime to Sailfin
  does **not** advance Axis 2 — the ported Sailfin code still lowers to LLVM IR
  and still calls libc. This is correct and should not change; Axis 1 must finish
  on its own terms.
- **Axis 3 (drop libc) is what makes Go *Go*.** Go's hermeticity comes from its
  own per-arch syscall stubs, which is why its binaries are truly static.
  Dropping clang but still dynamically linking `libc.so` is only half the Go
  story. Axis 3 is the deepest piece — and, since the capability seal became a
  1.0 GA blocker (#1639), no longer the *least urgent*: it is the single
  enforcement chokepoint the seal gates against (epic #1641). It is sketched in
  §8 Stage 4; the "optional" framing there predates the seal decision and is
  superseded for the tier-1 GA target.

---

## 3. Current dependency map (grounded)

| Layer | What it is today | Surface |
|---|---|---|
| **`.sfn-asm` native IR** | Structured *high-level* IR — `If/Else/For/Match/Try`, expressions stored as **opaque strings**. No SSA, no basic blocks, no registers. Closer to a serialized mid-level AST than a compiler IR. | `compiler/src/native_ir.sfn` (~310 lines) |
| **LLVM lowering** | The real backend: 99 files translating `.sfn-asm` → genuine **SSA LLVM IR text** (`phi`, `alloca`/`load`/`store`). LLVM types (`i8*`, `i64`, `{i8*, i64}`) and instructions are hardcoded **string templates** throughout. | `compiler/src/llvm/` (~61k lines) |
| **clang** | Two remaining hats: assemble `.ll`→`.o` (`clang -c`) and drive the final link (`clang … -o`), implicitly selecting platform startup objects and libraries. | `compiler/src/backend.sfn`, `compiler/src/build/clang_argv.sfn` |
| **Runtime** | Runtime implementation is Sailfin-native; the former C runtime is deleted. Platform access still crosses `extern fn` into libc/POSIX, so Axis 1 is complete while Axis 3 remains open. | `runtime/prelude.sfn`, `runtime/sfn/` |
| **IR validation** | `llvm-as` / `clang -c -emit-llvm` cascade as a `.ll` sanity check. | `compiler/src/emit_helpers.sfn` |
| **Target awareness** | Build-target conditioning now threads target OS/triple and linker flags through the backend, including the MSVC Windows path. The LLVM-text lowering remains strongly coupled to LLVM data-layout and ABI spellings. | `compiler/src/build/target.sfn`, `compiler/src/backend.sfn`, `compiler/src/llvm/` |

**The architecturally significant finding:** there is no clean seam to slot a
native backend into. `.sfn-asm` is too high-level (opaque string expressions),
and LLVM knowledge is smeared across 85 files as string templates. A native
backend cannot plug in below a tidy IR — **that seam does not exist yet**, and
creating it (§8 Stage 1.5) is the foundational prerequisite that also benefits
the LLVM path.

---

## 4. Why — the long-term health & performance argument

The shallow reason is compile speed: LLVM dominates build cost in any
Rust/Clang-style toolchain, and a bespoke fast backend is how Go gets sub-second
iteration. That alone serves the `docs/proposals/0006-build-architecture.md` <5-min self-host
target. But the durable reasons tie to Sailfin's three differentiators:

1. **Concurrency (pillar 3) will eventually *demand* backend control.** The M4
   scheduler epic (#965) plans structured concurrency on LLVM + pthreads. That
   gets you threads, but green threads / growable stacks / GC safepoints /
   preemption points require the codegen and scheduler to co-design stack maps
   and safepoint placement — which you cannot do cleanly through stock LLVM.
   Go owns its backend *specifically* for this. This is the load-bearing
   long-term argument: concurrency is the feature that turns a native backend
   from "nice" into "structurally necessary."
2. **Effects + capabilities (pillars 1 & 2) become auditable to the metal.**
   Today the differentiators are reasoned about in Sailfin and then handed to an
   opaque C++ toolchain. Owning the backend lets effect/capability metadata
   survive into the object file — effect-tagged binaries, capability-aware
   linking. LLVM structurally cannot give you this; it would be a genuine
   differentiator no other systems language has.
3. **Hermeticity & reproducibility.** Shelling out to whatever `clang` lives on
   `$PATH` is a reproducibility and distribution liability (and a determinism
   hazard — see Track 2). One self-contained binary plus `GOOS/GOARCH`-style
   cross-compile (vs. today's single Windows-cross path that needs `llvm-link` +
   MinGW) is a story we can sell, and it aligns with CLAUDE.md's stated end-state
   ("pure Sailfin toolchain — no Python, no C runtime, no downstream fixup
   scripts").

---

## 5. Honest costs

1. **We have an IR printer, not codegen.** The hard 80% (isel, regalloc, the
   optimizer) is greenfield. "Drop LLVM" is mostly *new code*, not a refactor.
2. **Multi-arch, multi-format slog.** x86-64 + aarch64 each need instruction
   selection, register allocation, and ABI (SysV / AAPCS / Win64), plus
   ELF/Mach-O/COFF encoders, DWARF debug info, and unwind tables (`.eh_frame`).
3. **Perf parity with `-O2` is a long tail — but it is not the gate.** Matching
   LLVM's optimizer throughput is genuinely hard and should not be promised as
   near-term. The pre-LLM tooling literature (Go, Zig's self-hosted backend,
   Cranelift) treated the *whole* effort as a decade-scale arc; that framing
   conflates two distinct targets. A **seal-sufficient backend** — correct,
   carrying capability metadata through lowering, gating syscalls, but *not*
   perf-competitive — is the target on the critical path for the capability seal
   (`capability-sealed-runtime.md`), and it is agent-amenable and de-riskable by
   differential testing against the existing LLVM backend (a cheap correctness
   oracle), which makes it plausibly a quarters-scale effort, not a decade. The
   **perf-parity backend** is the long tail, the part agentic work helps least
   with, and it is off the seal's critical path — required only for
   general-purpose-language competitiveness.
4. **Lost for free:** LLVM's sanitizers, LTO, PGO, and the entire optimization
   pipeline. The two-backend design (§6) is what keeps these available.

---

## 6. Reconciling with #347 (Track 6 — LLVM C-API binding)

This is the one place the existing roadmap pulls the other way, so address it
directly. #347 proposes binding the **LLVM C-API** via `extern fn` to eliminate
the textual-IR round-trip (`.ll` → `llvm-as` → `clang -c` → `clang` link → 1
in-process step). It is the marquee near-term codegen perf play — and it would
**pin Sailfin's ABI to a specific LLVM version (18+)**, the strongest existing
statement of "we are an LLVM compiler."

A native backend and a C-API binding look like mutually exclusive bets on the
same subsystem. **A `Backend` interface dissolves the conflict:**

```
interface Backend {
    fn lower(module: NativeModule) -> ObjectArtifact ![io];
    fn link(objects: ObjectArtifact[], out: string, libs: string[]) -> int ![io];
}
```

- `LlvmTextBackend` — today's `.ll` + `clang` path (the current behavior).
- `LlvmApiBackend` — #347's C-API binding. **Track 6 becomes "a faster LLVM
  backend impl," not a competing direction.** It ships and pays off immediately.
- `NativeBackend` — the long-horizon Sailfin-native codegen (§8 Stage 3+).

Decoupling first (§8 Stage 0) is therefore strictly compatible with #347:
whoever lands the C-API binding lands it as a `Backend` impl, and the native
backend arrives later as a third impl selected by build mode. **Recommendation:
do not block #347; require only that it land behind the `Backend` interface so
it doesn't re-hardcode LLVM assumptions across the driver.**

---

## 7. Relationship to existing tracks & milestones

| Existing work | Relation to this proposal |
|---|---|
| **#390 — M3: delete C runtime** (Axis 1) | Orthogonal but directionally aligned — kills the *C runtime* dependency, says nothing about the LLVM backend. Should finish independently. |
| **#965 — M4: scheduler/concurrency** (Axis 1) | Orthogonal short-term (runtime-in-Sailfin), but is the feature that ultimately *motivates* a native backend (§4.1). |
| **#763 — pointer-read intrinsics + errno** | Cheap reusable primitives lowered straight to LLVM `load`. A native backend would re-own them; no conflict. |
| **#343 — lld/mold linker** (Track 3) | **This proposal's Stage 1 in miniature.** Swaps the linker behind clang's driver. Natural precursor to owning the link entirely. |
| **#513 — Makefile slim-down** (Track 3) | Orthogonal but a useful precursor — it centralizes toolchain invocation into `sfn` subcommands, which is exactly the surface a native backend must own (esp. Phase 2, `sfn build --target=`). |
| **#347 — LLVM C-API binding** (Track 6) | Direct tension; reconciled in §6 via the `Backend` interface. |

**Track placement:** This is **Track 8 — Native Backend**. The seal-sufficient
slice is a 1.0 critical-path Project under the **Capability-Sealed Runtime**
Initiative; only optimizer/performance parity remains post-1.0.

---

## 8. Staged roadmap

Each stage is independently valuable and shippable. None requires a flag day.

- **Stage 0 — Decouple — shipped (#1112 / PR #1687).** Hide `process.run(["clang", …])`
  behind a `Backend` interface with `LlvmTextBackend` as the sole impl. Zero
  behavior change, but the driver stops hard-coding clang. This seam is live in
  `compiler/src/backend.sfn` and unblocks later backends from re-coupling the
  driver.
- **Stage 1 — Own the link.** Replace clang-as-linker with a direct `ld`/`lld`/
  `mold` invocation. #343/PR #1128 shipped linker auto-selection *behind clang*
  and is only a precursor; clang still supplies startup objects, platform
  libraries, and argument translation. SFN-453 isolates the two remaining
  clang roles by preassembling every textual-LLVM input and making
  `Backend.link` object-only. A direct Linux x86-64 link is the next production
  slice.
- **Stage 1.5 — Introduce a real mid-level SSA IR.** Typed values, basic blocks,
  virtual registers, between `native_ir` and codegen. **The foundational
  prerequisite that pays off regardless** — it also de-strings the LLVM path and
  gives the effect/ownership analyses a proper substrate. Likely the single most
  valuable piece of work in this whole arc even if Stage 3 never ships.
- **Stage 2 — Own object emission.** An ELF writer first (CI is Linux x86-64);
  LLVM still does instruction selection. Establishes the assembler/object-format
  muscle without the regalloc/isel risk.
- **Stage 3 — Native fast dev backend.** `mid-IR → naive-but-fast machine code →
  ELF`, **debug builds only**. Highest ROI, lowest risk: Go-speed `sfn run`
  without surrendering release perf. Steal Cranelift's philosophy (fast, simple,
  good-enough), don't compete with LLVM's optimizer. `sfn build --release` stays
  on LLVM.
- **Stage 4 — Syscall layer + perf tail.** Two threads, now split by priority:
  (a) the **owned syscall layer (Axis 3)** to drop libc on tier-1 — **1.0-critical**
  for the capability seal (#1641), not optional; (b) growing the native optimizer
  for the cases that matter, co-designed with the concurrency runtime (safepoints,
  stack maps, escape analysis feeding the arena allocator) — the **post-1.0** perf
  tail. LLVM becomes optional, then legacy.

---

## 9. Non-goals

- **Not** removing LLVM. The two-backend design keeps LLVM as the release-mode
  optimizer indefinitely; "independence" means "not *dependent*," not "absent."
- **Not** *all* of this is post-1.0 anymore. The seal-sufficient backend (#1640)
  and the owned syscall layer (#1641) are now on the 1.0 critical path as
  prerequisites of the capability seal (#1639). The **perf-parity** backend below
  is the part that stays post-1.0.
- **Not** matching `-O2` throughput in the native backend for 1.0. Perf parity is
  the post-1.0 long tail; the 1.0 job is a *correct, metadata-carrying,
  syscall-gating* backend, not beating LLVM at optimization. LLVM stays the
  release-mode optimizer indefinitely (the two-backend design holds).
- **Not** dropping libc everywhere as a precondition. Axis 3 drops libc on the
  **tier-1** target (Linux x86_64) for the seal; macOS/Windows keep a minimal
  vendor-library shim the gate still mediates (no stable raw-syscall ABI there).

---

## 10. Open questions / decision points

1. **Native IR or extend `.sfn-asm`?** A new typed SSA IR (Stage 1.5) is cleaner
   but is real work; the alternative is incrementally lowering `.sfn-asm`'s
   string expressions. Recommendation: new IR — the string-expression model is
   a dead end for codegen.
2. **First native target:** x86-64 (CI host, most users) vs. aarch64 (Apple
   silicon dev machines, and the platform where effect enforcement is currently
   *partial* per #613). Likely x86-64 first.
3. **Borrow Cranelift vs. build from scratch?** Cranelift is Rust; binding it
   would trade LLVM-dependence for Cranelift-dependence (and FFI), which only
   half-serves the dogfooding goal. A from-scratch Sailfin backend is the purist
   path and the better long-term-health story, at higher cost.
4. **How much does the M4 scheduler design need to know about Stage 3+ now?**
   If concurrency ships on LLVM first and a native backend arrives later, the
   safepoint/stack-map ABI may need to be retrofitted. Worth a forward-looking
   note in #965 even though the work is far off.

---

## 11. Recommended next step

Run two ordered workstreams under the **Seal-Sufficient Native Backend** Linear
Project:

1. **Remove clang as the Linux x86-64 linker driver.** First pin the exact
   object/startup/library contract, then invoke the selected linker directly
   behind the existing `Backend` seam. Keep macOS and Windows on the current
   path until their contracts have dedicated leaves.
2. **Build the typed SSA foundation.** Land a small, verified IR core with
   capability/effect metadata before porting source constructs or attempting
   machine code. Follow with differential lowering slices against
   `LlvmTextBackend`.

Do not prioritize the LLVM C-API backend ahead of these slices: it improves
compile latency but deepens the dependency this Project exists to remove.
