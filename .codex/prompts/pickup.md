# Codex Pickup Prompt

Use this prompt in Codex web or CLI when you want the Claude `/pickup` experience.

```text
Pick up the next Sailfin issue and drive it to a pull request.

Follow this repository's AGENTS.md and use the Sailfin pickup workflow in .codex/skills/sailfin-pickup/SKILL.md. If I provide `SFN-123`, use that Linear issue. If I provide a bare number, use that GitHub issue and resolve its Linear mirror. Otherwise select the highest-priority pickable issue in Linear's native `Ready` status. Workflow state is Linear-native — there is no GitHub `claude-ready` label fallback (it is retired); if Linear is unreachable, stop and report rather than guessing from a GitHub label.

Required workflow:
1. Query Linear `Ready` issues for the Sailfin team and choose/validate the issue; fall back to `gh` for GitHub-only issues.
2. Read any referenced SFEP/design note before planning; do not redesign an accepted SFEP in the issue body.
3. Apply the seed-dependency policy: bundle a single tightly-coupled compiler-source capability with its consumer by default; verify `## Required in pinned seed` only when the issue explicitly requires a predecessor in the pinned seed.
4. Claim the Linear issue, best-effort sync any GitHub mirror, and create a `codex/SFN-123-<slug>` branch for Linear pickup or `codex/<issue>-<slug>` for GitHub-only fallback.
5. Restate the issue goal, scope, acceptance criteria, files affected, design references, and verification plan.
6. Implement the smallest focused change that satisfies the issue.
7. If you discover a real bug or obvious gap outside the claimed scope, search Linear for duplicates and file a Sailfin (`SFN`) follow-up using Linear-native status, priority, estimate, Project, blocker, and relation fields. Use only canonical `type:*` and `area:*` labels, and follow `docs/conventions/linear-templates.md`.
8. Run the issue's verification commands plus the Sailfin safety checks from .codex/skills/sailfin-check/SKILL.md. Prefer targeted `build/bin/sfn test <path>` / `-k` / `--tag` commands; reserve `make test` and `make check` for issues that explicitly need a full gate or structural/high-risk changes.
9. Commit the changes and open a PR with the Linear issue link plus `Closes #<issue>` when a GitHub mirror exists.

The compiler self-caps memory at 8 GiB on Linux; do not use a `ulimit` prefix. Wrap direct single-file compiler invocations with `timeout 60`.
```
