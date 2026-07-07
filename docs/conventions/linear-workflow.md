# Linear Workflow — Initiatives, Projects, and Issues

This is the human-facing playbook for how work is organised across **Linear**
and **GitHub Issues**. It is the front door; the dense, agent-facing mechanics
live in [`issue-naming.md`](./issue-naming.md) (§ *Linear structure & naming*,
§ *Reflecting state across Linear and GitHub*, § *Release tracking*) and this file links to
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
| **Issue** | One session-sized leaf (XS/S/M, never L). A Linear `Ready` issue is pickable by `/pickup`. | Authored in **Linear** for maintainer/agent work, mirrored to GitHub when public tracking is needed; external GitHub issues mirror into Linear triage. | **Linear owns status, priority, estimate, project, and assignee**. GitHub labels remain the public compatibility taxonomy. |

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

### Sub-issues — allowed, but bounded

Sub-issues are fine for **splitting one session-sized leaf** into smaller
checkable steps (GitHub's native parent/child relationship carries the nesting,
mirrored to Linear). They are **not** a mini-epic. Rule of thumb: if a parent has
more than a handful of children, or the parent is not itself workable in a
session, it is an epic — promote it to a **Project** and let the children be
ordinary issues associated to that Project.

---

## "What work do I have?" — the daily views

- **By epic (Linear):** the Sailfin team board grouped by Project shows every
  epic and its live issues. Filter to an Initiative to see one theme.
- **Pickable now (Linear first):** open Sailfin (`SFN`) issues in the native
  `Ready` status, no unclosed `Blocked by`.
  This is exactly what `/pickup` selects; `/pickup` with no argument picks the
  top one, and `/pickup SFN-123` targets a specific Linear issue.
- **Needs shaping:** `needs-grooming` → run `/groom`; `needs-design` → architect
  queue; `needs-discussion` → parked for a human.

---

## Lifecycle of a new epic

1. **Create the Project** in Linear under the right Initiative (create a new
   Initiative only for a genuinely new pillar). Name it for the outcome.
2. **Write the design as an SFEP** (`/sfep new <slug>` → `docs/proposals/`), and
   put `Design: SFEP-NNNN` in the project description. See
   [`.claude/rules/proposals.md`](../../.claude/rules/proposals.md).
3. **Groom into leaves:** `/groom <epic>` decomposes it into session-sized
   Linear issues, ensures the Project exists, associates each leaf to the
   Project, and lets the GitHub integration create or attach the public mirror
   when needed. Each leaf cites the SFEP (`## Design`), it does not re-litigate
   the design.
4. **Work the leaves:** `/pickup` drives each from Linear issue → branch → PR.
   If a GitHub mirror exists, the PR uses `Closes #N`; otherwise the PR links
   `Linear: SFN-NNN` and the mirror can be attached later.
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
