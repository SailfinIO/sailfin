# Sailfin agent benchmark v2.5 bounded-pilot readout

Protocol: `sfn-agent-benchmark/v2.5.0`

Linear: [SFN-372](https://linear.app/sailfin/issue/SFN-372/experimentbench-run-fresh-v2-pilots-after-validity-fixes)

Decision: **confirmatory spend rejected under v2.5.0 before scored execution**.

## Frozen gate

All four validity blockers were Done and merged into the tested commit before
the run began. The independent-instance, Anthropic response-budget, Track A
structured-concurrency, and Track B structured-concurrency repairs are pinned
in the [v2.5 pilot manifest](results/sfn-372-v2.5.0/pilot-manifest.json).

The formatter, Sailfin check/build, frozen-instance validation, Sailfin and
Python stub smokes, timeout and response-invalidation fixtures, provider-auth
fixtures, TACIT online/offline oracle, packet budget/isomorphism checks, and
full Track A and Track B known-good/known-bad grader audits passed. Fresh
balanced schedules were generated for both model families: 129 Track A
attempts per family and 86 Track B attempts per family. No v2.1 observation
was selected, rerun, or pooled.

## Immediate stopping event

The unscored OpenAI schema probe passed against exact model ID
`gpt-5.6-terra`. The next gate, the unscored Anthropic schema probe against
`claude-sonnet-5`, returned provider error type `overloaded_error` with message
`Overloaded` and no model text.

Version 2.5 does not classify that response as its frozen
`transport_transient` category and defines no bounded provider retry. Retrying
manually would introduce a post-freeze, provider-specific policy. The run
therefore stopped before contamination probes, unscored arm tasks, or any
Track A or Track B scored request. [SFN-377](https://linear.app/sailfin/issue/SFN-377/fixbench-classify-and-retry-provider-overloads-symmetrically)
tracks the required symmetric retry policy and version bump.

## Track A — current adoption

There are no scored Track A observations under v2.5.0. The passing offline
grader audit and OpenAI schema probe establish setup evidence only; they do not
support a language, ecosystem, or adoption conclusion.

## Track B — intrinsic learnability

There are no scored Track B observations under v2.5.0. Track B was correctly
not started because the protocol orders provider setup, contamination, and
unscored authorization gates before either paid schedule.

## Published failure corpus

The checked-in [v2.5 result set](results/sfn-372-v2.5.0/) contains the frozen
pilot manifest, both schema-probe summaries, and the complete raw Anthropic
request/response pair. The raw response includes the provider request ID; no
credential or secret is present.

## Authorization decision

No confirmatory run is authorized. Neither track has a complete paired pilot,
and the Anthropic setup gate did not pass under the frozen policy. A corrected
run requires the protocol/corpus version bump and fresh balanced schedules
specified by SFN-377. No v2.5 setup result may be converted into a language
observation or pooled into that batch.

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
