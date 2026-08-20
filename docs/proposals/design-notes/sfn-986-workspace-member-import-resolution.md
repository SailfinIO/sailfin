# SFN-986 — Workspace-member import resolution, and what a `capsule.toml` field means

Single-issue implementation design gate (per `.claude/rules/proposals.md`: this
records a verdict on existing, shipped behaviour and corrects the documents that
describe it — not a forward-looking language or runtime design, so no SFEP
number). Design record for the PR that lands SFN-986.

- **Issues:** SFN-986 (this gate); SFN-988 (split out: wire `[dev-dependencies]`);
  SFN-989 (split out: publish-time advisory); SFN-987 (split out: the
  `workspace_member_capability_gate` call set)
- **Author:** agent:compiler-architect
- **Status:** design-approved
- **Updated:** 2026-08-20
- **Design records affirmed:** SFEP-0006 §4.5
  (`../0006-build-architecture.md`), SFEP-0072 §3.3
  (`../0072-domain-oriented-repository-topology.md`)

---

## 1. The question

SFN-986 was filed as a defect: a capsule can import a workspace sibling that its
own `capsule.toml` does not declare, and `[dev-dependencies]` is never read at
all. It carried a three-way fork — (A) enforce declarations as an allowlist,
(B) wire `[dev-dependencies]` only, (C) retract the promise and delete the
field — and asked for A-vs-C to be settled first.

**The fork is a false trichotomy.** The report bundles four findings of four
different genres. Separated, each has an unambiguous disposition, and none of
them is A.

| Finding | Genre | Disposition |
|---|---|---|
| Workspace members import without declaring | Docs precision gap + missing coverage | Affirm, document, pin with tests. **No code change.** |
| `[dev-dependencies]` never read | **Bug** against an Accepted SFEP | Fix per SFEP-0006 §4.6 → SFN-988 |
| In-workspace vs standalone divergence | Missing capability | Publish-time advisory → SFN-989 |
| `workspace_member_capability_gate` call set | Reach-pillar gap | Own issue → SFN-987 |

## 2. Two mechanisms named "implicit" — do not conflate them

The single most common way to get this area wrong is to treat these as one
thing. They are disjoint call graphs that happen to share the `members` data
model.

**(a) Implicit provider.** `[build] implicit = true`, per SFEP-0072 §3.3, landed
by SFN-931. Makes a provider's names available with **no import statement at
all** — the prelude mechanism. `select_workspace_implicit_members`
(`compiler/src/capsule_resolver/workspace.sfn`) filters members on
`.implicit == true`, and the selected specs are spliced into
`enumerate_capsule_sources` as additional specs, i.e. staged unconditionally
whether or not anything imports them.

**This mechanism is dormant in the real tree.** The only non-fixture capsule
that sets the flag is `capsules/sfn/prelude/capsule.toml`, which sets it to
`false` deliberately, pending the SFEP-0072 prelude-adoption slice.

**(b) Workspace-implicit source resolution.** `enumerate_workspace_implicit_sources`
(`compiler/src/capsule_resolver/implicit.sfn`) resolves a **written** scoped
import specifier against any workspace member, via `workspace_member_for_spec`
(`compiler/src/capsule_resolver/capability.sfn`) — bare name equality, with no
`.implicit` check and no `[dependencies]` **allowlist** check. Declared specs do
feed this leg, but only as an *exclusion* set that stops the same capsule being
staged twice; see §7. Its single call site in `dedupe.sfn` sits under an
`if workspace_root.length > 0` guard.

SFN-986 is entirely about **(b)**. Mechanism (a) neither causes nor cures it.

## 3. Verdict: (b) is intended behaviour

Four independent records agree, three of them predating the report:

1. **SFEP-0006 §4.5** (Accepted), resolution algorithm step 3, lists
   "Workspace members (always available)" on its own line *above* the
   `[dependencies]` / `[dev-dependencies]` line. Membership is sufficient by
   construction, not by omission.
2. **The shipped spec chapter** `spec/02-modules.md` lists "Workspace capsules
   — sibling capsules in a workspace" as its own resolution category, peer to
   registry capsules.
3. **The in-code rationale** in `implicit.sfn` records (b) as "the unified
   replacement for the hard-coded `_is_stdlib_capsule_cmd` allowlist that gated
   implicit stdlib resolution." Mechanism (b) is what allowed a hardcoded
   allowlist to be deleted. Reverting it re-creates that problem in manifest
   form.
4. **`advanced/capsules.md`** already scoped the requirement to registry
   imports — though it then contradicted itself in the Workspace Imports
   section by asserting the importer "must list the dependency in its own
   `capsule.toml`". That contradiction is corrected by SFN-986; it is the
   likeliest source of the report's premise.

## 4. Why option A was rejected

**It is a design reversal, not a bug fix.** It contradicts an Accepted SFEP and
a shipped spec chapter. Landing it honestly would require an SFEP superseding
SFEP-0006 §4.5 plus an amendment to the spec — it cannot arrive as a
`fix(build):`.

**The migration is large.** 181 files under `compiler/tests/` import an `sfn/*`
capsule absent from `compiler/capsule.toml`'s `[dependencies]` (which has no
`[dev-dependencies]` section at all). 19 of 29 `capsule.toml` files in the tree
declare nothing whatsoever. (Counts measured 2026-08-20; treat as
order-of-magnitude, not exact.)

**It fails the restriction-vs-power test** (CLAUDE.md). A is pure restriction.
The power it would notionally attach — "the manifest is a complete, shippable
statement of a capsule's dependency reach" — is already delivered better
elsewhere:

- Inside a workspace, the workspace root **already** enumerates the member graph
  in one place. Per-member `[dependencies]` restates it N times.
- The Reach pillar's actual claim is capability completeness, and that is proven
  per-function by E0400/E0402 propagation plus the E0403 cross-check. Those
  checks run on the consumer's own source and key off the *callee's declared
  effects*, not off how the callee's capsule was located, so a declaration
  requirement adds nothing to them. A adds no Reach.

  Cite this carefully. `compiler/tests/e2e/standalone_workspace_implicit_import_test.sfn`
  proves effect propagation from a workspace sibling, but its
  effect-propagation case declares the provider (`explicit_dep = true`); its
  *undeclared* case covers resolution and linking, not effects. **No test
  currently exercises effect propagation through an undeclared sibling**, so
  the claim above rests on reading the checker, not on coverage. It is a cheap
  gap to close — the fixture is one boolean away — and worth closing before
  anyone leans harder on this argument.

Payer (every monorepo user, forever, plus a tree-wide migration) is not
beneficiary. It fails as a headline.

**Option C was also rejected.** It would delete a field that SFEP-0006 §4.6
promises, that shipped `sfn add --dev` writes, and that standalone consumers
have no substitute for.

## 5. The accepted residue of A: the divergence is real

A's underlying insight survives its rejection. Resolution genuinely differs
between contexts:

- **Inside a workspace** — the member list resolves the specifier.
- **Outside one, with a `capsule.toml`** — no member list exists, so
  `[dependencies]` is the only set consulted.
- **Outside one, with no manifest at all** (a bare `sfn build main.sfn`) — a
  third leg applies: `enumerate_cache_implicit_sources`
  (`compiler/src/capsule_resolver/implicit.sfn`) resolves scoped imports
  straight against the user capsule cache, again with no declaration required.
  Its guard in `dedupe.sfn` requires both no project root and no workspace root.

So the "declaration required" case is narrower than it first looks: it is
specifically *a capsule with a manifest, outside any workspace*. Both the
workspace leg and the manifest-less cache leg resolve without declarations. Any
tooling that reasons about manifest completeness — SFN-989's advisory in
particular — has to account for all three.

So a capsule developed in a monorepo can be published with an incomplete
manifest and fail for its first standalone consumer. This is a "works on my
machine" trap that neither keeping (b) nor enforcing declarations addresses.

The chosen response is a **publish-time advisory** (SFN-989) that diffs a
capsule's scoped imports against its declared dependencies and warns. That
converts A's restriction into a Reach-pillar power — *the manifest you ship is
provably complete against your source* — with no tree-wide migration, no
contradiction of SFEP-0006 §4.5, and no build gate.

Empirically confirmed against seed 0.10.0 (SFN-986 grooming probe): a standalone
capsule importing a capsule declared only under `[dev-dependencies]` produces
output byte-identical to declaring it nowhere, while the same import under
`[dependencies]` is queued and its absence reported. Inside a workspace the same
import resolves silently with both tables empty.

**The trap is currently worse than a failed build.** When the standalone
consumer's import resolves to nothing, the compiler emits no diagnostic at all:
the import parses, type-checks, and lowers, then dies at link with an
`undefined symbol` and an ICE that tells the user to file a compiler bug. So the
divergence's failure mode is not "your manifest is incomplete" but "you have
found a compiler bug." That defect is tracked separately as SFN-990; it raises
the value of the SFN-989 advisory, since catching this at publish time avoids
the misleading failure entirely.

## 6. The general rule

The report's underlying error is a reasonable one: it assumed a field present in
the manifest schema is enforced. Most are not, and there is no marker
distinguishing them — `compiler/src/toml_parser.sfn` does not reject unknown
sections, so an unrecognised or inert section is indistinguishable from a live
one.

> **A `capsule.toml` or `workspace.toml` field is descriptive unless a named
> gate is cited.** "It parses and round-trips" is not enforcement. When
> documenting a field, cite the gate — a diagnostic code, a validation
> function, or a test — or state plainly that it is descriptive.

This rule, and the inventory in §7, exist so that sibling findings in the same
genre can cite this note instead of re-deriving the diagnosis. Two such
findings sit in Triage at time of writing: one on `sfn check` performing no
import validation, and one on `[capabilities] required = []` silently disabling
the E0403 cross-check. The second is likely the *same verdict genre* as this
note — intended and under-documented rather than broken — and should be
expected to resolve to "docs plus a negative test", not "enforce it".

## 7. Manifest-field enforcement inventory

Verified 2026-08-20. "Enforced" means a build, check, or command path rejects or
reports on the field's content — not merely that it parses.

| Field | Enforced? | By what |
|---|---|---|
| `[capabilities] required` | **Yes, when non-empty** | E0403 cross-check via `validate_capsule_capabilities`. An **empty list skips the check entirely** — deliberate, so standalone `.sfn` files outside any capsule have no phantom surface to compare against (rationale recorded in `capsule_resolver/dedupe.sfn`, echoed in `effect_gate.sfn` and `main.sfn`). Empty is *not* an assertion of "no effects". Also downgradable to warn/off via `SAILFIN_EFFECT_ENFORCE` (`effect_gate.sfn`). |
| `[workspace.capabilities]` `allow`/`deny` | **Yes, when the envelope is active** | E0405 (a member's declared effect exceeds the workspace envelope) and E0406 (malformed entry — non-canonical effect name, or a list not in canonical alphabetical order), in `capsule_resolver/capability.sfn`. Two caveats matching the `required` row's shape: the gate returns immediately when `allow` is **empty**, so a `deny`-only envelope never reaches E0406; and `mode = "warn"` reports without failing. |
| `[toolchain]` floor | **Yes** | `toolchain_decide` + `semver_satisfies_floor`, gated by `toolchain_gate_or_dispatch`. Floor semantics (running ≥ pin). Note it reports a plain `error: toolchain mismatch` string, **not** an `Exxxx` diagnostic, and is downgradable via `--skip-toolchain-check` / `SAILFIN_SKIP_TOOLCHAIN_CHECK` / `SAILFIN_TOOLCHAIN=off`. |
| `publish = false` | **Yes, on `sfn publish`** | E0612 — refuses to package, read credentials, or upload a private capsule. |
| `publish = false` (consumer side) | **Yes, on resolve** | E0613 — refuses a private capsule resolved from a **fetched** origin, before its sources are staged. A local workspace member may legitimately be private; only a fetched one is rejected. |
| `[dependencies]` | **Barely** | No semver-range satisfaction check: the declared version string is used verbatim as a cache-path segment. The only report is advisory and has no E-code — a direct dependency declared in `capsule.toml` but absent from `capsule.lock`. Otherwise declared specs only populate the exclusion set that stops the workspace and cache legs double-collecting. **Not an allowlist** — see §3. |
| `[dev-dependencies]` | **No** | Parsed, round-tripped, and written by `sfn add --dev`. Zero readers in resolution. This is the one unambiguous "parsed but not enforced" violation in the family → SFN-988. |
| `[build] implicit` | **Yes, as a selector** | Read by `toml_get_build_implicit` into `WorkspaceMember.implicit`, which is the sole selector for `select_workspace_implicit_members` — mechanism (a) in §2. Currently no non-fixture capsule sets it `true`. |
| SFEP-0020 role layering | **Test-enforced only** | `compiler/tests/unit/compiler_capsule_boundary_test.sfn` is a static ratchet over `compiler/src/*` imports. Nothing in the compiler rejects a layering violation at build or check time — it is a regression test, not a diagnostic-producing pass. Worth knowing before citing it as a compiler guarantee. |

Deliberately excluded: E0614 (target triple), E0615 (archive extraction), E0616
(home directory unresolvable), E0617 (emit-target precedence). All four gate
CLI-flag or environment inputs, not manifest fields.

## 8. What this note does not decide

- **Whether `[dev-dependencies]` should be transitive.** SFN-988 scopes them to
  test targets and non-transitive; that choice is made there, not here.
- **Where provider-manifest completeness should be proven and cached.** SFN-987
  raises that the one gate which audits a provider's own manifest runs only over
  the dormant mechanism (a). Widening it naively means a full parse of the entire
  dependency closure on every build, so it needs its own design gate.
- **Whether workspace membership should ever be narrowable.** A workspace could
  in principle offer an opt-in strict mode. That is SFEP-0051 territory
  (workspace-tier policy) and is deliberately not invented here.
