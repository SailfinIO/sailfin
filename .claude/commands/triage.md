# Triage the Issue Queue

Audit open issues for hygiene **in both directions**: demote incomplete
`claude-ready` issues, and **promote already-groomed `needs-grooming` issues
that nobody ever moved**. Surface stale, blocked, and orphaned work.

## Target: $ARGUMENTS

Optional filter — pass a label (e.g., `type:perf`) to triage a subset, or leave empty to triage everything.

## Relationship to `/sweep`

`/triage` is the **periodic, whole-queue hygiene auditor**. `/sweep` is the
**event-driven, post-merge coordinator** (concurrency budget, file-collision
analysis, dispatch sequencing, release-tracking sync). They are not
interchangeable — run `/triage` to keep the queue honest, run `/sweep` after a
merge to pick the next work.

The one mechanic they share is **clearing a blocker whose blocking issue
closed**. Both use the identical hard-vs-prose rule (Phase 3 → UNBLOCK below).
Keep that logic in sync: if you change blocker-clearing here, mirror it in
`/sweep` Phase 2, and vice-versa.

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

## The hygiene matcher (shared definition)

Both demotion and promotion depend on deciding whether a body is
**complete**. The matcher MUST be tolerant of real-world markdown variants —
a brittle literal match is what let fully-groomed issues rot in the backlog.

An issue body is **complete** when all of these are present (match
case-insensitively, accept any of the listed forms):

| Section | Accept any of |
|---|---|
| Goal | `## Goal` |
| Scope | `## Scope` |
| Scope → In | `In:` · `### In` · `**In:**` · `**In**` (anywhere under Scope) |
| Scope → Out | `Out:` · `### Out` · `**Out:**` · `**Out**` |
| Acceptance | `## Acceptance` (e.g. "Acceptance Criteria") with ≥1 `- [ ]` item |
| Files | `## Files` (e.g. "Files Affected"), not "TBD"/empty |
| Verification | `## Verification` with a runnable command |

**Size** is satisfied by EITHER a `size:{xs,s,m}` label OR a `## Size` body
section declaring XS/S/M. If the body declares a size but the label is
missing, that is a **backfill**, not a failure (see PROMOTE).

**Type** is satisfied by a `type:*` label. (The GitHub native Type field is a
separate, always-applied fix — see TYPE-FIX.)

---

## Phase 2: AUDIT

Classify every issue into exactly one action bucket. Apply the matcher above.

### Promotion candidates (the column-unsticking pass)
An issue is a **PROMOTE** candidate when ALL hold:
- It is `needs-grooming` (or carries no lifecycle label at all), and is **not** an `epic`.
- Its body is **complete** per the matcher (size may be body-only).
- It has **no open blocker** (apply the UNBLOCK hard-vs-prose rule to its `## Blocked by`).
- It has **no unresolved in-body decision or precondition** (see guards below).

**Promotion guards — do NOT promote if any apply** (these are the traps that
keep an issue genuinely un-pickable even with a complete-looking body):
- **Open design choice in body:** phrases like "pick during grooming",
  "one of (a)/(b)", "decide during grooming", "TBD by grooming", a Scope that
  lists mutually-exclusive options to choose between. → leave `needs-grooming`, flag.
- **Unmet precondition:** phrases like "once a seed past #N is pinned",
  "after #M closes/lands", "blocked on <prose>". Resolve the referenced
  issue/PR: if it is **closed/merged**, the precondition is met (promote, and
  say so in the comment). If still **open**, leave `needs-grooming` and flag.
- **Deferred-by-design:** "not picked up until …", "deliberately deferred".
  Verify the gating issue closed before promoting; otherwise leave + flag.

### Demotion candidates
An issue is a **DEMOTE** candidate when it is `claude-ready` but its body is
**incomplete** per the matcher, or it lacks a `type:*` label, or it is missing
a size entirely (no label AND no `## Size`).

### State buckets
- **UNBLOCK** — `blocked` and every hard `#N` ref in `## Blocked by` is closed (see rule below).
- **RELEASE** — `in-progress` but no active branch / its PR closed unmerged.
- **STALE** — `claude-ready` with no update in 30+ days (flag only).
- **OVERSIZED** — slipped through as L (no `size:l` exists; → `epic`).
- **TYPE-FIX** — GitHub native Type field is `null` (always fix, silently).
- **STALE-GROOM** — `needs-grooming` 14+ days that is NOT a promote candidate
  (still incomplete) → flag for `/groom` or closure review (no label change).
- **MAP-REFRESH** — `claude-ready` (or just-promoted) issue whose Goal + semantic
  `In:`/`Out:` scope are intact but whose `## Files Affected` **advisory map** has
  missing/renamed paths → re-derive and rewrite the advisory map (still
  non-binding; no line numbers/counts), and note the refresh. A stale map is
  expected entropy on a semantically-scoped issue — never a DEMOTE trigger.

---

## Phase 3: APPLY ACTIONS

Every label flip MUST be followed by a board sync so the card moves to the
matching column on the Sailfin Tracker (Project #4):

```bash
.claude/scripts/sync-project-status.sh <N> --from-labels
```

The helper derives the column from post-edit labels with strict precedence:
`in-progress` > `blocked` > `needs-grooming` > `claude-ready`.

### PROMOTE — move a groomed issue to Ready

```bash
# If no size:* label exists, backfill it from the body's "## Size" block by
# appending another --add-label flag (XS→size:xs, S→size:s, M→size:m), e.g.
#   gh issue edit <N> --remove-label "needs-grooming" --add-label "claude-ready" --add-label "size:s"
gh issue edit <N> --remove-label "needs-grooming" --add-label "claude-ready"
gh issue comment <N> --body "Auto-triage promotion: body passes the full hygiene bar (Goal/Scope-In-Out/Acceptance/Files/Verification) with no open blocker or unresolved decision. <If size backfilled: 'Size declared as <X> in the body; applied the size:<x> label.'> <If a precondition was checked: 'Precondition met — #<M> is closed.'> Moving to claude-ready/Ready."
.claude/scripts/sync-project-status.sh <N> --from-labels   # → Ready
```

### DEMOTE — strip claude-ready from an incomplete issue

```bash
gh issue edit <N> --remove-label "claude-ready" --add-label "needs-grooming"
gh issue comment <N> --body "Auto-triage: missing the following sections required for /pickup eligibility:
- <list of failed checks>

Run \`/groom\` to flesh this out, or close if no longer relevant."
.claude/scripts/sync-project-status.sh <N> --from-labels   # → To triage
```

### UNBLOCK — clear a resolved blocker (hard-vs-prose rule, shared with `/sweep`)

Parse `## Blocked by`. Classify each reference:
- **Hard reference (`#N`)** — closed/merged = resolved; open = still blocking.
- **Prose reference** (e.g. "Slice E", "the M4 runtime port", "a fresh seed
  cut") — an agent cannot determine when prose is satisfied, so its mere
  **presence** blocks the auto-flip. Only a human can clear a prose gate.

Flip **only** when (a) every hard `#N` ref is closed AND (b) the `## Blocked by`
section contains **no prose gate at all**. If any prose gate is present, leave
the `blocked` label and surface the issue under "Held back" for human review —
never auto-flip.

```bash
gh issue edit <N> --remove-label "blocked" --add-label "claude-ready"
gh issue comment <N> --body "Auto-triage: all hard blocker references closed (<list resolved #N>) and no prose gate present in '## Blocked by'. Marking ready for pickup."
.claude/scripts/sync-project-status.sh <N> --from-labels   # → Ready
```

If a blocker is `needs-grooming`-incomplete after unblocking, fold it through
the PROMOTE guard rather than landing it in Ready half-baked.

### RELEASE — orphaned in-progress back to the queue

```bash
gh issue edit <N> --remove-label "in-progress" --add-label "claude-ready"
gh issue comment <N> --body "Auto-triage: in-progress label was set but no active branch/PR found. Releasing back to queue."
.claude/scripts/sync-project-status.sh <N> --from-labels   # → Ready
```

### STALE — flag only (no label change, no board move)

```bash
gh issue comment <N> --body "Auto-triage: claude-ready for 30+ days without pickup. Likely stale — review priority or close."
```

### OVERSIZED — L-sized → epic

```bash
gh issue edit <N> --remove-label "claude-ready" --add-label "needs-grooming" --add-label "epic"
gh issue comment <N> --body "Auto-triage: this issue is L-sized; the canonical scheme has no \`size:l\`. Marking \`epic\` + \`needs-grooming\`. Run \`/groom #<N>\` to decompose into XS/S/M children."
.claude/scripts/sync-project-status.sh <N> --from-labels   # → To triage
```

### TYPE-FIX — null GitHub native Type field (silent, always)

```bash
# type:feature → Feature, type:bug → Bug, everything else → Task
.claude/scripts/set-issue-type.sh <N> <Feature|Task|Bug>
```

Apply to all issues with a null type regardless of other state. No label edit,
no comment, no board sync.

### MAP-REFRESH — rewrite a stale advisory map (the one allowed body edit)

When an issue's Goal + semantic `In:`/`Out:` scope are intact but its
`## Files Affected` **advisory map** lists missing/renamed paths, re-derive the
current surface for each `In:` unit (grep/glob the named symbols/units) and
**rewrite the advisory map** to the current paths. Keep it non-binding and
**free of line numbers and exact counts**; do not touch Goal, Scope, Acceptance,
or Verification. Leave a comment recording the refresh:

```bash
# Edit ONLY the `## Files Affected (advisory map …)` block of the body.
gh issue edit <N> --body "<updated body with the refreshed advisory map>"
gh issue comment <N> --body "Auto-triage map refresh: re-derived the advisory \`## Files Affected\` map from the current tree (\`old/path\` → \`new/path\`; added in-unit sibling \`x\`). Map only — Goal and semantic In/Out scope unchanged. The map is non-binding; \`/pickup\` reconciles any remaining drift."
```

This is the **sole** exception to "don't modify issue bodies" — it edits only
the advisory map, never the contract. A stale map is never a DEMOTE trigger.

If a sync call exits non-zero, capture the issue number under "Concerns" in the
report — the label flip stands but the board is out of sync.

---

## Phase 4: REPORT

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
  - Promoted <N> groomed issues to Ready (backfilled <N> size labels)
  - Stripped claude-ready from <N> incomplete issues
  - Released <N> orphaned in-progress issues back to queue
  - Unblocked <N> issues whose blockers closed
  - Refreshed <N> stale advisory maps (Goal/scope intact)
  - Flagged <N> stale claude-ready issues for human review
  - Flagged <N> L-sized issues for breakdown

Top picks for /pickup right now:
  1. #<N> — <title> (type, size)
  2. #<N> — <title> (type, size)
  3. #<N> — <title> (type, size)

Held back (complete body, but not pickable):
  ? #<N> — open design choice ((a) vs (b))
  ? #<N> — precondition #<M> still open
  ? #<N> — blocked on <prose>, no tracking issue

Concerns:
  - <anything that needs human attention>
```

---

## Constraints

- **Don't close issues automatically.** Closing is a human decision.
- **Don't modify issue bodies, except the advisory map.** Only labels and
  comments — with the single MAP-REFRESH exception, which rewrites *only* the
  `## Files Affected` advisory map (never Goal, Scope, Acceptance, or
  Verification) and always leaves a comment recording the refresh.
- **Promote conservatively.** A complete-looking body is necessary but not
  sufficient — the promotion guards (open decision / unmet precondition /
  deferred-by-design) exist because they bit us before. When a guard fires,
  leave the issue and report it under "Held back," never force it to Ready.
- **Be conservative on staleness.** 30 days is the floor for `claude-ready`;
  never mark stale at <30 days.
- **Match tolerantly.** Use the hygiene matcher's accepted forms — do not
  fail an issue on `### In` vs `In:` or a body-only `## Size`. Brittle matching
  is the bug that this pass exists to fix.
- **If you change a label, leave a comment explaining why.** Audit trail.
- **The label flip *is* the board update.** CI (`sync-project.yml`) reconciles
  Priority/Size/Status from labels on every label event, so no extra step is
  required. Optionally nudge Status sooner with
  `.claude/scripts/sync-project-status.sh <N> --from-labels`; it self-skips with
  a `note:` where `gh` can't reach the API (e.g. remote containers) — expected,
  not a failure to chase.
- **Fix a null GitHub Type field** via `set-issue-type.sh` (best-effort; it too
  self-skips when `gh` is unavailable, so set it from a session where `gh` works).
