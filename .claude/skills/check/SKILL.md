---
name: check
description: Run the full Sailfin compiler validation pipeline (make clean-build then make check). Use before declaring a feature shipped, before cutting a release, or when you need to verify self-hosting still works after a structural change.
allowed-tools: Bash, Read
---

# Full compiler validation

This skill runs `make check` — see CLAUDE.md `## The validation ladder` for what that pipeline covers and when to reach for it instead of a cheaper rung.

## Invoke

```bash
.claude/skills/check/scripts/run-check.sh
```

The script writes a timestamped log to `build/logs/check-<ts>.log`, and exits non-zero on failure with the last 80 lines of the log on stdout.

## Interpreting failures

If the script exits non-zero, read the log, identify the failing pipeline stage, and either:

- fix the compiler source (`compiler/src/*.sfn`), or
- spawn the `seed-stabilizer` agent if the root cause isn't obvious.

The four failure surfaces, in order of likelihood:

| Stage | Symptom | First place to look |
|---|---|---|
| Build from seed | Seed can't compile current source | Recent changes to parser/typecheck/emit |
| First-pass test suite | Behavior regression | The test's pipeline stage |
| Seedcheck build | First-pass binary miscompiles itself | LLVM lowering, emit_native |
| Hello-world smoke | Seedcheck can't run a basic program | Entry point, linker symbols |

## When NOT to use

See CLAUDE.md `## The validation ladder` — this skill is the top rung; use the
cheapest rung that catches the error instead.

## Budget

Expect 15–20 minutes on typical hardware. If the script runs past 30 minutes, something is wrong — investigate instead of waiting.
