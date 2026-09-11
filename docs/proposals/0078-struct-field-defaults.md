---
sfep: 78
title: Struct Field Default Values
status: Draft
type: language
created: 2026-09-11
updated: 2026-09-11
author: "agent:compiler-architect (drafted); project owner (direction + decisions)"
tracking:
supersedes:
superseded-by:
graduates-to: reference/spec/03-declarations.md
---

# SFEP-0078 — Struct Field Default Values

## 1. Summary

A struct field may declare a default value — `body_addr: int = 0;` — using the
same `= <expr>` form the language already ships for default *parameters*. A
struct literal that omits a field **with** a default materializes that default;
a literal that omits a field **without** a default becomes a typecheck error
(`E0311`) instead of today's lowering-stage `E1002`. The default's value comes
from the field's declaration, written by the type's author, and never from the
compiler fabricating a zero — so this closes the additive-field breaking-change
problem without reopening the SFN-527/SFN-392 zero-fill soundness hole, which
stays closed by construction.

## 2. Motivation

### 2.1 There is no way to add a field to a public struct

`capsules/sfn/http/src/types.sfn:21` `struct Response` gained two fields —
`body_addr: int` and `body_len: int` at `types.sfn:58-59`, added in commit
`98b99fa` so a response can carry binary bodies a NUL-terminated `string`
cannot hold. Every hand-written `Response { status, headers, body }` literal in
out-of-tree Sailfin code stopped building the moment that landed.

The capsule's own source records the consequence as a warning to readers
(`capsules/sfn/http/src/types.sfn:36-41`):

> **Every `Response` literal must state all five fields.** A partial literal
> typechecks and then fails at LLVM lowering with `E1002` ("refusing to
> fabricate a default"), so these two fields are a breaking change to every
> hand-written literal — set both to 0 for a text response.

and the published reference repeats it as a **Breaking change** admonition
(`site/src/content/docs/docs/reference/standard-library.md:1020`). Both
documents are honest, and both document a language limitation rather than a
library decision: Sailfin offers its authors no additive way to extend a public
struct. Every field added to any exported struct, in any capsule, forever, is a
major-version break for every literal of it.

The specific new fields make the point sharply. `body_addr: 0` and
`body_len: 0` are exactly what a text-body caller wants, exactly what every
in-tree builder (`response`, `html_response`, `json_response`, `not_found`,
`redirect`) already passes, and exactly what the type's author would have
written as the default if the language had a place to write it. The break is
pure ceremony: it forces thousands of call sites to restate a constant the
author already knows.

### 2.2 The status quo: `check` green, build red, four stages disagreeing

The partial-literal path is not merely unsupported — it is *inconsistently*
unsupported across the pipeline. Reproduced against seed 0.12.0 on this branch:

```
$ sfn check partial.sfn
checked 1 files: ok            # rc 0

$ sfn build partial.sfn
llvm lowering [fatal] [E1002]: struct literal for `T` missing field `b`
  — refusing to fabricate a default `i64`     # rc 1
```

Each stage handles the literal differently, and the disagreement is structural:

| Stage | What it does with a partial literal | Where |
|---|---|---|
| **Parse** | Stores only the fields written, in source order, with no back-reference to the declaration | `Expression.Struct` / `ObjectField` at `compiler/capsules/syntax/src/ast.sfn:96` and `:248-251`; built by `parse_struct_literal` at `compiler/capsules/syntax/src/parser/expressions/literals.sfn:309-324` |
| **Typecheck** | Iterates the **literal's** fields, never the declaration's — so a missing field is not merely unreported, it is unreachable | `compiler/capsules/analyzer/src/typecheck/expression_walk.sfn:325-354` |
| **Emit** | Re-serializes the partial set verbatim into `.sfn-asm` | `compiler/capsules/codegen/src/emitter_sailfin_expr.sfn:106-120` |
| **Lower** | Inverts the iteration to the **declared** list and searches the literal per declared field; on a miss raises fatal `E1002` while still emitting the `insertvalue` with `default_return_literal` so the IR stays structurally valid | `compiler/capsules/codegen-llvm/src/expression_lowering/native/core_literals_lowering.sfn:743-746` (declared iteration), `:747-756` (per-field search), `:838-856` (the `E1002` branch); `default_return_literal` at `compiler/capsules/codegen-llvm/src/expressions_helpers.sfn:153-161` |

The lowering gate is pinned by
`compiler/tests/e2e/lowering_fabricated_value_gate_test.sfn:112-114`.

So the language's only answer to "this field is missing" lives in the backend,
four stages downstream of where the author wrote the literal, with no span in
the user's source file naming the literal, and it is invisible to `sfn check` —
rung 1 of the validation ladder. That is the #1389 class of build-only failure,
in a construct that is common, not exotic.

### 2.3 The symmetric feature already ships end-to-end

Default *parameter* values are Shipped (`docs/status.md:1626`, documented at
`site/src/content/docs/docs/reference/spec/03-declarations.md:66`). Verified by
running it: `fn add(a: int, b: int = 7)` called as `add(1)` exits 8. The full
chain exists and is the template this proposal follows:

| Link | Site |
|---|---|
| Parse `= <expr>` after the annotation | `compiler/capsules/syntax/src/parser/declarations/syntax.sfn:564-581` |
| AST slot | `Parameter.default_value: Expression?`, `compiler/capsules/syntax/src/ast.sfn:239` |
| `.sfn-asm` emit | `compiler/capsules/codegen/src/emit_native.sfn:827-828`, `compiler/capsules/codegen/src/emit_native_format.sfn:605-606` |
| Native-IR slot | `NativeParameter.default_value: string?`, `compiler/capsules/ir/src/native_ir.sfn:79` |
| `.sfn-asm` re-parse | `compiler/capsules/ir/src/native_ir_utils_parse.sfn:745-782` |
| Cross-module arity contract | `compiler/src/typecheck_import_loader.sfn:157-171` — "`NativeParameter.default_value` round-trips through the artifact … so a staged signature carries its defaults faithfully" |
| Render back to `.sfn-asm` | `compiler/capsules/codegen-llvm/src/rendering_helpers.sfn:266-277` |
| Call-site fill | `compiler/capsules/codegen-llvm/src/expression_lowering/native/core_call_lowering.sfn:502-528` |

`FieldDeclaration` and `NativeStructField` are the *same shape as their
parameter counterparts minus the default slot* —
`compiler/capsules/syntax/src/ast.sfn:272-277` and
`compiler/capsules/ir/src/native_ir.sfn:133-137`. There are exactly two
`FieldDeclaration { … }` construction sites
(`compiler/capsules/syntax/src/parser/declarations/structs.sfn:223-228` and
`compiler/capsules/syntax/src/parser/declarations/enums.sfn:235-240`), and
roughly a dozen non-test files reference the type.

### 2.4 SFN-392 declared this out of scope because it was undocumented

SFN-392 ("reject struct literals that omit required fields") put, verbatim,
under **Out:**

> Introducing a field-default / partial-literal language feature. None is
> documented, and the lowerer's own diagnostic shows the original intent was to
> reject.

That was the correct call for a soundness fix, and its reasoning names exactly
the gap this proposal fills: *none is documented*. **This SFEP is that
document.** It does not weaken SFN-392 — §3.2 shows it strengthens it, by
moving the rejection forward from the backend to typecheck and leaving the
backend gate in place as a backstop.

## 3. Design

### 3.1 Syntax

A field declaration gains an optional `= <expr>` tail, positioned exactly where
a parameter's default sits:

```sfn
struct Response {
    status: int;
    headers: string[];
    body: string;
    body_addr: int = 0;
    body_len: int = 0;
}

// Legal: the two defaulted fields materialize as 0.
let r = Response { status: 200, headers: [], body: "hi" };

// Legal: an explicit value always wins over the default.
let b = Response { status: 200, headers: [], body: "", body_addr: p, body_len: n };

// Error E0311: `status` has no default and was omitted.
let bad = Response { headers: [], body: "hi" };
```

Grammar (`site/src/content/docs/docs/reference/grammar.md:65`):

```
FieldDeclaration   = [ "mut" ] Identifier TypeAnnotation [ "=" Expression ] ";" ;
```

which is character-for-character the tail already in the `Parameter`
production two dozen lines below it (`grammar.md:111`):

```
Parameter          = [ "mut" ] Identifier [ TypeAnnotation ] [ "=" Expression ] ;
```

This is not a new concept, and should not be argued as one. CLAUDE.md's
"boring syntax wins" test asks whether a deviation buys expressiveness: here
the alternative spellings (`@default(0)`, `?field: int`, a `Default` interface)
all introduce a second way to say "this named thing has a value when
unmentioned" while the language already has one. Rust, Swift, Kotlin, Python
and TypeScript all spell the struct/class-member default `= expr`; an LLM
generating `.sfn` from zero training data will write `= 0` and be right.

The field terminator rules are unchanged: `;`, `,`, or nothing for the last
field (`compiler/capsules/syntax/src/parser/declarations/structs.sfn:200-221`).
The default expression ends at the terminator.

### 3.2 Semantics

1. **A field with a default is optional in a literal.** Omitting it
   materializes the declared default at that literal site.
2. **A field without a default is required.** Omitting it is `E0311` at
   typecheck, reported at the literal's span, listing **every** missing field at
   once rather than one per pass.
3. **An explicit field always wins.** The default is consulted only when the
   name is absent from the literal.
4. **Defaults are materialized per literal site, not evaluated once.** There is
   no shared "default instance"; each omission lowers its own constant. With
   §3.3's constant restriction this distinction is unobservable today, and
   stating it now prevents a future extension from inheriting Python's mutable
   default-argument trap.
5. **Declaration order, layout, size, alignment, and ABI are unchanged.** A
   default is a source-level convenience attached to a field; it does not
   reorder fields, does not permit reordering in a literal (that is already
   allowed — lowering searches by name at
   `core_literals_lowering.sfn:747-756`), and does not change
   `NativeStructLayoutField` (`compiler/capsules/ir/src/native_ir.sfn:139-145`).
6. **A defaulted field is still a field.** It is `mut` or not on its own terms,
   it is matched, read, and assigned identically, and it appears in the layout
   exactly where it was declared.

**Why this does not reopen SFN-527/SFN-392.** The hole those issues closed was
that the *compiler* invented a value: `default_return_literal(llvm_type)`
(`compiler/capsules/codegen-llvm/src/expressions_helpers.sfn:153-161`) returns
`0`/`false`/`null`/`zeroinitializer` derived from the field's **LLVM type**,
with no relationship to the author's intent. SFN-392's reproducer is the exact
failure: a `flag: boolean` the author meant to set to `computed` became
`i1 false` and the `computed` SSA value went dead. Nothing in the program said
`false` was correct; the backend picked it because `i1`'s zero is `false`.

A declared default is the opposite: the value is written by the type's author,
in the type's own declaration, in source the reader can see, and it type-checks
against the field's declared type like any other expression. The distinction is
*provenance*, and the design keeps it structural rather than relying on
discipline:

- The `E1002` gate at `core_literals_lowering.sfn:838-856` **stays**, unchanged
  in wording and severity. It gains one branch *before* it: if the declared
  field carries a default, lower the default; otherwise fall through to
  `E1002`.
- `default_return_literal` is **never** reached for a defaulted field. The two
  paths never meet: a default either exists (author's value) or does not
  (`E1002`, refuse).
- With `E0311` in typecheck (§3.4), `E1002` becomes the backstop it was
  designed to be rather than the primary diagnostic — it fires only when a
  literal reaches lowering that the frontend could not adjudicate (an imported
  struct with no import context, §3.4), which is precisely the fail-closed case
  it exists for.

### 3.3 What may be a default: constant expressions only

**Recommended: restrict Phase-1 defaults to self-contained constant
expressions.** Concretely, the accepted forms are:

- integer, float, string, and boolean literals;
- `null`;
- a unary `-` applied to a numeric literal.

Everything else — identifiers, calls, field access, arithmetic, array literals,
struct literals, enum constructors — is rejected at typecheck with `E0312`.

The backend does not *force* this restriction, and the proposal should not
claim it does. Verified: the parameter-default path passes its default straight
to `lower_expression`
(`core_call_lowering.sfn:510-512`), whose first parameter is
`expression: string` — native-IR expression text
(`compiler/capsules/codegen-llvm/src/expression_lowering/native/core_expression.sfn:89`).
Field defaults can reuse that machinery verbatim. So the restriction is a
**frontend policy choice**, made for three reasons:

1. **Scope capture.** `lower_expression` takes the enclosing `bindings` and
   `locals`. A field default is lowered at the *literal's* site, not the
   declaration's, so an identifier in a default would resolve against whatever
   locals happen to be in scope where someone else wrote the literal — silently
   different per call site, and catastrophic when a name collides. A constant
   expression has no free names, so the implementation passes empty
   `bindings`/`locals` and the hazard is unrepresentable rather than avoided.
2. **Evaluation order and effects.** An arbitrary-expression default raises
   three questions this proposal would otherwise have to answer: *when* is it
   evaluated (declaration time? literal time? per omission?), *in what order*
   relative to the explicitly-written fields, and *may it carry an effect* —
   can `created_at: int = clock.now()` appear in a struct declaration, and if
   so does every literal of that struct acquire `![clock]`? That last question
   is the serious one: it would make a struct *declaration* an effect-bearing
   construct, which nothing in the effect system currently models (see §4).
   Constants make all three questions vacuous.
3. **Cross-module honesty.** The default crosses a capsule boundary as text in
   `.sfn-asm` (§3.5). A constant's text means the same thing in the consumer's
   module as in the producer's. An expression's text does not — it can name
   producer-module symbols the consumer never imported.

The cost is real and should be stated: `headers: string[] = []` — the single
most-wanted default on `Response` — is **not** expressible under this
restriction, because an empty array literal is a heap allocation rather than an
LLVM constant. That is a deliberate Phase-4 follow-on (§5.4), not an oversight;
it needs a decision about whether each omission allocates a fresh empty array
(the answer should be yes, per semantic 4) and a check that the allocation is
emitted into the literal's own lowering, not hoisted.

Const-foldable arithmetic (`2 * 1024`) is likewise **excluded from Phase 1**:
it requires a const-evaluator the frontend does not have, and the workaround
(write the folded value) is one keystroke. `null` **is** included, because it is
a first-class literal for every nullable annotation and is the natural default
for an added `T?` field — the single most common additive change after a scalar.

### 3.4 Where the required-field check lives: `E0311` in typecheck

The missing-required-field error moves to
`compiler/capsules/analyzer/src/typecheck/expression_walk.sfn:325-354`, the
`Struct` branch of `walk_expression`, which today iterates only
`expression.fields` (the literal's) and so can never observe an absence.

The declaration is already reachable from there. `_struct_field_expected_type`
(`compiler/capsules/analyzer/src/typecheck/struct_literal_fn_values.sfn:130-152`)
walks `ctx.declarations` for a `StructDeclaration` of the literal's type and
returns the named field's annotation; `_imported_struct_field_expected_type`
(`:164-186`) does the same over `ctx.imported_structs`. The new check needs the
*inverse* lookup — the declared field **list**, not one field's type — so the
implementation adds a sibling `_struct_declared_fields(type_name, ctx) ->
FieldDeclaration[]?` in the same file, returning `null` when the shape is
unresolvable and the declared list otherwise (local first, imported second,
matching the existing precedence).

Diagnostic shape:

```
E0311: struct literal for `Response` is missing required field `status`
  --> app.sfn:42:13
   = note: fields `status` and `body` have no default and must be given
   = help: add `status: <value>, body: <value>`, or declare a default on the
           field: `status: int = 0;`
```

One diagnostic per literal listing every missing field, not one per field — a
literal of a struct that grew three fields should not produce three errors.

**Two suppression conditions, both already precedented in this function.**

- **Unresolvable shape.** `expression_walk.sfn:320-324` already computes
  `no_import_context && shape_unresolvable && name_is_imported` to defer the
  fn-value verdict (SFN-1161) when the literal names an imported type whose
  declaration is not loaded — the state `sfn check` is in for a bare file with
  no built artifacts. `E0311` takes the same deferral: if
  `_struct_declared_fields` returns `null`, emit nothing and let the literal
  reach `E1002` at lowering, which has the full `combined_structs` set
  (`compiler/capsules/codegen-llvm/src/lowering/lowering_core/mod.sfn:255`).
  This is why `E1002` must stay.
- **Generic structs.** The existing `is_generic_struct` guard in the same loop
  suppresses element-type checking because `.sfn-asm` carries no struct type
  parameters. Field *presence* is independent of type substitution, so `E0311`
  does **not** need that guard — but the implementer must confirm the declared
  field list for a generic struct is complete rather than erased before relying
  on it.

**Field-value type checking.** The default expression is walked at the
declaration with `ctx_with_expected_type(ctx, field.type_annotation)`, so an
ill-typed default (`count: int = "x"`) is caught by the existing mismatch
diagnostics (`E0309`/`E0310` family) rather than a new code.

**E-code allocation.** `E03xx` — *duplicate symbols / type conflicts*, home
`typecheck*.sfn` (`docs/style-guide.md:221-228`) — is the right range: a
literal whose field set does not match its declaration is a type-shape
conflict, sibling to `E0310` (array element type mismatch). A repo-wide
`rg -o --no-filename '[EW][0-9]{4}' compiler runtime docs site capsules` shows
`E0301`–`E0310` in use and nothing above, so this proposal allocates:

| Code | Meaning | Emitted at |
|---|---|---|
| **`E0311`** | struct literal omits a field that has no default | `typecheck/expression_walk.sfn` (`Struct` branch) |
| **`E0312`** | struct field default is not a constant expression | `typecheck_types/declaration_and_statement_checks.sfn::check_struct_fields` (`:42-62`) |

The `docs/style-guide.md` row lands with the implementing PR; the reservation
is recorded in `docs/proposals/README.md` so other drafts skip these two.

### 3.5 Cross-module carry

A default declared in `sfn/http` must reach a consumer capsule's lowering,
exactly as a parameter default does today (§2.3). Five sites, all mirroring the
parameter chain:

| # | Change | Site |
|---|---|---|
| 1 | `FieldDeclaration.default_value: Expression?` | `compiler/capsules/syntax/src/ast.sfn:272-277`; set at the two construction sites `parser/declarations/structs.sfn:223-228` and `parser/declarations/enums.sfn:235-240` (the latter always `null` in Phase 1, §3.7) |
| 2 | `NativeStructField.default_value: string?` | `compiler/capsules/ir/src/native_ir.sfn:133-137` |
| 3 | `.sfn-asm` write — append ` = <expr>` to the struct field line | `compiler/capsules/codegen/src/emit_native_format.sfn:632-637` (`format_field`), mirroring `:605-606` for parameters |
| 4 | `.sfn-asm` read | `compiler/capsules/ir/src/native_ir_utils_parse.sfn:595-633` (`parse_struct_field_line`) |
| 5 | Artifact → frontend AST reconstruction, so `E0311` knows an imported field is defaulted | `compiler/capsules/analyzer/src/typecheck_imports.sfn:178-196` (`field_declaration_from_native` / `field_declarations_from_native`) |

**Site 4 is the one with a trap.** `parse_struct_field_line` currently strips an
optional `mut ` prefix and then splits on the *first* `": "`, assigning
everything after it to `type_annotation`
(`native_ir_utils_parse.sfn:604-629`). Appended naively, `body_addr: int = 0`
parses as a field of type `"int = 0"`. The fix is the parameter parser's
discipline (`:753-772`): after the type separator, split the remainder on the
first `=`, left side is the annotation, right side is the default text. That is
safe in both directions — a type annotation can never contain `=`, and only the
*first* `=` is consumed, so a default whose text contains `==` survives intact.
The legacy ` -> ` separator branch (`:604-620`) needs the same treatment.

**The default deliberately rides the `.struct` field line, not the `.layout`
line.** `NativeStructLayoutField` is parsed from a keyed-token line
(`.layout field <name> type=<T> offset=N size=N align=N`) whose type value
absorbs unrecognized trailing tokens by design — `_nir_layout_type_may_continue`
exists because "type annotations may contain whitespace" (SFN-532,
`compiler/capsules/ir/src/native_ir_utils_layout.sfn:188-192`). Adding a
`default=` token there would be parsed as part of the type on any older reader
and is a worse round-trip risk for zero benefit.

**Site 4 → lowering.** `StructFieldInfo`
(`compiler/capsules/codegen-llvm/src/types.sfn:317-323`) gains
`default_value: string?`. It is built in `build_type_context` from
`layout.fields` (`compiler/capsules/codegen-llvm/src/type_context.sfn:204-232`),
which has no defaults — but the same loop holds `definition`, the `NativeStruct`
whose `fields: NativeStructField[]` does. The implementation looks the default
up by name from `definition.fields` while walking `layout.fields`. Imported
structs arrive through the same path: `combined_structs` is the module's own
structs extended with `imported_structs`
(`lowering/lowering_core/mod.sfn:255`), and `build_type_context` takes
`NativeStruct[]` (`type_context.sfn:178`), so a dependency's declared defaults
are present with no additional plumbing.

### 3.6 The lowering branch

`core_literals_lowering.sfn:838-856` — the `else` of the
`literal_index >= 0` test — becomes:

```
if the declared field carries a default:
    lower the default text with EMPTY bindings and EMPTY locals,
      expected_type = expected.llvm_type
    on success: use that operand for the insertvalue
    on failure: push fatal E1002 (the default itself did not lower)
otherwise:
    push fatal E1002 as today  ← unchanged, including wording
```

Empty `bindings`/`locals` is the mechanical enforcement of §3.3's scope-capture
argument: even if a non-constant default somehow reached the backend, it cannot
silently bind to a local at the literal's site — it fails to lower and reports
`E1002`. The string-constant accumulation and `temp_index`/`lines` threading
follow `core_call_lowering.sfn:510-518` exactly.

### 3.7 `sfn fmt`, the Sailfin source emitter, and enum-variant fields

**`sfn fmt` almost certainly needs no printer change, and the reason is worth
recording because it contradicts the obvious assumption.** `sfn fmt` is not an
AST pretty-printer: `format_source` lexes the source and re-emits a classified
*token stream* (`compiler/src/tools/fmt/mod.sfn:14-35`). There is no
parameter-default printer in `compiler/src/tools/fmt/` to mirror — grep finds no
`default_value` reference under that directory at all — because a parameter's
`= 7` flows through as an operator token and an operand token. A field's `= 0`
will do the same. The one heuristic that inspects struct bodies classifies them
by the presence of colons *and* semicolons to refuse inlining
(`compiler/src/tools/fmt/emitter.sfn:42-48`); an added `=` does not perturb it.

This is a prediction, not a verified fact, and the implementer must prove it:
the Phase-2 acceptance includes a `sfn fmt --write` / `--check` round-trip over
a fixture carrying defaults in single-line, multi-line, `mut`, and trailing-
comma field forms. If fmt does mangle the spacing, that is a fmt bug to fix in
`emitter.sfn`, not a reason to change the syntax.

The **AST-driven** Sailfin emitter is a different matter and does need the
print: `format_field` at
`compiler/capsules/codegen/src/emitter_sailfin.sfn:559-565` must gain the
` = <expr>` tail its sibling `format_parameter` already has at `:599-600`.

**Enum-variant payload fields.** `parse_enum_variant_field` constructs the same
`FieldDeclaration` (`parser/declarations/enums.sfn:235-240`), and
`EnumVariantInfo.fields` is a `StructFieldInfo[]`
(`compiler/capsules/codegen-llvm/src/types.sfn:339`, populated at
`type_context.sfn:259`), so the machinery would carry variant defaults for
nearly free.

**Recommendation: do not enable them in Phase 1.** The enum-variant literal path
is currently *unsound in the opposite direction* — SFN-913 (`Backlog`, High,
`type:bug`/`area:lowering`) records that an enum-variant literal with a missing
field emits **no store at all**, leaving the payload slot holding whatever the
`alloca` contained, with the advisory at
`core_literals_lowering.sfn:1309` carrying no `[fatal]` marker so nothing trips
on it. Layering an opt-in "omission is legal" feature onto a path where omission
is already silently accepted and reads back stack residue would make the
unsound case indistinguishable from the intended one. **SFN-913 is a
predecessor of enum-variant defaults**, not a parallel concern: once it lands,
the enum path has the same fail-closed gate as the struct path and the default
branch drops in identically (§5.4, Phase 5).

In Phase 1 the enum variant-field parser is left unchanged, so `= <expr>` there
fails to parse through the existing variant-field failure path. That is honest
but produces a poor message; see §10 for the open question of whether to spend a
third E-code on a targeted one.

### 3.8 What does not change

- Struct layout, field order, size, alignment, and the boxed-`%T*` ABI.
- `E1002`'s wording, severity, and the e2e gate at
  `compiler/tests/e2e/lowering_fabricated_value_gate_test.sfn:112-114`. Its
  fixture struct has no defaults, so it stays green verbatim.
- `default_return_literal` (`expressions_helpers.sfn:153-161`) — unchanged, and
  still unreachable from any defaulted field.
- Extra/unknown fields in a literal. Rejecting those is a separate gap
  (`E1012`'s neighbourhood at `core_literals_lowering.sfn:1326` handles the enum
  case) and is deliberately out of scope.
- The `mut` axis. A default says nothing about mutability, and interacts with
  SFEP-0075's mutability floor only in that a defaulted `let`-bound struct is
  still immutable.

## 4. Effect & capability impact

**None, and that is a design constraint rather than an observation.**

The constant-expression restriction (§3.3) is what makes it none. A constant
carries no effect, so a struct declaration remains an effect-free construct and
a struct literal's effect set remains exactly the union of its explicitly
written field expressions — unchanged from today. No function signature gains an
effect because a struct it constructs grew a default.

The alternative is worth naming so a future extension does not walk into it
accidentally: an arbitrary-expression default such as
`created_at: int = clock.now()` would make **the struct declaration** an
effect-bearing construct, and every literal of that struct that omitted the
field would acquire `![clock]` transitively — a capability that appears in a
caller's signature because of a field it never mentioned. That inverts the
effect system's core promise, which is that reach is *derived from what the code
does* and readable at the site that does it. Any future proposal to widen §3.3
beyond constants must answer this before anything else; the capability manifest
(SFEP-0016) is derived from exactly these edges.

Capsule manifests, `E0402`/`E0403`, and the seal are untouched.

## 5. Self-hosting impact

### 5.1 The compiler cannot use this feature until a seed carries it

`compiler/src/` and `compiler/capsules/` are compiled by the **pinned seed**
during the first pass of `sfn dev bootstrap build`. A field default written in
compiler source would be a parse error to any seed predating the capability.
**Compiler source must therefore not use field defaults until a release
carrying Phase 2 has been cut and `bootstrap.toml [seed].version` advanced to
it.** The feature is additive for everything else — an old seed compiling code
with no defaults behaves identically — but it is not additive for the compiler's
own sources, and that is the one hard sequencing rule in this proposal.

This is a *deferral*, not a seed-blocker in the
`.claude/rules/seed-dependency.md` sense: no phase below requires the capability
to be present in the pinned seed in order to land.

### 5.2 The `sfn/http` consumer bundles — there is no seed gate

Verified against `.claude/rules/seed-dependency.md`'s runtime carve-out:

- `capsules/sfn/http` is a **workspace member** (`workspace.toml:42-43`), not a
  `runtime/capsule.toml` `sfn-sources` entry — the runtime's declarative source
  list is `sfn/*` plus `prelude.sfn`. The carve-out (runtime source calling a
  capability the seed lacks) therefore does not apply.
- The compiler does **not** depend on `sfn/http`: `compiler/capsule.toml`'s
  `[dependencies]` lists `sfn/syntax`, `sfn/ir`, `sfn/analyzer`, `sfn/codegen`,
  `sfn/codegen-llvm`, `sfn/runtime-native`, `sfn/cli`, `sfn/strings`,
  `sfn/crypto` — no `sfn/http`. The CLI reaches HTTP through `extern fn`
  precisely to avoid that edge (`compiler/src/cli/commands/cmd_shared.sfn:149`,
  SFN-496). So the pinned seed never compiles `sfn/http` during bootstrap.
- `sfn/http` is exercised by e2e tests run under the freshly built
  `build/bin/sfn` (`compiler/tests/e2e/serve_loopback_test.sfn`,
  `http_capsule_serve_gate_test.sfn`, and siblings).

Therefore `sfn dev bootstrap build` builds the new compiler from the old seed,
and **that fresh compiler compiles the `Response` defaults in the same pass**.
Capability and consumer bundle into one PR; splitting them would manufacture a
seed cut for a single consumer, which
`.claude/rules/seed-dependency.md` says not to do.

### 5.3 Phasing

Three phases to ship the feature, two follow-ons. Each phase is a valid
self-hosting compiler.

**Phase 1 — `E0311` in typecheck. No syntax change.** Adds
`_struct_declared_fields` and the missing-field check with its two suppression
conditions. Ships value alone: it closes SFN-392's primary scope, moves a
build-only failure to rung 1 of the validation ladder, and does not depend on
anything below.

*Fallout risk is low but must be measured, not assumed.* Because `E1002`
already fails the build closed, any first-party struct literal that is actually
*built* cannot be omitting a field today — so the in-tree fallout should be
near zero. The residual risk is a literal on a path that is checked but never
lowered. `sfn check compiler/src` (~5 min, rung 1) measures it before
`sfn dev bootstrap build` is spent. SFN-392's warning to "budget for first-party
fallout" was written before `E1002` was made fatal and is, on current main,
likely over-cautious — but verify rather than assume.

*Stage1 items:* type-checks, regression coverage, self-hosts, `fmt --check`,
spec note that omission is an error. No parse/emit/lower change.

**Phase 2 — the capability, bundled with the `sfn/http` consumer (§5.2).**
Parse, AST slot, `E0312` const-form check, default type-check against the field
annotation, `.sfn-asm` emit + re-parse, `typecheck_imports` reconstruction,
`StructFieldInfo.default_value`, the lowering branch, `emitter_sailfin`
`format_field`, `fmt` round-trip proof, and in the same PR: `Response`'s
`body_addr: int = 0; body_len: int = 0;`, the retraction of the warning comment
at `capsules/sfn/http/src/types.sfn:36-41`, and the **Breaking change**
admonition at `standard-library.md:1020`.

*Stage1 items:* all eight. This is the phase that must clear the full bar,
including `sfn dev verify` — it touches parse, typecheck, emit, IR, and
lowering, and it is a structural change requiring
`sfn dev bootstrap build --clean-tree`.

Whether Phase 2 is one issue or two is a decomposition call the grooming pass
should make with `.claude/rules/seed-dependency.md` in hand. The recommendation
here is **one issue**: the `sfn/http` change is three lines plus doc retractions
and has no independent value, and the frontend/backend halves cannot be split
either — a parse-and-carry PR that does not lower is "parsed but not enforced,"
which CLAUDE.md says is not shipped.

**Phase 3 — seed advance, then compiler adoption (optional).** After a release
carrying Phase 2 and a `bootstrap.toml` seed bump (automatic per
`cadence-seed-pin.yml`), compiler source may itself use defaults. Nothing
requires this; it is listed so §5.1's constraint has a visible endpoint. Good
first candidates are the compiler's own wide structs where a field was appended
and every literal had to be touched — `SourceSpan?` slots on `Statement`
variants are the canonical case (SFN-536's fallout, which is what surfaced
SFN-913).

### 5.4 Follow-ons, explicitly not in this proposal's shipping scope

- **Phase 4 — non-scalar constant defaults**, starting with the empty array
  literal `[]` (§3.3). Needs a decision on per-site allocation and a lowering
  path that emits the allocation into the literal's own block.
- **Phase 5 — enum-variant payload field defaults**, gated on **SFN-913**
  (§3.7).

### 5.5 Files affected, by pipeline stage

| Stage | Files |
|---|---|
| Parse / AST | `compiler/capsules/syntax/src/ast.sfn:272-277`; `compiler/capsules/syntax/src/parser/declarations/structs.sfn:200-235` |
| Typecheck | `compiler/capsules/analyzer/src/typecheck/expression_walk.sfn:325-354`; `compiler/capsules/analyzer/src/typecheck/struct_literal_fn_values.sfn` (new `_struct_declared_fields`); `compiler/capsules/analyzer/src/typecheck_types/declaration_and_statement_checks.sfn:42-62` (`E0312`); `compiler/capsules/analyzer/src/typecheck_imports.sfn:178-196` |
| Emit (`.sfn-asm`) | `compiler/capsules/codegen/src/emit_native_format.sfn:632-637`; `compiler/capsules/codegen/src/emitter_sailfin.sfn:559-565` |
| Native IR | `compiler/capsules/ir/src/native_ir.sfn:133-137`; `compiler/capsules/ir/src/native_ir_utils_parse.sfn:595-633` |
| LLVM lowering | `compiler/capsules/codegen-llvm/src/types.sfn:317-323`; `compiler/capsules/codegen-llvm/src/type_context.sfn:204-232`; `compiler/capsules/codegen-llvm/src/expression_lowering/native/core_literals_lowering.sfn:838-856` |
| Consumer | `capsules/sfn/http/src/types.sfn:21-59` |
| Docs | `site/src/content/docs/docs/reference/spec/03-declarations.md` §3.3; `site/src/content/docs/docs/reference/grammar.md:65`; `site/src/content/docs/docs/reference/standard-library.md:1020`; `docs/style-guide.md` E-code table |

## 6. Alternatives considered

**(a) Zero-fill omitted fields.** Make the lowering behaviour official: an
omitted field gets `default_return_literal(llvm_type)`. **Rejected** — this *is*
the SFN-527/SFN-392 soundness hole, and SFN-392's reproducer shows exactly why:
a `boolean` the author meant to compute became `i1 false`, the computed value
went dead, and the program printed the wrong answer with `sfn check` green and
the build green. The distinction this proposal turns on (§3.2) is that a value
must have an author. Zero-fill has none.

**(b) Spread / functional update — `Response { ..base, status: 404 }`.**
A genuinely good feature that Sailfin should probably have, and it **complements
rather than replaces** this one: it solves "derive a value from an existing
value", which is a different problem from "write a value from scratch". It does
not help the motivating case at all — a handler constructing a fresh `Response`
has no `base` to spread, and inventing a `Response.empty()` to spread from is
just a builder (option c) with extra syntax. It also depends on struct value
semantics being settled (SFEP-0075), which is still `Draft`. Worth its own SFEP;
not a substitute for this one.

**(c) Sealed / `#[non_exhaustive]`-style builder-only structs.** Mark a struct
as non-literal-constructible from outside its defining capsule, forcing
consumers through builders; then adding a field is never breaking because no
external literal exists. This is Rust's actual answer, and it is a coherent
one — but it is a *harder* break than the status quo, not a softer one: adopting
it on `Response` would invalidate every existing literal immediately and
permanently, including the correct five-field ones. It also imposes a builder
API on every struct author for a problem that a default solves declaratively.
**Recorded as possible future work**, orthogonal to this proposal: a sealed
struct could still carry field defaults for its own builders' use.

**(d) Do nothing — accept that adding a public field is breaking.** This is
Rust's position for non-`#[non_exhaustive]` structs and it is defensible; the
honest cost is: every stdlib struct is frozen at 1.0, or every addition is a
major version. For a language whose pitch is a machine-checked contract about
what code can reach and what it costs, freezing `Response` — the type every HTTP
handler in the ecosystem returns — the first time it needs a field is a bad
trade. It also leaves the `check`-green/build-red divergence of §2.2 in place,
which is a defect regardless of the feature decision. Phase 1 fixes that
divergence and is worth landing even if Phases 2+ are rejected.

**(e) `@default(0)` decorator instead of `= 0`.** Decorators exist
(SFEP-0023), so this needs no grammar change. **Rejected** on CLAUDE.md's
boring-syntax test: it is a second spelling for a concept the language already
spells `= expr`, it reads worse, it is unfamiliar to every language a user
arrives from, and an LLM with no `.sfn` training data will write `= 0` anyway.

**(f) Make every field optional, defaulting to the type's zero.** The
TypeScript-ish "all fields optional" shape. **Rejected** — it is (a) with a
nicer name, and it additionally destroys the ability to say "this field is
required", which is most of what a struct declaration is for.

## 7. Stage1 readiness mapping

Phase 1 (`E0311` only):

- [ ] Parses — n/a, no syntax change
- [ ] Type-checks / effect-checks — the deliverable
- [ ] Emits valid `.sfn-asm` — unchanged
- [ ] Lowers to LLVM IR — unchanged (`E1002` retained)
- [ ] Regression coverage
- [ ] Self-hosts
- [ ] `sfn fmt --check` clean
- [ ] Documented in the spec chapter (03-declarations §3.3)

Phase 2 (the capability + `sfn/http`):

- [ ] Parses — `= <expr>` in a struct field declaration
- [ ] Type-checks / effect-checks — `E0312` const form; default type-checked
      against the field annotation; effect impact is none by construction (§4)
- [ ] Emits valid `.sfn-asm` — field line carries ` = <expr>`, round-trips
- [ ] Lowers to LLVM IR — defaulted omission materializes the author's value
- [ ] Regression coverage — §8
- [ ] Self-hosts — `sfn dev bootstrap build --clean-tree` (structural)
- [ ] `sfn fmt --check` clean — including the round-trip proof of §3.7
- [ ] Documented in the spec chapter + grammar + standard-library retraction

`docs/status.md` is reconciled separately by `/status-sweep`.

## 8. Test plan

**Unit — typecheck (Phase 1):**
`compiler/tests/unit/typecheck_struct_literal_missing_field_test.sfn`
- `E0311` on a literal omitting one required field, with the literal's span.
- One diagnostic listing **both** names when two are omitted, not two
  diagnostics.
- Clean on a complete literal, and on a literal whose fields are written out of
  declaration order.
- Silent (deferred to `E1002`) when the struct shape is unresolvable and the
  name is imported — the `expression_walk.sfn:320-324` condition.

**Unit — typecheck (Phase 2):**
`compiler/tests/unit/typecheck_struct_field_default_test.sfn`
- No `E0311` when the omitted field declares a default.
- `E0312` on `x: int = some_fn()`, on `x: int = other_field`, and on
  `x: int = 2 * 1024`.
- No `E0312` on each accepted constant form, including `null` for a `T?` field
  and `-1` for an `int` field.
- Existing mismatch diagnostic on `count: int = "x"`.

**Unit — IR round-trip (Phase 2):**
`compiler/tests/unit/native_ir_struct_field_default_test.sfn`
- `parse_struct_field_line("body_addr: int = 0")` yields
  `type_annotation == "int"` and `default_value == "0"` — the §3.5 trap.
- The same for a `mut ` prefix, for the legacy ` -> ` separator, for a string
  default containing a space, and for a field with no default (`default_value`
  stays `null`).
- Emit → parse round-trip preserves the default text exactly.

**Integration — lowering (Phase 2):**
`compiler/tests/integration/lowering_struct_field_default_test.sfn`
- The `insertvalue` for an omitted defaulted field carries the declared
  constant, not `default_return_literal`'s zero — assert on the emitted IR,
  using a default whose value differs from the type's zero (`flag: boolean =
  true`, `n: int = 7`) so the two are distinguishable.
- An explicit value overrides the default.
- `E1002` still fires, unchanged, for a field with no default.

**E2E — behaviour and cross-module (Phase 2):**
`compiler/tests/e2e/struct_field_default_test.sfn`
- Build and run a program whose struct has a `true`-valued boolean default and a
  non-zero int default; assert the observed values.
- **Cross-capsule:** a program importing a struct with defaults from another
  capsule omits a defaulted field and gets the declared value — the §3.5
  artifact path, which no unit test exercises.
- `sfn check` and `sfn build` agree on a partial literal in both directions
  (rejected together for a non-defaulted field; accepted together for a
  defaulted one). Sibling to
  `compiler/tests/e2e/check_build_agree_module_global_test.sfn`.

**Formatter (Phase 2):** `sfn fmt --write` then `--check` round-trip over a
fixture carrying defaults in single-line, multi-line, `mut`, and trailing-comma
field forms (§3.7).

**Unchanged, must stay green:**
`compiler/tests/e2e/lowering_fabricated_value_gate_test.sfn:112-114` and the
`sfn/http` serve suite (`serve_loopback_test.sfn`, `serve_tls_loopback_test.sfn`,
`http_capsule_serve_gate_test.sfn`, `tls_large_body_test.sfn`).

**Verification commands:**

```
sfn check compiler/src                                   # rung 1, Phase 1 fallout scan
build/bin/sfn test compiler/tests/unit/typecheck_struct_literal_missing_field_test.sfn
build/bin/sfn test compiler/tests/unit/typecheck_struct_field_default_test.sfn
build/bin/sfn test compiler/tests/unit/native_ir_struct_field_default_test.sfn
build/bin/sfn test compiler/tests/integration/lowering_struct_field_default_test.sfn
build/bin/sfn test compiler/tests/e2e/struct_field_default_test.sfn
build/bin/sfn test compiler/tests/e2e/lowering_fabricated_value_gate_test.sfn
sfn dev bootstrap build --clean-tree                     # structural (Phase 2)
sfn fmt --check <touched files>
sfn dev verify                                           # Phase 2 ship gate only
```

## 9. References

- **SFN-392** — reject struct literals that omit required fields (the
  soundness half; its **Out:** section is quoted in §2.4). `Backlog`, High.
- **SFN-527** — fail closed where a null operand is replaced by a default; the
  issue behind `E1002` and the gate at
  `core_literals_lowering.sfn:838-856`.
- **SFN-913** — enum-variant literal with a missing field leaves the payload
  slot uninitialized. Predecessor of §5.4 Phase 5. `Backlog`, High.
- **SFN-1161** — imported-struct literal fn-value deferral; the precedent for
  `E0311`'s unresolvable-shape suppression
  (`expression_walk.sfn:320-324`).
- **SFEP-0075** — Struct Value Semantics and the Mutability Floor
  (`docs/proposals/0075-struct-value-semantics.md`). Independent of this
  proposal; its `E0919`–`E0921` allocation is in a different range.
- **SFEP-0041** — expected-type context in the typecheck walk; the mechanism
  that type-checks a default against its field annotation.
- **SFEP-0019** — `sfn/http`, the motivating consumer.
- **SFEP-0039** — nominal object model; why a struct literal is the sanctioned
  bare-object-literal target.
- `.claude/rules/seed-dependency.md` — the bundle-vs-split call applied in §5.2.
- Spec: `site/src/content/docs/docs/reference/spec/03-declarations.md` §3.2
  (default parameters, `:66`) and §3.3 (structs);
  `site/src/content/docs/docs/reference/grammar.md:65,111`.
- Prior art: Rust `#[derive(Default)]` + `..Default::default()` (chose the
  spread form and the sealed form, not field defaults); C++20 default member
  initializers; Swift default property values; Kotlin/Python/TypeScript default
  parameters and property initializers — all spelled `= expr`.

## 10. Open questions for the design gate

1. **The enum-variant parse message (§3.7).** Phase 1 leaves
   `parse_enum_variant_field` unchanged, so a default written on a variant
   payload field fails through the generic variant-field parse failure with a
   message that does not say why. Is a third E-code
   ("field defaults are not supported on enum-variant payload fields —
   SFN-913") worth allocating for a diagnostic that Phase 5 will delete, or is
   the poor message acceptable for the interval? The alternative — parse it and
   reject it in typecheck — costs the same code and reads better, but puts a
   temporary rejection in the frontend.
2. **`null` as a default (§3.3).** Included on the argument that an added `T?`
   field is the most common additive change. It is also the one accepted form
   whose materialized value is identical to what `default_return_literal` would
   have fabricated — so for that one case, the author's intent and the
   compiler's guess coincide. This is harmless (provenance still differs, and
   `E1002` still fires when no default is declared), but a reviewer who wants
   the provenance distinction to be *observable* in every case may prefer to
   exclude `null` in Phase 1.
3. **Generic structs (§3.4).** `E0311` should not need the existing
   `is_generic_struct` guard, since field presence is independent of type
   substitution — but the implementer must confirm the declared field list for a
   generic struct is complete rather than erased in `ctx.declarations` and
   `ctx.imported_structs` before relying on it. If it is erased for imported
   generics, `E0311` suppresses there and `E1002` remains the backstop.
4. **Is Phase 1 worth landing independently of Phase 2?** The recommendation
   here is yes — it fixes the `check`/build divergence, which is a defect on its
   own terms — but it does briefly make the additive-field problem *louder*
   (a friendlier error, still an error) before Phase 2 makes it go away. A
   reviewer may prefer to land both in one cycle.
