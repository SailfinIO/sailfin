# SFN-350 LLM benchmark

This directory contains a native Sailfin benchmark harness for measuring how
well raw LLM APIs solve the same small programming tasks across language arms.
It replaces the adjacent Python prototype without checking Python harness code
into the compiler repository.

## Scope

The runner is intentionally separate from `benchmarks/runtime/` and
`sfn/bench`. Runtime benchmarks measure compiled-program performance; this
benchmark measures model ergonomics through an iterate-to-green grading loop.

The current runner ships three seed tasks:

- `logic-001-runlength`
- `io-001-sumfile`
- `trap-001-stable-hash`

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
```

Results are written under `build/.../run-<timestamp>/` as `records.json` and
`summary.json`.

## Real run

```bash
export OPENAI_API_KEY=...
./build/sfn350 --adapter openai --model gpt-4.1 --arm sailfin --arm python

export ANTHROPIC_API_KEY=...
./build/sfn350 --adapter anthropic --model claude-sonnet-4-20250514 --arm sailfin
```

Useful filters:

```bash
./build/sfn350 --adapter stub --task io-001-sumfile --arm sailfin
./build/sfn350 --adapter openai --model gpt-4.1 --max-iters 3
```

Environment:

- `SAILFIN_BIN`: compiler binary used by the Sailfin arm. Defaults to
  `$PWD/build/bin/sfn`.
- `SFN350_TIMEOUT_CMD`: optional command prefix for Sailfin compile and run
  commands, for example `timeout 60`.
- `OPENAI_API_KEY` / `ANTHROPIC_API_KEY`: required for real model adapters.

## Notes

The Sailfin starter snippets avoid `sfn/strings` imports in generated bare-file
submissions because today `sfn check` accepts them but `sfn run` can fail to
lower those imported helper calls from a bare benchmark file. Keep this in mind
when expanding the task set.
