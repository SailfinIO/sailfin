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

It records the pre-decomposition compiler — one root capsule, before role
capsules were extracted. The root is now `sfn/compiler`; nothing here is an
optimization target, only a historical reference point.

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
2. the compiler self-host pin — `capsule.name == "sfn/compiler"` forces in-tree
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

## 2026-08-15 — SFN-747 §3.3 adjudication (Linux x86_64, five-point series)

**Verdict: over the 5% gate.** Three-run median cold `sfn check` peak RSS on the
`trivial` workload regressed from **157.7 MiB to 696.3 MiB (+341.5%)** between
the monolith baseline and the current tree — **68× the 7.9 MiB budget**. The
`sfn/analyzer` extraction's own isolated marginal cost is **+35.0%**, itself 7×
the gate. Recorded in SFEP-0020 §3.3.

The verdict carries a second finding that matters more than the number: the
regression is **not** caused by the `sfn/analyzer -> sfn/ir` edge that §3.3's
prescribed remedy targets, so the `sfn/module-interface` split would not
resolve it. See "Why the sanctioned remedy does not match the cause" below.

### Host and toolchain

| Field | Value |
|---|---|
| Commits measured | five points, `959f2bdb` … `cd64ea05` (table below) |
| Compiler under test | `build/bin/sfn`, self-hosted at each commit via `make compile` |
| Seed | each commit's own `bootstrap.toml [seed].version` (0.9.1 / 0.9.3 / 0.9.5) |
| OS / kernel | Linux 6.18.5-fc-v20, x86_64 |
| CPU | Intel Xeon @ 2.80GHz, 4 cores |
| RAM | 15.7 GiB |
| clang | Ubuntu clang 18.1.3 |
| Memory cap | default 8 GiB `RLIMIT_AS` self-cap (not overridden) |
| Captured | 2026-08-15T01:1xZ |

**This host is not the frozen baseline host** — same kernel line, same core
count, same RAM, same clang, but a 2.80GHz Xeon against the baseline's 2.10GHz.
The same-host rule is nonetheless satisfied, by re-measuring the monolith
commit here rather than by asserting hardware equivalence. That re-measurement
reproduced the frozen numbers to within 0.2 MiB on all three workloads:

| Workload | Frozen baseline (2026-08-05 host) | Re-measured here (M0) | Delta |
|---|---:|---:|---:|
| `trivial` | 157.8 MiB | 157.7 MiB | −0.1 MiB |
| `examples` | 105.9 MiB | 105.8 MiB | −0.1 MiB |
| `compiler-src` / `allsrc` | 3,345.7 MiB | 3,345.5 MiB | −0.2 MiB |

**Peak RSS is portable across these two hosts; wall time is not.** The same
monolith commit takes 33.46 s on the baseline host and 43.60 s here on
`allsrc` — a 30% wall difference against a 0.006% RSS difference. This
retrospectively strengthens the frozen document's "peak RSS carries the
decision" finding: RSS survives a host change that would have made any
wall-time verdict meaningless.

### Three corrections to the frozen procedure

**1. `compiler-src` is not comparable as literally defined, and was replaced.**
The frozen workload is `compiler/src/**/*.sfn`. The extractions *move* those
files into `compiler/capsules/*/src/`, so that glob falls 357 → 129 while the
compiler's actual source count *grows* 357 → 385. Measuring the frozen glob at
HEAD would have reported a large fake improvement from checking 64% fewer
files. This section therefore uses **`allsrc` = `compiler/src` +
`compiler/capsules/*/src`**, and the file count is printed in every row so the
+7.8% growth in real work is visible rather than hidden.

**2. `trivial` and `examples` measure different things, and only `trivial`
exercises the mechanism under adjudication.** The frozen document attributes
the `trivial` > `examples` inversion to `![io]` and `print.info` pulling a
wider import closure. That is not the main cause. `trivial`
(`compiler/tests/fixtures/cli/clean_effect.sfn`) sits under `compiler/`, which
carries a `capsule.toml`; `examples/basics/*.sfn` has no capsule manifest above
it (only the root `workspace.toml`). Project-root discovery therefore resolves
the compiler's capsule graph for `trivial` and resolves nothing for `examples`.
This makes `examples` a **negative control** rather than a second reading of
the same quantity — a role the frozen document did not know it had.

**3. Both fixtures were verified byte-identical across all five commits**
(SHA-256 of the `trivial` fixture and of the `examples/basics` tree), so the
primary signal is a controlled comparison and not a moving target.

### Measurement points

| Label | Commit | Seed | What landed | `compiler/src` | capsules |
|---|---|---|---|---:|---:|
| M0 | `959f2bdb` | 0.9.1 | monolith — the frozen baseline commit | 357 | 0 |
| M1 | `b28fec58` | 0.9.3 | import-context reads moved into driver (#2856) | 368 | 0 |
| M2 | `03598a6b` | 0.9.3 | `sfn/syntax` (#2872) + `sfn/ir` (#2878) extracted | 323 | 49 |
| M3 | `91ee684a` | 0.9.3 | `sfn/analyzer` extracted (#2880) | 275 | 98 |
| M4 | `cd64ea05` | 0.9.5 | `sfn/codegen` (#2908) + `sfn/codegen-llvm` (#2909) | 129 | 256 |

The issue that commissioned this run assumed HEAD was the post-analyzer point.
It is not — two further extractions landed after #2880, so M3 is the
post-analyzer reading and M4 is the current tree. Isolating M3 is what makes
the analyzer's marginal cost visible at all.

### A. Cold `sfn check` — three-run medians, all five points

Procedure matched frozen section A: one discarded warm-up, three timed runs,
`/usr/bin/time -f "%e %M"`. Every run of every workload at every point exited 0.
All 45 raw per-run values are committed as
`docs/baselines/check-sfep0020-adjudication-linux-x86_64.csv`
(`label,sha,workload,files,run,wall_s,peak_kb,exit`), so every median below is
recomputable from the record rather than taken on trust.

**`trivial` (1 file, inside the compiler capsule project) — the primary signal**

| Point | Wall median | vs M0 | Peak RSS median | vs M0 | RSS spread |
|---|---:|---:|---:|---:|---:|
| M0 monolith | 0.51 s | — | **157.7 MiB** | — | 0.07% |
| M1 import-context | 0.72 s | +41.2% | **206.9 MiB** | **+31.2%** | 0.06% |
| M2 post-syntax+ir | 1.33 s | +160.8% | **342.8 MiB** | **+117.4%** | 0.03% |
| M3 post-analyzer | 1.86 s | +264.7% | **462.9 MiB** | **+193.5%** | 0.02% |
| M4 current tree | 3.16 s | +519.6% | **696.3 MiB** | **+341.5%** | 0.02% |

**`examples` (15 files, no capsule manifest above them) — negative control**

| Point | Wall median | Peak RSS median | vs M0 | RSS spread |
|---|---:|---:|---:|---:|
| M0 | 0.31 s | 105.8 MiB | — | 0.07% |
| M1 | 0.32 s | 109.4 MiB | +3.3% | 0.04% |
| M2 | 0.35 s | 114.7 MiB | +8.3% | 0.14% |
| M3 | 0.34 s | 116.2 MiB | +9.8% | 0.06% |
| M4 | 0.40 s | 132.7 MiB | +25.4% | 0.13% |

**`allsrc` (whole compiler tree) — corroborating amortized signal**

| Point | Files | Wall median | vs M0 | Peak RSS median | vs M0 |
|---|---:|---:|---:|---:|---:|
| M0 | 357 | 43.60 s | — | 3,345.5 MiB | — |
| M1 | 368 | 44.19 s | +1.4% | 3,391.0 MiB | +1.4% |
| M2 | 372 | 33.29 s | −23.6% | 2,817.8 MiB | −15.8% |
| M3 | 373 | 33.88 s | −22.3% | 3,050.9 MiB | −8.8% |
| M4 | 385 | 37.10 s | −14.9% | 2,847.6 MiB | −14.9% |

The amortized workload **improved** by 14.9% on both metrics while checking 28
more files. The decomposition is not globally more expensive — it moved cost
from the amortized path onto the fixed per-invocation floor, which is precisely
the ratio the frozen document chose these three workloads to bracket.

### The mechanism, measured directly

The cost is capsule-graph resolution at check time, and it can be isolated
without reference to any historical commit. Copying the `trivial` fixture
outside any project (identical bytes, verified by SHA-256) and checking both
with the same M4 binary:

| Target | Wall | Peak RSS | Result |
|---|---:|---:|---|
| `compiler/tests/fixtures/cli/clean_effect.sfn` (in project) | 3.16 s | **696.3 MiB** | `checked 1 files: ok` |
| `/tmp/probe/clean_effect.sfn` (identical bytes, no project) | 0.33 s | **131.8 MiB** | `checked 1 files: ok` |

Same source, same verdict, **5.3× the memory and 9.6× the wall time.** The
entire difference is capsule resolution and staging. Two corroborations: the
out-of-project figure (131.8 MiB) matches the `examples` median (132.7 MiB),
confirming `examples` resolves no capsule graph and is a true control; and the
in-project figure at M0, when `compiler/capsule.toml` declared no internal
capsule dependencies, was 157.7 MiB.

The code path was traced independently of the measurement:
`_cr_collect_capsule_sources` (`compiler/src/capsule_resolver/discovery.sfn:181-251`)
walks a dependency capsule's entire `src/` tree and pushes every `.sfn` file,
with no import-relevance test, driven transitively through declared
`[dependencies]` (`discovery.sfn:552-575`). SFN-833 / SFEP-0070 added an
import-reachability filter that narrows this to the reachable closure — but
`sfn check` deliberately does **not** call it
(`compiler/src/capsule_resolver/reachability.sfn:648-665`), on the invariant
that check's staged set must remain a superset of build's. So check pays the
unfiltered cost by design.

### Applying the 5% rule

Thresholds derived from the M0 medians re-measured on this host:

| Workload | 5% of wall median | 5% of RSS median | Measured RSS regression | Verdict |
|---|---:|---:|---:|---|
| `trivial` | 26 ms | 7.9 MiB | **+538.6 MiB** | **over — 68×** |
| `examples` | 16 ms | 5.3 MiB | +26.9 MiB | over — 5.1× |
| `allsrc` | 2.18 s | 167.3 MiB | −497.8 MiB | under (improved) |

The gate is exceeded on the primary signal by any reading. Isolating the
`sfn/analyzer` extraction alone (M2 → M3, an interval spanning only 5 commits):
**+120.1 MiB, +35.0%** on `trivial` — 7× the gate on its own, and the tightest
attribution in the series.

The `examples` control also exceeds the gate (+25.4%), but it resolves no
capsule graph, so that drift is ordinary compiler growth across 154 commits and
is not attributable to decomposition. Netting it out, the capsule-attributable
share of the `trivial` regression is roughly 316 percentage points of the 341.5.

### Why the sanctioned remedy does not match the cause

§3.3 permits exactly one remedy for an over-gate result: split the serialized
import contract into a narrow `sfn/module-interface` capsule. The measurements
say that remedy would not fix what was measured.

§3.3's cost model is the `sfn/analyzer -> sfn/ir` edge making *analyzer-only
consumers* stage the whole IR capsule. But `compiler/capsule.toml` declares all
five internal capsules **directly** — at M0 it declared none:

```toml
# HEAD                          # M0 (959f2bdb)
"sfn/syntax"      = "*"         (no internal capsule dependencies)
"sfn/ir"          = "*"
"sfn/analyzer"    = "*"
"sfn/codegen"     = "*"
"sfn/codegen-llvm" = "*"
```

So checking a file in the compiler project enumerates all five capsules through
the root manifest, whether or not `sfn/analyzer` names `sfn/ir`. The regression
tracks the *number of declared capsules*, not that one edge — each extraction
adds cost of the same order (syntax+ir +136 MiB, analyzer +120 MiB,
codegen+codegen-llvm +233 MiB). Splitting `sfn/module-interface` would remove
part of one 120 MiB contribution out of a 539 MiB regression, leaving the great
majority in place. There is also no analyzer-only consumer in the tree today —
only one binary capsule exists, and it depends on all five — so the specific
shape §3.3 reasoned about is currently hypothetical.

The remedy the evidence points to is extending the SFN-833 reachability filter
to the check path. That is not one of the two approaches §3.3 forbids (it
neither moves artifact parsing into the analyzer nor restores a generic common
capsule), but it is also not the remedy §3.3 sanctions, so it needs an explicit
design decision rather than an implementer's judgement call. Filed as a
follow-up rather than decided here.

### Caveats

- **Each point self-hosts from its own pinned seed** (0.9.1 / 0.9.3 / 0.9.5),
  so the measured binary's codegen partly reflects the seed that built it. This
  matches how the frozen baseline was produced — each point is the compiler as
  it actually was at that commit — but it is a genuine confound for
  seed-sensitive quantities. It does not plausibly explain a 341% RSS change
  whose mechanism is independently traced to source enumeration, and the M0
  re-measurement reproducing the frozen numbers to 0.2 MiB bounds seed-to-seed
  drift on this instrument as very small.
- **Intervals are not single commits.** M0→M1 spans 48 commits, M1→M2 27, M3→M4
  74. Only **M2→M3 (5 commits)** is a tight attribution — which is fortunate,
  since that is the analyzer interval the gate is actually about. The other
  deltas should be read as "the wave", not as single changes.
- The `trivial` workload is the compiler's own tree, whose root manifest
  declares five internal capsules. An ordinary user project declaring one or
  two dependencies pays a proportionally smaller cost. The regression is real
  for anyone running `sfn check` inside a multi-capsule project, but 341% is
  the compiler's own figure, not a universal user-facing number.
- Wall time is reported for completeness and corroborates the RSS story on
  `trivial` (+519.6%), but per the frozen document's resolvability analysis the
  sub-second wall readings do not independently carry the verdict.
