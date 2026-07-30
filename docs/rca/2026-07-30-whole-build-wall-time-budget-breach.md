# RCA: Whole-Build Wall Time Over the SFEP-0006 300 s Budget

- **Date:** 2026-07-30
- **Author:** Sailbot (with Michael Curtis)
- **Severity:** Medium — seven of eight nightly `perf-history` runs over the
  SFEP-0006 `300 s` clean-build budget (2026-07-19 through 07-26, peaking at
  `363 s`, +21%). No build broke and no artifact was wrong; the cost contract
  was violated and nothing stopped the line.
- **Affected surface:** the `build_wall_s` metric recorded by
  `.github/workflows/perf-history.yml` on the `bench-data` branch — the wall
  time of one clean `make rebuild` (pinned-seed self-host).
- **Resolved by:** no revert. Wall time returned under budget on 07-27 when the
  pinned seed advanced to `0.8.2`; the four nightlies since read `211`, `211`,
  `209`, `261` s. This RCA records the account, and adds the enforcement the
  breach revealed was missing.
- **Status:** Closed. Guard landed (SFN-421); four follow-ups open.

## TL;DR

Three separate things were read as one regression.

1. **The 07-19 → 07-25 climb was not a regression.** Normalized cost per IR
   line was *flat* across the entire `0.8.0` seed line (`alpha.5` and `0.8.0`)
   (`290.1 ± 8.3 µs/line`, n=14). Predicting 07-25's wall time from 07-18's
   purely from IR-volume growth, at unchanged throughput, gives **316.3 s
   against 316 s measured**. The tree grew 7.9%; a fixed budget with <3%
   headroom absorbed it and crossed. `07-24`'s `332 s` is a `+2.1σ` excursion
   that reverts to trend the next night.
2. **The 2× per-module speedup is real, and it is not measured on the same
   binary as the wall time.** `make bench` times the *freshly self-hosted*
   compiler doing `emit llvm` only; `build_wall_s` times the *pinned seed*
   doing emit **plus** assemble **plus** link. A codegen-quality improvement
   therefore lands in the bench series one seed generation *before* it lands in
   the wall series — which is exactly the 07-26 shape: bench `443 → 188 s`
   while wall rose `316 → 363 s`, then wall `363 → 211 s` one generation later
   with no build-driver commit in between.
3. **Nothing enforced the budget.** A breach auto-filed an issue and the
   nightly still exited **green** — so seven over-budget nights produced a run
   of comments on one issue whose headline read as median jitter.

The build is under budget today, but on `261 s` of a `300 s` budget it has 13%
headroom, and per-unit cost already regressed 20.7% against the `0.8.2` era
at the `0.8.4` seed.

## Symptom

`build_wall_s` from `bench-data:build.csv`, with the pinned seed that ran each
build and the per-module bench aggregate from the same nightly:

| date | wall_s | seed | modules | Σ per-module time_s | Σ ir_lines | µs wall/line |
|---|---|---|---|---|---|---|
| 07-15 | 273 | 0.8.0-alpha.5 | 212 | 389.1 | 989,134 | 276.0 |
| 07-16 | 276 | 0.8.0-alpha.5 | 212 | 392.0 | 990,301 | 278.7 |
| 07-17 | 290 | 0.8.0-alpha.5 | 212 | 425.8 | 990,452 | 292.8 |
| 07-18 | 293 | 0.8.0-alpha.5 | 214 | 390.2 | 1,003,832 | 291.9 |
| 07-19 | **301** | 0.8.0-alpha.5 | 215 | 413.4 | 1,021,536 | 294.7 |
| 07-20 | 297 | 0.8.0-alpha.5 | 216 | 420.1 | 1,026,963 | 289.2 |
| 07-21 | **301** | 0.8.0 | 216 | 423.0 | 1,028,266 | 292.7 |
| 07-22 | 306 | 0.8.0 | 220 | 458.9 | 1,038,306 | 294.7 |
| 07-23 | 312 | 0.8.0 | 222 | 394.6 | 1,048,353 | 297.6 |
| 07-24 | **332** | 0.8.0 | 228 | 479.6 | 1,078,214 | 307.9 |
| 07-25 | 316 | 0.8.0 | 229 | 443.0 | 1,083,536 | 291.6 |
| 07-26 | **363** | 0.8.1 | 229 | **188.4** | 1,084,017 | 334.9 |
| 07-27 | **211** | 0.8.2 | 229 | 193.2 | 1,089,089 | 193.7 |
| 07-28 | 211 | 0.8.2 | 229 | 247.5 | 1,094,041 | 192.9 |
| 07-29 | 209 | 0.8.2 | 231 | 248.0 | 1,103,206 | 189.4 |
| 07-30 | 261 | 0.8.4 | 235 | 262.3 | 1,125,956 | 231.8 |

Under budget every night 07-03 → 07-18 (`230`–`293`; rows before 07-15 omitted),
then over budget on **seven of the eight nights** 07-19 → 07-26 — 07-20's `297`
is the single night in that stretch that stayed under — and back under from
07-27.

## Investigation

### Where the wall time actually goes

`make rebuild` (`Makefile:823-1018`) is **one** `<seed> build -p compiler`
invocation, not a triple pass. Its phases, and their parallelism:

| phase | driver | parallel? |
|---|---|---|
| capsule resolve + `.sfn-asm` staging | `capsule_resolver.sfn:1521` | **yes** — `_cr_run_parallel_emit`, `capsule_emit_parallel.sfn:537` |
| `.ll` emission per module | `capsule_resolver.sfn:2048` | **yes** — same pool |
| entry-module compile | `build.sfn:405` | serial, single module |
| **`.ll` → `.o` assemble, all ~259 modules** | `assemble_link_inputs`, `build/clang_argv.sfn:99-176` | **no — one `clang -c` at a time** |
| **runtime object compile (~34 sources)** | `_compile_runtime_sfn_sources`, `build/runtime_objs.sfn:1076-1150` | **no — serial `emit` + `clang -c` per source** |
| final link | `build/direct_link.sfn` via `backend.sfn:324` | single invocation |

Worker count for the parallel phases comes from `_cr_resolve_jobs`
(`capsule_emit_parallel.sfn:30-44`): `SAILFIN_BUILD_JOBS`, else a CPU probe
clamped by a RAM budget, ceiling 8.

The parallel/serial boundary is the structural answer to the issue's paradox:
**the fan-out covers emission up to `.ll`, and stops there.** Everything from
`.ll` to `.o` reverts to one subprocess at a time. Speeding up the parallel
stage shrinks an already-shrinking slice of the critical path while the serial
`clang -c` phase keeps its full cost — so a 2× emit win cannot produce a 2×
wall win, by Amdahl, no matter how genuine it is.

Measured on this host (4 cores, seed `0.8.4`, `-O2` — the flag the driver
actually passes, `build/link.sfn:357`), re-assembling the 259 emitted `.ll`
files from a completed build:

```
serial   (as the build does today):  49 s
pooled   (xargs -P4, same work):     12 s
```

So the serial assemble phase is worth **~37 s** of recoverable wall time —
about 10% of a `367 s` local clean build, and ~14% of the `261 s` CI budget
consumption. It is the largest single unparallelized phase on the critical
path.

### Why per-module time and wall time disagree

They measure different binaries and different phase sets:

- `sfn bench --compiler` (`cli/commands/bench.sfn:159-265`) spawns one
  subprocess per module against **`build/bin/sfn`** — the compiler that was
  just self-hosted — running `emit ... llvm` only (`bench.sfn:221`): parse,
  typecheck, effects, `emit_native`, `lower_llvm`. It never calls `clang -c`
  and never links.
- `build_wall_s` times **the pinned seed** compiling the whole tree, including
  both serial phases above and the link.

`.github/workflows/perf-history.yml:128-131` already says these are different
metrics. The consequence that was missed is *directional*: a change to
generated-code quality makes the binaries the compiler *produces* faster
immediately — visible in bench, which measures a freshly produced binary — but
only makes the compiler's *own* body faster once a seed is cut from the
improved compiler. Bench leads wall by one seed generation.

That predicts the 07-26/07-27 pair, and it is what happened:

- **07-26, seed `0.8.1`:** bench `443 → 188.4 s` (−57%), wall `316 → 363 s`
  (worst in the series). `0.8.1` emits faster code, so the compiler it built is
  fast; `0.8.1`'s own body was emitted by `0.8.0`, so the build it *ran* got
  none of that benefit.
- **07-27, seed `0.8.2`:** wall `363 → 211 s` (−42%), bench stays fast
  (`193.2 s`). `0.8.2`'s body was emitted by the improved `0.8.1`.

The lag explains why 07-26 was not *fast*. It does not by itself explain why
07-26 was *slower than 07-25* (`334.9` vs `291.6 µs/line`, +15%), since both
seeds' bodies were emitted by their predecessors. That `+47 s` stays
**unattributed**. The leading candidate is that `0.8.1` is the first seed
carrying the native parallel emit fan-out (`db848400`, SFN-498, plus a same-day
follow-up fix `d70ea4e4`) — new orchestration code whose retry rounds
(`max_rounds = 3`, `capsule_emit_parallel.sfn:588`) can silently re-run work
under contention. No other candidate was found in `7aa50af4f..d9d8c4431`, and
the excursion did not recur, so it was not pursued further.

Corroboration that this is generational and not a fix: **no build-driver commit
lands between the 07-26 and 07-27 nightlies.** `git log 7aa50af4f..6c2caf8e0 --
compiler/src/build compiler/src/cli Makefile` returns only commits already
present before 07-26. A 152 s drop with no code change in the window is a seed
substitution, not a repair.

### Attributing the climb

The `0.8.0` era (07-12 → 07-25, 14 nightlies) has a flat normalized cost:
`290.1 µs` of wall per IR line, `sd = 8.33`. Volume grew steadily —
`compiler/src` went `214 → 228` files and `122,074 → 130,729` lines (+7.1%)
between 07-18 and 07-24, the largest single contribution being `815b6240`
("typed SSA v0 core and verifier", +2,777 lines / 3 new files; self-hosting
compiles every file under `compiler/src` whether the pipeline imports it or
not).

Holding throughput at 07-18's `291.9 µs/line` and scaling only by measured IR
volume:

| target | predicted | actual | error |
|---|---|---|---|
| 07-24 | 314.7 s | 332 s | +17.3 s |
| 07-25 | 316.3 s | 316 s | **−0.3 s** |

07-25 is explained to within a third of a second by volume growth alone. The
budget was not consumed by a regression; it was consumed by **growth against a
fixed ceiling that had under 3% headroom left on 07-18**. `07-24`'s `+17 s` is
a `+2.1σ` excursion that reverts to trend on 07-25 — runner noise, not a step.

Candidate per-module cost additions in the window were checked and are not
dominant: `d95413fa`'s workspace-capability audit does re-parse a member's
tree, but `workspace_capability_gate()` short-circuits at
`capsule_resolver.sfn:3069` for envelope-free workspaces — including this repo
— so it is inert here; `730faf91` and `f1b68e78` add bounded per-routine and
per-module scans whose cost scales with decorator/import counts (usually
zero-to-small); `typed_ssa_verify.sfn` is not wired into the pipeline.

### Ruling out a measurement artifact

`b2384e09` ("content-address compile freshness") was the live suspicion — if it
let `make rebuild` skip work, the post-07-27 numbers would be an artifact
rather than a speedup. Reading it: it changes the skip predicate of
`compile-impl` only, and adds a *post-build* fingerprint comparison to
`rebuild-impl`. `rebuild-impl` gained no skip-if-unchanged path; it still runs
`"$seed" build -p compiler` unconditionally (`Makefile:826-903`). Confirmed
empirically — a cold local `make rebuild` took `367 s` and assembled all 259
objects; the same tree rebuilt warm took `269 s`. CI's caches are cold by
construction (fresh checkout, fresh `build/`), so the metric is measuring a
real clean build.

## Root Cause

Two independent causes, neither of them a code regression:

1. **The budget was exhausted by growth, not degraded by a change.** Cost per
   IR line was flat across the whole `0.8.0` line; the tree grew into a fixed
   `300 s` ceiling that already had <3% headroom. The `300 s` contract is not
   at fault (raising it is explicitly out of scope) — the absence of any
   *headroom* signal is: the only alert fires after the contract is already
   broken.
2. **The budget was unenforced.** `perf-history.yml` filed an issue on breach
   and exited 0. Combined with a filed headline that read as median drift, the
   breach persisted for two weeks.

The 07-26 spike and 07-27 recovery are a third, benign phenomenon: the
one-generation lag between a codegen improvement reaching the *built* compiler
and reaching the *seed*.

## Fix

**Enforcement** (`.github/workflows/perf-history.yml`): a final
`Enforce the whole-build wall-time budget` step fails the nightly when
`build_wall_s` exceeds `BUILD_BUDGET_S`, and emits a `::warning` once a run
reaches `BUILD_HEADROOM_WARN_PCT` (90%) of it. It runs last, so a breach still
files its issue and uploads its CSVs before the job goes red, and it carries the
same `dry_run` exemption as the issue-filing step so a trial dispatch stays
green.

It enforces the `build_wall_s` **recorded in `build.csv` for the commit** rather
than its own stopwatch. Append is idempotent per commit
(`scripts/perf_history.sh`), so a re-run against an already-recorded SHA
re-measures without re-recording; had the gate read its own measurement, a
dispatch re-run could have failed the job while the compare step reported no
breach in the same summary — or passed while an issue was filed.

Replayed against the recorded series, the gate fails on `301` (07-19, the first
breach) and on the six further breaches through 07-26, stays quiet at today's
`261` (87%), and would have warned on 07-17 (`290`, 96%) and 07-18 (`293`, 97%)
— two nights of notice before the contract broke.

**No revert, and no optimization in this change.** Wall time is under budget on
its own; the serial-assemble win below is real but is a build-driver change to
a path that destabilized twice in this same window, and it belongs in its own
reviewable PR.

## Verification

```bash
# Series and the normalized metric (read-only; no orphan-branch checkout)
git fetch origin bench-data
git show origin/bench-data:build.csv | column -t -s,

# Cold clean self-host, the exact CI metric (this host, 4 cores, seed 0.8.4)
make fetch-seed
time make rebuild CLANG=clang-18 SEED_NATIVE=build/toolchains/seed/bin/sfn
#   cold: 367 s, rc=0, 259 objects assembled
#   warm: 269 s  (CI is always cold: fresh checkout, fresh build/)

# Serial vs pooled cost of the .ll -> .o phase, over a completed build's IR
ls build/native/raw/*.ll | wc -l                     # 259
#   serial one-at-a-time (today's behaviour): 49 s
#   xargs -P4, identical work and flags:      12 s
```

## Follow-ups (open)

- **Parallelize the serial `.ll` → `.o` assemble phase**
  (`assemble_link_inputs`, `build/clang_argv.sfn:99-176`) and the runtime
  object compile (`_compile_runtime_sfn_sources`,
  `build/runtime_objs.sfn:1076-1150`) through the existing bounded pool
  (`_cr_run_parallel_emit`). Measured headroom: **37 s** of 49 s on 4 cores.
  This is the one change that buys back budget rather than tracking it.
- **Predicted regression, not yet observed:** `c8fd88af` (SFN-578) publishes
  every emitted IR file via `mkstemp` sibling + `rename(2)`, on both emit
  rounds across ~235 modules. It is *not* in seed `0.8.4` and so ran in no
  measured nightly. Expect it to cost wall time in the first nightly whose seed
  is cut past `838ba31dd`; the new gate will show it.
- **No per-phase timing exists on the build path.** `BuildReport`
  (`build_report.sfn:83-115`) carries cache stats and dep paths, no durations;
  the only phase timer (`main.sfn:78-85`, `470-558`) is reachable solely via
  the manual single-module `sfn emit --timing llvm` and is never passed by the
  fan-out (`capsule_emit_parallel.sfn:320-329`). Every phase number in this RCA
  had to be reconstructed externally. Wiring durations into `BuildReport` would
  make the next investigation a read instead of a re-derivation.
- **Per-unit cost regressed at seed `0.8.4`** — `231.8 µs/line` against the
  `0.8.2` era mean of `192.0` (+20.7%), or `+22.4%` against 07-29's `189.4`
  point-to-point — on flat IR volume, absorbing a 40-commit seed jump that
  skipped `0.8.3` as a pin. Unlike the 07-19 window this *is* a throughput
  change and it is unattributed; the always-on per-instruction "fail closed"
  additions in that delta are the leading hypothesis.

## Links

- `bench-data:build.csv`, `bench-data:compile.csv` — the measured series
- `docs/perf/bench-history.md` — how to read the branch, and the gate
- SFEP-0006 (`docs/proposals/0006-build-architecture.md`) — the `300 s` budget
- SFEP-0037 §3.3 — perf-history mechanism
- SFN-567 — the "rolling median" mislabel on the budget row (separate)
- SFN-566 — per-module peak RSS growth (separate)
- SFN-432 — `test-bin-warmer` timeout (related; coordinate)
