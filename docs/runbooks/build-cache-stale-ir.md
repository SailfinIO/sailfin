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

## Read this first: there are two cached classes

A build caches artifacts at **two independent layers**, and clearing one says
nothing about the other. If you are here because you cleared the cache and the
stale symptom survived, you almost certainly cleared only the first:

| Layer | Artifacts | Key | Sections |
|---|---|---|---|
| **Module cache** | `.ll`, `.o` | `cache_key_for`, `tgt2:` separator | §1–§3 |
| **Staging cache** | `.sfn-asm`, `.layout-manifest` | `stage_cache_key_from_digest`, `stage1:` separator | §4 |

The staging layer arrived later, with SFN-861: §1–§3 were written when `.ll` was
the only cached class, which is exactly why a reader can clear "the cache" and
still be served a stale artifact. The two key spaces are deliberately
domain-separated (`build_cache.sfn:1344-1346`) so they can never collide — which
also means they never invalidate together.

**The one thing most likely to mislead you:** `--no-cache` does not give you a
cold `.sfn-asm`. See §4.3.

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
at the `.ll` module-cache call site in `compiler/src/capsule_resolver.sfn`
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

## 3. The one narrow caveat: the in-process fallback

`cache_compiler_identity` reverts to the raw stamp (no binary-hash fold) when
the emitting-binary path is empty — the **in-process serial fallback**
(`sailfin_exe == ""`). Two callers reach it:

- **`sfn check`** — frontend-only (parse + typecheck + effect-check); it emits no
  `.ll` and touches no module-IR cache entry, so the trap cannot apply.
- **`sfn test` on a small import closure** — `_cr_effective_isolation_exe`
  (`capsule_resolver.sfn`) keeps the in-process path (returns `""`) when the
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
the module cache's `tgt2:`. Compiler identity is the same
`cache_compiler_identity` used by the `.ll` layer (§2), so a dirty rebuild busts
staged artifacts exactly as it busts module IR. Unlike `cache_key_for`, no
dependency-manifest hashes are folded in — `.sfn-asm` emit consults no
cross-module import context, so it is a pure function of that tuple
(`build_cache.sfn:1328-1336`).

### 4.3 Local hit vs. shared hit — and why it matters

The two are counted separately in the trace because they fail differently.

**Local hit** (`_cr_stage_cache_hit`, `staging.sfn:82-91`) — a stat + one hash,
no copy. It is a hit when the `.sfn-asm` *and* `.layout-manifest` *and*
`.srchash` all exist and the recorded digest equals a fresh
`sha256_of_file(src)`. Content-addressed, never mtime-based: `git checkout`
resets mtimes, so timestamps lie (#514).

**Shared hit** (`_cr_stage_cache_probe`, `stage_cache.sfn:190-230`) — tried
*only* after the local probe misses. It looks both artifacts up in the shared
root, copies them out into the work dir, and verifies the restored `.sfn-asm` is
non-empty before trusting it. On success the local `.srchash` is written too, so
a shared hit is promoted to a local hit for the next probe in the same work dir.

> **`--no-cache` does not disable the local layer.** `SAILFIN_NO_CACHE=1` and
> `--no-cache` disable the *shared* staging cache (`stage_cache.sfn:97`) and the
> module cache — but the local `.srchash` probe runs unconditionally at both
> call sites (`staging.sfn:203` serial, `staging.sfn:513` parallel), *before*
> any context or env is consulted. A `--no-cache` build with an unchanged source
> still serves the previously staged `.sfn-asm` from `build/compiler/import-context/`.
> To force a fresh emit you must delete that tree (§5).

### 4.4 Reading the trace

`SAILFIN_CACHE_TRACE=1` gates both summaries, but they are **two independent
counters printed from different modules** — zeros on one say nothing about the
other:

```
[cache] hits=… misses=… stores=… invalid_keys=… copy_failures=…        # build/cache.sfn — .ll/.o
[stage cache] local_hits=… hits=… misses=… stores=… restore_failed=…   # stage_cache.sfn — .sfn-asm/.layout-manifest
```

In the `[stage cache]` line, `local_hits` counts `.srchash` hits and `hits`
counts shared-root restores — so `local_hits=34 hits=0 misses=0` means nothing
was consulted from the shared cache at all. `restore_failed` is *not* a miss: it
counts entries found in the shared root whose copy-out failed or verified empty,
which then fall through to a fresh emit. A non-zero `restore_failed` points at a
damaged or racing cache root, not at a key problem.

Per-module lines under the same flag: `[stage cache hit] <slug>`,
`[stage cache miss] <slug>`, `[stage cache restore-failed] <slug>`,
`[stage cache store] <slug>`.

The `[cache]` summary is suppressed entirely when its counters are all zero;
the `[stage cache]` summary is not. Do not read a missing `[cache]` line as
evidence about staging.

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

**Staging cache (`.sfn-asm` / `.layout-manifest`):** the *shared* half is
covered by the three levers above, since it hangs off the same `cache_root`
(§4.1) — `--clean` removes the whole schema-versioned subtree, both classes with
it. The *local* half has **no flag**; it is cleared by deleting the tree:

```bash
rm -rf build/compiler/import-context          # local staged artifacts + .srchash sidecars
rm -rf <work_dir>/compiler/import-context     # when built with --work-dir
```

`make clean-build` also removes it (it wipes `build/`), which additionally takes
out the self-host shared root at `build/cache/v2` — but **not** a shared root
under `~/.cache/sailfin/v2`, which is where non-self-host capsules land. If you
want everything cold in one shot regardless of capsule, combine the two:

```bash
rm -rf build/compiler/import-context && SAILFIN_BUILD_CACHE_DIR=$(mktemp -d) sfn build -p <capsule>
```

**Confirming it worked.** `SAILFIN_CACHE_TRACE=1` (or `--cache-trace`) prints
per-module `[cache hit]` / `[cache miss]` lines and the `[cache] hits=… misses=…`
summary, which is the fastest way to confirm whether a rebuild actually
re-emitted a module — and, per §4.4, the separate `[stage cache] local_hits=…`
summary for the staging layer. Check **both** lines before concluding a build
was cold.

---

## References

- `compiler/src/build_cache.sfn` — cache key derivation (`cache_key_for`,
  `stage_cache_key_from_digest`), `cache_compiler_identity`, `cache_root_from`.
- `compiler/src/build_stamp.sfn` — the four-case stamp truth table (incl. `.dirty`).
- `compiler/src/capsule_resolver.sfn` — the `.ll` module-cache call sites.
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
> `.srchash`), and a private root at `<out_dir>/rt-import-context`. It shares the
> shared-cache primitives but none of the paths above, so nothing in §4 clears
> it.
