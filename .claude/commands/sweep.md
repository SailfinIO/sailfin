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
- `/sweep` — auto-detect closed issues/PRs in the last 24h, default budget = 2
- `/sweep 367` — anchor on PR/issue #367, default budget = 2
- `/sweep --greedy 367 332` — anchor on two merges, budget = 4
- `/sweep --greedy=6 --dry-run` — preview-only, budget = 6, auto-detect merges

If parsing yields no flags and no numbers: budget = 2, auto-detect merges, real (non-dry) run.

---

## Phase 1: GATHER

Resolve the merge anchor set.

If `$ARGUMENTS` includes bare numbers, use them directly:

```bash
for N in <numbers>; do
  gh issue view $N --json number,title,state,closingIssuesReferences,closedAt 2>/dev/null \
    || gh pr view $N --json number,title,state,closingIssuesReferences,mergedAt
done
```

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

gh pr list --label agent-authored --state open \
  --json number,title,headRefName,files --limit 20
```

If `agent-authored` returns zero PRs, also check for any open PR on a `claude/*` branch (the human-driven `/pickup` flow). Those count toward the budget the same way.

---

## Phase 2: SWEEP BLOCKERS

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
   ```
5. If `--dry-run` is set: do not edit or comment. Record the intended flip in the report.

---

## Phase 3: AUDIT CLAUDE-READY

For each issue in the `claude-ready` pool:

1. Parse `## Files Affected` from the body. Extract path-shaped tokens.
2. For each path not marked "New:", verify it exists in the working tree:
   ```bash
   test -f <path> || flag "missing-file"
   ```
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
  ⚠ #<N> — <title>      (missing file: <path>)
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
- **In `--dry-run` mode, make zero writes.** No labels, no comments. Print intended actions only.
- **Read `.github/AGENTS.md` for cap context.** Default budget = 2 matches the autonomous-pipeline cap; `--greedy` raises it for human-coordinated parallel sessions.

---

## Why this command exists

After every PR merge, the next coordination move is mechanical:
1. Some `blocked` issue's `#N` reference just resolved — flip it.
2. Some in-flight files just freed — recompute collision-safe candidates.
3. Some epic just gained a closer — surface that for the next `/pickup`.

`/triage` audits the whole queue and is too broad for this. `/pickup` claims a single issue and is too narrow. `/sweep` is the bridge: invoked after every merge, it produces the to-do list for the next `/pickup` calls in your other sessions.
