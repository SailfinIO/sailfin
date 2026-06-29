# Runtime-execution benchmarks

These benchmarks measure how fast **compiled Sailfin programs run** — the
counterpart to the compiler *build-perf* bench (`scripts/bench_compile.sh`,
`make bench`), which measures how fast the compiler emits IR.

This is the surface the C→Sailfin runtime rewrite most affects: now that the C
runtime is deleted and the runtime is pure Sailfin, these workloads establish a
0.7.0 baseline for the runtime hot paths (arena allocation, strings, arrays,
exceptions, I/O).

## How it works

Each workload is a standalone `.sfn` with `fn main() ![io, clock]` that:

- uses a **compile-time-constant** iteration count (never read from argv/env), so
  the work is identical across releases and the numbers are comparable;
- brackets the hot loop with `monotonic_millis()` (the in-language timer in
  `runtime/prelude.sfn`);
- prints **exactly one** machine-parseable line to stdout:
  `RESULT <name> <inner_ms> <ops>` (e.g. `RESULT arena_alloc 338 30000000`),
  and nothing else.

The harness (`scripts/bench_runtime.sh`) builds each workload's binary **once**,
discards a warm-up run, then runs it K more times (default 5), parsing the
`RESULT` line for the inner-loop time and wrapping each run with GNU `time` for
peak RSS. It reports min/median inner-ms and max peak-RSS, and can emit CSV.

## Running

```bash
make bench-runtime                                      # all workloads, 5 timed runs each
make bench-runtime BENCH_RUNTIME_ARGS="--iterations 10" # 10 timed runs each
make bench-runtime BENCH_RUNTIME_ARGS="--csv build/runtime.csv"

# Or the script directly (CLI mirrors scripts/bench_compile.sh):
bash scripts/bench_runtime.sh                           # all workloads
bash scripts/bench_runtime.sh --workload arena_alloc    # one workload (repeatable)
bash scripts/bench_runtime.sh --top 3                   # show 3 slowest
bash scripts/bench_runtime.sh --iterations 10 --csv /tmp/baseline.csv
bash scripts/bench_runtime.sh --budget-time 1000 --budget-mem 1048576
```

Script flags: `--seed <bin>` (default `build/native/sailfin`), `--csv PATH`,
`--top N`, `--iterations K` (default 5), `--workload <name>` (repeatable, default
all), `--budget-time MS`, `--budget-mem KB`, `--work-dir DIR` (default
`build/bench-runtime`). The script exits non-zero on any build failure, run
failure, or budget violation.

CSV schema:
`workload,inner_ms_min,inner_ms_median,peak_kb,ops,ops_per_ms,status,seed_version,platform`.

## Workloads

All workloads declare `![io, clock]` (`clock` for `monotonic_millis`, `io` for the
single `print` / the file I/O). Iteration counts are tuned so the inner loop runs
roughly 50–500ms on an Apple-Silicon dev machine — long enough to dwarf the
millisecond timer resolution, short enough that the whole suite stays under a few
minutes.

| Workload | Runtime subsystem stressed | Iteration count | What it does |
|---|---|---|---|
| `arena_alloc` | arena bump alloc (`runtime/sfn/memory/arena.sfn`) | 30,000,000 | Allocates a small 3-field struct per iteration in a tight loop, summing a field so the allocation isn't eliminated. |
| `arena_reset_churn` | arena page reuse (`runtime/sfn/memory/arena.sfn`) | 12,000 rounds × 5,000 burst | Each round allocates a burst into a fresh array that then drops, so later rounds re-walk and reuse the page chain. |
| `string_concat` | string concat/append (`runtime/sfn/string.sfn`) | 5,000 appends + 2,000,000 concats | Builds one large string via repeated `+`, then performs many independent short concats. |
| `string_find_format` | string scan + int→str (`runtime/sfn/string.sfn`) | 220,000 | Per iteration: byte-scan a medium string via `find_char`, plus an `int as string` integer-formatting concat. |
| `array_growth` | array push/grow (`runtime/sfn/array.sfn`) | 12,000,000 | Pushes elements onto a growing `int[]` (amortized doubling), then sum-iterates. |
| `array_map_filter` | collection traversal (`runtime/sfn/array.sfn`) | 8,000,000 | Map (double) → filter (multiples of 3) → reduce (sum) over a large array. |
| `exception_throw` | exception frames (`runtime/sfn/exception.sfn`) | 600,000 | Per-iteration `try`/`catch`; ~1 in 4 iterations throws and is caught. |
| `io_throughput` | filesystem adapter (`runtime/sfn/adapters/filesystem.sfn`) | 20,000 | Appends N lines to a temp file (`$TMPDIR`, fallback `/tmp`) via `fs.appendFile`, then reads the file back once. |
| `http_proxy_hotpath` | MCP-proxy request hot path (parse + `StrMap` + forward) | 12,000 iters × 7 rounds (median) | Per iteration: parse an HTTP/1.1 request (representative inline wire parse) → policy lookup in the real prelude `StrMap` (`runtime/sfn/collections.sfn`) → serialize the forwarded outbound request. CPU-only (no network). Documented **150 ms** budget; the program prints its own PASS/FAIL and the harness gates it with `--budget-time 150`. |

### Hot-path budget gate (`http_proxy_hotpath`, #1712)

`http_proxy_hotpath` establishes the parse→policy→forward baseline for the
MCP-proxy work (epic #1540, Track C gap C6) with a documented **150 ms**
per-round wall-clock budget. It is **advisory-only** (no CI gating yet — Track C
B5/epoll work is out of scope). To check the gate locally:

```bash
make bench-runtime BENCH_RUNTIME_ARGS="--workload http_proxy_hotpath --budget-time 150"
```

The benchmark measures the CPU hot path only: a live upstream forward is
non-deterministic and would break the cross-run comparability requirement, so the
"forward" step is the outbound-request serialization the proxy performs before
handing bytes to the socket. The parse is an inline parse mirroring
`capsules/sfn/http/src/wire.sfn::parse_request` — the `sfn/http` capsule parser
cannot be reused directly because the harness builds each workload as a bare
`.sfn` file and a capsule module with its own relative imports does not link into
a bare-file build. The policy lookup uses the **real** `StrMap` (#1710), which is
a runtime module and links cleanly.

### Compiler-version caveats (0.7.0-alpha.47)

Two workloads were simplified to compile on the 0.7.0 compiler:

- **`array_map_filter`** uses **manual loops** for map/filter/reduce. The
  higher-order collection methods (`.map` / `.filter` / `.reduce`) and the prelude
  free functions (`array_map` / `array_filter` / `array_reduce`) do **not** lower
  on this compiler (`llvm lowering [fatal]: cannot resolve return type for call`),
  so the workload spells the semantics out as loops. It still stresses the array
  read/push/grow paths.
- **All workloads** emit the `RESULT` line via `{{ }}` interpolation rather than
  pure `"..." + (x as string)` concatenation passed straight to `print`. On this
  compiler a `print` argument built entirely from `+` concatenation produces **no
  stdout output** (silent, exit 0); interpolation works. The duration and ops are
  bound to locals and interpolated.

`string_find_format` uses the prelude's `find_char` (no import) rather than
`sfn/strings::find`, which also does not lower on this compiler.
