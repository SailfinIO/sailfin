---
sfep: TBD
title: Nullable Access Operators (?. and ??)
status: Draft
type: language
created: 2026-07-01
updated: 2026-07-01
author: "agent:compiler-architect; human review"
tracking:
supersedes:
superseded-by:
graduates-to: reference/preview/nullability.md
---

# SFEP-XXXX — Nullable Access Operators (`?.` and `??`)

> Design record for the null-safe navigation (`?.`) and null-coalescing (`??`)
> operators over Sailfin's existing `T?` nullable types. Related: SFEP-0012
> (the postfix Result `?` / `TryOperator` — the disambiguation this SFEP must
> get right), SFEP-0034 (`x is T` narrowing — the machinery reused here).

## 1. Summary

Sailfin already models absence with a `T?` nullable-type suffix (Kotlin/
TypeScript style) baked into `TypeAnnotation.text`, used pervasively in the
compiler's own AST (`TypeParameter.bound: TypeAnnotation?`, `ImportSpecifier`
aliases, `Parameter.type_annotation: TypeAnnotation?`, and dozens more in
`compiler/src/ast.sfn`), with `Expression.NullLiteral` as the literal
(`ast.sfn:65`). What it lacks is *ergonomic access* to those values: there is
no null-safe navigation `?.` and no null-coalescing `??`, so every use of a
`T?` requires a hand-written `if x != null { ... }` guard. This SFEP adds two
front-end-only operators — `a?.b` (evaluates to `null` if `a` is `null`, else
`a.b`, short-circuiting the rest of the chain to a nullable result) and
`a ?? b` (yields `a` if non-null, else `b`, stripping nullability) — plus the
optional-index (`a?.[i]`) and optional-call (`a?.(args)`) forms for chain
completeness. Both desugar to guarded expressions over the existing `null`
literal, `!= null` comparison, and control flow; **no new runtime, no new IR
opcode, and no exception involvement**. The load-bearing design problem is
disambiguating `?.` and `??` from the postfix Result `?` (`TryOperator`,
SFEP-0012) and the ternary `?` (`Conditional`, #1690), all of which share the
`?` glyph — solved at the lexer by tokenizing `?.` and `??` as distinct
two-char symbols, exactly as `..`, `&&`, and `<=` are today.

## 2. Motivation

**Who hits it, how often.** Absence is everywhere in the compiler's own source.
`compiler/src/ast.sfn` alone declares nullable fields on `TypeParameter.bound`,
`SourceSpan?` on nearly every expression variant, `Parameter.type_annotation`,
`Parameter.default_value`, `Channel.element_type`, `Channel.capacity`,
`Serve.port`, `MatchCase.guard`, `ElseBranch.statement`/`body`, and many more.
Every read of one of these today is a manual guard:

```sfn
// The status quo — reading a nullable field safely.
let mut bound_text: string = "";
if param.bound != null {
    bound_text = param.bound.text;
}

// A two-level access needs a nested guard:
let mut label: string = "anon";
if node.span != null {
    // ... still cannot reach node.span.start_line in one expression
}
```

This is verbose, error-prone (a forgotten guard is a null dereference), and the
exact boilerplate `?.`/`??` exist to remove in every language that has nullable
types (Kotlin `?.`/`?:`, TypeScript `?.`/`??`, C# `?.`/`??`, Swift `?.`/`??`).

**Why the status quo is insufficient.** The `T?` type already ships and is spec'd
(`site/.../reference/spec/06-types.md:58` — *"Optional types: `T?` — the value
is `T` or `null`"*). The type exists but the ergonomics do not, which is the
worst of both worlds: the language *invites* nullable modelling (the compiler
uses it pervasively) but forces callers to hand-roll the access pattern. Adding
`?.`/`??` is the "boring syntax wins" completion of a feature already half-built
— it matches the conventions every LLM has seen thousands of times, reducing
generated-code error rates (CLAUDE.md "AI agents are users").

**Why now.** These are pure front-end sugar over constructs that already lower
(member access, index, call, `!= null`, and the statement-hoist continuation
rewrite proven by `desugar_try_in_block`). They add no runtime and no new safety
*claim* — a `?.` chain is exactly as safe as the `if != null` it desugars to, so
there is no "parsed but not enforced" trap.

## 3. Design

### 3.1 Overview and worked examples

```sfn
// Null-safe navigation: null if the receiver is null, else the member.
let text: string? = param.bound?.text;      // string? — null when bound is null

// Chains short-circuit: any null link yields null for the whole chain.
let line: int? = node.span?.start_line;

// Null-coalescing strips nullability with a fallback.
let bound_text: string = param.bound?.text ?? "<none>";   // string, never null

// Optional index and optional call (chain completeness):
let first: Item? = maybeList?.[0];
let result: int? = maybeFn?.(arg);

// Combined with `??` for a total expression:
let n: int = lookup(key)?.count ?? 0;
```

- `a?.b` — if `a` is `null`, the whole expression is `null` (type `B?`); else it
  is `a.b`. If `a`'s member `b` is itself nullable, the result stays `B?` (no
  double-nullable — `T??` normalizes to `T?`).
- `a?.[i]` — if `a` is `null`, `null`; else `a[i]`, result `Elem?`.
- `a?.(args)` — if `a` is `null`, `null`; else `a(args)`, result `Ret?`.
- `a ?? b` — if `a` is non-null, `a` (as its non-null type); else `b`. Result
  type is the non-null type of `a` unified with the type of `b`.

### 3.2 The disambiguation problem (load-bearing)

After SFEP-0012 (Result `?`) and #1690 (ternary `?`), the single-char `?` symbol
already carries **three** meanings, all resolved in the expression parser today:

| Form | Meaning | Where resolved (today) |
|---|---|---|
| type suffix `Config?` | nullable **type** | type-annotation scanner (`collect_type_annotation_until`) — never enters expression parsing |
| postfix `expr?` | Result error-propagation (`TryOperator`) | `parse_postfix_chain` `?` arm (`expressions.sfn:1318`) |
| infix `cond ? a : b` | ternary (`Conditional`) | base-precedence seam in `parse_expression_bp` (`expressions.sfn:370`) |

The existing postfix/ternary split (`expressions.sfn:1318-1344`) is a
**lookahead** disambiguation: when a `?` is seen in postfix position, the parser
peeks past it — if a top-level `:` follows a branch-start token
(`is_ternary_marker`), the `?` is left unconsumed for the ternary seam;
otherwise it is a `TryOperator`. Adding `?.` and `??` on top of this by
*character lookahead alone* would deepen an already-subtle seam.

**Decision: tokenize `?.` and `??` as distinct two-char symbols in the lexer**
(`is_two_char_symbol`, `lexer.sfn:446`), joining `..`, `&&`, `||`, `==`, `<=`,
`+=`, etc. This is the single most important design choice and it makes every
downstream production trivial:

- The lexer's maximal-munch pass (`lexer.sfn:333`) already emits the longest
  matching symbol. `a?.b` lexes as `[a] [?.] [b]`; `a ?? b` lexes as
  `[a] [??] [b]`; a bare `a?` still lexes `[a] [?]` (single `?`), and
  `cond ? a : b` still lexes `[cond] [?] [a] [:] [b]`. **A `?` immediately
  followed by `.` or `?` is a different *token* than a standalone `?`** — the
  ambiguity is resolved before the parser ever runs, so `TryOperator` and
  `Conditional` are untouched.
- The one adjacency to reason about is `a?.b` vs. *"Result-`?` then member
  access"* (`(a?).b`). **Rule: `?.` is always the null-safe access token; there
  is no `(a?).b` reading.** Because `?.` is lexed as one token, `a?.b` can only
  parse as null-safe access. To write Result-propagation-then-member you insert
  whitespace: `a? .b` lexes as `[a] [?] [.] [b]` (the `?` is not immediately
  followed by `.`), and separately, member access on a `Result`-unwrapped value
  is the far rarer intent. This is the same maximal-munch rule that already makes
  `a..b` a range (never `a.` `.b`) and `a==b` an equality (never `a=` `=b`). It
  is boring and matches Kotlin/TypeScript/Swift, where `?.` is likewise a single
  lexical token that wins over `?` `.`.
- **`a ?? b` vs. Result-`?` then ternary-`?`.** `a?? b : c` would be a
  degenerate reading; `??` as one token forecloses it — `a ?? b` is always
  coalescing. A Result-propagate feeding a ternary condition is written
  `a? ? b : c` (whitespace) or, idiomatically, parenthesized `(a?) ? b : c`.

**Consequence for `TryOperator` lookahead:** the existing ternary-vs-try
lookahead in `parse_postfix_chain` (`expressions.sfn:1338`,
`is_ternary_marker`) is *narrowed* by this change, not broken: it now only ever
sees a **single** `?` token (a `?.`/`??` never reaches it because the lexer
produced a two-char token the postfix loop's `strings_equal(sym, "?")` guard
does not match). The `??`/`?.` arms are new, separate productions.

### 3.3 Lexer

`compiler/src/lexer.sfn` — add two arms to `is_two_char_symbol` (`lexer.sfn:446`):

```sfn
if value == "?." { return true; }
if value == "??" { return true; }
```

No other lexer change. Maximal munch (`lexer.sfn:333`) already consumes the
two-char symbol when the pair matches. **Migration-safe:** the old seed lexes
`?.` as `[?] [.]` and `??` as `[?] [?]`; because the compiler source contains no
`?.`/`??` until a post-SFEP follow-up (§5), the old seed never needs the new
tokenization to build the new compiler.

### 3.4 Parser

`compiler/src/parser/expressions.sfn` — two additions in `parse_postfix_chain`
(`expressions.sfn:1177`), placed in the postfix `Symbol` loop alongside the
existing `.` / `(` / `[` / `?` arms:

**(a) `?.` arm** (null-safe member / index / call). When the current token is the
symbol `?.`:

```
postfix := primary (
      "." ident
    | "(" args ")"
    | "[" expr "]"
    | "as" type | "is" type
    | "?"                       // TryOperator (single ?)
    | "?." ident                // OptionalMember
    | "?." "[" expr "]"         // OptionalIndex
    | "?." "(" args ")"         // OptionalCall
)*
```

After consuming `?.`, dispatch on the *next* token:
- an `Identifier` → build `Expression.OptionalMember { object, member }`;
- `[` → parse the index expression and `]`, build `Expression.OptionalIndex
  { sequence, index }`;
- `(` → parse the call arguments via the existing `parse_call_arguments`, build
  `Expression.OptionalCall { callee, arguments }`.

Left-associates through the loop, so `a?.b?.c` parses as `((a?.b)?.c)` and
`a?.b()` parses as `(a?.b)(...)` — matching the plain `.`/`(` chain shape.

**(b) `??` arm** — `??` is **infix**, not postfix, so it is handled in
`parse_expression_bp`, not the postfix chain. Add `??` to `binary_precedence`
(`expressions.sfn:2209`) at a tier **below `||` (1) and above range `..` (0)**;
concretely `??` → precedence `1` requires re-numbering — instead insert `??` at
its own tier between `..` and `||` by giving `??` precedence `1` and shifting
`||`+ up by one, **or** (preferred, minimal-blast-radius) give `??` precedence
**0** shared with `..` but make it **right-associative** via a dedicated seam.

**Chosen rule (minimal, unambiguous):** treat `??` like the ternary/assignment
seams — a **dedicated right-associative arm at base precedence**
(`min_precedence == 0`) in `parse_expression_bp`, evaluated **after** the binary
climb (so `a || b ?? c` groups as `(a || b) ?? c`, coalescing binds looser than
`||`) but **before** the ternary and assignment seams (so `a ?? b ? c : d`
groups as `(a ?? b) ? c : d`, and `x = a ?? b` groups as `x = (a ?? b)`). The
right-hand side recurses at base precedence for right-associativity: `a ?? b ?? c`
→ `a ?? (b ?? c)`. This mirrors the *exact* structure of the existing ternary
seam (`expressions.sfn:370-410`) and assignment seam
(`expressions.sfn:422-445`), so it is a copy of a proven pattern, not a new
precedence-table entry that could perturb `||`/`&&` binding.

> Precedence summary (loosest → tightest): `= / +=` (assignment) · `? :`
> (ternary) · `??` (coalesce) · `||` · `&&` · … · postfix (`?.`, `.`, `()`,
> `[]`, `?`). `??` is right-associative; `?.` is postfix-tight and
> left-associative.

### 3.5 AST

`compiler/src/ast.sfn` — four new `Expression` variants, modelled field-for-field
on their non-optional cousins so the field-name GEP-slot convention holds (see
the `Assignment` field-name note at `ast.sfn:133-158`):

```sfn
// Null-safe member access `a?.b` — null if `object` is null, else `object.b`
// (nullable result). Fields mirror `Member` (`object`, `member`, `span`) so
// they share the enum's per-name field slots. Desugared to a guarded temp +
// `!= null` test before native emission (emit_native_desugar_null.sfn), the
// same statement-hoist strategy `desugar_try_in_block` uses for `?`.
OptionalMember { object: Expression, member: string, span: SourceSpan? },
// Null-safe index `a?.[i]`. Mirrors `Index` (`sequence`, `index`).
OptionalIndex { sequence: Expression, index: Expression, span: SourceSpan? },
// Null-safe call `a?.(args)`. Mirrors `Call` (`callee`, `arguments`, `span`).
OptionalCall { callee: Expression, arguments: Expression[], span: SourceSpan? },
// Null-coalescing `a ?? b` — `left` if non-null, else `right`. Right-assoc,
// binds looser than `||`. Desugared to a guarded temp + `!= null` select.
Coalesce { left: Expression, right: Expression, span: SourceSpan? },
```

`span` is appended last on every variant per the layout-stability convention at
`ast.sfn:60`. No change to any existing variant.

### 3.6 Type rules (`typecheck.sfn`)

Per the discovery documented in SFEP-0034 §3.5 and the `TryOperator` arm
(`typecheck.sfn:1090`), **the typecheck pass tracks names only — it performs no
expression-type inference (#829)**. So, exactly like `Cast`, `Is`, `TryOperator`,
and `Conditional`, the new nodes get **`walk_expression` recursion arms** (so
inner diagnostics — undefined symbols, fn-value misuse, parse-error nodes — still
fire), not a full nullable-type flow checker:

```sfn
if expression.variant == "OptionalMember" {
    return walk_expression(expression.object, bindings, imports);
}
if expression.variant == "OptionalIndex" {
    let mut d = walk_expression(expression.sequence, bindings, imports);
    return d.concat(walk_expression(expression.index, bindings, imports));
}
if expression.variant == "OptionalCall" {
    let mut d = walk_expression(expression.callee, bindings, imports);
    // recurse each argument (as the Call arm does)
    return d;
}
if expression.variant == "Coalesce" {
    let mut d = walk_expression(expression.left, bindings, imports);
    return d.concat(walk_expression(expression.right, bindings, imports));
}
```

**The nullable *typing* semantics** below are the normative contract the language
adopts; the **enforcement** of the "receiver must be `T?`" rule is scoped as a
fast-follow gated on expression-type inference (#829), for the same reason
SFEP-0034's non-enum `is` diagnostic is deferred — there is no consumer for a
refined type in typecheck today. This keeps the SFEP honest: v1 ships the
operators and their desugaring end-to-end (the ergonomic win), and the static
"you used `?.` on a non-nullable" diagnostic follows when #829 lands. The typing
contract:

1. **`a?.b`**: `a` should have a nullable type `T?`. The chain's result type is
   `B?` where `B` is the type of `T.b`. If `T.b` is itself nullable, the result
   normalizes to `B?` (no `T??`).
2. **`a?.[i]` / `a?.(args)`**: analogous — result is `Elem?` / `Ret?`.
3. **`a ?? b`**: `a` should be `T?`; the expression **strips** nullability — its
   type is `T` unified with the type of `b`. `T? ?? T` yields `T`. This is where
   a `?.`-chain most naturally terminates into a total value.
4. **`is`-narrowing tie-in (SFEP-0034).** `if x is T { ... }` already narrows
   `x` to the tested variant in the then-branch via the lowering's
   `narrowed_variant` machinery. A parallel **null-narrowing** — `if x != null`
   refining `x: T?` to `T` in the then-branch — is the same shape and is the
   natural home for future flow-based nullability enforcement; it is called out
   here as the extension point but is **not** built in v1 (it, too, waits on
   #829). `??` and `?.` do not require it: they desugar to explicit `!= null`
   tests that need no narrowing substrate.

No new E-codes are reserved for v1 (the existing range tops out near `E0816`;
`typecheck_types.sfn`). When the #829-gated receiver-nullability diagnostic
lands it reserves the next free `E08xx` slot, matching the numeric-code
convention (SFEP-0012 §Type rules).

### 3.7 Native IR — desugaring (the core lowering)

Like `?` (`TryOperator`), the nullable operators lower by **AST→AST desugaring
before native emission**, reusing the exact statement-hoist / continuation
machinery in `desugar_try_in_block` (`emit_native_desugar_try.sfn`). Add a
sibling pass, `emit_native_desugar_null.sfn`, run as a `Block -> Block` pre-pass
(alongside the try desugarer). The AST/native-IR have **no** match-expression or
if-expression form (only statements), so — exactly as the try desugarer does —
each nullable operator hoists its receiver into a fresh temp, tests it against
`null`, and threads the block remainder through.

**`a?.b` desugars** (hoisting into a fresh `__opt_N` temp) to:

```sfn
let __opt_0 = a;                 // evaluate the receiver ONCE
let mut __opt_0_r: B? = null;
if __opt_0 != null {
    __opt_0_r = __opt_0.b;       // plain Member access on the non-null temp
}
// ... uses of the original `a?.b` reference __opt_0_r ...
```

`a ?? b` desugars to:

```sfn
let __opt_1 = a;                 // evaluate the left ONCE
let mut __opt_1_r: T = b;        // default to the fallback
if __opt_1 != null {
    __opt_1_r = __opt_1;         // non-null: use the left (as its non-null type)
}
// ... uses of `a ?? b` reference __opt_1_r ...
```

Chains and mixed `?.`/`??` fall out of the recursion, precisely as the try
desugarer handles chained `?`: `a?.b ?? c` desugars the inner `a?.b` first
(binding `__opt_0_r: B?`), then the `??` over that temp (binding `__opt_1_r: B`).
Short-circuiting is preserved because the `.b` access only executes inside the
`__opt_0 != null` arm. **The fresh-temp-per-operator discipline** (the `__opt_N`
counter threaded through the block walk, mirroring `__try_N`) guarantees multiple
operators in one expression (`a?.b + c?.d`) do not collide, and that each
receiver is evaluated exactly once (correct for effectful receivers,
`fs.read()?.len`).

Because the desugared output is **only** `let`, `if`, `Member`/`Index`/`Call`,
`!= null` (`Binary`), and `NullLiteral` — all of which already emit valid
`.sfn-asm` — **no new native-IR opcode is introduced**, and the native
formatter needs **no new serialization arm** for the optional nodes in the
common (fully-desugared) path.

**Fallback formatter arms (defensive, mirroring `TryOperator`).** The try
desugarer leaves a `TryOperator` in place when it sits inside a ternary branch
(where statement-hoist would change evaluation order), and the native formatter
has a fallback `TryOperator` arm (`emit_native_format.sfn:259`) that serializes
it to `operand?` text for the shadow re-parser. For symmetry and safety, the
null desugarer likewise leaves an optional node in place inside a ternary/`??`
branch, and `emit_native_format.sfn` gains fallback arms serializing to the
lowering shadow re-parser's text form:

- `OptionalMember` → `(object)?.member`
- `OptionalIndex` → `(sequence)?.[index]`
- `OptionalCall` → `(callee)?.(args)`
- `Coalesce` → `(left) ?? (right)`

with matching shadow re-parsers in `compiler/src/llvm/expression_lowering/
native/core_parsing.sfn` (siblings of `parse_cast_expression` /
`parse_is_expression` / `parse_ternary_expression`). This is the same
"serialization-is-the-bridge" pattern the ternary and assignment nodes use
(`emit_native_format.sfn:226`, `:243`). In practice the desugarer handles the
overwhelming majority of sites, so these arms are the safety net, not the hot
path.

### 3.8 LLVM lowering

**No new lowering code in the desugared path.** The `if __opt_N != null { ... }`
form lowers through the existing `if`/`Binary(!=)`/`NullLiteral` paths, and the
member/index/call inside the arm lowers through the existing
`Member`/`Index`/`Call` lowering. The `!= null` test lowers to the same
null-pointer / sentinel comparison the compiler already emits for hand-written
`if x != null` guards (`NullLiteral` lowering, `emit_native_format.sfn:111`).
The only lowering additions are the **defensive shadow re-parsers** (§3.7) for
the ternary-branch fallback, which reuse the `strip_enclosing_parentheses` /
top-level-scan helpers `parse_cast_expression` and `parse_is_expression` already
provide.

### 3.9 Effect checking

`compiler/src/effect_checker.sfn` — four pass-through arms in
`collect_effects_from_expression`, identical in spirit to the `Cast` / `Is` /
`Conditional` / `TryOperator` arms (`effect_checker.sfn:888-982`). The operators
add **no effect of their own** (they are control flow over a `null` test); the
effectful surface is the receiver/arguments, which must be walked:

```sfn
if expression.variant == "OptionalMember" {
    return collect_effects_from_expression(expression.object, imports);
}
if expression.variant == "OptionalIndex" {
    let mut r = collect_effects_from_expression(expression.sequence, imports);
    return merge_requirements(r, collect_effects_from_expression(expression.index, imports));
}
if expression.variant == "OptionalCall" {
    // union of callee + each argument (as the Call form does)
    ...
}
if expression.variant == "Coalesce" {
    // BOTH sides: the left always evaluates; the right may. Union, like the
    // ternary arm (either branch may run).
    let mut r = collect_effects_from_expression(expression.left, imports);
    return merge_requirements(r, collect_effects_from_expression(expression.right, imports));
}
```

This is a **net tightening** identical to SFEP-0034's: if these ever parsed to
`Raw` (they do not — they are new structured nodes) an effectful receiver would
drop its effect; structuring them forces the operand walk. `fs.read()?.len`
surfaces `![io]`.

### 3.10 Formatter (`sfn fmt`)

Source-level `sfn fmt` must round-trip `a?.b`, `a?.[i]`, `a?.(args)`, and
`a ?? b` (verified `fmt --check`-stable). The canonical spacing is: **no space**
around `?.` (like `.`), and **single spaces** around `??` (like `||`) —
matching TypeScript/Kotlin convention and the "boring syntax wins" principle.
The source formatter emits these forms directly from the structured nodes; the
*native-IR* formatter arms (§3.7) are the separate lowering-bridge serialization.

### 3.11 Scope

**In v1 (this SFEP):** `?.` (member), `?.[]` (index), `?.(  )` (call), and `??`
(coalesce), fully desugared and self-hosting; parser + AST + effect-walk +
typecheck-walk + native desugar + fmt round-trip. Including index and call keeps
the chain complete (`a?.b?.[0]?.(x) ?? d` is expressible), which is the whole
point of an access-operator family — shipping only `?.member` would force a
manual guard back in for the exact cases where chaining matters most.

**Deferred fast-follows** (file as sub-issues):
- **Static receiver-nullability diagnostic** (`?.`/`??` on a non-nullable type) —
  blocked on expression-type inference (#829), the same blocker SFEP-0034's
  non-enum `is` diagnostic carries.
- **`if x != null` then-branch null-narrowing** (`T?` → `T`), the null analogue
  of SFEP-0034's variant narrowing — a natural extension of the same
  `narrowed_variant` machinery, deferred with #829.
- **`!` non-null assertion operator** (`a!.b`, force-unwrap) — a separate,
  safety-*loosening* construct; intentionally out of scope (it manufactures a
  panic path, unlike `?.`/`??` which are total).

## 4. Effect & capability impact

Effect-transparent. `?.`, `?.[]`, `?.(  )`, and `??` add **no** effect and no
capability-manifest change; each requires exactly the union of its operands'
effects (§3.9), the same treatment `Cast`/`Is`/`Conditional`/`TryOperator`
already receive. The change is a net *tightening* by construction: the operators
are new structured nodes whose operands are always walked, so an effectful
receiver (`fs.read()?.field`, `lookup()?.() ?? fallback()`) surfaces its
capability rather than hiding behind a `Raw` degradation. This advances the same
headline-integrity goal as epic #1180 (no effect-blind expression forms). No new
effect keyword; `??`'s right branch is treated like a ternary branch (may run →
its effects are required), which is conservative and sound.

## 5. Self-hosting impact

Passes touched, in pipeline order:

- **Lexer** (`lexer.sfn`) — two arms in `is_two_char_symbol` (`?.`, `??`).
- **Parser** (`parser/expressions.sfn`) — `?.` postfix arm (member/index/call
  dispatch) in `parse_postfix_chain`; `??` right-associative base-precedence
  seam in `parse_expression_bp` (copy of the ternary/assignment seam).
- **AST** (`ast.sfn`) — `OptionalMember`, `OptionalIndex`, `OptionalCall`,
  `Coalesce` variants (fields mirror `Member`/`Index`/`Call`; `span` last).
- **Typecheck** (`typecheck.sfn`) — four `walk_expression` recursion arms
  (names-only, per #829). No `SymbolEntry` change.
- **Effect checker** (`effect_checker.sfn`) — four operand-walk arms.
- **Native desugar** (new `emit_native_desugar_null.sfn`) — the `Block -> Block`
  hoist/continuation pre-pass, a sibling of `emit_native_desugar_try.sfn`, wired
  into the same emission entry point that already calls `desugar_try_in_block`.
- **Native formatter** (`emit_native_format.sfn`) — four defensive fallback
  serialization arms (the ternary-branch safety net).
- **LLVM lowering** (`llvm/.../core_parsing.sfn`) — four shadow re-parsers for
  the fallback arms; no new opcode, no new instruction lowering.

**Self-hosting invariant preserved — BUNDLE, no seed cut.** The change is
**additive** and the old seed is unaffected: the old lexer tokenizes `?.` as
`[?][.]` and `??` as `[?][?]`, and the compiler source contains **no** `?.`/`??`
usage in v1, so `make compile` builds the new compiler from the old pinned seed,
and that freshly-built compiler is the first one that both *emits* and (in a
follow-up) could *consume* the operators — all in one self-host pass. No
`/pin-seed`, no seed cut (`.claude/rules/seed-dependency.md`: single consumer,
same session → bundle). A **separate, opt-in follow-up** may migrate the
compiler's own `if x != null` guards to `?.`/`??`, but only after a seed
containing the operators exists — exactly the staging SFEP-0012 §Q6 and SFEP-0034
§3.9 use.

## 6. Alternatives considered

- **Single-char lookahead (no new tokens), disambiguating `?.`/`??` in the
  parser** like the existing try-vs-ternary seam. Rejected: it stacks a third
  and fourth meaning onto the already-subtle `?` lookahead in
  `parse_postfix_chain`, raising the odds of a regression in `TryOperator` /
  `Conditional` parsing. Two-char tokenization resolves the ambiguity in the
  lexer (maximal munch) *before* the parser runs — the same proven mechanism as
  `..`/`&&`/`<=`, and how Kotlin/TypeScript/Swift lex `?.` themselves.
- **`?:` (Elvis) instead of `??` for coalescing** (Kotlin's spelling). Rejected:
  `?:` collides head-on with the ternary `? :` tokens and would be a genuine
  lexical ambiguity (`a ?: b` vs `a ? x : b`). `??` (TypeScript/C#/Swift) is
  unambiguous once tokenized and is the more widely-seen spelling for LLMs.
- **A prelude `Option<T>` enum + `map`/`unwrap_or` methods** instead of syntax.
  Rejected for v1: it duplicates the already-shipped `T?`/`null` model (there is
  no `Option<T>` today, and adding one competes with `T?` for the same role),
  and method-chaining on `Option` needs closures/generics ergonomics that the
  `?.`/`??` sugar sidesteps entirely. `?.`/`??` are pure sugar over the *existing*
  nullable model — no new type, no runtime.
- **A new runtime null-check intrinsic.** Rejected: unnecessary. The desugaring
  emits ordinary `!= null` + `if`, which already lower correctly; adding an
  intrinsic would be gratuitous surface with no benefit.
- **Full flow-based nullability enforcement in v1** (reject `?.` on a
  non-nullable, narrow `T?`→`T` after `!= null`). Deferred, not rejected: it is
  blocked on expression-type inference (#829), the same blocker SFEP-0034's
  non-enum diagnostic carries. Shipping the operators' desugaring now (the
  ergonomic win) and the static diagnostic when #829 lands avoids coupling a
  usable feature to an unbuilt analysis — "fix the foundation first" without
  blocking the sugar behind it.
- **Including `!` force-unwrap in v1.** Rejected: `!` *loosens* safety (it
  introduces a panic path), the opposite of `?.`/`??` which are total. It belongs
  in its own SFEP with its own panic-semantics justification.

## 7. Stage1 readiness mapping

- [ ] **Parses** — `?.` postfix arm (member/index/call) + `??` base-precedence
  seam produce structured `OptionalMember`/`OptionalIndex`/`OptionalCall`/
  `Coalesce` nodes (no `Raw` fallthrough); `?.`/`??` lexed as two-char symbols.
- [ ] **Type-checks / effect-checks** — `walk_expression` arms (names-only,
  #829) + effect operand-walk arms; effectful receiver surfaces its effect. (The
  static receiver-nullability *diagnostic* is a #829-gated fast-follow — hence
  Draft/Accepted, not Implemented, until it lands.)
- [ ] **Emits valid `.sfn-asm`** — `emit_native_desugar_null.sfn` rewrites the
  operators to `let`/`if`/`!= null`/`Member`/`Index`/`Call`, all of which
  already emit; defensive native-formatter fallback arms cover the
  ternary-branch case.
- [ ] **Lowers to LLVM IR** — desugared path reuses existing `if`/`Binary`/
  `Member`/`Index`/`Call`/`NullLiteral` lowering; four shadow re-parsers for the
  fallback. No new opcode.
- [ ] **Regression coverage** — parser unit, effect-walk integration, and
  build-and-run e2e tests (§8).
- [ ] **Self-hosts** — `make compile`; old seed builds the new compiler
  (additive, no `?.`/`??` in compiler source). No seed cut.
- [ ] **`sfn fmt --check` clean** — every touched `.sfn`; source formatter
  round-trips `a?.b` / `a ?? b`.
- [ ] **Documented** — `docs/status.md` gains a nullable-operators row; the
  `graduates-to` preview chapter `reference/preview/nullability.md` is authored;
  spec `06-types.md` cross-links from the Optional-types row.

## 8. Test plan

Regression coverage under `compiler/tests/{unit,integration,e2e}/`:

- **`compiler/tests/unit/parser_nullable_access_test.sfn`** — `a?.b` parses to
  `OptionalMember` (object Identifier, `member`); `a?.[0]` to `OptionalIndex`;
  `a?.(x)` to `OptionalCall`; `a ?? b` to `Coalesce`. Precedence: `a || b ?? c`
  → `Coalesce{ left: Binary(||), right: c }`; `a ?? b ?? c` right-associates to
  `Coalesce{ a, Coalesce{ b, c } }`; `a ?? b ? c : d` → `Conditional{ Coalesce,
  c, d }`. Disambiguation: `a? .b` (whitespace) lexes `[a][?][.][b]` (Result-`?`
  then member), while `a?.b` lexes `[a][?.][b]`; `a?` alone still parses
  `TryOperator`; `cond ? a : b` still parses `Conditional`.
- **`compiler/tests/unit/lexer_nullable_tokens_test.sfn`** — `?.` and `??` lex as
  single `Symbol` tokens; `? .` / `? ?` (spaced) lex as two `?`/`.`/`?` tokens.
- **`compiler/tests/integration/nullable_effect_walk_test.sfn`** — a pure caller
  with `fs.read()?.len` / `readMaybe() ?? fallbackIo()` is rejected for the
  missing `![io]`; the same body with `![io]` compiles (net-tightening proof).
- **`compiler/tests/e2e/nullable_access_test.sfn`** — build and run a program
  exercising: `?.` returning `null` when the receiver is null and the member
  when non-null; a two-level chain short-circuiting on the first null; `??`
  supplying the fallback and passing through the non-null; a receiver evaluated
  **exactly once** (effectful receiver, assert single side effect); `?.[]` and
  `?.(  )`. Thread `PATH` / `SAILFIN_TEST_SCRATCH` per
  `.claude/rules/no-bash-e2e.md`.
- **`compiler/tests/e2e/nullable_desugar_snapshot_test.sfn`** (optional) —
  snapshot the desugared native IR for `a?.b ?? c` to lock the hoist/temp shape.
- **Self-host** — `make compile` + the full suite; a converted example
  (`examples/basics/nullable-access.sfn`) participates in the seedcheck corpus.

## 9. References

- SFEP-0012 (`docs/proposals/0012-result-and-question-operator.md`) — the postfix
  Result `?` (`Expression.TryOperator`, `ast.sfn:111-114`); §"Disambiguating the
  two `?`s" is the direct precedent this SFEP extends to a *third* and *fourth*
  `?`-glyph meaning. The `desugar_try_in_block` statement-hoist strategy
  (`emit_native_desugar_try.sfn`) is the model for `emit_native_desugar_null.sfn`.
- SFEP-0034 (`docs/proposals/0034-is-type-guard.md`) — `x is T` narrowing; §3.5
  documents the "typecheck tracks names only, #829 gates static type diagnostics"
  reality this SFEP inherits, and its `narrowed_variant` machinery is the
  extension point for future `T?`→`T` null-narrowing.
- Spec `reference/spec/06-types.md:58` — Optional types `T?` (the type this SFEP
  adds access operators for); line 63 (`Result<T, E>` roadmap note).
- `.claude/rules/seed-dependency.md` — the bundle decision (single consumer,
  additive, no seed cut).
- Key source: `compiler/src/lexer.sfn:446` (`is_two_char_symbol`),
  `:333` (maximal-munch symbol emit); `compiler/src/parser/expressions.sfn:1177`
  (`parse_postfix_chain`, `:1318` the `?` arm), `:370`/`:422` (ternary/assignment
  base-precedence seams — the `??` seam template), `:2209` (`binary_precedence`);
  `compiler/src/ast.sfn:54` (`Expression` enum), `:65` (`NullLiteral`), `:68`
  (`Member`), `:74` (`Index`), `:69` (`Call`); `compiler/src/typecheck.sfn:1060`
  (`Cast`/`Is`/`TryOperator` walk arms); `compiler/src/effect_checker.sfn:888`
  (`Cast`/`Is`/`Conditional`/`TryOperator` effect arms);
  `compiler/src/emit_native_format.sfn:203` (`Cast`/`Is`/`Conditional`/
  `TryOperator` native-IR serialization — the fallback-arm template);
  `compiler/src/emit_native_desugar_try.sfn` (the hoist desugarer to mirror).
- Prior art: TypeScript `?.`/`??`, C# `?.`/`??`, Swift `?.`/`??`, Kotlin
  `?.`/`?:` (Elvis).
