# CI test topology

How `make test`'s surface is partitioned across CI legs, budgeted for
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
  fixed sorted file list.
- **Named CI shards** — `sfn dev shard`
  (`compiler/src/cli/commands/dev_shard.sfn`). `_shard_defs()`
  (`:59-89`) hardcodes eight shards:
  - `unit-a`, `unit-b`, `unit-c` — a 3-way `--shard` split of
    `compiler/tests/unit`
  - `int-caps` — `compiler/tests/integration` + `capsules`, unsplit
    (`total: 0` means "run the whole discovery")
  - `e2e-a`, `e2e-b`, `e2e-c`, `e2e-d` — a 4-way split of
    `compiler/tests/e2e`

`sfn dev shard run <name>` re-parses the shard's roots into an ordinary
`sfn test <roots> [--shard I/N]` invocation and runs it through the same
pipeline, so a named shard's toolchain gate, per-test cache, and JSONL
reporting are identical to a direct `sfn test` call
(`dev_shard.sfn:224-265`).

`make test-shard SHARD=<name>` (`Makefile:442-470`) dispatches to
`sfn dev shard run`; it builds the compiler first if the binary is missing,
and honors `SAILFIN_AGENT_REPORT=1` to tee JSONL to
`build/agent-test.shard-<name>.jsonl`.

## The cover invariant

`sfn dev shard cover` (`_shard_cover()`, `dev_shard.sfn:272`) asserts that
the eight shards' file sets are disjoint, exhaustive, and contain nothing
outside the surface `make test` discovers
(`compiler/tests/unit`, `compiler/tests/integration`, `compiler/tests/e2e`,
`capsules` — `_make_test_roots()`, `dev_shard.sfn:94-96`). CI runs this as
the `shard-cover` job in `.github/workflows/ci.yml`; the Makefile
target is `test-shard-cover` (`Makefile:475-480`).

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
   nproc, is_darwin)` (`compiler/src/cli/commands/test/arg_and_jobs.sfn:71-102`):
   `min(cores, (usable_RAM - 5 GiB) / 3 GiB)`, floored at 1, capped at 16,
   and capped at 2 on Darwin, where `usable_RAM` is 80% of total RAM (the
   same name the code gives the pre-subtraction slice) and the 5 GiB
   subtrahend reserves the parent runner (SFN-781). Resolution precedence in
   `_resolve_test_jobs` (`:151-160`): an explicit `--jobs` flag beats
   `SAILFIN_TEST_JOBS`, which beats the native host probe.
   `scripts/detect_test_jobs.sh` reimplements the identical policy in bash
   for the Makefile's `TEST_JOBS ?=` default; the comment at
   `arg_and_jobs.sfn:68-70` states the two must stay in lockstep — there is
   no shared source for the policy across the two languages, so a change to
   one budget function requires the mirrored edit in the other. Nothing
   automatically cross-checks them: no test asserts the bash script's output
   against the native budget, so drift is caught only by review.

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

## Test-artifact cache (operational)

The design for the content-addressed key derivation lives in
`docs/proposals/0011-ci-test-speed.md`; this is the plumbing.

- Cache root: `<base>/test-bin/v3`, where `<base>` is
  `$SAILFIN_BUILD_CACHE_DIR` or the in-tree default `build/cache`
  (`test_bin_cache_root_with_override`, `compiler/src/build_cache.sfn:1380-1389`).
- `--no-test-cache` (`compiler/src/cli/commands/test/mod.sfn:232`) bypasses
  the per-test linked-binary cache; it threads to every pooled child
  (`compiler/src/cli/commands/test/pool.sfn:127`).
- `build-quality.yml`'s `test-bin-baseline` job runs a full `make test` on
  every push to `main`. Its purpose is warming the shared test-bin cache for
  the next PR to read, not correctness gating
  (`.github/workflows/build-quality.yml:341-342`). It is easy to misread
  this job as a merge gate — it is not; a failing baseline never poisons the
  cache PRs consume, because the cache save step only runs when the full
  suite passed.
- Two paths run cold (`--no-test-cache`): the daily aarch64-Linux unsharded
  soak, which gates its scheduled workflow, and the nightly `make check`.
- The correctness backstop for the whole toolchain is the nightly
  `make check` triple-pass self-host
  (`.github/workflows/nightly-selfhost.yml`, `make-check` job, cron
  `0 7 * * *` UTC, `SELFHOST_STRICT=1`, run on both Linux and macOS). The
  test-bin cache is read only by the `sfn test` runner; it is never consulted
  by that gate.

## Where each gate lives

- **`build-compiler-linux` / `build-compiler-macos`** — build the compiler
  once per OS in `.github/workflows/ci.yml`.
- **`build-linux` / `build-macos`** — fan out over `matrix.shard` (the eight
  named shards) and download the shared compiler tree rather than rebuilding
  it. This is the "split the build
  into its own job" design now shipped.
- **`shard-cover`** — the cover-invariant lint, gating on
  `build-compiler-linux`.
- **Tier-3 aarch64-Linux source lane** — `build-aarch64-linux` fans source PR
  and merge-queue tests over the same eight named shards. Every leg downloads
  the fixed-point compiler from `build-compiler-aarch64-linux`, restores and
  saves `test-bin-linux-arm64-<shard>-...`, uses native auto-budgeted in-leg
  concurrency, and reports `test_seconds` plus `test_bin_hit_rate`.
  `aarch64-linux-result` aggregates the cross vehicle, native fixed point,
  shard-cover, and matrix result into one check. That aggregate remains outside
  `required-ci` while the target is Tier 3; SFN-476 can add this single job when
  promoting the target instead of depending on every matrix child.
- **Scheduled aarch64-Linux soak** — `soak-aarch64-linux` downloads the same
  verified native compiler artifact but runs one unsharded full suite with
  `--no-test-cache`. It restores no test-bin cache, pins no `TEST_JOBS`, and a
  failure fails the scheduled workflow.
- **Windows** — boot/frontend smoke only via `smoke-windows`; no suite run.
- **`required-ci`** — the merge gate. Needs `ci-scope`,
  `linear-branch-claim`, `check-public-claims`, `check-fast`,
  `build-compiler-linux`, `build-compiler-macos`, `shard-cover`, `build-linux`,
  `build-macos`, and `smoke-windows` — ten jobs, not just the test legs. It does
  **not yet** need `aarch64-linux-result`; SFN-476 owns that Tier-2 promotion.
  `linear-branch-claim` is the gate that
  fails an `sfn-<N>` branch whose PR body does not close `SFN-<N>`; see
  `CLAUDE.md` (## Task tracking).

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
