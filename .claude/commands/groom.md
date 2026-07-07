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

### Don't over-decompose: bundle a capability with its single consumer (default)

**Bundling is the groom-time default, not a split-time afterthought.** When you
identify a compiler capability that is tightly coupled to exactly one consumer
that will be worked in the same session, **produce one issue** (one PR), not two.
Split only when the capability has **multiple consumers** that each justify
standalone shipping, or the work is **genuinely independent**. Any split that
creates a seed-cut gate for a single consumer must be **explicitly justified** in
the issue body — the default answer is bundle.

The full decision tree and the seed-cut-tax rationale live in the shared rule
**`.claude/rules/seed-dependency.md`** (cited by `/pickup` too, so both apply it
identically — design record SFEP-0026 WS-B). Apply that rule here rather than
re-deriving it. When a split is justified, follow "Seed dependencies" below:
label the predecessor `seed-blocker`, give the consumer
`## Required in pinned seed: #<predecessor>`, and queue the seed advance against
the next cadence bump rather than cutting reactively.

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

Create **only session-sized leaf issues** on GitHub — one per approved item.
The epic itself is **not** a GitHub issue: it is the Linear **Project** created
in the *Reflect in Linear* step below (`linear-workflow.md`). Do **not** open a
GitHub `Epic:` / `Tracking:` issue or apply the `epic` / `tracking` label — those
shapes are retired (`docs/conventions/issue-naming.md` § Title taxonomy).

Leaf titles follow `docs/conventions/issue-naming.md`: `<type>(<scope>):
<imperative verb phrase>` (Conventional Commit shape). Labels come from
`.github/labels.yml` (canonical registry); use lowercase prefixes (`type:bug`
not `bug`, `size:m` not `medium`).

```bash
gh issue create \
  --title "<title>" \
  --label "claude-ready,type:<type>,size:<size>" \
  --body "$(cat <<'EOF'
## Goal
<one sentence>

## Scope
**In:**
- <semantic unit of change — not a file path; e.g. "the effect-checker
  diagnostic emission for missing ![io]">

**Out:**
- ...

## Acceptance Criteria
- [ ] ...
- [ ] make compile passes
- [ ] make test passes

## Files Affected (advisory map — non-binding, expected to drift)
- compiler/src/... — ...   # likely-relevant starting points; non-exhaustive, no line numbers/counts

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

### Intent authoritative, file map advisory

A groomed issue's **contract** is its **Goal** plus a **semantic
`In:`/`Out:` scope**. The `## Files Affected` block is a **non-binding map** —
a navigation aid that is *expected to drift* and is reconciled at pickup, not
a checklist that gates correctness. This is the convention of record in
`docs/conventions/issue-naming.md` ("Intent-authoritative issues"); all four
issue-lifecycle commands cite it. When emitting an issue body:

- **Express `In:`/`Out:` as semantic units of change, not file paths.** Write
  "the effect-checker diagnostic emission for missing `![io]`", not
  "`effect_checker.sfn` lines X-Y". A new sibling file inside that unit (e.g.
  a split that moved diagnostic emission into `effect_checker/diagnostics.sfn`)
  is then **in scope by construction** — the unit, not the path, is the boundary.
- **Mark `## Files Affected` advisory** (the header reword above) and list paths
  as *likely-relevant starting points*, explicitly non-exhaustive.
- **Forbid line numbers anywhere** (`L142`, `~L100-135`) and **exact file
  counts** ("edit these 3 files", "two call sites") in any emitted body. Line
  numbers rot fastest; a count turns an in-unit Nth sibling into a phantom
  scope violation.

`/pickup` reconciles cosmetic map drift (a renamed path, an in-unit sibling)
and pauses only on **semantic** scope growth (a new acceptance criterion or new
public surface). Grooming a precise-but-brittle map only manufactures pickup
halts on entropy `/triage` would otherwise refresh.

Capture the issue numbers. After each `gh issue create`:

1. Set the GitHub native Type field to match the `type:*` label:
```bash
# Derive from the label: type:feature → Feature, type:bug → Bug, everything else → Task
.claude/scripts/set-issue-type.sh <new-issue-number> <Feature|Task|Bug>
```

The mapping from `type:*` label to GitHub Type:
- `type:feature` → `Feature`
- `type:bug` → `Bug`
- `type:refactor`, `type:perf`, `type:docs`, `type:tech-debt`, epics, tracking → `Task`

Then set up dependencies. For any issue that depends on a sibling that
hasn't merged yet, add the `blocked` label:

```bash
# For each issue blocked by an earlier one:
gh issue edit <N> --add-label "blocked"
# (and reference the blocker in the body — the gh CLI doesn't have native dependency support)
```

### Reflect in Linear

Once the GitHub issues exist, reflect the epic and its leaves into Linear per
`docs/conventions/issue-naming.md` § Reflecting state into Linear (best-effort —
skip with a one-line note if the Linear MCP tools aren't connected):

1. **Create or reuse the epic's Linear Project** under the correct initiative,
   named per § Linear structure & naming (concise Title-Case deliverable; no
   `Epic:` prefix or trailing `#N`/`SFEP-NNNN`), with `GitHub: #<epic>` and any
   `Design: SFEP-NNNN` placed in the project **description**, not the name.
2. **Assign each created leaf** to that Project and set its status from its
   labels. The mirror syncs in asynchronously — retry briefly, and let a later
   `/triage`/`/sweep` pass reconcile any leaf whose mirror hasn't appeared yet.
3. **Roll up the Project status** from its issues (any In Progress → `started`;
   else any Ready → `planned`; else `backlog`).

Never write a terminal (`Done`/`Canceled`) status — the leaves are open, and the
two-way sync would close them.

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

### Grouping: Linear Project for the epic; GitHub sub-issues only for leaf splits

Epic grouping is **not** a GitHub parent — it is the Linear **Project** the leaves
are associated to in the *Reflect in Linear* step below. Do not create a GitHub
`Epic:` parent to hang leaves off.

GitHub-native sub-issue nesting is still used in **one** case: when a single
session-sized leaf is split into smaller GitHub children (steps of one piece of
work). Attach each child as a sub-issue of its **leaf parent** — body references
alone do not populate the parent's "Sub-issues" panel. Use the REST API (the `gh`
CLI has no first-class command yet):

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

### Phased epics: one Linear Project per phase, groomed wave-by-wave

When an epic is **inherently multi-phase** — sequential phases where later phases
depend on earlier ones (e.g. SFEP-0027's Phase A → B → C → D, where B can't start
until A's modules land) — do **not** dump all leaves into one Project and groom
them in undocumented "waves." That is the structure that lost #351's Phase 3 (it
went 8/13-done with no sub-issues ever filed). Model the phases in Linear instead:

1. **One Linear Project per phase, all created up front** under the shared
   Initiative, named `<Epic> Phase <X> — <noun phrase>` (as the existing
   *Concurrency Maturity Phase 1 / Phase 2* Projects do). Give each future phase's
   Project a `Planned`/`Backlog` state and put its checklist + `Design: SFEP-NNNN`
   in the Project description. Leaves attach to the **current** phase's Project;
   future phases hold no leaves yet.
2. **Groom each phase's leaf issues wave-by-wave**, filing them (GitHub → Linear)
   into that phase's Project only when the wave is actually being opened. The empty
   next-phase Project is the visible *"groom me next"* card.

Why one-Project-per-phase (not one Project for the whole epic): a Project rolls up
its own issues' state. If every phase's leaves lived in a single Project, that
Project would read ~100% the moment Phase A's wave closed — hiding that B/C/D
aren't even groomed. Separate phase Projects keep each phase independently
plannable, focusable, and completable, and the Initiative view shows the phase
sequence at a glance. (`/sweep` Phase 2c still uses GitHub **leaf** sub-issue
rollups to recommend closing a leaf-parent — that is unchanged; it never closes a
Linear Project.)

**When NOT to use this:** a single-phase epic, or a flat bag of genuinely
independent issues with no phase ordering — one Project, leaves filed directly.
The per-phase Project structure is for *sequential, wave-groomed* phases only.

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
- **Title format follows `docs/conventions/issue-naming.md`** — Conventional Commit shape for leaf sub-tasks. Never open an `Epic:`/`Tracking:` GitHub issue or apply the `epic`/`tracking` label; epics are Linear Projects (see *Reflect in Linear*).
- **Don't create issues for work that's already in progress** — check `gh issue list` first to avoid duplicates.
- **When splitting one leaf into GitHub children, attach each child as a native sub-issue of its leaf parent** via the REST `/sub_issues` endpoint (epic grouping is the Linear Project, not a GitHub parent). Body cross-references do not populate the parent's Sub-issues panel. Use `-F sub_issue_id=<int>` (not `-f`) — the field must be typed.
- **Labels are the source of truth.** There is no derived board to sync.
- **Set the GitHub native Type field** with
  `.claude/scripts/set-issue-type.sh <N> <Feature|Task|Bug>` (best-effort; it
  self-skips when `gh` is unavailable). Derive the type from the `type:*` label:
  `type:feature` → `Feature`, `type:bug` → `Bug`, everything else → `Task`.
