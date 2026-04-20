# Sailfin Agent Contract

This document is the canonical source of truth for how autonomous agents
coordinate on this repository. Every workflow in `.github/workflows/*.md` and
every agent role in `.github/agents/*.agent.md` must honour the rules below.

If an agent's behaviour conflicts with this document, this document wins.

## How these workflows actually run

The `.github/workflows/*.md` files are **gh-aw source**, not what GitHub
Actions executes. Each `.md` compiles via `gh aw compile` into a sibling
`.github/workflows/*.lock.yml`, and Actions runs the lock file. **Source
edits do not take effect until the lock file is regenerated and committed.**
Whenever you change a `.md` workflow, run `gh aw compile` (or
`gh aw compile --approve-updates` when introducing a new restricted
secret) and commit the resulting `.lock.yml` in the same PR. The
`activation` check enforces this.

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
- **Cadence:** weekly on Mondays (off-peak minute; see workflow cron) + manual dispatch
- **Reads:** roadmap, `docs/status.md`, `docs/build-performance.md`, open issues, recent merges, CI health
- **Writes:** exactly ONE GitHub issue titled `Focus: Week of YYYY-MM-DD`, labeled `focus:proposed`, pinned via comment
- **Must NOT:** open PRs, modify code, close issues, label other issues, run the compiler
- **Human gate:** a human applies `focus:approved` to activate downstream agents
- **Output shape:** 3–5 workstreams, each with (name, why-now, rough success criterion, linked roadmap epic or status section)

### Tier 1 — Architecture (Architect + Grooming)

- **Workflows:** `.github/workflows/architect-review.md` (reactive), `.github/workflows/nightly-grooming.md` (proactive)
- **Cadence:** architect-review on `issues: labeled`; grooming runs daily (off-peak minute; see workflow cron), noop if no `focus:approved` issue exists
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
2. If the returned count ≥ 2, emit `noop` with message exactly:
   `"budget gate: <N>/2 open agent-authored PRs; standing down"`
3. Otherwise proceed; apply `agent-authored` label to the resulting PR

The string is reproduced verbatim in `engineer.md`. If you change the
wording in one file, change it in the other in the same commit — the
contract and the implementation must agree.

To change the budget, edit this file and the inline comment in
`engineer.md`. Do not change it via agent prompts.

The engineer workflow also enforces this with a `concurrency` group
(`gh-aw-engineer`, `cancel-in-progress: false`) so two near-simultaneous
label events serialize. Without the concurrency block, both runs could
pass the PR-count check before either applied its `agent-authored` label.

## Engine and model per tier

All workflows use `engine: id: claude` and require an `ANTHROPIC_API_KEY`
repo secret. Selecting the right model per tier is a real cost lever and
the only knob that matters for spend; everything else is rounding.

| Workflow | Model | Why |
|---|---|---|
| `planner.md` | `claude-opus-4-7` | Strategic synthesis; runs once a week |
| `architect-review.md` | `claude-opus-4-7` | Non-trivial reasoning; gates downstream code |
| `engineer.md` | `claude-opus-4-7` | Code quality is the product |
| `pr-review.md` | `claude-sonnet-4-6` | Four-perspective review; quality/cost sweet spot |
| `nightly-grooming.md` | `claude-haiku-4-5` | Pattern-match focus → templated issue |
| `issue-triage.md` | `claude-haiku-4-5` | Label routing |
| `release-notes.md` | `claude-haiku-4-5` | Commit summarization |

Rule of thumb: **Opus when wrong output corrupts a downstream tier;
Haiku when wrong output is easily caught by a human in seconds.**

To change a tier's model, edit the workflow file directly and update this
table in the same PR.

## Concurrency contract

Every workflow declares a `concurrency.group`. The pattern:

| Workflow | Group | cancel-in-progress | Why |
|---|---|---|---|
| `planner.md` | `gh-aw-planner` | `false` | Manual dispatch must not race scheduled run |
| `nightly-grooming.md` | `gh-aw-grooming` | `false` | Same reason |
| `engineer.md` | `gh-aw-engineer` | `false` | **Critical** — closes the budget-gate race |
| `architect-review.md` | `gh-aw-architect-${{ issue.number }}` | `false` | Per-issue serialization |
| `issue-triage.md` | `gh-aw-triage-${{ issue.number }}` | `true` | Edit retriggers — latest content wins |
| `pr-review.md` | `gh-aw-pr-review-${{ pr.number }}` | `true` | Force-push retriggers — latest commit wins |
| `release-notes.md` | `gh-aw-release-notes-${{ tag }}` | `false` | One comment per release tag |

`cancel-in-progress: false` preserves queued work (use when each event matters);
`true` discards superseded work (use when only the latest input is interesting).

## Skip-if-no-match short-circuits

Some workflows trigger on event types that fire often but only do work for
specific labels. Those use `skip-if-no-match` to exit at the workflow level
before booting the agent — saves the first-turn cost of writing a noop:

- `engineer.md`: `skip-if-no-match: 'label:design-approved OR label:bug'`
- `architect-review.md`: `skip-if-no-match: 'label:needs-design'`

The agent's preconditions still re-validate; this is purely an early exit.

## Repo memory

The Planner uses `tools.repo-memory` (branch `memory/planner`) for
cross-week continuity. It reads `state.md` from prior runs (last week's
workstream assessments and forward-looking notes) before composing the
new focus, then writes a fresh state at the end of each run. This is the
difference between "re-derive context every Monday" and "remember it."

If we find Grooming or other recurring agents need similar continuity,
add `tools.repo-memory` with a unique `id` per agent.

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
