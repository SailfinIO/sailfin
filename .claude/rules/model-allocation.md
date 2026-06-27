Opus time is the scarce resource. This rule governs which model does which
work so the orchestrator spends Opus on judgment and Sonnet on labor — without
ever letting Sonnet orchestrate or write code unsupervised. Every workflow
(`/pickup`, `/add-feature`, `/debug-compile`, `/perf`, …) follows it.

## The principle: Opus is the brain and the gate; Sonnet is the hands and the eyes

Opus (the orchestrator + the hard-reasoning specialists) owns the work where a
wrong call is expensive and hard to detect:

- **Orchestration** — selecting issues, sequencing, scope decisions, approval
  gates. The session orchestrator (Sailbot, `model: inherit`) stays on whatever
  model you launched (Opus for `/pickup`). Sonnet never orchestrates.
- **Design** — `compiler-architect` (feature/refactor/non-trivial-fix design).
- **Diagnosis judgment** — `seed-stabilizer` (genuine miscompiles, IR errors,
  perf/memory regressions requiring deep IR analysis).
- **The review gate** — `code-reviewer` adjudicates correctness, self-hosting
  safety, and effect compliance on every diff before commit.

Sonnet (the workhorse specialists) owns work that is read-only, mechanical, or
executed against an Opus-authored spec that Opus then verifies:

- **Reading / tracing** — `compiler-explorer` maps surface area and explains
  internals. The orchestrator should *not* grep 20 files itself on Opus; dispatch
  the explorer and act on its map.
- **Implementation to spec** — `implementer` writes routine code (mechanical
  edits, clear-cut bug fixes, refactors, test additions) against a precise
  Opus-authored spec. Sonnet decides neither *what* to build nor whether it's
  correct; it types the change and the Opus reviewer gates it.
- **Running tests + first-pass failure triage** — `test-runner`.
- **Docs sync** — `docs-updater`.

## The supervision contract (why Sonnet-writes-code is safe)

Sonnet implementation is never unsupervised:

1. **Opus authors the spec** — exact files, symbols, change, and acceptance
   criteria. No spec → no Sonnet implementation; Opus implements it directly.
2. **Sonnet executes in scope only** — a new acceptance criterion, new public
   surface, or a different semantic unit than the spec names means the
   implementer *stops and reports*, never silently grows the diff.
3. **Opus gates the result** — `code-reviewer` (Opus) reviews every Sonnet diff
   for correctness/self-host/effects, and the orchestrator runs the self-host
   gate (`make compile`) and verifies acceptance criteria before commit.

Mechanical gates run *before* the Opus reviewer so Opus never spends tokens on
formatting or trivia: `sfn fmt --check` and `sfn check` (cheap, model-free) must
be green first; the Opus reviewer adjudicates only the subtle correctness and
self-hosting questions.

## Routing implementation: keep it on Opus vs. hand to Sonnet

Hand a slice to the `implementer` (Sonnet) when the change is **routine and the
spec is precise**: mechanical edits, a clear-cut bug fix with a known repro, a
localized refactor, adding regression tests to a known pattern.

Keep implementation on the Opus orchestrator when the change is **novel,
cross-cutting, or entangled with design**: it spans many pipeline stages with
non-obvious interactions, the correct shape is still being discovered while
coding, or a wrong edit would be subtle and costly. When in doubt on a
*correctness-sensitive* change, Opus implements; when in doubt on a *mechanical*
change, Sonnet implements and Opus reviews.

**Decompose before deciding — the keep-vs-delegate call is per *slice*, not per
issue.** Separate the subtle core from the mechanical periphery (test/fixture
adaptation, repetitive call-site edits, boilerplate). Keeping the
correctness-sensitive core on Opus does **not** mean keeping the mechanical
periphery too — hand those slices to the `implementer`, ideally **in parallel**
while you write the core. The common miss is making one whole-issue decision ("I'll
do this issue myself") when the issue is really a small subtle core plus a large
mechanical slice that should have been split off.

**Break-even test for keeping a slice on Opus:** if a spec precise enough to
delegate it would have to contain the implementation nearly *verbatim*, just write
it — the spec-authoring cost has met the implementation cost (this legitimizes
self-implementing a small, subtle function). But if the spec ("adapt
`X_test.sfn` to cover Y", "apply this rename across these call sites") is far
*smaller* than its output, that gap is the delegation win — give it to the
`implementer`. Apply the test per slice: a subtle 25-line core and a mechanical
190-line test from the same issue can land on different sides of it.

## Tiered escalation: don't wake Opus for trivia

A failing `make compile`/`make test` does **not** go straight to the Opus
`seed-stabilizer`. Route it through the Sonnet `test-runner` first to classify:

- **Trivial** (fmt error, missing import, obvious typo, a test that just needs
  updating) → fix on Sonnet (`implementer`) under the orchestrator's direction.
- **Genuine** (miscompilation, LLVM IR rejection, self-host break, perf/memory
  regression needing IR analysis) → escalate to the Opus `seed-stabilizer`.

Same shape for review: the cheap mechanical checks gate first; Opus only
adjudicates what they can't.

## What never changes

- The session orchestrator stays Opus for `/pickup` and friends — this rule
  redistributes *labor*, it does not demote orchestration to Sonnet.
- Every non-negotiable invariant (memory cap, self-hosting, formatting, scope
  discipline, branch/PR discipline) holds regardless of which model did the
  typing. The model that wrote a line never lowers the bar it must clear.
