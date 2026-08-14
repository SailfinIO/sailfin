---
sfep: TBD
title: Shared runtime/dep object cache for nested builds in the e2e suite
status: Draft
type: tooling
created: 2026-08-14
updated: 2026-08-14
author: "agent:compiler-architect; human review"
tracking:
supersedes:
superseded-by:
graduates-to:
---

# SFEP-XXXX — Shared runtime/dep object cache for nested builds in the e2e suite

## 1. Summary

The e2e suite repeats runtime and dependency `.o` assembly per test file, because
several build-spawning code paths route their object cache under the per-file
`SAILFIN_TEST_SCRATCH`.

This proposal **rejects** sharing `SAILFIN_TEST_SCRATCH` across pool children as
unsound (§3.5): that directory holds fixed-name, non-content-addressed artifacts
(`program.ll`, `program.o`, `run.ll`, `run`, `test.ll`, `test`) whose collision
under `--jobs N` is the exact regression #1333 and #1411 were filed for, and the
failure mode is *executing another test's binary*.

Instead it generalises a seam the codebase already ships and already proved
concurrency-safe: `SAILFIN_TEST_RUNTIME_OBJDIR`
(`compiler/src/cli/commands/test/link.sfn:76-79`), a content-addressed,
`.key`-sidecar-gated, atomic-rename multi-writer object store
(`compiler/src/build/runtime_objs.sfn:344-357`, `:879-909`) that the pool already
prewarms once per invocation and hands to every child
(`compiler/src/cli/commands/test/multi_file_run.sfn:83-109`, `pool.sfn:197`).
Today only the `sfn test` **leaf link** honours it. This proposal extends it to
`sfn build` / `sfn run` links and to nested runners.

**Sizing, after attribution (§2.5): the claimable win is small and the headline
A/B number is a harness artifact.** The 504→246s five-file measurement ran five
*separate* `sfn test <file>` invocations, each of which takes the single-file leaf
path (`mod.sfn:543-547`) and therefore never sets `SAILFIN_TEST_RUNTIME_OBJDIR` —
so it hand-reproduced the #940 optimisation the pooled runner already performs.
It does not measure the pooled suite. See §2.5 and §9.1; the pooled baseline is
still unmeasured and §8.1 makes measuring it a blocking gate.

## 2. Motivation

### 2.1 The measured problem (input, restated)

On a 4-core/15 GiB box with `build/bin/sfn`:

| Case | Time |
|---|---|
| `array_filter_closure_test.sfn`, fresh HOME + `SAILFIN_BUILD_CACHE_DIR` + `SAILFIN_TEST_SCRATCH` | 73.45s |
| same, immediate re-run on the same roots | 1.56s |
| the nested `sfn run` alone, standalone | 1.61s cold / 1.10s warm |
| five heaviest build-spawning e2e files, **one `sfn test` invocation each**, fresh scratch per file | 504.62s |
| the same five sharing one `SAILFIN_TEST_SCRATCH` | 246.32s |

Per-file, fresh → shared:

| File | Nested command | Fresh | Shared | Win |
|---|---|---|---|---|
| `cli_bare_file_cached_capsule_import` | `sfn build` | 65.7 | 3.5 | 95% |
| `array_interpolation` | `sfn build` | 110.9 | 45.7 | 59% |
| `harness_crash_durability` | `sfn test` | 132.4 | 63.9 | 52% |
| `harness_stream_records` | `sfn test` | 123.2 | 64.1 | 48% |
| `array_filter_closure` | `sfn run` | 72.4 | 69.1 | **4.5%** |

The spread is the signal. It is not one mechanism, and §2.5 shows the *harness*
is one of the mechanisms.

### 2.2 Confirmations of the stated cause

- The pool does mint a per-file scratch, but **not** at `pool.sfn:182-209` (that
  range is `_pool_child_env`, which only *stamps* the value). The mint is
  `compiler/src/cli/commands/test/multi_file_run.sfn:191`
  (`let spawn_scratch = sub_root + "/sub-" + int_to_string(launched);`), with
  twins at `:263` and `:316`. Each child scratch is a **subdirectory of one
  invocation-wide `sub_root`** — a shared root already exists.
- That value governs `_cr_scratch_root()` (`capsule_resolver/paths.sfn:132-138`),
  `_test_scratch_root()` (`test/cache_scratch.sfn:31-35`), and
  `_resolve_sailfin_cache_dir_for_work()` (`build/cache.sfn:185-190`).
- A warm `SAILFIN_BUILD_CACHE_DIR` genuinely does not short-circuit the
  per-invocation resolve: `_cr_compile_one` (`capsule_resolver/compile.sfn:81-202`)
  has no "`.ll` already on disk, skip" branch, so every module pays `cache_key_for`
  plus a lookup and a restore-copy even on a hit.

### 2.3 Corrections — where the code contradicts the stated cause

**(a) The `.ll` module cache is mostly not scratch-resident.** `_cr_scratch_root()`
backs only `_cr_legacy_ll_path` (`paths.sfn:146-148`), the *fallback*. The primary
route is `ir_path_for_slug` → `capsule_artifact_ir_dir`, rooted at the fixed
in-tree `build/capsules/<scope>/<name>` (`capsule_artifact.sfn:194-196`). The
`.sfn-asm` / `.layout-manifest` / `.srchash` staging tree is
`_cr_import_context_root("")` = fixed in-tree `build/compiler/import-context`
(`paths.sfn:72-75`; `staging.sfn:194-196`). Both are already shared across every
pool child and already concurrently written.

**(b) `sfn run` puts nothing expensive in the scratch.** `run.sfn:183` calls
`_clang_link_multi(..., cache_dir = "")`, and `_resolve_sailfin_cache_dir("")`
returns the **literal `"build/sailfin"`** (`build/link.sfn:405-408`) — never
`SAILFIN_TEST_SCRATCH`. Only `run.ll` and `run` are scratch-routed
(`run.sfn:116-123`, #1411). Measurement agrees: 72.4 → 69.1.
**`array_filter_closure`'s ~70s is not scratch-attributable and is out of scope.**

**(c) `sfn build` does, and that is one of the two real consumers.**
`build.sfn:220` resolves `sailfin_cache_dir` via
`_resolve_sailfin_cache_dir_for_work(work_dir)` — `SAILFIN_TEST_SCRATCH` when
`work_dir` is empty — and passes it to `_clang_link_multi` at `:553`. Inside
`_clang_link_multi_with_opt` that argument is used for exactly two things, both
content-addressed object stores: `assemble_runtime_capsule_link_inputs(..., cache_dir, ...)`
(`link.sfn:278` — ~24 C/LL runtime objects plus ~14 runtime `sfn-source` emits)
and `assemble_link_inputs(ll_paths, cache_dir + "/link-obj", ...)`
(`link.sfn:294`). **Nothing else.**

**(d) None of the four "cold-dependent" files are broken by a shared outer
scratch.** Each mints its own isolation inside the test:
`dep_closure_prewarm_test.sfn:117-124` (own cache dir + ledger + scratch, hand-built
env at `:53-65`); `build_clean_runtime_objects_test.sfn:55,:91` (`fs.mkdtemp` root,
own cache dir, and `--work-dir` which outranks the scratch at `build/cache.sfn:186`);
`dep_object_cache_test.sfn:57,:78,:84`; `build_json_schema_test.sfn:95-100`. Their
coldness is a property of the env they *construct*, not the env they *inherit*.

### 2.4 Attribution probe — result

Run against `compiler/tests/e2e/fixtures/array_filter_closure/main.sfn` with
`sfn build`, cold scratch, warm CAS, `SAILFIN_CACHE_TRACE=1`:

```
[stage cache] local_hits=34 hits=0 misses=0 stores=0 restore_failed=0
[cache]       hits=70 misses=0 stores=0 invalid_keys=0 copy_failures=0
>>> elapsed 3.45 s
```

`misses=0` across both layers: **nothing recompiles**, everything is served from
the CAS or the local `.srchash` tree. And **a cold scratch with a warm CAS costs
3.45s, not 62s.** The probe answers copy-vs-recompile (copy) and simultaneously
falsifies the premise that scratch coldness costs tens of seconds per nested build.

### 2.5 Reconciliation — the A/B harness bypasses an optimisation the pool has

The 3.45s probe and the 65.7–132.4s A/B numbers are both correct; they measure
different runners.

**`sfn test <one file>` does not use the pool.** `mod.sfn:543-547`:

```
if test_files.length > 1 {
    return _run_multi_file(...);
}
return _run_single_process(...);
```

`_run_multi_file` is the *only* site that warms the runtime once per invocation
(`multi_file_run.sfn:83-109`) and the *only* site that sets
`SAILFIN_TEST_RUNTIME_OBJDIR` (`pool.sfn:197`). A single-positional-file
invocation reaches `_run_single_process`, which passes `scratch_root` straight
through as `cache_dir` (`single_process_run.sfn:312`), and
`_clang_link_test_cmd_with_deps` then finds no objdir env
(`test/link.sfn:76-78`) and falls back to it. So a lone `sfn test <file>` builds
**the whole runtime — 24 C/LL objects, 14 `sfn-source` emits — plus every
`link-obj/*.o`, into its own scratch.**

That is exactly what #940 was filed for; `test/link.sfn:66-75` states the problem
verbatim. The A/B ran five such invocations. Experiment B, by pointing all five at
one `SAILFIN_TEST_SCRATCH`, hand-reproduced #940's effect across invocations.

**Consequences.**

1. The 504→246s result **does not measure the pooled e2e suite**, and neither does
   the 1578s "fresh per-file ranking across 157 files". In a real
   `sfn test compiler/tests/e2e --jobs N` the runtime is already compiled once and
   `link-obj` is already shared. The pooled baseline is unmeasured.
2. **Runtime objects are already shared across pool children today** (answer to
   (b) in the review): `multi_file_run.sfn:83-109` warms `sub_root`,
   `pool.sfn:197` hands it down, `test/link.sfn:77-78` consumes it. What remains
   per-child in `sub-<n>` is `test.ll`, the linked `test` binary, `test-o0/`,
   dump-sources output, fixture temp dirs — and, critically, whatever a *nested*
   build puts there.
3. **The test binary itself is not the mechanism** (answer to (a)). It is built at
   `single_process_run.sfn:70,74` (`<scratch>/test.ll`, `<scratch>/test`) but
   cached in the CAS, not the scratch — `tb_cache_root` at `:249`/`:357` is
   `test_bin_cache_root_with_override(SAILFIN_BUILD_CACHE_DIR)`. A warm CAS serves
   it regardless of scratch state, and on a hit the whole lower+link is skipped
   (`:250-268`, `:273`). What *is* scratch-rooted is the set of **inputs** to
   producing it when the CAS misses — the runtime and `link-obj` objects — which
   is the objdir role this proposal targets. So §3 targets the right seam; it was
   the sizing, not the seam, that was wrong.
4. **The per-file wins split by nested command, and only two of three groups are
   in scope:**
   - `cli_bare_file_cached_capsule_import`, `array_interpolation` — nested
     `sfn build`, which inherits `SAILFIN_TEST_RUNTIME_OBJDIR` via
     `process.environ()` but **does not read it** (only `test/link.sfn` does).
     This is precisely the §3.3 gap, and it is real in a pooled run.
   - `harness_crash_durability`, `harness_stream_records` — nested `sfn test`,
     whose objdir is stripped by `clean_runner_env` (`fixtures.sfn:159-161`) and
     which then, being single-file, takes `_run_single_process` and rebuilds the
     runtime into `<outer_scratch>/<label>`. This is the §3.6 gap, also real.
   - `array_filter_closure` — nested `sfn run`, nothing scratch-resident (§2.3b).
     Out of scope.

**Residual unexplained gap — do not paper over it.** Even granting (4), a nested
`sfn build` into a cold scratch measured 3.45s, yet `cli_bare_file` fell 65.7 →
3.5s. A ~62s delta remains unattributed. The most likely candidate is that
`cli_bare_file_cached_capsule_import` **overrides `HOME`** for its nested build
(`:42-43, :99`), so unless `SAILFIN_BUILD_CACHE_DIR` or `XDG_CACHE_HOME` is
present in the inherited env, `cache_root_from` (`build_cache.sfn:664-671`) falls
to `$HOME/.cache/sailfin` under a fresh tmp HOME — a **cold CAS**, and the cost is
recompilation, not scratch coldness. If so, the file's 62s is a property of that
one fixture's env construction and is not generalisable to the suite. §8.1 settles
it.

## 3. Design

### 3.1 The invariant: split the two roles `SAILFIN_TEST_SCRATCH` conflates

| Role | Contents | Sharing |
|---|---|---|
| **Private work root** | `program.ll` / `program.o` (`build.sfn:461`, `:357`), `run.ll` / `run` (`run.sfn:119`, `:123`), `test.ll` / `test` (`single_process_run.sfn:70`, `:74`), `test-o0/`, dump-sources output, fixture temp dirs | **Never shared.** Fixed names, non-content-addressed, executed. |
| **Object cache root** | runtime `.o` + `.key` sidecars, runtime `sfn-source` `.ll`/`.o`, `link-obj/*.o` | **Shared.** Content-keyed, sidecar-validated, atomic-rename multi-writer. |

`SAILFIN_TEST_SCRATCH` keeps its current meaning and stays per-file. A **new,
separate variable** carries the object-cache root.

### 3.2 The variable

Introduce `SAILFIN_SHARED_OBJDIR`, resolved by one helper in
`compiler/src/build/cache.sfn` beside `_resolve_sailfin_cache_dir_for_work`:

```
_resolve_shared_objdir(fallback: string) -> string
  // env SAILFIN_SHARED_OBJDIR, else env SAILFIN_TEST_RUNTIME_OBJDIR,
  // else `fallback` (today's behaviour, byte-for-byte).
```

New variable rather than reuse: `SAILFIN_TEST_RUNTIME_OBJDIR` is paired with
`SAILFIN_TEST_RUNTIME_STAMP`, an invocation nonce (`multi_file_run.sfn:93-108`,
`runtime_objs.sfn:509-519`), and SFN-17 / PR #2411 stripped the pair from nested
runners precisely because the *stamp binding* was one of three symptoms
(`fixtures.sfn:139-158`). A nonce-free variable is shareable by construction: a
child reading it with no nonce does full key derivation and validates against the
on-disk `.key` sidecar, which `runtime_objs.sfn:500-508` documents as the
freshness authority.

### 3.3 Where it is honoured

1. **`compiler/src/build/link.sfn:392-400`** — apply
   `_resolve_shared_objdir(resolved_cache_dir)` inside `_clang_link_multi`,
   immediately after `_resolve_sailfin_cache_dir`. The whole of
   `_clang_link_multi_with_opt`'s `cache_dir` parameter is the object-cache role
   (§2.3c), so this one edit covers both `sfn build` (`build.sfn:553`) and
   `sfn run` (`run.sfn:183`).
   - Do **not** touch `build.sfn:461`/`:357` or `run.sfn:119`/`:123`.
   - Do **not** apply when `--work-dir` is non-empty — that is an explicit
     hermeticity request (`build/cache.sfn:186`,
     `build_clean_runtime_objects_test.sfn:91`). Gate on `work_dir.length == 0`
     at the `build.sfn` call site, so `cli_selfhost.sfn`'s pinned work dirs
     (`:659`, `:685`) are untouched.
2. **`compiler/src/cli/commands/test/link.sfn:76-79`** — extend the ladder to
   consult `SAILFIN_SHARED_OBJDIR` first, then `SAILFIN_TEST_RUNTIME_OBJDIR`,
   then `cache_dir`. No behaviour change for the pool today; this lets a *nested*
   runner participate.
3. **`compiler/src/cli/commands/test/pool.sfn:182-197`** — stamp
   `SAILFIN_SHARED_OBJDIR=<sub_root>` alongside the existing objdir, and drop any
   inherited copy in the same filter at `:188-191`. The parent already prewarms
   `sub_root` (`multi_file_run.sfn:83-109`).

### 3.4 How a file declares it needs isolation — it already does

**The opt-out is the default; no new API, marker, or allowlist is required.**

`SAILFIN_SHARED_OBJDIR` only reaches a nested build if the test hands it to the
child. E2E tests fall into two camps: `process.environ()` passthrough
(`array_filter_closure_test.sfn:29`, `array_interpolation_test.sfn:22`, most of the
309 subprocess-driving files) inherits and gets the speedup; hand-built child envs
do not — and every one of the four cache-state-asserting files hand-builds its env
(§2.3d), because `.claude/rules/no-bash-e2e.md` and SFN-401 already pushed that
class of test there.

The failure mode the brief worries about — a test silently passing against a warm
cache when it meant to assert cold behaviour — requires a test that both asserts
cache counters and blanket-inherits `process.environ()`. That combination is
already incoherent under the pool (it would also inherit `SAILFIN_BUILD_CACHE_DIR`,
making the assertion vacuous — the reason `dep_closure_prewarm_test.sfn:43-52`
spells this out), and exists in zero files today.

Two supporting measures:

- **A guard test, not a marker.** `compiler/tests/e2e/cache_assertion_env_hygiene_test.sfn`:
  scan `compiler/tests/e2e/*.sfn`; any file containing a cache-counter assertion
  substring (`"misses="`, `"\"hit_rate\""`, `"\"stores\""`, `"\"hits\":"`,
  `link-obj`) must not contain `process.environ()` outside a `clean_runner_env`
  call. Mechanical, cheap, fails **loudly** at authoring time.
- **A named escape hatch.** `isolated_build_env(label) -> string[]` in
  `capsules/sfn/test/src/fixtures.sfn` beside `clean_runner_env` (`:200-213`):
  same strip, plus `SAILFIN_SHARED_OBJDIR` and `SAILFIN_BUILD_CACHE_DIR` stripped
  and re-pointed at fresh `fs.mkdtemp` roots. Adopting it in the four files is
  optional cleanup, not part of the correctness argument.

**Rejected: a per-file marker the pool reads** (forces a read of every test file on
the launch path; a forgotten marker fails silently in the unsafe direction).
**Rejected: a static allowlist in the runner** (drifts, lives far from the test,
same silent failure).

### 3.5 Parallel-safety

**Blanket shared `SAILFIN_TEST_SCRATCH` is unsafe. Do not ship it.**

- `run.sfn:119`/`:123` — `<scratch>/run.ll` and `<scratch>/run` are **fixed
  names**, and `:212` executes `exe_path`. Two concurrent children overwrite each
  other's executable and one runs the other's binary. Documented as #1411 at
  `run.sfn:107-115`.
- `build.sfn:461`/`:357` — `program.ll`/`program.o`, same shape, documented as
  #1333 at `build/cache.sfn:174-184`: *"producing a cross-contaminated binary
  under the parallel `sfn test` pool."*
- `single_process_run.sfn:70`/`:74` — `test.ll` / `test`, same shape.

**The object-cache half is already proven safe for concurrent fill:**

- Runtime `.o`/`.ll`: `_mktemp_sibling_cmd` + `_atomic_rename_into_place`, added
  by SFN-87 / #1726 for exactly this reason —
  `runtime_objs.sfn:344-354` and `:879-886` state verbatim that `out_dir` "is a
  shared, best-effort prewarmed objdir (`SAILFIN_TEST_RUNTIME_OBJDIR`), so a
  prewarm miss can put two pool children in this branch for the same `obj`
  concurrently."
- CAS restores/stores go through `_cache_atomic_copy` (`build_cache.sfn:823-834`,
  used by `:929-950` and `:914-922`).
- Staging publishes its completeness gate atomically (`staging.sfn:111-124`,
  #1011) and re-verifies a restored `.sfn-asm` is non-empty
  (`stage_cache.sfn:207-222`).
- The stampede `dep_closure_prewarm_test.sfn` guards is a **waste** problem, not a
  corruption problem — duplicate emits were always correct-but-slow. SFN-148's
  `_prewarm_test_dep_closures` (`pool.sfn:7-62`) is the serialise-then-fan-out
  answer and already runs (`multi_file_run.sfn:149`).

**Residual:** two children could derive different cache keys for the same
legacy-routed `<scratch>/capsules/<mangled>.ll` if their dep-manifest closures
differ. This is why §3.1 shares only the object dirs, whose filenames fold content
identity via `.key` sidecars and `_runtime_obj_stem`. The no-`mktemp` degrade
(`build_cache.sfn:825-828`, `runtime_objs.sfn:355-358`) is non-atomic; that host
also forces serial emit, which is per-process and does not bind sibling children.
Accepted risk, unchanged in kind from today's objdir (§9.2).

### 3.6 The nested-`sfn test` family

`harness_crash_durability_test.sfn:48-49` and `harness_stream_records_test.sfn:45-46`
spawn a nested `sfn test` via `clean_runner_env(nested_runner_scratch(label))`.
`nested_runner_scratch` (`fixtures.sfn:184-188`) returns `<outer_scratch>/<label>`,
and the nested run is single-file, so it reaches `_run_single_process` and rebuilds
the entire runtime there (§2.5).

Fix: **deliberately omit `SAILFIN_SHARED_OBJDIR` from `_pool_managed_keys()`**
(`fixtures.sfn:159-161`) so `clean_runner_env` passes it through. The nonce-free
design in §3.2 is what makes that safe. This intentionally breaks that function's
stated "mirror `_pool_child_env`" contract and must carry an explicit comment
naming this SFEP, or a future contributor will "fix" it and silently revert the win.

Separately, `subframe_aggregation_stream_test.sfn:43,86` uses two different labels
for byte-identical fixtures; collapsing them is a free intra-file win, independent
of everything above.

## 4. Effect & capability impact

None. No new effect, no change to `canonical_effects()`. Every touched function is
already `![io]`; `_resolve_shared_objdir` reads the environment via the existing
`env.get` / `_get_env_cmd` builtins used by its neighbours.

## 5. Self-hosting impact

No compiler *pass* changes — build-driver orchestration only
(`compiler/src/build/`, `compiler/src/cli/commands/`) plus one capsule
(`capsules/sfn/test/`).

Seed dependency: **none, and nothing must be split.** The change is behavioural in
the compiler binary, consumed by test *sources*, not by `runtime/` source calling
a new builtin, so the runtime-source carve-out in `.claude/rules/seed-dependency.md`
does not apply. `make compile` builds the new compiler from the old seed and that
fresh binary runs the suite in the same pass. Land the compiler change,
`fixtures.sfn` change and guard test as **one PR**.

`cli_selfhost.sfn` pins `SAILFIN_TEST_SCRATCH` per stage (`:307-313`, `:659`) and
sets no `SAILFIN_SHARED_OBJDIR`, so seedcheck/stage3 must be byte-for-byte
unchanged — verify explicitly (§8.6).

## 6. Alternatives considered

**A. Share `SAILFIN_TEST_SCRATCH` across pool children.** Rejected on correctness
(§3.5): re-opens #1333/#1411; the failure is a wrong binary executed. Also changes
behaviour for every unit and integration test.

**B. Make `nested_runner_scratch` default to a suite-shared root.** Rejected as the
primary lever: it moves the same unsafe artifacts one level down, and reaches only
the `harness_*` family. It is the right shape once sharing is narrowed to the
objdir — see §3.6, which achieves the same effect through the env instead.

**C. A "needs cold cache" marker or runner allowlist.** Rejected in §3.4: both fail
silently when forgotten. The guard test achieves the coverage failing loudly.

**D. Give `_cr_compile_one` an mtime fast path.** Rejected: trades a
content-addressed guarantee for a heuristic in the one place
(`compile.sfn:98-126`) where staleness is currently impossible. §2.4 shows nothing
recompiles anyway.

**E. Make `_run_single_process` warm the runtime into a stable shared objdir the
way `_run_multi_file` does.** *Not rejected — deferred, and possibly the larger
lever.* This is what experiment B simulated by hand, and it would speed up every
developer's `sfn test <one file>` inner loop (the rung-3 command issue acceptance
criteria are written against, per `CLAUDE.md`'s validation ladder). It is out of
scope here because it does not affect CI's pooled run at all, and because a
single-file invocation has no invocation-wide root to warm into — it would need a
persistent, cross-invocation objdir with its own eviction story. File separately;
§2.5 is the evidence for it.

**F. Do nothing; raise `--jobs`.** Rejected: `_test_jobs_budget`
(`test/arg_and_jobs.sfn`) is already RAM-bound at 3 GiB/job per
`.claude/rules/compiler-safety.md`.

## 7. Stage1 readiness mapping

- [ ] Parses — n/a, no syntax change
- [ ] Type-checks / effect-checks — n/a
- [ ] Emits valid `.sfn-asm` — n/a
- [ ] Lowers to LLVM IR — n/a
- [x] Regression coverage — §8
- [ ] Self-hosts — `make compile`, then `make check`
- [ ] `sfn fmt --check` clean
- [ ] Documented — `docs/conventions/e2e-tests.md`; `docs/status.md` unchanged

## 8. Test plan

### 8.1 Corrected attribution (blocking — the 3.45s probe was the wrong workload)

The §2.4 probe measured a bare `sfn build`. The workload that costs 65.7s is
`sfn test <file>`, whose cost includes the leaf runtime build (§2.5). Three
commands, in order:

```
# (i) Reproduce the real 60s+ cost and see every cache layer, including the
#     nested child's (it inherits SAILFIN_CACHE_TRACE via process.environ()).
SAILFIN_TEST_SCRATCH=$(mktemp -d) \
SAILFIN_CACHE_TRACE=1 SAILFIN_TRACE_TEST_RUNNER=1 \
  /usr/bin/time -f 'elapsed %e' \
  build/bin/sfn test compiler/tests/e2e/cli_bare_file_cached_capsule_import_test.sfn \
  2>&1 | grep -E '^\[(cache|stage cache)\]|elapsed|cache (hit|miss)'
```

Expect several `[cache]` blocks — one per nested build. **The block with nonzero
`misses` names the mechanism.** Specifically: if the nested build's block shows
misses, confirm the §2.5 residual hypothesis by re-running with
`SAILFIN_BUILD_CACHE_DIR=$HOME/.cache/sailfin` explicitly exported (which survives
the fixture's `HOME` override at `:42-43`); if the misses vanish, the 62s was a
cold CAS caused by that fixture's own `HOME` rewrite, not by scratch coldness, and
this proposal cannot claim it.

```
# (ii) The only baseline that matters: ONE pooled invocation, cold scratch.
SAILFIN_TEST_SCRATCH=$(mktemp -d) /usr/bin/time -f 'pooled %e' \
  build/bin/sfn test compiler/tests/e2e --jobs 4

# (iii) Quantify the harness artifact: the same files, one invocation each.
#       The difference between (iii) and (ii) is the #940 effect the A/B measured.
for f in compiler/tests/e2e/*_test.sfn; do
  SAILFIN_TEST_SCRATCH=$(mktemp -d) build/bin/sfn test "$f"; done
```

**No percentage may be claimed against anything but (ii).**

### 8.2 Speedup

Baseline (ii) and post-change (ii), three runs each, report the median. Plus the
per-file spot checks for the two in-scope groups:

```
for f in cli_bare_file_cached_capsule_import array_interpolation \
         harness_crash_durability harness_stream_records; do
  SAILFIN_TEST_SCRATCH=$(mktemp -d) /usr/bin/time -f "$f %e" \
    build/bin/sfn test compiler/tests/e2e/${f}_test.sfn
done
```

Acceptance: no per-file regression anywhere; a measurable improvement on (ii).
`array_filter_closure` is expected to be flat (§2.3b) — a change there means the
ladder leaked somewhere unintended.

### 8.3 Correctness — mutation-test the four cold-dependent files

Break the invariant, confirm the test **fails**, restore, confirm it passes:

| File | Mutation | Must fail on |
|---|---|---|
| `dep_closure_prewarm_test.sfn` | comment out `_prewarm_test_dep_closures(...)` at `multi_file_run.sfn:149` | outcome `1` (duplicate digest) |
| `build_clean_runtime_objects_test.sfn` | no-op `clean_runtime_object_cache(...)` at `build.sfn:551` | step C asserting `misses=0` absent |
| `dep_object_cache_test.sfn` | point `link_obj_dir` (`test/link.sfn:79`) at a per-invocation temp | test 1's `ls link-obj` finding no `.o` |
| `build_json_schema_test.sfn` | make `_fresh_iso()` return `_shared_shape_iso()` | tests 3, 4, 8 |

Run each as `build/bin/sfn test compiler/tests/e2e/<file>.sfn -k "<name>"`.

Then all four in one pooled invocation with the shared objdir active, proving
inherited warmth cannot reach them:

```
build/bin/sfn test \
  compiler/tests/e2e/dep_closure_prewarm_test.sfn \
  compiler/tests/e2e/build_clean_runtime_objects_test.sfn \
  compiler/tests/e2e/dep_object_cache_test.sfn \
  compiler/tests/e2e/build_json_schema_test.sfn --jobs 4
```

### 8.4 Parallel-safety

- Full e2e suite at `--jobs 4`, **five consecutive runs**; any flake is a blocker,
  not a retry.
- `compiler/tests/e2e/nested_runner_no_collision_test.sfn` stays green.
- New unit test for `_resolve_shared_objdir`'s ladder (explicit → legacy objdir →
  fallback; empty string behaves as unset, matching `paths.sfn:128-131`).

### 8.5 Guard

`compiler/tests/e2e/cache_assertion_env_hygiene_test.sfn` (§3.4) — verify it fails
when a cache-counter assertion is added to a file using bare `process.environ()`.

### 8.6 Self-host

`make clean-build`, then `make check`. Seedcheck timing must be unchanged; a shift
means the ladder leaked into `cli_selfhost.sfn`'s pinned work dirs.

## 9. Risks

### 9.1 Claimable range — revised down

The prior draft claimed 30–45%. **That is withdrawn.** §2.5 shows the 504→246s
A/B measured five non-pooled invocations and therefore mostly re-derived #940,
which the pooled runner already performs. Against a pooled baseline:

- **In scope, real:** the nested-`sfn build` gap (§3.3) and the nested-`sfn test`
  gap (§3.6). Both are genuine in a pooled run — the former because `sfn build`
  inherits `SAILFIN_TEST_RUNTIME_OBJDIR` but does not read it; the latter because
  `clean_runner_env` strips it.
- **Size, best current evidence:** a nested `sfn build` into a cold scratch with a
  warm CAS costs **3.45s** (§2.4). Across the ~30 build-spawning e2e files that is
  order **~100s**, and only for the subset spawning `sfn build`/`sfn test` — the
  `sfn run` files gain nothing.
- **Therefore the defensible pre-measurement claim is single-digit-percent of a
  pooled e2e run**, not 30–45% and not 51%. If §8.1(i) shows the nested build's
  `[cache]` block has nonzero misses for a reason other than the fixture's own
  `HOME` rewrite, revise upward — but only then.
- **Not reachable by this design:** `array_filter_closure`'s ~70s (§2.3b).

### 9.2 Where I would look next, if a bigger lever is wanted

Named explicitly, because this design is now a small win and the suite cost is
real:

1. ~~**The test-binary CAS hit rate in a cold pooled CI run.**~~ **MEASURED AND
   FALSIFIED — do not spend effort here.** The reasoning below was sound and the
   counters did answer it cheaply, but the answer was negative. Five heavy files,
   pooled at `--jobs 4`, same box, back to back:

   - warm CAS: `test_bin_hits=5 misses=0 hit_rate=1.0000` → **148.76s**
   - cold CAS: `test_bin_hits=0 misses=5 hit_rate=0.0000` → **153.52s**

   **3%.** A full lower+link per test file costs ~1s, not the ~60s a dominant-cost
   hypothesis needs. This holds even though `test_bin_compiler_identity` folds the
   compiler binary SHA *unconditionally* (`build_cache.sfn:1396-1402`, SFN-545), so
   every compiler-touching PR really does run at hit rate 0 — that is by design and
   it is cheap. `test_bin_cache_key` (`:246`) is **not** the lever.

   Original reasoning, retained for the record: the linked test binary is "the
   dominant per-test cost" (`single_process_run.sfn:225-235`), and the runner
   already emits the counters — `test_bin_hits` / `test_bin_misses` are skimmed per
   child (`pool.sfn:358-362`) and aggregated into the run-level `--json` summary
   (`multi_file_run.sfn:370`).

   What the same runs *did* establish: `duration_ms` was 95.4s of 153.5s wall —
   **~19s per file** of test execution, nearly independent of cache state, the
   remainder being the one-time runtime warm. Cross-checked against CI, where e2e-b
   on linux-x86_64 is 1376s over ~80 files ≈ **17s/file**. So the per-file cost is
   the **nested builds inside the tests**, and the working lever is removing
   redundant ones per file (SFN-877: −13.8/−13.1/−18.1% across three targets;
   SFN-879: −32% on one file).
2. **`_run_single_process`'s missing runtime warm** (Alternative E). Does not touch
   CI, but it is the developer inner loop, and §2.5 shows it costs the full runtime
   build per invocation.
3. **`array_filter_closure`'s unexplained ~70s.** Its nested `sfn run` standalone
   is 1.61s cold. The gap between 1.61s and 73s is the `sfn test` leaf path, which
   points back to (1).

### 9.3 Accepted risks

- **Nonce-free objdir sharing partially reverses SFN-17 / PR #2411.** Mitigated by
  §3.2 (no stamp; sidecar remains authority) and by keeping
  `SAILFIN_TEST_SCRATCH` and `SAILFIN_TEST_JSON_SUBFRAME` stripped — the other two
  symptoms. The implementer must re-read `fixtures.sfn:139-158` and confirm all
  three are still individually addressed.
- **`_pool_managed_keys()` deliberately omits the new key** (§3.6), breaking its
  stated mirror contract. Requires an explicit comment naming this SFEP.
- **Non-atomic degrade on hosts without `mktemp`** (§3.5). Pre-existing, unchanged
  in kind, broadened in exposure.
- **Shared objdir growth.** Net disk goes down (dedup), but
  `_cleanup_test_scratch` (`cache_scratch.sfn:145-157`) preserves the tree on
  failure, so a failing pooled run preserves a larger tree.

### 9.4 Risks I would not accept

- Sharing the scratch itself (§3.5) — silent wrong-binary execution.
- Any design where forgetting a declaration produces a **passing** test that has
  stopped asserting what it names. §3.4's inversion and the guard test make that
  unreachable.
- Landing §3.3 and §3.6 as separate PRs with a seed cut between
  (`.claude/rules/seed-dependency.md`).
- **Shipping this on the strength of the 504→246s A/B.** §8.1(ii) must run first.

## 10. Files affected

**Build driver (object-cache role)**
- `compiler/src/build/cache.sfn` — add `_resolve_shared_objdir`, export it
- `compiler/src/build/link.sfn:392-408` — apply it in `_clang_link_multi`
- `compiler/src/cli/commands/build.sfn:553` — gate on `work_dir.length == 0`

**Test runner**
- `compiler/src/cli/commands/test/link.sfn:76-79` — extend the objdir ladder
- `compiler/src/cli/commands/test/pool.sfn:182-197` — stamp + filter the new key

**Test capsule**
- `capsules/sfn/test/src/fixtures.sfn` — `isolated_build_env`; comment at
  `_pool_managed_keys` (`:159`) explaining the deliberate omission

**Tests**
- `compiler/tests/unit/` — `_resolve_shared_objdir` ladder
- `compiler/tests/e2e/cache_assertion_env_hygiene_test.sfn` — new guard
- `compiler/tests/e2e/subframe_aggregation_stream_test.sfn:43,86` — unify labels

**Docs**
- `docs/conventions/e2e-tests.md`

## 11. References

- `#940` — runtime warmed once per invocation (`test/link.sfn:66-78`)
- `#1333` — concurrent `sfn build` clobbering `program.ll` (`build/cache.sfn:174-184`)
- `#1411` — concurrent `sfn run` clobbering `run` (`run.sfn:107-115`)
- `SFN-87` / `#1726` — atomic rename in the shared objdir (`runtime_objs.sfn:344-354`)
- `SFN-148` — dep-closure prewarm (`pool.sfn:7-62`)
- `#1230` / `#1233` — per-test linked-binary cache (`single_process_run.sfn:225-271`)
- `#1996` / SFEP-0044 §3-A — runtime identity stamp + nonce
- `SFN-401` / `#2411` — `clean_runner_env` (`fixtures.sfn:139-213`)
- `SFN-877` — the in-file shared-warm precedent (`build_json_schema_test.sfn:102-132`)
- `SFEP-0040` §3.1 — cache root ladder; `SFEP-0011` — CI test speed
- `.claude/rules/no-bash-e2e.md`, `.claude/rules/seed-dependency.md`
