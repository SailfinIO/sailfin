# Sailfin agent benchmark v2 bounded-pilot readout

Protocol: `sfn-agent-benchmark/v2.0.0`

Linear: [SFN-365](https://linear.app/sailfin/issue/SFN-365/experimentbench-run-bounded-v2-pilots-and-authorize-or-reject)

Repository commit at execution: `702109c8474458ebdebdac25984cb5ed9d053260`

Decision: **confirmatory spend rejected under v2.0.0**.

## Gate outcome

The 2026-07-15 bounded run passed the offline grader, packet, isomorphism,
timeout, provider-transport, and manifest gates. The first live request was the
required non-scored OpenAI schema probe for frozen model `gpt-5.6-terra` with
reasoning effort `medium`. The provider returned
`invalid_request_error: You have insufficient permissions for this operation.`

This is a provider authorization/setup invalidation. Section 6 of the frozen
protocol requires the affected batch to stop immediately and preserve the
failure. No Anthropic request, contamination probe, unscored task, Track A
observation, or Track B observation was scheduled after the failure. Human
interventions inside attempts were zero because no attempt began.

The sanitized complete provider exchange is published in
[`results/sfn-365-v2.0.0-provider-gate-failure.json`](results/sfn-365-v2.0.0-provider-gate-failure.json).
The local raw run directory remains under
`build/sfn365-provider-probes-openai/run-20260715-175033/` and is excluded from
version control with the rest of `build/`.

## Offline gate record

The following commands completed successfully before the provider call:

```bash
build/bin/sfn check benchmarks/llm/sfn350.sfn
build/bin/sfn build -o build/sfn350 benchmarks/llm/sfn350.sfn
./build/sfn350 --adapter stub --arm sailfin --results-dir build/sfn365-offline-smoke-sailfin
./build/sfn350 --adapter stub --arm python --results-dir build/sfn365-offline-smoke-python
./build/sfn350 --self-test-analysis
./build/sfn350 --self-test-timeouts
benchmarks/llm/verify-provider-auth.sh
./build/sfn350 --track b --check-packets
./build/sfn350 --track b --adapter stub --verify-graders --results-dir build/sfn365-track-b-grader-smoke
benchmarks/llm/tacit/fetch.sh
benchmarks/llm/tacit/verify.sh
SFN350_SCALA_OFFLINE=1 benchmarks/llm/tacit/verify.sh
./build/sfn350 --verify-graders --results-dir build/sfn365-grader-smoke
```

All 20 Track B template/arm pairs accepted their known-good fixture and
rejected their known-bad fixture. All 30 Track A template/arm pairs did the
same except the preregistered Python capability-trap gap: Python cannot
statically reject the unauthorized operation. This expected comparator limit
is recorded by the grader and is not a check/build/run divergence. TACIT 0.2.1
passed both connected-cache and forced-offline verification.

The live gate then failed on:

```bash
./build/sfn350 --adapter openai --model gpt-5.6-terra \
  --reasoning-effort medium --schema-probe \
  --results-dir build/sfn365-provider-probes-openai
```

## Evidence boundaries

### Track A — current adoption

No bounded-pilot observations were collected. The gate failure is not evidence
for or against Sailfin's present-day adoption readiness, relative success,
tooling ergonomics, or ecosystem position.

### Track B — intrinsic learnability

No contamination probe or bounded-pilot observation was collected. The gate
failure is not evidence for or against Sailfin-B's learnability relative to
Rill-17, packet completeness in a fresh model session, or intrinsic language
design.

### Neither track

The only live evidence is that the configured OpenAI account was not authorized
for the frozen `gpt-5.6-terra` schema probe at the time of execution. This is
evidence about experiment setup only. It cannot enter either language
denominator and cannot be converted into a technical or product claim.

## Authorization decision

The bounded-pilot authorization conditions were not met: the provider gate was
invalid, both paired schedules are empty, and neither track has a variance or
grader-stability result from real model output. No confirmatory call is
authorized under `sfn-agent-benchmark/v2.0.0`. Any future experiment must fix
provider authorization, apply the protocol's required version/change control,
and begin again with a fresh balanced batch; this invalid batch must never be
pooled with it.
