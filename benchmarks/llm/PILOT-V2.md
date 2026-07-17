# Sailfin agent benchmark v2.6 bounded-pilot readout

Protocol: `sfn-agent-benchmark/v2.6.0`

Linear: [SFN-372](https://linear.app/sailfin/issue/SFN-372/experimentbench-run-fresh-v2-pilots-after-validity-fixes)

Decision: **confirmatory spend rejected under v2.6.0 after an Anthropic
response-budget invalidation**.

## Frozen gate

All four original validity blockers were Done and merged before the run began.
Version 2.6 additionally classifies overload, rate-limit, timeout, curl, and
service-unavailable responses as `transport_transient`; applies the same
three-attempt, 1,000/2,000 ms retry policy to every provider path; preserves
each request, response, and retry decision; and stops outside language
denominators only after retry exhaustion.

The formatter, Sailfin check/build, frozen-instance validation, Sailfin and
Python stub smokes, timeout and response-invalidation fixtures, provider-auth
fixtures, TACIT online/offline oracle, packet budget/isomorphism checks, and
full Track A and Track B known-good/known-bad grader audits passed. Fresh
balanced schedules were generated for both model families and then restricted
to the 40 frozen corpus instances, excluding the three historical seed-smoke
tasks. No v2.1 or v2.5 observation was selected, rerun, or pooled.

The first v2.6 attempt stopped on OpenAI quota before a balanced Track A run.
After quota restoration, both exact-model schema probes and fresh blinded
contamination probes passed; neither model family showed prior substantive
Rill-17 knowledge. All ten unscored authorization requests completed without a
provider/setup invalidation. Nine were one-shot green. Anthropic's Track A
Sailfin authorization task produced an ordinary semantic/runtime failure; this
was preserved as unscored setup evidence and did not trigger a stop.

## Track A — current adoption

The resumed OpenAI Track A schedule completed all 120 frozen observations with
no setup invalidation. Ordinary one-shot rates were Sailfin 69.4%, Scala 72.2%,
and Python 91.6%; solve rates were 94.4%, 100%, and 100%. Sailfin failed two
structured-concurrency instances after five iterations. All four Sailfin and
Scala capability traps fired; Python's declared static-rejection gap appeared
in all four traps. Python also exceeded the preregistered 90% useful-variance
ceiling, so these results cannot authorize confirmation or be reused in a
successor version.

The Anthropic Track A schedule preserved 76 observations before the immediate
stop. On Sailfin `structured-concurrency-002`, iteration 1 produced answer text
but failed semantically. The repair response then returned
`stop_reason=max_tokens` with 8,192 output tokens, 8,191 thinking tokens,
thinking-only content, and no answer text. The harness classified the attempt
as `provider_response_budget_exhausted`, excluded it from every language
denominator, marked the run invalid, and stopped the remaining scored schedule.
Partial Anthropic rates are audit-only and cannot be interpreted or pooled.

## Track B — intrinsic learnability

There are no scored Track B observations under v2.6.0. Track B was correctly
not purchased after the Anthropic Track A response-budget invalidation.

## Published failure corpus

The checked-in [v2.6 result set](results/sfn-372-v2.6.0/) preserves both v2.6
attempts. The `resume-*` artifacts contain the clean-source manifest, both
schema-probe summaries, reviewed contamination decision, OpenAI's complete
Track A run/summary/analysis/failure index, Anthropic's stopped Track A
run/summary/analysis/failure index, and the response-budget failure evidence.
No credential or secret is present. The prior
[v2.5 setup attempt](results/sfn-372-v2.5.0/) remains audit evidence only.

## Authorization decision

No confirmatory run is authorized. Track A is invalid and incomplete across
model families, OpenAI Python failed the useful-variance ceiling, and Track B
has no scored observations. SFN-383 must enforce actual Anthropic answer
headroom on every initial and repair response, bump the protocol/corpus minor
version, and freeze a successor before paid execution resumes. No v2.6
observation may be selected, rerun, or pooled into that batch.

---

# Historical record: Sailfin agent benchmark v2.1 bounded-pilot readout

Protocol: `sfn-agent-benchmark/v2.1.0`

Linear: [SFN-365](https://linear.app/sailfin/issue/SFN-365/experimentbench-run-bounded-v2-pilots-and-authorize-or-reject)

Decision: **confirmatory spend rejected under v2.1.0**.

## Correction to the v2.0 preflight

The initial v2.0 OpenAI schema probe used Chat Completions and returned an
insufficient-permissions error. That was a harness transport defect, not
evidence that the configured account or key lacked access to
`gpt-5.6-terra`: the same key and model succeeded through the Responses API.
No scored v2.0 observation was collected. Version 2.1 changes the current-model
OpenAI transport to Responses and records the selected API in the run manifest;
legacy OpenAI models retain the Chat Completions adapter.

## Gates and bounded sequence

The v2.1 offline graders, packet/isomorphism checks, timeout tests, manifest
checks, live provider schema probes, and blinded contamination probes passed
for both model families. Neither model recognized Rill-17. One unscored task
per arm and model family then completed successfully; the Anthropic Rill-17
smoke needed one ordinary repair iteration.

The OpenAI Track A schedule completed all 40 instances in all three arms (120
attempts). During the Anthropic Track A schedule, 13 attempts received one or
more valid HTTP responses whose entire 4,096-token allowance was consumed by
hidden thinking, with `stop_reason: max_tokens` and no answer text. Those
attempts were correctly excluded from language denominators, but the runner
continued instead of applying the protocol's immediate-stop rule. The
Anthropic schedule is therefore invalid and cannot be interpreted or pooled.

Track B was not started. The protocol orders Track A first and bars further
paid calls after a provider-response invalidation or failed useful-variance
gate.

## Track A — current adoption

The complete OpenAI family schedule produced these ordinary-task pilot
statistics:

| Arm | One-shot | Solved | Mean iterations to green | Varying templates |
|---|---:|---:|---:|---:|
| Sailfin | 72.2% | 88.8% | 1.19 | 3 |
| Scala | 77.7% | 100% | 1.25 | 3 |
| Python | 88.8% | 100% | 1.11 | 0 |

Sailfin's one-shot difference was -5.56 percentage points versus Scala (95%
cluster-bootstrap interval -25.00 to +13.89) and -16.67 points versus Python
(-30.56 to -2.78). Four Sailfin structured-concurrency instances remained red
after the repair budget. The Sailfin effect system fired on all four capability
traps, as did the Scala wrappers; Python fired on none, which is the
preregistered comparator limitation.

Those structured-concurrency observations are additionally ineligible as
concurrency evidence. The v2.1 Sailfin quick reference instructed models to use
nonexistent `nursery` syntax instead of the shipped `routine` scope, and the
grader checked output only, allowing sequential programs in every arm. They may
not be selected, rerun, or pooled into v2.5.0. This post-pilot validity finding
does not retroactively turn any failure or success into a language comparison.

These are directional observations about present-day adoption ergonomics for
the OpenAI family only. They are not a cross-family Track A conclusion. The
pilot also fails the preregistered useful-variance gate because Python has no
template containing both a one-shot pass and failure.

The Anthropic summary is published for audit only. Its apparent rates (Sailfin
53.3%, Scala 90.9%, Python 97.2%) use incomplete, unequal denominators after
provider-response invalidations and are not estimates. Scala and Python would
also exceed the 90% ceiling threshold.

## Track B — intrinsic learnability

There are no scored Track B observations, so this run supplies no evidence
about Sailfin-B versus Rill-17 intrinsic learnability. Passing packet,
isomorphism, contamination, and unscored smoke gates establishes setup
readiness only.

## Neither track

The v2.0 Chat endpoint mismatch and the v2.1 Sonnet thinking-budget exhaustion
are benchmark-setup evidence. They cannot enter either language denominator or
be converted into language, ecosystem, or product claims. SFN-367 tracks the
required response-budget, classification, and immediate-stop correction.

## Published failure corpus

The checked-in result set preserves both Track A manifests, summaries,
analyses, and every machine-classified failed attempt:

- [OpenAI Terra failures](results/sfn-365-v2.1.0/openai-terra-track-a-failures.json)
  (34 attempts, including repaired attempts)
- [Anthropic Sonnet failures](results/sfn-365-v2.1.0/anthropic-sonnet-track-a-failures.json)
  (39 attempts, including all 13 provider-response invalidations)

The sibling `run`, `summary`, and `analysis` JSON files record the frozen
configuration and aggregate results. Raw prompts, responses, emitted source,
tool output, and timing remain in the immutable local run directories under
`build/sfn365-v21-pilot-track-a-*/`; secrets are not present in the published
corpus.

## Authorization decision

No confirmatory run is authorized. Track A lacks a complete valid paired
schedule across both model families and fails useful variance; Track B was
correctly not purchased. Fixing the Sonnet response policy and task difficulty
requires a new protocol/corpus version and a fresh balanced batch. No selected
v2.1 success or failure may be rerun or pooled into that batch.
