---
sfep: 0068
title: Native Cross-Target Builds (`sfn build --target=<triple>`)
status: Accepted
type: tooling
created: 2026-08-08
updated: 2026-08-22
author: "agent:compiler-architect; human review"
tracking: SFN-774, SFN-775, SFN-776, SFN-777
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0068 — Native Cross-Target Builds (`sfn build --target=<triple>`)

## 1. Summary

Teach the build driver a first-class `--target=<triple>` flag by promoting the
existing single-axis target model (`target OS`, `compiler/src/build/target.sfn`)
to a **triple** axis, and by moving the per-target runtime-module substitution
table out of compiler source into declarative `[targets.<triple>]` tables in
`runtime/capsule.toml` (a manifest seam `compiler/src/toml_parser.sfn` already
parses and nothing yet reads). This retires `make ci-cross-windows`
(`Makefile:1119-1308`, ~190 lines) and, with it, the entire `make rebuild`
post-build staging block (`Makefile:1001-1097`) that exists only to feed it.

The strategic point is a **reframe**: SFN-58 is written as "retire the mingw
cross path", which is why it sits behind SFN-57 (the native MSVC seed) and the
whole Native Windows project. This proposal **rehosts** the mingw path instead
of retiring it — mingw becomes one entry in a closed triple table owned by the
driver. The Makefile can then be deleted on this work alone, and SFN-58 later
degrades to deleting a `[targets.x86_64-w64-mingw32]` table plus one CI step.

## 2. Motivation

### 2.1 The Makefile's two largest remaining blocks are one feature

`ci-cross-windows` is a second, hand-rolled build driver: `llvm-link`
discovery over four candidate names, `clang -target x86_64-w64-mingw32`, a
hardcoded `RUNTIME_MODS` list doing per-module Windows/POSIX source
substitution, per-module `SAILFIN_TARGET_OS=Windows` re-emit overrides for
exactly three modules (`clock`, `exec`, `filesystem`), an explicit link
ordering, and tar packaging.

`rebuild-impl`'s post-build block (`Makefile:1001-1097`) mirrors `.ll` IR to
`build/native/raw/`, flattens `build/capsules/*/ir/*.ll` into that tree, and
re-stages `runtime/sfn/platform/posix` + `runtime/sfn/memory/ownedbuf`
import-context. `Makefile:944` states outright that this staging exists
**solely** as the `ci-cross-windows` prerequisite, not for the build itself.
Killing the cross target collapses this block too, leaving `rebuild-impl`
equal to what `sfn dev bootstrap build` already does natively
(`compiler/src/cli/commands/dev.sfn`, `_bootstrap_run_compiler_build`).

`Makefile:1113` names the fix verbatim: "the future `sfn build
--target=x86_64-w64-mingw32` retires this target wholesale."

### 2.2 The mechanism already exists; only the key is wrong

SFN-52 landed `compiler/src/build/target.sfn` (361 lines), which already owns
every target-divergent decision natively:

| Concern | Native function | Makefile equivalent |
|---|---|---|
| clang triple | `target_clang_triple` / `target_clang_flags` | `-target x86_64-w64-mingw32` (`:1163`) |
| linker choice | `target_forced_linker_flag` | `$(MINGW_CC)` (`:1276`) |
| GNU link GC | `target_uses_gnu_link_gc` | implicit |
| link libs | `target_filter_link_libs` / `target_extra_link_libs` | `-lm -lpthread -lws2_32` (`:1281`) |
| **runtime module swap** | **`target_condition_runtime_sfn_sources`** | **`RUNTIME_MODS` (`:1230`)** |
| artifact path tag | `target_artifact_tag` | `build/windows/obj` |
| `.exe` suffix | `target_exe_name` | hardcoded |

The native swap table is *strictly more complete* than the Makefile's: seven
swaps plus six appends (`process`, `rlimit`, `rand`, `tls`, `fs_exec_mode`,
`socket_ops`, `rename_ops` swapped; `realpath`, `clock`, `pthread`, `popen`,
`mkstemp`, `strcasestr` appended) against the Makefile's five swaps and zero
appends. Two mechanisms encode the same policy and, as the Makefile comment at
`:1211` admits, "BOTH must be updated when a runtime module gains a Windows
sibling" — guarded only by a string-matching drift test
(`compiler/tests/e2e/cross_windows_runtime_modules_test.sfn`).

The blocker is that the native model is keyed on **target OS**
(`"Linux" | "Darwin" | "Windows"`), and `target_clang_triple("Windows")`
returns `x86_64-pc-windows-msvc` unconditionally. There is no way to say
"Windows, GNU ABI". One axis is missing; everything else is built.

### 2.3 The cross exe today carries Linux-selected emit legs

`ci-cross-windows` reuses the *Linux-emitted* compiler IR from
`build/native/raw/` and only re-emits three runtime modules under
`SAILFIN_TARGET_OS=Windows`. But the emitter reads the resolved target at emit
time to select platform legs (`llvm/lowering_debug_state.sfn`, the errno
locator, `exe_path_locator()` per SFEP-0013). Every compiler-source module in
the cross exe was therefore emitted with Linux legs selected. A
driver-native cross build re-emits the whole tree for the target — a
correctness improvement, not just a refactor.

## 3. Design

### 3.1 The triple becomes the primary target key

`compiler/src/build/target.sfn` grows a triple resolver above the existing OS
resolver. The closed triple set (unknown triples are rejected at the flag,
not silently coerced):

| Triple | OS | ABI tag | Artifact tag |
|---|---|---|---|
| `x86_64-unknown-linux-gnu` | Linux | gnu | `linux-x86_64` |
| `aarch64-unknown-linux-gnu` | Linux | gnu | `linux-aarch64` |
| `x86_64-apple-darwin` | Darwin | mach | `darwin-x86_64` |
| `arm64-apple-darwin` | Darwin | mach | `darwin-arm64` |
| `x86_64-pc-windows-msvc` | Windows | msvc | `windows-msvc` |
| `x86_64-w64-mingw32` | Windows | gnu | `windows-gnu` |

`target_os_is_windows` and the POSIX→Win32 provider replacements key on the
**OS** component. The **ABI** component also selects the pthread provider:
MinGW uses statically linked winpthreads, while MSVC retains the Sailfin
`pthread_windows.sfn` shim; both use the independent `sysconf_windows.sfn`.
The ABI component keys the link decisions that diverge:

| Decision | `windows-msvc` | `windows-gnu` |
|---|---|---|
| clang `-target` | `x86_64-pc-windows-msvc` | `x86_64-w64-mingw32` |
| linker | `-fuse-ld=lld` | `x86_64-w64-mingw32-gcc -static` |
| GNU link GC (`--gc-sections`, `-Wl,-u`) | off | **on** |
| link libs | drop POSIX-only libs; add native Windows libs | keep `-lm -lpthread`; add `-lbcrypt -lcrypt32 -lws2_32` |
| TLS | native | `-femulated-tls` |

**Zero-behaviour contract preserved (#1112).** Every non-Windows triple keeps
returning an identity/empty result, so Linux and macOS argv and link inputs
stay byte-identical. `target_clang_flags` still returns `[]` for host-default
triples.

### 3.2 Where the resolved target lives: a set-once process cell

`build_target_os()` is read **ambiently** from ~14 call sites across
`backend.sfn`, `build/clang_argv.sfn`, `build/link.sfn`,
`build/runtime_objs.sfn`, `build_cache.sfn`, `build/determinism.sfn`,
`build/llvm_provider_context.sfn`, `cli/commands/run.sfn`, and
`cli/commands/test/*.sfn`. Three ways to seed it from a flag:

1. **Write the env var** — impossible. The Sailfin runtime has no `setenv`
   (`compiler/src/build_cache.sfn:279`, `runtime/sfn/process.sfn:1941`).
2. **Thread a `BuildTarget` parameter** through all 14 sites — a large,
   correctness-sensitive refactor with no payoff beyond this feature.
3. **A set-once in-process cell**, exactly mirroring
   `compiler/src/test_runner_state.sfn` (which solved the identical problem
   for `sfn test` mode and is snapshotted into the LLVM provider context).

Adopt (3). New module `compiler/src/build/target_state.sfn`:

```
set_build_target(triple)    // called once at the top of build.sfn:run
clear_build_target()        // called on every return path
active_build_target()       // pure read, no effect
```

Resolution order in `build_target_triple()`:

```
explicit cell  >  SAILFIN_TARGET_TRIPLE  >  SAILFIN_TARGET_OS (legacy alias)  >  host probe
```

`SAILFIN_TARGET_OS` survives as a legacy alias mapping `Windows` →
`x86_64-pc-windows-msvc` so every existing e2e test seam
(`windows_socket_ops_test.sfn`, `windows_runtime_siblings_test.sfn`,
`runtime_adapter_http_test.sfn`) keeps working unchanged.

**The one place the cell must be re-externalized:** per-module emit spawns
children. `_runtime_emit_child_env` (`compiler/src/build/runtime_objs.sfn`)
must inject `SAILFIN_TARGET_TRIPLE` from the resolved cell into the child env.
This is a like-for-like replacement of the Makefile's own per-module
`SAILFIN_TARGET_OS=Windows` override at `:1249`, so the mechanism is proven.

### 3.3 Per-module platform source selection becomes declarative

`compiler/src/toml_parser.sfn` **already** ships `toml_get_target_triples()`
(`:549`) enumerating `[targets.<triple>]` sections, and a section-aware
`toml_get_string_array(text, section, key)` (`:589`) whose header comment says
it exists "so callers can read `[targets.<triple>].cc-flags`". **Nothing
consumes either today.** This is the SFEP-0006 Stage A seam, built and never
wired. Wire it.

Additive schema in `runtime/capsule.toml`:

```toml
[targets.x86_64-w64-mingw32]
sfn-sources-replace = [
  "sfn/process.sfn=sfn/platform/process_windows.sfn",
  "sfn/platform/rlimit.sfn=sfn/platform/rlimit_windows.sfn",
  # ... every POSIX provider with a Windows sibling
]
sfn-sources-add = [
  "sfn/platform/realpath_windows.sfn",
  "sfn/platform/sysconf_windows.sfn",
  # ... the target-only Windows providers
]
sfn-sources-drop = []
ll-sources-add   = []
link-libs-drop   = []
link-libs-add    = ["-lbcrypt", "-lcrypt32", "-lws2_32"]
```

Because `toml_get_string_array` is **section-scoped**, a top-level
`sfn-sources` read by an older parser is unaffected by the new tables — the
schema is genuinely additive.

`runtime_capsule_resolver.sfn` resolves and validates the target table once at
the manifest boundary. `build/runtime_objs.sfn` applies the selected triple's
replacements, additions, drops, IR additions, and link-library edits through a
single shared transformation used by both compilation and linked-test cache
identity. `target_condition_runtime_sfn_sources` remains only as the one-seed
migration fallback described below.

**Migration constraint (load-bearing).** Do **not** delete the hardcoded
compiler-source table in the same change that adds the manifest table. On the
`windows-native-selfhost.yml` `native-build` job, the **seed** runs
`build -p compiler` on `windows-latest`, so the seed's own copy of
`target_condition_runtime_sfn_sources` performs the swap. A seed that cannot
read the manifest tables would build the Windows runtime with POSIX modules.
Keep the hardcoded table as the fallback when the manifest declares no
`[targets.<triple>]` section; delete it one seed later (see §5).

### 3.4 Real runtime providers replace the curated stub architecture

Native link validation refined the accepted design: the old Make target's
curated exclusion list and `runtime/ir/windows_stubs.ll` hid missing runtime
coverage and could not support production concurrency. The driver-native
MinGW build instead links the full manifest-selected runtime with real Windows
providers. POSIX modules are replaced by their Windows siblings, target-only
providers are added explicitly, and MinGW supplies its pthread ABI through
statically linked winpthreads. `sysconf_windows.sfn` owns the independent CPU
count ABI so it can be linked without the MSVC-only pthread shim.

Broad Win32 handle inheritance is serialized only across pipe/duplicate setup,
`CreateProcessA`, and parent-side handle closure. Process execution and drain
remain concurrent, preventing cross-spawn inheritance without serializing
child lifetimes. The target therefore needs no source drops and no stub IR.

`cross_module_shim.c` needs no special handling: it is produced in the
driver's own work dir and the native link path already picks it up.

### 3.5 `build/native/raw/` dies with the cross path

The mirror, the `build/capsules` flatten, the `posix` + `ownedbuf`
import-context re-staging, and the `llvm-link` discovery all exist only
because the cross recipe consumes IR emitted by a *different* invocation. A
driver-native cross build emits its own IR into its own target-tagged cache
bucket and needs none of it. `rebuild-impl` collapses to fingerprint + seed
resolve + `seed build -p compiler` + `dev bootstrap install` — which is
precisely `sfn dev bootstrap build`.

### 3.6 Cache-key correctness is not optional

`cache_key_for` (`compiler/src/build_cache.sfn:1204`) folds `target_os` as the
**last** key component, and the comment at `:1243-1258` states the ordering is
only sound while every target-derived flag is a total function of `target_os`.
Two Windows triples with different clang flags **violate that invariant
directly**. Required, in the same change as the triple axis:

- `cache_key_for`'s last component becomes the **triple**, not the OS.
- `_runtime_obj_key_with_target` (`build/runtime_objs.sfn`) likewise.
- `target_artifact_tag` returns `windows-msvc` / `windows-gnu`, so the two
  ABIs get distinct on-disk artifact paths instead of overwriting each other.
- Linked-test runtime identity hashes the same effective target-conditioned
  source, IR, and link-lib set that `assemble_runtime_capsule_link_inputs`
  consumes.

Without this, an msvc build and a mingw build silently share cache entries and
cross-link.

### 3.7 `--target` naming collision with `sfn package`

`sfn package --target` takes a **platform label** (`linux-x86_64`,
`windows-x86_64`; `cli/commands/package.sfn:86,168`), not a triple. Keep both
as-is — a packaging artifact name and a compilation triple are different
things — and map triple → label at the CI call site. Document the distinction
in both usage strings rather than unifying and churning the release plumbing.

## 4. Effect & capability impact

None. Target resolution is `![io]` (env + filesystem probes) exactly as
`build_target_os()` is today; `active_build_target()` is a pure read like
`test_runner_active()`. No new effect, no capability surface, no change to
`effect_taxonomy.sfn`.

## 5. Self-hosting impact

**Passes changed:** none of lexer → parser → AST → typecheck → effects. The
change is confined to the driver (`compiler/src/build/*`, `build_cache.sfn`,
`cli/commands/build.sfn`) plus the emit-time target snapshot already threaded
through `llvm_provider_context.sfn`.

**Seed-dependency call**, per `.claude/rules/seed-dependency.md`:

- **The triple axis, `--target`, and the cache-key fold bundle.** They are a
  compiler capability whose consumer (`cli/commands/build.sfn`, the CI cross
  build driven by `build/bin/sfn`) is in the same tree. `make compile` builds
  the new compiler from the old seed and that fresh compiler performs the
  cross build. **Not `seed-blocker`; no seed cut.**
- **The runtime-source carve-out does not block this change.** The new and
  hardened Windows providers use existing Sailfin syntax, Win32 extern ABI,
  and runtime primitives; they do not call a compiler capability absent from
  the pinned seed. The fresh compiler built from that compatible seed selects
  and compiles them through the manifest table.
- **One genuine seed gate exists, and it is a deletion.** Removing the
  hardcoded Windows swap table from `build/target.sfn` requires a pinned seed
  that reads the manifest tables, because the seed performs that swap on the
  native-Windows leg (§3.3). Handle it as a fallback retained for one seed and
  a follow-up deletion issue that queues on the cadence bump (SFEP-0026 WS-C),
  **not** as a `seed-blocker` predecessor gating the main work.
- **Splitting the triple axis from the mingw table does not manufacture a seed
  cut.** Both are compiler source with compiler-source consumers, so
  `make compile` bridges them. The split is therefore honest, not
  seed-taxed.

**Every migration step leaves a self-hosting compiler:** the triple axis is
introduced with identity behaviour for the host triple, so the host self-host
path is byte-identical before the Makefile target is deleted.

## 6. Alternatives considered

**Wait for SFN-57 (native MSVC seed) and delete the cross path outright.** The
status quo. It blocks Makefile deletion behind an entire multi-milestone
project (SFEP-0021 M1–M12) whose stated end state still keeps
`ci-cross-windows` alive "through Stages 1–3" as the bootstrap vehicle
(`0021:283,289`). Rejected: it inverts the dependency — the Makefile's death
should not wait on Windows's birth.

**Keep the mingw recipe in shell but shrink it.** Leaves two encodings of the
runtime substitution policy and the `RUNTIME_MODS` drift hazard the Makefile
comment itself flags. Rejected.

**Thread a `BuildTarget` value through every driver call site.** Architecturally
purer than a process cell, but a ~14-site refactor of the hottest path in the
driver with no benefit this feature needs, and no precedent. The
`test_runner_state.sfn` cell is the established answer to exactly this shape.
Deferred, not rejected — the cell's accessor is the natural future seam.

**Keep the swap table in compiler source and skip the manifest.** Simpler, and
avoids the one-seed fallback. Rejected because the table is *data about a
package*, the parser seam already exists unused, and SFEP-0006 Stage D
explicitly specifies `[targets.*]` manifest reads. Note the fallback makes the
migration cost near-zero anyway.

**Emit-once, cross-link-many (keep `build/native/raw/`).** Preserves the
current CI wall-time. Rejected: it is exactly the mechanism that gives the
cross exe Linux-selected emit legs (§2.3), and it forces the mirroring block
to survive in whatever replaces the Makefile.

## 7. Stage1 readiness mapping

- [ ] Parses — n/a (no language surface)
- [ ] Type-checks / effect-checks — driver modules only
- [ ] Emits valid `.sfn-asm` — unchanged
- [ ] Lowers to LLVM IR — target snapshot path unchanged; new triple threaded
- [ ] Regression coverage — §8
- [ ] Self-hosts — `make compile` on each phase; identity behaviour for host triple
- [ ] `sfn fmt --check` clean
- [ ] Documented in `docs/status.md` + `docs/proposals/0006-build-architecture.md` Stage D

## 8. Test plan

**Extend (unit):**
- `compiler/tests/unit/target_conditioning_test.sfn` — triple → (OS, ABI)
  decomposition; identity for every non-Windows triple; shared Windows
  replacements plus ABI-specific pthread and link results.
- `compiler/tests/unit/runtime_obj_target_identity_test.sfn` — the two Windows
  triples must produce **different** runtime-object keys.

**New (e2e):**
- `compiler/tests/e2e/target_flag_cache_key_test.sfn` — `--target` for the two
  Windows triples yields distinct artifact dirs and distinct cache keys; an
  unknown triple is rejected with a diagnostic, not silently coerced.
- `compiler/tests/e2e/cross_windows_runtime_modules_test.sfn` — a driver-native
  `--target=x86_64-w64-mingw32` build of a small capsule produces a PE
  binary; asserts the manifest target table and the compiler-source fallback
  table agree (the replacement for
  `cross_windows_runtime_modules_test.sfn`, whose Makefile-drift contract dies
  with the Makefile target).

Both e2e tests must isolate their nested build via `SAILFIN_TEST_SCRATCH` +
`clean_runner_env(nested_runner_scratch(...))` per `.claude/rules/no-bash-e2e.md`.

**Integration/CI acceptance:** `build/bin/sfn build --target=x86_64-w64-mingw32
-p compiler` produces a `sailfin.exe` that boots (`--version`, `check`) on
`windows-latest` — the same gate `windows-native-selfhost.yml`'s cross-seed
job applies today.

## 9. References

- `docs/proposals/0006-build-architecture.md` Stage D — the `--target` +
  `[targets.*]` promise (unshipped; see status note below)
- `docs/proposals/0021-windows-native-selfhost.md` §6, M12, §9 — the mingw
  retire path and the explicit note that `--target` "retires the cross hack"
- `.claude/rules/seed-dependency.md`; `docs/proposals/0026-delivery-process.md` WS-B/WS-C
- `Makefile:1113` (the promise), `:1119-1308` (`ci-cross-windows`),
  `:944` + `:1001-1097` (the staging block that exists only for it)
- `compiler/src/build/target.sfn` (SFN-52), `compiler/src/toml_parser.sfn:549,589`
- Linear: SFN-60 (final sweep), SFN-58 (mingw retire), SFN-57 (native MSVC seed)

> **Status note on SFEP-0006.** That proposal was marked `status: Implemented`
> while its Stage D exit criteria were unmet — the Makefile still exists and the
> `--target` bullet is unshipped. Per `.claude/rules/proposals.md`,
> `Implemented` requires clearing Stage1 readiness end-to-end. It has been
> demoted to `Accepted` with a "Stage D — remaining" subsection, and the
> registry row in `docs/proposals/README.md` corrected.
