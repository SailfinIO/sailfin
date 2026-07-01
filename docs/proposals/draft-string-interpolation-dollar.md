---
sfep: TBD
title: String Interpolation with ${ } (migrating off {{ }})
status: Draft
type: language
created: 2026-07-01
updated: 2026-07-01
author: "agent:compiler-architect; human review"
tracking:
supersedes:
superseded-by:
graduates-to: reference/spec/09-strings.md
---

# SFEP-XXXX — String Interpolation with `${ }` (migrating off `{{ }}`)

## 1. Summary

Replace Sailfin's `{{ expr }}` string-interpolation syntax with `${ expr }`,
matching JavaScript/TypeScript and Kotlin (Swift's `\(expr)` is the other
mainstream spelling but is not brace-delimited and does not fit Sailfin's
existing lexer shape as cleanly). The parser will accept both forms during a
deprecation window — mirroring the `TypeSep` dual-accept strategy of
SFEP-0005 — with `{{ }}` emitting a deprecation diagnostic, until the
compiler's own sources and the ecosystem are migrated and `{{ }}` is removed
before 1.0.

## 2. Motivation

Sailfin's current interpolation syntax is documented in
`site/src/content/docs/docs/reference/spec/09-strings.md`:

```sfn
let name = "Sailfin";
let greeting = "Hello, {{ name }}!";         // "Hello, Sailfin!"
```

`docs/status.md:176` lists this as **Shipped**, with the note "`${ }`
migration planned pre-1.0 (see Known Design Issues)". `docs/status.md:347-349`
records the problem explicitly, under "Known Design Issues (Pre-1.0 Syntax
Reform)":

> **String interpolation (`{{ }}` vs `${ }`)** — open. `{{ }}` means the
> opposite of its meaning in every mainstream template language; LLMs
> systematically generate wrong code. `${ }` migration is planned pre-1.0.

`CLAUDE.md`'s Pre-1.0 Syntax Reform list carries the same item (#2):

> **String interpolation: `${ }` not `{{ }}`** — parser change pending; keep
> `{{ }}` until updated.

Two independent forces make this load-bearing rather than cosmetic:

1. **Boring syntax wins** (`CLAUDE.md` Design Decision Framework). Every
   mainstream language with string interpolation that a working developer is
   likely to know — JavaScript/TypeScript, Kotlin, Bash (`${var}` for
   parameter expansion), PHP, Groovy — uses `${ }` (or the unbraced `$var`)
   for interpolation, and reserves double braces for template-engine
   *literal-escape* conventions (Jinja2/Handlebars/Mustache use `{{ }}` to
   mean "substitute a template variable into otherwise-literal text", the
   inverse framing from Sailfin's "substitute inside a language string
   literal"). `{{ }}` is not merely unfamiliar in Sailfin — it actively
   primes an experienced reader toward a *different* mental model.
2. **AI agents are users** (`CLAUDE.md`, same framework). LLMs have zero
   `.sfn` training data (per the project's stated tenet) and default to their
   training distribution — overwhelmingly `${ }` — when asked to write a
   Sailfin string literal with interpolation. This is not a hypothetical: the
   Design Decision Framework calls out `${ }` vs `{{ }}` by name as a
   systematic LLM-generation failure mode, and `docs/status.md:347-349` uses
   the same "LLMs systematically generate wrong code" language for this exact
   item. Every LLM-authored `.sfn` file that reaches for `${name}` compiles
   silently to a *literal* string containing `${name}` today — no parse
   error, no diagnostic, just wrong runtime output. That silent-wrongness is
   worse than a hard parse error would be.

This SFEP is the design record CLAUDE.md item 2 refers to as "pending" — it
did not previously exist as a numbered proposal, only as a roadmap bullet and
a `docs/status.md` note. It also fills the same procedural role SFEP-0005
filled for the colon-annotation reform: a concrete, citable plan the
implementer can execute directly, with a self-hosting-safe migration.

## 3. Design

### 3.1 Syntax

```sfn
let name = "Sailfin";
let greeting = "Hello, ${name}!";           // "Hello, Sailfin!"
let math = "2 + 2 = ${ 2 + 2 }";            // "2 + 2 = 4"
let nested = "User: ${ user.name.trim() }"; // arbitrary expressions
```

- `${` opens an interpolation segment; the matching `}` (see §3.3 for nesting)
  closes it.
- Whitespace immediately inside the braces is insignificant: `${name}` and
  `${ name }` are equivalent, matching the existing `{{ }}` rule ("Whitespace
  at the edges is ignored") in `09-strings.md`.
- A bare `$` not followed by `{` is an ordinary character with no special
  meaning — `"Total: $5"` is the literal string `Total: $5`. This matches how
  every language with `${ }` interpolation treats a lone `$` (JS template
  literals, Kotlin), and keeps prices/shell-ish text unaffected.
- **Escaping a literal `${`:** `\${` (backslash-escape, consistent with
  Sailfin's existing `\"`/`\\`/`\n` escape family recognized by the lexer's
  string-literal scanner) produces the two literal characters `${` with no
  interpolation. This is the same shape Kotlin uses (`\${`). JS's alternative
  convention of doubling (`$${`) is rejected as the primary form because it
  overloads `$` with a second meaning ("escape the next `$`") that has no
  precedent elsewhere in Sailfin's escape table — `\` is already the one and
  only escape introducer in `09-strings.md`'s (implicit, via the lexer)
  escape set. `\${` composes with zero new lexer rules: it is exactly one
  more two-character entry in the same escape-sequence table that already
  recognizes `\"`, `\\`, `\n`, `\r`, `\t`.

### 3.2 Grammar for the embedded expression

The embedded expression is **any Sailfin expression** — the existing
`{{ }}` implementation already supports "arbitrary expressions" per
`09-strings.md`'s own example (`user.name.trim()`), and nothing about moving
the delimiter changes that scope. Concretely, at minimum:

- Identifiers (`${name}`)
- Field/method access chains (`${user.name.trim()}`)
- Calls, including nested calls and argument lists (`${format(x, y)}`)
- Arithmetic/comparison/logical expressions (`${2 + 2}`, `${a > b}`)
- Any expression `lower_expression` (the existing LLVM-lowering expression
  evaluator) already accepts, since the design in §3.3 routes the extracted
  text through that same function unchanged.

No new expression grammar is introduced by this proposal — the deliverable
is exclusively the delimiter change and where recognition happens (see
§3.3). Interpolated segments are not permitted to contain statements
(`let`, `if`-as-statement, loops); this matches the current `{{ }}` behavior,
which only ever hands the extracted text to the *expression* lowerer.

### 3.3 Where recognition moves: lexer/parser vs. current lowering-time re-scan

This is the most consequential architectural decision in this proposal, so it
is stated explicitly rather than left implicit.

**Current state (verified by reading the source):** Sailfin's lexer
(`compiler/src/lexer.sfn`, string-literal branch starting at the
`is_double_quote(ch)` check around line 140) treats a `"..."` literal as
fully opaque — it scans forward to the matching unescaped `"` and emits one
`TokenKind.StringLiteral` token carrying the *raw, unprocessed* lexeme. There
is no interpolation awareness anywhere in the lexer, the parser
(`compiler/src/parser/`), the AST (`compiler/src/ast.sfn` — confirmed no
`Interpolat*` node exists), or the type checker. Interpolation is recognized
**only** during LLVM lowering, in
`compiler/src/llvm/expression_lowering/native/core_literals_lowering.sfn`
(`try_lower_interpolated_string_literal`, line 1917) and
`.../native/core_text.sfn` (`parse_interpolated_template`, line 487): the
already-unescaped literal text is re-scanned with a `find_substring_from`
search for the literal substrings `"{{"`/`"}}"`, split into a `parts[]` /
`expressions[]` pair, and each extracted expression's *text* is re-fed
through `lower_expression` (the general expression-lowering entry point,
also used for ordinary expression statements) as if it were freshly
re-parsed source.

**This SFEP recommends keeping that architecture** — i.e., **not** promoting
interpolation to a first-class AST node (no `InterpolatedString` variant
added to `ast.sfn`, no parser change to `parser/expressions.sfn`'s string
handling) — for three concrete reasons:

1. **Zero pipeline stages need to change except the delimiter recognized in
   two functions.** `parse_interpolated_template` in `core_text.sfn` is a
   ~35-line self-contained scanner; the change is `find_substring_from(...,
   "{{", ...)` / `"}}"` → the `${`/`}` scan described below, plus the
   `try_lower_interpolated_string_literal` guard at
   `core_literals_lowering.sfn:1919-1920` (`find_substring_from(content,
   "{{", 0)` / `"}}"`). Type checking, effect checking, and native-IR
   emission (`emit_native.sfn`) are already fully agnostic to interpolation
   today — they see one opaque `StringLiteral` — and stay that way.
2. **The re-scan-at-lowering design is exactly why the dual-accept migration
   in §5 is cheap.** Because recognition is late and localized to two
   functions in one file, supporting both delimiters simultaneously is a
   matter of trying `${`/`}` first, then falling back to `{{`/`}}`, in that
   single scanner — not threading a new token kind through the lexer, parser,
   and every AST consumer.
3. **Promoting to an AST node would be strictly more invasive for equal
   benefit.** An `InterpolatedStringLiteral` AST node would require lexer
   changes (recognizing `${` inside a string scan and emitting segment
   tokens), parser changes (building the node), and updates to every AST
   walker that currently treats a string literal as a single opaque token —
   the type checker's literal-type inference, the effect checker's
   AST-shape assumptions, and the Sailfin-source emitter
   (`emitter_sailfin_expr.sfn`/`emitter_sailfin.sfn`, used by `sfn fmt` and
   any AST-based tooling) all currently pass string literals through
   untouched. None of that investment is needed to fix the delimiter, and
   `docs/status.md`'s own framing of the feature as "Shipped" already
   presumes the current re-scan architecture is the shipped design — this
   proposal only changes what the scanner looks for, not when or how deeply
   it looks. (A future SFEP could still promote interpolation to a real AST
   node for other reasons — e.g. enabling `sfn fmt` to reformat the
   *interior* of an interpolation expression, which the current opaque-token
   design cannot do — but that is out of scope here; see §6.)

**Grammar for the scanner** (replaces `parse_interpolated_template`'s body):
scan the unescaped literal content left to right; on encountering `$`
immediately followed by `{`, treat everything up to the next unescaped `}`
as an embedded-expression segment (unbalanced brace nesting inside the
segment, e.g. `${ f({a: 1}) }`, must be brace-depth-tracked rather than
matched via a naive `find_substring_from(..., "}", ...)`, since the current
`{{ }}` scanner's `"}}"} `-substring search has no such nesting problem but a
single-`}` delimiter does — this is a real behavioral difference from the
current implementation that the implementer must account for, not merely a
delimiter swap). A `$` not followed by `{`, or an escaped `\${`, is emitted
as a literal character and does not open a segment.

### 3.4 Worked example: dual-accept period

```sfn
// Both compile identically during the deprecation window:
let a = "Hello, {{ name }}!";   // accepted; emits E-string-interp-deprecated
let b = "Hello, ${ name }!";    // accepted; no warning
```

### 3.5 What does *not* change

- String literals without any interpolation marker are unaffected.
- The escape table for ordinary characters (`\"`, `\\`, `\n`, `\r`, `\t`) is
  unaffected; `\${` is a new addition to that table, not a replacement.
- `.sfn-asm` / native IR format: string literals are emitted as opaque
  literal text today (interpolation is resolved to a segment-concatenation
  expression *before* IR emission, per §3.3); this proposal introduces no new
  IR shape, matching how SFEP-0005 needed no IR change for the annotation
  separator.

## 4. Effect & capability impact

None. String interpolation lowers to the same segment-concatenation +
`lower_expression` calls it does today (`try_lower_interpolated_string_literal`
in `core_literals_lowering.sfn`); the effect checker already treats an
interpolated literal exactly as it treats the desugared expression sequence
it becomes (a `+`-chain of string coercions and the embedded expression's own
effects, e.g. `"${io.read_line()}"` requires `![io]` because the embedded
call does — this is existing, unchanged behavior). Changing the delimiter
recognized by the scanner does not add, remove, or reorder any effect
requirement. `docs/status.md`'s effect rows for `sfn/strings` and the core
language are unaffected.

## 5. Self-hosting impact

**Which passes change:** exactly two functions in one file,
`compiler/src/llvm/expression_lowering/native/core_text.sfn`
(`parse_interpolated_template`) and the interpolation-detection guard in
`compiler/src/llvm/expression_lowering/native/core_literals_lowering.sfn`
(`try_lower_interpolated_string_literal`, lines 1919-1920). No changes to
`compiler/src/lexer.sfn`, `compiler/src/parser/`, `compiler/src/ast.sfn`,
`compiler/src/typecheck.sfn`, or `compiler/src/effect_checker.sfn` — all of
which already treat string literals as opaque and stay that way (§3.3).

**Why this is a breaking change requiring a migration path** (per
`.claude/rules/selfhost-invariant.md` and the `CLAUDE.md` self-hosting
constraints): the compiler's own sources use `{{ }}` today. A grep-verified
example: `examples/basics/structs.sfn:8` —
`return "Hello, {{self.name}}!";` — and 64 files across
`compiler/src/`, `runtime/`, `examples/`, and `capsules/` contain at least
one `{{ ... }}` interpolation literal as of this writing. If `${`/`}` were
made the *only* accepted form in one step, every one of those 64 files would
need to be migrated **atomically with** the scanner change, in the same
commit that changes `parse_interpolated_template` — and the *pinned seed*
(the released binary `make compile` bootstraps from, per `.seed-version`)
would need to already accept `${ }` before that commit could self-host,
which it does not. This is exactly the bootstrapping hazard
`CLAUDE.md`'s Self-Hosting Constraints section describes: "you can't change
syntax the compiler uses without a strategy for bootstrapping through the
transition."

**The migration strategy — dual-accept, then narrow, mirroring SFEP-0005:**
SFEP-0005 (`0005-colon-type-annotations.md`) solved the structurally
identical problem — a syntax reform touching thousands of occurrences across
the compiler's own source — by making the parser accept both the old and new
separator simultaneously (`TypeSep = "->" | ":"`), migrating all source
trees while both were legal, and only then splitting the acceptor into
two strict single-form functions (`consume_annotation_separator` /
`consume_return_type_separator`, SFEP-0005 "Phase 6"). This proposal follows
the same shape:

1. **Phase 1 — dual-accept scanner.** `parse_interpolated_template` tries
   `${ ... }` first; if no `${` is found, it falls back to scanning for
   `{{ ... }}` exactly as today. Both forms lower identically (same segment
   + expression-list result shape) — there is no AST or IR difference between
   the two spellings, only which delimiter the scanner recognized. This
   phase alone makes the *new* form legal without touching any of the 64
   existing occurrences. `make compile` self-hosts unchanged (the old seed's
   compiler binary does not need to understand `${ }` — the scanner change
   lives in `compiler/src/`, and `core_text.sfn` is `.sfn` source compiled
   *by* the seed, not consumed *as* seed capability; see the bundling note
   below).
2. **Phase 2 — deprecation diagnostic on `{{ }}`.** Once `${ }` round-trips
   (Phase 1 verified via `make compile` + `make test`), add a
   non-fatal deprecation diagnostic when the scanner falls back to the
   `{{ }}` branch, analogous to how a deprecated construct is flagged
   elsewhere in the checker (informational severity — this must not fail
   `sfn check`/`make check` yet, only surface a warning, since 64 in-tree
   files still use the old form at this point).
3. **Phase 3 — migrate compiler source, tests, runtime, examples, capsules.**
   Rewrite all 64 in-tree occurrences from `{{ expr }}` to `${ expr }`
   (a one-time mechanical script in the spirit of SFEP-0005's now-deleted
   `scripts/migrate_colon_annotations.py` — a fresh single-use script per
   SFEP-0005's own "Lessons Learned" note that such scripts are not kept in
   tree). Unlike SFEP-0005's context-sensitive `->`-vs-`->`-that-means-something-else
   ambiguity, this migration is comparatively low-risk: `{{` inside a string
   literal is unambiguous (no ordinary Sailfin string content collides with
   `{{`/`}}` as literal text in the existing corpus, since brace pairs are
   rare in prose/log-message literals — the script must still skip
   already-escaped or non-literal occurrences, e.g. `{{` appearing in a
   *comment* rather than a string literal, the same category of care
   SFEP-0005's script took for `->` inside comments/strings). Run
   `make compile && make test` after the rewrite. `sfn fmt --write` on every
   touched file per the standard change-discipline gate.
4. **Phase 4 — narrow the scanner to `${ }` only; drop `{{ }}` and its
   deprecation path.** Once no in-tree source uses `{{ }}` (Phase 3 complete)
   and the ecosystem has had a deprecation window to migrate (tracked via the
   roadmap/issue, not blocking this SFEP), remove the `{{`/`}}` fallback
   branch from `parse_interpolated_template` and the deprecation-diagnostic
   code from Phase 2. `{{ }}` becomes a plain (non-interpolated) literal
   string again — i.e. a stray `{{name}}` in a string literal is no longer
   special-cased and passes through as literal text, matching how an
   unmatched `${` with no `${` present behaves today. This is the "drop the
   old form after a new seed is cut" step `CLAUDE.md` describes, and — as
   with SFEP-0005 Phase 6 — is a candidate for landing as its own PR once
   Phase 3 has been in the pinned seed for at least one release cycle, so
   that no in-flight external capsule relying on `{{ }}` breaks without
   warning.

**Bundling note (per `.claude/rules/seed-dependency.md`):** Phases 1-3 do
**not** require a seed cut. `parse_interpolated_template` and
`try_lower_interpolated_string_literal` are ordinary `compiler/src/*.sfn`
functions; `make compile` builds the *new* compiler (with the updated
scanner) using the *old, pinned* seed exactly as it does for any other
`compiler/src/` change, and that freshly-built new compiler is what then
needs to accept `${ }` in the migrated Phase 3 source tree — which it does,
having been built from the Phase 1/2 source. Phases 1-3 should land as a
single PR (capability + its migration are one cohesive change with one
"consumer" — the compiler's own tree) rather than split across multiple
seed cuts, consistent with the default in `.claude/rules/seed-dependency.md`
("bundle a capability with its single consumer"). Only Phase 4 (dropping
`{{ }}` entirely) is a candidate for a later, separate PR, since its
correctness depends on an external fact (no remaining `{{ }}` usage anywhere
that will be built against this compiler) rather than on anything internal
to this repository — that PR is the one that should be sequenced against a
release/deprecation-window boundary, not against a seed cut per se.

## 6. Alternatives considered

- **`\( expr )` (Swift-style).** Rejected as the primary form. It is
  familiar to Swift developers but far less broadly recognized than `${ }`
  across the languages Sailfin's target audience (and LLM training data) is
  drawn from — JS/TS and Kotlin dominate both human familiarity and LLM
  training-data volume relative to Swift. It also introduces a lexer
  ambiguity with escaped parentheses and with Sailfin's existing lambda
  syntax (`fn(x) => expr`, SFEP-0029) that `${ }` does not have, since `${`
  is not a valid start of any other current Sailfin construct.
- **Bare `$name` (no braces, PHP/Bash-heartbeat style) with `${ expr }` only
  for non-trivial expressions.** Rejected: it adds a second grammar (bare
  identifier interpolation vs. braced expression interpolation) for marginal
  typing savings, and Sailfin's own precedent (`{{ name }}` today) already
  requires braces even for a bare identifier — keeping "always braced" is
  the smaller diff from current behavior and avoids ambiguity with `$` used
  adjacent to identifier-like text in prose literals (e.g. `"Price: $5 for
  item"` must never be misread as attempting interpolation of a variable
  named `5`).
- **Keep `{{ }}` permanently, treat the LLM-generation mismatch as a
  documentation/tooling problem (e.g. teach `sfn fix`/linters to rewrite
  `${ }` typos into `{{ }}`).** Rejected. This treats the symptom, not the
  cause, and only mitigates the *authoring* failure mode (an LLM or human
  typing `${ }` out of habit) while leaving the *reading* failure mode
  unaddressed (an LLM reading existing `{{ }}`-based Sailfin code and
  misinterpreting its semantics by analogy to Jinja2/Handlebars, where
  `{{ }}` denotes literal-into-template substitution — the inverse framing).
  It also does nothing for the stated design tenet ("Boring syntax wins") —
  keeping deliberately unusual syntax because tooling can paper over it
  contradicts the principle rather than satisfying it.
- **Promote interpolation to a first-class AST node now, as part of this
  change.** Rejected for *this* proposal — see §3.3 point 3. The delimiter
  swap does not need it, it substantially increases blast radius (lexer,
  parser, AST, every AST walker) for a change whose entire value is "which
  two characters open a segment," and it would entangle a mechanical
  syntax-reform PR with an unrelated representational upgrade. A future SFEP
  can propose the AST-node promotion independently (motivated by, e.g.,
  wanting `sfn fmt` to reformat interpolation interiors, or wanting the type
  checker to type-check embedded expressions before lowering instead of at
  lowering time) without needing to revisit the delimiter question this
  SFEP settles.
- **Skip the dual-accept window; do a single flag-day rewrite of all 64
  in-tree files plus the scanner in one commit, with no deprecation
  period at all.** Rejected as riskier with no offsetting benefit: it is
  the same total diff as Phases 1+3 combined, but removes the independently
  verifiable checkpoint ("`${ }` works, `{{ }}` still works, `make compile`
  is green") that the dual-accept phase gives for free, and forecloses any
  external-ecosystem grace period matching what SFEP-0005 gave the
  annotation-separator migration.

## 7. Stage1 readiness mapping

- [ ] Parses — Phase 1 (dual-accept scanner in `core_text.sfn`)
- [ ] Type-checks / effect-checks — no change required; already agnostic to
      interpolation delimiter (§4)
- [ ] Emits valid `.sfn-asm` — no change required; interpolation is resolved
      to ordinary segment-concatenation expressions before IR emission
- [ ] Lowers to LLVM IR — Phase 1 (`try_lower_interpolated_string_literal`
      guard update)
- [ ] Regression coverage — see §8
- [ ] Self-hosts — Phase 3 (compiler's own `{{ }}` occurrences migrated;
      `make compile` gate)
- [ ] `sfn fmt --check` clean — run on every file touched in Phase 3
- [ ] Documented in `docs/status.md` + spec — flip `docs/status.md:176`/
      `:347-349` and rewrite `site/src/content/docs/docs/reference/spec/09-strings.md`
      once Phase 3 lands; Phase 4 removes the "migration planned" language
      entirely

This SFEP stays `Draft` until the design gate is passed; it moves to
`Accepted` when cleared for implementation, and to `Implemented` only once
Phase 3 has landed, self-hosted, and the spec/status docs reflect `${ }` as
the sole documented form (per SFEP-0001 §4, "parsed but not enforced/
documented" does not qualify as `Implemented` — here the equivalent bar is
"accepted but the compiler's own source still emits deprecation warnings on
itself" not qualifying either).

## 8. Test plan

New/updated regression tests, following the existing pattern for
interpolation coverage (none of the below require new AST/typecheck test
scaffolding, since the feature stays a lowering-time concern per §3.3):

- **`compiler/tests/unit/`** — a lowering-focused unit test (co-located with
  or adjacent to wherever the current `{{ }}` lowering behavior is covered
  today — confirm via `Grep` for existing interpolation-lowering tests
  before adding) asserting: `parse_interpolated_template` correctly splits
  `"Hello, ${ name }!"` into `parts = ["Hello, ", "!"]`,
  `expressions = ["name"]`; a bare `$` not followed by `{` is left as
  literal text; `\${` produces the literal two characters `${`; nested
  braces inside a segment (`"${ f({a: 1}) }"`) are matched by depth, not by
  the first `}`.
- **`compiler/tests/integration/`** — an end-to-end compile+run test
  (`assert_compiles`/`assert_does_not_compile` from `sfn/test`, per
  `.claude/rules/no-bash-e2e.md`) verifying `${ name }` interpolation
  produces the expected runtime string output, matching an existing `{{ }}`
  integration test's shape if one exists (grep for one before writing a
  parallel case) so the two forms have symmetric coverage during the
  dual-accept window.
- **`compiler/tests/e2e/`** — a deprecation-diagnostic test (Phase 2)
  asserting that compiling a fixture containing `{{ name }}` produces the
  deprecation diagnostic on stderr/`--json` envelope, and that compiling a
  fixture containing `${ name }` produces no such diagnostic — using
  `assert_compiles`/`sfn check --json` per the `sfn/test` conventions in
  `.claude/rules/no-bash-e2e.md`, not a bash script.
- **Self-hosting gate (Phase 3):** `make compile` after the in-tree rewrite,
  then `make check` before declaring Phase 3 done, per
  `.claude/rules/selfhost-invariant.md`.
- **Formatting gate:** `sfn fmt --check` over every file touched in Phase 3
  (`compiler/src/`, `runtime/`, `examples/`, `capsules/`, and any touched
  `compiler/tests/*.sfn`), per `.claude/rules/formatting.md`.
- **Removal gate (Phase 4):** a negative test confirming `{{ name }}` no
  longer interpolates (compiles to the literal string `{{ name }}` in the
  output) once the fallback branch and deprecation diagnostic are removed.

## 9. References

- `docs/status.md:176` — current "Shipped" status row for `{{ }}` with the
  `${ }` migration note.
- `docs/status.md:347-349` — "Known Design Issues (Pre-1.0 Syntax Reform)",
  the `{{ }}` vs `${ }` problem statement this SFEP formalizes into a plan.
- `CLAUDE.md`, "Pre-1.0 Syntax Reform (Active)" item 2 — the standing
  intent this SFEP is the design record for.
- `CLAUDE.md`, "Design Decision Framework" — "Boring syntax wins", "AI agents
  are users" — the two tenets motivating this change.
- [SFEP-0005 — Colon Type Annotations](./0005-colon-type-annotations.md) —
  the directly analogous prior syntax-reform migration (dual-accept →
  migrate → narrow-the-parser), whose phase structure this proposal mirrors.
- `site/src/content/docs/docs/reference/spec/09-strings.md` — the spec
  chapter this SFEP's `graduates-to` target rewrites once `${ }` ships as the
  sole form.
- `compiler/src/lexer.sfn` (string-literal branch, ~line 140) — confirms
  string literals are lexed as opaque tokens today, with no interpolation
  awareness at the lexer stage.
- `compiler/src/llvm/expression_lowering/native/core_text.sfn`
  (`parse_interpolated_template`, line 487) and
  `compiler/src/llvm/expression_lowering/native/core_literals_lowering.sfn`
  (`try_lower_interpolated_string_literal`, line 1917) — the two functions
  this proposal's Phase 1 changes.
- `examples/basics/structs.sfn:8` — a representative in-tree `{{ }}`
  occurrence requiring Phase 3 migration.
- `.claude/rules/selfhost-invariant.md`, `.claude/rules/seed-dependency.md`
  — the self-hosting and seed-bundling constraints this proposal's Phase
  1-3 bundling recommendation follows.
