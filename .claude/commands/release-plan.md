# Plan a Release Cycle

Open or sync the **tracking issue** for an upcoming release version.
Idempotent — re-running the same version reconciles the checklist with
current `release:*` label state.

This is the open / curate phase of release management. The cut phase
lives in `/release`. See `docs/conventions/issue-naming.md` "Release
tracking" for the convention.

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
   predecessor merged but the pin hasn't been bumped:

   ```
   mcp__github__search_issues query='repo:SailfinIO/sailfin is:open label:needs-seed-cut'
   ```

3. Compose the issue body:

   ```markdown
   ## Goal

   Track what must close before **vX.Y.Z** is cut.

   ## Scope summary

   <one paragraph — ask the user to fill, or seed from the active focus
   issue if one exists>

   ## Must close before cut

   - [ ] #<N> — <title>  (`release:<gate>`, size:_, priority:_)
   - [ ] ...

   ## Seed blockers (must close before the next seed bump)

   - [ ] #<N> — <title>  (`seed-blocker`)
   - [ ] ...

   ## Seed cut required (auto-flagged)

   <!-- Populated from open `needs-seed-cut` issues. Each means a
   required-in-seed predecessor merged; cut a fresh alpha + `/pin-seed`
   before those issues are picked up. Omit the section if none. -->

   - [ ] #<N> — <title>  (`needs-seed-cut`)
   - [ ] ...

   ## Cut gate

   This is a curated cut. `/release` will list every open item under
   `release:<gate>` and require explicit override before dispatching.

   ## Soft signals (non-blocking)

   - Items under `release:<soft>` may roll forward to a later cycle.

   ## Cross-references

   - Convention: `docs/conventions/issue-naming.md` "Release tracking"
     and "Seed pinning"
   - Cut workflow: `.github/workflows/release.yml`
   - `/release` skill: `.claude/commands/release.md`
   - `/pin-seed` skill: `.claude/commands/pin-seed.md`
   ```

3. Create the issue:

   ```
   mcp__github__issue_write title='Release: vX.Y.Z' labels=['tracking']
   ```

4. Report what was created with the issue URL.

---

## Phase 3b: UPDATE MODE

If the tracking issue already exists:

1. Read the current body. Parse the `## Must close before cut`,
   `## Seed blockers`, and `## Seed cut required (auto-flagged)`
   sections. Extract every `- [ ] #N` and `- [x] #N` line in each.
2. Pull the current sets:

   ```
   mcp__github__search_issues query='repo:SailfinIO/sailfin label:release:<gate>'
   mcp__github__search_issues query='repo:SailfinIO/sailfin label:seed-blocker'
   mcp__github__search_issues query='repo:SailfinIO/sailfin is:open label:needs-seed-cut'
   ```

3. Reconcile each section independently (`## Seed cut required
   (auto-flagged)` reconciles against the `needs-seed-cut` set; create
   the section if newly-flagged issues exist and it's absent):
   - **In body, now closed** → flip `- [ ]` to `- [x]`. Keep the line.
   - **In body, no longer labeled, still open** → flag as drift, leave
     the line, mention in the report. Don't auto-remove (human decision).
   - **Newly labeled, missing from body** → append a new `- [ ]` line
     under the matching section.

4. If anything changed, edit the body and post a summary comment:

   ```
   Auto-sync (release-plan):
     ✓ ticked N items as closed (#A, #B)
     + added N newly-labeled items (#C, #D)
     ⚠ N drift items (in checklist but no longer labeled): #E
   ```

5. If nothing changed, no edit and no comment — just report.

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

Must-close set:
  Open:    N issues
  Closed:  N items ticked
  Drift:   N (review)

Candidates (if --candidates):
  ...

Dry run: changes <previewed | applied>
```

---

## Constraints

- **Idempotent.** Running the command twice in a row should be a no-op.
- **Only writes the tracking issue body, the `tracking` label, and
  optional comments.** Never auto-applies `release:*` labels — that's
  triage, not planning.
- **Never closes issues.** Same convention as `/triage` and `/sweep`.
- **One tracking issue per version.** If two exist with the same title,
  surface the conflict and stop — don't pick one.
- **In `--dry-run`, make zero writes.** Print intended actions only.
- **Read `docs/conventions/issue-naming.md` "Release tracking" before
  acting.** It's the source of truth for the gating-label table.

---

## Why this command exists

`/release` cuts a release. `/release-plan` opens the cycle and keeps
the tracking issue current as work flows. The two commands bookend
the curated-release flow:

```
plan ──▶ curate (label, /sweep auto-tick) ──▶ /release
```

Without this command, opening a tracking issue is manual boilerplate
and the checklist drifts. With it, planning is one command per cycle
plus passive maintenance via `/sweep`.
