# Reconcile `docs/status.md`

Batch-reconcile `docs/status.md` against what actually merged since the last
sweep. This is the **only** writer of that file — feature PRs do not touch it.

## Target: $ARGUMENTS

Empty: sweep from the last reconciliation to `origin/main`.
A version (`0.10.6`): sweep from that release's tag.
`--dry-run`: report the delta and the proposed row edits, change nothing.

---

## Why this is batched

`docs/status.md` answers "what ships today." A PR author has per-change
information, not current-state information, so a per-PR write obligation
produced two failures at once: the file was touched by ~a third of all commits
and conflicted constantly, and it grew ~20 lines per change while almost never
shrinking — 1,868 lines, of which one section was 1,126.

The sweep exists to give the writer the vantage point the file needs. That
makes **pruning a first-class part of the job**, not a nicety: a sweep that only
adds has reproduced the original problem with better spelling.

---

## Phase 1: ESTABLISH THE WINDOW

The last reconciliation is recorded in the file's own header
(`Reconciled at release <X>`). Confirm it against git, since a hand-written
marker can drift:

```bash
git fetch origin main
git log -1 --format='%h %ad %s' --date=short origin/main -- docs/status.md
```

Take the window as `<last reconciled tag>..origin/main`. List what landed:

```bash
git log --oneline <tag>..origin/main | wc -l
git log --format='%s' <tag>..origin/main
```

---

## Phase 2: DERIVE THE STATUS DELTA

**Most merged PRs change nothing in this file.** Refactors, test infrastructure,
CI, build-driver work, and internal renames move no status. Classify the window
and keep only what changes an answer a reader would get from the file:

| Lands in the sweep | Does not |
|---|---|
| A feature reaches Stage1 readiness (status flips `Partial`/`Parsed` → `Shipped`) | An internal refactor of shipped code |
| Enforcement turns on for an effect, diagnostic, or gate | A test added for already-shipped behavior |
| A runtime symbol completes its C → Sailfin migration | A CI topology or workflow change |
| A support tier changes for a target | A docs, spec, or SFEP edit |
| A new user-visible surface ships (CLI flag, diagnostic code, capsule) | A perf improvement with no behavior change |
| Something previously claimed shipped is found not to be | A dependency or seed pin bump |

**Dispatch `docs-updater` (sonnet)** to do the classification pass over the
window and return a candidate row list. Reserve your own judgment for Phase 3 —
the classification is mechanical, the adjudication is not.

---

## Phase 3: ADJUDICATE EACH CLAIM

Do not take a PR body's word for what shipped. Apply the **Stage1 readiness**
bar from `CLAUDE.md` to each candidate — parses, type/effect-checks, emits valid
`.sfn-asm`, lowers, has regression coverage, self-hosts, passes `sfn fmt
--check`. Verify against the tree, not the narrative:

```bash
build/bin/sfn test <the test the PR claims as coverage>
```

**"Parsed but not enforced" is not shipped.** A PR that adds parsing for a
construct moves a row to `Parsed`, never to `Shipped`. This is the single
judgment the sweep exists to make; it is why the sweep is not fully automated.

Where a claim cannot be verified, leave the row alone and note it in the report
rather than flipping on trust.

---

## Phase 4: WRITE ROWS, AND PRUNE

Every edit is a **status plus a one-line note**. If the note wants a paragraph,
the paragraph goes in the spec chapter or the `docs/proposals/*` design doc that
already owns that design, and the note links to it. 81 of the existing bullets
already cite an SFEP — the design is recorded; the file should point, not
restate.

Then prune, in the same commit:

- **Superseded rows.** A row describing a limitation that has since been lifted
  is deleted, not annotated with a second paragraph saying it was lifted.
- **Historical narrative.** Per-change story ("this landed in #NNNN after we
  found…") belongs to the merged PR. Delete it.
- **Restated design.** A bullet that duplicates an SFEP it cites collapses to a
  status plus the link.
- **Dead follow-up lists.** Follow-up issue numbers that have since closed.

**The ratchet:** report the file's net line delta. A sweep that grows the file
needs a reason you can state in one sentence — a genuinely new surface area.
Absent that, a sweep should be flat or negative. Track it:

```bash
git diff --numstat origin/main -- docs/status.md
```

Update the header's `Reconciled at release <X>` marker. Do **not** add a list of
issue numbers — that line was a pure conflict generator with no reader value,
and git already knows what changed.

---

## Phase 5: COMMIT AND PR

Work on `claude/status-sweep-<version>` — this has no backing `SFN-<N>` issue,
so the branch carries **no `sfn-<N>` segment** (`CLAUDE.md`, Task tracking).
Branch per `/pickup` Phase 2: fetched `origin/main`, `--no-track`.

The PR body reports the window, the count of merged PRs examined versus rows
touched, the net line delta with its justification, and anything left unflipped
for want of verification.

---

## Phase 6: REPORT

- Window swept, and how many merged PRs it covered
- Rows flipped, added, deleted
- Net line delta (and the one-sentence reason if positive)
- Claims left unflipped because they could not be verified
- Anything that suggests a row is structurally wrong rather than stale — worth
  an issue rather than a note

---

## Constraints

- **This command is the only writer of `docs/status.md`.** If a feature PR
  changed it, that is a process regression worth reporting, not a merge to
  reconcile around.
- **Prune in the same commit as you write.** A sweep that only adds has
  reproduced the problem the sweep exists to fix.
- **Never flip a row to `Shipped` on a PR body's claim** — verify against the
  Stage1 bar, or leave it and say so.
- **Never restore the issue-number list to the header.**
- **Never let a note grow past a line.** Link the spec chapter or the SFEP.
