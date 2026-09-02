# Triage the Issue Queue

Work the **`Triage` lane** on the Sailfin (`SFN`) team: decide what each captured
item actually is, kill what shouldn't exist, and groom the survivors to the
`/pickup` bar. Nothing else. This command does not audit `Ready`, does not sweep
`In Progress`, and does not coordinate picks.

> **Linear is the planning source of truth.** Every state change is a
> `mcp__Linear__save_issue` write on a native field. See
> `docs/conventions/linear-workflow.md` for the lane model and
> `docs/conventions/linear-templates.md` for the issue body template.

## Target: $ARGUMENTS

| Argument | Mode |
|---|---|
| *(empty)* | **Pass 1 — CLASSIFY.** Read the whole `Triage` lane, propose a disposition for each item, report, stop. |
| `groom` | **Pass 2 — GROOM.** Groom the next batch (default 5) of items you approved for `Ready`. |
| `groom <n>` | Pass 2 with an explicit batch size. |
| `SFN-123 SFN-456 …` | Pass 2 on exactly these issues, regardless of batch order. |
| `age` | **Disposal floor.** Read-only sweep of `Backlog` for issues past the floor in `.claude/rules/follow-up-filing.md`; propose KILL; stop. |

Pass 1 is **read-only**. It never writes. The two passes are separate so the
keep/kill calls land in front of a human before grooming effort is spent, and so
17 items don't degrade into one context-starved run.

## Relationship to `/groom`

`/groom` decomposes an **epic (a Linear Project)** into new leaves. `/triage`
Pass 2 brings **one existing issue** up to the `Ready` bar. No overlap. When a
Triage item turns out to be epic-scale, `/triage` routes it to `/groom` rather
than grooming it in place.

---

## Pass 1 — CLASSIFY

### 1.1 Gather

```
mcp__Linear__list_issues team="Sailfin" state="Triage" limit=200
```

Do **not** query `state="Backlog"` — the Linear API matches that filter by state
*type*, so it returns `Ready` + `Blocked` + `Backlog` together and floods the
pass with work that isn't yours.

Fetch `includeRelations=true` only for items whose blocker state you must resolve.

### 1.2 Assign exactly one disposition

| Disposition | Means | Pass 2 action |
|---|---|---|
| **READY** | A real, session-sized leaf. Body may be thin — Pass 2 fills it. | Groom to the full bar, set native fields, → `Ready`. |
| **BACKLOG** | Real and understood, but not now: no current project, superseded soon, or deliberately deferred. | Set `type:*`/`area:*` + priority, → `Backlog`. No body work. |
| **EPIC** | Too big for one session (an `L`, or "parent of many"). | Propose a Linear **Project**; hand to `/groom`. Never groom in place. |
| **KILL** | Stale, already fixed, duplicate, or not actually a defect. | **Propose only.** Terminal states are a human call — see Constraints. |
| **MERGE** | One root cause filed as several symptoms — same session, same file or subsystem, fixed by one change. | **Propose only.** Name the survivor; the others become `Duplicate` of it (human confirms) and their observations are folded into the survivor's body as a checklist before it is groomed. |
| **MISFILED** | Not leaf work at all — a note, or an epic status thread. | Route to its real home (a Project description, an SFEP). |

**Skip release trackers outright.** An issue titled `Release: vX.Y.Z` carrying
the `tracking` label is auto-opened by `.github/workflows/release-train.yml` and
mirrored in from GitHub, which is why it lands in `Triage`. It is owned by
release automation, enriched by `/release-plan`, and walks itself to `Done` when
the cut closes its GitHub issue. Never groom, classify, or close one — exclude
it from the counts and note it in one line under a `Skipped` heading.

**Look for siblings before anything else.** Sort the lane by creator and
creation time; issues filed minutes apart by the same session against the same
file or subsystem are the MERGE candidates. One root cause groomed as one issue
is one session and one CI run; three issues are three of each
(`.claude/rules/pr-discipline.md` — the pool is sized for one PR).

**Verify before proposing KILL.** "Already fixed" and "stale" are claims about
the tree, not about the issue text — check the current source, a test, or the
git log, and cite what you checked. An unverified KILL is worse than leaving it.

### 1.3 The `Ready` bar (shared definition)

An issue is `Ready` when its body carries all of these. Match
case-insensitively; accept any listed form.

| Section | Accept any of |
|---|---|
| Goal | `## Goal` |
| Scope | `## Scope` |
| Scope → In | `In:` · `### In` · `**In:**` · `**In**` |
| Scope → Out | `Out:` · `### Out` · `**Out:**` · `**Out**` |
| Acceptance | `## Acceptance` with ≥1 `- [ ]` item |
| Files | `## Files` (e.g. "Files Affected"), not "TBD"/empty |
| Verification | `## Verification` with a runnable command |

Plus native fields: a `type:*` label, a priority, and an estimate of 1/2/3
(never higher — a 5 is an **EPIC**, not a `Ready` issue).

### 1.4 Blockers and preconditions

An item with an unresolved gate is **not** READY, however complete its body:

- **Hard blocker** — a `blockedBy` relation or an `SFN-N` reference. Apply
  `docs/conventions/blocker-classification.md`. Still open → BACKLOG with the
  relation set, so Linear derives `Blocked`.
- **Prose gate** — "once a seed past X is pinned", "after Y lands", "pick during
  grooming", "one of (a)/(b)". Resolve the reference: satisfied → READY, say so;
  unsatisfied → BACKLOG, name the gate.
- **Open design choice** — a genuine fork in the body is a design gate, not a
  grooming gap. Route to `compiler-architect` or an SFEP; do not pick a side.

### 1.5 Report and stop

```
Triage Pass 1 — <date>

<N> items in the Triage lane.

READY (<n>) — groom these next
  SFN-123  <title>
           <one line: why it's ready-able, proposed type/area/priority/estimate>

BACKLOG (<n>)
  SFN-456  <title> — <why not now>

EPIC (<n>)
  SFN-789  <title> — proposed Project: <name>; run /groom

KILL (<n>) — proposed, awaiting your call
  SFN-321  <title> — <claim> (verified: <what you checked>)

MERGE (<n>) — proposed, awaiting your call
  SFN-233 ← SFN-234, SFN-235  <one-line root cause>; survivor keeps the checklist

MISFILED (<n>)
  SFN-456  <title> — belongs in <destination>

Skipped (<n>) — not triage work
  SFN-722  Release: v0.10.0 — release automation, self-closing

Next: /triage groom   (grooms the first 5 READY items)
```

Then **stop**. No writes in Pass 1.

---

## `age` — the disposal floor

Read-only, like Pass 1. Proposes; never writes.

```
mcp__Linear__list_issues team="Sailfin" state="Backlog" limit=250 orderBy="updatedAt"
```

`state="Backlog"` matches the state **type** and returns `Ready` and `Blocked`
too (`docs/conventions/linear-workflow.md` § Querying lanes) — filter to
`status == "Backlog"` client-side before applying the floor. Page until
`hasNextPage` is false.

An issue is past the floor when **all** hold: status `Backlog`; priority Medium,
Low, or none; no Project; `updatedAt` older than 45 days. Report:

```
Triage age — <date>

<N> Backlog issues; <n> past the disposal floor.

KILL (<n>) — proposed, awaiting your call
  SFN-321  <title> — idle <d>d, <priority>, no project

Near the floor (<n>) — idle 30–45d, same shape; no action proposed
  SFN-322  <title>
```

Then **stop**. Confirmed kills are set to `Canceled` by a human with a one-line
reason; an issue that is still real gets a Project or a priority, which takes
it off the floor.

---

## Pass 2 — GROOM

For each issue in the batch:

1. **Re-read it.** Pass 1 may be hours or days old and the tree has moved.
2. **Derive the real surface.** Delegate to `compiler-explorer` for the file map
   rather than grepping the tree yourself. The `## Files Affected` map is
   **advisory** — no line numbers, no counts; `/pickup` reconciles drift.
3. **Write the body** to the `Ready` bar (§1.3), using the
   `docs/conventions/linear-templates.md` skeleton. Preserve the reporter's
   original observation — you are adding structure around it, not replacing it.
4. **Set native fields and route:**

```
mcp__Linear__save_issue id="SFN-<N>" state="Ready" priority=<1..4> estimate=<1|2|3> \
  labels=["type:<t>","area:<a>"] project="<Project>" description="<groomed body>"
mcp__Linear__save_comment issueId="SFN-<N>" body="Triage: groomed to the Ready bar (Goal/Scope/Acceptance/Files/Verification). Type <t>, estimate <n>, priority <p><, project X>. Files map is advisory."
```

For **BACKLOG** items, set labels + priority and move on — no body work:

```
mcp__Linear__save_issue id="SFN-<N>" state="Backlog" priority=<1..4> labels=["type:<t>","area:<a>"]
mcp__Linear__save_comment issueId="SFN-<N>" body="Triage: real but not now — <reason>. Classified <type>/<area>; left unstructured until it's picked up for grooming."
```

**Stop and report** if grooming an issue reveals it is actually an EPIC, needs a
design decision, or contradicts what Pass 1 assumed. Do not silently expand the
batch's scope.

### Pass 2 report

```
Triage Pass 2 — groomed <n> of <N> approved

Ready now:
  SFN-123  <title>  (type, estimate, priority)

Reclassified mid-groom:
  SFN-456  → EPIC — <why>

Remaining approved: <n>   → /triage groom
```

---

## Constraints

- **Never write a terminal status.** `Done`/`Canceled`/`Duplicate` are human
  decisions. Pass 1 *proposes* KILL; a human confirms. The sole exception is
  obvious spam or an exact duplicate of a still-open issue, which you may mark
  `Duplicate` **with a comment naming the original**.
- **Pass 1 writes nothing.** Not a label, not a priority. Its output is a report.
- **Only the Triage lane.** Do not touch `Ready`, `In Progress`, `In Review`, or
  `Blocked` issues. Hygiene elsewhere in the queue is not this command's job.
  The one exception is `age`, which *reads* `Backlog` and writes nothing.
- **Native fields only.** Status, priority, estimate, project, and blockers are
  Linear-native. Labels are `type:*`/`area:*` (plus `seed-blocker`/`release:*`).
  Never a `size:*`/`priority:*`/`blocked` label — see
  `docs/conventions/linear-workflow.md` § Linear labels.
- **Always comment when you change status.** The thread is the audit trail.
- **Don't rewrite an issue's substance.** Pass 2 adds structure around the
  reporter's observation. If you believe the observation is wrong, that is a
  KILL proposal, not a body edit.
