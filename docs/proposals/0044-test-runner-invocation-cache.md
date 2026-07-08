---
sfep: 0044
title: Invocation-scoped runtime identity + in-process sha256 for the test runner
status: Implemented
type: tooling
created: 2026-07-08
updated: 2026-07-08
author: "agent:compiler-architect; human review"
tracking: "#1995, #1996, #1997, #1998, #1999, #2008, #2010"
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0044 — Invocation-scoped runtime identity + in-process sha256 for the test runner

## 1. Summary

The per-test-file child of the multi-file test runner spends ~2.8–3.4 s in its
"link window" even on a fully warm cache, of which the actual clang link is only
0.34 s. The remaining ~2.5 s is dominated by ~60 `popen`'d `sha256sum`/`shasum`
shell pipelines per child, run to recompute cache keys over the ~34
`runtime/sfn/**.sfn` sources — keys that are **invocation-constant** (the runtime
tree cannot change between the parent's one-time warm and a child's link within a
single `sfn test`). This SFEP (A) has the parent compute the runtime identity
once and hand it to children via a stamp file in the warm objdir so children skip
all per-file runtime hashing on the warm path, and (B) replaces the
`_sha256_of_file_cmd` popen pipeline with a pure-Sailfin in-process SHA-256
vendored from `capsules/sfn/crypto` — a compiler-source-only change with **no
seed dependency**. (C) resolver-pass sharing is scoped as a follow-up. Expected
warm per-file link window after A+B: from ~2.8–3.4 s to ~0.4–0.5 s.
Implemented via PRs #2000, #2001, #2007, #2009 (2026-07-08); work item C continues as #1997, dep-closure compile sharing as #2010.

## 2. Motivation

The full suite (~478 `*_test.sfn` files) runs ~50–70 min serially; `make check`
runs two cold suite passes plus self-host stages at 2–3 h nightly. The measured
per-warm-file breakdown (8-core macOS, runtime objects pre-warmed by the parent
via `SAILFIN_TEST_RUNTIME_OBJDIR`):

| Phase | Cost |
|---|---|
| child startup + discovery | 0.30 s |
| resolver pass (`prepare_project_capsules_for_test`) | 0.35 s |
| frontend compile of the test source | 0.15 s |
| **link window** | **2.8–3.4 s** (clang itself only 0.34 s) |
| exec | 0.36 s |

The link window is the outlier and it is almost entirely `sha256sum` subprocess
spawns, not linking. Two invocation-constant passes over the runtime tree run
**per child**:

1. `_test_bin_runtime_identity` (`test.sfn:2522`) hashes every runtime
   `.c`/`.ll`/`.sfn` source + prelude entry + every `.h` under each include root,
   via `runtime_link_inputs_identity` → `_sha256_of_file_cmd`
   (`build_cache.sfn:1347`). ~34 sources + headers.
2. `assemble_runtime_capsule_link_inputs` (`runtime_objs.sfn:761`) → for each of
   the ~34 sfn-sources, `_emit_runtime_sfn_to_obj` computes
   `runtime_object_cache_key_with_identity` (hashes the source,
   `build_cache.sfn:1012`) **and** `_runtime_obj_key_with_sibling_deps` (hashes
   each sibling dep, `runtime_objs.sfn:329`), plus
   `_stage_one_runtime_sfn_import_context` hashes the source again
   (`runtime_objs.sfn:473`). Even on a pure cache-hit path these key computations
   run so the sidecar `.key` can be compared — the object is not recompiled, but
   the key is still hashed.

Each `_sha256_of_file_cmd` call is a `sailfin_runtime_shell_capture` popen of a
`(command -v sha256sum && sha256sum … || shasum -a 256 …) | cut` pipeline
(`fs.sfn:232`). At ~478 files, this is on the order of 478 × 60 ≈ 29,000
process-spawn+pipe round-trips whose *only* product is a hash of a file that is
identical across the whole invocation.

## 3. Design

Three independent work items. A and B compose (each independently self-hosts) and
together collapse the warm link window; C is scoped as a follow-up.

### Work item A — Invocation-scoped runtime identity via a warm-objdir stamp

**Mechanism.** The multi-file parent already warms the runtime once into the
shared `sub_root` and hands children `SAILFIN_TEST_RUNTIME_OBJDIR`
(`test.sfn:635`). Extend that one-time warm to also write a **stamp manifest**
into the warm objdir, and have children read the stamp instead of re-hashing.

Stamp file: `<warm_objdir>/.runtime-identity.stamp`, written by the parent
immediately after a successful `assemble_runtime_capsule_link_inputs` warm. Its
contents (newline-separated `key=value`, versioned; **as built** — the full
cache keys are multi-line strings, so each stamp line carries the
`sha256_hex_of_string` of the key rather than the key itself, keeping the
format single-line-safe):

```
v1
invocation=<parent-minted nonce>
identity=<the runtime_link_inputs_identity digest>
obj/<cap_prefix + source basename + opt_flag + ".o">=<sha256 of the full
    sibling-folded runtime_object_cache_key_with_identity key>
asm/<slug>=<sha256 of the _stage_one import-context key>
```

The nonce is `sanitize(sub_root) + "-" + monotonic_millis()` — `sub_root` is
already per-invocation unique when mktemp'd, and the millis term covers the
externally-pinned-scratch case. The parent re-derives each key once with
exactly the emit path's derivation (`write_runtime_identity_stamp` in
`runtime_objs.sfn` binds them side by side); the runtime identity is computed
once by the parent (`_test_bin_runtime_identity`) and passed in. Derivation
drift between the writer and the emit path produces a stamped hash that
mismatches the sidecar — a fail-safe cache miss, never a stale hit.

**How children consume it.**

- `_test_bin_runtime_identity` (`test.sfn`): if `SAILFIN_TEST_RUNTIME_OBJDIR`
  is set **and** the stamp validates (versioned + `invocation=` equals the
  child's `SAILFIN_TEST_RUNTIME_STAMP` env), return the stamped `identity`
  directly — skipping the entire source/header hash loop. Otherwise fall back
  to the full in-process computation (single-file leaf path, or a
  missing/mismatched stamp).

- `_emit_runtime_sfn_to_obj` / `_stage_one_runtime_sfn_import_context`
  (`_runtime_stamp_cache_hit`): on the warm child path, a hit is
  `sha256(sidecar contents) == stamped hash` — zero source/sibling hashing.
  Any mismatch (or absent artifact/sidecar/stamp/nonce) falls through to the
  full key derivation and the existing `_runtime_obj_cache_hit` compare, so
  the sidecar remains the freshness authority.

**The staleness / correctness argument (the load-bearing part).**

The cache must never serve a stale runtime object or stale test binary. The stamp
must be *sound* (never validate a stale object) and its scope must not leak across
invocations.

1. *Within one invocation, the runtime tree is immutable.* The parent warms the
   runtime and writes the stamp before forking any child; no child (nor the
   parent) edits `runtime/sfn/**` during the run. So a source hashed at warm time
   is byte-identical when a child links. The stamped `obj_key` is therefore the
   *correct* key for the child's link — recomputing it would produce the same
   value. This is a pure elision of redundant work, not a relaxation of the
   correctness check: the child still compares the stamped key against the
   on-disk `.key` sidecar (`_runtime_obj_cache_hit`), so a corrupt or
   partially-written object still misses and recompiles.

2. *A stamp must not leak across invocations.* Two hazards: (a) a stale warm
   objdir reused by a later `sfn test` whose runtime tree changed; (b) a child
   from invocation X reading a stamp from invocation Y. Both are closed by an
   **invocation nonce**: the parent mints a fresh nonce per `sfn test`
   (`mktemp`-style, or `date +%s%N` + pid — reuse the existing `sub_root`
   `mktemp -d` basename, which is already per-invocation unique), writes it into
   the stamp's `invocation=` line, **and** passes it to every child as a new env
   var `SAILFIN_TEST_RUNTIME_STAMP=<nonce>`. A child uses the stamp *only* when
   the file's `invocation=` equals the env nonce it was handed. A reused objdir
   with a stale stamp (case a) is only reachable when the caller pins
   `SAILFIN_TEST_RUNTIME_OBJDIR` themselves (seedcheck/stage3); in that case the
   parent still rewrites the stamp with the current invocation's nonce at warm
   time, so the stamp always reflects *this* run's runtime tree. If the parent
   did not warm (no stamp written) the child sees no matching nonce and falls
   back to hashing — the current behavior, i.e. fail-safe.

3. *The single-file leaf path has no parent and no stamp.* `SAILFIN_TEST_RUNTIME_STAMP`
   is unset, so `_test_bin_runtime_identity` and the object-key path both fall
   through to the existing in-process hash. Behavior is byte-identical to today.
   (Once B lands, that fallback is in-process sha256 rather than popen, so the
   leaf path is also faster — but its *semantics* are unchanged.)

4. *What if a runtime source is touched mid-run?* It can't within the runner's
   own operation, but a hostile/racy external `touch` is defended structurally:
   the stamp only *supplies the expected key*; the object hit still requires the
   on-disk object + matching `.key` sidecar. If someone recompiles the runtime
   under the objdir mid-run, the sidecar written by that recompile carries the
   new key while the stamp carries the old — the child's compare mismatches and
   it recompiles into its own scratch. The stamp can cause a *miss-when-hit-was-
   possible* (harmless, self-corrects) but never a *hit-when-stale* (unsound).
   This asymmetry is the correctness guarantee: **the stamp is an optimization
   hint for the expected key, never the authority for freshness.**

**Test-bin cache key (test.sfn:1168 / `test_bin_cache_key`).** Yes — it can and
should consume the stamped `runtime_identity`. `test_bin_cache_key` already takes
`runtime_identity` as a parameter (`build_cache.sfn:1281`); today the child
computes it via `_test_bin_runtime_identity`. With A, that function returns the
stamped value on the warm path, so the test-bin key transparently consumes the
precomputed identity with no signature change. The test-bin key's own
correctness model is unchanged: it still folds the test source, dep closure,
compiler identity, and this runtime identity — and the runtime identity is
*exactly* the value it would have computed itself.

### Work item B — In-process SHA-256

**What exists.** `capsules/sfn/crypto/src/mod.sfn` contains a complete,
self-contained pure-Sailfin `sha256_hex(data: string) -> string` (FIPS 180-4).
It has **no imports**, **no effects** (`![pure]`-shaped — bitwise ops, array
push/index, `char_code`), and already compiles under the current seed (the
capsule ships and is tested at `capsules/sfn/crypto/tests/sha256_test.sfn`).

**Seed-dependency verdict: NONE.** Per `.claude/rules/seed-dependency.md`, a seed
dependency exists only when compiler-source needs a language/runtime capability
*not present in the pinned seed*. This uses only capabilities the seed already
has (it compiles the crypto capsule today). Two viable shapes, both seed-free:

- **Preferred: vendor `sha256_hex` into a new compiler-source module**
  `compiler/src/build/hash.sfn` (a pure function `sha256_hex_of_string(s:
  string) -> string`, plus the two helpers `sha256_rotr`, `sha256_word_hex`).
  Copying source into the compiler tree needs no seed change — `make compile`
  builds the new compiler from the old seed, which compiles the new module in the
  same pass. This is the canonical "capability compiled as part of the compiler
  source tree needs NO seed change" shape the rule calls out. It avoids the
  workspace-membership question of importing the capsule from compiler source
  (compiler/src does import `sfn/cli`, so capsule import *works*, but vendoring a
  ~60-line pure function is lower-risk than adding `sfn/crypto` to the compiler's
  dependency closure).

- Reading a file: replace `_sha256_of_file_cmd`'s pipeline body with
  `fs.readFile(path)` + `sha256_hex_of_string(contents)`. `fs.readFile` is `![io]`
  (already the effect `_sha256_of_file_cmd` carries), so the signature is
  unchanged. Empty-file / unreadable → `fs.readFile` returns `""`; hashing `""`
  yields the well-known empty-string digest, which would be a behavior change
  from today's `""`-on-failure contract. **Preserve the failure contract**: keep
  the current `if !fs.exists(path) { return ""; }` guard so a missing source
  still returns `""` (the "not content-addressable → recompile" signal every
  caller relies on).

**Call-site benefit (quantified).** `_sha256_of_file_cmd` has these callers
(grep confirmed): `build_cache.sfn` (`sha256_of_file`, `cache_key_for` ×2,
`cache_compiler_identity`, `test_bin_cache_key` ×2, `runtime_link_inputs_identity`,
and inside `_sha256_of_string`), `runtime_objs.sfn` (sibling-dep hash),
`determinism.sfn` (×2), `cli_selfhost.sfn` (×2), and the CLI commands
`publish.sfn`, `package.sfn` (×3), `add.sfn`. Replacing the one primitive speeds
**every** content-addressed path in the whole build driver — not just the test
runner. `_sha256_of_string` (`build_cache.sfn:868`) currently writes a tmp file
then popens `_sha256_of_file_cmd`; it should be rewritten to call
`sha256_hex_of_string(input)` directly, eliminating both the tmp-file write and
the popen (and the whole `mktemp`/race-workaround comment block becomes moot —
there is no shared tmp path to collide on).

`_shell_read_cmd` has other users (env reads, `find`, `stat`, `du`, `mktemp`,
`uname`, OpenSSL probe) that are **out of scope** for B — they are not hashing.
Only the sha256 primitive is replaced.

### Work item C — Resolver-pass sharing parent→child (follow-up, do not bundle)

The 0.35 s/file resolver pass (`prepare_project_capsules_for_test`) re-runs the
capsule resolver per child. Sharing it parent→child is *substantially harder*
than A/B: the resolver produces per-test dep closures (`dep_ll_paths`,
`native_texts`, interfaces, function effects, capabilities) that are
test-source-specific, not invocation-constant like the runtime identity. A shared
resolver result would need either a serialized per-file manifest handed to each
child (re-introducing the filesystem-IPC cost item 0006 flags as the primary
bottleneck) or an in-process multi-file resolver (which OOM'd/segfaulted on the
real suite — the exact reason per-file child isolation exists, `test.sfn:560`).
**Scope C as a standalone follow-up issue**, gated on the 0006 build-architecture
IPC redesign; do not force it into the A+B PR.

## 4. Effect & capability impact

None. All changes are within `![io]` build-driver code. `sha256_hex_of_string` is
a pure function (no effects); `_sha256_of_file_cmd` keeps its `![io]` signature
(now from `fs.readFile` rather than popen). No user-facing effect surface changes.

## 5. Self-hosting impact

No compiler *pass* changes (lexer→…→lowering are untouched). The changes are
entirely in the build/test driver modules:
`compiler/src/build/fs.sfn`, `compiler/src/build/hash.sfn` (new),
`compiler/src/build_cache.sfn`, `compiler/src/build/runtime_objs.sfn`,
`compiler/src/cli/commands/test.sfn`. Each item independently self-hosts:

- **B first** is a pure behavior-preserving swap of the hash primitive
  (same digest values — SHA-256 is SHA-256; verify against `sha256sum` in a
  regression test). `make compile` builds the new compiler from the old seed;
  the new hash module compiles in the same pass (no seed change).
- **A second** consumes B's faster primitive and adds the stamp. The stamp is
  additive (a missing stamp → current behavior), so an intermediate state where
  the parent writes a stamp but children ignore it, or vice versa, is still
  correct — the fallback path is always the current in-process computation.

The self-host build itself benefits: `cli_selfhost.sfn` and `determinism.sfn`
hash artifacts via the same primitive.

## 6. Alternatives considered

- **A runtime builtin sha256 (`extern fn`).** Would require the symbol in the
  pinned seed's runtime → a seed-blocker (`.claude/rules/seed-dependency.md`).
  Rejected: a pure-Sailfin vendored function needs no seed change and is equally
  fast in-process.
- **Import `sfn/crypto` from compiler source instead of vendoring.** Works (the
  compiler already imports `sfn/cli`), but adds the crypto capsule to the
  compiler's dependency closure and couples the compiler build to a capsule's
  lifecycle. Vendoring ~60 lines of stable, spec-frozen algorithm is lower-risk;
  the two copies are trivially kept in sync (a `sha256` algorithm does not
  change). A regression test cross-checks both against `sha256sum`.
- **Env var carrying the runtime identity (A) instead of a stamp file.** A single
  `runtime_identity` env var would cover `_test_bin_runtime_identity` but not the
  per-slug object-key elision, which needs a per-source map. A stamp file carries
  both in one artifact already living in the warm objdir, and its `invocation=`
  line is the natural scope guard. Rejected in favor of the stamp.
- **Skip the per-object key comparison entirely on the warm path** (trust the
  object exists). Rejected: it removes the freshness authority (the `.key`
  sidecar compare), reintroducing the class of stale-object bugs #632/#969/#1197
  fixed. The stamp supplies the *expected* key so the compare still runs — just
  without re-hashing.

## 7. Stage1 readiness mapping

Tooling change; no language surface. The relevant bars:

- [ ] Parses — N/A (no new syntax)
- [ ] Type-checks / effect-checks — new `hash.sfn` module passes `sfn check`
- [ ] Emits valid `.sfn-asm` — exercised by `make compile`
- [ ] Lowers to LLVM IR — exercised by `make compile`
- [ ] Regression coverage — see §8
- [ ] Self-hosts — `make compile` after each of B then A
- [ ] `sfn fmt --check` clean — on every touched `.sfn`
- [ ] Documented in `docs/status.md` — note the test-runner perf change; this
      SFEP is the design record

## 8. Test plan

**B — sha256 correctness (must land with B):**
- `compiler/tests/unit/build_hash_sha256_test.sfn` — `sha256_hex_of_string`
  against FIPS/NIST vectors (`""`, `"abc"`, the crypto capsule's known
  `"hello world"` digest) so the vendored copy is proven equal to a reference.
- `compiler/tests/e2e/build_hash_matches_sha256sum_test.sfn` — `![io]` test:
  write a file, hash it in-process, shell `sha256sum`/`shasum -a 256`, assert
  equal. Skip (assert true) if neither tool is present, per the no-bash-e2e rule.

**A — cache correctness (the critical regressions):**
- `compiler/tests/e2e/runtime_stamp_staleness_test.sfn` — the load-bearing one.
  With a per-invocation scratch: (1) build a test binary, capture output; (2)
  touch a `runtime/sfn/**` source's *content* (append a comment) into a private
  runtime copy the test points the runner at, run again in a *fresh* invocation
  (fresh nonce) → assert the child rebuilds (object key changed, stamp from run 1
  cannot false-hit run 2 because the nonce differs). This proves the nonce scope
  guard.
- `compiler/tests/e2e/runtime_stamp_missing_fallback_test.sfn` — run a single
  file with no `SAILFIN_TEST_RUNTIME_OBJDIR`/`SAILFIN_TEST_RUNTIME_STAMP` set →
  assert it passes (leaf path falls back to in-process hashing, unchanged).
- `compiler/tests/e2e/runtime_stamp_warm_hit_test.sfn` — multi-file run in one
  invocation → assert children hit the warm objdir and produce correct output
  (functional proof the stamp path links correctly).
- Existing `check_build_agree_module_global_test.sfn` and the runtime-object
  cache tests continue to gate the `.key` sidecar contract.

**Gate:** `make compile` after B, then after A; `make check` before declaring
shipped (the two-cold-pass gate proves no stale-hit crept in).

## 9. References

- `docs/proposals/0006-build-architecture.md` — build/IPC bottleneck root cause
  (C's blocker).
- `docs/proposals/0011-ci-test-speed.md` — the per-test-binary cache (#1230/#1233)
  this composes with.
- SFEP-0040 — content-addressed module cache root resolution.
- `.claude/rules/seed-dependency.md` — the no-seed-cut verdict for B.
- `capsules/sfn/crypto/src/mod.sfn` — the pure-Sailfin SHA-256 vendored by B.
- Key code paths: `compiler/src/build/fs.sfn:232` (`_sha256_of_file_cmd`),
  `compiler/src/build_cache.sfn:868` (`_sha256_of_string`), `:1281`
  (`test_bin_cache_key`), `:1342` (`runtime_link_inputs_identity`);
  `compiler/src/build/runtime_objs.sfn:761`
  (`assemble_runtime_capsule_link_inputs`), `:337` (`_emit_runtime_sfn_to_obj`);
  `compiler/src/cli/commands/test.sfn:635` (parent warm), `:2522`
  (`_test_bin_runtime_identity`), `:1168` (`test_bin_cache_key` call).
