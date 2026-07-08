# Pick Up the Next Issue

Autonomously query **Linear**, pick the highest-priority unblocked `Ready`
issue on the Sailfin (`SFN`) team, and drive it from branch creation through
PR open — flipping the Linear status as you go.

> **Linear is the planning source of truth.** Work items are native Linear
> `SFN-NNN` issues; there is no GitHub mirror for our own planned work. GitHub
> hosts the code and the PR. See `docs/conventions/linear-workflow.md` for the
> full model. Use the `mcp__Linear__*` tools for all issue state; use
> `mcp__github__*` / `git` for branches, commits, and PRs (there is no `gh`
> CLI in this environment).

## Target: $ARGUMENTS

If `$ARGUMENTS` is empty, pick the next available issue automatically.
If `$ARGUMENTS` is a Linear identifier (e.g. `SFN-142`), work that specific issue.

---

## Phase 1: SELECT AN ISSUE

Query open `Ready` issues on the Sailfin team:

```
mcp__Linear__list_issues team="Sailfin" state="Ready" limit=50
```

Filter out any issue that is:
- Assigned to someone else (`assignee` set to another user).
- Has an open **blocked-by** relation — fetch relations and confirm every
  blocker is `Done`/`Canceled`:
  ```
  mcp__Linear__get_issue id="SFN-<N>" includeRelations=true
  ```
  (A properly-groomed blocked issue sits in `Blocked`, not `Ready` — but
  verify, because a blocker may have re-opened.)

If `$ARGUMENTS` names an issue, fetch only that one and verify it is pickable
(`Ready`, unassigned or assigned to you, no open blocker):

```
mcp__Linear__get_issue id="SFN-<N>" includeRelations=true
```

**Priority order** (highest first):
1. **Linear priority** — Urgent (1), then High (2).
2. `type:bug` (bugs first)
3. `type:perf` (perf next — compounds future work)
4. Smallest **estimate** first within the same type (1 → 2 → 3)
5. Lowest `SFN-` number as tiebreaker (FIFO)

If no pickable issue exists, report: "No `Ready` SFN issues available. Run
`/triage` to audit the queue, or `/groom <epic>` to add work."

---

## Phase 1.5: VERIFY SEED FRESHNESS

If the issue body has a `## Required in pinned seed` section listing
predecessor PRs, verify each predecessor's merge commit is actually present in
the binary `make compile` uses — this catches the "merged but not seeded"
failure mode that broke the original #489 attempt. (`git` is available; use it.)

```bash
SEED_TAG="v$(cat .seed-version)"
git fetch --tags origin "$SEED_TAG" 2>/dev/null || git fetch --tags origin
git rev-parse --verify "${SEED_TAG}^{commit}" >/dev/null 2>&1 || {
  echo "Seed tag $SEED_TAG does not resolve — check .seed-version."; exit 1; }
```

For each predecessor PR `#P` in `## Required in pinned seed`, get its merge
commit (`mcp__github__pull_request_read` → `mergeCommit`) and check ancestry:

```bash
git merge-base --is-ancestor "$PR_MERGE" "$SEED_TAG"   # exit 0 ⇒ in seed
```

If ancestry fails, fall back to a **content check** before halting: SHA
ancestry produces a false negative when `main` was rebased/linearised between
the predecessor's merge and the seed cut (motivating example #499 / PR #703).
Confirm the predecessor's added files/symbols exist at `$SEED_TAG`
(`git cat-file -e "$SEED_TAG:<path>"`, or grep an expected symbol) — if they
do, proceed and record the fallback in the Phase 6 report. Only halt when
both the SHA check **and** the content check fail:

- Comment the pause on the Linear issue and stop (do **not** claim or branch):
  ```
  mcp__Linear__save_comment issueId="SFN-<N>" body="Pickup paused — predecessor #<P> is merged but not in the pinned seed (`$SEED_TAG`). Queue a cadence seed bump + `/pin-seed` before pickup. See `.claude/commands/pickup.md` Phase 1.5."
  ```
- Leave the issue in `Ready`; a later `/pickup` after the seed bump passes this gate.

Issues with no `## Required in pinned seed` section (most work — docs, tests of
shipped features, runtime experiments) skip this phase entirely.

---

## Phase 2: CLAIM AND BRANCH

Claim the issue in Linear and create the branch:

```
mcp__Linear__save_issue id="SFN-<N>" state="In Progress" assignee="me"
```

```bash
# Branch name embeds the Linear ID so Linear's GitHub integration auto-links
# the PR to the issue: claude/sfn-<N>-<slugified-title>
git checkout -b claude/sfn-<N>-<slug>
```

The `sfn-<N>` branch prefix is load-bearing — it is how Linear associates the
branch/PR with `SFN-<N>` and advances the issue on merge. Keep it lowercase.

Read the full issue body to extract Goal, Scope (In/Out), Acceptance criteria,
Files affected (advisory map), Verification commands, and Type (routes the
workflow). **If the body's `## Design` line cites an SFEP**
(`docs/proposals/NNNN-*.md`), read it as the design brief — the SFEP is the
durable *why*; the issue is the session-sized *what*. Don't re-derive design.

---

## Phase 3: DISPATCH TO WORKFLOW

Route by the issue's `type:*` label. Use the body (and any cited SFEP) as the
brief — don't redo design the architect already produced at grooming.

| Type | Workflow |
|---|---|
| `type:feature` | Follow `/add-feature` phases — skip the architect phase if the body already has a design (most groomed issues will). Implement → review → test → docs. |
| `type:bug` | Follow `/debug-compile` phases — body should already have a repro. Trace, fix, verify. |
| `type:perf` | Follow `/perf` phases — profile baseline, implement, bench after, verify. |
| `type:refactor` | Implement one self-hosting step at a time, spawn `code-reviewer`, run `test-runner`. |

### Model allocation: spend Opus on judgment, push labor to Sonnet

You (the orchestrator) run on Opus. Reserve yourself for decisions a wrong call
makes expensive — scope, sequencing, the review gate, genuine diagnosis — and
route the rest to Sonnet specialists per `.claude/rules/model-allocation.md`:

- **Surface mapping → `compiler-explorer` (sonnet).** Don't grep the tree
  yourself on Opus to re-derive each `In:` unit's surface; dispatch the explorer
  and apply the In/Out boundary to its map.
- **Routine implementation → `implementer` (sonnet), under your spec.** For
  mechanical edits, clear-cut bug fixes (known repro), localized refactors, and
  regression-test additions, author a precise spec and hand it off. Keep
  implementation on yourself only when the change is **novel, cross-cutting, or
  entangled with design**.
- **Review gate stays Opus.** Run the cheap mechanical checks first
  (`sfn fmt --check`, `sfn check <files>`), then spawn the Opus `code-reviewer`.
- **Failures triage on Sonnet first.** A failing `make compile`/`make test`
  goes to `test-runner` (sonnet) to classify: trivial (fmt, missing import,
  typo, stale test) → fix via `implementer`; genuine (miscompile, IR rejection,
  self-host break, perf/memory regression) → escalate to the Opus
  `seed-stabilizer`.

### Reconcile the advisory map, then check for real scope growth

A groomed issue's **contract** is its **Goal** plus the semantic `In:`/`Out:`
scope. `## Files Affected` is a **non-binding map**
(`docs/conventions/issue-naming.md`, "Intent-authoritative issues") that is
*expected to drift*. **Before** implementing, re-derive the current surface for
each `In:` unit — **dispatch `compiler-explorer` (sonnet)** — then compare its
file set against the advisory map and apply the **In/Out semantic boundary**:

- **In-scope — reconcile and proceed (do not pause):** a map path was
  renamed/moved (use the new one); an `In:` unit now spans additional sibling
  files in the same module (touch them all); a map file merged into a sibling
  already covered by the same unit (follow the content); the same public surface
  is reached through a refactored call path (follow it).
- **Out-of-scope — PAUSE, comment, do not proceed:** a **new acceptance
  criterion** is required; a **new public/user-facing surface** (CLI flag,
  exported symbol, diagnostic code) not implied by the Goal; the change must
  reach a **different semantic unit** than `In:` names; honoring `Out:` becomes
  impossible.

The discriminator: **does the Goal plus the semantic `In:`/`Out:` still hold?**
If yes, the drift is cosmetic — reconcile and record it in the PR (Phase 5 "Map
reconciliation"). If a new criterion or surface is required, that is real
growth — pause:

```
mcp__Linear__save_comment issueId="SFN-<N>" body="Scope adjustment needed: <reason>. Pausing for human input."
mcp__Linear__save_issue id="SFN-<N>" state="Triage"   # kick back to triage/grooming
```

Do not silently expand the *semantic* scope.

### When the blocker is a missing prerequisite (a seed dependency)

Sometimes the issue depends on a capability that does not exist yet (e.g. a
runtime issue needing a frontend primitive the compiler can't emit — the #1088
failure mode). Apply the shared **`.claude/rules/seed-dependency.md`** decision
tree (the same rule `/groom` uses):

- **Single consumer + tightly coupled → BUNDLE:** propose ONE cohesive PR that
  lands the prerequisite *and* the original issue together — no seed cut.
  (Default; usually faster than a multi-issue chain.)
- **Multiple consumers / independent / large blast radius → SPLIT:** file the
  predecessor as a standalone `seed-blocker` Linear issue; the consumer carries
  `## Required in pinned seed: #<predecessor-PR>` and queues against the next
  cadence seed bump.

Either way, **pause and present the bundle-vs-split choice to the user,
defaulting to bundle.**

---

## Phase 4: VERIFY ACCEPTANCE CRITERIA

Walk every acceptance criterion in the body. Each must pass before opening the PR:

```bash
make compile    # self-hosts
make test       # no regressions
# plus any issue-specific verification commands
```

Route a failing `make compile`/`make test` through `test-runner` (sonnet) to
classify before escalating; don't spend Opus on a formatting error. If a
criterion turns out impossible or wrong, comment on the Linear issue and pause
— do not declare done with unmet criteria.

---

## Phase 5: COMMIT AND PR

Commit the work:

```bash
git add <specific files>
git commit -m "$(cat <<'EOF'
<concise subject — what changed and why>

<body if needed>

Fixes SFN-<N>
EOF
)"
```

Push and open the PR with `mcp__github__create_pull_request`. Put the Linear
magic word in the PR body so the integration links and closes the issue on
merge:

```
## Summary
<1-3 bullets>

Fixes SFN-<N>

## Acceptance Criteria
<copy from the issue, all boxes checked>

## Map reconciliation
<advisory-map drift reconciled at pickup, or "None — map matched the tree">

## Verification
<commands run, with results>

## Files Changed
<short list>
```

Then move the issue to review and subscribe the session to the PR:

```
mcp__Linear__save_issue id="SFN-<N>" state="In Review"
```

- **Merge closes the issue.** Linear's GitHub integration advances `SFN-<N>`
  to `Done` when the PR (branch `claude/sfn-<N>-…`, body `Fixes SFN-<N>`)
  merges — don't set a terminal status by hand from the skill.
- After creating the PR, call `subscribe_pr_activity` so CI failures and review
  comments come back into the session.

**If this PR fully delivers the cited SFEP** (clears the Stage1 bar end-to-end
and self-hosts), advance it in the same PR: `/sfep graduate <N>`. If it's one
slice of a multi-issue SFEP, leave it `Accepted` and note remaining work.
Never mark an SFEP `Implemented` for "parsed but not enforced".

---

## Phase 6: REPORT

- Issue worked: SFN-<N> — <title>
- PR opened: <URL>
- Branch: `claude/sfn-<N>-<slug>`
- Verification results
- Seed freshness: if a predecessor was accepted via the Phase 1.5 content
  fallback (merge SHA orphaned but content present in the seed), note it — a
  human may want to know why the SHA fell out of seed ancestry.
- Anything that surprised you (worth recording for future grooming)

Surface any deferral or mid-flight scope adjustment explicitly.

---

## Constraints

- **Linear owns issue state.** Flip `state` via `mcp__Linear__save_issue`
  (`Ready` → `In Progress` on claim → `In Review` on PR). `Done` comes from the
  merge via Linear's integration — never write a terminal status from the skill.
- **The `claude/sfn-<N>-…` branch prefix is load-bearing.** It is how the PR
  auto-links to the Linear issue; keep it and put `Fixes SFN-<N>` in the PR body.
- **Never expand *semantic* scope silently.** A new acceptance criterion, new
  public surface, or a different `In:` unit means pause and ask. Cosmetic map
  drift is not scope growth — reconcile and proceed, recording it in the PR.
- **Never declare done with unchecked acceptance criteria.**
- **Never push to `main`.** Work on `claude/sfn-<N>-<slug>` and open a PR.
- The compiler self-caps memory (8 GiB on Linux); see `.claude/rules/compiler-safety.md`.
- **Never skip Phase 1.5** when the issue lists `## Required in pinned seed`.
- **One issue per session.** Issues were sized to be standalone; don't bundle
  (except a genuine seed prerequisite per the bundle rule above).
