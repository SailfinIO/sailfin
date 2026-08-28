---
name: sailfin-pickup
description: Pick up a ready Sailfin Linear or GitHub issue and drive it through branch, implementation, verification, independent review, and a ready-for-review PR handoff.
---

# Sailfin Pickup

Use this skill when the user asks Codex to pick up an issue, work the next
item, or emulate Claude's `/pickup` flow. Work autonomously from selection
through a ready-for-review pull request unless a stop condition below applies.

## Select and claim

- Before selecting or claiming an issue, run `git pull --ff-only origin main`
  so the pickup starts from the latest remote main. Stop if the update fails;
  do not merge, rebase, or overwrite local work to force it through.
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

Use Codex subagents when a bounded slice can proceed independently, such as
read-only surface mapping, a mechanical implementation slice, or first-pass
test-failure classification. Give each helper the issue contract and an exact
scope, keep ownership of sequencing and scope decisions in the main agent, and
inspect helper results before incorporating them. Helper delegation is optional;
the independent review gate below is mandatory.

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

## Review

Before review, check every acceptance criterion and run the fast and targeted
rungs selected by the `sailfin-check` ladder. If the issue requests `sfn test`,
`sfn dev verify`, or `sfn dev verify --strict`, or the change qualifies for one of those
full gates, record it as a deferred final gate rather than running it on a diff
that review may invalidate. Do not omit the requested gate; run it after the
change is review-stable.

Then spawn a fresh review subagent before committing or opening the PR. Keep the
reviewer independent: provide the issue contract, cited design, repository
instructions, verification results, `git status`, and the complete intended
change including untracked files, but do not provide the main agent's
conclusions or coach it toward approval.

Ask the reviewer to inspect correctness, self-hosting and pipeline completeness,
effect and ownership semantics, LLVM safety when relevant, scope discipline,
test coverage, documentation, and project conventions. Require findings to cite
files and lines and to distinguish blocking correctness issues from optional
improvements. A finding is blocking only when it demonstrates an acceptance,
correctness, safety, regression, or repository-invariant failure with concrete
code reasoning or a reproduction. Verify the finding before changing code; the
reviewer's severity label alone is not conclusive.

Resolve every blocking finding, rerun the affected verification, and request
another independent review when the fix materially changes behavior. Do not
promote optional improvements or unsupported concerns into blocking churn.
Count the initial review and each re-review as one review pass, and limit the
autonomous review/remediation loop to three passes. If the third pass still has
a blocking finding, or a later failure would require another source change,
stop and report the review history and remaining evidence rather than starting
a fourth pass.

Once review has no blocking findings, run every deferred full gate on that
review-stable revision. A source change made to fix a gate failure invalidates
the review and requires affected targeted verification, another review pass
within the limit above, and the deferred gate again. Do not commit or publish
the PR until review is clear and all required gates pass. If subagents are
unavailable, stop and report that the required independent review could not be
run rather than silently replacing it with a self-review.

## Finish

- Commit the reviewed, focused change and open a ready-for-review PR (not a
  draft) with the issue and design links, acceptance status, exact verification
  commands, review outcome, and residual concerns.
- Include `Fixes SFN-123` for Linear integration and `Closes #N` when a GitHub
  mirror exists. Move the Linear issue to `In Review`; merging, not this skill,
  completes it.
- Report the issue, branch, PR, verification and independent-review results,
  follow-ups, and anything surprising enough to improve future grooming.
