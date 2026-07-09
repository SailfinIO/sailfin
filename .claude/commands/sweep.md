# Sweep Blocker State and Coordinate Next Picks

Post-merge reconciliation over the **Linear** Sailfin (`SFN`) queue. Sweep
newly-resolved blockers, surface completed/next-up epics (Projects), and
recommend the next 1–3 issues to dispatch via `/pickup` based on a concurrency
budget and file-collision analysis.

This is the focused, event-driven sibling of `/triage`. Run it after every PR
merge while coordinating multiple `/pickup` sessions.

> **Linear is the planning source of truth.** Blocker/status writes are
> `mcp__Linear__save_issue`; Projects (epics) roll up their issues' state
> natively, so there is no GitHub tracker/sub-issue bookkeeping here. Resolve
> merged PRs → their Linear issue via the `sfn-<N>` branch / `Fixes SFN-<N>`
> link. Use `mcp__github__*` only to read merged PRs. See
> `docs/conventions/linear-workflow.md`.

## Target: $ARGUMENTS

**Flags:**
- `--greedy` (bare) — raise the concurrency budget from `2` to `4`
- `--greedy=N` — set the budget to `N`
- `--dry-run` — preview status flips and recommendations; make no writes

**Bare numbers** — treat each as a PR number that just merged; the command
resolves PR → linked Linear issue (`SFN-<N>` from branch/body).

Examples: `/sweep` (auto-detect last-24h merges, budget 2) · `/sweep 367`
(anchor on PR #367) · `/sweep --greedy 367 332` · `/sweep --greedy=6 --dry-run`.

---

## Phase 1: GATHER

Resolve the merge anchor set:
- If `$ARGUMENTS` has bare numbers, read each PR with
  `mcp__github__pull_request_read` and extract its Linear issue (`SFN-<N>` from
  the head branch `claude/sfn-<N>-…` or a `Fixes SFN-<N>` in the body).
- Otherwise auto-detect merges in the last 24h:
  ```
  mcp__github__list_pull_requests state="closed" ... (filter merged, mergedAt within 24h)
  ```

The set of Linear issues those PRs closed is the trigger for unblocking
dependents. Confirm each is `Done` in Linear (the integration should have
advanced it on merge; if it lags, note it — don't force a terminal status).

Pull the candidate pools from Linear:

```
mcp__Linear__list_issues team="Sailfin" state="Blocked" limit=100
mcp__Linear__list_issues team="Sailfin" state="Ready"   limit=100
mcp__Linear__list_issues team="Sailfin" state="In Progress" limit=100
```

In-flight set = open PRs on `claude/sfn-*` branches
(`mcp__github__list_pull_requests`, filter head `claude/`) plus the `In Progress`
Linear issues. De-dupe by SFN number.

---

## Phase 2: SWEEP BLOCKERS

> **Shared logic.** The hard-vs-prose blocker rule below is the one mechanic
> `/sweep` and `/triage` share (`/triage` Phase 3 → UNBLOCK). If you change it
> here, mirror it there.

For each `Blocked` issue:

1. Read its blocked-by relations (`get_issue includeRelations=true`) and any
   `## Blocked by` prose in the body.
2. Classify each blocker: **hard** (a Linear relation, or a `SFN-N`/`#N` ref) —
   closed = resolved; **prose** ("Slice E", "M3 runtime deletion") — never
   auto-flip on prose alone.
3. If every hard blocker is closed AND no prose gate remains, flip to `Ready`
   and drop the resolved relations:
   ```
   mcp__Linear__save_issue id="SFN-<N>" state="Ready" removeBlockedBy=["SFN-<resolved>"]
   mcp__Linear__save_comment issueId="SFN-<N>" body="Auto-sweep: blocker(s) resolved — <list>. Marking Ready."
   ```
4. Under `--dry-run`, record the intended flip; make no writes.

---

## Phase 2b: EPIC & RELEASE ROLLUP

Linear rolls up a Project (epic) from its issues natively — there is no GitHub
tracker to reconcile. This phase reads those rollups to surface coordination
signals; it makes **no writes** (identical under `--dry-run`).

1. **Completed epics.** For each Project touched by the anchor merges, read its
   issues (`list_issues project="<P>"`). When every issue is `Done`, recommend
   the Project be marked complete (a human/Project-lead decision — never
   auto-complete a Project). Report under "Epics ready to close."
2. **Next phase to groom.** For a phased epic (per-phase Projects under one
   Initiative), a fully-`Done` phase Project is the trigger to groom the next
   sibling phase Project (the one in `Backlog`/`Planned` with no leaves yet).
   Report under "Next phase to groom → `/groom <Phase Project>`."
3. **Release axis.** If a newly-`Done` issue carries `seed-blocker` or a
   `release:*` label, note it for `/release-plan` (releases are Linear **Cycles**
   — see `docs/conventions/issue-naming.md` § Release tracking; `/release-plan`
   owns Cycle bookkeeping and the seed-cut queue). A plain `seed-blocker` close
   **queues** the seed advance for the next cadence bump — it does not warrant a
   reactive cut unless the item carries `release-critical-seed`.

---

## Phase 3: AUDIT READY HYGIENE (report-only)

For each `Ready` issue, sanity-check without modifying it (hygiene edits are
`/triage`'s job):
- `## Files Affected` is an **advisory map** expected to drift — a missing path
  is a **soft note** ("advisory map may be stale — `/triage` can refresh"), not
  a defect. The semantic `In:`/`Out:` scope is the contract.
- "Appears already shipped" heuristics: if the goal names a symbol to
  delete/remove, grep to confirm it still exists; if it describes adding
  something, grep for evidence it already shipped under another name.

Report findings only; change nothing here.

---

## Phase 4: BUDGET

```
budget     = 4 if --greedy bare | N if --greedy=N | 2 otherwise
in_flight  = count of open claude/sfn-* PRs + In Progress SFN issues (de-duped)
free_slots = max(0, budget - in_flight)
```

Cache the union of files touched across in-flight PRs as `IN_FLIGHT_FILES`
(`mcp__github__pull_request_read` file lists) for collision analysis.

---

## Phase 5: COLLISION ANALYSIS

For each pickable `Ready` issue (exclude assigned / In Progress):

1. Parse `## Files Affected`.
2. **Hard collision** — files intersect `IN_FLIGHT_FILES` → exclude from
   "dispatch now"; surface as "after #X merges".
3. **Peer collision** — files intersect another candidate → "sequence after peer."
4. Score the rest:

   | Signal | Weight |
   |---|---|
   | Linear priority Urgent | +100 |
   | Linear priority High | +50 |
   | Closes an epic (last open issue in its Project) | +30 |
   | Unblocks ≥2 downstream issues | +20 each |
   | estimate 1 (XS) | +10 |
   | estimate 2 (S) | +5 |
   | estimate 3 (M) | 0 |
   | Track diversity (different Project/area than in-flight) | +15 |

5. Pick the top `free_slots` candidates with no hard collision with each other.

---

## Phase 6: REPORT

```
Sweep Report — <date>
Budget: <N>  |  In-flight: <N>  |  Free slots: <N>

Anchor merges:
  ✓ PR #<N> — <title>   (closed SFN-<M>)

Unblocked (flipped to Ready):
  ✓ SFN-<N> — <title>   (blockers resolved: SFN-<X>)

Still blocked:
  ⏸ SFN-<N> — <title>   (waiting on: SFN-<X> open, "Slice E" ambiguous)

Epics ready to close (recommendation):
  ✓ <Project> — all issues Done

Next phase to groom:
  → <Epic> Phase <X> done → /groom <Phase <Y> Project>

Release axis (for /release-plan):
  · SFN-<N> closed carries release:<gate> / seed-blocker

Audit findings (Ready hygiene):
  · SFN-<N> — advisory map may be stale (<path>) — /triage can refresh

Top picks for free slots:
  1. SFN-<N> — <title> (estimate, type) — <rationale>

Suggested sequence:
  Now (parallel):  SFN-<N>  ‖  SFN-<M>
  After SFN-<X>:   SFN-<Y>  (rebases onto <file>)

Concerns / human input needed:
  ? <ambiguous prose blocker>

Dry run: changes <previewed | applied>
```

---

## Constraints

- **Don't dispatch work.** This is a coordination layer; dispatch happens via
  `/pickup` in separate sessions.
- **Don't complete/cancel issues or Projects.** Same convention as `/triage` —
  terminal states are human decisions. Phase 2b only *recommends*.
- **Don't modify issue bodies.** Only status/relations and comments.
- **Be conservative with prose blockers.** Anything not a hard reference stays
  `Blocked` until a human confirms.
- **Comment whenever you flip a status.** Audit trail.
- **Native fields only** — status/priority/estimate/blockers are Linear-native.
- **In `--dry-run`, make zero writes.** Print intended actions only.
- **Read `.github/AGENTS.md` for cap context.** Default budget 2 matches the
  autonomous-pipeline cap; `--greedy` raises it for human-coordinated sessions.

---

## Why this command exists

After every PR merge the next coordination move is mechanical: some `Blocked`
issue's blocker just resolved (flip it); some in-flight files just freed
(recompute collision-safe candidates); some epic just gained a closer (surface
it for the next `/pickup`). `/triage` audits the whole queue (too broad);
`/pickup` claims one issue (too narrow). `/sweep` is the bridge that produces the
to-do list for the next `/pickup` calls.
