# Issue and Epic Naming Conventions

This is the canonical reference for issue/PR titling and labelling on
`sailfinio/sailfin`. Every workflow under `.github/workflows/`, every Claude
slash command under `.claude/commands/`, and every issue template is required
to follow it.

The label registry lives in `.github/labels.yml` and is auto-synced to GitHub
by the `Sync Labels` workflow on every push to `main`. Maintainers can also
run `scripts/setup-github-labels.sh` manually. Linear labels are intentionally
smaller: use native Linear fields for status, priority, estimate, Project,
Cycle, blockers, and assignee.

---

## Lifecycle (Linear state machine)

Workflow state is **Linear-native** — every node below is a Linear *status*, not
a GitHub label. GitHub is only an intake surface: an external-contributor issue
mirrors into Linear and its optional `needs-grooming` / `needs-design` **intake
hints** (see § *Status semantics (GitHub intake → Linear)*) just pick the initial
status. Those hints are never applied to a Linear-native `SFN-NNN` issue — the
status field already carries grooming/design state.

```
  GitHub intake (external contributors only)
  ┌──────────────────────────────────────────┐
  │ human files issue → mirrors into Linear;  │
  │ the initial Linear status comes from the  │
  │ intake signal (see § Status semantics):   │
  │ no hint → Triage, a needs-grooming /      │
  │ needs-design hint → Backlog               │
  └───────────────────────┬──────────────────┘
                          ▼ (no hint)
  Linear status (source of truth)
        ┌──────────┐   /groom shapes scope,
        │  Triage  │   criteria, estimate, type
        └────┬─────┘
             ▼
        ┌──────────┐   groomed but not yet scheduled / design pending;
        │ Backlog  │   ◄── intake with a grooming/design hint enters here
        └────┬─────┘
             ▼
        ┌──────────┐  ── eligible for /pickup
        │  Ready   │
        └────┬─────┘
             ▼
        ┌────────────┐
        │ In Progress│  ── /pickup claims + branches claude/sfn-N-…
        └────┬───────┘
             ▼
        ┌────────────┐  PR opened (Fixes SFN-N);
        │ In Review  │  Done on merge via Linear's GitHub integration
        └────┬───────┘
             ▼
        ┌──────────┐
        │   Done   │
        └──────────┘

  ── a blocker anywhere above ──► Blocked (via a Linear blocked-by relation)
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

There are **two recurring GitHub issue title shapes** — the sub-task (default)
and the planner-generated focus issue — plus the **`Release: vX.Y.Z`** cadence
tracker and **one reserved auto-generated prefix** (`[aw]`). Anything else is a
bug.

> **Epics and trackers are not GitHub issues.** An epic is a Linear **Project**
> (under an Initiative); a cross-cutting status thread is that Project itself.
> The historical `Epic:` / `Tracking:` GitHub title shapes are **retired** — see
> § 2 and § 3 below and the playbook in
> [`linear-workflow.md`](./linear-workflow.md). The **one** surviving tracking
> title is `Release: vX.Y.Z` (release automation owns it — see § *Release
> tracking*).

### 1. Sub-task (the default — what most issues and PRs are)

Conventional Commit form so the merged PR title lands as a clean commit,
with the Linear issue id appended so `SFN-NNN` is visible at a glance in the
PR list and the squashed commit:

```
<type>(<scope>): <imperative verb phrase> (SFN-NNN)
```

The trailing `(SFN-NNN)` is required on any PR that completes a Linear leaf
(omit it only for a PR with no backing issue). It keeps the Conventional
Commit prefix parseable while surfacing the issue id in the title; the body
still carries `Fixes SFN-NNN` as the machine-readable link that drives Linear
workflow state.

| Field      | Allowed values |
|------------|----------------|
| `<type>`   | `feat`, `fix`, `perf`, `refactor`, `chore`, `docs` (must match the `type:*` label below) |
| `<scope>`  | The primary subsystem touched. Use one of: `compiler`, `parser`, `typecheck`, `effects`, `lowering`, `emit`, `runtime`, `runtime-c`, `prelude`, `build`, `ci`, `cli`, `agents`, `docs`, `site`, `make`. Multiple scopes? Pick the most specific or split the issue. |
| `<verb>`   | Lowercase imperative. `add`, `remove`, `rename`, `flip`, `register`, `port`, `inline`, `dedupe`, `delete`, … |

**Examples:**

```
feat(typecheck): register extern fn declarations (SFN-412)
fix(lowering): emit valid LLVM for empty struct literal (SFN-518)
perf(ci): cache compiler binary across CI jobs (SFN-233)
refactor(emit): split emit_native_ops into ops/ submodule (SFN-346)
docs(spec): document Result and ? operator semantics (SFN-107)
chore(build): delete prior scripts/build.sh now retired post --work-dir cutover (SFN-901)
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

### 2. Epic — **retired as a GitHub issue; use a Linear Project**

An epic is now a **Linear Project** under an Initiative, not a GitHub issue.
See § *Linear structure & naming* below and the playbook in
[`linear-workflow.md`](./linear-workflow.md). Name the Project for its outcome
(`CLI Modularization`), drop the `Epic:` prefix and any track-id / `#N` /
`SFEP-NNNN`, and put `GitHub: #N` + `Design: SFEP-NNNN` in the Project
**description**.

Do **not** open a new `Epic:` GitHub issue. The legacy `epic` label is retired
and deleted by `.github/labels.yml`; `/groom` creates a Linear Project and files
only session-sized leaves.

### 3. Tracking issue — **retired; the Project (or Initiative) is the tracker**

Cross-cutting status no longer lives in a GitHub `Tracking:` issue. The Linear
Project rolls up its issues' state, and an Initiative groups related Projects —
that *is* the coordination surface. Do not open new `Tracking:` issues or apply
the `tracking` label to new work.

**One exception:** the per-cycle **`Release: vX.Y.Z`** issue survives, because
release automation (`release.yml`, `/release-plan`) keys off it and the
`release:*` labels. A release is a Linear **Cycle**, never a Project — see
§ *Release tracking*.

### 4. Focus issue (legacy planner output)

```
Focus: Week of YYYY-MM-DD
```

The Monday of the current ISO week in UTC. This was generated by the retired
GitHub Agentic Workflows planner. Do not open new focus issues unless the
planning workflow is redesigned; use Linear Projects/Cycles for active planning.

### Reserved: `[aw]` (retired workflow-failure issues)

The retired gh-aw harness opened `[aw] <Workflow Name> failed` issues
automatically when an autonomous workflow crashed. This is **not** one of the
four human-authored shapes. Do not create new `[aw]` issues manually.

---

## Label rules

| Rule | Why |
|------|-----|
| Every active issue carries exactly one `type:*` label | `/pickup` routes by it |
| **Workflow state is Linear-native, not a GitHub label.** Status (`Ready`/`In Progress`/`Blocked`/…), priority, estimate, and blockers live on the Linear issue. `claude-ready`, `in-progress`, and `blocked` are **retired** | One source of truth; `/pickup` selects Linear `Ready` |
| **Priority is a Linear-native field, not a GitHub label.** Set it in Linear (Urgent/High/Medium/Low) at groom/triage time; the `priority:*` labels are retired (see § *Cross-surface flow (Linear ↔ GitHub)*) | One source of truth; Linear's board sorts on the native field |
| Apply `area:*` labels when the touched subsystem is unambiguous | Helps `/sweep` dedupe collisions |
| `tracking` is **legacy** outside release automation — do not apply to new issues except the `Release: vX.Y.Z` cadence tracker (see § *Release tracking*) | Epics are Linear Projects; release automation still queries `tracking` |
| Never re-introduce a bare alias (`bug`, `runtime`, `medium`, …) | They are listed in `aliases:` of `labels.yml` and will be migrated away on the next sync |
| Never invent a new label in a workflow or slash command | Add it to `labels.yml` in a separate PR first |

### Legacy agentic-pipeline labels

These labels used to gate the retired GitHub Agentic Workflows pipeline. Keep
them only where they remain useful for human triage, Codex/Claude pickup, or
historical issue interpretation:

| Label | Gate |
|-------|------|
| `needs-design` | Human/agent hint that an issue needs design grooming |
| `type:bug` | Bug classification |
| `agent-authored` | PR originated from an autonomous or assistant-driven workflow |
| `needs-changes` | PR needs author rework before merge |

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

**Linear is the planning source of truth.** Our own work is authored natively as
Linear `SFN-NNN` issues; there is **no GitHub mirror** for it. The former GitHub
Project board (*Sailfin Tracker*, org project #4) and its label→board sync
workflow are **retired**. Lifecycle status, priority, estimate, blockers,
assignee, and Project membership live on the Linear issue.

GitHub's role is (a) the **code and PR host** and (b) **external-contributor
issue intake**: an issue filed on GitHub mirrors into the Sailfin (`SFN`) team's
**Triage**, where `/triage` classifies and grooms it. `type:*`/`area:*` labels
plus the release axis (`release:*`, `seed-blocker`) stay as the public GitHub
taxonomy; the workflow-state labels (`claude-ready`/`in-progress`/`blocked`) are
**retired**. Epic and roadmap-level grouping lives in **Linear** — Projects are
epics, Initiatives are pillars, releases are Cycles.

### Status semantics (GitHub intake → Linear)

Our own Linear issues own their status natively — nothing to derive. This
precedence applies only when **classifying an external-contributor GitHub issue**
that mirrored into Linear (or reconciling an older migrated issue): pick the
initial Linear status from the GitHub signals, first match wins.

| GitHub signal | Initial Linear status |
|--------|--------|
| Issue closed | `Done` (via the merge/close sync) |
| `needs-grooming` / `needs-design` hint | `Backlog` |
| No status-bearing label (default) | `Triage` |

Notable invariants:

- **New intake defaults to `Triage`.** An external issue with no grooming hint
  lands in `Triage` for `/triage` to shape.
- **Workflow-state labels are retired.** `claude-ready` / `in-progress` /
  `blocked` no longer appear on new issues; status is the Linear field.
- **Blockers are native relations.** A blocked issue sits in `Blocked` via a
  Linear blocked-by relation, so the `Ready` set is always pickable.
- **`In Review` is set by `/pickup`** when the PR opens; `Done` comes from the
  merge via Linear's GitHub integration.

## Linear structure & naming

Epic and roadmap-level grouping lives in Linear, in two tiers above the GitHub
issues. Keep it consistent:

| Tier | Represents | Naming |
|------|------------|--------|
| **Initiative** | a pillar or durable workstream | Theme name in Title Case. A small, stable set (e.g. *Capability-Sealed Runtime*, *Structured Concurrency*, *Build & Toolchain*). Rarely added. |
| **Project** | one epic | The deliverable as a concise Title-Case noun phrase, ≤ ~60 chars. Drop `Epic:` / `Tracking:` prefixes and any trailing `#N` / `SFEP-NNNN`. e.g. `CLI Modularization`, not `Epic: CLI modularization (SFEP-0027)`. |
| **Issue** | a session-sized leaf | A Linear `SFN-NNN` issue with a Conventional-Commit title (above), mirrored to GitHub when public tracking is needed; external GitHub issues mirror into Linear triage. |

**Cross-links go in the project description, not the name.** Each Linear project's
description carries the traceability the name omits:

- `GitHub: #N` — the epic's GitHub tracking issue, when one exists.
- `Design: SFEP-NNNN` — the governing proposal, when one exists.

This keeps project names scannable while preserving the link back to the design
record and the GitHub epic. A project belongs to exactly one initiative; a leaf
issue belongs to exactly one project.

When an epic is groomed, `/groom` creates (or reuses) a Linear Project under the
right initiative following this convention, files the session-sized leaves as
Linear issues, and attaches or creates GitHub public mirrors when needed. The
skills are the primary reflection path; the
`Linear Priority Sync` GitHub Action (`.github/workflows/linear-priority-sync.yml`,
using the Actions `LINEAR_API_KEY`) is a scheduled safety net that backfills the
Linear-native **priority and estimate** on mirrors the skills didn't reach —
notably the CI-auto-filed regression issues, whose mirror is created
asynchronously after `gh issue create` (see the note in step 3 below).

## Cross-surface flow (Linear ↔ GitHub)

Linear holds all planning state; our own work never exists as a GitHub issue.
There are exactly two cross-surface flows, both handled by the Linear GitHub
integration:

1. **Contributor intake (GitHub → Linear).** An external contributor files a
   GitHub issue; the integration mirrors it into the Sailfin (`SFN`) team's
   `Triage`. `/triage` classifies it (`type:*`/`area:*` labels, priority,
   estimate, Project) and routes it to `Ready`/`Backlog` — or `Duplicate` /
   `Canceled` with a comment. Set the initial status via the § *Status semantics
   (GitHub intake → Linear)* precedence above.
2. **PR close (GitHub → Linear).** `/pickup` branches `claude/sfn-<N>-<slug>` and
   the PR body cites `Fixes SFN-<N>`; the integration links the PR to `SFN-<N>`
   and advances it to `Done` on merge. The skill flips
   `Ready → In Progress → In Review` via `mcp__Linear__save_issue` and never
   writes a terminal status by hand (the merge does that).

For maintainer/agent work, `/groom` creates the leaf **natively** in Linear with
these fields set at creation — there is no reflect-to-GitHub step:

| Attribute | Linear field | Value |
|---|---|---|
| Estimate | `estimate` | XS/S/M → 1/2/3 (Sailfin team's Linear 1–5 scale) |
| Priority | `priority` | Urgent/High/Medium/Low → 1/2/3/4 |
| Status | `state` | `Ready` when groomed + unblocked; `Backlog` when scoped; `Blocked` via a blocked-by relation |
| Type/area | `labels` | `type:*`, `area:*` only |
| Epic | `project` | the epic's Project |

Every `Ready` leaf carries both an estimate and a priority (default a leaf to its
Project's priority if grooming set none). Never leave a groomed leaf at
`No priority` / no estimate, and never write a terminal status (`Done`/`Canceled`)
on open work.

**CI-auto-filed issues** (the `build-quality.yml` / `perf-history.yml` regression
filers) create GitHub issues whose Linear mirror is made asynchronously by the
integration. They can't set native fields inline, so the scheduled
`Linear Priority Sync` workflow (`.github/workflows/linear-priority-sync.yml`)
backfills them: estimate from `size:*`, priority per regression class
(`build-quality-regression` → Urgent, `perf-regression` → Medium). It only fills
unset values, so an interactively-set priority/estimate always wins.

## Release tracking

Milestones group long-lived **themes** (and feed `site/src/pages/roadmap.astro`).
They span many releases. To answer "what ships in version X" we use a separate
axis: the **`release:*` label namespace** plus a **per-cycle tracking issue**.

**In Linear, a release is a Cycle, never a Project.** A release is a time-boxed
cut *across* many epics, and a Linear issue belongs to exactly one Project (its
epic — see § Linear structure & naming), so the release axis must be orthogonal
to Projects. The `release:*` labels stay the source of truth (mirrored from
GitHub); `/release-plan` assigns the must-close `release:<gate>` issues to a
Linear **Cycle** for the target window, which carries the target date and
burndown. Never model a release as a Linear Project, and never move a
`release:<gate>` issue out of its epic Project — Cycle and Project membership are
independent axes. The mechanics live in `/release-plan` (Phase 3c). At cut time
no Linear action is needed: `release.yml` merges close the issues via
`Closes #N`, which the two-way sync propagates to `Done`, and the Cycle
completes on its end date.

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

### Release cadence

> **2026-07-18 amendment (SFEP-0026):** the cadence is now a **weekly,
> fully-automated stable train**, superseding the original bi-weekly
> curated-alpha design below where the two disagree.

The public compiler train is a **weekly cadence**. The scheduled
`release-train.yml` workflow runs every week and dispatches when `main` is
green — a `nightly-selfhost.yml` run whose `head_sha` equals current `main`
HEAD succeeded, so the gate binds to the exact commit being tagged (per-commit
CI is already guaranteed by the merge queue). If HEAD is not yet
nightly-verified at the cadence boundary, the train dispatches a fresh nightly
and holds; the nightly's completion re-triggers the train and the cut fires
once HEAD is green. Open release scope always rolls forward; it is reported on
the tracker but never blocks the train.

The train cuts a **stable** minor directly — not an alpha. The version rule,
applied against the current `compiler/capsule.toml` version:

- Prerelease line `X.Y.Z-pre.N` → ships `X.Y.Z` stable
  (`channel=stable bump=prerelease`).
- Already stable `X.Y.0` → advances to `X.(Y+1).0`
  (`channel=stable bump=minor`).

The former "hold the next minor train until the current stable line ships"
behavior no longer applies — there is no separate alpha-then-stable sequence
to skip ahead of; the train ships stable every week the gate is clear.

Stable promotion is **no longer human-confirmed** — the weekly train dispatch
*is* the promotion mechanism, gated purely on `main`'s green health at cut
time, not on a separate N-consecutive-green-days timer or an advisory
sign-off step.

Routine alphas (`channel=alpha bump=prerelease`) remain manual/off-cadence.
They are for urgent fixes, release-critical seed needs, or maintainer-curated
snapshots between trains; they are not the public cadence contract.

Release workflows post high-signal notifications to Slack when
`SLACK_RELEASE_WEBHOOK_URL` is configured in GitHub Actions secrets. The
intended channel is `#sailfin-notifications`; notifications fire on a new
stable release, a new prerelease, a seed pinned (the cadence pin PR
auto-merging), and a cut blocked (gate not clear) or dispatched.

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

> **2026-07-18 amendment (SFEP-0026):** the pin now **auto-pins on every
> green release** (stable or prerelease) and the pin PR **auto-merges**,
> superseding the batched-per-cadence design below where the two disagree.

The Sailfin compiler self-hosts from a released seed binary. The canonical
pin lives in `bootstrap.toml` as `[seed].version`.
**Bumping the pin is a separate concern from cutting a release** —
`release.yml` deliberately doesn't touch the seed pin because the new binary
doesn't exist at tag-creation time.

**Seeds auto-pin on every green release.** `cadence-seed-pin.yml` runs after
**every** green release — stable or prerelease alike — and opens a PR
advancing `bootstrap.toml [seed].version`; that PR **auto-merges** once its
own CI is green, with no manual merge step. This replaces the prior
once-per-cadence-cycle batching (trading reactive per-need cuts for a
single scheduled bump): under the weekly auto-stable train there is no batch
window to wait on, so the pin advances as often as releases go green. The
`release-critical-seed` off-cadence escape hatch below is largely moot under
this model, since there's no batch to break out of, but the underlying
bundle-vs-split decision tree (`.claude/rules/seed-dependency.md`) still
governs whether a capability should be bundled with its single consumer.

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

> **Superseded by the 2026-07-18 amendment** (see the note atop this
> section): the pin no longer batches onto a fixed cadence window — it
> auto-pins, auto-merging, after every green release. The historical
> batching design is kept below as prior art; a mid-flight `needs-seed-cut`
> flag now effectively clears on the **next** green release rather than
> the next cadence boundary.

Mid-flight seed needs — a `needs-seed-cut` flag from the advisor, or a
`seed-blocker` issue closing — **queue against the next scheduled cadence
seed bump** by default. After the cadence alpha assets publish, the
`cadence-seed-pin.yml` workflow opens a draft PR that advances
`bootstrap.toml [seed].version` (and the transitional mirror only while it
exists). The pin advances **once per cadence**; it is not run reactively for
each individual need. This is the SFEP-0026 §3.3 batching policy: trade a
small latency on non-critical seed needs for a large reduction in seed-pin
overhead.

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
it never dispatches `release.yml` or bumps the seed pin, and it never applies
`release-critical-seed` (that marker is human/grooming-applied; the advisor
only reads it). `/release-plan` consumes the `needs-seed-cut` label,
surfacing a "Seed cut required" checklist section on the per-cycle tracking
issue. A queued flag clears when the cadence `/pin-seed` lands; a
release-critical flag clears when its off-cadence `/pin-seed` lands. Remove
the label once pinned.

### When to bump the pin

The routine bump is now automatic: `cadence-seed-pin.yml` auto-pins and
auto-merges after every green release, so most seed needs are resolved by the
next release going green without any manual step. Run `/pin-seed [vX.Y.Z]`
manually only for an off-cadence or hotfix pin — e.g. when the need clears
the release-critical bar before the next release ships:

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
workflow that reads the compiler checkout seed pin.

## Milestones

Milestones are phase markers, not calendar deadlines. Epics are Linear Projects;
session-sized issues inherit the relevant milestone from their Project or parent
context.

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
