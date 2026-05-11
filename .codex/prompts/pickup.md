# Codex Pickup Prompt

Use this prompt in Codex web or CLI when you want the Claude `/pickup` experience.

```text
Pick up the next Sailfin issue and drive it to a pull request.

Follow this repository's AGENTS.md and use the Sailfin pickup workflow in .codex/skills/sailfin-pickup/SKILL.md. If I provide an issue number, use that issue; otherwise select the highest-priority pickable `claude-ready` issue.

Required workflow:
1. Query GitHub issues with `gh` and choose/validate the issue.
2. Run the pinned-seed freshness gate before claiming compiler/runtime work.
3. Claim the issue, sync the project status, and create a `codex/<issue>-<slug>` branch.
4. Restate the issue goal, scope, acceptance criteria, files affected, and verification plan.
5. Implement the smallest focused change that satisfies the issue.
6. Run the issue's verification commands plus the Sailfin safety checks from .codex/skills/sailfin-check/SKILL.md.
7. Commit the changes and open a PR with `Closes #<issue>`.

Never run Sailfin compiler or make verification commands without `ulimit -v 8388608 &&`.
```
