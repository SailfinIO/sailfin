# Proposal: Unified Build Architecture for Sailfin

Status: Draft
Date: 2026-04-17
Authors: Core Team

## Summary

Sailfin today has two largely independent build pipelines:

1. **`scripts/build.sh`** — a ~970-line bash orchestrator that self-hosts the
   compiler from a released seed. It discovers sources, spawns the seed once
   per module, stages an import-context directory, validates the emitted LLVM
   IR with retries, then llvm-link-merges and clang-links the result.
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

`make compile` delegates to `scripts/build.sh`, which is the actual build
driver. The Makefile mainly handles seed fetching, output-directory plumbing,
and re-running the script with the right environment.

Flow:

1. **Seed acquisition.** `make fetch-seed` downloads a released compiler
   (default `0.5.3-alpha.1`) to `build/seed/bin/sailfin` via `install.sh`.
   The seed must support `emit native` or the rebuild aborts.
2. **Source discovery.** `build.sh` walks `compiler/src/**/*.sfn` plus
   `runtime/**/*.sfn`, then parses `[dependencies]` in
   `compiler/capsule.toml` and appends sources from
   `capsules/<scope>/<name>/src/**/*.sfn` for each declared dep. Today the
   compiler's manifest declares no dependencies, so only the in-tree
   compiler + runtime sources are used.
3. **Import-context staging.** For every source, the seed runs
   `seed emit native <file>` once to produce a `.sfn-asm` textual IR.
   `scripts/build.sh` then derives the corresponding `.layout-manifest`
   by `grep`-extracting `.layout` lines from the emitted `.sfn-asm`
   (the seed does not produce the manifest as an independent output).
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
   and the prelude object into `build/native/sailfin`.

### 1.2 Building a user program (`sfn build`, `sfn run`)

`sfn build` and `sfn run` live in `compiler/src/cli_main.sfn` and handle a
single source file at a time.

- `sfn build [-o OUTPUT] <file>` — reads the file, calls
  `compile_to_llvm_file_with_module(source, module_name, "build/sailfin/program.ll")`,
  then `clang`-links against the installed runtime bundle via
  `_clang_link`. It does **not** resolve imports itself; the compiler's
  in-process import resolver reads from `build/native/import-context/` if
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
after `sfn add` downloads a `.sfnpkg` from `registry.sailfin.dev` and writes
an entry to `capsule.lock`.


---

## Part 2 — Problems

### 2.1 Two build systems

The compiler's build graph is resolved by `scripts/build.sh` (bash,
capsule-aware, produces real per-module `.ll` artifacts). A user program's
build graph is resolved by `inline_imports_for_source` (Sailfin, textually
inlines everything into one synthetic source). The two disagree on most
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

`docs/build-performance.md` identifies this as Root Cause 6. The only
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
The compiler's own self-host build (`scripts/build.sh`) links every
runtime source including `native_driver.c`. So the runtime bundle is
three different shapes depending on which code path consumes it.

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
(package), `scripts/bench_compile.sh` (bench), `scripts/run_native_test.sh`
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
   sources into artifacts. `scripts/build.sh` is deleted, not shrunk.
   The bootstrap is a Makefile target (or `sfn bootstrap` subcommand)
   that fetches a seed and invokes `seed sfn build -p compiler`.
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
"sfn/fmt" = "0.3.0"

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
     │    (workspace → lockfile → cache → registry, in that order)
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
`build/native/import-context/` staging directory. Every consumer reads
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
prelude-entry = "../runtime/prelude.sfn"
```

The driver's link phase reads this and produces the same output the bash
script produces today, but declaratively. When the Sailfin runtime rewrite
lands, `c-sources` is replaced with `entry = "src/mod.sfn"` and the link
step loses a special case.

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
- Cache store: `build/cache/<key-prefix>/<key>.{sfn-asm,layout-manifest,ll,o}`.
- Cache hits skip parse, typecheck, effect, emit, and clang. They do not
  skip link.
- `--no-cache` disables the lookup but still writes. `--clean` wipes the
  cache before building.
- The build report (`--json`) lists cache hits/misses per module. CI can
  fail the build if the hit rate drops below a threshold (regression
  signal).

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

- Extend `capsule.toml` parser to accept `[build].kind`,
  `[build].implicit`, `[workspace]`, `[dev-dependencies]`,
  `[targets.*]`, `[exports]`. The parser accepts them; nothing consumes
  them yet.
- Create `workspace.toml` at the repo root, enumerating `compiler`,
  `runtime-native`, `runtime-prelude` (new — wrapping
  `runtime/prelude.sfn`), and `capsules/sfn/*` as workspace members.
- Create `capsules/sfn/prelude/capsule.toml` pointing at `runtime/prelude.sfn`.
- `build.sh` continues to drive the build. No user-visible change.

**Exit criteria:** `make compile && make check` passes; the new manifest
fields round-trip through the parser; `workspace.toml` loads cleanly.

### Stage B — Real resolver, retire textual inlining and the weaken hack

**Goal:** One import-resolution code path, used by every CLI command.

- Port `_inline_relative_imports_cmd` into a first-class resolver
  `compiler/src/resolver/mod.sfn` that returns a `ResolvedGraph`.
- Retire `_is_stdlib_capsule_cmd` — the resolver reads the workspace
  file to discover that `sfn/http` maps to `capsules/sfn/http`.
- `sfn run` stops textually inlining imports; it compiles modules
  separately and links them. Diagnostics now reference original files.
- `sfn test` stops weakening the compiler binary. Tests that need
  compiler internals depend on a new `sfn/compiler-lib` capsule
  (extracted from `compiler/src/`, excluding `cli_main.sfn` and
  `cli_commands.sfn`) as a dev-dep. Tests that don't need compiler
  internals lose the weakening step entirely and get faster.
- `sfn build` accepts `-p <path>` and reads the manifest to resolve the
  entry + dep graph, but still hands off to the single-file emit path.
- Stdlib capsules can now ship patch versions: `sfn/http@0.2.2` is
  valid without a compiler release.

**Exit criteria:** `sfn test` passes with zero uses of `llvm-objcopy`;
`_inline_relative_imports_cmd` is deleted; stdlib allowlist is deleted;
`sfn build -p capsules/sfn/http` produces the same `mod.o` that
`build.sh` would.

### Stage C — In-process driver for user capsules

**Goal:** `sfn build` is a real project builder for everything except
the compiler.

- Implement the driver function graph from §4.3 in Sailfin.
- Content-addressed cache under `build/cache/`.
- `sfn package` and `sfn bench` subcommands ship; `tools/package.sh`
  and `scripts/bench_compile.sh` are deleted.
- `sfn bootstrap` ships; it fetches a released seed binary (replaces
  `install.sh` for users already on sfn). `install.sh` stays as the
  first-install curl target.
- All stdlib capsules build with `sfn build` in CI to exercise the
  driver before the compiler itself depends on it.
- `scripts/build.sh` continues to build the compiler (one last stage).

**Exit criteria:** Every stdlib capsule in `capsules/sfn/*` builds with
`sfn build -p <path>`, matches `build.sh` output byte-for-byte, and is
covered by cache-hit assertions in CI.

### Stage D — Compiler builds itself; `build.sh` and the Makefile retire

**Goal:** Delete the legacy orchestration.

- Teach the driver to handle `kind = "binary"` capsules that depend on
  `kind = "runtime"` capsules (C runtime + Sailfin prelude).
- Port the llvm-link + C runtime + final link steps out of `build.sh`
  into the driver's link phase.
- Cross-compile lands via `sfn build --target=<triple>` reading
  `[targets.*]` from the manifest. The `ci-cross-windows` Makefile
  target is deleted; CI calls `sfn build --target=x86_64-w64-mingw32`.
- `scripts/build.sh` is **deleted**.
- The Makefile is **deleted** (or shrunk to a 5-line convenience wrapper
  for contributors who prefer `make` muscle memory). `make compile` →
  `sfn build -p compiler`. `make test` → `sfn test`. `make check` →
  `sfn build --check-determinism`. `make package` → `sfn package`.
- The bootstrap sequence is now: `install.sh` (or `sfn bootstrap`)
  fetches a seed, then `sfn build -p compiler`.
- Retry/validation logic from `build.sh` survives only as
  `sfn build --isolate-modules` (opt-in, diagnostic only). Default path
  is single-process, no retries. If the compiler emits bad IR, the
  build fails loudly and the bad IR is dumped for inspection.

**Exit criteria:** `scripts/build.sh` and the Makefile no longer exist.
Fresh-clone bootstrap works with `install.sh && sfn build -p compiler`.
`compile_to_llvm_file_with_module`'s fallback paths are gone — the
structured pipeline either succeeds or fails.

### Stage E — Long-lived process, arena, incremental builds

**Goal:** Hit the <5 min build target from `docs/build-performance.md`.

- Arena allocator from `docs/runtime_architecture.md` §4.4 lands. The
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
  (per `docs/runtime_architecture.md` M2/M3). The compiler workspace
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
2. **Cache eviction.** Bounded by size, age, or never? A compiler build
   is ~120 modules × ~1 MB each ≈ 120 MB per successful build; CI
   caches could bloat quickly.
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

## Cross-references

- `docs/build-performance.md` — root-cause analysis of the current build's
  performance ceiling. Phase 5 in that plan is "long-lived compiler
  process", which is what Stage E implements.
- `docs/runtime_architecture.md` — the Sailfin-native runtime rewrite.
  Stage F of this proposal consumes M2/M3 from that plan.
- `docs/proposals/package-management.md` — user-facing registry and
  `sfn add` semantics. This proposal extends the manifest schema it
  defines.
- `docs/proposals/tooling.md` — `sfn check`, `sfn doc`, `sfn fix` all
  depend on the in-process driver landing in Stage C. `sfn lsp`
  specifically benefits from the Stage G sub-capsule decomposition.
