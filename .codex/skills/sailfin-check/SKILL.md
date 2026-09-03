---
name: sailfin-check
description: Run Sailfin compiler and test verification safely with the required self-hosting and formatting gates.
---

# Sailfin Check Skill

Use this skill whenever a task touches Sailfin compiler sources, runtime code, tests, or docs that describe implementation status.

## Safety invariant

- The compiler self-caps memory at 8 GiB on Linux (`SAILFIN_MEM_LIMIT` overrides); do not add `ulimit` prefixes or PreToolUse guards for ordinary runs.
- Wrap direct single-file compiler invocations with `timeout 60`; native pipeline commands handle their own timeouts.
- If `.sfn` files under `compiler/src/`, `compiler/capsules/`, or `runtime/` changed, run the formatter before final verification: `sfn fmt --write <files>` followed by `sfn fmt --check <files>` (or `build/bin/sfn ...` when `sfn` is not on `PATH`).
- If compiler source under `compiler/src/` or `compiler/capsules/` changed, run `sfn dev bootstrap build` before test-only validation so tests do not use a stale compiler binary.

## Verification ladder

1. Documentation/config-only change: run a fast syntax/readability check when available, otherwise `git diff --check`.
2. Sailfin source edit inner loop: run `sfn check <touched files>` (or `build/bin/sfn check <path>`) to catch parse/type/effect errors quickly.
3. Test-only or example change: run the targeted test first; run a broader suite only when the issue asks for it or risk warrants it.
4. Compiler/runtime source change: run `sfn dev bootstrap build` when the change touches compiler self-hosting surface, then run the targeted `build/bin/sfn test <path>` / `-k` / `--tag` commands.
5. Structural compiler change: rebuild with `sfn dev bootstrap build --clean-tree`.

Use `sfn test`, `sfn dev verify`, or `sfn dev verify --strict` only when the issue
explicitly requests a full-suite, release, determinism, or self-host fixed-point
gate; when declaring a feature shipped or cutting a release; or when the final
change is structural or high-risk. Structural work includes file splits, new
modules, module-graph changes, and renamed exports. High-risk work includes
self-host/bootstrap machinery, runtime ABI or startup, cross-pass compiler
contracts, ABI-affecting or cross-cutting LLVM/codegen changes, and concurrency,
cache-correctness, or determinism behavior. Merely touching compiler/runtime
source, changing several files, or receiving a serious review finding does not
by itself require a full gate.

During an issue-pickup workflow, run fast checks, `sfn dev bootstrap build`, and
targeted tests before independent review. Defer qualifying full gates until the candidate
has no blocking review findings so the expensive result applies to the final
revision. If a later source edit invalidates that result, repeat the affected
verification on the new review-stable revision.

## SFEP and docs coupling

- Behavior/status changes update the relevant spec/preview page and roadmap if applicable. `docs/status.md` is reconciled on the release cadence by `/status-sweep`, not by the change itself.
- Forward-looking design work belongs in an SFEP under `docs/proposals/`; do not mark SFEPs `Implemented` before Stage1 readiness and self-hosting are complete.

## Reporting

In the final response, list the exact command for every check and mark environment limitations separately from agent errors.
