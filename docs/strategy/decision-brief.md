# Sailfin — Strategic Decision Brief

**Date:** 2026-06-14 (status update 2026-06-26)
**Status:** Strategic overlay — agent context. Binds the internal vision (the
proposal docs) to the external market. Referenced from `CLAUDE.md`.

> **⚠️ Repositioning (2026-06-26).** The capability-sealed runtime is now a **1.0
> hallmark feature and a hard GA blocker** (epic #1639), not a post-1.0 capstone.
> It delivers pillar 2 (capability security) end-to-end; a compile-time-only check
> erased at codegen does not. **What this changes:** the seal's *scheduling* — it
> is on the 1.0 critical path, pulling backend (Axis 2, #1640) and syscall-layer
> (Axis 3, #1641) ownership with it. **What this does NOT change:** the
> safety-claim discipline below. The seal is still **not enforced today**; "now vs
> later" still distinguishes *compile-time proof (real now)* from *runtime seal
> (built, not yet shipped)*. The brief's "decouple timely AI positioning from the
> seal" argument (Gaps 2–3, §8 fork) still holds as **engineering sequencing** —
> the seal takes real backend+syscall work to build — but it is no longer framed
> as "post-1.0." Read "long-horizon half / deferred / post-1.0 capstone" below as
> "the 1.0 capstone that takes the longest to build."
**Canonical architecture docs (these win on architecture; this brief wins on
market positioning):** `docs/proposals/0016-capability-sealed-runtime.md`,
`docs/proposals/0015-llvm-independence.md`, `docs/proposals/0017-hierarchical-effects.md`,
`docs/proposals/0008-effect-validation.md`, `docs/proposals/0024-model-engines-and-training.md`.

> **What this is.** A strategic overlay for the Sailfin repo, written to be read
> by a Claude Code agent operating in-tree. It does **not**
> restate the internal vision — that already lives, better grounded, in the
> proposal docs below. Its job is to (a) bind the internal vision to the external
> market, (b) name the cross-cutting gaps, and (c) frame the open strategic fork.
> Where this brief and the proposal docs conflict, the proposal docs win on
> architecture; this brief wins on market positioning.
>
> **Canonical internal docs (read these first; do not duplicate them):**
> - `docs/proposals/0016-capability-sealed-runtime.md` — the capstone thesis (effects + capabilities + owned backend + owned syscall layer = a sealed binary). **This is the strategy.**
> - `docs/proposals/0015-llvm-independence.md` — the *how* of backend/syscall ownership.
> - `docs/proposals/0017-hierarchical-effects.md`, `docs/proposals/0008-effect-validation.md` — effect-system depth.
> - `docs/proposals/0024-model-engines-and-training.md` — model-engine surface (relevant to the `![model]` gap below).
> - `CLAUDE.md` — agent operating rules incl. the safety-claim discipline ("nothing is enforced today" unless it is).

---

## 1. How to use this brief (agent instructions)

1. Read the canonical docs above + current repo state (effect checker, `compiler/src/llvm`, `runtime/sfn`, `effect_taxonomy.sfn`, `typecheck_types.sfn`).
2. Audit against Section 6. Return findings before generating a backlog.
3. Generate issues that advance Section 5 and remediate Section 4 gaps, citing files and the one-line strategic rationale per issue.
4. Never make a runtime-enforcement claim that the code doesn't back (the seal is **vision**, not shipped). Preserve the safety-claim discipline.

---

## 2. Ground truth (verified against repo, July 2026)

- **Identity:** "A systems language with compile-time capability enforcement." This is real and shipping, not aspirational.
- **Enforced today (compile time):** `![io]`, `![net]`, `![clock]` are real gates; cross-module effect propagation (`E0402`); capsule capability cross-check via `capsule.toml` (`E0403`); structured diagnostics + fix-its; `sfn check --json` → `sailfin-check/1` envelope for the MCP server.
- **Codegen:** still LLVM (`compiler/src/llvm`). The Stage-0 `Backend` seam is
  merged and `LlvmTextBackend` is the sole implementation; there is no
  production native backend yet.
- **Runtime:** the C→Sailfin migration is complete; `runtime/native/` is deleted.
  AOT-native execution still lowers through LLVM and reaches the platform
  through libc/POSIX externs.
- **Enforcement locus today:** compile-time only. Per `capability-sealed-runtime.md`, the manifest is currently "a lint, not a cage" — erased at codegen. Runtime/syscall enforcement is the **1.0 capstone (GA blocker, epic #1639)** — repositioned from post-1.0 on 2026-06-26 — gated on owning the backend then the syscall layer. Still unenforced today.

**Discipline:** distinguish *compile-time proof* (real now) from *runtime seal* (vision). Never blur them externally.

---

## 3. The thesis

Sailfin owns its stack on purpose, because **you cannot seal a binary you don't own**. The differentiated end-state, per `capability-sealed-runtime.md`: a native binary whose declared capabilities are enforced down to the syscall — proven-safe code runs at full native speed with no gate; code the type system can't see (FFI, plugins, generated/`eval`'d code) hits the owned syscall gate and is refused if it exceeds the grant. Plus the genuinely novel synthesis: **scoped, inherited, revocable capabilities per task** via the structured-concurrency scheduler — effects say *what*, capabilities say *how much*, structured concurrency says *for how long and to whom*. No mainstream language offers this.

> A clarifying distinction: Sailfin's reach-into-untrusted-code story is **its own runtime gate catching in-process foreign/generated code**, not a contract that "sits above and feeds someone else's runtime" by emitting policy for an external enforcer. The emit-to-OPA/WASI/OTel idea survives only as a narrow *cross-process interop* option (Section 7), not the core.

---

## 4. External market reconciliation + gaps

**Market position (corroborates and extends `capability-sealed-runtime.md` §1).** The AI-guardrail market has converged on *runtime* enforcement — sandboxes, microVMs, policy gates (OPA), runtime authorization (Cerbos, CodeIntegrity), and tracing (OpenTelemetry/MLflow). Capability-secure *portable execution* is owned by WASI (security-by-default, but a coarse VM boundary). Compile-time effect systems (Koka, Flix, Effekt — Effekt is capability-based) have the typing rigor but no AI framing, no productization, and static-only guarantees defeated by FFI. **The open lane** is exactly the one your doc names: type-proven *and* runtime-enforced, at native speed, on a runtime you own. That lane is real and currently unoccupied.

**Gap 1 — `![model]` is scaffolded but not live (highest leverage).** `model` is in `effect_taxonomy.sfn` and partially wired in `typecheck_types.sfn`, but there's no call-site detector because no model-invoking surface ships yet. This is the one AI-specific effect, the piece with ~zero prior art, and the literal embodiment of the "why now." It is reachable on the **current LLVM stack** — it needs no backend/seal work. See Appendix A for a scoped issue.

**Gap 2 — the best narrative is hidden.** README / `llms.txt` / site sell "compile-time enforcement, LLVM-native" — the *less* differentiated half. The capstone thesis (the seal; scoped/revocable per-task capabilities; the unoccupied lane) lives only in internal proposals. The positioning essay must surface the capstone, split into a **shippable-now half** (compile-time proof + `![model]`) and a **long-horizon half** (the seal), so the safety-claim discipline holds.

**Gap 3 — sequencing.** The seal is gated on backend+syscall ownership; the *AI-era positioning* (compile-time proof for AI-generated code, model invocation as a tracked effect) is not. Decouple them: capture the timely positioning now on the current stack; let the seal be the long-horizon moat, not the thing the narrative waits on.

---

## 5. Near-term deliverables (all independent of the backend long pole)

1. **Land `![model]` as a live effect** (Appendix A). Highest strategic leverage, no seal dependency.
2. **Surface the capstone thesis publicly** — rework README/site framing to lead with the unoccupied lane, honestly split now/later. Feed `llms.txt` the corrected framing.
3. **Positioning essay** — the capstone thesis, market-aware, now/later split. Names WASI / Capslock / static-only effect systems as the foils your doc already identified.
4. **This brief committed + referenced from `CLAUDE.md`** as agent context.

Activated: prioritize the seal-sufficient backend + syscall ownership after the
Stage-0 backend seam. LLVM performance work that deepens coupling must not
displace these independence slices.

---

## 6. Alignment audit questions

- Is `![model]` a first-class, enforced effect — or still reserved? (Should be the headline AI primitive; currently the least-built.)
- Do effect signatures + capability grants compose across module boundaries and (eventually) per task? (Compositionality is the whole reason to be compile-time.)
- Does codegen *erase* effect/capability metadata, or is there any path to carry it through? (Metadata survival is the seal precondition — `llvm-independence.md` Track 8.)
- Is the public framing (README/site/`llms.txt`) leading with the differentiated capstone, or with the commodity compile-time/LLVM story?
- Does any in-flight work make a runtime-enforcement claim the code doesn't back? (Discipline violation — flag.)
- Does any work chase perf-parity codegen *before* the seal-sufficient backend? (Wrong order if the goal is the trust substrate — see Section 8.)

---

## 7. Cross-process interop (demoted, optional)

For untrusted code running in *other* processes/runtimes (true foreign execution, outside the Sailfin-owned process), the runtime gate doesn't reach. Only there might emitting to OPA/WASI/OTel matter. Treat as a future interop lane, not core, and not before the in-process seal exists.

---

## 8. The fork — and the timeline correction

**Timeline (corrected).** Backend ownership is **not** a fixed decade-scale gate. The pre-LLM tooling literature (Go, Zig, Cranelift) treated a self-hosted backend as a decade-scale arc; agent-assisted compiler work plus a cheap correctness oracle (differential testing against the existing LLVM backend) changes that math. Split it:
- **Seal-sufficient backend** — correct + carries capability metadata + gates syscalls; *not* perf-competitive with LLVM. On the critical path for the trust-substrate thesis. Agent-amenable and **plausibly compressible to quarters**, de-risked by differential testing against the existing LLVM backend (cheap correctness oracle). This is the target that matters.
- **Perf-parity backend** — matching LLVM's optimizer. The genuine long tail, the part agentic work helps least with, and **off the critical path for the seal**. Only required if the goal is general-purpose-language competitiveness.

**Two games:**
- **Trust-substrate / influence (legacy).** Success = the seal exists end-to-end and the constructs (model-as-effect, scoped/revocable per-task capabilities) are real and reachable in the corpus. Needs only the *seal-sufficient* backend. Robust to competitors; risk is obscurity (addressed by Gaps 2–3).
- **Competitive systems language (product).** Success = adoption *and* perf parity. Reintroduces the optimizer tail. Hard, and largely orthogonal to the seal's value.

**Decision (2026-07-23):** commit agent capacity to the seal-sufficient backend
now. Sequence direct-link ownership and a typed metadata-carrying SSA IR before
native machine-code slices; continue to treat perf parity as a separate
post-1.0 game.

---

## Appendix A — Scoped issue: land `![model]` as a live, enforced effect

**Goal.** Promote `model` from reserved-in-taxonomy to a first-class enforced effect, at parity with `![io]`/`![net]`/`![clock]`, with no dependency on backend/seal work.

**Context / files.** `compiler/src/effect_taxonomy.sfn` (already lists `model`), `compiler/src/typecheck_types.sfn` (partial `model` handling + `![model]` capability-gate diagnostic), the io/net/clock call-site detectors (the pattern to mirror), `capsule.toml` capability cross-check (`E0403`, should accept `model`), cross-module propagation (`E0402`, should propagate `model`). Read `docs/proposals/0024-model-engines-and-training.md` for the intended model-invoking surface before fixing entry points.

**Scope.**
1. Define the model-invoking surface (inference/engine entry points per `model-engines-and-training.md`). If no such surface ships yet, land a minimal one behind `![model]` so the detector has real call sites.
2. Add call-site detection mirroring io/net/clock: undeclared model invocation fails the build with a structured diagnostic + fix-it inserting `![model]`.
3. Confirm cross-module propagation (`E0402`) and capsule cross-check (`E0403`) treat `model` identically to existing effects (likely free if the taxonomy is the single source of truth — verify, don't assume).
4. Tests: positive (declared `![model]` compiles), negative (undeclared invocation fails with the new diagnostic), propagation, capsule-surface rejection.
5. Docs: README "Effect system (enforced)" moves `model` from *reserved* to *enforced*; update `llms.txt`.

**Acceptance.** A function invoking a model without `![model]` fails to compile with a fix-it; a capsule using `![model]` outside its declared surface fails with `E0403`; the AI-specific effect is demonstrably live on the current LLVM stack.

**Non-goals.** No runtime/seal enforcement of `![model]` (that's the capstone). No model-engine implementation beyond the minimal surface needed to make the gate real.

> **In-repo note (added on commit, 2026-06-14).** Appendix A's "land a minimal
> model-invoking surface now" pushes against the locked CLAUDE.md principle that
> AI is a post-1.0 `sfn/ai` library concern and the "don't ship unfinished safety
> claims" rule. Per owner decision, the `![model]` work is **architect-gated**:
> whether (and how minimal a surface) to land now is a `compiler-architect`
> design-gate decision before any code, *not* a settled plan. The strategic
> intent (`![model]` is the one AI-native differentiator, cheap on the current
> stack) stands; the scoping does not bypass the design gate.
