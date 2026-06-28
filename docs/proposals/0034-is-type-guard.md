---
sfep: 0034
title: Structured, Enforced `x is T` Type-Guard Operator
status: Accepted
type: language
created: 2026-06-28
updated: 2026-06-28
author: "agent:compiler-architect; agent:Sailbot (as-built revision); human review"
tracking: "#1753"
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0034 — Structured, Enforced `x is T` Type-Guard Operator

> Design record for issue #1753 (epic #1180, effect-system hardening). Related:
> SFEP-0008 (effect validation as build gate). The v1 slice (named-enum
> type-guards) is implemented end-to-end and self-hosts; the broader surface
> (inline unions, primitives, else-complement narrowing) is deferred to the
> fast-follows listed in §3.9 — hence `Accepted`, not `Implemented`.

## 1. Summary

Promote `x is T` from a parsed-but-unenforced construct — it degraded to
`Expression.Raw`, contributed zero effects, and performed zero narrowing — into
a **structured, enforced** type-guard operator. We add an `Is` expression node
(modelled on the existing `as`→`Cast` path), make the effect checker walk its
operand, make the formatter round-trip it, and lower `x is T` on a named `enum`
operand to the enum's discriminant tag test. Crucially, the then-branch
**narrows** the guarded operand to the tested variant — reusing the LLVM
lowering's existing `narrowed_variant` machinery (the same flow-sensitive
refinement that powers `if x.variant == "V"`), so member access inside the
branch resolves against the narrowed variant. `if input is Text { input.value }`
now works, reached through an ordinary `if`/`else`.

## 2. Motivation

`x is T` is the conventional, boring type-guard form (TypeScript `x is T`
predicates, Python `isinstance`, Rust `matches!`). In Sailfin it was a trap:

- `is` was **not a keyword or soft keyword** — it lexed as an `Identifier`.
- There was **no `is` arm** in `parse_postfix_chain` — the postfix loop broke on
  the non-`Symbol` `is` token, leaving `is T` unconsumed, and the leftover-token
  guard forced the whole expression into the `Expression.Raw` fallthrough.
- A `Raw` condition contributes **zero effects** (since #1186) and **zero
  narrowing** — so an effectful operand (`readFile() is T`) reached codegen
  effect-blind (the exact headline-integrity gap epic #1180 is closing), and the
  branch bodies saw the operand at its un-narrowed type.

Per the project principle "don't ship unfinished safety claims," we either remove
the construct or finish it. This SFEP finishes it for the canonical sum type
(named enums), the case where a type guard earns its keep.

## 3. Design

### 3.1 Lexing

No lexer change. `is` is recognized at parse time via
`identifier_matches(token, "is")`, exactly as `as` is and import-aliases are.
Keeping it a soft keyword (not reserved) preserves identifiers named `is` and
keeps the old seed — which lexes `is` as an identifier — compatible (see §5).

### 3.2 Parsing

An `is` arm in `parse_postfix_chain` (`parser/expressions.sfn`), placed right
after the `as` arm, builds `Expression.Is { operand, target_type }`. The target
is read by `read_is_target` — a narrower sibling of `read_cast_target` that
accepts **only** a named type with an optional generic argument list (`Foo`,
`Foo<X, Y>`): no pointer prefix (`* T`) and no fn-pointer (`fn (A) -> B`) forms,
which are meaningless as a runtime type predicate. A non-identifier target falls
through to a parse failure → `Raw`.

**Precedence.** Placing `is` in the postfix loop makes it postfix-tight, like
`as`. `x is T && y` parses as `(x is T) && y` because `&&` is a `Symbol` handled
by the lower binding-power climb, which terminates the postfix chain first.
`!(x is T)` and `x is T == z` likewise parse with the guard innermost. We do not
introduce a bespoke infix precedence tier (it would diverge from `as` for no
realistic gain).

### 3.3 AST

One variant added to `Expression` (`ast.sfn`), beside `Cast`:

```sfn
Is { operand: Expression, target_type: TypeAnnotation },
```

Field names `operand` / `target_type` match `Cast`, so they share the enum's
per-name field slots (no GEP collision — see the `Assignment` field-name note).
`TypeAnnotation { text: string }` carries the target type verbatim.

### 3.4 Effect checking

An `Is` arm in `collect_effects_from_expression` (`effect_checker.sfn`),
identical to the `Cast`/`Unary` arms, recurses into `operand` only:

```sfn
if expression.variant == "Is" {
    return collect_effects_from_expression(expression.operand, imports);
}
```

The target type carries no effect; the operand is the effectful surface. This
closes the effect-blind hole: `readFile() is T` now surfaces `![io]`. The
typecheck `walk_expression` gains a matching `Is` arm that recurses into the
operand so inner diagnostics (undefined symbols, fn-value misuse, parse-error
nodes) still fire.

### 3.5 Narrowing model (as built — reuse the existing machinery)

The drafted design proposed adding a `narrowed_type`/`declared_type` field to the
typecheck `SymbolEntry`. **Implementation discovery superseded that plan:** the
typecheck pass tracks names only (`SymbolEntry` has no type field) and performs no
expression-type inference (#829), so a typecheck-level narrowing slot would have
**no consumer** — nothing in `sfn check` reads a refined type. Meanwhile the LLVM
lowering **already implements flow-sensitive narrowing**: a `ParameterBinding` /
`LocalBinding` carries a `narrowed_variant` field, and `lower_if_instruction`
already narrows a guarded operand in the then-branch for a condition of the exact
shape `<base>.variant == "<V>"` (parsed by `_parse_variant_guard`), which
`lower_enum_member_access` then consumes to resolve `<base>.field` against variant
`V`.

So `is` narrowing **reuses that machinery** rather than building a redundant
parallel substrate in typecheck:

1. `_parse_is_guard` (in `instructions_if.sfn`) recognizes the formatted guard
   `(base) is Variant` — stripping the operand's enclosing parens, requiring a
   simple-identifier base and a simple-identifier variant — and returns the same
   `_VariantGuard { base, variant }` the `.variant ==` form produces.
2. `lower_if_instruction` tries `_parse_variant_guard` first, then falls back to
   `_parse_is_guard`. Either way the existing then-branch overlay
   (`_narrow_locals_for_variant` / `_narrow_bindings_for_variant`) sets
   `narrowed_variant` for the guarded operand, and `_restore_narrowing` clears it
   after the branch so it does not leak.

The result: `if input is Text { input.value }` narrows `input` to `Text` in the
then-branch with **zero new narrowing infrastructure** — it is exactly the
`if input.variant == "Text"` path with an `is` front door.

**Then-branch only.** The existing machinery narrows the then-branch; there is no
else-branch complement narrowing (deferred — §3.9). **Simple-identifier operand
only** (the existing restriction); a member/call operand lowers and effect-walks
but does not narrow.

### 3.6 Lowering model (named enums in v1)

The condition reaches LLVM lowering as rendered `.sfn-asm` text: the native-IR
formatter (§3.7) serializes `Is` to `(operand) is <type>`, and
`lower_condition_to_i1` lowers it via `lower_expression`. The new pieces:

1. **`parse_is_expression`** (`core_parsing.sfn`) — the lowering shadow re-parser,
   mirroring `parse_cast_expression`: scan for a top-level ` is ` outside
   brackets/strings; split into operand + target type. It **declines** when the
   target carries a top-level (angle-depth-0) whitespace — that means `is` is not
   the outermost operator (`x is T && y`, `x is T == z`), so the dispatcher peels
   the logical/comparison operator first. Generic targets keep their inner spaces
   at angle-depth ≥ 1 and are accepted whole.
2. **Dispatch** in `lower_expression` (`core.sfn`), placed **after** the logical
   (`&&`/`||`) split (so chained guards peel first) but **before** the
   comparison/bitwise finders (so a generic target's `<>` is not mis-split).
3. **`lower_is_expression`** (`core_literals_lowering.sfn`) — lowers the operand,
   resolves its enum from the LLVM type via `find_enum_info_by_llvm_type` (strip a
   pointer suffix for the boxed-struct ABI), resolves the target variant via
   `resolve_enum_variant_info`, extracts/loads the discriminant tag (field 0;
   `getelementptr`+`load` for a pointer operand, `extractvalue` for a by-value
   aggregate), and emits `icmp eq` against the variant's tag — the **same**
   discriminant test `match` emits (`instructions_match_condition.sfn`).

**v1 scope — enum operands.** A **named `enum`** operand is fully supported
(boolean + then-branch narrowing). A **non-enum** operand (inline `string | int`
union, primitive, plain struct) is **not** supported: `lower_is_expression`
returns no value with a `llvm lowering: is on a non-enum value ...` diagnostic.
Because in-branch narrowing of those surfaces (extracting a union payload for an
identifier use) is not wired — the `narrowed_variant` flow is enum-based —
shipping a boolean without the narrowed use would be a half-feature. They are
fast-follows (§3.9). Note: lowering diagnostics are non-fatal in `build`/`run`
(consistent with `cast`/`match` unsupported-case handling), and `sfn check` is
frontend-only, so a non-enum `is` is not statically rejected today — it is a
documented limitation pending expression-type inference (#829).

### 3.7 Formatter

A source-level `sfn fmt` round-trips `x is T` (verified `fmt --check`-stable). The
native-IR formatter (`emit_native_format.sfn`) serializes `Is` to
`(operand) is <type>` — the exact text `parse_is_expression` consumes; the
operand parens are load-bearing so `strip_enclosing_parentheses` recovers an
operand with embedded operators, exactly as the `Cast` formatter does.

### 3.8 Worked example (`examples/advanced/type-guards.sfn`)

```sfn
enum Input {
    Text { value: string },
    Number { amount: int },
}

fn process(input: Input) ![io] {
    if input is Text {
        print("It's a string: {{input.value}}");   // input: Text in this branch
    } else {
        print("It's a number: {{input.amount}}");
    }
}
```

`input is Text` lowers to a tag `extractvalue`/`icmp eq`; the then-branch narrows
`input` to `Text` so `input.value` resolves. Verified output:
`It's a string: Sail` / `It's a number: 42`.

### 3.9 Scope & slicing — ONE PR, deferred fast-follows

v1 (this PR) ships, for **named enum operands**: the structured `Is` node, the
parser arm, effect-walk, formatter round-trip, the enum-discriminant boolean
lowering, and then-branch narrowing via the reused `narrowed_variant` machinery.

**Deferred fast-follows** (file as sub-issues of #1180):
- `is` on **inline unions** (`string | int`) and **primitives** — needs
  union-payload narrowing for in-branch identifier use.
- **Else-branch complement** narrowing.
- **Member/index/call operand** narrowing.
- **`&&`-chained guard** narrowing.
- A **static (frontend) diagnostic** for a non-enum operand — blocked on
  expression-type inference (#829).

**Seed dependency — BUNDLE, no seed cut.** All v1 pieces are compiler-source with
a single consumer (the compiler + the converted example). The old pinned seed
lexes `is` as an identifier and the compiler source contains no `x is T`, so
`make compile` builds the new compiler from the old seed, which then compiles the
converted example in the same self-host pass. No `/pin-seed`.
(`.claude/rules/seed-dependency.md`.)

## 4. Effect & capability impact

`is` is effect-transparent: it requires the union of its operand's effects and
adds none. The change is a **net tightening** — `readFile() is T` previously
parsed to `Raw` and dropped the operand's `![io]`; now the structured `Is` node
forces the operand to be walked and the requirement surfaces. This advances
SFEP-0008 and epic #1180's headline-integrity goal by removing one more
`Raw`-degradation effect hole. No new effects, no capability-manifest change.

## 5. Self-hosting impact

Passes touched, in pipeline order:

- **Lexer** — no change (`is` stays a soft keyword).
- **Parser** (`parser/expressions.sfn`) — `is` postfix arm + `read_is_target`.
- **AST** (`ast.sfn`) — `Is { operand, target_type }` beside `Cast`.
- **Typecheck** (`typecheck.sfn`) — a `walk_expression` `Is` arm (operand
  recursion). **No `SymbolEntry` change** (the drafted field was dropped — see
  §3.5).
- **Effect checker** (`effect_checker.sfn`) — the one-line `Is` operand-passthrough.
- **Formatter** (`emit_native_format.sfn`) — the `Is` serialization arm.
- **LLVM lowering** — `parse_is_expression` (`core_parsing.sfn`), dispatch
  (`core.sfn`), `lower_is_expression` (`core_literals_lowering.sfn`), and
  `_parse_is_guard` + guard-fallback wiring (`instructions_if.sfn`).

**Self-hosting invariant preserved.** The change is **additive** and the old seed
is unaffected: it lexes `is` as an identifier and the compiler source uses no
`x is T`, so `make compile` builds the new compiler from the old seed; that
compiler then compiles the converted example in the same pass. No seed cut.
Verified: `make compile` (exit 0) after the change.

## 6. Alternatives considered

- **Narrowing via a new `SymbolEntry` type field (the drafted model (a)).**
  Rejected on implementation: typecheck has no expression-type inference (#829),
  so a typecheck refinement slot has no consumer; the LLVM lowering already owns
  flow narrowing (`narrowed_variant`). Reusing it is smaller and is the layer
  that actually drives codegen.
- **A side-table narrowing environment.** Rejected — duplicates the binding
  plumbing the lowering already threads.
- **Shipping inline-union / primitive `is` in v1.** Deferred — in-branch payload
  narrowing for unions is not wired and would be a half-feature; the enum case is
  the canonical, fully-working surface.
- **`is` as a reserved keyword.** Rejected per "keywords are expensive"; the soft
  keyword (the `as` precedent) keeps the old seed compatible.
- **A custom infix precedence tier for `is`.** Rejected — diverges from `as` for
  no realistic gain.
- **Multi-type RHS (`x is (A | B)`).** Rejected for v1 — a guard tests one
  variant; multi-type is sugar for an `||` of guards (a follow-up).

## 7. Stage1 readiness mapping

- [x] **Parses** — `is` postfix arm + `read_is_target` produce a structured `Is`
  node (no `Raw` fallthrough).
- [x] **Type-checks / effect-checks** — `walk_expression` `Is` arm + effect-walk
  `Is` arm; effectful operand surfaces its effect (`E0400`).
- [x] **Emits valid `.sfn-asm`** — native formatter serializes `(operand) is
  <type>`; round-trips through `parse_is_expression`.
- [x] **Lowers to LLVM IR** — `lower_is_expression` emits the tag
  `extractvalue`/`getelementptr`+`load` + `icmp eq` for enum-variant targets.
- [x] **Regression coverage** — parser unit, effect-walk integration, and
  build-and-run e2e tests (§8).
- [x] **Self-hosts** — `make compile` (exit 0); old seed compiles the new
  compiler, which compiles the converted example.
- [x] **`sfn fmt --check` clean** — every touched `.sfn` under `compiler/src/`
  and `examples/`.
- [x] **Documented** — `docs/status.md` flips `is` to shipped (enum scope noted);
  spec chapter added; `examples/advanced/type-guards.sfn` rewritten to real `is`.

(Checked for the **v1 enum slice**. The SFEP stays `Accepted` rather than
`Implemented` because the §3.9 fast-follows — unions/primitives, else-complement —
are out of this slice.)

## 8. Test plan

- **`compiler/tests/unit/parser_is_type_guard_test.sfn`** — `x is T` parses to a
  structured `Is` node (operand Identifier, `target_type.text`); generic target
  captured; `x is T && y` parses as `(x is T) && y` (Binary with `Is` left).
- **`compiler/tests/integration/is_effect_walk_test.sfn`** — a pure caller with
  `<effectful call> is <Variant>` is rejected for the missing effect; the same
  body with `![io]` compiles.
- **`compiler/tests/e2e/is_type_guard_test.sfn`** — build and run an enum `is`
  program; assert the then-branch narrowing + member access output (`T:hi` / `N`),
  threading `PATH` / `SAILFIN_TEST_SCRATCH` per `.claude/rules/no-bash-e2e.md`.
- **Self-host** — `make compile` + the full suite; the converted example
  participates in the seedcheck corpus.

## 9. References

- Issue #1753 (this feature); epic #1180 (effect-system hardening).
- SFEP-0008 (`docs/proposals/0008-effect-validation.md`) — effect validation as
  build gate; this SFEP closes one `Raw`-degradation effect hole.
- `.claude/rules/seed-dependency.md` — the bundle decision (no seed cut).
- Key source: `parser/expressions.sfn` (`is` arm, `read_is_target`); `ast.sfn`
  (`Is`); `effect_checker.sfn` / `typecheck.sfn` (operand walk);
  `emit_native_format.sfn` (formatter); `core_parsing.sfn`
  (`parse_is_expression`); `core_literals_lowering.sfn` (`lower_is_expression`);
  `core.sfn` (dispatch); `instructions_if.sfn` (`_parse_is_guard`, narrowing
  reuse via `narrowed_variant`); `instructions_match_condition.sfn` (the
  discriminant-test prior art).
- TypeScript `x is T` type predicates; Rust `matches!` — prior art.
