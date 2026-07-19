---
sfep: TBD
title: Workspace Manifest — Multi-Capsule Policy and the Capability Envelope
status: Draft
type: tooling
created: 2026-07-19
updated: 2026-07-19
author: "agent:compiler-architect"
tracking: "SFN-413 (Phase 1 member-declaration slice — multi-line arrays + glob), SFN-412 (workspace.toml reflow after seed pin), SFN-TBD (Phase 2 root [toolchain] default consumer), SFN-TBD (Phase 3 [workspace.dependencies] inheritance), SFN-TBD (Phase 4 capability envelope + drift audit)"
supersedes:
superseded-by:
graduates-to:
---

# SFEP-XXXX — Workspace Manifest — Multi-Capsule Policy and the Capability Envelope

## 1. Summary

Sailfin already has a `workspace.toml` at the repo root and a resolver that
reads `[workspace].members` (SFEP-0006 §4.2). This SFEP is not about the
resolver plumbing — SFEP-0006 owns that. It is about **what the workspace
manifest should express** as it matures into a production-grade multi-capsule
manifest, and the phased roadmap to get there. Two things happen at once:

1. We bring `workspace.toml` up to parity with Cargo/Go/Zig workspaces —
   ergonomic member declaration (multi-line arrays + implicit-member globs), a
   workspace-wide toolchain default, and shared dependency/metadata inheritance.
2. We add the thing no peer workspace manifest has: a **workspace-tier
   capability policy** — an effect envelope that bounds the union of effects the
   member capsules may require, with drift auditing across the whole graph. This
   is the capability-based-security pillar (CLAUDE.md pillar 2) applied one tier
   above the capsule, and it is the durable, defensible core of this proposal.

Phase 1 (member declaration) ships as the first implemented slice in the same PR
as this Draft. Phases 2–4 are staged so each is independently valid and
self-hosts through the pinned seed.

## 2. Motivation

The Sailfin repo is already a workspace: one `workspace.toml` binds the compiler,
the runtime, and ~20 `capsules/sfn/*` stdlib capsules so intra-workspace import
edges resolve from local source instead of the cache/registry. That file today
carries exactly one key — `[workspace].members` — and even that is written as a
single physical line of 22 quoted paths because the *pinned seed's* TOML parser
historically could not read a multi-line array (see the header comment in
`workspace.toml`, and §5 below on the seed gate). Every peer toolchain does
better than this:

| Capability | Cargo | Go | Zig | Sailfin today |
|---|---|---|---|---|
| Multi-line / glob members | ✅ (`members = ["crates/*"]`) | ✅ (`use ./...`) | ✅ | ❌ single line, explicit |
| Workspace toolchain pin | ✅ (`rust-version`, `rust-toolchain.toml`) | ✅ (`go` directive) | ✅ | ⚠️ read but unused at root |
| Shared dep/version inheritance | ✅ (`[workspace.dependencies]`) | ✅ (`go.work`) | ⚠️ | ❌ |
| Workspace metadata inheritance | ✅ (`[workspace.package]`) | — | — | ❌ |
| **Capability/effect envelope** | ❌ | ❌ | ❌ | ❌ (the opening) |

The first four rows are table-stakes ergonomics we are simply behind on. The
fifth row is the opening: **no mainstream workspace manifest can express "no
member of this project may touch the network except `sfn/net`," and none can
audit the effect surface of an entire multi-capsule graph.** Sailfin can, because
effects are first-class in the type system (`effect_checker.sfn` already forces
every function to declare the effects it uses, and `capsule.toml [capabilities]
required` already aggregates them per capsule). What is missing is the tier
*above* the capsule — a policy the workspace root owns that bounds the union.

Concrete failure the envelope prevents: today, `sfn add`-ing a transitive
dependency (or a stdlib capsule quietly gaining a `![net]` helper) silently
expands the effect surface of the whole build. A reviewer has no single place to
assert "this project is offline-only." The per-function and per-capsule tiers
catch *undeclared* effects; nothing catches *declared-but-unwanted-at-the-project-
scope* effects. That is a least-privilege / supply-chain gap that maps directly
onto the pillar we market.

SFEP-0002 (package management) sketched an aspirational `[[capsule]] allow =
[...]` shape and an `sfn capabilities audit` command as vision. This SFEP makes
that vision concrete, enforced, and grounded in the resolver and effect machinery
that actually exists.

## 3. Design

### Scope boundary (what this SFEP does *not* restate)

- **SFEP-0006 §4.2** owns the resolver machinery: `load_workspace_members`,
  `_cr_expand_member_globs`, `parse_workspace_member_paths`,
  `discover_workspace_root`, the resolution order (workspace → `workspace.lock`
  → `capsule.lock` → cache → registry), and lockfile ownership. This SFEP cites
  that machinery and extends the *schema it reads*; it does not redesign the walk.
- **SFEP-0002** owns the package-manager vision (models, provenance, registry,
  signing). This SFEP concretizes only the capability-policy slice of that vision
  and defers models/provenance to 0002.
- **SFEP-0017** owns hierarchical sub-effects as subsumption; §Phase 4 below
  reuses that subsumption relation, it does not redefine it.

### Phase 1 — Ergonomic member declaration (first slice, this PR)

**What ships:** the manifest reader accepts a multi-line `members` array, and the
resolver expands a trailing `/*` glob into Cargo-style implicit members.

```toml
[workspace]
members = [
    "compiler",
    "runtime",
    "capsules/sfn/*",   # every immediate subdir carrying a capsule.toml
]
```

Semantics (already implemented in the resolver, see §6):

- `toml_parser.sfn` parses a multi-line TOML array for `[workspace].members`
  (previously single-physical-line only).
- `capsule_resolver.sfn::_cr_expand_member_globs` expands a **trailing `/*`
  only** — every immediate subdirectory of the prefix that carries a
  `capsule.toml` becomes a member, in deterministic sorted order (`_cr_sort_strings`).
  A `*` anywhere but a trailing `/*` is left verbatim and rejected downstream by
  the literal-path safety check (`_cr_is_safe_member_path`).
- Glob prefixes are subject to the same safety rules as literal members
  (relative, no `..`, no backslashes).

**The seed-gated two-step (critical).** The *capability* (parser + glob
expansion) lands first and is verified by unit tests. The repo's own
`workspace.toml` **cannot** flip to the multi-line/glob form until a seed
carrying the new parser is pinned in `bootstrap.toml`, because `make compile`
self-hosts through the *pinned seed*, which reads `workspace.toml` with its own
baked-in TOML parser (a pre-capability seed would choke on the multi-line array).
This is exactly the pattern documented in the `workspace.toml` header comment.
The format flip of `workspace.toml` itself is therefore a **follow-up issue**
(`tracking:` "workspace.toml reflow after seed pin"), queued against the next
cadence seed bump per `.claude/rules/seed-dependency.md` — the capability and its
sole in-repo consumer (the workspace file) are split *only* because the consumer
literally cannot self-host until the capability is in the pinned seed. This is
the legitimate split case the seed-dependency rule carves out, not a manufactured
one.

### Phase 2 — Workspace-wide toolchain default

The resolver *already reads* a root `[toolchain]` pin as the default floor for
all members: `capsule_resolver.sfn::toolchain_decide` reads
`toml_get_toolchain_sfn` / `toml_get_toolchain_channel` from `workspace.toml`
first, then lets a member `capsule.toml` override *per field*. The floor/override
model is live (SFN-172, SFEP-0046). **The root `[toolchain]` block is simply
absent from the repo's `workspace.toml` today** — the capability exists with no
producer.

Phase 2 is therefore a documentation-and-adoption phase, not new machinery:

```toml
[toolchain]
sfn = "0.7.0-alpha.31"   # floor: running compiler must be >= this
channel = "alpha"        # channel rank floor
```

- The workspace pin is the **default floor** for every member.
- A member `capsule.toml [toolchain]` overrides the workspace value **per
  field** (a member may raise `sfn` without touching `channel`), exactly as
  `toolchain_decide` already implements.
- No new getters or resolver code — Phase 2 is: (a) document the block in the
  spec, (b) decide whether the sailfin workspace itself adopts a pin (a policy
  call — pinning the workspace floor to the bootstrap seed makes the self-host
  toolchain contract explicit, but couples the floor to the seed cadence).

### Phase 3 — Shared dependency and metadata inheritance

The Cargo parallel: members dedupe versions and shared metadata by inheriting
from the workspace root instead of restating them.

```toml
[workspace.package]
# Inheritable defaults for every member's [capsule] block.
version = "0.5.9"
license = "Apache-2.0"

[workspace.dependencies]
# Canonical version each member resolves against when it opts in.
"sfn/strings" = "0.3.0"
"sfn/test"    = "0.4.0"
```

A member opts in with a `workspace = true` marker (Cargo's exact spelling), so
inheritance is explicit, never implicit:

```toml
# capsules/sfn/http/capsule.toml
[capsule]
name = "sfn/http"
version = { workspace = true }        # inherit 0.5.9

[dependencies]
"sfn/strings" = { workspace = true }  # inherit 0.3.0
```

Design constraints:

- Inheritance is **resolved at load time** into a fully-expanded member manifest
  — the resolver never carries an un-inherited manifest past resolution, so the
  build plan and cache keys see concrete versions (cache correctness, SFEP-0006
  §4.12).
- `[workspace.dependencies]` sets the *canonical version*, not a pin — the
  lockfile (owned by the root per SFEP-0006) still records the resolved pin.
  Inheritance and locking compose: inheritance says "which range," the lock says
  "which exact version."
- Requires new getters (`toml_get_workspace_package_*`,
  `toml_get_workspace_dependencies`) and a `{ workspace = true }` inline-table
  form in `toml_parser.sfn`. The inline-table parse is the largest single piece
  of new TOML surface in this SFEP and is the reason Phase 3 is its own slice.

### Phase 4 — The capability envelope (the novel core)

A workspace declares an **effect envelope**: the maximum set of effects any
member may require. The resolver audits the union of member effect surfaces
against the envelope and fails the build (or `sfn check`) on drift. This is
least-privilege enforced at the project tier — the tier no peer manifest has.

```toml
[workspace.capabilities]
# The envelope: the ceiling on effects any member may require. Alphabetical,
# canonical effects only (io, net, model, gpu, rand, clock — the
# effect_taxonomy.sfn::canonical_effects() set).
allow = ["clock", "io"]

# Hard deny: forbidden workspace-wide even if allow or a grant lists it.
# Deny wins over everything.
deny = ["model"]

# Per-member least-privilege carve-outs above the base envelope. Only these
# members may exceed `allow`, and only by the listed effects.
[workspace.capabilities.grants]
"sfn/net"  = ["net"]
"sfn/http" = ["net"]
```

**Effective-allowed set.** For a member `M`:

```
effective(M) = (allow ∪ grants[M]) \ deny
```

**Drift.** `M` is in *capability drift* iff its required effect set contains any
effect not in `effective(M)`. The required set of `M` is computed in two
escalating strengths:

- **Phase 4a — declared surface.** `M`'s `capsule.toml [capabilities] required`
  (already parsed by `toml_get_capabilities_required`, `toml_parser.sfn:548`).
  Cheap, no compile needed; runs at resolve time.
- **Phase 4b — inferred surface.** The union of `![...]` effects across `M`'s
  public functions, as computed by `effect_checker.sfn`. This catches a member
  whose declared `[capabilities]` under-reports what its code actually uses.
  Because `effect_checker` already runs per module during `sfn check`/`sfn
  build`, 4b is a reduce over data the pipeline already produces — it just needs
  to be surfaced up to the workspace-scope audit.

**Three-tier subsumption.** This slots cleanly above the two effect tiers that
already exist, each a ceiling for the tier below:

```
function   ![io, net]                 ← effect_checker forces per-call declaration
   ⊆
capsule    [capabilities] required    ← per-capsule aggregate (documented)
   ⊆
workspace  [workspace.capabilities]   ← project-tier ceiling + per-member grants  (NEW)
```

The relation is the same subsumption `effect_checker` already uses, and it
composes with **SFEP-0017 hierarchical effects**: a workspace that allows `io`
thereby allows any sub-effect `io.*` a member requires; a `deny = ["net"]` denies
every `net.*` leaf. Phase 4 consumes SFEP-0017's subsumption predicate rather
than re-implementing membership as string equality.

**The audit pass.** A new resolver function

```
workspace_capability_audit(workspace_root) -> CapabilityDriftReport  ![io]
```

in `capsule_resolver.sfn`:

1. `load_workspace_members(workspace_root)` (exists).
2. Read the envelope via new getters (`toml_get_workspace_capabilities_allow`,
   `..._deny`, `..._grants`).
3. For each member, read its required set (4a: declared; 4b: inferred), compute
   `effective(M)`, and diff.
4. Emit a `Diagnostic` per drifting effect with the member path, the offending
   effect, and a fix-it hint ("`sfn/http` requires `net`, which exceeds the
   workspace envelope `[clock, io]`; add `\"sfn/http\" = [\"net\"]` to
   `[workspace.capabilities.grants]` or remove the effect").

**Enforcement, honestly.** Per CLAUDE.md pillar 4 ("don't ship unfinished safety
claims"), Phase 4 is **not** marketed or documented as a capability guarantee
until the drift gate *fails the build end-to-end*. It ships in `enforce` mode
(drift is an error) by default. A `mode = "warn"` knob exists only as a
migration aid for adopting workspaces:

```toml
[workspace.capabilities]
mode = "warn"   # transitional: report drift without failing. Default is enforce.
```

A parsed-but-unenforced envelope stays in the `Accepted` SFEP state (not
`Implemented`) and is absent from marketing until the enforce path is green.

**`sfn capabilities audit`.** The same pass backs a reporting command
(concretizing SFEP-0002's promise): `sfn capabilities audit` runs
`workspace_capability_audit` and prints the per-member required-vs-effective
table plus any drift, exit non-zero on drift. `sfn check` and `sfn build` at
workspace scope run it as a gate; the standalone command is for CI dashboards.

**A new diagnostic-code band** is required for capability-policy errors. The
exact `E0xxx` code is allocated at implementation against the owned-range table
in `docs/style-guide.md` (the effect/capability band around `E08xx`, avoiding the
ownership `E0901`/`E0907` collisions) — this SFEP reserves the *need*, not the
number.

### Phase 5 — Cargo-parallel members polish (lower priority)

Briefly, once Phases 1–4 land, three Cargo-parity conveniences round out the
manifest. Each is a small, independent slice:

- **`default-members`** — the subset built by a bare `sfn build`/`sfn test` at
  the root when no `-p` is given (Cargo `workspace.default-members`). Today a
  root build has no default target set.
- **`exclude`** — paths under a glob prefix to *omit* from expansion (Cargo
  `workspace.exclude`), so `capsules/sfn/*` can skip a scratch/vendored dir
  without listing every member explicitly.
- **`[profile.*]`** — shared build profiles (opt level, debug info) inherited by
  members, the concrete form of SFEP-0002's aspirational `[profiles.*]` and
  `[build]` blocks. Deferred until the driver has a real profile surface to
  consume.

## 4. Effect & capability impact

This is the SFEP's center of gravity. Phases 1–3 have **no** effect-system
interaction — they are manifest ergonomics. Phase 4 is a direct extension of the
capability pillar:

- **New tier, same mechanism.** The envelope reuses effect subsumption
  (`effect_checker.sfn`, SFEP-0017) and the canonical effect set
  (`effect_taxonomy.sfn::canonical_effects()` — `io, net, model, gpu, rand,
  clock`). Envelope/grant/deny effect lists are validated against that set and
  written **alphabetically** (per `.claude/rules/code-style.md`); a non-canonical
  effect name in the manifest is itself a diagnostic.
- **No new effects, no new keywords.** The envelope is data read by the resolver,
  not language syntax — it adds zero keywords and cannot become a `.sfn`
  construct that shadows a variable. This satisfies "libraries/data over
  keywords."
- **Enforcement is real or absent.** The audit either fails the build on drift
  (`enforce`) or is explicitly a migration-only `warn` — there is no
  parsed-but-silently-ignored middle state that could teach users to ignore the
  policy.
- **Interaction with `[capabilities] required`.** The per-capsule block stays the
  member-tier declaration; the workspace envelope bounds the union of those
  blocks (4a) and, at 4b, the inferred `![...]` surface. The two are consistent
  by construction: a member cannot satisfy the workspace envelope while violating
  its own `[capabilities]`, because `effect_checker` already gates the latter.

## 5. Self-hosting impact

The manifest reader is `compiler/src/toml_parser.sfn` (getters) plus
`compiler/src/capsule_resolver.sfn` (member expansion, toolchain decision,
capability audit). **Every schema change here is seed-gated**, and this is the
dominant design force for the whole SFEP:

- `make compile` self-hosts via `<pinned-seed> build -p compiler`. The **pinned
  seed** reads the repo's `workspace.toml` with *its own* baked-in TOML parser
  and resolver. Any new field the repo's `workspace.toml` actually *uses* must
  already be understood by the pinned seed, or the two-pass seedcheck diverges
  (or the seed errors) — see `.claude/rules/selfhost-invariant.md` and the
  `workspace.toml` header comment.
- Therefore every phase follows the same **capability-first, adoption-second**
  shape:
  1. Land the parser/getter/resolver capability + unit tests (compiler source).
     `make compile` builds it from the *old* seed — the old seed never has to
     read a manifest using the new field, because the repo `workspace.toml`
     hasn't changed yet.
  2. Cut and pin a seed carrying the capability (routine cadence bump).
  3. *Then* flip the repo's `workspace.toml` to use the new field.
- The capability and its sole in-repo consumer (the workspace file) are split
  **only** for this reason — the consumer cannot self-host until the capability
  is in the pinned seed. Per `.claude/rules/seed-dependency.md` this is the
  legitimate carve-out, not a manufactured split; the split is called out
  explicitly and queued against the cadence seed bump rather than triggering a
  reactive cut.

No other pipeline stage changes: there is no new `.sfn` syntax, so lexer, parser
(of `.sfn`), AST, typecheck, native emit, and LLVM lowering are all untouched.
The "compiler pass" that changes is the TOML reader and the resolver — neither of
which participates in `.sfn` codegen.

## 6. Alternatives considered

- **Do nothing; keep `workspace.toml` at `members`-only.** Rejected: we are
  behind peer toolchains on table-stakes ergonomics (single-line member list is
  actively painful at 22 entries), and the capability envelope — the one
  differentiated feature — has no home to live in.
- **Put the capability policy in each `capsule.toml`, not the workspace.**
  Rejected: `capsule.toml [capabilities] required` already exists and is the
  *member* tier. A per-capsule allowlist cannot express a *cross-capsule* ceiling
  ("only `sfn/net` may use `net`") — that is inherently a property of the graph,
  which only the workspace root sees.
- **Enforce the envelope purely from inferred effects (skip 4a declared).**
  Rejected as the starting point: inferred (4b) requires every member to compile
  before the audit can run, which couples the audit to a full build and makes
  `sfn check`-time reporting expensive. Declared (4a) runs at resolve time on
  data already parsed; 4b is a strengthening layered on top once it is cheap to
  surface.
- **Adopt SFEP-0002's `[[capsule]] allow = [...]` array-of-tables shape.**
  Rejected: that shape restates the member list (path, kind, deps) that
  `[workspace].members` + per-member `capsule.toml` already own, duplicating the
  resolver's source of truth. The `[workspace.capabilities]` table layers policy
  *onto* the existing member set instead of forking it. SFEP-0002's shape remains
  the aspirational vision; this is the grounded realization.
- **`mode = "warn"` as the permanent default.** Rejected: a warn-only default is
  precisely the "parsed but not enforced" anti-pattern. `warn` exists solely as a
  migration bridge; `enforce` is the default and the only marketed state.
- **A new keyword / `.sfn` syntax for workspace policy.** Rejected: keywords are
  expensive and a policy ceiling is configuration, not code — TOML is the right
  surface.

## 7. Stage1 readiness mapping

This is a tooling/manifest feature with no new `.sfn` language surface, so the
language-shaped checklist items map to their manifest-reader analogues:

- [ ] **Parses** — N/A for `.sfn` syntax; instead: new fields round-trip through
  `toml_parser.sfn` (unit tests). Phase 1 multi-line + glob: **done**.
- [ ] **Type-checks / effect-checks** — N/A for `.sfn`; Phase 4 adds the
  workspace-tier capability audit that *consumes* `effect_checker` output.
- [ ] **Emits valid `.sfn-asm`** — N/A (no codegen path touched).
- [ ] **Lowers to LLVM IR** — N/A (no codegen path touched).
- [ ] **Regression coverage** — resolver + getter unit tests per phase (§8);
  Phase 1 covered by `workspace_resolver_test.sfn` glob/multi-line cases.
- [ ] **Self-hosts** — each phase's capability builds from the old seed; the
  repo `workspace.toml` adopts the field only after a seed carrying it is pinned
  (§5). Phase 1 capability: self-hosts; format flip: gated.
- [ ] **`sfn fmt --check` clean** — on every touched `.sfn` (resolver, parser,
  tests). SFEP files themselves are Markdown, not `fmt`-gated.
- [ ] **Documented** — `docs/status.md` (manifest/workspace row) + the manifest
  reference chapter under `site/.../reference/`. Phase 4 stays out of any
  "enforced" claim until the drift gate is green end-to-end.

## 8. Test plan

Grounded in the existing `workspace_resolver_test.sfn` /
`relative_import_resolver_test.sfn` / `toml_parser_test.sfn` patterns
(inlined-helper unit tests — the resolver imports `./main`, so importing it
directly in a unit test pulls in the whole compiler and trips the seed's
per-module timeout; mirror `stdlib_capsule_allowlist_test.sfn`).

- **Phase 1 (member declaration).**
  - `toml_parser_test.sfn`: multi-line `[workspace].members` array round-trips to
    the same path list as the single-line form.
  - `workspace_resolver_test.sfn`: `_cr_expand_member_globs` on
    `["capsules/sfn/*"]` yields every subdir with a `capsule.toml`, sorted; a
    non-trailing `*` is passed through and rejected by `_cr_is_safe_member_path`;
    an unsafe prefix (`../*`, absolute) is skipped with a warning.
- **Phase 2 (toolchain default).** `toolchain_decide` unit cases (extend existing
  coverage): workspace `[toolchain]` pin applies as the floor; member
  `capsule.toml` overrides per field; malformed pin warns and does not constrain.
- **Phase 3 (inheritance).** `toml_parser_test.sfn`: `{ workspace = true }`
  inline-table parse; `[workspace.package]` / `[workspace.dependencies]` getters.
  Resolver test: a member with `version = { workspace = true }` resolves to the
  root's version; a member overriding it wins.
- **Phase 4 (capability envelope).**
  - `workspace_capability_audit` unit cases: member within envelope → no drift;
    member exceeding `allow` without a grant → drift diagnostic naming the
    effect; a matching `[grants]` entry clears the drift; `deny` overrides a
    grant → drift; hierarchical `io` allows `io.*` (SFEP-0017 interaction);
    non-canonical effect name in the envelope → diagnostic.
  - `mode = "warn"` reports drift with exit 0; default `enforce` exits non-zero.
  - E2E (`compiler/tests/e2e/*_test.sfn`, `![io]`, driving the subprocess per
    `.claude/rules/no-bash-e2e.md`): a fixture workspace with a drifting member
    fails `sfn build` / `sfn check`; `sfn capabilities audit` prints the table
    and exits non-zero.

## 9. References

- SFEP-0006 (`docs/proposals/0006-build-architecture.md`) §4.2, §4.5, §4.12 —
  the resolver machinery, resolution order, and lockfile ownership this SFEP
  extends but does not restate.
- SFEP-0002 (`docs/proposals/0002-package-management.md`) — the package-manager
  vision, `sfn capabilities audit`, and the aspirational `[[capsule]] allow`
  shape this SFEP concretizes.
- SFEP-0017 (`docs/proposals/0017-hierarchical-effects.md`) — the effect
  subsumption relation Phase 4 reuses for envelope membership.
- SFEP-0046 (`docs/proposals/0046-toolchain-pinning.md`) — the toolchain
  floor/override model Phase 2 documents.
- `.claude/rules/seed-dependency.md` — the bundle-vs-split decision and the
  seed-cut tax governing the Phase 1 capability/consumer split.
- `.claude/rules/selfhost-invariant.md` — the self-host invariant driving the
  capability-first, adoption-second staging.
- Source: `compiler/src/capsule_resolver.sfn`
  (`load_workspace_members`, `_cr_expand_member_globs`,
  `parse_workspace_member_paths`, `discover_workspace_root`, `toolchain_decide`,
  `resolve_workspace_lock_entries`); `compiler/src/toml_parser.sfn`
  (`toml_get_workspace_members`, `toml_get_toolchain_sfn/channel`,
  `toml_get_capabilities_required`, `toml_get_name/version`); `workspace.toml`.
