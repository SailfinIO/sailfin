# Groom a Roadmap Epic into Issues

Take a high-level epic (a **Linear Project** under an Initiative) and decompose
it into session-sized **Linear `SFN-NNN` issues** that Claude can pick up and
complete autonomously.

> **Linear is the planning source of truth.** Epics are Linear **Projects**
> (under Initiatives); leaves are native Linear issues on the Sailfin (`SFN`)
> team. There is **no** GitHub mirror for our planned work and **no** GitHub
> `Epic:`/`Tracking:` issue. Use `mcp__Linear__*` tools throughout. See
> `docs/conventions/linear-workflow.md` for the full model and
> `docs/conventions/linear-templates.md` for the issue/Project templates.

## Target: $ARGUMENTS

The argument can be:
- A Linear Project / epic name (e.g. "CLI Modularization")
- An Initiative name to mine for the next un-groomed Project
- A roadmap bullet or a document to mine (e.g. `docs/proposals/0006-build-architecture.md`)
- A free-form description of work that needs breaking down

---

## Phase 1: UNDERSTAND THE EPIC

Read the relevant context:
- **Linear** — the Initiative and its Projects. Find the epic and its place:
  ```
  mcp__Linear__list_initiatives includeProjects=true
  mcp__Linear__get_project id="<project-id-or-name>"
  mcp__Linear__list_issues project="<project>" limit=100
  ```
  The Project **description** carries the epic's outcome, scope, and
  `Design: SFEP-NNNN` link.
- `docs/status.md` — current state of the affected feature(s)
- `site/src/content/docs/docs/reference/spec/` (§1–§11) and `.../reference/preview/`
- The Project's cited SFEP and any document named in the argument

Identify: what outcome this epic produces when done, what's already partially in
place (existing issues under the Project), and what other epics must complete first.

---

## Phase 2: DECOMPOSE

Spawn the **compiler-architect** agent (Opus). Give it the epic + its
Initiative/Project context, the current compiler state, and the constraint that
each output issue must be **session-sized** (XS/S/M, never L).

The architect produces an ordered list of issues. Each issue must:
- Have a clear, verifiable goal achievable in one session
- Touch a bounded set of files
- Be self-contained (or have explicit blocker dependencies on earlier issues)
- Include concrete acceptance criteria
- Map to one of: Feature, Bug, Performance, Refactor

If the architect produces any L-sized item, push back: "this needs further breakdown."

### Capture the epic's design as an SFEP

An epic with real design surface needs a durable **design record** so leaves
don't re-litigate the *why* and `/pickup` has a brief. Before creating issues:

- **Check for an existing SFEP** (`grep docs/proposals/` and the registry
  `docs/proposals/README.md`, and the Project description's `Design:` line).
- **If one exists**, leaves cite it (`## Design: SFEP-NNNN`); update its
  `tracking:` front-matter to list the new issues.
- **If none exists and the epic embodies a substantive design**, have the
  architect write it as an SFEP first (`/sfep new <slug>` per
  `.claude/rules/proposals.md`) and accept it at the grooming gate
  (`/sfep status <slug-or-N> Accepted`).
- **If the epic is purely mechanical** (no design decision), no SFEP is needed.

### Feasibility-probe FFI / "no frontend dependency" claims (gate)

Before any issue that touches `runtime/` or crosses the C-ABI / `extern fn`
boundary is marked `Ready`, **probe the load-bearing feasibility claim** — do
not take "no frontend dependency" on faith. Run a throwaway `.sfn` snippet
through the current seed:

```bash
build/seed/bin/sailfin check /tmp/probe.sfn
build/seed/bin/sailfin emit -o /tmp/probe.ll llvm /tmp/probe.sfn
```

Confirm the construct can actually be expressed and emitted (not silently
dropped to `null`). If the probe fails, the prerequisite is a **frontend issue
that must be groomed first** — make it an explicit blocker / seed predecessor,
not a surprise (the gap that broke the original #1088 pickup).

### Don't over-decompose: bundle a capability with its single consumer (default)

**Bundling is the groom-time default.** When a compiler capability is tightly
coupled to exactly one consumer worked in the same session, **produce one
issue** (one PR), not two. Split only when the capability has **multiple
consumers** or is **genuinely independent**. Any split that creates a seed-cut
gate for a single consumer must be **explicitly justified** in the issue body.

The full decision tree and seed-cut-tax rationale live in
**`.claude/rules/seed-dependency.md`** (cited by `/pickup` too — SFEP-0026 WS-B).
Apply that rule here rather than re-deriving it. When a split is justified,
follow "Seed dependencies" below.

---

## Phase 3: REVIEW WITH USER

Present the proposed issue list as a table:

| # | Title | Type | Estimate | Priority | Blocked by |
|---|---|---|---|---|---|
| 1 | ... | Performance | S | High | — |
| 2 | ... | Refactor | M | Medium | #1 |

Priority is Urgent / High / Medium / Low — the architect assigns it from the
epic's place on the 1.0 critical path (default a leaf to its Project's priority
unless it's a genuine outlier). Estimate is XS/S/M. Both become **Linear-native
fields** in Phase 4.

Wait for user approval. The user may approve as-is (→ Phase 4), request changes
(iterate with the architect), or reject the breakdown (ask what's wrong).

---

## Phase 4: CREATE LINEAR ISSUES

Ensure the epic's Linear **Project** exists, then create one native Linear
issue per approved leaf under it. Do **not** create GitHub issues (those are for
external contributors) and never a GitHub `Epic:`/`Tracking:` issue.

### 4.1 — Ensure the Project exists

Resolve or create the epic's Project under the correct Initiative, named for its
outcome per `docs/conventions/issue-naming.md` § Linear structure & naming
(concise Title-Case noun phrase; no `Epic:` prefix, no trailing `#N`/`SFEP-NNNN`).
Put `Design: SFEP-NNNN` and any related links in the **description**, not the name:

```
mcp__Linear__list_projects query="<epic outcome>"
# if absent:
mcp__Linear__save_project name="<Outcome Name>" addTeams=["Sailfin"] addInitiatives=["<Initiative>"] description="## Outcome\n...\n\n## Design\n- SFEP: SFEP-NNNN"
```

### 4.2 — Create each leaf

For each approved leaf, create the issue with native status, priority,
estimate, project, labels, and blocker relations set directly — no separate
"reflect" step:

```
mcp__Linear__save_issue \
  team="Sailfin" \
  title="<type>(<scope>): <imperative verb phrase>" \
  project="<Project name>" \
  state="Ready" \
  priority=<1|2|3|4> \
  estimate=<1|2|3> \
  labels=["type:<t>", "area:<a>"] \
  description="<body — see skeleton below>"
```

Field mapping (canonical — see `docs/conventions/linear-workflow.md`):

| Attribute | Linear field | Value |
|---|---|---|
| Pickable-when-groomed | `state` | `Ready` (or `Backlog` if scoped-but-not-ready) |
| Priority | `priority` | Urgent/High/Medium/Low → 1/2/3/4 |
| Size | `estimate` | XS/S/M → 1/2/3 (never L) |
| Type / area | `labels` | `type:*`, `area:*` only — never status/priority/size labels |
| Blocked | relation | `blockedBy=["SFN-<blocker>"]` → status is set to `Blocked` automatically when a blocker is open |

**Issue body skeleton** (`docs/conventions/linear-templates.md` is the source):

```markdown
## Goal
<one sentence>

## Scope
**In:**
- <semantic unit of change — NOT a file path; e.g. "the effect-checker
  diagnostic emission for missing ![io]">

**Out:**
- ...

## Acceptance Criteria
- [ ] ...
- [ ] make compile passes
- [ ] make test passes

## Files Affected (advisory map — non-binding, expected to drift)
- compiler/src/... — ...   # likely-relevant starting points; non-exhaustive, no line numbers/counts

## Verification
```bash
timeout 60 build/bin/sfn run path/to/example.sfn
```

## Required in pinned seed
<#<PR> or "None" — see "Seed dependencies" below>

## Design
<SFEP-NNNN (docs/proposals/NNNN-<slug>.md), or "None" for purely mechanical work>

## Context
<links to the Project, roadmap, code, prior PRs>
```

**Always emit `## Required in pinned seed`, even as `None`.** `/pickup` treats a
missing section as legacy and falls back to walking blockers against the seed —
producing false-positive seed-cut requirements. An explicit `None` is the
contract for "no seed dependency."

### 4.3 — Set blocker relations

For any leaf that depends on a sibling that hasn't merged, set the native
blocked-by relation — Linear derives `Blocked` status from it:

```
mcp__Linear__save_issue id="SFN-<dependent>" blockedBy=["SFN-<blocker>"]
```

### Intent authoritative, file map advisory

A groomed issue's **contract** is its **Goal** plus a **semantic `In:`/`Out:`
scope**; `## Files Affected` is a **non-binding map** reconciled at pickup
(`docs/conventions/issue-naming.md`, "Intent-authoritative issues"). When
emitting a body:

- **Express `In:`/`Out:` as semantic units, not file paths.** A new sibling
  file inside a named unit is in scope by construction.
- **Mark `## Files Affected` advisory**, list paths as likely-relevant starting
  points, explicitly non-exhaustive.
- **Forbid line numbers** (`L142`, `~L100-135`) and **exact file counts**
  anywhere — both rot fastest and manufacture phantom scope violations.

### Seed dependencies

For each leaf, evaluate whether a predecessor must be **in the pinned seed
binary**, not just merged. `make compile` runs against `.seed-version`, so a
compiler-source dependency merged but not seeded fails to self-host.

Apply: if the leaf touches `compiler/src/` or `runtime/prelude.sfn` AND its
predecessor is a compiler-source change affecting the binary's behaviour
(lowering, parsing, typecheck, intrinsics, diagnostics, IR shape), the
predecessor must be in the seed first. When that holds:

1. Fill `## Required in pinned seed` with the predecessor's **PR number**.
2. Apply the `seed-blocker` label to the **predecessor** issue (the one shipping
   the change): `mcp__Linear__save_issue id="SFN-<predecessor>" labels=[...,"seed-blocker"]`.
3. Note in the Phase 5 report that a cadence seed bump + `/pin-seed` is required
   before pickup of the dependent leaf.

A pure docs/test/runtime issue typically needs no seed cut.

### Phased epics: one Project per phase, groomed wave-by-wave

When an epic is inherently multi-phase (Phase A → B → C, later phases depend on
earlier), model the phases as **separate Linear Projects** under the shared
Initiative, named `<Epic> Phase <X> — <noun phrase>` (as the existing
*Concurrency Maturity Phase 1 / Phase 2* Projects do). Give each future phase a
`Backlog`/`Planned` Project state with its checklist + `Design: SFEP-NNNN` in
the description. Groom each phase's leaves wave-by-wave into that phase's
Project when the wave opens; the empty next-phase Project is the visible "groom
me next" card. (One Project rolls up its own issues — a single Project for the
whole epic would read ~100% the moment Phase A closed, hiding that B/C aren't
groomed.)

**When NOT to use this:** a single-phase epic, or a flat bag of independent
issues with no ordering — one Project, leaves filed directly.

---

## Phase 5: REPORT

Report to the user:
- Linear issues created (SFN-NNN with titles) and the Project they landed under
- The dependency graph (what blocks what)
- The recommended pickup order
- Any seed-cut gate a split introduced (predecessor → dependent, queued bump)
- Any context the architect flagged that doesn't fit in an issue

Suggest: `/pickup` to start the queue, or `/triage` to verify hygiene.

---

## Constraints

- **Never create L-sized issues.** If work can't break into XS/S/M, it's not ready.
- **Never create issues without acceptance criteria.** The criteria are the contract.
- **Set status, priority, and estimate natively** on every leaf. A groomed,
  unblocked leaf is `Ready`; a blocked one gets a `blockedBy` relation (Linear
  derives `Blocked`). Never leave a `Ready` leaf at `No priority` / no estimate.
- **Labels are `type:*` / `area:*` only** — status, priority, estimate, and
  blockers are native Linear fields, not labels.
- **No GitHub issues.** Epics are Linear Projects; leaves are Linear issues.
  GitHub issues come only from external contributors (mirrored into Linear
  Triage) — never open one here.
- **Never write a terminal status** (`Done`/`Canceled`) on freshly-groomed work.
- **Don't duplicate in-progress work** — check `list_issues` for the Project first.
