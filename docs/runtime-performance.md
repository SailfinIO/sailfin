# Runtime Performance: Execution Baseline

**Date:** 2026-06-22 (initial baseline)
**Companion:** `docs/build-performance.md` tracks *compiler* build performance
(how fast the compiler emits IR for its own modules). This doc tracks *runtime*
performance — **how fast compiled Sailfin programs execute** — which is the
dimension the C→Sailfin runtime rewrite (epic #1308 / #822, C runtime deleted)
most directly affects.

---

## Why this exists

With the C runtime deleted, the entire runtime (arena allocator, strings,
arrays/collections, exceptions, I/O) is now pure Sailfin (`runtime/prelude.sfn`,
`runtime/sfn/**`). Nothing previously measured the execution speed of compiled
programs, so a regression in the ported runtime would ship silently. This
baseline is the instrument that catches one — and the number we point at when
claiming the pure-Sailfin runtime is performance-credible for 1.0.

This is orthogonal to `make bench` (`scripts/bench_compile.sh`), which measures
*compile* time + peak RSS per compiler module, not program execution.

## How it works

`make bench-runtime` → `scripts/bench_runtime.sh` builds each workload in
`benchmarks/runtime/*.sfn` to a native binary **once** (never timed), then runs
it `1 + K` times (default K=5), discarding a warm-up run. Each workload brackets
its hot loop with `monotonic_millis()` (`![clock]`) and prints a single
`RESULT <name> <inner_ms> <ops>` line; the harness records the self-timed inner
wall (min + median over K runs) as the primary metric and wraps the process with
GNU time (`/usr/bin/time -v` / `gtime`) for best-effort peak RSS. Iteration
counts are compile-time constants so the *work* is fixed across releases and only
performance varies.

```bash
make compile                                            # prerequisite
make bench-runtime BENCH_RUNTIME_ARGS="--csv out.csv"   # full suite
make bench-runtime BENCH_RUNTIME_ARGS="--workload arena_alloc --top 1"
```

Inner-ms is the headline because it isolates the runtime subsystem cost from
process startup / runtime init. Peak RSS is a process-level max (best-effort:
`0` when GNU time is absent; on macOS `brew install gnu-time`).

## Workloads

Each maps to a runtime subsystem the C-deletion replaced. See
`benchmarks/runtime/README.md` for the full catalog.

| Workload | Subsystem |
|---|---|
| `arena_alloc` | arena bump allocation |
| `arena_reset_churn` | arena page reuse across rounds |
| `string_concat` | string concat / append |
| `string_find_format` | string scan + int→str formatting |
| `array_growth` | array push / amortized-doubling grow |
| `array_map_filter` | collection traversal (manual loops — see note) |
| `exception_throw` | try/catch frame push/pop |
| `io_throughput` | file I/O write/read |

## 0.7.0 baseline (Darwin arm64)

Compiler `sfn 0.7.0-alpha.47+dev.64ed8a6d`, Apple Silicon, K=5. Raw CSV:
`docs/baselines/runtime-0.7.0-darwin-arm64.csv`.

| Workload | inner ms (min) | inner ms (median) | peak RSS | ops | ops/ms |
|---|---|---|---|---|---|
| `arena_alloc` | 336 | 336 | 691 MB | 30,000,000 | 89,286 |
| `arena_reset_churn` | 331 | 331 | 764 MB | 60,000,000 | 181,269 |
| `string_concat` | 101 | 101 | 159 MB | 2,005,000 | 19,852 |
| `string_find_format` | 441 | 442 | 197 MB | 220,000 | 498 |
| `array_growth` | 87 | 88 | 256 MB | 12,000,000 | 136,364 |
| `array_map_filter` | 75 | 78 | 316 MB | 8,000,000 | 102,564 |
| `exception_throw` | 196 | 197 | 3 MB | 600,000 | 3,046 |
| `io_throughput` | 418 | 423 | 3 MB | 20,000 | 47 |

Observations for follow-up (not regressions — first baseline, nothing to compare
against yet):

- **Arena allocation dominates RSS** (~700–760 MB for 30–60M allocations) —
  expected for a bump allocator that grows its page chain; the next baseline
  shows whether reset/reuse reclaims it.
- **`string_find_format` is the slowest per-op** (498 ops/ms) — the int→str
  formatting path is heavier than raw scanning; worth a look if string-heavy
  programs feel slow.
- **Linux x86_64 baseline pending** — runtime numbers are not cross-platform
  comparable (wall + RSS differ by arch), so a Linux row must be captured on a
  Linux runner before CI regression gating is meaningful.

## Known runtime limitations exercised here

The workloads were written against what the 0.7.0 compiler actually lowers. Two
constructs do **not** lower today and were worked around (all tracked, not
regressions):

- `.map`/`.filter`/`.reduce` and the prelude `array_map`/`array_filter`/
  `array_reduce` free functions fail with `llvm lowering [fatal]: cannot resolve
  return type for call` — gated on the runtime-callable closure primitive
  (tracking #766, epic #1118). `array_map_filter` uses manual loops instead.
- `sfn/strings::find` fails the same way; `string_find_format` uses the prelude
  `find_char` instead.

A third, **untracked** issue surfaced while authoring the workloads and is *not*
worked around in-language: the `int as string` cast silently produces `0`
(e.g. `let s = "x" + (n as string)` yields `0`, not `x42`), while `{{ }}`
interpolation lowers correctly. The workloads use interpolation throughout. See
the benchmarking notes / open issue.

## Follow-ups

- Capture the Linux x86_64 baseline on a Linux runner.
- Wire `--budget-time` / `--budget-mem` into a CI regression gate once ≥2
  baselines exist to set non-flaky thresholds.
- Fold `bench_runtime.sh` into `sfn bench --runtime` after the native `sfn bench`
  subcommand lands (#1503), reusing its shared GNU-time / CSV / flag scaffolding.
</content>
</invoke>
