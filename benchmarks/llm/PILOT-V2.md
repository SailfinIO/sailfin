# Sailfin agent benchmark v2.8 bounded-pilot readout

Protocol: `sfn-agent-benchmark/v2.8.0`

Linear: [SFN-437](https://linear.app/sailfin/issue/SFN-437/experimentbench-complete-clean-benchmark-against-sailfin-080-ga)

Decision: **reject confirmation and external-adoption spend under v2.8.0**.

## Frozen release and schedules

The evaluated compiler is the published Sailfin 0.8.0 macOS arm64 artifact:
tag `v0.8.0`, source commit
`604f377bcc32d2217734d4d9ede49003a88cdd54`, archive SHA-256
`91ff80b0b2119cbf0aba20b6da2f4a26e8c59d47c1092e41ae0aa627807d103d`,
and compiler SHA-256
`e963ae063c3c09ee58c64f571edb09852df3326b2ca685abc8485335254f491e`.
The v2.8 execution commit is
`461ed4439e066d6ec204bc02cc572730fa015938`, the protocol SHA-256 is
`c0f829c71987ad2bbbbd477771536f804c421cca49817ba7b4d4be77fceb9cd2`,
and the harness SHA-256 is
`b946ef01e87d0e73210043f1bc91e7420282131a3c7a2dfc2879d56da3b81b99`.

Seed `1040803689` froze all four schedules before the first scored request: 120
Track A and 80 Track B attempts per model family. Each schedule contains only
the 40 confirmatory instances; the three historical seed smokes are excluded.

## Gates completed

The released compiler checked and built the runner. All 40 independent
instances, Sailfin and Python stub executions, analysis/failure-taxonomy and
timeout fixtures, provider-auth fixtures, packet budgets, TACIT 0.2.1 online
and offline oracles, and the complete Track A and Track B grader audits passed.
Both exact-model schema probes and fresh pre-packet recognition probes passed.
Neither model family showed substantive prior Rill-17 knowledge. All ten
unscored authorization tasks completed without setup invalidation; nine were
one-shot green and Anthropic's Track A Sailfin smoke solved after one repair.

The initial fresh stub/grader audit inherited the repository-built 0.8.0
binary. After the scored stop, the complete Sailfin stub and both grader audits
were rerun explicitly against the published artifact and produced the same
grader-result hashes. Every authorization and scored Sailfin execution had
already used the published artifact. The post-stop audit strengthens the
failure package but does not rescue or expand the invalid run's claims.

## Track A — present-day adoption readiness

OpenAI completed all 120 frozen observations with no setup invalidation or
human intervention:

| Arm | One-shot | Solve by iteration 5 | Mean iterations to green |
| --- | ---: | ---: | ---: |
| Sailfin | 66.6% | 100% | 1.42 |
| Scala | 72.2% | 100% | 1.33 |
| Python | 91.6% | 100% | 1.11 |

The paired Sailfin-minus-Scala one-shot estimate is -5.6 percentage points
(95% task-cluster bootstrap interval -27.8 to +16.7). Sailfin-minus-Python is
-25.0 points (-41.7 to -11.1). Sailfin and Scala rejected all four capability
traps; Python rejected none, preserving the declared static-analysis gap.

These estimates are audit evidence, not a Track A decision. Python exceeded
the preregistered 90% useful-variance ceiling, and the second model family did
not complete. The protocol therefore requires a task-difficulty review and a
new corpus/protocol version before another bounded batch.

Anthropic preserved four successful observations, then stopped on
`logic-runlength-002` / Scala. All three allowed provider attempts returned
`overloaded_error: Overloaded`; the frozen 1,000 ms and 2,000 ms backoffs were
applied, retry exhaustion was excluded from language denominators, and the
remaining 115 Anthropic Track A attempts were not purchased. Selectively
rerunning that failure or pooling the partial family result is prohibited.

## Track B — controlled intrinsic learnability

Track B scored execution was correctly not started after the Track A stop.
Packet completeness, isomorphism, recognition clearance, authorization smokes,
and both 80-attempt schedules are preserved as setup evidence only. Intrinsic
learnability is unmeasured under v2.8.0.

## Usage and cost

Across schema, recognition, authorization, and scored requests, OpenAI used
122,582 input and 108,546 output tokens; Anthropic used 21,714 input and 12,251
output tokens. At the prices in effect on 2026-07-21 — OpenAI Terra $2.50/$15
per million input/output tokens and Claude Sonnet 5 introductory $2/$10 — the
estimated API cost is $1.934645 OpenAI plus $0.165938 Anthropic, $2.100583 in
total. No prompt-cache discount was observed. Pricing references:
[OpenAI Terra](https://developers.openai.com/api/docs/models/gpt-5.6-terra) and
[Claude Sonnet 5](https://platform.claude.com/docs/en/about-claude/models/whats-new-sonnet-5).

The completed OpenAI Track A records contain 2,103,380 ms of cumulative
attempt latency. Anthropic's four language observations plus the stopped
provider attempt contain 107,989 ms. These are summed per-attempt measurements,
not end-to-end wall-clock durations.

## Conclusions and investment decision

- **Real-world adoption readiness:** not established. OpenAI-family audit data
  places Sailfin near Scala on one-shot success and behind Python, but the
  family-paired run is invalid and incomplete.
- **Controlled intrinsic learnability:** unmeasured because Track B was not
  scored.
- **Further technical investment:** the result identifies no new Sailfin or
  harness correctness defect. Further benchmark work is justified only after
  an explicit task-difficulty/corpus redesign decision; larger confirmation is
  not authorized.
- **External adoption and business viability:** wholly unproven. No external
  adoption experiment or business conclusion is authorized by this batch.

The decision is **NO-GO on confirmatory spend and external-adoption testing**.
Any successor must use a new corpus/protocol version and a completely fresh
balanced batch; no v2.8 observation may be selected, rerun, or pooled. The
task-difficulty and corpus redesign is tracked by
[SFN-439](https://linear.app/sailfin/issue/SFN-439/specbench-redesign-v2-corpus-after-useful-variance-failure).

## Published evidence

The checked-in [v2.8 result set](results/sfn-437-v2.8.0/) preserves the release
and execution manifest, hashes for all schedules and grader audits, setup and
recognition evidence, the complete OpenAI Track A summary/analysis/failure
index, the partial Anthropic summary/analysis/failure index, all three raw
overload responses and retry decisions, verification commands, token/cost
accounting, and the final decision. No credential or secret is present.

---

# Sailfin agent benchmark v2.7 setup rejection

Protocol: `sfn-agent-benchmark/v2.7.0`

Linear: [SFN-437](https://linear.app/sailfin/issue/SFN-437/experimentbench-complete-clean-benchmark-against-sailfin-080-ga)

Decision: **stop at the setup gate and reject further v2.7 spend**.

## Frozen 0.8.0 release

The tested GA tag is `v0.8.0` at commit
`604f377bcc32d2217734d4d9ede49003a88cdd54`. The published macOS arm64
archive SHA-256 is
`91ff80b0b2119cbf0aba20b6da2f4a26e8c59d47c1092e41ae0aa627807d103d`;
the extracted `sfn` binary reports `sfn 0.8.0` and hashes to
`e963ae063c3c09ee58c64f571edb09852df3326b2ca685abc8485335254f491e`.
The v2.7 protocol and harness are byte-identical between the tag and the clean
execution commit `a396f2ba54b7653fa77d92404367a941770903c1`.

Every known SFN-372 validity fix was present in the GA tag before setup began:
isolated-workdir resolution, Track A and Track B structured-concurrency
grading, compiler-owned failure classification, symmetric provider retries,
Anthropic answer-headroom enforcement, and the Sailfin-B array/string packet.

## Gates completed

The released compiler checked and built the runner. All 40 independently
frozen instances, Sailfin and Python stub smokes, analysis/failure-taxonomy
fixtures, timeout fixtures, packet completeness and matched budgets, TACIT
0.2.1 online/offline oracles, and the complete known-good/known-bad Track A and
Track B grader audits passed. The provider-auth harness and exact-model schema
probes also completed before the blinded recognition stage.

OpenAI's pre-packet recognition probe completed with nonzero token usage.
`gpt-5.6-terra` called both blinded samples unknown and distinguished its
surface guesses from prior knowledge. That setup evidence is audit-only because
the paired gate stopped before clearance or packet exposure.

## Immediate stop

Both Anthropic recognition requests returned zero input and output tokens with
an `invalid_request_error`:

> `thinking.type.enabled` is not supported for this model. Use
> `thinking.type.adaptive` and `output_config.effort` to control thinking
> behavior.

The error occurred before either packet was shown and before any unscored
authorization or scored task. Continuing OpenAI alone would manufacture an
unpaired result, while changing the request inside this run would violate the
frozen request settings and require a new minor version. The batch therefore
stopped immediately with zero scored Track A observations and zero scored
Track B observations.

## Track conclusions and investment decision

- **Track A — real-world adoption readiness:** unmeasured under v2.7. No
  language, tooling, or ecosystem conclusion is authorized.
- **Track B — controlled intrinsic learnability:** unmeasured under v2.7. The
  OpenAI recognition response is setup evidence only.
- **Further technical investment:** narrowly justified to repair the benchmark
  transport and fail-closed probe behavior in SFN-438; this result does not
  justify or reject broader Sailfin implementation investment.
- **External adoption and business viability:** wholly unproven.

The decision is **NO-GO on confirmatory spend and external-adoption experiments
under v2.7.0**. SFN-438 must freeze a model-supported Anthropic effort/headroom
policy, make provider-error probes fail closed, bump the protocol and corpus
minor version, and pass fresh schema and recognition probes. SFN-437 may then
restart only with a completely fresh balanced batch; no v2.7 probe or future
observation may be selected, rerun, or pooled.

## Published failure corpus

The checked-in [v2.7 result set](results/sfn-437-v2.7.0/) records immutable
release and harness hashes, every completed gate, the raw Anthropic requests
and error responses, the audit-only OpenAI recognition review, zero-observation
analysis, and the blocking follow-up. No credential or secret is present.

---

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
