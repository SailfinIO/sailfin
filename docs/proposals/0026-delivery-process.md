---
sfep: 0026
title: Delivery Process — Drift-Tolerant Issues, Seed Discovery, Release Cadence
status: Accepted
type: process
created: 2026-06-26
updated: 2026-07-19
author: "agent:compiler-architect; project owner (direction + decisions)"
tracking:
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0026 — Delivery Process: Drift-Tolerant Issues, Seed Discovery, Release Cadence

> Accepted at the design gate (owner approval, 2026-06-26). Allocated **SFEP-0026**
> (registry max was 0025); file renamed from `draft-delivery-process.md` to
> `0026-delivery-process.md` and the registry row added in this PR. Graduates to
> `Implemented` once all 16 execution-plan edits (§3.4) land and one full cadence
> cycle is observed end-to-end (§7).

## 1. Summary

Sailfin's delivery pipeline (groom → pickup → release/seed) has three coupled
failure modes that together throttle throughput: (A) groomed issues encode
brittle specifics (line numbers, exact file lists) that rot as the codebase
moves, so `/pickup` halts on cosmetic map drift it cannot distinguish from real
scope growth; (B) seed dependencies discovered mid-flight default to a heavy
multi-issue/seed-cut chain rather than the cheaper bundle-in-one-PR path; and
(C) there is no release cadence — alphas double as reactively-cut seeds (now at
`0.7.0-alpha.49`), no trigger ever promotes beta/rc/stable, and the release
tracker uses markdown checkboxes instead of native sub-issues so there is no
rollup. This SFEP designs three workstreams — **drift tolerance**, **seed
discovery**, and **release cadence** — that make issue *intent* authoritative
and the file map advisory, promote capability+consumer bundling to a groom-time
default, and install a hybrid time-box + train release model with seed cuts
batched onto the cadence. It is a process SFEP: it changes *how the project
operates*, not the language or runtime. The most load-bearing deliverable is the
enumerated execution plan in §3.4 — the exact files and edits that become issues
after the design gate.

## 2. Motivation

The diagnosis comes from three observed pain clusters. Each was confirmed
against the current workflow sources; corrections to the original diagnosis are
flagged inline.

**Cluster A — issue drift.** `/groom` emits a concrete `## Files Affected` block
(`groom.md` body skeleton, ~L162-164: `- compiler/src/... — ...`) and grooming
guidance encourages naming specific paths. Between groom and pickup the codebase
moves (files split, renamed, a sibling added in the same semantic unit), so the
map rots. `/pickup` Phase 3 (`pickup.md` ~L280-294) has a correct hard guard —
"respect the Scope section… Do not silently expand scope" — but it operates on
the *file map* as if it were scope, and **cannot distinguish cosmetic map drift
(a renamed path, an in-unit Nth file) from real scope growth (a new acceptance
criterion, new public surface)**. The result is agents halting on cosmetic
drift. `/sweep` Phase 3 (`sweep.md` ~L155-167) actively flags `missing-file` on
any `## Files Affected` path that no longer exists, reinforcing the expectation
that the map is binding and precise — decaying precision becomes a reported
defect rather than expected entropy. *Diagnosis confirmed.*

**Cluster B — the seed-blocker dance.** Seed dependencies aren't always
discoverable at groom time. `groom.md` itself documents this (~L69-90, the
feasibility-probe gate): the original #1088 pickup's "no frontend dependency"
premise was false and the missing primitive surfaced reactively mid-pickup. When
a seed need is discovered mid-flight, the fully-codified path is heavy: file a
frontend predecessor → groom it → separate PR → cut a seed → `/pin-seed` →
re-pickup. The cheaper "bundle the capability with its single consumer in one PR
to avoid the seed cut" path **does** exist and is well-described in both
`groom.md` (~L92-110, the seed-cut tax) and `pickup.md` (~L296-318) — but it is
framed as a *reactive exception* an agent weighs mid-flight, not a *groom-time
default*. So the default behaviour still trends toward the heavy chain.
*Diagnosis confirmed.*

**Cluster C — no release cadence; seeds conflated with releases.**
`release.yml` is pure mechanism (`workflow_dispatch`, bash) — nothing decides
*when or why* a release happens. Three consequences:

1. **Alphas double as seeds, cut reactively per-need.** `compiler/capsule.toml`
   is at `0.7.0-alpha.49` and `.seed-version` pins that same alpha — confirming
   alphas-as-seeds and the ~49-reactive-advance treadmill. Each downstream seed
   need (the `needs-seed-cut` flow, `issue-naming.md` ~L358-380; the
   `seed-cut-advisor.yml` workflow) tends to motivate its own cut.
2. **No trigger ever fires beta/rc/stable promotion.** The `release:*` gating
   labels and the `Release: vX.Y.Z` tracker (`issue-naming.md` ~L251-309) exist,
   and `release.yml` *can* promote, but nothing decides *when*. **Correction to
   the diagnosis:** the alpha *version line* has advanced to **0.7.0**, not
   frozen at 0.6.0 — what is frozen is the last *stable/GA channel* cut. The
   substance of the diagnosis holds: no promotion trigger means stable lags the
   merged-and-validated work indefinitely.
3. **The release tracker uses markdown checkboxes, not native sub-issues.**
   `release-plan.md` (~L100-135, L147-180) writes `- [ ] #N` lines into the
   tracker body and reconciles them by string-matching — it does **not** attach
   GitHub-native sub-issues. This is inconsistent with `groom.md` (~L274-298),
   which attaches native sub-issues to epics for rollup. So a release cycle has
   no "Sub-issues" panel, no progress rollup, no native "what's left" view.
   *Diagnosis confirmed.*

The cost compounds: a 2-week-equivalent of merged fixes can sit unreleased while
agents burn cycles halting on cosmetic drift and manufacturing seed cuts. With
the autonomous pipeline capped at **≤2 concurrent agent-authored PRs**
(`.github/AGENTS.md` ~L99-110), every avoidable halt or extra PR is a meaningful
fraction of total throughput.

## 3. Design

The design is three workstreams sharing one principle: **declared intent is
authoritative; the mechanical map is advisory, reconciled at the point of use,
and batched against a cadence rather than serviced reactively.**

### 3.1 WS-A — Drift tolerance: intent authoritative, map advisory

**Core move.** A groomed issue's *contract* is its **Goal** plus a **semantic
`In:`/`Out:` scope**. The `## Files Affected` block is demoted to a
**non-binding map** — a navigation aid that is *expected to drift* and is
reconciled at pickup, never a checklist that gates correctness.

**Ban brittle citations in groomed issues.** `/groom` and the issue template
must forbid, in any issue body:

- **Line numbers** anywhere (`L142`, `~L100-135`). They rot fastest and carry no
  semantic weight.
- **Exact file *counts*** ("edit these 3 files", "two call sites"). A count
  turns an in-unit Nth sibling into a phantom scope violation.
- **Closed file enumerations presented as exhaustive.** `## Files Affected` lists
  paths as *likely-relevant starting points*, explicitly marked non-exhaustive.

**Express scope semantically so in-unit drift is in-scope by construction.** The
`In:` lines name *semantic units of change*, not files: e.g. "the effect-checker
diagnostic emission for missing `![io]`" rather than "`effect_checker.sfn` lines
X-Y". A new sibling file inside that semantic unit (e.g. a file split that moved
diagnostic emission into `effect_checker/diagnostics.sfn`) is then **in scope by
construction** — the unit, not the path, defines the boundary.

**The In/Out semantic boundary contract (the precise rule pickup applies).**

- **In-scope (proceed, reconcile, record):**
  - A path in `## Files Affected` was **renamed/moved** → use the new path.
  - A semantic unit named in `In:` is now spread across **additional sibling
    files** in the same module/directory → touch them all.
  - A file in the map **no longer exists** because its content merged into a
    sibling already covered by the same `In:` unit → follow the content.
  - The **same public surface** is reached through a refactored internal call
    path → follow it.
- **Out-of-scope (PAUSE, comment, do not proceed):**
  - A **new acceptance criterion** is required that the issue did not list.
  - A **new public/user-facing surface** (new CLI flag, new exported symbol, new
    diagnostic code) not implied by the Goal.
  - The change must reach a **different semantic unit** than `In:` names (e.g.
    the issue is scoped to the effect checker but the fix actually belongs in the
    parser).
  - Honoring `Out:` becomes **impossible** (an explicit exclusion is unavoidable).

The discriminator is one question: **does the Goal plus the semantic `In:`/`Out:`
still hold?** If yes, drift is cosmetic — reconcile and record it in the PR. If a
*new* criterion or surface is required, that is real growth — pause. This is the
exact distinction `pickup.md` cannot currently make because it treats the file
map as scope.

**Teach pickup to reconcile, not halt.** At pickup, before implementation, the
agent **re-derives the current surface** for each `In:` semantic unit (grep/glob
for the named symbols/units), compares against the advisory map, and:

- proceeds whenever Goal + semantic In/Out hold (per the contract above),
- **records the reconciliation in the PR body** (a "Map reconciliation:
  `old/path` → `new/path`; added sibling `X` (same unit)" note), so drift is
  visible and auditable but non-blocking,
- **pauses only on semantic scope growth** (the Out-of-scope list).

**Make `/sweep` map-staleness a soft note.** `sweep.md` Phase 3 keeps detecting
that a `## Files Affected` path is missing, but **downgrades `missing-file` from
a flagged defect to a soft, non-blocking note** ("map may be stale; `/triage`
can refresh"). It must *not* imply the issue is broken — a stale map on a
semantically-scoped issue is expected entropy, not rot.

**Let `/triage` refresh stale maps.** `/triage` already edits `claude-ready`
issues and validates `## Files` presence. Add a **map-refresh step**: when triage
encounters an issue whose advisory map has missing/renamed paths but whose Goal +
semantic scope are intact, it **re-derives and rewrites the advisory map** (still
non-binding, still no line numbers/counts) and notes the refresh. This moves map
maintenance to the cheap, already-editing pass and keeps pickup focused on the
semantic contract.

### 3.2 WS-B — Seed discovery: bundle-by-default + a shared decision rule

**Promote bundling to a groom-time default.** Today bundling a compiler
capability with its single consumer is a *reactive* mid-flight escape. WS-B makes
it the **groom-time default**: when `/groom` identifies a capability that is
tightly coupled to exactly one consumer that will be worked in the same session,
it produces **one issue** (one PR), not two — unless the capability has multiple
consumers or is genuinely independent. This is the existing seed-cut-tax logic
(`groom.md` ~L92-110), reframed from "factor this in when splitting" to "default
to one issue; justify any split that creates a seed-cut gate for a single
consumer."

**Codify a shared mid-flight decision rule.** The bundle-vs-split decision is
currently described in two places (`groom.md` and `pickup.md`) in prose. WS-B
extracts it into a single **shared rule** — `.claude/rules/seed-dependency.md` —
so `/groom`, `/pickup`, and any future agent apply it identically. The rule is a
decision tree:

```
A seed dependency is discovered (groom-time or mid-pickup):
│
├─ Is the dependency a compiler-source capability (lowering / parse /
│  typecheck / intrinsic / runtime-prelude) that the consumer needs
│  present in the *pinned seed*?
│     └─ No  → not a seed dependency. Normal `## Blocked by`. Done.
│     └─ Yes ↓
│
├─ How many consumers need this capability?
│     ├─ Exactly one, tightly coupled, same session
│     │     → BUNDLE: one PR lands capability + consumer together.
│     │       `make compile` builds the new compiler from the old seed;
│     │       that compiler compiles the consumer in the same self-host
│     │       pass → NO seed cut, NO `/pin-seed`. (Default.)
│     └─ Multiple consumers, OR genuinely independent, OR large blast
│        radius → SPLIT: file the capability as a standalone predecessor
│        with `seed-blocker`; the consumer carries
│        `## Required in pinned seed: #<predecessor>`.
│             └─ The split now REQUIRES a seed cut. Do NOT cut reactively —
│                QUEUE it against the next scheduled cadence seed bump
│                (WS-C). Mid-pickup: pause and present the bundle-vs-split
│                tradeoff to the user (per pickup.md), defaulting to bundle.
```

**Tie split-forced seed cuts to cadence batching.** The decisive change: a split
that forces a seed cut **does not trigger a reactive cut**. The predecessor lands
with `seed-blocker`; the seed advance is **batched onto the next cadence bump**
(WS-C). The `seed-cut-advisor.yml` workflow already surfaces "this merged PR is
required-in-seed by an open downstream issue" by labeling `needs-seed-cut` — WS-C
makes that label *queue against the cadence* rather than prompt an immediate cut,
unless the need clears the **release-critical** bar defined in §3.3.

### 3.3 WS-C — Release cadence: hybrid time-box + train, batched seeds

The owner has fixed two decisions; WS-C specifies them concretely.

**Hybrid time-box + train cadence.** A **fixed 2-week cadence** cuts the next
minor train. The interval is chosen to match the repository's existing 2-week
iteration cadence (`issue-naming.md` ~L217 — "2-week cadence, Monday-start"):
reusing the iteration boundary means the release train aligns with the planning
boundary agents already work to, and avoids inventing a second rhythm. At each
train boundary, **whatever is done ships; whatever is not rolls to the next
train** — no item blocks the train, the train does not wait for an item.

- **Mechanism.** A scheduled workflow (`release-train.yml`, cron every 2 weeks,
  Monday) opens/updates the `Release: vX.Y.Z` tracker and, when the cut gate is
  clear, dispatches `release.yml` for the cadence cut. It never *waits* on open
  items — they roll forward.
- **Alpha line unchanged.** Routine alpha prereleases remain the uncurated daily
  path (`issue-naming.md` ~L259-262). The train cut is the *curated minor* on the
  cadence; it consults the `release:next-minor` gate.

**Stable promotion gate.** Stable promotion is **not** on a timer. It fires when
**both** hold:

1. The active `Release: vX.Y.Z` tracker is **clear** — every hard-gated
   `release:stable` / `release:rc` item closed (the existing curated-cut gate,
   `issue-naming.md` ~L264-289), AND
2. **N = 7 consecutive green-CI days.** Seven days chosen deliberately: it spans
   a full nightly-self-host week (covering weekday and weekend cron variance) and
   is long enough that a single flaky-green day cannot promote, but short enough
   that a clean cycle promotes within one cadence interval. Fewer days risks
   promoting on transient green; more days would routinely miss the 2-week train.

When both hold, `/release-plan` surfaces "stable promotion eligible" and a human
confirms the `channel=stable` dispatch (promotion stays human-gated — the gate is
advisory, per `issue-naming.md` ~L269-272).

**Seed cuts batched onto the cadence.** Keep alphas-as-seeds (no decoupling of
the version line — explicitly an owner decision). Advance the **pinned seed once
per cadence cycle**, batched, rather than per-need:

- The cadence train cut produces an alpha; **that alpha is the scheduled seed
  bump.** `/pin-seed` runs once per cadence against it, collapsing the N reactive
  cuts of a cycle into ~1 scheduled bump.
- Mid-flight seed needs (`needs-seed-cut`, `seed-blocker`) **queue against the
  next scheduled bump** by default. The `seed-cut-advisor.yml` advisory comment
  is reworded from "cut a new alpha and `/pin-seed` before pickup" to "queued for
  the next cadence seed bump (tracker #X); `/pin-seed` runs on the next train
  cut" — *unless* the need is **release-critical**.

**The release-critical bar (the only thing that breaks the batch).** A mid-flight
seed need may force an **off-cadence** seed cut only if **all** of:

1. It **unblocks an item that is on the current `release:next-minor`/`release:1.0`
   hard gate** (the train cannot ship the intended scope without it), AND
2. **No bundle path exists** (per the §3.2 decision tree — it is a genuine
   multi-consumer or independent capability, so it cannot be folded into one PR
   with its consumer), AND
3. The wait until the next cadence bump would **slip the train's committed
   scope** (not merely defer a nice-to-have to the next train).

A need that fails any clause queues for the next cadence bump. A
miscompilation/seed-bug that breaks *active* downstream work (the existing
`seed-blocker` hotfix examples, `issue-naming.md` ~L321-327) clears the bar by
construction — it is release-critical because it blocks the gate. Mark such items
with a new **`release-critical-seed`** marker label so the advisor and
`/release-plan` can distinguish "break the batch" from "queue for cadence."

**Native sub-issues on the release tracker.** Replace `release-plan.md`'s
markdown-checkbox bookkeeping with **GitHub-native sub-issue attachment**,
mirroring `groom.md`'s `/sub_issues` REST pattern (~L274-298). Each
hard-gated/seed-blocker item is attached as a native sub-issue of the
`Release: vX.Y.Z` tracker, giving a real "Sub-issues" rollup panel and "what's
left" view. The markdown checklist becomes a *rendered summary* of the native
sub-issue state, not the source of truth — consistent with how epics already
work, and removing the string-matching reconciliation drift `release-plan.md`
currently warns about.

### 3.4 Execution plan (the authoritative deliverable)

Each item below is **file path + the specific change** — the seed material for
post-design-gate issues. Grouped by workstream. No full replacement text here;
the wording is produced at implementation behind the design gate.

#### WS-A — drift tolerance

1. **`.github/ISSUE_TEMPLATE/claude-task.md`** — Reword the `## Files Affected`
   section header/help to **"Files Affected (advisory map — non-binding,
   expected to drift)"**; add an inline instruction forbidding line numbers and
   exact file counts, and stating the list is a non-exhaustive starting point.
2. **`.claude/commands/groom.md`** (body skeleton, around the `## Files Affected`
   block and the issue-contract guidance) — Mirror the template reword; add a
   grooming rule: **express `In:`/`Out:` as semantic units of change, not file
   paths**; forbid line numbers and exact counts in any emitted issue body.
3. **`.claude/commands/pickup.md`** (Phase 3) — Insert a **"reconcile vs halt"**
   step *before* the existing scope guard: re-derive the current surface for each
   `In:` unit, apply the §3.1 In/Out semantic boundary contract, **proceed +
   record the reconciliation in the PR** on cosmetic drift, and **pause only on
   semantic scope growth** (the Out-of-scope list). Reword the existing "never
   expand scope silently" guard so it triggers on semantic growth, not on a
   missing/renamed map path.
4. **`.claude/commands/pickup.md`** (Phase 5 PR body / Constraints) — Add a
   **"Map reconciliation"** line to the PR-body template and a Constraint that
   reconciliation must be *recorded*, never silent.
5. **`.claude/commands/sweep.md`** (Phase 3) — Downgrade `missing-file` from a
   flagged defect to a **soft, non-blocking note** ("advisory map may be stale —
   `/triage` can refresh"); stop treating a missing `## Files Affected` path as an
   issue defect.
6. **`.claude/commands/triage.md`** — Add a **map-refresh step**: when an issue's
   Goal + semantic scope are intact but its advisory map has missing/renamed
   paths, **re-derive and rewrite the advisory map** (no line numbers/counts) and
   note the refresh. Keep the existing `## Files` presence check.
7. **`docs/conventions/issue-naming.md`** (issue-contract / Files-Affected
   guidance) — Document the **intent-authoritative / map-advisory** contract and
   the In/Out semantic boundary rule as the convention of record, so all four
   commands cite one source.

#### WS-B — seed discovery

8. **`.claude/rules/seed-dependency.md`** (**new file**) — The shared mid-flight
   seed-need decision tree from §3.2 (bundle-by-default; split→`seed-blocker`→
   queue against cadence; release-critical exception pointer). Auto-loaded like
   the other `.claude/rules/*.md`.
9. **`.claude/commands/groom.md`** ("Don't over-decompose" section) — Reframe
   bundling from a *split-time consideration* to the **groom-time default**:
   "produce one issue for a capability + its single coupled consumer; justify any
   split that creates a seed-cut gate." Cite the new rule (item 8) instead of
   restating the tree.
10. **`.claude/commands/pickup.md`** (Phase 3, the bundle-vs-split escape) —
    Replace the inline prose with a **citation of `.claude/rules/seed-dependency.md`**;
    keep the "pause and present the tradeoff to the user, defaulting to bundle"
    behaviour; add the explicit "a split forces a seed cut → queue against the
    cadence bump (WS-C), do not cut reactively" branch.

#### WS-C — release cadence

11. **`.github/workflows/release-train.yml`** (**new workflow**) — Scheduled
    cron (every 2 weeks, Monday), opens/updates the `Release: vX.Y.Z` tracker and
    dispatches the cadence minor cut when the cut gate is clear; never waits on
    open items (they roll forward). Plain/deterministic in the spirit of
    `seed-cut-advisor.yml` (no LLM engine); the actual `release.yml` dispatch
    stays human-confirmable.
12. **`.claude/commands/release-plan.md`** — (a) Replace markdown-checkbox
    bookkeeping with **native sub-issue attachment** to the `Release: vX.Y.Z`
    tracker, mirroring `groom.md`'s `/sub_issues` REST pattern; render the
    checklist as a summary of native sub-issue state. (b) Add the **stable
    promotion gate** wording (tracker clear AND N=7 consecutive green-CI days →
    surface "stable promotion eligible"). (c) Add a **"Seed bump (this cadence)"**
    section reflecting batched seed advancement and any `release-critical-seed`
    overrides.
13. **`.github/workflows/seed-cut-advisor.yml`** — Reword the advisory comment
    and label semantics: a `needs-seed-cut` flag means **"queued for the next
    cadence seed bump"** by default, not "cut now." Add a branch that, when the
    flagged dependent (or its predecessor) carries **`release-critical-seed`**,
    escalates the comment to "release-critical: off-cadence seed cut may be
    warranted." Keep the workflow deterministic / flag-only.
14. **`docs/conventions/issue-naming.md`** — (a) Add a **"Release cadence"**
    subsection: the 2-week train, the roll-forward semantics, the N=7-day stable
    promotion gate. (b) Update **"Seed pinning"** to state seeds advance on the
    cadence (batched), with the `release-critical` bar (§3.3) as the only
    off-cadence exception. (c) Register the new **`release-critical-seed`**
    marker label and its lifecycle (the only thing that breaks the seed batch).
15. **`.github/labels.yml`** — Register the **`release-critical-seed`** label
    (color/description) referenced by items 12–14.
16. **`.claude/commands/sweep.md`** (Phase 2b) — Teach the release-tracker sync to
    reconcile **native sub-issue state** (from item 12) rather than only the
    markdown checklist; keep auto-ticking on `seed-blocker` close.

This 16-item list is the implementation surface. After the design gate it
decomposes into roughly: WS-A as one S/M issue (items 1-7 are tightly coupled —
one semantic change to the issue contract across four commands + template +
convention), WS-B as one S issue (the new rule + two citation edits), and WS-C as
two issues (the cadence/seed convention + labels + advisor reword as one; the
`release-plan.md` native-sub-issue + `release-train.yml` workflow + sweep sync as
one). Final decomposition is a `/groom` decision; the bundling-by-default
principle (WS-B) applies to grooming *this* SFEP too — do not over-split.

## 4. Effect & capability impact

N/A (process SFEP) — this changes how the project grooms, picks up, and releases
work. It touches no `![effect]` annotations, no capability enforcement, no
compiler pass. The effect system and capability model are unaffected.

## 5. Self-hosting impact

N/A (process SFEP) — no change to `compiler/src/`, `runtime/`, or any `.sfn`
source. The self-hosting invariant (`.claude/rules/selfhost-invariant.md`) is
untouched: nothing here alters the lexer → parser → AST → typecheck → effects →
emitter → LLVM-lowering pipeline. The *only* indirect interaction is positive —
WS-C's batched-seed policy reduces churn on `.seed-version`, making the seed the
self-host build pins against advance on a predictable rhythm rather than
reactively, which lowers the chance of a `/pickup` Phase 1.5 seed-freshness halt.

## 6. Alternatives considered

- **Time-boxed-only cadence (ship strictly on the clock, no scope gate at all).**
  Rejected by the owner in favor of hybrid: a pure time-box would cut even when
  the train carries nothing meaningful, and gives no lever to hold a stable
  promotion until quality bars (green-CI days) are met. The hybrid keeps the
  fixed train *and* a quality gate on promotion.
- **Scope-boxed-only cadence (ship when a fixed scope is complete, no timer).**
  Rejected: this is the status quo's failure mode — without a clock, promotion
  never fires (the Cluster C symptom). A scope-boxed model lets one slow item
  hold the entire release indefinitely. The train's roll-forward semantics
  exist precisely to prevent this.
- **Decouple seeds from the version line (a separate seed channel, e.g.
  `seed-NNN` independent of `0.7.0-alpha.N`).** Rejected by the owner: it adds a
  second version axis and a second cut pipeline for marginal benefit. Keeping
  alphas-as-seeds and simply *batching* the advance onto the cadence achieves the
  goal (collapse N reactive cuts → ~1 scheduled bump) without a new channel.
- **Make the file map binding and just keep it fresh with more frequent
  `/sweep` runs (WS-A alternative).** Rejected: fighting entropy with more
  maintenance passes is strictly more work than removing the entropy's
  load-bearing role. Demoting the map to advisory eliminates the failure mode
  rather than chasing it.
- **Always split capability from consumer for cleaner PRs (WS-B alternative).**
  Rejected: the seed-cut tax (`groom.md` ~L99-110) makes splitting actively cost
  a release cycle when there is a single consumer. Bundling is both cheaper and,
  for a single tightly-coupled consumer, *cleaner in aggregate* (one self-host
  pass, one review).
- **Reactive per-need seed cuts (status quo, WS-C alternative).** Rejected: the
  `0.7.0-alpha.49` treadmill is the evidence. Batching trades a small latency on
  non-critical seed needs for a large reduction in cut/`pin-seed` overhead, with
  the `release-critical-seed` escape preserving urgency where it genuinely
  matters.

## 7. Stage1 readiness mapping

The Stage1 Readiness Checklist governs *language/runtime/tooling* features that
flow through the compiler pipeline. This is a **process** SFEP — it ships no
compiler artifact — so the checklist maps as N/A with the process-equivalent
"done" bar in brackets:

- [ ] Parses — N/A (no language surface) [equivalent: the new template/issue
      contract renders correctly and `/groom` emits a conforming body]
- [ ] Type-checks / effect-checks — N/A (no `.sfn` change)
- [ ] Emits valid `.sfn-asm` — N/A
- [ ] Lowers to LLVM IR — N/A
- [ ] Regression coverage — **applies in process form** (see §8 Test plan):
      dry-run rehearsals of `/pickup` reconciliation, `/release-plan`
      native-sub-issue attachment, and a cadence dry-run
- [ ] Self-hosts — N/A (no compiler-source change; §5)
- [ ] `sfn fmt --check` clean — N/A (the artifacts are Markdown/YAML, not `.sfn`;
      SFEPs and workflow files are not subject to `sfn fmt`)
- [ ] Documented — **applies**: `docs/conventions/issue-naming.md` and the
      `.claude/rules/`/commands updated as the convention of record (execution
      plan items 7, 8, 14)

The process "Implemented" bar (for flipping this SFEP) is: all 16 execution-plan
edits merged, the new rule auto-loaded, the `release-train.yml`/advisor workflows
live, and one full cadence cycle observed end-to-end (one train cut + one batched
seed bump) without a reactive off-cadence cut outside the release-critical bar.

## 8. Test plan

Process changes are validated by **dry-run rehearsal and simulation**, not
`compiler/tests/`:

- **WS-A — drift survival.** Take a real groomed `claude-ready` issue, simulate a
  rename of one file in its `## Files Affected` (and add an in-unit sibling), then
  dry-run `/pickup` Phase 3. **Pass:** the agent reconciles (proceeds, records the
  map drift in the PR-body draft) and does **not** halt. **Negative control:**
  inject a *new acceptance criterion* into the same issue and confirm the agent
  **pauses** — proving the discriminator distinguishes cosmetic drift from
  semantic growth.
- **WS-A — sweep/triage.** Run `/sweep --dry-run` over the `claude-ready` pool
  with a known-stale map and confirm `missing-file` now reports as a **soft note**
  (no defect flag). Run `/triage` (dry-run) on the same issue and confirm it
  proposes a **map refresh** (no line numbers/counts) while leaving scope intact.
- **WS-B — bundle decision.** Replay the #1088-shaped scenario (a runtime issue
  whose "no frontend dependency" premise is false) through `.claude/rules/seed-dependency.md`
  and confirm the tree yields **BUNDLE** for the single-consumer case and
  **SPLIT + queue-against-cadence** for a multi-consumer case. Confirm `/groom`
  produces **one** issue for the single-consumer shape (not two).
- **WS-C — release-plan native sub-issues.** Dry-run `/release-plan` against a
  test `Release: vX.Y.Z` tracker and verify it would **attach native sub-issues**
  (the `/sub_issues` REST call mirrors `groom.md`) and that the tracker's
  "Sub-issues" rollup reflects open/closed state. Reconcile against the markdown
  summary and confirm no drift between the two.
- **WS-C — cadence dry-run.** Trigger `release-train.yml` with `dry_run=true`:
  confirm it opens/updates the tracker, identifies the cadence minor, and would
  dispatch the cut **without waiting** on open items (they roll forward), and that
  it surfaces — but does not auto-fire — the stable promotion gate when the
  tracker is clear and the green-CI-day count is met.
- **WS-C — seed batching.** Simulate two mid-cycle `needs-seed-cut` flags (one
  ordinary, one carrying `release-critical-seed`). Confirm the advisor comment
  **queues** the ordinary one for the next cadence bump and **escalates** the
  release-critical one to "off-cadence cut may be warranted." Confirm `/pin-seed`
  is invoked **once** on the cadence cut, collapsing the ordinary flag.

Each dry-run is run twice (idempotency) to confirm no double-posting/double-
attachment, matching the idempotency discipline `seed-cut-advisor.yml` already
enforces.

## Amendment (2026-07-18): weekly auto-stable train

This amendment **supersedes §3.3 (WS-C — Release cadence)** as originally
designed. The owner-directed shift is from "curated cadence alpha + a
human-confirmed, quality-gated stable promotion" to a **fully automated weekly
stable train**, gated on `main`'s health rather than on a fixed quality timer
or a human sign-off. It does not change WS-A or WS-B.

- **Cadence is now WEEKLY, not bi-weekly.** The prior 2-week/ISO-week-parity
  interval (chosen in §3.3 to match the iteration boundary) is replaced by a
  **weekly** train. `release-train.yml` runs every week rather than every
  other week.
- **The train cuts a STABLE minor directly — no more `channel=alpha
  bump=minor`.** Version rule, applied against the current
  `compiler/capsule.toml` version:
  - If the current version is a prerelease line `X.Y.Z-pre.N`, the train ships
    `X.Y.Z` **stable** (`channel=stable bump=prerelease`).
  - If the current version is already stable `X.Y.0`, the train advances to
    `X.(Y+1).0` (`channel=stable bump=minor`).
  - The former **`pendingStable` HOLD** (refusing to cut the next minor alpha
    while a prior stable line hadn't shipped) is **removed** — it no longer
    applies once the train ships stable directly.
- **The cut gate is a green nightly self-host that covers HEAD's compiler.** A
  train dispatches only when a green `nightly-selfhost.yml` run **covers** the
  compiler at current `main` HEAD — verifying the *behaviour* being released,
  not merely "the latest nightly went green" (which could reflect a stale,
  pre-regression SHA). Coverage is not an exact `head_sha` match: on an
  actively-merged trunk HEAD advances several times an hour while the nightly
  runs once daily and takes up to ~3h, so requiring `head_sha == HEAD` is
  essentially never satisfiable and would stall the train indefinitely (#1956).
  Instead the gate accepts the most recent green nightly whose commit is an
  **ancestor** of HEAD, provided nothing self-host-relevant (`compiler/src`,
  `runtime`, `bootstrap.toml` — the triple-pass build's inputs) changed between
  that commit and HEAD. This preserves the safety the exact-match binding
  reached for — a self-host-breaking commit after the last green nightly makes
  the diff *dirty* and holds the cut — while staying satisfiable: docs / test /
  CI / capsule churn no longer blocks it. `release.yml` re-checks the same
  predicate against `origin/main` at tag time (a `verified_sha` input passed by
  the train), refusing to tag if `main` advanced onto an unverified
  compiler/runtime/seed change — closing the eval→tag race. `ci.yml` is *not*
  part of the gate: it runs on `pull_request`/`merge_group`, never on push to
  `main`, so per-commit single-pass self-host is already guaranteed by the
  merge queue; the nightly adds the triple-pass `make check` the queue does not
  run. If HEAD's compiler is not yet nightly-covered at a cadence boundary, the
  train dispatches a fresh nightly and holds; that nightly's completion
  re-triggers the train (via `workflow_run`) and the cut fires once HEAD is
  covered. There is no longer a separate N-consecutive-green-days quality timer.
  Open release scope (unclosed `release:*`-labeled items) **always rolls forward
  and never blocks the train** — the time-box/roll-forward semantics from the
  original §3.3 design are retained unchanged.
- **The self-host check is the *only* automated quality signal before GA — an
  explicit, owner-directed acceptance.** With stable promotion fully automated,
  the weekly train blesses whatever is on `main` HEAD as GA provided it
  self-hosts (triple-pass) and cleared the merge queue. There is no human
  review, soak period, or scope-completeness check between merge and GA. This
  is a deliberate trade of release-gating rigor for delivery velocity,
  appropriate to the high-merge-rate agentic workflow this repo runs; it is
  recorded here so the reduced safety envelope is a conscious decision, not an
  oversight. Tightening it later (a soak window, an N-green-nightlies timer, a
  smoke-test gate) is a policy dial, not a redesign.
- **Stable promotion is no longer human-confirmed.** The advisory
  human-confirmation step for `channel=stable` dispatch is removed, and
  `stable-promotion-advisor.yml` is **retired**. The weekly train *is* the
  stable-promotion mechanism; there is no separate advisory workflow to
  surface "promotion eligible" for a human to confirm.
- **The seed auto-pins on every green release, and the pin PR auto-merges.**
  Previously the pin advanced in a *draft* PR, once per cadence cycle, against
  only the cadence `*.0-alpha.1` cut, and required a manual merge (§3.3,
  "Seed cuts batched onto the cadence"; `docs/conventions/issue-naming.md`
  "Batched-cadence seeds"). That batching model is superseded: `bootstrap.toml
  [seed].version` now auto-pins on **every** green release — stable or
  prerelease alike — via `cadence-seed-pin.yml`, and the resulting pin PR
  **auto-merges once its own CI is green**, with no manual merge step. This
  decouples seed advancement from the (now weekly) release-train boundary:
  a seed can advance as often as releases go green, not just once per cadence
  cycle. The `release-critical-seed` off-cadence escape hatch (§3.3) becomes
  largely moot under this model since there is no batch to break out of, but
  the marker and the underlying bundle-vs-split decision tree
  (`.claude/rules/seed-dependency.md`, WS-B) are unaffected.
- **Slack notifications** fire on: a new stable release created, a new
  prerelease created, a seed pinned (the auto-merge of the pin PR), and a cut
  blocked (gate not clear) or a train dispatched.

This amendment is recorded here rather than as a rewrite of §3.3 so the
original design rationale (why a hybrid time-box + train, why N=7 days, why
batched seeds) remains legible as prior art; where this amendment and §3.3
conflict, **this amendment governs**. Implementing workflow changes
(`release-train.yml`, `cadence-seed-pin.yml`, the retirement of
`stable-promotion-advisor.yml`) live in `.github/workflows/*.yml` and are
tracked separately from this documentation update.

## 9. References

- `.claude/commands/groom.md` — issue body skeleton; feasibility-probe gate;
  "don't over-decompose / seed-cut tax"; native sub-issue attachment for epics.
- `.claude/commands/pickup.md` — Phase 1.5 seed-freshness precheck; Phase 3 scope
  guard and bundle-vs-split escape; Constraints.
- `.claude/commands/release-plan.md` — markdown-checkbox tracker bookkeeping (the
  surface WS-C replaces with native sub-issues).
- `.claude/commands/sweep.md` — Phase 2b release-tracker sync; Phase 3
  `missing-file` flagging.
- `.claude/commands/triage.md` — `claude-ready` hygiene (the map-refresh host).
- `.github/workflows/seed-cut-advisor.yml` — deterministic `needs-seed-cut`
  advisory the WS-C cadence reframes.
- `docs/conventions/issue-naming.md` — release tracking, seed pinning, `release:*`
  gating labels, `seed-blocker`/`needs-seed-cut` lifecycle, 2-week iteration
  cadence.
- `.github/AGENTS.md` — the ≤2 concurrent agent-authored PR budget (cadence-load
  context).
- `compiler/capsule.toml` (`0.7.0-alpha.49`), `.seed-version` (`0.7.0-alpha.49`) —
  evidence for the alpha-as-seed treadmill.
- SFEP-0001 (`docs/proposals/0001-sfep-process.md`) — process-SFEP precedent and
  required-section standard.
