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

## 9. Typed SSA v0 contract (normative)

This section fixes the Stage 1.5 handoff. In this section, **must** and **must
not** are requirements on every producer, verifier, transformation, renderer,
and backend that claims typed-SSA v0 support.

Typed SSA sits between parsed `.sfn-asm` and backend-specific lowering:

```text
.sfn-asm -> typed-SSA producer -> verifier -> LLVM or native backend
```

The contract is deliberately smaller than either Sailfin source or LLVM IR. It
represents scalar computation and control flow, carries the security metadata
needed by the capability seal, and leaves target layout and machine operations
to a backend ABI adapter. It contains no LLVM type names, opcodes, attributes,
data-layout strings, or textual instruction fragments.

### 9.1 Ownership and identities

A `Module` owns, directly or through intern tables:

- a module identity and source-capsule identity;
- `Symbol`, `Type`, `EffectSet`, and `CapabilitySet` tables;
- external declarations and defined functions; and
- an optional module capability manifest derived from its entry points:
  `Manifest { entry_points: FunctionId[], effects: EffectSetId,
  capabilities: CapabilitySetId }`.

The following identities are unsigned integer handles, not source names:

| Identity | Scope | Meaning |
|---|---|---|
| `SymbolId` | module | One interned Sailfin semantic name. |
| `TypeId` | module | One structurally interned type. |
| `EffectSetId` | module | One canonical set of effect atoms. |
| `CapabilitySetId` | module | One canonical set of capability atoms. |
| `FunctionId` | module | One declaration or definition. |
| `BlockId` | function | One basic block. |
| `ValueId` | function | One function parameter, block parameter, instruction result, or constant result. |

An identity must resolve in its owning scope and must not be reused for a
different entity. A backend must not infer semantics from the numeric value of
an identity. Moving an entity between modules or functions therefore requires
remapping every identity it owns or references.

Symbols are canonical UTF-8 strings interned by exact byte equality. They name
Sailfin semantics such as effects and capability kinds; they are not mangled
linker symbols or fragments of backend syntax.

The module, function, block, and instruction containers are ordered sequences.
Maps may accelerate lookup, but are not the semantic owner and must not decide
rendering or traversal order.

### 9.2 Target-neutral v0 types

Each `TypeId` names exactly one of:

```text
Unit
Bool
Int { width: 8 | 16 | 32 | 64, signed: boolean }
Float { width: 32 | 64 }
Pointer { pointee: TypeId?, address_space: integer }
```

`Unit` has no runtime value. `Bool` is a logical truth value; its storage width
is selected by the ABI adapter. Integer widths and signedness are semantic.
Floating-point values use IEEE-754 binary32 or binary64 semantics. A null
`pointee` denotes an opaque pointer. Address space zero is the ordinary Sailfin
process address space; other address spaces are reserved until a later contract
defines them.

Types are interned structurally: equal definitions in one module must have the
same `TypeId`, and unequal definitions must have different IDs. Source aliases
such as `int` are resolved before typed SSA and do not create distinct types.
Backend spellings such as `i64`, `double`, or `ptr` are not valid type
definitions in this IR.

Aggregates, slices, closures, function values, memory operations, exceptions,
and ownership operations are outside v0. A later version may add them without
changing the identity, block, metadata, or verifier rules defined here.

### 9.3 Functions, blocks, and values

A function declaration contains:

```text
Function {
    id: FunctionId
    symbol: SymbolId
    parameters: TypeId[]
    result: TypeId
    effects: EffectSetId
    capabilities: CapabilitySetId
    linkage: Internal | Exported | External
}
```

A definition adds an ordered, non-empty block sequence. Its first block is the
entry block. The entry block parameters are the function parameters, in
signature order; their `ValueId`s are the function's parameter values. An
external function has a declaration and no blocks.

Every non-entry block has zero or more typed block parameters. Branch operands
supply those parameters, replacing backend-specific phi nodes. Block
parameters are defined simultaneously at block entry. Instruction results are
defined after their operands and each result has exactly one `TypeId`. Values
are immutable and have exactly one definition.

### 9.4 Instructions and terminators

The v0 instruction set is:

```text
ConstBool(value) -> Bool
ConstInt(value) -> Int
ConstFloat(bits) -> Float
Unary(op, value) -> scalar
Binary(op, left, right) -> scalar
Compare(predicate, left, right) -> Bool
Call(function, arguments, effects, capabilities) -> scalar-or-Unit
```

`Unary`, `Binary`, and `Compare` use typed-SSA op and predicate enums, not
backend strings. `UnaryOp` contains `Negate`, `BooleanNot`, and `BitwiseNot`;
`BinaryOp` contains `Add`, `Subtract`, `Multiply`, `Divide`, `Remainder`,
`BooleanAnd`, `BooleanOr`, `BitwiseAnd`, `BitwiseOr`, `BitwiseXor`,
`ShiftLeft`, and `ShiftRight`; `ComparePredicate` contains `Equal`, `NotEqual`,
`Less`, `LessEqual`, `Greater`, and `GreaterEqual`. Each case has Sailfin
language semantics for its operand type. v0 adds neither wrapping integer nor
relaxed floating-point operations; either requires a distinct enum case in a
later contract. The verifier rejects an operation whose operand or result types
are not admitted by that enum case. Overflow and floating-point behavior must
not be inferred from a backend default.

`Call` is direct in v0: `function` is a `FunctionId`. Its arguments match the
callee signature exactly. A non-`Unit` call produces one result; a `Unit` call
produces none. Indirect calls and variadic calls require a later IR version.

Every block ends with exactly one of:

```text
Branch(target, arguments)
CondBranch(condition, then_target, then_arguments, else_target, else_arguments)
Return(value?)
Unreachable
```

A terminator is not an instruction and produces no value. No instruction may
follow it. `CondBranch.condition` has type `Bool`. Each branch argument list
matches its target block parameters in arity and type. `Return` has no value
for a `Unit` result and exactly one value of the declared result type otherwise.
`Unreachable` asserts that control cannot continue; it does not excuse invalid
instructions earlier in the block.

### 9.5 Effect, capability, and provenance metadata

Effects and capabilities are semantic data, not comments or backend
attributes. Both are interned canonical sets:

```text
EffectAtom { name: SymbolId }
CapabilityAtom { kind: SymbolId, arguments: MetadataValue[] }
MetadataValue = Bool | Int | String | Symbol
```

Atoms and their arguments use Sailfin semantic names. They must not contain
LLVM syntax or target instruction names. Sets contain no duplicates and are
ordered by the canonical byte encoding of their atoms. An empty set is a valid
interned set.

Metadata attaches at these exact points:

- a function declaration or definition records its transitive effect summary
  and required capability summary;
- every `Call` records the callee effects and required capabilities visible at
  that call site; and
- the optional module manifest records the union selected from designated
  entry points.

Pure scalar instructions and control-flow terminators do not carry effect or
capability sets. Source spans and a producer-defined provenance card may attach
to any function, block, instruction, or terminator for diagnostics, but are
non-semantic and must not affect verification or code generation.

A call's effect and capability sets must be supersets of the referenced
callee's declared sets. A defined function's sets must be supersets of every
call in its body. This permits a producer to carry a conservative summary while
forbidding a backend from seeing less authority than the program requires.

Transformations must preserve security metadata monotonically:

- cloning or moving a call preserves its sets;
- replacing a call preserves supersets of the original sets unless a verified
  analysis recomputes an equal or smaller summary from the new callee;
- merging call paths uses set union;
- splitting a function copies the relevant call metadata and recomputes both
  function summaries before verification; and
- deleting unreachable code may remove its metadata only when the associated
  call is deleted.

No renderer or backend may silently drop these sets. A backend that cannot
consume them must reject the module rather than treating it as unannotated.

### 9.6 Verifier invariants

The typed-SSA verifier runs before any backend and must reject a module unless
all of the following hold:

1. Every ID resolves in the correct owner, all module symbols are unique, and
   all interned types and metadata sets are structurally canonical.
2. Every definition has a valid type; every use refers to one definition in
   the same function; and that definition dominates the use. Block parameters
   dominate their block, including all instructions and its terminator.
3. The entry parameters exactly match the function signature. Every branch
   target exists and every branch argument matches the corresponding block
   parameter in arity and type.
4. Every block has exactly one final terminator and no earlier terminator.
   Every block other than the entry is reachable from a named predecessor;
   unreachable regions are represented with an `Unreachable` terminator, not
   orphan blocks.
5. Each instruction satisfies its operation-specific arity and typing rules.
   Constants fit their declared width, calls match the callee signature, and
   returns match the function result.
6. Call and function effect/capability summaries satisfy the superset rules in
   §9.5, and the module manifest, when present, covers every designated entry
   point.
7. The ordered containers and assigned IDs satisfy the deterministic
   construction rules in §9.7.

Verification is fail-closed and side-effect free. Diagnostics identify the
module, function, block, offending ID, and violated invariant. A failed module
must not reach LLVM rendering, native instruction selection, object emission,
or linking.

### 9.7 Determinism and textual rendering

The producer assigns IDs in one deterministic walk:

1. intern types and metadata by canonical structural encoding;
2. visit functions in `.sfn-asm` declaration order after the existing
   deterministic module merge;
3. visit blocks in structured-lowering order, with the entry first and branch
   successors in source order; and
4. assign `ValueId`s to entry parameters, then block parameters and instruction
   results in block order.

Intern tables render in canonical structural order. Functions, blocks, and
instructions render in their owned sequence. Hash-map iteration, filesystem
enumeration, addresses, thread completion order, and backend-generated names
must not affect IDs or output.

Every implementation provides a canonical UTF-8 debug renderer. It is not an
input language in v0, but identical verified modules must render byte-for-byte
identically, including one `\n` line ending after the final line. The renderer
uses typed-SSA names (`t0`, `v0`, `b0`) and semantic op names, never LLVM
sigils or instruction text. For example:

```text
module demo
type t0 = bool
type t1 = int(signed,64)
effects e0 = {}
capabilities c0 = {}
fn choose(v0:t0, v1:t1, v2:t1) -> t1 effects=e0 capabilities=c0 {
  b0(v0:t0, v1:t1, v2:t1):
    cond_branch v0, b1(v1), b2(v2)
  b1(v3:t1):
    return v3
  b2(v4:t1):
    return v4
}
```

Metadata values use JSON escaping in the renderer. Floating constants render
their exact bit pattern, not a locale-dependent decimal. Rendered IDs follow
the deterministic assignments above and are dense from zero within their
scope.

### 9.8 Target boundary and first target

Typed SSA is target-neutral. It does not contain a target triple, register
class, calling-convention spelling, object format, relocation, or data-layout
string. A backend combines a verified module with a separate target profile and
the runtime ABI.

The first supported native profile is **Linux x86-64, little-endian, SysV
AMD64**. Its ABI adapter maps logical `Bool`, fixed-width scalars, pointers,
function parameters, calls, and returns to the layouts and symbol contracts in
`site/src/content/docs/docs/reference/runtime-abi.md`. That mapping must not
rewrite the typed-SSA module. LLVM lowering is another adapter over the same
contract; LLVM spellings begin only after the verified handoff.

### 9.9 Implementation and differential-testing seams

The next implementation leaf owns four independently testable seams:

1. **Core model and renderer:** module-owned identities, intern tables, scalar
   instructions, terminators, metadata, and canonical debug snapshots.
2. **Verifier:** focused negative tests for every invariant in §9.6, plus
   positive scalar branch/call/return fixtures.
3. **Producer boundary:** a lowering pass from the existing `NativeFunction`
   and string-expression `.sfn-asm` model into verified typed SSA. Unsupported
   constructs fail with a diagnostic; they do not bypass typed SSA or inject
   backend text.
4. **Backend boundary:** LLVM and native consumers accept only a verified
   module plus a target profile. Backend-specific operands, types, and
   instructions are created on the consumer side of this boundary.

The existing LLVM backend remains the differential oracle. Each construct
ported to typed SSA uses the same source fixture to produce:

- canonical typed-SSA output;
- verified LLVM output and program behavior; and
- on Linux x86-64, native output with the same exit status, stdout, stderr, and
  externally visible state.

Tests also compare normalized function and call effect/capability sets before
backend lowering. Backend-specific object bytes, symbol ordering not fixed by
the runtime ABI, debug addresses, timing, and optimization quality are not
differential-equality requirements.

### 9.10 v0 non-goals

Typed-SSA v0 does not:

- replace `.sfn-asm` as the compiler's serialized high-level artifact;
- model aggregates, closures, memory, ownership, exceptions, concurrency,
  indirect calls, or variadics;
- define optimization passes, register allocation, instruction selection,
  object emission, linking, or a textual parser;
- expose LLVM types, attributes, intrinsics, or instruction strings; or
- claim the native backend, capability seal, or typed-SSA implementation has
  shipped.

---

## 10. Non-goals

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

## 11. Open questions / decision points

1. **Borrow Cranelift vs. build from scratch?** Cranelift is Rust; binding it
   would trade LLVM-dependence for Cranelift-dependence (and FFI), which only
   half-serves the dogfooding goal. A from-scratch Sailfin backend is the purist
   path and the better long-term-health story, at higher cost.
2. **How much does the M4 scheduler design need to know about Stage 3+ now?**
   If concurrency ships on LLVM first and a native backend arrives later, the
   safepoint/stack-map ABI may need to be retrofitted. Worth a forward-looking
   note in #965 even though the work is far off.

---

## 12. Recommended next step

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
