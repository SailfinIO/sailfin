---
name: sailfin-pickup
description: Pick up a ready Sailfin Linear or GitHub issue and drive it through branch, implementation, verification, and PR handoff.
---

# Sailfin Pickup

Use this skill when the user asks Codex to pick up an issue, work the next
item, or emulate Claude's `/pickup` flow. Work autonomously from selection
through a draft pull request unless a stop condition below applies.

## Select and claim

- `SFN-123` selects that Linear issue. A bare number selects that GitHub issue
  and its Linear mirror when one exists. With no identifier, choose the
  highest-priority pickable Sailfin issue in Linear's native `Ready` state.
- A pickable issue is unassigned or assigned to the current user and has no
  unresolved blocker. Rank candidates by Linear priority, then `type:bug`,
  `type:perf`, smallest estimate, and lowest identifier.
- Linear owns workflow state. If Linear is unreachable, do not infer state from
  retired GitHub workflow labels.
- Before editing, set the Linear issue to `In Progress`, assign it to the
  current user, and create `codex/SFN-123-<slug>` (or
  `codex/<N>-<slug>` for a GitHub-only issue).

Read the complete issue and any cited SFEP or design note. Treat its goal,
semantic scope, acceptance criteria, and verification commands as the contract;
the listed files are an advisory map that may have drifted.

## Execute

Implement the smallest cohesive change that satisfies the contract. Follow
`AGENTS.md`, update tests and documentation when behavior changes, and use the
`sailfin-check` skill for the appropriate formatting, self-hosting, and
verification gates.

Apply the seed-dependency policy in `.claude/rules/seed-dependency.md`. Verify
any predecessor explicitly listed under `## Required in pinned seed` before
claiming compiler or runtime work. Stop without claiming when the prerequisite
is absent from the pinned seed.

Pause only when the issue is blocked, its semantic scope must expand, an
acceptance criterion is impossible or materially wrong, or the seed policy
requires a genuine bundle-versus-split decision. File-path drift within the
stated semantic scope is not a reason to pause.

## Record discoveries

This workflow authorizes creating Linear follow-up issues for concrete bugs,
missing behavior, or trackable gaps discovered outside the claimed scope.
Search Linear first to avoid duplicates; do not expand the current change
silently.

Use `docs/conventions/linear-templates.md` for fields and description content.
Relate the follow-up to the source issue, preserve its Project when appropriate,
and mark it blocked by the current issue only when it truly cannot start before
the current pull request lands. Leave uncertain or oversized discoveries in
`Triage` rather than over-specifying them.

## Finish

- Check every acceptance criterion and run the issue's verification commands
  plus the `sailfin-check` ladder. Prefer targeted tests; use full gates only
  when requested or warranted by structural/high-risk work.
- Commit the focused change and open a draft PR with the issue and design links,
  acceptance status, exact verification commands, and residual concerns.
- Include `Fixes SFN-123` for Linear integration and `Closes #N` when a GitHub
  mirror exists. Move the Linear issue to `In Review`; merging, not this skill,
  completes it.
- Report the issue, branch, PR, verification results, follow-ups, and anything
  surprising enough to improve future grooming.
