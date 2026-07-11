# `sfn bench --json` Schema (`sailfin.bench/v1`)

Status: Shipped in SFN-64 (epic #1503). Locked at `sailfin.bench/v1`.
2026-07-11.

`sfn bench --json` is a boolean flag, the same shape as `sfn check --json`:
it suppresses the human-readable table and prints a single UTF-8 JSON
document to stdout. There is no `--json=PATH` form — write to a file with a
shell redirect (`sfn bench --compiler --json > out.json`). It works in both
bench modes:

- `sfn bench --compiler --json` — compiler domain (per-module emit timing).
- `sfn bench [<path>...] --json` — runtime domain (per-workload timing).

Exit codes mirror the human renderer: `0` clean, `1` build/emit/run failure,
`2` budget violation (`--budget-time` / `--budget-mem` exceeded). The same
value is echoed as the `exit_code` field in the envelope.

**Pre-flight config errors emit no envelope.** Two setup failures are detected
before any benchmark runs and are reported as a plain-text message on stderr
with exit `1` and **empty stdout** — not as a JSON envelope: compiler mode when
the import-context is missing (`build/compiler/import-context` absent — run
`make compile` first), and runtime mode when no workloads resolve from the
given paths. A `--json` consumer must therefore treat empty/non-JSON stdout
with a non-zero exit as a setup error rather than assuming every invocation
yields an envelope. Every failure that occurs *after* benchmarking starts
(build/emit/run failure, budget violation) is reported inside the envelope via
`exit_code` and per-result `status`.

## Versioning

The first field of every envelope is `schema`. Today it is the literal string
`"sailfin.bench/v1"`. Breaking changes bump this string (e.g.
`"sailfin.bench/v2"`). Consumers MUST hard-fail on unknown versions rather
than guess at unfamiliar field shapes.

Additive changes (new optional fields) keep the same version string.
Consumers must tolerate unknown fields. Two tests guard the field set so a
silent leak fails CI before it lands: the e2e schema-lock test
(`compiler/tests/e2e/bench_json_schema_test.sfn`) runs both modes end-to-end,
and the encoder unit test (`compiler/tests/unit/bench_json_test.sfn`) locks the
envelope shape, status normalization, and escaping at the
`render_bench_json_envelope` boundary.

## Envelope shape

```jsonc
{
  "schema": "sailfin.bench/v1",
  "command": "sfn bench",
  "domain": "compiler",
  "exit_code": 0,
  "tool": {
    "version": "0.8.0-alpha.5",
    "platform": "Linux x86_64"
  },
  "config": {
    "iterations": 1,
    "warmup": 0
  },
  "results": [
    {
      "name": "lexer",
      "ops": 0,
      "unit": "ms",
      "time_ms": {
        "min": 455,
        "median": 455,
        "max": 455,
        "stddev": 0
      },
      "peak_rss_kb": 118580,
      "status": "ok"
    }
  ]
}
```

## Top-level fields

| Field | Type | Notes |
|---|---|---|
| `schema` | string | Always first. `"sailfin.bench/N"` — consumers must hard-fail on unknown N. |
| `command` | string | Always `"sfn bench"`. |
| `domain` | string | `"compiler"` (per-module emit timing, `sfn bench --compiler`) or `"runtime"` (per-workload timing, `sfn bench [<path>...]`). |
| `exit_code` | number | Mirrors the process exit code: `0` clean, `1` build/emit/run failure, `2` budget violation (`--budget-time` / `--budget-mem`). |
| `tool` | object | `{ "version", "platform" }` — see below. |
| `config` | object | `{ "iterations", "warmup" }` — see below. |
| `results` | array | One object per benchmarked module (compiler domain) or workload (runtime domain). |

## `tool`

| Field | Type | Notes |
|---|---|---|
| `version` | string | The running compiler's version string, e.g. `"0.8.0-alpha.5"`. |
| `platform` | string | `"<uname -s> <uname -m>"`, e.g. `"Linux x86_64"`. |

## `config`

| Field | Type | Notes |
|---|---|---|
| `iterations` | number | Compiler domain always reports `1` — it measures one emit per module, no repeat runs. Runtime domain reports the effective `--iterations` value (default 5). |
| `warmup` | number | Compiler domain always reports `0` — there is no warm-up concept for a single emit. Runtime domain reports the effective `--warmup` value (default 1). |

## `results[]`

Each result is a JSON object with a fixed field set, shared by both domains.

| Field | Type | Notes |
|---|---|---|
| `name` | string | Compiler domain: the module label (e.g. `lexer`, `parser__mod` — path slashes flattened to `__`). Runtime domain: the workload label (the `_bench.sfn` fixture's stem, e.g. `arena_alloc`). |
| `ops` | number | Runtime domain: the workload's reported operation count. Compiler domain: always `0` — module emit has no op concept. |
| `unit` | string | Labels the `time_ms` measurements. Currently always `"ms"`; reserved for a finer-grained unit under a future schema bump. `time_ms` values are **always milliseconds** regardless of `unit`. |
| `time_ms` | object | `{ "min", "median", "max", "stddev" }`, all integer milliseconds — see below. |
| `peak_rss_kb` | number | Peak resident set size in KiB, sampled from the metered subprocess. **Platform caveat**: this is a Linux/WSL-oriented measurement (KiB, as reported by the kernel); Darwin normalization is deferred, so both this column and `--budget-mem` are most meaningful on Linux today. |
| `status` | string | Normalized status — see below. |

### `time_ms`

| Field | Type | Notes |
|---|---|---|
| `min` | number | Minimum wall-clock time across the timed samples, in milliseconds. |
| `median` | number | Median wall-clock time, in milliseconds. |
| `max` | number | Maximum wall-clock time, in milliseconds. |
| `stddev` | number | Population standard deviation across the timed samples, floored to an integer, in milliseconds. |

Runtime domain computes all four across the timed (post-warmup) iterations.
Compiler domain has a single emit sample per module, so `min == median ==
max` and `stddev == 0` always.

### `status`

Normalized to one of `ok` | `fail` | `slow` | `highmem`, with `+`-joined
combinations (e.g. `"slow+highmem"`). The two bench modes internally track a
richer set of tokens — `ok` / `FAIL` / `BUILDFAIL` / `RUNFAIL` / `SLOW` /
`HIGHMEM` — which the JSON encoder maps down to the documented enum before
emitting:

| Internal token(s) | Normalized `status` |
|---|---|
| `ok` | `ok` |
| `FAIL`, `BUILDFAIL`, `RUNFAIL` | `fail` |
| `SLOW` | `slow` |
| `HIGHMEM` | `highmem` |

`+`-joined internal combinations (e.g. `SLOW+HIGHMEM`) normalize token-by-token,
preserving the combination (e.g. `"slow+highmem"`).

## Examples

### Compiler-domain clean run

```jsonc
{
  "schema": "sailfin.bench/v1",
  "command": "sfn bench",
  "domain": "compiler",
  "exit_code": 0,
  "tool": { "version": "0.8.0-alpha.5", "platform": "Linux x86_64" },
  "config": { "iterations": 1, "warmup": 0 },
  "results": [
    {
      "name": "lexer",
      "ops": 0,
      "unit": "ms",
      "time_ms": { "min": 455, "median": 455, "max": 455, "stddev": 0 },
      "peak_rss_kb": 118580,
      "status": "ok"
    },
    {
      "name": "num_format",
      "ops": 0,
      "unit": "ms",
      "time_ms": { "min": 151, "median": 151, "max": 151, "stddev": 0 },
      "peak_rss_kb": 66440,
      "status": "ok"
    }
  ]
}
```

### Runtime-domain clean run

```jsonc
{
  "schema": "sailfin.bench/v1",
  "command": "sfn bench",
  "domain": "runtime",
  "exit_code": 0,
  "tool": { "version": "0.8.0-alpha.5", "platform": "Linux x86_64" },
  "config": { "iterations": 3, "warmup": 1 },
  "results": [
    {
      "name": "arena_alloc",
      "ops": 30000,
      "unit": "ms",
      "time_ms": { "min": 551, "median": 552, "max": 577, "stddev": 12 },
      "peak_rss_kb": 6740,
      "status": "ok"
    }
  ]
}
```

### Runtime-domain budget violation (`exit_code: 2`)

```jsonc
{
  "schema": "sailfin.bench/v1",
  "command": "sfn bench",
  "domain": "runtime",
  "exit_code": 2,
  "tool": { "version": "0.8.0-alpha.5", "platform": "Linux x86_64" },
  "config": { "iterations": 2, "warmup": 1 },
  "results": [
    {
      "name": "arena_alloc",
      "ops": 30000,
      "unit": "ms",
      "time_ms": { "min": 537, "median": 550, "max": 564, "stddev": 13 },
      "peak_rss_kb": 6708,
      "status": "highmem"
    }
  ]
}
```

## Consumers

- **MCP server** (`tools/mcp-server/`): exposes `sailfin_bench`, which shells
  `sfn bench --json` and returns the parsed envelope as `structuredContent`
  for agentic/programmatic clients.
- **CI scrapers / interactive use**: `jq` is the canonical reader. Examples:
  ```bash
  sfn bench --compiler --json | jq '.results | sort_by(.time_ms.median) | reverse | .[0:5]'  # 5 slowest modules
  sfn bench --json | jq '[.results[] | select(.status != "ok")]'                             # failing/slow/highmem only
  sfn bench --json | jq -r '.results[] | "\(.name): \(.time_ms.median)ms (\(.status))"'       # one-line-per-result summary
  ```

## Stability contract

- Field names and types in `sailfin.bench/v1` are frozen.
- New optional fields will land *with the same schema string* — consumers
  must tolerate unknown fields.
- Field renames or type changes bump to `sailfin.bench/v2`.
- The schema-lock test at `compiler/tests/e2e/bench_json_schema_test.sfn`
  exercises both bench domains and asserts the field set matches this
  document.
