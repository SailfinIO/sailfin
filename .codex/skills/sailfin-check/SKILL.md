---
name: sailfin-check
description: Run Sailfin compiler and test verification safely with the required memory cap.
---

# Sailfin Check Skill

Use this skill whenever a task touches Sailfin compiler sources, runtime code, tests, or docs that describe implementation status.

## Safety invariant

- Prefix every `make` target that may compile or test Sailfin with `ulimit -v 8388608 &&`.
- Prefix direct compiler invocations with `ulimit -v 8388608 && timeout 60` for single test files or examples.
- If `.sfn` files under `compiler/src/` or `runtime/` changed, run the formatter before final verification.

## Verification ladder

1. Documentation/config-only change: run a fast syntax/readability check when available, otherwise `git diff --check`.
2. Test-only or example change: run the targeted test first, then `ulimit -v 8388608 && make test` when a compiler binary exists.
3. Compiler/runtime source change: run `ulimit -v 8388608 && make compile` before `ulimit -v 8388608 && make test`; use `make check` when time allows.
4. Structural compiler change: run `ulimit -v 8388608 && make clean-build` before rebuilding.

## Reporting

In the final response, list the exact command for every check and mark environment limitations separately from agent errors.
