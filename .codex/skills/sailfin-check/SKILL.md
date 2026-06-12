---
name: sailfin-check
description: Run Sailfin compiler and test verification safely with the required memory cap.
---

# Sailfin Check Skill

Use this skill whenever a task touches Sailfin compiler sources, runtime code, tests, or docs that describe implementation status.

## Safety invariant

- Wrap direct compiler invocations with `timeout 60` for single test files or examples (the compiler self-caps memory on Linux).
- If `.sfn` files under `compiler/src/` or `runtime/` changed, run the formatter before final verification.

## Verification ladder

1. Documentation/config-only change: run a fast syntax/readability check when available, otherwise `git diff --check`.
2. Test-only or example change: run the targeted test first, then `make test` when a compiler binary exists.
3. Compiler/runtime source change: run `make compile` before `make test`; use `make check` when time allows.
4. Structural compiler change: run `make clean-build` before rebuilding.

## Reporting

In the final response, list the exact command for every check and mark environment limitations separately from agent errors.
