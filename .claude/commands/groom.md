# Groom a Roadmap Epic into Issues

Take a high-level roadmap item and decompose it into session-sized GitHub issues that Claude can pick up and complete autonomously.

## Target: $ARGUMENTS

The argument can be:
- A roadmap section name (e.g., "syntax reform", "compiler stabilization")
- A specific bullet from the [roadmap](https://sailfin.dev/roadmap) (e.g., "Implement await expression parsing")
- A document to mine for work items (e.g., `docs/build-performance.md`)
- A free-form description of work that needs breaking down

---

## Phase 1: UNDERSTAND THE EPIC

Read the relevant context:
- `site/src/pages/roadmap.astro` — find the epic and its surrounding priorities (published at [sailfin.dev/roadmap](https://sailfin.dev/roadmap))
- `docs/status.md` — current state of the affected feature(s)
- `docs/spec.md` — what the language commits to
- Any document referenced in the argument

Identify:
- What outcome this epic produces when fully done
- What's already partially in place
- What dependencies exist (must other epics complete first?)

---

## Phase 2: DECOMPOSE

Spawn the **compiler-architect** agent (Opus). Give it:
- The epic and its context
- The current compiler state (relevant files)
- The constraint: each output issue must be **session-sized** (XS/S/M, never L)

The architect produces an ordered list of issues. Each issue must:
- Have a clear, verifiable goal achievable in one session
- Touch a bounded set of files
- Be self-contained (or have explicit `Blocked by` dependencies on earlier issues)
- Include concrete acceptance criteria
- Map to one of: Feature, Bug, Performance, Refactor

If the architect produces any L-sized item, push back: "this needs further breakdown."

---

## Phase 3: REVIEW WITH USER

Present the proposed issue list as a table:

| # | Title | Type | Size | Blocked by |
|---|---|---|---|---|
| 1 | ... | Performance | S | — |
| 2 | ... | Refactor | M | #1 |

Wait for user approval. The user may:
- Approve as-is → proceed to Phase 4
- Request changes (drop, merge, split, reorder) → iterate with the architect
- Reject the breakdown entirely → ask what's wrong

---

## Phase 4: CREATE ISSUES

For each approved issue, create it via `gh`:

```bash
gh issue create \
  --title "<title>" \
  --label "claude-ready,type:<type>,size:<size>" \
  --body "$(cat <<'EOF'
## Goal
<one sentence>

## Scope
**In:**
- ...

**Out:**
- ...

## Acceptance Criteria
- [ ] ...
- [ ] make compile passes
- [ ] make test passes

## Files Affected
- compiler/src/... — ...

## Verification
\`\`\`bash
ulimit -v 8388608 && timeout 60 build/native/sailfin run path/to/example.sfn
\`\`\`

## Size
<XS|S|M>

## Type
<Feature|Bug|Performance|Refactor>

## Blocked by
<#N or "None">

## Context
<links to roadmap, code, prior PRs>
EOF
)"
```

Capture the issue numbers. After all are created, set up dependencies:

```bash
# For each issue blocked by an earlier one:
gh issue edit <N> --add-label "blocked"
# (and reference the blocker in the body — the gh CLI doesn't have native dependency support)
```

---

## Phase 5: REPORT

Report to the user:
- Issue numbers created (with titles)
- The dependency graph (what blocks what)
- The recommended pickup order
- Any context the architect flagged that doesn't fit in an issue

Suggest: `/pickup` to start working the queue, or `/triage` to verify hygiene.

---

## Constraints

- **Never create L-sized issues.** If the architect can't break work into XS/S/M, the work is not yet ready.
- **Never create issues without acceptance criteria.** The criteria are the contract.
- **Always set the `claude-ready` label** on issues that are ready to pick up. Use `needs-grooming` for issues that exist as placeholders but need refinement.
- **Always set the `type:*` and `size:*` labels** so `/pickup` can filter correctly.
- **Don't create issues for work that's already in progress** — check `gh issue list` first to avoid duplicates.
