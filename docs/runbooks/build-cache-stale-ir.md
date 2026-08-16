# Build cache & stale IR on dev rebuilds runbook

The content-addressed build cache (`compiler/src/build_cache.sfn`,
`$SAILFIN_BUILD_CACHE_DIR` / `~/.cache/sailfin`) keys each module's emitted
`.ll` on its source hash, its dependency manifests, and the **compiler's
identity**. A recurring worry — and a real cycle-sink during the SFN-154 work
(PR #2071) — is that editing the emitter / LLVM lowering and rebuilding will
silently reuse cached IR for a capsule whose *own* source didn't change (e.g.
`sfn/cli`), so the compiler change never reaches those modules.

This page records **why that is already handled on the normal build path**, the
one narrow case where it isn't, and the escape hatch when you suspect a stale
hit.

## Read this first: the axis that matters is local vs. shared

§1–§3 were written when the emitted `.ll` was the only cached class. It is not.
Staged `.sfn-asm` / `.layout-manifest` artifacts became cached too (SFN-861),
and they are covered in §4.

The distinction that actually decides whether you have cleared anything is
**not** module-vs-staging — those two *shared* caches hang off the same
`cache_root` and are wiped together. It is **local vs. shared**:

| Tier | Holds | Keyed on | Cleared by |
|---|---|---|---|
| **Shared** (`cache_root`) | `.ll`, `.o`, `runtime.o`, and staged `.sfn-asm` / `layout.manifest` | source + **compiler identity** + target | `--clean`, `SAILFIN_BUILD_CACHE_DIR` |
| **Local** (`build/compiler/import-context/`) | staged `.sfn-asm`, `.layout-manifest` | **source hash alone** — no compiler identity, no target | `--clean` only |

That second row is the whole reason this section exists. Every shared entry
folds the emitting compiler's identity, so §2's guarantee — a rebuilt compiler
busts downstream artifacts — holds there. **The local staging tier folds no
compiler identity at all**, so an artifact emitted by a *different* compiler is
served straight back (`capsule_resolver/mod.sfn:364-370`). That is a live
staleness path of exactly the family §1–§3 exist to discuss, and §2's "no manual
cache clear is needed" does not extend to it.

**The two things most likely to mislead you**, both in §4.3:

- `--no-cache` does **not** give you a cold `.sfn-asm`. `--clean` does.
- Under `--no-cache`, the `[stage cache]` trace line disappears entirely — so it
  cannot be used to confirm that build was cold.

---

## 1. Committed and released builds are always correct

The compiler identity mixed into the key is the build stamp
(`compiler/src/build_stamp.sfn`), which resolves to one of:

| Build | Stamp | Cache behaviour |
|---|---|---|
| Tag at HEAD | `<version>` | Distinct per release → never collides across compilers. |
| Clean commit | `<version>+dev.<hash>` | The commit hash changes on every commit → any committed codegen change busts downstream IR. |
| Dirty tree | `<version>+dev.<hash>.dirty` | See §2 — the emitting binary's content hash is folded in. |
| No git available | `<version>+dev` | No hash and no `.dirty` suffix, so the §2 binary-hash fold does **not** apply. Stable per checkout at a given capsule version — coherent for any single binary, but two different builds at the same `<version>` share the key. Only reachable outside a git checkout (release tarball, vendored source); a normal dev tree always lands in one of the rows above. |

So a **released, CI, or committed** build can never serve stale IR from an
emitter change: the version component already differs. SFN-181 scopes this out
explicitly ("changing cache behavior for released/committed builds — already
correct there").

## 2. Dirty dev rebuilds bust downstream IR automatically

The trap's premise — "an uncommitted compiler change doesn't bump the version,
so the cache serves stale IR" — is **outdated**. A dirty working tree produces a
`.dirty` stamp (`build_stamp.sfn`, via a `git diff --quiet HEAD --` probe), and
`build_cache.sfn::cache_compiler_identity` folds the **emitting compiler
binary's SHA-256** into the cache identity for `.dirty` stamps. The wiring lives
at the `.ll` module-cache call site in `compiler/src/capsule_resolver/compile.sfn`
(`cache_compiler_identity(resolve_compiler_version_for_cache(""), sailfin_exe)`),
so every fresh `make compile` — which rebuilds the binary — changes that hash and
misses the cache for all downstream capsule modules.

Verified end-to-end (warm the cache, edit an LLVM lowering pass, `make compile`,
rebuild the same unchanged capsule against the same cache):

```
# build 1 (cold):              hits=0 misses=8 stores=8
# build 2 (warm, no change):   hits=8 misses=0 stores=0   ← cache works
# build 3 (warm, compiler
#          rebuilt dirty):     hits=0 misses=8 stores=8   ← .dirty busts it
```

The dirty rebuild re-emitted all eight `sfn/cli` modules. **No manual cache
clear is needed for the normal `sfn build -p` / `make compile` loop.**

That guarantee is about the **`.ll` module cache**, and it extends to every
cache tier that folds compiler identity — which is all of them except one. The
local staging tier does not, so a dirty rebuild leaves its `.sfn-asm` /
`.layout-manifest` untouched. See §4.2.

## 3. The one narrow caveat: the in-process fallback

`cache_compiler_identity` reverts to the raw stamp (no binary-hash fold) when
the emitting-binary path is empty — the **in-process serial fallback**
(`sailfin_exe == ""`). Two callers reach it:

- **`sfn check`** — frontend-only (parse + typecheck + effect-check); it emits no
  `.ll` and touches no module-IR cache entry, so the trap cannot apply *to the
  module cache*. It does still **stage**, with an explicitly disabled cache
  config (`capsule_resolver/check.sfn:77-83`) — populating
  `build/compiler/import-context/` and its `.srchash` sidecars, which a later
  `sfn build` will locally hit. Combined with §4.2, a `sfn check` run is one
  concrete way to seed the local tier with artifacts from a different compiler.
- **`sfn test` on a small import closure** — `_cr_effective_isolation_exe`
  (`capsule_resolver/mod.sfn:256`) keeps the in-process path (returns `""`) when the
  closure is below the isolation threshold, and only switches to the
  subprocess-per-module binary for large closures (an OOM guard). On that
  in-process leg the module `.ll` cache *is* enabled
  (`empty_build_cache_config()`), and `cache_compiler_identity("…​.dirty", "")`
  falls back to the raw stamp — so **a same-commit dirty rebuild will not bust a
  small fixture's cached module IR**. This is the one live residual of the trap.
  It is narrow (only same-commit `.dirty` iterations, only sub-threshold
  closures) and does not touch committed/released correctness.

Note the separation of layers here: the per-test **binary** cache is a distinct
layer keyed on the *commit-stable* `resolve_test_bin_identity_for_cache`, and
`--no-test-cache` disables **only** that binary layer
(`cli/commands/test/single_process_run.sfn`). It does **not** force cold
recompilation of cached `.ll` **modules** — so it is not a workaround for
the module-IR staleness above. For that, see §5.

Closing this residual in code would mean folding a self-binary (or
compiler-source) hash into the identity when `effective_exe == ""` in
`compile_capsule_modules`. It is left as a follow-up rather than bundled into
this doc-only change; the §5 escape hatch covers it operationally in the
meantime.

The same empty-`sailfin_exe` condition independently disables the **entire
shared staging cache** (`_cr_resolve_stage_cache_ctx`,
`stage_cache.sfn:91`) — that code cites this section as where the underlying
identity gap is documented. The effect there is the opposite of a staleness
risk: an in-process leg simply never consults or populates the shared staging
layer. Its *local* `.srchash` layer still runs (§4.3).

## 4. The second cached class: staged `.sfn-asm` / `.layout-manifest`

Before a capsule's modules are compiled, each source is **staged** — emitted to
a `.sfn-asm` (native IR) plus a `.layout-manifest` (struct layouts) that later
modules read as import context. SFN-861 gated that emit on a cache key, because
it was re-running ~34 redundant child compilers per build. Staging is therefore
a second cached class, with its own two-tier structure.

### 4.1 Where entries live

**Local (per work dir).** `_cr_import_context_root` (`capsule_resolver/paths.sfn`):

```
build/compiler/import-context/            # default, no --work-dir
<work_dir>/compiler/import-context/       # sfn build --work-dir <root>
```

holding, per module slug: `<slug>.sfn-asm`, `<slug>.layout-manifest`, and the
`<slug>.srchash` sidecar that gates them. (`.slugalias` and `.import-deps`
sidecars also live here; they are staging bookkeeping, not cached artifacts.)

**Shared (cross-work-dir).** The same content-addressed root as the module
cache — `cache_root(capsule_name)`, resolved by `cache_root_from`
(`build_cache.sfn:687-694`) in this order:

| # | Source | Root |
|---|---|---|
| 1 | `$SAILFIN_BUILD_CACHE_DIR` | `<dir>/v2` |
| 2 | self-host (`capsule_name == "sfn/compiler"`) | `build/cache/v2` |
| 3 | `$XDG_CACHE_HOME` | `<dir>/sailfin/v2` |
| 4 | `$HOME` | `<home>/.cache/sailfin/v2` |
| 5 | fallback | `build/cache/v2` |

Entries are `<root>/<digest[0..2]>/<digest>/ir.sfn-asm` and
`.../layout.manifest` (`cache_artifact_path` / `_filename_for_kind`). Because
both layers hang off the *same* `cache_root`, **setting
`SAILFIN_BUILD_CACHE_DIR` cold-starts the staging layer as well as the module
layer** — that is the one lever that reliably cold-starts both shared caches at
once.

### 4.2 How the key is derived

`stage_cache_key_from_digest` (`build_cache.sfn:1364-1373`) folds:

```
<source SHA-256> \n <compiler identity> \n <slug> \n stage1: <target triple>
```

The **slug is folded in**, and `stage1:` domain-separates this key space from
the module cache's `tgt2:` — so the two can never collide on the same
source/slug/version/triple tuple. Compiler identity is the same
`cache_compiler_identity` used by the `.ll` layer (§2), so a dirty rebuild busts
*shared* staged artifacts exactly as it busts module IR. Unlike `cache_key_for`,
no dependency-manifest hashes are folded in — `.sfn-asm` emit consults no
cross-module import context, so it is a pure function of that tuple
(`build_cache.sfn:1328-1336`).

> **This key governs the shared tier only.** The local tier is not keyed by it.
> `_cr_stage_cache_hit` (`staging.sfn:82-91`) gates purely on
> `recorded == sha256_of_file(src)` — **no compiler identity, no target
> triple**. A dirty `make compile` therefore does **not** invalidate locally
> staged `.sfn-asm` / `.layout-manifest`; an unchanged source is served the
> artifact the *previous* compiler emitted. The compiler source states this
> outright at `capsule_resolver/mod.sfn:364-370` — "an artifact emitted by a
> DIFFERENT compiler is served straight back — exactly the staleness `--clean`
> exists to break." This is the staging layer's analogue of §3's residual, and
> it is why `--clean` (not `--no-cache`) is the lever in §5.

### 4.3 Local hit vs. shared hit — and why it matters

The two are counted separately in the trace because they fail differently.

**Local hit** (`_cr_stage_cache_hit`, `staging.sfn:82-91`) — three existence
probes, a sidecar read, and one hash; no copy. It is a hit when the `.sfn-asm`
*and* `.layout-manifest` *and* `.srchash` all exist and the recorded digest
equals a fresh `sha256_of_file(src)`. Content-addressed, never mtime-based:
`git checkout` resets mtimes, so timestamps lie (#514). As §4.2 notes, this gate
folds no compiler identity.

**Shared hit** (`_cr_stage_cache_probe`, `stage_cache.sfn:190-230`) — tried
*only* after the local probe misses. It looks both artifacts up in the shared
root, copies them out into the work dir, and verifies the restored `.sfn-asm` is
non-empty before trusting it. On success the local `.srchash` is written too
(`staging.sfn:225` serial, `:530` parallel), so a shared hit is promoted to a
local hit for the next probe in the same work dir.

> **`--no-cache` does not disable the local layer; `--clean` is what clears it.**
> `--no-cache` (via `config.enabled`, `stage_cache.sfn:90`) and
> `SAILFIN_NO_CACHE=1` (`stage_cache.sfn:97`) disable the *shared* staging cache
> and the module cache. Neither is consulted by the local probe: no
> `ctx.enabled` or env check guards `_cr_stage_cache_hit` at either call site
> (`staging.sfn:203` serial, `:513` parallel). So a `--no-cache` build with an
> unchanged source still serves the previously staged `.sfn-asm` out of
> `build/compiler/import-context/` — including one emitted by a different
> compiler (§4.2). `--clean` is the lever: it wipes that tree *before* staging
> runs (`capsule_resolver/mod.sfn:401-407`, SFN-872).

### 4.4 Reading the trace

The two summaries are **independent counters printed from different modules,
under different gating** — zeros on one say nothing about the other:

```
[cache] hits=… misses=… stores=… invalid_keys=… copy_failures=…        # build/cache.sfn
[stage cache] local_hits=… hits=… misses=… stores=… restore_failed=…   # stage_cache.sfn
```

**They are not gated alike, and this trips people up:**

| Line | On `sfn build` | On `sfn run` | Suppressed when |
|---|---|---|---|
| `[cache]` | **always** (no flag needed) | only under trace | all counters zero |
| `[stage cache]` | only under trace | only under trace | trace off — see below |

`SAILFIN_CACHE_TRACE=1` / `--cache-trace` is what turns on `[stage cache]` and
the per-module `[cache hit]` / `[cache miss]` lines. The `[cache]` *summary* is
unconditional on `sfn build` (`cli/commands/build.sfn:509`, `:603`) and
trace-gated only on `sfn run` (`cli/commands/run.sfn:217`).

> **The `[stage cache]` line vanishes exactly when you most want it.** Every
> print is wrapped in `if ctx.trace` (`staging.sfn:455`, `:480`, `:594`), and
> `ctx.trace` is false on *any* disabled context — `--no-cache`,
> `SAILFIN_NO_CACHE=1`, an empty `sailfin_exe`, an empty identity or root
> (`stage_cache.sfn:51-59`, `:90-104`). So a `--no-cache` build prints no
> `[stage cache]` summary at all, and its absence is **not** evidence that
> staging did nothing — the local tier still ran (§4.3).

Reading the counters: `local_hits` counts `.srchash` hits, `hits` counts
shared-root restores — so `local_hits=34 hits=0 misses=0` means the shared cache
was never consulted, not that it was empty. `restore_failed` is *not* a miss: it
counts entries found in the shared root whose copy-out failed or verified empty,
then fell through to a fresh emit — a damaged or racing cache root, not a key
problem. An invalid digest returns early (`stage_cache.sfn:203`) incrementing
**nothing**, so `misses=0` does not by itself prove the shared cache was
consulted.

Per-module lines under the same flag: `[stage cache hit] <slug>`,
`[stage cache miss] <slug>`, `[stage cache restore-failed] <slug>`,
`[stage cache store] <slug>`.

## 5. Escape hatch

If you ever suspect a stale hit (an unusual cache-dir state, a manually staged
binary, or the in-process caveat above), force a cold compile without nuking the
whole cache.

**Module cache (`.ll` / `.o`):**

```bash
sfn build -p <capsule> --no-cache     # bypass lookup + store for this build
sfn build -p <capsule> --clean        # wipe the schema-versioned cache subtree first
SAILFIN_BUILD_CACHE_DIR=$(mktemp -d) sfn build -p <capsule>   # fresh, isolated cache
```

`sfn test` does not yet accept `--no-cache` / `--clean`, so for the small-closure
test residual in §3 the lever is a fresh cache root:

```bash
SAILFIN_BUILD_CACHE_DIR=$(mktemp -d) sfn test <dir-or-_test.sfn>   # cold module cache
```

**Staging cache (`.sfn-asm` / `.layout-manifest`):** `--clean` is the lever for
both tiers, but note **`--no-cache` is not** — it leaves the local tree fully
live (§4.3). One ordering wrinkle is worth knowing, because it decides what a
single `--clean` run actually achieves:

| Tier | Wiped where | Relative to staging | Effect on *this* build |
|---|---|---|---|
| Local | `capsule_resolver/mod.sfn:401-407` | **before** | cold — staging re-emits |
| Shared | `capsule_resolver/compile.sfn:266-281` | **after** | not cold; staging already probed and stored, and the wipe then removes what it just published |

So `--clean` cold-starts the *local* staging tier immediately, but the *shared*
staging tier only from the **next** invocation. To cold-start the shared tier
for the run in front of you, redirect the root instead:

```bash
SAILFIN_BUILD_CACHE_DIR=$(mktemp -d) sfn build -p <capsule> --clean   # both tiers cold, this run
```

To clear the local tree by hand (no build, or to inspect what was there):

```bash
rm -rf build/compiler/import-context          # local staged artifacts + .srchash sidecars
rm -rf <work_dir>/compiler/import-context     # when built with --work-dir
```

`make clean-build` also removes it — it wipes `build/*` except the fetched seed
toolchain store (`KEEP_SEED`) — which additionally takes out the self-host shared
root at `build/cache/v2`, but **not** a shared root under `~/.cache/sailfin/v2`,
where non-self-host capsules land.

**Confirming it worked.** `SAILFIN_CACHE_TRACE=1` (or `--cache-trace`) prints
per-module `[cache hit]` / `[cache miss]` lines and the `[stage cache]` summary;
the `[cache]` summary prints on `sfn build` regardless. Read both — but read
them per §4.4, which explains why a *missing* `[stage cache]` line proves
nothing about whether staging ran.

---

## References

- `compiler/src/build_cache.sfn` — cache key derivation (`cache_key_for`,
  `stage_cache_key_from_digest`), `cache_compiler_identity`, `cache_root_from`.
- `compiler/src/build_stamp.sfn` — the four-case stamp truth table (incl. `.dirty`).
- `compiler/src/capsule_resolver/compile.sfn` — the `.ll` module-cache call site
  and the shared-root `--clean` wipe.
- `compiler/src/capsule_resolver/mod.sfn` — `_cr_effective_isolation_exe`, and
  the local import-context `--clean` wipe (SFN-872) with the rationale for why
  the `.srchash` gate needs it.
- `compiler/src/capsule_resolver/stage_cache.sfn` — shared staging cache: context
  resolution, probe/restore, store, `[stage cache]` summary.
- `compiler/src/capsule_resolver/staging.sfn` — local `.srchash` gate and the
  serial/parallel staging loops.
- `compiler/src/build/cache.sfn` — the `[cache]` summary line.
- SFEP-0040 (`docs/proposals/0040-artifact-cache.md`) — shared-cache root ladder and GC.
- SFN-181 — this trap; SFN-154 / PR #2071 — the cycle-sink that motivated it.
- SFN-861 — added the staging cache; SFN-871 — this section (§4).

> Runtime `.sfn` sources take a **parallel but separate** staging path
> (`compiler/src/build/runtime_objs.sfn`): its own key (`runtime_asm_cache_key`,
> `asm1:` separator), its own local sidecar convention (`<artifact>.key`, not
> `.srchash`), and a private *local* root at `<out_dir>/rt-import-context` that
> none of §5's levers clear. Its **shared** tier, though, publishes `sfn-asm`
> artifacts into the same `cache_root` as §4.1 (`runtime_objs.sfn:1164`),
> separated only by the `asm1:` / `stage1:` key domains — so
> `SAILFIN_BUILD_CACHE_DIR` and `--clean`'s shared wipe do reach it. Its local
> tier is deliberately left alone by `--clean` (`capsule_resolver/mod.sfn:390-394`)
> because its `.key` sidecar *does* fold compiler identity, so it has no
> equivalent stale-serve hole.
