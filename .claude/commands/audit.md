# Sanity audit

Quick sanity check of the current workspace. Designed to be run on its own (`/audit`) or on a recurring timer (`/loop 10m /audit`) during long autonomous sessions so regressions surface early.

## Steps

1. If `make check` has not completed in this session, run the `check` skill. Do not re-run it if a successful run is already on record.

2. If tests **fail**: diagnose exactly one failure. Identify the pipeline stage and the root cause using `references/pipeline-stages.md` from the `debug-compile` skill. **Do not attempt fixes autonomously** — just report the failure, the stage, and the suspected cause.

3. If tests **pass**: summarize any uncommitted compiler changes on the current branch:

   ```bash
   git status --short
   git diff --stat HEAD
   ```

   Note whether the working tree has drifted from `origin/<branch>` (the `<git-context />` injected on every prompt already shows dirty/unpushed counts).

## Constraints

- Respect the memory cap — the `PreToolUse` hook will block compiler invocations without `ulimit -v 8388608`.
- This is a **read-only** audit. Do not edit source, do not commit, do not push.
- Report findings in ≤ 10 lines; longer reports defeat the purpose of a recurring audit.
