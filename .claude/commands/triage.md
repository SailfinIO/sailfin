# Triage the Issue Queue

Audit the **Linear** Sailfin (`SFN`) queue for hygiene **in both directions**:
promote already-groomed issues that nobody moved to `Ready`, and demote
incomplete `Ready` issues. Shape new intake (external-contributor GitHub issues
that mirrored into Linear `Triage`). Surface stale, blocked, and orphaned work.

> **Linear is the planning source of truth.** All state changes are
> `mcp__Linear__save_issue` status/priority/estimate/label/relation writes.
> There is no GitHub board or fallback labels to keep in sync. External GitHub
> issues arrive in Linear `Triage` via the integration; that is the only GitHub
> surface this command reads. See `docs/conventions/linear-workflow.md`.

## Target: $ARGUMENTS

Optional filter — pass a label (e.g. `type:perf`) or a status to triage a
subset, or leave empty to triage the whole open queue.

## Relationship to `/sweep`

`/triage` is the **periodic, whole-queue hygiene auditor**. `/sweep` is the
**event-driven, post-merge coordinator** (concurrency budget, collision
analysis, next picks). They share one mechanic — **clearing a blocker whose
blocking issue closed** (both use the hard-vs-prose rule below). Keep that logic
in sync between the two files.

---

## Phase 1: GATHER

Pull the open SFN queue, grouped by the states this pass acts on:

```
mcp__Linear__list_issues team="Sailfin" state="Triage" limit=200
mcp__Linear__list_issues team="Sailfin" state="To triage" limit=200
mcp__Linear__list_issues team="Sailfin" state="Backlog" limit=200
mcp__Linear__list_issues team="Sailfin" state="Ready" limit=200
mcp__Linear__list_issues team="Sailfin" state="Blocked" limit=200
mcp__Linear__list_issues team="Sailfin" state="In Progress" limit=200
```

Apply the optional `$ARGUMENTS` filter. Use `includeRelations=true` on any issue
whose blocker state you need to resolve.

---

## The hygiene matcher (shared definition)

Promotion and demotion both depend on whether a body is **complete**. Match
case-insensitively and accept any listed form (brittle matching is the bug this
pass exists to fix).

| Section | Accept any of |
|---|---|
| Goal | `## Goal` |
| Scope | `## Scope` |
| Scope → In | `In:` · `### In` · `**In:**` · `**In**` (under Scope) |
| Scope → Out | `Out:` · `### Out` · `**Out:**` · `**Out**` |
| Acceptance | `## Acceptance` with ≥1 `- [ ]` item |
| Files | `## Files` (e.g. "Files Affected"), not "TBD"/empty |
| Verification | `## Verification` with a runnable command |

**Estimate** is satisfied by a native Linear estimate (1/2/3) OR a `## Size`
body section declaring XS/S/M. If the body declares a size but the estimate is
unset, that is a **backfill** (set it), not a failure.

**Type** is satisfied by a `type:*` label.

---

## Phase 2: AUDIT

Classify every issue into exactly one action bucket.

### PROMOTE candidates (the queue-unsticking pass)
An issue is a **PROMOTE** candidate when ALL hold:
- It is in `Triage` / `To triage` / `Backlog` (not already `Ready`/started).
- Its body is **complete** per the matcher.
- It has **no open blocker** (apply the UNBLOCK hard-vs-prose rule to its
  blocked-by relations and any `## Blocked by` prose in the body).
- It has **no unresolved in-body decision or precondition** (guards below).

**Promotion guards — do NOT promote if any apply:**
- **Open design choice in body:** "pick during grooming", "one of (a)/(b)",
  "TBD by grooming", a Scope listing mutually-exclusive options → leave in place, flag.
- **Unmet precondition:** "once a seed past #N is pinned", "after #M lands".
  Resolve the reference: closed/merged → precondition met (promote, say so);
  still open → leave and flag.
- **Deferred-by-design:** "not picked up until …". Verify the gate closed first.

### DEMOTE candidates
An issue is a **DEMOTE** candidate when it is `Ready` but its body is
**incomplete** per the matcher, or it lacks a `type:*` label, or it has no
estimate (neither native estimate nor `## Size`).

### INTAKE candidates (new contributor issues)
An issue in `Triage` / `To triage` that mirrored in from an external GitHub
issue (the integration records the GitHub link on it) and has **no** SFN
classification yet. Shape it: set `type:*`/`area:*` labels from the report,
apply an estimate + priority if scopeable, associate it to the right Project,
then route it — `Ready` if it's already a complete, session-sized leaf;
`Backlog` if scoped but not ready; leave in `Triage` with a flag if it needs
grooming; `Duplicate`/`Canceled` (with a comment) for non-actionable intake.

### State buckets
- **UNBLOCK** — `Blocked` and every hard blocker (relation or `#N`/`SFN-N` ref) is closed.
- **RELEASE** — `In Progress` but no active branch / its PR closed unmerged → back to `Ready`.
- **STALE** — `Ready` with no update in 30+ days (flag only).
- **OVERSIZED** — an L-scale issue (estimate > 3 or body `## Size: L`) → back to
  `Triage`/`Backlog` for `/groom` to decompose into a Project's leaves.
- **STALE-GROOM** — `Backlog`/`Triage` 14+ days that is NOT a promote candidate
  (still incomplete) → flag for `/groom` or closure review.
- **MAP-REFRESH** — `Ready` (or just-promoted) issue whose Goal + semantic
  `In:`/`Out:` scope are intact but whose `## Files Affected` advisory map has
  missing/renamed paths → re-derive and rewrite the advisory map (still
  non-binding; no line numbers/counts). A stale map is expected entropy — never
  a DEMOTE trigger.

---

## Phase 3: APPLY ACTIONS

Every action is a native Linear write. Leave a comment
(`mcp__Linear__save_comment`) whenever you change status so the thread has an
audit trail. **Never write a terminal status** (`Done`) on open work.

### PROMOTE — move a groomed issue to Ready

```
mcp__Linear__save_issue id="SFN-<N>" state="Ready" estimate=<1|2|3 if backfilled> priority=<1..4 if unset>
mcp__Linear__save_comment issueId="SFN-<N>" body="Auto-triage promotion: body passes the full hygiene bar (Goal/Scope-In-Out/Acceptance/Files/Verification), no open blocker or unresolved decision. <If backfilled: 'Size <X> in body → estimate <n>; default priority <p>.'> Moving to Ready."
```

Backfill the estimate from the body `## Size` (XS/S/M → 1/2/3) and default the
priority to the issue's Project priority if unset.

### DEMOTE — strip Ready from an incomplete issue

```
mcp__Linear__save_issue id="SFN-<N>" state="Triage"
mcp__Linear__save_comment issueId="SFN-<N>" body="Auto-triage: missing sections required for /pickup eligibility: <list>. Run /groom to flesh out, or cancel if no longer relevant."
```

### INTAKE — shape a new contributor issue

```
mcp__Linear__save_issue id="SFN-<N>" labels=["type:<t>","area:<a>"] priority=<1..4> estimate=<1|2|3> project="<Project>" state="<Ready|Backlog>"
mcp__Linear__save_comment issueId="SFN-<N>" body="Auto-triage intake: classified as <type>/<area>, associated to <Project>. <Routed to Ready | Needs grooming — /groom | Marked duplicate of SFN-M>."
```

### UNBLOCK — clear a resolved blocker (hard-vs-prose rule, shared with `/sweep`)

Read blocked-by relations (`get_issue includeRelations=true`) and any
`## Blocked by` prose in the body. Classify each:
- **Hard reference** (a Linear blocked-by relation, or a `SFN-N`/`#N`) — closed
  = resolved; open = still blocking.
- **Prose reference** ("Slice E", "the M4 runtime port", "a fresh seed cut") — an
  agent can't decide when prose is satisfied; its **presence** blocks the flip.

Flip to `Ready` **only** when every hard reference is closed AND no prose gate
remains. Remove the resolved relations and set status:

```
mcp__Linear__save_issue id="SFN-<N>" state="Ready" removeBlockedBy=["SFN-<resolved>"]
mcp__Linear__save_comment issueId="SFN-<N>" body="Auto-triage: all hard blockers closed (<list>) and no prose gate present. Marking Ready."
```

If a just-unblocked issue is still `needs-grooming`-incomplete, fold it through
the PROMOTE guard rather than landing it in `Ready` half-baked.

### RELEASE — orphaned In Progress back to the queue

```
mcp__Linear__save_issue id="SFN-<N>" state="Ready"
mcp__Linear__save_comment issueId="SFN-<N>" body="Auto-triage: In Progress but no active branch/PR found. Releasing back to Ready."
```

### STALE / STALE-GROOM / OVERSIZED — flag (and for OVERSIZED, re-route)

STALE and STALE-GROOM are flag-only (comment, no status change). OVERSIZED moves
back to `Triage`/`Backlog` with a comment pointing at `/groom` to decompose it
into a Project's leaves (an L-scale issue is epic-scale — it becomes a Project,
not a single issue).

### MAP-REFRESH — rewrite a stale advisory map (the one allowed body edit)

When Goal + semantic `In:`/`Out:` scope are intact but `## Files Affected` lists
missing/renamed paths, re-derive the current surface for each `In:` unit and
**rewrite only that block** (non-binding, no line numbers/counts). Do not touch
Goal, Scope, Acceptance, or Verification. Record it:

```
mcp__Linear__save_issue id="SFN-<N>" description="<body with only the ## Files Affected map refreshed>"
mcp__Linear__save_comment issueId="SFN-<N>" body="Auto-triage map refresh: re-derived ## Files Affected from the current tree. Map only — Goal and semantic In/Out unchanged. /pickup reconciles any remaining drift."
```

This is the **sole** exception to "don't modify issue bodies."

---

## Phase 4: REPORT

```
Triage Report (<date>)

Audited: <total> open SFN issues

Status breakdown:
  Ready (pickable):    <N>
  Ready (stale):       <N>
  In Progress (active):   <N>
  In Progress (orphaned): <N>
  Backlog/Triage:      <N>
  Blocked (real):      <N>
  Blocked (cleared):   <N>
  New intake shaped:   <N>

Actions taken:
  - Promoted <N> groomed issues to Ready (backfilled <N> estimates)
  - Demoted <N> incomplete Ready issues to Triage
  - Shaped <N> new contributor issues (type/area/priority/project)
  - Released <N> orphaned In Progress back to Ready
  - Unblocked <N> issues whose blockers closed
  - Refreshed <N> stale advisory maps
  - Flagged <N> stale / oversized issues

Top picks for /pickup right now:
  1. SFN-<N> — <title> (type, estimate)
  2. ...

Held back (complete body, not pickable):
  ? SFN-<N> — open design choice ((a) vs (b))
  ? SFN-<N> — precondition <M> still open
  ? SFN-<N> — blocked on <prose>, no tracking issue

Concerns:
  - <anything needing human attention>
```

---

## Constraints

- **Don't cancel/close issues automatically.** Terminal states
  (`Done`/`Canceled`/`Duplicate`) are human decisions — except an obvious
  duplicate/spam intake, which you may mark `Duplicate`/`Canceled` **with a
  comment** during INTAKE.
- **Don't modify issue bodies, except the advisory map** (MAP-REFRESH).
- **Promote conservatively.** A complete body is necessary but not sufficient —
  the guards (open decision / unmet precondition / deferred-by-design) exist
  because they bit us before. When a guard fires, leave it and report under
  "Held back."
- **Be conservative on staleness.** 30 days is the floor for `Ready`.
- **Match tolerantly.** Use the matcher's accepted forms; a body-only `## Size`
  or `### In` must pass.
- **Always comment when you change status.** Audit trail.
- **Native fields only** — status/priority/estimate/blockers are Linear-native,
  not labels. Labels are `type:*`/`area:*` (+ `seed-blocker`/`release:*` for the
  seed/release axes).
