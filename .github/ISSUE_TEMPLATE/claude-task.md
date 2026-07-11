---
name: Claude Task
about: A session-sized work item that Claude (or a human) can complete in one focused session
title: "<type>(<scope>): <verb phrase>"
labels: ["needs-grooming"]
assignees: []
---

<!--
This template is contributor intake, not an implementation-ready ticket. A
GitHub issue filed from this template mirrors into the Linear SFN team's
Triage, where maintainers classify it, groom scope, and set workflow status.
Fill in what you can concretely, but do NOT set workflow state yourself —
that's the maintainer's job once it lands in Linear. Maintainer- or
agent-created implementation work is authored natively as a Linear `SFN-NNN`
issue and does not need a GitHub mirror at all.

A well-groomed issue is one that can be completed in a single focused session
and produce a mergeable PR. If you can't fill in every section concretely,
the issue is too big or too vague — break it down further.

Title format (see docs/conventions/issue-naming.md):
  - Sub-tasks:  <type>(<scope>): <imperative verb phrase>
                e.g.  feat(typecheck): register extern fn declarations

GitHub issues are session-sized leaf work only. Epics and trackers are NOT
GitHub issues — an epic is a Linear Project, a tracker is a Project/Initiative
(see docs/conventions/linear-workflow.md). The `Release: vX.Y.Z` cadence
tracker is the sole surviving GitHub tracking title.

Labels come from .github/labels.yml — never invent new ones here. The
template defaults to `needs-grooming`, a public triage hint that a maintainer
clears once the issue is groomed in Linear (add `type:*`, `size:*`, optional
`area:*` there).

Priority and estimate are Linear-native fields, not GitHub labels. Record
the intended priority in the `## Priority` section below; the groomer sets
the Linear priority from it and the Linear estimate from the `## Size` /
`size:*` value.
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
timeout 60 build/bin/sfn run path/to/example.sfn
```

## Size

<!-- Pick one. If L, this issue is too big — break it down. Drives the Linear estimate: XS→1, S→2, M→3. -->
- [ ] **XS** — single file, < 1 hour
- [ ] **S** — few files, 1-3 hours
- [ ] **M** — multi-file, 3-6 hours
- [ ] **L** — > 6 hours (NEEDS BREAKDOWN — too big to take on as-is; a maintainer will break it down and set status in Linear)

## Priority

<!--
Pick one. This sets the Linear-native priority field (not a GitHub label) —
the groomer carries it onto the Linear mirror (Urgent/High/Medium/Low → 1/2/3/4).
Default to the parent epic/Project's priority unless this leaf is a genuine
outlier. Judge by the 1.0 critical path: pillars & GA blockers rank higher,
product/post-1.0 polish lower.
-->
- [ ] **Urgent** — actively blocking; drop-everything
- [ ] **High** — a pillar / 1.0 critical-path item
- [ ] **Medium** — enabling infra; lands this milestone
- [ ] **Low** — nice to have; post-1.0 or product polish

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
that `bootstrap.toml [seed].version` points at. Common cases:
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
