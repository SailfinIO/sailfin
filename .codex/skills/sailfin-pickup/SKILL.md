---
name: sailfin-pickup
description: Pick up a ready Sailfin Linear or GitHub issue and drive it through branch, implementation, verification, and PR handoff.
---

# Sailfin Pickup Skill

Use this skill when the user asks Codex to pick up an issue, work the next item,
or emulate Claude's `/pickup` flow.

## Issue selection

Issue identifiers are accepted in two forms:

- `SFN-123` selects the Linear issue directly.
- `123` selects GitHub issue `#123`, then looks up the Linear mirror when the
  Linear tools are reachable.

With no explicit issue, prefer Linear. Query Sailfin (`SFN`) Linear issues in
the native `Ready` status, then filter out any issue that is assigned to someone
else, canceled, completed, or externally blocked. Workflow state is
Linear-native — there is no GitHub `claude-ready` label to fall back to (it is
retired). If the Linear tools are unreachable, stop and report that rather than
guessing a pick from a GitHub label.

Rank remaining issues by:

   - Linear-native priority Urgent, then High
   - `type:bug`
   - `type:perf`
   - smallest `size:*` (`XS` before `S` before `M`)
   - lowest Linear identifier, then lowest GitHub issue number when tied

For a supplied `SFN-123`, resolve it with Linear first and validate the same
pickability rules. For a supplied GitHub issue number, fetch it directly with
`gh issue view <N> --json number,title,labels,assignees,body,state,url` and then
try to resolve the Linear mirror by querying the issue number or URL.

## Seed dependency policy

`make compile` self-hosts against the binary pinned by `bootstrap.toml [seed].version`, so a compiler-source capability that a consumer needs in the pinned seed can force a seed cut. Apply the project seed-dependency rule:

- Bundle a capability with its single tightly-coupled consumer by default; this avoids manufacturing a seed cut.
- Split only when the capability has multiple consumers, is genuinely independent, or has a large blast radius.
- When split, the predecessor should be labeled `seed-blocker`, the consumer should list it under `## Required in pinned seed`, and the seed bump queues against the normal cadence unless release-critical.

Before claiming compiler/runtime work, read the Linear description or GitHub
issue body. If `## Required in pinned seed` lists predecessors, verify at least
one closing/merge commit (or an explicit content expectation from the issue
body) is present in the pinned seed tag. If not, comment on the Linear issue or
GitHub issue and stop without claiming it.

## Claim and branch

For Linear-native pickup, claim Linear first:

- set state to `In Progress`;
- assign to `me` when the Linear tools support it;
- do not add GitHub workflow-state labels such as `blocked`, `in-progress`, or
  `claude-ready` (all retired) — Linear's native status is the single source of
  truth.

A GitHub mirror (external-intake issue) needs no status-label sync: its state is
derived from the Linear issue you have already advanced.

Create the branch as `codex/SFN-123-<slug>` for Linear-native pickup, or
`codex/<N>-<slug>` for GitHub-only fallback.

## Implementation rules

- Restate the issue goal, scope, acceptance criteria, files affected, design/SFEP references, and verification plan before editing.
- For multi-pass compiler changes, implement in pipeline order: lexer, parser, AST, type checker, effect checker, native emitter, LLVM lowering, runtime/prelude if needed, tests.
- Keep changes focused and update `docs/status.md` first when behavior changes.
- Add or update Sailfin-native tests beside related coverage under `compiler/tests/`.
- Use the Sailfin check skill for formatting and verification.

## Follow-up issue filing

During pickup, do not silently expand the current issue when you discover a
real bug, missing acceptance criterion, or obvious gap outside the claimed
scope. Search Linear first to avoid duplicates, then file a Sailfin (`SFN`)
Linear issue when the work is concrete enough to track.

Create follow-ups with Linear-native fields:

- Team: `Sailfin` (`SFN`).
- Status: `Triage` when the gap needs human shaping, `Backlog` when scoped but
  not yet ready, `Blocked` when it depends on the current issue/PR or another
  unresolved blocker, and `Ready` only when it is fully groomed, unblocked, and
  pickable.
- Project: reuse the current issue's Project when the follow-up belongs to the
  same epic; otherwise leave it unprojected only when genuinely cross-cutting
  and say why in the description.
- Priority: inherit the current issue or Project priority unless the discovery
  is a release, self-hosting, seed, or correctness blocker. Use Urgent only for
  drop-everything blockers, High for critical-path work, Medium for enabling
  current-milestone work, and Low for polish or post-milestone work.
- Estimate: use the Sailfin Linear scale (`1` = XS, `2` = S, `3` = M). If the
  work is larger than M, leave it in `Triage` or create a Project/design note
  instead of filing an oversized leaf.
- Labels: use only canonical `type:*` and `area:*` labels. Do not add Linear
  labels for status, priority, estimate, release, blockers, assignee, or
  project membership.
- Relations: mark the follow-up `related to` the current issue; mark it
  `blocked by` the current issue only when it cannot start before the current
  PR lands.

Use the repository template in `docs/conventions/linear-templates.md` for the
issue description. The description must include the discovery source, expected
acceptance criteria, verification commands or test expectations, and links to
the current issue/PR or GitHub mirror when available.

## PR handoff

- Run the verification commands from the issue body plus the Sailfin check ladder. Do not expand to `make test` or `make check` unless the issue asks for a full gate or the implementation is structural/high-risk.
- Commit atomically with a Conventional Commit style message, for example `fix(compiler): handle ...`.
- Open a PR whose body includes scope, issue links, SFEP/design link when
  applicable, verification commands, and residual concerns. Use `Closes #N`
  when a GitHub mirror exists; always include the Linear issue link
  (`Linear: SFN-123`).
