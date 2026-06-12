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
<!-- Bullet list of exactly what this issue changes. Be specific. -->
-

**Out:**
<!-- Bullet list of what this issue explicitly does NOT touch. Prevents scope creep. -->
-

## Acceptance Criteria

<!-- Specific, verifiable outcomes. Each one must be objectively pass/fail. -->
- [ ]
- [ ] `make compile` passes (compiler self-hosts)
- [ ] `make test` passes (no regressions)

## Files Affected

<!-- Every file the implementation will touch, with a short note on what changes. -->
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
