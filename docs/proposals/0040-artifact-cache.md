---
sfep: 0040
title: Global Artifact Cache Store and Garbage Collection
status: Implemented
type: tooling
created: 2026-07-04
updated: 2026-07-24
author: "agent:compiler-architect; human review"
tracking: "#1892, #1893"
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0040 — Global Artifact Cache Store and Garbage Collection

## 1. Summary

Sailfin already has the hard part of a good build-artifact story — a real
content-addressed incremental cache (`build/cache/v2`, keyed on a hash of
source, dependency hashes, compiler version, flags, and slug, published by
atomic rename). But it ships that cache with two foot-gun defaults: it lives at
a **per-project, CWD-relative** path, and it **grows without bound** (no
eviction, no GC — only `--clean`/`make clean-build` reclaims it). The result is
the exact "Rust `target/` is heavy" complaint: every project duplicates its own
artifact cache, and each one grows forever. This SFEP changes two defaults and
adds one command: (1) default the content-addressed cache to a shared per-user
directory (XDG `~/.cache/sailfin`), keeping the existing overrides; (2) add
`sfn cache` (`prune` / `clean` / `info`) with a size/age GC; (3) make a cache
schema-version bump sweep stale `v<N>/` trees instead of leaving them to rot. No
language, effect, or self-hosting semantics change — this is toolchain hygiene.

## 2. Motivation

A social-media framing that keeps recurring: "node_modules is heavy — wait till
you see Rust's `target/`." It conflates two problems. **Axis 1** is *build
artifact* bloat (`.o`/IR/binaries duplicated per project, never GC'd — Rust's
`target/`). **Axis 2** is *dependency* dedup (one physical copy of a package
version shared across projects — pnpm's symlinked central store). Sailfin is
already sound on axis 2: external capsules resolve from a single global
version-keyed cache `~/.sfn/cache/capsules/<scope>/<name>/<version>/src/`
(`compiler/src/capsule_resolver.sfn:619-648`), the Cargo model, no
`node_modules`. This SFEP is entirely about **axis 1**, where we have the
mechanism but the wrong defaults.

Concretely, today (`compiler/src/build_cache.sfn`):

- The content-addressed cache root is `cache_root()` → `build/cache/v2`,
  CWD-relative, overridable only via `$SAILFIN_BUILD_CACHE_DIR`
  (`build_cache.sfn:238-250`). There is **no global user-level default** — every
  project checkout gets its own private `build/cache`, so a module compiled
  identically in ten projects is cached ten times.
- There is **no eviction of any kind**. A grep for `evict|prune|gc|LRU|age.?out`
  across `compiler/src` finds only a comment noting artifacts "age out via the
  user's normal cache-cleanup or `--clean` flow" (`build_cache.sfn:84-86`) — i.e.
  never, absent human action. The only reclaim paths are the explicit `--clean`
  flag (`cache_clean`, `build_cache.sfn:224-230`, an `rm -rf` of the schema root)
  and `make clean-build`.
- A cache **schema-version bump** (the `v2` in the path) simply starts writing to
  a new `v<N>/` and **leaves the old tree in place** (`build_cache.sfn:47-52`), so
  every historical schema version accretes on disk forever.

The sharing hook already exists and is safe: the cache is content-keyed and
published by atomic rename (`build_cache.sfn:352-400`), which is exactly why
concurrent test workers already share `build/cache/v2` without corruption. We
are not defaulting to that safe-by-construction sharing across projects, and we
give the user no bounded-size story. Both are cheap to fix.

## 3. Design

Three independent, composable changes to `compiler/src/build_cache.sfn` and one
new CLI command. None touch the cache *key*, the *entry layout*
(`<key[0..2]>/<key>/{ir.sfn-asm,layout.manifest,mod.ll,mod.o}`), or the
atomic-publish protocol — only *where the root is* and *when entries are
removed*.

### 3.1 Global default cache root

`cache_root()` gains a resolution ladder (highest precedence first):

1. `$SAILFIN_BUILD_CACHE_DIR/v<N>` — unchanged, explicit override (CI, sandboxes).
2. `$XDG_CACHE_HOME/sailfin/v<N>` if `$XDG_CACHE_HOME` is set.
3. `$HOME/.cache/sailfin/v<N>` — the new default on Linux/macOS.
4. `build/cache/v<N>` — retained **fallback** when `$HOME` is unresolvable
   (containers, minimal CI) and as the in-tree cache for the compiler's own
   self-host build, which must stay hermetic under `build/`.

The compiler self-host build (`[capsule].name == "sailfin"`, the same predicate
`build_stamp.sfn:75` already keys on) pins the root to in-tree `build/cache` so
`make compile` / `make check` remain hermetic and reproducible — the global
store is a *user-project* convenience, never a self-host input.

```sfn
// build_cache.sfn — resolution sketch (illustrative)
fn cache_root() -> string ![io] {
    let explicit = env.get("SAILFIN_BUILD_CACHE_DIR");
    if explicit.length > 0 { return explicit + "/" + _schema_dir(); }
    if _is_compiler_selfhost() { return "build/cache/" + _schema_dir(); }
    let xdg = env.get("XDG_CACHE_HOME");
    if xdg.length > 0 { return xdg + "/sailfin/" + _schema_dir(); }
    let home = env.get("HOME");
    if home.length > 0 { return home + "/.cache/sailfin/" + _schema_dir(); }
    return "build/cache/" + _schema_dir();  // hermetic fallback
}
```

Because entries are content-addressed, cross-project sharing at the global root
is sound with no new locking: two projects that compile the same
(source, deps, compiler-version, flags, slug) tuple hit the same key and the
same atomically-published entry. This is the pnpm-central-store win, applied to
*build artifacts* — the thing Rust's `target/` never did.

Unchanged and still local: the non-content-addressed **driver scratch**
(`build/sailfin/program.ll`, `program.o`, import-context, build-stamp). These
are clobber-unsafe by design and must stay per-project / per-invocation
(redirected by `--work-dir` / `SAILFIN_TEST_SCRATCH` as today). Only the
content-addressed cache moves.

### 3.2 `sfn cache` command

A new top-level command (`compiler/src/cli/commands/cache.sfn`, registered in
the dispatch table alongside `lock`, `add`, `package`):

- `sfn cache info` — print the resolved cache root, entry count, and total size
  on disk. Zero effects beyond `![io]`.
- `sfn cache prune [--max-size <bytes>] [--max-age <days>]` — LRU eviction. Walk
  `v<N>/` entries, stat each entry directory's mtime (touched on cache *hit* so
  mtime is a true recency signal — see 3.4), delete oldest-first until under
  `--max-size`, and delete anything older than `--max-age`. Defaults chosen
  conservatively (e.g. `--max-size` ~5 GiB, `--max-age` 30 days) and documented;
  no implicit prune on normal builds (opt-in, like `cargo`'s ecosystem tools).
- `sfn cache clean` — the existing `--clean` reclaim, surfaced as a subcommand
  (the `--clean` flag stays for back-compat).

`sfn cache clean --all-schemas` deletes sibling `v<M>/` trees for `M < N` (the
stale-schema sweep, see 3.3) in addition to the current schema.

### 3.3 Schema-bump sweep

When `cache_root()` is first materialized for schema `v<N>`, opportunistically
remove sibling `v<M>/` (`M < N`) trees under the same base — a bounded,
idempotent cleanup that prevents dead schema versions accreting. Guarded so it
runs at most once per process and never touches `$SAILFIN_BUILD_CACHE_DIR`
roots the user explicitly pointed at (they may be sharing a base with other
tooling). Alternative if the eager sweep is deemed too aggressive: fold it into
`sfn cache prune`/`clean --all-schemas` only. (See §6.)

### 3.4 Mtime-on-hit for honest LRU

For `prune` to evict by true recency rather than creation time, a cache *hit*
must touch the entry's mtime. Add a single `fs` touch of the entry directory in
the hit path (`build_cache.sfn` lookup, near the existing read at ~`:352-400`).
This is the only change to the hot path and is a metadata-only write.

## 4. Effect & capability impact

None to the language or effect system. All new surface is `![io]` (filesystem
reads, stats, unlinks, and an env lookup for the cache root) — the same effect
class the cache already carries. `sfn cache` is an `![io]` command like `lock`.
No new capability is introduced and no effect taxonomy change is required.

## 5. Self-hosting impact

No compiler *pass* changes — this touches the build driver / cache layer
(`build_cache.sfn`, a new `cli/commands/cache.sfn`), not lexer → parser → AST →
typecheck → effects → emitter → LLVM lowering. The self-hosting invariant is
preserved by construction: the compiler's own build pins the cache root to
in-tree `build/cache` (§3.1), so `make compile` / `make check` stay hermetic and
never read a developer's global `~/.cache/sailfin`. The change is validated the
usual way — `make compile` must self-host after the edit, `make check` before
declaring it shipped. Risk is low because the cache *key* and *entry format* are
untouched; only root resolution and removal are new.

## 6. Alternatives considered

- **Do nothing (status quo).** The mechanism exists; users can already set
  `$SAILFIN_BUILD_CACHE_DIR` and run `--clean` by hand. Rejected: defaults are
  the product. "Set an env var and remember to `rm -rf`" is exactly the ergonomic
  gap that makes Rust's `target/` a meme.
- **pnpm-style per-file symlink store.** Symlink individual artifacts from a
  content-addressed store into a per-project tree. Rejected: our unit of caching
  is a whole compiled module (`.ll`+`.o`+manifest), not a file tree we assemble;
  the resolver already reads straight from the keyed store, so there is nothing
  to symlink *into*. Symlinks would add per-build fan-out and Windows-portability
  cost (SFEP-0021) for no dedup we don't already get.
- **Automatic prune on every build.** Rejected as a default: surprising latency
  and delete-under-concurrency hazards. Prune stays explicit (`sfn cache prune`),
  optionally wired into CI. A size *watermark* warning on build (non-deleting)
  is a possible future addition.
- **Eager schema-sweep vs. sweep-only-on-prune (§3.3).** The eager sweep keeps
  disk tidy with zero user action but deletes on first build after an upgrade;
  the conservative option confines all deletion to explicit `cache` subcommands.
  Open question for the design gate — default proposed is the guarded eager
  sweep, with a flag to opt out.

## 7. Stage1 readiness mapping

This is a toolchain/driver change, not a language feature, so the parse/typecheck
/emit/lower rows are N/A (no new syntax). The applicable bar:

- [ ] Parses — N/A (no grammar change)
- [ ] Type-checks / effect-checks — new `![io]` command type-checks clean
- [ ] Emits valid `.sfn-asm` — N/A
- [ ] Lowers to LLVM IR — N/A
- [ ] Regression coverage — see §8
- [ ] Self-hosts — `make compile` green; compiler build pins in-tree cache root
- [ ] `sfn fmt --check` clean on every touched `.sfn`
- [ ] Documented in `docs/status.md` + `docs/proposals/0006-build-architecture.md`
      (build/cache section) and the CLI reference

## 8. Test plan

`compiler/tests/` coverage, all Sailfin-native (`.sfn`, per `no-bash-e2e.md`):

- **Unit** (`build_cache` root resolution): `$SAILFIN_BUILD_CACHE_DIR` wins;
  `$XDG_CACHE_HOME` next; `$HOME/.cache/sailfin` default; hermetic `build/cache`
  fallback when `$HOME` is empty; self-host predicate pins in-tree. Drive via a
  helper that reads the resolved root under a scoped child env.
- **e2e** (`compiler/tests/e2e/cache_command_test.sfn`): with a scratch cache
  root threaded via `$SAILFIN_BUILD_CACHE_DIR`, build a fixture twice → second
  build is a cache hit; `sfn cache info` reports ≥1 entry and a plausible size;
  `sfn cache prune --max-size 0` empties it; `sfn cache clean` removes the tree.
  Use `with_env` / a per-child env array (never process-global mutation).
- **e2e** (schema sweep): pre-create a sibling `v<N-1>/` dir under the scratch
  root, run a build, assert the stale tree is gone (eager sweep) or survives
  until `sfn cache clean --all-schemas` (whichever §6 resolution is chosen).
- **Hermeticity guard**: assert a compiler self-host build does not read/write
  `$HOME/.cache/sailfin` (root pinned in-tree) — protects `make check`.

## 9. References

- Ground truth: `compiler/src/build_cache.sfn` (cache key `:772-799`, root
  `:238-250`, atomic publish `:352-400`, no-GC comment `:84-86`, schema-rot
  comment `:47-52`, `--clean` `:224-230`).
- Axis-2 dependency cache (out of scope here, already sound):
  `compiler/src/capsule_resolver.sfn:619-648`.
- SFEP-0006 (`0006-build-architecture.md`, Implemented) — build architecture the
  cache sits under; its build/cache section is the graduation target.
- SFEP-0002 (`0002-package-management.md`, Draft) — imagines a `cache` command
  surface; stale, superseded on this axis by this SFEP.
- SFEP-0021 (`0021-windows-native-selfhost.md`) — Windows path portability
  constraint informing the no-symlink decision (§6).
- Prior art: Cargo `~/.cargo`, pnpm content-addressed store, `ccache`/`sccache`
  (content-addressed compile caches with size-bounded LRU).
