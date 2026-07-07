# Issue and Epic Naming Conventions

This is the canonical reference for issue/PR titling and labelling on
`sailfinio/sailfin`. Every workflow under `.github/workflows/`, every Claude
slash command under `.claude/commands/`, and every issue template is required
to follow it.

The label registry lives in `.github/labels.yml` and is auto-synced to GitHub
by the `Sync Labels` workflow on every push to `main`. Maintainers can also
run `scripts/setup-github-labels.sh` manually.

---

## Lifecycle (issue state machine)

```
                                       ┌────────────────┐
                                  ┌────►│ needs-grooming │
                                  │     │ (placeholder)  │
                                  │     └────────┬───────┘
              human files issue ──┘              │  fill scope/criteria
                                                 ▼
                                       ┌────────────────┐
                              ┌───────►│  needs-design  │◄──── grooming agent
                              │        │  (architect    │
                              │        │   queue)       │
                              │        └────────┬───────┘
                              │                 │
                              │  needs-discussion (parked, awaits human)
                              │                 │
                              │                 ▼
                              │        ┌────────────────┐
                              │        │ design-approved│  ── architect gate
                              │        └────────┬───────┘
                              │                 │
                              │                 ▼
                              │        ┌────────────────┐
                              │        │  claude-ready  │  ── eligible for /pickup
                              │        └────────┬───────┘
                              │                 │
                              │                 ▼
                              │        ┌────────────────┐
                              │        │   in-progress  │
                              │        └────────┬───────┘
                              │                 │
                              │                 ▼
                              │        ┌────────────────┐
                              │        │   PR opened    │
                              │        │ (issue closes  │
                              │        │  on merge via  │
                              │        │  Closes #N)    │
                              │        └────────────────┘
                              │
                  ── if blocker found anywhere above ──► `blocked`
```

## PR lifecycle

```
PR opened (engineer) ──► needs-review ──► (review agents run)
                                       │
                                       ├──► needs-changes ──► engineer pushes ──► needs-review
                                       │
                                       └──► approved ──► human merges
```

Plus the orthogonal markers `agent-authored` (every PR opened by an
autonomous agent — counts toward the budget gate) and `security` (Security
review attached or required).

---

## Title taxonomy

There are **four human-authored title shapes** (sub-task, epic, tracking,
focus) plus **one reserved auto-generated prefix** (`[aw]`). Anything else
is a bug.

### 1. Sub-task (the default — what most issues and PRs are)

Conventional Commit form so the merged PR title lands as a clean commit:

```
<type>(<scope>): <imperative verb phrase>
```

| Field      | Allowed values |
|------------|----------------|
| `<type>`   | `feat`, `fix`, `perf`, `refactor`, `chore`, `docs` (must match the `type:*` label below) |
| `<scope>`  | The primary subsystem touched. Use one of: `compiler`, `parser`, `typecheck`, `effects`, `lowering`, `emit`, `runtime`, `runtime-c`, `prelude`, `build`, `ci`, `cli`, `agents`, `docs`, `site`, `make`. Multiple scopes? Pick the most specific or split the issue. |
| `<verb>`   | Lowercase imperative. `add`, `remove`, `rename`, `flip`, `register`, `port`, `inline`, `dedupe`, `delete`, … |

**Examples:**

```
feat(typecheck): register extern fn declarations
fix(lowering): emit valid LLVM for empty struct literal
perf(ci): cache compiler binary across CI jobs
refactor(emit): split emit_native_ops into ops/ submodule
docs(spec): document Result and ? operator semantics
chore(build): delete prior scripts/build.sh now retired post --work-dir cutover
```

The `<type>` prefix and the `type:<type>` label MUST agree:

| Title prefix | Label         |
|--------------|---------------|
| `feat`       | `type:feature`  |
| `fix`        | `type:bug`      |
| `perf`       | `type:perf`     |
| `refactor`   | `type:refactor` |
| `chore`      | `type:tech-debt` |
| `docs`       | `type:docs`     |

### 2. Epic (parent of multiple sub-tasks)

```
Epic: <track-id>: <noun phrase>
```

| Field | Definition |
|-------|------------|
| `<track-id>` | Stable identifier from the roadmap. Examples: `M0`, `M1.5`, `M2`, `T1`, `T7`, `SR` (syntax reform), `EFF` (effect system hardening). New track IDs are added to the roadmap first. |
| `<noun phrase>` | Title-case, scope-positive description of the outcome. |

**Examples:**

```
Epic: M2: Core Runtime in Sailfin
Epic: M3: Capability Adapters in Sailfin + Delete C Runtime
Epic: T1: Per-module memory budget under 800 MB
Epic: T7: Compiler decomposition into sub-capsules
Epic: SR: Pre-1.0 syntax reform
```

Always paired with the `epic` label. Children link back via `Blocked by` /
`Parent: #<N>` references in their bodies.

### 3. Tracking issue (cross-cutting status, not directly implementable)

```
Tracking: <topic> (<YYYY-MM-DD>)
```

The date is when the tracker was opened (not when the work happens). Use a
tracking issue when you want a single thread to coordinate multiple PRs but
no single PR closes it.

**Examples:**

```
Tracking: Runtime Rewrite Reassessment & Sequencing (2026-05-06)
Tracking: Build Performance & Production-Readiness (2026-05-06)
```

Always paired with the `tracking` label. Tracking issues are explicitly
**not** `claude-ready` — they are coordination surfaces, not work items.

### 4. Focus issue (planner output, weekly)

```
Focus: Week of YYYY-MM-DD
```

The Monday of the current ISO week in UTC. Generated by `planner.md`; do not
hand-author. Always paired with `focus:proposed` (planner) or `focus:approved`
(human).

### Reserved: `[aw]` (auto-generated workflow-failure issues)

The gh-aw harness opens `[aw] <Workflow Name> failed` issues automatically
when an autonomous workflow crashes. This is **not** one of the four
human-authored shapes — it's a reserved prefix the system manages.
Leave the `[aw]` prefix in place; downstream tooling pattern-matches on it.

---

## Label rules

| Rule | Why |
|------|-----|
| Every active issue carries exactly one `type:*` label | `/pickup` routes by it |
| Every `claude-ready` issue carries exactly one `size:*` label | `/pickup` and `/sweep` rank by it |
| Use `priority:*` only when prioritisation matters; default is no priority label | Avoids label inflation; absence ≠ low |
| Apply `area:*` labels when the touched subsystem is unambiguous | Helps `/sweep` dedupe collisions |
| `epic` and `tracking` are mutually exclusive | They mean different things |
| Never re-introduce a bare alias (`bug`, `runtime`, `medium`, …) | They are listed in `aliases:` of `labels.yml` and will be migrated away on the next sync |
| Never invent a new label in a workflow or slash command | Add it to `labels.yml` in a separate PR first |

### Labels that gate the agentic pipeline

These are the load-bearing labels — every workflow under `.github/workflows/`
checks at least one of them:

| Label | Gate |
|-------|------|
| `focus:approved` | `nightly-grooming` and (soft) `engineer` will not act without it |
| `needs-design` | Triggers `architect-review.md` |
| `design-approved` | Triggers `engineer.md` |
| `type:bug` | Also triggers `engineer.md` (urgent fixes bypass focus gate) |
| `agent-authored` | `engineer.md` budget gate counts these — without it the gate breaks |
| `needs-changes` | Re-triggers engineer to address feedback |

---

## Intent-authoritative issues (contract vs. advisory map)

A groomed issue's **contract** is its **Goal** plus a **semantic `In:`/`Out:`
scope**. The `## Files Affected` block is an **advisory map** — a navigation aid
that is *expected to drift* and is reconciled at pickup, never a checklist that
gates correctness. This is the convention of record; `/groom`, `/pickup`,
`/sweep`, and `/triage` all cite it rather than each restating the rule.

**Why.** Between grooming and pickup the codebase moves — files split, get
renamed, gain siblings in the same module. If the file map is treated as binding,
`/pickup` halts on cosmetic drift it cannot distinguish from real scope growth,
and `/sweep` flags decaying precision as a defect. Making *intent* authoritative
and the *map* advisory removes that failure mode instead of fighting its entropy.

### Express scope as semantic units, not files

`In:`/`Out:` lines name **semantic units of change**, not paths — e.g. "the
effect-checker diagnostic emission for missing `![io]`", not "`effect_checker.sfn`
lines X-Y". A new sibling file *inside* that unit (after a split that moved the
emission into `effect_checker/diagnostics.sfn`) is then **in scope by
construction** — the unit, not the path, defines the boundary.

### Banned in any groomed issue body

- **Line numbers** anywhere (`L142`, `~L100-135`) — they rot fastest and carry
  no semantic weight.
- **Exact file counts** ("edit these 3 files", "two call sites") — a count turns
  an in-unit Nth sibling into a phantom scope violation.
- **Closed file enumerations presented as exhaustive** — `## Files Affected`
  lists paths as *likely-relevant starting points*, explicitly non-exhaustive.

### The In/Out semantic boundary contract (what `/pickup` applies)

At pickup, before implementing, the agent re-derives the current surface for each
`In:` unit and compares it against the advisory map:

- **In-scope — reconcile, proceed, and record in the PR (never halt):**
  - a `## Files Affected` path was **renamed/moved** → use the new path;
  - an `In:` unit is now spread across **additional sibling files** in the same
    module → touch them all;
  - a map file **no longer exists** because its content merged into a sibling
    already covered by the same `In:` unit → follow the content;
  - the **same public surface** is reached through a refactored internal call
    path → follow it.
- **Out-of-scope — PAUSE, comment, do not proceed:**
  - a **new acceptance criterion** the issue did not list is required;
  - a **new public/user-facing surface** (CLI flag, exported symbol, diagnostic
    code) not implied by the Goal;
  - the change must reach a **different semantic unit** than `In:` names;
  - honoring `Out:` becomes **impossible**.

The discriminator is one question: **does the Goal plus the semantic `In:`/`Out:`
still hold?** If yes, the drift is cosmetic — reconcile and record it (the
`/pickup` PR-body "Map reconciliation" line). If a new criterion or surface is
required, that is real growth — pause for human input.

### Command responsibilities

- **`/groom`** emits `## Files Affected` as an advisory, non-exhaustive map and
  `In:`/`Out:` as semantic units; never line numbers or counts.
- **`/pickup`** reconciles cosmetic map drift and records it; pauses only on
  semantic scope growth (the Out-of-scope list above).
- **`/sweep`** reports a missing `## Files Affected` path as a **soft note**
  ("advisory map may be stale — `/triage` can refresh"), not a defect flag.
- **`/triage`** refreshes a stale advisory map (re-derives paths, no line
  numbers/counts) when Goal + semantic scope are intact.

## Issue tracking

**Labels are the sole source of truth.** The former GitHub Project board
(*Sailfin Tracker*, org project #4) and its label→board sync workflow have been
**retired**. Issue state lives entirely in GitHub labels; `priority:*`/`size:*`
labels carry priority and size directly, and the GitHub native parent/child
relationship carries sub-issue nesting. Epic and roadmap-level grouping now lives
in **Linear** — Linear Projects correspond to epics, while session-sized leaf
work stays as GitHub issues mirrored into Linear by the GitHub↔Linear integration.

### Status semantics

A single status is derived from issue state plus labels, first match wins. This
precedence is the convention `/triage` and `/sweep` apply. The GitHub↔Linear
integration mirrors the **labels** themselves into Linear; a Linear issue's
board status is owned natively in Linear and was seeded from this same
precedence — Linear does not continuously recompute status from the labels.

| Signal | Status |
|--------|--------|
| Issue closed (or PR merged for linked PRs) | `Done` |
| `in-progress` label | `In progress` |
| `blocked` label | `Blocked` |
| `claude-ready` label (no blocker) | `Ready` |
| `needs-grooming` / `needs-design` / `design-approved` | `Backlog` |
| No status-bearing label | `To triage` (implicit default) |

Notable invariants:

- **`To triage` is not a label.** It is the implicit default for an issue that
  carries no status-bearing label (`in-progress` / `blocked` / `claude-ready` /
  `needs-grooming` / `needs-design` / `design-approved`) — not a value written
  anywhere on the issue.
- **`blocked` beats `claude-ready`.** A blocked-but-groomed issue reads as
  `Blocked`, not `Ready`, so the ready set is always pickable.
- **`In review` is intentionally not derived** for issues. An issue with
  `in-progress` keeps that status across PR-open → review → merge → close; the
  PR side of GitHub already tracks review state.

## Linear structure & naming

Epic and roadmap-level grouping lives in Linear, in two tiers above the GitHub
issues. Keep it consistent:

| Tier | Represents | Naming |
|------|------------|--------|
| **Initiative** | a pillar or durable workstream | Theme name in Title Case. A small, stable set (e.g. *Capability-Sealed Runtime*, *Structured Concurrency*, *Build & Toolchain*). Rarely added. |
| **Project** | one epic | The deliverable as a concise Title-Case noun phrase, ≤ ~60 chars. Drop `Epic:` / `Tracking:` prefixes and any trailing `#N` / `SFEP-NNNN`. e.g. `CLI Modularization`, not `Epic: CLI modularization (SFEP-0027)`. |
| **Issue** | a session-sized leaf | Unchanged — a GitHub issue with a Conventional-Commit title (above), mirrored into Linear. |

**Cross-links go in the project description, not the name.** Each Linear project's
description carries the traceability the name omits:

- `GitHub: #N` — the epic's GitHub tracking issue, when one exists.
- `Design: SFEP-NNNN` — the governing proposal, when one exists.

This keeps project names scannable while preserving the link back to the design
record and the GitHub epic. A project belongs to exactly one initiative; a leaf
issue belongs to exactly one project.

When an epic is groomed, `/groom` creates (or reuses) a Linear Project under the
right initiative following this convention, files the session-sized leaves as
GitHub issues that mirror into it, and reflects their state per **§ Reflecting
state into Linear** below. A Linear-sync GitHub Action (using the Actions
`LINEAR_API_KEY`) can later make the same reflection fire on label changes made
outside the skills; until then the skills are the reflection path.

## Reflecting state into Linear

Linear mirrors GitHub issues (via the GitHub↔Linear integration) and holds the
epic/roadmap grouping (Linear Projects = epics). GitHub labels stay the **source
of truth**; Linear status and project membership are **derived from them, one
direction only** — never read Linear state back onto a GitHub issue.

When a workflow (`/groom`, `/triage`, `/sweep`) creates an issue or flips a
status-bearing label, it reflects the change into Linear with the Linear MCP
tools (`list_issues`, `save_issue`, `list_projects`, `save_project`). This is
**best-effort**: if the Linear MCP tools are not connected in the session, skip
the reflection with a one-line note — never fail or block the GitHub-side work
on it (the same posture the skills take when `gh` is unavailable).

1. **Find the mirror.** A GitHub issue's Linear mirror is located with
   `list_issues` querying the issue's number or URL (the integration records the
   GitHub link on the mirror). A newly-created issue mirrors in
   **asynchronously** — allow a brief lag and retry a few times; if the mirror
   still isn't present, record it and let the next `/triage`/`/sweep` pass
   reconcile it. Never block on it.
2. **Set issue status from labels** using the § Status semantics precedence
   (first match wins). **Never** write `Done`, `Canceled`, or any terminal
   status onto a mirror whose GitHub issue is still open — the two-way sync would
   close the GitHub issue. Only the non-terminal statuses (In Progress, Blocked,
   Ready, To triage, Backlog, Todo) are ever written.
3. **Assign the issue to its epic's Project** if it isn't already, resolving the
   Project from the epic (`epic`/parent reference) and creating it per § Linear
   structure & naming when it doesn't exist yet.
4. **Roll up the Project status** from its issues: any issue In Progress →
   Project `started`; else any Ready → `planned`; else `backlog`. Never
   `completed`/`canceled` from a workflow.

## Release tracking

Milestones group long-lived **themes** (and feed `site/src/pages/roadmap.astro`).
They span many releases. To answer "what ships in version X" we use a separate
axis: the **`release:*` label namespace** plus a **per-cycle tracking issue**.

### When release tracking applies

There is exactly one **uncurated** combination — it takes whatever is on
`main` and skips the release-tracking gate entirely:

- `channel=alpha bump=prerelease` (the routine daily alpha bump)

**Every other combination is curated** and consults the `release:*` labels:

- Any `bump=patch`, `bump=minor`, or `bump=major` (in any channel)
- Any promotion to a non-alpha channel (`beta`, `rc`, `stable`)

For curated cuts `/release` lists the open items under the matching
`release:*` label and the tracking issue, and requires explicit
confirmation before dispatching. The gate is advisory — the human always
has the final call.

### Labels

| Label | Hard gate at | Soft signal at |
|-------|--------------|----------------|
| `release:next-minor` | `bump=minor` (next 0.X.0) | `bump=patch`, beta promotion |
| `release:beta` | promotion to `channel=beta` | rc promotion |
| `release:rc` | promotion to `channel=rc` | stable promotion |
| `release:stable` | promotion to `channel=stable` | — |
| `release:1.0` | `bump=major` to 1.0.0 | `bump=minor` |

Multiple labels may co-exist on one issue (e.g. an item may gate both the
beta promotion *and* the 1.0 GA). The labels are intent — they declare *when*
something must ship, not *what theme it belongs to* (that's the milestone).
"Hard gate" means `/release` lists every open issue holding the label and
requires explicit override; "soft signal" means it's mentioned as context
but doesn't block.

`bump=patch` cuts have no hard label gate — they're curated only in the
sense that `/release` confirms the user wants a new patch line (rather
than another alpha prerelease).

### Tracking issue (`Release: vX.Y.Z`)

For each meaningful upcoming version, open one tracking issue titled exactly
`Release: vX.Y.Z` (e.g. `Release: v0.6.0`, `Release: v1.0.0`). Apply the
`tracking` label. Body is a checklist of "must close before cutting" items
linking to the issues/PRs holding the corresponding `release:*` label.

`/release` looks up the tracking issue by title when the bump/channel combo
is curated, surfaces unfinished items, requires explicit confirmation if any
are open, and posts a comment on the tracking issue after a successful
dispatch.

Don't open a tracking issue for routine alpha bumps. The cost is in the
curation, not the issue.

## Seed pinning

The Sailfin compiler self-hosts from a released seed binary. The pin
lives at `.seed-version` (single-line file at repo root) and is read by
`make fetch-seed`, `ci.yml`, `nightly-selfhost.yml`, and
`release-branches.yml`. **Bumping the pin is a separate concern from
cutting a release** — `release.yml` deliberately doesn't touch
`.seed-version` because the new binary doesn't exist at tag-creation
time and most alpha releases shouldn't be pinned.

**Seeds advance on the cadence, batched.** Per SFEP-0026 WS-C, the pin is
**not** chased reactively per-need (the `0.7.0-alpha.49` treadmill). Routine
seed needs are collected and the pin advances **once per release cadence
cycle**, against that cycle's alpha cut — collapsing the N reactive cuts of a
cycle into ~1 scheduled bump. The one exception is a **release-critical** seed
need (see below), which may break the batch.

### `seed-blocker` label

Apply `seed-blocker` to any issue whose fix or feature must land
**before the next seed bump**. Examples:

- A miscompilation in the current seed that breaks downstream work.
- A new compiler feature the next workstream depends on.
- A test-runner / CI fix needed before nightly self-host can pass.

`/release-plan` lists open `seed-blocker` issues alongside the
release-gating set when opening a tracking issue. `/sweep` auto-ticks
matching checklist items when a `seed-blocker` issue closes via a
merged PR.

A `seed-blocker` issue does **not** trigger a reactive cut on its own.
Its seed advance is **batched onto the next cadence bump** (below) unless
the need clears the release-critical bar.

### Batched-cadence seeds and the `release-critical-seed` marker

Mid-flight seed needs — a `needs-seed-cut` flag from the advisor, or a
`seed-blocker` issue closing — **queue against the next scheduled cadence
seed bump** by default. `/pin-seed` runs **once per cadence** against that
cycle's alpha cut; it is not run reactively for each individual need. This
is the SFEP-0026 §3.3 batching policy: trade a small latency on
non-critical seed needs for a large reduction in cut/`pin-seed` overhead.

**The release-critical bar (the only thing that breaks the batch).** A
mid-flight seed need may force an **off-cadence** seed cut only if **all
three** hold (SFEP-0026 §3.3):

1. It **unblocks an item on the current `release:next-minor` / `release:1.0`
   hard gate** — the train cannot ship its committed scope without it; **and**
2. **No bundle path exists** — per `.claude/rules/seed-dependency.md`, it is a
   genuine multi-consumer or independent capability that cannot be folded into
   one PR with its consumer; **and**
3. Waiting for the next cadence bump would **slip the train's committed scope**
   (not merely defer a nice-to-have to the next train).

A need that fails **any** clause queues for the next cadence bump. A
miscompilation / seed-bug that breaks *active* downstream work clears the bar
by construction — it is release-critical because it blocks the gate.

**`release-critical-seed` marker lifecycle.** Apply `release-critical-seed`
to a seed need (the dependent issue or, for a seed-bug, the predecessor) that
clears the bar above. It is the signal that distinguishes "break the batch"
from "queue for cadence":

- **Applied by** grooming or a human when the three-clause bar is met — never
  auto-applied. It is orthogonal to `needs-seed-cut`/`seed-blocker` and
  typically co-exists with them.
- **Read by** the seed-cut advisor, which escalates its advisory comment from
  "queued for the next cadence bump" to "off-cadence seed cut may be warranted"
  when a flagged dependent (or a just-closed predecessor) carries it. The
  advisor only reads the marker — it stays flag-only and never dispatches a cut.
- **Consumed by** `/release-plan`, which surfaces release-critical seed needs
  separately from the batched queue.
- **Cleared** when the off-cadence cut lands and `/pin-seed` runs, or when the
  need is reclassified as non-critical (then it rejoins the cadence batch).

### `## Required in pinned seed` issue section

Sub-task issues that depend on a predecessor's compiler-source change
being **in the seed binary** (not just merged on `main`) use a dedicated
`## Required in pinned seed` body section, separate from `## Blocked by`.
The contract:

- `## Blocked by` means "must be closed/merged before pickup starts."
- `## Required in pinned seed` means "the merged code must be present
  in the binary that `make compile` uses."

When grooming, populate `## Required in pinned seed` for any sub-task
that touches `compiler/src/` or `runtime/prelude.sfn` and depends on
a predecessor's compiler-source change. Apply `seed-blocker` to the
**predecessor** issue. `/pickup` Phase 1.5 verifies the precondition
via `git merge-base --is-ancestor <merge-sha> <seed-tag>` before
claiming, and refuses to start if the predecessor is merged but not
seeded. The previous Slice E.2 attempt (issue #489) failed because
this gate was implicit instead of explicit.

For issues groomed before this section existed, `/pickup` Phase 1.5
falls back to checking every `## Blocked by` reference if the issue
touches compiler-source files.

### Seed-cut advisor (automated)

`/pickup` Phase 1.5 is the strict gate, but it only fires when an agent
is actively trying to claim an issue. The **seed-cut advisor**
(`.github/workflows/seed-cut-advisor.yml`) is the complementary
visibility layer: a plain, deterministic Actions workflow (no gh-aw, no
LLM) that runs on every PR merge to `main`. When a merged PR closes an
issue that an open, `release:next-minor`, compiler-touching issue lists
under `## Required in pinned seed` (or, legacy, `## Blocked by`), the
advisor:

- comments on the **active** `Release: vX.Y.Z` tracker (resolved
  dynamically — open issue, `tracking` label, `Release: vX.Y.Z` title;
  never hardcoded) with an `Auto-advisor:` line naming the merged PR and
  the dependent issues, and
- applies the `needs-seed-cut` label to the tracker and the dependent
  issues.

By default the advisory comment reads **"queued for the next cadence seed
bump"** — the `needs-seed-cut` flag means the seed advance is batched onto
the cadence, not cut now. **Only** when a flagged dependent (or one of the
just-closed predecessors) carries `release-critical-seed` does the comment
escalate to **"off-cadence seed cut may be warranted"** (it clears the
release-critical bar above).

It is idempotent (one advisory per PR per tracker) and **only flags** —
it never dispatches `release.yml` or bumps `.seed-version`, and it never
applies `release-critical-seed` (that marker is human/grooming-applied; the
advisor only reads it). `/release-plan` consumes the `needs-seed-cut` label,
surfacing a "Seed cut required" checklist section on the per-cycle tracking
issue. A queued flag clears when the cadence `/pin-seed` lands; a
release-critical flag clears when its off-cadence `/pin-seed` lands. Remove
the label once pinned.

### When to bump the pin

The routine bump rides the cadence (one batched `/pin-seed` per cycle, above).
Run `/pin-seed [vX.Y.Z]` off-cadence only when the need clears the
release-critical bar:

- A `seed-blocker` issue just closed and the fix shipped in the latest
  alpha.
- Downstream work needs a feature/fix that landed in a recent alpha.
- A `bump=patch` was just cut (almost always implies a hotfix-pin).
- Nightly self-host shows drift between the seed and trunk that the
  build cache can't smooth over.

### When NOT to bump the pin

- A routine alpha that fixes nothing the current working set needs.
- A `seed-blocker` issue is still open (unless deferring is intentional).
- `release-tag.yml` is still running for the target — wait for the
  binary upload.
- The current pin is < 5 alphas behind and CI is green — the pin is
  working; don't churn it.

### Patch-a-seed flow (hotfix)

When a current-seed bug breaks downstream work:

1. Land the fix on `main` (regular PR + merge).
2. `/release` with `channel=alpha bump=prerelease` to cut an alpha
   containing the fix.
3. Wait for `release-tag.yml` to upload the binary (a few minutes).
4. `/pin-seed` to open the one-line bump PR.
5. Merge the pin PR → CI/nightly/`make fetch-seed` start using it.
6. Rebase the blocked branch onto `main`.

The pin PR lives off `main` (never `claude/*`), is reviewed even though
it's one line, and is never auto-merged — it cascades through every
workflow that reads `.seed-version`.

## Milestones

Milestones are phase markers, not calendar deadlines. Every `epic` issue
should carry exactly one milestone; sub-task issues inherit the milestone
of their parent epic via the GitHub parent/child link.

| Milestone | Track IDs | Captures |
|-----------|-----------|----------|
| `M1: Compiler Stabilization` | `M0`, `M1`, `T1` | Phase 1 systems primitives, build pipeline correctness, compiler perf |
| `M1.5: Drop Emission` | `M1.5` | Deterministic scope-exit drops; hard prereq for M2 |
| `M2: Runtime in Sailfin` | `M2` | Replace C runtime with pure Sailfin (arena, string, array, io, exception, …) |
| `M3: Structured Concurrency` | `M3` | `routine`/`await`/`channel`/`spawn` plus atomic intrinsics |
| `Effect System Hardening` | `EFF` | Compile-gate enforcement, hierarchical effects, transitive call-graph checking — runs in parallel with runtime work |
| `1.0 — General Availability` | `T7` | Pure Sailfin toolchain (M5 retired `native_driver.c`; remaining C helpers retire pre-1.0), all enforcement gates active |

---

## Slice E `// alias-coverage` convention

During the Slice E numeric-types migration (track `M0`, epic #424) every
preserved reference to the `number` type in `compiler/src/` and
`runtime/prelude.sfn` carries a trailing `// alias-coverage: <reason>`
comment.  This applies to two categories of sites:

1. **Type-annotation sites** — `: number` or `-> number` in source declarations.
   These are tracked by the audit grep:

```bash
grep -rnE "(: number|-> number)" compiler/src/ runtime/prelude.sfn \
  | grep -v "// alias-coverage" \
  | grep -v ":[[:space:]]*//"   # exclude comment-only lines (false positives)
# Must return ONLY sites that bulk-migration PRs still need to migrate.
```

2. **String-branch seams** — `== "number"` comparisons that dispatch on the
   Sailfin type name and will need to split when `int`/`float` arrive.  These
   are not caught by the audit grep above but are tagged for the same reason.

**Contract:**

- A site is **preserved** (opt-out from bulk migration) only when the `number`
  reference is intentional and semantic: Future mapping seams, runtime
  type-guard predicates, or numeric-type values that are not integer counters.
  Every such site carries the marker.
- A `(: number|-> number)` site is **in scope** (will be migrated in a bulk
  PR) when `number` is used as an integer counter, index, or size.  These
  sites must **not** carry the marker.
- Bulk migration PRs must not introduce new untagged `: number` or
  `-> number` sites in `compiler/src/` or `runtime/prelude.sfn`.
  Reviewers should run the audit grep above before approving.

**Suggested tag reasons** (keep short and consistent):

| Situation | Tag value |
|-----------|-----------|
| `== "number"` branches that will split for `int`/`float` | `Future mapping seam (Slice E.2 follow-up)` |
| Runtime `is_number` / `check_type_primitive` guard | `runtime type-guard predicate keyword` |
| Numeric-type value that is not an integer counter (e.g. float-valued) | `number-type value (not an integer counter)` |

---

## Track ID directory

Reserved track IDs (extend by editing the roadmap, then this list):

| ID    | Track |
|-------|-------|
| `M0`  | Foundational language primitives (atomics, `Result`, `?`) |
| `M1`  | Phase 1 systems primitives (extern fn, integer types, raw pointers) |
| `M1.5`| Drop emission |
| `M2`  | Core runtime in Sailfin |
| `M3`  | Capability adapters (filesystem, HTTP, model) + port remaining C helpers to Sailfin |
| `T1`  | Per-module memory budget under 800 MB |
| `T2`  | Build performance — pipeline parallelism |
| `T3`  | Build performance — IR caching |
| `T4`  | Build performance — link/lower/emit |
| `T5`  | Long-lived compiler process |
| `T6`  | LLVM C-API binding (eliminate textual IR round-trip) |
| `T7`  | Compiler decomposition into sub-capsules |
| `SR`  | Pre-1.0 syntax reform |
| `EFF` | Effect system hardening (validate_effects() in main.sfn, hierarchical effects) |

If you need a new track, propose it in the roadmap PR — don't introduce ad-hoc
prefixes (`Slice E`, `R.0`, etc.) in epic titles. Sub-tasks of a track ride
on the Conventional Commit shape and reference the track in the body.
