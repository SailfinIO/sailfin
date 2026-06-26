# Sweep Blocker State and Coordinate Next Picks

Post-merge issue-tracker reconciliation. Sweep newly-resolved blockers, audit `claude-ready` hygiene, and recommend the next 1-3 issues to dispatch via `/pickup` based on a configurable concurrency budget and file-collision analysis.

This is the focused, event-driven sibling of `/triage`. Run it after every PR merge while you're coordinating multiple `/pickup` sessions.

## Target: $ARGUMENTS

Parse `$ARGUMENTS` as a mix of flags and numbers:

**Flags** (tokens starting with `--`):
- `--greedy` (bare) — raise the concurrency budget from `2` to `4`
- `--greedy=N` — set the concurrency budget to `N` (no upper bound)
- `--dry-run` — preview label flips and recommendations; do not modify any issue or post comments

**Bare numbers** — treat each as a PR or issue number that just merged or closed; the command resolves PR → linked issue(s) automatically.

Examples:
- `/sweep` — auto-detect merged PRs in the last 24h (and their linked issues), default budget = 2
- `/sweep 367` — anchor on PR/issue #367, default budget = 2
- `/sweep --greedy 367 332` — anchor on two merges, budget = 4
- `/sweep --greedy=6 --dry-run` — preview-only, budget = 6, auto-detect merges

If parsing yields no flags and no numbers: budget = 2, auto-detect merges, real (non-dry) run.

---

## Phase 1: GATHER

Resolve the merge anchor set.

If `$ARGUMENTS` includes bare numbers, use them directly. Try `gh pr view` first
because `closingIssuesReferences` and `mergedAt` are PR-only fields, and
`gh issue view <N>` resolves PRs as issues (they share a number space) — so
querying `gh issue view` first would silently skip the PR-specific data.

```bash
for N in <numbers>; do
  # PR-first: PRs carry mergedAt + closingIssuesReferences.
  gh pr view $N --json number,title,state,closingIssuesReferences,mergedAt 2>/dev/null \
    || gh issue view $N --json number,title,state,closedAt
done
```

For raw issue anchors (closed manually, no PR), there's no
`closingIssuesReferences` to expand — treat the issue itself as the
closed trigger.

Otherwise, auto-detect merges in the last 24h:

```bash
gh pr list --state merged --limit 20 \
  --json number,title,closingIssuesReferences,mergedAt \
  | jq '[.[] | select(.mergedAt > (now - 86400 | todate))]'
```

For each anchor PR, extract the closed issue numbers from `closingIssuesReferences` — these are the `Closes #N` references. The set of newly-closed issues is the trigger for unblocking dependents.

Pull the candidate pools:

```bash
gh issue list --label blocked --state open \
  --json number,title,labels,body,assignees --limit 100

gh issue list --label claude-ready --state open \
  --json number,title,labels,body,assignees --limit 100

# gh pr list does not support --json files; just list PRs here. Phase 4
# fetches file lists per PR via gh pr view.
gh pr list --label agent-authored --state open \
  --json number,title,headRefName --limit 20
```

Always include open PRs on a `claude/*` branch (the human-driven `/pickup` flow) in the in-flight set — they count toward the budget the same way as `agent-authored` PRs, and both categories can be live simultaneously:

```bash
gh pr list --state open \
  --json number,title,headRefName \
  --jq '[.[] | select(.headRefName | startswith("claude/"))]'
```

The in-flight set is the union of the two queries (de-duped by PR number).

---

## Phase 2: SWEEP BLOCKERS

> **Shared logic.** The hard-vs-prose blocker-clearing rule below is the one
> mechanic `/sweep` and `/triage` have in common (`/triage` Phase 3 → UNBLOCK).
> They are otherwise distinct — `/sweep` is the post-merge coordinator (budget,
> collisions, dispatch); `/triage` is the whole-queue hygiene auditor
> (promote/demote, Type fixes, orphan release). Do not merge them. If you change
> this rule, mirror it in `/triage`.

For each issue in the `blocked` pool:

1. Parse the `## Blocked by` section of the body. Extract every `#N` reference via regex (`#\d+`).
2. For each `#N`, check its state: `gh issue view N --json state,stateReason` (works for both issues and PRs).
3. Classify each blocker:
   - **Hard reference (#N)** — closed = resolved; open = still blocking
   - **Prose reference** (e.g., "Slice E", "M3 — runtime/native/ deletion") — always ambiguous; never auto-flip on prose alone
4. If all hard references are closed AND no prose references remain unresolved:
   ```bash
   gh issue edit <N> --remove-label blocked --add-label claude-ready
   gh issue comment <N> --body "Auto-sweep: blocker(s) resolved — <list resolved #N references>. Marking ready for pickup."

   # Move the card on the Sailfin Tracker (Project #4) out of the
   # Blocked column. The helper derives the new column from the
   # post-edit labels — here that resolves to "Ready".
   .claude/scripts/sync-project-status.sh <N> --from-labels
   ```
5. If `--dry-run` is set: do not edit, comment, or sync. Record the intended
   flip (label change AND target column) in the report.

---

## Phase 2b: SYNC RELEASE TRACKING ISSUES

If any of the issues newly closed by the anchor merges carries a
`release:*` or `seed-blocker` label, the corresponding `Release: vX.Y.Z`
tracking issue needs its rollup reconciled. The tracker uses
**GitHub-native sub-issues** as the source of truth (SFEP-0026 WS-C;
`/release-plan` attaches them) — so this sync reconciles **native
sub-issue state**, not a string-matched markdown checklist. This is a
passive sync — `/release-plan` is the active equivalent for cycle
bookkeeping.

For each newly-closed issue:

1. Get its labels:
   ```bash
   gh issue view <N> --json labels --jq '.labels[].name' \
     | grep -E '^(release:|seed-blocker$)'
   ```
2. For each `release:<gate>` label found, locate the tracking issue:
   ```
   mcp__github__search_issues query='repo:SailfinIO/sailfin is:issue in:title "Release: v" label:tracking'
   ```
   Map `release:<gate>` to the matching tracking issue title — typically
   the one whose target version corresponds to the gate. If multiple
   match (e.g. an item gates both `release:beta` and `release:1.0`),
   reconcile each.
3. **Reconcile native sub-issue state** rather than hand-ticking markdown:
   ```bash
   TRACKER=<tracking-issue-number>
   # Is the just-closed issue attached as a native sub-issue?
   gh api /repos/SailfinIO/sailfin/issues/$TRACKER/sub_issues --paginate \
     --jq '.[].number' | grep -qx <N> && echo attached || echo missing
   ```
   - **Attached** → its closed state shows in the GitHub "Sub-issues"
     rollup automatically; no body edit needed. If `/release-plan` renders
     a summary section, re-render the matching `☐`→`☑` line from the
     native state (don't store closed-ness in the body).
   - **Missing (closed item carries a gating/`seed-blocker` label but is
     not a sub-issue)** → attach it so the rollup is complete, mirroring
     `/release-plan` (typed `-F sub_issue_id`):
     ```bash
     child_id=$(gh api repos/SailfinIO/sailfin/issues/<N> --jq '.id')
     gh api -X POST /repos/SailfinIO/sailfin/issues/$TRACKER/sub_issues \
       -F sub_issue_id=$child_id --jq '.number'
     ```
4. For `seed-blocker`, keep the auto-tick behaviour: ensure the closed
   item is reflected in the tracker's `## Seed blockers` / `## Seed bump
   (this cadence)` rollup, and surface in the report so the user knows the
   **cadence `/pin-seed`** will pick it up (a plain `seed-blocker` /
   `needs-seed-cut` close queues for the next cadence bump — it does **not**
   warrant a reactive cut unless the item carries `release-critical-seed`;
   SFEP-0026 §3.3).
5. Post a one-line comment:
   ```
   Auto-sweep: #<N> closed via PR #<M> — sub-issue rollup reconciled (release:<gate>, seed-blocker).
   ```
6. If the closed issue is neither attached nor labeled on any tracker,
   mention it in the report under "Concerns" (likely means it was labeled
   after the tracking issue was created without `/release-plan` re-running).

If no newly-closed issue carries either label, skip this phase
entirely. **In `--dry-run`, make zero writes** (no sub-issue attachments,
no body edits, no comments).

---

## Phase 3: AUDIT CLAUDE-READY

For each issue in the `claude-ready` pool:

1. Parse `## Files Affected` from the body. Extract path-shaped tokens.
2. For each path not marked "New:", verify it exists in the working tree:
   ```bash
   test -f <path> || note "stale-map"   # soft note, NOT a defect flag
   ```
   `## Files Affected` is an **advisory map** (`docs/conventions/issue-naming.md`,
   "Intent-authoritative issues") that is *expected to drift* — a missing path is
   not an issue defect. Surface it as a **soft, non-blocking note** ("advisory map
   may be stale — `/triage` can refresh") and do **not** imply the issue is broken.
   The semantic `In:`/`Out:` scope is the contract; a stale map on a
   semantically-scoped issue is expected entropy, not rot.
3. Sanity-check for "appears already shipped" signals (heuristic only):
   - If the issue's goal mentions a symbol/function to delete or remove, `grep` to confirm it still exists.
   - If the issue describes adding a file/feature, `grep` for evidence the work shipped under a different name.
4. Never modify labels or body in this phase — `claude-ready` hygiene is `/triage`'s job. Only report findings here.

---

## Phase 4: BUDGET

Compute concurrency:

```
budget     = 4 if --greedy bare
           = N if --greedy=N
           = 2 otherwise

in_flight  = count of open agent-authored PRs + open claude/* branch PRs
free_slots = max(0, budget - in_flight)
```

Cache the union of files touched across all in-flight PRs as `IN_FLIGHT_FILES` for collision analysis:

```bash
gh pr view <N> --json files | jq -r '.files[].path'
```

---

## Phase 5: COLLISION ANALYSIS

For each pickable `claude-ready` issue (exclude any with `in-progress` or assignees):

1. Parse `## Files Affected` from the body.
2. **Hard collision** — issue's files intersect `IN_FLIGHT_FILES`. Exclude from "dispatch now" recommendations; surface as "after #X merges".
3. **Peer collision** — issue's files intersect another candidate's files. Note as "sequence after peer" rather than parallel.
4. Score the remaining candidates:

   | Signal | Weight |
   |---|---|
   | `priority:critical` label | +100 |
   | `priority:high` label | +50 |
   | Closes an epic on merge | +30 |
   | Unblocks ≥2 downstream issues | +20 per |
   | `size:xs` | +10 |
   | `size:s` | +5 |
   | `size:m` | 0 |
   | Track diversity (different epic/area than already in-flight) | +15 |

5. Pick the top `free_slots` candidates that have no hard collision with each other.

---

## Phase 6: REPORT

Produce a concise report:

```
Sweep Report — <date>
Budget: <N>  |  In-flight: <N>  |  Free slots: <N>

Anchor merges:
  ✓ PR #<N> — <title>   (closed #<M>, #<K>)
  ✓ PR #<N> — <title>   (closed #<M>)

Unblocked (label flipped):
  ✓ #<N> — <title>      (blockers resolved: #<X>, #<Y>)

Still blocked:
  ⏸ #<N> — <title>      (waiting on: #<X> open, "Slice E" ambiguous)

Audit findings (claude-ready hygiene):
  · #<N> — <title>      (advisory map may be stale: <path> — /triage can refresh)
  ⚠ #<N> — <title>      (symbol "<name>" appears removed — verify scope)

Top picks for free slots:
  1. #<N> — <title> (size, type) — <one-line rationale>
  2. #<N> — <title> (size, type) — <one-line rationale>

Suggested sequence:
  Now (parallel):  #<N>  ‖  #<M>
  After #<X>:      #<Y>  (rebases onto <file>)
  After all:       #<Z>  (closes epic #<E>)

Concerns / human input needed:
  ? <ambiguous prose blocker>
  ? <conflicting signal>

Dry run: changes <previewed | applied>
```

---

## Constraints

- **Don't dispatch work.** This command is a coordination layer. Dispatch happens via `/pickup` in separate sessions.
- **Don't close issues.** Same convention as `/triage`. Closing is a human decision.
- **Don't modify issue bodies.** Only labels and comments.
- **Be conservative with prose blockers.** Anything not a hard `#N` reference stays blocked until a human confirms.
- **Always leave a comment when flipping a label.** Future-you needs the audit trail.
- **Every label flip must be paired with a board sync** via
  `.claude/scripts/sync-project-status.sh <N> --from-labels`. Surface any
  non-zero exit under "Concerns" so a human can reconcile the column.
- **In `--dry-run` mode, make zero writes.** No labels, no comments, no
  board syncs. Print intended actions only.
- **Read `.github/AGENTS.md` for cap context.** Default budget = 2 matches the autonomous-pipeline cap; `--greedy` raises it for human-coordinated parallel sessions.

---

## Why this command exists

After every PR merge, the next coordination move is mechanical:
1. Some `blocked` issue's `#N` reference just resolved — flip it.
2. Some in-flight files just freed — recompute collision-safe candidates.
3. Some epic just gained a closer — surface that for the next `/pickup`.

`/triage` audits the whole queue and is too broad for this. `/pickup` claims a single issue and is too narrow. `/sweep` is the bridge: invoked after every merge, it produces the to-do list for the next `/pickup` calls in your other sessions.
