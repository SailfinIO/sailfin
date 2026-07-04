---
sfep: 0041
title: Unified expected-type + typing-environment context for the typecheck walk
status: Implemented
type: tooling             # a compiler-internal refactor; no user-facing surface
created: 2026-07-04
updated: 2026-07-04
author: "agent:compiler-architect; human review"
tracking: "#1900, #1904, #1905"
supersedes:
superseded-by:
graduates-to: "docs/status.md (E0828 object-literal coverage); SFEP-0039 §3.2"
---

# SFEP-0041 — Unified expected-type + typing-environment context for the typecheck walk

> Addendum to SFEP-0039 (`0039-nominal-object-model.md`). This is a
> compiler-internal refactor, not a language change, so it is deliberately
> lighter than a full feature SFEP. It defines the abstraction that lets the
> `E0828` bare-object-literal rule (and its future siblings) be applied
> uniformly at every position instead of being bolted on one issue at a time.

## 1. Summary

SFEP-0039 §3.2 introduced `E0828` — a bare object literal `{ ... }` requires a
concrete-`struct` target. It shipped (#1899) at exactly **one** position: the
`let` site (`typecheck.sfn:450`). The residual positions were split into three
issues — array/generic-head normalization + parameter defaults (#1900), return
position (#1904), lambda body/return (#1905) — and each is being handled
individually, with more positions still to come (struct-field defaults,
generic-instantiation arguments, call arguments).

The root cause is a **missing abstraction, not four bugs**: the typecheck walk
has no unified channel for the type an expression is *expected* to have, nor a
bundled typing environment. Each position that wants to consult the expected
type has to re-thread whatever it needs by hand, and two of the walk families
(statements vs. expressions) carry *different, coincidentally-overlapping*
positional parameter lists, so a position reachable only through the lighter
expression family (lambda bodies) literally cannot see `top_level` or the
enclosing return type.

This addendum defines a single `TypeckCtx` record — the typing environment plus
an `expected_type` / `enclosing_return_type` channel — threaded through both
walk families, mirroring Rust's `FnCtxt` + `Expectation` and Go's assignment
target propagation. It then folds the three open residual issues (#1900, #1904,
#1905) into staged consumers of that channel.

## 2. Motivation

### 2.1 The status quo is per-position hand-threading

The single consumption point today is `check_object_literal_target(initializer,
annotation, anchor_name, anchor_span, top_level)` (`typecheck_types.sfn:425`).
It is a clean, testable classifier. The problem is entirely *upstream* of it —
getting the right `annotation` (the expected type) and `top_level` to each call
site:

- **`let` (works, #1899).** `check_statement`'s `VariableDeclaration` branch
  (`typecheck.sfn:445-454`) has both the annotation (`statement.type_annotation`)
  and `top_level` locally, so it just calls the classifier.
- **Return (#1904, not done).** The `ReturnStatement` branch
  (`typecheck.sfn:720-724`) only calls `walk_expression`. The enclosing function's
  declared return type lives in `check_function_body`'s `signature.return_type`
  (`ast.sfn:270`) but is **never threaded down** through `check_block` →
  `check_statement`. So the return position has no expected type to hand the
  classifier.
- **Lambda body / return (#1905, not done).** Lambda bodies are walked *only*
  through the lighter expression family — `walk_expression` (`typecheck.sfn:1008`)
  → `walk_block_expressions` (`:1492`) → `walk_statement_expressions` (`:1503`)
  — which takes `(… , bindings, imports)` and has **no `top_level` and no
  return-type** parameter at all (see the comment at `:1489-1491`). The
  lambda-body `let` twin (`:1513-1517`) therefore runs the bare-fn and
  intersection checks but *cannot* call `check_object_literal_target` (no
  `top_level`). The `Lambda` branch already reads `expression.return_type`
  (`ast.sfn:78-93`) for the bare-fn/intersection checks, but has nowhere to
  route it as an enclosing return type.
- **Parameter defaults (#1900, not done).** `Parameter.default_value`
  (`ast.sfn:216`) is a bare-object-literal position classified against
  `parameter.type_annotation`; `seed_parameter_scope` (`typecheck.sfn:783`) has
  both in hand but never runs the classifier.
- **Coming next.** Struct-field defaults (blocked — `FieldDeclaration`
  (`ast.sfn:247`) has no `default_value` field yet), generic-instantiation
  arguments, and call arguments each add another position that will want the
  same channel.

Each of these is the *same* question — "what type is this expression expected to
be, and is a bare object literal legal there?" — asked at a different node.
Solving them one issue at a time re-derives the plumbing five times and leaves
the two walk families permanently divergent.

### 2.2 Why the two families diverged

`check_statement` / `check_block` / `check_function_body` carry the full
resolution environment: `interfaces`, `top_level`, `scope_start`,
`is_top_level`. `walk_expression` / `walk_block_expressions` /
`walk_statement_expressions` carry only `bindings` and `imports`. They share
`bindings`/`imports` **by coincidence**, not by design — the expression family
was introduced (`:1487-1491`) purely to recurse into lambda-body expression
positions and only ever needed the two symbols it happened to grab. That
coincidence is exactly the #1905 blocker: the family that walks lambda bodies is
the one missing `top_level`.

Unifying the environment into one record is therefore not just tidier — it is
the concrete fix for #1905, because it gives lambda-body walking `top_level` and
`enclosing_return_type` for the first time.

## 3. Design

### 3.1 The context record — `TypeckCtx`

A single plain record carries the typing environment and the expected-type
channel for **both** walk families. Every field type already exists in the
compiler, so the record is expressible under the current seed (it is the same
shape as `FunctionSignature`, `ast.sfn:266`, and `SymbolEntry`,
`typecheck_types.sfn:73` — plain records, no struct generics):

```sfn
// typecheck_types.sfn — the typing environment + expected-type channel
// threaded through the typecheck walk. One record serves both the
// statement/block family and the expression family; a given family reads
// only the subset it needs (unused fields are inert).
struct TypeckCtx {
    // --- typing environment (was loose positional params) ---
    bindings: SymbolEntry[];          // in-scope symbols for the current frame
    imports: ImportSymbolTable;       // localized import/effect table
    interfaces: Statement[];          // interface decls (statement family only)
    top_level: SymbolEntry[];         // #812 resolution-only top-level scope
    is_top_level: boolean;            // statement family: top-level vs nested
    scope_start: int;                 // shadowing boundary for register_local_symbol

    // --- expected-type channel ---
    enclosing_return_type: TypeAnnotation?;  // declared return type of the
                                             // innermost enclosing fn/lambda;
                                             // ambient, stable across a body
    expected_type: TypeAnnotation?;          // the type the *current* expression
                                             // is expected to have, set by its
                                             // immediate syntactic parent
}
```

**`expected_type` vs. `enclosing_return_type`.** They are different scopes of the
same idea:

- `enclosing_return_type` is **ambient** — set once when a function or lambda
  body is entered, unchanged for the whole body. It is *one producer* of
  `expected_type` (at a `return` statement, the expected type of the returned
  expression *is* the enclosing return type). It also gives the currently-dead
  `check_try_operator` (`typecheck.sfn:1299`) a natural live home later
  (§3.6).
- `expected_type` is **local** — the contextual type of the specific expression
  being checked right now, set by its immediate parent position (a `let`
  annotation, a return, later a call argument or field default) and cleared when
  recursing into a child position that imposes no contextual type (e.g. the
  operands of a `Binary`). Usually `null`.

For the positions wired in this addendum, every producer is *co-located* with
its consumer except the function-return → nested-return case, which is precisely
why `enclosing_return_type` is threaded as its own ambient field. `expected_type`
is the general channel reserved so the future positions (call args, field
defaults) plug in without another signature change.

**One record, both families.** The expression family reads the subset
`{bindings, imports, top_level, enclosing_return_type, expected_type}`; the
statement family additionally reads `{interfaces, scope_start, is_top_level}`.
Carrying inert fields in one family is free and is the standard shape (Rust's
`FnCtxt` carries the whole environment; `check_expr` takes an `Expectation`).
Crucially, unifying the record is what finally gives lambda-body walking
`top_level` + `enclosing_return_type` — the fix for #1905.

### 3.2 Constructors / derivation helpers

Because Sailfin records are constructed by literal, ctx derivation is a set of
small pure helpers (all in `typecheck_types.sfn`), so no call site hand-copies
eight fields:

```sfn
fn make_typeck_ctx(bindings, imports, interfaces, top_level, is_top_level) -> TypeckCtx
    // root: scope_start = 0, enclosing_return_type = null, expected_type = null

fn ctx_with_bindings(ctx: TypeckCtx, bindings: SymbolEntry[], scope_start: int) -> TypeckCtx
    // entering a nested block scope (clone_bindings already done by caller)

fn ctx_enter_body(ctx: TypeckCtx, bindings: SymbolEntry[], return_type: TypeAnnotation?) -> TypeckCtx
    // entering a fn/lambda body: sets enclosing_return_type, clears expected_type

fn ctx_with_expected(ctx: TypeckCtx, expected: TypeAnnotation?) -> TypeckCtx
    // set the local expected type for a subexpression

fn ctx_no_expected(ctx: TypeckCtx) -> TypeckCtx
    // clear expected_type when recursing into a non-propagating child
```

### 3.3 The single consumption point stays put

`check_object_literal_target` (`typecheck_types.sfn:425`) remains the **only**
place that decides whether a bare object literal is legal, and its signature is
**unchanged**:

```sfn
fn check_object_literal_target(
    initializer: Expression?, annotation: TypeAnnotation?,
    anchor_name: string, anchor_span: SourceSpan?,
    top_level: SymbolEntry[]) -> Diagnostic[]
```

Keeping the classifier ctx-*agnostic* (it takes the resolved expected annotation
+ `top_level`, not the whole ctx) is deliberate: it stays a pure function
testable in isolation (the 7 existing unit tests keep compiling), and it forces
the *caller* — the position that knows its own expected type — to resolve the
annotation. The ctx's job is only to *deliver* the annotation and `top_level` to
call sites that previously couldn't reach them. Each caller supplies the
`annotation` argument from the right source:

| Position | `annotation` argument | `top_level` source | Closes |
|---|---|---|---|
| `let` (statement) | `statement.type_annotation` | `ctx.top_level` | shipped (#1899) |
| parameter default | `parameter.type_annotation` | `ctx.top_level` (in `seed_parameter_scope`) | #1900 |
| return (statement) | `ctx.enclosing_return_type` | `ctx.top_level` | #1904 |
| lambda-body `let` | `statement.type_annotation` | `ctx.top_level` | #1905 |
| lambda return | `ctx.enclosing_return_type` (= lambda return type) | `ctx.top_level` | #1905 |
| *future:* call arg | `ctx.expected_type` (param type) | `ctx.top_level` | — |
| *future:* field default | `field.type_annotation` | `ctx.top_level` | blocked on AST |

### 3.4 `_object_literal_head_type` normalization (rides along from #1900)

The classifier's head normalizer `_object_literal_head_type`
(`typecheck_types.sfn:405`) currently only strips a trailing `?`. #1900's design
requires two more cases, added here so the classifier is complete once and for
all before it is called from four more positions:

1. **Array short-circuit.** After trimming and `?`-stripping, if the target head
   ends in `[]` (an array type `T[]`), a bare object literal can **never**
   satisfy it — emit `E0828` (the un-inferable / mismatch form,
   `has_concrete_target = false`) **regardless of whether `T` is a struct**. Add
   a predicate `_object_literal_target_is_array(text)` and short-circuit in
   `check_object_literal_target` *after* the intersection check (so `E0829`
   precedence, SFEP-0039 §3.3, is preserved) and *before* head lookup.
2. **Generic-head base normalization.** If the (non-array) head contains `<`,
   strip the generic argument block (`Base<...>` → `Base`) and classify the
   base. Reuse the existing `extract_generic_argument_block` /
   `split_generic_argument_list` machinery (`typecheck_types.sfn:508`) or a
   simple substring-to-first-`<`. Effect: `Box<int>` where `Box` is a concrete
   `struct` compiles (sanctioned construction path); `Container<T>` where
   `Container` is an interface fires `E0828`.

Precedence inside the classifier is therefore: intersection (`E0829`, untouched)
→ array short-circuit (`E0828`) → generic-head strip → head lookup (interface →
`E0828`; struct / unknown / alias → conservative pass, unchanged).

### 3.5 How context flows through each family

**Statement/block family (has `top_level` today).** Replace the loose
`(bindings, interfaces, scope_start, imports, top_level, is_top_level)` tail on
`check_statement` / `check_block` / `check_function_body` with a single `ctx:
TypeckCtx`. `check_function_body` enters the body via `ctx_enter_body(ctx,
parameter_scope.bindings, signature.return_type)`; nested-block branches
(TestDeclaration `:618`, WithStatement `:633`, ForStatement `:639`, MatchStatement
`:654`, IfStatement `:667`/`:671`/`:680`, BlockStatement `:694`) derive child
ctxs via `ctx_with_bindings`. The `ReturnStatement` branch (`:720`) gains the
classifier call using `ctx.enclosing_return_type` + `ctx.top_level`.

**Expression family (lacks `top_level` today).** Replace `(bindings, imports)` on
`walk_expression` / `walk_block_expressions` / `walk_statement_expressions` /
`walk_match_pattern` with `ctx: TypeckCtx`. Most self-recursive calls pass `ctx`
unchanged (or `ctx_no_expected(ctx)` where a child imposes no contextual type).
The `Lambda` branch (`:1113`) enters the body with `ctx_enter_body(ctx,
<bindings + lambda params>, expression.return_type)`, so nested returns inside
the lambda see the lambda's return type as `enclosing_return_type`. The
`walk_statement_expressions` `ReturnStatement` branch (`:1507`) and the
lambda-body `let` twin (`:1513`) gain classifier calls, now that `top_level` is
reachable via `ctx`.

### 3.6 `check_try_operator` (out of scope, noted)

`check_try_operator` (`typecheck.sfn:1299`) is dead — only 7 unit tests call it;
the `TryOperator` branch (`:1202`) never does. With `ctx.enclosing_return_type`
now threaded, wiring it live is a natural follow-up (its `enclosing_return_type`
argument is exactly the new ctx field). It is **explicitly out of scope** here to
keep the refactor tight; it stays dead, and this SFEP just records that the ctx
gives it a live home whenever `?`-operand-type inference lands (#829).

### 3.7 Staged implementation plan

Each stage self-hosts (`make compile` green) on its own; stages are independently
mergeable and ordered by increasing blast radius.

- **Stage A — classifier completion (closes #1900).** Add
  `_object_literal_target_is_array`, the array short-circuit, and generic-head
  base normalization to `check_object_literal_target` / `_object_literal_head_type`
  (`typecheck_types.sfn`). Add the parameter-default classifier call in
  `seed_parameter_scope` (`typecheck.sfn:783`) — it already has
  `parameter.type_annotation`, `parameter.default_value`, and `top_level`; **no
  ctx needed**. Purely additive to behavior; no signature churn.
- **Stage B — introduce `TypeckCtx`, migrate the statement/block family (closes
  #1904).** Add the record + helpers (§3.1–3.2). Flip `check_statement` /
  `check_block` / `check_function_body` to take `ctx`. This trio is a closed
  mutually-recursive cluster in one file, so all ~15 internal call sites (`:418`,
  `:550`, `:618`, `:633`, `:639`, `:654`, `:667`, `:671`, `:680`, `:694`, `:767`,
  `:808`) change in one atomic edit. Construct the root ctx at the two entries:
  the program walk (`:418`) and the method body (`:550`). Wire the return-position
  classifier call. **Bridge:** statement-family calls into the still-unmigrated
  expression family pass `ctx.bindings, ctx.imports` (additive, self-hosting).
- **Stage C — migrate the expression family (closes #1905).** Flip
  `walk_expression` / `walk_block_expressions` / `walk_statement_expressions` /
  `walk_match_pattern` to take `ctx` (~57 sites, mostly the mechanical
  `bindings, imports` → `ctx` transform). Remove the Stage-B bridges. Wire the
  `Lambda`-branch `ctx_enter_body`, the `walk_statement_expressions`
  `ReturnStatement` classifier call, and the lambda-body `let` classifier call.
- **Stage D — reserved extension channel (design-only here).** Document the
  call-argument (`ctx.expected_type` = parameter type) and struct-field-default
  (blocked on adding `FieldDeclaration.default_value`) consumers as the next
  positions to plug into the channel. No code in this SFEP.

## 4. Effect & capability impact

**None.** This is a compiler-internal refactor of the typecheck walk. It adds no
effects, no capabilities, no user-facing syntax, and does not touch the effect
checker. The only observable behavior change is *more* `E0828` diagnostics firing
at the return / lambda / parameter-default / array / generic-head positions that
SFEP-0039 §3.2 already specified but that shipped only at the `let` site.

## 5. Self-hosting impact

Only **typecheck** (`typecheck.sfn`, `typecheck_types.sfn`) changes; lexer,
parser, AST, effect checker, emitter, and LLVM lowering are untouched. Every
change is a plain record definition plus positional-parameter threading —
constructs the pinned seed has supported since long before this work.

Per `.claude/rules/seed-dependency.md`: **no seed dependency, no seed cut.**
`TypeckCtx` is *compiled by* the old seed, not *used by* it — `make compile`
builds the new compiler from the pinned seed, and that fresh compiler exercises
the new walk on its own source. Each stage is one self-contained PR whose `make
compile` builds green from the current seed; nothing here needs to be present in
the seed before its consumer lands. The self-host invariant (`make compile`
before commit; `make check` for the full gate) holds at every stage boundary
because each stage leaves the walk complete and every call site updated.

## 6. Alternatives considered

- **Keep two ad-hoc parameter-threadings (the status quo, rejected).** Thread
  `enclosing_return_type` through the statement family and `top_level` through
  the expression family as bare positional parameters, per-issue. Rejected: it
  re-derives the plumbing at every new position (five positions and counting),
  cements the two families' divergent shapes, and each future position (call
  args, field defaults) is another cross-family signature change. The user
  explicitly chose the unified context over this.
- **Two separate context records, one per family.** A `StmtCtx` and an `ExprCtx`.
  Rejected: doubles the surface, and the expression family's *missing* fields
  (`top_level`, `enclosing_return_type`) are exactly what #1905 needs — a separate
  `ExprCtx` that omits them just reproduces the bug. One record is what unblocks
  lambda bodies.
- **Put the expected type on the classifier signature (ctx-aware classifier).**
  Have `check_object_literal_target` take the whole `ctx`. Rejected: couples a
  pure, unit-tested classifier to the walk state and would churn the 7 existing
  unit tests for no gain. The caller resolves the annotation; the classifier
  stays pure.
- **A full bidirectional type inferencer now.** Overkill and off-roadmap: #829
  has no live inferencer, types are strings, and this SFEP needs only a
  contextual *expected type* channel, not inference. The channel is designed so a
  real inferencer can later populate `expected_type` without another refactor.

## 7. Stage1 readiness mapping

Internal refactor — no new user-facing feature, so parser/emitter/LLVM rows are
"unchanged" rather than "new work."

- [x] Parses — no syntax change.
- [ ] Type-checks / effect-checks — the deliverable: `E0828` fires uniformly at
  the return / lambda / parameter-default / array / generic-head positions via
  the unified channel.
- [x] Emits valid `.sfn-asm` — unchanged (rejected programs never reach the
  emitter; accepted programs emit identically).
- [x] Lowers to LLVM IR — unchanged.
- [ ] Regression coverage — per-position `assert_does_not_compile` (E0828) +
  positive `assert_compiles` cases; classifier unit tests for array / generic
  heads (§8).
- [ ] Self-hosts — `make compile` green after each of Stages A/B/C.
- [ ] `sfn fmt --check` clean on `typecheck.sfn`, `typecheck_types.sfn`.
- [ ] Documented — `docs/status.md` E0828 row updated to "all positions"; SFEP-0039
  §3.2 cross-links this addendum.

## 8. Test plan

Regression per position, extending the SFEP-0039 typecheck suite
(`compiler/tests/`):

- **Classifier units (Stage A)** in `typecheck_types`-level unit tests: array
  target `let x: Order[] = { ... }` → E0828 even when `Order` is a struct;
  generic head `Box<int>` (struct `Box`) compiles; `Container<T>` (interface
  `Container`) → E0828; `Named?` optional-interface unchanged; intersection
  `A & B` still yields E0829 (precedence).
- **Parameter default (Stage A):** `fn f(o: SomeInterface = { ... })` → E0828;
  `fn f(o: SomeStruct = { ... })` compiles.
- **Return (Stage B):** a function `-> SomeInterface { return { ... }; }` →
  E0828; `-> SomeStruct { return { ... }; }` compiles; a bare `{ ... }` returned
  where the enclosing return type is an array → E0828.
- **Lambda (Stage C):** a lambda `fn() -> SomeInterface { return { ... }; }` →
  E0828; a lambda-body `let bad: SomeInterface = { ... };` → E0828; the
  struct-target twins compile.
- **No-regression:** the existing `let`-site E0828 cases (#1899) and the 7
  `check_try_operator` unit tests stay green; a full `make check` triple-pass
  self-host confirms the compiler still type-checks its own source after each
  stage.

Use `assert_does_not_compile(source, "E0828")` / `assert_compiles(source, ...)`
from `sfn/test` per `.claude/rules/no-bash-e2e.md`.

## 9. References

- Parent: SFEP-0039 (`docs/proposals/0039-nominal-object-model.md`), §3.2 (`E0828`),
  §3.3 (`E0829` precedence).
- Issues: #1899 (shipped `let` site), #1900 (array/generic-head normalization +
  parameter defaults), #1904 (return position), #1905 (lambda body/return),
  #829 (`?`-operand inference — future `check_try_operator` consumer).
- Code: `typecheck.sfn` (`check_statement:444`, `check_block:802`,
  `check_function_body:765`, `seed_parameter_scope:783`, `walk_expression:1008`,
  `walk_block_expressions:1492`, `walk_statement_expressions:1503`,
  `check_try_operator:1299`); `typecheck_types.sfn`
  (`check_object_literal_target:425`, `_object_literal_head_type:405`,
  `ScopeResult:92`, `SymbolEntry:73`); `ast.sfn`
  (`FunctionSignature:266`, `Parameter:216`, `FieldDeclaration:247`).
- Prior art: Rust `FnCtxt` + `Expectation` (`check_expr_with_expectation`); Go
  assignment-target propagation.
- Process: `.claude/rules/seed-dependency.md` (no seed cut), SFEP-0001.
