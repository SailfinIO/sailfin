# Codex Pickup Prompt

Use this prompt in Codex web or CLI when you want the Claude `/pickup` experience.

```text
Pick up the next Sailfin issue and drive it to a pull request.

Follow this repository's AGENTS.md and use the Sailfin pickup workflow in .codex/skills/sailfin-pickup/SKILL.md. If I provide an issue number, use that issue; otherwise select the highest-priority pickable `claude-ready` issue.

Required workflow:
1. Query GitHub issues with `gh` and choose/validate the issue.
2. Read any referenced SFEP/design note before planning; do not redesign an accepted SFEP in the issue body.
3. Apply the seed-dependency policy: bundle a single tightly-coupled compiler-source capability with its consumer by default; verify `## Required in pinned seed` only when the issue explicitly requires a predecessor in the pinned seed.
4. Claim the issue, sync the project status, and create a `codex/<issue>-<slug>` branch.
5. Restate the issue goal, scope, acceptance criteria, files affected, design references, and verification plan.
6. Implement the smallest focused change that satisfies the issue.
7. Run the issue's verification commands plus the Sailfin safety checks from .codex/skills/sailfin-check/SKILL.md.
8. Commit the changes and open a PR with `Closes #<issue>`.

The compiler self-caps memory at 8 GiB on Linux; do not use a `ulimit` prefix. Wrap direct single-file compiler invocations with `timeout 60`.
```
