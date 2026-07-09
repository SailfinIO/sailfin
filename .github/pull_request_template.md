<!--
Sailfin PR template. Fill in each section; delete this comment and any
inapplicable rows. Keep the Linear line — the org webhook links and closes
the issue from it. See docs/conventions/linear-workflow.md.

PR TITLE: Conventional Commit shape with the Linear issue id appended, e.g.
  feat(typecheck): register extern fn declarations (SFN-412)
The trailing `(SFN-NNN)` is required so SFN-NNN is visible in the PR list and
the squashed commit. Full spec: docs/conventions/issue-naming.md § 1.
-->

## Summary

<!-- What changed and why, in a few sentences. Which compiler pass(es) or
runtime module(s) this touches. Link the SFEP if one governs this work. -->

Fixes SFN-NNN

<!--
Linear magic words (org GitHub integration):
  - Auto-close on merge: Fixes / Closes / Resolves / Implements / Completes SFN-NNN
  - Link only, no close: Ref / Refs / Part of / Related to / Contributes to SFN-NNN
  - Several at once:      Fixes SFN-12, SFN-34 and SFN-56
  - Suppress linking:     add `skip SFN-NNN` or `ignore SFN-NNN`
Prefer `Fixes SFN-NNN` for the leaf this PR completes — never `Closes #N`
(GitHub-issue numbers don't drive our Linear workflow state).
-->

## Changes

<!-- Bullet the concrete edits, grouped by pipeline stage where it helps:
     lexer / parser / ast / typecheck / effect_checker / emit_native / llvm
     lowering / runtime / driver / tests / docs. -->

-

## Validation

<!-- Check what you actually ran. Compiler-source changes MUST clear the
self-host gate; a green `sfn check` is not a build guarantee (#1389). -->

- [ ] `sfn fmt --check` clean on every touched `.sfn` file
- [ ] `sfn check` (fast static analysis) passes
- [ ] `make compile` — compiler self-hosts (required for any `compiler/src/*.sfn` change; `make clean-build` first for structural changes)
- [ ] `make check` — full suite + seedcheck (for shipped features / releases / structural changes)
- [ ] Regression coverage added or updated under `compiler/tests/`
- [ ] N/A — docs/config-only change (no `.sfn` touched)

## Stage1 readiness

<!-- Only for a language/runtime feature. Delete this section otherwise.
"Parsed but not enforced" is NOT shipped — see CLAUDE.md. -->

- [ ] Parses, type-checks, and effect-checks
- [ ] Emits valid `.sfn-asm` and lowers to LLVM IR
- [ ] Effect enforcement wired end-to-end (not annotation-only)
- [ ] `docs/status.md` and the relevant spec §N chapter updated

## Notes for reviewers

<!-- Risk areas, deferred follow-ups (file a Linear issue and cite it —
no bare TODO), or anything the diff doesn't make obvious. -->
