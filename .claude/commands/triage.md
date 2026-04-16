# Triage the Issue Queue

Audit open issues for hygiene. Flag issues that aren't ready for `/pickup`. Surface stale, blocked, and orphaned work.

## Target: $ARGUMENTS

Optional filter — pass a label (e.g., `type:perf`) to triage a subset, or leave empty to triage everything.

---

## Phase 1: GATHER

Pull all open issues:

```bash
gh issue list \
  --state open \
  --json number,title,labels,assignees,body,createdAt,updatedAt \
  --limit 200
```

Apply the optional label filter from `$ARGUMENTS` if provided.

---

## Phase 2: AUDIT

For each issue, check:

### Hygiene checks (must all pass for `claude-ready`)
- [ ] Has a `## Goal` section with a single sentence
- [ ] Has `## Scope` with both `In:` and `Out:` populated
- [ ] Has `## Acceptance Criteria` with at least one specific, verifiable item
- [ ] Has `## Files Affected` listing the files (not "TBD" or empty)
- [ ] Has `## Verification` with a runnable command
- [ ] Has a `size:*` label (XS/S/M — never L)
- [ ] Has a `type:*` label (feature/bug/perf/refactor)

### State checks
- Is it `claude-ready` but actually stale (no update in 30+ days)?
- Is it `in-progress` but the assignee branch is gone or PR closed?
- Is it `blocked` but the blocking issue is closed?
- Is it `needs-grooming` but has been sitting for 14+ days?

---

## Phase 3: APPLY ACTIONS

For each issue with hygiene failures:

```bash
# Strip claude-ready, add needs-grooming, comment with what's missing
gh issue edit <N> --remove-label "claude-ready" --add-label "needs-grooming"
gh issue comment <N> --body "Auto-triage: missing the following sections required for /pickup eligibility:
- <list of failed checks>

Run \`/groom\` to flesh this out, or close if no longer relevant."
```

For state issues:

```bash
# Blocker resolved — clear the blocked label
gh issue edit <N> --remove-label "blocked" --add-label "claude-ready"
gh issue comment <N> --body "Auto-triage: blocking issue #<M> is closed. Marking ready for pickup."

# Stale claude-ready — flag for review
gh issue comment <N> --body "Auto-triage: this issue has been claude-ready for 30+ days without pickup. Likely stale — review priority or close."

# Orphaned in-progress — release back to the queue
gh issue edit <N> --remove-label "in-progress" --add-label "claude-ready"
gh issue comment <N> --body "Auto-triage: in-progress label was set but no active branch found. Releasing back to queue."
```

For `L` sized issues that snuck through:

```bash
gh issue edit <N> --remove-label "claude-ready,size:L" --add-label "needs-grooming,epic"
gh issue comment <N> --body "Auto-triage: L-sized issues must be broken down. Run \`/groom #<N>\` to decompose into XS/S/M issues."
```

---

## Phase 4: REPORT

Produce a summary report:

```
Triage Report (<date>)

Audited: <total> open issues

Status breakdown:
  claude-ready (pickable):  <N>
  claude-ready (stale):     <N>
  in-progress (active):     <N>
  in-progress (orphaned):   <N>
  needs-grooming:           <N>
  blocked (real):           <N>
  blocked (cleared):        <N>

Actions taken:
  - Stripped claude-ready from <N> issues missing required sections
  - Released <N> orphaned in-progress issues back to queue
  - Unblocked <N> issues whose blockers closed
  - Flagged <N> stale claude-ready issues for human review
  - Flagged <N> L-sized issues for breakdown

Top picks for /pickup right now:
  1. #<N> — <title> (type, size)
  2. #<N> — <title> (type, size)
  3. #<N> — <title> (type, size)

Concerns:
  - <anything that needs human attention>
```

---

## Constraints

- **Don't close issues automatically.** Closing is a human decision.
- **Don't modify issue bodies.** Only labels and comments.
- **Be conservative on staleness.** 30 days is the floor — never mark something stale at <30 days.
- **If you change a label, leave a comment explaining why.** Future-you needs to understand the audit trail.
