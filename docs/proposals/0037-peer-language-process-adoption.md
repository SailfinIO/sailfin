---
sfep: 0037
title: Peer-Language Process Adoption — Merge Queue, ICE Discipline, Perf History, Corpus Runs, Reduction, Fuzzing
status: Accepted
type: process
created: 2026-07-01
updated: 2026-07-01
author: "agent:orchestrator (Sailbot); project owner (direction + decisions)"
tracking: "#1806, #1807, #1808, #1809 (Tier 1, §3.13)"
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0037 — Peer-Language Process Adoption

## 1. Summary

Sailfin's delivery skeleton already matches the state of the art in mature
language projects: the SFEP process mirrors Python's PEPs and Rust's RFCs
(SFEP-0001), the nightly triple-pass self-host (`nightly-selfhost.yml`) mirrors
rustc's stage2/stage3 comparison, the determinism gate (`build-quality.yml`)
mirrors reproducible-builds discipline, and the release train (SFEP-0026)
mirrors Rust's cadence model. This SFEP catalogs the process machinery those
projects run that Sailfin does **not** yet have, ranks it by leverage for an
agent-driven repository, and commits a tiered adoption plan. Tier 1 (merge
queue, ICE discipline, continuous perf history, corpus runs) is enumerated as
session-sized issues in §3.13; Tier 2 (test-case reduction, fuzzing, seed
bisection, SFEP final-comment-period) and Tier 3 (feature gates, target tiers,
1.0 compatibility promise, hygiene) are scoped here and groomed when their
tier is reached. It is a process SFEP: apart from two items that graduate into
their own toolchain/language SFEPs (§3.5 reduction, §3.9 feature gates), it
changes how the project operates, not the language.

## 2. Motivation

The repository is developed almost entirely by agents. That amplifies both
directions: good process compounds (agents follow it every time, without
fatigue), and process gaps compound (agents re-derive by hand, every session,
what a tool or gate would have done mechanically). An inventory of
`.github/workflows/`, `scripts/`, `Makefile`, and `docs/proposals/` against
the process portfolios of Rust, Go, Python, Swift, LLVM, and Zig confirms the
following gaps — each one is machinery a peer project built because manual
handling stopped scaling:

- **Unserialized landings.** `ci.yml` tests the PR's synthetic merge commit
  *as of the CI run* — against whatever `main` was then, not against the
  `main` tip the PR is actually merged into, and nothing serializes or
  revalidates at landing time; `build-quality.yml` catches breakage only
  *after* it lands on `main`. With concurrent agent PRs (budgeted in
  `.github/AGENTS.md`), semantic merge conflicts between in-flight PRs are
  precisely the failure class agents cannot foresee. Rust has refused to
  land untested combinations since 2013 (the bors "not rocket science"
  rule).
- **No ICE contract.** A compiler panic prints whatever the failing pass
  printed. There is no internal-compiler-error banner (version, active pass,
  span, "file a bug" pointer) and no ICE issue template — so agent-filed
  compiler-bug issues are free-form and hard to dedupe. rustc has treated
  every ICE as a reportable bug with a uniform banner for over a decade.
- **No performance history.** `benchmark.yml` is `workflow_dispatch`-only and
  uploads throwaway artifacts; the only baselines are two hand-committed CSVs
  in `docs/perf/`. Memory regressions have killed CI runners before being
  noticed (#1245), and the <5 min build target (SFEP-0006) is unenforceable
  without a time series. Rust (perf.rust-lang.org) and LLVM (the
  compile-time tracker) catch these per-merge.
- **No corpus runs.** Nothing compiles the full in-tree corpus (`examples/`,
  `capsules/`, `benchmarks/runtime/`) against a candidate compiler and diffs
  the result against the pinned seed. Rust's crater and Swift's
  source-compatibility suite exist because unit suites systematically miss
  whole-program breakage — Sailfin's own instance is the `check`-green-but-
  build-red class (#1386/#1389), currently guarded by a single hand-written
  e2e test.
- **No reduction, no fuzzing, no bisection.** Agents hand-minimize failing
  repros (burning orchestrator-tier tokens on labor `llvm-reduce`/C-Reduce do
  deterministically), nothing fuzzes the parser/formatter (the closest tools
  are `diag_determinism_sweep.sh` and `test_arena.sh`, which are differential
  in spirit but not generative), and nothing walks the dense released-seed
  history to find a first-bad seed the way `cargo-bisect-rustc` walks
  nightlies.
- **No decision forcing-function for SFEPs.** `Draft → Accepted` has no
  timebox or mandated adversarial pass; Rust's Final Comment Period exists
  because designs otherwise linger or get rubber-stamped.
- **Policy debt before 1.0.** "Parsed but not enforced" is policed by
  documentation discipline, not a compiler mechanism (Rust: feature gates);
  the macOS enforcement gap (#613) is a scattered caveat, not a stated
  support tier (Rust: target tier policy); and nothing yet defines what 1.0
  promises or how pre-1.0 syntax reforms sunset old forms (Go: the Go 1
  compatibility promise; Python: PEP 387).

## 3. Design

Each item names its prior art, the mechanism, the Sailfin adaptation, and its
done-bar. Tiers order adoption by leverage; nothing in a later tier blocks an
earlier one.

### Tier 1 — keep `main` green, make bug reports mechanical

#### 3.1 Merge queue ("not rocket science" rule)

*Prior art:* Rust's bors; GitHub merge queue is the managed successor.

*Mechanism:* a PR lands only after CI passes on the **speculative merge
commit against the `main` tip at landing time**, serialized through a
queue. A merge result that went stale while other PRs landed is re-tested,
never assumed.

*Adaptation:* enable GitHub merge queue on `main` with the `ci.yml` shard
legs as required checks. The in-tree change is small: `ci.yml` (and the
shard-cover lint leg) gains a `merge_group:` trigger so the queue can run it;
enabling the queue itself is a repository-settings action for the owner.
`build-quality.yml` stays as the post-merge structural backstop
(determinism + cache hit-rate are too slow for the queue).

*Done-bar:* two PRs that individually pass CI but conflict semantically
cannot both land; the second fails in the queue, not on `main`.

#### 3.2 ICE discipline

*Prior art:* rustc's ICE banner ("internal compiler error … please file a
bug", version hash + query stack) plus a dedicated ICE issue template and the
`E-needs-mcve` label.

*Mechanism:* every compiler panic on non-user-error paths is a bug by
definition, and the crash output carries enough structure that filing and
deduping are mechanical.

*Adaptation:* a top-level panic boundary in the CLI driver prints a uniform
banner: the resolved version (`resolve_compiler_version()`, including the
`.build-stamp` dev hash), the active pipeline stage, the source file/span
being processed when known, and the repository's new-issue URL. Add
`.github/ISSUE_TEMPLATE/ice.md` (pre-labeled `type:bug`) with slots for the
banner, the repro, and the minimized repro (§3.5's reducer fills the last
slot once it exists). Distinguishing user-source diagnostics from ICEs is
already the codebase's stated norm (`.claude/rules/code-style.md`: core
passes never `panic()` on user input) — the banner makes violations of that
norm self-reporting.

*Done-bar:* an injected panic in any pipeline stage produces the banner with
correct version and stage; the template exists and `/triage` can dedupe two
ICE issues by banner content.

#### 3.3 Continuous performance history

*Prior art:* perf.rust-lang.org (per-merge instruction counts, regression
triage as a workflow); LLVM's compile-time tracker; Go's performance
dashboard.

*Mechanism:* benchmark results are a **time series with alert thresholds**,
not a one-shot artifact. Regressions open work items automatically.

*Adaptation:* a nightly workflow runs `make bench --csv` (per-module compile
time + peak RSS — the harness already exists as `sfn bench --compiler`)
and `make bench-runtime`, appends the CSVs plus commit SHA to an orphan
`bench-data` branch, and compares against the rolling median of the last N
runs. A regression beyond threshold (initially: >10% wall-time or >10% peak
RSS on any module, or the whole-build total crossing the SFEP-0006 budget)
opens a `type:perf` issue with the offending module and the two data points,
deduping against an open issue for the same module. No SaaS dependency; the
data branch is plain CSV and can grow a dashboard later.

*Done-bar:* a synthetic slowdown injected into one module produces exactly
one auto-filed issue naming that module; reverting it does not re-file.

#### 3.4 Corpus runs ("crater-lite")

*Prior art:* Rust's crater (compile the crates.io ecosystem against a
candidate compiler, diff against the baseline); Swift's source-compatibility
suite (a curated corpus of real projects compiled per toolchain).

*Mechanism:* whole-program compilation over a real-code corpus, with the
previous compiler as the oracle — catches breakage unit suites structurally
miss.

*Adaptation:* the corpus is in-tree today: `examples/`, `capsules/`,
`benchmarks/runtime/`. A nightly workflow builds the candidate compiler,
then for every corpus entry records the triple (`sfn check` verdict, build
verdict, run verdict where the entry is runnable) for both the candidate and
the pinned seed, and fails on any *regression* in the diff (seed-accepts →
candidate-rejects, or verdict-pair disagreement). Two invariants are asserted
corpus-wide, not just where a hand-written test exists: **`check`-green ⇒
build-green** (the #1386/#1389 class) and **fmt round-trip stability**
(`fmt(fmt(x)) == fmt(x)` for every corpus file — near-free here, and it
protects the CI fmt gate). When a capsule registry exists post-1.0, the same
harness extends to external capsules — that is the actual crater shape, and
this workflow is deliberately its seed.

*Done-bar:* injecting the #1386 module-global pattern into a corpus entry
fails the run with a verdict-pair disagreement, without any bespoke test.

### Tier 2 — widen the correctness net

#### 3.5 Test-case reduction (`sfn reduce`) — graduates to its own SFEP

*Prior art:* `llvm-reduce`, C-Reduce, rustc's `treereduce`/glacier pipeline.

*Shape:* `sfn reduce <file> --check '<predicate command>'` repeatedly applies
AST-aware shrinking passes (drop a declaration, drop a statement, inline a
trivial binding, truncate a list) and keeps a candidate iff the predicate
still fails the same way. The parser/AST already give Sailfin the hard part;
the driver is a fixpoint loop. This is disproportionately valuable here:
agents hit compiler bugs constantly, and minimization is currently
orchestrator-tier hand labor. It is also dogfooding — the reducer is a pure
Sailfin program. **Toolchain surface ⇒ it gets its own SFEP** (per SFEP-0001;
siblings: SFEP-0004 `sfn check`, SFEP-0007 `sfn fmt`); this section fixes
only its priority and rationale.

#### 3.6 Fuzzing, cheapest properties first

*Prior art:* Csmith and its differential-testing lineage; fuzz-rustc; Zig's
in-tree fuzzer.

*Adaptation, ordered by cost:* (a) **fmt round-trip** over mutated in-tree
sources — `fmt(fmt(x)) == fmt(x)` and `parse(fmt(x)) ≡ parse(x)` (the corpus
run in §3.4 covers unmutated sources; this extends to generated ones);
(b) **parser total-ness** — the parser never panics on arbitrary byte
mutations of valid programs, it diagnoses (this is §3.2's norm made
adversarial); (c) **differential accept/reject** — the pinned seed and the
freshly-built compiler must agree on generated programs, reusing the
self-host artifacts the nightly job already produces as a free oracle.
Grammar-directed generation can start as a trivial template mutator and grow;
the harness (a `*_test.sfn` or a nightly workflow leg) matters more than the
generator's sophistication.

#### 3.7 Seed bisection

*Prior art:* `cargo-bisect-rustc`.

*Adaptation:* released seeds are a dense, already-hosted artifact history
that nothing walks. A small script (`scripts/bisect_seed.sh`): given a repro
command and a good/bad seed range, binary-search the released seeds
(download via the `make fetch-seed` machinery), run the repro, report the
first bad seed and the corresponding source range. This converts
"when did this miscompile appear?" from an Opus `seed-stabilizer`
archaeology session into a mechanical Sonnet task — direct leverage on
`.claude/rules/model-allocation.md`.

#### 3.8 Final Comment Period for SFEPs

*Prior art:* Rust's FCP (rfcbot): a timeboxed window with an explicit
disposition before an RFC is accepted, merged, or closed.

*Adaptation (amends SFEP-0001):* entering FCP is the gate between `Draft`
and `Accepted`. On FCP entry, a mandated adversarial-review pass runs — N
independent reviewer agents attack the design from fixed lenses
(soundness, self-hosting, scope/YAGNI, ecosystem impact). The retired
`architect-review.md` gh-aw workflow was prior art for this shape; any future
FCP reviewer automation should be redesigned against the current Linear/Codex
workflow rather than resurrecting the old pipeline unchanged. The window is 7
days or owner short-circuit; the disposition (accept / reject / back to draft)
and the objections raised are recorded in the SFEP. This gives the
solo-maintainer + agents configuration what FCP gives Rust's teams: a forcing
function that prevents both lingering drafts and rubber-stamped accepts.

### Tier 3 — policy debt to pay before 1.0

#### 3.9 Feature gates — graduates to its own SFEP

*Prior art:* Rust's `#![feature(...)]` gates + the Unstable Book.

*Rationale:* "parsed but not enforced is not shipped" (CLAUDE.md) is the
*policy*; feature gates are the *mechanism*. Half-real surfaces —
`PII<T>`/`Secret<T>`, the sized-int family, structural `async fn` — should be
unreachable without an explicit opt-in (e.g. `--unstable=<name>` or a capsule
manifest key) instead of documented-around. This converts a documentation
discipline into a compiler-enforced one — the same trade the repo made when
the compiler began self-applying its memory cap instead of relying on a
caller-side `ulimit` ritual. Language + CLI surface ⇒ its own SFEP; this
section fixes priority (before 1.0, since gating existing surfaces after GA
is a compatibility break).

#### 3.10 Target tier policy

*Prior art:* Rust's target tier policy (tier 1 = guaranteed to work,
CI-blocking; tier 2 = guaranteed to build; tier 3 = best-effort).

*Adaptation:* one page, `docs/conventions/target-tiers.md`, referenced from
`docs/status.md`: **Tier 1 — Linux x86_64** (full effect enforcement,
memory-cap load-bearing, CI-blocking); **Tier 2 — macOS arm64** (builds and
tests in CI; documented enforcement gaps, #613; memory cap a no-op per
`.claude/rules/compiler-safety.md`). Windows (SFEP-0021) enters as Tier 3
and earns promotion by meeting written criteria rather than by vibes. The
scattered per-caveat phrasing ("real on Linux, partial on macOS") collapses
into one citable statement.

#### 3.11 1.0 compatibility promise + deprecation policy

*Prior art:* the Go 1 compatibility promise (arguably Go's most successful
process artifact); Python's PEP 387 deprecation ladder; Rust's editions
(explicitly *not* proposed here — a solo-maintained pre-1.0 language should
not pay the edition mechanism's cost yet).

*Adaptation:* an SFEP, written before GA, that states (a) what 1.0 promises
(source compatibility for code using only spec-§N surfaces and canonical
effects; explicitly excluding `--unstable` gates per §3.9 and Tier 3
targets per §3.10) and (b) the deprecation ladder for sunsetting pre-1.0
forms (`{{ }}` interpolation, `->` param annotations): deprecate with a
diagnostic + `sfn fmt` auto-migration where possible → warn N releases →
remove. The active syntax reforms make this urgent: today old forms have no
stated sunset.

#### 3.12 Hygiene (small, independent)

- **CODEOWNERS**: map `area:*` paths to the specialist agent that reviews
  them (`compiler/src/llvm/` → lowering review, `runtime/` → runtime review)
  — machine-readable review routing; today no CODEOWNERS exists.
- **PR template**: the issue contract is strong
  (`.github/ISSUE_TEMPLATE/claude-task.md`); no PR-side contract exists.
  Sections: linked issue (`Closes #N`), verification commands run,
  self-host status, fmt status.
- **RCA template + `regression` label**: `docs/rca/` has one ad-hoc entry;
  add a template (trigger, blast radius, root cause, guard added) and a
  `regression` label in `labels.yml` so regressions get priority triage the
  way rustc's `regression-from-*` labels drive its triage.

### 3.13 Execution plan — Tier 1 issues

Groomed as session-sized issues (tracked in the front-matter):

1. **#1806** — `chore(ci): add merge_group trigger to CI and document
   merge-queue enablement` — §3.1. `ci.yml` + a runbook note; queue
   enablement itself is an owner settings action.
2. **#1807** — `feat(cli): print a uniform ICE banner on compiler panic +
   add ICE issue template` — §3.2. Panic boundary in the CLI driver +
   `ice.md` template.
3. **#1808** — `chore(ci): nightly perf-history job — bench time series on a
   data branch + regression auto-filing` — §3.3. New workflow + `bench-data`
   orphan branch + threshold compare script.
4. **#1809** — `chore(ci): nightly corpus run — diff candidate compiler vs
   pinned seed` — §3.4. New workflow + corpus-runner script asserting
   verdict-pair agreement and fmt round-trip.

Tier 2/3 items are groomed when their tier is reached; §3.5 and §3.9 start
as new draft SFEPs, §3.8 and §3.11 as amendments/additions beside SFEP-0001.

## 4. Effect & capability impact

None directly — this SFEP changes project operations, not language
semantics. Two touchpoints: feature gates (§3.9) would become the standard
staging mechanism for *future* effect-system surfaces (e.g. hierarchical
sub-effects, SFEP-0017) before they are enforcement-complete; and the corpus
run (§3.4) exercises effect checking over whole programs, widening
enforcement coverage beyond hand-written tests.

## 5. Self-hosting impact

Tier 1 items 3.1/3.3/3.4 are CI/workflow-only: no compiler pass changes, no
self-host interaction beyond *consuming* built artifacts. The ICE banner
(§3.2) touches the CLI driver (orchestration surface — permitted, it adds no
build fixups) and self-hosts normally under `make compile`. The corpus run
and differential fuzzing (§3.4, §3.6) strengthen the self-host invariant:
they use the pinned seed as an oracle against the candidate, the same trust
structure `make check`'s seedcheck pass already relies on. `sfn reduce`
(§3.5) and feature gates (§3.9) are compiler-source work and will carry
their self-hosting analysis in their own SFEPs.

## 6. Alternatives considered

- **Status quo (adopt nothing).** The gaps are each survivable alone; the
  argument against is compounding cost in an agent-driven repo — every
  un-mechanized step is re-derived by hand every session, and two of the
  gaps (untested merges, unnoticed perf/memory regressions) have already
  produced incidents (#1245, the post-merge breakage class
  `build-quality.yml` was built to catch).
- **Big-bang adoption.** Land everything at once. Rejected: Tier 2/3 items
  have design surface of their own (reducer passes, gate syntax, promise
  wording) and would arrive half-baked; the tier structure lets Tier 1 pay
  for itself immediately.
- **SaaS perf tracking (Bencher, CodSpeed, bencher.dev-style)** instead of a
  data branch. Rejected for now: adds an external dependency and auth
  surface for a solo project; plain CSV on an orphan branch is sufficient,
  auditable, and can feed a dashboard later. Revisit if triage volume grows.
- **bors-ng / homu self-hosted queue** instead of GitHub merge queue.
  Rejected: operational cost of hosting a bot for a feature GitHub now
  provides natively.
- **Generic reducers (C-Reduce/`treereduce` with a Sailfin grammar)** instead
  of a native `sfn reduce`. Viable as a stopgap, but a native reducer is
  AST-aware (fewer invalid candidates), dogfoods the language, and matches
  the toolchain-independence direction (SFEP-0015). The stopgap-vs-native
  call is made in the reducer's own SFEP.
- **Rust-style editions** as the 1.0 compatibility mechanism. Rejected
  pre-1.0: the promise + deprecation ladder (§3.11) covers the need at a
  fraction of the mechanism cost; editions remain available post-1.0 if
  breaking evolution is ever warranted.

## 7. Stage1 readiness mapping

Process SFEP — the language-pipeline checklist does not apply as written.
Per-item done-bars are defined in §3.1–§3.4 (Tier 1) and in the follow-on
SFEPs for §3.5/§3.9. The two compiler-source items self-host under the
normal gate:

- [ ] §3.2 ICE banner: `make compile` green; banner verified by injected
      panic; `sfn fmt --check` clean on touched files
- [ ] §3.1/§3.3/§3.4 workflows: green on a scheduled run and on a
      deliberately-failing injection (per done-bars)
- [ ] Tier 2/3: deferred to their own SFEPs/amendments

## 8. Test plan

The gates verify themselves by injection, not by unit tests:

- **Merge queue (§3.1):** open two PRs that individually pass CI but
  together break the build (e.g. one renames a symbol the other adds a call
  to); assert the second fails in the queue and `main` stays green.
- **ICE banner (§3.2):** a `compiler/tests/e2e/*_test.sfn` drives the
  compiler over a fixture wired to a debug-only forced panic (or a known
  panicking input while one exists) and asserts the banner's version, stage,
  and issue-URL lines via `process.run_capture` + `sfn/strings::find`, per
  `.claude/rules/no-bash-e2e.md`.
- **Perf history (§3.3):** inject a synthetic slowdown (a sleep-equivalent
  in one module's bench entry) in a scratch run; assert exactly one issue is
  filed naming that module and that a clean re-run files nothing.
- **Corpus run (§3.4):** inject the #1386 runtime-evaluated module-global
  pattern into a scratch corpus entry; assert the run fails with a
  check-green/build-red verdict disagreement. Assert fmt round-trip failure
  when a corpus file is hand-mangled.

## 9. References

- SFEP-0001 (process), SFEP-0026 (delivery process — cadence, seed
  discovery), SFEP-0006 (build architecture — the <5 min target §3.3
  enforces), SFEP-0011 (CI test-speed), SFEP-0014 (agent-legible output),
  SFEP-0015 (toolchain independence), SFEP-0004/0007 (tool-SFEP precedent
  for §3.5), SFEP-0017 (a future consumer of §3.9), SFEP-0021 (Windows —
  enters via §3.10 tiers)
- Issues: #1245 (memory regression killed runners → §3.3), #1386/#1389
  (check-green ⇒ build-green gap → §3.4), #613 (macOS enforcement gaps →
  §3.10), #1205/#1209 (prior art for mechanism-over-discipline → §3.9)
- Prior art: Rust — bors/"not rocket science", perf.rust-lang.org, crater,
  `cargo-bisect-rustc`, ICE policy, RFC FCP, feature gates + Unstable Book,
  target tier policy; LLVM — `llvm-reduce`, compile-time tracker; Python —
  PEP 1/PEP 387; Go — proposal process, Go 1 compatibility promise, perf
  dashboard; Swift — evolution process, source-compatibility suite; Zig —
  in-tree fuzzing, wasm-seed bootstrap; Csmith — differential compiler
  testing lineage
