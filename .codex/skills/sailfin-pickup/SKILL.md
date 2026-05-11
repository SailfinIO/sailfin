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

## Seed freshness gate

Before claiming compiler or runtime work, read `.seed-version`, fetch the matching `v<seed>` tag, and verify every issue/PR listed in `## Required in pinned seed` has at least one closing or merge commit that is an ancestor of the seed tag. If not, comment on the issue and stop without claiming it.

## Claim and branch

```bash
gh issue edit <N> --add-label "in-progress" --remove-label "claude-ready"
.claude/scripts/sync-project-status.sh <N> --from-labels || true
git switch -c codex/<N>-<slug>
```

The project sync helper remains under `.claude/scripts/` because it is provider-neutral repository automation.

## Implementation rules

- Restate the issue goal, scope, acceptance criteria, files affected, and verification plan before editing.
- For multi-pass compiler changes, implement in pipeline order: lexer, parser, AST, type checker, effect checker, native emitter, LLVM lowering, tests.
- Keep changes focused and update `docs/status.md` first when behavior changes.
- Add or update Sailfin-native tests beside related coverage under `compiler/tests/`.

## PR handoff

- Run the verification commands from the issue body plus the Sailfin check ladder.
- Commit atomically with a Conventional Commit style message, for example `fix(compiler): handle ...`.
- Open a PR whose body includes scope, issue link (`Closes #N`), verification commands, and any residual concerns.
