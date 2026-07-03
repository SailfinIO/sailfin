---
sfep: TBD
title: Compile-Time Match Exhaustiveness Checking
status: Draft
type: language
created: 2026-07-01
updated: 2026-07-01
author: "agent:compiler-architect; human review"
tracking:
supersedes:
superseded-by:
graduates-to: reference/spec/08-patterns.md
---

# SFEP-XXXX — Compile-Time Match Exhaustiveness Checking

## 1. Summary

Add a compile-time exhaustiveness check for `match` on enum-typed and
`bool`-typed scrutinees: a `match` that omits a variant (or a `bool` case) and
carries no unconditional wildcard/binding arm becomes a **build error** at
`sfn check` / typecheck time, naming the specific uncovered variant(s) with a
fix-it hint. Today this gap is caught only at *runtime*, via the
`match_exhaustive_failed` trap (`runtime/prelude.sfn:701`) — the exact "parsed
but not enforced" pattern the project's design framework flags as worse than
absent. The runtime backstop stays as defense-in-depth for scrutinees whose
type the frontend cannot statically resolve today (#829), but the compile-time
check becomes the primary guarantee, matching Rust's and Swift's `match`/
`switch` exhaustiveness.

## 2. Motivation

Sailfin's enums are real tagged unions — an `i32` (or narrower) discriminant
tag plus a max-payload byte region, computed and stored per-enum in
`EnumTypeInfo` (`compiler/src/llvm/lowering/lowering_phase_types.sfn:45-69`,
`tag_type`/`tag_size`/`max_payload_size`/`variants`). `match` already
destructures them with real variant patterns
(`Response.Ok { value }`/`Response.Error { code, message }`), guards, literals,
and `_` (`docs/status.md:173`: "`match` | Shipped | Literals, `_`, guards,
enum-variant destructuring"; spec `site/src/content/docs/docs/reference/spec/08-patterns.md:11-27`).
The declarations chapter states the intended semantics outright: "Enum values
are matched exhaustively with `match`"
(`site/src/content/docs/docs/reference/spec/03-declarations.md:111-112`).

That statement is not true today. Grepping `compiler/src/typecheck.sfn` for
"exhaustive" finds nothing — the typecheck pass never inspects a `MatchStatement`
for variant coverage. `docs/status.md:177` says so plainly: "Pattern-match
exhaustiveness | Partial | Runtime backstop (`match_exhaustive_failed`)". A
program with

```sfn
enum Response { Ok { value: int }, Error { code: int, message: string } }

fn handle(r: Response) -> int {
    match r {
        Response.Ok { value } => value,
    }
}
```

compiles clean under `sfn check` and `make compile` today. It only fails at
**runtime**, and only on the one input path that happens to hit
`Response.Error` — `match_exhaustive_failed` raises a `ValueError`
("Non-exhaustive match for value ...", `runtime/prelude.sfn:701-704`). This is
exactly a correctness bug the type system exists to prevent: the two pillars
that make Sailfin's enums valuable (effects and capabilities aside) are
undermined if a refactor that adds a variant (say, `Response.Timeout`) silently
compiles every existing exhaustive-looking `match` without a peep, and the
first sign of trouble is a production crash on the new variant.

Concretely this is worse than "no exhaustiveness feature at all" per the
project's "don't ship unfinished safety claims" principle (`CLAUDE.md`): the
spec prose already tells users their `match` is checked, and it is not. Rust
(`match` non-exhaustive → `E0004`) and Swift (`switch` must be exhaustive)
both reject this at compile time; this SFEP closes the gap for Sailfin's
canonical sum-type case.

**Interesting existing asset:** the LLVM lowering pass *already computes*
variant-coverage per `match` — but purely to decide whether to terminate the
merge block with `unreachable` (a codegen optimization) rather than falling
through to the runtime trap. See `lower_match_instruction`
(`compiler/src/llvm/lowering/instructions_match.sfn:825-834`):

```sfn
let mut match_exhaustive: boolean = has_unconditional_default;
if !match_exhaustive {
    if !has_guarded_cases {
        if subject_enum_info != null {
            match_exhaustive = matched_enum_tags.length == subject_enum_info.variants.length;
        } else if union_payload_types.length > 0 {
            match_exhaustive = matched_union_variants.length == union_payload_types.length;
        }
    }
}
```

This is the right *algorithm* (guarded arms excluded, tag-set-equality test)
at the wrong *pipeline stage* to serve as a user-facing diagnostic: it runs
deep in LLVM lowering (`build`/`run` only, not `sfn check`), it has no access
to source spans for a `sfn check`-shaped diagnostic, and its silence on the
non-exhaustive case is deliberate (it falls through to
`match_exhaustive_failed` instead of erroring). This SFEP moves the
*user-facing gate* to typecheck — where `sfn check` runs it before any IR
exists — while leaving the lowering-level `match_exhaustive` computation
alone (it continues to drive the `unreachable`-vs-trap codegen choice; see
§5).

## 3. Design

### 3.1 Scope for 1.0

- **In scope:** exhaustiveness over a `match` scrutinee that is **statically
  known to be a named `enum` type** (the high-value case — Sailfin's sum-type
  surface), and over a `bool`-typed scrutinee (`true`/`false`).
- **Shallow, variant-level only.** Coverage is computed at the level of "is
  each variant *name* covered by some arm," not at the level of the payload
  fields a variant-destructuring arm binds. `Response.Ok { value }` counts as
  full coverage of `Ok` regardless of which fields it binds or ignores; there
  is no deeper structural/nested-pattern exhaustiveness (e.g. exhaustiveness
  over a payload field that is itself an enum). A nested enum payload still
  requires its own `_`/binding wildcard, or its own dedicated `match`, if the
  outer arm needs to narrow further. This mirrors Rust's variant-level
  exhaustiveness (which *does* recurse into structural patterns) only at the
  first level — full recursive struct/tuple-pattern exhaustiveness is
  explicitly **out of scope** for 1.0 and left as a documented limitation
  (see §6).
- **Out of scope:** exhaustiveness over infinite/large domains — `int`,
  `float`, `string` literal patterns. These stay wildcard-required forever;
  there is no proposal to ever require literal-pattern exhaustiveness over an
  unbounded domain (Rust doesn't either, short of range-pattern totality
  tricks this project has no reason to chase). A `match` on an `int`
  scrutinee with only literal arms and no `_` is unaffected by this SFEP and
  continues to rely on the runtime backstop (documented limitation).
- **Non-enum, non-bool scrutinees** (inline `string | int` unions, plain
  structs, primitives other than `bool`) are unaffected — same reasoning as
  SFEP-0034 §3.6's `is` v1 scope cut: the frontend has no live
  expression-type inference (#829), so the scrutinee's static type is not
  reliably resolvable in the general case. See §3.3 for exactly which cases
  *are* staticaly resolvable without #829, and how.

### 3.2 Where this runs: typecheck, not effect-checker or lowering

The check is added as a typecheck-phase pass, hooked at the existing
`MatchStatement` arm in `check_statement`
(`compiler/src/typecheck.sfn:569-588`) — the site that already walks the
scrutinee expression, each case's pattern/guard/body, and produces the
`Diagnostic[]` that feeds `check_program_scopes` → `typecheck_diagnostics_full`
→ `sfn check`'s exit code. This is deliberate:

- It is the **earliest point in the pipeline** exhaustiveness can be checked
  meaningfully — before effect-checking, before native-IR emission, before
  any LLVM lowering exists. `sfn check` (parse + typecheck + effect-check,
  no IR/codegen) is the compiler's fast inner loop
  (`docs/proposals/0004-check-architecture.md`); exhaustiveness is a
  type-level property and belongs there, not gated behind a full `make
  compile`.
- It reuses the walk that's already threading `bindings`/`imports`/
  `top_level` through every statement — no new traversal infrastructure.
- The **second**, existing `MatchStatement` site
  (`compiler/src/typecheck.sfn:1337-1349`, inside
  `walk_statement_expressions`) is the nested-in-expression-position walk
  (used for expression-level diagnostics inside larger constructs); it is
  **not** duplicated with the exhaustiveness check to avoid double-reporting
  the same `match` twice when it also appears in statement position — see
  §3.6.

### 3.3 Resolving the scrutinee's static type without expression-type inference

The central design question is: how does typecheck know a `match` scrutinee is
of enum type `Foo`, given typecheck has **no expression-type inference**
(#829) — `SymbolEntry` (`compiler/src/typecheck_types.sfn:71-91`) carries only
`name`/`kind`/`span`/generic/C-ABI flags, no type. This is the same
constraint that keeps `E0814` (`await` non-future) and `E0815` (channel-send
mismatch) as pure, test-driven helper functions with no live wiring
(`compiler/src/typecheck.sfn:1223-1230`), and that made SFEP-0034 scope `is`
to a narrower, structurally-resolvable case rather than wait for #829.

This SFEP takes the same **name-based, pattern-driven** approach the LLVM
lowering pass already uses successfully for the analogous problem
(`resolve_match_subject_annotation`,
`compiler/src/llvm/lowering/instructions_match.sfn:97-122`, and
`_match_extract_call_target`/`resolve_match_subject_call_annotation` at
lines 130-165) — but resolve the **enum identity from the patterns
themselves**, which sidesteps needing the scrutinee's declared type at all
for the common case:

1. **Collect top-level enum declarations once per compile unit.** A new pass,
   `collect_enum_variant_sets(program: Program) -> EnumVariantSet[]`, walks
   `program.statements` for `Statement.EnumDeclaration` nodes (`ast.sfn:389-394`)
   and builds `{ name: string, variant_names: string[] }` for each — pure name
   extraction from `variants: EnumVariant[]` (`ast.sfn:260-264`), no type
   inference needed; this is exactly the same level of information
   `register_top_level_symbol`'s `EnumDeclaration` arm already touches
   (`compiler/src/typecheck.sfn:318-320`), just capturing the variant list
   too instead of only the enum's own name.
2. **Infer the scrutinee's candidate enum from its case patterns, not its
   declared type.** For a `MatchStatement`, walk `statement.cases[i].pattern`.
   A pattern of `Expression.Struct { type_name, fields }`
   (`ast.sfn:77`) with `type_name.length == 2` — the `Enum.Variant { ... }`
   shorthand the parser already produces for `Response.Ok { value }`
   (`compiler/src/parser/statements.sfn:845`, `expression_from_tokens`) —
   names its enum directly as `type_name[0]` and its variant as
   `type_name[1]`. If **every** non-wildcard, non-guarded case pattern in the
   `match` resolves to `Struct` patterns naming the *same* enum (found in the
   set from step 1), that enum is the match's resolved scrutinee type and its
   `variant_names` is the coverage universe. This needs **no** knowledge of
   the scrutinee expression's own declared type — the patterns are
   self-describing. This covers the dominant real-world shape (destructuring
   match over an enum with `Enum.Variant { ... }` arms) with zero
   type-inference dependency.
3. **Fallback: unqualified variant-name patterns.** A shorthand pattern that
   names only the variant (bare `Ok { value }`, without the `Response.`
   qualifier) is not disambiguated by the pattern alone if multiple enums
   share a variant name. For 1.0, this SFEP requires the **qualified** form
   (`Enum.Variant { ... }`) for the exhaustiveness check to activate; an
   unqualified variant pattern is treated as *not statically resolvable* and
   the `match` is skipped by the check (falls back to the runtime-only
   backstop) rather than guessed at — no false positives. (Today's
   `docs/status.md:173`/spec examples already write the qualified form in
   every worked example, so this is not a regression on real code.)
4. **`bool` scrutinees** are resolved independent of enum-declaration lookup:
   if every non-wildcard, non-guarded case pattern is a `BooleanLiteral`
   (`ast.sfn:64`, text `"true"`/`"false"`) and at least one case pattern in
   the match is a `BooleanLiteral`, the coverage universe is the two-element
   set `{true, false}` — no scrutinee-type resolution needed at all, since
   `bool` has no subtypes to disambiguate.
5. **Mixed/ambiguous matches are not checked.** If the case patterns don't
   uniformly resolve to one of (3.3.2) or (3.3.4) — e.g. a mix of `Struct`
   patterns naming different enums (a static-type error the effect/type
   checker doesn't otherwise catch today, out of scope here), or `Raw`
   patterns the parser couldn't structure — the exhaustiveness check
   declines silently (no diagnostic, matching the "decline, don't guess"
   discipline SFEP-0034 §3.6 established for `is` on non-enum operands). This
   keeps the check **sound but incomplete**: it never fires a wrong
   diagnostic, but it also does not yet catch every non-exhaustive match in
   the language. Widening the resolvable cases (declared-type flow from
   `let`/parameter annotations) is the natural follow-up once #829 lands.

### 3.4 Guards do not count as coverage

An arm with a non-empty guard (`case.guard != null` and, per the existing
`guard_has_text` check the lowering pass already performs at
`instructions_match.sfn:419-426`, a guard with actual trimmed text) does
**not** count toward covering its variant, because the guard may evaluate to
`false` and fall through. This matches Rust and Swift:

```sfn
match r {
    Response.Ok { value } if value > 0 => print("positive"),
    Response.Ok { value } => print("non-positive"),   // still required
    Response.Error { code, message } => print.err(message),
}
```

Concretely: the coverage set for step 3.3.2 is built only from **unguarded**
case patterns. This is a direct mirror of the lowering pass's own
`has_guarded_cases` / `!guard_has_text` gating on `matched_enum_tags`
(`instructions_match.sfn:411-491`) — the typecheck-level pass reimplements
the same rule so `sfn check` and `build`/`run` agree (see §5).

### 3.5 The diagnostic

New diagnostic code **`E0823`** (the next free slot in the `E08xx` typecheck
range; `E0801`–`E0819` are taken across `typecheck_types.sfn`/`typecheck.sfn`/
`atomics.sfn`/`byte_load.sfn`/`core_member_lowering.sfn`, and the sibling
in-flight draft `docs/proposals/0038-generic-constraints.md` has claimed
`E0820`–`E0822`):

```
error[E0823]: non-exhaustive match over enum `Response`
  --> src/handlers.sfn:14:5
   |
14 |     match r {
   |     ^^^^^^^^ missing variant(s): `Error`
   |
   = help: add an arm for `Response.Error { .. }`, or a wildcard `_ => ...` arm
```

Factory: `make_match_non_exhaustive_diagnostic(enum_name: string,
missing_variants: string[], span: SourceSpan?) -> Diagnostic`, added to
`typecheck_types.sfn` beside the other `E08xx` factories
(`make_await_non_future_diagnostic` et al., `typecheck_types.sfn:607-620`),
following the same shape:

```sfn
struct Diagnostic {
    code: string;       // "E0823"
    severity: string;   // "error"
    message: string;    // "non-exhaustive match over enum `Response`: missing variant(s): `Error`"
    file_path: string;
    primary: Token?;    // spans the `match` keyword / subject expression
    suggestion: FixSuggestion?;  // "add an arm for `Response.Error { .. }`, or a wildcard `_` arm"
}
```

`missing_variants` (plural) lists **every** uncovered variant, not just the
first, so a multi-variant addition (e.g. adding two new variants to an enum
with ten call sites) reports the complete gap per site in one pass rather
than a fix-iterate-refail loop.

**Secondary, optional diagnostic — redundant-arm warning.** A `W08xx`
warning, **`W0823`** (warnings and errors are independently numbered per the
existing `W01xx` load-warning precedent noted in the `Diagnostic.suggestion`
comment, `typecheck_types.sfn:60-62`), for an arm whose pattern can never
match because an earlier unguarded arm in the same `match` already covers its
variant/literal:

```sfn
match r {
    Response.Ok { value } => value,
    Response.Ok { value } => value * 2,   // W0823: unreachable — `Ok` already covered above
    Response.Error { code, message: _ } => 0,
}
```

This is a **nice-to-have, secondary to the exhaustiveness error** — mark it
optional for the initial implementation slice. It reuses the exact same
coverage-set bookkeeping (3.3) computed for the exhaustiveness check (an arm
is redundant if its variant/literal is already in the accumulated coverage
set *before* processing it, and it is itself unguarded), so the marginal
implementation cost is a few lines once the accumulator exists — but it is
severable: shipping `E0823` alone with `W0823` deferred to a fast-follow is
an acceptable, independently valid slice, whereas shipping `W0823` without
`E0823` would not be (the error is the actual safety claim).

### 3.6 Avoiding double-reporting between the two `MatchStatement` walk sites

`typecheck.sfn` walks `MatchStatement` in two places: the statement-position
arm in `check_statement` (line 569, feeds `sfn check`'s primary diagnostics)
and the expression-position arm in `walk_statement_expressions` (line 1337,
used when a `match` is nested inside another construct's expression walk —
e.g. inside an `if`/`for`/`with` body via `walk_block_expressions`). Both
currently duplicate the pattern/guard/body walk structure. The exhaustiveness
check is added **only** to the statement-position site (line 569); the
expression-position site is left untouched (it already exists purely to
surface *nested* expression diagnostics like undefined symbols inside guard
conditions, not top-level statement diagnostics, and a `MatchStatement` always
also appears via the statement-position walk when it's the direct body of a
block — see `check_block`'s dispatch). This avoids a `match` reachable from
both walk paths triggering `E0823` twice for the same source span.

### 3.7 Worked example (`docs/status.md`-cited case)

```sfn
enum Response {
    Ok { value: int },
    Error { code: int, message: string },
}

fn handle(r: Response) -> int {
    match r {
        Response.Ok { value } => value,
    }
}
```

Before this SFEP: compiles clean; traps at runtime with
`match_exhaustive_failed` the first time `handle` is called with
`Response.Error`. After this SFEP: `sfn check` (and `make compile`) rejects
this with `E0823`, naming `Error` as the missing variant, before any binary
exists.

## 4. Effect & capability impact

None. Exhaustiveness checking is a pure type-level static analysis over
`Statement.EnumDeclaration` and `MatchStatement` AST shape; it introduces no
new runtime behavior, no new effect, and does not touch the effect checker
(`effect_checker.sfn`) or capability manifests. The new diagnostic is
emitted from the typecheck pass exactly like the existing `E08xx` family.

## 5. Self-hosting impact

Passes touched, in pipeline order:

- **Lexer** — no change.
- **Parser** — no change. The `Struct`/`BooleanLiteral` pattern shapes this
  design reads already exist (`ast.sfn:77`, `ast.sfn:64`); no new syntax.
- **AST** — no new node. `Statement.EnumDeclaration` and `MatchCase`/pattern
  shapes are read, not modified.
- **Typecheck** (`compiler/src/typecheck.sfn`, `compiler/src/typecheck_types.sfn`) —
  the substantive change:
  - New pass `collect_enum_variant_sets` (new file
    `compiler/src/typecheck_match_exhaustiveness.sfn`, kept separate from the
    already-large `typecheck.sfn`/`typecheck_types.sfn` per the project's
    per-file memory-footprint discipline — see `lowering_phase_types.sfn`'s
    own "Extracted... to reduce per-file memory footprint" precedent).
  - New pass `check_match_exhaustiveness(statement: Statement, enum_sets:
    EnumVariantSet[]) -> Diagnostic[]` in the same new file, called from the
    `MatchStatement` arm of `check_statement`
    (`compiler/src/typecheck.sfn:569-588`) after the existing pattern/guard/
    body walk, threading in the `enum_sets` computed once per
    `typecheck_diagnostics_full` call (`compiler/src/typecheck.sfn:174-195`,
    alongside the existing `collect_top_level_symbols`/
    `collect_interface_definitions` calls).
  - New diagnostic factories `make_match_non_exhaustive_diagnostic` /
    (optionally) `make_match_redundant_arm_diagnostic` in
    `typecheck_types.sfn`, following the `E08xx` factory shape at lines
    591-638.
- **Effect checker** — no change (§4).
- **Native Emitter** (`emit_native.sfn`) — no change; a `match` that fails
  `E0823` never reaches emission (typecheck failure stops the pipeline before
  IR generation, per the standard `sfn check`/`make compile` gate ordering).
- **LLVM Lowering** (`compiler/src/llvm/lowering/instructions_match.sfn`) —
  **no functional change.** The existing `match_exhaustive` computation
  (lines 825-834) and the runtime `match_exhaustive_failed` fallback stay
  exactly as they are today. This is deliberate, not an oversight:
  - It remains the **defense-in-depth** backstop for the scrutinees §3.3
    declines to check statically (unqualified variant patterns, mixed/
    ambiguous matches, non-enum/non-bool scrutinees) — those still reach
    lowering unchecked by typecheck, so the `unreachable`-vs-trap choice
    still matters for them.
  - It also remains correct **even for the now-statically-guaranteed
    exhaustive matches**: once `E0823` passes, `match_exhaustive` at lowering
    time is definitionally `true` for that same match (same tag-set-equality
    algorithm, same guard exclusion — §3.4 explicitly mirrors
    `instructions_match.sfn:411-491`'s `has_guarded_cases`/`!guard_has_text`
    gating), so lowering already emits `unreachable` instead of a trap call
    for these matches today. The typecheck gate and the lowering computation
    independently agree; there is no need to delete or thread a "already
    proven exhaustive" flag through IR — recomputing a cheap tag-set
    equality at lowering time is not a performance concern (it is O(variant
    count) per match, not a fixed-point analysis) and keeps lowering
    self-contained, which matters for the modules that consume
    `instructions_match.sfn` without ever calling into typecheck (e.g. a
    hypothetical future direct-emit path).
  - **Runtime prelude** (`runtime/prelude.sfn:701-704`) — no change to
    `match_exhaustive_failed`; it keeps its `E0` role for the unchecked
    residual and is documented as such (§3.1, §6).

**Self-hosting invariant preserved.** This is a strictly **additive**
diagnostic gate. The old pinned seed contains no reference to `E0823` and no
compiler-source `match` is non-exhaustive today (every `match` across
`compiler/src/*.sfn` already writes exhaustive arms or a trailing `_`, by
construction — the compiler was written before this gate existed but its
authors already follow the discipline the gate now enforces); grep-auditing
`compiler/src/**/*.sfn` for enum `match`es without a trailing `_`/binding
wildcard is part of the implementation's first verification step (§8) to
confirm this before the gate is wired live. `make compile` builds the new
compiler (containing the new check) from the old seed; that new compiler then
self-hosts by compiling the (already-exhaustive) compiler source in the same
pass. **No seed cut required** — this is a single-consumer, compiler-source
capability with no separate downstream consumer to bundle against (the
"consumer" is `sfn check`/`make compile` itself, exercised in the same PR).
Per `.claude/rules/seed-dependency.md`, this is squarely the bundle case: one
PR, `make compile` self-hosts against the old seed with the new gate active
in the same pass.

## 6. Alternatives considered

- **Full recursive structural exhaustiveness (nested enum payloads,
  tuple/struct patterns), matching Rust's decision-tree algorithm exactly.**
  Rejected for 1.0 — Rust's usefulness/exhaustiveness matrix algorithm is
  substantially more machinery than variant-level coverage, and Sailfin's
  `match` patterns today only destructure one level (`Enum.Variant { field,
  ... }`); there is no nested-pattern surface yet to make deep exhaustiveness
  pay for itself. Shallow variant-level coverage catches the overwhelming
  majority of real bugs (the "I added a variant and forgot a call site"
  class) at a fraction of the implementation cost. Deep exhaustiveness is a
  natural post-1.0 extension once nested destructuring patterns exist.
- **Requiring the scrutinee's declared type via `let x: Enum = ...` /
  parameter annotation flow, instead of inferring the enum from the case
  patterns.** Considered and rejected as the *primary* mechanism (though
  compatible as a future widening): this is exactly the #829
  expression-type-inference dependency that SFEP-0034 explicitly declined to
  block on for `is`. Pattern-driven inference (§3.3) delivers the same
  practical coverage for the dominant `Enum.Variant { ... }` shape without
  waiting on #829, and composes cleanly with declared-type flow as a later,
  strictly additive widening (more matches become checkable; no match that
  passes today would start failing).
- **Checking exhaustiveness at LLVM lowering time (extending the existing
  `match_exhaustive` computation into a hard diagnostic) instead of
  typecheck.** Rejected: lowering only runs on `build`/`run`, not `sfn
  check`, so this would leave the fast inner loop blind to the exact defect
  the feature exists to catch, contradicting the project's validation-ladder
  design (`sfn check` as the cheap, IR-free gate,
  `docs/proposals/0004-check-architecture.md`). It would also require
  threading source spans through lowering, which today works from
  `.sfn-asm`-rendered text, not original AST spans — a strictly harder place
  to produce a good diagnostic than typecheck, which still holds the AST.
- **Treating any non-exhaustive match as a warning, not an error.** Rejected
  — per "don't ship unfinished safety claims," a warning that's silently
  ignorable (as most warnings are, in practice) does not close the gap the
  spec already claims is closed (`03-declarations.md:111-112`, "matched
  exhaustively"). This must be a hard build error to be an honest claim.
- **Requiring the fully-qualified `Enum.Variant` form and rejecting the
  unqualified shorthand (`Ok { value }`) outright as a parse/type error.**
  Rejected — the unqualified shorthand is existing, valid syntax
  (`docs/status.md:173`); this SFEP only declines to *check* exhaustiveness
  for matches using it (§3.3.3), it does not restrict what's legal to write.
  Disambiguating the unqualified form needs either #829 or a
  single-enum-in-scope heuristic, both deferred.
- **Shipping the redundant-arm warning (`W0823`) as a required part of this
  slice.** Rejected as a hard requirement — marked optional/secondary (§3.5)
  since it is a code-quality lint, not a soundness gap; the exhaustiveness
  error is the safety-critical deliverable and should not be gated on the
  warning's completion.

## 7. Stage1 readiness mapping

- [ ] **Parses** — N/A (no new syntax; existing `match` syntax unchanged).
- [ ] **Type-checks / effect-checks** — `E0823` non-exhaustive-match error
  wired live into `check_statement`'s `MatchStatement` arm; `W0823`
  redundant-arm warning (optional slice).
- [ ] **Emits valid `.sfn-asm`** — N/A; a match that fails `E0823` never
  reaches emission. Matches that pass are emitted exactly as before (no
  `.sfn-asm` shape change).
- [ ] **Lowers to LLVM IR** — no change required (§5); the existing
  `match_exhaustive` computation in `instructions_match.sfn` already agrees
  with the new typecheck-level gate by construction (same algorithm, guard
  exclusion mirrored per §3.4).
- [ ] **Regression coverage** — see §8.
- [ ] **Self-hosts** — `make compile` after auditing `compiler/src/**/*.sfn`
  for any enum `match` lacking a trailing wildcard (expected: none found,
  per §5's construction argument, but must be verified before flipping the
  gate live).
- [ ] **`sfn fmt --check` clean** — every touched `.sfn` file.
- [ ] **Documented** — `docs/status.md:177` flips from "Partial | Runtime
  backstop" to "Shipped (enum + bool scrutinees; shallow variant-level)";
  `site/src/content/docs/docs/reference/spec/08-patterns.md`'s stability
  note (line 9) and exhaustiveness bullet (line 27) updated to reflect the
  compile-time guarantee and its scope cut (§3.1).

(All boxes unchecked — this SFEP is a design record, not yet implemented.)

## 8. Test plan

- **`compiler/tests/unit/typecheck_match_exhaustiveness_test.sfn`**:
  - A `match` over an enum with a qualified `Enum.Variant { ... }` arm per
    variant compiles with zero `E0823` diagnostics.
  - A `match` missing one variant produces exactly one `E0823` naming that
    variant.
  - A `match` missing multiple variants produces one `E0823` listing all of
    them (§3.5's `missing_variants` plurality).
  - A `match` with a trailing `_` (or bare-identifier binding) wildcard arm
    compiles with zero `E0823` regardless of variant coverage.
  - A guarded arm covering the only occurrence of a variant does **not**
    count as coverage — `E0823` still fires for that variant (§3.4).
  - A `bool` scrutinee `match` with both `true` and `false` arms compiles
    clean; missing one produces `E0823`.
  - An unqualified variant-name pattern (`Ok { value }` without `Response.`)
    does not trigger `E0823` even when non-exhaustive (§3.3.3 decline case) —
    asserts the "sound but incomplete" behavior explicitly, so a future
    widening's regression test has a documented baseline to diff against.
  - A non-enum, non-bool scrutinee (e.g. `int` literal patterns without `_`)
    is unaffected — zero `E0823` (out of scope, §3.1).
- **`compiler/tests/unit/typecheck_match_redundant_arm_test.sfn`** (if the
  optional `W0823` slice ships): an arm whose variant is already covered by
  an earlier unguarded arm produces `W0823`; a guarded earlier arm does not
  suppress the later arm's necessity and produces no `W0823`.
- **`compiler/tests/integration/match_exhaustiveness_check_test.sfn`**: drives
  `sfn check` (per `docs/proposals/0004-check-architecture.md`'s
  frontend-only contract) against a fixture source string containing the
  §3.7 worked example; asserts the JSON diagnostic envelope contains
  `E0823` and the process exits non-zero. A companion fixture with the
  missing arm added asserts a clean, zero-diagnostic exit.
- **`compiler/tests/e2e/`**: no new e2e test required — this is a pure
  frontend diagnostic with no codegen/runtime surface to exercise beyond
  what integration coverage already proves; the existing lowering-level
  `match` e2e coverage (build-and-run enum `match` programs) is unaffected
  and continues to validate the `unreachable`/runtime-trap codegen path
  untouched by this change (§5).
- **Self-host audit**: before wiring the gate live, grep
  `compiler/src/**/*.sfn` for every `match <enum-typed-subject>` and confirm
  each has a trailing wildcard or full qualified-variant coverage — the
  concrete verification for §5's "no seed cut, single-PR bundle" claim.
  `make compile` (exit 0) is the final self-hosting proof.

## 9. References

- `docs/status.md:173,177` — `match` feature-matrix row; the exhaustiveness
  gap this SFEP closes.
- `site/src/content/docs/docs/reference/spec/08-patterns.md` — §8 Pattern
  Matching (pattern forms, stability note, exhaustiveness bullet to be
  updated on graduation).
- `site/src/content/docs/docs/reference/spec/03-declarations.md:109-112` —
  §3.4/§3.5 enum semantics; the "matched exhaustively" claim this SFEP makes
  true.
- `compiler/src/ast.sfn:389-394` (`Statement.EnumDeclaration`), `:260-264`
  (`EnumVariant`), `:412-416` (`Statement.MatchStatement`), `:241-245`
  (`MatchCase`), `:77` (`Expression.Struct`), `:62-64` (literal expressions).
- `compiler/src/typecheck.sfn:569-588` (statement-position `MatchStatement`
  walk — the new check's hook site), `:1337-1349` (expression-position
  walk — deliberately not duplicated, §3.6), `:873-893`
  (`register_match_pattern_bindings`), `:1164-1168` (`walk_match_pattern`),
  `:318-320` (`register_top_level_symbol`'s `EnumDeclaration` arm), `:174-195`
  (`typecheck_diagnostics_full` — where `enum_sets` collection is threaded
  in), `:1223-1230` (the `#829`-gated concurrency type-rule precedent this
  design follows the shape of).
- `compiler/src/typecheck_types.sfn:54-69` (`Diagnostic`/`FixSuggestion`
  shape), `:591-638` (`E0813`–`E0815` factory precedent this SFEP's
  `E0823` factory mirrors).
- `compiler/src/llvm/lowering/lowering_phase_types.sfn:45-69` — enum tag/
  max-payload-size layout (`EnumTypeInfo`), confirming enums are real tagged
  unions.
- `compiler/src/llvm/lowering/instructions_match.sfn:97-165`
  (`resolve_match_subject_annotation`/`resolve_match_subject_call_annotation`
  — the name-based, no-type-inference resolution precedent this SFEP's
  §3.3 follows), `:825-834` (the existing `match_exhaustive` computation
  this SFEP leaves untouched at the lowering layer), `:411-491`
  (`has_guarded_cases`/`!guard_has_text` gating this SFEP's §3.4 mirrors).
- `runtime/prelude.sfn:701-704` (`match_exhaustive_failed` — the runtime
  backstop kept as defense-in-depth, §3.1/§5).
- `docs/proposals/0004-check-architecture.md` — `sfn check` as the fast,
  IR-free analysis gate this check is designed to run inside.
- `docs/proposals/0034-is-type-guard.md` — prior art for scoping a
  frontend feature to the statically-resolvable case rather than blocking on
  #829 expression-type inference; the "decline, don't guess" discipline this
  SFEP's §3.3.5 follows.
- `docs/proposals/0038-generic-constraints.md` — sibling in-flight draft
  claiming `E0820`–`E0822`; this SFEP claims the next free block,
  `E0823`(–`W0823`), to avoid collision.
- Issue #829 — expression-type inference (tracked dependency for widening
  §3.3's resolvable-case set in a follow-up, not a blocker for this SFEP's
  1.0 scope).
- Rust `E0004` (non-exhaustive `match`), Swift's exhaustive `switch`
  requirement — prior art for the "hard compile error, not a lint" decision
  (§6).
