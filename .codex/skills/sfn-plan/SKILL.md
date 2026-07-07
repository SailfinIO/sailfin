---
name: sfn-plan
description: Plan Sailfin work in Linear from Initiatives through Projects to session-sized compiler/runtime issues. Use when Codex needs to audit or create Linear planning structure, prioritize production compiler/runtime health and performance, assign Projects/Cycles/priorities/estimates, groom Triage/Backlog/Ready/Blocked queues, or propose/apply bulk Linear issue updates.
---

# Sailfin Planning Skill

Use this skill for Linear planning and queue maintenance. The goal is a
production-ready, high-performance Sailfin compiler/runtime, not a tidy board.
Use `sailfin-pickup` only after a leaf issue is ready to implement.

## Planning Sources

Use Linear as the planning source of truth:

1. Initiatives: durable product/engineering pillars.
2. Projects: epics under Initiatives.
3. Issues: session-sized leaves under Projects.
4. Cycles: release windows across Projects.

Read repo context only to validate technical truth:

- `docs/conventions/linear-workflow.md`
- `docs/conventions/linear-templates.md`
- `docs/conventions/issue-naming.md`
- `docs/status.md` for what currently ships
- relevant SFEPs or design notes under `docs/proposals/`
- compiler/runtime source or tests when issue feasibility depends on code facts

Do not use `site/src/pages/roadmap.astro` as the source for planning direction.
The site is a published view; Linear Initiatives/Projects are the planning
surface. Only inspect site files when the task is specifically docs/site sync.

## Operating Rules

- Read first, propose second, write third. Do not bulk-update Linear until the
  user approves the proposed batch.
- Do not invent planning direction from stale docs, vibes, or issue counts.
  Every created or promoted issue must trace to a Linear Initiative/Project, an
  accepted/draft design record, a status gap, a failing/fragile verification
  path, or direct source evidence.
- Prefer fewer, sharper issues over broad backlog expansion. A healthy queue has
  pickable leaves, not hundreds of ambiguous tickets.
- Treat releases as Cycles, never Projects. Keep release scope orthogonal to
  each issue's epic Project.
- Use Linear native fields for status, priority, estimate, Project, Cycle,
  assignee, blockers, and relations. Do not create labels for those dimensions.
- Never move an issue to `Ready` unless it is session-sized, unblocked,
  prioritized, estimated, and has clear acceptance criteria plus verification.

## Production Health Lens

When prioritizing or creating work, classify the technical reason explicitly:

| Lens | Use for |
|---|---|
| Correctness | miscompiles, type/effect holes, invalid diagnostics, spec mismatches |
| Self-hosting | fixed-point determinism, seed readiness, compiler rebuild safety |
| Performance | compile latency, memory/RSS, cache effectiveness, runtime throughput |
| Runtime safety | ABI soundness, ownership/lifetime hazards, TLS/net/io behavior |
| Portability | Linux/macOS/Windows build and runtime behavior |
| Developer ergonomics | diagnostics, `sfn check`, `sfn test`, build output, MCP/LSP |
| Release health | blockers for the next Cycle, seed bumps, CI and packaging gates |

Urgent/High priorities require a concrete health rationale. Low-priority polish
should not crowd out correctness, self-hosting, performance, or release health.

## Discovery Workflow

Build a live inventory with Linear tools:

1. Resolve the Sailfin (`SFN`) team, states, Cycles, labels, Projects, and
   Initiatives. If Initiative listing is not directly available, recover it from
   Project initiative fields/status updates; if it cannot be recovered, stop and
   report that the hierarchy is unavailable.
2. For each Initiative, list active/planned Projects and recent status updates.
3. For each Project, list open issues grouped by status, priority, estimate,
   assignee, blocker state, and Cycle.
4. Find open issues with no Project, no priority, no estimate, no Cycle where
   release-scoped, stale `Blocked`, stale `Ready`, or oversized scope.
5. Sample enough issue descriptions and related SFEP/status/source context to
   explain recommendations with evidence.

When status names differ, use the names returned by Linear and map them to repo
concepts: intake (`Triage`/`To triage`), scoped not pickable (`Backlog`),
pickable (`Ready`), claimed (`In Progress`), waiting (`Blocked`), and terminal
completed/canceled states.

## Issue Construction Bar

Create or promote only leaf issues. Each proposed issue must include:

- Initiative and Project, or a reason it is intentionally unprojected.
- Health lens and priority rationale.
- Goal in one or two sentences.
- Semantic `In`/`Out` scope, not a brittle file checklist.
- Acceptance criteria with observable behavior.
- Verification commands or test expectations.
- Estimate on the Sailfin scale: `1` = XS, `2` = S, `3` = M.
- Design/status/source evidence: SFEP/design note, `docs/status.md` row, failing
  test class, code location, release blocker, or prior issue/PR.
- Blocker relations when work depends on another unresolved issue.

Anything larger than M becomes a Project or remains in triage for splitting.
Do not file speculative "improve performance" issues without a measurement,
benchmark target, regression signal, or concrete compiler/runtime bottleneck.

## Queue Actions

Classify each issue into one action bucket:

- `create_project`: a durable epic is missing under an Initiative.
- `create_leaf`: a concrete leaf is missing and meets the construction bar.
- `attach_project`: an existing issue clearly belongs to a Project.
- `fill_fields`: priority, estimate, Cycle, or relation is missing.
- `promote_ready`: issue meets the Ready bar and has no blockers.
- `move_backlog`: scoped but not ready or not current-cycle work.
- `move_triage`: ambiguous, oversized, missing evidence, or needs design.
- `keep_blocked`: real unresolved blocker remains.
- `unblock_candidate`: only completed hard blockers remain; no prose gate.
- `cycle_candidate`: should be in an upcoming release Cycle.
- `cancel_candidate`: obsolete, duplicate, or superseded; requires approval.

Project priority follows the highest-priority current gating leaf. Project status
rolls up from leaves: started when any leaf is in progress, planned when ready
leaves exist, backlog before grooming.

## Release Cycle Planning

For a release:

1. Resolve the target Linear Cycle and the GitHub `Release: vX.Y.Z` tracker if
   one exists.
2. Pull candidates from Linear Projects, release labels, seed blockers,
   self-hosting status, CI/package gates, and explicit user direction.
3. Propose `in_cycle`, `roll_forward`, and `not_release_scope` groups with
   rationale.
4. After approval, assign accepted issues to the Cycle and normalize Project,
   priority, estimate, and blocker fields.
5. If an issue is acting as a release tracker in `Todo`, propose converting it
   into a real leaf, linking it to the Cycle/tracker, or canceling it. Do not
   make the release a Project.

## Proposal Format

Before writes, present:

```text
Sailfin Planning Proposal

Objective:
- <production compiler/runtime outcome>

Inventory:
- Initiatives reviewed: <N>
- Projects reviewed: <N>
- Issues reviewed: <N>
- Cycle: <name or none>

Recommended actions:
| Action | Count | Examples | Evidence |
|---|---:|---|---|
| Create Project | N | <name> | Initiative gap / design record |
| Create Leaf | N | <title> | status/source/perf evidence |
| Attach Project | N | SFN-123 -> Project | goal matches epic |
| Fill Fields | N | SFN-456 priority High estimate 2 | health rationale |
| Move Status | N | SFN-789 Backlog -> Ready | passes Ready bar |
| Assign Cycle | N | SFN-111 -> vX.Y.Z | release gate |

Held back:
- SFN-222: missing evidence / oversized / unresolved design / prose blocker

Risks:
- <planning or technical uncertainty>
```

After approval, apply small logical batches and report each changed issue with
old and new field values. If a write tool lacks a needed field, stop and report
the gap instead of approximating with labels.
