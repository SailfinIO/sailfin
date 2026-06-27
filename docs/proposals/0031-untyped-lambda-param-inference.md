---
sfep: 31
title: Infer untyped lambda parameter and return types from the expected call-site function type
status: Implemented
type: language
created: 2026-06-26
updated: 2026-06-27
author: "agent:compiler-architect"
tracking: [1683]
supersedes:
superseded-by:
graduates-to: site/src/content/docs/docs/reference/spec/05-expressions.md
---

# SFEP-TBD — Infer untyped lambda parameter/return types from the expected call-site function type

> Design deliverable bundled into issue #1683 (the SFEP-0029 additive
> `fn(x) => expr` short-form implementation), per owner approval. This SFEP
> covers a **pre-existing, syntax-independent** codegen gap: an untyped lambda
> passed to a callback position lowers with the wrong LLVM parameter/return
> types and segfaults at runtime. The `=> expr` parser short form is already
> implemented and self-hosts; it is **out of scope** here.

## 1. Summary

An anonymous lambda whose parameters carry **no type annotation** — e.g.
`.map(fn(x) => x * x)` or its block-form twin `.map(fn(x) { return x * x; })` —
segfaults (exit 139) when passed to a builtin array method or a user
higher-order function. A **typed** lambda in the same position
(`.map(fn(x: int) -> int => x * x)`) works. The bug is therefore "untyped
lambda → wrong LLVM types", not specific to the new `=> expr` syntax: both body
forms fail identically.

Root cause (confirmed end-to-end): the lambda-lift pass synthesises the lifted
top-level function `sfn_lambda_<N>` by copying `lambda.parameters` and
`lambda.return_type` verbatim into a `FunctionSignature`
(`lambda_lowering.sfn:329` `_synthesize_lifted_function_with_captures`). For an
untyped lambda those annotations are `null`. The emitter then writes a `.param
<name>` line with **no `: type`** (`emit_native.sfn:777`), so the lifted
function's LLVM parameter defaults to the wrong type/width, while the `.map`
runtime dispatch calls it through the fixed closure ABI `i64(i8* env, i64)`
(`core_call_resolution.sfn`, `runtime_array_map_fn`). The type mismatch is the
segfault.

The fix is to **backfill the untyped lambda's `parameters[i].type_annotation`
and `return_type` from the expected function type available at the call site**,
*before* the lift pass runs, so the synthesised signature is fully typed and
lowers exactly as a typed lambda already does. The expected type comes from one
of two sources: (1) a user function/method parameter declared `fn(A0, …) -> R`,
or (2) a builtin array method (`.map`/`.filter`/`.reduce`) whose mapper
signature is fixed by the receiver's element type.

## 2. Motivation

### 2.1 The gap and who hits it

`.map(fn(x) => x * x)` is the single most common callback idiom — the one LLMs
reliably produce ("AI agents are users"), and the headline ergonomic win
SFEP-0029 was accepted to deliver. Shipping the `=> expr` short form while
untyped callbacks **segfault** would teach users (and agents) that the short
form is broken, when in fact the parser is correct and only the type backfill is
missing. Requiring `fn(x: int) -> int => x * x` to avoid a crash defeats the
entire ergonomic case.

This is also a **safety-claim** issue (CLAUDE.md "don't ship unfinished safety
claims"): a segfault is strictly worse than a clean "callee signature is not
known" diagnostic. Today the untyped path produces neither correct code nor an
honest refusal — it produces a crash.

### 2.2 Why a typed lambda already works

A typed lambda's `parameters[i].type_annotation.text` is `"int"` and its
`return_type.text` is `"int"`, so the lifted `.param x: int` line carries the
width, the lowering maps it to `i64`, and the closure ABI matches. The untyped
lambda differs *only* in that those two text fields are absent. The fix is to
make the untyped lambda **textually identical** to the typed one before lift —
nothing downstream changes.

## 3. Design

### 3.1 Where: a dedicated backfill pass before lift, in `emit_native`

Three candidate stages were weighed:

- **Typecheck** (`typecheck.sfn`): rejected. `walk_expression`'s Lambda arm
  (`typecheck.sfn:1007`) only descends into the body; it does **not** thread the
  callee signature into the argument walk, and adding call-site→argument type
  flow to typecheck is a much larger change (it is the `#829` expression-type
  inference work, explicitly out of scope). Typecheck also does not currently
  mutate the AST for codegen purposes.
- **`core_call_resolution.sfn` at lowering**: rejected as the *primary* site.
  By the time lowering runs, the lambda has **already been lifted** to a
  `sfn_lambda_<N>` whose signature was synthesised from the null annotations —
  the wrong-typed `define` is already emitted. The expected type *is* known here
  (this is where the element type and the mapper descriptor are derived), but
  the lifted function is upstream of it. Fixing it here would require
  re-synthesising the lifted function, which is exactly the lift pass's job.
- **A new backfill pass run immediately before `lift_non_capturing_lambdas`,
  inside `emit_native_with_module_name` / `emit_native_text_with_module_name`**:
  **chosen.** It walks `Call` nodes with knowledge of (a) the callee's declared
  parameter fn-types and (b) the array-builtin element rule, and writes the
  inferred `type_annotation` / `return_type` onto any untyped `Lambda` argument
  in place. The lift pass then synthesises a fully-typed signature with **zero
  changes to lift or lowering**. Because structs/arrays are reference types in
  this self-hosted compiler, the pass can mutate the shared AST in place (no
  functional-rebuild plumbing required), and it runs at emit time where the
  whole `Program` is in hand.

Concretely, `emit_native.sfn` gains one line at both entry points, immediately
before the existing `lift_non_capturing_lambdas(program)` call
(`emit_native.sfn:109` and `:159`):

```
let typed_program = backfill_untyped_lambda_types(program);
let lifted = lift_non_capturing_lambdas(typed_program);
```

The new pass lives in a new module
`compiler/src/llvm/expression_lowering/native/lambda_param_inference.sfn`
(peer of `lambda_lowering.sfn`), exporting one entry point
`backfill_untyped_lambda_types(program: Program) -> Program`.

### 3.2 What the pass walks

The pass is an AST walker shaped like `lambda_lowering.sfn`'s `_rewrite_*`
family (statements → blocks → expressions), but it only acts on **`Call`
expressions**. For each `Call`:

1. Resolve the **callee's expected parameter types** (§3.3): a `string[]` where
   entry `i` is the function-type text expected for argument `i`, or `""` when
   argument `i` is not a function-typed parameter.
2. For each argument that is an `Expression.Lambda` with **at least one untyped
   parameter or a null `return_type`**, and whose corresponding expected entry
   is a function-type text `fn(P0, …) -> R`, parse that text (§3.4) and assign:
   - `parameters[i].type_annotation = TypeAnnotation { text: Pi }` for each `i`
     where `parameters[i].type_annotation == null` and `Pi` exists. A param that
     is *already* annotated is left untouched (the annotation wins — typed
     lambdas are unchanged, satisfying the no-regression constraint).
   - `return_type = TypeAnnotation { text: R }` only when `return_type == null`.
3. Recurse into the (possibly updated) lambda body and all other sub-expressions
   so nested calls / nested lambdas are also covered.

Arity guard: if the lambda's declared parameter count does not match the
expected type's parameter count, **skip backfill for that argument** (leave it
as today) rather than guess — an honest no-op degrades no worse than the current
behaviour.

### 3.3 Obtaining the expected type for the two cases

**Case A — user function / method HOF parameter.** The callee of the `Call` is
an `Identifier` (free function) or a `Member` (method). The pass needs that
callee's `FunctionSignature.parameters`, each of whose
`type_annotation.text` is the function-type text `"fn(int) -> int"` when the
parameter is a callback. Build a **name → `FunctionSignature` table** by walking
the `Program`'s top-level `FunctionDeclaration`s (and struct
`MethodDeclaration`s, keyed `Struct.method`) in a single pre-pass over
`program.statements`, before the expression walk. Look the callee name up in the
table; the expected type for argument `i` is
`signature.parameters[i].type_annotation.text` (or `""` if null / out of range).
This reuses the *same* text the typed-lambda path already round-trips, so no new
type representation is introduced.

> Scope note: free functions and direct struct-method calls
> (`recv.method(cb)` where `recv`'s declared type is a known struct) are
> covered. Indirect/aliased callees (a callback stored in a variable then
> invoked, a callback returned from another call) are **deferred** — the pass
> simply finds no signature and no-ops, which is no worse than today.

**Case B — builtin array method (`.map`/`.filter`/`.reduce`).** The expected
mapper signature is fixed by the receiver's element type and is *already*
derived in `core_call_resolution.sfn` (the `_pre_am_elem == "i64"` gate that
selects `runtime_array_map_fn` et al.). For the **minimum viable scope** the
backfill mirrors that exact restriction — it only handles `i64`-element arrays
(`int[]`), which is the only element type the runtime mapper bodies support
today:

- `.map(cb)` on `int[]` → `cb` expected `fn(int) -> int`.
- `.filter(cb)` on `int[]` → `cb` expected `fn(int) -> boolean`.
- `.reduce(init, cb)` on `int[]` → `cb` (argument index 1) expected
  `fn(int, int) -> int` (acc, elem).

To know the receiver is an `int[]`, the pass inspects the `Member` callee's
`object`: when it is a simple `Identifier`, resolve its declared element type
from the enclosing function's parameter/local annotations. Rather than
re-implement binding resolution in this pass, the pass keys off the **same
signal the runtime path uses** — it conservatively backfills the array-builtin
case only when the element type is unambiguously `int`/`i64` from the receiver's
declared annotation (a literal `[1,2,3].map(...)` or a binding annotated
`int[]`). When the element type cannot be determined statically here, the pass
no-ops and the existing `core_call_resolution.sfn` path emits its honest "callee
signature is not known" diagnostic — **degrading no worse than today**. Non-`int`
element arrays (`string[]`, `float[]`, struct-element) are out of scope for both
the runtime mapper and this backfill (gated on generics, #766), exactly as the
runtime path already gates them.

### 3.4 Parsing the function-type text `"fn(int, string) -> bool"`

**No existing helper parses a fn-type text into parts.** The grep survey
confirms function types are mapped *wholesale* to the closure pair
`{i8*, i8*}` (`type_mapping.sfn:440`, `:626` — `starts_with(trimmed, "fn(")`);
nothing splits out the parameter list or return type. So this SFEP adds a small,
self-contained text splitter (no new grammar, no parser dependency), local to
the new module:

```
parse_fn_type_text(text: string) -> FnTypeParts   // { param_types: string[], return_type: string }
```

Algorithm (string-level, robust to nested generics):

1. Trim. Require a `fn(` (or `fn (`) prefix; otherwise return an empty/`ok:false`
   result and the caller no-ops.
2. Find the matching close paren for the opening `(` by **depth counting** over
   `(`/`)` *and* `<`/`>` (so a nested `fn(Map<string, int>) -> …` or
   `fn(fn(int) -> int) -> int` does not split on an inner comma). This is the
   same depth-balanced discipline `collect_type_annotation_until` already uses in
   the parser and `_encode_captures` relies on for markers.
3. Split the parameter slice on **top-level commas only** (depth 0 for both
   `()` and `<>`), trimming each segment. An empty slice → zero params.
4. After the close paren, look for the top-level `->`; the trimmed remainder is
   the return-type text. No `->` → return type is `""` (treated as void / left
   null; backfill only sets `return_type` when a non-empty `R` is found).

This splitter is **deliberately textual and total** — it never throws, returns
`ok:false`/empties on anything it does not recognise, and the caller treats a
non-parse as a no-op. Because the inputs it must handle are exactly the
function-type texts the *typed* lambda path already produces and the callee
signatures the compiler already stores, the common cases (`fn(int) -> int`,
`fn(int, int) -> int`, `fn(int) -> boolean`) are trivial; the depth counting
covers the few nested-generic shapes without a full type parser.

### 3.5 Worked example

Source: `let xs: int[] = [1, 2, 3]; let ys = xs.map(fn(x) => x * x);`

1. Parser desugars `=> x * x` to `{ return x * x; }`; the `Lambda` has one
   parameter `x` with `type_annotation == null` and `return_type == null`
   (SFEP-0029 path, already shipped).
2. **Backfill pass** sees `xs.map(<lambda>)`. Case B: `.map` on an `int[]`
   receiver ⇒ expected `fn(int) -> int`. `parse_fn_type_text` yields
   `param_types = ["int"]`, `return_type = "int"`. The pass sets
   `parameters[0].type_annotation = {text:"int"}` and
   `return_type = {text:"int"}` in place.
3. **Lift pass** synthesises `sfn_lambda_0(__env: i8*, x: int) -> int` — now
   textually identical to the typed-lambda case.
4. Emitter writes `.param x: int` / return `int`; lowering maps to
   `i64(i8* env, i64)`, matching the `runtime_array_map_fn` ABI. No segfault.

## 4. Effect & capability impact

None. The pass touches only `type_annotation` / `return_type` *text* on lambda
AST nodes for codegen typing; it runs at emit time, after effect checking, and
does not read, set, or alter any effect set, capability, or manifest. Lambda
effect tracking (the SFEP-0029 §4 future slot) is untouched.

## 5. Self-hosting impact

- **No self-hosting risk.** The compiler's own source uses **zero** lambda
  expressions (SFEP-0029 §5 — every `fn(` under `compiler/src/` is a comment or
  a function-pointer *type*, never a lambda value). So no `compiler/src/*.sfn`
  file is a consumer of this pass; the pass can never miscompile the compiler.
  The old seed compiles the new compiler regardless.
- **Additive and bundle-safe.** This is a pure additive codegen fix bundled into
  issue #1683 with the SFEP-0029 short form and its example/test consumers, in
  **one PR** (per `.claude/rules/seed-dependency.md`): `make compile` builds the
  new compiler from the old seed, and that compiler then compiles the new
  `.map(fn(x) => x*x)` examples/tests in the same self-host pass — **no seed cut,
  no `/pin-seed`**.
- **Typed-lambda behaviour is provably unchanged.** The pass only writes
  annotations that are currently `null`; a param/return that already has an
  annotation is skipped. A typed lambda has no null annotations, so it is a
  no-op on every existing typed path — the regression surface is empty by
  construction. (Pin this with the typed-lambda regression test in §8.)
- **Passes touched:** a new module
  (`lambda_param_inference.sfn`) and two one-line call sites in
  `emit_native.sfn`. Lift, emit, typecheck, effect-check, and LLVM lowering are
  otherwise unchanged.

## 6. Alternatives considered

- **Fix it in the lift pass directly** (thread expected types into
  `_synthesize_lifted_function_with_captures`): viable but worse separation —
  the lift pass would have to also build the callee-signature table and the
  array-element rule, conflating capture lifting with type inference. A distinct
  pass that *normalises the AST* before lift keeps lift unchanged and the new
  logic testable in isolation.
- **Fix it at lowering in `core_call_resolution.sfn`** (§3.1): the lifted
  function is already synthesised by then; we would have to re-emit it.
  Rejected.
- **Do it in typecheck** (§3.1): requires call-site→argument type flow that does
  not exist (#829); large blast radius; rejected for this focused fix.
- **Default an untyped lambda param to `int`/`i64` unconditionally** (no
  call-site lookup): would "work" for the `int[]`/`int`-callback common case but
  silently miscompile a `string`/`float`/struct callback to an `int` param
  instead of refusing. Rejected — it manufactures a *new* wrong-types hazard in
  place of the segfault, violating "don't ship unfinished safety claims". The
  call-site-driven approach backfills only when it *knows* the type and no-ops
  otherwise.

## 7. Stage1 readiness mapping

- [ ] Parses — unchanged (SFEP-0029 short form already parses; this SFEP adds no
      syntax).
- [ ] Type-checks / effect-checks — unchanged (pass runs post-effect-check;
      writes only codegen type text).
- [ ] Emits valid `.sfn-asm` — the lifted `sfn_lambda_<N>` now emits `.param
      x: int` and a typed return for untyped lambdas in covered positions.
- [ ] Lowers to LLVM IR — the lifted function lowers identically to a typed
      lambda; `runtime_array_map_fn` / user-HOF ABI matches.
- [ ] Regression coverage — §8.
- [ ] Self-hosts — guaranteed (compiler authors no lambdas; additive; §5).
- [ ] `sfn fmt --check` clean — run on the new module + `emit_native.sfn`.
- [ ] Documented — `docs/status.md` lambda/closure row updated to note untyped
      callbacks lower for the covered cases; SFEP-0029 cross-reference.

## 8. Test plan

**Unit (`compiler/tests/unit/lambda_param_inference_test.sfn`, new):**

- `parse_fn_type_text("fn(int) -> int")` → params `["int"]`, return `"int"`.
- `parse_fn_type_text("fn(int, int) -> int")` → params `["int","int"]`.
- `parse_fn_type_text("fn(int) -> boolean")` → return `"boolean"`.
- Nested generic / nested fn guard:
  `parse_fn_type_text("fn(Map<string, int>) -> boolean")` → one param
  `"Map<string, int>"` (not split on the inner comma);
  `parse_fn_type_text("fn(fn(int) -> int) -> int")` → one param
  `"fn(int) -> int"`.
- Non-fn input (`"int"`, `""`) → `ok:false` / empties (caller no-ops).
- Backfill is a no-op on an already-typed lambda argument (annotations
  preserved verbatim — the no-regression pin).

**e2e (`compiler/tests/e2e/untyped_lambda_callback_test.sfn`, new — build &
run, isolated per `.claude/rules/no-bash-e2e.md`):**

- `.map(fn(x) => x * x)` on an `int[]` **executes** and prints the squared
  array (was exit 139). The proof the headline case is fixed.
- The block-form twin `.map(fn(x) { return x * x; })` executes and prints the
  same result (proves the fix is syntax-independent, not tied to `=> expr`).
- `.filter(fn(x) => x > 1)` and `.reduce(0, fn(acc, x) => acc + x)` on `int[]`
  execute and print correct results.
- A user HOF `fn apply(cb: fn(int) -> int, n: int) -> int { return cb(n); }`
  called as `apply(fn(x) => x + 1, 5)` executes and prints `6`.
- **No-regression leg:** the typed forms
  `.map(fn(x: int) -> int => x * x)` and `apply(fn(x: int) -> int => x + base, 5)`
  still execute and print the same values (must be byte-identical output to the
  untyped forms).
- **Honest-degrade leg:** an untyped callback in an *unsupported* position
  (e.g. a `string[]` map, or an aliased callee) still produces the existing
  "callee signature is not known" diagnostic — **not** a crash and **not** a
  silent miscompile.

Refresh-by-build only (no snapshot churn): these are execution tests asserting
on captured stdout via `process.run_capture`, threading `PATH` /
`SAILFIN_TEST_SCRATCH` per the build-and-run isolation rule.

## 9. Risks

1. **Receiver element-type resolution for the array-builtin case (§3.3 Case
   B).** The pass must conservatively determine `int[]`. Mitigation: only
   backfill when the element type is unambiguously `int`/`i64` from a literal or
   a declared `int[]` annotation; otherwise no-op and let the existing
   diagnostic fire. The honest-degrade test leg pins that an undetermined
   element type does not crash.
2. **Callee-signature table misses (aliased/indirect callees).** Mitigation:
   miss → no-op (no worse than today). Deferred indirect cases are documented,
   not silently mishandled.
3. **fn-type text the splitter does not recognise** (exotic shapes). Mitigation:
   `parse_fn_type_text` is total and returns `ok:false` on anything unexpected;
   the caller no-ops. The nested-generic/nested-fn unit cases pin the shapes
   that *must* parse.
4. **Accidentally touching typed lambdas (regression).** Mitigation: the pass
   only writes annotations that are `null`; the no-regression unit + e2e legs
   assert byte-identical output between typed and untyped forms.
5. **Walker coverage gaps** (a lambda argument nested in a position the walker
   does not descend, mirroring the `lambda_lowering.sfn` method-body no-op at
   `:942`). Mitigation: the backfill walker shares the lift walker's expression
   coverage; any position lift does not descend is already a `<lambda>`
   placeholder today, so an un-backfilled lambda there is no worse than current
   behaviour. Document the shared coverage boundary.

## 10. Verification

- `sfn check compiler/src/llvm/expression_lowering/native/lambda_param_inference.sfn
  compiler/src/emit_native.sfn` — inner loop after each edit.
- `sfn fmt --write` then `sfn fmt --check` on both touched `.sfn` files.
- `sailfin test compiler/tests/unit/lambda_param_inference_test.sfn` — splitter +
  no-op unit coverage.
- `sailfin test compiler/tests/e2e/untyped_lambda_callback_test.sfn` — the
  build-and-run legs (covered + no-regression + honest-degrade).
- `make compile` — self-host invariant (mandatory for the `compiler/src/*.sfn`
  change; clears the `check`-passes-but-build-fails bar, #1389/#1386).
- `make check` — full triple-pass gate before declaring shipped.

## 11. Future considerations

- **Generics (#766)** lift the `int`-only restriction: once `string[]`,
  `float[]`, and struct-element array mappers exist, `parse_fn_type_text` already
  yields the correct element/return text — only the array-builtin element gate in
  §3.3 Case B (and the runtime mapper bodies) need to widen. The user-HOF case
  (Case A) is already element-agnostic, since it reads the callee's declared
  fn-type text directly.
- **Expression-type inference (#829)** would let Case A cover aliased/indirect
  callees (a callback stored then invoked) by giving each expression a resolved
  type; this pass's call-site table is a deliberate subset that can be replaced
  by, or fed from, that inference when it lands.
- **Lambda effect tracking (SFEP-0029 §4):** when `Expression.Lambda` grows an
  `effects` field, this pass is unaffected — it normalises types, not effects —
  and the two changes compose without interaction.

## 12. Status — Implemented (2026-06-27, #1683)

Shipped end-to-end and self-hosts. `.map(fn(x) => x * x)`, the block twin
`.map(fn(x) { return x*x; })`, `.filter`/`.reduce`, and an untyped lambda to a
user HOF (`apply(fn(x) => x + 1, 5)`) all execute correctly (were `exit 139`).
Typed lambdas are byte-identical (no regression).

**Two deviations from the §3 design, both pragmatic and load-bearing:**

1. **Folded into the lift pass, not a separate pass.** The backfill is invoked
   from the lift walker's `Call` handler (`lambda_lowering.sfn`,
   `backfill_call_argument` per argument) rather than as a standalone pre-pass.
   Reason: the seed compiler uses **value semantics for AST structs** (verified:
   an in-place nested-field mutation does not persist), so a standalone pass
   would have to functionally rebuild the entire ~250-line statement/expression
   walker the lift pass already implements. Folding reuses that walker and —
   critically — **guarantees coverage parity**: every lambda the lift pass reaches
   is also backfilled, so no position is left as a segfaulting untyped lambda.

2. **Static program-wide binding table, not a threaded lexical scope.** §3.3
   Case B resolves the receiver's element type from a binding table. The design
   threaded a *mutable* per-walk scope through `LiftContext`; in practice,
   re-storing a freshly-rebuilt `BindingEntry[]` into the threaded context
   **corrupted the struct string fields** under the seed compiler (a SIGSEGV in
   `strnlen` during lookup — the immutable, build-once `signatures` table never
   showed this). The fix mirrors the working `signatures` pattern: a flat
   `(name, type)` table over every function/method parameter and `let` (collected
   depth-first through nested blocks) is built **once** and threaded read-only.
   Trade-off: lookups are program-global rather than lexically scoped — a
   conservative subset that can only no-op or correctly backfill in the covered
   cases (a non-`int` receiver type fails the array-builtin gate), never a crash.

Files: `compiler/src/llvm/expression_lowering/native/lambda_param_inference.sfn`
(new), `lambda_lowering.sfn` (lift-pass hook + `LiftContext` fields). Tests:
`compiler/tests/unit/lambda_param_inference_test.sfn` (splitter + no-op pins),
`compiler/tests/e2e/untyped_lambda_callback_test.sfn` (build-and-run, covered +
no-regression legs).
