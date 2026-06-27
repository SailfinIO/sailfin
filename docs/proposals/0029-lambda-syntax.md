---
sfep: 29
title: Lambda expression syntax for 1.0 — keep, reform, or defer
status: Implemented
type: language
created: 2026-06-26
updated: 2026-06-27
author: "agent:compiler-architect"
tracking: [690, 1683]
supersedes:
superseded-by:
graduates-to: site/src/content/docs/docs/reference/spec/05-expressions.md
---

# SFEP-0029 — Lambda expression syntax for 1.0 — keep, reform, or defer

> Design deliverable for issue #690. This SFEP surveys the candidate lambda
> syntaxes against the *current* tokenizer/parser, weighs parser-ambiguity and
> migration cost, and recommends a direction. No parser/formatter/test code is
> changed by this document.
>
> **Design gate — Accepted 2026-06-26.** The owner ratified the §3.6 hybrid:
> **keep the `fn(...) { }` block form unchanged and add an additive,
> expression-bodied `fn(x) => expr` short form.** Full reform (replacing
> `fn(...)`) and defer-to-2.0 were both considered and declined. Implementation
> is tracked as a follow-up issue (see §10); this SFEP graduates to
> `Implemented` when that lands and self-hosts.

## 1. Summary

Sailfin's anonymous-function (lambda) syntax is today `fn(x: int, y: int) -> int
{ ... }` — a leading `fn` keyword, parenthesized parameters using the shipped
`:` annotation reform, an optional `-> ReturnType`, an optional (currently
discarded) `![...]` effect annotation, and a `{ }` block body. Issue #690 asks
whether this should be reformed to a more conventional shape before 1.0, kept,
or deferred to 2.0.

This SFEP analyzes four candidates — **keep `fn(...)`**, **bare paren block
`(...) -> T { }`**, **Rust pipes `|...| -> T { }`**, and **JS/TS arrow `(...)
=> ...`** — and **recommends keeping the `fn(...)` form for 1.0 while adopting
a narrow, additive ergonomic win**: an **expression-bodied `fn(...) => expr`**
short form (§3.6). **This is the accepted direction** (design gate, 2026-06-26);
the `=>`/match-arm collision is avoided structurally because the `=>` only
appears after a `fn(...)` head the parser is already committed to. The
single decisive fact is that `=>` is **already the match-arm separator** in both
the parser (`token_utils.sfn:545`) and the shipped spec (§04, §08, §12), so a
free-standing JS/TS arrow lambda is not lexically free — it collides head-on
with a shipped construct. The keyword-led `fn` dispatch is also the only form
that needs **zero lookahead** and keeps the (pillar-#1) effect annotation
trivially attachable, and the compiler's own source uses **zero** lambda
expressions, so reform carries no self-hosting risk but also buys the
self-hosting build nothing.

## 2. Motivation

### 2.1 The status quo and its frictions

The current lambda parser (`compiler/src/parser/expressions.sfn:1261`,
`parse_lambda_expression`) recognizes a lambda by a leading `fn` identifier
(Sailfin has no keyword tokens; `fn` lexes as `Identifier`). Dispatch is a
single keyword check at `expressions.sfn:389–402`: if the primary-expression
position sees an identifier equal to `fn`, it parses a lambda; otherwise it
does not. This makes lambda recognition **zero-lookahead and unambiguous**.

Three frictions motivate the question:

1. **Verbosity vs. conventions.** Every other mainstream language has a terser
   anonymous function: JS/TS `(x) => x + 1`, Rust `|x| x + 1`, Python `lambda
   x: x + 1`. Sailfin's `fn(x: int) -> int { return x + 1; }` is the most
   verbose of the lot — it requires a keyword, a return-type arrow, a block, and
   an explicit `return`. For the common "map/filter/reduce callback" case this
   is heavy: `numbers.map(fn(x) -> int { return x * x; })`.

2. **A fragile return-type capture.** The return type is captured by a
   text-collect hack — `expression_tokens_collect_until(current, ["!", "{"])`
   (`expressions.sfn:1299`) — not by the real type parser. This is the
   mechanism that produced the **#1546 typed-result round-trip bug**, where a
   trailing `![io]` was swallowed into the return-type text (`int ![io]`),
   defeating the future-kind classifier. The current code stops the capture at
   `!` as a point fix, but the underlying approach remains brittle.

3. **The effect set is parsed then discarded.** The lambda's `![...]`
   annotation is consumed and thrown away (`expressions.sfn:1306–1320`); the
   AST node `Expression.Lambda { parameters, body, return_type, captures }`
   (`ast.sfn:78–82`) has no field for it. Since effects are pillar #1, any
   syntax decision should at minimum not make eventually tracking the lambda
   effect set *harder*.

### 2.2 Who hits this, how often

Lambdas are load-bearing in real Sailfin code: closures shipped in the M1.5
chain (#685–689; `compiler/src/llvm/closures.sfn`,
`compiler/src/llvm/expression_lowering/native/lambda_lowering.sfn`), with
working examples (`examples/advanced/lambda-closure.sfn`,
`examples/functional/map-reduce.sfn`, `examples/algorithms/quicksort.sfn`) and
the `spawn fn() -> T { ... }` concurrency surface
(`reference/preview/concurrency.md:19`). The `fn(...)` form is therefore a real,
documented, user-facing construct — not a parser curiosity — which raises the
stakes on getting the syntax right before 1.0 (syntax is permanent;
`reference/preview/` and the spec already commit to `fn(...)` and `spawn fn()
... { }`).

### 2.3 Why decide now

Syntax is the one thing 1.0 cannot iterate on without a breaking change. The
`:`-annotation reform (SFEP-0005, **Implemented**) already changed the *inside*
of the parens (`x: int`, not `x -> int`), so the lambda head is now in its 1.0
shape *except* for the outer wrapper (`fn`/`|...|`/`(...)`) and the body lead-in
(`{ }` block vs. `=> expr`). This SFEP closes the remaining question.

## 3. Design

### 3.0 Constraints inherited from shipped reforms

Two shipped decisions tightly constrain the design space; every candidate must
be evaluated against them, not against a clean slate:

- **`:` for annotations, `->` for return types (SFEP-0005, Implemented).**
  Parameters inside a lambda head already read `x: int`. Function/lambda
  **return** types keep `->`. So any candidate that *also* wants an arrow body
  (JS/TS `=>`) must coexist with a kept `->` return arrow — risking the
  **two-arrow eyesore** `(x: int) -> int => expr`.

- **`=>` is the match-arm separator (shipped).** The lexer produces `=>`
  (`lexer.sfn:448`), but it is **already consumed** — as the pattern→body
  separator in `match` arms. Confirmed in the parser
  (`compiler/src/parser/token_utils.sfn:545`, `_capture_match_pattern`) and in
  the shipped spec: `reference/spec/04-statements.md:46–48`,
  `08-patterns.md:13–17`, `12-result-and-errors.md:50–97`
  (`Pattern => expr`). `=>` is **not** consumed anywhere for lambdas today. This
  is the central fact for the JS/TS-arrow candidate.

### 3.1 The four candidates

Worked against the identical example — a two-arg adder and a map callback:

```sfn
// 1. Keep (status quo)
let add = fn(x: int, y: int) -> int { return x + y; };
let sq  = numbers.map(fn(x) -> int { return x * x; });

// 2. Bare paren block (drop `fn`)
let add = (x: int, y: int) -> int { return x + y; };
let sq  = numbers.map((x) -> int { return x * x; });

// 3. Rust pipes
let add = |x: int, y: int| -> int { return x + y; };
let sq  = numbers.map(|x| -> int { return x * x; });

// 4. JS/TS arrow (expression- and block-bodied)
let add = (x: int, y: int) => x + y;          // expr body, no `->`, no return
let sq  = numbers.map((x) => x * x);          // the ergonomic win
let f   = (x: int) => { doStuff(x); return x; }; // block body
```

### 3.2 Candidate 1 — Keep `fn(...) -> T { }`

- **Lookahead / ambiguity:** zero. Dispatch is a single keyword test on `fn`
  (`expressions.sfn:389`). No conflict with parenthesized expressions, tuples,
  match arms, or function-pointer *types* (`fn(A) -> B`, which are a distinct
  grammar position and unaffected by any value-syntax change).
- **Boring-syntax / AI-users:** `fn` is unusual relative to JS/TS/Rust/Python,
  but it is *unambiguous* and *self-describing*; LLM error mode is "uses the
  wrong keyword," which is a single-token miss, not a structural parse failure.
  Lower expressiveness, but the most robust to malformed generation.
- **Effect placement:** `fn(x: int) -> int ![io] { }` — the `![...]` sits in the
  same slot as a function declaration, so tracking it later is a one-field AST
  add with no grammar change. **Easiest** of all candidates for pillar-#1 work.
- **Migration cost:** none.
- **Reversibility:** fully reversible — keeping the status quo forecloses
  nothing; an arrow short form can be added additively in 2.0.

### 3.3 Candidate 2 — Bare paren block `(...) -> T { }`

- **Lookahead / ambiguity:** **expensive and genuinely hard.** The parser
  reaches a `(` in primary position for *both* a parenthesized expression
  `(x)` / a grouped sub-expression and a lambda head `(x: int) -> T { }`. To
  disambiguate it must scan to the matching `)` and then peek the *next*
  significant token: `->` or `{` ⇒ lambda; anything else ⇒ grouped expression.
  The hard case is a single bare identifier `(x)` with no `:` inside and no
  `->`/`{` after — that is unambiguously a grouped expression, but the parser
  cannot know until it has consumed the whole paren group and looked one token
  past it. This requires either backtracking or a balanced-paren pre-scan in a
  parser that is otherwise single-token-lookahead. It also interacts badly with
  IIFEs and postfix chains (`(x) -> T { }()` vs `(expr)(...)`), which already
  needed special handling (`parser_iife_postfix_test.sfn`).
- **Boring-syntax / AI-users:** no mainstream language uses bare-paren *block*
  lambdas; LLMs have no prior for it, so it inherits arrow-shaped expectations
  (`=>`) and would mis-generate.
- **Effect placement:** `(x: int) -> int ![io] { }` — workable, same slot as
  candidate 1.
- **Migration cost:** moderate (drop `fn` everywhere), mechanically formattable.
- **Reversibility:** poor — once `(...)` can begin a lambda, the grammar's
  paren-position ambiguity is permanent.
- **Verdict:** the lookahead cost alone disqualifies it; it buys terseness at
  the price of the parser's cleanest invariant.

### 3.4 Candidate 3 — Rust pipes `|...| -> T { }`

- **Lookahead / ambiguity:** low-to-moderate. A leading `|` in expression
  position is currently only the start of a bitwise/logical-or operand's
  *right* side, never a *prefix*; so a `|` in primary position is free to
  introduce a lambda. The risk is the empty-param case `|| ...`, which is
  lexed/parsed as the logical-or operator `||` (`lexer.sfn`), so `|| -> T { }`
  would need the lexer or parser to special-case a `||` immediately followed by
  a lambda body — a real wrinkle. Non-empty `|x|` is clean.
- **Boring-syntax / AI-users:** strong Rust prior, but Rust pipes are *not* the
  highest-training-data form (that is JS/TS arrows), and they clash visually
  with Sailfin's bitwise `|`/`||`. Mixed signal for LLMs.
- **Effect placement:** `|x: int| -> int ![io] { }` — workable.
- **Migration cost:** moderate, mechanically formattable, but the `||`
  empty-param hazard makes the formatter rewrite non-trivial.
- **Reversibility:** poor — overloads `|`, which is permanent.
- **Verdict:** the `||` collision and the `|`-overload are avoidable costs for a
  form that is not the LLM-optimal one.

### 3.5 Candidate 4 — JS/TS arrow `(...) => expr` / `(...) => { }`

This is the form with **by far the most LLM training data** and the strongest
"AI agents are users" argument. But it collides with two shipped facts:

- **`=>` is taken (the match-arm separator).** A free-standing arrow lambda
  `(x) => x + 1` shares its core token with `match` arms `Pattern => expr`.
  These positions are *mostly* distinguishable (a match arm only appears inside
  a `match { }` body), but the lexer/parser would now have one token meaning two
  things, and any future grammar work near `match` or expression bodies inherits
  that overload. This is the single largest risk in the whole proposal.
- **The two-arrow eyesore.** Because return types keep `->` (SFEP-0005), a
  *typed* arrow lambda reads `(x: int) -> int => expr` — two different arrows in
  one head. Authors would naturally drop the `->` and rely on inference
  (`(x: int) => expr`), which is fine for expression bodies but means the
  *typed-return block* form `(x: int) -> T => { ... }` is genuinely ugly and
  effectively discouraged.
- **Paren-position lookahead.** Same `(x)`-vs-grouped-expr disambiguation cost
  as candidate 2, *plus* the `=>` peek. The parser must scan to the matching
  `)` and peek for `=>` (or `->`/`{`). Same backtracking/pre-scan requirement.
- **The expression-bodied win is real.** The genuine ergonomic prize is **`=>
  expr` with no block and no `return`** — `numbers.map(x => x * x)`. That is the
  thing users actually want and LLMs reliably produce. A block-bodied arrow
  `(x) => { ... }` adds little over the existing `{ }` block and reintroduces the
  two-arrow problem.
- **Effect placement:** `(x: int) => expr ![io]`? There is no clean slot for an
  effect annotation on an expression-bodied arrow — it would have to go *after*
  the body or be inferred. This makes the (pillar-#1) lambda-effect-tracking
  work **harder**, not easier — a meaningful strike given effects are the lead
  differentiator.
- **Migration cost:** high if it *replaces* `fn(...)` (every site, plus docs and
  the `spawn fn()` surface); low if it is *additive* (new short form, old form
  kept).
- **Reversibility:** the worst — `=>` would be permanently dual-purpose.

### 3.6 The hybrid the recommendation rests on

The only way to capture candidate 4's real prize (`=> expr`) without paying its
worst cost (free-standing `=>` colliding with match arms, paren-position
backtracking) is to **keep the `fn` keyword as the lambda lead-in** and allow an
**expression body after `=>`**:

```sfn
let sq = numbers.map(fn(x) => x * x);          // expr body, fn-led, no return
let add = fn(x: int, y: int) => x + y;          // typed head, expr body
let f   = fn(x: int) -> int { ...; return x; }; // block body unchanged
```

Here `fn` still does the zero-lookahead dispatch, so there is **no
paren-position ambiguity** and **no backtracking**; the `=>` appears only after
a `fn(...)` head the parser is already committed to, so it cannot be confused
with a match arm (the parser is inside `parse_lambda_expression`, not
`parse_match_case`). The effect annotation keeps its clean slot —
`fn(x: int) => x + 1 ![io]` is awkward, so for the **expression-bodied** short
form effects would be *inferred* (the common callback case rarely annotates
effects), while the **block-bodied** form keeps the explicit `fn(...) -> T ![io]
{ }` slot for when an author needs it. This preserves pillar-#1 ergonomics.

This hybrid is **additive**: the existing `fn(...) { }` block form is untouched,
so the parser dual-accepts during the whole transition and the `:`-reform
precedent (parser accepts both forms, then the old one is dropped after a seed
cut) is not even needed — nothing is being *removed*.

## 4. Effect & capability impact

Lambdas are where effect-bearing closures will eventually be tracked, so the
syntax choice is a pillar-#1 concern even though *this* SFEP changes no effect
behavior:

- **Today:** the lambda `![...]` annotation is parsed then discarded
  (`expressions.sfn:1306–1320`); `Expression.Lambda` has no effect field
  (`ast.sfn:78–82`). Effect checking treats a lambda body's effects by walking
  it as part of the enclosing function's effect set.
- **Recommendation's impact:** keeping the `fn`-led head preserves the *cleanest
  future slot* for the lambda effect set — `fn(...) -> T ![io] { }` mirrors a
  function declaration, so the eventual AST add (an `effects: EffectSet?` field
  on `Lambda`) and the eventual checker change are a localized follow-up, not a
  grammar fight. The JS/TS free-arrow candidate, by contrast, has **no natural
  effect slot** on an expression body and would force effect inference or a
  trailing annotation — actively harder. The recommendation therefore *protects*
  the effect roadmap.
- **No capability-manifest impact.** Lambda syntax does not touch
  `capsule.toml`, the capability-audit surface, or effect propagation across
  module boundaries.

## 5. Self-hosting impact

**The decisive self-hosting fact: the compiler's own source and the runtime use
zero lambda expressions.** Every `fn(` occurrence under `compiler/src/` and
`runtime/` is either a comment or a function-pointer **type** annotation
(`cb: fn(int) -> int`, `Map<string, fn() -> int>`) — verified by grepping the
value-position patterns (`= fn(`, `spawn fn(`, `(fn(`, `, fn(`, `return fn(`):
the only hits in `compiler/src/` are inside comments, and `runtime/` has none.
Function-pointer *types* are a distinct grammar position and are **not** affected
by any lambda-*value* syntax change.

Consequences:

- **No self-hosting risk from reform.** Because the compiler doesn't author
  lambda expressions, changing or extending lambda value syntax cannot break the
  self-host build. The seed compiles the new compiler regardless.
- **No self-hosting *benefit* either.** Reform buys the 90-minute build nothing;
  this is purely a user-facing/ergonomics decision, not a foundation fix.
- **Passes touched if the recommendation ships:** lexer (none — `=>` already
  lexed), parser (`expressions.sfn` `parse_lambda_expression`: accept `=>
  <expr>` as an alternative to `{ }` after the head; rewrite the fragile
  return-type capture to the real type parser while there — fixing the #1546
  class), AST (no new node; reuse `Expression.Lambda`, wrapping the expr body in
  an implicit `return` so the `body: Block` field is unchanged), typecheck/effect
  (unchanged — same body semantics), emitter/LLVM lowering (**unchanged** — the
  expr body desugars to a single-`return` block before
  `lambda_lowering.sfn`/`closures.sfn` ever see it).
- **Additive, so no dual-accept seed dance needed.** Since nothing is removed,
  the parser accepts both bodies from day one; no seed cut gates the change. If
  the owner instead chose to *replace* `fn(...)` (candidate 2/3/4 full reform),
  that *would* need the SFEP-0005-style dual-accept window plus a seed cut to
  drop the old form — a much larger commitment this SFEP recommends against.

## 6. Alternatives considered

The four candidates are analyzed in §3.2–§3.5; their disqualifiers:

- **Bare paren block (§3.3)** — paren-position backtracking; no LLM prior;
  permanently muddies grouped-expression parsing.
- **Rust pipes (§3.4)** — `||` empty-param collision and `|`-operator overload;
  not the LLM-optimal form.
- **Full JS/TS arrow replacement (§3.5)** — `=>` already means match-arm
  separator; two-arrow eyesore with the kept `->`; no clean effect slot; worst
  reversibility.

Two further alternatives:

- **Python `lambda x: ...`** — rejected: `:` is the annotation/match separator
  (SFEP-0005, match arms); `lambda x: y` is irredeemably ambiguous with an
  annotated binding. Also a new keyword (keywords are expensive).
- **Defer everything to 2.0 (status quo, no short form)** — viable and *safe*;
  the cost is shipping 1.0 with the most verbose callback syntax of any
  mainstream language, which is a real "AI agents are users" tax for the
  map/filter/reduce idiom LLMs generate constantly. This is the
  recommendation's fallback if the `=>` overload is judged too risky (§10).

## 7. Stage1 readiness mapping

This SFEP is a **design deliverable**; the boxes below describe what the
*recommended* (hybrid `fn(...) => expr`) follow-up implementation must satisfy.
None are claimed as met by this document.

- [ ] Parses — `expressions.sfn` accepts `=> <expr>` body after the `fn(...)`
      head; return-type capture rewritten to the real type parser (#1546 class).
- [ ] Type-checks / effect-checks — unchanged body semantics; expr body wrapped
      in implicit `return` so the existing checker path is reused.
- [ ] Emits valid `.sfn-asm` — unchanged (desugars before the emitter).
- [ ] Lowers to LLVM IR — unchanged (`lambda_lowering.sfn`, `closures.sfn` see a
      normal single-`return` block).
- [ ] Regression coverage — see §8.
- [ ] Self-hosts — guaranteed by construction (compiler authors no lambdas; the
      change is additive).
- [ ] `sfn fmt --check` clean — formatter learns to print `=> expr` (and may
      offer to collapse a single-`return` block to `=> expr`).
- [ ] Documented — `docs/status.md`, `reference/spec/` lambda chapter,
      `grammar.md` `LambdaExpression` rule, and a CLAUDE.md "Pre-1.0 Syntax
      Reform" entry.

## 8. Test plan

For the recommended hybrid (follow-up implementation; not part of this SFEP):

- **Parser unit** (`compiler/tests/unit/parser_lambda_body_test.sfn`,
  extended): `fn(x) => x * x` parses to `Expression.Lambda` with a body that is
  a single `return`; `fn(x: int) -> int => x` parses (typed head, expr body);
  `fn(x) => x ![io]` parses with the trailing effect; the block form
  `fn(x) -> int { ... }` still parses (no regression).
- **Ambiguity guard** (new `parser_lambda_arrow_vs_match_test.sfn`): a `match`
  arm `Pattern => expr` inside a function that *also* contains a `fn(x) => expr`
  both parse correctly — the `=>` overload does not cross-contaminate.
- **#1546 regression** (existing typed-result round-trip test): `fn(x) -> int
  ![io] { ... }` keeps `int` as the return type, not `int ![io]`.
- **Closure capture** (`typecheck_lambda_capture_test.sfn`,
  `closure_lifting_test.sfn`): an expr-bodied lambda captures and lifts
  identically to the block form.
- **e2e** (`array_map_closure_test.sfn`, `array_reduce_closure_test.sfn`):
  `.map(fn(x) => x * x)` executes and produces the same output as the block
  form.
- **Formatter round-trip**: `sfn fmt --check` is idempotent on `=> expr` and the
  block form; the collapse rule (if adopted) round-trips.

If the owner instead picks **defer-to-2.0**, the test plan is empty (no code
change); this SFEP simply records the decision and rationale.

## 9. References

- Issue #690 — the open design question this SFEP resolves.
- SFEP-0005 (`docs/proposals/0005-colon-type-annotations.md`, Implemented) — the
  `:`/`->` reform constraining the lambda head and the kept return arrow.
- `compiler/src/parser/expressions.sfn:1261` (`parse_lambda_expression`),
  `:389–402` (keyword dispatch).
- `compiler/src/parser/token_utils.sfn:545` — `=>` consumed as the match-arm
  separator (the central collision).
- `compiler/src/ast.sfn:78–82` — `Expression.Lambda` node (no effect field).
- `compiler/src/lexer.sfn:448` — `=>` already lexed.
- `site/src/content/docs/docs/reference/grammar.md:220–222` —
  `Expression`/`LambdaExpression` rules.
- Shipped `=>` (match arms): `reference/spec/04-statements.md:46`,
  `08-patterns.md:13`, `12-result-and-errors.md:50`.
- `reference/preview/concurrency.md:19` — `spawn fn() -> int { ... }` surface.
- Closures (M1.5, #685–689): `compiler/src/llvm/closures.sfn`,
  `.../native/lambda_lowering.sfn`, `examples/advanced/lambda-closure.sfn`.
- #1546 — typed-result round-trip bug from the fragile return-type capture.
- CLAUDE.md Design Decision Framework ("Boring syntax wins", "AI agents are
  users", "Libraries over keywords", "Fix the foundation first").

## 10. Decision & follow-up

**Accepted (design gate, 2026-06-26):** adopt the §3.6 hybrid — keep the
`fn(...) { }` block form unchanged and add an **additive, expression-bodied
`fn(x) => expr` short form**. Rationale, verbatim from the gate:

- It captures the real ergonomic prize (the `.map(fn(x) => x * x)` callback
  idiom LLMs reliably produce — "AI agents are users") **without** the
  free-standing `=>` / match-arm collision, the paren-position backtracking, or
  the two-arrow eyesore that disqualify candidates 2–4.
- It is **purely additive**: the block form is untouched, so the parser
  dual-accepts from day one — **no dual-accept seed dance, no seed cut**
  (SFEP-0026 / `.claude/rules/seed-dependency.md`: the additive parser change and
  its example/test consumers **bundle in one PR**, since `compiler/src` authors
  no lambda expressions and the new compiler compiles the consumers in the same
  self-host pass).
- It carries **no self-hosting risk** (compiler source uses zero lambda
  expressions — §5) and lets the implementer rewrite the fragile return-type
  capture to the real type parser, retiring the **#1546** bug class.

**Declined:** full reform (replace `fn(...)`, §3.3–§3.5) — too costly, collision-
and reversibility-prone; defer-to-2.0 (§6) — leaves 1.0 with the most verbose
callback syntax of any mainstream language.

**Accepted residual risks** (revisit if they bite during implementation):

1. The `=>` token now carries two meanings (match-arm separator + lambda
   expr-body). Confined behind a committed `fn(...)` head it cannot
   cross-contaminate parsing, but it is a standing tax on future `match` /
   expression-grammar work. The `parser_lambda_arrow_vs_match` guard (§8) pins
   this.
2. The expression-bodied form has no clean slot for an explicit `![...]` effect
   annotation, so short lambdas rely on **effect inference**; the block form
   `fn(...) -> T ![io] { }` remains the explicit-annotation path. Acceptable for
   the callback case; a latent constraint on pillar-#1 lambda-effect tracking.

**Implementation** is a single additive follow-up issue (parser short-form +
formatter + tests + docs, bundled per the seed-dependency rule), `## Design:
SFEP-0029`. This SFEP flips to `Implemented` and sets `graduates-to:` the spec
lambda chapter when that PR lands and self-hosts.

## 11. Status — Implemented (2026-06-27, #1683)

Shipped end-to-end and self-hosts. `parse_lambda_expression`
(`compiler/src/parser/expressions.sfn`) accepts `fn(...) => expr` after the
head, desugaring the expression body to a single-`return` `Block` so
typecheck / effects / emit / lowering see a normal block (no AST node added).
The fragile return-type capture was rerouted through the real type parser
(`collect_type_annotation_until`), retiring the #1546 class. The formatter
round-trips both forms idempotently. Regression coverage:
`parser_lambda_body_test.sfn`, `parser_lambda_arrow_vs_match_test.sfn` (the
`=>` overload guard), and the `untyped_lambda_callback_test.sfn` e2e (the
`.map(fn(x) => x*x)` callback executes).

The headline callback case `.map(fn(x) => x*x)` additionally required typing
the untyped lambda from the callee signature — a **pre-existing**,
syntax-independent codegen gap (the untyped block form failed identically).
That fix was bundled into the same PR and is recorded in **SFEP-0032**
(untyped lambda parameter/return inference).
