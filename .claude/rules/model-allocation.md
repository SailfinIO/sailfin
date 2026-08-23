Opus time is the scarce resource. The orchestrator spends Opus on judgment and
Sonnet on labor — without ever letting Sonnet orchestrate or write code
unsupervised.

**Opus owns work where a wrong call is expensive and hard to detect:**
orchestration (sequencing, scope, approval gates — Sonnet never orchestrates),
design (`compiler-architect`), deep diagnosis (`seed-stabilizer`), and the review
gate (`code-reviewer`).

**Sonnet owns work that is read-only, mechanical, or executed against an
Opus-authored spec:** tracing and surface maps (`compiler-explorer` — don't grep
twenty files yourself on Opus), routine implementation (`implementer`), test runs
and first-pass triage (`test-runner`), docs sync (`docs-updater`).

**The supervision contract.** Opus authors the spec (exact files, symbols,
change, acceptance criteria — no spec means Opus implements it directly); Sonnet
executes in scope only and *stops and reports* rather than growing the diff; Opus
gates the result. Cheap model-free gates (`sfn fmt --check`, `sfn check`) run
*before* the Opus reviewer so Opus only adjudicates subtle correctness.

**Decompose before deciding — the keep-vs-delegate call is per *slice*, not per
issue.** Keeping a correctness-sensitive core on Opus does not mean keeping the
mechanical periphery too; hand those out in parallel while you write the core.
The common miss is one whole-issue decision when the issue is a small subtle core
plus a large mechanical slice.

**Break-even test.** If the spec precise enough to delegate a slice would contain
the implementation nearly verbatim, just write it. If the spec is far smaller
than its output, that gap is the delegation win.

**Cost control is model tier and scope — never a turn cap.** No agent
definition carries `maxTurns`. A cap cannot tell "finished cheaply" from "cut
off mid-edit": the subagent just stops, the orchestrator gets a truncated
report, and the work is re-spawned or absorbed onto Opus — costing more than
the cap saved. Sailfin agents need long tool chains (`sfn dev bootstrap build` alone is
many round-trips), so any defensible number sits above where a cap would help.
Bound cost with `model:`/`effort:` and a narrow spec instead, and rely on the
prompt's stop-and-report contract for early exit.

**Tiered escalation.** A failing build does not go straight to Opus. Route it
through `test-runner` to classify: trivial (fmt, missing import, a test needing
an update) → fix on Sonnet; genuine (miscompilation, IR rejection, self-host
break, perf/memory regression) → escalate to `seed-stabilizer`.

Every invariant holds regardless of which model did the typing. The model that
wrote a line never lowers the bar it must clear.
