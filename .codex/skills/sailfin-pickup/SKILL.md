---
name: sailfin-pickup
description: Pick up a ready Sailfin GitHub issue and drive it through branch, implementation, verification, and PR handoff.
---

# Sailfin Pickup Skill

Use this skill when the user asks Codex to pick up an issue, work the next item, or emulate Claude's `/pickup` flow.

## Issue selection

1. Query ready issues:
   ```bash
   gh issue list --label "claude-ready" --state open --json number,title,labels,assignees,body --limit 50
   ```
2. Filter out blocked, in-progress, assigned, or externally blocked work.
3. Rank remaining issues by:
   - `priority:critical`
   - `priority:high`
   - `type:bug`
   - `type:perf`
   - smallest `size:*` (`XS` before `S` before `M`)
   - lowest issue number

If the user supplied an issue number, fetch it directly with `gh issue view <N> --json number,title,labels,assignees,body,state` and validate the same pickability rules.

## Seed dependency policy

`make compile` self-hosts against the binary pinned by `.seed-version`, so a compiler-source capability that a consumer needs in the pinned seed can force a seed cut. Apply the project seed-dependency rule:

- Bundle a capability with its single tightly-coupled consumer by default; this avoids manufacturing a seed cut.
- Split only when the capability has multiple consumers, is genuinely independent, or has a large blast radius.
- When split, the predecessor should be labeled `seed-blocker`, the consumer should list it under `## Required in pinned seed`, and the seed bump queues against the normal cadence unless release-critical.

Before claiming compiler/runtime work, read the issue body. If `## Required in pinned seed` lists predecessors, verify at least one closing/merge commit (or an explicit content expectation from the issue body) is present in the pinned seed tag. If not, comment on the issue and stop without claiming it.

## Claim and branch

```bash
gh issue edit <N> --add-label "in-progress" --remove-label "claude-ready"
.claude/scripts/sync-project-status.sh <N> --from-labels || true
git switch -c codex/<N>-<slug>
```

The project sync helper remains under `.claude/scripts/` because it is provider-neutral repository automation.

## Implementation rules

- Restate the issue goal, scope, acceptance criteria, files affected, design/SFEP references, and verification plan before editing.
- For multi-pass compiler changes, implement in pipeline order: lexer, parser, AST, type checker, effect checker, native emitter, LLVM lowering, runtime/prelude if needed, tests.
- Keep changes focused and update `docs/status.md` first when behavior changes.
- Add or update Sailfin-native tests beside related coverage under `compiler/tests/`.
- Use the Sailfin check skill for formatting and verification.

## PR handoff

- Run the verification commands from the issue body plus the Sailfin check ladder.
- Commit atomically with a Conventional Commit style message, for example `fix(compiler): handle ...`.
- Open a PR whose body includes scope, issue link (`Closes #N`), SFEP/design link when applicable, verification commands, and residual concerns.
