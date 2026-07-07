# Pick Up the Next Issue

Autonomously query the issue tracker, pick the highest-priority unblocked issue, and drive it from branch creation through PR open.

## Target: $ARGUMENTS

If `$ARGUMENTS` is empty, pick the next available issue automatically.
If `$ARGUMENTS` is an issue number (e.g., `142`), work that specific issue.

---

## Phase 1: SELECT AN ISSUE

Query open `claude-ready` issues that aren't blocked or in-progress:

```bash
gh issue list \
  --label "claude-ready" \
  --state open \
  --json number,title,labels,assignees,body \
  --limit 50
```

Filter out:
- Issues with the `blocked` label
- Issues with the `in-progress` label
- Issues with any assignee (someone else is on it)
- Issues whose body lists open `Blocked by` issues that aren't closed

If `$ARGUMENTS` specifies an issue number, fetch only that one and verify it's pickable:
```bash
gh issue view <N> --json number,title,labels,assignees,body,state
```

**Priority order** (highest first):
1. `priority:critical` label
2. `priority:high` label
3. `type:bug` (bugs first)
4. `type:perf` (perf next — compounds future work)
5. Smallest `size:*` first within the same type (XS → S → M)
6. Lowest issue number as tiebreaker (FIFO)

If no pickable issue exists, report: "No claude-ready issues available. Run `/triage` to audit, or `/groom <epic>` to add work."

---

## Phase 1.5: VERIFY SEED FRESHNESS

Before claiming, verify every predecessor the issue lists in
`## Required in pinned seed` is actually present in the binary that
`make compile` will use. This catches the "merged but not seeded"
failure mode that broke the original #489 attempt.

```bash
SEED_TAG="v$(cat .seed-version)"
git fetch --tags origin "$SEED_TAG" 2>/dev/null || git fetch --tags origin

# Verify the seed tag actually resolves before any merge-base check.
# A typo in .seed-version or a missing remote tag should produce a
# clear diagnostic, not a low-signal `git merge-base` error.
if ! git rev-parse --verify "${SEED_TAG}^{commit}" >/dev/null 2>&1; then
  echo "Seed tag $SEED_TAG does not exist locally or on origin."
  echo "Verify .seed-version points at a valid published release tag."
  exit 1
fi
```

Parse the issue body for the `## Required in pinned seed` section.
Extract every `#N` reference. A reference MAY carry an optional inline
expectation of the form `#N (expect: <symbol> in <path>)` — e.g.
`#511 (expect: emit_runtime_call in compiler/src/llvm/expression_lowering/native/runtime_call.sfn)`.
Parse `<symbol>` and `<path>` when present; treat any form you can't
parse as a bare `#N` (back-compat — plain `#N` references stay valid).
The expectation is consumed only here, by the content-based fallback
below; `/groom` need not emit it.

For each predecessor:

```bash
# Per-predecessor expectation parsed from the section above; both empty
# when the reference is a bare `#N`. Consumed only by the content-based
# fallback (Probe 1) when SHA ancestry fails.
EXPECT_SYMBOL=""   # e.g. emit_runtime_call
EXPECT_PATH=""     # e.g. compiler/src/llvm/.../runtime_call.sfn

# Detect PR vs issue up front. `gh pr view <issue-number>` errors,
# while `gh issue view <pr-number>` succeeds but returns null
# closedByPullRequestsReferences. PR-first avoids both ambiguity
# and a wasted issue lookup when the dependency is already a PR.
if gh pr view "$N" --repo SailfinIO/sailfin --json number >/dev/null 2>&1; then
  PRS="$N"
else
  # Issue: collect EVERY closing PR. If multiple PRs closed the issue
  # (e.g. revert + reland, partial-fix sequence), the predecessor is
  # in the seed iff *any* of them is an ancestor of the seed tag.
  PRS=$(gh issue view "$N" --repo SailfinIO/sailfin \
         --json closedByPullRequestsReferences \
         --jq '.closedByPullRequestsReferences[]?
               | select(.isCrossRepository | not)
               | .number')
fi

if [ -z "$PRS" ]; then
  echo "Predecessor #$N has no merged PR — pickup blocked until it merges."
  exit 1
fi

ANCESTOR_FOUND=0
LAST_MERGE=""
for PR in $PRS; do
  PR_MERGE=$(gh pr view "$PR" --repo SailfinIO/sailfin \
              --json mergeCommit --jq '.mergeCommit.oid // empty')
  [ -z "$PR_MERGE" ] && continue
  LAST_MERGE="$PR_MERGE"
  if git merge-base --is-ancestor "$PR_MERGE" "$SEED_TAG" 2>/dev/null; then
    ANCESTOR_FOUND=1
    break
  fi
done

# --- Content-based fallback -------------------------------------------
# SHA ancestry is the fast happy path. It can yield a FALSE NEGATIVE
# when `main` is rebased/linearised between a predecessor's merge and
# the seed cut: the recorded merge SHA gets orphaned even though the
# predecessor's code is present in the seed tree (motivating example:
# #499 / PR #703 — see Context / Background). ONLY when SHA ancestry
# fails for EVERY candidate merge commit do we fall back to comparing
# the predecessor's content against the seed tree.
FALLBACK_NOTE=""
if [ "$ANCESTOR_FOUND" -eq 0 ]; then
  # Probe 1 — symbol match (opt-in, tightest). Honored only when the
  #   issue pinned `#N (expect: <symbol> in <path>)` for this predecessor.
  if [ -n "$EXPECT_SYMBOL" ] && [ -n "$EXPECT_PATH" ]; then
    if git show "$SEED_TAG:$EXPECT_PATH" 2>/dev/null | grep -q "$EXPECT_SYMBOL"; then
      ANCESTOR_FOUND=1
      FALLBACK_NOTE="content match: '$EXPECT_SYMBOL' present in $SEED_TAG:$EXPECT_PATH"
    else
      echo "Predecessor #$N: expected symbol '$EXPECT_SYMBOL' NOT found in $SEED_TAG:$EXPECT_PATH"
    fi
  fi

  # Probe 2 — path match (cheap, default). Every non-removed file any
  #   candidate PR touched must resolve at $SEED_TAG. Correct for the
  #   common additive predecessor (e.g. #511 adding runtime_call.sfn).
  if [ "$ANCESTOR_FOUND" -eq 0 ]; then
    for PR in $PRS; do
      FILES=$(gh api "repos/SailfinIO/sailfin/pulls/$PR/files" --paginate \
               --jq '.[] | select(.status != "removed") | .filename' 2>/dev/null)
      [ -z "$FILES" ] && continue
      ALL_PRESENT=1
      MISSING=""
      while IFS= read -r f; do
        [ -z "$f" ] && continue
        git cat-file -e "$SEED_TAG:$f" 2>/dev/null && continue
        ALL_PRESENT=0
        MISSING="$MISSING $f"
      done <<< "$FILES"
      if [ "$ALL_PRESENT" -eq 1 ]; then
        ANCESTOR_FOUND=1
        FALLBACK_NOTE="content match: all files from PR #$PR present at $SEED_TAG"
        break
      fi
      echo "Predecessor #$N (PR #$PR): files missing at $SEED_TAG:$MISSING"
    done
  fi

  if [ "$ANCESTOR_FOUND" -eq 1 ]; then
    echo "Predecessor #$N: merge SHA not an ancestor of $SEED_TAG, but $FALLBACK_NOTE."
    echo "Proceeding via content-based fallback — record this in the Phase 6 report."
  fi
fi

if [ "$ANCESTOR_FOUND" -eq 0 ]; then
  echo "Predecessor #$N (last checked merge $LAST_MERGE) is NOT in the pinned seed $SEED_TAG."
  echo "  (SHA ancestry failed AND the content-based fallback found missing files/symbols.)"
  echo "Cut a fresh seed before pickup:"
  echo "  gh workflow run release.yml --repo SailfinIO/sailfin --ref main \\"
  echo "    -f channel=alpha -f bump=prerelease"
  echo "Then /pin-seed once release-tag.yml uploads the binary."
  exit 1
fi
```

**Why the content-based fallback exists.** The SHA-ancestor check is
fast and correct on a stable history, but it produces a *false negative*
when `main` is rebased or linearised between a predecessor's merge and
the seed cut. The recorded merge SHA is then orphaned — not an ancestor
of the seed tag — even though the predecessor's code is sitting in the
seed tree. Motivating example (#499 / PR #703): predecessor #495
(PR #511) merged 2026-05-08 and is present in seed `v0.6.0` (cut
2026-05-19) — `compiler/src/llvm/expression_lowering/native/runtime_call.sfn`
exists at `v0.6.0` with `emit_runtime_call` exported — yet
`git merge-base --is-ancestor 00e10692 v0.6.0` reports false because the
original merge SHA was orphaned. The strict SHA check stays the happy
path; the content probes fire only after it fails for every candidate
merge commit, so happy-path performance is unchanged. Probe 1
(symbol) is the tightest and is opt-in via `#N (expect: <symbol> in
<path>)`; Probe 2 (path) is the cheap default that covers additive
predecessors. A predecessor whose content is *genuinely* absent
(added file missing at `$SEED_TAG`, or expected symbol not found) still
halts with the original diagnostic.

**Legacy fallback** for issues groomed before the
`## Required in pinned seed` section existed: if the issue does NOT
have that section but its `## Files Affected` lists anything under
`compiler/src/` or `runtime/prelude.sfn`, walk every `#N` in
`## Blocked by` through the same per-PR merge-base check above.

The legacy fallback only triggers when the section is **missing
entirely**. Issues groomed under the new contract include the
section even when it's empty (see `/groom` body skeleton), and an
empty section means "no seed dependency" — pickup proceeds.
Apply the **same SHA-then-content check** to each `## Blocked by`
blocker: try `git merge-base --is-ancestor` first, and only when that
fails for every candidate merge commit, run the content-based fallback
(Probes 1 & 2 above) before halting. The orphaned-SHA false negative
applies identically to legacy issues, so a blocker whose code is in the
seed tree must not block pickup just because its merge SHA was rebased
away. Legacy `## Blocked by` references are bare `#N` (no `(expect: …)`
expectation), so legacy blockers rely on the path-based Probe 2.
If a blocker fails both the SHA check and the content fallback, halt
with the same diagnostic.

If the precheck fails, comment on the issue and stop — do NOT claim
or branch:

```bash
gh issue comment <N> --body "Pickup paused — predecessor #<P> is merged but not in the pinned seed (\`$SEED_TAG\`). Cut a new alpha and \`/pin-seed\` before pickup. See \`.claude/commands/pickup.md\` Phase 1.5."
```

The issue stays `claude-ready`; another `/pickup` attempt after the
seed is bumped will pass this gate.

If the precheck passes (every required predecessor is in the seed),
proceed to Phase 2.

---

## Phase 2: CLAIM AND BRANCH

Mark the issue as in-progress and create a branch:

```bash
# Claim it
gh issue edit <N> --add-label "in-progress" --remove-label "claude-ready"

# Branch name: claude/<N>-<slugified-title>
git checkout -b claude/<N>-<slug>
```

Then **reflect the claim into Linear** per `docs/conventions/issue-naming.md`
§ Reflecting state into Linear: set the issue's mirror to `In Progress` and roll
up its Project to `started`. Best-effort — skip with a note if the Linear MCP
tools aren't connected. (The eventual `Closes #N` merge closes the GitHub issue,
which the two-way sync propagates to `Done` on its own — don't set it here.)

Read the full issue body to extract:
- Goal
- Scope (in/out)
- Acceptance criteria
- Files affected
- Verification commands
- Type (determines workflow)

---

## Phase 3: DISPATCH TO WORKFLOW

Based on the issue's `type:*` label, follow the appropriate workflow. Use the issue body as the brief — don't redo the design work the architect already produced during grooming. **If the body's `## Design` line cites an SFEP** (`docs/proposals/NNNN-*.md`), read it for the full design rationale — the SFEP is the durable record (the *why*); the issue is the session-sized slice (the *what to do now*). Do not duplicate or re-derive the design.

| Type | Workflow |
|---|---|
| `type:feature` | Follow `/add-feature` phases — but skip the architect phase if the issue body already has a design (most groomed issues will). Go straight to implementation, then review, test, docs. |
| `type:bug` | Follow `/debug-compile` phases — issue body should already have reproduction. Trace, fix, verify. |
| `type:perf` | Follow `/perf` phases — profile baseline, implement, bench after, verify. |
| `type:refactor` | Implement (one self-hosting step at a time), spawn `code-reviewer`, run `test-runner`. No architect needed if issue body has the plan. |

### Model allocation: spend Opus on judgment, push labor to Sonnet

You (the orchestrator) run on Opus. Reserve yourself for the decisions a wrong
call makes expensive — scope, sequencing, the review gate, genuine diagnosis —
and route the rest to Sonnet specialists per `.claude/rules/model-allocation.md`:

- **Surface mapping → `compiler-explorer` (sonnet).** Do not grep the tree
  yourself on Opus to re-derive each `In:` unit's surface (next section).
  Dispatch the explorer with the `In:` units and let it return the current file
  set; you apply the In/Out boundary to its map.
- **Routine implementation → `implementer` (sonnet), under your spec.** For
  mechanical edits, clear-cut bug fixes (known repro), localized refactors, and
  regression-test additions, author a precise spec (exact files, symbols, change,
  acceptance criteria) and hand it to the `implementer`. Keep implementation on
  yourself (Opus) only when the change is **novel, cross-cutting, or entangled
  with design** — where a subtle wrong edit is costly. When in doubt on a
  correctness-sensitive change, implement it yourself; on a mechanical change,
  delegate and review.
- **Review gate stays Opus.** Run the cheap mechanical checks first
  (`sfn fmt --check`, `sfn check <files>`) so they're green before you spend
  Opus, then spawn the Opus `code-reviewer` to adjudicate correctness,
  self-hosting safety, and effects on the diff — whoever typed it.
- **Failures triage on Sonnet first.** A failing `make compile`/`make test` goes
  to the `test-runner` (sonnet) to classify: trivial (fmt, missing import, typo,
  stale test) → fix via the `implementer`; genuine (miscompile, IR rejection,
  self-host break, perf/memory regression) → escalate to the Opus
  `seed-stabilizer`. Don't wake Opus for a formatting error.

### Reconcile the advisory map, then check for real scope growth

A groomed issue's **contract** is its **Goal** plus the semantic `In:`/`Out:`
scope. `## Files Affected` is a **non-binding map** (`docs/conventions/issue-naming.md`,
"Intent-authoritative issues") that is *expected to drift* between grooming and
pickup. **Before** implementing, re-derive the current surface for each `In:`
unit — **dispatch `compiler-explorer` (sonnet)** with the `In:` units rather than
grepping the tree yourself on Opus — then compare its returned file set against
the advisory map and apply the **In/Out semantic boundary contract**:

- **In-scope — reconcile and proceed (do not pause):**
  - A path in `## Files Affected` was **renamed/moved** → use the new path.
  - A semantic unit named in `In:` is now spread across **additional sibling
    files** in the same module/directory → touch them all.
  - A map file **no longer exists** because its content merged into a sibling
    already covered by the same `In:` unit → follow the content.
  - The **same public surface** is reached through a refactored internal call
    path → follow it.
- **Out-of-scope — PAUSE, comment, do not proceed:**
  - A **new acceptance criterion** the issue did not list is required.
  - A **new public/user-facing surface** (new CLI flag, exported symbol,
    diagnostic code) not implied by the Goal.
  - The change must reach a **different semantic unit** than `In:` names (e.g.
    the issue is scoped to the effect checker but the fix belongs in the parser).
  - Honoring `Out:` becomes **impossible**.

The discriminator is one question: **does the Goal plus the semantic
`In:`/`Out:` still hold?** If yes, the drift is cosmetic — **reconcile and
record it in the PR** (the Phase 5 "Map reconciliation" line); never halt on a
renamed or missing map path. If a *new* criterion or surface is required, that is
real scope growth — pause per the guard below.

**During implementation, the semantic scope is the line.** If the work genuinely
needs a **new acceptance criterion or new public surface** (real growth, per the
Out-of-scope list above), or `Out:` is **impossible** to honor, STOP and comment
on the issue:

```bash
gh issue comment <N> --body "Scope adjustment needed: <reason>. Pausing for human input."
```

Then mark the issue with `needs-grooming` and remove `in-progress`:

```bash
gh issue edit <N> --add-label "needs-grooming" --remove-label "in-progress"
```

Do not silently expand the *semantic* scope. A renamed/moved/merged map path or
an in-unit sibling is **not** scope growth — reconcile it and keep going.

**When the blocker is a missing _prerequisite_ (not just a wrong scope line).**
Sometimes the issue isn't mis-scoped — it depends on a capability that does
not exist yet (e.g. a runtime issue that needs a frontend primitive the
compiler can't emit). Before defaulting to a multi-issue chain (file a
predecessor → groom → separate PR → seed cut → re-pickup), apply the shared
**`.claude/rules/seed-dependency.md`** decision tree (the same rule `/groom`
uses — design record SFEP-0026 WS-B). Do not re-derive the tree here; the rule
is the source of truth. The mid-pickup outcomes it dictates:

- **Single consumer + tightly coupled → BUNDLE:** propose ONE cohesive PR that
  lands the prerequisite *and* the original issue together. `make compile`
  builds the new compiler from the old seed, and that compiler compiles the
  consumer in the same self-host pass — so bundling avoids the seed cut a split
  would force. This is the default and is usually faster than the
  file/groom/PR/seed/re-pickup ceremony.
- **Multiple consumers, or genuinely independent, or large blast radius →
  SPLIT:** file the predecessor as a standalone `seed-blocker` issue. **A split
  forces a seed cut — do NOT cut reactively. Queue the seed advance against the
  next cadence bump** (SFEP-0026 WS-C); the consumer carries
  `## Required in pinned seed: #<predecessor>` and waits for that bump.

Either way, **pause and present the bundle-vs-split choice to the user,
defaulting to bundle** — do not silently pick the heavier multi-issue route. The
original #1088 pickup fanned out into separate issues/PRs + a seed-cut gate when
one bundled PR would have delivered the same result with less overhead. State the
tradeoff; let the user decide.

---

## Phase 4: VERIFY ACCEPTANCE CRITERIA

Walk through every acceptance criterion in the issue body. Each must pass before opening the PR:

```bash
make compile    # self-hosts
make test       # no regressions
# plus any issue-specific verification commands
```

If any criterion fails, fix it — but triage before escalating. Route a failing
`make compile`/`make test` through the Sonnet `test-runner` to classify: trivial
(fmt, missing import, typo, stale test) → fix via the `implementer`; genuine
(miscompile, IR rejection, self-host break, perf/memory regression) → escalate to
the Opus `seed-stabilizer`. Don't spend Opus diagnosing a formatting error.

If a criterion turns out to be impossible or wrong, comment on the issue and pause for human input — do not declare done with unmet criteria.

---

## Phase 5: COMMIT AND PR

Commit the work:

```bash
git add <specific files>
git commit -m "$(cat <<'EOF'
<concise subject — what changed and why>

<body if needed — link issue with "Closes #N">

Closes #<N>
EOF
)"
```

Push and open the PR:

```bash
git push -u origin claude/<N>-<slug>

gh pr create \
  --title "<short title — under 70 chars>" \
  --body "$(cat <<'EOF'
## Summary
<1-3 bullets>

Closes #<N>

## Acceptance Criteria
<copy from issue, with all boxes checked>

## Map reconciliation
<advisory-map drift reconciled at pickup, or "None — map matched the tree".
e.g. "`old/path.sfn` → `new/path.sfn` (renamed); added sibling `x.sfn` (same In: unit)">

## Verification
\`\`\`bash
<commands run, with results>
\`\`\`

## Files Changed
<short list>
EOF
)"
```

The merge will auto-close the linked issue.

**If this PR fully delivers the cited SFEP** (the feature now clears the Stage1
bar end-to-end and self-hosts), advance the SFEP in the same PR: `/sfep graduate
<N>` to flip it to `Implemented`, set `graduates-to`, and sync the registry. If
the PR only implements one slice of a multi-issue SFEP, leave the SFEP
`Accepted` and note remaining work in the Phase 6 report. Never mark an SFEP
`Implemented` for "parsed but not enforced".

---

## Phase 6: REPORT

Report to the user:
- Issue worked: #N — <title>
- PR opened: <URL>
- Branch: claude/<N>-<slug>
- Verification results
- Seed freshness: if any predecessor was accepted via the Phase 1.5
  content-based fallback (merge SHA orphaned but content present in the
  seed), note it explicitly with the probe used (`$FALLBACK_NOTE`) — a
  human may want to investigate why the SHA fell out of seed ancestry.
- Anything that surprised you during implementation (worth recording for future grooming)

If anything was deferred or scope was adjusted mid-flight, surface it explicitly.

---

## Constraints

- **Never expand *semantic* scope silently.** A new acceptance criterion, new
  public surface, or a different `In:` unit means pause and ask. Cosmetic map
  drift (a renamed/moved/merged path, an in-unit sibling) is **not** scope
  growth — reconcile it and proceed.
- **Always record map reconciliation, never silently.** When the advisory
  `## Files Affected` map drifted from the tree, capture the reconciliation in
  the PR body's "Map reconciliation" line so the drift is visible and auditable.
- **Never declare done with unchecked acceptance criteria.** If a criterion can't be met, comment and pause.
- **Never push to main directly.** Always work on the `claude/<N>-<slug>` branch and open a PR.
- **Always link the issue in the PR.** `Closes #N` ensures auto-close on merge.
- The compiler self-caps memory (8 GiB on Linux); see `.claude/rules/compiler-safety.md`.
- **Never skip Phase 1.5.** The `## Required in pinned seed` precheck (and its legacy fallback) prevents the failure mode that broke the original #489 attempt — a compiler-source migration picked up against a seed that predated its dependency. If the precheck fails, halt and comment; do not attempt to triple-bootstrap a workaround binary.
- **One issue per session.** Don't try to bundle multiple issues — they were sized to be standalone.
- Labels are the source of truth; there is no separate board to sync.
