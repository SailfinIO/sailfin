# Consumer-build benchmark: pre-filter baseline

**Companion:** `consumer-baseline.csv` (the data), SFEP-0070
(`docs/proposals/0070-capsule-source-closure-reachability.md`) — the
import-reachability filter these numbers exist to measure.

This is the **pre-filter** baseline. Every downstream change in the
SFEP-0070 epic re-runs `make bench-consumer` and records its delta against
this file. Without it there is no way to tell whether the filter paid for
itself.

## Provenance

| | |
|---|---|
| Command | `make bench-consumer BENCH_CONSUMER_ARGS="--csv docs/perf/consumer-baseline.csv"` |
| Compiler | `sfn 0.9.5` (self-hosted via `make compile`) |
| Pinned seed | `bootstrap.toml [seed].version = "0.9.5"` |
| Commit | `c21d8b7` |
| Platform | Linux x86_64 (6.18.5), 4 cores |
| Date | 2026-08-11 |

Numbers are from a single machine and are **not** comparable across hosts —
compare deltas taken on the same host, which is what the epic's leaves do.

## The numbers

| Fixture | Cold | Warm | Stripped bytes | Ctors | Staged | Cold misses |
|---|---|---|---|---|---|---|
| `hello` | 48.73s | 1.76s | 386,848 | 32 | 34 | 68 |
| `hello_lib` | 49.50s | 1.90s | 390,528 | 34 | 35 | 69 |
| `tls_client` | 49.61s | 1.85s | 388,288 | 38 | 39 | 73 |

## What the baseline shows

**A hello-world stages 34 modules, 33 of them `sfn/crypto`.** `runtime/capsule.toml`
declares `[dependencies] "sfn/crypto" = "*"`, so a program that never opens a
socket still parses, type-checks, effect-checks, emits, caches, and lowers the
entire crypto capsule. This is the cost SFEP-0070 §2.1 predicted, now measured.

**The TLS client — the only fixture that legitimately reaches crypto — costs
0.88s more than the hello-world that does not** (49.61s vs 48.73s, +5 staged
modules). The floor, not the feature, is what a consumer pays for. That gap is
the headline number for the epic: it should widen as the filter drops crypto
from the two fixtures that never reach it, not because TLS gets slower.

**Size is flat, and that is the finding.** 386,848 → 388,288 bytes across the
whole range is 0.4%. `--gc-sections` with `-ffunction-sections -fdata-sections`
already strips unreferenced capsule code, and the runtime retain-root flags
force-retain only runtime objects, never capsule objects. **Binary size is not
the metric to quote for this epic** — it is recorded to demonstrate it stays
flat. A future change that claims a size win here should be treated as
suspicious until explained.

**The constructor floor is real and proportional to modules linked.** 32
`.init_array` slots for a hello-world. Module type-init constructors are GC
roots, so they and every `linkonce_odr` descriptor they register survive
dead-stripping — unlike the code `--gc-sections` removes. This is the metric
that moves with the filter, and the reason binary size does not.

**Cold is ~27x warm** (48.73s vs 1.76s). The filter targets the cold column;
the warm column is a control that should stay flat.

## Reading the columns

- `modules_staged` — modules in the build's resolved closure. **The number the
  filter is expected to move.**
- `cold_cache_misses` — cache misses on an empty cache, spanning **both** the
  `.ll` module cache and the `.o` object cache. A work proxy, not a module
  count: it legitimately exceeds `modules_staged`, and not by a fixed ratio
  (34/68 for `hello`, 39/73 for `tls_client`), because the runtime object layer
  is shared across modules.
- `cache_hits` / `cache_misses` — from the **warm** run. A genuinely warm cache
  reads `hits > 0, misses = 0`; any other reading means the cold run failed to
  populate and the warm number is not a warm number.
- `binary_bytes` — **stripped** size. `-1` if no strip tool was available
  (status gains `nostrip`); never an unstripped size in the same column.
- `ctors` — `.init_array` slot count from the linked artifact, derived, never
  estimated. On ELF this includes any C-runtime entry (e.g. `frame_dummy`)
  alongside the per-module `@__sfn_module_type_init__` constructors, so treat it
  as a consistent relative measure rather than an exact module-ctor count.
  `-1` + `noctor` where the section or the tool is unavailable.

## Reproducing

```bash
make compile          # the harness measures the compiler you built
make bench-consumer BENCH_CONSUMER_ARGS="--csv /tmp/consumer.csv"
```

Fixtures are only ever **built**, never executed, so no network is required.
Each fixture gets its own `--work-dir` (isolating the import-context staging
tree and the per-capsule `.ll` tree) and its own `SAILFIN_BUILD_CACHE_DIR` that
does not exist before the cold run. Both are per-fixture: without the
`--work-dir` half, a fixture's "cold" run silently reuses staging left by
`make compile` or by an earlier fixture, which understates cold time by roughly
3s per fixture on this host.

The child build also runs with `--skip-toolchain-check`, keeping the
`[toolchain]` version-floor gate — which can dispatch a network fetch — out of
the measured window.

## The standing gate

This shape is what the nightly records. `perf-history.yml` runs
`make bench-consumer` on the same cadence as the other two benches and appends
the rows to `consumer.csv` on the `bench-data` branch, where each fixture is
compared against the rolling median of the last N same-seed runs (SFN-832). The
CSV deliberately carries no `run_sha`/`run_date` columns —
`scripts/perf_history.sh`'s `_append_tagged` prepends those itself — so this file
and the series share one shape.

The gate **warns and never fails the nightly**; `ctors` and `modules_staged` are
compared with no noise band, because they are deterministic and a percentage
threshold would absorb exactly the closure growth worth catching. How to read
the series: `docs/perf/bench-history.md` § *The consumer-build series*.
