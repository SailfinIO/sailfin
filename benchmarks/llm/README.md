# Sailfin agent-language benchmark

The frozen two-track v2 preregistration lives in
[`PROTOCOL-V2.md`](PROTOCOL-V2.md). The bounded v2.6.0 attempts and their
OpenAI quota and Anthropic response-budget stops are recorded in
[`PILOT-V2.md`](PILOT-V2.md), followed by the historical v2.1.0 readout.
Version 2.6 freezes symmetric transient-provider retries after the v2.5 setup
attempt exposed missing overload handling. Version 2.7 revised the Sailfin-B
packet to teach shipped array and `sfn/strings` helpers (SFN-388), but its setup
stopped before scoring when `claude-sonnet-5` rejected manual thinking. Version
2.8 migrated to adaptive thinking and passed every setup and authorization
gate. OpenAI completed Track A, but Python exceeded the useful-variance ceiling;
Anthropic then exhausted all three overload retries on its fifth Track A
observation, so Track B was not purchased and confirmation was rejected. A
successor requires a task-difficulty review and a new corpus/protocol version.
No v2.1, v2.5, v2.6, v2.7, or v2.8 observation may be selected, rerun, or
pooled with a fresh balanced batch; SFN-439 tracks that redesign. In particular,
v2.1 structured-concurrency
observations are ineligible because the live Sailfin guidance named nonexistent
syntax and the grader accepted sequential output-equivalent programs. The
SFN-350 v1 decision protocol and pilot interpretation remain preserved in
[`EXPERIMENT.md`](EXPERIMENT.md) as historical evidence only. Do not reuse v1
paid outputs as v2 confirmatory data, and do not use the three seed tasks alone
to make a decision: they are an offline/pilot harness set, not the frozen
confirmatory benchmark.

This directory contains a native Sailfin benchmark harness for measuring how
well raw LLM APIs solve the same small programming tasks across language arms.
It replaces the adjacent Python prototype without checking Python harness code
into the compiler repository.

## Scope

The runner is intentionally separate from `benchmarks/runtime/` and
`sfn/bench`. Runtime benchmarks measure compiled-program performance; this
benchmark measures model ergonomics through an iterate-to-green grading loop.

The runner preserves three seed tasks as non-confirmatory smoke coverage:

- `logic-001-runlength`
- `io-001-sumfile`
- `trap-001-stable-hash`

The frozen confirmatory corpus adds 10 templates with four independently
allocated stable instances each (40 instances): two logic transformations,
CLI normalization, parsing, honest filesystem and loopback-HTTP capabilities,
structured concurrency, standard-package use, a local edit, and a
capability-leak trap. `corpus.json`
records IDs, categories, ordinary/trap membership, hidden-case counts, prompt
and hidden-fixture SHA-256 identities, and the predeclared 25% prompt-scaffold
token band. Startup validation rejects cumulative instance markers, duplicate
four-way fixture sets, and cross-instance mutation.

The default `stub` adapter returns canned solutions for offline plumbing tests.
Real runs use `openai` or `anthropic` through `curl` from native Sailfin.

Track B adds the packet-taught `sailfin-b` arm and the nonce `rill-17`
synthetic control. Rill-17 is an experimental control, not a product
competitor: its surface tokens are translated deterministically into the same
frozen Sailfin subset, so types, primitives, effects, execution, and graders
remain matched. Its only purpose is to reduce pretrained-language familiarity
in the controlled-learnability comparison.

## Build

```bash
build/bin/sfn check benchmarks/llm/sfn350.sfn
build/bin/sfn build -o build/sfn350 benchmarks/llm/sfn350.sfn
```

## Offline smoke

```bash
./build/sfn350 --adapter stub --arm sailfin --results-dir build/sfn350-smoke-sailfin
./build/sfn350 --adapter stub --arm python --results-dir build/sfn350-smoke-python
./build/sfn350 --self-test-analysis
./build/sfn350 --self-test-timeouts
benchmarks/llm/verify-provider-auth.sh
```

Validate Track B packet completeness, six-example limits, 1,800–2,200-token
normalized prose budgets, and the 5% matched-arm band before any provider call:

```bash
./build/sfn350 --track b --check-packets
./build/sfn350 --track b --adapter stub --verify-graders \
  --results-dir build/sfn350-track-b-grader-smoke
```

The packet hashes and versions are recorded in every Track B `run.json`.
Before showing either packet to a real model, capture the blinded recognition
probe and review its rubric:

```bash
./build/sfn350 --track b --adapter openai --model gpt-5.6-terra \
  --reasoning-effort medium --contamination-probe \
  --results-dir build/sfn350-track-b-probes
```

The generated report starts with `"cleared": false`. Set it to `true` only
after the blinded key confirms no exact or substantively correct prior Rill-17
knowledge, then point `SFN350_CONTAMINATION_REPORT` at that reviewed report.
Real Track B execution fails closed without it. Sailfin-B recognition is
recorded as residual familiarity but does not itself invalidate the run.

Fetch and verify the pinned TACIT comparator once, then the smoke can run with
the Scala compiler and library caches offline:

```bash
benchmarks/llm/tacit/fetch.sh
benchmarks/llm/tacit/verify.sh
SFN350_SCALA_OFFLINE=1 benchmarks/llm/tacit/verify.sh
```

Verify one known-good and one known-bad fixture per frozen template and arm:

```bash
./build/sfn350 --verify-graders --results-dir build/sfn350-grader-smoke
```

The verification result records Python's expected inability to statically
reject the capability trap rather than hiding that baseline gap. For the
structured-concurrency template, the known-good fixtures spawn and join work in
input order, while the known-bad fixtures are sequential but output-equivalent;
they must fail with `missing_concurrency` before semantic execution.

Results live under `build/.../run-<timestamp>/`. `run.json` pins provider and
toolchain identities and exact commands; `corpus.json` freezes task metadata;
`schedule.json` contains stable attempt IDs; `records.json`, `summary.json`, and
`analysis.json` retain scored observations; `failures.json` indexes every
failure artifact; and `blind-review/` exports sources plus a separate key.
Provider failures retain their raw request/response files and a classified
`provider-failure.json`. Authentication/permission and quota/billing failures
invalidate `run.json` and `analysis.json` and stop the remaining paid schedule;
the attempted observation remains in `records.json`.

Each failed grading iteration also writes `classification-N.json` with one
primary SFN-364 category, optional secondary causes, Track B attribution, and
language-denominator eligibility. The final record mirrors those fields.
Track A keeps compiler/runtime defects as user-visible adoption failures;
Track B excludes an implementation-defective paired instance across every arm
and reports the attribution separately. `blind-review/classifications.json`
contains no arm/model identity or automatic label for manual review;
`key.json` and `automatic-classifications.json` are separate audit artifacts.
The closed primary-category values are:
`pretrained_syntax_library_interference`, `rule_absent_from_materials`,
`rule_present_not_applied`, `invented_syntax_or_api`,
`correct_program_rejected`, `check_build_run_divergence`,
`compiler_crash_hang_or_ice`, `unhelpful_diagnostic_or_failed_repair`,
`missing_or_excessively_awkward_primitive`,
`ordinary_semantic_or_test_failure`, `capability_false_friction`, and
`provider_or_setup_invalidation`.

Track B ablations run separately from the frozen primary condition:

```bash
./build/sfn350 --track b --ablation examples --repeats 5 --dry-run
./build/sfn350 --track b --ablation diagnostics --repeats 5 --dry-run
./build/sfn350 --track b --ablation primitive --repeats 5 --dry-run
```

The seed and frozen attempt identity assign paired arms to balanced treatments.
`examples` compares the concise packet with matched expanded supplements;
`diagnostics` compares full repair text with a normalized phase-only message;
and `primitive` compares the packet primitive with a documented local
implementation. `schedule.json` records every assignment and completed runs
write `ablation.json`. Ablation runs set `primary_pool_eligible: false` and
cannot authorize Track B's primary decision. First-emission versus
compiler-guided repair remains directly observable through `iterations` and
the per-iteration classification artifacts.

## Real run

```bash
export OPENAI_API_KEY=...
./build/sfn350 --adapter openai --model gpt-5.6-terra \
  --reasoning-effort medium --arm sailfin --arm scala --arm python

export ANTHROPIC_API_KEY=...
./build/sfn350 --adapter anthropic --model claude-sonnet-5 --arm sailfin
```

Before a scored run, probe each configured adapter once without adding an
observation:

```bash
./build/sfn350 --adapter openai --model gpt-5.6-terra \
  --reasoning-effort medium --schema-probe
./build/sfn350 --adapter anthropic --model <frozen-id> --schema-probe
```

A schema probe validates only the configured request and response shape. It is
not an authorization gate for full task requests. The bounded paid three-arm
probe remains the authorization gate and must complete without a setup-class
provider failure before confirmatory observations are scheduled.

Schedule five balanced attempts per instance, arm, and model family without
making provider calls:

```bash
./build/sfn350 --adapter stub --model-family family-a --repeats 5 --dry-run
```

For a real run, pass the same frozen `--model-family`, `--repeats`, `--seed`,
arm set, and task set to each provider/model configuration. The analysis uses
paired ordinary observations, resamples frozen task clusters for 95% bootstrap
intervals, reports traps and false friction separately, and refuses to
authorize a decision below 100 paired ordinary observations per baseline. It
never declares GO or NO itself.

You can also place provider keys in a repo-local `.env` file or
`benchmarks/llm/.env`:

```dotenv
OPENAI_API_KEY=...
ANTHROPIC_API_KEY=...
```

Useful filters:

```bash
./build/sfn350 --adapter stub --task io-001-sumfile --arm sailfin
./build/sfn350 --adapter openai --model gpt-5.6-terra \
  --reasoning-effort medium --max-iters 3
```

Environment:

- `SAILFIN_BIN`: compiler binary used by the Sailfin arm. Defaults to
  `$PWD/build/bin/sfn`.
- `SFN350_TIMEOUT_CMD`: optional full command-prefix override for every generated
  compile and run command, for example `timeout 120`. The default is `timeout 60`
  (`gtimeout 60` on hosts where GNU timeout uses that name). Timeout expiry is
  recorded separately from compile/runtime errors, including empty stdout and
  stderr files plus a `.timeout` marker for the failed iteration.
- `OPENAI_API_KEY` / `ANTHROPIC_API_KEY`: required for real model adapters.
  The runner prefers shell environment values and falls back to `.env`, then
  `benchmarks/llm/.env`.
- `TACIT_LIBRARY_JAR`: optional path override for the verified TACIT 0.2.1
  library JAR. The default is `build/toolchains/tacit/0.2.1/TACIT-library.jar`.
- `SFN350_REPO_ROOT`: optional absolute repository root for launches outside
  the checkout root.

## Notes

The benchmark requires the isolated-working-directory resolver fix from
SFN-352 (`f073fb1f`). With that commit, generated bare-file submissions may use
bundled `sfn/*` helpers consistently from the repository root or task directory.

Confirmatory outputs must not be collected until the runner includes SFN-352
and both live schema probes have passed with exact model IDs frozen. Provider
failures remain observations; rerunning selected failures or deleting their
artifact directories invalidates the preregistered run.

The OpenAI adapter defaults to `gpt-5.6-terra` with reasoning effort `medium`.
GPT-5 requests use the Responses API with `max_output_tokens`,
`reasoning.effort`, and no temperature; explicitly selected legacy models use
Chat Completions with the older `max_tokens` plus temperature request shape.
The Anthropic adapter freezes Claude Sonnet 5 adaptive thinking with
`output_config.effort=medium`, an 8,192-token hard total-output ceiling, and no
claimed strict answer reservation; thinking-only budget exhaustion remains an
immediate provider-response invalidation.
Provider credentials are written only to a temporary header file for
the duration of each `curl` request and removed on shell exit rather than being
expanded into the child process argument list.
