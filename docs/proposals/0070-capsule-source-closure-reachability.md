---
sfep: 70
title: Import-Reachability Filtering of the Capsule Source Closure
status: Accepted
type: tooling
created: 2026-08-11
updated: 2026-08-17
author: "agent:compiler-architect; human review; agent:Codex (2026-08-17 SFN-894 amendment)"
tracking: SFN-804, SFN-830, SFN-831, SFN-832, SFN-833, SFN-834, SFN-894
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0070 — Import-Reachability Filtering of the Capsule Source Closure

## 1. Summary

The capsule resolver compiles every `.sfn` file under a declared dependency's
`src/`, reachable or not. Because `runtime/capsule.toml` declares
`[dependencies] "sfn/crypto" = "*"` (SFN-341/SFN-773), that means **every**
Sailfin binary — including a hello-world that never opens a socket — parses,
type-checks, effect-checks, emits, caches, and lowers all 33 `sfn/crypto`
modules, and carries one `@__sfn_module_type_init__` constructor per module past
`--gc-sections`.

This proposal introduces a **module-level import-reachability filter** on the
resolved capsule source set: a demand-driven closure from the consumer's own
modules (plus, on the build path, the runtime's `sfn-sources`) over the
already-existing pre-parse import scanner, refined so that a symbol imported
through a barrel's `export … from "./sibling"` chain retains only the module
that **defines** it. The filter runs on the build, run, check, and test
resolution paths, may only ever *remove* modules from the set that path would
otherwise stage, and **fails open** — a filter that cannot prove its own closure
property falls back to the unfiltered set rather than breaking a build or
check.

## 2. Motivation

### 2.1 The cost is build time and the constructor floor, not binary size

`--gc-sections` with `-ffunction-sections -fdata-sections`
(`build/link.sfn`, `build/clang_argv.sfn`) already strips unreferenced capsule
code, and `_runtime_retain_root_flags` deliberately force-retains only *runtime*
objects, never capsule objects. So the headline win is **not** stripped-binary
size. It is:

1. **Build time.** Every unreached module is parsed, type-checked,
   effect-checked, emitted to `.sfn-asm` + `.layout-manifest`, cached, parsed
   again, and lowered to `.ll` — twice through the front end, twice through the
   cache, once through `llvm-link`.
2. **The constructor floor.** `llvm/lowering/type_descriptors.sfn` emits one
   `internal @__sfn_module_type_init__<module>` per module with named types,
   wired into `@llvm.global_ctors`. Constructors are GC roots, so the ctor and
   every `linkonce_odr` descriptor and name-string global it registers survive
   dead-stripping. The floor is exactly proportional to *modules linked*.
3. **Isolation-path selection.** `_cr_effective_isolation_exe`
   (`capsule_resolver/mod.sfn`) routes a large-closure build onto
   subprocess-per-module emission based on `resolved.sources.length`. An
   inflated closure can push a small build onto the expensive path.

The SFN-341 design note (`docs/proposals/design-notes/`
`sfn-341-native-tls-runtime-swap.md` §3.1.3) stated this floor when it accepted
the runtime→capsule dependency edge, and §10 named the filter "the highest-
leverage build-time item this analysis turned up."

### 2.2 Capsule granularity buys nothing for the motivating case

`sfn/crypto` *is* imported — by `runtime/sfn/platform/tls.sfn` and by the
compiler's own `cli/commands/toolchain.sfn`, which imports exactly one symbol:

```sfn
import { ed25519_verify_utf8 } from "sfn/crypto";
```

A capsule-granular reachability test keeps all 33 modules for that one symbol.
The win requires **submodule** precision, and — because `crypto/src/mod.sfn` is
a 590-line barrel of `export { … } from "./sibling"` — submodule precision
requires resolving a demanded *name* to its *defining module* across re-export
edges. There is no useful intermediate.

### 2.3 What the existing machinery does and does not give us

- `collect_relative_import_specs` / `collect_scoped_import_specs`
  (`compiler/src/capsule_import_scan.sfn`) are comment- and string-aware
  pre-parse scanners that already walk **both** `import … from "spec"` and
  `export … from "spec"` (the latter added by #508). They extract only the spec
  string; the `{ name, alias }` list is discarded.
- `_cr_direct_import_slugs_for` (`capsule_resolver/staging.sfn`) already resolves
  those specs to `CapsuleSource` slugs — relative imports by resolved path,
  scoped imports by capsule prefix via `_cr_scope_name_prefix`. Its own comment
  records the scoped case as "intentionally coarse for PR1e — refining to
  per-submodule precision lands separately once the resolver retains
  submodule-resolution edges." This proposal is that refinement.
- `_runtime_reexport_closure` (`build/runtime_objs.sfn`, SFN-800) walks
  re-export edges, but over **`.sfn-asm` artifacts after staging**, for
  `.import-deps` sidecars. Different medium, different phase, different output.
  It is not reusable here and is left untouched (§6).
- Discovery runs with **zero parse data**. `ImportDeclaration.import_specifiers`
  (`syntax/src/ast.sfn`) exists only after `parse_program`, which first runs
  inside staging — after the source set is already fixed. Any reachability
  computed at resolution time must come from the text scanner.

## 3. Design

### 3.1 The relation

Define a single module-edge relation over resolved sources.

A **module** is a resolved `CapsuleSource` — `(spec, source_path, slug)` — after
`_cr_resolve_and_dedupe` has deduplicated on `(slug, source_path)`.

`edges(m, U)` returns the modules in universe `U` that `m` names directly:

- **Relative** specs (`./x`, `../x`) resolve by `resolve_relative_import` from
  `m`'s directory, with the existing `./dir` → `dir/mod.sfn` fallback, matched
  against `U` by `source_path`.
- **Scoped** specs resolve by capsule prefix (`_cr_scope_name_prefix`) plus a
  path tail: `sfn/crypto/aead` names the single module whose slug is
  `sfn/crypto/aead`; bare `sfn/crypto` names the capsule's entry module
  `sfn/crypto/mod` (the `/mod` fallback already implemented for `.import-deps`
  in `runtime_objs.sfn`), **not** every submodule.
- A spec that resolves to nothing in `U` contributes nothing. The resolver can
  only ever return members of `U`, so it cannot manufacture a slug.

This relation is extracted into one function and used by **both** the filter and
`_cr_direct_import_slugs_for`, so "the filter and the cache-key/manifest
derivation agree on what an edge is" is structural rather than incidental
(§3.5).

### 3.2 Roots

The filter computes the least fixed point of `edges` from a root set. Roots are:

- Every source the consumer's own walks produced — the relative-import walk, the
  `walk_project_src` binary walk, and the `include_host_as_dep` host-capsule
  walk. These are identifiable in the deduped set: they carry `spec == ""` or a
  local/workspace origin rather than a dependency spec.
- The entry path, when `walk_project_src` excludes it from `sources`
  (the `slug_universe_extra` entry that `_cr_prepare` already builds).
- **When `consumer.runtime_root` is non-empty: every runtime `sfn-source` and
  the `prelude-entry`.** `RuntimeCapsuleArtifacts.sfn_sources` is already
  available via `runtime_capsule_from_root`. These are roots even though they
  are not themselves in `resolved.sources` — they are compiled separately by
  `_compile_runtime_sfn_sources` — because their imports are exactly why the
  runtime's dependency closure was unioned in at all. Use the **un**-target-
  conditioned list: over-approximating roots retains more, which is the safe
  direction.

Missing a root class is the epic's dominant failure mode; §3.6 is the mitigation.

### 3.3 Name-labelled re-export edges

The scanner grows a second entry point that returns, per `import`/`export … from`
statement, both the spec and the brace-list identifiers, preserving `as` aliases
by their *source* name. It reuses the existing character walk verbatim — the
same `in_string` / `in_line_comment` / `in_block_comment` state machine and the
same `_cr_word_matches` boundary test — and only additionally records the span
between the opening and closing brace, splitting on commas outside those states.
The existing name-blind entry points stay, unchanged, so no current caller
moves. There is no `export *` form in the language today (verified across
`compiler/`, `runtime/`, and `capsules/`), so a brace list is always explicit.

The closure carries a **demand set** per module: the set of names an importer
asked that module for, or the sentinel **`ALL`**.

- A module enqueued with demand `ALL` is retained whole and all of its own
  `import`/`export … from` edges are followed with demand `ALL`.
- A module enqueued with a concrete name set `N` publishes an **export table**
  from its own `export { … } from "./sibling"` statements. For each `n ∈ N`
  found in that table, the defining sibling is enqueued with demand `{n}` (a
  chain of barrels therefore narrows at each hop). Names in `N` **not** found in
  any re-export statement are assumed to be defined by the module itself.
- A module carrying a name set still follows its **own** `import … from` edges
  with demand `ALL`: it is being compiled, so anything it imports is fair game.
  Only `export … from` edges are name-filtered.
- Any construct the scanner cannot resolve confidently — a bare side-effect
  `import "spec";`, a spec reached from a module whose demand could not be
  computed, a brace list the scanner truncated on its step guard — degrades that
  edge to `ALL`. **Uncertainty always widens the set.**
- A module reached by two paths takes the union of its demands; `ALL` absorbs.

Worked example (post-§3.7):

```
runtime/sfn/platform/tls.sfn
  import { aead_aes_128_gcm, ... , X509ChainResult } from "sfn/crypto"
      -> sfn/crypto/mod, demand = { aead_aes_128_gcm, ..., X509ChainResult }
sfn/crypto/mod.sfn export table
      aead_aes_128_gcm      -> ./aead
      pem_certificates_to_der -> ./pem
      ...
  -> enqueue sfn/crypto/{aead,pem,rand,tls13_handshake,...}, each demand {name}
  -> the ~20 barrel edges no name demanded are never enqueued
each retained submodule's own `import … from "./bits"` etc. -> demand ALL
```

and, for the compiler's own self-host:

```
cli/commands/toolchain.sfn: import { ed25519_verify_utf8 } from "sfn/crypto"
  -> sfn/crypto/mod, demand { ed25519_verify_utf8 } -> ./ed25519 -> its own imports
```

### 3.4 Where it runs

**A post-dedupe pass inside `_cr_prepare` (`capsule_resolver/mod.sfn`), on
`resolved.sources`, before `_cr_effective_isolation_exe` and
`stage_capsule_imports`.** Not inside `_cr_collect_capsule_sources` and not
inside `enumerate_capsule_sources`, because:

- **The roots are not visible there.** The consumer's own modules come from
  `enumerate_relative_sources` / the binary-capsule walk, and are joined with
  the dependency sources only in `_cr_resolve_and_dedupe`. A filter inside
  discovery would have to re-derive the roots it cannot see.
- **The SFN-341 union stays intact.** The `runtime_root` union at
  `discovery.sfn` decides *which capsules are candidates*; the filter decides
  *which of their modules are reached*. Keeping the two layers separate
  preserves §3.1.3's accepted decision verbatim, including its `visited`
  spec-keyed dedup and the transitive manifest walk.
- **Dedupe first means canonical identities.** Filtering a set that still
  contains `(slug, source_path)` duplicates would give the graph duplicate
  nodes.
- **One shared wrapper serves every filtered consumer.** `build`, `run`, and
  `test`'s link path funnel through `_cr_prepare`; the check-only facade calls
  the same resolve/dedupe/filter wrapper before staging analysis interfaces.
  The #1370 `emit llvm` path retains its dedicated unfiltered staging facade:
  it emits an explicitly requested module and does not enter a link closure.
- **It precedes the isolation decision,** so a shrunken closure also gets the
  cheaper `_cr_effective_isolation_exe` route.

The cost paid is that the filesystem BFS in `_cr_collect_capsule_sources` still
walks every dependency's `src/`. That is `fs.listDirectory` only — negligible
against the compile it avoids — and keeping it makes the filter a pure set
subtraction over an otherwise-unchanged pipeline, which is what makes fail-open
(§3.6) possible.

### 3.5 The correctness invariant

> **Closure invariant.** For the retained set `K`, `edges(m, K) ⊆ K` for every
> `m ∈ K`.

Why it matters: `_cr_dep_manifest_paths_for_slugs` and `_cr_manifests_to_asm_paths`
(`capsule_resolver/staging.sfn`) build `<root>/<slug>.layout-manifest` and
`<root>/<slug>.sfn-asm` **by string concatenation with no existence check**. A
retained module whose dep slug is not staged therefore yields a path to a file
that never existed; the emit subprocess reads no interface for it and **silently
loses cross-module effect data**, under-enforcing `E0402`. That is the silent
failure the invariant exists to prevent. (A wrongly-dropped *definition*, by
contrast, is loud: an undefined symbol at link.)

Three layers of enforcement:

1. **Structural.** One shared edge resolver (§3.1) used by the filter and by
   `_cr_direct_import_slugs_for`. Because both resolve *against* the list they
   are handed, a resolver run against `K` can only return members of `K`.
2. **Single-list discipline.** The filter applies to `resolved.sources`, and
   every downstream list — the staging input, `slug_universe_extra`, the
   `compile_capsule_modules` input, the `.import-deps` universe — derives from
   the filtered list. Re-introducing an unfiltered list anywhere is the way this
   breaks.
3. **Verification pass, fail-open.** After computing `K`, re-run the edge
   resolver over `K` and check every resolved edge lands in `K`. On violation,
   print a diagnostic naming the module and the missing slug and **return the
   unfiltered set**. The build proceeds exactly as it does today. This is a
   performance optimisation; a bug in it must never be able to break or
   mis-compile a build.

Operator controls, matching the `SAILFIN_TRACE_MEM_LIMIT` precedent:

- `SAILFIN_CAPSULE_FILTER=off` — disable the filter entirely (bisect handle and
  field escape hatch).
- `SAILFIN_TRACE_CAPSULE_FILTER=1` — print retained/dropped counts and the
  dropped slug list to stderr.

### 3.6 Per-command closure completeness

SFN-894 supersedes this section's original build-subset-of-check invariant.
The filter runs on `sfn check` as well as build/link paths.
`prepare_project_capsules_for_check` still leaves `runtime_root` empty because
check never links the runtime; its explicit checked files are the entry roots,
and their transitive imports determine the dependency modules staged as
analysis interfaces.

The normative invariant is:

> **For each resolver path, the retained set is closed over the imports
> reachable from that path's semantic roots. The filter never adds a module and
> fails open to that path's unfiltered set if closure cannot be proved.**

Build and check retained sets therefore need not contain one another. Build
roots include the project entry and selected runtime sources; check roots are
the files requested in its resolution group. A runtime-only module is relevant
to linking but not to frontend checking. Conversely, a file explicitly passed
to check may not be part of the project's binary entry closure. Set inclusion
between those commands conflates different questions and forced check to stage
every source of every declared dependency, which SFN-747 measured at +341.5%
peak RSS against the monolith.

This does not permit check to go green while omitting an import its requested
files can exercise: entry-root seeding, fixed-point traversal, and the
verification pass in §3.5 retain that complete closure or decline the
optimisation. A dependency module outside that closure is unreachable from the
checked files and remains the owning capsule's responsibility to check in its
own CI. An existing checked entry that names no dependency is an authoritative
empty closure; it does not fail open merely because traversal has no first
module to enqueue.

### 3.7 Interaction with the `tls.sfn` deep-import workaround

`runtime/sfn/platform/tls.sfn` imports twelve deep `sfn/crypto/<module>` paths
instead of the `sfn/crypto` facade. Its header records this as a workaround with
an explicit removal condition — SFN-800's re-export closure reaching the pinned
seed. `bootstrap.toml [seed].version = "0.9.5"` and SFN-800's commit is an
ancestor of the 0.9.5 release, so **the condition is satisfied.**

The collapse is **in scope for this proposal and sequenced before the
name-labelling work**, because:

- It moves the runtime from *explicit submodule edges* to *one barrel edge* —
  precisely the case §3.3 exists to handle. Leaving the deep imports in place
  would let the name-labelling work pass its acceptance through an easy path it
  will not have in production. Collapsing first makes the barrel path the only
  path.
- It is **perf-neutral today**: with no filter, a deep import and a barrel import
  cost identically (the whole capsule either way). So it can land early at low
  risk, and only *becomes* the hard case once the filter exists.
- Per `.claude/rules/code-style.md`, the change deletes both the workaround and
  its comment block.
- Per `.claude/rules/seed-dependency.md`, the runtime-source carve-out applies to
  `tls.sfn` — the pinned seed compiles it — but the capability it needs is
  already **in** that seed, so it is not a `seed-blocker` and has no predecessor.

## 4. Effect & capability impact

No new effects and no change to the effect taxonomy. One indirect interaction,
handled in §3.5: cross-module effect enforcement (`E0402`) on the build path is
carried by the `.layout-manifest`/`.sfn-asm` paths derived from resolved dep
slugs, so an incoherent filtered set would under-enforce callee-effect
transitivity rather than fail loudly. The closure invariant and the fail-open
verification pass are the guard, and the test plan (§8) asserts an effect-gate
diagnostic still fires through a filtered barrel import.

Capability manifests are unaffected: a capsule's declared capabilities are read
from its `capsule.toml`, not from which of its modules were compiled.

## 5. Self-hosting impact

No lexer, parser, AST, typecheck, or lowering change. The work is confined to
the build driver's resolver (`compiler/src/capsule_resolver/`), the pre-parse
scanner (`compiler/src/capsule_import_scan.sfn`), and one runtime source file
(§3.7). `_runtime_reexport_closure` and the link path are untouched.

Two self-hosting consequences to state plainly:

1. **Benefit-realisation lag.** `make compile` self-hosts *from the pinned seed*,
   so the seed's resolver performs the capsule walk for the compiler's own
   build. The compiler's self-host time therefore improves only after a seed
   carrying the filter is pinned — not in the PR that lands it. The measurable
   win in-PR is on `sfn build` of a user program using the freshly built
   compiler.
2. **No seed-blocker in this epic.** The filter is compiler source consumed by
   compiler behaviour, so it bundles with its consumers under
   `.claude/rules/seed-dependency.md`. The `tls.sfn` collapse is runtime source
   that merely *changes*; the compiler capability it depends on is already in the
   pinned seed, which the rule's carve-out explicitly excludes from the
   `seed-blocker` path.

## 6. Alternatives considered

**Capsule-granular reachability only.** Drop a dependency capsule entirely when
no module imports it. Rejected as a *stage*: the motivating case
(`sfn/crypto` reached from the runtime and from `toolchain.sfn`) keeps all 33
modules under it, so it delivers ~0 of the target win. It is not rejected as a
*behaviour* — it falls out of §3.1 for free, since a capsule with no reached
module contributes nothing.

**Reuse `_runtime_reexport_closure`.** It walks `.sfn-asm` artifacts *after*
staging, to build `.import-deps` sidecars for the runtime object cache. The
filter must run *before* staging, over source text, on all consumers. Sharing
would force one of them to change input medium and phase. Rejected: reuse the
*shape* (BFS with membership checked at the push site, a guard that prints
rather than truncating in silence) and leave the code alone. The two must remain
consistent, and are: a dropped module is never staged, so it can never appear in
a sidecar, and nothing that could go stale on it survives.

**Parse the dependency sources to get real `import_specifiers`.** Rejected on
ordering and on the validation ladder: `parse_program` first runs inside
staging, after the source set is fixed; hoisting it means parsing every
dependency source twice, which is the cost this proposal exists to remove.

**Narrow the `@__sfn_module_type_init__` emission rule instead.** Attractive
because it targets the ctor floor directly at lower blast radius — and rejected.
Registration exists so `sfn_resolve_type` can find a type by name hash at
runtime; which types get queried is **whole-program** knowledge that per-module
emission does not have, so there is no per-module predicate to narrow on. The
only real narrowing is replacing constructors with a linker-section registry the
runtime iterates, which is a runtime/ABI change with three per-format spellings
(ELF, Mach-O `section$start`, COFF `$b` grouping) and deserves its own SFEP. The
filter removes the same ctors at the source — 26 fewer crypto modules linked is
26 fewer ctors — with no codegen change. The baseline artifact (§8) tracks ctor
count so the question stays revisitable on evidence.

**Install-time seeding of the shared module cache** (design note §10). Out of
scope. It is a different mechanism (populate `cache_root` at
`sfn toolchain install`) against a different metric (first-cold-build latency on
a fresh host), and it carries a provenance question — shipping prebuilt `.ll`
implies attesting them — that belongs to the distribution design, not the
resolver. §10 itself scopes it as conditional on measurement; the baseline this
proposal establishes is that measurement.

**Runtime capability slices** (design note §10, third follow-on). Out of scope
and correctly so: changing what the runtime guarantees a program is a positioning
decision, not a size optimisation.

## 7. Stage1 readiness mapping

- [ ] Parses — n/a, no syntax change
- [ ] Type-checks / effect-checks — n/a, no analyzer change
- [ ] Emits valid `.sfn-asm` — unchanged for retained modules; asserted byte-
      identical for a build whose reachable set is the full set
- [ ] Lowers to LLVM IR — unchanged
- [ ] Regression coverage — §8
- [ ] Self-hosts — `make compile` + `make check`; self-host artifact set must be
      unchanged or strictly smaller with no link regression
- [ ] `sfn fmt --check` clean
- [ ] Documented in `docs/status.md` (build behaviour + the two env toggles) and
      `docs/perf/bench-history.md` (the new metric series)

## 8. Test plan

**Baseline artifact (prerequisite).** A repeatable consumer-build benchmark mode
producing, per fixture (hello-world; hello + one library capsule; a TLS client):
cold wall time, warm wall time, stripped binary bytes, `@llvm.global_ctors`
entry count, modules staged, modules compiled, cache hit/miss. Committed as a
baseline CSV under `docs/perf/`, in the shape
`scripts/perf_history.sh append` consumes.

**New coverage — the gap this epic must fill.** No test today asserts that an
unreached submodule is excluded.

- `compiler/tests/e2e/` — a fixture capsule with a barrel re-exporting two
  submodules, a consumer importing one symbol; assert the unimported submodule's
  `.ll` is not produced and its `@__sfn_module_type_init__` symbol is absent from
  the linked binary.
- Empty-reachable-set case: a declared-but-never-imported dependency contributes
  zero modules and the build still links.
- Runtime-root roots: a hello-world with `runtime_root` set retains exactly the
  crypto modules `tls.sfn` reaches, and links. This is the SFN-341 regression
  surface — a missed root class fails here.
- Closure-invariant / fail-open: a forced invariant violation prints its
  diagnostic and falls back to the unfiltered set, and the build succeeds.
- `SAILFIN_CAPSULE_FILTER=off` reproduces today's artifact set exactly.
- Effect enforcement through a filtered barrel import still raises `E0402`.

**No regression in** `compiler/tests/e2e/runtime_capsule_dependency_test.sfn`
(SFN-773 + the SFN-800 re-export leg), `compiler/tests/e2e/capsule_transitive_dep_link_test.sfn`
(SFN-35), and `capsules/sfn/crypto/tests/`.

**`sfn check` reachability.** A checked file in a multi-capsule project imports
one dependency through its barrel while declaring another dependency it never
imports. Assert that the reached barrel/module stages, the orphaned sibling and
never-imported capsule do not, and the check succeeds. The subprocess and
in-process staging paths must still produce byte-identical artifacts for the
same filtered set.

## 9. References

- SFN-804 — the originating issue.
- `docs/proposals/design-notes/sfn-341-native-tls-runtime-swap.md` §3.1.3 (link
  scoping, the ctor floor, the `check` gating) and §10 (this follow-on, plus the
  two deliberately-excluded ones).
- SFEP-0006 (`0006-build-architecture.md`) — the clean-build budget this work
  pays into. This proposal is filed separately because it introduces a new
  invariant and new operator toggles, not merely another optimisation under
  0006's plan.
- SFEP-0026 (`0026-delivery-process.md`) WS-B and `.claude/rules/seed-dependency.md`
  — the bundle-vs-split call and the runtime-source carve-out.
- SFEP-0037 §3.3 — the perf-history time series this work extends.
- SFN-800 (`_runtime_reexport_closure`), SFN-773/SFN-341 (the runtime→capsule
  dependency edge), SFN-35 (transitive dep link), #508 (`export … from` in the
  scanner), #1405 (isolation-path selection), #1389 (`check`/build divergence).
