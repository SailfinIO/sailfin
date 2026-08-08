# Compiler Decomposition: Pre-Migration Baseline

**Date:** 2026-08-05 (initial baseline, monolith)
**Design:** `docs/proposals/0020-compiler-decomposition.md` §§3.3, 3.7, 8
**Companion:** `docs/proposals/0006-build-architecture.md` (Build performance)
tracks the per-module emit budget generally; this doc freezes the specific
numbers SFEP-0020's decomposition is graded against.

---

## Why this exists

SFEP-0020 decomposes the compiler into six workspace-private capsules. It
accepts one known cost up front (§3.3): the resolver enumerates every `.sfn`
source in a dependency capsule rather than the entry facade's import closure,
so once `sfn/analyzer` depends on `sfn/ir`, analyzer-only consumers — most
importantly `sfn check` — stage the entire IR capsule.

The design does not leave that to judgement. It sets a numeric rule:

> For this decision, "materially" means more than a 5% regression in the
> three-run median cold `sfn check` wall time or peak RSS against the monolith
> baseline on the same host.
>
> — SFEP-0020 §3.3

Exceeding it splits the serialized import contract into a narrow
`sfn/module-interface` capsule; staying under it does not. That rule is
unusable without a recorded "before", and §8 additionally requires cold/warm
compile time, cache hits, and peak RSS captured *before the first move*. This
page is that "before".

It measures the compiler as it stands today — one `sailfin` capsule, no
capsules extracted. Nothing here is an optimization target; it is a reference
point.

## Host and toolchain

The 5% rule is explicitly same-host. These numbers are only a valid comparand
for a re-run on an identically-specified machine.

| Field | Value |
|---|---|
| Commit | `959f2bdb2cf7dbebb7dbb57a59779974154f6da0` |
| Compiler under test | `build/bin/sfn` 0.9.1 (self-hosted via `make compile`) |
| Seed | 0.9.1 (`bootstrap.toml [seed].version`, `policy = "exact"`) |
| Capsule version | 0.9.1 (`compiler/capsule.toml`) |
| Compiler modules | 357 `.sfn` files under `compiler/src/` |
| OS / kernel | Linux 6.18.5-fc-v18, x86_64 |
| CPU | Intel Xeon @ 2.10GHz, 4 cores |
| RAM | 15.7 GiB |
| clang | Ubuntu clang 18.1.3 |
| Memory cap | default 8 GiB `RLIMIT_AS` self-cap (not overridden) |
| Captured | 2026-08-05T23:24Z |

## How caches are isolated

No user-global cache data is read, written, or deleted at any point in this
procedure. Two different mechanisms cover the two halves of the measurement,
and they are not interchangeable.

**`sfn check` has no persistent cache to isolate.** It parses, typechecks, and
effect-checks; it produces no IR and consults no build cache. Verified
empirically for this baseline: a `sfn check` invocation writes **zero** files
under `build/` and **zero** under `$HOME/.cache`. The only state that varies
between runs is the OS page cache, which the run protocol below handles with a
discarded warm-up rather than with cache flushing — `drop_caches` is
host-global, needs root, and would make the procedure unrunnable for an
ordinary developer.

**`sfn build` isolates via an explicit cache root.** `cache_root_from`
(`compiler/src/build_cache.sfn:661-690`, SFEP-0040 §3.1) resolves highest
precedence first:

1. `$SAILFIN_BUILD_CACHE_DIR` — the override this procedure uses;
2. the compiler self-host pin — `capsule.name == "sailfin"` forces in-tree
   `build/cache/<schema>`, so `make compile` never reads a developer's global
   store even without the override;
3. `$XDG_CACHE_HOME/sailfin/<schema>`;
4. `$HOME/.cache/sailfin/<schema>`;
5. in-tree `build/cache/<schema>` fallback.

Pointing `SAILFIN_BUILD_CACHE_DIR` at a fresh scratch directory therefore takes
rung 1 and never reaches rungs 3 or 4. A cold pass is a *fresh directory*, never
a deletion — `--clean` and `sfn cache clean` are deliberately not used. Each
pass also gets its own `--work-dir` so the per-invocation scratch tree
(`program.ll`, capsule staging) cannot carry over. The emitted `BuildReport`
echoes the resolved `cache.root`, which is how a re-runner confirms the
isolation actually took effect rather than assuming it.

## Procedure

Prerequisite: `make compile` (the measured binary must be the self-hosted one,
not the seed).

### A. Three-run median cold `sfn check`

For each workload: one discarded warm-up run, then three timed runs; report the
median. Wall time and peak RSS come from `/usr/bin/time`, since the compiler
self-reports neither for its own process — `process.run_capture_metered`
(`runtime/sfn/process.sfn:1154-1181`) meters only spawned children, so it cannot
measure a directly-invoked `sfn check`.

```bash
/usr/bin/time -f "%e %M" build/bin/sfn check <files...>
```

Three workloads, chosen to bracket the fixed-overhead-to-work ratio, because
that ratio is what the §3.3 rule is actually sensitive to:

| Workload | Files | What it isolates |
|---|---|---|
| `trivial` | 1 (`compiler/tests/fixtures/cli/clean_effect.sfn`) | fixed per-invocation floor — maximum sensitivity to extra capsule staging |
| `examples` | 15 (`examples/basics/*.sfn`) | a realistic small user check |
| `compiler-src` | 357 (`compiler/src/**/*.sfn`) | amortized upper bound; real analyzer work dominates |

### B. Cold and warm compiler build

```bash
CACHE=/scratch/sfep-0020/cache            # fresh directory, not a deletion
SAILFIN_BUILD_CACHE_DIR="$CACHE" /usr/bin/time -f "%e %M" \
  build/bin/sfn build -p compiler --work-dir /scratch/sfep-0020/work-cold --json
# repeat verbatim against the same $CACHE with a fresh --work-dir for the warm pass
```

Cache state is read from the `BuildReport`'s `cache` block
(`hits`/`misses`/`stores`/`hit_rate`/`root`).

### C. Per-module compile

```bash
build/bin/sfn bench --compiler --top 20 --csv /scratch/sfep-0020-monolith.csv
```

Re-emits each `compiler/src/**.sfn` module's LLVM IR in an isolated metered
subprocess. Raw output is committed as
`docs/baselines/compile-0.9.1-linux-x86_64.csv`
(`module,time_s,peak_kb,ir_lines,status,seed_version`).

## Results

### A. Cold `sfn check` — three-run medians

| Workload | Files | Wall median | Wall spread | Peak RSS median | RSS spread |
|---|---|---|---|---|---|
| `trivial` | 1 | **0.35 s** | 8.6% | **157.8 MiB** | 0.02% |
| `examples` | 15 | **0.21 s** | 0.0%¹ | **105.9 MiB** | 0.05% |
| `compiler-src` | 357 | **33.46 s** | 2.6% | **3,345.7 MiB** | 0.00% |

¹ All three runs reported 0.21 s; `/usr/bin/time %e` has 10 ms resolution, so
this is quantisation, not true zero variance. See "Applying the 5% rule".

Spread is `(max − min) / median` across the three timed runs.

Note the `trivial` > `examples` inversion on both metrics: the one-line fixture
declares `![io]` and calls `print.info`, pulling in an import closure the
`examples/basics` files do not. It is the more conservative floor of the two,
which is why it is retained.

### B. Compiler build — cold vs warm

| Pass | Wall | Peak RSS | Cache hits | Misses | Stores | `hit_rate` |
|---|---|---|---|---|---|---|
| Cold (fresh cache root) | **220.89 s** | 3,474.6 MiB | 0 | 416 | 416 | **0.00** |
| Warm (same cache root) | **83.91 s** | 3,381.7 MiB | 416 | 0 | 0 | **1.00** |

Resolved `cache.root` on both passes: `/scratch/sfep-0020/cache/v2` — confirming
the override took rung 1 and no global store participated.

The warm pass is a full 100% cache hit and still costs 83.91 s. That is the
**non-cacheable driver floor**: workspace discovery, top-level program emit,
link, and artifact publication. Cacheable per-module emit is the difference,
~137 s. This split matters for §3.7 step 8 — decomposition changes module
boundaries and cache keys, so a regression should be attributed against the
right half rather than against the 220.89 s total.

Peak RSS here is `rusage` semantics: the maximum of the driver and any *single*
waited-for child, **not** the concurrent aggregate across parallel emit workers.
Per `.claude/rules/compiler-safety.md`, the fleet ceiling is jobs × 8 GiB and is
not what this column measures.

### C. Per-module compile (monolith, 357 modules)

| Metric | Value |
|---|---|
| Modules benchmarked | 357 |
| Sum of isolated emits | 259.33 s (CSV column sums to 257.78 s; per-module values are 2 dp) |
| Harness wall / peak | 263.86 s / 1,874.4 MiB |
| Slowest module | `typed_ssa` — 8.73 s |
| Peak-RSS module | `typed_ssa` — 1,874.4 MiB (1,919,348 KB) |

The harness peak and the peak-RSS module are the same measurement: GNU
`time %M` reports the maximum over the process *and* its waited-for children, so
the harness figure is exactly the heaviest single child's `peak_kb`. The two
agreeing to the byte is a consistency check on the instrument, not two
independent readings.

Top 5 by compile time: `typed_ssa` (8.73 s), `ownership_checker` (7.49 s),
`llvm__expression_lowering__native__core_literals_lowering` (2.91 s),
`llvm__expression_lowering__native__core_ops_lowering` (2.38 s),
`llvm__expression_lowering__native__core_concurrency_lowering` (2.36 s).

The two heaviest modules are both analyzer-side, and one module alone accounts
for 1.87 GiB of the 8 GiB budget — relevant to §3.4's placement of ownership and
typed-SSA work.

## Applying the 5% rule

The §3.3 thresholds derived from the medians above:

| Workload | 5% of wall median | 5% of RSS median |
|---|---|---|
| `trivial` | 17 ms | 7.9 MiB |
| `examples` | 11 ms | 5.3 MiB |
| `compiler-src` | 1.67 s | 167.3 MiB |

**Peak RSS carries the decision; wall time cannot, below the whole-tree scale.**
This is the one methodological finding a future reader most needs:

- **Peak RSS is exceptionally stable** — spread ≤0.05% on every workload, i.e.
  two orders of magnitude inside the 5% threshold. A 5% RSS regression is
  unambiguously resolvable on any of the three workloads.
- **Sub-second wall time is not resolvable at all.** On `trivial`, run-to-run
  spread (8.6%) is *larger than the 5% threshold itself*, and on `examples` the
  11 ms budget sits at the timer's 10 ms resolution. A wall-time verdict on
  either workload would be noise.
- **`compiler-src` wall time is resolvable but has only ~2× margin** (2.6%
  spread against a 5% threshold). Usable, and worth re-running more than three
  times if a post-extraction result lands between 3% and 7%.

So: after the `sfn/analyzer` extraction (§3.7 step 4), adjudicate the
`sfn/module-interface` split on **peak RSS on the `trivial` and `examples`
workloads** — those are where whole-capsule IR staging would show up most
sharply and where the instrument is most precise — using `compiler-src` wall
time as the corroborating amortized signal. The rule reads "wall time **or**
peak RSS", so an RSS-only trigger is sufficient to force the split.

## Caveats

- **Do not compare across hosts.** `docs/baselines/compile-0.8.4-linux-x86_64.csv`
  exists and covers 302 modules against this run's 357, but it was captured on
  different hardware. The module-count growth is a structural fact; the timing
  and RSS columns are **not** comparable between the two files, and SFEP-0020's
  rule is same-host by construction.
- These numbers are a 4-core, 15.7 GiB machine. Wall times on a wider host will
  differ substantially, particularly the build passes, which fan out per-module
  emit. Peak RSS is far more portable than wall time.
- The baseline is frozen at the commit above. Re-measure rather than
  extrapolate if `compiler/src/` has moved materially before the comparison.
- Following the house convention in `docs/perf/runtime-performance.md`, append
  dated post-migration sections below rather than editing the frozen numbers.

## 2026-08-08 — SFN-736 import-context ownership observation (Darwin arm64)

This re-run covers the two workloads named by SFN-736 after import-context
artifact discovery and reads moved from LLVM lowering into the compiler driver.
It is an **observation, not a §3.3 5% adjudication**, because the frozen
baseline host is Linux x86_64 and this development host is Darwin arm64. The
same-host rule above forbids treating the deltas as an implementation effect.

| Field | Value |
|---|---|
| Base commit plus working change | `68350cf538c0059ee8693e1be3d642d34ad86951` + SFN-736 |
| Compiler under test | `build/bin/sfn` 0.9.1, self-hosted with `make compile` |
| Seed / capsule version | 0.9.1 / 0.9.1 |
| Compiler modules | 367 `.sfn` files under `compiler/src/` |
| OS / kernel | Darwin 27.0.0, arm64 |
| CPU / logical CPUs | Apple M2 Max / 12 |
| RAM | 64 GiB |
| clang | Homebrew clang 17.0.6 |
| Memory cap | default 8 GiB `RLIMIT_AS` self-cap (not overridden) |
| Captured | 2026-08-08T16:32Z |

Procedure matched section A: one discarded warm-up followed by three runs per
workload. GNU time was `/opt/homebrew/bin/gtime -f "%e %M"` because Darwin's
`/usr/bin/time` does not support GNU `-f` formatting.

| Workload | Files | Timed runs (wall s / peak KiB) | Wall median | Peak RSS median | RSS spread |
|---|---:|---|---:|---:|---:|
| `trivial` | 1 | `0.28 / 204240`, `0.28 / 204240`, `0.28 / 204192` | **0.28 s** | **199.5 MiB** | 0.02% |
| `examples` | 15 | `0.14 / 111216`, `0.14 / 111216`, `0.14 / 111200` | **0.14 s** | **108.6 MiB** | 0.01% |

Both commands exited 0 on every timed run. The measured check paths performed
no LLVM lowering. A future Linux x86_64 run on the frozen baseline host remains
required before these values can accept or reject the optional
`sfn/module-interface` split under SFEP-0020 §3.3.
