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
   `seed emit native <file>` once to produce a `.sfn-asm` textual IR and a
   `.layout-manifest` sidecar. These artifacts are the cross-module interface
   the second-pass emit depends on. They are written to
   `build/selfhost/native/seed_cwd/build/native/import-context/<slug>.sfn-asm`.
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
  and resolved against `capsules/sfn/<name>/src/mod.sfn`. The stdlib list is
  a hard-coded allowlist of 20 names.
- **Scoped** (`sfn/cli`, `acme/router`) → looked up in the nearest
  `capsule.toml` (walking up from the source directory), then resolved under
  `~/.sfn/cache/capsules/<scope>/<name>/<version>/src/mod.sfn`. Prefers
  `capsule.lock` over `capsule.toml` when both are present.

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

`capsules/sfn/*` contains 20 first-party capsules
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
hard-coded list of 20 bare names. The resolver logic that maps
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

### 2.6 Runtime bundle coupling

`sfn build`'s link step needs six files from a runtime bundle:
`include/`, `src/sailfin_runtime.c`, `src/sailfin_sha256.c`,
`src/sailfin_base64.c`, `src/native_driver.c`, `ir/runtime_globals.ll`,
and `obj/prelude.o`. The installer copies these to `runtime/native/` next
to the binary and resolves at runtime by probing five candidate paths in
`_runtime_prelude_path`. This is fine for a C runtime — it has to be fine
because the C runtime is what exists — but when the runtime moves to
Sailfin, the link model has to change. If we plan for that now, the
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


---

## Part 3 — Design Principles

The future system should satisfy the following, in priority order:

1. **One build driver.** `sfn build` is the only code path that turns
   sources into artifacts. `scripts/build.sh` shrinks to a one-line
   bootstrap that runs `sfn build -p compiler` using the seed compiler.
2. **Capsule is the unit of compilation.** A capsule is defined by its
   `capsule.toml`. Builds produce one artifact per capsule plus a
   dependency manifest; the driver composes them.
3. **Build graph is explicit and machine-readable.** The driver can emit
   the dependency graph, the cache keys, and the per-module timings as
   structured output. No free-form stderr parsing.
4. **Stdlib is a registry fact, not a compiler fact.** The compiler does
   not know which capsules are stdlib; it knows how to resolve
   `scope/name` specs against a configured set of sources (workspace
   tree, cache, registry). Stdlib is the `sfn/*` scope, registered in a
   workspace file that ships with the compiler.
5. **One resolver, two modes.** Intra-capsule and inter-capsule imports
   go through the same resolver. The only difference is whether the
   source lives in the current capsule's `src/` or a dependency's `src/`.
6. **In-process by default, subprocess only when required.** The
   long-lived driver compiles all modules in one process, shares parsed
   imports, and resets the arena between modules. A subprocess is spawned
   only when the user asks for it (e.g., `sfn build --isolate-modules`
   for debugging corruption).
7. **Cache is content-addressed.** Cache keys are
   `hash(source, resolved_deps, compiler_version, flags)`. The driver
   never trusts mtime.
8. **Runtime is a capsule.** The C runtime stays as `sfn/runtime-native`
   (or similar) until the Sailfin rewrite lands; after that, it is a
   first-party Sailfin capsule resolved through the same dependency graph
   as everything else.
9. **Fix-ups belong in the compiler.** The driver does not retry on
   miscompilation, does not post-process IR, and does not have fallback
   paths for "try X, if that doesn't work try Y". If the compiler emits
   invalid IR, the build fails.


---

## Part 4 — Future State: Unified `sfn build`

### 4.1 Command surface

```
sfn build                    # build the capsule in the current directory
sfn build -p <capsule>       # build a specific capsule by name or path
sfn build --release          # optimized build (default is debug)
sfn build --emit=ir          # emit .sfn-asm + .layout-manifest, no link
sfn build --emit=obj         # emit .o, no link
sfn build --emit=bin         # default; produce an executable/library
sfn build --target=<triple>  # cross-compile
sfn build --jobs=N           # parallel module compilation (default: nproc)
sfn build --json             # structured build report on stdout
sfn build --isolate-modules  # subprocess per module (for debugging)
```

`sfn run`, `sfn test`, `sfn check` all delegate to the same build pipeline
and only differ in what they do with the artifact:

- `sfn run` → `sfn build --emit=bin`, then execute the binary.
- `sfn test` → `sfn build` with test-only deps enabled, then execute each
  test binary (or one combined test binary — see §4.6).
- `sfn check` → `sfn build --emit=ir` stopping after typecheck + effects,
  no codegen.

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

### 4.8 Caching and determinism

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
itself and the test suite still passes.

### Stage A — Manifest as source of truth (no user-visible changes)

- Extend `capsule.toml` parser to accept `[build].kind`,
  `[workspace]`, `[dev-dependencies]`, `[targets.*]`. The parser accepts
  them; nothing consumes them yet.
- Add a top-level `workspace.toml` alongside `compiler/capsule.toml`
  that enumerates `compiler`, `runtime-native`, and `capsules/sfn/*` as
  workspace members.
- `build.sh` continues to drive the build. Lands with no behavior change
  beyond richer manifest schemas.

### Stage B — Resolver-in-compiler

- Port `_inline_relative_imports_cmd` logic into a first-class resolver
  in `compiler/src/resolver/mod.sfn`.
- Replace the hard-coded stdlib allowlist with workspace-driven
  resolution backed by the workspace file.
- `sfn run` / `sfn test` stop doing textual inlining; they call the
  resolver and pass a `ResolvedGraph` to the emit pipeline.
- `sfn build` gains the ability to build a capsule from its manifest
  (`sfn build -p <path>`). It still can't build the compiler.

### Stage C — In-process driver for user capsules

- Implement the driver function graph from §4.3 in Sailfin.
- User capsules build with `sfn build`. All stdlib capsules are rebuilt
  this way in CI to exercise the driver.
- Cache keyed on content hashes. Rebuild-performance parity with today's
  `sfn build <file>` is a must-hit.
- `scripts/build.sh` continues to build the compiler.

### Stage D — Compiler builds itself with `sfn build`

- Teach the driver to handle `kind = "binary"` capsules that depend on
  `kind = "runtime"` capsules (the C runtime).
- Port the llvm-link + C runtime + final link steps out of `build.sh`
  into the driver's link phase.
- `scripts/build.sh` is rewritten as a 30-line shim that fetches the
  seed, runs `seed sfn build -p compiler`, and copies the output.
- Retry/validation logic migrates into the driver as
  `--isolate-modules` (opt-in, diagnostic only). Default path is
  single-process, no retries.

### Stage E — Long-lived arena, incremental builds

- Arena allocator from `docs/runtime_architecture.md` §4.4 lands. The
  driver resets the arena between modules rather than exiting the
  process.
- Cache hit rate becomes a measured metric in CI.
- Parallel builds default-on.

### Stage F — Runtime rewrite consumes the build system

- The Sailfin-native runtime lands as `sfn/runtime-sailfin`. The compiler
  workspace depends on it instead of `sfn/runtime-native`. The driver's
  link phase loses its `kind = "runtime"` special case (or keeps it only
  for C FFI capsules).

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
6. **Migration of `sfn test`.** The test runner today weakens the
   compiler's own object file to satisfy cross-module symbols. That hack
   goes away when tests are real modules linked against a real
   `sfn/test` library. Some existing tests may rely on symbols that only
   exist in the compiler binary; they need to declare `sfn/compiler`
   (or a narrower library capsule) as a test dep.

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
  depend on the in-process driver landing in Stage C.
