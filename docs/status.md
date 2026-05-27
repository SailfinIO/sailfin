# Status

Updated: May 11, 2026 (Stage C complete through C4 migration; Stage D PR1–PR5 shipped; Stage E PR1–PR7 shipped; lowering temp-index recovery fix for #543 staged — PR1–1f / #254–#259, C2a / #261, C2b1 / #262, C2b2 / #263, C2c / #264, C4 v1 / #265, C4b / #266, C4 migration / #267, D PR1 / #268, D PR2 / #269, D PR3 / #271, D PR4 / #272, D PR5 / #273, E PR1 / #274, E PR2 / #277, E PR3 / #278, E PR4 / #280, E PR5 / #378, E PR6 / #382, E PR7 / #383; seed pinned to v0.5.10-alpha.13)

This document tracks what works today and what is in progress. It is the source
of truth — consult it before editing docs, examples, or making claims about
feature availability.

## Build Pipeline (Current)

- **LLVM lowering temp-index recovery fix (#543, 2026-05-11).**
  `coerce_operand_to_type` and `harmonise_operands` now recover
  returned SSA temp counters by scanning emitted `%tN` definitions on
  every exit path, including diagnostic/null-operand returns. The
  recovery scan is shared by statement, assignment, condition, and
  operand lowering paths so cross-module ABI-width corruption cannot
  leave callers with stale `temp_index` values during the numeric
  migration.
- `<seed> build -p compiler` is the sole build driver for the compiler's
  self-build. The Sailfin-native driver (in `compiler/src/cli_main.sfn` +
  `compiler/src/capsule_resolver.sfn`) walks the binary capsule's
  `src/`, stages every transitive import as an
  `.sfn-asm` artifact, and invokes per-module emit subprocesses against
  the resolver's parallel xargs fan-out. The prior `scripts/build.sh`
  orchestrator was retired in Stage E PR7 (#383) — fresh-clone
  bootstrap is now `install.sh && sfn build -p compiler` per
  `docs/proposals/build-architecture.md` Stage D exit criteria.
- End-user `sfn build` and `sfn run` resolve every dependency through one
  unified resolver in `compiler/src/capsule_resolver.sfn`
  (`prepare_project_capsules`). The resolver combines three paths in one
  pass: (1) relative imports walked from the entry, (2) manifest-declared
  `[dependencies]`, (3) **workspace-implicit** imports — any `sfn/X`
  reference the source uses without declaring, resolved against the
  workspace.toml member list. The textual `inline_imports_for_source`
  fallback in `sfn run` is gone (Stage B PR1).
- `sfn build -p <capsule-path>` builds a capsule by manifest path. Reads
  `[build].kind`: `"library"` (default for stdlib capsules) emits a `.o`
  via `clang -c`; `"binary"` links an executable; `"runtime"` errors as a
  Stage F deferral.
- **`sfn check` runs through the unified resolver** as of A2: a single
  `prepare_project_capsules_for_check` pass stages every dep's
  `.sfn-asm` artifact, `typecheck_import_loader.sfn` converts those
  artifacts into AST interface declarations, and
  `check_source_with_imports` feeds them to
  `typecheck_diagnostics_with_imports`. Cross-module `implements`
  conformance (E0301) is now live for end users without any textual
  import inlining — covered by
  `compiler/tests/e2e/test_check_cross_module_conformance.sh`.
- **Diagnostic infrastructure Phase 1** (A3): the `Diagnostic` struct
  now carries `severity` ("error" | "warning" | "hint" | "info") and
  `file_path`; the renderer reads both from the struct rather than
  hand-threaded parameters. Import-context load warnings (`W0001`
  missing artifact, `W0002` parse failure) flow through the same
  `render_diagnostic` pipeline as typecheck and effect errors,
  unblocking the upcoming `--json` output flag and `sfn lsp`. Phase 2
  (`secondary` source locations + `FixSuggestion`/`TextEdit` for
  `sfn fix`) lands later.
- **`sfn test` runs through the unified resolver** (Stage B PR2,
  shipped 2026-04-26). `handle_test_command` partitions discovered
  test files by `(project_root, workspace_root)`, invokes
  `prepare_project_capsules_for_test` once per group to stage
  `.sfn-asm` import-context AND compile each capsule dependency to
  its own `.ll`, then per-test routes typecheck through
  `compile_tests_to_llvm_file_with_module_imports` and link through
  `_clang_link_test_cmd_with_deps` — same shape `cli_check.sfn`
  adopted in A2. Test sources lower with `mangle_symbols=true`; the
  inline harness in
  `lower_to_llvm_lines_with_parsed_context_for_tests` appends the
  test module's `__<module_suffix>` to each `test:` symbol so
  harness call sites match the mangled definition.
  The textual import inliner (`_inline_relative_imports_cmd`,
  `inline_imports_for_source`, the test-specific writer chain) is
  gone — A4 of Track A in `docs/proposals/check-architecture.md` is
  complete. **`llvm-objcopy --weaken native.linked.o` retired
  (Stage B PR3, 2026-04-28).** Empirical investigation showed the
  weak-object backstop was masking a trailing-slash bug in
  `_collect_test_files_cmd`, not providing genuinely missing
  symbols; a one-line `_strip_trailing_slashes_cmd` call (mirroring
  the Phase 5a fix to `_collect_sfn_files_cmd`) lets the resolver
  produce the full closure of dep `.ll` files, and the 47-line
  weaken block + 25-line `_resolve_llvm_objcopy_cmd` helper +
  `cross_module_shim.o` push all delete. `sfn/compiler-lib`
  extraction is reframed as a Stage G concern, not a Stage B
  blocker. **Stage B is fully closed.**
- **Stage C cache milestone shipped (PR1–1f, #254–#259, 2026-04-28).**
  Six PRs deliver an end-to-end content-addressed build cache that
  every `sfn build` / `sfn run` honours by default:
  - **PR1 (#254)** — `compiler/src/build_cache.sfn` foundation:
    `cache_key_for(source, deps, version, flags)` derives a
    sha256 digest sharded under `<cache_root>/<prefix>/<key>/`,
    where `<cache_root>` defaults to `build/cache/v1` and can be
    overridden via `$SAILFIN_BUILD_CACHE_DIR`;
    `cache_lookup_complete` / `cache_store` implement a
    content-addressed entry. Schema-versioned (`v1`) so a future
    key-shape change can age old entries out cleanly.
  - **PR1b (#255)** — wired into `_cr_compile_one` so each
    per-capsule module compile checks the cache before lowering
    and stores the resulting `.ll` after a fresh build.
    `SAILFIN_CACHE_TRACE=1` prints `[cache hit/miss/store]
    <slug>` per module.
  - **PR1c (#256)** — `CacheStats { hits, misses, stores,
    invalid_keys, copy_failures }` accumulated per build and
    surfaced as a single `[cache] hits=N misses=M …` summary
    line. `sfn build` gains `--no-cache`, `--clean`, and
    `--cache-trace` flags layered over the env-var defaults.
    `lookup_attempted` flag suppresses the summary on
    `--no-cache` runs (the cache was never consulted).
  - **PR1d (#257)** — same flag surface mirrored onto
    `sfn run`. Six-test e2e (`test_run_cache_flags.sh`) locks
    the build/run lockstep so future drift fails CI.
  - **PR1e (#258)** — per-source dep manifests:
    `_cr_collect_per_source_dep_manifests` replaces the
    conservative "all staged manifests" key input with the
    actual transitive imports each source reaches. An unrelated
    capsule changing busts only the modules that import it.
    Manifest interface stability propagates the invalidation
    transitively, so direct deps suffice in the key. 10–100×
    cache-hit-rate improvement on incremental builds with
    multiple capsules.
  - **PR1f (#259)** — `sfn build --json` emits a single line of
    schema-versioned JSON to stdout instead of human output.
    `compiler/src/build_report.sfn` defines the `BuildReport`
    struct and the `build_report_to_json(report)` serializer;
    `compiler/tests/e2e/test_build_json_schema.sh` (uses `jq`)
    locks every top-level field. Foundation for `sfn lsp`, the
    MCP server's structured compile feedback, CI cache-hit-rate
    gates, and future structured link errors (proposal §4.11 —
    the `diagnostics: []` slot is the forward-compat hook).
- **Stage C2 per-capsule artifact layout (in flight, 2026-04-28).**
  Three PRs land the §4.4 layout (`build/capsules/<scope>/<name>/`)
  for everything `sfn build -p` produces:
  - **C2a (#261)** — per-capsule manifest sidecar.
    `compiler/src/capsule_artifact.sfn` defines
    `CapsuleArtifactManifest` and the `schema_version: "1"`
    JSON shape; after a successful `sfn build -p` the resolver
    writes `build/capsules/<scope>/<name>/manifest.json`.
    Path-traversal hardening via `is_safe_scope_name` rejects
    malicious `[capsule].name = "../../etc"`. Locked by
    `compiler/tests/e2e/test_capsule_artifact_sidecar.sh`.
  - **C2b1 (#262)** — `-p` build outputs default to the
    canonical per-capsule paths: library obj at
    `build/capsules/<scope>/<name>/obj/mod.o`, binary at
    `build/capsules/<scope>/<name>/bin/<bin-name>`. Positional
    builds and explicit `-o` keep their existing locations.
  - **C2b2 (#263)** — dep `.ll` files migrated from the flat
    `build/sailfin/capsules/<mangled>.ll` layout into the
    per-capsule tree. Manifest-declared dep sources land at
    `build/capsules/<dep-scope>/<dep-name>/ir/<rel>.ll`;
    intra-capsule (relative-import) sources of a `-p`
    consumer with safe scope/name land under the consumer's
    own `ir/` tree. Positional builds and the compiler
    self-host (`[capsule].name = "sailfin"` is single-segment)
    keep the legacy fallback automatically. Centralised in
    `capsule_artifact.sfn::ir_path_for_slug` + the resolver's
    new `ResolverConsumer`. `BuildReport.dep_ll_paths` and the
    sidecar's `deps.ll_paths` reflect the new path strings;
    `schema_version` stays at "1" (string-array-of-paths shape
    is unchanged — only path content drifted, same precedent
    C2b1 set for `out_path`). Locked by new
    `test_capsule_ir_layout.sh` and hardened
    `test_build_json_schema.sh` /
    `test_capsule_artifact_sidecar.sh` `dep_ll_paths`
    file-exists assertions.
  - **C2c (#264)** — per-module sidecar entries.
    `CapsuleArtifactManifest.modules: [{slug, ir_path,
    cache_key}]` enumerates every dep `.ll` the build
    produced, so consumers (`sfn package` C4, `sfn lsp`,
    MCP) can iterate per-source artifacts without
    re-walking the build tree. Threaded through
    `ModuleCacheEvent.{slug, cache_key_digest}` →
    `CompileCapsuleResult.module_events` →
    `ProjectCapsuleResult.module_events` → the sidecar
    emitter. Schema stays at "1" (additive field;
    pre-C2c v1 consumers ignore it and continue
    working). `obj_path` deferred — per-module `.o`s
    aren't materialised in the per-capsule tree today
    (only the cache has them, content-addressed).
- **Stage C4 `sfn package` (#265 + this PR).**
  Sailfin-native command that produces a distributable tarball
  + sha256 sidecar + JSON manifest. Three modes:
  - **Compiler mode (no `-p`, no `--installer`):** reads
    `compiler/capsule.toml` for version, stages `bin/sailfin` +
    `bin/sfn` from `--compiler-bin` (default
    `build/native/sailfin`), tars them to
    `<out>/sailfin-native-<target>-<version>.tar.gz`. Replaces
    the standalone-compiler half of `tools/package.sh`. **C4 v1
    (#265).**
  - **User-capsule mode (`-p <path>`):** reads the C2c sidecar
    at `<path>/build/capsules/<scope>/<name>/manifest.json`,
    extracts `kind` + `out` to locate the artifact, stages
    the binary or `obj/mod.o` plus the sidecar +
    `capsule.toml` into a self-describing tarball at
    `<out>/<sanitised-name>-<target>-<version>.tar.gz`. Falls
    over with a clear error when the sidecar is missing
    (hint: `sfn build -p <path>` first). **C4 v1 (#265).**
  - **Installer mode (`--installer`, this PR):** bundles the
    compiler + `runtime/native/` + (when available) the
    pre-built prelude `.o` + (when available) the staged
    `import-context/` into `<out>/installer-<target>.tar.gz`.
    No version in the tarball name (matches the historical
    `tools/package.sh` shape consumed by `release-tag.yml` +
    `ci.yml`); manifest carries `kind = "installer"`. Mutually
    exclusive with `-p`. Replaces the second half of
    `tools/package.sh` — after this lands, every output of the
    shell script has a Sailfin-native equivalent.
  - **Manifest** is schema-versioned via
    `dist_manifest.sfn::DistManifest` (`schema_version: "1"`)
    — adds `kind` (compiler / installer / binary / library),
    `capsule`, and `tarball` fields beyond
    `tools/package.sh`'s output.
  - **Migration (landed)**: `Makefile`'s `package` /
    `ci-package` / `ci-package-installer` targets now invoke
    `sfn package` / `sfn package --installer` directly.
    `tools/package.sh` is **deleted**. The composite action
    `.github/actions/sailfin-build/action.yml` (which CI's
    `release-tag.yml` + `ci.yml` go through) keeps calling
    `make ci-package`, so the workflow surface is unchanged.
    `make ci-cross-windows` still has its own inline cross-
    compile + installer logic — Windows-target support in
    `sfn package` is a follow-up (Stage D / late-C territory,
    requires `--target` validation against host).
- **Stage D PR1 (#268, shipped).** `kind = "runtime"` capsule
  schema landed as a real, parsed manifest variant.
  `runtime/native/capsule.toml` is the first such capsule
  (`name = "sfn/runtime-native"`) declaring `c-sources`,
  `ll-sources`, `include-dirs`, `link-libs`, and a transitional
  `prelude-entry = "../prelude.sfn"`. New
  `compiler/src/runtime_capsule_resolver.sfn` exposes
  `enumerate_runtime_capsule_artifacts(workspace_root,
  dep_specs)` returning `RuntimeCapsuleArtifacts[]` with
  workspace-rooted paths. Pure foundation — no production call
  site invoked it yet.
- **Stage D PR2 (#269, shipped).** Driver-side wiring for
  `kind = "runtime"` capsule deps:
  - `compiler/capsule.toml` declares `[dependencies]
    "sfn/runtime-native" = "*"` so the resolver picks the
    runtime capsule up via the workspace's member list.
  - `ProjectCapsuleResult` gains a `runtime_capsules:
    RuntimeCapsuleArtifacts[]` field; `prepare_project_capsules`
    populates it via `enumerate_runtime_capsule_artifacts`
    filtered by the project's manifest deps.
    `ResolverDedupeResult` carries the new `manifest_dep_specs`
    + `workspace_root` so the lookup happens once per
    resolution pass.
  - New `_clang_compile_runtime_capsule_objects` helper
    iterates declarative `c-sources` / `ll-sources` /
    `include-dirs` / `link-libs` from each artifact, compiles
    cached `.o` outputs, and threads `link-libs` into the
    final clang invocation. `_clang_link_multi_with_opt` (and
    its public wrappers) gain a `runtime_capsules` parameter:
    when non-empty, the new path runs; when empty, the legacy
    hardcoded `runtime_root/native/...` lookup stays
    load-bearing for end-user `sfn build` (which doesn't
    declare a runtime dep).
  - `enumerate_capsule_sources` skips `kind = "runtime"`
    workspace members so the legacy `_cr_locate_capsule_src`
    lookup doesn't false-positive on runtime capsule names
    and emit "could not locate source" diagnostics.
  - The (since-retired) `scripts/build.sh` orchestrator gained a
    transitional one-line bridge to skip the `sfn/runtime-native`
    dep when iterating `[dependencies]` (it lived at
    `runtime/native/`, not `capsules/sfn/runtime-native/`). The
    script retired as a load-bearing path in Stage D PR4 (when
    `make compile` flipped over to `<seed> build -p compiler`)
    and was deleted from the tree in Stage E PR7 (#383); this
    entry is preserved as historical context.
  - **Verification gap intentional.** `sfn build -p compiler`
    runs through every new code path and produces a partial
    binary, but the link line is missing the compiler's CLI
    modules (cli_main.sfn, capsule_resolver.sfn, etc.) because
    `compiler/src/main.sfn`'s transitive import graph doesn't
    cover them — the formerly-load-bearing `scripts/build.sh`
    walked `compiler/src/**/*.sfn` directly, while the resolver
    only walks reachable imports. Closing this gap (a
    binary-capsule `src/` walker for `kind = "binary"` projects)
    is the Stage D PR3 scope. `make compile` (then on the
    retired build.sh path, historical) was unchanged for the
    duration of Stage D PR2 and remained the active bootstrap.
- **Stage D PR3 (#271, shipped).** `sfn build -p compiler`
  produces a working compiler binary. Two changes work together:
  - **Binary-capsule `src/` walker.** `ResolverConsumer` gains
    a `walk_project_src` field (false by default). When
    `cli_main.sfn` resolves `-p` to a `kind = "binary"`
    capsule, it sets the field true and the resolver runs
    `enumerate_binary_capsule_sources(project_root, entry)` —
    a BFS over `<project_root>/src/**/*.sfn` mirroring
    `_cr_collect_capsule_sources` — to surface every module the
    `[build] entry` doesn't transitively import. Slugs come
    from `_cr_relative_slug` so any module the entry DOES reach
    dedupe-collapses cleanly with the relative-import walker.
  - **Subprocess-per-module compile (mirrors the historical
    `scripts/build.sh` shape, since retired).** Without
    isolation the resolver's in-process compile loop
    (138 modules in one arena) OOMed around the 135th module on
    8 GB. `_cr_compile_one` now shells out to `<sailfin_exe>
    emit --module-name <slug> -o <ll> llvm <src>` when
    `cli_main.sfn` threads `binary_dir + "/sailfin"` through.
    A new `--module-name` flag on `sfn emit` carries the slug
    so cross-capsule deps (slug `<scope>/<name>/<sub>`, NOT
    what `module_name_from_path` derives) mangle their symbols
    identically to the in-process path. Empty `sailfin_exe`
    falls back to in-process compile so `sfn check` and
    `sfn test` (which don't yet plumb `binary_dir`) keep their
    existing behavior.
  - **Result.** Cold-start `sfn build --clean -p compiler`
    succeeds in ~6.5 minutes (sequential subprocess; the
    historical `build.sh` parallelized with `--jobs 4` so the
    ~2-minute target lands once Stage D PR4 flips `make compile`
    over and the resolver grows job parallelism). The produced binary runs
    `examples/basics/hello-world.sfn` and self-builds again
    (cache hits = 135/136 on the second pass).
  - **Test coverage.** New `test_binary_capsule_walker.sh`
    builds a `kind = "binary"` fixture with an unimported
    sibling module and asserts the walker enumerates it,
    while a positional `sfn build src/main.sfn` does NOT.
    Full suite stays at 80 unit / 17 integration passing;
    the pre-existing `test_check_compiler_src.sh` flake is
    independent (reproduces on the PR2 baseline too).
- **Stage D PR4 (#272, shipped).** `make compile` /
  `make rebuild` cutover. `.seed-version` bumped to
  `0.5.10-alpha.4` (the first release shipping PR1–PR3, so the
  fetched seed is itself capable of building the compiler via
  `sfn build -p compiler`). The Makefile's `rebuild` target
  drops the formerly-load-bearing `bash scripts/build.sh` from
  the default path in favour of `<seed> build -p compiler`, then
  copies `build/sailfin/program` to `build/native/sailfin` and
  writes `build/native/.build-stamp` with the same
  `<version>+dev.<hash>[.dirty]` shape the prior build.sh
  produced. Behaviour notes: (a) `BUILD_JOBS` no longer plumbs
  through the driver — the driver parallelises subprocess emits
  internally; (b) `NATIVE_OPT` / `SELFHOST1_OPT` no longer
  affect `make rebuild` — the driver hardcodes `-O2`.
  At this point in history `make check`'s stage2/stage3
  invocations still used the prior build.sh and still honoured
  `OPT`, so the fixed-point comparison stayed apples-to-apples;
  Stage E PR3 later flipped them onto the driver's `--work-dir`
  flag. Two transitional workarounds shipped
  alongside the cutover (kept until alpha.5 makes them
  redundant): pre-staging `main.sfn-asm` outside the resolver
  because alpha.4's binary-capsule walker excluded the entry,
  and a `build/.shim/llvm-as → llvm-as-18` symlink so the
  alpha.4 seed's IR validator could find a parser on Ubuntu's
  versioned-only llvm-18 install.
- **Stage D PR5 (#273, shipped).** Cleanup. `.seed-version`
  bumps to `0.5.10-alpha.5` — the first release including PR4's
  source-side fixes:
  - The validator cascade in `_cr_compile_one` (`llvm-as` →
    `llvm-as-18` → `clang -c -emit-llvm` → `clang-18`) replaces
    the alpha.4 seed's `llvm-as`-only validator that fell
    through to "validator missing, accept the IR" on systems
    without the unversioned llvm-as symlink.
  - `prepare_project_capsules` now stages the entry's
    `.sfn-asm` separately when `walk_project_src` is on, so
    sibling modules importing from the entry can find its
    interface declarations. Was missing in alpha.4.
  With both fixes in the seed itself, the Makefile's PR4
  workarounds (the llvm-as shim + the entry pre-stage step)
  retire. At this historical point the formerly-load-bearing
  prior `bash scripts/build.sh` fallback still survived —
  cold builds of the 138-module compiler still peaked above 8 GB
  virtual-memory at the resolver level (the parent process's
  in-process state plus per-module subprocess overhead exceeded
  budget on the 8 GB ulimit CI used), so when the seed bailed
  silently before producing `build/sailfin/program`, the
  fallback historically ran the prior build.sh to keep CI
  green. The fallback retired in Stage E PR2 once the
  subprocess-stage import-context (Stage E PR1) brought peak
  memory under budget.
- **Stage E PR1 (#274, shipped).** Subprocess-stage import-
  context. `_cr_stage_one` and `stage_capsule_imports` gain a
  `sailfin_exe` parameter that, when non-empty, shells the heavy
  `write_native_text_file_with_module` work out to a fresh
  subprocess (`<sailfin> emit --module-name <slug> -o <asm>
  native <src>` — flags before mode, matching `cli_main.sfn`'s
  emit parser). Mirrors the PR3 subprocess-per-module compile
  shape. The parent's arena no longer accumulates 138 modules'
  worth of AST + IR text — verified by self-hosting the new
  compiler under the 8 GB ulimit, which prior to this PR had to
  fall back to the historical `bash scripts/build.sh`. Empty
  `sailfin_exe` preserves the in-process path that `sfn check`
  and `sfn test` callers use; `prepare_project_capsules` (the
  build/run path) threads the resolved binary path through. The
  Makefile's prior `bash scripts/build.sh` fallback survived
  alongside this PR until alpha.6 cut.
- **Stage E PR2 (#277, shipped).** Pin alpha.6 + retire the
  prior build.sh fallback. `.seed-version` bumped to
  `0.5.10-alpha.6`, the first release including PR1's
  subprocess-stage import-context. With that fix in the seed
  itself, cold builds of the 138-module compiler fit in the
  8 GB virtual-memory cap that CI runners and
  `compiler-safety.md` enforce. The fallback block in `make
  rebuild` (which historically dropped to `bash scripts/build.sh`
  when `<seed> build -p compiler` bailed silently) is gone —
  `<seed> build -p compiler` is the only path now.
  At this historical point `scripts/build.sh` itself stayed
  in-tree for `make check`'s stage2/stage3 fixed-point
  comparison (which still needed `WORK_DIR` control the driver
  didn't yet expose) and as an emergency seed-bootstrap escape
  hatch; both consumers retired in Stage E PR6 (#382) and the
  script itself was deleted in Stage E PR7 (#383).
- **Stage E PR3 (#278, shipped).** Parallel-emit fan-out.
  `_cr_run_parallel_emit` writes three newline-delimited lines
  per task (`slug`, `output`, `source`) to a `mktemp`-allocated
  file, then pipes the file through `tr '\n' '\0'` into
  `xargs -0 -P N -n 3 sh -c '...'` so `N = _cr_resolve_jobs()`
  workers run concurrently. The `tr` step converts the
  newline-delimited file into NUL-delimited input that POSIX
  xargs consumes via `-0`; the GNU-only `-d '\n'` flag isn't
  used because BSD xargs (macOS CI) doesn't support it.
  `_cr_resolve_jobs` reads `SAILFIN_BUILD_JOBS` first, falls
  back to `nproc` (clamped to `[1, 8]` for system-memory
  safety: 8 workers × ~500 MB arena each ≈ 4 GB peak total
  across parent + workers, well under the 8 GB ulimit).
  Each parallel worker runs the same retry + IR-validation
  cascade the serial `_cr_compile_one` does (up to 3 attempts;
  `llvm-as` → `llvm-as-18` → `clang -c -emit-llvm` →
  `clang-18` for `llvm` mode; native mode skips validation),
  inlined into the per-task shell script. Cache stores happen
  AFTER the worker exits 0, so a corrupted-IR retry can't
  poison the cache.
  `stage_capsule_imports` and `compile_capsule_modules`
  partition into cache-hit and needs-emit subsets in a
  sequential pass, batch the needs-emit set into one xargs
  run, then sequentially extract layout manifests / store
  cache entries. Mirrors the historical `scripts/build.sh`'s
  `xargs -P "$JOBS"` pattern (formerly at `build.sh:819` for
  staging, formerly at `build.sh:853` for compile) so end users
  see the same parallelism shape that prior build.sh
  historically gave
  them.
  Performance: cold `sfn build -p compiler` measured at
  **2m27s** with the new parallel resolver on a 4-core box,
  down from **6m07s** sequential. That's a 2.5× speedup,
  matching the prior `scripts/build.sh --jobs 4`'s historical
  wall time.
  The 8 GB ulimit still holds *per worker process* — each
  subprocess gets its own arena, so any one worker stays
  bounded and the parent's own peak memory doesn't materially
  scale with parallelism. Total system memory does rise with
  the worker count, so higher `SAILFIN_BUILD_JOBS` values
  trade memory for wall time. `SAILFIN_BUILD_JOBS=1` keeps
  the pre-PR3 sequential path available as a
  regression-bisect escape hatch.
  Empty `sailfin_exe` (sfn check, sfn test) keeps the
  in-process emit path; parallelism only engages when the
  caller threads `binary_dir` through. Single-source builds
  also stay sequential — the xargs overhead would dominate.
- **Stage E PR4 (#280, shipped).** `ci-cross-windows`
  modernization. With the prior build.sh fallback retired in
  PR2 + the alpha.7 seed pinned with the parallel resolver, the
  legacy `build/selfhost/native/raw/` and
  `build/selfhost/native/seed_cwd/` paths in
  `ci-prepare-test-artifacts` and `ci-cross-windows` were dead
  on the rebuild flow. Both targets collapsed to the single
  sfn-build layout: `ci-prepare-test-artifacts` reduces to a
  presence check on `build/native/import-context/` +
  `build/native/obj/runtime/prelude.o`, and
  `ci-cross-windows` reads exclusively from
  `build/native/raw/` (mirrored by `make rebuild` so the test
  suite can't clobber it). `.seed-version` bumped to
  `0.5.10-alpha.7`. At this historical point `scripts/build.sh`
  was the last surviving consumer in-tree, kept only for
  `make check`'s stage2/stage3 fixed-point comparison while the
  driver lacked multi-output WORK_DIR control.
- **Stage E PR5 — Driver `--work-dir` flag (#378, shipped).**
  Adds `sfn build --work-dir <DIR>`, virtualising
  `<DIR>/native/import-context/` and the default
  `<DIR>/native/sailfin` output. This is the prerequisite for
  the `make check` cutover.
- **Stage E PR6 — `make check` stage2/stage3 driver flip (#382,
  shipped).** Replaces the historical `bash scripts/build.sh`
  invocations in `make check` with `sfn build -p compiler
  --work-dir build/selfhost/native-{seedcheck,stage3}` calls
  using `SAILFIN_TEST_SCRATCH` per-stage isolation +
  `--no-cache`. The fixed-point hash-diff stays load-bearing.
- **Stage E PR7 — prior build.sh orchestrator retired (#383,
  this PR).** Deleted the retired `scripts/build.sh`. With
  both consumers retired (rebuild fallback in PR2, `make check`
  in PR6), the
  script was deleted outright and every Makefile / status /
  build-performance reference was updated to mark the file as
  retired. Fresh-clone bootstrap is now
  `install.sh && sfn build -p compiler` per
  `docs/proposals/build-architecture.md` Stage D exit criteria.
- `make compile` builds the compiler from a released seed. `make check`
  validates the seedcheck binary can run `hello-world.sfn` and pass the test suite.
- **Deterministic self-hosting**: the compiler is a verified fixed point —
  stage2 and stage3 produce byte-identical LLVM IR across all modules.
  `make check` enforces this.
- The legacy Python fixup script (`selfhost_native.py`) was removed after the
  compiler reached clean LLVM IR output (v0.5.0-alpha.22+).

## Compiler Pipeline (Current)

- The self-hosted native compiler in `compiler/src/` is the primary toolchain;
  `make compile` produces `build/native/sailfin`.
- Pipeline: Lexer → Parser → Type Checker → Native Emitter
  (`.sfn-asm` IR) → LLVM Lowering.
- **Effect checker status**: `validate_effects()` is invoked from every
  `compile_to_*` entry point in `main.sfn` and **fails the build by
  default** on undeclared effects (Phases B/C/D — shipped 2026-04-26;
  see below). The `SAILFIN_EFFECT_ENFORCE` env var lets capsule
  authors opt into the pre-Phase-D modes: unset / `=error` is the
  enforced default; `=warning` keeps the gate as a non-blocking
  warning (transitional mode); `=off` skips validation entirely
  (build-path only — `sfn check` still runs validation per
  proposal §4.7). Tracked by `docs/proposals/effect-validation.md`
  (Phases A–G; Phases A/B/C/D landed 2026-04-26).
- **Effect diagnostic source spans (Phase A — shipped 2026-04-26).** The
  `EffectViolation` struct now carries `signature_token`, `trigger`, and
  `severity` slots, populated from `FunctionSignature.name_span` via
  `_token_from_signature` in `effect_checker.sfn`. The renderer in
  `tools/check.sfn` reads `violation.trigger` into `Diagnostic.primary`,
  so effect diagnostics now render with `--> file:line:column` and a
  caret pointing at the function declaration — matching typecheck output
  shape. New `compiler/src/effect_taxonomy.sfn` exports the locked-in
  canonical effect set (`canonical_effects()` returns `["clock", "gpu",
  "io", "model", "net", "rand"]`) as the authoritative 1.0 list. The
  taxonomy module is the regression-test anchor and the future home for
  every effect-name decision; wiring `effect_checker.sfn` and
  `tools/check.sfn` to consume it (e.g. rejecting unknown effect names
  in `analyze_routine`, sorting `missing_effects` for deterministic
  rendering) lands later in Phase G alongside the name-resolution
  detector. Per-expression trigger tokens were threaded into the AST
  in Track B PR1 (B1, see below); the renderer now carets effect
  diagnostics at the offending call site rather than the routine
  declaration.
- **Effect diagnostic per-call-site carets (Track B PR1 / B1 —
  shipped 2026-04-26).** `Expression.Identifier`, `Expression.Member`,
  and `Expression.Call` now carry an optional `span: SourceSpan?`
  populated by the parser at every construction site.
  `EffectRequirement` gained a `trigger: Token?` slot; the body walker
  in `collect_effects_from_expression` populates it from the namespace
  identifier (`fs` / `print` / `http` / `console` / `websocket`) or
  the bare-callee identifier (`spawn` / `sleep` / `serve`) so each
  per-effect requirement remembers where it came from. `analyze_routine`
  picks the first non-null trigger from the missing-requirements list
  as the violation's `trigger`; the synthesized signature_token stays
  as the fallback for the residual text-pattern (`Raw`-body) path,
  decorator-implied effects, and synthesized expressions. End-to-end
  result: a long routine with one effectful call deep in the body now
  carets the diagnostic at that call (`--> file:N:M`) rather than the
  signature line. Coverage: 6 new B1 unit tests in
  `compiler/tests/unit/effect_checker_test.sfn` (16 total) plus
  `compiler/tests/e2e/test_check_effect_call_site_caret.sh` (4 e2e
  cases). Tracked by `docs/proposals/check-architecture.md` Track B.
- **Effect validation as build gate (Phases B/C/D — shipped 2026-04-26).**
  `validate_and_render_effects` (in `compiler/src/effect_gate.sfn`)
  runs after typecheck in every `compile_to_*` entry point. The
  rendering surface from `tools/check.sfn` extracted into
  `compiler/src/diagnostics_render.sfn` so the build path and
  `sfn check` share one source of truth — diagnostic shape, severity
  selection, and caret rendering match across both surfaces. Severity
  is resolved from `SAILFIN_EFFECT_ENFORCE` via
  `resolve_effect_enforcement`; the env-var read uses a
  `process.run`-based shell helper because the 0.5.x seed compiler
  has a known runtime-helper-collection bug for the `env.get`
  intrinsic (it emits the call but not the LLVM `declare`). Each
  build worker derives a process-unique tmp path from its file_path
  to avoid races on `make compile -j4`. Off-mode emits a one-line
  stderr notice per file so contributors can see the gate was
  consciously bypassed.

  Phase C audited the in-tree compiler under warning mode and added
  `![io]` to the 11 functions that legitimately emit `print.err`
  debug traces (lexer/parser entry points and lowering helpers).
  Phase D flipped the unset env-var default from `warning` to
  `error`, so unannotated effect usage now fails `make compile`,
  `sfn build`, `sfn run`, `sfn test`, and `sfn check` by default.
  All `examples/*.sfn` build cleanly under the new default. Capsule
  authors who need to migrate gradually can opt into
  `SAILFIN_EFFECT_ENFORCE=warning` for telemetry-only mode.
- **Cross-module effect propagation (Phase E — shipped 2026-04-26).**
  When a caller invokes an `Identifier` that resolves to an imported
  function with declared effects, `validate_effects_with_imports`
  promotes the call into a per-call effect requirement and emits
  `E0402` (cross-module) instead of the in-module `E0400` if the
  caller's signature doesn't propagate the effect. The new
  `compiler/src/effect_imports.sfn` module owns the
  `ImportSymbolTable` data shape; the loader
  (`typecheck_import_loader.sfn`) populates it as a side-channel of
  the same `.sfn-asm` artifact read that already produces the
  `Statement.InterfaceDeclaration` list. `tools/check.sfn`,
  `effect_gate.sfn`, `cli_check.sfn`, and `cli_commands.sfn` thread
  the table through to every analysis surface.

  Alias resolution: `import { foo as bar } from "..."` registers
  `bar` in the localized table with `foo`'s effect set, so the AST
  walker sees `Call(Identifier("bar"))` and resolves correctly. The
  scope filter in `localize_import_symbols_for_program` ensures a
  same-named in-module function never picks up a global table
  entry's effects. E1 covers direct `Identifier` callees;
  `Member`-callee resolution (`mod.fn()`) and decorator-implied
  transitives are deferred to a follow-up Phase E2.
- **Capsule capability cross-check (Phase F — shipped 2026-04-26).**
  The capsule manifest's `[capabilities] required = [...]` list is
  now a real compile-time contract. Any function declaring an
  effect outside the manifest's allowed surface fails with
  diagnostic code `E0403` ("declares effect ![X] outside capsule
  capability surface ![A, B, ...]"). Empty surface (no
  `[capabilities]` section, or standalone .sfn outside any capsule)
  degrades the check to a no-op, so pre-Phase-F projects keep
  building.

  Plumbing: `toml_get_capabilities_required` parses the manifest;
  `capsule_resolver.sfn` exposes `capabilities_required: string[]`
  on `CheckCapsuleResolution` and `TestCapsuleResolution`;
  `effect_checker.validate_capsule_capabilities` does the cross-
  check; `diagnostics_render.capability_violation_to_diagnostic`
  emits the diagnostic with a fix-it hint suggesting either widening
  the manifest or narrowing the function. `effect_gate.sfn` exposes
  `validate_and_render_effects_with_capabilities` so build-path
  callers (`compile_tests_to_llvm_file_with_module_imports`) and
  the `sfn check` path render E0400/E0401/E0402/E0403 through the
  same severity contract.

  Audit: `compiler/capsule.toml` widened from `["io"]` to
  `["io", "clock"]` so `compile_to_llvm_with_module_timed`'s
  `![io, clock]` declaration (used by `sfn emit llvm --timing`)
  fits the surface. All `capsules/sfn/*/capsule.toml` manifests
  were already correct against their declared effects — no
  changes needed.
- Experimental LLVM JIT execution is available for targeted backend coverage.
- CI uses the native build workflow (`.github/workflows/ci.yml`) to build, test,
  and attach release assets.
- Native compiler tests live in `compiler/tests/{unit,integration,e2e}` and run
  via `sfn test` or `make test-unit`, `make test-integration`, `make test-e2e`.

## Feature Matrix

| Feature | Status | Notes |
|---|---|---|
| `let` / `let mut` variables | Shipped | Type annotations optional; limited inference |
| Functions (`fn`) | Shipped | Including generics, default params, decorators |
| `async fn` | Parsed | `await` is **not** parsed; async is structural only |
| Structs | Shipped | Including generic params, `implements` clause |
| Interfaces | Shipped | Trait-style method signatures |
| Enums / ADTs | Shipped | Variants with payloads |
| Type aliases | Shipped | Including generic params |
| `if`/`else` | Shipped | |
| `for` loops | Shipped | |
| `loop { … }` / `break` / `continue` | Shipped | The infinite-loop primitive — `while` is intentionally not a keyword; `compiler/src/parser/statements.sfn` rejects it at statement position so users get `E0411` with a `loop`/`break` fix-it instead of silent misparse |
| `match` | Shipped | Literals, `_` wildcard, guards; destructuring enum variants |
| `try`/`catch`/`finally` | Shipped | Maps to runtime exceptions |
| String interpolation (`{{ }}`) | Shipped | |
| Pattern matching exhaustiveness | Partial | Runtime backstop via `match_exhaustive_failed` |
| Effect annotations (`![...]`) | Shipped | Parsing and declaration |
| Effect enforcement — `io` | **Enforced** | Checker detects `print.*`, `console.*`, `fs.*`, `@logExecution`; build fails on undeclared usage by default (Phase D shipped 2026-04-26) |
| Effect enforcement — `net` | **Enforced** | Checker detects `http.*`, `websocket.*`, `serve`; build fails on undeclared usage by default |
| Effect enforcement — `model` | Reserved | Declarable; effect-checker has no detector yet. The `sfn/ai` capsule (post-1.0) supplies the call sites Phase G's name-resolution detector will key on |
| Effect enforcement — `clock` | **Enforced** | Checker detects `sleep` / `runtime.sleep`; build fails on undeclared usage by default |
| Effect enforcement — `gpu`, `rand` | Parsed only | Reserved at 1.0 in the canonical taxonomy; no detector logic yet |
| Effect enforcement as compilation gate | **Shipped (Phase D, 2026-04-26)** | `validate_and_render_effects` runs after typecheck in every `compile_to_*` entry; default severity is `error` so undeclared effects fail the build. `SAILFIN_EFFECT_ENFORCE=warning` opt-in for capsule authors mid-migration; `=off` build-path escape hatch (proposal §4.7) |
| Cross-module effect propagation | **Shipped (Phase E, 2026-04-26)** | A caller of an imported function inherits the callee's declared effects; missing propagation fails the build with `E0402`. Aliased imports (`import { foo as bar }`) resolve under the local name. E1 covers direct `Identifier` calls; `Member`-callee resolution and decorator-implied transitives deferred to Phase E2 |
| Capsule capability cross-check | **Shipped (Phase F, 2026-04-26)** | `[capabilities] required = [...]` in `capsule.toml` is a real compile-time contract; functions declaring an effect outside the surface fail with `E0403`. Empty surface skips the check (standalone .sfn unchanged). Phase G (post-1.0) replaces the text-pattern checker with name-resolution detection and adds effect polymorphism |
| Generic type inference | Partial | Type params captured; inference coverage is limited |
| Interface conformance validation | Partial | Basic checks; variance not yet enforced |
| `Affine<T>` / `Linear<T>` | Parsed only | Ownership wrappers accepted; move/consume rules not enforced |
| `&T` / `&mut T` borrows | Parsed only | Accepted syntactically; exclusivity not checked |
| `PII<T>` / `Secret<T>` | Parsed only | Parsed as nominal types; no taint enforcement |
| `model` / `prompt` / `tool` / `pipeline` blocks | **Removed** | Moved to the `sfn/ai` library capsule (post-1.0). The `![model]` effect remains as the capability gate |
| `routine { }` blocks | **Not implemented** | Not parsed |
| `await` | **Not implemented** | Not parsed |
| `channel()` concurrency | **Not implemented** | Not parsed as concurrency primitive |
| `spawn` | **Not implemented** | Not parsed |
| `\|>` pipeline operator | **Not implemented** | Planned post-1.0 expression operator (unrelated to the removed `pipeline` block) |
| Currency literals (`$0.05`) | **Not implemented** | Use numeric literal + comment |
| Time literals (`1s`, `150ms`) | **Not implemented** | Use numeric literals |
| `scope.with_timeout(...)` | **Not implemented** | |
| `unsafe` / `extern` | Parsed only | Syntax accepted; enforcement not active |
| Policy decorators (`@policy(...)`) | Parsed only | No compiler or runtime effect |
| `sfn fmt` (formatter) | **Shipped** | Token-stream formatter: indentation, spacing, inline blocks, unary operator handling, import sorting & specifier reordering, blank line normalization, `--check`/`--write` modes, CI enforcement; see `docs/proposals/fmt-architecture.md` for architecture and known limitations |
| `sfn check` (fast analysis) | **Shipped (v1 + Track B B1/B2/B3/B4 + Phase 5a)** | Runs parse + typecheck + effect-check on `.sfn` sources without emitting IR or invoking `clang`. Reports diagnostics to stderr with a summary on stdout. Exits non-zero on findings. Cross-module `implements` conformance live via the unified resolver (A2). Diagnostics carry `severity` and `file_path` and route load warnings (`W0001`/`W0002`) through the same renderer as errors (A3). Effect violations caret at the offending call site, not the function declaration (B1). `--json` emits the `sailfin-check/1` envelope (flat events array + summary) — schema documented at `docs/reference/check-json-schema.md`, locked by `compiler/tests/e2e/test_check_json_schema.sh`, and consumed by the MCP server's `sailfin_diagnostics` tool (B2). E0400/E0401/E0402 effect diagnostics now carry a structured `FixSuggestion` with a `TextEdit` that splices `![effects] ` in at the function body's opening brace — `sfn fix` and the upcoming LSP code-action handler consume the structured edit directly (B3). The build path (`sfn run`/`sfn build`/`sfn test`) now emits the same `error[Exxxx]: --> file:line:col` shape as `sfn check` — the legacy `[typecheck]`-prefixed renderer in `main.sfn` is gone (~150 lines deleted) and every `compile_to_*` entry routes through `diagnostics_render.render_diagnostic` (B4). Directory-mode checks (`sfn check compiler/src/`) now reclaim arena scratch between iterations via `sailfin_intrinsic_runtime_arena_mark` / `..._rewind`, so the full 132-file compiler tree completes in ~130 s under `SAILFIN_USE_ARENA=1` instead of SIGSEGVing at ~120 s — see `docs/proposals/phase-5a-arena-reset.md` and `docs/build-performance.md` Phase 5a. |
| `sfn vet` (static analyzer) | Planned | Pre-1.0; see `docs/proposals/tooling.md` |
| `sfn lsp` (language server) | Planned | Phase 1 pre-1.0; see `docs/proposals/tooling.md` |
| `sfn doc` (doc generator) | Planned | 1.0; see `docs/proposals/tooling.md` |
| `sfn fix` (auto-rewriter) | Planned | 1.0; see `docs/proposals/tooling.md` |
| Notebook support | Not started | Post-1.0 |
| Package registry (`sfn init/add/publish`) | Shipped | CLI commands implemented; default registry at `pkg.sfn.dev`; configurable via `sfn config set registry <url>` or `SFN_REGISTRY` env var |

## Print API (Current)

- `print(value)` is the canonical output builtin (stdout, no prefix).
- `print.err(value)` writes to stderr.
- `print.info`/`print.warn`/`print.error` are deprecated legacy variants kept for
  backward compatibility; new code should use `print()` and `print.err()`.
- The `sfn/log` capsule provides structured logging (`log.info`, `log.warn`,
  `log.error`, `log.debug`) with named loggers and fields. `log.warn` and
  `log.error` route to stderr via `print.err()`.

## Standard Library Capsules (Current)

The following capsules ship as part of the Sailfin standard library under
`capsules/sfn/`. Users import them by bare name (e.g. `from "fmt"`).

| Capsule | Import | Status | Effects | Description |
|---------|--------|--------|---------|-------------|
| `sfn/fmt` | `"fmt"` | Shipped | None | String formatting, trim, case conversion, split/join |
| `sfn/json` | `"json"` | Shipped | None | JSON parsing, serialization, pretty-print |
| `sfn/crypto` | `"crypto"` | Shipped | None | SHA-256, base64 encode (via C runtime) |
| `sfn/math` | `"math"` | Shipped | None | abs, min/max, clamp, floor/ceil/round, pow, sum/mean |
| `sfn/path` | `"path"` | Shipped | None | Path join, dirname, basename, ext, normalize |
| `sfn/toml` | `"toml"` | Shipped | None | TOML v1.0 parsing, serialization, dotted-path access |
| `sfn/fs` | `"fs"` | Shipped | `io` | File read/write/append, exists, mkdir, read_dir, set_perms, get_perms, mkdtemp, is_executable, symlink |
| `sfn/os` | `"os"` | Shipped | `io` | Env vars, home dir, exec, exit |
| `sfn/log` | `"log"` | Shipped | `io`, `clock` | Structured leveled logging with named loggers |
| `sfn/time` | `"time"` | Shipped | `clock` | Sleep, monotonic timing, elapsed |
| `sfn/http` | `"http"` | Partial | `net`, `io` | GET/POST client (via C runtime); server stubbed |
| `sfn/sync` | `"sync"` | Stubbed | `io` | channel/parallel/spawn API (pending concurrency runtime) |
| `sfn/net` | `"net"` | Stubbed | `net`, `io` | TCP/UDP socket API (pending runtime intrinsics) |
| `sfn/tensor` | `"tensor"` | Shipped (CPU) | `gpu` (planned) | Tensor ops, matmul, transpose; GPU dispatch not yet implemented |
| `sfn/layers` | `"layers"` | Shipped (CPU) | `gpu` (planned) | Linear layers, ReLU, sequential models |
| `sfn/nn` | `"nn"` | Shipped (CPU) | `gpu` (planned) | Activations, normalization, argmax, one_hot |
| `sfn/losses` | `"losses"` | Shipped | None | MSE, MAE, Huber, hinge loss functions |
| `sfn/cli` | `"cli"` | Shipped | `io` | CLI arg parsing, subcommands, help generation, terminal styling |

## Runtime (Current)

- The binary's entry point is the Sailfin-emitted `@main` (M5, #451;
  shipped 2026-05-25); the compiler-emitted prologue resolves the runtime
  root and dispatches the CLI. Supporting helpers — strings, arrays,
  exceptions, the C arena, crypto, the `sfn_*` C trampolines listed under
  the M2.12 audit below — still live under `runtime/native/src/` as C and
  are linked into the native compiler binary; M3 ports the rest.
- The native CLI locates a bundled runtime next to the executable (override with
  `SAILFIN_RUNTIME_ROOT`).
- Legacy Python runtime shims have been removed; the toolchain does not rely on
  `runtime/*.py` helpers.
- The native filesystem adapter supports `readFile`, `writeFile`, `appendFile`,
  `writeLines`, and directory helpers.
- **String concat optimization (`string_append`)**: The LLVM lowering emits
  `sailfin_runtime_string_append` (realloc-based in-place extend) for intermediate
  results in chained `+` concat chains instead of `sailfin_runtime_string_concat`
  (malloc+copy). This eliminates 2 dead intermediate allocations per 4-way concat
  and is estimated to reduce per-module peak memory 30-50% for string-heavy
  compilation paths. Pure lowering optimization — no user-visible syntax change.
  Implemented in `compiler/src/llvm/expression_lowering/native/core_strings.sfn`
  and `core_ops_lowering.sfn`; runtime entry point in
  `runtime/native/src/sailfin_runtime.c`.
- **The remaining C helpers will be replaced by Sailfin in M3 before 1.0.**
  The entry-point cutover already shipped in M5 (#451). M3 ports the
  ~90 ABI functions still in C (strings, arrays, I/O, exceptions, crypto,
  time, and process execution) into `runtime/sfn/*.sfn`, then deletes
  `runtime/native/`. This is a hard prerequisite for the 1.0 release.

### Runtime Migration Prerequisites

The runtime rewrite depends on compiler features that must ship first. The
[roadmap](https://sailfin.dev/roadmap) sequences these as numbered phases:

| Compiler Feature | Status | Runtime Subsystems It Unblocks |
|---|---|---|
| `extern fn` (parser + type-checker + LLVM `declare` emission) | **Shipped** (parser + emitter + typecheck registration with E0801–E0805 C-ABI validation; runtime-module LLVM call lowering against imported externs pinned by `runtime/sfn/io.sfn` — return-flow shape — and `runtime/sfn/clock.sfn` — discard-statement shape, post-#306; general typecheck call-site resolution deferred until typecheck grows a call resolver) | All — `runtime/sfn/platform/*.sfn` modules can now type-check end-to-end, and runtime service modules can start consuming them |
| First `runtime/sfn/platform/libc.sfn` skeleton (12 declarations: malloc/free/realloc/memcpy/memcmp, write/read, fopen/fclose/fread/fwrite, getenv) | **Shipped 2026-05-01** (typecheck + fmt + LLVM `declare` emission verified by `compiler/tests/e2e/test_runtime_libc_skeleton.sh`) | Confirms the extern pipeline works on a realistic file; seed for `runtime/sfn/memory.sfn`, `runtime/sfn/io.sfn`, and `runtime/sfn/adapters/filesystem.sfn` at M2 |
| First `runtime/sfn/io.sfn` Sailfin-native service wrapper (`sfn_write_fd` over `platform/libc.write`) | **Shipped 2026-05-04** (typecheck + fmt + LLVM imported-extern call lowering verified by `compiler/tests/e2e/test_runtime_io_skeleton.sh`) | Proves runtime modules can import platform extern declarations and emit direct calls without a C shim |
| Sleep migration PR 2 — Sailfin-native `@sfn_sleep` over `nanosleep` (issue #397) | **Shipped 2026-05-20**. `runtime/sfn/clock.sfn` is now the sole definition site for `@sfn_sleep`; its body calls libc `nanosleep` directly via `runtime/sfn/platform/posix.sfn` after building a `struct Timespec { tv_sec: i64, tv_nsec: i64 }` (16 bytes — matches the C `struct timespec` ABI on Linux x86_64 and macOS arm64). The pre-PR C entrypoint `sailfin_runtime_sleep` and the `sfn_sleep` C trampoline (both in `runtime/native/src/sailfin_runtime.c`), the `sailfin_runtime_sleep` import in `runtime/sfn/platform/libc.sfn`, its per-symbol descriptor in `compiler/src/llvm/runtime_helpers.sfn`, and the matching helper-preamble entry in `compiler/src/llvm/lowering/lowering_helpers.sfn` are all gone. `runtime/native/capsule.toml`'s `sfn-sources` now lists `../sfn/clock.sfn`, so the runtime-capsule link path (used by `make compile`) compiles and links the module automatically; `make rebuild` additionally stages `build/native/obj/runtime/clock.o` for the legacy `sfn run` / `sfn build` link path (`_clang_compile_runtime_objects` in `compiler/src/cli_main.sfn` returns it as `cached[4]`). **EINTR-resume restored 2026-05-26 (issue #693)** — `sfn_sleep` now wraps the `nanosleep` call in a `loop`-with-`break` capped at 32 iterations that exits on `ret == 0`. The bounded-retry shortcut trusts the return value alone (no `errno` read) because the body's `tv_nsec` clamp + non-negative `tv_sec` + stack-allocated `req` make `EINVAL` and `EFAULT` unreachable in this usage, so a non-zero return is definitionally `EINTR`. Re-passing the same `req` each iteration slightly over-sleeps under a signal but preserves the wall-clock-≥-requested correctness contract. The strict-errno path and the `clock_gettime` adapter (which needs to read back the `tv_sec`/`tv_nsec` the kernel writes to `ts`) are tracked in epic [#763](https://github.com/SailfinIO/sailfin/issues/763) — both still need pointer-read intrinsics and an `errno` surface. Pinned by the updated `compiler/tests/e2e/test_runtime_clock_skeleton.sh` (asserts `call i32 @nanosleep` in the body, no `@sailfin_runtime_sleep` references survive, and a `br i1` back-edge after the call witnesses the retry loop), `test_sleep_unit_semantics.sh` (#307 — still brackets `sleep(75) ≈ 75 ms` on an unsignalled run), and the new `test_sleep_eintr_resume.sh` (#693 — asserts `sleep(500)` survives a mid-flight `SIGURG` and returns after ≥ 450 ms). | First runtime function migrated end-to-end from C to Sailfin: the `@sfn_sleep` symbol's only definition site is now `.sfn` code, and the C runtime has no `sailfin_runtime_sleep` / `sfn_sleep` body. Closes PR 2 of the sleep migration framed in `docs/runtime_audit.md`; closes Phase C of the #306 cleanup by deleting the per-symbol `sailfin_runtime_sleep` descriptor workaround. |
| Sleep call-site routing (PR 1 of the sleep migration) | **Shipped 2026-05-04**. Runtime helper registry rewires compiled user `sleep(N)` and the prelude's `runtime_sleep_fn` to lower to `call void @sfn_sleep(double)` instead of `call void @sailfin_runtime_sleep(...)`. PR 2 above (2026-05-20) replaced the C-side definition of `@sfn_sleep` with the Sailfin one; the call-path rewire stays in place. Pinned by `compiler/tests/e2e/test_runtime_clock_skeleton.sh` and `compiler/tests/e2e/test_sleep_routes_to_sfn_clock.sh`. | Establishes the pattern that future C-to-Sailfin migrations will follow: rewire the call site, back the symbol with C, replace the C body with a Sailfin link in a follow-up PR once link infrastructure is reliable |
| Sleep unit semantics — milliseconds end-to-end (issue #307) | **Shipped 2026-05-05**. Pre-existing semantic bug surfaced (but not introduced) by the sleep migration: the prelude advertised `sleep(milliseconds: number)` while `sailfin_runtime_sleep(double seconds)` interpreted its input as seconds (multiplied by 1000 for `Sleep` ms / 1e6 for `usleep` µs). `sleep(500)` actually slept for 500 seconds. **Resolution:** locked the unit to **milliseconds** across all four layers — public `sleep(ms)` surface (prelude + `sfn/time` capsule, already correct), the Sailfin wrapper `sfn_sleep(milliseconds: float)` in `runtime/sfn/clock.sfn`, the imported extern declaration `sailfin_runtime_sleep(milliseconds: float)` in `runtime/sfn/platform/libc.sfn`, and the C entrypoint signature `void sailfin_runtime_sleep(double milliseconds)` + trampoline `void sfn_sleep(double milliseconds)`. POSIX implementation upgraded from deprecated `usleep` to `nanosleep` with EINTR-resume so long durations and signal interruption are handled correctly (also matches the architect's PR 2 destination — `extern fn nanosleep` in `platform/posix.sfn`). Pinned end-to-end by `compiler/tests/e2e/test_sleep_unit_semantics.sh`, which brackets `sleep(75)` between two `monotonic_millis()` reads inside the user program (isolating the sleep from compile/link/start overhead) and asserts the elapsed window falls between 50 ms (lower bound for `nanosleep` floor + scheduler jitter) and 30 s (upper bound — ~3 orders of magnitude below the 75 s the seconds-bug would produce). | Aligns with public spec (`effects.md`, `standard-library.md`) and the `sfn_sleep(ms)` destination in `docs/runtime_architecture.md` §2.7.4; also unblocks PR 2 of the sleep migration (the libc-direct `nanosleep` rewrite can now lock the units intentionally) |
| `kind = "runtime"` capsule schema: `sfn-sources` field (dormant) | **Shipped 2026-05-04** as scaffolding for PR 2 of the sleep migration. TOML getter `toml_get_sfn_sources`, the `RuntimeCapsuleArtifacts.sfn_sources` field on `compiler/src/runtime_capsule_resolver.sfn`, and `_rcr_normalize_path` for canonical workspace-rooted path output. **No consumer is wired up yet** — the active `runtime/native/capsule.toml` does not populate the field. PR 2 will introduce the link-time compile loop that consumes it (gated on issue #308's IPC-isolation track). Schema unit tests in `compiler/tests/unit/runtime_capsule_resolver_test.sfn` regression-test the dormant scaffolding. | Future runtime modules (process, memory, …) will ship by adding manifest entries — no per-module Makefile staging once the link-time compile lands |
| Runtime `sfn-sources` link-time consumer (dormant) + compiler-toggle env-var migration | **Shipped (issue #308)**. `_compile_runtime_sfn_sources` in `compiler/src/cli_main.sfn` wires `RuntimeCapsuleArtifacts.sfn_sources` into `_clang_link_multi_with_opt`: per source, spawns `<self> emit --module-name <slug> -o <ll> llvm <src>` wrapped in `sh -c "SAILFIN_TRACE_EMIT= SAILFIN_SKIP_TYPECHECK= SAILFIN_TRACE_TEST_RUNNER= SAILFIN_DUMP_TEST_SOURCES= …"` so the child compiler does NOT inherit the parent's debug-toggle env. Toggle migration: the user-facing `build/sailfin/.skip_typecheck`, `.trace_emit`, `.trace_test_runner`, `.dump_test_sources` flag-file probes now read `SAILFIN_*` env vars first, with a one-release file-probe back-compat shim via `_legacy_flag_file` in `compiler/src/cli_commands_utils.sfn`. Rollback gate `SAILFIN_DISABLE_RUNTIME_SFN_SOURCES=1` skips the new link-time loop entirely. The consumer is **dormant** until PR B of the sleep migration populates `runtime/native/capsule.toml`'s `sfn-sources`. Pinned by `compiler/tests/e2e/test_subprocess_emit_clean_env.sh`. **Issue #311 follow-up shipped 2026-05-05:** the deferred `.test_runner_active` marker (10+ hot lowering reads + 6 paired `.trace_test_runner` reads) was migrated to in-process state in `compiler/src/test_runner_state.sfn` rather than env-var + cache. The marker was intra-process all along — the test orchestrator (`handle_test_command`) and every lowering consumer run in the same Sailfin process — so no env-var, `setenv` extern, per-process cache, or back-compat shim was needed. `enter_test_runner_mode(trace)` / `exit_test_runner_mode()` bracket the orchestrator; `test_runner_active()` / `test_runner_trace()` are pure module-level boolean reads. Pinned by `compiler/tests/e2e/test_runner_state_marker.sh`. **Issue #312 follow-up shipped 2026-05-05:** retired the trailing internal-diagnostic flag-file probes (`build/sailfin/.trace_lowering` ×11 hot sites, `.trace_call_lowering` ×2 hot sites, `.skip_module_globals` ×1 cold site, `.trace_argv` ×1 cold site) in favour of `SAILFIN_TRACE_LOWERING` / `SAILFIN_TRACE_CALL_LOWERING` / `SAILFIN_SKIP_MODULE_GLOBALS` / `SAILFIN_TRACE_ARGV` env vars. The three lowering flags read through lazy-init dual-boolean caches in `compiler/src/llvm/lowering_debug_state.sfn` (`_X_initialized` + `_X_value`, the same shape `test_runner_state.sfn` settled on for #311) so the per-statement hot path is two `load i1` reads + a `br i1` with no float widening; `.trace_argv` reads `_env_flag` directly at CLI entry. Same one-release `_legacy_flag_file` shim as #308. The `.phase_*_diagnostics` and `.skip_test_inlining` probes mentioned in #312's original inventory were already gone (replaced with in-memory diagnostics or removed entirely) when the audit ran, so #312 closed the file-IPC removal campaign with `grep -rnE 'fs.exists\\("build/sailfin/\\.(phase\|skip\|trace\|dump)_' compiler/src/` returning zero outside the new helper's header comment. Pinned by `compiler/tests/e2e/test_compiler_debug_toggle_env_vars.sh`. | Unblocks PR B of the sleep migration (and every future C→Sailfin runtime port — `clock`, `io`, `memory`, …) by replacing the file-IPC race with explicit env-var control of the child compiler's environment |
| First Sailfin-native runtime module linked into the compiler binary (M2.1 #394 + M2.2 #477) | **Shipped 2026-05-07 (M2.1 stub), real bump allocator 2026-05-25 (M2.2)**. `runtime/sfn/memory/arena.sfn` exports five `sfn_arena_sfn_*` symbols (`create` / `alloc` / `reset` / `destroy` / `realloc`) — M2.1 shipped them as libc-wrapper stubs to prove the runtime/sfn link path; M2.2 (#477) replaces the bodies with a real page-chain bump allocator per `docs/runtime_architecture.md` §2.1.1: 24-byte `Arena` handle owning a linked list of 32-byte `ArenaPage` headers each backed by a separately-malloc'd byte buffer. `alloc` rounds the page's `used` cursor up to the request alignment (default 8) and bumps it; on page overflow it walks the downstream chain looking for room (so resets reuse pages) before allocating a fresh page sized `max(default_page_size, size + align)` spliced in after the current page. `realloc` extends in place when `ptr + old_size` sits exactly at the current page's bump tip and the page has room; otherwise it fresh-allocs + memcpys and "leaks" the old buffer into the arena (reclaimed at the next reset/destroy). Pointer-typed struct fields ride as `i64` slots (same workaround as `runtime/sfn/memory/rc.sfn`: the seed compiler silently drops stores to `* T` struct fields routed through a `* StructTy` pointer). `runtime/native/capsule.toml`'s `sfn-sources` field lists this file, waking up `_compile_runtime_sfn_sources` (the dormant consumer from #308) for `make compile`'s `sfn build -p compiler` invocation. The Sailfin module's exports use the `_sfn_` infix to coexist with the C arena (`runtime/native/src/sailfin_arena.c`)'s `sfn_arena_*` exports — both arenas link side-by-side until M3 retires the C source per `docs/runtime_architecture.md` §2.1.1 (flip the C namesakes to `static`, rename the Sailfin exports to the bare form, route every caller through the Sailfin module). The prior `scripts/build.sh`'s `RUNTIME_SFN_ALLOW` allowlist (retired alongside the script itself in Stage E PR7 / #383) historically mirrored the manifest entry; the allowlist retired when `make check` migrated to `sfn build` (Stage E PR6 / #382). Pinned by `compiler/tests/e2e/test_runtime_memory_arena.sh` (typecheck + fmt + LLVM `define` shape per export + clang-linked lifecycle roundtrip exercising create → alloc → realloc-grow-in-place → realloc-copy-on-overflow → page-overflow → reset → re-alloc → destroy with an interposed `free` counter asserting the page-chain length matches the destroy free count) and `compiler/tests/e2e/test_runtime_sfn_sources_active.sh` (compiler-binary `nm` audit + manifest/allowlist drift check). | First proof-of-life for the runtime rewrite from C to Sailfin and the first runtime/sfn module whose bodies match the architect spec end-to-end; establishes the manifest-and-allowlist pattern every M2 follow-up (rc, string, array, exception, io, process, type_meta, prelude) reuses |
| Sailfin-native process spawning (M2.9, issue #405) | **Shipped 2026-05-22**. `runtime/sfn/process.sfn` exports `sfn_process_run({i8**, i64, i64}*) -> double` and takes over the `posix_spawnp` + `waitpid` dance the C trampoline `sailfin_runtime_process_run_v2` used to drive. `compiler/src/llvm/runtime_helpers.sfn` flips the `process.run` descriptor's `native_signature` to `sfn_process_run`; the legacy `_v2` C trampoline stays exported for seed-compiled IR but is now unreferenced in user emission (acceptance criterion). The body marshals `argv: string[]` into a NULL-terminated `(len + 1) * 8`-byte buffer via libc `malloc` + per-slot `atomic_store` (the seed-supported store primitive for raw-pointer slots — bare `slots[i] = x` on a raw `* i64` silently lowers to a no-op), calls `posix_spawnp` with the parent's `environ` (accessed via a one-line C bridge `sailfin_runtime_get_environ` — Sailfin has no `extern var` syntax to read `environ` directly), and decodes the `waitpid` status via inlined `WIFEXITED` / `WEXITSTATUS` / `WIFSIGNALED` macros (decimal masks `127` and `65280` substitute for `0x7f` / `0xff00`, which silently fold to 0 on the pinned seed — verified 2026-05-22). `runtime/native/capsule.toml`'s `sfn-sources` now lists `../sfn/process.sfn`, waking `_compile_runtime_sfn_sources` for `make compile`. The legacy `sfn run` / `sfn build` link path picks up the staged `build/native/obj/runtime/process.o` via the new `_runtime_process_path` in `compiler/src/cli_main.sfn` (returning it as `cached[5]` from `_clang_compile_runtime_objects`); `sfn test` adds it via the matching `process_paths[]` list in `compiler/src/cli_commands.sfn`'s `_clang_link_test_cmd_with_deps`. The cross-windows path is intentionally not extended — `posix_spawnp` is not in mingw-w64, and Windows users calling `process.run` would surface a link-time `undefined reference to sfn_process_run`; a Windows-specific implementation lands in a follow-up. Pinned by `compiler/tests/e2e/test_runtime_process.sh` (typecheck + fmt + LLVM `define double @sfn_process_run` shape + `call @posix_spawnp` / `@waitpid` body assertions + user-emission flip — the call site must land on `@sfn_process_run`, not `@sailfin_runtime_process_run_v2`) and `compiler/tests/integration/process_run_test.sfn` (real spawn of `echo` / `true` / `false` / nonexistent / empty argv — exit codes 0, 0, 1, 127, 127 respectively). Env-inheritance regression (caught during M2.9 development) covered by `compiler/tests/e2e/test_subprocess_emit_clean_env.sh`'s "first child should have inherited parent_val" assertion. | Third Sailfin-native runtime function migrated end-to-end from C to Sailfin (after `@sfn_sleep` and the `sfn_arena_sfn_*` / `sfn_rc_sfn_*` families); demonstrates that POSIX spawn-class primitives — non-trivial pointer marshalling + wait-status decoding — land cleanly in Sailfin once the `atomic_store` slot-write idiom and the `sailfin_runtime_get_environ` C-bridge pattern are in place. Establishes the bridge pattern for future C-to-Sailfin migrations that need libc globals (`errno`, `__progname`, …) until Sailfin grows `extern var` syntax. |
| Prelude facade migrated off `runtime.X` for the M2-replaced surface (M2.12a, issue #407) → audit + dead-delegate cleanup (M2.12b, issue #408) | **M2 closed 2026-05-26**. M2.12a (#407, PR #755) added explicit imports of seven `runtime/sfn/*.sfn` modules (`array`, `clock`, `exception`, `io`, `process`, `string`, `type_meta`) at the top of `runtime/prelude.sfn` and flipped `runtime_sleep_fn` to bind to the imported `sfn_sleep`. M2.12b (#408) extends that to the M2.10 type-meta cluster: `runtime_is_string_fn` / `_is_number_fn` / `_is_boolean_fn` / `_is_array_fn` / `_is_callable_fn` / `_resolve_runtime_type_fn` / `_instance_of_fn` now bind to the imported `sfn_*` symbols from `runtime/sfn/type_meta.sfn` (the M2.10 #402 surface). The helper registry's `native_signature` rows for these targets (PR #749 / M2.10) already routed compiled IR to the same `@sfn_*` symbols, so emitted user code is byte-identical; the M2.12b flip closes the audit at the Sailfin-source layer. The remaining `runtime.X` references in `runtime/prelude.sfn` are explicitly scoped to M3 and grouped by why the flip is deferred — (1) no `sfn_*` definition anywhere yet: capability bridges (`console`, `fs`, `http`, `websocket`, `create_capability_grant`, `create_filesystem_bridge`, `create_http_bridge`), `monotonic_millis`, `logExecution`, `to_debug_string`, `assert_fail`, `serve`, `is_void`; (2) `sfn_*` stub exists but the descriptor still has `native_signature: null` and emits calls to the legacy `sailfin_runtime_array_*` C bodies: `array_map` / `array_filter` / `array_reduce` (real implementations gate on closures-with-capture); (3) TLS / setjmp API split — `raise_value_error` (TLS) vs `sfn_throw` (setjmp/longjmp), M3 unifies them; (4) `native_signature` routes to a `sfn_*` symbol that's still a C trampoline in `runtime/native/src/sailfin_runtime.c` — `char_code` (→`@sfn_str_codepoint`), `grapheme_count` (→`@sfn_str_grapheme_count`), `grapheme_at` (→`@sfn_str_grapheme_at`); the prelude-side flip also needs a `string` ↔ `* u8` / `int` ↔ `float` boundary cast deferred per the issue's audit-only `In:` list. The audit invariant the M2.12b flip targets is "every M2-replaced symbol's emitted call lands on the canonical `sfn_*` symbol name" — that holds end-to-end via either direct sfn import (type-meta) or `native_signature` routing (`sleep`, `process.run`, `print*`, `sfn_str_codepoint`, `sfn_str_grapheme_*`). Only `sfn_sleep`, `sfn_process_run`, the `sfn_arena_sfn_*` / `sfn_rc_sfn_*` families, and the M2.10 type-meta surface are actually defined in Sailfin today; the other `sfn_*` symbols are still C trampolines and stay live until M3 lifts each body into a Sailfin module. Pinned by the standard `make compile` + `make test` self-host gate; the determinism sweep on `compiler/src/llvm/lowering/lowering_core.sfn` continues to produce byte-identical IR across 20 iterations. | Closes the M2 milestone: the legacy `sailfin_runtime_*` bodies (e.g. `sailfin_runtime_print_raw`, `sailfin_runtime_string_concat`) are now dead in fresh user emission, still linked for seed compat. Every M2-replaced symbol's emitted call lands on the canonical `sfn_*` symbol name; M3 retires the remaining `sfn_*` C trampolines by lifting their bodies into `runtime/sfn/*.sfn`. |
| Sailfin-native type-metadata registry (M2.10, issue #402) | **Shipped 2026-05-25**. `runtime/sfn/type_meta.sfn` exports `sfn_type_register` / `sfn_resolve_type` / `sfn_instance_of` / `sfn_type_of` + the five primitive guards (`sfn_is_string` / `_is_number` / `_is_boolean` / `_is_callable` / `_is_array`) backed by a libc-heap registry (`{i64 length, i64 capacity}` header + open-addressing-ready entry slots; v0 uses a linear-scan `strcmp` lookup, growing 2× on overflow via `realloc`). `SfnTypeDescriptor` is the architect-spec minimum (`{i64 id, i64 name_ptr, i32 kind}`); field descriptors with offsets and structural interface `instance_of` stay deferred per the issue's `Out:` list. New compiler-side lowering pass `compiler/src/llvm/lowering/type_descriptors.sfn` emits one `@__sfn_type_desc.<sanitized>` global per named struct/enum/interface plus a matching `@__sfn_type_desc_name.<sanitized>` NUL-terminated name string — both `linkonce_odr` so multi-module imports of the same type coalesce at link time — and a `@__sfn_module_type_init__<module>` constructor wired through `@llvm.global_ctors` that calls `@sfn_type_register(&desc)` for each. `compiler/src/llvm/runtime_helpers.sfn` flips the seven `runtime_is_*` / `runtime_resolve_runtime_type_fn` / `runtime_instance_of_fn` descriptors' `native_signature` to the matching `sfn_*` entrypoints; the legacy `sailfin_runtime_is_*` / `_resolve_type` / `_instance_of` C stubs (all returning false / null) stay exported for seed-built IR but are now unreferenced in user emission. The primitive guards still return false at v0 — value-side type tagging is deferred per the issue's `Out:` list; the material flip is `sfn_resolve_type` (linear scan of registered descriptors) and `sfn_instance_of` (descriptor identity), which together turn the prelude's `check_type_descriptor` → `runtime_resolve_runtime_type_fn` → `runtime_instance_of_fn` chain into a real "matching descriptors compare equal, non-matching compare unequal" round-trip. `runtime/native/capsule.toml`'s `sfn-sources` now lists `../sfn/type_meta.sfn`. The legacy `sfn run` / `sfn build` link path picks up the staged `build/native/obj/runtime/type_meta.o` via the new `_runtime_type_meta_path` in `compiler/src/cli_main.sfn` (returning it as `cached[8]` from `_clang_compile_runtime_objects`); `sfn test` adds it via the matching `type_meta_paths[]` list in `compiler/src/cli_commands.sfn`'s `_clang_link_test_cmd_with_deps`. The runtime module that defines `sfn_type_register` is excluded from the ctor + `@llvm.global_ctors` emission (recursive load-order dependency) but still emits descriptor globals for its own `SfnTypeDescriptor` / `SfnTypeRegistryHeader` types; its module preamble also skips the `declare void @sfn_type_register(i8*)` line (LLVM rejects `declare` + `define` on the same function). Descriptor-emission dedupes by type name within a single module to handle the test-runner concatenation path that surfaces imported-type duplicates as llvm-as `redefinition of global` failures. **Acceptance criterion #2 (`nm build/native/sailfin | grep __sfn_type_desc` shows registered descriptors) gates on the next seed bump** — the released seed predates this emission and therefore does not stamp descriptor globals into the first-pass binary; the IR-level check in `compiler/tests/e2e/test_runtime_type_meta.sh` proves the new compiler emits them for fresh user code. A pinned-seed re-cut closes the literal `nm` assertion. Pinned by `compiler/tests/e2e/test_runtime_type_meta.sh` (typecheck + fmt + LLVM `define` shape per export + descriptor-global wire shape on a user module with named structs + `@__sfn_module_type_init__*` constructor wiring + `@llvm.global_ctors` linkage + prelude emission flip routing through `@sfn_resolve_type` / `@sfn_instance_of` + binary symbol export check + manifest entry). Also touched `compiler/src/llvm/lowering/abi_hash.sfn` to expose `limbs_to_unsigned_decimal` (the descriptor `id` derivation uses FNV-1a 64-bit hashes of the type name for cross-module determinism). | Fourth Sailfin-native runtime function migrated end-to-end from C to Sailfin (after `@sfn_sleep`, the `sfn_arena_sfn_*` / `sfn_rc_sfn_*` families, and `@sfn_process_run`); converts the seven type-meta C stubs from "always false" to "registry-backed identity compare" without requiring value-side type tagging. Pins the descriptor-global + module-init-ctor wire shape every future reflection caller will follow. Field descriptors and structural `instance_of` for interfaces remain deferred per the issue's `Out:` list. |
| Sailfin-native atomic reference counting primitive (M2.3, issue #395) | **Shipped 2026-05-21**. `runtime/sfn/memory/rc.sfn` exports three `sfn_rc_sfn_*` symbols (`alloc` / `retain` / `release`) backed by libc `malloc` / `free` and the M0 atomics intrinsics (`atomic_add` / `atomic_sub`, shipped via #331-#334). The header layout (`docs/runtime_architecture.md` §2.1.2) is a 16-byte prefix `{ refcount: i64, drop_fn_addr: i64 }` sitting at `payload - 16`; `sfn_rc_sfn_alloc` returns the payload pointer (header invisible to user code), `sfn_rc_sfn_retain` emits `atomicrmw add ptr %p, i64 1 seq_cst, align 8`, and `sfn_rc_sfn_release` emits `atomicrmw sub ptr %p, i64 1 seq_cst, align 8` then calls `free` exactly when the post-decrement guard `prev == 1` fires. **drop_fn storage uses an `i64` slot** (`drop_fn_addr`) rather than `* u8` because the seed compiler's struct-field assignment silently drops stores to `* u8` fields routed through a `* StructTy` pointer; `as i64` lowers to a clean `ptrtoint i8* … to i64` and a 64-bit store, byte-equivalent to storing the raw pointer on every Sailfin platform. **drop_fn invocation is deferred to M2.4/M2.6** per the issue's `Out:` scope — releases that hit zero call `free` directly; the destructor hook fires once `sfn_drop_SfnString` / `sfn_drop_SfnArray` synthesis lands. `runtime/native/capsule.toml`'s `sfn-sources` array now lists `../sfn/memory/rc.sfn` alongside the arena entry. The Sailfin module uses the `sfn_rc_sfn_*` infix to coexist with the C runtime's pre-existing `sfn_rc_release` no-op stub in `runtime/native/src/sailfin_runtime.c:1885` (M1.5.2 placeholder from #326) without a link-time collision. Pinned by `compiler/tests/e2e/test_runtime_memory_rc.sh`: typecheck + fmt + LLVM `define` shape per export + `atomicrmw add / sub seq_cst, align 8` IR-shape grep scoped to retain/release + bare-name collision regression + a clang-linked functional roundtrip (`alloc → retain → release → release`) with an interposed `free` counter that asserts exactly one `free` call. | Second proof-of-life of the runtime rewrite from C to Sailfin; unblocks every value type that needs cross-scope sharing (strings, arrays, channel payloads); pins the atomic-intrinsic refcount ABI that M2.4/M2.6 destructor synthesis layers on |
| Extern call return-type defaulting hardened (issue #306, Phase A) | **Shipped 2026-05-06**. The LLVM lowering pipeline used to silently default `llvm_return = "i8*"` in `compiler/src/llvm/expression_lowering/native/core_call_resolution.sfn:716` whenever the call resolver could not determine the callee's signature (no runtime-helper descriptor, no entry in `imported_functions`, and not a recognised trait dispatch). With the result discarded, that produced structurally-invalid IR — `call i8* @sailfin_runtime_sleep(double …)` against `declare void @sailfin_runtime_sleep(double)`. Clang accepted the mismatch only because the result was unused, and the bug self-fed: the synthesized `declare` line was extracted from the same malformed `call`, keeping declare and call locally consistent while both diverged from the real function's ABI. The `sailfin_runtime_sleep` repro from the issue body was masked on 2026-05-04 by a per-symbol `RuntimeHelperDescriptor` (`compiler/src/llvm/runtime_helpers.sfn:113-127`); the underlying default was unchanged. **Resolution:** killed the silent default. `resolve_call_signature` now initialises `llvm_return = ""` and only assigns when the descriptor table, `imported_functions` lookup, or trait-dispatch interface signature succeeds. `coerce_and_emit_call` gates emission on `llvm_return.length > 0`; an empty value triggers a hard-fail diagnostic ("llvm lowering: cannot resolve return type for call to `<symbol>` — callee signature is not known to the compiler") printed to `print.err` and pushed into the diagnostic stream, with no `call` line emitted. The diagnostic surfaces structural lowering bugs immediately instead of leaking malformed IR downstream. Pinned by the tightened `compiler/tests/e2e/test_runtime_clock_skeleton.sh` — the call-shape grep now requires the typed `call void @sailfin_runtime_sleep(` form (formerly `call .* @sailfin_runtime_sleep(` would have matched the broken `call i8*` shape) and explicitly forbids the `call i8*` regression. The matching update to `compiler/tests/e2e/test_runner_state_marker.sh` (its assertion 3) replaces the now-impossible IR-call-shape signal with the post-mangle `import_subs >= 1` trace observation, which directly verifies the import-stripping gate (`is_test_module=false`) without depending on the pre-fix feedback loop. **Phase B + Phase C deferred:** the architect's plan calls for a typecheck-level `imported_externs` channel (Phase B) so `sfn check` can resolve calls to imported externs end-to-end (closes "general typecheck call-site resolution deferred" caveat in the row above), then retiring the per-symbol `sailfin_runtime_sleep` `RuntimeHelperDescriptor` workaround (Phase C). Both follow-ups need their own issues; not in this PR. | The call lowering pipeline can no longer mask declare/call ABI mismatches — every future `runtime/sfn/*.sfn` adapter that wraps a libc function for its side effect (logging, fire-and-forget I/O, the upcoming `nanosleep` rewrite of `sfn_sleep` in PR 2 of the sleep migration) emits structurally-correct IR or fails loud with a typed diagnostic |
| Three further `runtime/sfn/platform/*.sfn` skeletons (`pthread.sfn` 11 decls, `posix.sfn` 4 decls, `net.sfn` 9 decls) | **Shipped 2026-05-02** (typecheck + fmt + LLVM `declare` emission verified per file by `compiler/tests/e2e/test_runtime_{pthread,posix,net}_skeleton.sh`); not yet imported by any module. Function-pointer parameters degrade to `* u8` due to a `sfn fmt` / `is_c_abi_function_pointer` interaction documented in the `pthread.sfn` header | Validates the extern pipeline on richer C-ABI shapes (pointer-to-pointer, primitive-pointer out-parameters, multi-family opaque-struct pointers); seed for `runtime/sfn/scheduler.sfn` + `runtime/sfn/channel.sfn` (M4), `runtime/sfn/process.sfn` + `runtime/sfn/adapters/clock.sfn` (M2), and `runtime/sfn/adapters/http.sfn` (M3) |
| `int` / `float` numeric types | **Slices A + B + C + D + E.1 + E.1.5 shipped (A/B/C 2026-05-02, D 2026-05-03, E.1 2026-05-08, E.1.5 2026-05-10)**. Slice A: annotated locals/params/returns lower to `i64` / `double`; extern accept-list admits `int` / `float`; integer/float arithmetic & comparison dispatch verified by `compiler/tests/e2e/test_numeric_int_float.sh`. Slice B: `&`, `|`, `^`, `<<`, `>>` lex/parse/lower to LLVM `and`/`or`/`xor`/`shl`/`ashr i64`, verified by `compiler/tests/e2e/test_numeric_bitwise.sh`. Slice C: extern accept-list expanded to `i16`/`u16`/`u32`/`u64`/`isize`/`f32`. **Slice D — `as` cast LLVM lowering matrix:** parser/AST/native-IR rendering (PR #289) plus the LLVM lowering matrix in `lower_cast_expression` (`compiler/src/llvm/expression_lowering/native/core_literals_lowering.sfn`) — `int → float` lowers to `sitofp`, `float → int` to `fptosi`, integer widening to `sext` (or `zext` for `i1`), narrowing to `trunc`, `f32 → double` to `fpext`, `double → f32` to `fptrunc`, and `as bool` is rejected with a fix-it pointing at `x != 0`. Verified by `compiler/tests/unit/numeric_cast_test.sfn` (extended) and `compiler/tests/e2e/test_numeric_cast.sh` (new — 8 LLVM-shape pinning cases). The matrix opens with a no-op `coerce_operand_to_type(lowered.operand, lowered.operand.llvm_type, …)` keepalive call to defeat an alpha.8 seed dead-code pass that would otherwise elide `let operand = lowered.operand` and prevent the matrix from firing — `lower_return_instruction` in `statement.sfn` works around the same DCE quirk by passing `operand` to `coerce_operand_to_type` immediately after binding. **Slice E.1 — bare-literal default + `number` alias (#488, 2026-05-08):** unsuffixed integer literals now default to `int` (i64) in LLVM lowering — `let x = 42; let y = x + 1` lowers to `alloca i64`, `add i64`. Decimal/exponent literals stay on the `double` path. `: number` and `: float` are both registered as primitive aliases for `double` in every type-mapping seam (`type_mapping.sfn`, `core_type_mapping.sfn`, `statement_type_mapping.sfn`, `module_globals.sfn`), so existing `: number` annotations across the compiler source continue to lower as `double`. Verified by the new `compiler/tests/e2e/test_numeric_int_default.sh` and `compiler/tests/unit/numeric_int_default_test.sfn`. Closes L1 in §3.7. **Slice E.1.5 — refuse silent `float → int` coercion at ABI boundaries (#528, 2026-05-10):** adds `numeric_type_kind` to `compiler/src/llvm/type_mapping.sfn` (returns `"int"` / `"float"` / `"other"`) and extends `coerce_operand_to_type` in `compiler/src/llvm/expression_lowering/native/core_operands.sfn` so call-arg coercion and struct-field writes default to a strict mode that rejects mismatch with a `[fatal]` ABI primitive diagnostic. The rule is asymmetric — only `caller=double, callee=i64` fires today, because the reverse direction (`arr.length` into a `: number` slot) still happens pervasively in the existing tree and is deferred to E.3. A `@[abi_widen]` parameter attribute was added as a per-parameter opt-out during the partial migration but went unused (the asymmetric rule above kept the call-arg site quiet for the only direction E.2 touched). #550 downgraded the asymmetric rejection from `[fatal]` to `[warning]` (the warning still fires but the coercion proceeds via `coerce_numeric_primitive`), and **#532 removed the `@[abi_widen]` surface end-to-end** (parser, `Parameter.attributes` / `NativeParameter.attributes`, `.sfn-asm` round-trip, and the call-arg lookup); the call-arg coerce site now passes `allow_widen=false` unconditionally. Verified by `compiler/tests/integration/numeric_abi_mismatch_test.sfn`. **Slice E.2 partial source migration (#530, 2026-05-12):** the closed instruction-lowering numeric cluster now uses `: int` for integer-shaped declarations across LLVM result fields/counters, lifetime IDs/depths, native-IR/layout metadata, and transitive statement/core-lowering consumers. **Slice E.3a — integer-shaped `: number` migration complete (#567, 2026-05-16; #555 split into #559–#567 plus the lockstep PRs #571 / #572 / #576 / #578 / #579 / #586 / #601–#609):** every `: number` / `-> number` site in `compiler/src/*.sfn`, `runtime/prelude.sfn`, and `compiler/tests/**/*.sfn` either flipped to its semantic `: int` / `: float` shape (per the decision artifact at `docs/proposals/slice-e3a-semantic-audit.md`) or carries a trailing `// alias-coverage:` marker documenting the opt-out (prelude shadows in `cli_commands_utils.sfn` and `llvm/utils.sfn`, the C-ABI `sailfin_cli_main` / `native_cli_main` boundaries, the runtime `is_number` predicate, the literal-text predicates in `core_text.sfn`, and the `Future` mapping seam in `type_mapping.sfn`). The site-level audit `grep -rnE "(: number\|-> number)" compiler/src/ runtime/prelude.sfn compiler/tests/ --include='*.sfn' \| grep -v "// alias-coverage"` returns zero. The bulk-PR lockstep splits (#579, #571 / #576) were forced by bidirectional coupling between `compiler/src/*.sfn` and `compiler/src/llvm/lowering/` — the original parallel-safe disjoint-subtree assumption broke on the `make_native_*_layout` family and the `string_utils` ↔ `llvm/utils` shadow chain. **Slice E.3b — strict-refusal reapply shipped 2026-05-18 (#556):** `dominant_type` now returns an empty-string sentinel on mixed int↔float pairs; `harmonise_operands` and `coerce_operand_to_type` boundary mode emit a `[fatal]` ABI primitive mismatch diagnostic with the canonical fix-it `add \`as float\` or \`as int\` to disambiguate`. Slice D's `as` cast is the load-bearing escape valve; the four documented alias-coverage seams (prelude shadows, C-ABI boundaries, the `Future` mapping seam, and the runtime `is_number` predicate) spell their boundary conversions explicitly. L2/L3 closed; #296 closed. Slice E complete. Verified by `compiler/tests/unit/numeric_int_float_coercion_test.sfn`. | Sizes/indices, bitwise ops, numeric `as` casts, integer-literal defaulting, full source migration, strict int↔float refusal — all shipped (Slice E closed) |
| Raw pointer types (`*T`) enforced | Planned | OS handles (`*FILE`, `*DIR`, `*pthread_t`), buffer pointers |
| `Result<T, E>` + `?` operator | Planned | Every fallible operation (file I/O, allocation, network) |
| Bitwise integer operators (`&`, `|`, `^`, `<<`, `>>`) | **Shipped 2026-05-02** as numeric Slice B (see row above) — lex/parse/lower to LLVM `and`/`or`/`xor`/`shl`/`ashr i64`. The lowering also emits a clear diagnostic when bitwise/shift ops are applied to `double` operands. The cross-type half (typecheck-side rejection of `double & x`) was originally bundled into Slice D's `dominant_type` tightening but moved to Slice E along with the rest of the int↔float disambiguation work — see issue #296. | SHA-256, Base64, flags, enum tag extraction now unblocked |
| Closures with capture | Planned | `map`/`filter`/`reduce`, spawn handlers, route handlers |
| Generic type constraints | Planned | `Array<T>`, `Slice<T>`, `HashMap<K, V>`, `Channel<T>` |
| Deterministic drop emission | **M1.5 — in flight (#322)**. Promoted out of the "core runtime in Sailfin" milestone by the 2026-05-06 runtime-rewrite reassessment (#321) into its own epic so reviewers can audit the seam (`LocalBinding.allocation_kind` + `emit_scope_drops`) independently of core-runtime service PRs. Conservative escape rule in v0 is function-return promotion only; closure-capture and channel-send promotion follow once those features land. See `docs/runtime_architecture.md` §3.1 and §4.5b, and `docs/runtime_audit.md` Hard prereq #5. | Memory reclamation — enables `string_drop` and `array_drop`; unblocks every allocating Sailfin-native runtime service that follows |
| M0 Atomic intrinsics — shipped (#323) | **Shipped (M0, 2026-05-07)**. All six builtins (`atomic_load`, `atomic_store`, `atomic_add`, `atomic_sub`, `atomic_cas`, `atomic_fence`) parse, emit to native IR, and lower to LLVM `load atomic` / `store atomic` / `atomicrmw add` / `atomicrmw sub` / `cmpxchg` / `fence seq_cst`. Arity/type validation (E0806) is enforced during LLVM lowering (`compiler/src/llvm/atomics.sfn`); the typecheck pass treats atomic calls as ordinary call expressions. Sub-issues: #331 (load/store), #332 (add/sub), #333 (cas), #334 (fence), #335 (docs). Memory ordering `seq_cst` for v0; relaxed/acquire/release variants post-1.0. See `docs/runtime_architecture.md` §3.5 and `docs/runtime_audit.md` item 11. | Reference counting (M2), task queues and channel flags (M4) |

See `docs/runtime_audit.md` for the full migration plan.

## Installer (Current)

- The installer defaults to `~/.local/bin` on all platforms (override with
  `GLOBAL_BIN_DIR`).
- Pinned stable version for development: `v0.1.1-alpha.135`.

## Known Design Issues (Pre-1.0 Syntax Reform)

The following design issues have been identified through external review and must
be resolved before 1.0 to avoid breaking a public API. Each is tracked in
the [roadmap](https://sailfin.dev/roadmap) and `docs/proposals/colon-type-annotations.md`. This section records the *problem*; the
roadmap records the *plan*.

### Type annotation syntax (`->` vs `:`) — **migrated**

**Resolution**: The compiler source, runtime, capsules, tests, and examples
all use `:` for parameter, variable, and field type annotations. Function
return types continue to use `->`.

```sfn
fn add(x: number, y: number) -> number { ... }
let name: string = "Sailfin";
struct User { id: number; name: string; }
```

**Remaining work**: None — migration complete. The parser now enforces
`:` in annotation positions and `->` in return-type positions.

### String interpolation (`{{ }}` vs `${ }`)

**Problem**: `{{ }}` universally means "escape interpolation" in template
languages (Jinja2, Handlebars, Mustache, Angular) and "literal braces" in
Rust's `format!`. Sailfin uses it for the *opposite* meaning.

**Impact**: Medium-high. Every developer will be confused. LLM code generators
trained on billions of lines of `{{ }}` = "literal braces" will systematically
produce wrong Sailfin code.

### Numeric type system (`number` = f64 only)

**Problem**: The sole numeric type is `number` (64-bit float). This causes:
- Precision loss for integers above 2^53
- Semantically wrong array indexing (floats as indices)
- Unreliable bit operations
- The "double-encoded pointers" fixup category (~12 of ~69 compiler fixups) —
  pointers are encoded as doubles because that's what `number` compiles to

**Impact**: High. This is a systems language targeting LLVM. JavaScript made
this choice and added BigInt 25 years later to compensate. Don't repeat it.

### Error handling gaps

**Problem**: Errors are invisible in function signatures. `try`/`catch` is the
only structured mechanism, supplemented by ad-hoc union return types
(`number | DivisionError`) with no propagation operator.

**Impact**: Medium. No `Result<T, E>` or `?` operator means every error-handling
call site requires manual `match`. Error types proliferate across module
boundaries with no composition mechanism.

### Unenforced syntax (deferred to post-1.0)

**Decision**: `Affine<T>`, `Linear<T>`, `&T`, `&mut T`, `PII<T>`, `Secret<T>`
are all parsed but not enforced. Rather than marketing unenforced guarantees,
these features are explicitly deferred to post-1.0. Sailfin's safety story is
**effects and capabilities**, not borrow checking or taint tracking — those will
ship when they can be enforced end-to-end.

**Status**: Ownership and taint types remain in the parser for forward
compatibility but are not advertised as shipped features. They will be removed
from marketing materials and the homepage.

### Strategic focus

**Decision**: Sailfin's three differentiators are: (1) effect system,
(2) capability-based security, (3) structured concurrency. All pre-1.0 effort
focuses on making these world-class. AI integration, ownership enforcement,
and taint tracking are post-1.0 library and compiler work.

## AI / Model Constructs (Moved to Library)

The `model`, `prompt`, `tool`, and `pipeline` keywords were originally designed
as language-level syntax. They have been **removed from the language** and will
be delivered as ordinary library APIs in the post-1.0 `sfn/ai` capsule.
Rationale:

- AI APIs change faster than language grammars can evolve
- Library-level features can iterate independently of compiler releases
- The `![model]` effect — the capability gate — remains a language-level feature
- Keyword syntax reserved unnecessary grammar surface for features that had no
  runtime behaviour

**Current state**: The parser, AST, typecheck, effect-checker, native emitter,
LLVM runtime-helper descriptors, and C runtime stubs for these constructs have
all been removed. The `![model]` effect is the only AI-specific construct that
remains in the language.

**What stays in the language**: The `![model]` effect annotation, which gates
AI operations through the capability system. Once the `sfn/ai` capsule ships,
its functions will carry `![model]` in their signatures and effect checking
will propagate transitively the same way it does for `io`, `net`, and `clock`.

Design-level discussion for the future library API is preserved in
`docs/proposals/model-engines-and-training.md`.
