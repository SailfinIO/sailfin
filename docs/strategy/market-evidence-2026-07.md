# Market Evidence — July 2026

**Date collected:** 2026-07-26
**Status:** Evidence base for `docs/strategy/decision-brief.md`. Dated citations
only. This file exists so the analysis behind the brief is checkable and is not
re-derived from scratch.

**How to use.** The brief states conclusions; this file holds the evidence. If a
conclusion in the brief looks wrong, find its row here and dispute the source. Do
not add undated claims. Preserve the `UNVERIFIED` markers — they mark things that
must not be cited externally.

---

## 1. Does a security product built on an effect system sell?

**No.** Internally established before this sweep and corroborated by it.

- Three adversarial market reviews (internal, recorded in the Linear
  `Product & Adoption` initiative description) concluded a security product on
  the effect system is **"admired and not purchased"** — Google's Capslock shipped
  free. The initiative was demoted to Low priority on 2026-07-14 and the gateway
  reclassified from company to demo/wedge.
- Where AI-security capital actually went: Palo Alto Networks acquired Protect AI
  (~$700M, closed Jul 2025); Check Point acquired Lakera (~$300M, Q4 2025); Snyk
  acquired Invariant Labs (2025-06-24). **No acquisition in this window was of a
  language or a type system.**
- Sandbox/runtime infrastructure is the money layer: Modal $355M Series C at
  $4.65B post (May 2026), >$300M ARR; E2B $35M; Daytona $24M.
- Buyer-side procurement asks for **audit trails, kill switches, attestations,
  human-in-the-loop** — all runtime artifacts. A compile-time proof generates no
  evidence. EU AI Act Annex III high-risk deadline provisionally moved
  2026-08-02 → 2027-12-02 (European Parliament, 2026-06-16), so the compliance
  forcing function is softer than marketing suggests.

**The pro-structural-enforcement argument, for balance.** "The Attacker Moves
Second" (Nasr, Carlini, Tramèr et al.; 14 authors from OpenAI, Anthropic, Google
DeepMind; arXiv 2510.09023; USENIX Security '26) broke **all 12** tested defenses
at **>90% attack success** under adaptive attack. Every learned or pattern-based
defense fell; the survivors are deterministic structural enforcement. Note this
supports *deterministic*, not specifically *compile-time* — CaMeL and FIDES
already occupy the deterministic-runtime slot.

---

## 2. Is there prior art on capability/effect typing for agent code?

**Yes, peer-reviewed, from a first-rank type theorist.**

- **arXiv 2603.00991, "Tracking Capabilities for Safer Agents"** — Odersky, Zhao,
  Xu, Bračevac, Pham (Scala 3 capture-checking team). Published as "Securing
  Agents With Tracked Capabilities," ACM Conf. on AI and Agentic Systems,
  doi 10.1145/3786335.3813127. Thesis: the agent emits code in a capability-safe
  language; capabilities are program variables regulating access to effects and
  resources; the type system tracks them statically; adds *local purity* —
  statically proving a sub-computation is side-effect-free.
- **The crack in it:** Scala 3 capture checking remains experimental as of 3.8.x
  ("highly experimental and unstable"), no committed stabilization date, has
  `caps.unsafe` escape hatches, is opt-in/retrofitted, and Scala is not a systems
  language. 3.8.3 added an experimental `safe` mode.

## 3. Where is the unclaimed ground in capability security?

**Manifest completeness.** Every shipping system is hand-authored and
default-open, and says so:

| System | Admission |
|---|---|
| **ChainCaps** (arXiv 2605.26542) | Expert manifests block **100%** of attacks; **naive manifests block 27.3%** |
| **AgentBound** (arXiv 2510.21236) | Auto-generates manifests from source at **80.9% accuracy** — 1 in 5 wrong |
| **FIDES** (arXiv 2505.23643; shipped in Microsoft Agent Framework ≥1.3.0, 2026-05-20; experimental in GitHub Copilot CLI) | Labels are opt-in per source; **unlabeled tools default to trusted/public**; most-restrictive-wins over-blocks |
| **Scala capture checking** | Opt-in, unsafe escapes |

They default-open because they are retrofits — a retrofit that defaults closed
breaks every existing program. A language with capabilities from day one has no
gradual-adoption hole. **This is the differentiated claim.**

Also relevant: **CaMeL** (arXiv 2503.18813, Google DeepMind + ETH Zurich) is the
field-defining paper and enforces *dynamically*, via a custom interpreter — proof
that capability thinking wins the argument and that the winners implemented it as
a runtime, not a language.

**Gap statement, quotable but weak provenance:** arXiv 2607.05743 (single-author
preprint, no venue) — *"Type-system-enforced security remains largely unexplored
despite theoretical promise."* Cite as directional signal only.

## 4. The precedent against in-language sandboxing

**JEP 486 — Permanently Disable the Security Manager**, JDK 24. Oracle's stated
rationale: the SecurityManager was for applets, *"was never recommended for
sandboxing entire applications,"* and *"Java applications should be sandboxed in
the same way as native applications, using technologies outside the JDK such as
containers, hypervisors, and other operating system-level mechanisms."* A
25-year experiment, concluded against.

**Scope of the precedent.** It defeats "types instead of policy engines." It does
not defeat "checked by the compiler, enforced at runtime, attested at deploy,"
because that is the complement rather than the replacement.

## 5. Kernel-level security: a dead wedge

- **84% of confidential-computing adopters are blocked on attestation
  validation** (Linux Foundation/IDC, 600+ IT leaders). The buyer's question is
  attestation, not expressing what code may do. Independent analysts report CC
  revenue growth through 2026 remains modest.
- **SafeTensors structurally eliminated the pickle RCE channel** without a type
  system, removing the most vivid motivating example. The commercial response to
  malicious models is scanning and signing (Protect AI/Prisma AIRS, HiddenLayer,
  Sigstore/SLSA), not types.
- **NVIDIA already occupies "safe systems language for GPU kernels":** cuTile
  Rust (arXiv 2606.15991, NVlabs — Elibol, Roesch, Gelado, Buehler, Garland)
  extends Rust ownership to tile-based kernels, statically preventing data races
  and unsafe aliasing, at **2 PFlop/s GEMM = 96% of cuBLAS** on B200 and 7 TB/s
  element-wise. It is memory safety, not capability security — it says nothing
  about numerical contracts, cross-backend agreement, or determinism.
- Hardware TEE guarantees are eroding: TEE.Fail (Intel/AMD/NVIDIA via DDR5 bus
  interposition), GPUBreach (ETH Zurich + Georgia Tech), "Behind Bars" (USENIX
  Security '26 — MIG cache side channel leaking LLM kernel launch patterns),
  SideLink (NVLink covert channels). Nobody has monetized the resulting gap.
- **No company sells "provably safe ML kernels."** Empty slot, empty because
  there is no CISO budget line for it.

---

## 6. What ML infrastructure engineers actually complain about

Ranked by evidence strength. **Language-addressable** is the column that matters.

| Pain | Evidence | Language-addressable |
|---|---|---|
| Multi-node failures and **silent** collective hangs | Meta @Scale, 2026-06-25: *"one of the most burdensome failure modes"*; debugging *"takes hours to days—or even weeks"*; the watchdog *"fires where the system gets stuck, not necessarily where it first went wrong."* PyTorch Flight Recorder (2026-03-25) shipped because logs are insufficient | Narrow slice only — bounded/cancellable tasks make stuck-vs-progressing observable. Root causes are cabling, NICs, dead nodes |
| Toolchain/version/dependency hell | Lattner lists it first in *Democratizing AI Compute* Pt 4; recurs on HN 2016→2026 unchanged | **No** — packaging problem |
| Non-NVIDIA stacks burn people | EETimes ROCm thread (2026-04-12, 264 pts/198 comments); "ROCm 7.1.1: you can (not) build" (2026-02-22) — hipBLASLt emitted **240 GB** of temp assembly, ROCm's LLVM fork infinite-looped on AVX512 hanging builds 10+ hours | Partially, and less than hoped — see §7 |
| **Compile and autotune latency** | HN Helion thread (2025-11-02): *"Is it normal to spend 10 minutes on tuning nowadays?"* / *"`max-autotune` can be much slower than that"* | **Yes** |
| Kernel debugging / "guessing what the compiler did" | Lattner Pt 7: failures give *"an opaque stack trace from deep inside compiler internals"*; Triton devs are *"guessing what the compiler did"*. HN: Triton is *"ten times harder to debug"* than CUDA | Partially — tooling, not syntax |
| **Numerical nondeterminism and cross-backend disagreement** | See §8 — the strongest fit | **Yes** |
| DSL fragmentation | 2026 entrant list: CUDA Tile/TileIR (Apache-2.0), cuTile Python, cuTile Rust, Cutile.jl, Helion, CubeCL, BarraCUDA, ZLUDA 6, Spectral Compute, Mojo. HN: *"My head is spinning with options"* | Cautionary, not an opening |
| MFU forensics, flaky GPU CI, cost/capacity, data loading | vLLM: 13M CI job-minutes in Jun 2026, 1,400 concurrent runners, 600+ accelerator types | **No** |

**Do not build the pitch on:** dependency hell, NCCL hangs, MFU forensics, CI
fleet economics, cost/capacity, data loading. The widely-cited "70% of training
time is I/O" figure traces to recycled vendor marketing — `UNVERIFIED`, do not
cite.

---

## 7. Is portable kernel authoring an opening?

**No — six independent findings against.**

1. **The blocker is above the language.** ~**20% of CUDA library coverage** is
   replicated by alternatives (missing cuSPARSELt, cuSOLVER, cuRAND, cuTENSOR,
   NPP, nvJPEG, nvCOMP, NCCL, OptiX). Industry summary, from a vendor building an
   alternative: *"we tried to port to X and could never complete it."*
2. **Portability broke inside NVIDIA.** Blackwell is ≥4 incompatible targets
   (sm_100/103/120/121). `tcgen05`/TMEM is SM100-only; an sm_120 kernel *must
   not use it at all*. Real errors: `ptxas: Instruction 'tcgen05.fence' not
   supported on .target 'sm_120f'`. Triton PR #8045 reverted to inline asm to
   unbreak sm103 because NVPTX could not lower tcgen05.
3. **Google narrowed Pallas to NVIDIA.** JAX 0.9.0 (2026-01-20) moved default GPU
   lowering to Mosaic GPU; **JAX 0.11.0 (2026-07-16): "The Triton backend is
   deprecated and will be removed."** Mosaic GPU is Hopper/Blackwell only. AMD:
   Triton path only, `contributions welcome`, "not prioritized." Apple: excluded,
   and the community JAX-on-Apple backend lists Pallas/Mosaic as out of scope.
   JAX's own design doc: examples are *"GPU only. They will require tweaks to the
   block sizes to work on TPUs."*
4. **The frontier is architecture-locked.** FlashAttention-4 is hand-written
   CuTe/CUTLASS with five specialized warp roles and manual pipeline concurrency
   (*"quite gnar code"*), running up to **2.7× Triton** on Blackwell. Modal's
   reverse-engineering writeup records: *"the Triton team gave up on writing
   Blackwell attention."*
5. **Both vendors converged on portable-DSL-plus-mandatory-escape-hatch.**
   Triton→Gluon, cuTile→CuTe/CUTLASS, ROCm→CK/AITER assembly. *The escape hatch
   is the design, not a temporary gap.*
6. **NVIDIA's own portable tile DSL is worse than Triton.** Independent
   evaluation (arXiv 2604.23466, 2026-04-25): CuTile **52–79% of cuBLAS** vs
   Triton **62–101%**; attention swings **5.6× across architectures**; CuTile
   cannot run on Hopper or earlier. Recommendation: *"prefer Triton when
   cross-architecture portability is required."*

**The load-bearing decomposition.** The tile/layout **algebra ports**; the
per-target **schedule does not** — pipelining, specialization topology,
register/TMEM allocation, cache-aware tile ordering. HipKittens (arXiv 2511.08083,
Stanford Hazy Research + AMD): wave specialization is structurally impossible on
CDNA (AMD statically divides registers across waves), reaching only 80% of peak
BF16 GEMM, so they invented 8-wave ping-pong instead; *"each AMD matrix
instruction uses an entirely different layout"* with shared-memory bank phases
*"undocumented in the CDNA ISA."* They beat AMD's own hand-tuned AITER by
**1.0–2.1×** on attention forward and Triton by **1.3–3.0×** on GEMM.

**Nobody models the schedule as a checkable artifact.** It is tuning config,
autotuner output, or a hand-written variant. Per-vendor tuning is mandatory
everywhere: Intel's Triton README (Tensor Descriptors *"more than 2x"*, grid
misordering *"20% to 2x"*); WebGPU/LlamaWeb (**41%** from autotuning alone, three
device tiers); IREE (tuner lives in AMD's repo, best quoted result ~10% on
SDXL/MI300X); llama.cpp OpenCL (Adreno-tuned, *"not optimal"* elsewhere); Pallas
(production attention generates **three** workload-specialized kernels).

**The moat moved.** Every documented 2026 AMD failure is an *integration* failure,
not an expressiveness failure: zero MI355X tests in vLLM CI; Pollara NIC CI at
**0% parity**; MI455X SGLang nightly *"builds and publishes"* with *"no test job,
no accuracy gate."* SemiAnalysis (2026-07-25): *"ROCm is finally moving with real
urgency, but the competitive frontier has moved faster"*; *"the composability of
disagg prefill, wideEP and FP4 inference optimizations needs significant
improvement."*

---

## 8. Numerical contracts: the validated opening

**arXiv 2604.22032, "Kernel Contracts" (2026-04-23)** — a formal specification
language for kernel behaviour: preconditions, postconditions, **tolerance,
reference oracle, measurement protocol**, violation signature; 12 contract
classes; calibrated against three real incidents (Huawei Ascend, Sakana, AMD).
Motivating failures, verbatim in spirit: *a matmul on AMD produces a different
gradient than the same matmul on NVIDIA; an out-of-bounds access returns zero on
one stack and garbage on another;* silent precision degradation in fused ops.

**This is effectively a specification for the type system nobody has built, and
SFEP-0054 independently designs a subset of it.**

Demand is revealed, not surveyed:

- **Deterministic inference costs 34–61% of throughput today.** Thinking Machines
  (2025-09) achieved bit-identical output across 1,000 runs at **~61.5%**
  throughput cost, root-causing nondeterminism to **batch-size dependence of
  reduction kernels** rather than FP non-associativity; SGLang (2025-09-22) got
  it to **~34.35%** with CUDA graphs. People are surrendering a third to
  two-thirds of their fleet for this property.
- **nvcc 13.0 silently corrupted data** in CuTe GEMM on GB202; CUDA 13.0–13.1
  emitted illegal instructions.
- Silent data corruption is now its own research field, and **NaN/±INF account
  for only 1.01% of SDC outcomes** (arXiv 2605.04213, 3M+ simulator hours) — the
  corruption is plausible-looking numbers.
- Accuracy failures from composition, in production: DeepSeek-R1 disaggregated +
  DP-attention produced **near-zero GSM8K**; EP at batch 64 gives **~80% vs 94%**
  baseline, traced to *"numerical corner cases in quantization kernels."* FP8 KV
  cache accuracy failures on MI300X (vLLM #45562).
- **13% TFLOPS spread from kernel engineering alone** on identical B200 hardware
  and identical NVFP4 MoE workload (SGLang 1262 / FlashInfer-CuteDSL 1225 /
  vLLM 1117), and **1.78×** SGLang-over-vLLM at batch 1.

**Multi-vendor is now structural, which makes cross-backend agreement an
operational gate rather than an academic one.** Anthropic is simultaneously
anchor tenant for ~1M Google TPUs (>1 GW in 2026), up to 2 GW of AMD MI450
(announced 2026-07-22, first GW 1H 2027), and an NVIDIA Blackwell customer.

**Verification, not generation, is the bottleneck in AI kernel work.** This makes
contracts more urgent, because reward hacking *is* contract violation:

- Sakana's kernel agent *"found a way to cheat"* — a memory-reuse exploit that
  bypassed correctness checking; claimed 10–100×, real results ~3× slower;
  retracted (TechCrunch, 2025-02-21).
- KernelBench aggregate speedup falls **3.13× → 1.49×** after excluding
  contaminated tasks; documented fake speedups of **50–120×** from hardcoded
  outputs, dropped ops, and weight assumptions (arXiv 2509.14279). Three separate
  2026 papers exist purely to fix KernelBench's production-realism gap.
- Mark Saroufim (GPU MODE), MLSys 2026 invited talk: *"very few AI-generated
  kernels are sufficiently reliable for production use without substantial human
  oversight."* Simon Guo (KernelBench co-author, 2025-10): frontier models beat
  PyTorch eager *"less than 20% of the time"* at baseline; **CUDA is ~0.073% of
  training corpora.**
- Practitioners are independently converging on strong static typing as the
  LLM-codegen substrate: *"statically-typed languages with strong type checking
  are excellent targets for AI codegen."*

---

## 9. Cross-vendor ML compilers: a graveyard

**No cross-vendor MLIR compiler has a production success story at scale.**

- The one clean production win — **Synaptics Torq** (IREE/MLIR-based, Coral NPU
  in silicon) — is a **per-vendor customized fork targeting a proprietary matrix
  ISA**, GA "during 2026." The opposite of the portability thesis.
- **IREE:** LF AI & Data **sandbox** tier since May 2024 with no advancement;
  **zero adopting organizations listed on its own community page**; 3.9k stars
  against 1.4k open issues; issue #20775 (open 14 months) shows IREE CUDA
  **>180× slower than ONNX Runtime** on a T4 and slower than IREE's own CPU path.
  AMD's ROCm 7.14 launch blog (2026-07-15) does not mention IREE, SHARK, or MLIR;
  the highlighted stacks are vLLM, SGLang, llama.cpp, Ollama. AMD's actual graph
  compiler remains MIGraphX, lowering to hand-tuned vendor libraries.
- **The two most credible teams moved to hardware-native authoring in 2026.**
  TVM's **TIRx** (2026-06-22) *"deliberately lowers the abstraction boundary
  compared to Triton to give experts direct control"*; best published result is
  **parity**, not superiority, and only on B200. **Mojo is built purely on MLIR
  Core** — *"the broader MLIR project includes many AI-related dialects, such as
  `linalg`, `affine`, and `scf`, but Mojo doesn't use any of these."* MLIR's own
  creator declined to build his commercial stack on its ML dialects.
- **Absorption pattern, five instances:** OctoAI→NVIDIA (2024-09-30, commercial
  services dead in ~5 weeks); CentML→NVIDIA (2025-06-13, ops ended 2025-07-17,
  Hidet archived 2026-05-12); Nod.ai→AMD (SHARK-Studio unmaintained, shark-ai
  releases stopped 2025-12-17); Spectral Compute→NVIDIA Inception (Jun 2026);
  **Modular→Qualcomm (announced 2026-06-24, closing H2 2026)**.
- **What survived is a format, not a compiler.** StableHLO: 5 years backward /
  2 years forward compatibility, produced by TF/JAX/PyTorch, consumed by XLA and
  IREE, in production since end of 2022. It won because *it asks for very little
  — it standardizes the op set and leaves every hard codegen problem to the
  backend.* Every project that died was trying to beat vendor libraries on
  performance. The one that lived never tried.

---

## 10. Challenger stacks: claims vs. shipped reality

**MLPerf Training v6.0, Llama 3.1 8B, identical 8×MI350X hardware** (MLCommons
results, published June 2026; submission ID 6.0-0117):

| Submitter | Framework | Time to train |
|---|---|---|
| AMD | Primus 0.2.0 (PyTorch/ROCm) | **109.76 min** |
| MiTAC | Primus + Megatron-LM | 110.43 min |
| **tinycorp** | **tinygrad** | **187.48 min** |
| HPE (8×GB300, reference) | NeMo 26.04 | 63.52 min |

**tinygrad is 1.71× slower than the vendor's own PyTorch stack on byte-identical
silicon**, and its submission runs on ROCm 7.1.1 rather than its sovereign stack.
Its AMD contract to train Llama 405B as fast as NVIDIA was due ~July 2026 and is
undelivered; AMD's own MLPerf v6.0 blog never mentions tinygrad, and AMD closed to
within 6% of B200 on Llama 3.1-8B using PyTorch/Primus without it. tinygrad.org's
own FAQ, live: *"How is tinygrad faster than PyTorch?" → "For most use cases it
isn't yet, but it will be."* Only named production user is openpilot — same
founder, inference-only.

**CubeCL/Burn:** README states *"CubeCL is currently in alpha."* All performance
numbers self-reported; **no third-party reproduction found**; **no CDNA hardware
ever benchmarked** — the AMD story is consumer/laptop RDNA on *"our team's
developer machines."* Admitted benchmark-shape overfit: *"It's no coincidence that
our algorithms peak at shape 6144³—this is the shape we focused most of our manual
tuning on."* Burn 0.21.0's flagship GEMV is **1.8% slower** than LibTorch. HN
reception: 6 points / 0 comments. $3M seed.

**Mojo/MAX:** only **three continuously-tested SKUs** (B200, MI355X, MI300X);
everything else including all Apple Silicon is "known compatible, not tested."
Compiler still closed; open-sourcing promised Fall 2026, ModCon 2026-08-18 — i.e.
the decision lands after a Qualcomm acquisition agreement. Mojo 1.0 was announced
for H1 2026 and missed; the 1.0 beta itself deprecates `fn` in favour of `def`
(language-wide breaking rename) and defers private members, which Modular's own
post calls *"essential to providing memory safety."*

**Modular's own portability admission** — *Structured Mojo Kernels Part 4*: B200
vs MI355X differs on thread group size (32 vs 64), matrix instructions
(`tcgen05.mma` vs `mfma`), sync primitives (`mbarrier` vs `s_barrier`), register
allocation (dynamic vs static), and *"the NVIDIA pattern of dedicated producer and
consumer warps is not directly efficient on AMD. A different coordination strategy
is required."* The post's headline evidence is **85% fewer lines of code**, with
**zero NVIDIA-vs-AMD performance data**. The win is source unification with
specialization pushed inside — a real but far narrower claim than the marketing.

**Every headline number, examined, is narrower than its citation.** Modular's
"faster than cuBLAS" is **100.6% at 4096³ and 90% at 8192³**, and the preceding
post in the series is titled "85% of SOTA." tinygrad's "outperforms PyTorch"
contradicts its own live FAQ.

**Neutral-arbiter validation is near-absent.** Modular: zero MLPerf submissions
(verified against Inference v6.0 closed-division submitter list). Tracel: zero.
tinygrad: submitted and lost. **Nobody has publicly reproduced any challenger
performance claim.**

**Nobody has crossed the ecosystem moat.** None of tinygrad, Burn/CubeCL, or
Mojo/MAX is a Hugging Face Hub-supported library. MLX is.

---

## 11. Static tensor shapes: a 100% historical failure rate

| Project | Status |
|---|---|
| Tensor Comprehensions (Meta) | Archived 2023-04-28 |
| Dex (Google Research) | Last commit 2024-01-11 |
| **tensor_annotations (DeepMind)** | **Archived 2026-02-16; README says switch to jaxtyping — a *runtime* checker** |
| PyTorch named tensors | **Fully removed** (2.13.0) |
| Hidet (CentML) | Archived 2026-05-12 |
| `dfdx` (Rust, const-generic shapes) | 3,972 downloads/90d vs candle-core 2.4M — **600×** |

- **einops beats jaxtyping ~4:1 on downloads and ~5:1 on stars** — the legibility
  tool beats the verification tool, and jaxtyping is itself *runtime*. Its own
  FAQ: *"full dtype/shape checking is beyond the scope of what static type
  checkers is currently capable of."* It deliberately declines PEP 646.
- **PEP 646 shipped in 3.11 and its headline motivating use case never
  materialized.** `pytorch#26889` (static shape checking) open since 2019-09-26.
- **Meta shipped static tensor shapes in Pyrefly and the internet shrugged:** HN
  6 points / 0 comments, then 3 points / 0 comments. An introductory "what is a
  tensor" post got 55 points. `pypie`, a 2026 static tensor-shape DSL: **17
  downloads/month.**
- **Revealed preference, from a believer:** a practitioner called static shape
  checking *"an insta-switch feature for me"* and then *"gave up because it was
  adding so much visual clutter, without clear benefits."*
- **From the one person who shipped it** — Futhark's Henriksen, still rewriting
  his type checker on 2026-07-21: *"it really is a dependent type system"*;
  *"there are still some ugly parts where I think we never worked out a good
  theory for size inference."*
- **Dynamic shapes are load-bearing, not incidental.** TVM's Relax (ASPLOS 2025)
  exists specifically to abandon static shapes. vLLM's continuous batching makes
  batch composition unknowable before the request arrives. MoE routing, `nonzero`,
  NMS and top-k are data-dependent. PyTorch spent four years *un*-specializing
  shapes because static specialization is a cost.
- **Even best-in-class needs escape hatches:** Pyrefly is experimental, has no
  dynamic story (falls back to `Any`), is PyTorch-only, is a vendor dialect
  (*"there is no agreed-on standard"*), explicitly refuses a constraint solver,
  and still needs **~1.5 `type: ignore` per model** — with AI-assisted porting.

**The constructive reading.** The unmet need is not verification, it is *legible,
machine-checked shape documentation*. Every actor's own motivation text says the
same thing: shapes live in comments, comments rot, make the comments checkable.
einops won by making the comment *be* the code at near-zero cost. Pyrefly's stated
motivation is literally *"the type checker should infer those comments rather than
developers maintaining them by hand."*

**The narrow pro-static wedge, honestly stated.** Deep-Bench (arXiv 2502.18726)
finds shape/dimension errors are the **top defect category** in LLM-generated deep
learning code (45 + 28 instances across two categories). AutoReproduce
(arXiv 2505.20662) reports the majority of execution errors in LLM-generated ML
code stem from incorrect shapes. But this argues for *fast checkable feedback*,
not specifically compile-time — an agent reading a runtime traceback in two
seconds gets the same signal. Static wins on (a) silent broadcasting bugs that
never raise and (b) errors on code paths the agent did not execute — the latter
mattering when the run costs $50k.

---

## Collection gaps and `UNVERIFIED` items

Do not cite these externally without fresh primary sourcing.

- **Reddit is absent from this evidence base** (blocked to the collection tools).
  r/MachineLearning and r/LocalLLaMA practitioner sentiment is unrepresented.
- HN comment excerpts came through a summarizing fetch: **near-verbatim, not
  guaranteed exact**. Authors and dates are reliable; re-check wording before
  quoting publicly.
- `UNVERIFIED`: the "$2M AMD bounty" for tinygrad (likely conflates tiny corp's
  ~$2M/yr hardware revenue with the AMD contract; largest confirmed bounty is
  $1,000). tinybox units sold, backlog, refund complaints. AWS SageMaker Neo's
  current status and TVM usage. Whether `torch.compile(backend="hidet")` still
  functions. Whether the fusilli hipDNN plugin landed in `rocm-libraries` (not
  present in `develop/dnn-providers` as of 2026-07-26). Rubin's
  Blackwell-code-compatibility claim (third-party blog only). AMD's ROCm 7
  "3.5× inference" claim (no independent datacenter reproduction). Helios
  production status (AMD "in production" vs analyst "85% of backplane needs
  retiming" — directly contested). MI455X perf claims (34× vs 10× over MI355X,
  inconsistent within AMD's own materials). OpenCL 3.1 exact release date.
- The "70% of training time is I/O" figure is recycled vendor marketing. Do not
  cite.
- Any claim of the form "company X uses Burn/tinygrad/MAX in production" traced,
  on inspection, to AI-generated aggregator blogs. Treat as unsubstantiated.
