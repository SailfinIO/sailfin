# Groom a Roadmap Epic into Issues

Take a high-level roadmap item and decompose it into session-sized GitHub issues that Claude can pick up and complete autonomously.

## Target: $ARGUMENTS

The argument can be:
- A roadmap section name (e.g., "syntax reform", "compiler stabilization")
- A specific bullet from the [roadmap](https://sailfin.dev/roadmap) (e.g., "Implement await expression parsing")
- A document to mine for work items (e.g., `docs/proposals/0006-build-architecture.md`)
- A free-form description of work that needs breaking down

---

## Phase 1: UNDERSTAND THE EPIC

Read the relevant context:
- `site/src/pages/roadmap.astro` — find the epic and its surrounding priorities (published at [sailfin.dev/roadmap](https://sailfin.dev/roadmap))
- `docs/status.md` — current state of the affected feature(s)
- `site/src/content/docs/docs/reference/spec/` (chapter files §1–§11) — what the language commits to today; `.../reference/preview/` for planned features
- Any document referenced in the argument

Identify:
- What outcome this epic produces when fully done
- What's already partially in place
- What dependencies exist (must other epics complete first?)

---

## Phase 2: DECOMPOSE

Spawn the **compiler-architect** agent (Opus). Give it:
- The epic and its context
- The current compiler state (relevant files)
- The constraint: each output issue must be **session-sized** (XS/S/M, never L)

The architect produces an ordered list of issues. Each issue must:
- Have a clear, verifiable goal achievable in one session
- Touch a bounded set of files
- Be self-contained (or have explicit `Blocked by` dependencies on earlier issues)
- Include concrete acceptance criteria
- Map to one of: Feature, Bug, Performance, Refactor

If the architect produces any L-sized item, push back: "this needs further breakdown."

### Capture the epic's design as an SFEP

An epic with real design surface needs a durable **design record** so the
sub-issues don't each re-litigate the *why*, and so `/pickup` has a brief to
read. Before creating issues:

- **Check for an existing SFEP** for this epic (`grep` `docs/proposals/` and the
  registry `docs/proposals/README.md`). Many epics already have one (e.g. the
  effect-system, ownership, and test-infra epics).
- **If one exists**, the sub-issues reference it (see the `## Design` line in the
  body skeleton below); update its `tracking:` to list the epic + new issues.
- **If none exists and the epic embodies a substantive design** (a language,
  runtime/ABI, or toolchain decision — not just a bag of mechanical tasks), have
  the architect write it as an SFEP first (`/sfep new <slug>`, or it writes
  `docs/proposals/draft-<slug>.md` directly per `.claude/rules/proposals.md`).
  Accept it at the grooming gate (`/sfep status <slug-or-N> Accepted`) so the
  sub-issues can cite a numbered SFEP.
- **If the epic is purely mechanical** (no design decision — e.g. "migrate N call
  sites"), no SFEP is needed; the issues stand on their own.

Each sub-issue then **cites the SFEP rather than duplicating its design** — the
SFEP is the *why*, the issue is the *what to do this session*.

### Feasibility-probe FFI / "no frontend dependency" claims (gate)

Before any issue that touches `runtime/` or crosses the C-ABI / `extern fn`
boundary goes `claude-ready`, **probe the load-bearing feasibility claim** —
do not take "this is written against the extern layer the seed already
compiles / has no frontend dependency" on faith. The cheapest probe is a
throwaway `.sfn` snippet run through the current seed:

```bash
build/seed/bin/sailfin check /tmp/probe.sfn
build/seed/bin/sailfin emit -o /tmp/probe.ll llvm /tmp/probe.sfn
```

Confirm the construct the issue depends on can actually be **expressed and
emitted** (not silently dropped to `null` / elided). Runtime code that calls
a C API frequently needs a frontend capability that does not exist yet —
e.g. taking a function's address to pass as a `pthread_create` start routine
(the gap that broke the original #1088 pickup: its "no frontend dependency"
premise was false, and the missing primitive surfaced reactively mid-pickup
instead of as a planned predecessor). If the probe fails, the prerequisite
is a **frontend issue that must be groomed first** — make it an explicit
`Blocked by` / `Required in pinned seed` predecessor, not a surprise.

### Don't over-decompose: bundle a capability with its single consumer

Splitting is not free. Prefer **one issue/PR** for a compiler capability plus
its first consumer when they are tightly coupled and one agent will work them
together; only split when the work is genuinely independent **or** the
capability has multiple consumers that each justify standalone shipping.

The decisive sub-rule — **the seed-cut tax**: when a compiler-source change
(lowering / parsing / typecheck / intrinsics) and its runtime/consumer change
land as **separate releases**, the consumer cannot self-host until the
capability is in the **pinned seed** — forcing a seed cut + `/pin-seed`
between them (see "Seed dependencies" below). Bundling the capability and its
consumer in **one PR avoids the seed cut entirely**: `make compile` builds the
new compiler from the old seed, and that freshly-built compiler then compiles
the consumer that uses the new capability — all in one self-hosting pass. So
**splitting a capability away from its only consumer actively manufactures a
release cycle that bundling would not need.** Factor this into every split
decision: if a proposed split creates a seed-cut gate and there is a single
consumer, prefer bundling.

---

## Phase 3: REVIEW WITH USER

Present the proposed issue list as a table:

| # | Title | Type | Size | Blocked by |
|---|---|---|---|---|
| 1 | ... | Performance | S | — |
| 2 | ... | Refactor | M | #1 |

Wait for user approval. The user may:
- Approve as-is → proceed to Phase 4
- Request changes (drop, merge, split, reorder) → iterate with the architect
- Reject the breakdown entirely → ask what's wrong

---

## Phase 4: CREATE ISSUES

For each approved issue, create it via `gh`. Titles follow
`docs/conventions/issue-naming.md`:

- Sub-tasks: `<type>(<scope>): <imperative verb phrase>` (Conventional Commit shape).
- Epics: `Epic: <track-id>: <noun phrase>` — also apply the `epic` label.
- Tracking issues: `Tracking: <topic> (<YYYY-MM-DD>)` — also apply the `tracking` label.

Labels come from `.github/labels.yml` (canonical registry). Use lowercase
prefixes (`type:bug` not `bug`, `size:m` not `medium`).

```bash
gh issue create \
  --title "<title>" \
  --label "claude-ready,type:<type>,size:<size>" \
  --body "$(cat <<'EOF'
## Goal
<one sentence>

## Scope
**In:**
- ...

**Out:**
- ...

## Acceptance Criteria
- [ ] ...
- [ ] make compile passes
- [ ] make test passes

## Files Affected
- compiler/src/... — ...

## Verification
\`\`\`bash
timeout 60 build/native/sailfin run path/to/example.sfn
\`\`\`

## Size
<XS|S|M>

## Type
<Feature|Bug|Performance|Refactor>

## Blocked by
<#N or "None">

## Required in pinned seed
<#N or "None" — see "Seed dependencies" below for when to populate this>

## Design
<SFEP-NNNN (docs/proposals/NNNN-<slug>.md) — the design record this issue implements, or "None" for purely mechanical work>

## Context
<links to roadmap, code, prior PRs>
EOF
)"
```

**Always emit the `## Required in pinned seed` section**, even when the
value is `None`. `/pickup` Phase 1.5 treats a missing section as legacy
and falls back to walking `## Blocked by` against the seed tag — which
produces false-positive seed-cut requirements on routine work. An
explicit `None` value is the contract that says "no seed dependency."

Capture the issue numbers. After each `gh issue create`:

1. Sync the board so the new card lands in the correct column:
```bash
.claude/scripts/sync-project-status.sh <new-issue-number> --from-labels
```

2. Set the GitHub native Type field to match the `type:*` label:
```bash
# Derive from the label: type:feature → Feature, type:bug → Bug, everything else → Task
.claude/scripts/set-issue-type.sh <new-issue-number> <Feature|Task|Bug>
```

The mapping from `type:*` label to GitHub Type:
- `type:feature` → `Feature`
- `type:bug` → `Bug`
- `type:refactor`, `type:perf`, `type:docs`, `type:tech-debt`, epics, tracking → `Task`

Then set up dependencies. For any issue that depends on a sibling that
hasn't merged yet, add the `blocked` label and resync — the helper will
move that card from "Ready" into the "Blocked" column:

```bash
# For each issue blocked by an earlier one:
gh issue edit <N> --add-label "blocked"
# (and reference the blocker in the body — the gh CLI doesn't have native dependency support)
.claude/scripts/sync-project-status.sh <N> --from-labels   # → Blocked
```

If a sync call exits non-zero, capture the issue number and surface it in
the Phase 5 report so the human knows the board is out of sync.

### Seed dependencies

For each created issue, evaluate whether its predecessors must be **in the
pinned seed binary**, not just merged on `main`. The two states are
different — `make compile` runs against the binary at `.seed-version`, so
a dependency that's merged but not seeded will fail to self-host.

Apply this rule:

- If the issue touches `compiler/src/` or `runtime/prelude.sfn` AND its
  predecessor is a compiler-source change that affects the compiler
  binary's behaviour (lowering, parsing, type-checking, intrinsics,
  diagnostics, IR shape), the predecessor must be in the seed before
  this issue can self-host.

When that holds:

1. Fill in the `## Required in pinned seed` section of the issue body
   with the predecessor issue/PR number — separate from `## Blocked by`.
2. Apply the `seed-blocker` label to the **predecessor issue** (the
   one shipping the change, not the dependent one):

```bash
gh issue edit <predecessor> --add-label seed-blocker
.claude/scripts/sync-project-status.sh <predecessor> --from-labels
```

3. Note in the Phase 5 report that a seed cut + `/pin-seed` will be
   required between the predecessor's merge and pickup of this issue.

Examples:
- Slice E.2 (struct-field migration) requires Slice E.1 (`int`/`float`
  aliases) to be in the seed because the migration emits LLVM IR that
  relies on the new `int → i64` mapping. The previous E.2 attempt
  (#489) failed precisely because this gate was implicit instead of
  explicit.
- A new effect-checker pass that emits diagnostics requires the
  diagnostic-codes PR to be in the seed.
- A pure docs/test/runtime issue typically does NOT require a seed cut.

`/pickup` enforces the `## Required in pinned seed` contract via
`git merge-base --is-ancestor`. Skipping the section here means the
agent has decided the issue does not need a fresh seed; getting that
wrong is the failure mode this gate exists to prevent.

### Attach issues to the parent epic as native sub-issues

If the grooming target was an **existing epic issue** (e.g. `/groom 450`), every
created issue must be attached as a GitHub-native sub-issue of that epic — body
references alone do not populate the parent's "Sub-issues" panel and break the
roadmap UI. Use the REST API (the `gh` CLI has no first-class command yet):

```bash
# Look up the parent's internal node id (NOT the issue number) once:
PARENT=450
PARENT_ID=$(gh api repos/SailfinIO/sailfin/issues/$PARENT --jq '.id')

# For each created sub-issue, look up its id and attach it. The
# sub_issue_id field MUST be passed with -F (typed integer); -f sends a
# string and the API rejects it with a 422.
for n in 458 459 460 461 462 463; do
  child_id=$(gh api repos/SailfinIO/sailfin/issues/$n --jq '.id')
  gh api -X POST /repos/SailfinIO/sailfin/issues/$PARENT/sub_issues \
    -F sub_issue_id=$child_id --jq '.number'
done

# Verify the parent now lists every child:
gh api /repos/SailfinIO/sailfin/issues/$PARENT/sub_issues \
  --jq '.[] | "#\(.number) \(.title)"'
```

Skip this step only when the grooming target was a roadmap section, a free-form
prompt, or a document — i.e. when no parent epic issue exists.

---

## Phase 5: REPORT

Report to the user:
- Issue numbers created (with titles)
- The dependency graph (what blocks what)
- The recommended pickup order
- Any context the architect flagged that doesn't fit in an issue

Suggest: `/pickup` to start working the queue, or `/triage` to verify hygiene.

---

## Constraints

- **Never create L-sized issues.** If the architect can't break work into XS/S/M, the work is not yet ready.
- **Never create issues without acceptance criteria.** The criteria are the contract.
- **Always set the `claude-ready` label** on issues that are ready to pick up. Use `needs-grooming` for issues that exist as placeholders but need refinement.
- **Always set the `type:*` and `size:*` labels** so `/pickup` can filter correctly. Apply `area:*` labels when the touched subsystem is unambiguous.
- **Use only labels defined in `.github/labels.yml`** — never invent new ones in this command. If you think a new label is warranted, edit `labels.yml` in a separate PR first.
- **Title format follows `docs/conventions/issue-naming.md`** — Conventional Commit shape for sub-tasks, `Epic:` prefix for epics, `Tracking:` for trackers.
- **Don't create issues for work that's already in progress** — check `gh issue list` first to avoid duplicates.
- **When grooming an existing epic issue, attach every created issue as a native sub-issue of that epic** via the REST `/sub_issues` endpoint. Body cross-references do not populate the parent's Sub-issues panel and leave the roadmap UI incomplete. Use `-F sub_issue_id=<int>` (not `-f`) — the field must be typed.
- **Every created or relabeled issue must end Phase 4 with a board sync.** Run
  `.claude/scripts/sync-project-status.sh <N> --from-labels` after each
  `gh issue create` and after any follow-up `gh issue edit` that adds
  `blocked`. The Sailfin Tracker (Project #4) must reflect the labels.
- **Every created issue must have its GitHub native Type field set.** Run
  `.claude/scripts/set-issue-type.sh <N> <Feature|Task|Bug>` immediately after
  the board sync. Derive the type from the `type:*` label: `type:feature` →
  `Feature`, `type:bug` → `Bug`, everything else → `Task`.
