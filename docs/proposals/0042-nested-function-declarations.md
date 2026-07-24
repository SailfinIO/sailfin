---
sfep: 0042
title: Nested / Local Function Declarations (non-capturing static `fn` items)
status: Implemented
type: language
created: 2026-07-05
updated: 2026-07-24
author: "agent:compiler-architect; human review"
tracking: "#1609, #1922, #1935, #1940, #1950"
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0042 — Nested / Local Function Declarations (non-capturing static `fn` items)

## 1. Summary

Allow a `fn name(params) -> T ![effects] { body }` declaration to appear in
**statement position** inside another function or lambda body. A nested `fn` is
a lexically-scoped **static** function (Rust's model): its name is visible
across the whole enclosing block (block-hoisted, so siblings may mutually
recurse and a nested `fn` may recurse into itself), and its body may reference
only its own parameters, module-level items, and other in-scope nested `fn`s —
**never** an enclosing local or parameter. Referencing an enclosing local is a
hard error (`E0421`) with a fix-it pointing at `let f = fn(...) => ...`, which
is Sailfin's existing capturing-lambda form. Nested `fn`s lift to plain
top-level functions with scope-qualified mangled names and are called by name
via ordinary static dispatch, so native-IR and LLVM lowering need no new code
for the by-name path. This SFEP is a slice of epic **#1609** (first-class
function values); using a nested `fn`'s bare name as a first-class value reuses
#1609's `{fnptr, null-env}` lowering and is gated on that item.

## 2. Motivation

Today, statement-position `fn name(...)` does not parse. `parse_block_statement`
(`compiler/src/parser/statements.sfn:198`) has arms for `let`, `for`, `loop`,
`routine`, `if`, `match`, `with`, `unsafe`, `return`, `throw`, `try`, `assert`,
and a `while` reserved-guard — but **no `fn` arm**. A `fn helper() { ... }`
inside a function body therefore falls through to `parse_expression_statement`
and hits the `E0818` "unstructured expression" backstop. The anonymous-lambda
parser (`parse_lambda_expression`, `parser/expressions.sfn:1877`) only matches
`fn(` with no name, so it does not catch this either.

This is a real ergonomic and readability gap. Programmers reach for a named
local helper to factor a multi-step body without polluting the module namespace
or dropping to a `let`-bound lambda (which reads as data, not as a definition,
and — per #1921 — could not self-recurse until recently because a `let` binding
is not in scope inside its own initializer). Every mainstream systems language
the target audience knows offers *some* form of this, and LLMs emit it
reflexively (see the AI-agents-are-users principle) — so the current failure is
a systematic `E0818` papercut in generated code.

### Go vs. Rust: why Sailfin picks Rust's model

There are two established designs:

- **Go** has *no* named nested function declarations. You write a closure
  literal bound to a variable: `helper := func(x int) int { ... }`. Closures
  capture the enclosing environment **by reference**, and self-recursion is
  awkward: you must pre-declare `var helper func(int) int` and then assign,
  because the name is not in scope inside the literal. The capture-by-reference
  default is also a well-known footgun (loop-variable capture).

- **Rust** has **non-capturing nested `fn` items** *and* separate closures. A
  nested `fn` is an ordinary static function that merely happens to be
  name-scoped to the enclosing block; it cannot see the enclosing dynamic
  environment, and referencing an enclosing local from a nested `fn` is a hard
  error (`E0434`, "can't capture dynamic environment in a fn item; use the ||
  { ... } closure form instead"). Capture is the closure's job. Nested `fn`
  items are block-hoisted, so they self- and mutually recurse with no
  forward-declaration ritual.

Sailfin already has the closure half of Rust's split: `let f = fn(x) => expr`
and the block form `let f = fn(x) -> T { ... }` capture enclosing variables
(SFEP-0029; capturing-lambda lifting in
`llvm/expression_lowering/native/lambda_lowering.sfn`). What it lacks is the
**named static** half. Adopting Go's capturing-closure-only model would either
duplicate what `let`-lambdas already do or silently make `fn name` capture —
reintroducing the by-reference footgun and forcing a heap-allocated environment
behind a construct that reads like a plain function. Rust's split is the honest
fit: `let`-lambda when you need capture, nested `fn` when you need a named,
recursive, zero-overhead static helper. It also sidesteps the #1921 recursion
limitation structurally — a block-hoisted `fn` name is in scope inside its own
body, so `fn fib(n: int) -> int { ... fib(n - 1) ... }` just works, where the
`let`-lambda equivalent needs the (now-shipped but heavier) recursive-`let`
machinery.

## 3. Design

### 3.1 Semantics

- **Syntax.** `fn name(p1: T1, p2: T2, ...) -> R ![e1, e2] { body }` in
  statement position, identical to a top-level function declaration. Return
  type and effect row are optional exactly as at top level.
- **Static, non-capturing.** The body's free names must resolve to one of:
  (a) the nested `fn`'s own parameters, (b) module-level items (imports,
  top-level functions, types, module constants), (c) sibling nested `fn`s in
  the same or an enclosing block, or (d) the nested `fn`'s own name
  (self-recursion). Any name that resolves to an **enclosing local or
  parameter** is rejected with `E0421` (§3.3).
- **Block-hoisted visibility.** All sibling nested `fn` names in a block are in
  scope across the entire block regardless of declaration order. Two siblings
  may mutually recurse. This is the item-hoisting rule, in deliberate contrast
  to the sequential `let` registration threaded through `walk_block_expressions`
  (`typecheck.sfn:1628-1640`, the #1921 model): a `let` is visible only *after*
  its declaration; a nested `fn` is visible *throughout* its block.
- **Nesting depth.** A nested `fn` may itself contain nested `fn`s. Names at
  each depth are block-scoped to that depth; an inner nested `fn` sees its
  enclosing nested `fn`s' names (they are module-level-equivalent static items
  from its perspective) but still not their locals.
- **Shadowing.** A nested `fn` name may shadow a module-level function of the
  same name within its block; resolution prefers the nearest enclosing block's
  nested `fn`. Two nested `fn`s with the **same name in the same block** are a
  duplicate-symbol error (`E0001`, via `make_duplicate_symbol_diagnostic` —
  `register_local_symbol` runs the dedup check for the `"function"` kind, unlike
  `"variable"`), just like two top-level
  functions.

```sfn
fn classify(values: int[]) -> string ![io] {
    // Block-hoisted: `is_even` is visible here even though it is
    // declared below, and the two siblings mutually recurse.
    fn is_even(n: int) -> boolean {
        if n == 0 { return true; }
        return is_odd(n - 1);        // sibling, declared later — OK
    }
    fn is_odd(n: int) -> boolean {
        if n == 0 { return false; }
        return is_even(n - 1);       // sibling — OK
    }

    fn describe(n: int) -> string {
        if is_even(n) { return "even"; }  // sibling nested fn — OK
        return "odd";
    }

    let mut out = "";
    for v in values {
        out = out + describe(v) + " ";   // by-name call — static dispatch
    }
    return out;
}
```

```sfn
fn bump(base: int) -> int {
    fn helper(n: int) -> int {
        return n + base;   // ERROR E0421: `base` is an enclosing parameter.
    }                       //  fix-it: bind a closure to capture it.
    return helper(1);
}
// Fix (capture is the lambda's job):
fn bump_ok(base: int) -> int {
    let helper = fn(n: int) => n + base;   // capturing let-lambda
    return helper(1);
}
```

### 3.2 Pipeline stages

#### S1 — Parser (`compiler/src/parser/statements.sfn`)

Add an `fn`-name dispatch arm to `parse_block_statement`, placed before the
`parse_expression_statement` fallthrough (before `statements.sfn:365`). Detect
the arm with two-token lookahead: `identifier_matches(token, "fn")` **and** the
next non-trivia token is an identifier (a *name*), which distinguishes a nested
declaration from an anonymous lambda expression `fn(` (whose next token is `(`).
When matched, delegate to the existing `parse_function` machinery
(`compiler/src/parser/declarations.sfn:806`) so the parsed `FunctionSignature` +
body is byte-for-byte the top-level shape, and wrap the result in
`Statement.FunctionDeclaration` (`ast.sfn:351`) — the same node the top-level
dispatch and the lambda-lift pass already produce. **No new AST node is
required.**

Modifier handling in v0 (reject cleanly rather than silently mis-handle):

- `async fn name(...)` at nested position → reject with a clear diagnostic
  (`async fn` is structural-only even at top level; nested async has no defined
  semantics). Recommend routing through the reserved-guard style (return
  `success: false` so typecheck emits a targeted message).
- Decorators on a nested `fn` (`@foo fn name`) → reject in v0. `parse_decorators_stub`
  already runs at the top of `parse_block_statement`; if decorators are present
  on the `fn` arm, return the not-success sentinel and let typecheck report
  "decorators are not supported on nested functions (yet)".
- `unsafe fn name(...)` → the top-level `parse_function` already threads
  `is_unsafe`; a nested `unsafe fn` is trivially supported (the body's
  `unsafe`-gated operations are checked as usual), so accept it. The `unsafe`
  *block* arm (`statements.sfn:290`) is unaffected — that matches `unsafe {`,
  not `unsafe fn`.

#### S2 — Typecheck + scope (`compiler/src/typecheck.sfn`, `typecheck_captures.sfn`)

Three sub-changes, all additive:

1. **Body typecheck already largely works.** `check_statement` has a
   `FunctionDeclaration` arm (`typecheck.sfn:540-567`) that registers the name
   into the **lexical `bindings` scope** via `register_local_symbol` (correct —
   lexically scoped, *not* `top_level`/global) and calls `check_function_body`.
   `check_block` (`typecheck.sfn:908-925`) recurses generically over statements.
   So once S1 emits the node, signature + body checking flows through unchanged.

2. **Block-hoisting (two-pass block walk).** `check_block` and
   `walk_block_expressions` currently register bindings **sequentially** as they
   iterate. Add a pre-pass over each block's statements that registers *all*
   sibling `FunctionDeclaration` names into the block scope **before** any body
   is walked. Concretely: before the per-statement loop in `check_block`
   (`typecheck.sfn:913`) and in `walk_block_expressions` (`typecheck.sfn:1630`),
   iterate the statements once and `register_local_symbol(..., "function", ...)`
   every `FunctionDeclaration`; then run the existing body loop. This makes a
   sibling declared *later* resolvable from an *earlier* sibling's body and
   makes each nested `fn` self-visible. `let`s keep their sequential
   registration (the pre-pass only hoists `FunctionDeclaration`s).

3. **E0420 walk recursion + capture rejection (new).**
   `walk_statement_expressions` (`typecheck.sfn:1644-1730`) — the walk that
   resolves identifiers and emits `E0420` on an undefined name — has **no
   `FunctionDeclaration` arm** and falls through to `return []` (line 1729), so
   nested `fn` bodies are never descended by the resolution walk. Add a
   `FunctionDeclaration` arm that walks the body **in a scope that deliberately
   excludes enclosing locals/parameters**: the arm builds a fresh binding scope
   containing only (a) the nested `fn`'s own parameters, (b) module-level items
   (already in `ctx` via the top-level/import tables), and (c) the block-hoisted
   sibling nested-`fn` names, then runs the block walk under that scope. Any
   identifier that would have resolved against an *enclosing local* is now
   unresolved in this restricted scope → the walk emits the new **`E0421`**
   (§3.3) instead of `E0420`, so the diagnostic can carry the capture-specific
   message and fix-it. `typecheck_captures.sfn::walk_statement` already has a
   `FunctionDeclaration` arm (`typecheck_captures.sfn:277-280`) that extends the
   scope with the fn's parameters and walks the body — reuse its
   `extend_with_parameters` shape to build the restricted scope.

#### S3 — Emit / lift (`compiler/src/llvm/expression_lowering/native/lambda_lowering.sfn`, called from `emit_native.sfn`)

Reuse the **shape** of `lift_non_capturing_lambdas` (`lambda_lowering.sfn:123`,
invoked from `emit_native.sfn:111,166`) but with a simpler target. That pass
rewrites lambdas into a `Raw` closure-pair marker plus a synthesized top-level
`Statement.FunctionDeclaration` appended to `program.statements`. For a nested
`fn`:

- **Lift to a plain top-level function** — no `__env` parameter, no `{i8*, i8*}`
  closure-pair marker, no `Raw` rewrite of the call site's *value*. The nested
  `FunctionDeclaration` is hoisted verbatim to `program.statements` under a
  mangled name, and by-name call sites are rewritten to call that mangled name
  directly.
- **Rewrite by-name call sites.** Within the enclosing function (and inner
  nested fns), a `Call` whose callee identifier resolves to a nested `fn` gets
  its callee name rewritten to the mangled name. This is a name substitution in
  the lift walker, keyed by the scope-qualified resolution built in S2.

Once lifted, everything downstream is flat and name-based:
`native_ir.sfn` and `llvm/lowering/entrypoints.sfn` see an ordinary top-level
function and an ordinary named call. **Zero new native-IR or LLVM code for the
by-name path.**

**Mangling (must be collision-safe).** The lambda counter `sfn_lambda_<N>`
(`lambda_lowering.sfn:230`) is module-monotonic and safe only because lambdas
are anonymous. Two different outer functions each declaring `fn helper()` would
collide once flattened into the single top-level symbol namespace. Scheme:

```
sfn_nested_<enclosing_chain>_<name>_<N>
```

- `<enclosing_chain>` is the `_`-joined chain of enclosing function names from
  outermost to the immediate parent (e.g. `classify` for a top-level parent,
  `classify_describe` for a fn nested inside `describe` inside `classify`),
  giving human-readable symbols and deterministic disambiguation across
  different outer functions.
- `<name>` is the nested fn's source name.
- `<N>` is a **module-monotonic counter** (a sibling of the lambda counter,
  threaded through `LiftContext`) appended unconditionally. It is the actual
  uniqueness guarantee: it disambiguates same-name nested fns living in
  *different* blocks of the same enclosing chain (e.g. one in an `if` arm and
  one in an `else` arm both named `helper`), which the chain prefix alone cannot
  separate. Same-name siblings *in the same block* are already a duplicate-symbol
  error in S2 (E0001), so they never reach mangling.
- **Deeper nesting** composes naturally: an inner nested fn's chain includes its
  outer nested fn's source name, and each level draws its own `<N>`.

#### S4 — Lowering (`compiler/src/llvm/lowering/entrypoints.sfn`)

- **By-name calls: free.** A lifted nested fn is a top-level function; a
  rewritten call is an ordinary named `Call`. Nothing to add.
- **Name-as-value: gated on #1609.** Using a nested fn's *bare name* as a
  first-class `fn(...)` value (assigning it, passing it as an argument) is the
  same problem as using a top-level function name as a value, which #1609 owns:
  the target lowering is `{fnptr, null-env}` via the dispatch seam at
  `llvm/expression_lowering/native/core_call_emission.sfn` and env-struct
  emission in `llvm/closures.sfn`. #1609 lists "named fn → typed `fn(...)`
  value, lowered to `{fnptr, null-env}`" as **unshipped** — the typed-value path
  currently errors via the `#1147` `E0808` guard, and only `as *u8` referencing
  works. Therefore **name-as-value for nested fns is explicitly deferred to
  after #1609's named-fn-value item lands** (Sub-issue B, §Decomposition). The
  by-name path (S1–S3 + S4-by-name) ships independently and first.

#### S5 — Tests, docs, graduation

Regression tests (§8), `docs/status.md` row, a spec/preview chapter, and
flipping this SFEP to `Implemented` once the checklist (§7) is met end-to-end.

### 3.3 New diagnostic: E0421

**Code:** `E0421` (verified free: `E04xx` currently uses `E0400`–`E0403`,
`E0410`, `E0411`, `E0420`; grep found no `E0421`). E0421 is emitted from the
same resolution walk that emits `E0420` (`typecheck.sfn`), so it is the natural
adjacent code even though the `E04xx` range is nominally "effect violations" —
`E0420` (undefined name) and `E0410`/`E0411` (reserved statements) already
demonstrate that the resolution/statement diagnostics live in this range. Home:
`typecheck.sfn` (emit) + `diagnostics_render.sfn` (render), mirroring `E0420`.

**Message:** `nested \`fn\` cannot capture \`<name>\` from the enclosing scope`.
**Fix-it:** `bind a closure to capture it: \`let f = fn(...) => ...\``. This
mirrors Rust `E0434`.

### 3.4 Same-name shadowing and sibling-scope resolution (resolved)

Nested-fn resolution keys by **source name** in three places built during
Sub-issue A: the typecheck scope (`_build_nested_fn_scope`), the emit rename map
(`_lookup_nested_rename`), and the routine-local effect table
(`_local_effect_table`). Nested fns lifted to distinct mangled symbols are
collision-free, and lexical shadowing **between nested fns** is handled (inner
scope wins: the rename lookup scans innermost-first, and sibling scope entries
are ordered to shadow module-level names). Two classes of edge case beyond
distinct-name nested fns — a nested fn name colliding with a **value binding**,
or with a same-named fn in a **sibling block** — needed scope-aware keying. They
were closed across two PRs.

**Closed by #1940** (the Sub-issue A follow-up):

1. **Emit rename vs. a value-binding shadow.** Sailfin lets a local value binding
   shadow a nested fn name (`fn helper() { … } let helper = fn(x) => x;
   helper(1)`); typecheck resolves `helper(1)` to the `let`, but the emit rename
   — keyed only by callee name — used to rewrite the call to the lifted nested
   symbol. The lift walker now skips the rename when a local/param binding
   shadows the name at the call site (`lambda_lowering.sfn`, the `NestedRename`
   shadow sentinel).
2. **Block-scoped effect resolution for the enclosing routine.** The routine's
   own requirement walk now hoists each block's direct fns
   (`_hoist_block_local_fns` in `collect_effects_from_block`), so a call resolves
   to the `fn` in its nearest enclosing block rather than to one flat
   routine-wide row.

**Closed by #1950** (two narrower residuals surfaced in #1940's review — both
non-blocking: (a) unsound but contrived, (b) a spurious diagnostic only):

- (a) **Deferred sibling resolution.** A nested fn's own body was still analyzed
  against the flat routine-wide table, so a call to a same-named **sibling** in a
  different scope could mis-resolve (last-write-wins). Deferred analysis now
  seeds each nested fn's body with the effect table of its lexically enclosing
  scope (`ScopedFn` in `effect_checker.sfn`), so a sibling call resolves by
  scope.
- (b) **Effect-side value-binding shadow.** The effect checker now mirrors (1) on
  the emit side: a `let`/parameter that shadows a same-named nested `fn` zeroes
  that fn's effect row for calls in its scope (position-sensitive for a `let`,
  whole-body for a parameter), so the caller is not required to declare an effect
  it does not incur.

Distinct-name nested fns — the overwhelmingly common case — were never affected.

## 4. Effect & capability impact

There is a **live effect-checker bug that this SFEP must fix**, independent of
the parser gap. `effect_checker.sfn::collect_effects_from_statement`
(`effect_checker.sfn:605-607`) has a `FunctionDeclaration` arm that *inlines*
the nested body's effects into the enclosing block's requirement:

```sfn
if statement.variant == "FunctionDeclaration" {
    return collect_effects_from_block(statement.body, imports);
}
```

This treats a *declaration* as if it were *inline-executed* — so a
declared-but-uncalled `fn foo() ![io] { print.info("x"); }` would wrongly force
`![io]` onto its parent function. That is unsound for the new construct (and is
latent today for the lambda-lifted nodes that flow through this arm).

**Fix.** A nested `fn` declaration contributes **no** effect requirement to its
enclosing block on its own — only a **call** to it does, via the ordinary
transitive call rule (a caller must declare the callee's effects). Two coupled
changes:

1. **Stop inlining.** The `FunctionDeclaration` arm in
   `collect_effects_from_statement` must return the empty requirement for the
   *declaration* (the nested body is effect-checked as its own deferred
   function, not merged into the enclosing block). The nested body still gets
   its own effect check — that its declared row covers what it does — via the
   deferred-function path below.
2. **Register nested fn effect signatures for call-site transitivity.** The
   local-function effect table is built by `_merge_local_functions` /
   `analyze_statement`, which iterate `program.statements` at **top level only**,
   so a nested fn's own effect row is absent and a call to it cannot be checked
   transitively. Add a recursive collection pass that walks into
   `FunctionDeclaration` bodies and registers each nested fn's effect signature
   into the local-function effect table, **keyed by the same scope-qualified /
   mangled name S3 assigns** (so the post-lift call site — which now targets the
   mangled name — resolves to the right row). Because S3 lifts nested fns to
   top-level functions, an alternative valid ordering is to run effect analysis
   *after* the lift, when the nested fns are already flat top-level entries with
   ordinary rows; the SFEP permits either, but the keying must agree with the
   name the call site ends up using.

Net effect-system behaviour after the fix:

- A nested `fn foo() ![io]` that is never called imposes no effect on its parent.
- A parent that *calls* `foo()` must declare `![io]` (or transitively inherit
  it), exactly like calling any other effectful function.
- Effect lists stay alphabetical per `code-style.md`; no new effects, no new
  capability surface — this is a pure name/scope construct.

## 5. Self-hosting impact

Passes touched, in pipeline order: **parser** (`statements.sfn`, new dispatch
arm), **typecheck** (`typecheck.sfn` block-hoist pre-pass + E0421 walk;
`typecheck_captures.sfn` scope reuse), **effect checker** (`effect_checker.sfn`
inline-bug fix + nested-signature registration), **emitter/lift**
(`lambda_lowering.sfn` plain-fn lift + mangling). Native IR and LLVM lowering
are **unchanged** for the by-name path (the lift makes nested fns
indistinguishable from top-level fns downstream).

Each stage self-hosts on its own:

- S1 is **additive** — the old seed's parser is unaffected; the new parser only
  *adds* recognition of a form the old one rejected. The compiler source does
  **not** need to *use* nested fns for the new compiler to build (they are opt-in
  syntax). So `make compile` builds the new compiler from the *old* pinned seed
  with no seed-cut required (see §Decomposition).
- S2/S3/S4-by-name build on S1 in the **same** self-host pass — the freshly
  built compiler (from the old seed) is the one that would later compile any
  compiler source adopting the feature.
- The compiler may adopt nested fns in its own source **later**, but need not; a
  first-class candidate is refactoring the many `_`-prefixed module-private
  helpers that exist only to serve one caller, but that is a follow-up, not a
  requirement of this SFEP. Adopting them only becomes safe once the feature is
  in the **pinned** seed.

## 6. Alternatives considered

- **Go-style capturing sugar (`fn name` captures by reference).** Rejected. It
  duplicates the existing `let`-lambda capture path, reintroduces the
  by-reference-capture footgun, and hides a heap-allocated environment behind a
  construct that reads as a plain static function. It also muddies the
  effect/ownership story (a capturing `fn` would need env lifetime analysis).
  Sailfin already has capture — via `let`-lambdas — so the missing half is
  precisely the *non-capturing named* one.
- **Desugar nested `fn` to a `let`-bound lambda.** Rejected as the *primary*
  model because a named `fn` is semantically distinct: (a) **recursion** — a
  block-hoisted `fn` name is in scope in its own body with zero ceremony, where
  a `let`-lambda needed the heavier recursive-`let` machinery (#1921) and reads
  as data; (b) **no hidden heap** — a nested `fn` lifts to a plain top-level
  function with a raw `fnptr`, never a `{fnptr, env}` pair or an env allocation,
  so it is strictly zero-overhead; (c) **intent** — `fn` announces "a definition"
  where `let f = fn ...` announces "a value". Users pick the tool by whether they
  need capture, not by accident of desugaring.
- **New AST node for nested functions.** Rejected — `Statement.FunctionDeclaration`
  already carries everything needed (signature, body, `is_unsafe`, decorators),
  is already produced by the lambda-lift pass, and is already handled by
  `check_statement` and `typecheck_captures.walk_statement`. Reusing it keeps
  the blast radius minimal.
- **Allow decorators / `async` on nested fns in v0.** Deferred — no defined
  semantics yet; rejecting cleanly (§S1) is honest and reversible.

## 7. Stage1 readiness mapping

- [ ] **Parses** — new `fn`-name arm in `parse_block_statement` (S1).
- [ ] **Type-checks / effect-checks** — block-hoist pre-pass, E0421 capture
  rejection (S2); effect-inline bug fix + nested-signature registration (S4/§4).
- [ ] **Emits valid `.sfn-asm`** — lift to plain top-level fn; downstream
  `native_ir.sfn` unchanged (S3).
- [ ] **Lowers to LLVM IR** — by-name path free; name-as-value gated on #1609
  (S4).
- [ ] **Regression coverage** — unit (parser/typecheck/effects) + integration +
  e2e (§8).
- [ ] **Self-hosts** — additive syntax, no seed cut for Sub-issue A (§5,
  §Decomposition).
- [ ] **`sfn fmt --check` clean** — every touched `.sfn` file formatted.
- [ ] **Documented** — `docs/status.md` row + spec/preview chapter (S5).

## 8. Test plan

Unit (`compiler/tests/unit/`):

- **Parser** — `fn name(...) { }` in a function body produces
  `Statement.FunctionDeclaration`; anonymous `fn(` in the same body still parses
  as a lambda (dispatch disambiguation); a nested `fn` inside a lambda body
  parses; the old `E0818` no longer fires for the nested-fn form.
- **Block-hoisting** — two sibling nested fns mutually recurse (forward
  reference resolves, no `E0420`); a nested fn self-recurses; a nested fn is
  callable from an earlier sibling's body.
- **Capture rejection** — a nested fn body referencing an enclosing `let`
  emits `E0421` with the fix-it; referencing an enclosing *parameter* emits
  `E0421`; referencing its own param / a module-level fn / a sibling nested fn
  does **not** emit `E0421`.
- **Duplicate name** — two same-name nested fns in one block emit the existing
  duplicate-symbol diagnostic (E0001).
- **Effect checker** — a declared-but-uncalled nested `fn foo() ![io]` does
  **not** force `![io]` on its parent (regression for the `effect_checker.sfn:605`
  bug); a parent that *calls* `foo()` without `![io]` gets the effect diagnostic;
  with `![io]` it passes.

Integration (`compiler/tests/integration/`):

- Mangling collision — two different outer functions each declaring `fn helper()`
  both compile and dispatch to the correct body (distinct mangled symbols).
- Nested-in-nested — a fn nested two levels deep lifts and calls correctly.

E2e (`compiler/tests/e2e/`, `*_test.sfn` per `no-bash-e2e.md`):

- Build-and-run a fixture using mutually-recursive nested fns; assert program
  output.
- Snapshot the emitted top-level symbol names to pin the mangling scheme.

## 9. References

- **Epic #1609** — First-class function values (this SFEP is a slice; owns the
  `{fnptr, env}` ABI, the `core_call_emission.sfn` dispatch seam, `llvm/closures.sfn`
  env emission, and the unshipped named-fn → `{fnptr, null-env}` value item that
  Sub-issue B depends on). SFEP-0030 (`0030-first-class-function-values.md`).
- **#1917** — parameter-scope resolution gap (sibling of the block-scope work).
- **#1921** — sequential `let` registration / recursive-`let` limitation
  (contrast for the block-hoisting rule).
- **#1922** — related scope/resolution work.
- **#1147** — the `E0808` guard that currently blocks the typed named-fn-value
  path (relevant to Sub-issue B's gating).
- **#1118** — related function-value work.
- **Rust `E0434`** — "can't capture dynamic environment in a fn item; use the
  `|| { ... }` closure form instead" — the prior art for the capture-rejection
  model and the E0421 fix-it.
- SFEP-0029 (`0029-lambda-syntax.md`) — the capturing-lambda short form that
  E0421 points users toward.

---

## Appendix: sub-issue decomposition for `/groom` (epic #1609)

Per `.claude/rules/seed-dependency.md`, bundle a capability with its single
consumer unless there is a genuine multi-consumer or independence reason to
split. The natural cut here is **by-name vs. as-value**, because the as-value
path has a real external dependency (#1609's named-fn-value item) while the
by-name path is self-contained.

### Sub-issue A — nested `fn` called by name (ship first) — Size: **M**

Scope: S1 (parser arm) + S2 (block-hoist pre-pass, E0421 capture rejection,
walk recursion) + S3 (plain-fn lift + scope-qualified mangling) + S4-by-name
(free) + §4 effect-checker fix (stop inlining, register nested signatures).
Clears the `E0818` backstop for statement-position `fn name`. Delivers the whole
user-visible feature *except* using a nested fn's bare name as a value.

**Bundling / seed-cut analysis.** Sub-issue A is **one PR, no seed cut.** It
introduces a parser capability (the `fn`-name arm) and its own consumers
(typecheck/effects/emit) in the *same* change. The compiler source does not need
to *use* nested fns for the new compiler to build, so `make compile` builds the
new compiler from the **old pinned seed**, and that freshly built compiler
compiles the feature's own tests in the same self-host pass. There is no
capability that a *separate downstream consumer* needs present in the pinned
seed, so nothing here forces a `/pin-seed`. Splitting S1 from S2/S3 would
manufacture exactly the seed-cut gate the rule warns against — keep them
bundled.

### Sub-issue B — nested `fn` as a first-class value — Size: **S**

Scope: allow a nested fn's bare name in value position (assignment, argument),
lowering to `{fnptr, null-env}` via #1609's dispatch seam, and lifting the
`E0808`/#1147 guard for this case.

**Dependency.** `## Required in pinned seed:` — **blocked by #1609's named-fn →
`{fnptr, null-env}` value item.** Carry `## Blocked by: #1609`. Because B's
enabling capability is owned by #1609 (a separate, multi-consumer capability —
top-level *and* nested fn names both use it), this is the legitimate split: B is
not bundled into A, and the seed advance that B needs rides the next scheduled
cadence bump once #1609's item lands, per the split branch of the
seed-dependency tree. B is small once the lowering exists — mostly lifting the
guard for the nested case and a resolution tweak so a nested fn name resolves in
value position.
