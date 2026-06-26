# Plan a Release Cycle

Open or sync the **tracking issue** for an upcoming release version.
Idempotent — re-running the same version reconciles the tracker's
**native sub-issues** with the current `release:*` / `seed-blocker` /
`needs-seed-cut` label state.

The tracker uses **GitHub-native sub-issues** as the source of truth (the
same mechanism `/groom` attaches to epics), giving a real "Sub-issues"
rollup panel and a native "what's left before X" view. The markdown
sections in the body are a **rendered summary** of that native state — not
hand-maintained checkboxes (SFEP-0026 WS-C; `docs/proposals/0026-delivery-process.md`).

This is the open / curate phase of release management. The cut phase
lives in `/release`, and the cadence train (`.github/workflows/release-train.yml`)
opens the tracker on the 2-week boundary and defers enrichment here. See
`docs/conventions/issue-naming.md` "Release tracking" for the convention.

## Target: $ARGUMENTS

Parse `$ARGUMENTS` as a target version (with or without leading `v`)
plus optional flags:

- `--candidates` — also surface unlabeled issues that look like
  candidates for the release (open epics in matching theme milestones,
  `priority:high` items in the active focus issue's workstream).
- `--dry-run` — print intended actions but make no changes.

Examples:
- `/release-plan v0.6.0` — open or sync `Release: v0.6.0`
- `/release-plan 0.6.0 --candidates` — same plus a candidates list
- `/release-plan v1.0.0 --dry-run` — preview only

If `$ARGUMENTS` is empty: infer the target as the next minor of the
current version in `compiler/capsule.toml` (e.g. `0.5.10-alpha.11` →
`0.6.0`). Confirm with the user before proceeding.

---

## Phase 1: RESOLVE TARGET

Parse `vX.Y.Z`. Map the version to the **gating label** it represents:

| Target shape | Gating label |
|---|---|
| `vX.Y.0` where Y > current minor (next minor) | `release:next-minor` |
| `v1.0.0` | `release:1.0` |
| `vX.Y.Z` matching the active beta promotion | `release:beta` |
| `vX.Y.Z` matching the active rc promotion | `release:rc` |
| `vX.Y.Z` matching the active stable promotion | `release:stable` |

If the version doesn't fit any of the above (e.g. a patch-line bump
mid-cycle), there's no specific label gate; surface that and ask the
user whether to proceed (most patch lines don't need a tracking issue).

---

## Phase 2: LOOK UP THE TRACKING ISSUE

Search for an exact-title match:

```
mcp__github__search_issues query='repo:SailfinIO/sailfin is:issue in:title "Release: vX.Y.Z"'
```

- **Found** → switch to UPDATE mode (Phase 3b).
- **Not found** → switch to CREATE mode (Phase 3a).

---

## Phase 3a: CREATE MODE

If no tracking issue exists for the target:

1. Pull every currently-open issue holding the gating label:

   ```
   mcp__github__search_issues query='repo:SailfinIO/sailfin is:open label:release:<gate>'
   ```

2. Pull open `seed-blocker` issues — they often correlate with what
   should ship in the same cycle:

   ```
   mcp__github__search_issues query='repo:SailfinIO/sailfin is:open label:seed-blocker'
   ```

2b. Pull open `needs-seed-cut` issues — flagged by the seed-cut advisor
   (`.github/workflows/seed-cut-advisor.yml`) when a required-in-seed
   predecessor merged but the pin hasn't been bumped. By default a
   `needs-seed-cut` flag means **queued for the next cadence seed bump**,
   not "cut now" (SFEP-0026 §3.3). Also pull `release-critical-seed` —
   the marker that distinguishes "break the batch" from "queue for cadence":

   ```
   mcp__github__search_issues query='repo:SailfinIO/sailfin is:open label:needs-seed-cut'
   mcp__github__search_issues query='repo:SailfinIO/sailfin is:open label:release-critical-seed'
   ```

3. Compose the issue body. The body is a **rendered summary** of the
   native sub-issue state (step 5 attaches the sub-issues); it is not the
   source of truth, so do not hand-maintain `- [ ]` toggles — re-render
   the lines from current open/closed state on each run:

   ```markdown
   ## Goal

   Track what must close before **vX.Y.Z** is cut on the release cadence.

   ## Scope summary

   <one paragraph — ask the user to fill, or seed from the active focus
   issue if one exists>

   ## Must close before cut

   <!-- Rendered from native sub-issues carrying `release:<gate>`.
   ☑/☐ reflects each sub-issue's open/closed state. The GitHub
   "Sub-issues" panel is the source of truth; this list mirrors it. -->

   - ☐ #<N> — <title>  (`release:<gate>`, size:_, priority:_)
   - ☑ #<N> — <title>  (closed)

   ## Seed blockers (must close before the next seed bump)

   - ☐ #<N> — <title>  (`seed-blocker`)

   ## Seed bump (this cadence)

   <!-- The pinned seed advances ONCE per cadence cycle, batched
   (SFEP-0026 §3.3). `needs-seed-cut` flags queue here for the next
   cadence `/pin-seed`; they do NOT trigger a reactive cut. -->

   Queued for the next cadence bump (`/pin-seed` runs on the next train cut):

   - ☐ #<N> — <title>  (`needs-seed-cut`)

   **Release-critical (off-cadence cut may be warranted):**

   <!-- Only items carrying `release-critical-seed` — they clear the
   three-clause bar in `docs/conventions/issue-naming.md` "Batched-cadence
   seeds" and may break the batch. Omit this sub-list if none. -->

   - ⚠ #<N> — <title>  (`release-critical-seed`)

   ## Stable promotion

   <!-- Advisory gate. Promotion stays human-gated. See Phase 3c. -->

   Eligible when **both** hold: this tracker is clear (every hard-gated
   item closed) **and** 7 consecutive green-CI days on `main`.
   Current: <eligible | not eligible — reason>.

   ## Cut gate

   This is a curated cadence cut. `/release` will list every open item
   under `release:<gate>` and require explicit override before dispatching.
   Open scope rolls forward — it never blocks the train.

   ## Cross-references

   - Cadence train: `.github/workflows/release-train.yml`
   - Convention: `docs/conventions/issue-naming.md` "Release tracking"
     and "Seed pinning"
   - Cut workflow: `.github/workflows/release.yml`
   - `/release` skill: `.claude/commands/release.md`
   - `/pin-seed` skill: `.claude/commands/pin-seed.md`
   - Design: SFEP-0026 (`docs/proposals/0026-delivery-process.md`) WS-C
   ```

4. Create the tracker issue:

   ```
   mcp__github__issue_write title='Release: vX.Y.Z' labels=['tracking']
   ```

5. **Attach each curated item as a native sub-issue** of the tracker —
   mirroring `/groom`'s epic sub-issue pattern. Body references alone do
   not populate the parent's "Sub-issues" panel. Use the REST API (the
   `gh` CLI has no first-class command yet); `sub_issue_id` MUST be passed
   with `-F` (typed integer) or the API rejects it with a 422:

   ```bash
   # The tracker's internal node id (NOT the issue number):
   TRACKER=<tracker-number>
   TRACKER_ID=$(gh api repos/SailfinIO/sailfin/issues/$TRACKER --jq '.id')

   # Attach every must-close / seed-blocker / needs-seed-cut item:
   for n in <gate + seed-blocker + needs-seed-cut issue numbers>; do
     child_id=$(gh api repos/SailfinIO/sailfin/issues/$n --jq '.id')
     gh api -X POST /repos/SailfinIO/sailfin/issues/$TRACKER/sub_issues \
       -F sub_issue_id=$child_id --jq '.number'
   done

   # Verify the rollup now lists every child:
   gh api /repos/SailfinIO/sailfin/issues/$TRACKER/sub_issues \
     --jq '.[] | "#\(.number) \(.title)"'
   ```

   Attaching an issue that is already a sub-issue is a harmless 4xx — treat
   it as idempotent (skip, don't fail the run).

6. Report what was created with the issue URL and the count of attached
   sub-issues.

---

## Phase 3b: UPDATE MODE

If the tracking issue already exists, reconcile its **native sub-issues**
(the source of truth) against the current label sets, then re-render the
body summary from native state:

1. Read the tracker's current native sub-issues:

   ```bash
   TRACKER=<tracker-number>
   gh api /repos/SailfinIO/sailfin/issues/$TRACKER/sub_issues --paginate \
     --jq '.[] | {number, state}'
   ```

2. Pull the current label sets:

   ```
   mcp__github__search_issues query='repo:SailfinIO/sailfin label:release:<gate>'
   mcp__github__search_issues query='repo:SailfinIO/sailfin label:seed-blocker'
   mcp__github__search_issues query='repo:SailfinIO/sailfin is:open label:needs-seed-cut'
   mcp__github__search_issues query='repo:SailfinIO/sailfin is:open label:release-critical-seed'
   ```

3. Reconcile the native sub-issue set (do **not** edit `- [ ]` toggles by
   hand — open/closed is read from the sub-issue, not stored in the body):
   - **Newly labeled, not yet a sub-issue** → attach it via
     `POST /issues/$TRACKER/sub_issues` (`-F sub_issue_id=<int>`; see
     Phase 3a step 5). The "Sub-issues" panel then shows it automatically.
   - **Already a sub-issue, now closed** → no action; the panel and the
     re-rendered summary reflect the closed state on their own.
   - **A sub-issue that no longer carries any gating/seed label, still
     open** → flag as drift in the report; **do not detach** (removing a
     sub-issue is a human decision, same as `/sweep`/`/triage` never
     auto-close).

4. **Re-render the body summary** from the reconciled native state: rebuild
   the `## Must close before cut`, `## Seed blockers`, `## Seed bump (this
   cadence)` (queued vs. `release-critical-seed`), and `## Stable promotion`
   sections so each `☐`/`☑`/`⚠` line mirrors the current sub-issue
   open/closed state and labels. Create a section if newly-relevant items
   exist and it's absent.

5. If anything changed (a sub-issue attached, or the rendered summary
   differs), edit the body and post a summary comment:

   ```
   Auto-sync (release-plan):
     + attached N new sub-issues (#C, #D)
     ✓ summary re-rendered — N closed (#A, #B)
     ⚠ N drift items (sub-issue no longer labeled): #E
   ```

6. If nothing changed, no edit and no comment — just report.

---

## Phase 3c: STABLE PROMOTION GATE (advisory)

Stable promotion is **not** on a timer (SFEP-0026 §3.3). After reconciling
the tracker, evaluate eligibility and surface it — never auto-dispatch
(`channel=stable` stays human-gated). Eligible only when **both** hold:

1. **Tracker clear.** Every hard-gated sub-issue (`release:stable` /
   `release:rc`, per the gate) is closed — read from the native sub-issue
   rollup, not the markdown.
2. **N = 7 consecutive green-CI days.** The Nightly self-host check
   (`.github/workflows/nightly-selfhost.yml`) concluded `success` on `main`
   for 7 consecutive days with no failing run in the window:

   ```bash
   gh run list --workflow nightly-selfhost.yml --branch main \
     --created ">=$(date -u -d '7 days ago' +%Y-%m-%d)" \
     --json conclusion,createdAt --jq '[.[] | .conclusion] | unique'
   ```

   Pass only when every run in the 7-day window is `success` (the `unique`
   set is exactly `["success"]`) and at least one run exists per day.

Render the verdict into the `## Stable promotion` section and the report:
**eligible** → "stable promotion eligible — a human may dispatch
`release.yml channel=stable`"; **not eligible** → state which clause fails
(open hard-gated sub-issues, or the green-CI day count). Seven days is
chosen to span a full nightly week (weekday + weekend cron variance) while
still fitting inside one cadence interval.

---

## Phase 4: CANDIDATES MODE (optional, when `--candidates` is set)

Surface unlabeled issues that *might* belong on this release's gate:

1. **From theme milestones.** For the active theme milestones (#6, #7,
   #8, #10, plus any matching the gating label by topic), list
   open epic issues without any `release:*` label.
2. **From priority.** Open `priority:high` and `priority:critical`
   issues without any `release:*` label.
3. **From the focus issue.** If a `focus:approved` issue exists, its
   workstream targets are likely candidates; list them.

Print as "consider applying `release:<gate>`":

```
Candidates for release:<gate> (not currently labeled):
  - #N — <title>  (rationale: open epic in milestone "M", priority:high)
  - ...
```

**Don't auto-apply labels.** Recommendation only — the human decides.

---

## Phase 5: REPORT

Concise summary:

```
Release Plan — vX.Y.Z (gate: release:<gate>)
Tracking issue: <created | updated | unchanged> (#<N>)

Sub-issues (native rollup):
  Attached: N total  (+M new this run)
  Open:     N  |  Closed: N
  Drift:    N (sub-issue no longer labeled — review, not auto-detached)

Seed bump (this cadence):
  Queued (needs-seed-cut):     N — batched for next cadence /pin-seed
  Release-critical (override): N — off-cadence cut may be warranted

Stable promotion: <eligible | not eligible — reason>

Candidates (if --candidates):
  ...

Dry run: changes <previewed | applied>
```

---

## Constraints

- **Idempotent.** Running the command twice in a row should be a no-op —
  attaching an already-attached sub-issue is a harmless skip, and the
  re-rendered summary is byte-identical when nothing changed.
- **Native sub-issues are the source of truth.** The markdown sections are
  a rendered mirror — never hand-edit `☐`/`☑` toggles; re-render from the
  sub-issue rollup. Attach via `POST /issues/<tracker>/sub_issues`
  (`-F sub_issue_id=<int>`, typed — `-f` 422s).
- **Only writes the tracker body, the `tracking` label, sub-issue
  attachments, and optional comments.** Never auto-applies `release:*` or
  `release-critical-seed` labels — that's triage/grooming, not planning.
- **Never closes or detaches.** Same convention as `/triage` and `/sweep`:
  closing an issue and removing a sub-issue are human decisions. Surface
  drift; don't act on it.
- **Promotion stays human-gated.** Phase 3c only *surfaces* "stable
  promotion eligible" — it never dispatches `release.yml channel=stable`.
- **Seeds batch onto the cadence.** `needs-seed-cut` items queue for the
  next cadence `/pin-seed`; only `release-critical-seed` items may break
  the batch (SFEP-0026 §3.3). Never recommend a reactive cut for a plain
  `needs-seed-cut` flag.
- **One tracking issue per version.** If two exist with the same title,
  surface the conflict and stop — don't pick one.
- **In `--dry-run`, make zero writes.** No body edits, no sub-issue
  attachments, no comments. Print intended actions only.
- **Read `docs/conventions/issue-naming.md` "Release tracking" before
  acting.** It's the source of truth for the gating-label table.

---

## Why this command exists

`/release` cuts a release. `/release-plan` opens the cycle and keeps
the tracking issue current as work flows. The two commands bookend
the curated-release flow:

```
cadence train opens tracker ──▶ plan (attach sub-issues, render summary)
  ──▶ curate (label, /sweep native-sub-issue sync) ──▶ /release
```

Without this command, opening a tracking issue is manual boilerplate and
the rollup drifts. With it, planning is one command per cycle plus passive
maintenance via `/sweep` — and the native "Sub-issues" panel gives a
real "what's left before X" view instead of string-matched checkboxes.
