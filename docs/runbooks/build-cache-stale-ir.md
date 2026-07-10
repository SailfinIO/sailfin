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

---

## 1. Committed and released builds are always correct

The compiler identity mixed into the key is the build stamp
(`compiler/src/build_stamp.sfn`), which resolves to one of:

| Build | Stamp | Cache behaviour |
|---|---|---|
| Tag at HEAD | `<version>` | Distinct per release → never collides across compilers. |
| Clean commit | `<version>+dev.<hash>` | The commit hash changes on every commit → any committed codegen change busts downstream IR. |
| Dirty tree | `<version>+dev.<hash>.dirty` | See §2 — the emitting binary's content hash is folded in. |

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
(`sailfin_exe == ""`) used by `handle_check_command` and the `sfn test` runner.
In practice this path does not expose the trap:

- `sfn check` is frontend-only (parse + typecheck + effect-check); it emits no
  `.ll` and touches no module-IR cache entry.
- The `sfn test` runner keys its linked binaries on the *commit-stable*
  `resolve_test_bin_identity_for_cache` identity, and `make check` / the full
  suite pass `--no-test-cache` as the cold-build backstop.

If a future in-process caller does start emitting `.ll` through
`_cr_compile_one` with an empty `sailfin_exe`, fold a compiler-source or
self-binary hash into the identity there too — that is the only remaining hole,
and it is currently unreachable.

## 4. Escape hatch

If you ever suspect a stale hit (an unusual cache-dir state, a manually staged
binary, or the in-process caveat above), force a cold compile without nuking the
whole cache:

```bash
sfn build -p <capsule> --no-cache     # bypass lookup + store for this build
sfn build -p <capsule> --clean        # wipe the schema-versioned cache subtree first
SAILFIN_BUILD_CACHE_DIR=$(mktemp -d) sfn build -p <capsule>   # fresh, isolated cache
```

`SAILFIN_CACHE_TRACE=1` (or `--cache-trace`) prints per-module `[cache hit]` /
`[cache miss]` lines and the `[cache] hits=… misses=…` summary, which is the
fastest way to confirm whether a rebuild actually re-emitted a module.

---

## References

- `compiler/src/build_cache.sfn` — cache key derivation, `cache_compiler_identity`.
- `compiler/src/build_stamp.sfn` — the four-case stamp truth table (incl. `.dirty`).
- `compiler/src/capsule_resolver.sfn` — the `.ll` module-cache call sites.
- SFEP-0040 (`docs/proposals/0040-artifact-cache.md`) — shared-cache root ladder and GC.
- SFN-181 — this trap; SFN-154 / PR #2071 — the cycle-sink that motivated it.
