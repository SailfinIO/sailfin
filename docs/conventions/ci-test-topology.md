# CI test topology

How `sfn test`'s surface is partitioned across CI legs, budgeted for
parallelism, and cached — as it stands today. The design behind the
content-addressed test-binary cache and the deterministic shard partition
lives in `docs/proposals/0011-ci-test-speed.md`; this page is the
operational map: shard names, job counts, cache plumbing, and where each
gate runs. No wall-clock timings here — those drift out of date faster than
this file is read.

## Shard taxonomy

The shard map is owned by the compiler, not bash. `scripts/test_shards.sh`
does not exist; `compiler/src/cli/commands/dev_shard.sfn:1-16` records that
`sfn dev shard` retired it.

Two independent partitioning mechanisms exist, at different layers:

- **`sfn test --shard I/N`** — a generic, stable-stride partition available
  on any `sfn test` invocation. `_parse_shard_field_at` and
  `_shard_keeps_index` (`compiler/src/cli/commands/test/arg_and_jobs.sfn:184-246`)
  implement the rule: a 0-based file index belongs to shard `I` of `N` when
  `item_index % N == I - 1`. Deterministic and stable across runs for a
  fixed sorted file list. **This is unchanged by SFN-863** — plain
  `--shard I/N` always stays the alphabetical stride, not the file-count
  stride it was previously described as ("file-count-balanced" was true only
  in the trivial sense that shard sizes differ by at most one file; it says
  nothing about *time* balance, which is what named shards need).
- **Named CI shards** — `sfn dev shard`
  (`compiler/src/cli/commands/dev_shard.sfn`). `_shard_defs()`
  (`:59-89`) hardcodes eight shards:
  - `unit-a`, `unit-b`, `unit-c` — a 3-way split of `compiler/tests/unit`
  - `int-caps` — `compiler/tests/integration` + `capsules`, unsplit
    (`total: 0` means "run the whole discovery")
  - `e2e-a`, `e2e-b`, `e2e-c`, `e2e-d` — a 4-way split of
    `compiler/tests/e2e`

  Since SFN-863 these are **time-weighted**, not file-count-balanced: each
  shard's `I/N` partition is greedy LPT (longest processing time) over a
  per-file weight, not the plain stride. Measured macOS e2e shard totals
  under the old stride were 3716 / 1746 / 3146 / 2243 s (2.13x skew).
  Treat *simulated* balance as no evidence at all: SFN-883's table modeled
  its four legs balanced to 32 parts in 268,000 — 0.01% predicted imbalance
  — and those legs measured 1.48x-1.85x across two runs. Only measured
  wall-clock counts
  (`docs/measurements/e2e-shard-weights-2026-08-31.md`).

`sfn dev shard run <name>` re-parses the shard's roots into an ordinary
`sfn test <roots> --shard I/N --shard-weights <table>` invocation and runs it
through the same pipeline, so a named shard's toolchain gate, per-test cache,
and JSONL reporting are identical to a direct `sfn test` call
(`dev_shard.sfn:224-265`). `sfn dev shard list`/`run`/`cover` all resolve the
same `I/N` files through `_shard_lpt_keeps`
(`compiler/src/cli/commands/test/arg_and_jobs.sfn`), so they can never
disagree about which files a shard owns.

### The weight table

`compiler/tests/shard_weights.tsv` is a generated `path\tweight` table (one
`#`-prefixed comment header, then one row per test file):

```
path	weight
compiler/tests/e2e/aarch64_binfmt_probe_test.sfn	816
```

`weight = round(1e6 * max over targets of (file_elapsed / suite_total))` — a
*share* of one target's suite time, not a raw duration, so the same table
balances hosts running at different absolute speeds (macOS-arm64 measured
8565 s against Linux-arm64's 5088 s on run 33407348555 — 1.68x). Each
target's measured suite total is printed in the generated header, so that gap
is re-derived on every refresh rather than quoted from memory.

**It is a ranking signal, not a per-file cost model**, and SFN-863's
"target-neutral by construction" wording overstated it. Measured on run
33407348555 (SFN-1223), a file's share differs *between* the two targets by
p10-p90 = 0.83x-1.66x, and the same file's weight moves *between runs* by
p10-p90 = 0.66x-1.51x once the suite-growth median shift is divided out (raw,
0.575x-1.314x), with one file in ten moving more than 2x. So `max over
targets` picks whichever target gave that file the larger share of its own
suite — not whichever host is slower, which the normalisation cancels. The
table reliably separates a
100,000-weight file from a 500-weight one; it does not tell you what any
single file costs. A discovered file absent from the table gets the median of
the loaded table (`_shard_default_weight` in
`compiler/src/cli/commands/test/arg_and_jobs.sfn`) rather than 0, so a newly
added test still lands in a plausible LPT slot instead of always sorting
last. SFN-863 hardcoded that default as the constant `2136` — the table's
median at generation time — but the copy drifted from the table's actual
median across two regenerations (SFN-883, SFN-1223) before SFN-1224 made it
derive the median from the loaded table at load time instead, so it can no
longer decay.

**Coverage signal.** `sfn dev shard cover` also reports how much of the
discovered test surface has no weight row: a `[shard-weights]` line naming
the count and percentage uncovered, and the value unlisted files fall back
to. Above 15% uncovered it additionally prints a `WARN` to stderr (with up to
10 of the uncovered paths) telling you to regenerate the table — but it never
fails the build; the weight table is a scheduling hint, not a correctness
gate. 15% is chosen against the measured decay rate — 53 `*_test.sfn` added
per week on average over the 8 weeks to 2026-09-01, against an 884-file
surface, so coverage sheds ~6% per week — which puts the threshold roughly
2.5 weeks after a refresh: about once per refresh cycle rather than on every
PR. It is deliberately not calibrated on *modeled* leg spread, per the rule
above; what an unweighted file costs in wall-clock is exactly the thing the
missing row denies us.

**Fail-open.** `sfn dev shard` and `sfn test --shard-weights <path>` both
fall back to the plain alphabetical stride whenever the table is missing,
unreadable, or has zero parseable data rows
(`_shard_weight_table_row_count` in `arg_and_jobs.sfn`) — a stale or deleted
table degrades the partition's balance, it never fails a build or a test
run.

**Where the per-file timing lives.** Every `macos-arm64` and `linux-arm64`
shard leg uploads its JSONL sidecar as a run artifact named
`ci-test-timing-<target>-<shard>`, retained 90 days (SFN-866). Download those
from any run to get `file_elapsed_ms` per file without re-running anything —
not `duration_ms`, which is only that row's even-distribution per-test slice
(SFN-1222). A grouped macOS leg (SFN-873) contributes one sidecar per shard
it ran.

`linux-x86_64` legs deliberately emit **no** sidecar: they keep the
byte-identical human output path so one leg still exercises it
(`sailfin-build/action.yml:410-414`). The two arm64 targets therefore build
the whole table, and **every `linux-x86_64` weight is an extrapolation**
across exactly the cross-target gap measured above — expect its partition to
balance less well than the targets that were measured. See SFN-862 before
changing that.

**Refreshing it.** Do not re-derive the arithmetic by hand — run the script
CI already runs, so the applied table and the CI candidate are produced by
one implementation:

```bash
gh run download <run-id> -R SailfinIO/sailfin -p 'ci-test-timing-*' -D ci-timing
scripts/aggregate_shard_weights.sh ci-timing compiler/tests/shard_weights.tsv
```

It dedupes each file's `file_elapsed_ms` per target (rows for the same file
all carry the same value, so summing rather than deduping would multiply the
weight by the test count), divides by that target's suite total, takes the
max share across targets, and scales by `1e6`. It also prints each target's
measured suite total into the header. Two provenance lines are **not**
generated and must be re-added by hand, as the committed table carries them:
`# Source: run <id> JSONL sidecars (<date>) ...` and
`# Refresh procedure: docs/conventions/ci-test-topology.md.` Re-add them
where the committed table carries them — directly after the generated
`# Targets contributing:` line — so a refresh diffs clean against the
`shard-weights-candidate` artifact instead of showing a reordered header.
Do not hand-add
a median: a derived number nothing recomputes is how the previous header's
"median (282)" became a stale authority.

Every run's `shard-weights-candidate` job (`ci.yml`) runs the same script on
that run's sidecars and uploads the result plus a drift summary, so a
candidate usually already exists — check it before downloading anything. A
regeneration that disagrees with the candidate for the same run is a bug in
one of the two, not a judgement call.

There is no automated refresh job — a stale table only costs balance, per the
fail-open guarantee above, so refreshing is a manual maintenance task rather
than a release gate.

`sfn dev shard run <name>` builds the compiler first if the binary is
missing, and honors `SAILFIN_AGENT_REPORT=1` to tee JSONL to
`build/agent-test.shard-<name>.jsonl`.

## The cover invariant

`sfn dev shard cover` (`_shard_cover()`, `dev_shard.sfn:272`) asserts that
the eight shards' file sets are disjoint, exhaustive, and contain nothing
outside the surface `sfn test` discovers
(`compiler/tests/unit`, `compiler/tests/integration`, `compiler/tests/e2e`,
`capsules` — `_make_test_roots()`, `dev_shard.sfn:94-96`). CI runs this as
the `shard-cover` job in `.github/workflows/ci.yml`, via `sfn dev shard
cover`.

This lint is mandatory, not advisory: it is the only thing standing between
rebalancing the shard map and silently ceasing to run a group of tests. A
file added to `compiler/tests/unit` that no shard's stride happens to catch
would otherwise pass every leg green while never executing.

## Job budget and how it composes

Two independent parallelism knobs exist and multiply if not bounded
together:

1. **Across-leg sharding** — the eight named CI shards, run as separate
   jobs (see below).
2. **Per-file parallelism within a leg** — `_test_jobs_budget(memsize_bytes,
   nproc, is_darwin)` (`compiler/src/cli/commands/test/arg_and_jobs.sfn:85-118`):
   `min(cores, (usable_RAM - 5 GiB) / 3 GiB)`, floored at 1, capped at 16,
   and capped at 2 on Darwin, where `usable_RAM` is 80% of total RAM (the
   same name the code gives the pre-subtraction slice) and the 5 GiB
   subtrahend reserves the parent runner (SFN-781). Resolution precedence in
   `_resolve_test_jobs` (`:189-198`): an explicit `--jobs` flag beats
   `SAILFIN_TEST_JOBS`, which beats the native host probe. The pre-binary
   bash duplicate that once computed its own default is retired (SFN-1158 /
   SFEP-0074 §5.2), along with the parity test that cross-checked it —
   `sfn test`/`sfn dev verify` omit `--jobs` and let the native probe size
   the pool; `SAILFIN_TEST_JOBS=N` is the sole override.

Pooled test children are pinned to `SAILFIN_BUILD_JOBS=1`
(`compiler/src/cli/commands/test/pool.sfn:219-221`) so a pooled child that
itself triggers a build cannot fan its emit out again and multiply the
budget (SFN-547) — see `.claude/rules/compiler-safety.md`, which owns the
memory-budget contract this composes with.

CI's Linux x86_64 and macOS arm64 legs set `shard_test_jobs: "3"`, which pins
per-file parallelism *within* each shard leg on top of across-leg sharding.
The aarch64-Linux legs deliberately leave that input empty: each 4-vCPU/16-GiB
runner applies the native CPU+RAM test budget (currently 2 children) rather
than overriding the SFN-781 memory guard.

A 2026-07-01 measurement sweep concluded that tree-wide peak RSS stays flat
or drops as test-suite `--jobs` rises, because test-fixture emits are far
lighter than a heavy compiler-module emit, and that memory was therefore
never the binding constraint for the test surface. **SFN-781 retracted that
finding.** It held only for cached runs, where most children never compile:
a cold `--no-test-cache` full suite at `--jobs 4` on a 16 GiB / 4-core host
peaked at 17.26 GiB tree RSS and was OOM-killed. Memory is the binding
constraint on the cold path, the parent runner is the largest single process
in the tree, and that is why the test pool now budgets a parent term plus a
separately-measured per-child reserve rather than sharing the emit
fan-out's policy.

## Measured macOS shard cost (2026-08-28)

The `[ci-metrics]` lines from run `33215108439` (`macos-arm64`, all eight
shards, one PR). `test_s` is test-phase wall seconds; `test_bin_hit_rate` is
the fraction of that shard's tests whose linked binary came from the cache.

| shard | `test_s` | `test_bin_hit_rate` | leg it ran in |
| --- | ---: | ---: | --- |
| `e2e-b` | 1566 | 0.00 | `e2e-b` |
| `e2e-d` | 1289 | 0.00 | `e2e-d+unit-b` |
| `e2e-a` | 1245 | 0.00 | `e2e-a` |
| `e2e-c` | 932 | 0.96 | `e2e-c+int-caps` |
| `unit-a` | 518 | 1.00 | `unit-a+unit-c` |
| `int-caps` | 498 | 0.00 | `e2e-c+int-caps` |
| `unit-b` | 406 | 1.00 | `e2e-d+unit-b` |
| `unit-c` | 299 | 0.00 | `unit-a+unit-c` |

Two things follow, and they point in different directions.

**The five-way packing is stale, but the upside is small.** SFN-873 packed the
groups when `e2e-b` was the long pole; it no longer is. Current makespan is
`e2e-d+unit-b` at 1695 s against a 6753 s total, and the LPT-optimal packing of
these numbers — `e2e-b` | `e2e-c+unit-b` | `unit-a+int-caps+unit-c` | `e2e-d` |
`e2e-a` — reaches 1566 s. That is a **7.6% (2.15 min) makespan gain, and it is
the ceiling**: `e2e-b` alone is 1566 s, and no five-way packing of eight
indivisible shards can beat the largest one. Repacking also saves **zero
runner-minutes** — total work is unchanged, only the critical path shortens.

So a repack is not worth a CI run on its own: it edits `ci.yml` and
`seed-test-bin.yml`, and `ci.yml` is in `ci-scope`'s `source` glob, so landing
it costs a full macOS matrix to save 2.15 min of wall clock per later PR. (For
scale, the eight `test_s` values above total 112.6 runner-minutes of test phase
alone, before per-leg setup and before `build-compiler-macos`; the whole-matrix
figure is larger and is not derivable from this table.) Fold it into the next change that
already touches `ci.yml` or `compiler/tests/` for another reason.

**Keep the two groupings in sync when you do, because nothing enforces it.**
`seed-test-bin.yml`'s `seed-macos` is the producer of the same five cache keys
`build-macos` consumes, and they are matched by hand: no lint parses both
matrices, and `shard-cover` validates the shard *taxonomy*, not the CI packing.
Drift is silent — never a red job, only a slower macOS leg:

- **Membership drift** (a shard moves to a different leg on one side only):
  that shard restores an entry the seeder filled with someone else's binaries
  and gets nothing. Costs one shard's link time.
- **Leader swap** (a pair is reordered so the `shard2` becomes the leader):
  `build-macos` now restores a key `seed-macos` no longer writes at all, so
  *both* shards in that leg go cold and the seeder's entry is unreachable.

A cross-reference comment in `build-macos`'s own matrix would be the natural
guard — `ci.yml` is the file people actually edit — but `ci.yml` is in the
`source` glob, so adding one costs a full macOS matrix. It belongs in the same
change as the repack.

**The cache misses are real, and traced.** The raw counters behind those
`0.00`s are genuine misses, not an artifact of the metric: `e2e-b` reports
`test_bin_hits=0, test_bin_misses=90`, `e2e-a` 0/89, `e2e-d` 0/96, `int-caps`
0/160, `unit-c` 0/114. (Worth knowing anyway: `_trj_format_hit_rate` returns
`"0.0000"` for a zero denominator too, so the rate alone cannot distinguish
"every lookup missed" from "no lookup was attempted" — read the counters.)

**One mechanism explains every observed hit: the shared key.**
`sailfin-testbin-<target>-<seed>-<freshness>` carried no shard component, so
every shard leg computed the identical key and raced to publish under it. In
seeding run `33228066072`, eight macOS legs sharing that key: one save
succeeded, **five died with "Unable to reserve cache … another job may be
creating this cache"**, two skipped as already-existing. What survives is not
the whole-suite archive the key is meant to hold but an arbitrary union
accumulating one shard per generation. In the measured PR run all five legs
restored the same 339 MB entry, and it happened to carry `unit-a`, `unit-b`
and `e2e-c` — exactly the three shards that hit.

That the shared archive is the sole explanation is settled by `unit-b`: it hit
1.00 while running in the leg whose per-shard key (`test-bin-macOS-e2e-d-`)
reported `Cache not found for input keys`. No per-shard restore reached it, so
its binaries can only have come from the shared archive — and an archive
carrying `unit-b` plainly carried `unit-a` and `e2e-c` too. The per-shard
restores of stale entries by `unit-a` and `e2e-c` are consistent with their
hits but cannot be shown to have caused them. `linux-x86_64` has a baseline
job that masks all of this; `macos-arm64` has none.

The fix is a shard component in that key, placed *before* the seed version so
the `sailfin-testbin-<target>-<seed>-` restore-key still resolves to the
whole-suite baseline and can never prefix-match another shard's slice. Legs
stop racing, each keeps its own slice, and no leg loses the ability to publish
— which matters because `ci.yml`'s shard legs restore per-shard keys but never
save one, so the composite's save is the only test-bin publish a PR run does.

**The per-shard keys are a separate, working mechanism.** Run `33228066072`
saved 8 of 8 `test-bin-macOS-<shard>-<sha>` entries — pre-grouping, one per
shard. Under the grouping this page describes, `seed-macos` publishes **five**
entries under the leader shard names, each carrying both of its shards'
binaries, matching the five keys `build-macos` restores. The `0.00` leader
shards (`e2e-a`/`e2e-b`/`e2e-d`) missed because at measurement time no entry
existed for them at any SHA, against either the exact key or the prefix — a
cold-state transient, not a standing bug.

**Do not size a repack against this.** An earlier reading valued the five
`0.00` shards at ~82 runner-minutes of avoidable relinking per PR. That was
unsound for a reason independent of the cold state: `test_s` is compile plus
link plus *execute*, not link time — `unit-a` hit 1.00 and still took 518 s —
so a shard's whole wall time was never the recoverable quantity. Whether hit
rates recover depends on the grouped seeder publishing before `main`'s
compiler bytes next change, not on anything automatic.

Note this is a single-run sample, and the caveat the section below already
makes still applies: there is no durable time-series for test-suite wall time,
so treat these as one measurement, not a baseline.

## Test-artifact cache (operational)

The design for the content-addressed key derivation lives in
`docs/proposals/0011-ci-test-speed.md`; this is the plumbing.

- Cache root: `<base>/test-bin/v4`, where `<base>` is
  `$SAILFIN_BUILD_CACHE_DIR` or the in-tree default `build/cache`
  (`test_bin_cache_root_with_override`, `compiler/src/build_cache.sfn:1380-1389`).
- `--no-test-cache` (`compiler/src/cli/commands/test/mod.sfn:232`) bypasses
  the per-test linked-binary cache; it threads to every pooled child
  (`compiler/src/cli/commands/test/pool.sfn:127`).
- `build-quality.yml`'s `test-bin-baseline` job runs a full `sfn test` on
  every push to `main`. Its purpose is warming the shared test-bin cache for
  the next PR to read, not correctness gating
  (`.github/workflows/build-quality.yml:341-342`). It is easy to misread
  this job as a merge gate — it is not; a failing baseline never poisons the
  cache PRs consume, because the cache save step only runs when the full
  suite passed.
- Two paths run cold (`--no-test-cache`): the daily aarch64-Linux unsharded
  soak, which gates its scheduled workflow, and the nightly `sfn dev verify`.
- The correctness backstop for the whole toolchain is the nightly
  `sfn dev verify --strict` triple-pass self-host
  (`.github/workflows/nightly-selfhost.yml`, cron `0 7 * * *` UTC, run on both
  Linux and macOS). The seed builds the compiler and the freshly built
  compiler drives verification, so a fix to the verify orchestration takes
  effect without waiting for a seed cut. The test-bin cache is read only by
  the `sfn test` runner; it is never consulted by that gate.

  That job's id is still literally `make-check`. It is a required status
  check, so renaming it needs a branch-protection change and was left as a
  follow-up beyond the Makefile-deletion commit (SFN-60).

## Where each gate lives

- **`build-compiler-linux` / `build-compiler-macos`** — build the compiler
  once per OS in `.github/workflows/ci.yml`.
- **`build-linux` / `build-macos`** — fan out over `matrix.shard` (the eight
  named shards) and download the shared compiler tree rather than rebuilding
  it. This is the "split the build
  into its own job" design now shipped.
- **`shard-cover`** — the cover-invariant lint, gating on
  `build-compiler-linux`.
- **Tier-2 aarch64-Linux source lane** — `build-aarch64-linux` fans source PR
  and merge-queue tests over the same eight named shards. Every leg downloads
  the fixed-point compiler from `build-compiler-aarch64-linux`, restores and
  saves `test-bin-linux-arm64-<shard>-...`, uses native auto-budgeted in-leg
  concurrency, and reports `test_seconds` plus `test_bin_hit_rate`.
  `aarch64-linux-result` aggregates the cross vehicle, native fixed point,
  shard-cover, and matrix result into one check. `required-ci` consumes that
  aggregate, so any ARM prerequisite or shard failure blocks source PRs and
  merge queues without depending on every matrix child separately (SFN-476).
- **Scheduled aarch64-Linux soak** — `soak-aarch64-linux` downloads the same
  verified native compiler artifact but runs one unsharded full suite with
  `--no-test-cache`. It restores no test-bin cache, pins no `SAILFIN_TEST_JOBS`, and a
  failure fails the scheduled workflow.
- **Windows** — boot/frontend smoke only via `smoke-windows`; no suite run. This
  is the whole of the Windows contract: Tier 3, best effort
  (`docs/conventions/target-tiers.md`).
- **`required-ci`** — the merge gate. Needs `ci-scope`,
  `linear-branch-claim`, `check-public-claims`, `check-fast`,
  `build-compiler-linux`, `build-compiler-macos`, `shard-cover`, `build-linux`,
  `build-macos`, `smoke-windows`, and `aarch64-linux-result` — eleven jobs, not
  just the test legs. The ARM aggregate is the Tier-2 promotion gate (SFN-476).
  `linear-branch-claim` is the gate that
  fails an `sfn-<N>` branch whose PR body does not close `SFN-<N>`; see
  `CLAUDE.md` (## Task tracking).
  The gate has one non-path failure mode: a **draft** PR fails it with
  "deferred -- draft pull request". `ci-scope` forces every scope output
  false while a PR is a draft, so only `ci-scope`, `linear-branch-claim` and
  `required-ci` run at all -- the scarce macOS pool (5 account-wide) is not
  spent on a change that cannot merge. An in-scope PR asks this workflow for
  six macOS job-slots; before `installer-smoke.yml` gained its own installer
  scope it could ask for two more, so a PR touching compiler code and
  `docs/status.md` -- a pairing Stage1 readiness required at the time --
  requested eight against a pool of five and contended with itself. Stage1
  readiness no longer requires it: `docs/status.md` is reconciled on the release
  cadence, so that pairing is now rare rather than routine.
  `ready_for_review` reruns the full matrix on the same head.

## Metrics and the known gap

The `sailfin-build` action captures `build_seconds` / `build_cache_hit_rate`
and `test_seconds` / `test_bin_hit_rate` into `build/ci-metrics.env`
(`.github/actions/sailfin-build/action.yml`). The build-phase write remains
macOS-only and is surfaced in
`build-compiler-macos` (`build_seconds` and
`build_cache_hit_rate` only). Test-phase writes are surfaced per shard in
`build-macos` and, since SFN-826, `build-aarch64-linux`, with
`test_seconds` and `test_bin_hit_rate`. These metrics are ephemeral and
per-run only — unlike
`perf-history.yml`'s build-time series, there is no durable time-series for
test-suite wall time. Rebalancing the shard map or the job budget today has
no historical baseline to check a regression against beyond the current
run's own numbers.

## See also

- `docs/proposals/0011-ci-test-speed.md` — the cache-key derivation and
  deterministic-partition design
- `.claude/rules/compiler-safety.md` — the per-process memory-budget
  contract this job-budget arithmetic composes with
- `.claude/rules/no-bash-e2e.md` — why the test surface is `*_test.sfn`,
  never bash
- `docs/conventions/e2e-tests.md` — writing an e2e test
- `site/src/content/docs/docs/reference/spec/11-testing.md` — the normative
  user-facing test-runner reference (the per-test binary cache lives here)
- `site/src/content/docs/docs/reference/cli.md` — the `sfn test --shard` and
  `sfn dev shard` flag surface
