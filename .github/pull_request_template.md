<!--
Sailfin PR template. Fill in each section; delete this comment and any
inapplicable rows. Keep the Linear line — the org webhook links and closes
the issue from it. See docs/conventions/linear-workflow.md.

PR TITLE: Conventional Commit shape with the Linear issue id appended, e.g.
  feat(typecheck): register extern fn declarations (SFN-412)
The trailing `(SFN-NNN)` is required on any PR completing a Linear leaf, so
SFN-NNN is visible in the PR list and the squashed commit (omit it only for a
PR with no backing issue). Full spec: docs/conventions/issue-naming.md § 1.
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
- [ ] `sfn dev bootstrap build` — compiler self-hosts (required for `.sfn` changes under `compiler/src/` or `compiler/capsules/`; `sfn dev clean build` first for structural changes)
- [ ] `sfn dev verify` — full suite + seedcheck (for shipped features / releases / structural changes)
- [ ] Regression coverage added or updated under `compiler/tests/`
- [ ] N/A — docs/config-only change (no `.sfn` touched)

## Stage1 readiness

<!-- Only for a language/runtime feature. Delete this section otherwise.
"Parsed but not enforced" is NOT shipped — see CLAUDE.md. -->

- [ ] Parses, type-checks, and effect-checks
- [ ] Emits valid `.sfn-asm` and lowers to LLVM IR
- [ ] Effect enforcement wired end-to-end (not annotation-only)
- [ ] The relevant spec §N chapter updated
<!-- Not docs/status.md: it is reconciled on the release cadence by a
maintainer sweep, not by this PR. -->

## Notes for reviewers

<!-- Risk areas, deferred follow-ups, or anything the diff doesn't make
obvious. A follow-up is a new Linear issue only if it clears
.claude/rules/follow-up-filing.md (reproduced defect, Urgent/High, or hard
prerequisite) — then it lands in Backlog, never Triage. Everything else is a
`Noticed in passing` comment on the issue this PR works. No bare TODO. -->
