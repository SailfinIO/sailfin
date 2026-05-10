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

## Project board

Every open issue is tracked on the **Sailfin Tracker** project
(org project #4: `https://github.com/orgs/SailfinIO/projects/4`).

| Field | Source | Notes |
|-------|--------|-------|
| Status | derived from issue state + labels | See **Status mapping** below |
| Priority | `priority:*` label | `Critical`/`High`/`Medium`/`Low` mirror the four `priority:*` labels |
| Size | `size:*` label | `XS`/`S`/`M` mirror the three `size:*` labels (no L; L items must be groomed down or promoted to `epic`) |
| Milestone | `milestone` field | Phase marker — `M1`, `M1.5`, `M2`, `M3`, `Effect System Hardening`, `1.0` |
| Iteration | manual | 2-week cadence, Monday-start. Optional per-issue (set on epics or in-flight work) |
| Start / Target date | manual | Use on epics, not leaf issues — leaf issues are sized in hours, not days |
| Parent issue / Sub-issues progress | auto | Inherits from the GitHub native parent/child relationship |

### Status mapping

Status is derived from issue state plus labels. First match wins:

| Signal | Status |
|--------|--------|
| Issue closed (or PR merged for linked PRs) | `Done` |
| `in-progress` label | `In progress` |
| `blocked` label | `Blocked` |
| `claude-ready` label (no blocker) | `Ready` |
| `needs-grooming` / `needs-design` / `design-approved` | `Backlog` |
| No matching signal | (left alone — usually `To triage`) |

Notable invariants:

- **`blocked` beats `claude-ready`.** A blocked-but-groomed issue lands in `Blocked`, not `Ready`, so the Ready column is always pickable.
- **`In review` is intentionally not auto-set** for issues. An issue with `in-progress` keeps that status across PR-open → review → merge → close transitions; the PR side of GitHub already tracks review state.
- **No signal → no change.** The sync never bounces an item back to `To triage`. If a maintainer manually moves an item to `Backlog`, it stays put until a label gives the workflow a stronger signal.

Labels are canonical. The `Sync Project` workflow (`.github/workflows/sync-project.yml`)
auto-adds new issues to the project and recomputes Priority/Size/Status from
labels on every issue event. To backfill or repair drift, run
`scripts/sync-issue-to-project.sh --all-open` locally or trigger the
workflow with `backfill=true`.

The workflow needs a PAT with `project` + `read:org` scopes, stored as
`PROJECT_SYNC_TOKEN` (falls back to `RELEASE_PAT`). If neither secret is
available the workflow no-ops — labels stay correct, only the project
view goes stale.

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

### When to bump the pin

Run `/pin-seed [vX.Y.Z]`:

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
| `1.0 — General Availability` | `T7` | Pure Sailfin toolchain, no C runtime, all enforcement gates active |

---

## Track ID directory

Reserved track IDs (extend by editing the roadmap, then this list):

| ID    | Track |
|-------|-------|
| `M0`  | Foundational language primitives (atomics, `Result`, `?`) |
| `M1`  | Phase 1 systems primitives (extern fn, integer types, raw pointers) |
| `M1.5`| Drop emission |
| `M2`  | Core runtime in Sailfin |
| `M3`  | Capability adapters + delete C runtime |
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
