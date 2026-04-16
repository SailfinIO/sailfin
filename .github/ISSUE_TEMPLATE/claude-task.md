---
name: Claude Task
about: A session-sized work item that Claude (or a human) can complete in one focused session
title: ""
labels: ["claude-ready", "needs-grooming"]
assignees: []
---

<!--
This template defines the contract between issue authors and Claude.
A well-groomed issue is one Claude can complete in a single session and
produce a mergeable PR. If you can't fill in every section concretely,
the issue is too big or too vague — break it down further or remove the
`claude-ready` label until it can be groomed.
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
ulimit -v 8388608 && timeout 60 build/native/sailfin run path/to/example.sfn
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

<!-- List issue numbers that must close before this can start. Empty if unblocked. -->

## Context / Background

<!-- Any background reading: links to roadmap items, relevant code, prior PRs, design discussions. -->

## Notes for Claude

<!-- Anything specific Claude should know: gotchas, prior attempts, things to avoid. -->
