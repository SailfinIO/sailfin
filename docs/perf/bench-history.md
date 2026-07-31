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
| `compile.csv` | `run_sha,run_date,` + `sfn bench --compiler --csv` header (`module,time_s,peak_kb,ir_lines,status,seed_version`) |
| `runtime.csv` | `run_sha,run_date,` + `sfn bench benchmarks/runtime --csv` header (`workload,inner_ms_min,inner_ms_median,peak_kb,ops,ops_per_ms,status,seed_version,platform`) |
| `build.csv` | `run_sha,run_date,build_wall_s,budget_s` |

Every nightly run appends one block of rows to each file. Append is
**idempotent per commit, per file**: each of `compile.csv`, `runtime.csv`, and
`build.csv` is guarded on its own SHA column, so re-running the job never
duplicates rows — even after a partial run where one bench aborted before
writing its CSV and only the others were recorded (safe manual re-runs).

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

`sfn bench --compiler` sums **isolated** per-module `emit llvm` timings; that serial
sum is **not** the parallel clean-build wall-time the SFEP-0006 `<5 min`
(`300 s`) target measures. So the job times a real `make rebuild` and records
that wall-time in `build.csv`; the compare step checks *that* number against the
budget (`BUILD_BUDGET_S`), never the per-module sum.

They also do not measure the same **binary**. `sfn bench --compiler` times the
compiler that was just self-hosted (`build/bin/sfn`) running emit only, with no
`clang -c` and no link. `build_wall_s` times the **pinned seed** compiling the
whole tree, link included. So an improvement to *generated-code quality* reaches
the bench series a full seed generation before it reaches the wall series: the
compiler the seed produces gets faster immediately, while the seed's own body
stays as the previous generation emitted it. Read a bench/wall divergence across
a seed bump as that lag before reading it as a regression — 2026-07-26 showed
bench dropping 57% on the same night wall time hit its series maximum
(`docs/rca/2026-07-30-whole-build-wall-time-budget-breach.md`).

Two consequences worth keeping in mind when reading `build.csv`:

- **The number is only valid cold.** The same tree rebuilt warm measures ~27%
  lower. CI is cold by construction (fresh checkout, fresh `build/`); a local
  comparison is not, unless you clear `build/` first.
- **Wall time grows with the tree at roughly constant cost per IR line.** Divide
  `build_wall_s` by that night's `Σ ir_lines` from `compile.csv` before calling
  anything a regression — a rising raw wall time at flat cost-per-line is the
  tree growing into a fixed budget, which needs headroom, not a bisect.

## Enforcement

A breach **fails the nightly**. The final `Enforce the whole-build wall-time
budget` step exits non-zero when `build_wall_s > BUILD_BUDGET_S`, and emits a
`::warning` once a run reaches `BUILD_HEADROOM_WARN_PCT` (`90`) of the budget. It
runs after issue-filing and artifact upload, so a breach still leaves its full
record behind, and it is skipped on a `dry_run` dispatch so that trial stays
green. Before this existed a breach only filed an issue and the job stayed green,
which is how a two-week run of over-budget nightlies went unremarked in 2026-07
(SFN-421).

It enforces the `build_wall_s` **recorded in `build.csv` for the commit**, not
the stopwatch of the run it is in. Because append is idempotent per commit, a
re-run against an already-recorded SHA re-measures without re-recording; reading
the row is what keeps the gate and the auto-filed issue from disagreeing inside
one job summary. When the two differ the step logs both.

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

## Attributing a regression to a pass, and to a commit

`build.csv` can tell you a seed step got slower. It cannot tell you *which pass*
or *which commit* — the µs-per-IR-line ratio localises to a seed generation and
stops there. SFN-613 (per-unit cost +20.7% at seed `0.8.4`) was closed with two
techniques worth reusing, neither of which needs new instrumentation.

**Attribute to a pass with `sfn emit --timing`.** `sfn emit --timing llvm <file>`
prints `[timing] module=<name> phase=<parse|typecheck|emit_native|lower_llvm|total> ms=<n>`
to stderr (`compiler/src/main.sfn:78-90, 470-558`). Running it under two seeds on
an **identical** source tree isolates the pass. For SFN-613 that showed
`lower_llvm` up +32% to +96% while every other phase stayed flat, and — decisively
— the emitted `.ll` was **byte-identical** between the seeds. Identical output at
higher cost means the regression is analysis that emits nothing, which rules out
whole categories of suspect at once. It is not wired into the build fan-out
(`capsule_emit_parallel.sfn`); SFN-614 tracks that.

**Attribute to a commit by holding the seed constant.** `make rebuild
SEED_NATIVE=<abs path>` overrides the tree's own `bootstrap.toml` pin, so
building each candidate commit with the *same* seed varies only source logic.
Run it once on the older tag first as a control: v0.8.2's source built by seed
`0.8.4` matched seed `0.8.2`'s own timing, proving the regression was in source
logic rather than in the quality of the `0.8.4` binary — which is what the
one-generation lag above would otherwise suggest.

Two traps this cost time on, both worth checking first:

- **The session clone may be shallow.** A grafted history makes `git log
  <tag>..<tag>` and `git merge-base --is-ancestor` silently wrong — the SFN-613
  delta looked like 3 commits when it is 32. Run `git rev-parse
  --is-shallow-repository` before drawing any conclusion from history, and
  prefer **content checks** (`git cat-file -e <tag>:<path>`), which are immune.
- **Expensive code is not the same as hot code.** A quadratic walk added in the
  same window (`emission_reachability.sfn`) looked like an obvious culprit and
  measured as a no-op, because it only runs for functions lacking a terminator.
  Confirm a candidate by measuring it, not by reading its complexity.

### Recorded outcome — SFN-613

Attributed to `07f8d64ea` (saturating float-to-integer casts):
`ensure_intrinsic_declarations` (`llvm/lowering/lowering_io.sfn`) scanned the
whole emitted line array once per (operation, int type, float type) combination
— 24 unconditional scans per module, emitting nothing for source that uses no
saturating intrinsic. Fixed in place (single prefiltered pass, detection
unchanged), returning `lower_llvm` to the `0.8.2` baseline with byte-identical
IR. Not an accept-with-rationale: the fail-closed guarantee was never the cost,
its implementation was.

[perf.rust-lang.org]: https://perf.rust-lang.org
