# Sailfin Agent Contract

This document is the canonical source of truth for how autonomous agents
coordinate on this repository. Every workflow in `.github/workflows/*.md` and
every agent role in `.github/agents/*.agent.md` must honour the rules below.

If an agent's behaviour conflicts with this document, this document wins.

## Prime directive

Code only flows **downward** through the tier pyramid. No agent self-generates
work. Every PR traces back to an approved focus workstream, through an
architect-approved issue, within a budget gate.

```
                     ┌──────────────────┐
                     │   Strategy       │    Planner
                     │   (focus doc)    │    weekly, writes ONE issue
                     └────────┬─────────┘
                              │   focus:approved  (human gate)
                     ┌────────▼─────────┐
                     │   Architecture   │    Architect / Grooming
                     │   (issues)       │    grooms issues, no code
                     └────────┬─────────┘
                              │   design-approved (architect gate)
                     ┌────────▼─────────┐
                     │   Engineering    │    Engineer
                     │   (PRs)          │    budget-gated, one PR per issue
                     └────────┬─────────┘
                              │   PR opened
                     ┌────────▼─────────┐
                     │   Review         │    QC / Security / Product / Docs
                     │   (comments)     │    no merges
                     └────────┬─────────┘
                              │
                            human merge
```

## Tier rules

### Tier 0 — Strategy (Planner)

- **Workflow:** `.github/workflows/planner.md`
- **Cadence:** weekly (Mondays 08:00 UTC) + manual dispatch
- **Reads:** roadmap, `docs/status.md`, `docs/build-performance.md`, open issues, recent merges, CI health
- **Writes:** exactly ONE GitHub issue titled `Focus: Week of YYYY-MM-DD`, labeled `focus:proposed`, pinned via comment
- **Must NOT:** open PRs, modify code, close issues, label other issues, run the compiler
- **Human gate:** a human applies `focus:approved` to activate downstream agents
- **Output shape:** 3–5 workstreams, each with (name, why-now, rough success criterion, linked roadmap epic or status section)

### Tier 1 — Architecture (Architect + Grooming)

- **Workflows:** `.github/workflows/architect-review.md` (reactive), `.github/workflows/nightly-grooming.md` (proactive)
- **Cadence:** architect-review on `issues: labeled`; grooming daily at 07:00 UTC, noop if no `focus:approved` issue exists
- **Reads:** current approved focus, issue body, relevant source files
- **Writes:** issues (grooming) or labels+comments on issues (architect-review). Every newly-groomed issue must include a `## Focus Workstream` section citing the current focus.
- **Must NOT:** open PRs, modify source code, merge anything
- **Gate:** architect flips `needs-design` → `design-approved` only after verifying the issue has scope, acceptance criteria, files-affected, and a focus-workstream citation

### Tier 2 — Engineering (Engineer)

- **Workflow:** `.github/workflows/engineer.md`
- **Cadence:** on `issues: labeled` with `design-approved` or `bug`
- **Budget gate:** before any work, count open PRs with label `agent-authored`. If the count is ≥ 2, call `noop`. Budget is set in `.github/AGENTS.md` and updated there only.
- **Reads:** issue + architect review, source, tests
- **Writes:** exactly ONE PR per issue. PR must have label `agent-authored` and body `Closes #<issue>`.
- **Must NOT:** bundle multiple issues into one PR, expand scope, skip tests, merge itself

### Tier 3 — Review (QC / Security / Product / Docs)

- **Workflow:** `.github/workflows/pr-review.md` and related
- **Writes:** PR comments, labels (`needs-changes`, `needs-review`), no code
- **Must NOT:** merge, force-push, rewrite history

## Budget: currently **2 concurrent agent-authored PRs**

The engineer's preflight check must:

1. Call `list_pull_requests` with `state=open`, `labels=agent-authored`
2. If the returned count ≥ 2, emit `noop` with message:
   `"budget gate: already <N> open agent-authored PRs (limit 2)"`
3. Otherwise proceed; apply `agent-authored` label to the resulting PR

To change the budget, edit this file and the inline comment in
`engineer.md`. Do not change it via agent prompts.

## Labels (canonical)

| Label | Applied by | Meaning |
|---|---|---|
| `focus:proposed` | Planner | Weekly focus issue awaiting human approval |
| `focus:approved` | Human | Weekly focus is live; downstream agents may act on it |
| `focus:stale` | Planner | Superseded by a newer focus issue; ignore for grooming |
| `needs-design` | Triage, Grooming | Issue needs architect review before implementation |
| `design-approved` | Architect | Implementation may begin |
| `needs-discussion` | Architect | Design blocked pending human input |
| `agent-authored` | Engineer | PR originated from an autonomous workflow; counts against budget |
| `needs-changes` | Reviewers | PR needs author rework before merge |
| `needs-review` | Engineer | Changes pushed; please re-review |
| `blocked` | Triage | Waiting on another issue to close |

Labels `focus:proposed`, `focus:approved`, `focus:stale`, and `agent-authored`
must exist in the repository. Create them once with `gh label create` (see
`scripts/setup-agent-labels.sh` if present).

## Focus artifact

The current focus lives as a GitHub issue, not a checked-in file. Rationale:

- Labels are the system's natural approval mechanism
- Comments give a single thread for human feedback
- Closing or re-pinning is cheap

The Planner searches for issues with `focus:proposed` or `focus:approved` and
either updates the open one (if still in the same ISO week) or marks the
previous one `focus:stale` and closes it, then opens a new one.

Downstream agents query for `is:issue is:open label:focus:approved` and take
the most recently updated. If there are zero matches, they noop.

## Handoff contract for new issues

Every groomed issue (whether from grooming workflow, human, or architect) must
include these sections to be `design-approved`:

- **Goal** — one sentence
- **Focus Workstream** — link or title reference to the current focus issue's
  workstream bullet
- **Scope** — explicit `In:` and `Out:` lists
- **Acceptance Criteria** — verifiable pass/fail items
- **Files Affected** — every file the implementation touches
- **Verification** — exact commands a reviewer can run
- **Size** — XS (<1hr) / S (1–3hr) / M (3–6hr). Never L.

Architect must refuse (`needs-discussion`) any issue missing a section.

## Local (Claude Code) vs autonomous (GitHub) agents

Two rosters exist and they are **not interchangeable**:

- **`.claude/agents/*.md`** — interactive subagents spawned during a human-driven
  Claude Code session. The human is present; these may explore, speculate, and
  propose freely.
- **`.github/workflows/*.md`** — scheduled or event-driven workflows with no
  human-in-the-loop at runtime. These follow the rules in this document
  without exception.

A local agent and a workflow may share a name (e.g. `compiler-architect`
local, `architect` workflow). They do not share permissions. When in doubt
about whether a behaviour is allowed, assume it is allowed locally and
prohibited autonomously.

## Prohibited patterns

These are the failure modes this contract exists to prevent. Any agent
exhibiting them is misconfigured:

- Opening PRs from a hardcoded priority list without referencing an approved focus
- Opening PRs without an architect-approved issue
- Opening multiple PRs in a single run
- Bypassing the budget gate
- Autonomously closing, labelling, or editing another agent's focus/design issue
- Running `git push --force` or amending non-local commits
- Calling the Python bootstrap (Stage0)

## Changing this contract

This file is the spec for the autonomous layer. Changes to agent behaviour
must land here **before** the corresponding `.md` workflow is updated. A PR
that edits a workflow without updating this file (when rules change) should
be flagged by QC.
