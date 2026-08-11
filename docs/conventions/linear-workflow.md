# Linear Workflow — Initiatives, Projects, and Issues

This is the human-facing playbook for how work is organised across **Linear**
and **GitHub Issues**. It is the front door; the dense, agent-facing mechanics
live in [`issue-naming.md`](./issue-naming.md) (§ *Linear structure & naming*,
§ *Cross-surface flow (Linear ↔ GitHub)*, § *Release tracking*) and this file links to
them rather than restating them.

If you only remember one thing: **an epic is a Linear Project, not a GitHub
issue.** Issues are session-sized leaf work — nothing bigger.

Repo-side Linear issue, Project, and document templates live in
[`linear-templates.md`](./linear-templates.md). Use those templates when Linear's
native template slots are empty or unavailable to an agent.

---

## The three tiers

```
Initiative        a pillar / durable theme          (Linear)      ~6, rarely added
   └─ Project     one epic                           (Linear)      the roadmap unit
        └─ Issue  one session-sized piece of work    (Linear ↔ GitHub public mirror)
             └─ (sub-issue)  a split of one leaf, optional
```

| Tier | Is | Lives in | Who owns state |
|------|----|----------|----------------|
| **Initiative** | A pillar or durable workstream (e.g. *Structured Concurrency*, *Build & Toolchain*). A small, stable set. | Linear | Set by hand; changes rarely. |
| **Project** | Exactly one epic — a deliverable with real surface area and a design record (SFEP). | Linear | Rolled up from its issues; the design/context lives in the project **description**. |
| **Issue** | One session-sized leaf (XS/S/M, never L). A Linear `Ready` issue is pickable by `/pickup`. | **Linear** — authored natively as `SFN-NNN`. External-contributor GitHub issues mirror into Linear **Triage**; we do **not** mirror our own planned work back to GitHub. | **Linear owns status, priority, estimate, project, blockers, and assignee.** GitHub hosts the code and PRs; its labels are a public taxonomy for contributor intake and the release axis, not our workflow state. |

A Project belongs to exactly one Initiative. A leaf Issue belongs to exactly one
Project. Releases are a fourth, **orthogonal** axis — a Linear **Cycle**, never a
Project (see below).

---

## The rules

1. **Never open a GitHub `Epic:` or `Tracking:` issue.** An epic is a Linear
   Project under an Initiative. A cross-cutting status thread is the Project
   itself (or its Initiative). The old GitHub `Epic:` / `Tracking:` title shapes
   are **retired** — see [`issue-naming.md`](./issue-naming.md) § *Title
   taxonomy*.
2. **Issues are leaf work only.** If a would-be issue is too big for one session
   (an `L`, or a "parent of many"), it is an epic → make it a Project and
   `/groom` it into leaves.
3. **Linear is the maintainer planning source of truth.** Status, priority,
   estimate, project, assignee, blockers, and cycle live on the Linear issue.
   Do not create Linear labels that duplicate native Linear fields
   (`blocked`, `in-progress`, `claude-ready`, `size:*`, `priority:*`,
   `release:*`). GitHub labels stay as the public compatibility taxonomy for
   external contributors, release automation, and GitHub-only fallbacks.
4. **Project names are scannable; links go in the description.** Name a project
   for its outcome (`CLI Modularization`), not `Epic: CLI modularization
   (SFEP-0027)`. Put `GitHub: #N` and `Design: SFEP-NNNN` in the description.
5. **Releases are Cycles, not Projects.** A release cuts *across* epics; modeling
   it as a Project would force it into one epic. Keep the `release:*` labels + the
   per-cycle `Release: vX.Y.Z` GitHub tracking issue; `/release-plan` assigns the
   gating issues to a Linear Cycle. (`Release:` is the **one** GitHub tracking
   title that survives — release automation owns it.)

### Public roadmap

Linear planning is private by default. Initiative membership does not mean a
Project is committed to 1.0, approved for public discussion, or safe to publish.
The public site includes only Projects carrying the owner-approved
`roadmap:public` label and exactly one `horizon:*` publication label. The site
renders a reviewed, sanitized snapshot and never exposes Linear URLs.

See [`public-roadmap.md`](./public-roadmap.md) for the approval contract and
publication flow. Agents must not add or change public-roadmap labels without
explicit owner direction.

### Sub-issues — allowed, but bounded

Sub-issues are fine for **splitting one session-sized leaf** into smaller
checkable steps (GitHub's native parent/child relationship carries the nesting,
mirrored to Linear). They are **not** a mini-epic. Rule of thumb: if a parent has
more than a handful of children, or the parent is not itself workable in a
session, it is an epic — promote it to a **Project** and let the children be
ordinary issues associated to that Project.

---

## The lanes

Each lane answers exactly one question. If you can't say which question a lane
answers, it shouldn't exist.

| Lane | Answers | Who moves it | Body bar |
|---|---|---|---|
| **Triage** | *Should this exist at all?* | you file here; `/triage` works it | none — raw capture is fine |
| **Backlog** | *Real, but not now.* | `/triage` | classified (`type:*`/`area:*`) + priority; no structure |
| **Ready** | *Could an agent finish this cold?* | `/triage` Pass 2, `/groom` | **full bar** — Goal / Scope In+Out / Acceptance / Files / Verification, plus estimate 1–3 |
| **Todo** | *What's next, in what order?* | **you, by hand** | already `Ready`-grade; this lane only reorders |
| **In Progress** → **In Review** | in flight | `/pickup` | — |
| **Done** | merged | Linear's GitHub integration | — |
| **Blocked** | orthogonal — derived from an open `blockedBy` relation | Linear | — |

**`Todo` is the steering wheel.** `Ready` is a *pool* — it holds dozens of
groomed issues, and its ordering is only ever "highest priority wins." When you
want specific work next, drag it to `Todo`. `/pickup` drains `Todo` first and
only falls back to `Ready` when `Todo` is empty, so a `Todo` issue outranks
every `Ready` issue regardless of priority. Keep the lane short — a `Todo` with
twenty issues is just a second `Ready`.

Only two lanes are pickable: `Todo`, then `Ready`. Nothing enters either without
clearing the full body bar.

### "What work do I have?"

- **By epic:** the Sailfin team board grouped by Project. Filter to an
  Initiative to see one theme.
- **Next up:** the `Todo` lane, in order. `/pickup` takes the top one.
- **Needs deciding:** the `Triage` lane → `/triage` (Pass 1 classifies and
  reports; Pass 2 grooms the survivors to `Ready`).
- **Needs decomposing:** an epic-scale item → a Linear Project → `/groom`.

External-contributor GitHub issues mirror into `Triage` and go through the same
`/triage` pass as anything you file yourself.

---

## Lifecycle of a new epic

1. **Create the Project** in Linear under the right Initiative (create a new
   Initiative only for a genuinely new pillar). Name it for the outcome.
2. **Write the design as an SFEP** (`/sfep new <slug>` → `docs/proposals/`), and
   put `Design: SFEP-NNNN` in the project description. See
   [`.claude/rules/proposals.md`](../../.claude/rules/proposals.md).
3. **Groom into leaves:** `/groom <epic>` decomposes it into session-sized
   **native Linear issues**, ensures the Project exists, and associates each leaf
   to it with native status/priority/estimate/blockers. Leaves stay Linear-native
   — no GitHub mirror for our own work. Each leaf cites the SFEP (`## Design`); it
   does not re-litigate the design.
4. **Work the leaves:** `/pickup` drives each from Linear issue → branch → PR. It
   branches `claude/sfn-<N>-<slug>` and the PR cites `Fixes SFN-<NNN>`, so
   Linear's GitHub integration links the PR and advances the issue to `Done` on
   merge. The skill flips `Ready → In Progress → In Review` via the Linear MCP.
5. **Graduate:** when the epic ships, flip its SFEP to `Implemented` and update
   `docs/status.md`.

---

## How this was migrated (2026-07-07)

The legacy model was GitHub `Epic:` issues with attached sub-issues, on the
retired *Sailfin Tracker* GitHub Project board (org project #4). The migration:

- Created the six Initiatives and one Linear **Project per epic**.
- Folded each old GitHub epic's body into its Linear **Project description**, then
  **canceled** the duplicate mirrored epic issue in Linear.
- **Closed** the ~28 GitHub `Epic:`/`Tracking:` issues as *not planned*, each with
  a comment pointing to its Linear Project. (The `Release: v0.8.0` / `v0.9.0`
  trackers stayed open — release automation owns them.)

From here, follow the rules above: epics are Projects, Linear carries maintainer
leaf work, GitHub remains the public mirror, and no new GitHub
`Epic:`/`Tracking:` issues are opened.

### Querying lanes — the state-type trap

`mcp__Linear__list_issues state="<name>"` matches a state **type** as readily as
a state name, and `Ready`, `Backlog`, and `Blocked` are all type `backlog`. So
`state="Backlog"` returns all three lanes at once. Query the lane you actually
mean, and never assume the result set is one lane.

This is also why a new workflow state is never free: a lane whose name shadows a
type silently widens every existing query. `To triage` was deleted for exactly
this reason — it duplicated `Triage` in meaning while hiding inside `Backlog`
results.

## Linear labels

Linear team labels should be smaller than the GitHub label registry. Use them
only for dimensions Linear does not already model natively, mainly `type:*` and
`area:*` classification. Use native Linear fields for status, priority,
estimate, Project, Cycle, blockers, assignee, and duplicate/canceled state.

The Linear MCP tools available to Codex can create labels, but they do not
currently expose label edit/delete. Clean up stale Linear labels in the Linear
UI when convenient:

- Delete or archive native-field duplicates: `blocked`, `in-progress`,
  `claude-ready`, `size:xs`, `size:s`, `size:m`, `size:l`, `release:*`,
  `priority:critical`, `priority:high`, `priority:medium`, `priority:low`.
- Delete or archive non-canonical migrated labels when no issue still needs
  them: `type:enhancement`, `type:chore`, `workstream`, `agentic-workflows`,
  `area:perf`, plus the default `Bug`/`Feature`/`Improvement` labels if they are
  unused.
- Delete `epic` and `tracking` from Linear labels. Epics are Projects; releases
  are Cycles. The GitHub `tracking` label remains only for release automation.
