# Runtime-execution benchmarks

These benchmarks measure how fast **compiled Sailfin programs run** — the
counterpart to the compiler *build-perf* bench (`sfn bench --compiler`,
`make bench`), which measures how fast the compiler emits IR.

This is the surface the C→Sailfin runtime rewrite most affects: now that the C
runtime is deleted and the runtime is pure Sailfin, these workloads establish a
0.7.0 baseline for the runtime hot paths (arena allocation, strings, arrays,
exceptions, I/O).

## How it works

Each workload is a standalone `<name>_bench.sfn` that imports `benchmark_fixed`
and `keep` from `sfn/bench` and calls
`benchmark_fixed("<name>", <count>, fn () -> int { ...; return keep(...); })`.
`benchmark_fixed` runs the body exactly `count` times, brackets it with the
in-language timer, and emits **exactly one** machine-parseable line to stdout:
`bench-record/1 ops=<int> inner_ms=<int> name=<label>`. `keep(...)` anchors the
hot-loop result so it isn't optimized away.

`sfn bench [<path>...]` (default path `benchmarks/runtime`) discovers every
`*_bench.sfn` workload in a directory (a `.sfn` path is taken directly), builds
each workload's binary **once**, discards `--warmup` runs (default 1), then
times `--iterations` runs (default 5) via a metered subprocess that reports
wall time and peak RSS from rusage. It parses each run's `bench-record/1` line,
aggregates min/median inner-ms and max peak RSS across the timed runs, checks
any `--budget-*` gates, and reports the result (table, `--csv`, or both). It
replaces the retired runtime bench shell script.

## Running

```bash
make bench-runtime                                      # all workloads, 5 timed runs each
make bench-runtime BENCH_RUNTIME_ARGS="--iterations 10" # 10 timed runs each
make bench-runtime BENCH_RUNTIME_ARGS="--filter arena*"
make bench-runtime BENCH_RUNTIME_ARGS="--csv build/runtime.csv"

# Or the native runner directly:
build/bin/sfn bench benchmarks/runtime                          # all workloads
build/bin/sfn bench benchmarks/runtime/arena_alloc_bench.sfn     # one workload, by path
build/bin/sfn bench benchmarks/runtime --filter arena*           # one workload, by name glob
build/bin/sfn bench benchmarks/runtime --top 3
build/bin/sfn bench benchmarks/runtime --iterations 10 --csv /tmp/baseline.csv
build/bin/sfn bench benchmarks/runtime --budget-time 1000 --budget-mem 1048576
```

Runtime-mode flags: `--iterations K` (default 5), `--warmup W` (default 1),
`--filter GLOB` (glob on workload name, e.g. `arena*`), `--top N`, `--csv PATH`,
`--budget-time MS` (median inner-ms), `--budget-mem KB` (peak RSS), `--work-dir
DIR` (default `build/bench-exec`). The runner exits non-zero on any build
failure, run failure, or budget violation. (Compiler mode is unchanged: `sfn
bench --compiler ...`.)

CSV schema:
`workload,inner_ms_min,inner_ms_median,peak_kb,ops,ops_per_ms,status,seed_version,platform`.

## Workloads

All workloads declare `![io, clock]` (`clock` for `monotonic_millis` inside the
harness, `io` for the file I/O / record print). Op counts are tuned so the timed
window runs roughly 50–500ms — long enough to dwarf the millisecond timer
resolution, short enough that the whole suite stays under a few minutes.

**Peak RSS.** The `sfn/bench` harness runs the whole timed window in one arena
scope, so allocations that live to the end of a body call accumulate across the
window. Workloads that stress the arena-struct hot path (`arena_alloc`,
`arena_alloc_for_range`) keep their allocation inside a directly-timed inner
loop, so the per-iteration arena rewind (#1514/#1515) reclaims each struct and
peak RSS stays flat (bounded by the batch). The array/string workloads
(`array_growth`, `array_map_filter`, `arena_reset_churn`, `string_concat`) do
not benefit from the struct rewind, so their peak RSS reflects the array/string
memory they allocate over the timed window — a real measurement of that path,
not a leak.

| Workload | Runtime subsystem stressed | Iteration count | What it does |
|---|---|---|---|
| `arena_alloc` | arena bump alloc (`runtime/sfn/memory/arena.sfn`) | 30,000 batches × 1,000 | Each body call is a 1,000-iteration inner `loop` allocating a small non-escaping 3-field struct per pass. The inner loop directly allocates, so the per-iteration arena rewind (#1514) reclaims each struct and peak RSS stays flat (bounded by the batch, ~6 MB). |
| `arena_alloc_for_range` | arena bump alloc via `for`-range reclamation (#1515) | 30,000 batches × 1,000 | As `arena_alloc` but the inner loop is `for i in 0..n` over `number`-field structs, covering the for-range arm of the rewind seam. Peak RSS stays flat. |
| `arena_reset_churn` | arena page reuse (`runtime/sfn/memory/arena.sfn`) | 12,000 rounds × 5,000 burst | Each round allocates a burst into a fresh array that then drops, so later rounds re-walk and reuse the page chain. |
| `string_concat` | string concat/append (`runtime/sfn/string.sfn`) | 2,000,000 concats | Performs many independent short concats via repeated `+`. |
| `string_find_format` | string scan + int→str (`runtime/sfn/string.sfn`) | 220,000 | Per iteration: byte-scan a medium string via `find_char`, plus an `int as string` integer-formatting concat. |
| `array_growth` | array push/grow (`runtime/sfn/array.sfn`) | 12,000 batches | Pushes elements onto a growing `int[]` (amortized doubling), then sum-iterates. |
| `array_map_filter` | collection traversal (`runtime/sfn/array.sfn`) | 8,000 batches | Map (double) → filter (multiples of 3) → reduce (sum) over a large array. |
| `exception_throw` | exception frames (`runtime/sfn/exception.sfn`) | 150,000 batches of 4 `risky` calls | Per-iteration `try`/`catch`; ~1 in 4 calls throws and is caught. |
| `io_throughput` | filesystem adapter (`runtime/sfn/adapters/filesystem.sfn`) | 20,000 | Appends N lines to a temp file (`$TMPDIR`, fallback `/tmp`) via `fs.appendFile`, then reads the file back once. |
| `http_proxy_hotpath` | MCP-proxy request hot path (parse + `StrMap` + forward) | 12,000 | Per iteration: parse an HTTP/1.1 request (representative inline wire parse) → policy lookup in the real prelude `StrMap` (`runtime/sfn/collections.sfn`) → serialize the forwarded outbound request. CPU-only (no network). Documented **150 ms** budget, gated via `--filter http_proxy_hotpath --budget-time 150`. |
| `http_router_many_route_dispatch` | `sfn/http` ordered router dispatch | 2,000 | Dispatches a request matching the last of 64 registered routes, exercising precomputed pattern matching and one request-path split per dispatch. |

### Hot-path budget gate (`http_proxy_hotpath`, #1712)

`http_proxy_hotpath` establishes the parse→policy→forward baseline for the
MCP-proxy work (epic #1540, Track C gap C6) with a documented **150 ms**
per-round wall-clock budget. It is **advisory-only** (no CI gating yet — Track C
B5/epoll work is out of scope). To check the gate locally:

```bash
make bench-runtime BENCH_RUNTIME_ARGS="--filter http_proxy_hotpath --budget-time 150"
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

One workload was simplified to compile on the 0.7.0 compiler:

- **`array_map_filter`** uses **manual loops** for map/filter/reduce. The
  higher-order collection methods (`.map` / `.filter` / `.reduce`) and the prelude
  free functions (`array_map` / `array_filter` / `array_reduce`) do **not** lower
  on this compiler (`llvm lowering [fatal]: cannot resolve return type for call`),
  so the workload spells the semantics out as loops. It still stresses the array
  read/push/grow paths.

`string_find_format` uses the prelude's `find_char` (no import) rather than
`sfn/strings::find`, which also does not lower on this compiler.
