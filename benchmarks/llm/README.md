# SFN-350 LLM benchmark

The decision protocol and the latest pilot interpretation live in
[`EXPERIMENT.md`](EXPERIMENT.md). Do not use the three seed tasks alone to make
a GO/NO decision: they are an offline/pilot harness set, not the frozen
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

The frozen confirmatory corpus adds 10 templates with four stable instances
each (40 instances): two logic transformations, CLI normalization, parsing,
honest filesystem and loopback-HTTP capabilities, structured concurrency,
standard-package use, a local edit, and a capability-leak trap. `corpus.json`
records IDs, categories, ordinary/trap membership, hidden-case counts, and the
predeclared 25% prompt-scaffold token band.

The default `stub` adapter returns canned solutions for offline plumbing tests.
Real runs use `openai` or `anthropic` through `curl` from native Sailfin.

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
benchmarks/llm/verify-provider-auth.sh
```

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
reject the capability trap rather than hiding that baseline gap.

Results live under `build/.../run-<timestamp>/`. `run.json` pins provider and
toolchain identities and exact commands; `corpus.json` freezes task metadata;
`schedule.json` contains stable attempt IDs; `records.json`, `summary.json`, and
`analysis.json` retain scored observations; `failures.json` indexes every
failure artifact; and `blind-review/` exports sources plus a separate key.

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
- `SFN350_TIMEOUT_CMD`: optional command prefix for Sailfin compile and run
  commands, for example `timeout 60`.
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
GPT-5 requests use `max_completion_tokens` and omit temperature; explicitly
selected legacy models retain the older `max_tokens` plus temperature request
shape. Provider credentials are written only to a temporary header file for
the duration of each `curl` request and removed on shell exit rather than being
expanded into the child process argument list.
