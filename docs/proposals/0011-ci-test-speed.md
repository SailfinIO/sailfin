---
sfep: 11
title: "CI Test-Speed Plan"
status: Accepted
type: tooling
created: 2026-05-01
updated: 2026-07-06
author: "agent:compiler-architect"
tracking: "#1012, #843"
supersedes:
superseded-by:
graduates-to:
---

# CI Test-Speed Plan: cutting PR feedback time

Status: Phase 1 (CI sharding + shard-cover lint) implemented in PR #1012;
Levers 2 (per-test binary cache) and 3 (scope trim) remain proposed.
Author: compiler-architect
Reconciles with: #839/#843 (test-infra epic, Phase 4), #513 (Makefile
slim-down), #339 (build perf), #940 (multi-file runner forking), #1011
(macOS flakes under parallel-build contention).

---

## 1. Goal

Cut PR CI wall time — currently Linux ~24 min / macOS ~47 min — by
attacking the test suite, which is ~90% of wall time on a warm build
cache, **without losing any total coverage** and **without requiring the
post-1.0 `routine`/`spawn` runtime that Phase 4 (#843) is blocked on.**

Target after Phase 1: macOS 47 min → ~14-16 min, Linux 24 min → ~9-10 min.

---

## 2. Current state (measured)

Run 26894545759 (warm content-addressed module cache):

| Phase | Linux | macOS |
|---|---|---|
| `make rebuild` (selfhost, warm cache) | 1m32s | 3m15s |
| `make test` | **21m47s** | **42m22s** |
| fmt + canary + cross + package + upload | ~75s | ~60s |

The suite is the pain; macOS is ~2x slower per-test than Linux.

### How the suite runs today

- PR `ci.yml` (`.github/workflows/ci.yml:40-126`): one matrix leg per OS;
  the `sailfin-build` composite action
  (`.github/actions/sailfin-build/action.yml:121-125`) calls `make test`.
- `make test` (`Makefile:153-166`): one process —
  `$(NATIVE_BIN) test compiler/tests/unit compiler/tests/integration
  compiler/tests/e2e capsules` — then `make test-e2e-sh`
  (`Makefile:268-296`, the 94 legacy `test_*.sh` scripts).
- The unified runner `handle_test_command`
  (`compiler/src/cli_commands.sfn:875`) discovers all `_test.sfn` files,
  then for >1 file takes the **multi-file subprocess path**
  (`cli_commands.sfn:1071-1175`): a **sequential `loop`**
  (`cli_commands.sfn:1144-1170`) that forks one `<self> test <file>`
  child (`_run_test_child`, `cli_commands.sfn:840-853`) per file. Each
  child compiles the test through LLVM lowering + a clang link
  (`_clang_link_test_cmd_with_deps`, `cli_commands.sfn:140-193`) and
  runs the binary.
- The runtime capsule is warmed **once** per invocation into a shared
  objdir and shared via `SAILFIN_TEST_RUNTIME_OBJDIR`
  (`cli_commands.sfn:1121-1141`) — so the per-test cost is
  lower+link+run of the test itself, not the runtime.
- **No test-level parallelism** (the loop is serial) and **no per-test
  binary cache** (every child re-lowers + re-links + re-runs every run).

### File counts (the shardable surface)

- 118 unit, 30 integration, 4 e2e `_test.sfn`; 23 capsule `_test.sfn`;
  94 legacy e2e `test_*.sh`. ~1,876 `test` blocks total.

### Cache plumbing (the seam sharding must respect)

- Content-addressed module IR cache `build/cache/` keyed by
  `cache_key_for` (`compiler/src/build_cache.sfn`): hashes source content
  + sorted dep-manifest hashes + compiler version + canonicalized flags
  (`build_cache.sfn:17-29, 508-522`). No paths/mtimes — reusable across
  runners.
- Primed by `build-quality.yml` on push:main
  (`build-quality.yml:238-250`), restored in the composite action
  (`action.yml:84-91`) with prefix `restore-keys`. So with warm cache the
  build is ~free; the cost is the test compile+link+run, which is **not**
  cached.

### Why Phase 4 (#843) is blocked but we are not

Phase 4.1 (`02-phases.md:61-75`) is *in-process* parallelism (`sfn test
--jobs N` running N `routine`s), gated on the structured-concurrency
runtime that doesn't exist. **CI-level sharding (separate OS processes /
CI jobs) needs none of that** — GitHub gives us the parallelism for free
across matrix legs. This plan pulls the *value* of Phase 4 forward via CI
fan-out + an OS-process `xargs -P` seam, explicitly **not** via the
blocked in-process runtime.

---

## 3. Constraints (non-negotiable)

- **Self-hosting invariant.** Compiler fixes land in `compiler/src/*.sfn`;
  the driver is pure orchestration, no fixups.
- **Memory cap.** Every compiler invocation on Linux/WSL prefixed
  `ulimit -v 8388608`. Parallelism multiplies memory pressure — the shard
  count must respect the per-job RAM budget (`detect_build_jobs.sh`
  rationale: ~2 GB/worst-module; macOS runner ~7 GB ceiling).
- **Formatting gate.** `sfn fmt --check` must pass on touched `.sfn`.
- **Determinism.** Any test-binary caching must not weaken the
  fixed-point / `--check-determinism` gates (`ci.yml:277-330`,
  `build-quality.yml:180-236`). Those gate the *compiler build*, not test
  binaries — but a test-binary cache must invalidate correctly so a
  changed dep never reuses a stale binary.
- **#1011 — scratch isolation.** macOS flakes when parallel module builds
  contend on shared cache/staging. Any new parallelism (sharded jobs,
  `xargs -P`) must give each worker an isolated scratch root via
  `SAILFIN_TEST_SCRATCH` / `SAILFIN_TEST_RUNTIME_OBJDIR`
  (`_test_scratch_root`, `cli_commands.sfn:218`); see §7.

---

## 4. The three levers

### Lever 1 — Shard the suite across parallel CI jobs (highest ROI, lowest risk)

**Idea.** Fan the `ci.yml` matrix from 2 legs (one per OS) to `2 x N`
legs: each leg builds the compiler once, then runs only its shard of the
test surface. GitHub runs them concurrently, so wall time ≈ build +
(suite / N) + fixed overhead.

**Where it lives:** CI-config (`ci.yml`) + a thin path-selection seam.
The runner *already* accepts multiple positional suite paths
(`handle_test_command`, `cli_commands.sfn:919-937`) and multiple
`_test.sfn` files, so **no compiler change is required for a coarse
suite-level shard.**

**Shard map (coarse, Phase 1 — by existing suite, balanced by file count):**

| Shard | Contents | ~files |
|---|---|---|
| `unit-a` | first half of `compiler/tests/unit` | ~59 |
| `unit-b` | second half of `compiler/tests/unit` | ~59 |
| `int-e2e-caps` | `integration` + `e2e` + `capsules` | ~57 |
| `e2e-sh` | the 94 legacy `test_*.sh` (`make test-e2e-sh`) | 94 scripts |

Four shards per OS. macOS critical path drops from ~42 min to roughly
`max(shard) ≈ 42/3.5 ≈ ~12 min` for the `.sfn` shards (the `.sh` shard
runs in parallel and is independent). Unit is split in half because it is
the largest single suite; the runner has no built-in "half a directory"
selector, so we pass explicit file lists (see seam below).

**The build-cost-per-shard problem and its fix.** Each shard leg runs
`make rebuild` first (`action.yml:104-113`), so naively every shard pays
the 1.5-3 min build. Two options:

- **1a (Phase 1, simplest):** accept the rebuild per shard. With the warm
  content-addressed cache restored (`action.yml:84-91`) the build is
  1m32s (Linux) / 3m15s (macOS). Total added build cost = `(N-1) x
  build` of *parallel* runner-minutes, but **wall time is unchanged**
  because shards run concurrently. The only cost is runner-minute
  consumption (4x build instead of 1x). Acceptable for Phase 1; ship it.
- **1b (Phase 2, optimization):** split the build into its own job that
  uploads `build/bin/sfn` + `build/compiler/import-context` +
  `build/cache` as a workflow artifact (or `actions/cache` with a
  per-run key), and have each shard `needs:` that job and download
  instead of rebuilding. Saves the redundant build runner-minutes and
  removes build-time variance from the shard critical path. This is the
  right end-state and aligns with #513 (sfn owning build/check) — the
  build job becomes the single `sfn build -p compiler` producer.

**Seam for "half a directory".** Two implementation choices, in
increasing compiler involvement:

- **Seam A (CI-only, zero compiler change):** the shard's CI step does
  `find compiler/tests/unit -name '*_test.sfn' | sort | awk 'NR%2==0'`
  (or `split`) and passes the explicit file list as positionals to
  `sailfin test`. The runner already handles a positional file list. A
  thin `make test-shard SHARD=unit-a` target (or inline in `ci.yml`)
  encapsulates the selection. **Recommended for Phase 1.** Owner: CI.
- **Seam B (compiler, deferred):** add `sailfin test --shard I/N <paths>`
  that does deterministic file-count-balanced partitioning internally
  (hash filename → bucket, or stable sort + stride). Cleaner, keeps shard
  logic in one tested place, and is reusable by `make`/nightly. This is a
  small, safe runner addition (`handle_test_command` flag parse +
  partition over the already-collected `test_files` list,
  `cli_commands.sfn:978-995`). **Defer to Phase 2** — Seam A unblocks
  immediately; Seam B is the durable home and should land before the
  shard count grows past ~4.

**Coverage preservation.** The union of shards = the current
`make test` surface, file-for-file. A `ci.yml` "shard-cover" lint step
(or a `make test-shard-cover` that asserts `sort -u` of all shard file
lists == `find ... -name '*_test.sfn' | sort`) guarantees no file is
dropped or double-counted as shards are rebalanced. **This guard is
mandatory** — it's the only thing standing between "rebalance the shard
map" and "silently stop running 12 tests."

**Risk:** runner-minute cost (1a); rebalancing drift (mitigated by the
cover lint); macOS contention if a single runner ever hosts >1 shard
(it won't — each shard is its own runner). Low overall.

**Expected wall delta:** macOS PR critical path ~47 → ~16-18 min
(build 3m + ~12-14 min worst shard + overhead). Linux ~24 → ~10-11 min.

---

### Lever 2 — Per-test binary cache (the fundamental incremental fix)

**Idea.** Content-address each test's compiled native binary on `(test
source hash + transitive dep hashes + compiler version + clang flags)`,
mirroring `cache_key_for`. On a cache hit, skip LLVM lowering + clang
link and **just run the cached binary** (or skip entirely if we also
cache the pass/fail result — see below). On an incremental PR that
touches 3 files, only the tests whose transitive dep set changed re-link;
the rest hit.

**Where it lives:** compiler runner (`compiler/src/cli_commands.sfn`),
reusing `build_cache.sfn` primitives. This is **runner-internals work**,
not CI-config.

**Cache key.** Reuse the existing content-hash machinery in
`build_cache.sfn` (`content_hash` at `:529`, dep-manifest sorting at
`:443`, `canonicalize_flags` at `:508`). The per-test key is:

```
sha256(
  content_hash(test.sfn)
  || sorted(content_hash(each transitive dep .sfn / .sfn-asm))
  || compiler_version
  || canonical(clang_flags)        // "-O0", runtime objdir contract, target triple
  || build_cache_schema_version()
)
```

The transitive dep set is exactly what the per-group resolver already
computes (`TestGroup.native_texts` / `dep_ll_paths`,
`cli_commands.sfn:1189-1211`) — the dep `.ll`/`.sfn-asm` inputs to the
link are enumerable at link time, so the key has access to every input
hash. **Correctness hinge:** a changed dep changes its content hash,
changes the key, misses the cache. This is the same invariant
`cache_key_for` already upholds for the module IR cache; we are not
inventing a new correctness model, just a second consumer of it.

**Two cache granularities (ship the first, consider the second):**

- **2a — cached binary (conservative, recommended first):** store the
  linked `test` executable keyed as above under
  `build/cache/test-bin/v1/<key>`. On hit, skip lower+link, still **run**
  the binary. Saves the LLVM-lower + clang-link cost (the dominant cost —
  clang link of a test + runtime objects is the expensive step), keeps
  the run (so flaky-at-runtime tests still surface, and we never trust a
  cached *result*). Lowest correctness risk.
- **2b — cached result (aggressive, gate behind a flag):** also store the
  exit code / pass-fail, and skip the run on hit. Faster but trusts that
  a test with identical inputs is deterministic. **Only enable on
  PR-shard runs, never on the nightly full `make check` or the
  determinism gates.** Off by default; `SAILFIN_TEST_RESULT_CACHE=1`.

**Invalidation & safety:**

- Keyed on content, so any source/dep/compiler/flag change misses —
  never a false hit. Same model as the module cache.
- LRU-evicted by GitHub's cache; in-tree it lives under `build/cache/`
  (already git-ignored, already the cache root).
- **Must not touch the determinism gates.** Those run `sfn build
  --no-cache` / `--check-determinism` against the *compiler* build
  (`ci.yml:305-311`, `build-quality.yml:174-213`) — a separate code path
  from `handle_test_command`. The test-binary cache is read only by the
  runner. Add an explicit `--no-test-cache` flag (and have `make check` /
  nightly pass it) so the full-suite gate always cold-builds test
  binaries and the cache can never mask a test-compile regression.
- **#1011 interaction:** the cache write must be atomic
  (write-to-temp-in-scratch + rename into `build/cache/test-bin/`) so two
  shards racing on the same key don't half-write. The existing hash-tmp
  pattern (`build_cache.sfn:417`, unique-per-worker suffix) is the
  precedent; reuse it. Reads are lock-free (content-addressed: a present
  file under `<key>` is correct or absent).

**CI plumbing.** Add `build/cache` is *already* restored
(`action.yml:84-91`); extend the restore/save to include the
`test-bin/v1` subtree (it's under the same `build/cache` path, so the
existing cache step covers it — but the **save** currently only happens
in `build-quality.yml` on push:main, which runs **no tests**, so it never
populates `test-bin`). Two options:

- Add a `actions/cache/save` of `build/cache/test-bin` at the end of each
  PR shard (per-OS, per-shard key) so the *next* PR push warms from the
  prior one. Scoped to branch + base-branch per GitHub cache rules, so a
  PR's second push reuses its first push's test binaries — the
  incremental-PR win.
- Optionally have a nightly/push:main job populate a baseline
  `test-bin` cache (full suite) that PRs restore from, so even a
  PR's *first* push gets hits for unchanged tests. Best ROI but more
  plumbing; defer to Phase 3. **Refinement (SFN-431):** this baseline
  warmer (`test-bin-baseline` in `build-quality.yml`) restores its *own*
  prior test-bin cache and builds incrementally rather than cold — the
  cold-producer choice was hygiene, not soundness (only the `build-quality`
  determinism gate has a cold-build invariant, and it reads no test
  binaries). Cross-commit correctness holds because each entry is
  content-addressed by the commit-stable capsule version + source (#1233),
  so a changed test misses and recompiles.

**Risk:** medium. Correctness rests on the dep-hash set being *complete*
(miss a dep → false hit → stale test passes). Mitigation: derive the dep
list from the same resolver output the link already consumes (no
separate, drift-prone enumeration), and gate the full suite with
`--no-test-cache` so any escaped staleness is caught nightly/at-merge.
Start with 2a (still runs the binary) to bound the blast radius.

**Expected wall delta:** depends on PR churn. A typical PR touching a
handful of `compiler/src` files invalidates the tests transitively
depending on them but hits the rest — on incremental pushes the suite
can drop 50-80% when most tests are unchanged. Stacks multiplicatively
with Lever 1 (each shard caches its own subset).

---

### Lever 3 — Trim PR scope; full suite to nightly/merge

**Idea.** PRs run a fast **smoke subset** (especially on macOS, the long
pole); the full suite gates on push:main and nightly.

**Where it lives:** CI-config + a tag/selection seam in the runner.

**Defining "smoke".** Three candidate selectors, in order of preference:

- **3a — tag-based (recommended).** The runner already supports
  `--tag <value>` filtering (`cli_commands.sfn:904-910`, `set_test_filters`).
  Tag a curated set `@tag("smoke")` covering: the effect-gate /
  exit-code regression (#615/#807, already a discrete `ci.yml` step),
  the cross-module ABI tests (#633), the canary/lowering paths, one test
  per major feature area. PR macOS runs `sailfin test --tag smoke`;
  Linux runs the full sharded suite (Linux is cheap enough to keep full
  coverage on every PR). Owner: needs someone to *curate and apply* the
  tag across ~176 files — a one-time content pass, plus a CODEOWNERS-style
  rule that new feature tests get a smoke tag where appropriate.
- **3b — path/changed-file selection.** Run only tests in suites touched
  by the PR diff (e.g. a PR touching only `compiler/src/llvm/**` runs
  unit+integration but skips capsules). Riskier (cross-cutting changes
  under-test) and needs a diff→suite mapping; defer.
- **3c — keep e2e-sh and capsules off macOS PRs.** The 94 `.sh` scripts
  and capsule tests run on Linux PRs + nightly macOS only. Cheap, safe
  for the long pole.

**The coverage guarantee (the hard part).** Trimming PR scope is only
safe if the full suite gates *somewhere before release*. Current state:

- push:main `build-quality.yml` runs **no tests** — it only gates
  determinism + cache hit-rate. **Gap:** nothing runs the full suite on
  merge to main today except the PR that merged it.
- nightly `selfhost.yml` runs the full `make check` (triple-pass) on
  Linux + macos-26.

So Lever 3 **requires** closing the merge-gate gap: either (i) add a
full-suite job to `build-quality.yml` (push:main) — preferred, it's the
merge gate — or (ii) accept nightly as the full-suite backstop and
document that a smoke-only PR can land a macOS-specific regression that
surfaces ≤24h later in nightly. **Recommendation:** add a full-suite
sharded run to push:main so the full suite gates on every merge, and PRs
run smoke-on-macOS + full-on-Linux. That keeps total signal: every line
of test still runs on every merge, just not on every PR macOS leg.

**Risk:** medium-high — this is the lever that actually *removes*
coverage from the PR gate. The mitigations (full suite on push:main,
Linux stays full on PR) keep the net signal, but a macOS-only regression
gets a slightly longer feedback loop (merge instead of PR). Only pursue
after Levers 1+2 land, and only if their wall-time wins prove
insufficient.

**Expected wall delta:** macOS PR leg → smoke subset (~2-4 min of tests)
+ build. But the win overlaps heavily with Lever 1 — if sharding already
gets macOS to ~12 min, Lever 3's marginal value is smaller and its
coverage cost is real. Treat as the *last* lever, not the first.

---

### Lever 4 — Within-shard `--jobs` parallelism (Phase 1 follow-on, shipped 2026-07-01)

**Idea.** Levers 1–3 parallelize *across* CI legs but each leg still runs
its shard **serially internally** (`sailfin test --jobs 1`). The multi-file
runner's bounded worker pool (`--jobs N`, #1236) is already shipped and
proven equivalence-safe (`runner_jobs_parallel_test.sfn`), but CI never
opted in — the serial-internal default was calibrated on the 3.23 GiB heavy
*compiler-module* emit (SFEP-0022 §2.4), which CI shards never build.

**Benchmark (2026-07-01, self-hosted `0.7.0-alpha.50`, on a 4-vCPU/16 GiB
box == the ubuntu runner).** Wall time + tree-wide peak RSS (summed across
all `sailfin`/`clang`/`ld` processes) per shard, sweeping `--jobs`:

| shard | jobs=1 | jobs=2 | jobs=3 | jobs=4 | peak RSS |
|---|---|---|---|---|---|
| `e2e-c` (build-spawners, heaviest type) | 389.7s | 218.9s (1.78×) | 189.4s (2.06×) | 173.7s (2.24×) | 1.6 → 2.1 GiB |
| `unit-a` (frontend compiles) | 596.4s | — | — | 88.4s (**6.75×**) | 3.6 → 3.2 GiB |

Peak RSS stays **flat or drops** under parallelism, topping out at 3.6 GiB —
22% of the 16 GiB runner — because test-fixture emits are ~30× lighter than
a heavy compiler module. Memory was never the binding constraint for the
test surface. e2e shards gain ~2× (each test already spawns a nested
multi-core `sfn build`); frontend/unit shards gain ~6× (single compiles that
leave cores idle on link/spawn stalls when serial).

> **Measurement method / accuracy.** The `peak RSS` column is the tree-wide
> anonymous working set from a 0.2 s `ps` sampler (matched `sailfin`/`clang`/
> `ld…` process names; page cache excluded). This box has no GNU
> `/usr/bin/time`, so per-module `make bench` memory reads 0 — a separate
> limitation that does not affect these figures. Cross-checked against the
> kernel's own cgroup accounting (`memory.max_usage_in_bytes`, reset then
> read after one run): e2e-c @ jobs=3 charged **3.18 GiB** total vs the
> sampler's 2.1 GiB — the ~1 GiB delta is reclaimable page cache from the
> IR/object/binary writes (evicted under pressure before any OOM), plus a
> little RSS the name filter misses. So the honest ceiling is ~3.2 GiB
> cache-inclusive / ~2.1 GiB hard working set; both sit far under the 16 GiB
> (Linux) / 7 GiB (macOS) budgets, and the jobs=3/2 decision holds under the
> higher, kernel-measured number. macOS remains the extrapolated case (no
> `RLIMIT_AS` backstop) pending one CI confirmation run.

**Shipped.** `scripts/test_shards.sh run` reads `SAILFIN_TEST_JOBS` (default
1 = byte-identical serial; non-numeric → serial, which also blocks
word-injection into the unquoted expansion); the `sailfin-build` action
forwards it via a `shard_test_jobs` input; `ci.yml` sets **3** on Linux legs
and a conservative **2** on macOS legs. macOS is conservative because Darwin
has **no** `RLIMIT_AS` backstop (SFEP-0022) and the runner is 7 GiB/3-vCPU;
its value should be confirmed against one real CI run before raising, per
SFEP-0022 §7. The compiled-in runner default stays 1 for local determinism
and arbitrary callers. Emit fan-out (`_cr_resolve_jobs`, clamp `[1, 8]`) is
**unchanged** — it already resolves to 3 (Linux) / 1 (macOS 7 GiB) on
GitHub runners, so raising the clamp buys nothing until runners exceed 8
cores.

> Observed but out of scope: `effect_gate_build_path_entry_test.sfn` (line
> 129) fails standalone in a fresh container (exit 134) — identical at every
> `--jobs` level, so parallelism-independent. Tracked separately.

---

## 5. Reconciliation with existing epics

- **#843 Phase 4 (post-1.0, blocked on `routine`/`spawn`).** This plan
  does **not** unblock or pull forward in-process `--jobs` parallelism.
  It achieves the *same wall-time goal* via OS-level CI sharding (Lever 1)
  and caching (Lever 2), neither of which needs the concurrency runtime.
  When Phase 4 lands post-1.0, `sailfin test --jobs N` becomes an
  *additional* in-leg multiplier composable with sharding. Update
  `02-phases.md` to note that the CI-sharding path (this doc) is the
  pre-1.0 stand-in for 4.1's wall-time goal; 4.1 remains the in-process
  story. No conflict.
- **#513 Makefile slim-down (sfn owns build/check/cross/stamp).** Lever 1
  Seam B (`sailfin test --shard I/N`) and Lever 2 (cache in the runner)
  both move logic *into* `sfn`, aligning with #513. The Phase-1 CI-only
  Seam A is a temporary bash/Makefile seam; flag it for migration to
  Seam B so we don't accrete shard logic in `ci.yml` long-term.
- **#940 (multi-file runner forking).** Lever 2 builds directly on the
  per-invocation runtime-objdir warming (`cli_commands.sfn:1121-1141`)
  and the per-file subprocess shape. The binary cache slots into
  `_run_test_child` / `_clang_link_test_cmd_with_deps` — check the cache
  before lowering+linking, populate it after a successful link.
- **#1011 (macOS parallel-build contention).** Lever 1 makes each shard a
  separate runner (no shared scratch — strictly *safer* than today's
  single-runner BUILD_JOBS=2). Lever 2's cache writes must be atomic
  (rename-into-place) to be shard-safe. The `xargs -P` intra-shard
  variant (NOT recommended for Phase 1) would reintroduce single-runner
  contention and must isolate `SAILFIN_TEST_SCRATCH` per worker — only
  pursue if shard count hits diminishing returns.

---

## 6. Sequencing & ownership

| Step | Lever | Where | Owner | Risk | Wall delta (macOS) |
|---|---|---|---|---|---|
| 1 | L1 Seam A: shard `ci.yml` matrix 2→2x4, file-list selection, per-shard `make rebuild`, **shard-cover lint** | CI-config + thin Makefile target | CI | low | 47→~16-18 min |
| 2 | L1 1b: split build into a `needs:` job, share `build/native` + `build/cache` artifact across shards | CI-config | CI | low-med | removes redundant build minutes; small wall win |
| 3 | L1 Seam B: `sailfin test --shard I/N` deterministic partition | runner (`cli_commands.sfn`) | compiler | low | (durability, not wall) |
| 4 | L2 2a: per-test binary cache (key + read/write in runner), atomic writes, `--no-test-cache` for full suite — **shipped (#1230)** | runner (`cli_commands.sfn` + `build_cache.sfn`) | compiler | med | incremental PRs 50-80% suite skip |
| 5 | L2 CI: save/restore `build/cache/test-bin` per shard; nightly baseline warm | CI-config | CI | low | warms first-push hits |
| 6 | L3: smoke tag + macOS-smoke PR leg + **full suite on push:main** | runner tag (exists) + CI-config + content pass | CI + compiler (curation) | med-high | only if 1-2 insufficient |

**Dependencies:** Step 2 depends on 1. Step 3 supersedes Seam A from 1
(do after 1 ships). Step 5 depends on 4. Step 6 depends on 1 (and the
push:main full-suite job) and should only proceed if 1+2 leave macOS
above target.

---

## 7. Phase 1 — ship this week (safe quick win, zero compiler change)

Do exactly Lever 1 Seam A + the cover lint. This is pure CI-config plus
one thin Makefile target and **touches no `.sfn`**, so it can't break
self-hosting, the determinism gates, or formatting:

1. Add `make test-shard SHARD=<name>` (or inline in `ci.yml`) that maps a
   shard name to a `find ... | sort | split/stride` file list and runs
   `$(NATIVE_BIN) test <files>` (and, for the `e2e-sh` shard, `make
   test-e2e-sh`). Honor `ulimit -v 8388608` on Linux as today.
2. Fan `ci.yml`'s matrix to `os x shard` (4 shards/OS as in §4). Each leg:
   build (warm cache) + its shard. Keep fmt/canary/effect-gate/cross on
   **one** designated leg per OS (e.g. `unit-a`) so they run once, not 4x.
3. Add a `shard-cover` check: assert `sort -u` of every shard's file
   list equals `find compiler/tests -name '*_test.sfn' | sort` plus the
   capsule glob (and the `.sh` set for the e2e-sh shard). Fail CI if a
   file is uncovered or double-covered.
4. Keep `build-quality.yml` (push:main) and nightly `selfhost.yml`
   exactly as-is — full coverage still gates at merge-adjacent points.

Expected result this week: macOS PR ~47 → ~16-18 min, Linux ~24 → ~10-11
min, **no coverage lost, no compiler risk.** Levers 2 and 3 follow as
runner work and a scope decision respectively.

---

## 8. Verification

- **Per-shard correctness (Phase 1):** the sum of per-shard pass counts
  across a full PR run equals the pre-shard `make test` pass count.
  Concretely: run the cover lint (step 3 above) + compare aggregate
  `═══ ...: N/M passed ═══` banner totals against a baseline `make test`
  run on the same SHA.
- **No coverage drift:** `shard-cover` lint green on every PR.
- **Determinism untouched:** `ci.yml` fixed-point step
  (`ci.yml:277-330`) and `build-quality.yml` gates still pass on
  push:main — they don't read the test-binary cache, and Lever 2 ships
  with `--no-test-cache` on the full-suite/check paths.
- **Lever 2 cache correctness:** a PR that edits one
  `compiler/src/*.sfn` dep must show cache *misses* for every test
  transitively importing it and *hits* for the rest (assert via a
  `cache.test_bin_hit_rate` field added to the runner's `--json`
  summary, mirroring `cache.hit_rate`). A no-op rerun must show ~100%
  test-bin hits.
- **Self-host + fmt (any `.sfn` touched in Steps 3-6):** `make compile &&
  make test` green; `sfn fmt --check` clean on touched files.

---

## 9. Future considerations (toward 1.0)

- **Phase 4 composability.** When `routine`/`spawn` land, `sailfin test
  --jobs N` (4.1) multiplies *within* each shard; the shard map and the
  binary cache both survive unchanged. The `--shard I/N` partition (Seam
  B) and `--jobs N` are orthogonal axes.
- **#513 end-state.** Seam B + the test-binary cache push more build/test
  ownership into `sfn`, shrinking the Makefile/CI bash surface — exactly
  the #513 direction. The Phase-1 bash seam is explicitly temporary.
- **Optional stacked follow-up (NOT prioritized here):** lld/mold +
  raising the macOS `BUILD_JOBS` cap (#343). The per-test clang **link**
  is the dominant per-test cost (§Lever 2); a faster linker compounds
  with both sharding and the binary cache. Mention only — out of scope
  for this plan.
