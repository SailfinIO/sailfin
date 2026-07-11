---
sfep: 6
title: Unified Build Architecture
status: Implemented
type: tooling
created: 2026-04-17
updated: 2026-04-28
author: "agent:compiler-architect"
tracking:
supersedes:
superseded-by:
graduates-to:
---

# Proposal: Unified Build Architecture for Sailfin

> **Note (2026-05-08).** The prior `scripts/build.sh` orchestrator was
> retired in Stage E PR7 (#383). Every reference to `scripts/build.sh`
> below describes the formerly-load-bearing historical state and is
> preserved for context. Fresh-clone bootstrap is now
> `install.sh && sfn build -p compiler` per Stage D exit criteria.

Status: Stages A and B fully shipped. **Stage C cache milestone shipped (PR1–1f / #254–#259 / 2026-04-28).** Stage C broader items (C2 artifact layout / C3 stdlib CI gate / C4 `sfn package` / C5 `sfn bench` + `sfn bootstrap`) and Stages D–G remain.
Date: 2026-04-17 (drafted) · 2026-04-25 (status refreshed) · 2026-04-25 (Stage B PR1 landed) · 2026-04-25 (PR2/A1 typecheck hookup landed) · 2026-04-25 (PR2/A2 resolver wiring landed) · 2026-04-26 (PR2 `sfn test` migration + A4 deletion landed) · 2026-04-28 (PR3 `llvm-objcopy --weaken` retired via path-norm fix; libextract decoupled) · 2026-04-28 (Stage C cache milestone PR1–1f shipped)
Authors: Core Team

## Implementation Status (as of 2026-04-28, Stage C cache milestone shipped + per-capsule artifact layout shipped through C2b1; C2b2 in flight)

**Stage A — shipped.** Manifest schema, `workspace.toml`,
`capsules/sfn/prelude/capsule.toml`, and `[build].kind = "binary"` on the
compiler's own manifest all landed. Parse-only — no consumers wired in
Stage A itself.

**Stage B — split into PR1 (resolver + sfn build/run) and PR2 (test + check
+ libextract).** This avoids bundling the high-risk `sfn/compiler-lib`
extraction with the lower-risk resolver wiring.

### Stage B PR1 — shipped on `claude/build-stage-b-hlXw1`

Four commits, all green through `make compile` (~133-148s):

1. `feat(resolver): add WorkspaceMember + workspace.toml discovery to capsule_resolver`
   — `WorkspaceMember`, `parse_workspace_member_paths`,
   `discover_workspace_root`, `load_workspace_members`,
   `workspace_member_for_spec`. 8 inlined-helper unit tests.
2. `feat(resolver): add enumerate_relative_sources to capsule_resolver`
   — string-/comment-aware import scanner, `resolve_relative_import`,
   BFS-walking `enumerate_relative_sources(entry)`. 19 unit tests.
3. `refactor(cli): wire sfn build/run to unified resolver; add sfn build -p`
   — `_prepare_project_capsules` now combines (1) relative imports,
   (2) manifest-declared capsule deps, (3) workspace-implicit imports
   (`scope/name` references the source uses but doesn't `[depends]` on,
   resolved against `workspace.toml`). The textual-inline fallback in
   `sfn run` is **deleted**. `sfn build -p <capsule-path>` ships, with
   `[build].kind = "library"` capsules emitting a `.o` instead of
   linking. All 19 stdlib `capsules/sfn/*` manifests gain
   `[build].kind = "library"`. `compiler/tests/e2e/test_capsule_build.sh`:
   4/4 PASS.
4. `refactor(resolver): move prepare_project_capsules into capsule_resolver`
   — clean move from `cli_main.sfn` so `cli_commands.sfn` (PR2) can
   import it for the test path.

### Stage B PR2 — shipped (`sfn test` + `sfn check` migrations) + remaining libextract follow-up

PR2 originally scoped to "extract `sfn/compiler-lib` and retire
`llvm-objcopy --weaken`". After PR1, it grew to absorb four
architecturally-coupled items. As of 2026-04-26, four are shipped and
one remains as a follow-up workstream:

1. **`sfn test` migration — shipped (2026-04-26).**
   `lower_to_llvm_lines_with_parsed_context_for_tests` now lowers test
   sources with `mangle_symbols = true` and the inline harness
   appends `__<sanitize_module_suffix(native_module.module_name)>` to
   each `test:` symbol so harness call sites match the mangled
   definition. Path (a) from the original two-fix-paths analysis,
   chosen for symbol parity with the rest of the compile pipeline.
   `handle_test_command` runs one
   `prepare_project_capsules_for_test` pass per `(project_root,
   workspace_root)` group, mirroring the structure
   `cli_check.sfn` adopted in A2; the test compile uses
   `compile_tests_to_llvm_file_with_module_imports` (typecheck with
   imports + import-context-in-LLVM threading) and the link uses
   `_clang_link_test_cmd_with_deps` (dep `.ll` files prepended ahead
   of the still-weakened `native.linked.o`).
   Fixed a latent slug-naming inconsistency: `_cr_relative_slug` now
   delegates to `module_name_from_path` so dependency slugs match the
   slug the importer's mangling pass derives via
   `resolve_import_module_slug_for_module`.
   `compiler/tests/e2e/test_runner_import_inlining_test.sfn`,
   `cross_module_import_test.sfn`, and `directory_import_test.sfn`
   all link and run via the resolver-driven path.

2. **`sfn check` migration — shipped via Track A2 (2026-04-25).** See
   the A2 notes in `docs/proposals/0004-check-architecture.md`. The
   typechecker-side hookup (A1) and the resolver wiring (A2) shipped
   together; cross-module `implements` conformance (E0301) is now
   live for end users without any textual import inlining.

3. **Delete the legacy helpers — shipped (2026-04-26, A4).**
   `_inline_relative_imports_cmd`, `inline_imports_for_source`,
   `_strip_relative_import_lines_cmd`,
   `_collect_relative_import_spans_cmd`, the
   `_RelativeImportSpanCmd` struct, `_lookup_dep_version_cmd`,
   `_resolve_cached_capsule_path_cmd`,
   `_resolve_import_path_cmd`, `_clang_link_test_cmd` (the no-deps
   variant), `compile_tests_to_llvm_file_with_module`,
   `write_llvm_ir_for_tests`, and `write_llvm_ir_for_tests_from_text`
   are gone — net `-714` lines across `cli_commands.sfn`,
   `main.sfn`, and `entrypoints_tests_writer.sfn`. The architect's
   plan also listed `_is_stdlib_capsule_cmd` /
   `_resolve_capsule_name_cmd` / `_is_stdlib` and
   `stdlib_capsule_allowlist_test.sfn` for deletion; those survive
   this cycle because `sfn add` still consumes the stdlib-name
   resolution chain. They retire once `sfn add` migrates to
   workspace.toml-driven resolution — separate workstream.

4. **`llvm-objcopy --weaken` retirement — shipped (2026-04-28, PR3).**
   The original PR2 plan assumed retiring the weaken hack required
   first extracting `sfn/compiler-lib`. An empirical probe
   (`SAILFIN_TEST_NO_WEAKEN=1` env-var gate, see commit `acc8af5`)
   showed otherwise: the weakened-compiler-object backstop was
   masking a path-normalization bug, not providing genuinely
   missing symbols.

   **The bug:** `_collect_test_files_cmd` (`cli_commands_utils.sfn`)
   did not strip trailing slashes from its `root` argument before
   walking the directory tree. `sfn test compiler/tests/unit/`
   produced paths like `compiler/tests/unit//foo_test.sfn`, which
   `_cr_resolve_and_dedupe`'s relative-import walker could not
   navigate. The resolver returned `deps=0`, every test that
   imported anything got `undefined reference` link errors, and
   the weakened compiler binary backstopped them — masking the
   resolver's correctness regression.

   **Symbol-closure audit:** of 91 test files, only 22 import
   anything from `compiler/src/`; the union of those imports is 10
   modules whose transitive closure is exactly 13 files (`ast`,
   `cli_commands_utils`, `diagnostics_render`, `effect_checker`,
   `effect_gate`, `effect_imports`, `effect_taxonomy`, `native_ir`,
   `string_utils`, `token`, `toml_parser`, `typecheck_types`,
   `version`). The resolver was already producing strong `.ll`
   files for that closure post-PR2 — when the path math worked.
   Single-file invocations (`sfn test path/to/foo_test.sfn`)
   already worked without weaken because they bypassed the
   broken directory walker entirely.

   **The fix:**
   - `_collect_test_files_cmd` now calls `_strip_trailing_slashes_cmd`
     on `root` (mirroring the Phase 5a fix to `_collect_sfn_files_cmd`).
   - The 47-line `--weaken` block in `_clang_link_test_cmd_with_deps`
     deletes — including the `cp` of `native.linked.o`, the
     `args.push(weak_path)`, and the `cross_module_shim.o` push.
   - `_resolve_llvm_objcopy_cmd` (the `llvm-objcopy-{14..30}`
     PATH-probing helper, only consumed by the deleted block)
     deletes — net 25 lines.
   - `compiler/tests/unit/cli_path_normalization_test.sfn` gains
     two regression tests asserting the slash-form invariant on
     `_collect_test_files_cmd` directly.

   **Decoupling outcome:** `sfn/compiler-lib` extraction is no longer
   on Stage B's critical path. The architectural case for
   sub-capsule decomposition (proposal §4.10) still stands as a
   Stage G concern when the compiler grows enough sub-capsules to
   benefit from independent caching, parallel sub-builds, and
   independent versioning. It is not a 1.0 blocker.

### What remains for Stages C–G

Unchanged from the original plan (Part 5):

- **Stage C** — In-process driver for user capsules; content-addressed
  cache; `sfn package` and `sfn bench` subsume the shell scripts.
- **Stage D** — Compiler builds itself via `sfn build`; delete the
  prior `scripts/build.sh` (since retired in Stage E PR7) and the
  Makefile.
- **Stage E** — Long-lived process, arena, incremental builds; hit the
  <5 min build target.
- **Stage F** — Sailfin runtime rewrite; `sfn/runtime-native` retires.
- **Stage G (post-1.0)** — Compiler decomposition into sub-capsules.

### Other unblocked drift since the original draft

- **Phase 6 parallel selfhost shipped.** `make compile` is ~2 min local
  / 5:28 CI Linux (was ~13 min serial). Phase 5 (long-lived process)
  is no longer urgent for the wall-time target.
- **`sfn check` shipped** (April 18 — see
  `docs/proposals/0004-check-architecture.md`). Provides the parser /
  typecheck / effect surface the unified driver reuses.

### Build-script fixups historically load-bearing (now retired)

- `EMIT_RETRIES=3` (formerly at `scripts/build.sh:51`, since retired
  alongside the script in Stage E PR7 / #383) — Stage 4 attempted
  `EMIT_RETRIES=1` and reverted on April 25 because `instructions.sfn`
  flaked. The retry knob now lives only in the driver (Track 4 M3
  cutover gated).
- The fallback paths in `compile_to_llvm_file_with_module`
  (formerly `compiler/src/main.sfn:480`) were retired in #380 (Stage E
  PR3 cascade deletion).

## Summary

Sailfin today has two largely independent build pipelines:

1. **`scripts/build.sh`** (since retired in Stage E PR7 / #383) — historically
   a ~970-line bash orchestrator that self-hosted the compiler from a released
   seed. It discovered sources, spawned the seed once per module, staged an
   import-context directory, validated the emitted LLVM IR with retries, then
   llvm-link-merged and clang-linked the result.
2. **`sfn build` / `sfn run` / `sfn test`** — a single-file CLI in
   `compiler/src/cli_main.sfn` that compiles one `.sfn` file to LLVM IR, then
   clang-links it against a pre-built runtime bundle. `sfn run` and `sfn test`
   additionally perform *textual* import inlining to resolve project
   dependencies.

The two pipelines solve the same problem (turn a graph of `.sfn` modules into
a native binary) with different code paths, different resolution rules, and
different failure modes. They exist because the compiler was built
incrementally toward self-hosting, filling gaps with shell scripts whenever a
compiler feature wasn't yet ready.

This proposal documents what exists today, enumerates the resulting
architectural problems, and proposes a future state where **`sfn build` is
the only build driver** — used to build user programs, stdlib capsules, and
the compiler itself. The native C runtime migration (Phase 3 of the runtime
enablement plan) is treated as a coordinate axis, not a blocker: the build
architecture must land first so the runtime rewrite can consume it.


---

## Part 1 — Current State

### 1.1 Building the compiler (`make compile`)

Historically `make compile` delegated to the prior `scripts/build.sh`
(since retired in Stage E PR7 / #383), which was the actual build driver.
The Makefile mainly handled seed fetching, output-directory plumbing, and
re-running the script with the right environment. The driver
(`<seed> build -p compiler`) now plays both roles.

Flow:

1. **Seed acquisition.** `make fetch-seed` downloads a released compiler
   (default `0.5.3-alpha.1`) to `build/toolchains/seed/bin/sfn` via `install.sh`.
   The seed must support `emit native` or the rebuild aborts.
2. **Source discovery.** `build.sh` walks `compiler/src/**/*.sfn` plus
   `runtime/**/*.sfn`, then parses `[dependencies]` in
   `compiler/capsule.toml` and appends sources from
   `capsules/<scope>/<name>/src/**/*.sfn` for each declared dep. Today the
   compiler's manifest declares no dependencies, so only the in-tree
   compiler + runtime sources are used.
3. **Import-context staging.** For every source, the seed runs
   `seed emit native <file>` once to produce a `.sfn-asm` textual IR.
   The prior (now retired) `scripts/build.sh` historically derived
   the corresponding `.layout-manifest` by `grep`-extracting
   `.layout` lines from the emitted `.sfn-asm` (the seed does not
   produce the manifest as an independent output); this work now
   happens inside the driver's resolver.
   Together these staged artifacts form the cross-module interface the
   second-pass emit depends on. They are written under
   `build/selfhost/native/seed_cwd/build/native/import-context/`.
4. **Per-module LLVM emit.** For each source the script:
   - Creates an isolated `seed_cwd` directory.
   - Copies the *entire* import-context directory into it (one copy per
     module — 121 copies for the current compiler).
   - Removes the module's own staged artifact to prevent self-import.
   - Runs `seed emit -o <out.ll> llvm <file>` from that directory, with a
     memory cap (12 GB) and a 180 s timeout.
   - Validates the output with three checks: non-empty, valid header,
     full-file parse via `llvm-as` (or clang as fallback).
   - Retries up to `EMIT_RETRIES=3` times on failure; captures corrupt
     output to `$CORRUPTED_DIR` for diagnosis.
5. **Per-module clang compile.** Each `.ll` is compiled to `.o` with
   `clang $CLANG_FLAGS -c`.
6. **LLVM link.** Every non-prelude `.ll` is merged into
   `sailfin.linked.bc` via `llvm-link`, then lowered to `native.linked.o`
   with clang.
7. **C runtime compile.** Four C files
   (`sailfin_runtime.c`, `sailfin_sha256.c`, `sailfin_base64.c`,
   `native_driver.c`) plus `runtime_globals.ll` and the Sailfin
   `runtime/prelude.sfn` (compiled separately to `prelude.o`) are compiled.
8. **Final link.** `clang` links the compiler object, the runtime objects,
   and the prelude object into `build/bin/sfn`.

### 1.2 Building a user program (`sfn build`, `sfn run`)

`sfn build` and `sfn run` live in `compiler/src/cli_main.sfn` and handle a
single source file at a time.

- `sfn build [-o OUTPUT] <file>` — reads the file, calls
  `compile_to_llvm_file_with_module(source, module_name, "build/sailfin/program.ll")`,
  then `clang`-links against the installed runtime bundle via
  `_clang_link`. It does **not** resolve imports itself; the compiler's
  in-process import resolver reads from `build/compiler/import-context/` if
  present.
- `sfn run <file>` — before compilation, calls `inline_imports_for_source`
  in `cli_commands.sfn`. That function performs *textual* import inlining:
  it finds every `import { ... } from "…"` statement, resolves the spec via
  three rules, reads each dependency's source, recursively inlines its
  imports, and concatenates the sources into a single synthetic buffer that
  is then passed to the compiler.

Three import resolution rules are interleaved across
`cli_commands.sfn:_inline_relative_imports_cmd` and
`cli_commands_utils.sfn:_is_stdlib_capsule_cmd`:

- **Relative** (`./foo`, `../foo`) → resolve against the source file's
  directory.
- **Stdlib bare** (`http`, `fs`, `test`, …) → rewritten to `sfn/<name>`
  and resolved against `capsules/sfn/<name>/src/mod.sfn`. The stdlib list
  is a hard-coded allowlist.
- **Stdlib scoped special-case** (`sfn/cli`, `sfn/http`, … for names in
  the stdlib allowlist) → resolved directly against the in-tree
  `capsules/sfn/<name>/src/mod.sfn`, bypassing both `capsule.toml` and
  the user cache.
- **Scoped, non-stdlib** (`acme/router`) → looked up in the nearest
  `capsule.toml` (walking up from the source directory), then resolved
  under `~/.sfn/cache/capsules/<scope>/<name>/<version>/src/mod.sfn`.
  Prefers `capsule.lock` over `capsule.toml` when both are present.

### 1.3 Running tests (`sfn test`)

`sfn test` in `cli_commands.sfn:handle_test_command` walks a directory for
`*_test.sfn` files and, for each one:

1. Runs the same textual import inliner used by `sfn run`.
2. Compiles to LLVM IR via `compile_tests_to_llvm_file_with_module`.
3. Links via `_clang_link_test_cmd`, which is subtly different from
   `sfn build`'s link: it **weakens** the self-hosted compiler's
   `native.linked.o` (`llvm-objcopy --weaken`) and links it in so that
   symbols from the inlined test sources override the weakened compiler
   symbols. This lets tests share the compiler's runtime without fighting
   linker conflicts.

### 1.4 Capsules today

`capsules/sfn/*` contains the first-party stdlib
(`cli`, `crypto`, `fmt`, `fs`, `http`, `json`, `layers`, `log`, `losses`,
`math`, `net`, `nn`, `os`, `path`, `sync`, `tensor`, `test`, `time`,
`toml`). Each has:

- `capsule.toml` — `[capsule]`, `[dependencies]`, `[capabilities]`,
  `[build] entry = "src/mod.sfn"`.
- `src/mod.sfn` — the single entry module (most capsules today are
  single-file).

The compiler binary carries a hard-coded allowlist of stdlib capsule names.
Third-party capsules live in `~/.sfn/cache/capsules/<scope>/<name>/<version>/`
after `sfn add` downloads a `.sfnpkg` from the configured registry
(`pkg.sfn.dev` by default) and writes an entry to `capsule.lock`.


---

## Part 2 — Problems

### 2.1 Two build systems

Historically the compiler's build graph was resolved by the prior
`scripts/build.sh` (since retired in Stage E PR7) — bash, capsule-aware,
producing real per-module `.ll` artifacts. A user program's build graph
was resolved by `inline_imports_for_source` (Sailfin, textually inlining
everything into one synthetic source). The two disagreed on most
things that matter:

| Concern | `build.sh` | `sfn build` / `run` |
|---|---|---|
| Unit of compilation | per-module `.ll` | single concatenated blob |
| Cross-module type info | `.sfn-asm` + `.layout-manifest` | none (textual inlining reconstructs it) |
| Dependency discovery | `[dependencies]` in `capsule.toml` | hard-coded stdlib allowlist + lockfile walk |
| Cache granularity | module (implicit, via file mtime) | none (rebuild every time) |
| Memory budget | per-module 12 GB cap | single-process, unbounded |
| Parallelism | xargs `-P $JOBS` | sequential, one file at a time |
| Runtime link | explicit object list | `_clang_link` with fallback path probes |

This is the central defect: the compiler itself cannot be built with
`sfn build`. The workaround (a bash orchestrator) duplicates the build
graph logic, meaning every capsule-system improvement has to land in two
places.

### 2.2 Stdlib is a compiler-internal allowlist

`_is_stdlib_capsule_cmd` in `compiler/src/cli_commands_utils.sfn` is a
hard-coded list of bare names. The resolver logic that maps
`import … from "http"` to `capsules/sfn/http/src/mod.sfn` is in the
compiler binary. Adding or renaming a stdlib capsule is a compiler change,
not a registry change. The stdlib is also not versioned independently of
the compiler; `sfn/http@0.2.1` is what you get whenever you're on that
compiler build, period.

### 2.3 Textual import inlining has the wrong semantics

`sfn run` and `sfn test` concatenate sources rather than compiling modules
separately. Consequences:

- Every test payload is recompiled from scratch — no benefit from the
  import-context the main build already paid to compute.
- Name collisions across inlined modules must be prevented by convention
  because the combined buffer has one global namespace.
- Diagnostics reference positions in the synthetic buffer, not the original
  file. Source maps exist only implicitly via module markers.
- The technique cannot support module-level privacy, separate linkage, or
  per-module `![effect]` enforcement.

### 2.4 Process-per-module is a cost floor

For the compiler's own build, `build.sh` spawns one seed process per
module — currently 121 — and each pays:

- Full runtime init (hash tables, mutex, arena if enabled).
- A full import-context directory copy (121 × ~1 MB of `.sfn-asm`).
- Re-parsing every transitively-imported `.layout-manifest` from scratch.

`docs/proposals/0006-build-architecture.md` §2.4 identifies this as Root Cause 6. The only
reason it is still Phase 5 on the fix plan is that every earlier phase
requires a memory manager that the runtime doesn't have yet.

### 2.5 Build script contains fixups that hide compiler bugs

The `EMIT_RETRIES` loop in `build.sh` retries seed invocations up to three
times on empty output, bad headers, or mid-file IR corruption, and
captures failing outputs to `$CORRUPTED_DIR` for analysis. This is in
direct tension with the "fix the compiler, not the build script" rule in
`.claude/rules/selfhost-invariant.md`: the script *is* fixing up the
compiler, just at a coarse granularity. Until the underlying
nondeterminism is eliminated, removing the retry loop is a regression;
but every day it stays in place, the signal that a compiler bug exists
gets absorbed as "normal noise".

The same applies to `compile_to_llvm_file_with_module` in `main.sfn`,
which has a fallback path for "try the structured pipeline; if that
looks corrupted, prepend a header; if that still looks corrupted, try
`compile_to_llvm_with_module` as a string-return fallback". Every one
of those branches is a live bug the driver is papering over.

### 2.6 Runtime bundle coupling

`sfn build`'s `_clang_link` step needs four inputs from the runtime
bundle: `include/`, `src/sailfin_runtime.c`, `ir/runtime_globals.ll`,
and `obj/prelude.o`. `sfn test`'s `_clang_link_test_cmd` has a broader
coupling — it additionally pulls in `src/sailfin_sha256.c` and
`src/sailfin_base64.c` (every `.c` under `src/` except `native_driver.c`,
which supplies the binary's `main` and is excluded in the test path).
The compiler's own self-host build (formerly the now-retired
prior `scripts/build.sh`; now via the driver's
`_clang_link_multi_with_opt`) links every runtime source including
`native_driver.c`. So the runtime bundle was historically three
different shapes depending on which code path consumed it.

The installer copies these assets to `runtime/native/` next to the
binary and resolves at runtime by probing six candidate paths in
`_runtime_prelude_path`. This is fine for a C runtime — it has to be
fine because the C runtime is what exists — but when the runtime moves
to Sailfin, the link model has to change. If we plan for that now, the
transition is a capsule-resolution problem, not a link-script rewrite.

### 2.7 `sfn build` is single-file

`sfn build foo.sfn -o foo` takes one file and produces one binary. It
does not:

- Read `capsule.toml` to find the entry point.
- Resolve `[dependencies]` at all (only `sfn run` does).
- Produce a library artifact (no `.a`, no re-linkable object).
- Support test-only or dev-only dependencies.
- Emit a reusable `.sfn-asm` + `.layout-manifest` for downstream consumers.

A "build" command in every other modern toolchain (cargo, go, zig) takes a
project manifest and produces whatever the manifest declares. Ours takes a
file.

### 2.8 Make is a second orchestrator layered on top of `build.sh`

The 615-line Makefile exists because `sfn` is incomplete. It glues
together `build.sh` (compile), `install.sh` (seed fetch), `tools/package.sh`
(package), `scripts/run_native_test.sh`
(test), `scripts/test_arena.sh` (arena gate), plus an inline 100-line
MinGW cross-compile branch for Windows. Every target is a thin shell
wrapper around a dedicated script.

This is the classic "tooling grown into the scar tissue of missing
language tooling" pattern. Cargo users don't run `make build`. Go users
don't run `make build`. When `sfn build`, `sfn test`, `sfn package`,
`sfn bench` exist as first-class commands, the Makefile serves no
purpose — its targets either disappear or reduce to a one-line `sfn X`
invocation.

### 2.9 Stdlib versioning is bolted to compiler releases

Because `_is_stdlib_capsule_cmd` is a hard-coded compiler allowlist, the
stdlib cannot ship patches between compiler releases. Fixing a bug in
`sfn/http` requires cutting a new compiler version, because the stdlib
capsules are installed as part of the compiler tree, not resolved from
the registry. This kills any hope of:

- Shipping `sfn/http@0.2.2` as a point release.
- Running an old compiler against a newer stdlib capsule.
- Letting stdlib capsules have independent deprecation cycles.

The ecosystem constraint is much worse than it looks at first glance:
every stdlib contributor is gated on a full compiler release cycle.

### 2.10 `sfn test` weakens compiler symbols with `llvm-objcopy`

`_clang_link_test_cmd` in `cli_commands.sfn` runs
`llvm-objcopy --weaken` against the self-hosted compiler's
`native.linked.o` and links it into every test binary. This works because
the compiler binary happens to contain every symbol any compiler test
might need — the runtime helpers, the parser exports, the AST
constructors. Weakening lets test-provided symbols (from inlined test
imports) override the compiler's copies at link time.

This is a scary hack:

- It only works for tests of the compiler itself. A third-party capsule's
  tests can't weaken the compiler binary because they don't want the
  compiler's exports in scope.
- It ties tests to a specific build of the compiler — if a symbol is
  renamed, every test's link breaks until the compiler is rebuilt.
- It is a concrete blocker on separating the compiler into a
  `sfn/compiler-lib` capsule, because the library can't be linked in as
  a normal dep when tests expect the whole compiler as a weak object.

### 2.11 `runtime/prelude.sfn` is privileged and invisible

`runtime/prelude.sfn` is Sailfin source, not C. But it is not a capsule.
It has:

- A hard-coded location (`runtime/prelude.sfn`, not under `capsules/`).
- A hard-coded module name (`runtime__prelude` in `build.sh`'s slug
  function).
- A special link position (compiled separately, linked after
  `native.linked.o`, never included in llvm-link's merge).
- An implicit dependency from every other compile (the prelude's
  symbols are assumed to be in scope for every module).

From a build system perspective, the prelude is the hairiest module in
the tree because nothing declares its relationship to anything else. A
proper capsule model would make it `sfn/prelude` — a capsule every
compile implicitly depends on, built and linked the same way as every
other dep.

### 2.12 Cross-compilation is a Makefile branch

The `ci-cross-windows` target in the Makefile is ~100 lines of inline
shell that reuses the Linux `.ll` files, runs `llvm-link`, cross-compiles
C runtime with `x86_64-w64-mingw32-gcc`, and links. There is no
corresponding macOS-arm64 or wasm target — adding one requires another
100-line branch.

The future state has `sfn build --target=<triple>`, but every line of
that Makefile target is a decision the driver needs to make
declaratively: which runtime capsule per target, which C compiler, which
linker flags, which system libs. The Makefile encodes those decisions
in shell; the driver should encode them in manifests.

### 2.13 Compiler sub-directories are effectively hidden sub-capsules

`compiler/src/` has nested trees: `llvm/` (~16 files), `lowering/`
(phase-structured), `parser/` (phase-structured), `expression_lowering/`,
`tools/`. These directories are *de facto* sub-capsules — each has
tight internal cohesion and a thin interface to its siblings. But they
are not capsules:

- They share the compiler's single `capsule.toml`.
- They cannot be built independently or cached independently.
- A change to one forces a full re-emit of the entire compiler.

In a capsule-aware world, splitting the compiler into
`sfn/compiler-parser`, `sfn/compiler-typecheck`, `sfn/compiler-emit`,
`sfn/compiler-llvm`, etc. would:

- Make the compiler's dep graph visible to the build system.
- Let `sfn build --jobs=N` parallelize across sub-capsules, not just
  modules.
- Cap per-capsule memory usage (today `lowering_core.sfn` alone can
  consume 7 GB).
- Let tests depend on just the sub-capsule they exercise, not the whole
  compiler.

This is a Stage F-style cleanup, but the manifest schema should permit
it from day one.


---

## Part 3 — Design Principles

The future system should satisfy the following, in priority order:

1. **One build driver.** `sfn build` is the only code path that turns
   sources into artifacts. The prior `scripts/build.sh` was deleted in
   Stage E PR7 (#383), not shrunk; it is retired. The bootstrap is a
   Makefile target (or `sfn bootstrap` subcommand) that fetches a seed
   and invokes `seed sfn build -p compiler`.
2. **No orchestration layer above `sfn`.** The Makefile retires in
   parallel with `build.sh`. Anything `make X` does today becomes either
   a `sfn X` subcommand or a one-line convenience wrapper. Steady-state
   contributors type `sfn build`, not `make compile`.
3. **Capsule is the unit of compilation.** A capsule is defined by its
   `capsule.toml`. Builds produce one artifact per capsule plus a
   dependency manifest; the driver composes them.
4. **Build graph is explicit and machine-readable.** The driver can emit
   the dependency graph, the cache keys, and the per-module timings as
   structured output. No free-form stderr parsing.
5. **Stdlib is a registry fact, not a compiler fact.** The compiler does
   not know which capsules are stdlib; it knows how to resolve
   `scope/name` specs against a configured set of sources (workspace
   tree, cache, registry). Stdlib capsules version independently from the
   compiler — patches and minor versions ship without a compiler release.
6. **One resolver, two modes.** Intra-capsule and inter-capsule imports
   go through the same resolver. The only difference is whether the
   source lives in the current capsule's `src/` or a dependency's `src/`.
7. **In-process by default, subprocess only when required.** The
   long-lived driver compiles all modules in one process, shares parsed
   imports, and resets the arena between modules. A subprocess is spawned
   only when the user asks for it (e.g., `sfn build --isolate-modules`
   for debugging corruption).
8. **Cache is content-addressed.** Cache keys are
   `hash(source, resolved_deps, compiler_version, flags)`. The driver
   never trusts mtime.
9. **Runtime and prelude are capsules.** The C runtime stays as
   `sfn/runtime-native` until the Sailfin rewrite lands; `runtime/prelude.sfn`
   becomes `sfn/prelude` immediately. No privileged locations, no hard-coded
   module names, no magic link order — the manifest declares the facts.
10. **Cross-compilation is a manifest property.** `sfn build --target=<triple>`
    selects a per-target runtime capsule, toolchain, and link profile from
    declarative data. No shell branches.
11. **Tests are normal capsules.** `sfn test` depends on `sfn/test` as a
    library, not on weakened symbols from the compiler binary. The
    `llvm-objcopy --weaken` path retires with textual import inlining.
12. **Fix-ups belong in the compiler.** The driver does not retry on
    miscompilation, does not post-process IR, and does not have fallback
    paths for "try X, if that doesn't work try Y". If the compiler emits
    invalid IR, the build fails — loudly, with the IR attached.
13. **Link-time errors are structured diagnostics.** Clang stderr is
    parsed into `{severity, file, span, message, kind}` entries and
    merged into the driver's diagnostic stream. `sfn build --json` emits
    link errors the same way it emits parse errors.


---

## Part 4 — Future State: Unified `sfn build`

### 4.1 Command surface

```
# Build pipeline
sfn build                    # build the capsule in the current directory
sfn build -p <capsule>       # build a specific capsule by name or path
sfn build --release          # optimized build (default is debug)
sfn build --emit=ir          # emit .sfn-asm + .layout-manifest, no link
sfn build --emit=obj         # emit .o, no link
sfn build --emit=bin         # default; produce an executable/library
sfn build --target=<triple>  # cross-compile
sfn build --jobs=N           # parallel module compilation (default: nproc)
sfn build --json             # structured build report on stdout
sfn build --isolate-modules  # subprocess per module (diagnostic only)
sfn build --check-determinism # build twice, diff IR hashes

# Derived from build
sfn run                      # sfn build --emit=bin, then exec
sfn test                     # sfn build with dev-deps, exec test binaries
sfn check                    # sfn build stopping after typecheck + effects
sfn fmt                      # (exists) format sources

# Registry / workspace
sfn add <capsule>            # (exists) add a dependency
sfn init                     # (exists) scaffold a capsule
sfn publish                  # (exists) publish to registry
sfn login                    # (exists) store registry token
sfn bootstrap                # fetch a seed binary (replaces install.sh for
                             #   users who already have an older sfn)

# Release / distribution
sfn package                  # produce distributable tarballs
                             #   (replaces tools/package.sh)
sfn bench                    # run benchmarks
                             #   (replaces scripts/bench_compile.sh)
```

`sfn run`, `sfn test`, `sfn check` all delegate to the same build pipeline
and only differ in what they do with the artifact:

- `sfn run` → `sfn build --emit=bin`, then execute the binary.
- `sfn test` → `sfn build` with dev-deps enabled, then execute each
  test binary (or one combined test binary — see §4.6).
- `sfn check` → `sfn build --emit=ir` stopping after typecheck + effects,
  no codegen.

`sfn package` and `sfn bench` subsume `tools/package.sh` and
`scripts/bench_compile.sh` respectively. Together with `sfn bootstrap`
replacing `install.sh` for updates, this leaves zero build-related shell
scripts in steady state. (`install.sh` stays as a one-shot first-install
curl target for users who don't have `sfn` yet.)

### 4.2 Capsule manifest (extended)

```toml
[capsule]
name = "sfn/http"
version = "0.2.1"
description = "HTTP client and server for Sailfin"

[capabilities]
required = ["io", "net"]

[build]
# Existing — the entry module.
entry = "src/mod.sfn"
# New — what to produce.
kind = "library"          # "library" | "binary" | "mixed"
# New — optional explicit output name for binaries.
# bin-name = "httpd"

[dependencies]
"sfn/strings" = "0.3.0"

[dev-dependencies]
"sfn/test" = "0.4.0"

[targets.wasm32-unknown-unknown]
# Per-target overrides (optional).

[workspace]
# Only present in workspace-root manifests.
members = ["compiler", "capsules/sfn/*"]
```

The compiler's own manifest becomes a workspace root that declares the
runtime, prelude, and stdlib capsules as workspace members. The compiler
capsule itself lists them as dependencies. This makes `make compile`
equivalent to `sfn build -p compiler` with all dependencies resolved from
the workspace.

### 4.3 Driver architecture

The driver is a Sailfin function, not a shell script. Call graph:

```
sfn build
 └─ driver::build_capsule(capsule_ref)
     ├─ manifest::load(path) → Manifest
     ├─ resolver::resolve(manifest) → ResolvedGraph
     │    (workspace → workspace.lock → capsule.lock → cache → registry,
     │     in that order)
     ├─ planner::plan(graph) → BuildPlan
     │    (topologically ordered module list + cache keys)
     ├─ executor::execute(plan) → Artifacts
     │    ├─ for each module (in parallel, bounded by --jobs):
     │    │   ├─ cache::lookup(key) → hit? use it
     │    │   ├─ parser::parse(source) → AST
     │    │   ├─ typecheck::check(ast, imports) → TypedAST
     │    │   ├─ effects::validate(typed_ast) → EffectReport
     │    │   ├─ emit::native(typed_ast) → .sfn-asm + .layout-manifest
     │    │   ├─ lower::llvm(native_ir) → .ll
     │    │   └─ cache::store(key, artifacts)
     │    └─ linker::link(artifacts, manifest.kind) → Binary | Library
     └─ report::summarize(plan, artifacts)
```

Key points:

- The driver is **one process**. Modules share parsed imports, the arena,
  and the cache.
- **Resolution order** (shipped: #1048 capsule.lock, #1071 workspace.lock):
  workspace siblings resolve first and short-circuit — a lockfile can never
  redirect an intra-workspace edge (e.g. compiler → runtime). For external
  deps, a root `workspace.lock` pin wins over the consuming capsule's
  `capsule.lock`, which wins over the `capsule.toml` version range; then
  the user cache, then the registry. Absent lockfiles are a no-op —
  resolution is byte-identical to the pre-lockfile behaviour.
- **Lockfile ownership**: the workspace root (or a standalone binary
  capsule's root) owns the lockfile — `sfn lock` (#1070) writes
  `workspace.lock` at the workspace root only. Library capsules do **not**
  commit lockfiles; their version *ranges* live in `capsule.toml`, and the
  consuming root decides the pins. (Same rule as Cargo/npm: applications
  commit lockfiles, libraries don't.)
- **Seed gate (self-host hazard)**: `make compile` runs `<seed> build -p
  compiler`, so the *pinned seed's* resolver reads any committed root
  `workspace.lock` during self-host. Do **not** commit a root
  `workspace.lock` until a seed embedding the #1071 consumer is pinned —
  a pre-consumer seed would either choke on or silently ignore the file,
  and the two-pass seedcheck would diverge from the first pass. Satisfied
  as of seed `v0.7.0-alpha.31` (contains #1071); committing the root
  lockfile itself is #1050.
- Each module's work is a pure function from `(source_hash, dep_hashes,
  flags)` to `(sfn-asm, layout-manifest, ll)`. Pure inputs → cacheable.
- Parallelism is opt-in per phase. Parser/typecheck can be parallel once
  imports are resolved; emit is embarrassingly parallel within a capsule.
- `linker::link` knows what kind of artifact to produce. For a library
  capsule, the artifact is a collection of `.sfn-asm`, `.layout-manifest`,
  and object files that consumers can link against. For a binary, it
  links against the transitive closure of library artifacts.

### 4.4 Artifact layout

Per-capsule artifacts live in `<workspace>/build/capsules/<scope>/<name>/`:

```
build/capsules/sfn/http/
├── manifest.json          # resolved deps, compiler version, cache keys
├── ir/
│   ├── mod.sfn-asm
│   └── mod.layout-manifest
├── obj/
│   └── mod.o
└── bin/                   # only if kind = "binary"
    └── httpd
```

The compiler capsule gets the same layout:

```
build/capsules/sfn/compiler/
├── manifest.json
├── ir/
│   ├── main.sfn-asm
│   ├── parser/mod.sfn-asm
│   └── ...                # one per module
├── obj/
│   └── compiler.linked.o  # after llvm-link
└── bin/
    └── sailfin
```

The `.sfn-asm` + `.layout-manifest` pair replaces the current
`build/compiler/import-context/` staging directory. Every consumer reads
from `build/capsules/<dep>/ir/` for the dep's exported interface.

### 4.5 Resolver: one path for all imports

```
import { handle_get } from "sfn/http";   // dependency
import { split_lines } from "./utils";   // intra-capsule
import { spec_id } from "../ast";        // intra-capsule (parent dir)
```

Resolution algorithm:

1. If spec starts with `./` or `../`, resolve against the importer's
   directory. Must stay inside the importer's capsule (error if it
   escapes).
2. Otherwise, split on the first `/` into `scope/name[/rest]`.
3. Look up `scope/name` in the resolved dep graph:
   - Workspace members (always available).
   - `[dependencies]` / `[dev-dependencies]` from the current capsule's
     manifest, pinned by `capsule.lock`.
   - Resolution sources: local workspace, user cache
     (`~/.sfn/cache/capsules/...`), registry.
4. If `rest` is empty, load the dep's `[build].entry`. If `rest` is
   given, resolve it as a submodule path under the dep's `src/`.

The compiler does **not** carry a stdlib allowlist. Instead, a shipped
workspace file (installed alongside the binary) declares `sfn/*` as
workspace members pointing at the bundled capsule sources. Users can
override this by putting a `workspace.toml` in their project.

### 4.6 Test execution

`sfn test` runs the same build pipeline with two adjustments:

- `[dev-dependencies]` are merged into the active dep graph.
- The executor's link phase produces a test binary per test file (or a
  single combined binary if `[test].bundle = true`). The test runner is
  itself a capsule (`sfn/test` today) that the driver depends on.

Textual import inlining in `cli_commands.sfn` goes away. Tests compile
like any other module; the test runner provides the harness via a
library dep, not by being concatenated into the source buffer.

### 4.7 Runtime as a capsule

Today the C runtime is a magic directory (`runtime/native/`) that the
linker probes for by path. In the new model it is declared as:

```toml
# workspace root
[workspace]
members = ["compiler", "runtime-native", "capsules/sfn/*"]

# runtime-native/capsule.toml
[capsule]
name = "sfn/runtime-native"
version = "0.5.4"

[build]
kind = "runtime"                 # new kind
c-sources = [
  "src/sailfin_runtime.c",
  "src/sailfin_sha256.c",
  "src/sailfin_base64.c",
  "src/native_driver.c",
]
ll-sources = ["ir/runtime_globals.ll"]
# sfn-sources = ["../sfn/io.sfn", "../sfn/clock.sfn"]  # dormant; PR 2 enables
prelude-entry = "../runtime/prelude.sfn"
```

The driver's link phase reads this and produces the same output the bash
script produces today, but declaratively. When the Sailfin runtime rewrite
lands, `c-sources` is replaced with `entry = "src/mod.sfn"` and the link
step loses a special case.

The `sfn-sources` field is the Sailfin-side counterpart to `c-sources`.
Each entry points at a `.sfn` module the runtime capsule wants compiled
and linked alongside its C/LL surface. **Schema status (2026-05-04):**
the TOML getter, the `RuntimeCapsuleArtifacts.sfn_sources` resolver
field, and `_rcr_normalize_path` for canonical workspace-rooted output
are all in place. **No driver consumes the field yet** — the link-time
compile loop that subprocess-spawns the running compiler to emit
`.ll` for each entry is gated on issue #308's IPC-isolation track
(parent-compiler-spawning-child-compiler currently races on shared
`build/sailfin/.foo` scratch state, producing miscompiled IR).
PR 2 of the sleep migration introduces both halves — the link
loop and the manifest population — once #308 lands.

`prelude-entry` is the transitional Stage D bridge for the prelude —
once the prelude moves under `capsules/sfn/prelude/` (Stage F per §4.8),
the field retires and the prelude joins the dep graph as an implicit
library. `sfn-sources` then becomes the only path runtime modules ship
through until the C runtime itself is rewritten (M3) and the entire
runtime capsule flips to `kind = "library"` with `entry = "src/mod.sfn"`.

### 4.8 Prelude as a capsule

`runtime/prelude.sfn` becomes `sfn/prelude`:

```toml
# capsules/sfn/prelude/capsule.toml
[capsule]
name = "sfn/prelude"
version = "0.5.4"
description = "Sailfin standard prelude (collections, strings, type checks)"

[capabilities]
required = []

[build]
kind = "library"
entry = "src/mod.sfn"
implicit = true                  # implicit dep of every compilation
```

`implicit = true` signals that the driver adds this capsule to every
build's dep graph automatically — the same effect the current magic
prelude link achieves, but driven by the manifest instead of hard-coded
paths. A user with a custom `workspace.toml` can override `sfn/prelude`
for embedded targets.

Side effects:

- `slug_from_path` in `build.sh` loses its special case for
  `runtime__prelude`.
- The compiler's import resolver loses the implicit `runtime/*` branch;
  prelude symbols are in scope because `sfn/prelude` is an implicit dep,
  not because of path magic.
- Packaging no longer has a "copy prelude.o to its own location" step;
  the prelude is an ordinary artifact in `build/capsules/sfn/prelude/obj/`.

### 4.9 Cross-compilation

```
sfn build --target=x86_64-w64-mingw32
sfn build --target=aarch64-apple-darwin
sfn build --target=wasm32-unknown-unknown
```

The driver consults `[targets.<triple>]` in the manifest, which may
override:

- The resolved runtime capsule (e.g., `sfn/runtime-wasm` for wasm32).
- The C toolchain (`cc`, `ar`, `ld`) for any `kind = "runtime"` dep.
- Optimization flags and link flags.
- Additional system libraries.

```toml
[targets.x86_64-w64-mingw32]
runtime = "sfn/runtime-native"
cc = "x86_64-w64-mingw32-gcc"
link-libs = ["-static"]

[targets.wasm32-unknown-unknown]
runtime = "sfn/runtime-wasm"
cc = "clang"
cc-flags = ["-target", "wasm32-unknown-unknown"]
```

The 100-line `ci-cross-windows` Makefile target reduces to
`sfn build --target=x86_64-w64-mingw32 --release && sfn package --target=x86_64-w64-mingw32`.

### 4.10 Compiler decomposition into sub-capsules

The compiler's own source tree is organized into workspace members:

```
compiler/
├── capsule.toml                 # sfn/compiler — the binary entry
├── src/cli_main.sfn             # thin driver over the sub-capsules
├── parser/capsule.toml          # sfn/compiler-parser
├── parser/src/...
├── typecheck/capsule.toml       # sfn/compiler-typecheck
├── typecheck/src/...
├── emit/capsule.toml            # sfn/compiler-emit
├── emit/src/...
└── llvm/capsule.toml            # sfn/compiler-llvm
    └── src/...
```

Benefits:

- Each sub-capsule has its own dep graph, own cache key, own parallel
  worker slot.
- Tests for the parser depend on `sfn/compiler-parser`, not the whole
  compiler. `llvm-objcopy --weaken` has no excuse to exist.
- Per-capsule memory caps bound the worst-case compile footprint (today
  `lowering_core.sfn` alone hits 7 GB; isolated in a sub-capsule, it
  still hits 7 GB, but it can't starve its siblings).
- Sub-capsules can be published independently for tooling
  (`sfn/compiler-parser` is useful to LSP and `sfn check` consumers).

This is Stage F-plus work — the schema supports it from Stage A, but
the actual decomposition is a late-cycle cleanup.

### 4.11 Structured link diagnostics

Clang's stderr is currently the user's first signal that a link failed.
The driver normalizes it into the same diagnostic schema the compiler
already produces:

```json
{
  "severity": "error",
  "kind": "link/undefined-symbol",
  "message": "undefined reference to 'sailfin_runtime_foo'",
  "artifacts": ["build/capsules/sfn/http/obj/mod.o"],
  "hint": "Missing dep? Check [dependencies] in capsules/sfn/http/capsule.toml"
}
```

The driver ships a small number of link-error recognizers:

- Undefined symbol → hint "check your `[dependencies]`" or "did you
  forget to `sfn add`?".
- Multiple definition → hint "symbol `X` defined in both caps `A` and
  `B`; rename or re-export".
- Missing runtime object → hint "`sfn/prelude` did not produce
  `prelude.o`; try `sfn build --clean`".

Unknown link errors pass through as `kind = "link/unknown"` with the
raw clang line attached. `sfn build --json` emits all of them the same
way it emits parse errors, making `sfn lsp` and MCP integrations
able to act on link failures.

### 4.12 Caching and determinism

- Cache key per module:
  `sha256(source)` ⊕ `sha256(each resolved dep's .layout-manifest)` ⊕
  `compiler_version` ⊕ `canonical(flags)`.
- Cache store: `<root>/<key[0..2]>/<key>/{ir.sfn-asm,layout.manifest,mod.ll,mod.o}`
  — one directory per key, sharded by the 2-char key prefix. `<root>` already
  includes the schema suffix (`.../v2`) and defaults to a shared per-user
  directory (`$XDG_CACHE_HOME/sailfin/v2` or `$HOME/.cache/sailfin/v2`;
  `$SAILFIN_BUILD_CACHE_DIR` override; in-tree `build/cache/v2` fallback and for
  the compiler self-host build — SFEP-0040 §3.1).
- Cache hits skip parse, typecheck, effect, emit, and clang. They do not
  skip link.
- `--no-cache` disables the lookup but still writes. `--clean` wipes the
  cache before building.
- The build report (`--json`) lists cache hits/misses per module. CI can
  fail the build if the hit rate drops below a threshold (regression
  signal).
- `sfn cache info/prune/clean` (SFEP-0040 §3.2–3.4) provides bounded-size GC
  over this same store: `info` reports the resolved root, entry count, and
  total on-disk size; `prune [--max-size <bytes>] [--max-age <days>]` evicts
  entries oldest-first by mtime (touched on cache hit, so eviction order is
  true LRU) down to a size/age bound, opt-in only (no implicit prune on
  ordinary builds); `clean [--all-schemas]` extends `--clean` to optionally
  sweep stale sibling `v<M>` schema trees as well as the current one.

Determinism: the fixed-point check currently in `make check` (stage2 vs
stage3 IR hashes) becomes a first-class assertion of the driver. If two
consecutive builds with the same inputs produce different IR hashes,
`sfn build --check-determinism` fails.


---

## Part 5 — Migration Path

The transition is staged so that at every step the compiler still builds
itself and the test suite still passes. Each stage ships independently
and is individually revertible.

### Stage A — Manifest & workspace schema (no behavior change)

**Goal:** Make the declarative future expressible without changing how
builds actually run.

This stage ships parse-only. No consumers, no resolver changes, no
behavior change in `make compile`, `sfn build`, `sfn run`, or `sfn test`.
Its only job is to put the schema on disk so Stage B can lean on it.

#### Concrete work (sized **size:s**, type:refactor)

**In:**

- Extend `compiler/src/toml_parser.sfn` to accept and round-trip the new
  manifest fields:
  - `[build].kind` — string, one of `"binary" | "library" | "runtime"`
  - `[build].implicit` — boolean
  - `[workspace].members` — string array (glob-friendly: `"capsules/sfn/*"`)
  - `[dev-dependencies]` — same shape as `[dependencies]`
  - `[targets.<triple>]` — table with optional `runtime`, `cc`, `cc-flags`,
    `link-libs`
  - `[exports]` — string array (re-export allowlist; submodule paths)
- Add a `ManifestExtensions` accessor module (or extend the existing
  manifest reader in `capsule_resolver.sfn` / `cli_commands.sfn`) so a
  caller can ask "does this manifest declare a workspace?" without
  re-parsing. **No call sites yet** — this is a getter that returns
  `None`/empty for every existing manifest.
- Create `workspace.toml` at the repo root with members:
  ```toml
  [workspace]
  members = [
      "compiler",
      "runtime-prelude",
      "capsules/sfn/*",
  ]
  ```
- Create `capsules/sfn/prelude/capsule.toml` (or, equivalently,
  `runtime-prelude/capsule.toml` — pick one path and stick with it):
  ```toml
  [capsule]
  name = "sfn/prelude"
  version = "0.5.9"
  description = "Sailfin standard prelude (collections, strings, type checks)"
  [capabilities]
  required = []
  [build]
  kind = "library"
  entry = "../runtime/prelude.sfn"   # or move the file; see open question below
  implicit = true
  ```
- Set the compiler's own `compiler/capsule.toml` to declare
  `[build].kind = "binary"` (still no consumer; documents intent).
- Add round-trip unit tests in `compiler/tests/unit/toml_parser_test.sfn`
  covering each new field, plus a workspace-load test in
  `compiler/tests/unit/manifest_workspace_test.sfn`.

**Out (explicitly deferred to Stage B):**

- The resolver does not learn about workspace members yet — keep the
  hard-coded `_is_stdlib_capsule_cmd` allowlist.
- `inline_imports_for_source` stays as the fallback in `cli_main.sfn:590`.
- `sfn build -p <path>` is not added.
- The `llvm-objcopy --weaken` path stays.
- No changes to the prior `scripts/build.sh` (since retired in Stage E PR7) or the Makefile.
- Do not move `runtime/prelude.sfn` on disk yet (the manifest's `entry`
  can point at the existing path with `..`). Moving it is a Stage B
  concern because every consumer's slug changes.

#### Files affected

- `compiler/src/toml_parser.sfn` (extend)
- `compiler/tests/unit/toml_parser_test.sfn` (extend)
- `compiler/tests/unit/manifest_workspace_test.sfn` (new)
- `workspace.toml` (new, repo root)
- `capsules/sfn/prelude/capsule.toml` (new)
- `compiler/capsule.toml` (add `[build].kind = "binary"`)

#### Verification

- `ulimit -v 8388608 && make compile` — unchanged behavior.
- `ulimit -v 8388608 && make test-unit` — new tests pass.
- `ulimit -v 8388608 && make check` — fixed-point still holds.
- Manual: `build/bin/sfn emit native workspace.toml` is **not**
  expected to do anything meaningful; this stage adds parsing, not
  loading semantics.

#### Exit criteria

- New manifest fields round-trip through `toml_parser.sfn` (covered by
  unit tests).
- `workspace.toml` and `capsules/sfn/prelude/capsule.toml` both parse
  without error and produce the expected struct.
- `make compile && make check` passes with no behavior delta.
- The compiler binary size delta is negligible (< 1% — schema-only).

#### Open question to resolve in this stage's PR

- **`sfn/prelude` directory layout.** Either keep `runtime/prelude.sfn` in
  place and have the new manifest's `entry` point at it via `..`, or move
  it to `capsules/sfn/prelude/src/mod.sfn` now. Moving it changes every
  consumer's import slug and `build.sh`'s `slug_from_path` special case
  for `runtime__prelude`, which is squarely Stage B territory. Default to
  **keep in place**; revisit at Stage B start.

### Stage B — Real resolver, retire textual inlining and the weaken hack

**Goal:** One import-resolution code path, used by every CLI command.

`compiler/src/capsule_resolver.sfn` already covers manifest-declared
capsule deps (separate-compile via `discover_project_root` →
`enumerate_capsule_sources` → `stage_capsule_imports` →
`compile_capsule_modules`). Stage B unifies it with the relative-import
walker and teaches it to consume the workspace file Stage A produces.

Stage B splits into two PRs to keep the libextract risk isolated from
the resolver wiring:

#### Stage B PR1 — resolver + sfn build/run (shipped on `claude/build-stage-b-hlXw1`)

- Workspace machinery in `capsule_resolver.sfn`: `WorkspaceMember`,
  `parse_workspace_member_paths`, `discover_workspace_root`,
  `load_workspace_members`, `workspace_member_for_spec`.
- Relative-import scanner + walker in `capsule_resolver.sfn`:
  `collect_relative_import_specs`, `resolve_relative_import`,
  `enumerate_relative_sources(entry_path)`.
- Workspace-implicit imports in `capsule_resolver.sfn`:
  `collect_scoped_import_specs`,
  `enumerate_workspace_implicit_sources(entry, members, excluded_specs)`
  — replaces the hard-coded stdlib allowlist as the source of truth for
  which `sfn/X` imports resolve without an explicit `[dependencies]`
  entry.
- `prepare_project_capsules(input_path)` orchestrator combines (1)
  relative imports, (2) manifest-declared capsule deps, (3)
  workspace-implicit imports into one staged + compiled set.
- `sfn build` and `sfn run` consume the unified resolver. The
  `inline_imports_for_source` text-fallback path in `sfn run` is
  **deleted**.
- `sfn build -p <capsule-path>` reads `[build].entry` + `[build].kind`
  from the capsule manifest. `kind = "library"` emits a `.o` via
  `clang -c`; `kind = "binary"` (default) links as before; `kind =
  "runtime"` errors with a Stage F deferral note.
- All 19 stdlib `capsules/sfn/*` manifests gain `[build].kind =
  "library"`.
- 27 new unit tests across `workspace_resolver_test.sfn` and
  `relative_import_resolver_test.sfn` (inlined helpers, mirroring
  `stdlib_capsule_allowlist_test.sfn` — the resolver imports `./main`
  so direct importing in a unit test pulls in the whole compiler and
  trips the seed's per-module timeout).

#### Stage B PR2 — sfn test, sfn check, A4 helper deletion (shipped); libextract + weaken retirement (follow-up)

PR1 hit two architectural walls that turned out to be naturally
coupled to the libextract work originally scoped here. PR2 delivered
the resolver-driven path for both, and A4 deleted the legacy helpers.

- **`sfn test` migration — shipped (2026-04-26):**
  `lower_to_llvm_lines_with_parsed_context_for_tests` lowers test
  sources with `mangle_symbols = true`, and the inline harness
  appends `__<sanitize_module_suffix(native_module.module_name)>` to
  each `test:` symbol. `handle_test_command` partitions test files
  by `(project_root, workspace_root)` (mirroring `cli_check.sfn`'s
  A2 pattern), runs `prepare_project_capsules_for_test` once per
  group to stage `.sfn-asm` import-context AND compile each capsule
  dependency to its own `.ll`, then per-test calls
  `compile_tests_to_llvm_file_with_module_imports` (typecheck with
  imports + import-context-in-LLVM threading) and
  `_clang_link_test_cmd_with_deps` (dep `.ll` files prepended ahead
  of the still-weakened `native.linked.o`). Path (a) from the
  original two-fix-paths analysis — chosen for symbol parity with
  the rest of the compile pipeline. The `.skip_test_inlining` flag is gone
  (vestigial after the inliner retired). A latent slug-naming
  inconsistency in `_cr_relative_slug` was fixed: it now delegates
  to `module_name_from_path` so dependency slugs match the slug the
  importer's mangling pass derives via
  `resolve_import_module_slug_for_module`.

- **`sfn check` migration — shipped via Track A (A1 + A2 + A3,
  2026-04-25):** see `docs/proposals/0004-check-architecture.md` for
  the staged details. Cross-module `implements` conformance (E0301)
  is now live without textual import inlining.

- **A4 (shipped 2026-04-26):** deleted
  `_inline_relative_imports_cmd`, `inline_imports_for_source`,
  `_strip_relative_import_lines_cmd`,
  `_collect_relative_import_spans_cmd`, the
  `_RelativeImportSpanCmd` struct, `_lookup_dep_version_cmd`,
  `_resolve_cached_capsule_path_cmd`,
  `_resolve_import_path_cmd`, `_clang_link_test_cmd` (the no-deps
  variant), `compile_tests_to_llvm_file_with_module`,
  `write_llvm_ir_for_tests`, and `write_llvm_ir_for_tests_from_text`.
  Net `-714` lines across `cli_commands.sfn`, `main.sfn`, and
  `entrypoints_tests_writer.sfn`. The architect's plan listed
  `_is_stdlib_capsule_cmd`, `_resolve_capsule_name_cmd`, and
  `_is_stdlib` (in `toml_parser.sfn`) for deletion too;
  investigation showed they're still consumed by `sfn add` — they
  retire once `sfn add` migrates to workspace.toml-driven
  resolution (separate workstream).

#### Stage B PR3 — `llvm-objcopy --weaken` retirement (shipped 2026-04-28)

PR3 closes the last open Stage B item. The empirical investigation
that drove this PR is documented in the Stage B PR2 §4 entry above
(see "Implementation Status"). Net change:

- `_collect_test_files_cmd` (`cli_commands_utils.sfn`) calls
  `_strip_trailing_slashes_cmd` on `root` before walking. Mirrors
  the Phase 5a fix to `_collect_sfn_files_cmd`.
- `_clang_link_test_cmd_with_deps` (`cli_commands.sfn`) loses the
  47-line weaken block (cp + objcopy + push of `native.linked.o`
  + `cross_module_shim.o` push).
- `_resolve_llvm_objcopy_cmd` (the `llvm-objcopy-{14..30}`
  PATH-probing helper, only consumed by the deleted block) deletes.
- `compiler/tests/unit/cli_path_normalization_test.sfn` gains two
  regression tests for the slash-form invariant, asserting on
  `_collect_test_files_cmd` directly.
- The diagnostic `SAILFIN_TEST_NO_WEAKEN` env-var gate from commit
  `acc8af5` reverts in the same PR.

**Decoupling outcome:** `sfn/compiler-lib` extraction is no longer
on Stage B's critical path. The architectural case for sub-capsule
decomposition (proposal §4.10) still stands as a Stage G concern
when the compiler grows enough sub-capsules to benefit from
independent caching, parallel sub-builds, and independent
versioning. It is not a 1.0 blocker.

#### Combined Stage B exit criteria

- `_inline_relative_imports_cmd`, `inline_imports_for_source`,
  `_strip_relative_import_lines_cmd`,
  `_collect_relative_import_spans_cmd`, and the writer-chain
  helpers (`compile_tests_to_llvm_file_with_module`,
  `write_llvm_ir_for_tests`,
  `write_llvm_ir_for_tests_from_text`) no longer exist. ✓
- `sfn build -p capsules/sfn/http` produces the same `mod.o` that
  `build.sh` would (compare `objdump -t` symbol tables; bit-exact is
  the goal but not strictly required). **PR1 shipped the `sfn build
  -p` surface; symbol-table parity is achievable today.** ✓
- `make compile && make check` still passes; the stage2/stage3
  fixed-point still holds. ✓
- `sfn fmt --check` is clean on every touched file. ✓
- `sfn test` passes with zero uses of `llvm-objcopy --weaken`
  anywhere in the codebase. ✓ (PR3, 2026-04-28)

Stage B is now closed. Cutting a fresh seed (`gh workflow run
release.yml`) is the recommended next action before Stage C work
begins, so the Stage C in-process driver builds against a
post-Stage-B baseline.

### Stage C — In-process driver for user capsules

**Goal:** `sfn build` is a real project builder for everything except
the compiler.

The original Stage C scope is split into work-streams. The cache
work-stream is **complete**; the layout / packaging / CI-gate
work-streams remain.

#### Stage C cache milestone — shipped (PR1–1f / #254–#259 / 2026-04-28)

Six PRs deliver an end-to-end content-addressed build cache. Every
`sfn build` and `sfn run` honours it by default.

- **PR1 (#254) — cache module foundation.**
  `compiler/src/build_cache.sfn` defines `cache_key_for(source,
  deps, version, flags)` (sha256 over content + dep manifests +
  compiler version + canonical flags), the on-disk layout
  (`<root>/<key[0..2]>/<key>/{ir.sfn-asm, layout.manifest, mod.ll,
  mod.o}`), and the lookup/store primitives. Schema-versioned
  (`v1`) so a future key-shape change can age old entries out
  cleanly. Unit tests lock the contract.
- **PR1b (#255) — wired into `_cr_compile_one`.** The per-capsule
  module compile checks the cache before invoking
  `compile_to_llvm_file_with_module` and stores the produced
  `.ll` after a fresh build. `SAILFIN_CACHE_TRACE=1` prints
  `[cache hit/miss/store] <slug>` per module.
- **PR1c (#256) — stats + CLI flags.** `CacheStats { hits,
  misses, stores, invalid_keys, copy_failures }` accumulated per
  build and surfaced as a single `[cache] hits=N misses=M …`
  summary line. `sfn build` gains `--no-cache`, `--clean`, and
  `--cache-trace` flags layered over the env-var defaults. The
  `lookup_attempted` flag on `ModuleCacheEvent` suppresses the
  summary on `--no-cache` runs (the cache was never consulted).
- **PR1d (#257) — `sfn run` flag plumbing.** Same flag surface
  mirrored from `sfn build`. New `compiler/tests/e2e/test_run_cache_flags.sh`
  locks the build/run lockstep so future drift fails CI.
- **PR1e (#258) — per-source dep manifests.**
  `_cr_collect_per_source_dep_manifests` replaces the conservative
  "all staged manifests" key input with the actual transitive
  imports each source reaches. An unrelated capsule changing busts
  only the modules that import it. Manifest interface stability
  propagates the invalidation transitively, so direct deps suffice
  in the key. 10–100× cache-hit-rate improvement on incremental
  builds with multiple capsules.
- **PR1f (#259) — `sfn build --json`.** First machine-readable
  surface for build outcomes. `compiler/src/build_report.sfn`
  defines the `BuildReport` struct + `build_report_to_json`
  serializer; emits a single line of JSON to stdout when `--json`
  is set, with `schema_version: "1"` as the contract for breaking
  changes. `compiler/tests/e2e/test_build_json_schema.sh` (uses
  `jq`) locks every top-level field. Foundation for `sfn lsp`,
  the MCP server's structured compile feedback, CI cache-hit-rate
  gates, and future structured link errors (the `diagnostics: []`
  slot is the §4.11 hook).

The cache milestone is **functionally complete**. Every Sailfin
command that touches deps respects the same cache contract;
incremental rebuilds skip unchanged modules; the surface is
machine-readable.

#### Remaining Stage C work-streams

The cache-aside Stage C exit criteria from the original plan (every
stdlib capsule builds with `sfn build -p`, byte-for-byte parity
with `build.sh`, CI cache-hit floor) still stand and break down as:

- **C2 — Standard artifact layout** (in flight). Move `sfn build`'s
  outputs into the per-capsule tree from §4.4
  (`build/capsules/<scope>/<name>/{manifest.json, ir/, obj/, bin/}`).
  Broken into four sub-PRs by risk:
    - **C2a — sidecar schema** (shipped, #261). Per-capsule
      `manifest.json` written after `sfn build -p`. Locks the
      schema downstream consumers (`sfn package`, `sfn lsp`,
      MCP) consume. Path-traversal hardening via
      `is_safe_scope_name`.
    - **C2b1 — binary / library out_path** (shipped, #262).
      `sfn build -p` (no `-o`) defaults library outputs to
      `<dir>/obj/mod.o` and binary outputs to
      `<dir>/bin/<bin-name>`. User-provided `-o` still wins.
      Unsafe-scope `[capsule].name` falls back to legacy
      `build/sailfin/program{,.o}`.
    - **C2b2 — dep `.ll` migration** (in flight). Manifest-
      declared dep sources land at
      `build/capsules/<dep-scope>/<dep-name>/ir/<rel>.ll`;
      intra-capsule (relative-import) sources of a `-p`
      consumer land under the consumer's own `ir/` tree.
      Centralised in `capsule_artifact.sfn::ir_path_for_slug`
      + `capsule_resolver.sfn::ResolverConsumer`. Two-pass
      resolution: source collectors emit `ll_path = ""` and
      `_cr_resolve_and_dedupe` fills in the resolved path
      from the per-build layout. `BuildReport.dep_ll_paths`
      and the sidecar's `deps.ll_paths` reflect the new
      paths; `schema_version` stays at `"1"` (string-array-
      of-paths shape unchanged — same precedent C2b1 set
      for `out_path`).
    - **C2c — per-module sidecar entries** (in flight). Adds
      `modules: [{slug, ir_path, cache_key}]` to the sidecar.
      `slug` matches `CapsuleSource.slug`; `ir_path` is the
      same string as the corresponding `deps.ll_paths` entry
      (locked per-module so consumers can iterate `modules`
      without a parallel-array lookup); `cache_key` is the
      sha256 hex (`""` when caching is disabled or the digest
      was rejected). `obj_path` is deferred until per-module
      compile-then-link lands — today the build only
      produces a single `mod.o` per library capsule (already
      surfaced via `out`) or no per-capsule object (binaries
      link the .ll set directly). Threaded through
      `ModuleCacheEvent` + `CompileCapsuleResult.module_events`
      → `ProjectCapsuleResult.module_events` →
      `_emit_capsule_artifact_sidecar`. Schema stays at
      "1" — the field is additive, existing v1 consumers
      that only read previously-defined fields keep working.
  Unblocks C4 (`sfn package` knows what's in a capsule).
- **C3 — CI gate on stdlib.** Build every `capsules/sfn/*` with
  `sfn build -p` in CI and assert byte-for-byte parity vs `build.sh`
  + a cache-hit-rate floor on no-source-change reruns. Likely a
  nightly cron rather than per-PR to keep CI fast.
- **C4 — `sfn package`.** Sailfin-native `handle_package_command`
  in `cli_commands.sfn` produces tarballs + sha256 sidecars +
  schema-versioned JSON manifests for three artifact shapes:
    - **C4 v1 (#265, shipped).** Standalone compiler tarball
      (`sailfin-native-<target>-<version>.tar.gz`) replacing
      `tools/package.sh`'s first output, plus user-capsule
      packaging (`-p <capsule-path>`) driven off the C2c
      sidecar.
    - **C4b (#266, shipped).** `--installer` mode bundles the
      compiler + `runtime/native/` + (if available) the prelude
      `.o` + (if available) the staged `import-context/` into
      `installer-<target>.tar.gz`, replacing the second half of
      `tools/package.sh`. Tarball name omits the version
      (matching the historical convention `release-tag.yml` +
      `ci.yml` expect); manifest reuses
      `DistManifest.kind = "installer"`.
    - **C4 migration (landed).** `Makefile`'s `package` /
      `ci-package` / `ci-package-installer` targets now call
      `sfn package` / `sfn package --installer` directly;
      `tools/package.sh` is **deleted**. The composite action
      `.github/actions/sailfin-build/action.yml` (which CI's
      `release-tag.yml` + `ci.yml` go through) still calls
      `make ci-package`, so the workflow surface is unchanged.
      The cross-Windows installer (`make ci-cross-windows`)
      keeps its own inline cross-compile + installer logic —
      adding Windows-target support to `sfn package` is a
      separate follow-up.
  Manifest schema is `DistManifest.schema_version = "1"` — adds
  `kind` (compiler / installer / binary / library), `capsule`,
  and `tarball` fields beyond what `tools/package.sh` emitted.
- **C5 — `sfn bench` + `sfn bootstrap`.** Replace
  `scripts/bench_compile.sh` and (for upgrade users) `install.sh`.
  After this, the prior `scripts/build.sh` was the only
  build-related shell script remaining — Stage D / Stage E PR7
  retired it.

The prior `scripts/build.sh` (since retired in Stage E PR7 / #383)
historically continued to build the compiler through Stage C; Stage
D was the cutover that began to retire it (with PR7 completing the
deletion).

**Exit criteria (unchanged):** Every stdlib capsule in `capsules/sfn/*`
builds with `sfn build -p <path>`, matches the historical (now retired)
`build.sh` output byte-for-byte (or close enough that any drift is
documented), and is covered by cache-hit assertions in CI.

### Stage D — Compiler builds itself; `build.sh` and the Makefile retire

**Goal:** Delete the legacy orchestration.

- Teach the driver to handle `kind = "binary"` capsules that depend on
  `kind = "runtime"` capsules (C runtime + Sailfin prelude).
- Port the llvm-link + C runtime + final link steps out of the
  prior `build.sh` (since retired) into the driver's link phase.
- Cross-compile lands via `sfn build --target=<triple>` reading
  `[targets.*]` from the manifest. The `ci-cross-windows` Makefile
  target is deleted; CI calls `sfn build --target=x86_64-w64-mingw32`.
- `scripts/build.sh` is **deleted** (retired in Stage E PR7 / #383).
- The Makefile is **deleted** (or shrunk to a 5-line convenience wrapper
  for contributors who prefer `make` muscle memory). `make compile` →
  `sfn build -p compiler`. `make test` → `sfn test`. `make check` →
  `sfn build --check-determinism`. `make package` → `sfn package`.
- The bootstrap sequence is now: `install.sh` (or `sfn bootstrap`)
  fetches a seed, then `sfn build -p compiler`.
- Retry/validation logic from the prior (retired) `build.sh` survives
  only as `sfn build --isolate-modules` (opt-in, diagnostic only).
  Default path is single-process, no retries. If the compiler emits
  bad IR, the build fails loudly and the bad IR is dumped for
  inspection.

**Exit criteria:** The prior `scripts/build.sh` and the Makefile
(legacy orchestration) no longer exist (build.sh retired in Stage E
PR7 / #383; Makefile retirement deferred to a later PR). Fresh-clone
bootstrap works with `install.sh && sfn build -p compiler`.
`compile_to_llvm_file_with_module`'s fallback paths are gone — the
structured pipeline either succeeds or fails.

### Stage E — Long-lived process, arena, incremental builds

**Goal:** Hit the <5 min build target (see build performance baseline in this document).

- Arena allocator from `docs/proposals/0025-native-runtime-architecture.md` `#321-arenas` lands. The
  driver resets the arena between modules rather than exiting the
  process.
- In-process import-context cache: parsed `.layout-manifest` structs
  live in-memory for the duration of a build.
- Parallel builds default to `--jobs=nproc`.
- Cache hit rate becomes a measured metric in CI with a floor that
  fails the build if hits drop unexpectedly.
- Determinism check (`sfn build --check-determinism`) runs on every PR.

**Exit criteria:** Clean build <5 min; incremental no-op build <5 s;
determinism gate in CI.

### Stage F — Runtime rewrite; no special cases left

**Goal:** The last `kind = "runtime"` special case either retires or
is fully declarative.

- The Sailfin-native runtime lands as `sfn/runtime-sailfin`
  (per `docs/proposals/0025-native-runtime-architecture.md`). The compiler workspace
  depends on it instead of `sfn/runtime-native`.
- The driver's link phase loses its `c-sources` branch — or keeps it
  only for C FFI capsules users might ship (e.g., a `sfn/zlib` binding).
- The `prelude-entry` special case in `sfn/runtime-native`'s manifest
  is deleted; `sfn/prelude` is a normal capsule dep of the runtime.

### Stage G (optional, post-1.0) — Compiler decomposition

**Goal:** Split the compiler into sub-capsules for parallelism and
tooling reuse.

- `compiler/` restructures into `sfn/compiler`, `sfn/compiler-parser`,
  `sfn/compiler-typecheck`, `sfn/compiler-emit`, `sfn/compiler-llvm`,
  each with its own `capsule.toml`.
- `sfn check` and `sfn lsp` depend on `sfn/compiler-parser` +
  `sfn/compiler-typecheck` only, skipping emit and LLVM entirely.
- Parallel builds gain another level of parallelism (sub-capsules
  in parallel, modules within each in parallel).

Not on the 1.0 critical path. Schema supports it from Stage A, but the
actual split is an ecosystem-maturity cleanup.

---

## Part 6 — Open Questions

1. **Workspace file location.** Does the shipped stdlib workspace file
   live at `$PREFIX/lib/sailfin/workspace.toml` (Unix convention) or
   next to the binary? Affects how installers lay things out.
2. **Cache eviction.** Resolved by SFEP-0040 §3.2–3.4 (#1893): bounded by
   size and age via the explicit, opt-in `sfn cache prune`
   (`--max-size`/`--max-age`, LRU by mtime-on-hit) and `sfn cache clean
   [--all-schemas]` — never implicit on an ordinary build.
3. **Per-target sub-graphs.** Cross-compilation to wasm32 needs a
   different runtime capsule. Does the driver build both graphs in one
   invocation (`sfn build --target=native --target=wasm32`) or require
   separate commands?
4. **Registry vs. workspace priority.** If a user has a workspace member
   named `sfn/http` and also a `[dependencies] "sfn/http" = "0.3.0"`, which
   wins? Proposal says workspace, to match Cargo. Needs confirmation.
5. **Sub-module imports across capsules.** `import { X } from "sfn/http/client"`
   requires that consumers can see the dep's sub-modules, not just its
   entry. Either all `src/**/*.sfn` are part of the public surface, or
   capsules declare an explicit `[exports]` list. Proposal leans toward
   explicit exports to keep the ABI surface small.
6. **`sfn/compiler-lib` scope.** Stage B extracts a library capsule from
   `compiler/src/` so tests can depend on it without weakening the
   binary. What goes in? Proposal says everything except `cli_main.sfn`,
   `cli_commands.sfn`, `cli_commands_utils.sfn` (which become
   `sfn/compiler`'s binary-specific code). Needs a symbol audit to
   confirm no test today needs CLI internals.
7. **Implicit-dep semantics.** `[build].implicit = true` on `sfn/prelude`
   adds it to every build's dep graph. Does that apply to test binaries,
   benchmarks, and `--emit=ir` outputs too? Proposal says yes for all
   compilation targets; no for documentation-only outputs.
8. **`make` as a user-facing affordance.** Some users will want `make`
   muscle memory to keep working. Do we ship a 5-line convenience
   Makefile in Stage D, or insist on `sfn` only? The minimalist choice
   removes one layer; the pragmatic choice reduces migration friction.
9. **`install.sh` vs `sfn bootstrap`.** When a user already has `sfn`,
   `sfn bootstrap` is the right update path. When they don't, they need
   `curl | sh` to get the first binary. Keep both, document the split.
10. **Link-error recognizer surface.** The structured link diagnostics
    in §4.11 require mapping clang stderr lines to error kinds. What's
    the minimum recognizer set for 1.0? Proposal: undefined symbol,
    multiple definition, missing object. Unknown errors fall through
    with raw stderr attached.

---

## Build performance

**Target:** clean build of the compiler in under 5 minutes (Stage E exit criterion).

### 0.7.0 baseline (2026-06-22, post C-runtime deletion)

First per-module compile baseline since the C runtime was deleted and the runtime
became pure Sailfin. Captured with `make bench` (all 166 `compiler/src` modules,
isolated `emit llvm` per module, Darwin arm64, compiler `sfn 0.7.0-alpha.47+dev.64ed8a6d`).
Raw CSV: `docs/baselines/compile-0.7.0-darwin-arm64.csv`.

| Metric (per-module emit, isolated) | 0.7.0-alpha.47 (Darwin arm64) |
| --- | --- |
| Modules | 166 (all `ok`, within budget) |
| Slowest module | `cli_commands` 22.30 s |
| Next slowest | `cli_main` 19.76 s, `llvm__expression_lowering__native__core` 16.71 s |
| Peak RSS (heaviest) | **4389 MB** (`llvm__expression_lowering__native__core`) |
| Sum of isolated per-module emits | 566.73 s (serial; not the parallel build wall-time) |

These are *isolated per-module* emit timings (each module emitted alone against
`build/compiler/import-context`). Peak RSS of ~4.4 GB on a single module is under the
8 GiB self-cap but is the standout regression candidate to watch — the heaviest
emitters are the `llvm/expression_lowering/native/core*` family and the two CLI
modules.

Runtime execution performance (the dimension most affected by C-runtime deletion) is
tracked separately in `docs/perf/runtime-performance.md` with its own `make bench-runtime`
harness and 0.7.0 baseline.

### post-Phase-A CLI deltas (2026-06-29, SFEP-0027 Phase A)

SFEP-0027 Phase A carved the build-driver orchestration out of `cli_main.sfn`
into `compiler/src/build/{runtime_objs,link,determinism,cache}.sfn` (#1730–#1733)
and shattered the 937-line `sailfin_cli_main_legacy` into per-command
`_legacy_dispatch_<cmd>` helpers (#1734). The falsifiable Phase A success gate
(#1735) is the per-module emit RSS drop. Measured with `make bench
--module cli_main --module cli_commands` (Darwin arm64, compiler
`sfn 0.7.0-alpha.50+dev.e4eac88c`); the "before" column is the 0.7.0 baseline CSV
row above.

| Module | emit time (before → after) | peak RSS (before → after) | IR lines (before → after) |
| --- | --- | --- | --- |
| `cli_main` | 19.76 s → **10.24 s** (−48%) | 2,473,616 KB (2,415 MB) → **1,090,560 KB (1,065 MB)** (−56%) | 20,543 → 9,977 |
| `cli_commands` | 22.30 s → **10.77 s** (−52%) | 3,520,976 KB (3,438 MB) → **1,162,240 KB (1,135 MB)** (−67%) | 29,258 → 10,335 |

Both CLI modules drop out of the "two heaviest CLI emitters" callout above: their
post-Phase-A peak RSS (~1.0–1.1 GB) is well under the 4,389 MB
`llvm__expression_lowering__native__core` peak and roughly in line with the median
emitter. `cli_commands` is unchanged in source by Phase A (it is emptied in Phase C),
but its isolated emit shrank because the build-driver functions it imports moved out
of the monolithic `cli_main` closure into small `build/` modules — its emit import
closure (and thus IR-line expansion and working set) shrank with the carve. Per
SFEP-0027 §8, no Phase A step raised peak RSS; both levers measurably lowered it, so
neither is reverted. A line-budget sentinel
(`compiler/tests/unit/cli_main_line_budget_test.sfn`, budget 1,500) guards
`cli_main.sfn` against silently re-ballooning toward the pre-Phase-A 3,067-line
monolith.

### native/core* lowering-family RSS carve (2026-07-06)

The same per-module-working-set lever SFEP-0027 Phase A applied to the CLI
modules, applied to the heaviest emitters after them: the
`llvm/expression_lowering/native/core*` lowering family. Two cohesive,
behavior-preserving carves split the two heaviest modules' oversized function
sets into new siblings, so each emits with a smaller working set (the moved
functions are called only by `lower_expression`). Measured with `make bench`
(Linux x86_64, compiler `sfn 0.8.0-alpha.2+dev.d935954`); "before" is the full
`make bench` baseline captured on the same host before the carves.

| Module | peak RSS (before → after) | IR lines (before → after) |
| --- | --- | --- |
| `native/core` | 1,452 MB → **924 MB** (−36%) | 17,478 → 8,612 |
| `native/core_concurrency_lowering` (new) | — → 935 MB | — → 10,169 |
| `native/core_literals_lowering` | 1,320 MB → **1,120 MB** (−15%) | 15,385 → 11,377 |
| `native/core_cast_lowering` (new) | — → 564 MB | — → 5,130 |

`core.sfn` (was the #1 peak-RSS module in the whole build) sheds the 9
concurrency / channel / tostring special-form lowerings
(spawn/channel/parallel/serve/await) into `core_concurrency_lowering.sfn`;
`core_literals_lowering.sfn` (was #2) sheds its `is`/cast/interpolated-string
block into `core_cast_lowering.sfn`. In both carves the moved functions are
called only by `lower_expression` (which stays in `core.sfn`), so the split is a
pure verbatim move — no logic, effect, or signature change — validated by
`make check` (unit/integration/e2e/capsules all green) and a byte-identical
`--work-dir` self-host parity build. No carve raised peak RSS.

The single 1,452 MB peak — the build's tallest pole — is eliminated: `core.sfn`
drops to 924 MB and neither new sibling exceeds it, so the parallel build's
`jobs × heaviest-concurrent-module` RAM ceiling is now bounded by the next tier
(`cli/commands/test.sfn` ~1,417 MB, `core_operands.sfn` ~1,207 MB) rather than by
the lowering core. `core_literals_lowering`'s residual 1,120 MB is dominated by
the untouched 650-line `lower_array_literal`. Follow-ups (same lever): split
`cli/commands/test.sfn`'s single 1,132-line `run` (in-function split, the new
tallest pole), and carve `core_operands.sfn` (~1,207 MB, three ~500–750-line
coercion giants) and `capsule_resolver.sfn` (~1,229 MB).

### Phase-scoped arena reclamation (2026-07-07, SFEP-0043)

A complementary lever to the working-set carves above: instead of reducing the
per-module working set by splitting modules, **reclaim the front-half working set
mid-process** so lowering reuses the freed pages. Takes an arena mark before
`parse_program`; after the emitter produces `native_lines`, joins them to a
single flat string and relocates that string's data buffer to malloc'd memory
(`compiler/src/arena_relocate.sfn::relocate_string_to_heap`); then rewinds the
arena to reclaim the entire AST/typecheck/emit region; then lowers; then frees
the heap buffer. Gated by `SAILFIN_ARENA_PHASE_REWIND` (default ON).

Measured across 199 modules (rewind OFF vs ON, same binary):

| Metric | Before | After |
| --- | --- | --- |
| Peak RSS (heaviest module) | 1,211 MB | **1,009 MB** (−16.7%) |
| Sum of per-module peak RSS | 72.4 GB | **56.1 GB** (−22.5%) |
| Mean per-module RSS | 364 MB | **282 MB** |
| Sum wall time | 871.9 s | 867.3 s (−0.5%, neutral) |

Global win across all pipeline stages; 2 known regressions (`capsule_resolver`
+18%, `core_literals_lowering` +8%) — small front-half modules where the
relocated-text copy exceeds reclaimed garbage; neither sets the new peak.
Design record: `docs/proposals/0043-phase-scoped-arena-reclamation.md` (SFEP-0043).

---

## Cross-references

- `docs/proposals/0025-native-runtime-architecture.md` — the Sailfin-native runtime rewrite.
  Stage F of this proposal consumes M2/M3 from that plan; Stage E implements
  the long-lived process with arena resets between modules.
- `docs/proposals/0002-package-management.md` — user-facing registry and
  `sfn add` semantics. This proposal extends the manifest schema it
  defines.
- `docs/proposals/0003-tooling.md` — `sfn check`, `sfn doc`, `sfn fix` all
  depend on the in-process driver landing in Stage C. `sfn lsp`
  specifically benefits from the Stage G sub-capsule decomposition.
