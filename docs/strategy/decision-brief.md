# Sailfin — Strategic Decision Brief

**Date:** 2026-07-26
**Status:** Strategic overlay — agent context. Binds the internal vision to the
external market. Referenced from `CLAUDE.md`.

> **This revision supersedes the 2026-06-14 brief in full.** The prior brief's
> positioning — "a systems language with compile-time capability enforcement,"
> with the capability-sealed runtime as the differentiator — is retracted as a
> *headline*, not as engineering. The seal still ships; it is no longer the
> reason Sailfin exists. See §2 for what changed and §9 for the specific claims
> withdrawn. The evidence base for this revision is
> `docs/strategy/market-evidence-2026-07.md`; every empirical claim below cites
> it rather than restating sources.

**Canonical architecture docs (these win on architecture; this brief wins on
positioning):** `docs/proposals/0016-capability-sealed-runtime.md`,
`docs/proposals/0066-codegen-provider-ownership.md`, `docs/backend-independence.md`,
`docs/proposals/0052-ml-acceleration-strategy.md`,
`docs/proposals/0053-shape-typed-tensor-ir.md`, `docs/proposals/0054-low-precision-numerics.md`.

---

## 1. How to use this brief (agent instructions)

1. Read this brief plus `docs/strategy/market-evidence-2026-07.md` before
   generating any roadmap, positioning copy, or issue backlog.
2. Apply the **restriction-vs-power test** (§3) to any proposed feature or
   marketing claim. A feature that only *forbids* something needs a power
   attached or it does not ship as a headline.
3. Never state a guarantee the code does not back. The safety-claim discipline
   (§8) is unchanged and binding.
4. Do not re-derive the market analysis. If a claim here looks wrong, check the
   evidence file's citation and dispute it there.

---

## 2. The headline

> **Sailfin emits proof, not just binaries.**
>
> Every build produces a machine-checked contract about the code — what it can
> reach, what numbers it produces, what it costs to run — and that contract is
> verifiable by someone who does not use Sailfin.

**Calibration — the headline is the target, and the reachable claim today is
weaker by one step.** A stranger can *grade* a kernel against an emitted contract:
the preconditions, postconditions, tolerance, oracle, measurement protocol and
violation signature fully determine a pass/fail run that a non-Sailfin harness can
execute. What a stranger cannot yet do is **re-derive the tolerance** — they must
trust Sailfin's arithmetic or reimplement the derivation formula. So until the
schema and its derivation test vectors ship as a standalone spec (SFEP-0062 Phase
5), the honest external phrasing is **"gradeable by a stranger, trusting our
arithmetic,"** not "verifiable." The safety-claim discipline in §8 binds this
brief's own headline, not only the code.

Three properties make this the right headline where the previous one failed:

- **It is additive.** It grants a capability rather than withdrawing one.
- **Payer equals beneficiary.** The person who builds the code receives the
  artifact. No externality to argue about.
- **It does not require whole-language adoption or performance parity.** A
  contract is valuable to someone running Triton, CuTe, or PyTorch today. That
  is the only adoption path available to a language with no users.

**Why the previous headline failed.** "Compile-time capability enforcement" is a
restriction. Nobody adopts a language to be told what their code may not do.
Rust gets away with a restriction because it is the price of a power (C speed
without segfaults); the borrow checker is the invoice, not the product. Sailfin
sold the invoice. And the market test was run and returned a verdict: a security
product built on an effect system is *admired and not purchased* — Google's
Capslock shipped free, and the AI-security money went to runtime, sandbox, and
attestation vendors, never to a language or a type system.

**Why proof is the right power now.** Every sweep in the evidence file found the
same wound, in a different layer: in this industry everything is asserted and
almost nothing is verified. Kernel numerics, capability manifests, per-target
schedules, tensor shapes, and published performance claims are all hand-authored,
default-open, and checked by nothing. **The failures are verification failures,
not expressiveness failures.** Verification is the one thing a compiler is
uniquely placed to do, and the one thing that grows more valuable as generated
code volume rises while human review capacity stays flat.

---

## 3. The restriction-vs-power test

Apply this before committing capacity to any feature or claim.

**Ask: does this let someone do something they could not do before, or does it
stop them doing something they could?**

A restriction ships only when bundled with a power that the same person, in the
same moment, wants for themselves. Governance is a feature of a language people
already chose; it is not a reason to choose one.

Worked examples:

| Framing | Verdict |
|---|---|
| "Declare `![net]` so reviewers can see reach" | Restriction. Payer ≠ beneficiary. Not a headline. |
| "The compiler derives a complete capability manifest you can ship and attest" | Power. Artifact you receive, not a tax you pay. |
| "Prove your kernel cannot leak `PII<T>`" | Restriction. Same product the market already declined. |
| "The same program gives the same bits, and mixed precision cannot compile" | Power. Reproducibility you cannot get elsewhere. |
| "Static tensor shapes prevent shape bugs" | Restriction, and the annotation cost has killed six prior attempts. Ergonomics at best. |

---

## 4. The three pillars

The mechanisms are unchanged. The claims are re-cut so each pillar is a **proof**
rather than a prohibition. Nothing is abandoned; the seal, effects, capabilities,
and structured concurrency all keep their roadmaps and change their justification.

### Pillar 1 — Reach: what this code can touch

**Mechanism:** effect types (`![io, net, …]`), capsule manifests, cross-module
propagation (`E0402`), capsule cross-check (`E0403`), the capability-sealed
runtime (SFEP-0016) as the runtime enforcement half.

**The differentiated claim is completeness, not enforcement.** Every shipping
capability system in this space is a retrofit, and every one of them is
hand-authored and default-open *because* it is a retrofit — a retrofit that
defaults closed breaks every existing program. A language with effects and
capabilities from day one has no gradual-adoption hole. That is a structural
advantage nobody can copy without starting over.

**The claim to make:** *the compiler is the only place a capability manifest can
be proven complete rather than authored by hand.*

**The claim not to make:** that untrusted code is caged. SFEP-0016 §3.1's claim
ladder narrows the honest claim to *Sailfin-authored code cannot make an un-gated
syscall* — a statement about cooperative code, and the **provenance-sealed** tier
rather than the fully sealed one. Marketing the adversarial version is a
discipline violation (§8).

**Positioning against the OS-sandbox precedent.** JEP 486 permanently disabled
Java's SecurityManager, with Oracle's stated rationale that applications should
be sandboxed using containers, hypervisors, and OS mechanisms. That precedent
defeats "types instead of policy engines." It does not defeat **"checked by the
compiler, enforced at runtime, attested at deploy"** — the complement framing,
which also matches what buyers actually procure (audit trails, kill switches,
attestations; all runtime artifacts). Lead with the complement.

### Pillar 2 — Result: what numbers it produces

> **Naming constraint, and it binds.** "Result" collides with `Result<T, E>`
> (SFEP-0012). It stays a **positioning word only** — never a module, type,
> field, CLI noun, or diagnostic name. Code and artifacts use `contract`.

**Mechanism:** SFEP-0054's numerics contract — exact dtype identity, no implicit
promotion, mandatory ≥f32 accumulators, an explicit ban on reassociation and
hidden-wider accumulators, per-test error bounds derived from dtype, accumulator
dtype, op count and unit roundoff, validated against a bit-exact CPU reference.

**This is the strongest defensible claim in the repo and it is not currently
marketed.** The field published a specification for approximately this in April
2026 (*Kernel Contracts*: preconditions, postconditions, tolerance, reference
oracle, measurement protocol, violation signature) and nobody has built it. The
demand is revealed, not surveyed: practitioners are surrendering 34–61% of
inference throughput to obtain bit-identical outputs, production stacks silently
drop benchmark accuracy when optimizations compose, and vendor compilers have
silently miscompiled production GEMMs.

**Bookkeeping correction required.** SFEP-0054 Phase 1 is marked *Shipped* while
typecheck collapses `f16`/`bf16` into the coarse `"float"` kind — precisely what
§3.2 of that SFEP forbids ("type equality is exact; `f16 != bf16`"). What shipped
is two storage carriers. **The unimplemented half is the differentiator.** Fix
the coarse-kind collapse and allocate `E0910`–`E0915` before making any claim
here.

### Pillar 3 — Cost: what it takes to run, and whether it finishes

**Mechanism:** schedule-as-contract, plus structured concurrency as the liveness
half. **Shipped today: join-all nurseries only.** Cancel-on-fault and deadlines
are designed but unimplemented (`docs/proposals/draft-concurrency-cancellation.md`,
still a draft — never gated, never scheduled).

**Throughput.** Every stack in this space concedes that the per-target *schedule*
— pipelining, specialization topology, register/TMEM allocation, tile ordering —
must be re-instantiated per target, while the tile/layout *algebra* ports. And
none of them models the schedule as a checkable artifact: it is tuning config,
autotuner output, or a hand-written variant. A contract of the form *this
schedule, on this target, produces these numerics within this tolerance at this
measured throughput* is the artifact nobody produces.

**Liveness.** Bounded, cancellable, cancel-on-fault tasks would make *stuck vs.
progressing* observable by construction. That is the one language-shaped angle on
the most expensive failure mode in ML infrastructure — silent collective hangs
that take hours to weeks to debug because the watchdog fires where execution is
stuck rather than where it first went wrong.

**The unimplemented half is the differentiator.** What ships today is the
*bounded* half: `routine { }` lowers to a real nursery whose exit blocks until
every child completes, so no task outlives its scope and a leaked task is not a
failure mode we have. What does not ship is the *cancellable* half — a faulting
child does not cancel its siblings, and the nursery still blocks at exit waiting
for them. For a long-running server that is a live resource-retention bug: a
failed request handler cannot shed the work it spawned. Ship Phase 1 of the
cancellation draft before making a liveness claim in public material.

---

## 5. The measurement-regime opening

**Nobody in the challenger space submits performance numbers to a neutral
arbiter.** Modular has never entered MLPerf. Tracel (Burn/CubeCL) has never
entered, and has never published a benchmark on datacenter AMD silicon at all.
tinygrad entered once and lost to the vendor's own PyTorch stack by 1.71× on
byte-identical hardware. Every headline number in this space, examined, is
narrower than its citation.

For a project whose methodology thesis is oracle-driven development, this is an
open lane. **Being the only challenger stack whose numbers a stranger can
reproduce is a differentiator that costs discipline and nothing else** — and it
is the credibility asset that survives even while the compiler is slow, provided
the slowness is stated plainly.

Corollary, and it binds: Sailfin's own published numbers are currently all
self-relative. A track whose stated purpose is "how we become fast" has never
measured itself against OpenBLAS, cuBLAS, or XLA. Land one external baseline
before any performance claim leaves the repo.

---

## 6. Oracle availability (retained from the prior brief, unchanged)

**Agentic leverage is proportional to oracle availability.** Agents collapse work
where an automated check says correct/not-correct, because that converts judgment
into iteration, and iteration is cheap. Sorted by that test: a native CPU backend
compresses (oracle: differential testing against the existing LLVM backend); an
owned syscall layer compresses (oracle: libc's observable behaviour); crypto/TLS
compresses best (oracle: RFC test vectors plus interop); GPU kernel *correctness*
compresses (oracle: the CPU/XLA reference). Language and ABI design judgment does
not — there is no automated check for "is this the right surface."

**Performance has an oracle when the unit is small and independently measurable,
and lacks one when the objective is diffuse.** A tile schedule timed against a
reference is an oracle-driven search loop. Matching LLVM's `-O2` is a
whole-program pass pipeline whose wins are interaction effects, with no per-unit
oracle. Same word, different problem shape.

**This thesis is now also the product.** Pillars 1–3 are three instances of
manufacturing an oracle for the user: a complete manifest, a numerical contract,
a schedule contract. The method became the differentiator.

**A wording rule follows, and it binds.** "post-1.0" and "deferred" name a *when*
with no unblocking condition, and agents read a status as a standing instruction —
work parked under those labels is never re-evaluated, including after the thing
that made it expensive stopped being true. Where something genuinely is not now,
name *why*: `gated on: <concrete predecessor>` for a dependency, which re-surfaces
the moment that predecessor lands, or the reason it resists compression
(`long tail: no per-unit perf oracle`) for genuine tail work. **1.0 is a maturity
boundary, not a schedule.** An item with no named gate is a planning defect.

---

## 7. What changes on the ground

Ordered. Each item is a consequence of §2–§5, not a preference.

1. **Soundness is a thesis blocker, not a bug queue.** You cannot sell proofs
   from a compiler whose lowering fails open. The SFN-526 fatal-gate family is
   one architectural defect — the compiler detects a problem, pushes a
   diagnostic, then emits code anyway and exits 0 — with the individual silent
   miscompiles as its regression suite. This precedes every pillar.
2. **SFEP-0054's unimplemented half is the flagship claim** — exact dtype
   identity, `E0910`–`E0915`. **Owner decision 2026-07-26: it does not ship
   first.** SFEP-0062 phases a whole-function determinism class ahead of it,
   because that class is statically discharged from the effect row and is
   therefore reachable on the current stack with no predecessors at all — no
   tensor tier, no 0054, no 0058, no seal. Shipping it first proves the contract
   machinery and the emitted artifact before the hard numerics work begins. The
   coarse-`"float"` fix runs as its own parallel track and converges at SFEP-0062
   Phase 4. **Consequence for messaging:** until Phase 4, the external claim is
   about *determinism*, not precision. Do not describe the precision contract as
   shipped before then.
3. **Read *Kernel Contracts* (arXiv 2604.22032) and either adopt its vocabulary
   or supersede it in an SFEP.** Being the language that implements the
   specification the field just published is positioning leverage with a
   months-long window.
4. **SFEP-0052 Track A stays capped at oracle-and-fallback duty.** Its category
   has no production survivors; the demotion already recorded on 2026-07-25 was
   correct and should not be reversed. Do not grow it.
5. **Shape typing demotes from differentiator to ergonomics — but it is
   load-bearing for Result, which is not the same thing.** Static shapes make the
   op count a compile-time constant, which is what makes a derived tolerance a
   closed form; under dynamic shapes the bound goes symbolic and must be
   conservatively bounded or evaluated at runtime, a real and currently unpriced
   design cost (SFEP-0062 pushback §1). Never market it, never skip it. It still
   needs a first-class symbolic/unknown-dimension story *before* it is built —
   SFEP-0053's "static shapes only" is the design every corpse in that category
   shared.
6. **`extern` is the one design gate blocking all three pillars simultaneously.**
   `E0804` forbids effect annotations on externs, so enforcement depends on
   voluntary wrapping; that hole defeats Reach's completeness claim, defeats the
   seal's adversarial claim, and defeats Result/Cost the moment the fast path
   is typed vendor FFI. SFEP-0016 §4.4 Q3 is unresolved. Owner-level design gate.
7. **Track B's taint/`PII<T>` story demotes.** It is the restriction the market
   declined, relocated to an accelerator, and the `extern` hole defeats it anyway.
8. **Submit one number to something you do not control.** Cheapest credibility
   win on the board.
9. **SFEP-0024 should be `Superseded`.** It contradicts SFEP-0052 on effect
   taxonomy and type syntax and is the only ML document a reader would mistake
   for current direction.

---

## 8. Safety-claim discipline (unchanged and binding)

- Distinguish *compile-time proof* (real now) from *runtime seal* (built, not
  shipped). Never blur them externally.
- "Parsed but not enforced" is not shipped, and is never marketed or documented
  as a guarantee.
- A contract claim is subject to the same rule: an unenforced tolerance is not a
  tolerance. Do not describe a contract as checked until a gate fails on it.
- **Base support vs. sealed support.** Base support — builds, runs, tests green,
  installer ships — targets Linux x86-64 (Tier 1), Linux arm64 and macOS arm64
  (Tier 2). Windows x86-64 ships an installer but is **Tier 3 — best effort**:
  cross-compiled from Linux and smoke-tested only, with no build or suite run on
  the platform, so it does not carry the full base-support claim
  (`docs/conventions/target-tiers.md`). Sealed support — owned codegen,
  owned syscalls, no un-gated syscall path — is tier-1 Linux x86-64 only, per
  SFEP-0016 §3.1 and `docs/backend-independence.md`. Adding a base platform does
  not multiply seal work. Shipping a
  platform is never a claim that the seal holds on it. See `docs/status.md`
  Support Tiers for the live table.

---

## 9. Retractions

Recorded so they are not re-derived. Each was believed, tested, and failed.

| Retracted claim | Why |
|---|---|
| The capability seal is the differentiator | It is a restriction. Fully built, it still does not answer "why switch." Demoted to Reach's enforcement half. |
| A security product on the effect system is the wedge | Three adversarial market reviews concluded *admired, not purchased*. All AI-security acquisition capital went to runtime/sandbox/attestation vendors. |
| Portable kernel authoring is the opening | Six independent sweeps against. ~80% of CUDA's library surface is unreplicated; portability broke *inside* NVIDIA (four incompatible Blackwell targets); Google narrowed Pallas to NVIDIA Hopper+ in 2026; every stack pairs a portable abstraction with a mandatory per-vendor escape hatch. |
| Cross-vendor MLIR compilation is a viable lane | No production survivors at scale. The two most credible teams both moved to hardware-native kernel authoring in 2026, and MLIR's own creator declined to build his commercial stack on its ML dialects. |
| Demand is validated by Modular's funding | Modular is being acquired by a silicon vendor. The thesis exited rather than validated; that is the fifth absorption in this space. |
| Static tensor shapes are independently validated | Backwards. Dynamic shapes are load-bearing, not incidental; the industry engineered *toward* symbolic dims because static specialization is a cost. Six prior static-shape efforts are dead or removed. |

---

## 10. Open questions

- Does the contract format live in Sailfin only, or ship as a consumable
  specification that non-Sailfin kernels can be validated against? The adoption
  argument favours the latter; the scope cost is unassessed.
- What is the determinism tax of Result, measured? The claim is only a power if
  it beats the 34–61% incumbents pay for their opt-in modes.
- Is `extern` capability-typed, forbidden in untrusted units, or something else?
  (SFEP-0016 §4.4 Q3.) Blocks all three pillars.
- Does the seal need a written threat model naming memory corruption as a
  capability-forgery vector? SFEP-0016 §4.1 concedes runtime-as-TCB and §4.4 Q5
  now names forgery as open, but neither connects it to SFEP-0018's incomplete
  ownership work.
