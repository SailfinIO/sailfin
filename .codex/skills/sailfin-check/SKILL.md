---
name: sailfin-check
description: Run Sailfin compiler and test verification safely with the required self-hosting and formatting gates.
---

# Sailfin Check Skill

Use this skill whenever a task touches Sailfin compiler sources, runtime code, tests, or docs that describe implementation status.

## Safety invariant

- The compiler self-caps memory at 8 GiB on Linux (`SAILFIN_MEM_LIMIT` overrides); do not add `ulimit` prefixes or PreToolUse guards for ordinary runs.
- Wrap direct single-file compiler invocations with `timeout 60`; `make` targets handle their own timeouts.
- If `.sfn` files under `compiler/src/` or `runtime/` changed, run the formatter before final verification: `sfn fmt --write <files>` followed by `sfn fmt --check <files>` (or `build/bin/sfn ...` when `sfn` is not on `PATH`).
- If `compiler/src/*.sfn` changed, run `make compile` before test-only validation so tests do not use a stale compiler binary.

## Verification ladder

1. Documentation/config-only change: run a fast syntax/readability check when available, otherwise `git diff --check`.
2. Sailfin source edit inner loop: run `sfn check <touched files>` (or `build/bin/sfn check <path>`) to catch parse/type/effect errors quickly.
3. Test-only or example change: run the targeted test first, then `make test` when a compiler binary exists.
4. Compiler/runtime source change: run `make compile` before `make test`; use `make check` when declaring a shipped feature, cutting a release, or after higher-risk changes.
5. Structural compiler change: run `make clean-build` before rebuilding.

## SFEP and docs coupling

- Behavior/status changes update `docs/status.md` first, then the relevant spec/preview page and roadmap if applicable.
- Forward-looking design work belongs in an SFEP under `docs/proposals/`; do not mark SFEPs `Implemented` before Stage1 readiness and self-hosting are complete.

## Reporting

In the final response, list the exact command for every check and mark environment limitations separately from agent errors.
