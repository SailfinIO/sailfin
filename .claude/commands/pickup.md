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

## Phase 2: CLAIM AND BRANCH

Mark the issue as in-progress and create a branch:

```bash
# Claim it
gh issue edit <N> --add-label "in-progress" --remove-label "claude-ready"

# Branch name: claude/<N>-<slugified-title>
git checkout -b claude/<N>-<slug>
```

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

Then mark the issue with `needs-grooming` and remove `in-progress`. Do not silently expand scope.

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
- **One issue per session.** Don't try to bundle multiple issues — they were sized to be standalone.
