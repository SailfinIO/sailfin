# Perf history: the `bench-data` branch

**Companion:** `docs/proposals/0037-peer-language-process-adoption.md` §3.3
(the design record) and `docs/proposals/0006-build-architecture.md` (the <5 min
build budget). Workflow: `.github/workflows/perf-history.yml`. Logic:
`scripts/perf_history.sh`.

## What it is

`bench-data` is an **orphan branch** — it shares no history with `main` and
holds only benchmark CSVs. The nightly `perf-history.yml` job builds the
compiler from the pinned seed, runs `make bench` (per-module compile time +
peak RSS) and `make bench-runtime`, tags each row with the commit SHA and run
date, and **appends** them. Over time the branch becomes a performance time
series in the spirit of [perf.rust-lang.org] and the LLVM compile-time tracker —
history with alert thresholds, not one-shot artifacts. The motivating incident
is #1245: a memory regression that killed CI runners before anyone noticed,
because there was no history to notice it against.

The CSV on the branch is the deliverable; a dashboard can consume it later. The
job never touches the bench harnesses or their budgets — it only records and
compares their output.

## Files on the branch

| File | Columns |
|---|---|
| `compile.csv` | `run_sha,run_date,` + `scripts/bench_compile.sh --csv` header (`module,time_s,peak_kb,ir_lines,status,seed_version`) |
| `runtime.csv` | `run_sha,run_date,` + `scripts/bench_runtime.sh --csv` header (`workload,inner_ms_min,inner_ms_median,peak_kb,ops,ops_per_ms,status,seed_version,platform`) |
| `build.csv` | `run_sha,run_date,build_wall_s,budget_s` |

Every nightly run appends one block of rows to each file. Append is
**idempotent per commit**: if a run's SHA is already in `compile.csv`, re-running
the job is a no-op (safe manual re-runs).

## How regressions are detected

For each module in the current run, the compare step takes the **rolling median
of the last N runs** (default `N=7`, `PERF_MIN_RUNS`) and flags the module if
the current value exceeds that median by more than the threshold (default
`10%`, `PERF_THRESHOLD_PCT`) on either **wall-time** (`time_s`) or **peak RSS**
(`peak_kb`). Median-of-N plus a percentage floor exist precisely to absorb the
run-to-run jitter of shared CI runners — single-run deltas never alert.

Cold start is a clean no-op: fewer than `N` prior runs (or a module without `N`
baseline samples, e.g. a newly added module) is skipped rather than compared
against thin history. Only `FAIL` rows are excluded (a failed compile has no
meaningful timing); `SLOW`/`HIGHMEM` rows carry valid measurements and stay in
the comparison.

**Runtime scope.** `runtime.csv` is recorded on the branch every night, but the
comparison/auto-filing is currently **module-scoped** (compile bench +
whole-build budget). Per-workload runtime-regression alerting is a deferred
SFEP-0037 §3.3 follow-up — the runtime series accumulates now so the future
dashboard (and later alerting) has history to work with.

### The whole-build budget is measured separately

`bench_compile.sh` sums **isolated** per-module `emit llvm` timings; that serial
sum is **not** the parallel clean-build wall-time the SFEP-0006 `<5 min`
(`300 s`) target measures. So the job times a real `make rebuild` and records
that wall-time in `build.csv`; the compare step checks *that* number against the
budget (`BUILD_BUDGET_S`), never the per-module sum.

## What happens on a regression

The job auto-files **one `type:perf` issue per offending module**, titled
`perf regression: <module>`. Dedup mirrors `build-quality.yml`: the
`perf-regression` label plus exact title equality — an open issue for the same
module gets a comment instead of a duplicate. The `<whole-build>` pseudo-module
carries a build-budget breach. Reverting the regression files nothing new; the
next clean run simply detects no regression.

## Reading / reproducing locally

```bash
# Inspect the series (read-only; no local checkout of the orphan branch needed)
git fetch origin bench-data
git show origin/bench-data:compile.csv | column -t -s,

# Reproduce a module's number locally (same harness the job runs)
make compile
make bench BENCH_ARGS="--csv /tmp/compile.csv --top 20"
make bench-runtime BENCH_RUNTIME_ARGS="--csv /tmp/runtime.csv --top 20 --iterations 5"

# Exercise the compare logic offline against synthetic history
scripts/perf_history.sh compare --data-dir <dir> --sha <sha> --out /tmp/reg.tsv
```

To validate auto-filing end-to-end, dispatch the workflow with
`synthetic_slowdown_module=<module>` — it injects a 2× slowdown for that module
into a **scratch copy** (the pushed series stays honest) and files exactly one
issue. Use `dry_run=true` to run the benches + compare without pushing to
`bench-data` or filing issues (a safe green trial).

[perf.rust-lang.org]: https://perf.rust-lang.org
