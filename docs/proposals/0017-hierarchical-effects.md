---
sfep: 17
title: Hierarchical Sub-Effects as Subsumption
status: Implemented
type: language
created: 2026-06-07
updated: 2026-07-18
author: "agent:compiler-architect"
tracking: "#1180, #1182"
supersedes:
superseded-by:
graduates-to: reference/preview/hierarchical-effects.md
---

# Proposal: Hierarchical Sub-Effects as Subsumption Within the Locked Six

Status: Approved for implementation (gating decisions §D1–D5 locked 2026-06-07 by repo owner)
G6/G7 shipped: subsumption (SFN-98) and detection + manifest tightening (SFN-99).
Date: June 7, 2026 (drafted) · 2026-06-07 (gating decisions locked)
Authors: compiler-architect (drafted via `/pickup #1182`)
Parent: [docs/proposals/0008-effect-validation.md](./0008-effect-validation.md)
Related spec: [`site/src/content/docs/docs/reference/spec/07-effects.md`](../../site/src/content/docs/docs/reference/spec/07-effects.md)
Related preview: [`site/src/content/docs/docs/reference/preview/hierarchical-effects.md`](../../site/src/content/docs/docs/reference/preview/hierarchical-effects.md)
Tracks: Effect-system hardening / Phase G (epic #1180), gates G6/G7
Closes: #1182

## Summary

Sailfin's canonical effect taxonomy is **locked at 1.0** to exactly six atoms —
`clock`, `gpu`, `io`, `model`, `net`, `rand` — in
[`compiler/src/effect_taxonomy.sfn:18-22`](../../compiler/src/effect_taxonomy.sfn#L18-L22):

> "Adding a seventh effect post-1.0 means breaking the lock — do not extend
> without an explicit RFC."

This is that RFC. It resolves how hierarchical sub-effects (`io.fs`, `net.http`)
can exist **as subsumption refinements within the locked six** — never as new
top-level atoms. The deliverable is a model in which `io.fs` is a *refinement of*
`io` (written `io.fs ⊑ io`), so the canonical set returned by
`canonical_effects()` stays exactly six strings and the 1.0 taxonomy lock is
**not** broken. A function that declares the bare atom `![io]` keeps the broadest
grant and every existing annotation stays valid verbatim.

The model decided here:

- **Representation** — sub-effects are **dotted-name strings** (`io.fs`,
  `net.http`, `io.fs.read`) whose first dotted segment (the *root*) must be one
  of the canonical six. The taxonomy is not extended with a seventh atom; it is
  *refined* under the existing six.
- **Subsumption** — a grant subsumes a requirement iff the grant is at least as
  broad in the refinement lattice. Declaring `io` satisfies an `io.fs`
  requirement; declaring `io.fs` does **not** satisfy a bare-`io` requirement.
- **Manifest interaction** — `[capabilities] required = [...]` may list either
  coarse atoms or sub-effects; the same subsumption rule decides whether a
  function's declared effect is inside the capsule's authorized surface.
- **Backward compatibility** — every existing `![io]` (and every coarse atom in
  every existing manifest) stays valid and maximally permissive.
- **Gating** — the model ships **pre-1.0** as gates G6 (sub-effect parsing +
  subsumption ordering) and G7 (detection + manifest cross-check), because
  refinements *within* the six do not break the 1.0 lock. Implementation does
  not begin until this RFC is signed off (it now is — see "Decisions Locked").

No compiler code is changed by this issue; the deliverable is the owner-approved
design that unblocks G6/G7.

## The Taxonomy Lock (why this RFC is required)

`compiler/src/effect_taxonomy.sfn` is the single source of truth for which
effect strings the checker, diagnostic renderer, and capability cross-check
recognize:

```sfn
fn canonical_effects() -> string[] {
    return ["clock", "gpu", "io", "model", "net", "rand"];
}
```

The lock is load-bearing. The comment at lines 18-22 forbids adding a **seventh**
atom without an explicit RFC, because the taxonomy is a 1.0 compatibility
surface: code annotated `![io, net]` and manifests declaring
`required = ["io"]` must keep meaning the same thing across every 1.0.x release.

The one-paragraph preview (`preview/hierarchical-effects.md`) promised
fine-grained sub-effects (`io.fs.read`, `net.http`, `net.ws`) but never said
*how* they coexist with the lock. The naive reading — "add `io.fs` as a new
recognized effect" — would smuggle new atoms past the lock. This RFC rejects
that reading. **`io.fs` is not a new atom; it is a refinement of the existing
`io` atom.** `canonical_effects()` still returns six strings after G6/G7 land.

## Part 1 — Decisions

The five gating decisions, locked 2026-06-07 (full sign-off in "Decisions
Locked" at the end of this document):

| # | Decision | Choice |
|---|---|---|
| D1 | Taxonomy representation | **Dotted-name strings** (`io.fs`), not structured pairs |
| D2 | Subsumption direction | A **broad grant subsumes a narrow requirement** (`io` satisfies `io.fs`; `io.fs` does not satisfy `io`) |
| D3 | Manifest interaction | `required = [...]` entries are grants; subsumption decides authorization |
| D4 | Backward compatibility | Every existing `![io]` and coarse manifest entry stays valid and maximally permissive |
| D5 | Gating | Ships **pre-1.0** as G6/G7; does **not** add a seventh canonical atom |

The remaining parts specify each decision with worked examples.

## Part 2 — Representation (D1): dotted-name strings

A sub-effect is a string of the form `<root>` `.` `<segment>` (`.` `<segment>`)*
where `<root>` is one of the canonical six and each `<segment>` is a lowercase
identifier. Examples: `io.fs`, `io.fs.read`, `io.fs.write`, `io.console`,
`net.http`, `net.ws`, `net.dns`.

Rationale for dotted strings over structured `{root, refinement}` pairs:

- **Boring syntax wins.** The preview already uses `io.fs.read` / `net.http`.
  Dotted names match the user's existing mental model and the spec's prose; a
  structured representation would invent a new surface form for zero
  expressiveness gain.
- **Minimal wire-format churn.** `NativeFunction.effects: string[]` in
  `compiler/src/native_ir.sfn` already round-trips effect *strings* across
  capsule boundaries (see `effect-validation.md` §1.4). Dotted names ride that
  channel with **no `.sfn-asm` format change** — a sub-effect is just a longer
  string. A structured pair would require a new field and a migration of every
  staged artifact.
- **The canonical set is unchanged.** `canonical_effects()` keeps returning the
  six **roots**. Sub-effect validity is decided by a *new* predicate (G6 work,
  sketched below), not by extending the canonical list.

**Validity rule (G6).** A dotted effect string is *recognized* iff its root
segment is a canonical atom. `is_canonical_effect("io")` stays exactly as today
(membership in the six). A sibling predicate decides dotted names:

```sfn
// G6 — sketch only; not implemented by this issue.
// Returns true iff `name` is the `pure` sentinel, or its first dotted
// segment is one of the six.
fn is_recognized_effect(name: string) -> boolean {
    // Preserve the universally-allowed `![pure]` sentinel
    // (`is_universally_allowed_effect` in effect_taxonomy.sfn). `pure`
    // is not a canonical atom, carries no refinements, and must keep
    // round-tripping unchanged when G6 lands.
    if is_universally_allowed_effect(name) { return true; }
    let root = effect_root(name);   // "io.fs.read" -> "io"; "io" -> "io"
    return is_canonical_effect(root);
}
```

`canonical_effects()` is **not** modified. There is no seventh entry. An
unrecognized root (e.g. `disk.read`) is rejected exactly as an unrecognized
atom is today.

## Part 3 — Subsumption semantics (D2)

### 3.1 The refinement lattice

Each canonical atom is the **top** of its own refinement sub-tree. Dotted names
add nodes *below* the atom. Ordering is by prefix: `a ⊑ b` ("a refines b", "a is
narrower than b") iff `b` is a dotted prefix of `a` (or `a == b`).

```
            io                     net                  clock  gpu  model  rand
          /  |  \                /  |  \                (atoms with no
    io.fs io.console io.env  net.http net.ws net.dns    refinements yet —
     /  \                                                still valid bare)
io.fs.read io.fs.write
```

So: `io.fs.read ⊑ io.fs ⊑ io`, and `net.http ⊑ net`. Two siblings are
**unordered**: `io.fs` and `io.console` neither refines the other, even though
both refine `io`.

The bare atom (`io`) is the **least specific** (broadest) element of its
sub-tree — the join of everything below it. This is the key property that makes
backward compatibility free (Part 5).

### 3.2 The grant/requirement rule

There are two roles for an effect string:

- A **requirement** R is produced by an operation or an imported callee — "this
  code needs capability R".
- A **grant** G is what a function *declares* in `![...]` (or what a capsule
  manifest authorizes).

**Rule.** A grant `G` satisfies a requirement `R` **iff `R ⊑ G`** — the grant is
at least as broad as the requirement. Equivalently: *a broad grant subsumes a
narrow requirement; a narrow grant does not cover a broad or sibling
requirement.*

This is the standard variance for capability grants: holding the broad
capability `io` lets you perform any `io.*` operation, but holding only the
narrow `io.fs` does not let you perform a generic `io` operation whose precise
sub-effect the checker could not refine.

A function's declared set `Declared` satisfies its required set `Required` iff
**every** `r ∈ Required` is subsumed by **some** `g ∈ Declared`:

```
satisfies(Declared, Required)  ⇔  ∀ r ∈ Required. ∃ g ∈ Declared. r ⊑ g
```

### 3.3 Worked examples

Let the body-detector / call-resolver produce the requirement on the left; the
function declares the grant set on the right.

| Requirement R | Declared grant G | `R ⊑ G`? | Result |
|---|---|---|---|
| `io.fs` | `io` | yes (`io.fs ⊑ io`) | **OK** — broad grant subsumes narrow need |
| `io` | `io.fs` | no (`io ⋢ io.fs`) | **Missing effect** — narrow grant cannot cover a bare-`io` requirement |
| `io.fs.read` | `io.fs` | yes | **OK** — broad refinement subsumes deeper one |
| `io.fs` | `io.fs` | yes (`==`) | **OK** — exact match |
| `io.console` | `io.fs` | no (siblings) | **Missing effect** — `io.fs` does not authorize console I/O |
| `net.http` | `net` | yes | **OK** |
| `net` | `net.http` | no | **Missing effect** |
| `io.fs` | `net` | no (different root) | **Missing effect** — cross-root never subsumes |

The canonical worked case the issue calls out:

> **`io.fs ⊑ io`.** A function that performs a filesystem read produces the
> requirement `io.fs`. If it declares `![io]`, the broad grant subsumes the
> narrow requirement and the function type-checks. If instead it declares only
> `![io.fs]`, that is *also* sufficient for the `io.fs` requirement — but it is
> **insufficient** for any operation the checker can only attribute to bare
> `io` (e.g. a console write the detector resolves as `io` rather than
> `io.console`). Declaring `io.fs` narrows the function's authority; it does not
> satisfy an `io`-level requirement.

### 3.4 Canonical rendering

Diagnostics and the manifest render effect sets in canonical sort order, same as
today (`effect_taxonomy.sfn` stores the six in sort order for deterministic
`missing_effects` output). Dotted names sort lexicographically within their root,
so `![io.console, io.fs, net.http]` renders stably regardless of detection
order. A missing-effect diagnostic reports the **most specific** requirement the
checker derived (`io.fs`), and the fix-it suggests either that sub-effect or its
broader parent (`io`), since both satisfy it.

## Part 4 — Capsule-manifest interaction (D3)

`[capabilities] required = [...]` entries are **grants** at the capsule
boundary. The same subsumption rule from Part 3 decides whether a function's
declared effect is inside the authorized surface (this generalizes
`effect-validation.md` §4.6 / Phase F's `E0403`):

```
authorized(effect e, required R)  ⇔  ∃ g ∈ R. e ⊑ g
```

Worked manifest cases:

| Manifest `required` | Function declares | Authorized? | Note |
|---|---|---|---|
| `["io"]` | `![io.fs]` | yes (`io.fs ⊑ io`) | Coarse manifest grant covers a narrow function effect |
| `["io.fs"]` | `![io]` | **no** (`io ⋢ io.fs`) | A manifest may *tighten* a capsule to filesystem-only and forbid general `io` |
| `["io.fs"]` | `![io.fs.read]` | yes | Deeper refinement still inside the grant |
| `["io.fs"]` | `![io.console]` | **no** | Sibling outside the granted sub-tree → `E0403` |
| `["net"]` | `![net.http]` | yes | |

This makes the manifest a strictly more expressive contract: an author can write
`required = ["io.fs"]` to declare "this capsule touches the filesystem but never
the console or environment", and the compiler enforces it. The diagnostic for a
violation reuses `E0403` with the granted sub-tree named in the note.

**Audit interaction.** The dependency-audit / capability cross-check consumes
the same lattice: a downstream consumer that grants a dependency `io.fs` is
guaranteed (by subsumption) that the dependency cannot perform `io.console` or
`io.env`. This is the capability-narrowing story differentiator #2 promises.

## Part 5 — Backward compatibility (D4)

Backward compatibility is **free** because each bare atom is the top (broadest
element) of its refinement sub-tree:

- **Every existing `![io]` annotation stays valid and maximally permissive.**
  `io` subsumes every `io.*` requirement, so any function that compiled under
  the flat taxonomy still compiles: its `io` grant satisfies any sub-effect
  requirement the refined detector now produces.
- **Every existing manifest `required = ["io"]` stays valid.** `io` authorizes
  every `io.*` function effect, so no manifest needs editing when G6/G7 land.
- **No `.sfn-asm` migration.** Dotted names are strings in the existing
  `effects: string[]` field; old artifacts (all bare atoms) deserialize
  unchanged.
- **Opt-in narrowing only.** Sub-effects are something an author *adds* to get
  tighter guarantees. Nobody is forced to refine. The flat six remain the
  default and the recommended starting point.

The only way to *observe* a behavior change is to deliberately write a narrower
grant (`![io.fs]` or `required = ["io.fs"]`) than the requirement — which is
exactly the new tightening capability, and is opt-in.

## Part 6 — Gating (D5): pre-1.0 via G6/G7

Per owner decision (2026-06-07), the model ships **pre-1.0**. This is consistent
with the taxonomy lock precisely because **no seventh atom is added** —
`canonical_effects()` returns the same six before and after. Sub-effects are
refinements *within* the locked atoms, so the 1.0 compatibility surface (the set
of roots) is unchanged.

Implementation gates (this RFC unblocks them; it does not implement them):

- **G6 — `feat(effect-taxonomy): sub-effect parsing + subsumption ordering`.**
  - Parser/lexer: accept dotted effect names in `![...]` clauses.
  - `effect_taxonomy.sfn`: add `effect_root(name)`, `is_recognized_effect(name)`
    (root ∈ six), and `effect_subsumes(grant, requirement)` (prefix order).
    `canonical_effects()` is **untouched** — still six entries.
  - Replace exact-string set membership in the checker's "is this effect
    declared?" test with `effect_subsumes`-based satisfaction.
  - Regression coverage: the Part 3 truth table as unit tests.
- **G7 — sub-effect detection + manifest cross-check.**
  - Refine the detector so filesystem helpers attribute `io.fs`, console helpers
    `io.console`, HTTP `net.http`, etc., while unresolved sources fall back to
    the bare root (conservative — never *over*-narrow a requirement).
  - Extend the Phase F capability cross-check (`E0403`) to use
    `effect_subsumes` against `required`.
  - Spec §7 + `docs/status.md` updates.

**Do not start G6/G7 until this RFC is signed off.** It now is (see "Decisions
Locked"). Detection must stay conservative: when the checker cannot prove a
*narrower* requirement, it emits the **bare root** requirement, never a guessed
sub-effect — otherwise a refinement could spuriously narrow a real requirement
and let an under-grant slip through.

## Part 7 — Relationship to `effect-validation.md` §4.2

`effect-validation.md` §4.2 ("Effect hierarchy and composition") states "Effects
do **not** form a hierarchy at 1.0" and gives `model` is-not-a-sub-effect-of
`net` as the example. That statement is about **cross-atom** hierarchy among the
six *siblings* — `model` is not nested under `net`; the six are flat peers. This
RFC does **not** change that: the six roots remain flat, unordered peers with no
cross-root subsumption (the last row of the Part 3.3 table — `io.fs ⋢ net` —
makes this explicit).

What this RFC adds is **intra-atom** refinement: a tree *below* each atom. The
two are orthogonal:

- Cross-atom (§4.2): `model` and `net` stay independent. Unchanged.
- Intra-atom (this RFC): `io.fs ⊑ io`. New.

The scheduling note in §4.2/Phase G that hierarchy work is "post-1.0" is
**amended** by the owner's D5 decision: intra-atom refinements are pulled into
the 1.0 surface as G6/G7, since they add no atom and break no lock. Effect
*polymorphism* (effect-validation Phase G, `!E` variables) remains post-1.0 and
is unaffected by this RFC.

## Part 8 — Out of scope

- **Any compiler code.** That is G6/G7 (separate issues). This issue is
  design-only.
- **Adding a seventh canonical atom.** Forbidden by the lock; this RFC's entire
  premise is that sub-effects avoid it.
- **Cross-atom hierarchy.** `model ⊑ net` and friends stay rejected (§4.2).
- **Effect polymorphism (`!E`).** Post-1.0; effect-validation Phase G.
- **An exhaustive registry of every sub-effect.** G7 introduces sub-effects
  incrementally as detectors are refined; the lattice rule does not require a
  fixed closed set of refinements, only that every root is canonical.
- **Runtime capability enforcement.** Compile-time only, as with all effect
  work.

## Part 9 — Verification

This is a design-only change; verification is that the tree stays clean and the
deliverables exist:

```bash
# RFC exists and states the lock / subsumption / no-seventh-atom premise
test -f docs/proposals/0017-hierarchical-effects.md && \
  grep -i "seventh\|subsum\|lock" docs/proposals/0017-hierarchical-effects.md

# Preview points at the RFC
grep -q "proposals/hierarchical-effects" \
  site/src/content/docs/docs/reference/preview/hierarchical-effects.md

# No compiler source touched — taxonomy lock untouched
git diff --name-only main -- compiler/ runtime/   # expect: empty
```

## Decisions Locked (2026-06-07)

The repo owner reviewed this proposal (via `/pickup #1182`) and signed off on:

- **D1 — Representation.** Sub-effects are **dotted-name strings** (`io.fs`,
  `net.http`), not structured pairs. `canonical_effects()` keeps returning the
  six **roots**; sub-effect validity is decided by a new root-membership
  predicate, not by extending the canonical list. **No seventh atom is added.**
- **D2 — Subsumption.** A broad grant subsumes a narrow requirement:
  `io.fs ⊑ io`. Declaring `io` satisfies an `io.fs` requirement; declaring
  `io.fs` does **not** satisfy a bare-`io` requirement. Satisfaction is
  `∀ r ∈ Required. ∃ g ∈ Declared. r ⊑ g`.
- **D3 — Manifest interaction.** `[capabilities] required = [...]` entries are
  grants; the same subsumption rule decides authorization (`E0403` reused). A
  manifest may *tighten* a capsule with a sub-effect grant (`required =
  ["io.fs"]`).
- **D4 — Backward compatibility.** Every existing `![io]` and every existing
  coarse manifest entry stays valid and maximally permissive, because each bare
  atom is the top of its refinement sub-tree. No `.sfn-asm` migration.
- **D5 — Gating.** Ships **pre-1.0** as gates G6 (sub-effect parsing +
  subsumption ordering) and G7 (detection + manifest cross-check). This does
  **not** break the 1.0 taxonomy lock
  (`compiler/src/effect_taxonomy.sfn:18-22`) because it adds refinements *within*
  the six, not a seventh atom.

This RFC is the sign-off gate referenced by gates G6 and G7. With these
decisions locked, G6/G7 implementation is unblocked. Effect polymorphism
(effect-validation Phase G) remains post-1.0 and is out of scope here.
