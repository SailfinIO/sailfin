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
- [ ] Has the GitHub native **Type** field set (Feature / Task / Bug) — check via
  `gh api graphql -f query='query{repository(owner:"SailfinIO",name:"sailfin"){issue(number:<N>){issueType{name}}}}'`

### State checks
- Is it `claude-ready` but actually stale (no update in 30+ days)?
- Is it `in-progress` but the assignee branch is gone or PR closed?
- Is it `blocked` but the blocking issue is closed?
- Is it `needs-grooming` but has been sitting for 14+ days?

---

## Phase 3: APPLY ACTIONS

Every label flip in this phase MUST be followed by a board sync so the card
moves to the matching column on the Sailfin Tracker (Project #4). Use:

```bash
.claude/scripts/sync-project-status.sh <N> --from-labels
```

The helper derives the column from the post-edit labels with strict
precedence: `in-progress` > `blocked` > `needs-grooming` > `claude-ready`.

For each issue with hygiene failures:

```bash
# Strip claude-ready, add needs-grooming, comment with what's missing
gh issue edit <N> --remove-label "claude-ready" --add-label "needs-grooming"
gh issue comment <N> --body "Auto-triage: missing the following sections required for /pickup eligibility:
- <list of failed checks>

Run \`/groom\` to flesh this out, or close if no longer relevant."

# Move the card to "To triage" so the board reflects the new state
.claude/scripts/sync-project-status.sh <N> --from-labels
```

For state issues:

```bash
# Blocker resolved — clear the blocked label
gh issue edit <N> --remove-label "blocked" --add-label "claude-ready"
gh issue comment <N> --body "Auto-triage: blocking issue #<M> is closed. Marking ready for pickup."
.claude/scripts/sync-project-status.sh <N> --from-labels   # → Ready

# Stale claude-ready — flag for review (no label change, no board move)
gh issue comment <N> --body "Auto-triage: this issue has been claude-ready for 30+ days without pickup. Likely stale — review priority or close."

# Orphaned in-progress — release back to the queue
gh issue edit <N> --remove-label "in-progress" --add-label "claude-ready"
gh issue comment <N> --body "Auto-triage: in-progress label was set but no active branch found. Releasing back to queue."
.claude/scripts/sync-project-status.sh <N> --from-labels   # → Ready
```

For `L` sized issues that snuck through (no `size:l` label exists in the
canonical scheme — anything that would be L gets `epic` instead):

```bash
gh issue edit <N> --remove-label "claude-ready" --add-label "needs-grooming,epic"
gh issue comment <N> --body "Auto-triage: this issue is L-sized; the canonical scheme has no \`size:l\`. Marking as \`epic\` + \`needs-grooming\`. Run \`/groom #<N>\` to decompose into XS/S/M children."
.claude/scripts/sync-project-status.sh <N> --from-labels   # → To triage
```

For issues whose GitHub native **Type** field is `null`:

```bash
# Derive from type:* label; set silently (no board sync needed — Type is not a label)
# type:feature → Feature, type:bug → Bug, everything else → Task
.claude/scripts/set-issue-type.sh <N> <Feature|Task|Bug>
```

This is a **silent fix** — no label edit, no comment, no board sync required.
Apply it to all issues with a null type regardless of other state.

If a sync call exits non-zero, capture the issue number and surface it under
"Concerns" in the Phase 4 report — the label flip stands but the board is
out of sync and a human should reconcile it.

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
- **Every label flip must be paired with a board sync.** Run
  `.claude/scripts/sync-project-status.sh <N> --from-labels` after every
  `gh issue edit` so Project #4 (Sailfin Tracker) keeps tracking the labels.
- **Always fix a null GitHub Type field** — run
  `.claude/scripts/set-issue-type.sh <N> <Feature|Task|Bug>` for any issue
  whose `issueType` is null. No board sync or comment needed for this fix.
