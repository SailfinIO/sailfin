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

Two responsibilities:

1. **Plan** (always) — open or sync the tracker as a rendered mirror of the
   current `release:*` label state (Phases 1–3, 5).
2. **Curate** (`--candidates`) — the propose → **you approve** → apply loop
   that *decides release scope* and applies the `release:<gate>` labels the
   plan step then renders (Phase 4). Without this, unplanned merged work is
   never labeled, so the tracker opens empty — the gap `--candidates`
   exists to close.

## Target: $ARGUMENTS

Parse `$ARGUMENTS` as a target version (with or without leading `v`)
plus optional flags:

- `--candidates` — run the **full-reconcile curation loop**: scan issues,
  SFEPs, and merged-but-unreleased work for candidates; propose a scoped
  set classified IN vs ROLL-FORWARD with rationale; present it for your
  approval; then **apply `release:<gate>` to the approved subset** and
  re-render the tracker (Phase 4). Label writes happen *only* on your
  explicit approval — never unattended, never under `--dry-run`.
- `--dry-run` — print intended actions (including the candidate proposal)
  but make no writes: no tracker edits, no sub-issue attaches, no label
  applications.

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

## Phase 3c: REFLECT INTO LINEAR (release Cycle)

Releases live on an axis **orthogonal to the epic-Projects** — a release is a
time-boxed cut across many epics, and a Linear issue belongs to exactly one
Project (its epic), so the release axis is the `release:*` labels (source of
truth) plus a Linear **Cycle** for the target window (which carries the dates and
burndown). Releases are **never** Linear Projects. See
`docs/conventions/issue-naming.md` § Release tracking.

Reflect the plan into Linear (best-effort — skip with a one-line note if the
Linear MCP tools aren't connected, per § Reflecting state into Linear; never
write a terminal issue status):

1. **Pick the target Cycle.** `list_cycles` for the Sailfin team; choose the
   cycle whose window covers the intended cut (the current cycle, or the next
   when the current is closing). Its `endsAt` is the visible target date.
2. **Assign the must-close set to that Cycle.** For every open `release:<gate>`
   issue on the tracker, set its Linear mirror's `cycle` to the target cycle and
   its `priority` from the issue's `priority:*` label (critical→1/Urgent,
   high→2, medium→3, low→4). This is what yields the dated, burndown-tracked
   "what's in vX.Y.Z" view.
3. **Assign the tracking issue** to the same Cycle and set its priority, so the
   coordination issue rides along.

Do NOT create a Project for the release, and do NOT move the `release:<gate>`
issues out of their epic Projects — Cycle membership is orthogonal to Project
membership.

---

## Phase 4: CURATION LOOP (when `--candidates` is set)

The scope-deciding half of the command: **propose → you approve → apply**.
It is the only step that writes `release:*` labels, and only ever to the
subset you approve. This closes the structural gap where unplanned merged
work (e.g. a feature/bug shipped in an out-of-cadence alpha) never gets
labeled, so the tracker renders empty.

### 4.1 — Full-reconcile scan (propose)

**Only open issues are gate-label candidates.** A `release:<gate>` label
means "must close before the cut," so it is **never** applied to a
closed/merged issue. Merged-but-unreleased work is summarized as an
informational **manifest**, not proposed for labeling. Gather from all of
these sources, deduplicating by issue number (an issue may hit several —
record every reason; it strengthens the rationale):

**Gate-label candidates (open only):**

1. **Priority.** Open issues at Linear-native priority Urgent or High with
   no `release:*` label (priority is a Linear field, read via the mirror — not
   a GitHub label). Best-effort: if the Linear MCP tools aren't connected, skip
   this source and rely on the others below.
2. **Correctness regressions.** Open `type:bug` issues (any priority) with
   no `release:*` label — a shipped-feature defect is a strong stable gate.
3. **SFEP-targeted.** Read the SFEP registry (`docs/proposals/README.md`)
   for proposals in `Accepted` (design-approved, implementation pending) or
   `Draft`-with-tracking status; follow each SFEP's `tracking:` front-matter
   to its implementing issues and include the open, unlabeled ones. (This is
   the SFEP scan the old `--candidates` lacked.)
4. **Seed state.** Cross-reference the open `seed-blocker` /
   `needs-seed-cut` sets already pulled in Phase 3 — surface any not yet
   labeled for the gate.
5. **Focus issue.** If a `focus:approved` issue exists, include its
   workstream targets.
6. **Theme-milestone epics.** Open epics in the active theme milestones
   (#6, #7, #8, #10, plus any matching the gate by topic). **Flag these as
   "usually milestone-tracked, not a single-cut gate"** — surface but
   default them to ROLL-FORWARD. An **epic is a container, not a gate unit**:
   what belongs on a release gate is an epic's in-flight *sub-issue*, never
   the multi-release epic itself.

**Manifest (informational — never labeled):**

7. **Merged-but-unreleased.** Issues closed by PRs merged to `main` since
   the last release of this line — the headline work that *will* ship in
   the target. Summarize as a count + notable features for the tracker's
   manifest section; do **not** propose these for the gate label (they are
   closed — see the open-only rule above). Its value is (a) the release
   manifest and (b) catching any *open* unplanned work, which is already
   covered by sources 1–3.

   ```bash
   # Baseline = the last release of this line. Exclude prereleases so a
   # stable-promotion manifest spans the whole minor; fall back to the
   # nearest v* tag if the line has no stable cut yet.
   LAST=$(git describe --tags --abbrev=0 --match 'v*' --exclude '*-*' 2>/dev/null \
          || git describe --tags --abbrev=0 --match 'v*' 2>/dev/null)
   SINCE=$(git log -1 --format=%cd --date=short "$LAST" 2>/dev/null)
   gh pr list --state merged --base main --search "merged:>=$SINCE" \
     --json number,title,closingIssuesReferences \
     --jq '.[] | "\(.title)"' | sort -u
   ```

### 4.2 — Classify and present (your approval gate)

Classify each candidate as a recommendation, then **present the full set
and stop for the user's decision** — do not apply anything yet:

- **IN** — should gate this release (correctness regressions, Linear-native
  priority Urgent, SFEP items explicitly targeting this version).
  **Open issues only** — a merged/closed item is never IN; it belongs to
  MANIFEST (see the open-only rule in 4.1).
- **ROLL-FORWARD** — defer to a later release (epics/themes, speculative
  or unscoped Linear-native priority High, anything whose landing this cycle
  is uncertain).
- **MANIFEST** — merged-but-unreleased work; informational only, never
  labeled (rendered into the tracker's manifest section).

Present grouped by disposition with a one-line rationale and the exact
label each IN item would receive. The MANIFEST group is informational
context — it is rendered into the tracker's manifest section, never
labeled:

```
Proposed scope — Release: vX.Y.Z (gate: release:<gate>)

IN (apply release:<gate> — open issues only):
  #N — <title>   [type:bug · shipped-feature miscompile]
  #M — <title>   [priority:Urgent · SFEP-00NN target]

ROLL-FORWARD (no label / defer):
  #P — <title>   [epic, milestone-tracked — not a single-cut gate]

MANIFEST (merged since <last tag>, ships in target — informational, not labeled):
  N issues; headliners: <feature>, <feature>, ...

Reply: approve all IN · move #X to IN/ROLL · drop #Y · edit the set.
```

**Stop here.** The user approves, trims, or re-classifies. Apply nothing
without an explicit go-ahead. Under `--dry-run`, end after presenting.

### 4.3 — Apply the approved set

For each issue the user approved as IN, apply the gate label (a **write**,
authorized by the approval just given):

```bash
gh issue edit <N> --add-label "release:<gate>"
```

Never apply a label to a ROLL-FORWARD or dropped item. Never apply
`release-critical-seed` here (that marker stays a `/triage` decision).

### 4.4 — Re-render the tracker

Labels just changed, so reconcile the tracker to reflect them: run the
**Phase 3b UPDATE-MODE** reconcile (attach the newly-labeled issues as
native sub-issues, re-render the body summary, post the auto-sync comment).
If the tracker did not exist before this run, Phase 3a already created it;
re-run 3b to attach the freshly-labeled set. The tracker now lists the
scope you approved.

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

Curation (if --candidates):
  Proposed:   N  (IN: N, ROLL-FORWARD: N)
  Approved:   N  → release:<gate> applied to #A, #B, ...
  Deferred:   N  (rolled forward, unlabeled)
  Re-render:  +M sub-issues attached to #<tracker>

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
- **Label writes are approval-gated, never unattended.** The default plan
  step (no `--candidates`) writes only the tracker body, the `tracking`
  label, sub-issue attachments, and comments — it never touches `release:*`.
  The `--candidates` curation loop applies `release:<gate>` **only to the
  subset the user explicitly approves** in Phase 4.2, and never applies
  `release-critical-seed` (that stays a `/triage` decision). No `release:*`
  label is ever applied without a human go-ahead in the same run.
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
  attachments, no comments, **no label applications** — the curation loop
  ends after presenting the proposal. Print intended actions only.
- **Read `docs/conventions/issue-naming.md` "Release tracking" before
  acting.** It's the source of truth for the gating-label table.

---

## Why this command exists

`/release` cuts a release. `/release-plan` opens the cycle, **decides its
scope** (via `--candidates`), and keeps the tracking issue current as work
flows. The commands bookend the curated-release flow:

```
cadence train opens tracker
  ──▶ /release-plan --candidates : propose scope ──▶ YOU approve
        ──▶ apply release:<gate> ──▶ render tracker (sub-issues + summary)
          ──▶ /sweep keeps the rollup synced ──▶ /release cuts
```

Without the curation loop, `release:*` labeling is a manual step everyone
forgets — so trackers open empty and unplanned merged work ships
unrecorded. With it, scope is one approval-gated command per cycle plus
passive `/sweep` maintenance, and the native "Sub-issues" panel gives a
real "what's left before X" view instead of string-matched checkboxes.
