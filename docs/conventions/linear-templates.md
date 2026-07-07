# Linear Templates

These templates are the source of truth for Sailfin Linear work. Linear's native
issue, Project, and document template slots may be empty; agents should still
follow this file when creating or updating Linear records.

## Issue template

Use this for maintainer-created work and pickup follow-ups.

**Title**

Use Conventional Commit shape when it helps scanning:

```text
<type>(<scope>): <imperative verb phrase>
```

Examples: `fix(parser): reject unterminated type effects`,
`docs(sfep): record capsule import staging`.

**Fields**

| Field | Value |
|---|---|
| Team | `Sailfin` (`SFN`) |
| Status | `Triage` for unclear intake, `Backlog` for scoped but not ready, `Ready` for fully groomed and unblocked leaves, `Blocked` when a blocker relation exists, `In Progress` only when claimed |
| Project | Same Project as the current issue when the work belongs to the same epic |
| Priority | Urgent = release/self-host/seed blocker; High = critical path; Medium = current-milestone enabling work; Low = polish or post-milestone work |
| Estimate | `1` = XS, `2` = S, `3` = M; split or triage anything larger |
| Labels | Canonical `type:*` and `area:*` labels only |
| Relations | `related to` the source issue; `blocked by` only when work cannot start yet |

Do not create or apply Linear labels for status, priority, estimate, release,
blockers, assignee, cycle, or Project membership.

**Description**

```markdown
## Goal

One or two sentences describing the user-visible or maintainer-visible outcome.

## Context

- Found during: SFN-NNN / PR #NNN / GitHub #NNN
- Project: <Linear Project or "unprojected: <reason>">
- Design: SFEP-NNNN / design note / none

## Scope

In:
- <concrete behavior, file family, or workflow>

Out:
- <nearby work intentionally left alone>

## Acceptance criteria

- <observable condition>
- <test/docs/status expectation>

## Verification

- `<command>`
- `<command>`

## Links

- Linear: SFN-NNN
- GitHub: #NNN
- PR: #NNN
```

## Project template

Use a Linear Project for an epic: a deliverable with meaningful surface area,
usually backed by an SFEP or design note. Do not use a Linear issue or GitHub
issue as an epic.

**Name**

Use an outcome name, not a tracker label:

```text
Capsule Import Resolution
```

**Fields**

| Field | Value |
|---|---|
| Team | `Sailfin` (`SFN`) |
| Initiative | One existing durable pillar whenever possible |
| Status | `Backlog` before grooming, `Planned` when leaves exist, `Started` when a leaf is in progress |
| Priority | Highest priority of its current gating leaves |
| Target | Release Cycle only when the epic gates that release |

**Description**

```markdown
## Outcome

The concrete capability this Project ships.

## Design

- SFEP: SFEP-NNNN / draft / none
- Status doc impact: yes/no

## Scope

In:
- <major capability>

Out:
- <explicit non-goal>

## Leaf issue criteria

- Leaves are XS/S/M.
- Each Ready leaf has priority and estimate.
- No leaf re-litigates an accepted SFEP.

## Links

- Docs/status:
- GitHub mirror/tracker, if any:
- Related Projects:
```

## Document template

Use a Linear document for working notes, project briefings, and agent-readable
context that should live beside Linear planning.

**Title**

```text
<Project or topic>: <decision/context name>
```

**Body**

```markdown
## Purpose

Why this document exists and what decision or context it preserves.

## Current state

The facts an agent or maintainer needs before acting.

## Decisions

- <decision, date, owner/source>

## Open questions

- <question and next owner>

## Follow-ups

- SFN-NNN: <title>

## References

- SFEP/design:
- GitHub/PR:
- Docs:
```
