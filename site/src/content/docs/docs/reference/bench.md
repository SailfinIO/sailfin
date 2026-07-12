---
title: Benchmarking
description: Reference for the sfn bench command, its compiler and runtime modes, the sfn/bench harness capsule, and the sailfin.bench/v1 JSON output.
section: reference
sidebar:
  order: 7
---

## Overview

`sfn bench` is the native benchmarking command. It has two modes:

- **Compiler mode** (`sfn bench --compiler`) measures how fast the compiler
  emits IR — per-module compile time and peak memory across the
  `compiler/src/**.sfn` tree.
- **Runtime mode** (`sfn bench [<path>...]`, the default) measures how fast
  **compiled Sailfin programs run** — it discovers, builds, and times
  `*_bench.sfn` workloads written against the [`sfn/bench`](#the-sfnbench-capsule)
  harness capsule.

Both modes share a table renderer, a CSV writer, budget gates, and a
`--json` envelope ([`sailfin.bench/v1`](#json-output)). The command replaces the
retired compile-time and runtime bench shell scripts; `make bench` and
`make bench-runtime` are now thin wrappers over it.

Mode selection is by the `--compiler` flag: present → compiler mode; absent →
runtime mode.

```bash
sfn bench --compiler          # per-module compiler emit timing + memory
sfn bench                     # runtime workloads under benchmarks/runtime
sfn bench path/to/workloads   # runtime workloads under an explicit path
```

---

## Compiler mode

```bash
sfn bench --compiler [options]
```

Re-emits each `compiler/src/**.sfn` module's LLVM IR against a staged
import-context, timing the emit and sampling peak resident set size (RSS) via a
metered subprocess. The import-context tree is produced by `make compile`, so
run that first.

**Options:**

| Flag | Default | Description |
|---|---|---|
| `--compiler` | off | Select compiler mode. |
| `--module <substr>` | all modules | Only benchmark modules whose source path contains `<substr>`. Repeatable; each occurrence adds a filter. Warns if a filter matches nothing. |
| `--import-context <dir>` | `build/compiler/import-context` | Root of the staged import-context tree. Missing → error, exit 1. |
| `--top <n>` | off | After the run, print the `n` slowest modules. |
| `--csv <path>` | none | Also write per-module results as CSV to `<path>` (parent dir created). |
| `--budget-time <seconds>` | off | Per-module wall-time budget in **seconds**. Exceeding it marks the module `SLOW` and exits 2. |
| `--budget-mem <kb>` | off | Peak-RSS budget in KB. Exceeding it marks the module `HIGHMEM` and exits 2. |
| `--work-dir <dir>` | `build/bench` | Scratch directory for staged emit. |
| `--json` | off | Emit the [`sailfin.bench/v1`](#json-output) envelope on stdout instead of the table. |

**Table columns:** `MODULE  TIME  PEAK  IR LINES  STATUS` (time in seconds, peak
in MB), followed by a `SUMMARY` block (module count, total and slowest time,
peak memory, failure/budget counts).

**Example:**

```bash
make compile                                   # stage the import-context first
sfn bench --compiler --top 10                  # 10 slowest modules
sfn bench --compiler --module parser --csv build/compile.csv
sfn bench --compiler --budget-time 5 --budget-mem 2097152
```

---

## Runtime mode

```bash
sfn bench [<path>...] [options]
```

Discovers every `*_bench.sfn` workload under the given paths (a `.sfn` path is
taken directly; a directory contributes its `*_bench.sfn` entries
non-recursively), builds each workload's binary **once**, discards `--warmup`
runs, then times `--iterations` runs through a metered subprocess that reports
wall time and peak RSS. It parses each run's `bench-record/1` line (see
[the harness capsule](#the-sfnbench-capsule)), aggregates min/median inner-ms
and max peak RSS across the timed runs, and checks any budget gates.

With no path argument, the default is `benchmarks/runtime` — the bundled runtime
workloads.

**Options:**

| Flag | Default | Description |
|---|---|---|
| `<path>...` | `benchmarks/runtime` | One or more `*_bench.sfn` files or directories of them. |
| `--iterations <k>` | `5` | Timed runs per workload after warm-up (floored to 1). |
| `--warmup <w>` | `1` | Discarded warm-up runs per workload before timing (floored to 0). |
| `--filter <glob>` | none | Only run workloads whose name matches `<glob>` (`*`/`?` supported). Warns if none match. |
| `--top <n>` | off | After the run, print the `n` slowest workloads. |
| `--csv <path>` | none | Also write per-workload results as CSV to `<path>`. |
| `--budget-time <ms>` | off | Median inner-time budget in **milliseconds**. Exceeding it marks the workload `SLOW` and exits 2. |
| `--budget-mem <kb>` | off | Peak-RSS budget in KB. Exceeding it marks the workload `HIGHMEM` and exits 2. |
| `--work-dir <dir>` | `build/bench-exec` | Scratch directory for built workload binaries. |
| `--json` | off | Emit the [`sailfin.bench/v1`](#json-output) envelope on stdout instead of the table. |

**Table columns:** `WORKLOAD  MEDIAN  PEAK  OPS/MS  STATUS` (median inner-ms,
peak in MB, ops per ms), followed by a `SUMMARY` block.

**Example:**

```bash
sfn bench                                             # all bundled workloads
sfn bench benchmarks/runtime/arena_alloc_bench.sfn    # one workload by path
sfn bench benchmarks/runtime --filter "arena*"        # by name glob
sfn bench benchmarks/runtime --iterations 10 --csv /tmp/baseline.csv
sfn bench benchmarks/runtime --budget-time 1000 --budget-mem 1048576
```

The bundled workloads and what each stresses are catalogued in
`benchmarks/runtime/README.md`.

---

## The `sfn/bench` capsule

Runtime workloads are written against the `sfn/bench` capsule — the
benchmarking counterpart to `sfn/test`. It provides an in-language timer, a
black-box sink to defeat dead-code elimination, and the structured record the
runner parses.

```sfn
import { benchmark, keep } from "sfn/bench";
```

**API:**

| Function | Effects | Description |
|---|---|---|
| `benchmark(name: string, body: fn () -> int) -> int` | `![clock, io]` | Auto-calibrating runner: grows the invocation count until a batch runs long enough to dwarf the millisecond timer (target ~100 ms), then emits that batch's record. The headline API. |
| `benchmark_fixed(name: string, ops: int, body: fn () -> int) -> int` | `![clock, io]` | Fixed-count runner: invokes `body` exactly `ops` times, brackets it with the timer, and emits the record. Use when the iteration count must be pinned. |
| `keep(x: int) -> int` | — | Black-box sink: returns `x` through a branch the compiler cannot fold, so the hot-loop result is not optimized away. |
| `record_line(name: string, ops: int, inner_ms: int) -> string` | — | Builds the record text (normally emitted for you by the runners). |

`benchmark` and `benchmark_fixed` declare `![clock, io]` — `clock` for the
`monotonic_millis()` bracketing and `io` for printing the record.

Each call emits **exactly one** machine-parseable line to stdout:

```
bench-record/1 ops=<int> inner_ms=<int> name=<label>
```

`name` is last so a label containing spaces is still recoverable. This is the
line `sfn bench`'s runtime mode parses.

**Minimal workload** (`*_bench.sfn`):

```sfn
import { benchmark, keep } from "sfn/bench";

fn _work(seed: int) -> int {
    let a = seed * 2654435761;
    let b = a + 1013904223;
    return keep(b);
}

fn main() ![clock, io] {
    let _ = benchmark("sample", fn () -> int { return _work(7); });
}
```

Run it directly with `sfn run <file>_bench.sfn`, or place it under a directory
that `sfn bench <dir>` scans.

---

## JSON output

`--json` suppresses the human table and prints a single `sailfin.bench/v1` JSON
document to stdout — the same shape as `sfn check --json`. It works in both
modes:

```bash
sfn bench --compiler --json > compile.json
sfn bench --json | jq '[.results[] | select(.status != "ok")]'
```

The envelope carries `schema`, `command`, `domain` (`compiler`|`runtime`),
`exit_code`, `tool`, `config`, and a `results` array of per-item
`{name, ops, unit, time_ms{min,median,max,stddev}, peak_rss_kb, status}`
records. The full field-by-field schema, the status normalization
(`ok`|`fail`|`slow`|`highmem`), worked examples, and the versioning/stability
contract are documented in
[`docs/reference/bench-json-schema.md`](https://github.com/SailfinIO/sailfin/blob/main/docs/reference/bench-json-schema.md).

**MCP tool.** The Sailfin MCP server exposes `sailfin_bench`, a pure passthrough
that shells `sfn bench … --json` and returns the parsed envelope as
`structuredContent` for agentic clients. Its parameters mirror the flags above
(`compiler`, `path`, `top`, `filter`, `module`, `iterations`); see
`tools/mcp-server/README.md`.

---

## Exit codes

Shared by both modes and mirrored in the JSON envelope's `exit_code`:

| Code | Meaning |
|---|---|
| `0` | Clean run; everything within budget. |
| `1` | Build / emit / run failure, or a pre-flight config error (compiler mode: missing import-context; runtime mode: no workloads resolved). Pre-flight errors print plain text to stderr with **no** JSON envelope. |
| `2` | Budget violation only (`--budget-time` / `--budget-mem` exceeded, no build/run failure). Also returned for a CLI usage error. |

---

## Makefile targets

Both targets are thin wrappers over the native command:

```bash
make bench BENCH_ARGS="--top 10"                    # → sfn bench --compiler …
make bench-runtime BENCH_RUNTIME_ARGS="--iterations 10"  # → sfn bench benchmarks/runtime …
```

`make bench` requires a prior `make compile` (it needs the staged
import-context).
