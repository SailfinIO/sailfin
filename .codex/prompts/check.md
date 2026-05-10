# Codex Check Prompt

```text
Verify the current Sailfin working tree.

Follow AGENTS.md and .codex/skills/sailfin-check/SKILL.md. Inspect the diff, identify what changed, choose the smallest sufficient verification ladder, and run the checks. Prefix every Sailfin compiler or make command with `ulimit -v 8388608 &&`. Report exact commands and results.
```
