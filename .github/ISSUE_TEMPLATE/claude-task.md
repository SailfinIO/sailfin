---
name: Claude Task
about: A session-sized work item that Claude (or a human) can complete in one focused session
title: "<type>(<scope>): <verb phrase>"
labels: ["needs-grooming"]
assignees: []
---

<!--
This template defines the contract between issue authors and Claude.

A well-groomed issue is one Claude can complete in a single session and
produce a mergeable PR. If you can't fill in every section concretely,
the issue is too big or too vague — break it down further.

Title format (see docs/conventions/issue-naming.md):
  - Sub-tasks:  <type>(<scope>): <imperative verb phrase>
                e.g.  feat(typecheck): register extern fn declarations
  - Epics:      Epic: <track-id>: <noun phrase>          + apply `epic` label
  - Trackers:   Tracking: <topic> (<YYYY-MM-DD>)         + apply `tracking` label

Labels come from .github/labels.yml — never invent new ones here. The
template defaults to `needs-grooming`. Once scope, criteria, and files
are filled in, swap it for `claude-ready` (and add `type:*`, `size:*`,
optional `area:*`).
-->

## Goal

<!-- One sentence. What changes after this is merged? -->

## Scope

**In:**
<!--
Name the semantic UNITS of change, not file paths — e.g. "the effect-checker
diagnostic emission for missing ![io]", not "effect_checker.sfn lines X-Y".
The unit, not the path, defines the boundary: a new sibling file inside that
unit (after a split) is in scope by construction. Be specific about behaviour;
never cite line numbers.
-->
-

**Out:**
<!--
What this issue explicitly does NOT touch. Prevents scope creep. A new
acceptance criterion or a new public/user-facing surface is out of scope by
definition — if the work needs one, that is real scope growth, not drift.
-->
-

## Acceptance Criteria

<!-- Specific, verifiable outcomes. Each one must be objectively pass/fail. -->
- [ ]
- [ ] `make compile` passes (compiler self-hosts)
- [ ] `make test` passes (no regressions)

## Files Affected (advisory map — non-binding, expected to drift)

<!--
A NON-EXHAUSTIVE navigation aid: likely-relevant starting points, NOT a
binding checklist. The codebase moves between grooming and pickup (files
split, get renamed, gain siblings), so this map is expected to drift and is
reconciled at pickup — it never gates correctness. The authoritative contract
is the Goal plus the semantic In/Out scope above.

Do NOT write line numbers (`L142`, `~L100-135`) or exact file counts ("these
3 files", "two call sites"): both rot fastest and turn an in-unit sibling into
a phantom scope violation. List paths as starting points only.
-->
- `compiler/src/...` —
- `compiler/tests/...` —

## Verification

<!-- Exact commands a reviewer can run to confirm the change works. -->
```bash
timeout 60 build/native/sailfin run path/to/example.sfn
```

## Size

<!-- Pick one. If L, this issue is too big — break it down. -->
- [ ] **XS** — single file, < 1 hour
- [ ] **S** — few files, 1-3 hours
- [ ] **M** — multi-file, 3-6 hours
- [ ] **L** — > 6 hours (NEEDS BREAKDOWN — remove `claude-ready` label and add `needs-grooming`)

## Type

<!-- Pick one. Sets the workflow Claude should use. -->
- [ ] **Feature** — new language construct (use `/add-feature`)
- [ ] **Bug** — incorrect compiler behavior (use `/debug-compile`)
- [ ] **Performance** — speed/memory improvement (use `/perf`)
- [ ] **Refactor** — structural change with no user-visible behavior change

## Blocked by

<!--
List issue/PR numbers that must close before this can start. Empty if unblocked.

If the dependency is a compiler-source change that this issue must
self-host on (i.e. `make compile` will fail without it baked into
the seed binary), use the "Required in pinned seed" section below
*instead of or in addition to* this one — merging the PR is not enough.
-->

## Required in pinned seed

<!--
List issue/PR numbers whose merged code must be present in the binary
that `.seed-version` points at. Common cases:
  - This issue migrates compiler annotations that depend on a
    syntax/lowering change shipped in a prior PR.
  - This issue uses a new compiler intrinsic / diagnostic / IR shape
    added by a prior PR.

When this is non-empty, the predecessor's source issue MUST also be
labeled `seed-blocker` so `/sweep` ticks the seed-pin checklist when
it closes. `/pickup` refuses to claim this issue until every listed
predecessor is an ancestor of the pinned seed tag (verified via
`git merge-base --is-ancestor <merge-sha> <seed-tag>`).

Empty if the issue does not depend on a fresh seed (most non-compiler
work — docs, tests of already-shipped features, runtime experiments).
-->

## Context / Background

<!-- Any background reading: links to roadmap items, relevant code, prior PRs, design discussions. -->

## Notes for Claude

<!-- Anything specific Claude should know: gotchas, prior attempts, things to avoid. -->
