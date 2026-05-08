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
