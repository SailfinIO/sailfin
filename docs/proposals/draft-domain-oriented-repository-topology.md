---
sfep: TBD
title: Domain-Oriented Repository Topology
status: Draft
type: tooling
created: 2026-08-17
updated: 2026-08-17
author: "agent:Codex; human review"
tracking: "https://linear.app/sailfin/project/repository-topology-and-capsule-layout-fd4f474aaaae"
supersedes:
superseded-by:
graduates-to:
---

# SFEP-TBD — Domain-Oriented Repository Topology

## 1. Summary

Reorganize Sailfin's first-party capsules under three domain roots:
`compiler/`, `stdlib/`, and `runtime/`. The `sfn/compiler` driver becomes an
explicit `compiler/driver` capsule beside the five private compiler phase
capsules; public `sfn/*` libraries move from `capsules/sfn/*` to `stdlib/*`;
the native runtime keeps the `runtime/` root but normalizes its Sailfin sources
under `runtime/src`; and the implicit prelude becomes a real, self-contained
`stdlib/prelude` capsule instead of a manifest shell pointing outside its root.

This is a physical ownership change, not a new compiler decomposition. It
preserves SFEP-0020's role boundaries and every logical capsule name, supported
import specifier, public/role dependency contract, publication policy,
installed command, and manifest-derived artifact namespace. The prelude is the
explicit exception: its parse-only capability declaration is corrected to
match its source, its runtime imports become a provider ABI, and the runtime
gains the one-way `sfn/prelude` edge. The design replaces path-prefix
architectural policy with manifest identity where the policy is about capsules,
while retaining physical checks for source containment, discovery, and
repository hygiene. Migration is staged so each move is independently
revertible and self-hosting.

## 2. Motivation

### 2.1 The logical architecture is sound; its physical projection is not

SFEP-0020 successfully split the compiler into six role-oriented capsules, but
its prescribed tree makes one capsule double as a domain root:

```text
compiler/
  capsule.toml            # sfn/compiler
  src/                    # the driver capsule
  capsules/
    syntax/
    analyzer/
    ir/
    codegen/
    codegen-llvm/
```

The driver is therefore visually privileged over capsules that are peers in
the dependency graph. `compiler/src/` still contains 129 Sailfin source files,
while the private phase capsules contain 257 files between them. A contributor
cannot infer from `compiler/src` whether a file belongs to driver orchestration
or is merely a residual extraction candidate.

The public library tree has the opposite problem:

```text
capsules/sfn/<name>/
```

Both path segments repeat manifest facts: the directory contains capsules, and
their `[capsule].name` values already carry the `sfn/` scope. The path does not
say that these are Sailfin's standard-library sources, and private compiler
capsules use the same logical scope from a different physical convention.

The runtime/prelude boundary is less honest still. `sfn/prelude` has a manifest
at `capsules/sfn/prelude/capsule.toml`, but its entry is
`../../../runtime/prelude.sfn`. The runtime manifest separately compiles that
same file through `prelude-entry = "prelude.sfn"`. SFEP-0006 §2.11 records the
resulting privileged path, module name, link position, and implicit dependency;
its §4.8 already defines the intended real capsule. The current tree has the
shape of that design without its semantics.

### 2.2 Physical paths have become accidental architecture APIs

The workspace currently registers four different member shapes:

```toml
members = [
    "compiler",
    "compiler/capsules/*",
    "runtime",
    "capsules/sfn/*",
]
```

That topology is repeated across semantic classes that should not all have the
same relationship to paths:

| Class | Current coupling | Correct authority |
|---|---|---|
| Workspace discovery | literal member and glob paths in `workspace.toml` | physical workspace inventory |
| Capsule ownership and private-boundary rules | prefixes such as `compiler/capsules/` | resolved manifest name, dependency graph, and `publish` policy |
| Source/module identity | path-derived slugs plus capsule canonicalization | capsule identity plus capsule-relative module path |
| Bootstrap and pinned-seed resolution | committed workspace paths and manifest entries | physical paths, interpreted by the pinned seed |
| Freshness, formatting, watches, and layout fingerprints | repeated root lists | expanded workspace inventory plus explicit non-capsule roots |
| Cache and artifacts | a mixture of source paths and capsule names | content plus logical capsule/module identity; artifacts by capsule name |
| Test discovery and sharding | `compiler/tests` and `capsules/**/tests` path taxonomies | owner-local tests plus explicit cross-domain suites |
| CI, release, and packaging | hard-coded source, manifest, and staging paths | workspace inventory for sources; logical identity for artifacts/version policy |
| Documentation and agent instructions | literal navigation and command examples | physical paths, updated in the same structural slice |

The repository contains hundreds of literal references to
`compiler/capsules`, `capsules/sfn`, or `runtime/prelude`. Many are historical
citations and test fixtures that should stay literal. Others are load-bearing
source fingerprints, boundary checks, release-manifest walkers, cache keys, and
test shard inputs. Treating them as one blind search-and-replace set would
either weaken real checks or preserve accidental coupling.

### 2.3 The desired invariant

A first-party source path should answer “who owns this?” while a manifest should
answer “what capsule is this?”. Moving a capsule between physical directories
must not rename the capsule, change its authority, or move its build artifacts.
Conversely, a file should not escape its capsule root merely to preserve an old
directory convention.

## 3. Design

### 3.1 Canonical end-state topology

The accepted end state is domain-first:

```text
compiler/
  driver/                         # sfn/compiler; publish = false
    capsule.toml
    src/
  syntax/                         # sfn/syntax; publish = false
    capsule.toml
    src/
    tests/
  analyzer/                       # sfn/analyzer; publish = false
    capsule.toml
    src/
    tests/
  ir/                             # sfn/ir; publish = false
    capsule.toml
    src/
    tests/
  codegen/                        # sfn/codegen; publish = false
    capsule.toml
    src/
    tests/
  codegen-llvm/                   # sfn/codegen-llvm; publish = false
    capsule.toml
    src/
    tests/
  tests/
    unit/                         # driver or whole-compiler contracts
    integration/                  # cross-role behavior
    e2e/                          # CLI/toolchain behavior
    fixtures/

stdlib/
  archive/                        # sfn/archive
    capsule.toml
    src/
    tests/
  cli/                            # sfn/cli
    capsule.toml
    src/
    tests/
  crypto/                         # sfn/crypto
    capsule.toml
    src/
    tests/
  ...
  strings/                        # sfn/strings
    capsule.toml
    src/
    tests/
  prelude/                        # sfn/prelude
    capsule.toml
    src/
      mod.sfn
    tests/

runtime/                          # sfn/runtime-native
  capsule.toml
  src/                            # current runtime/sfn/**
    runtime_globals.sfn
    adapters/
    concurrency/
    memory/
    platform/
  ir/                             # target-specific LLVM support, when needed
  tests/
```

`src/` remains the capsule-local source convention. The problem with today's
`compiler/src/` is not the convention itself; it is that the directory's owner
is implicit. `compiler/driver/src/` makes the owner explicit and gives all six
compiler capsules the same manifest/source/test shape.

The steady-state workspace is:

```toml
[workspace]
members = [
    "compiler/*",
    "stdlib/*",
    "runtime",
]
```

The existing trailing-`/*` rule expands only immediate directories containing
`capsule.toml`, in sorted order. `compiler/tests` is therefore not a member.
The path locates a member; the member's manifest supplies its canonical name.

### 3.2 Logical compatibility contract

The relocation preserves all of the following:

- Capsule names: `sfn/compiler`, `sfn/syntax`, `sfn/analyzer`, `sfn/ir`,
  `sfn/codegen`, `sfn/codegen-llvm`, every public `sfn/*` library, and
  `sfn/runtime-native`.
- Supported imports and manifest dependency keys. No consumer changes an
  import solely because its provider moved.
- Compiler-private `publish = false` policy and the dependency DAG from
  SFEP-0020.
- Every `[capabilities].required` value and source-level effect except the
  prelude shell's inaccurate parse-only `required = []`; §3.3 makes its
  existing `clock`, `io`, and `net` effects honest before activation.
- The installed `sfn` command and `build/bin/sfn` compatibility path.
- Manifest-derived artifacts under `build/capsules/<scope>/<name>/`, including
  `build/capsules/sfn/compiler/` and public-library artifact paths.
- Capsule versions. A path-only move does not trigger a semantic version bump;
  release automation continues to bump a capsule only when its release policy
  otherwise requires one.
- Workspace-local resolution before lockfile, cache, or registry resolution.

One manifest-aware source-identity service owns module mapping for compilation,
relative-import traversal, direct emit, and determinism tooling. It accepts a
canonical source path, the resolved workspace inventory, and the member's
build role. Production code must not add another repo-path-to-slug branch for
`compiler/`, `stdlib/`, or `runtime/`.

The service preserves the identities each role has today:

| Source role | Virtual module identity |
|---|---|
| Selected root binary (`sfn/compiler`) | path relative to its `src/` root, for example `cli/main`; the binary is not its own dependency |
| Library workspace member | `<manifest-name>/<path-relative-to-src>`, for example `sfn/syntax/parser/mod` |
| Runtime-provider source | `<sfn-module-prefix>/<path-relative-to-sfn-source-root>`, preserving `runtime/sfn/string` |
| Implicit prelude | `sfn/prelude/mod`; the sole intentional transition from `runtime/prelude` |

The selected-root rule resolves the driver's current ambiguity: moving
`compiler/src/cli/main.sfn` to `compiler/driver/src/cli/main.sfn` keeps the
virtual identity `cli/main`, not `sfn/compiler/cli/main`. Compiler phase and
standard-library capsules retain their manifest-prefixed identities because
their `src/`-relative paths do not change.

Runtime identity becomes explicit in the runtime manifest:

```toml
[build]
kind = "runtime"
sfn-source-root = "src"
sfn-module-prefix = "runtime/sfn"
sfn-sources = [
    "src/runtime_globals.sfn",
    "src/string.sfn",
    # ...
]
```

Before the physical move, the compatibility form uses
`sfn-source-root = "sfn"`, the same `sfn-module-prefix = "runtime/sfn"`, and
the existing `sfn/...` entries. The resolver verifies every `sfn-sources` and
gate entry is contained by the declared source root, strips that root, and
prepends the virtual prefix. The move changes the root and entry paths together
but not module slugs, runtime ABI symbol handling, or cache identity.

The source-identity service and the two runtime manifest fields are compiler
capabilities consumed by the pinned seed. They must be implemented with
byte-identical results on the current tree, released, and pinned before any
compiler, driver, or runtime source root moves. Installed dependency lookup may
retain `<prefix>/capsules/<scope>/<name>`; in-repository lookup uses workspace
members.

The prelude is the one intentional identity transition. Its current
`runtime/prelude` slug is one of the special cases SFEP-0006 §4.8 requires the
toolchain to retire. The real capsule uses `sfn/prelude/mod`. This is not a
public import rename—`sfn/prelude` is the manifest identity already on disk—but
it can rename private module-mangled symbols and cache entries. The prelude
slice must therefore:

1. preserve explicitly named runtime ABI symbols;
2. classify all other IR changes with the rename-only classifier and an
   explicit `runtime/prelude` → `sfn/prelude/mod` map;
3. prove exactly one prelude object is linked into every build; and
4. reject any semantic IR difference that is not separately reviewed.

### 3.3 Prelude manifest and implicit dependency

The end-state manifest is self-contained:

```toml
[capsule]
name = "sfn/prelude"
version = "<unchanged-unless-separately-released>"
description = "Sailfin standard prelude (collections, strings, type checks)"

[capabilities]
required = ["clock", "io", "net"]

[build]
kind = "library"
entry = "src/mod.sfn"
implicit = true
```

No `[build].entry` may resolve outside its capsule root. `sfn/prelude` is
included once through workspace implicit-dependency resolution. The runtime
manifest's transitional `prelude-entry` field retires, as do hard-coded
`runtime/prelude.sfn` packaging and module-slug branches.

The prelude does **not** declare a dependency on `sfn/runtime-native`. That
would make the prelude depend on one concrete target provider and, if the
runtime declares its normal `sfn/prelude` edge, create a manifest cycle.
Instead, the runtime provider declares the ordinary edge:

```toml
[dependencies]
"sfn/prelude" = "*"
```

The graph deduplicates that edge with the globally implicit member. The
prelude's calls into the selected runtime use the runtime-provider ABI, which
is resolved only at final link. The seven current relative imports from
`./sfn/{array,clock,exception,io,process,string,type_meta}` are replaced before
the move by typed `extern fn` declarations for the same `sfn_*` symbols. The
remaining `runtime.X` delegates already use the descriptor/provider ABI and
stay unchanged; retiring that magic namespace is a separate seed-gated runtime
project, not topology work. This gives `stdlib/prelude/src/mod.sfn` no
filesystem or manifest edge back into `runtime/` while preserving its wrappers
and explicit runtime ABI names.

The seven imported modules are in the runtime's unconditional source set, so
the provider contract does not widen demand. In particular, the prelude's
`serve` wrapper continues to reference the established descriptor ABI and is
dead-stripped when `net` is not demanded; this proposal does not force
`full-runtime = true`. Prelude adoption must test a no-`net` binary, a
`net`-demanding binary, the full-runtime compiler build, and alternate-target
runtime conditioning. A selected replacement runtime must provide the same
prelude ABI surface.

`required = ["clock", "io", "net"]` is the provider capsule's authority
ceiling, not an eager grant to every consumer. This corrects the current
parse-only shell: the source already declares `sleep`/`monotonic_millis`
(`clock`), logging/printing/process wrappers (`io`), and `serve` (`io`, `net`).
An imported function's effects propagate only when a consumer calls it, under
SFEP-0008 §4.2 and §4.6. The toolchain-provided implicit prelude is audited as a
dependency, not unioned into the consumer workspace's declared-member envelope;
the caller's propagated effect remains subject to its own capsule and workspace
ceilings. A workspace that explicitly supplies or overrides `sfn/prelude` as
one of its members must grant that member `clock`, `io`, and `net` (or narrow
its source). Regressions prove that a pure program and a workspace denying
`net` still build when they do not call a net-effecting prelude function, while
calling `serve` requires and audits `net` normally.

#### Implicit symbol provenance

`implicit = true` makes names available without a source import; it does not
make them provider-less. The seeded implicit-member capability must load the
prelude's emitted interface/layout metadata and attach provider module
`sfn/prelude/mod` to every implicit function, value, and type. The analyzer's
filesystem name scanner may remain only as a bounded compatibility path while
`runtime/prelude.sfn` is authoritative; it retires in the adoption slice.

Lowering uses that provider metadata for ordinary calls and address-taken
function values, rewriting them to the prelude module's qualified definitions.
The six prelude-mirror calls (`char_code`, `char_at`, `char_from_code`,
`find_char`, `string_starts_with`, and `record_eq_flag_message`) consume the
same provider-qualified interface instead of emitting provider-less bare
externs. The rewrite scans both `call @name` and bare `@name` references so a
prelude function passed as a value cannot become an undefined symbol. Explicit
runtime-provider ABI names remain unmangled under §3.2.

This provenance/rewrite is part of the slice-2 `seed-blocker`, not an adoption
fixup. While the real prelude shell is `implicit = false`, fixtures activate a
contained synthetic implicit capsule and prove an ordinary call, a mirror-style
call, a type/value lookup, and an address-taken function all resolve to one
qualified provider and link once. The released seed must pass those fixtures
before the real prelude is enabled.

This cannot be combined with the physical move in the first implementation
slice. `toml_get_build_implicit` is currently a parse-only getter with no
production consumer. The pinned seed reads the committed workspace and runtime
manifests during `make compile`; a freshly built compiler cannot repair a
capability absent from the seed that is needed to build that compiler.

Prelude adoption shares the bootstrap capability gate with source identity:

1. Set the existing manifest shell to `implicit = false` while it still points
   at `runtime/prelude.sfn`; this prevents a new consumer from linking the
   prelude twice.
2. Implement implicit workspace-member consumption and the “exactly once”
   rule, plus the source-identity fields in §3.2, with the old tree and runtime
   `prelude-entry` still authoritative.
3. Land regression coverage, release that complete capability family, and pin
   a seed containing it before any physical adoption.
4. Rewrite the prelude's seven relative runtime imports to the provider ABI at
   its old location and prove byte-equivalent behavior.
5. Move the source to `stdlib/prelude/src/mod.sfn`, set `implicit = true`, add
   the runtime's `sfn/prelude` dependency, and remove `prelude-entry` in one
   atomic, revertible slice.
6. Remove the legacy path/module/link/package special cases only after the
   clean fixed-point build proves the manifest path is authoritative.

The capability-family leaf is a `seed-blocker`; every adoption leaf records it
under “Required in pinned seed”. The capabilities cross one scheduled seed
boundary together, following SFEP-0026 rather than triggering reactive cuts.

### 3.4 Test ownership

Tests follow the same ownership rule as sources:

- A test of one capsule's API or private contract lives in that capsule's
  `tests/` directory.
- `compiler/tests/unit` remains for driver-owned utilities and whole-compiler
  contracts that do not have one phase owner.
- `compiler/tests/integration` covers interactions between compiler roles.
- `compiler/tests/e2e` covers installed CLI, build, self-host, and language
  behavior.
- Runtime-provider tests live under `runtime/tests` unless they are compiler
  integration/e2e tests.
- Shared fixtures stay under the suite that owns them; a fixture is not a
  workspace member unless it intentionally carries a manifest.

Test classification is gradual. A capsule root may move before all tests are
re-homed, provided the old central suite still resolves it by manifest identity
and remains green. An implementation leaf must not mix a source-root move with
unrelated test-ownership cleanup.

Discovery and sharding consume three explicit roots—`compiler`, `stdlib`, and
`runtime`—then select `*_test.sfn` files. The existing weight table remains
keyed by physical test filename because that is the file the runner executes.
A test-move slice regenerates affected rows, runs shard coverage, and records
the rebalance; it does not introduce a second logical-key compatibility layer.

### 3.5 Identity checks versus physical checks

#### Manifest-identity checks

The following checks must resolve the owning workspace member and operate on
its canonical manifest data:

- compiler role dependency direction and the no-reverse-edge rules;
- `publish = false` for every compiler capsule;
- allowed narrow standard-library dependencies;
- capsule version lockstep and release selection;
- capability ceilings;
- import ownership, reachability, and cross-capsule visibility;
- artifact roots and cache namespaces; and
- “one workspace member per canonical capsule name”.

For example, `compiler_capsule_boundary_test.sfn` must ask whether an imported
module belongs to `sfn/syntax`, not whether its path begins with
`compiler/capsules/syntax`.

#### Physical checks

The following remain physical because repository location is the contract they
enforce:

- workspace member discovery and allowed domain roots;
- manifest-entry and source containment, including symlink/reparse-point
  escapes;
- absence of retired roots after migration;
- source enumeration for formatting, watching, and packaging;
- test/fixture discovery;
- documentation links and contributor/agent navigation; and
- the module-layout fingerprint's input inventory.

Physical enumerators should expand `workspace.toml` and inspect member
manifests instead of repeating lists of capsule roots. Explicit non-capsule
inputs such as `workspace.toml`, `bootstrap.toml`, runtime IR, and cross-domain
tests remain separately named.

#### Hybrid checks

Cache keys and module identities bridge both domains. They use canonical
capsule identity and capsule-relative source path plus source/dependency/tool
content—not an absolute checkout path. A physical relocation may invalidate
the old on-disk cache once, but a clean build in two different checkout roots
must converge to the same identities and outputs. Stale cache compatibility is
not required.

### 3.6 Path-coupling migration inventory

Implementation grooming must classify, not merely count, every hit from the
acceptance audit:

```text
rg -n 'compiler/capsules|capsules/sfn|runtime/prelude' \
  workspace.toml Makefile compiler runtime capsules .github scripts docs .codex
```

The minimum inventory is:

| Surface | Required migration |
|---|---|
| `workspace.toml` and resolver fixtures | transitional dual globs; duplicate-name rejection; final three-root inventory |
| `compiler/src/module_paths.sfn` and boundary tests | resolve capsule owner/name; retain physical containment separately |
| source freshness and `scripts/module_layout_fingerprint.sh` | derive workspace source roots; include driver, runtime, and manifest inputs |
| build cache and artifact routing | exclude checkout path from logical identity; keep `build/capsules/<scope>/<name>` |
| `Makefile` fast checks, formatting, benchmarks, and capsule tests | consume discovered roots and preserve target names |
| seed/bootstrap fixtures | prove old seed parses each transitional workspace and resolves the full private dependency closure |
| compiler test discovery and shard weights | discover all owner-local roots exactly once; regenerate physical filename weights after moves |
| CI build caches and quality gates | hash the discovered source/manifests or the canonical fingerprint, not selected old paths |
| release and release-train workflows | discover manifests by workspace identity; preserve compiler-role lockstep and package contents |
| `sfn package`/install assets | stage `stdlib`, runtime sources, and the real prelude from their manifests |
| docs, `.codex`, `.github/agents`, and instructions | update current navigation with the slice; preserve historical proposal/RCA citations |

Historical statements are not rewritten merely because their paths are old.
Living commands, links, policies, and tests are updated. Fixtures that
deliberately model an old or external layout keep it and say so.

### 3.7 Rollback-safe migration sequence

Every numbered slice is a separately mergeable and revertible change. No slice
leaves two manifests with the same `[capsule].name`, and no compatibility
symlink is introduced.

1. **Topology contract and inventory.** Add a repository-topology test that
   loads workspace members, rejects duplicate names and escaping entries, and
   records the allowed current and future roots. Add the path-coupling
   inventory as test data or a maintained convention. No source moves.
2. **Bootstrap capability family.** Add the one manifest-aware source-identity
   service; consume `sfn-source-root` / `sfn-module-prefix` for runtime sources;
   and implement `implicit = true` graph/link semantics plus provider-qualified
   symbol provenance for calls, values, types, and mirror references. Results
   on the current tree must be byte-identical. Set the existing prelude shell
   to `implicit = false` before enabling the consumer, retain `prelude-entry`,
   and prove arbitrary physical member roots in fixtures. Correct the prelude's
   manifest ceiling to `["clock", "io", "net"]` while it remains dormant. This
   complete capability family is a `seed-blocker`.
3. **Release and pin the capability family.** Publish a release containing
   slice 2 and update `bootstrap.toml`. Re-run the private-workspace, source
   identity, runtime-slug, and implicit-disabled fixtures against the released
   seed. No physical source path moves before this gate is green.
4. **Manifest-driven automation.** Make fingerprints, formatter/check roots,
   CI cache inputs, release manifest discovery, and test discovery consume the
   workspace inventory while the old layout remains. Behavioral ownership
   checks switch to manifest identity here.
5. **Standard-library migration.** Add `stdlib/*` beside
   `capsules/sfn/*`, then move public capsules in dependency-aware batches.
   Each batch removes the old member before adding the same manifest at its new
   path. The prelude is excluded from this slice.
6. **Private compiler roles.** Add `compiler/*` beside `compiler` and
   `compiler/capsules/*`; move `syntax`, `ir`, `analyzer`, `codegen`, and
   `codegen-llvm` one capsule at a time without changing their internal
   `src/`-relative paths. Update each role's owner-local tests and living docs
   only when needed for that capsule.
7. **Compiler driver.** Move the root manifest and `compiler/src` together to
   `compiler/driver`. Bootstrap/build invocations use that physical path while
   artifact, virtual driver identity, and installed-command assertions remain
   unchanged. Replace the literal `compiler` workspace member in the same
   commit; validate the prospective manifest against the pinned seed before
   moving so no committed state contains a dangling member.
8. **Runtime source root.** With the pinned seed already consuming the virtual
   identity fields, change `sfn-source-root` from `sfn` to `src`, move
   `runtime/sfn/**` to `runtime/src/**`, and update source/gate arrays. Prove
   every `runtime/sfn/*` virtual slug remains unchanged. Do not combine this
   with prelude adoption.
9. **Prelude provider boundary.** At `runtime/prelude.sfn`, replace the seven
   `./sfn/*` imports with typed declarations of the selected runtime-provider
   ABI. Keep `prelude-entry` and prove the current link, demand gates, and
   emitted behavior are unchanged.
10. **Prelude adoption.** Move the file to `stdlib/prelude/src/mod.sfn`, set its
    manifest to `implicit = true`, add the runtime-to-prelude dependency, remove
    `prelude-entry`, update package/install inputs, classify the identity
    rename, switch implicit names/mirrors from the filesystem scanner to the
    provider-qualified interface, and delete legacy special cases atomically.
11. **Test ownership cleanup.** Move remaining single-owner compiler and runtime
   tests beside their capsules in bounded batches. Regenerate affected shard
   weights and prove discovery coverage after each batch.
12. **Remove transition support.** Delete `capsules/`,
    `compiler/capsules/`, dual globs, aliases, and current-document references
    only after no production or test path uses them. Update `docs/status.md`,
    the compiler-capsule extraction convention, and contributor/agent guidance;
    then mark this SFEP Implemented only after the complete tree self-hosts.

If any slice requires a new seed capability beyond slices 2–3, it pauses before
adoption and follows the capability-first rule in `.claude/rules/seed-dependency.md`.
It does not add a build-driver fallback or path fixup.

### 3.8 Structural verification contract

Each structural implementation slice records a before/after baseline and runs:

1. `sfn fmt --write <touched .sfn files>` followed by
   `sfn fmt --check <touched .sfn files>`;
2. `make clean-build`, because source roots or module graphs changed;
3. `make compile` before any targeted test, so tests use the fresh compiler;
4. the narrow resolver, topology, boundary, release, discovery, and runtime
   suites named by that slice;
5. `make check` for the two-pass fixed-point self-host gate;
6. `make check-determinism` on supported release hosts, plus rename-only IR
   classification for modules whose internal spelling intentionally changed;
7. a before/after cold `make compile`, warm/no-op compile, compiler check, and
   peak-RSS measurement on the same host; and
8. package/install verification whenever package contents, release discovery,
   or the driver/prelude/runtime roots change.

A move is blocked by a semantic IR difference, a changed public artifact path,
a missing/duplicate test, or a statistically material performance regression.
For time/RSS measurements, three runs before and after are recorded; a median
regression above 5% requires remediation or an explicit accepted explanation.
Path-only cache misses on the first build after migration are expected and are
reported separately from steady-state behavior.

Representative targeted gates include:

```text
build/bin/sfn test compiler/tests/unit/workspace_resolver_test.sfn
build/bin/sfn test compiler/tests/unit/compiler_capsule_boundary_test.sfn
build/bin/sfn test compiler/tests/e2e/seed_private_workspace_fixture_test.sfn
build/bin/sfn test compiler/tests/e2e/module_layout_fingerprint_test.sfn
build/bin/sfn test compiler/tests/e2e/compiler_capsule_release_lockstep_test.sfn
build/bin/sfn test compiler/tests/e2e/dev_shard_test.sfn
build/bin/sfn test compiler/tests/e2e/rename_only_ir_classifier_test.sfn
build/bin/sfn test compiler/tests/e2e/runtime_sfn_sources_link_consumer_test.sfn
```

The topology-contract, implicit-prelude, and package/install regressions named
above are new tests to be added by their owning implementation slices.

## 4. Effect & capability impact

This proposal changes no language effect rule and grants no source function new
authority. Compiler phases remain authority-free as specified by SFEP-0020,
the driver retains its declared toolchain authority, and standard-library and
runtime capabilities remain with their current logical owners.

The prelude manifest is the one correction: its parse-only `required = []` is
not an honest ceiling for source that already declares `clock`, `io`, and `net`
effects, and the current empty-list sentinel skips E0403. Before the manifest
becomes load-bearing it changes to `required = ["clock", "io", "net"]` and the
normal capability validator must check it. As §3.3 specifies, availability of
an implicit provider does not eagerly propagate all its latent API effects to a
consumer. Calls propagate their declared effects normally; consumer capsule
and workspace envelopes remain the enforcement points. An explicit workspace
override of `sfn/prelude` is an ordinary member and must fit that workspace's
grant/deny policy.

Manifest-driven ownership checks strengthen capability review: a source cannot
gain an allowed effect because it moved under a privileged path, and moving a
capsule cannot change its capability ceiling. Making `sfn/prelude` a real
capsule turns its existing effects into an enforced provider-local ceiling;
implicit dependency is graph membership, not an eager consumer authority grant.

## 5. Self-hosting impact

The design changes repository topology, workspace member paths, source
discovery, runtime source-identity manifest fields, and implicit-member
consumption. It changes no lexer, parser, AST, type, effect, or target IR
semantics, but its bootstrap capability family does change analyzer symbol
provenance and LLVM symbol rewriting for implicit providers. Physical moves can
also affect cache keys, import contexts, and bootstrap inputs, so the capability
and adoption slices use the strictest self-hosting path.

`make compile` is run by the released compiler pinned in `bootstrap.toml`. Every
workspace form committed during migration must therefore be parsed and
resolved by that seed. Existing literal and trailing-one-level-glob syntax is
sufficient for the domain moves, but the seed fixture is rerun before relying
on it. A working-tree compiler capability is not assumed to help the pinned
seed consume that same working tree.

The complete source-identity and implicit-provider family is the explicit seed
gate (§§3.2–3.3). Its parser/resolver/analyzer/lowering capability lands and is
released before the workspace adopts it. Runtime source continues
to obey the stricter runtime carve-out: if a relocated runtime source starts
calling a compiler builtin/intrinsic absent from the seed, that capability
lands alone as a `seed-blocker`; topology work must not manufacture such a
dependency.

Fixed-point success means more than two green binaries: module identity,
artifacts, and package contents must be deterministic from clean roots. No
caller-side memory-limit workaround, alternate build driver, or fallback path
is permitted.

## 6. Alternatives considered

### 6.1 Keep the SFEP-0020 layout

This has the lowest migration risk and the current tree is functional. It
retains the misleading driver-root/phase-child asymmetry, redundant
`capsules/sfn` hierarchy, out-of-root prelude, and widespread path coupling.
Rejected because it leaves ownership less legible than the architecture.

### 6.2 Put every capsule under a single `packages/` root

`packages/compiler/*`, `packages/stdlib/*`, and `packages/runtime` would look
uniform, but the extra level adds no ownership information. A flat
`packages/*` would erase the important distinction between private compiler
implementation, public libraries, and runtime provider assets. It also makes
private phases look publishable and does not simplify cross-domain test or
release policy. Rejected in favor of direct domain roots.

### 6.3 Put all `sfn/*` capsules under `capsules/sfn/`

This aligns physical and logical scope but mixes private compiler internals
with user-consumable standard-library inventory. `[capsule].name` and
`publish` already express scope and publication; directory placement should
express repository ownership. SFEP-0020 rejected this mixing and that judgment
still stands.

### 6.4 Keep the compiler driver at `compiler/`

This minimizes bootstrap changes, but preserves the exact asymmetry motivating
the proposal: the driver capsule remains the root and its logical peers remain
children. Rejected.

### 6.5 Preserve old roots with symlinks or forwarding manifests

Symlinks behave differently in archives and on Windows, complicate cleanup,
and risk duplicate discovery. Two manifests with the same canonical name make
workspace resolution order a hidden semantic choice. Transitional dual globs
with exactly one real manifest per capsule are deterministic and revertible;
compatibility roots are rejected.

### 6.6 Move files immediately and repair callers afterward

The source tree would be temporarily clearer, but bootstrap, release, cache,
test, and boundary behavior would fail in different commits. It would also
encourage driver fixups. Rejected in favor of making consumers topology-aware
before their inputs move.

## 7. Stage1 readiness mapping

This proposal is Draft and the new topology is not implemented. The design PR
changes documentation only, so language pipeline items remain unchanged:

- [x] Parses — no syntax change; existing language behavior remains shipped.
- [x] Type-checks / effect-checks — no type/effect change.
- [x] Emits valid `.sfn-asm` — no emitter change.
- [x] Lowers to LLVM IR — no lowering change.
- [ ] Regression coverage — implementation slices must add the topology and
  implicit-prelude contracts and update all targeted suites in §3.8.
- [ ] Self-hosts — every structural slice must pass clean two-pass self-host;
  the complete end-state tree has not done so.
- [x] `sfn fmt --check` clean — no `.sfn` file changes in this design PR;
  implementation slices carry their own formatting gates.
- [ ] Documented in `docs/status.md` + spec — `docs/status.md` remains truthful
  about the current tree. It and living conventions update during graduation;
  no language-spec change is expected.

SFEP-0020 remains Implemented. This proposal supersedes only its physical
layout prescription (§3.2) after this proposal itself reaches Implemented; its
role ownership, dependency invariants, privacy rules, and readiness record
remain normative throughout migration.

## 8. Test plan

The design PR runs `git diff --check` and verifies this draft's front matter and
registry entry against SFEP-0001. It also repeats the path audit in SFN-928 to
confirm every semantic class is represented in §3.6. It does not run compiler
build gates because no executable source, manifest, or workflow changes.

Implementation coverage is layered:

- Unit: workspace glob expansion, duplicate canonical names, member/source
  containment, selected-binary identity, manifest-prefixed library identity,
  runtime source-root/prefix virtual slugs, implicit-member selection,
  exactly-once graph insertion, provider-qualified calls/types/values, bare
  function-value rewriting, mirror provenance, boundary rules by capsule
  identity, and test-root discovery.
- Integration: old/new transitional workspaces, mixed migrated and unmigrated
  members, local-over-lock/cache/registry precedence, cache behavior across
  checkout roots, runtime-to-prelude dependency closure, provider-ABI symbol
  satisfaction, no-cycle graph construction, provider-local capability
  validation, and consumer-envelope non-widening for unused latent APIs.
- End to end: pinned-seed private workspace fixture, clean compiler self-host,
  source-layout fingerprint, test shard coverage, compiler release lockstep,
  package/install contents, installed `sfn` name, manifest-derived artifact
  paths, prelude exactly-once link, no-`net`/`net`/full-runtime demand behavior,
  a pure workspace that denies unused `net`, ordinary/mirror/function-value
  implicit prelude calls, cross-platform runtime source selection, and
  rename-only IR classification.
- Full gates: the structural contract in §3.8, including `make check`,
  determinism, and before/after time/RSS measurements.

## 9. References

- [SFN-928 — define a uniform physical layout for first-party capsules](https://linear.app/sailfin/issue/SFN-928/docssfep-define-a-uniform-physical-layout-for-first-party-capsules)
- [Repository Topology & Capsule Layout project](https://linear.app/sailfin/project/repository-topology-and-capsule-layout-fd4f474aaaae)
- [SFEP-0001 — SFEP Purpose and Process](./0001-sfep-process.md)
- [SFEP-0006 — Unified Build Architecture](./0006-build-architecture.md),
  especially §§2.11, 4.2, 4.4, 4.8, 4.10, and 4.12
- [SFEP-0020 — Role-Oriented Compiler Capsules](./0020-compiler-decomposition.md)
- [SFEP-0026 — Delivery Process](./0026-delivery-process.md)
- [SFEP-0040 — Global Artifact Cache Store and Garbage Collection](./0040-artifact-cache.md)
- [SFEP-0051 — Workspace Manifest](./0051-workspace-manifest.md)
- [Compiler capsule extraction procedure](../conventions/compiler-capsule-extractions.md)
- [Seed dependency rule](../../.claude/rules/seed-dependency.md)
- [Self-host invariant](../../.claude/rules/selfhost-invariant.md)
