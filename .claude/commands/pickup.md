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
Extract every `#N` reference. For each:

```bash
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

if [ "$ANCESTOR_FOUND" -eq 0 ]; then
  echo "Predecessor #$N (last checked merge $LAST_MERGE) is NOT in the pinned seed $SEED_TAG."
  echo "Cut a fresh seed before pickup:"
  echo "  gh workflow run release.yml --repo SailfinIO/sailfin --ref main \\"
  echo "    -f channel=alpha -f bump=prerelease"
  echo "Then /pin-seed once release-tag.yml uploads the binary."
  exit 1
fi
```

**Legacy fallback** for issues groomed before the
`## Required in pinned seed` section existed: if the issue does NOT
have that section but its `## Files Affected` lists anything under
`compiler/src/` or `runtime/prelude.sfn`, walk every `#N` in
`## Blocked by` through the same per-PR merge-base check above.

The legacy fallback only triggers when the section is **missing
entirely**. Issues groomed under the new contract include the
section even when it's empty (see `/groom` body skeleton), and an
empty section means "no seed dependency" — pickup proceeds.
If any blocker's merge commit is not an ancestor of the seed tag,
halt with the same diagnostic.

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

Mark the issue as in-progress, sync the project board, and create a branch:

```bash
# Claim it
gh issue edit <N> --add-label "in-progress" --remove-label "claude-ready"

# Move the card on the Sailfin Tracker (Project #4) to match.
# The helper derives the column from the current labels; with the edit
# above that resolves to "In progress".
.claude/scripts/sync-project-status.sh <N> --from-labels

# Branch name: claude/<N>-<slugified-title>
git checkout -b claude/<N>-<slug>
```

If the project sync exits non-zero, do not abort the pickup — note the drift
and surface it in the Phase 6 report so a human can reconcile.

Read the full issue body to extract:
- Goal
- Scope (in/out)
- Acceptance criteria
- Files affected
- Verification commands
- Type (determines workflow)

---

## Phase 3: DISPATCH TO WORKFLOW

Based on the issue's `type:*` label, follow the appropriate workflow. Use the issue body as the brief — don't redo the design work the architect already produced during grooming.

| Type | Workflow |
|---|---|
| `type:feature` | Follow `/add-feature` phases — but skip the architect phase if the issue body already has a design (most groomed issues will). Go straight to implementation, then review, test, docs. |
| `type:bug` | Follow `/debug-compile` phases — issue body should already have reproduction. Trace, fix, verify. |
| `type:perf` | Follow `/perf` phases — profile baseline, implement, bench after, verify. |
| `type:refactor` | Implement directly (one self-hosting step at a time), spawn `code-reviewer`, run `test-runner`. No architect needed if issue body has the plan. |

**During implementation, respect the Scope section.** If you discover the issue's `In:` scope is wrong (missing a needed file, or `Out:` is impossible to honor), STOP and comment on the issue:

```bash
gh issue comment <N> --body "Scope adjustment needed: <reason>. Pausing for human input."
```

Then mark the issue with `needs-grooming`, remove `in-progress`, and resync the
board so the card moves out of the "In progress" column:

```bash
gh issue edit <N> --add-label "needs-grooming" --remove-label "in-progress"
.claude/scripts/sync-project-status.sh <N> --from-labels
```

Do not silently expand scope.

---

## Phase 4: VERIFY ACCEPTANCE CRITERIA

Walk through every acceptance criterion in the issue body. Each must pass before opening the PR:

```bash
ulimit -v 8388608 && make compile    # self-hosts
ulimit -v 8388608 && make test       # no regressions
# plus any issue-specific verification commands
```

If any criterion fails, fix it. If a criterion turns out to be impossible or wrong, comment on the issue and pause for human input — do not declare done with unmet criteria.

---

## Phase 5: COMMIT AND PR

Commit the work:

```bash
git add <specific files>
git commit -m "$(cat <<'EOF'
<concise subject — what changed and why>

<body if needed — link issue with "Closes #N">

Closes #<N>

Co-Authored-By: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
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

## Verification
\`\`\`bash
<commands run, with results>
\`\`\`

## Files Changed
<short list>

🤖 Generated with [Claude Code](https://claude.com/claude-code)
EOF
)"
```

The merge will auto-close the linked issue.

---

## Phase 6: REPORT

Report to the user:
- Issue worked: #N — <title>
- PR opened: <URL>
- Branch: claude/<N>-<slug>
- Verification results
- Anything that surprised you during implementation (worth recording for future grooming)

If anything was deferred or scope was adjusted mid-flight, surface it explicitly.

---

## Constraints

- **Never expand scope silently.** If the issue's scope is wrong, pause and ask.
- **Never declare done with unchecked acceptance criteria.** If a criterion can't be met, comment and pause.
- **Never push to main directly.** Always work on the `claude/<N>-<slug>` branch and open a PR.
- **Always link the issue in the PR.** `Closes #N` ensures auto-close on merge.
- **Always apply `ulimit -v 8388608`** before running the compiler.
- **Never skip Phase 1.5.** The `## Required in pinned seed` precheck (and its legacy fallback) prevents the failure mode that broke the original #489 attempt — a compiler-source migration picked up against a seed that predated its dependency. If the precheck fails, halt and comment; do not attempt to triple-bootstrap a workaround binary.
- **One issue per session.** Don't try to bundle multiple issues — they were sized to be standalone.
- **Every label flip must be paired with a board sync.** Run
  `.claude/scripts/sync-project-status.sh <N> --from-labels` after any
  `gh issue edit ... --add-label/--remove-label` so the Sailfin Tracker
  board (Project #4) stays in sync with the labels.
