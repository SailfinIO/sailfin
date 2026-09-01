---
sfep: 2
title: Capsule Distribution and the Registry Protocol
status: Accepted
type: tooling
created: 2025-10-01
updated: 2026-09-01
author: "Tooling / Registry Working Group (original sketch); agent:Sailbot (2026-08 rewrite); human review"
tracking:
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0002 — Capsule Distribution and the Registry Protocol

> **Amendment (2026-08-05) — model-artefact scope retracted, doc realigned to
> shipped behaviour.** This SFEP was one of the original architecture sketches
> folded into the SFEP system at its founding (#1652) and was never edited
> afterwards. Two things had gone wrong. First, roughly half of it described
> **model-artefact management** — `[models]`, `[[modelpack]]`, `sfn add-model`,
> `sfn models sync`, generation cards, evaluator baselines, cost caps — a surface
> that exists nowhere in the compiler and is not on the roadmap; see
> [§2.1](#21-retracted-scope--model-artefacts). Second, its framing was inverted
> relative to reality: it claimed the registry was live "but the current toolchain
> lacks native commands for interacting with it," when in fact the distribution
> path has shipped for several releases. The body below is a rewrite, not a patch.

## 1. Summary

Sailfin distributes libraries as **capsules**: source archives published to a
registry, fetched by version into a shared local cache, and compiled from source
by the consumer. This SFEP owns the *distribution* half of that story — the
archive format, the registry protocol, publish authentication, capsule naming,
and the integrity guarantees attached to a fetch. It does **not** own the
resolver walk, the workspace manifest, or the build cache; those have their own
proposals ([§3.1](#31-scope-boundary--what-this-sfep-does-not-restate)).

The distribution path ships today and is in users' hands: `sfn init`, `sfn add`,
`sfn lock`, `sfn publish`, `sfn package`, `sfn login`, and `sfn config` are all
live in seed 0.9.1, backed by 24 first-party capsules on `pkg.sfn.dev`.

What does *not* ship is the half that matters for the Reach pillar. A published
capsule's capability manifest travels **inside** the artifact but is not surfaced
in the registry index; `sfn add` **ignores** the `digest` and `yanked` fields the
registry serves; and transitive dependencies are not fetched at all. So Sailfin
today derives a complete capability manifest and then drops it at the repo
boundary, and it distributes code over a protocol that publishes integrity
metadata no client checks. Sections
[3.3](#33-phase-1--verify-the-digest-on-fetch)–[3.7](#37-phase-5--enforce-capsule-publish--false)
close that gap in five phases, any of which can land alone and in any order —
only Phase 4 has a soft ordering preference (its fetches should inherit Phase 1's
verification, so it is cheaper to land second).

## 2. Motivation

Sailfin's first pillar claims the compiler "derives a capability manifest and
proves it **complete**" — and that the manifest is something *you can ship and
attest*. That claim is what makes the effect system a power rather than a
restriction (`docs/strategy/decision-brief.md` §3). The compiler holds up its
end: `[capabilities] required` is parsed
(`compiler/src/toml_parser.sfn:636-653`), cross-checked against every function's
declared effects by `validate_capsule_capabilities`
(`compiler/capsules/analyzer/src/effect_checker/validations.sfn:16`), and enforced as **E0403** — emitted at
`compiler/capsules/analyzer/src/effect_diagnostics.sfn:147`, rendered via
`compiler/src/diagnostics_render.sfn:84` — through the build gate
(`compiler/src/effect_gate.sfn:152-166`).

The distribution layer then throws that away. Three concrete failures:

**A consumer cannot see a dependency's reach before fetching it.** The registry
index exposes, per version, only `digest`, `url`, `meta`, and `yanked` — and
`meta` is `{}` for all 24 capsules across every published version, because
`sfn publish` sends it as a hardcoded literal
(`compiler/src/cli/commands/publish.sfn:167`). The capability manifest is not
missing from the *artifact* — the capsule's full `capsule.toml` is the first
entry in the archive (`publish.sfn:119`) — it is missing from the *index*, which
is the only thing a consumer, auditor, or mirror can read without downloading
and unpacking every candidate version.

**Worse, fetching is unauthenticated in the integrity sense.** The registry
serves a `sha256` digest per version, and `sfn add` never reads it: the index
parser extracts *only* the `"latest"` field
(`compiler/src/cli/commands/add.sfn:198-241`). The client computes a sha256
*after* download (`add.sfn:425`) and records it to the lockfile
(`add.sfn:430-437`) — a trust-on-first-download imprint, compared against
nothing. A tampered artifact is undetectable on first fetch. The same parser
ignores `yanked`, so a withdrawn version installs cleanly; this is live today,
since `sfn/async` and `sfn/io` have every version yanked (`latest: null`).

**And the dependency graph must be resolved by hand.** `sfn add` fetches exactly
one capsule and never reads the fetched manifest's own `[dependencies]`
(`add.sfn:286-444` — no worklist, no second fetch). The *build* path is
transitively aware (`compiler/src/capsule_resolver/discovery.sfn:401-514`) but
only *locates* already-cached source; on a miss it emits "run `sfn add <spec>` to
populate the cache" (`discovery.sfn:509-513`). Users therefore discover their
transitive graph one build error at a time.

None of these are hard problems. They are consequences of the distribution layer
having been built as a thin `curl` wrapper to get the ecosystem moving, which was
the right call at the time and is now the constraint.

### 2.1 Retracted scope — model artefacts

The original sketch treated model artefacts as first-class dependencies:
a `[models]` manifest section, `[[modelpack]]` workspace entries with digests and
`evaluators`/`cost_cap` fields, `sfn add-model <provider>:<name>@<ver>`,
`sfn models sync`, `sfn cache cards --replay <trace>`, generation cards embedded
in build outputs, and `sfn test --scope seed=42 --scope temperature=0.2`.

**All of it is retracted.** No part was ever implemented: `git grep 'models' --
compiler/src` returns zero hits, and the only occurrence of `modelpack` in the
tree was this file. The reasoning is not re-derived here — it is already on the
record in three places:

- **`docs/strategy/decision-brief.md` §7 item 9** retired SFEP-0024 on the
  grounds that it was "the only ML document a reader would mistake for current
  direction." That was acted on — SFEP-0024 is `Superseded` — and this file
  inherited the same defect for the package-management half. Retracting it here
  discharges that.
- **`docs/status.md:959-967`** records that the `model`/`prompt`/`tool`/
  `pipeline` constructs were **removed from the language** — parser, AST,
  typecheck, emitter and runtime stubs deleted. Only the `![model]` *effect*
  survives, and it is `Reserved`: declarable and propagating, with no detector,
  landing with the post-1.0 `sfn/ai` capsule (`docs/status.md:696`).
- **`CLAUDE.md`** states the governing rule: AI integration is a post-1.0
  library concern gated by `![model]`, never language syntax — libraries over
  keywords.

The surviving ML story is **numerics, not model management**: SFEP-0052 (Accepted)
covers accelerator interop and capability-typed kernels, with SFEP-0053/0054/0062
beneath it. Its artefacts — `sfn/tensor`, `sfn/nn`, `sfn/layers`, `sfn/losses` —
are published as **ordinary capsules** through the protocol described here and
need no special-cased manifest surface. That is the point: a model-weights story,
if one is ever wanted, is a capsule-shaped problem, and this SFEP should be
revisited then rather than pre-committing a schema now.

Also retracted, per **decision-brief §7 item 7** and SFEP-0052's 2026-07-26
amendment: the claim that `sfn capabilities audit` "ensures that policies exist
for taint-tracked types such as `PII<T>` or `Secret<T>`," and that "policy
bundles ship alongside capsules, so downstream consumers inherit redaction rules,
retention windows, and consent flows." The taint strand is demoted — it is the
restriction the market declined, and `extern` defeats it regardless.
`sfn capabilities audit` is real, but it is SFEP-0051's workspace
capability-envelope report, not a taint-policy tool.

**Downstream cleanup this retraction exposes but does not perform.** Retiring the
model surface here leaves four artefacts elsewhere still presenting it as current
direction — the same defect decision-brief §7 item 9 named. Recorded so they are
not lost:

- `site/src/content/docs/docs/advanced/ai-constructs.md` and
  `.../learn/ai-constructs.md` — user-facing pages for constructs
  `docs/status.md:959-967` records as **removed from the language**.
- `site/src/content/docs/docs/reference/preview/model-execution.md` — the
  `graduates-to` target of a `Superseded` SFEP, cross-linked from
  `getting-started/tour.md:613` and `learn/effects.md:399`.
- `docs/status.md:967` — still points readers at
  `0024-model-engines-and-training.md` for design discussion, which is
  `Superseded`; it should point at SFEP-0052.

These are documentation edits with no compiler impact, and none is a
prerequisite for any phase in §3.

## 3. Design

### 3.1 Scope boundary — what this SFEP does *not* restate

Modeled on SFEP-0051 §3. Each line is a hard cede; this SFEP cites these rather
than redesigning them.

| Territory | Owner |
|---|---|
| Resolver walk, resolution order, manifest schema plumbing | **SFEP-0006** §4.2, §4.5, §4.12 (Implemented) |
| `workspace.toml` in full — members, globs, `[workspace.capabilities]` envelope, `[profile.*]` | **SFEP-0051** (Accepted) |
| `[toolchain]` manifest section, pin semantics, floor semver, channel gate, `sfn toolchain install` | **SFEP-0046** §3.1 (Accepted) |
| `bootstrap.toml`, seed pinning — explicitly *not* public manifest schema | **SFEP-0047** (Implemented) |
| Build-artifact cache (axis 1) and the `sfn cache` verb | **SFEP-0040** (Implemented) |
| Runtime capability enforcement — the seal | **SFEP-0016** §3.2 (Accepted) |
| The toolchain surface, its output-envelope contract, and `lsp` / `doc` / `fix` (`vet` is retracted — lint lives in `sfn check`'s `W02xx` range) | **SFEP-0003** (Accepted) |
| Toolchain release cadence and seed cuts | **SFEP-0026** §3.3 (Accepted) |
| Effect subsumption for sub-effects | **SFEP-0017** (Implemented) |
| `[capsule] publish` — both the boolean *schema* and the publish-time refusal it specifies | **SFEP-0020** §3.6 (Accepted) |

Two corrections to inbound cross-references this rewrite creates:

- **SFEP-0006:1784-1786** says it "extends the manifest schema" defined by this
  proposal. That dependency direction is now inverted in practice: 0006 shipped
  the schema and resolver; this SFEP cites 0006. Worth a follow-up edit to 0006.
- **SFEP-0051:88-90** defers "models/provenance" *to* this SFEP. The models half
  is retracted (§2.1), so that deferral now dangles and 0051 should be amended to
  defer provenance only.

Retained from SFEP-0040 §2's split: the **dependency** cache
(`~/.sfn/cache/capsules/<scope>/<name>/<version>/src/`, axis 2) is this SFEP's
territory; the build-artifact cache and its `$SAILFIN_BUILD_CACHE_DIR` ladder are
not.

### 3.2 Shipped baseline

Recorded here because it is the substrate the phases modify, and because no other
design document states it. The normative user-facing reference is
`site/src/content/docs/docs/advanced/capsules.md`; this is the *why* behind it
(per SFEP-0001 §8: "the SFEP remains the design record (the *why*); the spec
chapter is the normative reference (the *what*)").

**Naming.** Capsules are `<scope>/<name>`. All 24 registry capsules are in the
first-party `sfn/` scope; a bare name on the command line is shorthand for that
scope (`sfn add http` → `sfn/http`). There are no unscoped registry entries. The
original sketch's claim that "standard library capsules use bare names" described
the *shorthand*, not the identifier.

**Archive format — `SFNPKG/1`.** A flat text container built by
`publish.sfn:118-133`:

```
SFNPKG/1\n
--- path: capsule.toml\n<verbatim manifest text>\n
--- path: <rel>/<file>.sfn\n<file contents>\n
...
```

The manifest is always the first entry, read straight off disk (`publish.sfn:88`)
and embedded unmodified — so `[capabilities] required`, `[dependencies]`, and
`[capsule] publish` all travel with the artifact. Subsequent entries are the
`.sfn` files under `src/` (`publish.sfn:121-133`, a depth-10 walk via
`_collect_sfn_files_cmd`). `add.sfn:243-279` is the inverse, scanning for
`--- path: ` markers; the round-trip is not byte-exact, since the packer appends
a trailing newline per entry that the unpacker retains. **Capsules are
distributed as source and compiled by the consumer**; there is no binary
artifact in the protocol.

**Registry protocol.** Three endpoints, over plain HTTPS:

| Method | Path | Purpose |
|---|---|---|
| `GET` | `/api/index.json` | full index: `{capsules: {"<scope>/<name>": {latest, versions: {"<v>": {digest, url, meta, yanked}}}}}` |
| `GET` | `/api/capsules/<scope>/<name>/<version>.sfnpkg` | raw `SFNPKG/1` payload |
| `POST` | `/api/publish` | `{type, capsule, version, digest, content_b64, meta}` |

Registry selection is a three-rung ladder (`cmd_shared.sfn:36-128`):
`SFN_REGISTRY` → `~/.sfn/config.toml [registry] url` → the compiled-in
`https://pkg.sfn.dev` (`cmd_shared.sfn:47`). Publish authentication is a bearer
token from `SFN_TOKEN` or `~/.sfn/credentials`, written by `sfn login`.
Published versions are immutable; withdrawal is via the `yanked` flag, not
deletion.

**Transport is `curl`, not `![net]`.** Both commands shell out via
`process.run` — `add.sfn:110-122` (index fetch) and `:99-101` (artifact
download), `publish.sfn:182-184` (the POST) — and are therefore declared
`![io]`, not `![net]`. This is not gated on anything: a native HTTP client
already ships and `sfn toolchain install` already uses it
(`intrinsic_effects.sfn:56-57`, `:125-127` register `http.get` / `http.post` /
`http.download` with `net.http` effects; `cli/commands/toolchain.sfn:240`
consumes it, and `:14-15` notes that path "does NOT shell out"). The registry
client is an unported holdover, not a design position — see
[§4](#4-effect--capability-impact) and the alternative in §6.

**Dependency version values are exact literals.** The value in `[dependencies]`
is used as a cache directory name, with precedence `workspace.lock` >
`capsule.lock` > the literal manifest string (`discovery.sfn:452-479`). There is
no range solver: `semver.sfn:11-13` states that npm-style `^`/`~` ranges are
"intentionally absent (SFEP-0046 §6)." `SemVer` *ordering* is used in two
narrower places — the toolchain floor check
(`capsule_resolver/toolchain.sfn:144-151`) and selecting the highest **already
cached** version on the manifest-less bare-build path
(`capsule_resolver/discovery.sfn:171-190`, SFN-216) — but neither evaluates a
constraint against a candidate set. In practice exact pinning works because
`sfn add` writes a concrete resolved version and pins the lockfile; a
hand-written `"^1.0"` does not resolve.

> **Documentation defect, filed by this rewrite.**
> `site/src/content/docs/docs/advanced/capsules.md:197-202` publishes a version
> constraint table (`^1.0`, `^0.2`, `~1.2`), and `:219` states verbatim: "The
> Sailfin resolver uses a version-constraint solver similar to Cargo's. It selects
> the highest version of each dependency that satisfies all constraints across the
> dependency graph." No such solver exists, and with no transitive fetch there is
> no graph to solve across. Per
> decision-brief §8 — "'parsed but not enforced' is not shipped, and is never
> marketed or documented as a guarantee" — that section must be corrected to
> describe exact-version pinning. This is a docs fix, tracked separately from the
> phases below; §3.8 states the intended end state.
>
> A second, smaller gap in the same family: `sfn lock` and `sfn package` both
> ship in seed 0.9.1 but appear **nowhere** in
> `site/src/content/docs/docs/reference/cli.md` — its Package Management section
> (`:410-521`) documents only `init`, `add`, `publish`, `login`, and `config`.
> Undocumented-but-shipped is the inverse of the defect above and a good deal
> less harmful, but it belongs on the same fix.

**Adding a dependency widens your capability surface.** `sfn add` merges the
fetched capsule's `[capabilities] required` into the *consumer's* manifest
(`add.sfn:410-421`). This keeps the build compiling, but means a dependency's
reach silently becomes yours — exactly the supply-chain gap SFEP-0051:66-72
describes and answers at the workspace tier. Phase 3 makes the widening
*visible before the fetch*; 0051's envelope makes it *boundable*.

### 3.3 Phase 1 — Verify the digest on fetch

*No gate; implementable today. The registry already serves the field.*

Extend the index parser to read `digest` alongside `latest`, and compare it to
the sha256 computed at `add.sfn:425` **before** unpacking. On mismatch, refuse
and leave the cache untouched.

- New diagnostic **E0610** — "artifact digest mismatch," reporting the capsule,
  version, expected and actual digest.
- The lockfile entry keeps its current shape; the value written is now a
  *verified* hash rather than an observation.
- When the index omits `digest` for a version (older mirrors), refuse rather than
  silently degrading — a fetch that cannot be verified is a fetch that fails.
  Escape hatch `SFN_ALLOW_UNVERIFIED=1` for bring-up against private mirrors,
  which must print a warning naming the capsule.

This is the smallest change with the largest claim attached: it converts
trust-on-first-download into verified fetch.

### 3.4 Phase 2 — Honour `yanked`

*No gate; implementable today.*

Read `yanked` per version. Refuse to *newly* select a yanked version
(**E0611** — "version is yanked"), with the message naming the latest
non-yanked version if one exists. A yanked version already pinned by an existing
lockfile entry still resolves, so a yank does not retroactively break a green
build; it only stops new adoption. When *every* version is yanked (`latest:
null` — the live state of `sfn/async` and `sfn/io`), fail with a distinct
message rather than the current confusing empty-`latest` path.

### 3.5 Phase 3 — Publish the derived capability manifest into `meta`

*Gated on: the registry service accepting and serving a non-empty `meta` object
on `POST /api/publish` (server-side, outside this repo).*

Replace the hardcoded `"meta":{}` at `publish.sfn:167` with a populated object
carrying, at minimum, the publishing capsule's declared capability surface and
its declared dependencies:

```json
"meta": {
  "schema": 1,
  "capabilities": ["clock", "io", "net"],
  "dependencies": {"sfn/json": "0.2.4", "sfn/strings": "0.3.0"},
  "toolchain": {"sfn": "0.9.1", "channel": "stable"}
}
```

All three values are already in hand at publish time — the manifest is read at
`publish.sfn:88`. The registry then serves them in `/api/index.json`, which makes
three things possible that are impossible today: a consumer can see a
dependency's reach **before** fetching; an auditor or mirror can survey the
ecosystem's capability surface without downloading every archive; and Phase 4 can
plan a transitive fetch from the index instead of by unpacking.

This is the phase that carries the pillar. The compiler already derives the
manifest and proves it complete within a build; this is the step that makes it
*shippable and attestable*, which is the difference between the restriction and
the power (decision-brief §3).

Two constraints. First, `meta` is **derived, not authored** — there is no new
manifest surface for a publisher to hand-write and get wrong, and no way to
publish a `meta` that disagrees with the embedded `capsule.toml`. Second, it is
**not a runtime guarantee**: per SFEP-0016 §1 and §3.2, the manifest is a
compile-time declaration checked as E0403 — "a *lint*, not a *cage*" — and
0016 §8's threat model bounds what a seal would and would not cover. Wording
must stay at "declared and cross-checked," never "enforced at runtime," until
0016 ships.

### 3.6 Phase 4 — Transitive fetch

*No gate. The data needed is already inside the artifact.*

Because `capsule.toml` is the first entry of every `SFNPKG/1` archive
(`publish.sfn:119`), `sfn add` can resolve the transitive graph **with no
registry change at all**: after unpacking, read the fetched manifest's
`[dependencies]` and enqueue each unsatisfied spec, reusing the worklist shape
already proven in `discovery.sfn:401-514`. Once Phase 3 lands, the same walk can
be planned from the index instead — cheaper, and it allows reporting the full
plan before any download.

Requirements: a visited-set keyed on `<scope>/<name>@<version>` (cycles between
capsules are possible and must not hang — guard the loop per
`.claude/rules/code-style.md`); every fetched artifact passes Phase 1
verification once that has landed; `capsule.toml` records only the **direct** dependency the user
asked for, while `capsule.lock` records the full closure. Dev-dependencies of a
dependency are not transitive.

This retires the "run `sfn add <spec>` to populate the cache" error
(`discovery.sfn:509-513`) as the primary way users learn their own graph.

### 3.7 Phase 5 — Enforce `[capsule] publish = false`

*No gate; the boolean is already parsed. This phase **implements SFEP-0020 §3.6's
existing design** rather than proposing a new one — it closes the enforcement
half noted in `docs/status.md:21-26` (SFN-707).*

`sfn publish` must refuse when the manifest declares `publish = false`
(**E0612** — "capsule is marked unpublishable"), before packaging and before any
network call. Today the field parses with full type-strictness and then nothing
consumes it at publish time, which is the most literally accidental
foot-gun in the surface: a private capsule declares its intent and the tool
ignores it.

### 3.8 Version constraint semantics — intended end state

*Ranges gated on: Phase 4 (a solver needs a graph) plus a range predicate over
`SemVer`, which `semver.sfn:11-13` already scopes as addable "without changing
this schema."*

The near-term position is the honest one and should be documented as such:
**exact versions, pinned by lockfile**, in the Go-modules spirit rather than
Cargo's. It is not a placeholder — with immutable published versions and a
verified digest, exact pinning gives reproducibility with no solver to trust.
The public docs must be corrected to say this (§3.2).

Ranges become worth building when the ecosystem has enough depth that manual
version bumping across a closure hurts — which requires Phase 4 to exist first,
since the pain is a property of graphs, not of single dependencies. Deferring the
solver until then is a sequencing judgment, not an aesthetic one.

## 4. Effect & capability impact

**On the language and effect system: none.** No new effect, no change to the
canonical six, no change to E0402/E0403 semantics or to the
`[capabilities] required` cross-check.

**On the capability *story*: this is the pillar's delivery mechanism.** Phase 3
is the step where a derived manifest stops being a build-local artifact and
becomes something a consumer, auditor, or mirror can read — which is what
"derives a manifest you can ship and attest" has been claiming. Until then the
claim outruns the tooling at the repo boundary.

Two honesty constraints on any wording that comes out of this:

- The manifest is **declared and cross-checked at compile time (E0403)**, never
  "enforced at runtime." Runtime enforcement is SFEP-0016's seal, which is
  `Accepted`, not shipped: "the capability manifest is a *lint*, not a *cage*"
  (SFEP-0016 §1).
- An absent or empty `[capabilities]` surface **skips** the cross-check; it is
  not deny-all (`advanced/capsules.md:129`). A published `meta.capabilities`
  of `[]` therefore means "declared nothing," not "reaches nothing," and must
  never be rendered as the latter.

The registry client's own effect row is `![io]` (it shells `curl`), not `![net]`
— see §3.2.

## 5. Self-hosting impact

Low, and confined to the CLI. The five phases touch
`compiler/src/cli/commands/add.sfn`, `publish.sfn`, and the shared registry
resolution in `cmd_shared.sfn`; none touch the lexer, parser, typechecker,
effect checker, or any lowering path. No AST or `.sfn-asm` change.

The margin is wider than it first looks, and worth stating precisely so nobody
builds a defensive design around a hazard that does not exist. `make compile` is
`<seed> build -p compiler`, so the **pinned seed's** resolver performs the walk —
and that walk never touches any of this code:

- All five phases live in `sfn add` / `sfn publish`, neither of which
  `make compile` invokes.
- The resolver reads no index and makes no network call at all:
  `_cr_locate_capsule_src` is pure `fs.exists` (`discovery.sfn:119-144`), and
  nothing under `compiler/src/capsule_resolver/` performs one.

So the invariant to preserve is narrow: a cached or in-tree workspace capsule
must never acquire a network dependency, and `cmd_shared.sfn` — the one file the
phases share with anything outside the two commands — must keep its registry
resolution side-effect-free. Beyond that, a Phase 1 or 2 refusal can fail a
user's fetch but cannot brick the self-host.

Per `.claude/rules/selfhost-invariant.md`, each phase needs `make compile` before
it is done; none is structural, so `make clean-build` is not required. Per
`.claude/rules/seed-dependency.md`, none of these is a compiler capability that
*runtime source* calls, so the runtime carve-out does not apply and each phase
bundles with its own consumer in a single PR — no seed cut.

## 6. Alternatives considered

**Ship binary artifacts instead of source.** Rejected for now. Source
distribution keeps the archive format trivial, makes the capability manifest
auditable by reading the archive, and sidesteps a target matrix per capsule. The
cost is consumer-side compile time, which SFEP-0040's artifact cache already
absorbs. Revisit if compile time on a deep closure becomes the dominant cost.

**Put the capability manifest in a signed sidecar rather than index `meta`.**
Stronger — a signature makes the manifest attestable by a third party, not merely
readable. Rejected as the *first* step because it needs a key-distribution story
the project does not have, and `meta` delivers most of the consumer value with a
one-field change. Phase 3 is deliberately shaped so signing layers on top: sign
the same derived object. Signed provenance stays future hardening with a real
gate (key distribution), not a vague "planned."

**Verify the digest but keep installing yanked versions.** Rejected: they are the
same class of bug (index fields the client ignores) and separating them would
leave a phase whose only content is "read one more field."

**Port the registry client to the native `![net]` HTTP surface.** Should happen,
and it is gated on nothing — the native client already ships and
`sfn toolchain install` already consumes it (§3.2). Excluded from the five phases
only because it is orthogonal to all of them, and folding a transport rewrite
into an integrity fix would make both harder to review. It deserves its own
issue: the payoff is that the registry client would declare `![net]` honestly
rather than hiding its reach behind `process.run`, which is a small
embarrassment for a language whose first pillar is proving reach.

**Retire this SFEP as `Superseded` and write a fresh one.** Rejected: four
proposals cite `SFEP-0002` (0006, 0040, 0046, 0051), and SFEP-0001 §8 keeps a
load-bearing file in place. Rewriting preserves the citable identifier; the
amendment banner carries the honesty about what changed.

**Keep the model scope as aspirational vision.** Rejected — this is the specific
failure decision-brief §7 item 9 named when it retired SFEP-0024: an unimplemented
document a reader mistakes for current direction. See §2.1.

## 7. Stage1 readiness mapping

`Accepted`, not `Implemented`: the distribution path ships, but the integrity
half does not, and SFEP-0001 §4 is explicit that a safety feature is not
`Implemented` until enforced end-to-end.

| Slice | State |
|---|---|
| `capsule.toml` schema — `[capsule]`, `[dependencies]`, `[dev-dependencies]`, `[capabilities]`, `[build]` parse and round-trip | Shipped (SFEP-0006 §4.2) |
| `[dev-dependencies]` → resolution | Shipped (SFEP-0006 §4.6, SFN-988) — `sfn test` targets only, root manifest only, never transitive |
| `capsule.toml` `[toolchain]` section | Shipped (SFEP-0046 §3.1 — not 0006 §4.2) |
| `SFNPKG/1` archive format, round-trip pack/unpack | Shipped |
| Registry protocol — index, download, publish | Shipped |
| `sfn init` / `add` / `lock` / `publish` / `package` / `login` / `config` | Shipped (seed 0.9.1) |
| Publish auth — `sfn login`, `SFN_TOKEN`, `~/.sfn/credentials` | Shipped |
| Registry selection ladder — `SFN_REGISTRY` → config → compiled default | Shipped |
| Dependency cache — `~/.sfn/cache/capsules/<scope>/<name>/<version>/src/` | Shipped (axis 2, SFEP-0040 §2) |
| `capsule.lock` / `workspace.lock` | Shipped (`docs/status.md:752`) |
| `[capabilities] required` → E0403 cross-check | Shipped |
| **Phase 1** — digest verification on fetch (E0610) | **Pending** — no gate |
| **Phase 2** — `yanked` enforcement (E0611) | **Pending** — no gate |
| **Phase 3** — derived capability manifest in index `meta` | **Pending** — gated on registry service support |
| **Phase 4** — transitive fetch | **Pending** — no gate |
| **Phase 5** — `publish = false` enforcement (E0612) | **Implemented** — SFN-714 |
| Version ranges + solver | **Deferred** — gated on Phase 4 + a `SemVer` range predicate |
| Signed provenance | **Deferred** — gated on key distribution |
| Port the registry client to the native `![net]` HTTP surface | **Out of scope here** — no gate; orthogonal to all five phases (§6) |
| Pre-publish test run, ignore-file packaging rules | **Out of scope** — recorded as known omissions, not planned work |

The last two rows say "out of scope," not "deferred," deliberately.
Decision-brief §6 holds that "an item with no named gate is a planning defect,"
so an item nobody has committed to is recorded here as a known omission rather
than dressed as a schedule.

E-codes **E0610**–**E0612** are allocated from the `E05xx`–`E06xx` build/check
tooling range (`docs/style-guide.md:224`); `E0600` (re-export bans) is the only
other occupant. Register them in the style guide when the first lands.

Note for whoever implements these: `add.sfn` and `publish.sfn` currently report
failures as bare `print` / `print.err` strings with no `Diagnostic`, span, or
E-code machinery. Introducing E06xx codes there establishes a new pattern for
these commands rather than extending an existing one — budget for the plumbing,
not just the check.

## 8. Test plan

E2E only — these are subprocess-driven CLI behaviours, so per
`.claude/rules/no-bash-e2e.md` they are `*_test.sfn` files using `sfn/test` with
`process.run_capture`, never shell scripts. `compiler/tests/e2e/publish_test.sfn`
already exists and is the pattern to follow (it is named in the shell-shim bullet
at `docs/conventions/e2e-tests.md:181-183`).

Every test that drives a fetch or publish must run against a **local stub
registry** rather than `pkg.sfn.dev` — a temp-dir HTTP surface, or `SFN_REGISTRY`
pointed at a file-backed fixture. No test may depend on live registry state.
Per the pool traps in `no-bash-e2e.md`, any test spawning a nested build threads
`SAILFIN_TEST_SCRATCH` and `PATH`, and uses
`clean_runner_env(nested_runner_scratch("<label>"))`.

| Phase | Coverage |
|---|---|
| 1 | fetch with matching digest succeeds; **tampered artifact with valid digest field is refused with E0610 and leaves the cache untouched**; missing `digest` refused; `SFN_ALLOW_UNVERIFIED=1` permits with a warning |
| 2 | yanked version refused with E0611 naming the latest non-yanked; lockfile-pinned yanked version still resolves; all-versions-yanked (`latest: null`) gives a distinct message |
| 3 | `publish` emits `meta` matching the manifest's declared capabilities and dependencies; a manifest with no `[capabilities]` emits `[]` and not an omitted key; round-trips through the index |
| 4 | a capsule with a transitive dep fetches the closure in one `sfn add`; a dependency cycle terminates rather than hanging; `capsule.toml` gains only the direct dep while `capsule.lock` gains the closure; dev-deps of a dep are not fetched |
| 5 | `publish = false` refuses with E0612 before any network call; `publish = true` and an absent key both publish |

Plus a regression guarding the self-hosting hazard in §5: a build against a
populated cache makes **no** network call, so Phases 1–2 cannot affect
`make compile`.

## 9. References

**Implementation (verified 2026-08-05, seed 0.9.1)**

- `compiler/src/cli/commands/add.sfn` — `:110-122` index fetch, `:99-101`
  artifact download, `:198-241` index parser (reads only `latest`), `:243-279`
  unpack, `:286-444` `run` (no transitive worklist), `:396-422` manifest write,
  `:410-421` capability merge, `:425` post-hoc sha256, `:430-437` lockfile.
  `:87-97` `_curl_post_json_cmd` is dead code with no caller — a plausible
  Phase 3 revival target.
- `compiler/src/cli/commands/publish.sfn` — `:88` manifest read, `:118-133`
  archive, `:141-147` digest, `:155-168` JSON body assembly, `:167` hardcoded
  `"meta":{}`, `:182-184` the curl POST
- `compiler/src/cli/commands/{login,config,lock,package}.sfn`
- `compiler/src/cli/commands/cmd_shared.sfn` — `:116-128` registry ladder,
  `:104-110` config-file rung, `:47` compiled-in default
- `compiler/src/capsule_resolver/discovery.sfn` — `:119-144` cache lookup (pure
  `fs.exists`), `:171-190` highest-cached-version selection, `:401-514`
  transitive worklist on the build path, `:452-479` version precedence,
  `:509-513` cache-miss diagnostic
- `compiler/src/capsule_resolver/toolchain.sfn:144-151` — semver floor check
- `compiler/src/lock.sfn:1-15` — lockfile format
- `compiler/src/toml_parser.sfn` — `:15-35` `SailToml`, `:334-388` typed-struct
  section ladder, `:636-653` `[capabilities] required`, `:270`
  `_toml_parse_capsule_publish`. Note a *second*, generic reader
  (`toml_get_string` `:782`, `toml_get_string_array` `:589`) serves arbitrary
  sections including `[registry]` and `[workspace.capabilities]`, so the typed
  ladder is not the complete recognized surface.
- `compiler/capsules/analyzer/src/effect_checker/validations.sfn:16`
  (`validate_capsule_capabilities`), `compiler/capsules/analyzer/src/effect_diagnostics.sfn:147`
  (E0403 literal), `compiler/src/diagnostics_render.sfn:84`,
  `compiler/src/effect_gate.sfn:152-166`
- `compiler/capsules/ir/src/intrinsic_effects.sfn:56-57`, `:125-127` and
  `cli/commands/toolchain.sfn:14-15`, `:240` — the native `![net]` HTTP surface
  the registry client does not yet use
- `compiler/src/semver.sfn:11-13` — ranges intentionally absent

**Registry state (`pkg.sfn.dev`, observed 2026-08-05)** — 24 capsules, all in the
`sfn/` scope; per-version fields `digest`, `url`, `meta`, `yanked`; `meta` empty
for every capsule and version; `sfn/async` and `sfn/io` fully yanked
(`latest: null`).

**Related proposals** — SFEP-0006 (build architecture, resolver), 0051
(workspace manifest), 0046 (toolchain pinning), 0047 (bootstrap manifest), 0040
(artifact cache), 0016 (capability seal), 0020 §3.6 (`publish` schema), 0003
(built-in tooling), 0026 (delivery process), 0036 (TLS runtime).
**Retracted direction** — 0024 (Superseded); current ML line is 0052 → 0053 /
0054 / 0062.

**Docs** — `site/src/content/docs/docs/advanced/capsules.md` (normative user
reference; `:197-202` and `:219` carry the constraint-solver defect filed in §3.2;
`:129` the not-deny-all rule; `:521-528` the honest publishing paragraph),
`.../reference/cli.md:410-521` (Package Management — documents neither `sfn lock`
nor `sfn package`), `docs/status.md:21-26`, `:696`, `:748`, `:752`, `:959-967`,
`docs/strategy/decision-brief.md` §3 (`:101`), §6 (`:238-241`), §7 items 7 and 9
(`:286`, `:290-292`), §8 (`:300-301`), §9.
