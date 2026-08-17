---
sfep: 20
title: Role-Oriented Compiler Capsules
status: Implemented
type: tooling
created: 2026-06-22
updated: 2026-08-17
author: "agent:compiler-architect; project owner (direction + naming); agent:Codex (2026-08-03 amendment; 2026-08-08 §3.5 corrections 1–2 status); agent:implementer (2026-08-05 provider slot); agent:Sailbot (2026-08-06 narrow-stdlib matrix amendment; 2026-08-06 §3.5 correction 7 prelude-slug extension)"
tracking: "#345 (historical epic); Linear project Role-Oriented Compiler Capsules. §3.7 steps 1-2 (landed): SFN-705, SFN-706, SFN-707, SFN-708, SFN-709, SFN-710, SFN-711, SFN-712, SFN-713, SFN-714, SFN-715, SFN-717, SFN-718, SFN-734. §3.7 steps 3-8 (groomed 2026-08-06): SFN-735 through SFN-751."
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0020 — Role-Oriented Compiler Capsules

> The 2026-08-03 amendment replaces the original
> `compiler-frontend` / `compiler-backend` / `compiler-common` design. The
> compiler has more than doubled in size since that design was measured, and
> its present phase structure supports boundaries named for responsibilities
> rather than for which side of the pipeline they occupy.

## 1. Summary

Decompose the self-hosted compiler into six workspace-private capsules:
`sfn/syntax`, `sfn/analyzer`, `sfn/ir`, `sfn/codegen`,
`sfn/codegen-llvm`, and the `sfn/compiler` binary. Each name denotes a stable
responsibility and an explicit input/output contract. All six capsules live
under `compiler/`, carry `[capsule] publish = false`, version in lockstep with
the compiler, and remain implementation details of the Sailfin toolchain. A
seventh name, `sfn/codegen-native`, is **reserved but not created** by this
proposal — it is the peer-provider slot SFEP-0066 §3.2 requires, and every
count of "six capsules" below excludes it.

This design deliberately has no `frontend`, `backend`, or `common` capsule.
Those labels describe relative position, not ownership. A generic common
capsule would also turn dependency mistakes into a permanent dumping ground.
Shared generic functionality belongs in the standard library; shared compiler
data belongs to the phase that defines its contract.

## 2. Motivation

The compiler is again large enough that a single capsule obscures ownership,
inflates rebuilds, and makes independent tool surfaces harder to isolate. On
2026-08-03, `compiler/src/` contains **351 `.sfn` files and 145,292 lines**,
compared with the original proposal's 166 files and approximately 99,000 lines.
The current tree now has substantial dedicated subgraphs for:

- syntax (`parser/`, `lexer.sfn`, `token.sfn`, `ast.sfn`);
- semantic analysis (`typecheck/`, `typecheck_types/`, `effect_checker/`,
  ownership, decorators, and diagnostics);
- three intermediate representations (native IR, typed SSA, and tensor IR);
- LLVM lowering (`llvm/`, currently 139 files and approximately 65,000 lines);
- workspace/build orchestration (`build/`, `capsule_resolver/`);
- commands and tools (`cli/`, `tools/`, test orchestration).

The original two-way cut no longer describes this system. In particular:

1. `frontend` bundled tokenization, parsing, semantic analysis, import metadata,
   and user diagnostics even though `sfn check`, formatting, symbol indexing,
   and future language services need different subsets of those facilities.
2. `backend` bundled target-neutral IR, optimization, LLVM-specific lowering,
   filesystem publication, assembly, and linking. That boundary conflicts with
   SFEP-0066's requirement that LLVM be a replaceable provider.
3. `common` was defined by the existence of cycles rather than by a coherent
   contract. That rewards the current dependency graph instead of correcting it.
4. The old proposal marked reusable compiler libraries publishable. These are
   not standard-library APIs and must not acquire compatibility obligations by
   accident.

The goal is not to make the compiler look sophisticated by choosing unusual
names. Mature compilers routinely use responsibility names such as syntax,
semantic analysis, IR, code generation, and target-specific generation. The
production-quality property is that each name predicts what the capsule owns,
what it may depend on, and what it returns.

## 3. Design

### 3.1 Naming and visibility decisions

The accepted capsule set is six, plus one reserved slot marked as such:

| Capsule | Responsibility | Stable output | Must not own |
|---|---|---|---|
| `sfn/syntax` | Lexing, parsing, source spans, tokens, and AST shapes | parsed syntax tree | symbol resolution, type/effect rules, lowering |
| `sfn/analyzer` | Name/import resolution, types, effects, ownership, decorators, and semantic diagnostics | analyzed program + diagnostics | CLI rendering, filesystem discovery, target lowering |
| `sfn/ir` | Native IR, typed-SSA, and tensor-IR data models, parsers, renderers, and verifiers | validated IR values | AST traversal, target code generation, file publication |
| `sfn/codegen` | Target-neutral lowering from analyzed syntax into Sailfin IR, including IR-producing optimization passes | verified Sailfin IR | LLVM spelling, process execution, linking |
| `sfn/codegen-llvm` | LLVM-specific lowering from Sailfin IR to LLVM IR/object inputs | LLVM module text or object-ready data | parsing source, semantic analysis, final linking |
| `sfn/codegen-native` | *(empty slot)* A native code-generation provider, peer to `sfn/codegen-llvm`, consuming verified Sailfin IR directly instead of LLVM text | object-ready data | parsing source, semantic analysis, final linking |
| `sfn/compiler` | The `sfn` binary: command dispatch, workspace resolution, build planning, caches, artifact I/O, toolchain selection, assembly, and linking | executable/tool responses | reusable language-phase implementations |

`analyzer` is preferred to `semantics` because it names an executable service:
given parsed input and imported interfaces, it produces an analyzed program or
diagnostics. `codegen` is retained because it is the precise industry term for
the transformation being performed. The LLVM implementation is named
`codegen-llvm` rather than `backend` so its target dependency is visible and a
future provider can sit beside it without renaming the rest of the compiler.
`sfn/codegen-native` is that named slot (SFEP-0066 §3.2); it stays empty until
it clears §3.7's no-placeholder rule.

The `sfn/*` names are workspace identities, not public-library promises.
`publish = false` is the normative distribution boundary. Promoting any one of
these capsules into a supported external API requires a separate SFEP covering
versioning, compatibility, documentation, and registry publication.

### 3.2 Physical layout

Standard-library capsules remain under the repository's top-level `capsules/`
directory. Compiler implementation capsules do not go there:

```text
compiler/
  capsule.toml                 # sfn/compiler, binary, publish = false
  src/                         # driver/build/CLI during and after migration
  capsules/
    syntax/
      capsule.toml             # sfn/syntax
      src/mod.sfn
    analyzer/
      capsule.toml             # sfn/analyzer
      src/mod.sfn
    ir/
      capsule.toml             # sfn/ir
      src/mod.sfn
    codegen/
      capsule.toml             # sfn/codegen
      src/mod.sfn
    codegen-llvm/
      capsule.toml             # sfn/codegen-llvm
      src/mod.sfn
```

`workspace.toml` adds `compiler/capsules/*` as a member glob. The existing
`capsules/sfn/*` glob continues to mean first-party standard-library capsules;
the two populations are visibly distinct in the repository even though their
capsule names share the `sfn` scope.

Every library exposes a small `src/mod.sfn` facade. Consumers import that
facade or an explicitly documented submodule; filesystem location is not an
implicit public API. Internal capsules share the compiler release version and
are upgraded atomically. When SFEP-0051 workspace package inheritance ships,
the version should be inherited rather than copied into six manifests.

### 3.3 Dependency graph

The allowed direct dependencies are:

| Capsule | May depend on |
|---|---|
| `sfn/syntax` | runtime prelude and narrow standard-library capsules |
| `sfn/ir` | runtime prelude and narrow standard-library capsules |
| `sfn/analyzer` | `sfn/syntax`, `sfn/ir`, and narrow standard-library capsules |
| `sfn/codegen` | `sfn/syntax`, `sfn/analyzer`, `sfn/ir`, and narrow standard-library capsules |
| `sfn/codegen-llvm` | `sfn/ir` and narrow standard-library capsules |
| `sfn/codegen-native` | `sfn/ir` and narrow standard-library capsules |
| `sfn/compiler` | all internal libraries, runtime, and required standard-library capsules |

The intended data flow is:

```text
source text
  -> sfn/syntax          (AST)
  -> sfn/analyzer        (analyzed program + diagnostics)
  -> sfn/codegen         (validated Sailfin IR)
  -> sfn/codegen-llvm    (LLVM/object input)
  -> sfn/compiler        (artifact publication, assembly, and link)
```

Narrow standard-library capsules (`sfn/strings`, `sfn/json`, `sfn/path`, and
the rest of the non-capability-bearing set) are available to *every* internal
role, including `sfn/codegen` and the codegen providers. They are leaf
dependencies: they import no internal compiler capsule, so granting them
creates no reverse edge and preserves dependency fan-out. Without this,
§3.5.7's "generic helpers graduate" is unachievable for codegen and the
providers, which would be left owning private copies of exactly the generic
helpers the correction retires. Capability-bearing capsules remain restricted
to `sfn/compiler`; that is the boundary this grant does not cross.

`sfn/ir` is a representation dependency used by the middle stages, not an
orchestrating stage. Its representations must therefore remain independent of
syntax, analysis, code generation, and the driver.

There is a real cost to `sfn/analyzer -> sfn/ir`: the current resolver
enumerates every `.sfn` source in a dependency capsule rather than compiling
only the entry facade's import closure. Grouping native IR, typed SSA, and
tensor IR therefore makes analyzer-only consumers stage the entire IR capsule.
The first extraction must measure that cost. If it materially defeats the
`sfn check` isolation goal, split the serialized import contract into a narrow
workspace-private `sfn/module-interface` capsule; do not solve the problem by
moving artifact parsing into analyzer or by restoring a generic common capsule.
For this decision, "materially" means more than a 5% regression in the
three-run median cold `sfn check` wall time or peak RSS against the monolith
baseline on the same host.

#### 3.3.1 Adjudication (2026-08-15, SFN-747) — over the gate

**Verdict: the 5% gate is exceeded, decisively.** Three-run median cold
`sfn check` peak RSS on the `trivial` workload went from **157.7 MiB at the
monolith baseline to 696.3 MiB in the current tree (+341.5%)** — 68× the 7.9 MiB
budget — measured across a five-point commit series on one host, with the
monolith commit re-measured there and reproducing the frozen baseline to within
0.2 MiB. The `sfn/analyzer` extraction's own isolated marginal cost is
**+35.0%**, 7× the gate. Full data, procedure, and caveats:
`docs/perf/decomposition-baseline.md` § "2026-08-15 — SFN-747 §3.3 adjudication".

**The prescribed remedy does not address the measured cause, so it is not
adopted here.** This paragraph's cost model is the `sfn/analyzer -> sfn/ir` edge
making analyzer-only consumers stage the whole IR capsule. Measurement shows the
regression instead tracks the *number of internal capsules the consuming
manifest declares*: `compiler/capsule.toml` names all five directly (it named
none at the baseline), so a check inside the compiler project enumerates all
five regardless of that edge, and each extraction contributed cost of the same
order (syntax+ir +136 MiB, analyzer +120 MiB, codegen+codegen-llvm +233 MiB). A
narrow `sfn/module-interface` capsule would remove part of one 120 MiB
contribution out of a 539 MiB regression. There is also no analyzer-only
consumer in the tree today — one binary capsule exists and it depends on all
five — so the shape this paragraph reasoned about is currently hypothetical.

The mechanism is confirmed live in code, not merely inferred:
`_cr_collect_capsule_sources`
(`compiler/src/capsule_resolver/discovery.sfn:181-251`) enumerates a dependency
capsule's whole `src/` tree with no import-relevance test. SFN-833 / SFEP-0070
added a reachability filter that narrows this on the *build* path, but
`sfn check` deliberately does not call it
(`compiler/src/capsule_resolver/reachability.sfn:648-665`) so that check's
staged set stays a superset of build's. Extending that filter to check is the
remedy the evidence points to; it is forbidden by neither prohibition above
(it moves no artifact parsing into the analyzer and restores no generic common
capsule), but it is outside what this paragraph sanctions, so it requires an
explicit design decision. Tracked as SFN-894; **`sfn/module-interface` is not
adopted or rejected on its own merits here — it is set aside as not responsive
to the measured cost.**

The following dependency rules are build/test invariants:

- no internal library imports `sfn/compiler` or files from its source tree;
- `sfn/syntax` never imports `sfn/analyzer`;
- `sfn/ir` never imports syntax, analyzer, codegen, LLVM, or driver modules;
- `sfn/codegen-llvm` never reparses source or invokes semantic analysis;
- only `sfn/compiler` performs workspace discovery, persistent artifact I/O,
  process execution, assembly, or final linking;
- no top-level standard-library capsule imports an internal compiler capsule.

### 3.4 Source ownership map

This table is a migration map, not a promise that every current file moves
unchanged. Mixed-responsibility files must be split at the contract boundary.

| Current area | Destination |
|---|---|
| `lexer.sfn`, `token.sfn`, `ast.sfn`, `parser/` | `sfn/syntax` |
| `typecheck/`, `typecheck_types/`, `effect_checker/`, ownership, decorators, import/re-export checks, semantic diagnostic model | `sfn/analyzer` |
| `native_ir*` data/parser/verification, `typed_ssa.sfn`, `typed_ssa_{render,verify}.sfn`, tensor-IR data/fusion/verification | `sfn/ir` |
| `emit_native*`, `emitter_sailfin*`, typed-SSA production, tensor lowering and target-neutral IR production | `sfn/codegen` |
| `llvm/` | `sfn/codegen-llvm` |
| `main.sfn`, `cli/`, `tools/`, `check/engine.sfn`, `build/`, `capsule_resolver/`, test runner, cache/manifest/version/lock/release modules, `backend.sfn` assembly/link provider | `sfn/compiler` |

The present `backend.sfn` stays with the compiler driver because it owns
external tool invocation and final link planning. It may later be renamed to a
driver-oriented name, but it is not part of `sfn/codegen-llvm`: generating LLVM
and invoking a host linker are separate responsibilities.

### 3.5 Boundary corrections required before moves

The current import graph contains historical shortcuts. They are not reasons to
reintroduce a `common` capsule. The migration first fixes these seams inside the
monolith, then moves files:

1. **Landed (SFN-734): syntax is syntax-only at this seam.**
   `parser/expressions/prefix.sfn` no longer imports `spawn_future_kind`; the
   symbol lives only in analyzer-side type rules. The parser retains the source
   type annotation, and the analyzer assigns the resolved future kind.
2. **Landed (SFN-734): IR owns its interchange types.** `NativeArtifact` is
   defined in `native_ir.sfn`, and `emit_native_layout.sfn` imports it from IR.
   Construction remains in codegen, so the edge points from codegen to IR and
   IR does not depend back on codegen or analyzer.
3. **Intrinsic semantics are not LLVM semantics.** Effect analysis currently
   reaches into `llvm/runtime_helpers`. Move target-neutral intrinsic identity
   and effect metadata into IR/analyzer-owned contracts. LLVM keeps only symbol
   and ABI lowering.
4. **LLVM does not re-run the frontend.** Lambda lowering currently imports the
   parser and capture analyzer. Capture/lift work must finish before the IR
   boundary so `sfn/codegen-llvm` consumes typed IR only.
5. **Code generation returns artifacts; the driver writes them.** Current emit
   and lowering paths import `build/fs.sfn`. Replace those edges with returned
   lines/bytes plus explicit diagnostics. `sfn/compiler` owns atomic publication
   and cache policy.
6. **Driver engines are not analysis libraries.** `check/engine.sfn` currently
   imports workspace resolution, build paths, and CLI-facing tools. It stays in
   `sfn/compiler` and calls a pure analyzer API. Diagnostic JSON/text rendering
   that encodes CLI or protocol envelopes also stays in the driver; diagnostic
   data types stay in `sfn/analyzer`.
7. **Generic helpers graduate; specialized helpers stay owned.** Replace
   generic string/TOML/JSON/path/crypto copies with `sfn/strings`, `sfn/toml`,
   `sfn/json`, `sfn/path`, and `sfn/crypto` where their APIs are sufficient.
   LLVM symbol sanitization belongs to `sfn/codegen-llvm`; native-IR text
   helpers belong to `sfn/ir`; build filesystem helpers remain in
   `sfn/compiler`. There is no catch-all support capsule.

   This includes the prelude's share of that surface. Seven files under
   `compiler/src/` import from the slug `"runtime/prelude"`, and between them
   they take exactly three symbols — `char_code` (4 sites), `substring` (3),
   `char_at` (2) — which are `sfn/strings` material by the rule above, and
   reachable there from every holding capsule under §3.3's narrow-stdlib grant.
   §3.3 permits `sfn/syntax`, `sfn/ir`, and `sfn/compiler` to depend on the
   runtime prelude, so imports from those roles are not invariant breaches;
   they are the same generic-helper cleanup, and doing it here removes the
   prelude from four of the five library capsules' dependency sets for free.

   What remains after that cleanup is a migration hazard rather than a
   boundary error, and it is **not this proposal's to fix.** `"runtime/prelude"`
   is a path-shaped import slug resolving to something that is not a capsule:
   no manifest resolution consults it, and the `capsules/sfn/prelude/` stub
   that nominally represents it contains only a `capsule.toml` whose
   `entry = "../../../runtime/prelude.sfn"` escapes its own root. §3.2 states
   that filesystem location is not an implicit public API; this slug is one,
   and the files holding it move to new relative depths under
   `compiler/capsules/*/src/`. SFEP-0006 §2.11 already catalogues the four
   privileges behind this (hard-coded location, hard-coded `runtime__prelude`
   module name, a link position outside `llvm-link`'s merge, and an implicit
   dependency from every other compile), and §4.8 already designs the fix —
   `sfn/prelude` as a real `implicit = true` library capsule, which is
   outstanding Stage F work. **Verify slug resolution from the new capsule
   depths as part of step 3**, and treat any breakage as a reason to pull
   SFEP-0006 §4.8 forward rather than to add a compensating path constant here.

Each correction must reduce or preserve dependency fan-out. A move that creates
a reverse edge is incomplete even if the workspace still compiles.

### 3.6 Private-capsule manifest contract

This SFEP moves `publish` from the old draft's proposed `[build]` location to
`[capsule]`, because publication is package-distribution policy, not a build
mode:

```toml
[capsule]
name = "sfn/analyzer"
version = "0.8.4"
description = "Sailfin semantic analysis pipeline (toolchain-internal)"
publish = false

[capabilities]
required = []

[build]
kind = "library"
entry = "src/mod.sfn"
```

Manifest semantics:

- `[capsule] publish` is a strict boolean and defaults to `true` for backwards
  compatibility. Any non-boolean value is a manifest error; it must not be
  interpreted as either true or false.
- `sfn publish` rejects `publish = false` before packaging, authentication, or
  any network call and names the capsule in the diagnostic.
- Workspace resolution may use a `publish = false` member from its declared
  local path. A conforming registry/cache resolver must reject a fetched
  manifest carrying `publish = false` before staging or compilation.
- Older compiler binaries cannot be retroactively constrained by this field.
  The package registry should also reject bundles whose manifests set
  `publish = false`, providing server-side defense against obsolete or modified
  publishing clients; that service change is tracked with the schema rollout.
- `publish = false` is not source-language visibility. Other members of the
  same workspace can import the capsule normally when they declare it.
- All six compiler capsules, including the binary, set `publish = false`.

### 3.7 Migration sequence

The decomposition lands as self-hosting slices:

1. **Private manifest policy.** Implement and test `[capsule] publish`, then set
   it on the existing compiler capsule without changing its name.
2. **Monolith boundary cleanup.** Land the seven corrections in §3.5 while all
   files still live under `compiler/src/`. Add static dependency tests before
   physical moves.
3. **Foundation capsules.** Create `sfn/syntax` and `sfn/ir`; move their leaf
   graphs and make the existing compiler depend on them.
4. **Analyzer capsule.** Move semantic analysis behind one analyzed-program API.
   `sfn check` remains a driver command but no longer pulls codegen through an
   analysis import.
5. **Target-neutral codegen.** Move IR production to `sfn/codegen`; keep all
   filesystem writes in the compiler.
6. **LLVM provider.** Move `llvm/` to `sfn/codegen-llvm` after the no-reparse and
   no-driver-import guards are green.
7. **Compiler identity.** Rename the root capsule from `sailfin` to
   `sfn/compiler`, preserving the executable path/name `build/bin/sfn` and the
   installed `sfn` command. Verify scoped artifact paths and cache prefixes.
8. **Final gate and measurements.** Run the fixed-point gate, full tests,
   determinism checks, and compare cold/warm compile time and peak RSS with the
   pre-migration baseline.

No step creates empty placeholder capsules far ahead of a source move. A new
capsule lands when it owns a usable contract and at least one real consumer.

## 4. Effect & capability impact

The decomposition changes no Sailfin effect semantics. It does make the
compiler's authority boundaries more honest:

- `sfn/syntax`, `sfn/ir`, `sfn/analyzer`, `sfn/codegen`, and
  `sfn/codegen-llvm` target `required = []`. They accept text/data and return
  values/diagnostics without filesystem, network, clock, or process effects.
- `sfn/compiler` retains the toolchain's `![io]`, `![clock]`, and `![net]`
  authority for workspace access, cache/artifact publication, timing, package
  operations, toolchain download, assembly, and linking.
- Any unavoidable effect in an internal library must be documented as a
  boundary exception and reviewed before the move; convenience is not enough.

This division ensures importing the analyzer does not implicitly grant the
authority needed to execute a linker or access the registry.

## 5. Self-hosting impact

This is a structural change to the self-hosted compiler and therefore follows
the strictest bootstrap path.

Before the first manifest switch, a fixture must prove that the pinned seed can:

1. parse the expanded workspace member list;
2. resolve the private library members from workspace paths;
3. build their transitive dependency order; and
4. link them into the `sfn/compiler` binary.

The seed does not need to enforce `publish = false` to build local members, but
it must tolerate the new manifest key. If it cannot, the schema implementation
must ship and be pinned as a seed before private manifests adopt the field.

For each `.sfn` change under `compiler/src/` or `compiler/capsules/`:

1. format the touched files;
2. run `make compile` before targeted tests so they use the new compiler;
3. run the narrow relevant unit/integration tests; and
4. keep the compiler able to rebuild itself at the end of the change.

Every physical capsule move is structural and therefore requires
`make clean-build` before rebuilding. The final slice runs `make check` to prove
the seedcheck fixed point. Module/capsule names affect symbol mangling and
artifact paths, so deterministic differences must be explained as mechanical
renames; semantic output must remain unchanged.

## 6. Alternatives considered

### Keep `compiler-frontend`, `compiler-backend`, and `compiler-common`

Rejected. Frontend/backend are directional labels that conceal several stable
services, and common has no ownership rule. The current tree already proves the
three names are too coarse.

### Use `sfn/compiler-*` for every component

Rejected as the default. The `sfn` scope, private manifest, and physical
`compiler/capsules/` location already establish ownership. Repeating
`compiler-` makes imports longer without making the boundary more precise.
Target-qualified names such as `sfn/codegen-llvm` remain appropriate because
the qualifier distinguishes implementations.

### Use only `sfn/analyzer`, `sfn/codegen`, and `sfn/compiler`

Rejected as the final architecture. It is a reasonable first extraction, but it
would leave target-independent IR contracts buried inside codegen and the
65,000-line LLVM graph inseparable from other generation work. `sfn/syntax`,
`sfn/ir`, and `sfn/codegen-llvm` create useful independent cache and dependency
boundaries.

### Name the semantic capsule `sfn/semantics` or `sfn/sema`

Rejected. `sema` is concise but project-insider jargon; `semantics` describes a
subject rather than the service. `analyzer` is clear at import sites and aligns
with `sfn check` and future language-service consumers.

### Put compiler capsules under top-level `capsules/sfn/`

Rejected. That directory is the standard-library inventory. Co-locating private
compiler implementation would make repository layout contradict manifest
policy and blur what ships for user import.

### Introduce `sfn/compiler-common` or `sfn/compiler-support`

Rejected. Renaming common to support does not create an ownership rule. Generic
facilities belong in standard-library capsules; representation-specific helpers
belong to IR/codegen/analyzer; orchestration helpers belong to the compiler.

### Extract `sfn/driver` in the first decomposition

Rejected. `sfn/compiler` is currently the only consumer of build planning,
cache policy, process execution, and final linking. A driver library without a
second consumer would add another capsule boundary while leaving the same
authority and dependency closure. Extract it later if a real embedding or
daemon use case establishes a smaller reusable contract.

### Publish syntax/analyzer as reusable libraries now

Rejected. Their APIs are not versioned or supported for third-party use. A
private capsule boundary is valuable for the compiler without prematurely
turning an internal refactor seam into a public ecosystem contract.

## 7. Stage1 readiness mapping

This proposal changes toolchain structure rather than language behavior. The
checklist is interpreted as preservation across the decomposed workspace:

- [x] Existing programs parse identically through `sfn/syntax`.
- [x] Existing type/effect/ownership checks and diagnostics remain equivalent
  through `sfn/analyzer`.
- [x] `sfn/codegen` emits valid, deterministic `.sfn-asm` / typed IR.
- [x] `sfn/codegen-llvm` lowers the validated IR to equivalent LLVM IR.
- [x] Boundary, manifest, regression, and end-to-end coverage is green.
- [x] The decomposed compiler self-hosts to a fixed point.
- [x] All moved `.sfn` files pass `sfn fmt --check`.
- [x] `docs/status.md` and relevant architecture references describe the shipped
  capsule graph. No language-spec change is required.

SFN-751 closed the implementation gate on 2026-08-17. `make check` reached a
byte-identical stage2/stage3 fixed point with zero module differences and
passed 316 unit, 56 integration, 336 end-to-end, and 92 capsule test files.
The dedicated ten-iteration, four-worker determinism sweep covered 445 modules
with zero nondeterministic, emit-failed, or missing-result modules. The final
cold/warm build measurements and their cross-host interpretation are recorded
in `docs/perf/decomposition-baseline.md`; raw values are in
`docs/baselines/compile-sfep0020-post-migration-darwin-arm64.csv`.

All readiness items are complete, so this SFEP is **Implemented**. The
unrelated clean-tree Make-contract concurrency race observed during the gate is
tracked separately as SFN-918; both affected tests and the complete stable
rerun passed.

## 8. Test plan

### Manifest policy

- Unit-test omitted/true/false/malformed `[capsule] publish` values.
- E2E-test that `sfn publish` rejects a private capsule before authentication or
  network access.
- Resolver-test that workspace-private members resolve locally and the same
  manifest is rejected when presented as a registry/cache candidate.

### Dependency architecture

- Add a static import-boundary test for every invariant in §3.3.
- Build/check each internal capsule through its public facade.
- Prove `sfn check` depends on syntax/analyzer/IR but not codegen or LLVM.
- Measure the analyzer-only cost of the whole-source `sfn/ir` dependency and
  adjudicate the 5% cold-check wall-time or peak-RSS budget in §3.3. If the
  budget is exceeded, explain the measured cause and either apply the
  `sfn/module-interface` split when it addresses that cause or record the
  responsive remediation/design follow-up. SFN-747 supplied that adjudication;
  §3.3.1 records why the split was not responsive and why SFN-894 is the
  follow-up.
- Prove `sfn/codegen-llvm` has no parser, analyzer, driver, filesystem, process,
  or network imports.
- Prove no `capsules/sfn/*` source imports an internal compiler capsule.
- Prove the `"runtime/prelude"` slug resolves from every capsule that still
  holds it after §3.5 correction 7, at its post-move depth under
  `compiler/capsules/*/src/`. A capsule that no longer needs the prelude should
  assert it imports nothing from it.

### Behavioral preservation

- Run targeted parser, type/effect/ownership, native-IR, typed-SSA, tensor-IR,
  LLVM lowering, build, resolver, and CLI suites as their owning files move.
- Run `make compile` for every compiler-source slice.
- Run `make clean-build && make compile` after each structural capsule move.
- Run `make check` after the final graph and identity changes.
- Run determinism checks before and after capsule-name/symbol-mangling changes.
- Record cold/warm compile time, cache hits, and peak RSS before the first move
  and after the final move; regressions require explanation or remediation.

## 9. References

- SFEP-0006 — Unified Build Architecture
- SFEP-0014 — Agent-Legible Build/Test Output
- SFEP-0066 — Codegen Provider Ownership (the `sfn/codegen-native` slot, §3.2)
- SFEP-0027 — CLI Modularization
- SFEP-0041 — Unified Expected-Type and Typing-Environment Context
- SFEP-0046 — Native Toolchain Version Pinning and Dispatch
- SFEP-0051 — Workspace Manifest
- SFEP-0053 — Shape-Typed Tensor IR and Fusion
- SFEP-0059 — Typed SSA Activation
- Historical tracking epic #345
