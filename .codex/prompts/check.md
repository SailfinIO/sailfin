# Codex Check Prompt

```text
Verify the current Sailfin working tree.

Follow AGENTS.md and .codex/skills/sailfin-check/SKILL.md. Inspect the diff, identify what changed, choose the smallest sufficient verification ladder, and run the checks. Prefer `sfn check <touched .sfn files>` as the fast parse/type/effect inner loop, then `make compile` for compiler-source changes and `make check` only for full-gate needs. The compiler self-caps memory; no `ulimit` prefix. Wrap direct single-file compiler invocations with `timeout 60`.
```
