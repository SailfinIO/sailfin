---
sfep: TBD
title: Cross-invocation runtime-object persistence for the `sfn test` link path
status: Draft
type: tooling
created: 2026-08-22
updated: 2026-08-22
author: "agent:compiler-architect; human review"
tracking: SFN-1086
supersedes:
superseded-by:
graduates-to:
---

# SFEP-XXXX — Cross-invocation runtime-object persistence for the `sfn test` link path

## 1. Summary

`sfn test` pays a ~40 s (Linux) / ~47 s (Windows) runtime-object build on every
invocation whose scratch is cold, and that cost **never amortizes across
invocations**. The pool already amortizes it *within* one invocation
(`multi_file_run.sfn:105` warms once, children hit via
`SAILFIN_TEST_RUNTIME_OBJDIR`), and `sfn build` / `sfn run` already amortize it
*across* invocations through the shared content-addressed cache (#1096). The
test path is the only link path excluded, because
`compiler/src/cli/commands/test/link.sfn:142` passes the literal `""` as
`shared_cache_root`.

This proposal removes that exclusion: resolve a real `shared_cache_root` on the
test path and thread it to the two `assemble_runtime_capsule_link_inputs` call
sites the test command owns (`link.sfn:142`, `multi_file_run.sfn:105`), gated
`""` under `--no-test-cache` exactly as `sfn build` gates it `""` under
`--no-cache` (`build.sfn:590-592`). Measured proxy A/B on a novel, never-built
test file with a fresh scratch each run: 40.36 s → 38.80 s today (no
amortization) versus 40.24 s → **1.59 s** with persistence — **25x** on the
second and every subsequent invocation.

No new machinery is introduced. The store, the key derivation, the multi-writer
atomic-rename discipline, and the artifact kinds (`runtime-obj`, `sfn-asm`) all
ship today and are already exercised by the build path.

## 2. Motivation

### 2.1 Measurements (Linux x86_64, `build/bin/sfn` 0.10.4, `jobs=2`)

| Scenario | Wall |
|---|---|
| 1 trivial test file, fresh scratch | 40.33 s |
| same file again, same scratch | 0.03 s |
| different file, same scratch | 1.26 s |
| **fresh scratch again** | **39.78 s** |
| 5 files, one pooled invocation, fresh scratch | 45.8 s |
| N=15 / N=30 / N=60 (30 newly built) | 51.0 / 59.8 / 212.6 s |

The scaling is strictly linear in file count, so the 40 s is not per-file — it
is a **per-fresh-scratch constant**. Per fresh scratch the run materializes 40
runtime `.o` + 41 `.ll`, 36 `link-obj/*.o`, and 180 `rt-import-context` staging
files. A three-line trivial test costs the same as a real one.

Windows: cold 47.4 s; the single-file *warm* floor is 3.15 s against Linux's
0.42 s, so Windows carries a second, separate constant (per-object file copy)
that this proposal reduces the frequency of but does not remove.

### 2.2 The cause is one literal

```
compiler/src/cli/commands/test/link.sfn:139-142
    // Test link path keeps runtime objects work-dir-local (shared root
    // empty); the shared content-addressed runtime cache (#1096) is
    // scoped to the build/run path that feeds the build-quality gate.
    let rt = assemble_runtime_capsule_link_inputs(runtime_caps, rt_cache_dir, "-O0", binary_dir, "");
```

The same function on the build path receives a real root
(`build/link.sfn:292`, fed from `build.sfn:590-592` / `run.sfn:297-299`).

### 2.3 The exclusion was scope, not correctness — verified

`a3234818` ("fix(cache): back runtime objects with the shared content cache
(#1096) (#1101)") states in its body: *"The shared layer is threaded as
`shared_cache_root` and gated on `cache_config.enabled` (empty under
`--no-cache`), and the `sfn test` link path stays work-dir-local."*

That sentence is a **statement of scope**. The commit's entire stated motivation
is restoring the build-quality determinism gate's `cache.hit_rate >= 0.95` on
the `det-pass1` → `det-pass2` sibling-work-dir pair — a build-path gate. No
correctness argument for excluding the test path appears in the commit body, in
`link.sfn`'s comment (which only re-states the scope), or anywhere in
`runtime_objs.sfn`.

I looked specifically for a correctness reason and did not find one. The two
candidates I checked and ruled out:

1. **"Test and build compute different runtime source sets, so sharing is
   unsound."** Addressed in §3.4 — for the demand-set difference specifically,
   the key folds what distinguishes them, so a differing set produces a
   *different key*, i.e. a miss. Note §3.4's broader "no false hit is
   reachable" claim is withdrawn for an unrelated reason (SFN-1087); it does
   not reinstate this objection, which concerns the demand set only.
2. **"Enabling it would defeat `make check`'s cold suite."** Real, and the
   reason this proposal ships the `--no-test-cache` gate (§3.5). It is an
   argument for a lever, not for a permanent exclusion.

**Verdict: the fix is sound.** The remainder of §3 states the correctness
argument explicitly.

### 2.4 Where the win lands

- **Local inner loop.** Every `sfn test <file>` after the first, on any scratch,
  on any branch that has not changed the compiler binary or the runtime sources.
- **The e2e suite.** Nested `sfn test` / `sfn build` children inherit
  `SAILFIN_BUILD_CACHE_DIR` through `clean_runner_env`
  (`capsules/sfn/test/src/fixtures.sfn:236-251` strips only
  `_pool_managed_keys` and `_caller_override_keys`; the cache dir is not in
  either list), so ~309 subprocess-driving e2e files participate automatically.
- **CI**, once §3.7 wires the cache path.

## 3. Design

### 3.1 Shape of the change

Three edits plus one helper. Nothing in `compiler/src/build/runtime_objs.sfn`
changes: it already accepts, threads, and honours `shared_cache_root` on every
layer the test path uses.

The probe ladder in `_prepare_runtime_sfn_object` is **additive** — this
proposal only makes the third rung reachable from the test path:

```
runtime_objs.sfn:888  stamp fast path      (_runtime_stamp_cache_hit)
runtime_objs.sfn:903  work-dir sidecar     (_runtime_obj_cache_hit)
runtime_objs.sfn:910  shared CAS  <— today unreachable from `sfn test`
runtime_objs.sfn:920+ emit + clang
```

Nothing is removed. Every existing hit path keeps priority, which is why no
currently-fast path becomes slower (§5.3).

### 3.2 New helper — `runtime_obj_cache_root()`

`compiler/src/build_cache.sfn`, immediately after `test_bin_cache_root`
(`:1489-1504`), mirroring its shape exactly:

```
// Pure variant.
fn runtime_obj_cache_root_with_override(override_path: string) -> string {
    // `<base>/<build_cache_schema_version()>`, base = override or "build/cache"
    return cache_root_from(override_path, false, "", "");
}

// Production reader.
fn runtime_obj_cache_root() -> string ![io] {
    return runtime_obj_cache_root_with_override(_get_env_cmd("SAILFIN_BUILD_CACHE_DIR"));
}
```

**Why this ladder and not `cache_root(capsule_name)`.** The test command never
resolves a root capsule name; `discovery.sfn:205` reads per-suite manifest names
only. Threading one to `link.sfn` would be a real refactor for no correctness
gain. The chosen ladder produces the **identical string** to
`cache_root("sfn/compiler")` in both cases that matter:

| Condition | `cache_root("sfn/compiler")` | `runtime_obj_cache_root()` |
|---|---|---|
| `SAILFIN_BUILD_CACHE_DIR=X` | `X/v2` | `X/v2` |
| unset, in-tree | `build/cache/v2` | `build/cache/v2` |

So in this repo — and in CI — `sfn build -p compiler` and `sfn test` share one
store by construction. The precedent is `test_bin_cache_root`, which has used
exactly this ladder since #1230.

**Accepted divergence.** For a *non-compiler* capsule with `HOME` set,
`sfn build` resolves `~/.cache/sailfin/v2` while `sfn test` resolves
`build/cache/v2`. The two then do not share. This costs a warm-start
opportunity; it can never produce a wrong artifact (different roots, same key
derivation). Unifying the two ladders is a separate question that belongs with
`sfn cache`, which itself reads `cache_root("")` (`cli/commands/cache.sfn:111`)
and therefore already disagrees with the self-host pin. Out of scope; noted so
the next reader does not mistake it for an oversight.

### 3.3 The three seams

**(a) `compiler/src/cli/commands/test/link.sfn:49`** — add a trailing parameter:

```
fn _clang_link_test_cmd_with_deps(ll_path, out_path, runtime_root, dep_ll_paths,
                                  cache_dir, binary_dir, runtime_demand,
                                  shared_cache_root: string) -> TestLinkResult ![io]
```

and at **`:142`** replace the literal `""` with `shared_cache_root`. Replace the
`:139-141` comment with one that records the gate (§3.5) rather than the
retired exclusion. `_ensure_dir_cmd(rt_cache_dir)` at `:138` is unchanged.

A parameter, not an env read: this function already reads
`SAILFIN_TEST_RUNTIME_OBJDIR` at `:78` and adding a second ambient input to a
link function makes the decision untestable from the call site. There is exactly
one production caller.

**(b) `compiler/src/cli/commands/test/single_process_run.sfn`** — the sole
caller. `no_test_cache: boolean` is already parameter 7 at `:70`. Resolve the
root once, beside the existing `test_cache_enabled` block at `:186-206`:

```
let mut rt_shared_cache_root: string = "";
if !no_test_cache { rt_shared_cache_root = runtime_obj_cache_root(); }
```

and pass it at **`:321`**. Resolving once (not per file) matches the existing
treatment of `tb_cache_root`, `tb_compiler_identity`, and `tb_target_triple` —
all invocation-stable, all hoisted for the same reason.

**(c) `compiler/src/cli/commands/test/multi_file_run.sfn:105`** — the parent
warm. `no_test_cache` is already parameter 8 at `:42`. Same two lines, same
gate, then pass the resolved root as the fifth argument.

The pool needs no new plumbing: `_pool_child_argv`
(`pool.sfn:143-149`) already forwards `--no-test-cache` to every child, so
parent and children compute the same root independently and cannot disagree.

### 3.4 Correctness argument — why sharing is safe

**Claim, as narrowed by review.** For every input the key *does* fold, two
producers (a `sfn build` and a `sfn test`, a narrowed and an unnarrowed demand
set, an `-O0` and an `-O2` link) either produce **identical bytes and share a
key**, or produce different bytes and land on **different keys** — a miss.

**The stronger claim this section originally made — "a false hit is
unreachable" — is withdrawn.** Adversarial review of PR #3077 found a second,
unkeyed source of truth: `_load_llvm_import_context`
(`compiler/src/main.sfn:947`) ignores the `.import-deps` sidecar the key folds
and re-resolves imports against the **on-disk contents of `ctx_root`**,
including `.slugalias` indirection, a depth-3 transitive walk, and
`module_aliases` that reach symbol mangling. The object is therefore a function
of a directory's contents while the key is a function of a sidecar list; they
coincide only when `ctx_root` holds exactly `staged_slugs`, and nothing prunes
`ctx_root`.

That gap is **pre-existing on the build/run path** and is tracked as SFN-1087.
This proposal does not create it, but it does widen exposure by adding a second
producer into the same store, so it is recorded here rather than left to the
issue alone. No reproducer is known; it is an unsound invariant, not an observed
miscompile.

**The `.o` key**, composed at `runtime_objs.sfn:900` and re-composed identically
by the stamp writer at `:578`:

```
runtime_object_cache_key_with_identity(src, opt_flag, compiler_identity)   // build_cache.sfn:1114-1141, :1173-1178
    = sha256(src bytes) "\n" opt_flag "\nsecsplit1-strabi1" "\n" compiler_identity
  |> _runtime_obj_key_with_sibling_deps(ctx_root, slug)                    // :636  — "\n" sha256(each staged .sfn-asm listed in <slug>.import-deps)
  |> _runtime_obj_key_with_slug(slug)                                      // :689  — "\nobj1:" slug
  |> _runtime_obj_key_with_target(target_triple)                           // :754  — "\ntgt2:" triple
```

Match that against the emit's actual inputs — the child argv at `:922`
(`emit --module-name <slug> --import-context <ctx_root> -o … llvm <src>`) plus
the subsequent `llvm_assemble_argv(ll, obj, opt_flag, [])`:

| Emit/compile input | Folded by |
|---|---|
| source bytes | `sha256(src)` |
| module slug (`.module <slug>` is literally in the emitted text) | `obj1:` |
| sibling signatures threaded via `--import-context` | per-dep `sha256` of each staged `.sfn-asm` |
| the compiler binary doing the emit | `compiler_identity` |
| clang opt level | `opt_flag` |
| section/ABI flag scheme | `secsplit1-strabi1` |
| target | `tgt2:` |

That table is the whole argument. The two specific risks raised against it:

**Risk 3 — the demand-set difference. Confirmed sound.** `sfn test` forces
`runtime_demand_all()` (`discovery.sfn:433-451`, SFN-882) while `sfn build`
narrows via `select_runtime_sfn_sources` (`runtime_selection.sfn:149-171`).
Narrowing is gate-table-driven per source, **not import-closed** — so a build's
staged set can be a strict subset of a test's. Two cases, both safe:

- A module whose `.import-deps` list is *identical* under both (the common case:
  its imports survived narrowing) hashes the identical dep `.sfn-asm` bytes and
  gets the identical key. Its emitted bytes are identical too, because
  `_write_runtime_sfn_import_deps` (`:1339`) derives the list from the module's
  **own** `.import` entries and only *filters* against `staged_slugs` — a wider
  staged set adds nothing to a narrower module's sidecar. **A genuine shared
  hit.**
- A module that lost a dep under narrowing gets a **shorter** dep list, hence a
  shorter key string, hence a different digest. Its emitted `.ll` genuinely
  differs (less import context). **A miss, correctly.**

The same reasoning covers the SFN-800 re-export closure (`:1287`), which also
only ever contracts under a narrower staged set.

**Risk 4 — the opt flag. Confirmed folded.** `runtime_object_cache_key`
(`build_cache.sfn:1141`) returns `content + "\n" + opt_flag +
"\nsecsplit1-strabi1"`. Test's `-O0` and build's `-O2` objects can never collide.
The `.o` filename stem also carries the flag (`_runtime_obj_stem`, `:145`), so
the work-dir tier separates them too.

**A genuine cross-tool share does exist, and it is desirable.**
`runtime_asm_cache_key` (`:776`) calls
`runtime_object_cache_key_with_identity(src, "", compiler_identity)` — the opt
flag is deliberately empty, because a staged `.sfn-asm` is emitted by
`emit --no-resolve-gate … native` (`:1187`) with no opt level and no import
context. Its inputs are exactly source bytes + slug + compiler, all folded. So
`sfn build` and `sfn test` **legitimately share all 180 staging artifacts**.
That is a large part of the measured win and it is already unit-covered
(`compiler/tests/unit/runtime_stage_shared_cache_test.sfn:209, :246, :275`
pin slug separation, identity separation, and kind separation respectively).

**The residual, stated rather than papered over.** `cache_compiler_identity`
(`build_cache.sfn:1414-1422`) folds the binary SHA-256 **only when the version
ends in `.dirty`**. On a clean tree at a commit, `build/native/.build-stamp`
reads `0.10.4+dev.<hash>` and the identity is that bare string — so two
*different* binaries built from the same commit (pass-1 `build/bin/sfn` and
`build/bin/sfn-seedcheck`) share one identity. This is pre-existing and already
applies to the `.ll` module cache (`capsule_resolver/compile.sfn:318` uses the
same helper) and to the runtime objects on the build path. It is not created by
this change, but it *is* the reason §3.5's lever is mandatory rather than
optional.

### 3.5 `--no-test-cache` and `make check`'s cold-suite policy

**Rule: `--no-test-cache` resolves `shared_cache_root` to `""`.**

This is the direct analogue of the build path, where `--no-cache` sets
`build_shared_cache_root = ""` (`build.sfn:590-592`, `run.sfn:297-299`) and
`--clean` additionally clears it for one invocation (`build.sfn:606-608`). The
empty root disables **both** the read and the write inside
`_runtime_obj_shared_cache_fetch` / `_publish`
(`runtime_objs.sfn:216-217`, `:233-235`), so nothing leaks in either direction.

**What this preserves, concretely.**

`make check` (`Makefile:741`) runs the seedcheck full suite as
`make test NATIVE_BIN=build/bin/sfn-seedcheck TEST_BIN_CACHE_FLAGS=--no-test-cache`.
With the gate, that run resolves an empty root and rebuilds every runtime object
with the seedcheck binary — **byte-for-byte the behaviour it has today**. The
same holds for `make check`'s optional `CHECK_FULL_PASS1=1` leg
(`Makefile:683`) and for `sfn dev verify`, which hard-codes `--no-test-cache`
(`dev_verify.sfn:568-575`).

The stage2/stage3 fixed point is untouched: `sfn selfhost` spawns each stage as
`build --no-cache -p compiler` (`cli_selfhost.sfn:319`), which already zeroes
the shared root.

`make test`'s default `TEST_BIN_CACHE_FLAGS ?=` (`Makefile:161`) is empty, so
the local inner loop and CI's cache-enabled shard legs get the speedup.

**Why couple to `--no-test-cache` rather than mint a new flag.** The flag's
help text is "Bypass the per-test linked-binary cache"; the widening makes it
"this invocation neither reads nor writes any cross-invocation test artifact
cache." That is a *stronger* and more defensible contract than today's, it is
the meaning every caller already relies on (`Makefile:157-160`:
"the merge/seedcheck gate always cold-builds every test binary — the cache can
never mask a test-compile regression"), and it means zero call sites change. A
second flag would be a second thing to remember to pass, and the one place it
matters (`make check`) already passes this one. Update the flag description at
`test/mod.sfn:218` to match.

**Honest scoping of what "cold" already means.** `--no-test-cache` has never
made a `make check` suite fully cold: the `.ll` module cache
(`capsule_resolver/compile.sfn:318`) is not gated by it and, on a clean tree,
already shares entries between the pass-1 and seedcheck binaries via the
identity residual in §3.4. This proposal does not widen that hole and does not
close it. Closing it is a separate decision — the natural fix is making
`cache_compiler_identity` fold the binary hash unconditionally, which would
change cache behaviour for every consumer and must not ride along here.

### 3.6 The import-context staging phase

Two questions, answered.

**(a) Does routing the test path's shared root make staging persist? Yes,
automatically.** `_stage_runtime_sfn_import_context` (`:1408`) already takes
`shared_cache_root` and forwards it to `_stage_one_runtime_sfn_import_context`
(`:1116`) for both the sibling loop (`:1428`) and the dep-closure loop
(`:1490`), and to `_stage_imported_platform_externs` (`:1547`). That function
fetches at `:1161` and publishes at `:1220`, kind `"sfn-asm"`. It is reached
from `_compile_runtime_sfn_sources:1672`, which receives the root from
`assemble_runtime_capsule_link_inputs:1873`. So changing the one literal at
`link.sfn:142` persists the 180 staging artifacts as well as the 40 objects.
This is the larger half of the win — staging is 68 serial child emits.

**(b) Is parallelizing it separately shippable? Yes — and it should NOT be in
scope.** Three reasons:

1. **It is a no-op inside pool children.** `_cr_resolve_jobs`
   (`capsule_emit_parallel.sfn:44-58`) reads `SAILFIN_BUILD_JOBS` first, and
   `_pool_child_env` pins every pooled child to `SAILFIN_BUILD_JOBS=1`
   (`pool.sfn:246-248`, SFN-547) so the two fan-outs cannot nest and multiply
   the RAM budget. A parallel staging loop would therefore only help the *parent*
   warm and the *single-file* leaf path — the same two places this proposal
   already reduces to a CAS copy.
2. **Its value is measured after, not before.** With persistence in place the
   cold staging path runs once per compiler identity per host, not once per
   fresh scratch. Sizing the parallelization against today's cold-every-time
   baseline would overstate it by roughly the post-fix miss rate.
3. **It is genuinely delicate.** Staging is a three-phase pipeline with an
   in-place-growing worklist: sibling + dep-closure staging, then
   `_stage_imported_platform_externs` (`:1547`) which *reads* the staged
   `.sfn-asm` of pass 1 and pushes onto `staged_slugs`/`staged_asm_paths` while
   iterating, then the `.import-deps` writing pass (`:1508-1513`) which must see
   the complete set. Fanning out phase 1 is tractable; the wave structure is
   what makes it a design of its own.

File it as a follow-up, sized from a post-fix measurement.

### 3.7 CI wiring

Without this, the fix is local-only: CI's test-shard legs restore
`build/cache/test-bin` (`ci.yml:1005`, `:1288`, `:1790`) and nothing else. The
module-IR / runtime-obj restore in the shared action is explicitly gated off for
exactly these jobs — `.github/actions/sailfin-build/action.yml:218` reads
`if: ${{ inputs.mode != 'skip-build' }}`, and the shard legs pass
`mode: skip-build`.

Two changes, mirroring keys that already exist:

1. **Produce.** `build-quality.yml`'s `test-bin-baseline` job already restores
   `build/cache` (`:471-478`) and runs the full suite with the cache enabled
   (`:538-549`). After this proposal that run also populates the `-O0`
   `runtime-obj` and `sfn-asm` entries. Add a `Save build cache` step beside the
   existing `Save test-bin cache for PR CI` (`:560-565`), under the same
   `sailfin-buildcache-linux-x86_64-<seed>-<fp>-<freshness>` key the
   `build-quality` job already saves at `:275-279`.
2. **Consume.** In the three shard legs, add an `actions/cache/restore` for
   `build/cache` **before** the existing test-bin restore, with the
   `sailfin-buildcache-` key + `restore-keys` prefix copied verbatim from
   `action.yml:222-226`.

Three properties make this safe and they are the same three the existing steps
rely on:

- **Restore-only in the shards.** Saving there would occupy a key slot a
  complete baseline run needs — the SFN-797 failure mode, spelled out at
  `build-quality.yml:566-583`.
- **Ordering.** The test-bin restore must run *after* the `build/cache` restore
  so its populated subtree overlays the (empty) `test-bin` the wider archive
  carries. `action.yml:236-238` already documents this ordering requirement.
- **Key discipline.** The `sailfin-buildcache-` key carries the seed version and
  the layout fingerprint; the looser target-only fallback stays omitted
  (`action.yml:212-216`). Do not merge this into the `sailfin-testbin-` prefix —
  `action.yml:227-231` records why a shared prefix lets a test-bin-only entry
  shadow the module-IR cache.

**Size.** Measured in-tree: 1.7 MB of runtime `.o` and 2.5 MB of
`rt-import-context` per target/opt combination. Against a `build/cache/v2` that
is already 358 MB, the added slice is noise; no eviction policy change is
needed. `sfn cache prune --max-size` remains the release valve.

## 4. Effect & capability impact

None. Every touched function is already `![io]` build-driver orchestration. No
effect signature changes; no new capability surface; no change to
`canonical_effects()` or to the manifest derivation. `runtime_obj_cache_root()`
is `![io]` for the same reason `test_bin_cache_root()` is — one `_get_env_cmd`.

## 5. Self-hosting impact

### 5.1 Passes

No compiler *pass* changes. The change is confined to the build driver
(`compiler/src/cli/commands/test/`) and one helper in
`compiler/src/build_cache.sfn`. Lexer, parser, AST, typecheck, effect checker,
`emit_native.sfn`, and LLVM lowering are untouched.

### 5.2 Seed dependency — **bundle, no seed cut**

Per `.claude/rules/seed-dependency.md`: this is a compiler-source-only change
with **no runtime-source consumer**. Nothing under `runtime/` calls a new
builtin or intrinsic, so the runtime carve-out does not apply. `make compile`
builds the new compiler from the old pinned seed, and that fresh binary carries
the new `sfn test` behaviour immediately. **One issue, one PR, no
`seed-blocker`, no `/pin-seed`.**

The regression tests in §8 drive `sfn_bin_path()`, which resolves to the
freshly-built binary via `SAILFIN_BIN` — so they observe the new behaviour in
the same PR that introduces it.

### 5.3 No existing fast path regresses

The shared fetch is the **third** rung of the probe ladder (§3.1), behind the
invocation stamp and the work-dir sidecar. Concretely: `test_bin_cache_test.sfn`
mints a fresh `SAILFIN_BUILD_CACHE_DIR` per leg but inherits one
`SAILFIN_TEST_SCRATCH` across all four, so legs 2–4 hit the work-dir sidecar
today and keep hitting it after the change. No file gets slower.

### 5.4 Concurrency

No new exposure. The parent warms `sub_root` before forking
(`multi_file_run.sfn:104-121`), so children find a populated objdir and the CAS
fetch is not on the concurrent path in the normal case. Where it *is* reachable
concurrently (a failed parent warm — already possible today),
`_cache_atomic_copy` (`build_cache.sfn:853-860`) publishes through a sibling
temp + rename, and `_runtime_obj_cache_record` writes the `.key` sidecar only
after the artifact is in place.

## 6. Alternatives considered

**Do nothing; accept the 40 s.** Rejected: it is paid by every cold-scratch
invocation, which is every CI shard, every e2e nested runner without an
inherited warm objdir, and every developer switching branches. The cost is
already the dominant term for a trivial test.

**A new `SAILFIN_TEST_SHARED_CACHE` env var instead of reusing
`SAILFIN_BUILD_CACHE_DIR`.** Rejected — boring wins. A second root to configure,
a second thing for CI to cache, and a second way for the two tools to disagree
about where objects live. The existing variable already scopes every other cache
layer in the tree.

**Gate on a new `--no-runtime-cache` flag rather than widening
`--no-test-cache`.** Rejected: §3.5. The one place the gate is load-bearing
(`make check`) already passes `--no-test-cache`, and a second flag that must be
remembered fails in the unsafe direction.

**Thread a `CacheConfig` through the test command so it resolves
`cache_root(capsule_name)` exactly like `sfn build`.** Rejected for this
proposal: the test command has no root-capsule notion (`discovery.sfn:205` is
per-suite), and §3.2 shows the simpler ladder is string-identical in both cases
that matter. Revisit only if the `sfn cache` / self-host-pin ladder is unified.

**Fold this into
`docs/proposals/draft-nested-build-object-cache-sharing.md`.** Rejected —
see §9.

**Ship staging parallelization together.** Rejected: §3.6(b).

## 7. Stage1 readiness mapping

This is a build-driver change, not a language feature; the frontend rows are
N/A by construction and are marked so rather than left ambiguous.

- [x] Parses — N/A (no syntax change)
- [x] Type-checks / effect-checks — N/A (no new effect surface); the change must
      pass `sfn check` on the touched modules
- [x] Emits valid `.sfn-asm` — N/A
- [x] Lowers to LLVM IR — N/A
- [ ] Regression coverage — §8
- [ ] Self-hosts — `make compile`, then `make check` once before merge
- [ ] `sfn fmt --check` clean
- [ ] Documented in `docs/status.md` (build/test performance row) — no spec
      chapter applies

## 8. Test plan

All tests are `*_test.sfn` using `sfn/test`. No bash
(`.claude/rules/no-bash-e2e.md`). Every nested invocation hand-builds its child
env and threads its own `SAILFIN_BUILD_CACHE_DIR` and `SAILFIN_TEST_SCRATCH`,
per SFN-401 and the pool-isolation trap.

### 8.1 New — `compiler/tests/e2e/test_runtime_obj_shared_cache_test.sfn`

Model on `compiler/tests/e2e/runtime_obj_shared_cache_test.sfn`, which is the
build-path twin of every leg below (`_build_env`, `_has_file_named`, the
`[cache]`-summary assertions via `sfn/strings::find`).

1. **Cold `sfn test` populates the shared cache.** Fresh `SAILFIN_BUILD_CACHE_DIR`
   + fresh `SAILFIN_TEST_SCRATCH`; run a one-test fixture file. Assert the cache
   root then contains at least one `runtime.o` and at least one `ir.sfn-asm`
   (`_filename_for_kind`, `build_cache.sfn:733-741`). **This is the leg that
   fails on `main`** — today the test path writes neither.
2. **A second invocation with a FRESH scratch and the SAME cache root skips the
   rebuild.** The core contract. Assert via the `[cache]` summary that
   `misses=0` (or hits ≥ 1 and no runtime miss) on run 2, and additionally that
   run 2's wall time is a small fraction of run 1's is *not* asserted — timing
   assertions are flaky under the pool. Assert counters only.
3. **`--no-test-cache` neither reads nor writes.** Fresh cache root, run with
   `--no-test-cache`, assert the cache root contains **no** `runtime.o`. Then
   pre-populate the root via a plain run, wipe the scratch, re-run with
   `--no-test-cache`, and assert the run still misses (the `[cache]` summary
   shows runtime misses > 0). **This is the cold-suite policy test** — the one
   that must fail if a future change removes the gate.
4. **A runtime source content change busts the entry.** Copy `runtime/` to a
   temp root (the shape `runtime_identity_stamp_test.sfn:234` already uses),
   warm, edit one module, re-run with a fresh scratch, assert a miss. Guards
   the §3.4 key argument end to end.
5. **A cross-opt-level probe.** Run `sfn build` on a one-line program and
   `sfn test` on a one-test fixture against **one** shared cache root, then
   assert both a `-O0`- and a `-O2`-stemmed runtime object exist in the
   respective work dirs and that neither run reports an anomalous hit. Pins
   Risk 4 at the integration level; the unit-level pin already exists
   (§8.3).

### 8.2 New — `compiler/tests/unit/runtime_obj_cache_root_test.sfn`

`![pure]` where possible, against `runtime_obj_cache_root_with_override`:

- override empty → `"build/cache/" + build_cache_schema_version()`
- override set → `"<override>/" + build_cache_schema_version()`
- the two agree with `cache_root_from(explicit, true, xdg, home)` for the
  self-host capsule under both conditions — the §3.2 table, pinned so a future
  edit to either ladder that breaks the build↔test share fails a test rather
  than silently halving the win.

### 8.3 Existing tests — verdict per file

**Must keep asserting cold behaviour; must NOT be updated:**

| File | Why it stays as-is |
|---|---|
| `compiler/tests/e2e/runtime_obj_shared_cache_test.sfn` | Build path only; unaffected. Its three legs remain the build-path contract. |
| `compiler/tests/e2e/test_bin_cache_test.sfn` | Asserts `test_bin_*` counters only. Its `--no-test-cache` leg (`:146`) asserts both counters zero — still true, and now additionally backed by §8.1 leg 3. |
| `compiler/tests/unit/runtime_stage_shared_cache_test.sfn` | Eight legs pinning slug / identity / kind / empty-root / torn-restore separation for the `sfn-asm` layer. These become *more* load-bearing (the test path now exercises that layer) — do not touch. |
| `compiler/tests/unit/runtime_obj_target_identity_test.sfn` | 24 `![pure]` legs on the key folds, including the opt-flag and slug adjacency. Unchanged. |
| `compiler/tests/unit/runtime_obj_slug_wiring_test.sfn` | Cross-slug false-hit guard. Unchanged. |
| `compiler/tests/e2e/dep_closure_prewarm_test.sfn` | `.ll` module-cache stampede, separate layer, own `SAILFIN_BUILD_CACHE_DIR` (`:47-60`). Unchanged. |
| `compiler/tests/e2e/build_clean_runtime_objects_test.sfn` | `sfn build --clean`, build path. Unchanged. |
| `compiler/tests/e2e/cache_command_test.sfn` | Operates on a seeded synthetic root. Unchanged. |

**Needs review, likely unchanged:**

| File | Check |
|---|---|
| `compiler/tests/e2e/dep_object_cache_test.sfn` | Uses `--no-test-cache` (`:57`) *to force the cold link path* so `link-obj/` is created. Under the gate that run also skips the runtime CAS — which is what it already gets today from its fresh `mkdtemp` objdir. Leg B (unwritable `link-obj`, `:71`) is the work-dir-local object cache, a different directory from the CAS. **Expect no change**; confirm `link-obj/*.o` still appears. |
| `compiler/tests/e2e/runtime_identity_stamp_test.sfn` | Leg 4 (`:234`) copies `runtime/` out of tree and asserts a content change is observed. Post-change the *unmodified* copy may CAS-hit entries the in-repo runtime published (same content, same slug, same identity → same key — correct by §3.4). The assertion is about observing the change, not about a cold build, so it should still pass. **Verify explicitly**; if it turns out to assert cold staging implicitly, thread a private `SAILFIN_BUILD_CACHE_DIR` rather than weakening the leg. |
| `compiler/tests/e2e/runtime_sfn_sources_link_consumer_test.sfn` | Asserts the canonical `%Timespec*` staged form (SFN-344). Now potentially served from the CAS. Content-identical by key, so the assertion holds; confirm on a warm run. |

### 8.4 Commands

```
sfn fmt --write compiler/src/build_cache.sfn compiler/src/cli/commands/test/*.sfn
sfn fmt --check compiler/src/build_cache.sfn compiler/src/cli/commands/test/*.sfn
sfn check compiler/src/build_cache.sfn compiler/src/cli/commands/test/link.sfn \
          compiler/src/cli/commands/test/single_process_run.sfn \
          compiler/src/cli/commands/test/multi_file_run.sfn
make compile
build/bin/sfn test compiler/tests/e2e/test_runtime_obj_shared_cache_test.sfn
build/bin/sfn test compiler/tests/unit/runtime_obj_cache_root_test.sfn
build/bin/sfn test compiler/tests/unit/runtime_stage_shared_cache_test.sfn
build/bin/sfn test compiler/tests/e2e/runtime_obj_shared_cache_test.sfn
build/bin/sfn test compiler/tests/e2e/test_bin_cache_test.sfn
build/bin/sfn test compiler/tests/e2e/dep_object_cache_test.sfn
build/bin/sfn test compiler/tests/e2e/runtime_identity_stamp_test.sfn
make check                      # once, before merge — the cold-suite policy gate
```

Speedup verification (record in the PR body, both on one host):

```
# baseline and after, same command, novel test file, fresh scratch each run
SAILFIN_TEST_SCRATCH=$(mktemp -d) SAILFIN_BUILD_CACHE_DIR=/tmp/sfn-cas-probe \
  build/bin/sfn test <novel_test.sfn>     # run 1: cold
SAILFIN_TEST_SCRATCH=$(mktemp -d) SAILFIN_BUILD_CACHE_DIR=/tmp/sfn-cas-probe \
  build/bin/sfn test <novel_test.sfn>     # run 2: expect ~1-2 s, not ~40 s
```

## 9. Relationship to existing design work

**This is a new SFEP, not an amendment.** Three documents touch adjacent ground;
none owns this.

- **SFEP-0044 (`0044-test-runner-invocation-cache.md`, Implemented).** Owns
  *within-invocation* amortization: the parent-warm stamp (work item A) and
  in-process SHA-256 (B). Its whole framing is "keys that are
  **invocation-constant**" (§1). It removes the per-*child* re-derivation cost;
  it does not and cannot remove the per-*invocation* build cost. Its work item C
  (resolver-pass sharing) is also within-invocation. **Non-overlapping.** This
  proposal composes with it cleanly — the stamp remains the first probe rung
  (§3.1) and is unmodified.
- **`draft-nested-build-object-cache-sharing.md` (Draft).** Owns
  *within-invocation* sharing of the **objdir** (`SAILFIN_SHARED_OBJDIR`, a
  work-dir-shaped store) so nested builds inside e2e tests can participate. Its
  §3.3 item 2 says of the `sfn test` leaf link: *"No behaviour change for the
  pool today; this lets a nested runner participate."* That is a different
  seam (`link.sfn:77-79`, the objdir ladder) and a different axis. **Not
  superseded — but materially resized.** With cross-invocation persistence
  landed, a nested build's runtime objects arrive from the CAS regardless of
  whether it inherits an objdir, so the draft's already-modest claimable win
  (its own §2.5/§9.1 revise it down) shrinks further. **Recommendation:** land
  this proposal first, then amend that draft's §2.5 sizing and §9.1 range
  against a fresh post-fix measurement before accepting it. Do not merge the two
  documents: one is a store-lifetime change, the other a store-location change,
  and conflating them would make either hard to revert.
- **SFEP-0040 (`0040-artifact-cache.md`).** Owns the cache root ladder and the
  self-host pin this proposal reuses. No change required; §3.2's accepted
  divergence is noted against it.

## 10. Scope split

**Minimum shippable — one issue, one PR (M).**

1. `runtime_obj_cache_root()` + pure variant (`build_cache.sfn`, after `:1504`).
2. The three seams (§3.3) and the `--no-test-cache` gate (§3.5).
3. Flag help text at `test/mod.sfn:218`.
4. `compiler/tests/e2e/test_runtime_obj_shared_cache_test.sfn` (§8.1) and
   `compiler/tests/unit/runtime_obj_cache_root_test.sfn` (§8.2).
5. `docs/status.md` note.

Do not split (1) from (2): the helper has exactly one consumer and splitting
would manufacture a review cycle for no benefit (`.claude/rules/seed-dependency.md`,
"Don't manufacture splits"). There is no seed gate either way (§5.2).

**Bundle-or-split judgement call — the CI wiring (§3.7), 3 YAML blocks.**
Recommend **bundling** into the same PR. It is small, its keys are copied
verbatim from adjacent steps, and shipping the compiler change without it means
the fix demonstrably does nothing on the machine where the 40 s is paid most
often. Splitting costs no seed cut, so if a reviewer prefers YAML isolated, that
is a defensible S follow-up — but it must land in the same cycle or the win is
invisible in CI timings and the change will look like a regression-risk with no
payoff.

**Follow-ups — separate issues, sized after measurement.**

| Item | Size | Note |
|---|---|---|
| Parallelize `_stage_runtime_sfn_import_context` (`:1408`) | M | §3.6(b). No-op in pool children; three-phase worklist; measure post-fix first. |
| Windows warm floor (3.15 s vs Linux 0.42 s) | ? | Separate constant — per-object file copy on the fetch path. Investigate `cache_copy_artifact_to` on Windows. Not addressed here. |
| Unconditional binary-hash fold in `cache_compiler_identity` (`:1414`) | M | §3.4 residual. Affects every cache consumer; must not ride along. |
| Unify the `cache_root` ladders (`sfn cache` vs self-host pin vs test) | S | §3.2 accepted divergence. |

## 11. Risks

**R1 — a future change silently drops the `--no-test-cache` gate and quietly
weakens `make check`.** Mitigated by §8.1 leg 3, which asserts the gate
directly (no `runtime.o` written under `--no-test-cache`, and a miss on a
pre-warmed root). This is the single most important new test.

**R2 — a cache-asserting e2e test goes vacuous.** §8.3 enumerates every
candidate. All eight "must not change" files either scope their own
`SAILFIN_BUILD_CACHE_DIR` or assert a different layer. Adopting the guard test
proposed in `draft-nested-build-object-cache-sharing.md` §3.4
(`cache_assertion_env_hygiene_test.sfn`) would make this mechanical rather than
review-dependent; recommended, not required, and it belongs to that draft.

**R3 — repo-cache pollution from nested runners.** After this change, an e2e
test that spawns a nested `sfn test` without scoping `SAILFIN_BUILD_CACHE_DIR`
will write runtime-obj entries into the repo's `build/cache/v2`. This is already
true of every nested `sfn build` for the `.ll` layer, the entries are
content-addressed (never wrong, only extra), and the measured slice is
~4.2 MB per identity against a 358 MB tree. Accepted.

**R4 — the `.dirty` identity residual (§3.4).** Two same-version binaries share
runtime-object entries on a clean tree. Pre-existing on the build path and the
`.ll` layer; not widened here; fully neutralized for `make check` by the §3.5
gate. Tracked as a follow-up, not a blocker.

**R5 — the demand-set difference produces a lower hit rate than expected**
(build's narrowed staging yielding shorter dep lists than test's). Not a
correctness risk (§3.4), but it could mean the build↔test `sfn-asm` share is
smaller in practice than the "all 180" upper bound. The §8.1 leg-2 counter
assertion measures the real number; report it in the PR body rather than
projecting it.

## 12. References

- `a3234818` — "fix(cache): back runtime objects with the shared content cache
  (#1096) (#1101)" — the commit whose scope statement this proposal reverses.
- SFEP-0044 `0044-test-runner-invocation-cache.md` — within-invocation
  amortization (the stamp).
- SFEP-0040 `0040-artifact-cache.md` — the cache root ladder and self-host pin.
- SFEP-0011 `0011-ci-test-speed.md` — Lever 2, the per-test binary cache.
- `draft-nested-build-object-cache-sharing.md` — adjacent; resized by this (§9).
- SFN-142 (cold-suite policy), SFN-547 (`SAILFIN_BUILD_JOBS=1` pin), SFN-797
  (cache key occupancy), SFN-861 / SFN-870 (the `sfn-asm` and `.o` slug folds),
  SFN-882 (demand-driven runtime selection), SFN-545 (test-bin compiler
  identity).
- `.claude/rules/seed-dependency.md` — the bundle-vs-split decision applied in
  §5.2.
