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

The e2e suite's dominant cost is **runtime and dependency `.o` assembly repeated
once per test file**, because the pooled test runner gives each test file a
private `SAILFIN_TEST_SCRATCH` and several build-spawning code paths route their
object cache under that scratch.

This proposal **rejects the obvious fix** — sharing `SAILFIN_TEST_SCRATCH` across
pool children — as unsound: that directory holds fixed-name, non-content-addressed
artifacts (`program.ll`, `program.o`, `run.ll`, `run`, `test`) whose collision under
`--jobs N` is the exact regression `#1333` and `#1411` were filed for, and the
failure mode is *executing another test's binary*, not a slow suite.

Instead it generalises a seam the codebase already ships and already proved
concurrency-safe: `SAILFIN_TEST_RUNTIME_OBJDIR`
(`compiler/src/cli/commands/test/link.sfn:76-79`). That directory is a
content-addressed, `.key`-sidecar-gated, atomic-rename multi-writer object store
(`compiler/src/build/runtime_objs.sfn:344-357`, `:879-909`) which the pool
already prewarms once per invocation and hands to every child
(`compiler/src/cli/commands/test/multi_file_run.sfn:72-109`). Today only the
`sfn test` leaf link honours it. This proposal extends it to `sfn build` /
`sfn run` links and to nested runners, so the shareable half of the scratch is
shared while the unshareable half stays private.

**Honest sizing up front:** the safe win is **not uniform across the 12 heavy
files and is not established at 51%**. The measured shared-scratch experiment
mixes at least three distinct mechanisms, and for one of the five files measured
(`array_filter_closure`, a `sfn run` consumer) the code says almost nothing
shareable is scratch-resident — matching its measured 4.5% win. §2.4 sets out a
one-command attribution step that must run *before* implementation, and §9.1
states what is and is not claimable.

## 2. Motivation

### 2.1 The measured problem (input, restated)

On a 4-core/15 GiB box with `build/bin/sfn`:

| Case | Time |
|---|---|
| `array_filter_closure_test.sfn`, fresh HOME + `SAILFIN_BUILD_CACHE_DIR` + `SAILFIN_TEST_SCRATCH` | 73.45s |
| same, immediate re-run on the same roots | 1.56s |
| the nested `sfn run` alone, standalone | 1.61s cold / 1.10s warm |
| five heaviest build-spawning e2e files, fresh scratch per file | 504.62s |
| the same five sharing one `SAILFIN_TEST_SCRATCH` | 246.32s |

Per-file, fresh → shared:

| File | Nested command | Fresh | Shared | Win |
|---|---|---|---|---|
| `cli_bare_file_cached_capsule_import` | `sfn build` | 65.7 | 3.5 | 95% |
| `array_interpolation` | `sfn build` | 110.9 | 45.7 | 59% |
| `harness_crash_durability` | `sfn test` | 132.4 | 63.9 | 52% |
| `harness_stream_records` | `sfn test` | 123.2 | 64.1 | 48% |
| `array_filter_closure` | `sfn run` | 72.4 | 69.1 | **4.5%** |

The spread is the signal. It is not one mechanism.

### 2.2 Confirmations of the stated cause

Confirmed by reading:

- The pool does mint a per-file scratch, but **not** via `fs.mkdtemp` per file and
  **not** at `pool.sfn:182-209` (that range is `_pool_child_env`, which only
  *stamps* the value). The mint is
  `compiler/src/cli/commands/test/multi_file_run.sfn:191`
  (`let spawn_scratch = sub_root + "/sub-" + int_to_string(launched);`), with
  twins at `:263` (retry tail) and `:316` (serial path). Each child scratch is a
  **subdirectory of one invocation-wide `sub_root`**, which matters: a shared root
  already exists and is already used for exactly this purpose.
- That value governs `_cr_scratch_root()`
  (`compiler/src/capsule_resolver/paths.sfn:132-138`), `_test_scratch_root()`
  (`compiler/src/cli/commands/test/cache_scratch.sfn:31-35`), and
  `_resolve_sailfin_cache_dir_for_work()` (`compiler/src/build/cache.sfn:185-190`).
- A warm `SAILFIN_BUILD_CACHE_DIR` genuinely does **not** short-circuit the
  per-invocation resolve. `_cr_compile_one`
  (`compiler/src/capsule_resolver/compile.sfn:81-202`) has **no**
  "`.ll` already on disk, skip" branch: every module pays
  `cache_key_for` (a SHA-256 of the source plus each dep `.layout-manifest`) plus
  a `cache_lookup_artifact` + `cache_copy_artifact_to` even on a hit. Cost is
  linear in closure size, per nested build, always.

### 2.3 Corrections — where the code contradicts the stated cause

Three corrections, each of which changes the design:

**(a) The `.ll` module cache is mostly *not* scratch-resident.** `_cr_scratch_root()`
only backs `_cr_legacy_ll_path` (`paths.sfn:146-148`), the *fallback*. The primary
route is `ir_path_for_slug` → `capsule_artifact_ir_dir(scope, name)`, rooted at the
**fixed in-tree** `build/capsules/<scope>/<name>` (`compiler/src/capsule_artifact.sfn:194-196`).
Likewise the `.sfn-asm` / `.layout-manifest` / `.srchash` staging tree is
`_cr_import_context_root("")` = **fixed in-tree** `build/compiler/import-context`
(`compiler/src/capsule_resolver/paths.sfn:72-75`;
`compiler/src/capsule_resolver/staging.sfn:194-196`). Both are already shared
across every pool child today, and already concurrently written. So "a cold
per-module `.ll` resolve on each file's first nested spawn" is only true for the
*legacy-routed* slugs — for a manifest-dep closure the `.ll`s are already warm on
disk; what repeats is the key derivation and the restore-copy, not the emit.

**(b) `sfn run` does not put its runtime objects in the scratch at all.**
`compiler/src/cli/commands/run.sfn:183` calls `_clang_link_multi(..., cache_dir = "")`,
and `_resolve_sailfin_cache_dir("")` returns the **literal `"build/sailfin"`**
(`compiler/src/build/link.sfn:405-408`) — never `SAILFIN_TEST_SCRATCH`. Only
`run.ll` and the `run` executable are scratch-routed (`run.sfn:116-123`, #1411).
This predicts that a `sfn run`-only e2e file gains almost nothing from a shared
scratch — and the measurement agrees (72.4 → 69.1). **`array_filter_closure`'s
73s is therefore not explained by scratch coldness at all**; on the fresh-HOME
run it is cold-CAS re-emit, and its ~70s in the five-file experiment is
unexplained by any mechanism this proposal addresses. Do not count it as
recoverable.

**(c) `sfn build` *does*, and that is where the big wins live.**
`compiler/src/cli/commands/build.sfn:220` resolves `sailfin_cache_dir` via
`_resolve_sailfin_cache_dir_for_work(work_dir)` — `SAILFIN_TEST_SCRATCH` when
`work_dir` is empty — and passes it to `_clang_link_multi` at `:553`. Inside
`_clang_link_multi_with_opt` that argument is used for exactly two things, both
content-addressed object stores:
`assemble_runtime_capsule_link_inputs(..., cache_dir, ...)` (`link.sfn:278`, the
~24 C/LL runtime objects plus ~14 runtime `sfn-source` emits) and
`assemble_link_inputs(ll_paths, cache_dir + "/link-obj", ...)` (`link.sfn:294`,
the dep `.o`s). **Nothing else.** The two nested-`sfn build` files are the 95%
and 59% wins.

**(d) None of the four "cold-dependent" files are actually broken by a shared
outer scratch.** Each mints its own isolation *inside* the test:
- `dep_closure_prewarm_test.sfn:117-124` — `with_tmp_dir` → its own
  `SAILFIN_BUILD_CACHE_DIR`, `SAILFIN_EMIT_LEDGER`, `SAILFIN_TEST_SCRATCH`, in a
  hand-built env (`:53-65`).
- `build_clean_runtime_objects_test.sfn:55, :91` — `fs.mkdtemp` root, own
  `SAILFIN_BUILD_CACHE_DIR`, and `--work-dir work` which outranks
  `SAILFIN_TEST_SCRATCH` at `build/cache.sfn:186`.
- `dep_object_cache_test.sfn:57, :78` — `fs.mkdtemp` under the outer scratch,
  passing that fresh dir as *both* the nested scratch and objdir (`:58`, `:84`).
- `build_json_schema_test.sfn:95-100` — `_fresh_iso()` is two `fs.mkdtemp`s in
  the system temp.

Their coldness is a property of the env they *construct*, not of the env they
*inherit*. This is the load-bearing safety fact for §3.4.

### 2.4 Required attribution step (blocking)

One mechanism remains unexplained: why a cold scratch costs ~62s on
`cli_bare_file_cached_capsule_import` when the runtime-object shared CAS
(`runtime_objs.sfn:340`, `:387`, `:861`) should serve ~38 objects as file copies.
Either the CAS is **missing** (something recompiles) or it is **hitting** and the
copy/key-derivation itself is the 62s. The fix is the same shape either way, but
the expected saving differs by an order of magnitude, so measure first:

```
# One nested build into a guaranteed-cold scratch, warm CAS, cache trace on.
SAILFIN_BUILD_CACHE_DIR=$HOME/.cache/sailfin \
SAILFIN_TEST_SCRATCH=$(mktemp -d) \
SAILFIN_CACHE_TRACE=1 \
  build/bin/sfn build -o /tmp/probe.bin compiler/tests/e2e/fixtures/array_interpolation/main.sfn 2>&1 \
  | grep -E '^\[(cache|stage cache)\]'
```

A `[cache] hits=NN misses=0` line means copy/derivation overhead; any nonzero
`misses` names the real culprit and must be understood before §3 is implemented.
Record the result in the implementing issue.

## 3. Design

### 3.1 The invariant: split the two roles `SAILFIN_TEST_SCRATCH` conflates

| Role | Contents | Sharing |
|---|---|---|
| **Private work root** | `program.ll`, `program.o` (`build.sfn:461`, `:357`), `run.ll`, `run` (`run.sfn:119`, `:123`), `test.ll` + the linked test binary, `test-o0/`, dump-sources output, fixture temp dirs | **Never shared.** Fixed names, non-content-addressed, executed. |
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

It is a **new variable rather than a reuse of `SAILFIN_TEST_RUNTIME_OBJDIR`**
for one reason: `SAILFIN_TEST_RUNTIME_OBJDIR` is paired with
`SAILFIN_TEST_RUNTIME_STAMP`, an invocation nonce
(`multi_file_run.sfn:93-108`, `runtime_objs.sfn:509-519`), and SFN-17 / PR #2411
stripped the pair from nested runners precisely because the *stamp binding* was
one of three symptoms (`capsules/sfn/test/src/fixtures.sfn:139-158`). A
nonce-free variable is shareable by construction: a child reading
`SAILFIN_SHARED_OBJDIR` with no nonce does full key derivation and validates
against the on-disk `.key` sidecar, which `runtime_objs.sfn:500-508` documents
as the freshness authority — a stamp can only cause miss-when-hit-was-possible,
never the reverse, and here there is no stamp at all.

### 3.3 Where it is honoured

Three call sites, all narrow:

1. **`compiler/src/build/link.sfn`** — the whole of `_clang_link_multi_with_opt`'s
   `cache_dir` parameter is the object-cache role (§2.3c). Apply
   `_resolve_shared_objdir(resolved_cache_dir)` **inside `_clang_link_multi`
   (`:392-400`)**, immediately after `_resolve_sailfin_cache_dir`. This single
   edit covers both `sfn build` (`build.sfn:553`) and `sfn run` (`run.sfn:183`),
   and leaves `_ensure_dir(cache_dir)` at `:237` pointing at the shared dir,
   which is correct and already how the objdir is created today.
   - Do **not** touch `build.sfn:461` (`program.ll`), `:357` (`program.o`), or
     `run.sfn:119/:123` (`run.ll`, `run`).
   - Do **not** apply it when `--work-dir` is non-empty: `--work-dir` is an
     explicit hermeticity request (`build/cache.sfn:186`,
     `build_clean_runtime_objects_test.sfn:91`). Gate on `work_dir.length == 0`
     at the `build.sfn` call site rather than inside `link.sfn`, so
     `cli_selfhost.sfn`'s pinned work dirs (`:659`, `:685`) are untouched.
2. **`compiler/src/cli/commands/test/link.sfn:76-79`** — extend the existing
   ladder to consult `SAILFIN_SHARED_OBJDIR` first, then
   `SAILFIN_TEST_RUNTIME_OBJDIR`, then `cache_dir`. Behaviour is unchanged for
   the pool today; this only lets a *nested* runner participate.
3. **`compiler/src/cli/commands/test/multi_file_run.sfn`** — the parent already
   prewarms `sub_root` (`:83-109`). Add `SAILFIN_SHARED_OBJDIR=<sub_root>` to
   `_pool_child_env` (`pool.sfn:196-197`), alongside the existing
   `SAILFIN_TEST_RUNTIME_OBJDIR`, and drop any inherited copy in the same filter
   at `pool.sfn:188-191`.

### 3.4 How a file declares it needs isolation — it already does

**The opt-out is the default, and it requires no new API, marker, or allowlist.**

`SAILFIN_SHARED_OBJDIR` only reaches a nested build if the test *hands it to the
child*. E2E tests fall into two camps:

- **`process.environ()` passthrough** (`array_filter_closure_test.sfn:29`,
  `array_interpolation_test.sfn:22`, ~most of the 309 subprocess-driving files) —
  inherits the shared objdir, gets the speedup.
- **Hand-built child env** — every one of the four cache-state-asserting files
  (§2.3d), because `.claude/rules/no-bash-e2e.md` and SFN-401 already pushed
  exactly that class of test there. They cannot inherit what they never copy.

So the correctness-critical set is immune *structurally*, not by remembering a
marker. The failure mode the brief worries about — "a test silently starts
passing against a warm cache when it meant to assert cold behaviour" — requires a
test that both asserts cache counters and blanket-inherits `process.environ()`.
That combination is already incoherent under the pool (it would also inherit the
parent's `SAILFIN_BUILD_CACHE_DIR`, making the assertion vacuous — the reason
`dep_closure_prewarm_test.sfn:43-52` spells this out at length), and it exists in
zero files today.

Two supporting measures, in order of value:

- **A guard test, not a marker.** Add
  `compiler/tests/e2e/cache_assertion_env_hygiene_test.sfn`: scan
  `compiler/tests/e2e/*.sfn`; for any file whose text contains a cache-counter
  assertion substring (`"misses="`, `"\"hit_rate\""`, `"\"stores\""`,
  `"\"hits\":"`, `link-obj`), assert it does **not** contain
  `process.environ()` outside a `clean_runner_env` call. This makes the invariant
  mechanical and fails loudly at authoring time — the opposite of a silent
  correctness loss. It is a lint over source text, cheap, and needs no runner
  change.
- **A named escape hatch for the rare case.** Add
  `isolated_build_env(label) -> string[]` to `capsules/sfn/test/src/fixtures.sfn`
  beside `clean_runner_env` (`:200-213`): the same strip, plus
  `SAILFIN_SHARED_OBJDIR` and `SAILFIN_BUILD_CACHE_DIR` stripped and re-pointed
  at fresh `fs.mkdtemp` roots. This gives a future cache-state test one call to
  make, rather than the 20-line hand-built `_child_env` each of the four files
  currently repeats. Adopting it in those four files is optional cleanup, not
  part of the correctness argument.

**Rejected: a per-file marker the pool reads.** The pool would have to parse or
pre-scan each file to decide the child env before spawning, adding a read of every
test file to the launch path, and a forgotten marker fails *silently* in the unsafe
direction. Rejected: **a static allowlist in the runner** — it drifts, it lives far
from the test that depends on it, and a forgotten entry again fails silently.

### 3.5 Parallel-safety — the make-or-break question, answered

**Blanket shared `SAILFIN_TEST_SCRATCH` is unsafe. Do not ship it.** Concrete
collisions under `--jobs N`:

- `run.sfn:119/:123` — `<scratch>/run.ll` and `<scratch>/run` are **fixed names**.
  Two concurrent `sfn run` children sharing a scratch overwrite each other's
  executable and then `process.run([exe_path])` at `:212` — one test executes the
  other's binary. The comment at `run.sfn:107-115` documents this as #1411, already
  observed.
- `build.sfn:461` / `:357` — `<scratch>/program.ll` / `program.o`, same shape,
  documented as #1333 at `build/cache.sfn:174-184`: "producing a cross-contaminated
  binary under the parallel `sfn test` pool."
- The test leaf's own `test.ll` / linked binary under `_test_scratch_root()`.

**The object-cache half is already proven safe for concurrent fill**, by design and
by prior incident:

- Runtime `.o` and `.ll`: sibling `_mktemp_sibling_cmd` + `_atomic_rename_into_place`,
  added by **SFN-87 / #1726 for exactly this reason** — the comments at
  `runtime_objs.sfn:344-354` and `:879-886` say verbatim that `out_dir` "is a
  shared, best-effort prewarmed objdir (`SAILFIN_TEST_RUNTIME_OBJDIR`), so a
  prewarm miss can put two pool children in this branch for the same `obj`
  concurrently."
- CAS restores/stores: `_cache_atomic_copy` (`build_cache.sfn:823-834`) is
  temp-then-rename; `cache_store_artifact` (`:929-950`) and
  `_cache_copy_artifact_to_impl` (`:914-922`) both go through it.
- Staging: `_cr_write_srchash_digest` publishes the completeness gate atomically
  (`staging.sfn:111-124`, #1011), and `_cr_stage_cache_probe` re-verifies a
  restored `.sfn-asm` is non-empty before blessing it
  (`stage_cache.sfn:207-222`).
- The stampede `dep_closure_prewarm_test.sfn` guards is a **waste** problem (N
  children emitting the same module), not a **corruption** problem — the ledger
  asserts no duplicate *emit*, and duplicate emits were always correct-but-slow.
  SFN-148's `_prewarm_test_dep_closures` (`pool.sfn:13-62`) is the serialise-then-
  fan-out answer, and it already runs (`multi_file_run.sfn:149`).

There is **one residual** worth stating: two children could in principle derive
*different* cache keys for the *same* legacy-routed `.ll` path
(`<scratch>/capsules/<mangled>.ll`) if their dep-manifest closures differ, and
then one links IR the other restored. This is why §3.1 does **not** share the
`.ll` scratch — only the object dirs, whose filenames already fold content
identity via `.key` sidecars and `_runtime_obj_stem`. Keep it that way.

The degraded no-`mktemp` path (`build_cache.sfn:825-828`, `runtime_objs.sfn:355-358`)
falls back to a non-atomic in-place copy. That host also forces serial emit
(`can_parallel = false` → `effective_jobs = 1`), but that is a *per-process*
serialisation and does not bind sibling pool children. Treat as an accepted risk
on hosts without `mktemp` (§10) — the same risk the objdir already carries today.

### 3.6 What this does *not* fix

The `harness_*` family (48–52% measured) spawns a nested `sfn test` via
`clean_runner_env(nested_runner_scratch(label))`
(`harness_crash_durability_test.sfn:48-49`, `harness_stream_records_test.sfn:45-46`).
`nested_runner_scratch` (`fixtures.sfn:184-188`) returns `<outer_scratch>/<label>`,
so the nested runner's object dir is per-outer-scratch. Once §3.3 lands, the fix
for this family is a **one-line change to `clean_runner_env`**: re-add
`SAILFIN_SHARED_OBJDIR` (which it currently does not strip, since the key is new) —
i.e. deliberately *not* adding it to `_pool_managed_keys()` (`fixtures.sfn:159-161`).
That is the whole change; the nonce-free design in §3.2 is what makes it safe,
and it must be justified explicitly in the diff because `_pool_managed_keys`
carries a "mirror `_pool_child_env`" contract that this intentionally breaks.

Also note `subframe_aggregation_stream_test.sfn:43,86` uses two different labels
for byte-identical fixtures; collapsing them to one label is a free intra-file
win, independent of everything above.

## 4. Effect & capability impact

None. No new effect, no change to `canonical_effects()`. Every touched function is
already `![io]`. `_resolve_shared_objdir` reads the environment via the existing
`env.get` / `_get_env_cmd` builtins used by its neighbours in the same modules.

## 5. Self-hosting impact

No compiler *pass* changes — no lexer, parser, AST, typecheck, effect, emitter or
LLVM-lowering change. This is build-driver orchestration only
(`compiler/src/build/`, `compiler/src/cli/commands/`), plus one capsule
(`capsules/sfn/test/`).

Seed dependency: **none, and nothing must be split.** The change is behavioural in
the compiler binary, consumed by test *sources*, not by `runtime/` source calling a
new builtin — so the runtime-source carve-out in `.claude/rules/seed-dependency.md`
does not apply. `make compile` builds the new compiler from the old seed and that
fresh binary runs the suite in the same pass. Land compiler change + `fixtures.sfn`
change + guard test as **one PR**; splitting them would manufacture a seed-cut gate
for a single consumer.

`cli_selfhost.sfn` pins `SAILFIN_TEST_SCRATCH` per stage (`:307-313`, `:659`) and
sets no `SAILFIN_SHARED_OBJDIR`, so seedcheck/stage3 are byte-for-byte unchanged —
verify this explicitly (§8).

## 6. Alternatives considered

**A. Share `SAILFIN_TEST_SCRATCH` across pool children (pool-level).** Rejected on
correctness (§3.5): re-opens #1333 and #1411, and the failure is a wrong binary
executed, not a slow test. It also changes behaviour for *every* unit and
integration test, not just e2e, for a benefit that §2.3 shows is concentrated in
one e2e sub-family.

**B. Make `nested_runner_scratch` default to a suite-shared root (test-level).**
Rejected as the primary lever: it moves the same unsafe artifacts
(`run.ll`, `program.ll`, the nested runner's `test` binary) into a shared
directory, just one level down, and it only reaches the `harness_*` family — the
two biggest wins (`sfn build` consumers) never call it. It is however the right
*shape* for §3.6, once the sharing is narrowed to the objdir.

**C. Add a "needs cold cache" marker or runner allowlist.** Rejected in §3.4: both
fail silently when forgotten, which is the exact asymmetry the brief calls out. The
guard test in §3.4 achieves the same coverage failing loudly.

**D. Give `_cr_compile_one` a "`.ll` newer than source, skip lookup" fast path.**
Rejected: it would trade a content-addressed guarantee for an mtime heuristic in
the one place (`compile.sfn:98-126`) where staleness is currently impossible. If
§2.4 shows key-derivation dominates, the right answer is memoising the derivation
within one invocation, not weakening the freshness check.

**E. Do nothing; raise `--jobs`.** Rejected: `_test_jobs_budget`
(`compiler/src/cli/commands/test/arg_and_jobs.sfn`) is already RAM-bound at
3 GiB/job per `.claude/rules/compiler-safety.md`; more jobs multiply the repeated
work rather than removing it.

## 7. Stage1 readiness mapping

- [ ] Parses — n/a, no syntax change
- [ ] Type-checks / effect-checks — n/a
- [ ] Emits valid `.sfn-asm` — n/a
- [ ] Lowers to LLVM IR — n/a
- [x] Regression coverage — §8
- [ ] Self-hosts — `make compile`, then `make check`
- [ ] `sfn fmt --check` clean
- [ ] Documented — `docs/conventions/e2e-tests.md` gains the
      `SAILFIN_SHARED_OBJDIR` / `isolated_build_env` section; `docs/status.md`
      needs no change

## 8. Test plan

### 8.1 Attribution (before implementing)

The `SAILFIN_CACHE_TRACE=1` command in §2.4. Blocking.

### 8.2 Speedup

Baseline and post, same box, same warm `SAILFIN_BUILD_CACHE_DIR`, three runs each,
report the median:

```
# Per-file, the five measured heavy files.
for f in cli_bare_file_cached_capsule_import array_interpolation \
         harness_crash_durability harness_stream_records array_filter_closure; do
  /usr/bin/time -f "$f %e" build/bin/sfn test compiler/tests/e2e/${f}_test.sfn
done

# Whole suite, pooled, the number that actually matters.
/usr/bin/time -f "e2e %e" build/bin/sfn test compiler/tests/e2e --jobs 4
```

Acceptance: no per-file regression anywhere; the two `sfn build` consumers improve
materially. **Do not gate acceptance on a suite-wide percentage** until §2.4 is
answered — see §9.1.

### 8.3 Correctness — mutation-test the four cold-dependent files

For each, break the invariant and confirm the test **fails**; then restore and
confirm it passes. This is the step that proves they would still catch a regression:

| File | Mutation | Must fail on |
|---|---|---|
| `dep_closure_prewarm_test.sfn` | comment out `_prewarm_test_dep_closures(...)` at `multi_file_run.sfn:149` | outcome `1` (duplicate digest) |
| `build_clean_runtime_objects_test.sfn` | make `clean_runtime_object_cache(...)` at `build.sfn:551` a no-op | step C asserting `misses=0` absent |
| `dep_object_cache_test.sfn` | in `test/link.sfn:79`, point `link_obj_dir` at a per-invocation temp | test 1's `ls link-obj` finding no `.o` |
| `build_json_schema_test.sfn` | make `_fresh_iso()` return `_shared_shape_iso()` | tests 3, 4, 8 |

Run each as `build/bin/sfn test compiler/tests/e2e/<file>.sfn -k "<name>"`.

Additionally, run all four **twice in the same pooled invocation** with the shared
objdir active, to prove inherited warmth cannot reach them:

```
build/bin/sfn test \
  compiler/tests/e2e/dep_closure_prewarm_test.sfn \
  compiler/tests/e2e/build_clean_runtime_objects_test.sfn \
  compiler/tests/e2e/dep_object_cache_test.sfn \
  compiler/tests/e2e/build_json_schema_test.sfn \
  --jobs 4
```

### 8.4 Parallel-safety

- Run the full e2e suite at `--jobs 4` **five consecutive times**; any flake is a
  blocker, not a retry. Concurrency bugs of this class are pool-only and
  low-probability per run.
- `compiler/tests/e2e/nested_runner_no_collision_test.sfn` must stay green.
- New unit test in `compiler/tests/unit/` for `_resolve_shared_objdir`'s ladder
  (explicit → legacy objdir → fallback; empty string behaves as unset, matching
  `_cr_scratch_root`'s documented contract at `paths.sfn:128-131`).

### 8.5 Guard

`compiler/tests/e2e/cache_assertion_env_hygiene_test.sfn` (§3.4) — verify it fails
when a cache-counter assertion is added to a file using bare `process.environ()`.

### 8.6 Self-host

`make clean-build` (new module-level exports), then `make check`. Confirm the
seedcheck pass timing is unchanged — `cli_selfhost.sfn` sets no
`SAILFIN_SHARED_OBJDIR`, so any timing shift there means the ladder leaked.

## 9. Risks

### 9.1 The one I would not accept as stated

**Claiming "51% off the e2e suite" from this change.** The 504→246 measurement
shares *everything*, including the unsafe artifacts. This proposal shares a strict
subset. §2.3b shows the `sfn run` family — one of the five measured files, and by
the input's own ranking a large share of the remaining 145 files at 3.5s each —
has essentially nothing shareable in the scratch. Until §2.4 attributes the 62s on
`cli_bare_file_cached_capsule_import`, the defensible claim is:

- **Confidently reachable:** the nested-`sfn build` family (§2.3c). Two of the top
  five, 65.7s + 110.9s fresh.
- **Reachable with the §3.6 follow-up:** the nested-`sfn test` family, 132.4s +
  123.2s fresh.
- **Not reachable by this design:** `array_filter_closure`'s ~70s. Its cost is not
  scratch-resident and needs its own investigation.

If the top-12 concentration (68% of 1578s) is mostly the first two families, the
suite-level win plausibly lands **in the 30–45% band**, not 51%. State it that way
until measured.

### 9.2 Accepted risks

- **Nonce-free objdir sharing partially reverses SFN-17 / PR #2411.** Mitigated by
  §3.2 (no stamp, sidecar remains authority) and by keeping `SAILFIN_TEST_SCRATCH`
  and `SAILFIN_TEST_JSON_SUBFRAME` stripped — those were the other two symptoms.
  The implementer must re-read `fixtures.sfn:139-158` and confirm all three
  symptoms in that incident are still individually addressed.
- **`_pool_managed_keys()` deliberately omits the new key**, breaking its stated
  mirror contract with `_pool_child_env`. Requires an explicit comment at
  `fixtures.sfn:159` naming the SFEP, or a future contributor will "fix" it and
  silently revert the speedup.
- **Non-atomic degrade on hosts without `mktemp`** (§3.5). Pre-existing, unchanged
  in kind, broadened in exposure. Accept and note.
- **Shared objdir growth.** One invocation-scoped dir now accumulates every nested
  build's runtime and dep objects instead of N per-file dirs. Net disk goes *down*
  (dedup), but `_cleanup_test_scratch` (`cache_scratch.sfn:145-157`) preserves the
  tree on failure — a failing pooled run now preserves a larger tree. Acceptable.

### 9.3 Risks I would not accept

- Sharing the scratch itself (§3.5) — silent wrong-binary execution.
- Any design where forgetting a declaration produces a **passing** test that has
  stopped asserting what it names. §3.4's inversion (inheritance is opt-in) and
  the guard test exist to make that unreachable.
- Landing §3.3 and §3.6 as separate PRs with a seed cut between. They are one
  capability and its consumers; bundle them
  (`.claude/rules/seed-dependency.md`).

## 10. Files affected

**Build driver (object-cache role)**
- `compiler/src/build/cache.sfn` — add `_resolve_shared_objdir`, export it
- `compiler/src/build/link.sfn:392-408` — apply it in `_clang_link_multi`
- `compiler/src/cli/commands/build.sfn:553` — gate on `work_dir.length == 0`

**Test runner**
- `compiler/src/cli/commands/test/link.sfn:76-79` — extend the objdir ladder
- `compiler/src/cli/commands/test/pool.sfn:182-197` — stamp + filter the new key
- `compiler/src/cli/commands/test/multi_file_run.sfn` — no change if the value is
  `sub_root`; confirm the prewarm at `:83-109` still targets it

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

- `#1333` — concurrent `sfn build` clobbering `program.ll` (`build/cache.sfn:174-184`)
- `#1411` — concurrent `sfn run` clobbering `run` (`run.sfn:107-115`)
- `SFN-87` / `#1726` — atomic rename in the shared objdir (`runtime_objs.sfn:344-354`)
- `SFN-148` — dep-closure prewarm (`pool.sfn:7-62`)
- `#940` — runtime warmed once per invocation (`test/link.sfn:66-78`)
- `#1996` / SFEP-0044 §3-A — runtime identity stamp + nonce
- `SFN-401` / `#2411` — `clean_runner_env` (`fixtures.sfn:139-213`)
- `SFN-877` — the in-file shared-warm precedent (`build_json_schema_test.sfn:102-132`)
- `SFEP-0040` §3.1 — cache root ladder; `SFEP-0011` — CI test speed
- `.claude/rules/no-bash-e2e.md`, `.claude/rules/seed-dependency.md`
