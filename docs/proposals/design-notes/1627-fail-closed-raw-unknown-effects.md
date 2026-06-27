# Design note — #1627: fail-closed enforcement for effect-opaque `Raw` / `Unknown` nodes

- **Issue:** #1627 (effect-system hardening)
- **Epic:** #1180
- **Design record extended:** SFEP-0008 (`docs/proposals/0008-effect-validation.md`)
- **Author:** agent:compiler-architect
- **Status:** Draft (single-issue design gate; not a new SFEP)
- **Date:** 2026-06-26; **revised 2026-06-27** (the E0818-flip endgame — parts A–F)
- **Decision:** **Structural lift (root fix)** chosen at the design gate. The
  earlier text-anchor "floor" (`_raw_contains_effectful_anchor`) is **superseded**
  and retained below only as the analysis that led to the root-fix decision.

---

## 2026-06-27 revision — the E0818-flip endgame (parts A–F)

This section is the **authoritative, ordered implementation spec** for flipping
the blanket `E0818` fail-closed `Raw` arm green and self-host-clean. It
**supersedes the older "Staging A–E" section below** wherever they differ
(notably the older line numbers, which are stale post-#1689/#1690). The user
approved enabling the blanket `E0818` arm; this section resolves the hard
problems that blocked it. **Everything bundles into one PR (no seed cut)** — see
the final staging note.

### Verified current source map (re-confirmed by exploration 2026-06-27)

Trust these over the §"Root cause" line numbers below.

- **`Expression.Raw` producers** — exactly two live escape paths, both in
  `compiler/src/parser/expressions.sfn::expression_from_tokens`:
  `parse_expression_bp` returns `success:false` (~:272-277) and leftover
  unconsumed tokens after a successful climb (~:279-284). The
  `expression_parse_failure` placeholder (~:74, `success:false`) never escapes
  the parser. Every valid-but-`Raw` construct flows through the two
  `expression_from_tokens` paths.
- **Assignment** has **no AST node at all** (no `Statement.Assignment`, no
  `Expression.Assignment`). `a = b;` parses as
  `Statement.ExpressionStatement { expression: expression_from_tokens("a = b") }`
  (statements.sfn ~:1495-1500), and `=` has precedence `-1` in
  `binary_precedence` (~:1831/1861) so the climb leaves `=` unconsumed →
  **leftover tokens → `Expression.Raw{text:"a = b"}`**. Lowering re-parses that
  Raw text in `llvm/.../statement.sfn::lower_expr_stmt` via
  `parse_assignment_expression` (statement.sfn:161). So assignment is an
  ExpressionStatement-wrapped Raw today.
- **Prefix `*`/`&`** — `parse_prefix_expression` (expressions.sfn ~:499-523)
  handles only symbol ops `-` and `!`, plus soft keywords. `&` and prefix `*`
  fall through → Raw. The shadow lowering parser DOES handle prefix `*` (deref,
  core.sfn:2281) and prefix `&` (borrow, core_parsing.sfn:44) on text.
- **Cast `as` arm** in `parse_postfix_chain` (expressions.sfn ~:836-900):
  `lift_pointer_target = current_expression.variant != "Identifier"` (~:868).
  Bare-identifier operands accept only bare-name targets (`as int`); `* T` is
  rejected → parse failure → the enclosing expression degrades to Raw. Generic
  (`as Foo<...>`) and fn-pointer (`as fn(A)->B`) targets are never accepted →
  leftover tokens → Raw.
- **Effect checker** `collect_effects_from_expression`
  (`effect_checker.sfn` ~:735-1016): arms for Call, Member, Unary (:878 walks
  operand), Cast (:881 walks operand, #1689), Binary, Conditional (:897, #1690),
  Array, Object, Struct, Lambda, Index, Range, TryOperator, Spawn, Await,
  Channel, Parallel, Serve. **Fall-through `return []` at :1015** — the silent
  drop site for `Raw`. `collect_effects_from_statement` (~:531-622) has **no
  `Unknown` arm**; fall-through `return []` at :621.
- **fn-reference diagnostics** — `check_fn_reference_raw(text, symbols, span)` in
  `typecheck_types.sfn` ~:1785-1841, called from `typecheck.sfn:1088` **only**
  for `expression.variant == "Raw"`. Text-parses two forms: `& <fn>` → E0808
  (`make_fn_value_position_diagnostic`); `<fn> as <type>` → if target is `* u8`
  / `* fn...` it is the blessed pointer-to-code form, validates C-ABI (generic →
  E0808; non-C-ABI → E0808 via `make_fn_address_unsupported_diagnostic`), else
  E0808. The `head == left` guard (:1811) bails when the operand is not exactly a
  bare identifier (so a fn-cast buried in a call argument is not classified). The
  `walk_expression` `Identifier` arm (typecheck.sfn ~:1073-1081) independently
  emits E0808 for a function-kind identifier used as a value.
- **Diagnostic factory** `make_parse_error_diagnostic` (typecheck_types.sfn
  ~:573-586, code E0816). **Highest used code is E0816. E0817 and E0818 are
  free.**
- **Formatter** (`emit_native_format.sfn`): `Unary` arm (:108-115) pushes
  `operator` then `_format_binary_operand_into(operand)` (parenthesizes Binary /
  Cast operands; otherwise verbatim). `Cast` arm (:192-202) → `(operand) as
  <target.text>`. `Conditional` arm (:203-219) → `(c) ? (t) : (e)`. `Raw` arm
  (:303+) emits normalized raw text.
- **Conditional walker arms (the template to mirror for Assignment)** exist in
  exactly these files: `effect_checker.sfn:897`, `typecheck.sfn:1015`,
  `typecheck_captures.sfn:323`, `ownership_checker.sfn:936`,
  `emit_native_format.sfn:203`, `emitter_sailfin_expr.sfn:137`,
  `llvm/expression_lowering/native/lambda_lowering.sfn:606`.

### Live effect escapes still open today (re-probed 2026-06-27)

- `*print.info(x)` (prefix deref) — ESCAPES (Raw)
- `&print.info(x)` / `&print.info` (address-of) — ESCAPES (Raw)
- `(a = print.info(x))` (assignment-expr) — ESCAPES (Raw)
- Already caught: `as int`, `as *T` (non-ident operand), bare `as Result`,
  ternary, plain calls.

### In-source `Raw` nodes E0818 would otherwise trip on — the exhaustive census

Grepped `compiler/src`, `runtime`, `capsules` (excluding `tests/`):

1. **Bare-identifier `<fn> as *T`** — exactly ONE:
   `capsules/sfn/http/src/server.sfn:142`,
   `sfn_serve_framed(_sfn_http_trampoline as * u8, port as i32)`. The cast is the
   **first argument** to `sfn_serve_framed`; the bare-ident `* u8` target is
   rejected by the cast arm → the **whole `sfn_serve_framed(...)` call** has
   leftover tokens → degrades to one `Raw{text:"sfn_serve_framed(...)"}`.
   `check_fn_reference_raw`'s `head == left` guard bails (head is
   `sfn_serve_framed`, not a fn-cast), so it is clean today — and `_sfn_http_trampoline`
   is a concrete `fn(OwnedBuf)->OwnedBuf` (struct-ABI, **not** C-ABI-primitive),
   so naively structuring it into Cast + classifying re-introduces the #1689
   E0809 regression.
2. **`& fn` address-of of a bare function identifier** — ZERO in non-test source.
   (All `&ident` grep hits in `compiler/src` are inside comments or string
   literals.) The `& fn` E0808 path (`check_fn_reference_raw`, :1790-1798) is
   exercised only by `compiler/tests/unit/fn_reference_typecheck_test.sfn`.
3. **Generic / fn-pointer cast targets** (`as Foo<...>`, `as fn(A)->B`) — ZERO in
   non-test source. (`examples/web/http-server.sfn:43` and several e2e fixtures
   use `handle as * fn (Request) -> Response`, but that is a **non-bare-identifier
   operand**? No — `handle` IS a bare identifier, so it is also census item 1's
   sibling: a bare-ident operand with a `* fn ...` target. Today it degrades to
   Raw the same way. See part A — these are covered by the same fix.)
4. **Assignment-as-statement `a = b;`** — PERVASIVE across compiler/runtime
   source (hundreds of sites). Each is an `ExpressionStatement{Raw}`. **This is
   the dominant E0818 blocker** and the reason a naive flip explodes the build.

**Conclusion:** the only structural blockers to E0818 are (1) the one
bare-ident `<fn> as *T` http-trampoline cast (+ its `as * fn ...` siblings in
examples/tests), and (4) every assignment statement. Generic targets and `&fn`
are absent from non-test source. Parts A–D below close exactly these.

---

### Part A — `<fn> as *T` (and `as * fn ...`) off the `Raw` path without the E0809 regression

**Chosen option: (b′) — structure ALL `as <pointer/fn-pointer/generic> T` into
`Cast`, and run fn-reference classification on the structured `Cast` ONLY under
the exact condition the old `Raw` path did: when the cast is the *entire*
analyzed expression with a bare-identifier operand.** Reject options (a) and (c):

- **(a) relax the C-ABI check for `* u8`** — rejected. A fn cast to `* u8` is the
  blessed code-pointer idiom, but the C-ABI check (`is_c_abi`) is *load-bearing
  ABI soundness*, not over-strictness: it guards that the address handed to a C
  caller (`pthread_create`, `sfn_serve_framed`) is a callable C-ABI entry. The
  http trampoline is **deliberately** `fn(OwnedBuf)->OwnedBuf` precisely because
  the runtime calls it with an `OwnedBuf` by the struct-ABI the Sailfin backend
  emits — `sfn_serve_framed`'s C signature takes a `void*` and the runtime
  re-enters Sailfin through it. Whether that is genuinely C-ABI-sound is a
  separate question (#1147 territory); **#1627 must not change fn-reference ABI
  semantics.** Relaxing the check to make the flip work would silently weaken an
  ABI guard for every fn cast — wrong blast radius for an effects PR.
- **(c) exempt recognized fn-references in the E0818 arm** — rejected as the
  primary mechanism. A structural "is this Raw a fn-reference" classifier in the
  effect checker is defensible on *soundness* grounds (taking a fn's address
  invokes no effect, so a fn-reference is genuinely effect-free and analyzable —
  E0818 is defense-in-depth for *unanalyzable* nodes, and a recognized
  fn-reference is analyzable). BUT it keeps the `Raw` overload alive, which is
  exactly the latent re-parse-divergence hazard the root fix exists to kill, and
  it risks drifting back toward text-pattern classification. We adopt the
  *spirit* of (c) — fn-references are effect-free, so they need not be E0818'd —
  by **structuring them so the effect checker sees a `Cast` (walks the operand,
  which is a bare identifier → no effect → clean)**, not by special-casing `Raw`.

**The mechanism — preserve the old classification predicate exactly:**

The reason structuring `<fn> as *T` regressed E0809 in #1689 was *not* the
structuring — it was that classification moved to a `Cast` arm that fired in
positions the old `Raw` path never reached (the old path bailed via `head ==
left` whenever the cast was buried in a larger expression, e.g. a call argument).
The fix is to **replicate that predicate**:

1. **Parser** (`expressions.sfn` cast arm, ~:866-899): drop the
   `lift_pointer_target = current_expression.variant != "Identifier"` gate.
   *Always* lift a pointer / fn-pointer cast target into `Cast` (extend the
   target reader per Part C to also accept `fn (...) -> T`). Bare-identifier
   operands now also produce `Cast{operand: Identifier, target_type.text: "* u8"}`.
   The formatter already serializes this to `(_sfn_http_trampoline) as * u8` —
   byte-equivalent (modulo the operand parens, which the shadow re-parser strips)
   to the prior Raw text, so **lowering is unchanged**.
2. **typecheck `Cast` arm** (`typecheck.sfn:1024-1032`, currently just recurses):
   add fn-reference classification that fires **only when the Cast operand is a
   bare `Identifier` that resolves to a function kind** — i.e. exactly the
   `head == left` predicate, but read structurally off `expression.operand`
   instead of by text. Extract the classification *body* of
   `check_fn_reference_raw` (the `<fn> as <type>` half: target inspection →
   E0808/E0809 via `make_fn_address_unsupported_diagnostic` /
   `make_fn_value_position_diagnostic`) into a shared
   `classify_fn_cast(head: string, target_text: string, entry: SymbolEntry,
   span) -> Diagnostic[]` and call it from the new `Cast` arm. **Crucially, this
   arm fires only at the top of `walk_expression` for a `Cast` whose operand is a
   bare fn Identifier — when the `Cast` is nested inside a `Call`'s argument list,
   `walk_expression` recurses into the argument and reaches the `Cast` arm with
   the SAME bare-identifier operand, so it WOULD now classify the trampoline.**

   This is the trap. To preserve the exact old behavior, the classification must
   be suppressed in argument position the way the old whole-call-degrades-to-Raw
   accident suppressed it. Two sound ways:

   - **(b-i) — the http trampoline is genuinely a valid fn-address and SHOULD
     classify clean.** Re-examine: under the old path the trampoline escaped
     classification by accident (the call degraded to Raw, head guard bailed).
     The *correct* answer is not to preserve the accident but to make
     classification **pass** for it. `_sfn_http_trampoline as * u8` is a real,
     intended fn-address materialization — the runtime calls it. The only reason
     it would fail E0809 is `is_c_abi == false` for an `OwnedBuf`-taking fn. So
     the principled fix is to ensure `is_c_abi` is computed correctly for this
     signature, OR to recognize that `as * u8` (opaque code pointer, type-erased)
     is ABI-agnostic by construction — a `* u8` is `void*`; the callee re-casts
     it, so the C-ABI-of-the-Sailfin-signature check is **only** meaningful for
     the *typed* `as * fn (A) -> B` form (line 133/examples), never for the
     erased `as * u8` form. **Decision:** in `classify_fn_cast`, restrict the
     C-ABI enforcement (E0809) to the **typed `* fn (...)` target**; an erased
     `* u8` target is accepted for any concrete (non-generic) function. This is
     ABI-sound: `* u8` carries no calling convention, so no convention can be
     violated by producing it; the convention is enforced where it is *declared*
     (`* fn (...)`), which is where `try_lower_plain_fn_ptr_call` and
     `serve(... as * fn ...)` actually consume it. Generic fns still → E0808
     (no monomorphic address exists).

   This **removes the regression at its root** instead of replicating an
   accident, and it lets classification run uniformly in any position
   (argument or not) — simpler, no position predicate needed. `as * fn (...)`
   forms (examples/tests) keep full C-ABI enforcement.

**Net Part A:** parser always lifts pointer/fn-pointer cast targets to `Cast`;
`check_fn_reference_raw` is split into `classify_fn_cast` (shared) + the residual
`& fn` half (Part B); the typecheck `Cast` arm classifies a bare-fn-Identifier
operand via `classify_fn_cast`, with E0809 scoped to typed `* fn (...)` targets
and `* u8` accepted for any concrete fn. The effect checker `Cast` arm is
**unchanged** (already walks operand; a bare-identifier operand yields no
effect). The `Raw` arm of `check_fn_reference_raw` in `typecheck.sfn:1088` keeps
handling the residual `& fn` Raw (Part B) until that too is structured.

**Canary:** `compiler/tests/unit/effect_cast_operand_test.sfn` (the existing
bare-identifier `Raw` gate test must be UPDATED — the gate is removed; the
trampoline now structures into `Cast` and classifies clean) +
`compiler/tests/unit/fn_reference_typecheck_test.sfn` (E0808 for generic
`gen as * u8`; E0808/clean parity for `nc as * u8` / `worker as * u8`;
`label as * u8` non-fn stays clean). Self-host gate: `make compile` must build
`capsules/sfn/http/src/server.sfn` clean.

### Part B — prefix `&` structuring vs the `&fn` E0808 path

**Claim to verify:** if prefix `&` becomes `Unary{&, operand}`, does `&fn_name`
still get E0808? **Answer: NO, not automatically — and a change is required.**

- `&print.info(x)` (address-of a call result) → `Unary{&, Call{Member}}`. The
  effect checker `Unary` arm (:878) walks the operand → the `Call` fires `io`.
  **Correct, no change.** This closes the `&print.info(x)` escape.
- `&fn_name` (address-of a bare function identifier) → `Unary{&, Identifier}`.
  The typecheck `walk_expression` has **no `Unary` arm today** (grep confirms:
  Conditional/Cast/TryOperator/Range arms exist; no Unary). So a structured
  `Unary` currently falls through `walk_expression`'s tail `return []` — the
  operand is NOT recursed, so the `Identifier` arm's E0808 never fires. **This is
  the required change:** add a `Unary` arm to `walk_expression`
  (`typecheck.sfn`) that recurses into `expression.operand`. Then `&fn_name`'s
  operand `Identifier{fn_name}` reaches the existing `Identifier` arm
  (:1073-1081) → `make_fn_value_position_diagnostic` (E0808). **Behavior
  preserved via the generic Identifier arm — no `&`-specific logic needed.**

  Note: the old `& <fn>` path in `check_fn_reference_raw` (:1790-1798) used
  `make_fn_value_position_diagnostic` (E0808), exactly what the Identifier arm
  emits. So routing `&fn` through `Unary → Identifier` is behavior-equivalent.
  Since there are **zero** in-source `&fn` sites, the only consumer is
  `fn_reference_typecheck_test.sfn` — update/confirm it asserts E0808 for the
  structured form.

**Distinguishing the two:** `&fn_name` (Identifier operand, fn kind → E0808 in
Identifier arm, no effect) vs `&(print.info(x))` (Call operand → io via effect
checker Unary arm). The split is automatic once both the typecheck `Unary`
recursion (E0808 reachability) and the effect-checker `Unary` arm (already
present, effect reachability) exist.

**Parser change:** `parse_prefix_expression` (:505-523) — extend the symbol set
from `{-, !}` to `{-, !, *, &}`, building `Unary{operator: sym, operand: parsed
at unary_precedence()}`. The binary `&`/`*` handlers in `binary_precedence` are
unaffected (infix-only; prefix position never reaches the climb).

**Formatter:** the `Unary` arm (:108-115) already pushes `operator` then the
operand. For `&`/`*` it emits `&operand` / `*operand`, which the shadow parser
lowers via borrow (core_parsing.sfn:44) / deref (core.sfn:2281). **Risk:**
`_format_binary_operand_into` parenthesizes `Binary` and `Cast` operands but NOT
`Call`/`Member`. `&print.info(x)` → `&print.info(x)`; the shadow borrow parser
`parse_borrow_expression` takes everything after `&` as the target — for a call
that is `print.info(x)`, which borrow lowering must accept or reject cleanly.
**Verify in the IR-diff canary** that `&<call>` and `*<call>` lower identically
to the pre-change Raw text (they are byte-identical: Raw text was the same
`&print.info(x)` string). Because the source contains no prefix `&`/`*` on
calls today (they were Raw and the effect checker dropped them — but did they
lower? they were never *written* in source, only probed), the in-source risk is
limited to `*ptr` / `&x` simple-identifier forms, which the shadow parser
already handles. **The IR-diff canary over in-source `*ptr`/`&x` sites is the
gate.**

**Canary:** `effect_prefix_deref_addr_test.sfn` — `*print.info(x)` and
`&print.info(x)` require `![io]`; `&fn_name` → E0808; plus the IR-diff identity
test over in-source `*ptr`/`&x`.

### Part C — generic / fn-pointer cast targets

There are **zero** in-source `as Foo<...>` or `as fn(...)` targets, and the
`as * fn (...)` targets (examples/tests) are covered by Part A's reader
extension. So Part C is **minimal and mostly defensive**, but required so E0818
cannot trip on a future/edge construct.

**Cast-target reader extension** (`expressions.sfn` cast arm, replacing the
`*`-prefix loop + single-Identifier read at ~:866-893): after consuming `as`,
read a full type-annotation target by **reusing the existing type-annotation
parser** (the same path that parses `let p: * fn (A) -> B`). Concretely:

- Keep the existing `*`-prefix accumulation for `* T` / `** T`.
- After the pointer prefix, instead of requiring a single `Identifier`, call the
  shared type-annotation token reader to consume `fn (A, B) -> R`, `Foo<X, Y>`,
  or a bare identifier, capturing the verbatim target text into
  `TypeAnnotation.text`. The type-annotation grammar already exists for
  parameter/var/field positions; this keeps cast targets in lockstep.
- Only a genuinely unparseable target falls through to
  `expression_parse_failure` (→ Raw → E0818, correctly: it is junk).

The formatter `Cast` arm serializes `(operand) as <target.text>` verbatim, and
the shadow `parse_cast_expression` already scans for top-level ` as ` and
strip-parens the operand — so generic/fn-pointer target text round-trips with no
new lowering arm. **Verify** the type-annotation reader does not over-consume
past the cast (e.g. a trailing `,` in a call-arg list); bound it to the cast's
token window.

**To find any hidden in-source occurrence before flipping:** see Part F's
instrumentation probe (it enumerates *all* surviving Raw producers by text, so a
stray generic cast would be named there).

**Canary:** `cast_generic_target_test.sfn` — `x as Result<int, string>` and
`f as fn (int) -> int` structure into `Cast` (assert via the parser test harness
that `parse_program` yields a `Cast`, not a `Raw`); IR-diff for `as * fn (...)`
in-source-adjacent fixtures stays identical.

### Part D — assignment-as-expression (the dominant blocker)

**This is the highest-blast-radius part** (hundreds of in-source `a = b;` sites).
Mirror exactly how #1690 added `Conditional` to every walker.

**AST** (`ast.sfn`): add
`Assignment { target: Expression, operator: string, value: Expression, span: SourceSpan? }`.
`operator` holds `"="` or a compound (`"+="`, `"-="`, …) so the node carries the
same information `parse_assignment_expression` recovers from text today
(statement.sfn:196-200 desugars compound). Using an AST `operator` field keeps
the structured node lossless.

**Parser:** assignment binds **lower than ternary** (right-associative,
precedence below `Conditional`). The cleanest seam is **after** the
precedence-climbing loop AND after the ternary check in `expression_from_tokens`
(expressions.sfn, the same place #1690 added the ternary peek): once `left` is
the fully-climbed (and possibly ternary-wrapped) expression, peek for a
top-level assignment operator (`=`, `+=`, `-=`, `*=`, `/=`, `%=`) that is NOT
`==`/`!=`/`<=`/`>=`. If found, parse the RHS as a full expression (recursing for
right-assoc), build `Assignment{target: left, operator, value: rhs}`.
**Guard:** only treat `=` as assignment, never `==` — the lexer must distinguish
(it already lexes `==` as a distinct token / two-char symbol; confirm the peek
checks the full operator token, not a single `=` char). Because `=` currently has
precedence `-1` (never climbed), this is purely additive: every `a = b` that was
Raw becomes `Assignment`; nothing that parsed before changes.

**Formatter** (`emit_native_format.sfn`): add an `Assignment` arm emitting
`<target> <operator> <value>` (e.g. `a = b`, `x += 1`) — **the exact text
`parse_assignment_expression` (statement.sfn:161) already lowers.** No new
lowering arm. Parenthesize the target/value only if they are `Binary`/`Cast`/
`Assignment` (reuse `_format_binary_operand_into`-style guarding) so a chained or
operator-laden side round-trips; for the overwhelmingly common
`identifier = expr` and `member.field = expr` cases this is verbatim.

**Walkers — add an `Assignment` arm to each of the seven Conditional sites:**

1. **`effect_checker.sfn`** (`collect_effects_from_expression`, before :1015):
   union the effects of `target` and `value` (an effectful LHS like
   `arr[compute_io()] = x` or RHS must surface). The ExpressionStatement path
   already routes here via `collect_effects_from_statement`'s ExpressionStatement
   arm (:599).
2. **`typecheck.sfn`** (`walk_expression`, near :1015): recurse into `target`
   and `value` (concat diagnostics).
3. **`typecheck_captures.sfn`** (near :323): walk `target` and `value`, merge
   captures (`fn() { captured = x; }` captures `captured`).
4. **`ownership_checker.sfn`** (near :936): walk `target` and `value` — an
   assignment is a write to the target's scope; preserve current ownership
   behavior by treating it as the statement path does (an assignment Raw is
   currently analyzed by the lowering ownership pass, not here; the structured
   arm must at minimum recurse so nested moves are seen — match the
   ExpressionStatement handling).
5. **`emit_native_format.sfn`** (the formatter arm above).
6. **`emitter_sailfin_expr.sfn`** (near :137): serialize the structured
   assignment for the `.sfn-asm` emitter round-trip (mirror its Conditional arm).
7. **`llvm/.../lambda_lowering.sfn`** (the lambda-capture rewrite, near :606):
   rewrite captured identifiers inside `target` and `value` (a lambda body may
   assign to a captured `mut` binding).

**Self-host risk — HIGH** (every assignment statement changes node shape). The
guarantee is the formatter→shadow-parser identity: `Assignment{a, "=", b}` →
`"a = b"` → `parse_assignment_expression` → the identical lowering that the
`Raw{"a = b"}` produced. **The IR-diff canary over a representative set of
in-source assignment sites (simple, compound, member-target, index-target) is
the proof.** Compound assignment must round-trip its operator (`x += 1` →
`"x += 1"`, NOT `"x = x + 1"` — the desugar stays in lowering at
statement.sfn:196, fed the original operator).

**Canary:** `assignment_node_ir_identity_test.sfn` (IR-diff simple/compound/
member/index assignments before vs after) + `effect_assignment_test.sfn`
(`a = print.info(x)` and `arr[io()] = x` require `![io]`).

### Part E — `E0817` nested `Unknown`

`Statement.Unknown` is produced by `parse_unknown` (declarations.sfn ~:1793,
call sites :1320/:1525/:1679/:1691/:1697/:1728) and `parse_unknown_statement`
(statements.sfn ~:1511, called from `parse_block` :149-153). **No diagnostic is
recorded at any site.** Zero in-source `Unknown` nodes exist (the tree
self-hosts).

**Approach (matches #1180-b):** record a parse diagnostic **at the production
site**, not in the effect checker — cleaner than threading a top-level flag
through the shared `check_statement` walker. Add `make_unparseable_statement_diagnostic`
(`E0817`, mirroring `make_parse_error_diagnostic`) and emit it from
`parse_unknown_statement` (the nested-block producer) with the captured token
span.

**Double-fire gating** (the crux of part E): a nested `Unknown` must NOT
double-report when another pass already minted a diagnostic for the same text.
Gate the E0817 emission to fire **only when**:
- `detect_removed_ai_keyword(text).length == 0` (no removed-AI-keyword
  diagnostic), AND
- `detect_unsupported_statement_keyword(text).length == 0` (no `E0411`
  removed-keyword like `while`), AND
- the statement is **not** at top level (top-level `Unknown` already gets `E0500`
  in `tools/check.sfn:165`, a disjoint node position — nested production via
  `parse_block` is where the gap is).

The effect checker still gets a defensive `Unknown` arm in
`collect_effects_from_statement` (before :621) that returns `[]` (an unparseable
statement contributes no *analyzable* effect; the E0817 parse diagnostic already
fails the build, so the effect arm need not also error — keep it `[]` to avoid a
second diagnostic on the same node). This is Part E's only effect-checker touch.

**Canary:** `effect_unknown_block_level_test.sfn` — nested `@@@ junk !!!` →
E0817; top-level `@@@` still E0500; `while(){}` still E0411 (dedup proof);
no E0817 when E0411/removed-keyword already fired.

### Part F — the `E0818` flip + pre-flip enumeration

**Enumerate remaining in-source Raw producers BEFORE flipping** (so you
structure them rather than discover them via a broken build):

**Temporary instrumentation probe** (the safe way): in
`expression_from_tokens` (expressions.sfn ~:272-284), behind an env gate
`SAILFIN_TRACE_RAW`, `print.err` the `trim_text(tokens_to_text(tokens))` and the
enclosing span each time a Raw is produced. Then run `make compile` once with
`SAILFIN_TRACE_RAW=1` and collect stderr — every distinct Raw text emitted while
compiling the compiler+runtime+capsules is a producer you must structure (or
confirm is genuine junk). This is read-only instrumentation; **remove it before
the PR lands** (or keep it permanently behind the env gate as a debugging aid —
implementer's call, but it must be a no-op by default). Cross-check the probe
output against the census above (items 1–4): after Parts A–D, the probe should
emit **nothing** for compiler/runtime/capsules source. Any residual line names a
construct A–D missed → structure it before flipping.

**The flip** (`effect_checker.sfn`, `collect_effects_from_expression`
fall-through at :1015): replace the final `return []` with a `Raw` arm placed
**before** it:

```
if expression.variant == "Raw" {
    if trim_text(expression.text).length == 0 { return []; }   // empty Raw is never effectful
    // emit E0818 via the effect-violation channel (so SAILFIN_EFFECT_ENFORCE /
    // [kind: effect] rendering applies), carated at expression.span.
    ...
}
return [];   // genuinely unhandled non-Raw variants stay non-fatal (defensive)
```

Empty `Raw{text:""}` (the never-escapes placeholder shape) returns `[]`. The
non-empty arm emits `E0818` ("unstructured expression cannot be analyzed;
rewrite so the compiler can parse it"). Add `make_effectful_raw_diagnostic`
(E0818) mirroring `make_parse_error_diagnostic`. **Soundness note:** because
Parts A–D structured every effect-free-but-Raw form (fn-references, assignment,
prefix ops, casts), every *remaining* Raw is genuinely unanalyzable — so E0818 as
a hard error is correct, not over-broad. fn-references are no longer Raw, so the
"fn-references are effect-free, don't E0818 them" concern is moot (they're
`Cast`/`Unary` now).

**The self-host gate IS the proof.** `make compile` after the flip MUST stay
green. A failure names the exact construct still degrading to Raw — structure it
(Parts A–D) or, if it is genuine junk in source, fix the source. Then
`make check` (triple-pass) before declaring shipped.

**Canary:** `effect_raw_failclosed_test.sfn` — a genuinely unlowerable
expression → E0818; a valid structured expression → clean.
`effect_raw_negative_substring_test.sfn` — Raw/structured text mentioning
`print` as a non-call substring → no E0818 (proves no text-scan reintroduction —
E0818 fires on *node shape*, not text content).

---

### Ordered implementation plan (one PR, no seed cut)

Each stage ends with a self-host checkpoint. Order is chosen so the highest-risk
structuring (assignment) lands before the flip, and the flip is last.

| Stage | Work | Self-host checkpoint | Canary |
|---|---|---|---|
| **F0** | Add `SAILFIN_TRACE_RAW` probe (read-only). | `make compile` (behavior unchanged). | run `SAILFIN_TRACE_RAW=1 make compile`, save baseline Raw census. |
| **A** | Parser: always-lift pointer/fn-ptr cast targets → `Cast`. Split `check_fn_reference_raw` → `classify_fn_cast` (E0809 scoped to `* fn (...)`; `* u8` accepted for any concrete fn) + residual `& fn`. typecheck `Cast` arm classifies bare-fn-Identifier operand. | `make compile` (esp. `capsules/sfn/http/src/server.sfn:142`). | `effect_cast_operand_test` (update gate test), `fn_reference_typecheck_test`. |
| **B** | Parser: prefix `*`/`&` → `Unary`. typecheck: add `Unary` arm to `walk_expression` (recurse operand → preserves `&fn` E0808). | `make compile` + IR-diff in-source `*ptr`/`&x`. | `effect_prefix_deref_addr_test`. |
| **C** | Cast-target reader: accept generic/`fn (...)` targets via type-annotation parser. | `make compile`. | `cast_generic_target_test`. |
| **D** | AST `Assignment` node; parser assignment seam; formatter arm; **7 walker arms**. | `make compile` + IR-diff simple/compound/member/index assignments — **the high-risk gate**. | `assignment_node_ir_identity_test`, `effect_assignment_test`. |
| **E** | `E0817` at `parse_unknown_statement` site (gated vs E0500/E0411/removed-keyword); defensive `Unknown` effect arm `[]`. | `make compile`. | `effect_unknown_block_level_test`. |
| **F** | Re-run `SAILFIN_TRACE_RAW=1 make compile` → **must emit zero** Raw for compiler/runtime/capsules. Then flip the E0818 arm. Remove (or gate-off) the probe. | **`make compile` green = the proof no in-source Raw survives**; then `make check`. | `effect_raw_failclosed_test`, `effect_raw_negative_substring_test`. |

**Bundling / no seed cut:** every stage is a compiler-source change consumed by
the same self-host pass. `make compile` builds the new compiler from the pinned
seed; that compiler then compiles runtime + capsules (the consumers of the new
parsing/effect behavior) in the same pass. There is no separate consumer release,
so **no seed cut, no `/pin-seed`** (per `.claude/rules/seed-dependency.md`). The
old seed never runs the new E0818 arm — enforcement first fires in the
firstpass→seedcheck build, exactly like #957.

### Self-host risk register (parts A–F)

| Risk | Detection | Mitigation |
|---|---|---|
| Part A re-introduces E0809 on the http trampoline. | `make compile` fails building `server.sfn:142`. | E0809 scoped to typed `* fn (...)` targets; `* u8` accepted for any concrete fn (ABI-sound: `* u8` is conventionless). |
| Part A `Cast` arm classifies a fn-cast in argument position that the old Raw path skipped. | `fn_reference_typecheck_test` + `make compile`. | classification is uniform & *correct* now (E0809 only on typed targets), so position no longer matters — no predicate to preserve. |
| Part B `&fn` loses E0808 (no `Unary` arm in walk_expression). | `fn_reference_typecheck_test` (E0808 case). | add `Unary` recursion to `walk_expression`; operand `Identifier` arm emits E0808. |
| Part B `&<call>`/`*<call>` formatter text diverges from prior Raw text. | IR-diff canary. | formatter emits `&operand`/`*operand` verbatim — byte-identical to the prior Raw string. |
| **Part D assignment node changes hundreds of sites → IR drift.** | **IR-diff canary (simple/compound/member/index)** + `make compile`. | formatter→shadow-parser identity; compound operator preserved (desugar stays in lowering). |
| Part D `=` mis-parsed as `==` (or vice versa). | parser unit test; `make compile`. | peek the full operator token, exclude `==`/`!=`/`<=`/`>=`. |
| Part E E0817 double-fires with E0500/E0411/removed-keyword. | `effect_unknown_block_level_test` dedup assertions. | gate on `detect_removed_ai_keyword`/`detect_unsupported_statement_keyword` empty + nested-only. |
| **Part F flip breaks self-host** (a missed Raw producer). | `SAILFIN_TRACE_RAW` pre-flip census == empty; `make compile` post-flip. | structure the named producer before flipping; the probe makes discovery cheap and pre-emptive. |
| Closure-pair `Raw` marker (`lambda_lowering.sfn:957`) trips E0818. | `make compile`. | that marker is created **after** typecheck/effect-check, so the E0818 arm never sees it — confirmed (unchanged from prior analysis). |

### Verification commands

- `SAILFIN_TRACE_RAW=1 make compile 2>&1` before Stage A (baseline census) and
  before Stage F (must be empty for compiler/runtime/capsules).
- `make compile` after **every** stage (self-host checkpoint).
- IR-diff canaries (Stages B, D): drive from `![io]` `*_test.sfn` via
  `process.run_capture` building a fixture with `sfn build` (thread `PATH` +
  `SAILFIN_TEST_SCRATCH`), capture the `.ll`, `diff` against the pre-change
  golden — per `.claude/rules/no-bash-e2e.md`.
- `make check` (triple-pass) before declaring shipped.
- `sfn fmt --check` on every touched `.sfn`.

### Files affected (parts A–F), by pipeline stage

- **Parser:** `compiler/src/parser/expressions.sfn` (cast-target reader A/C;
  prefix `*`/`&` B; assignment seam D), `compiler/src/parser/statements.sfn`
  (E0817 at `parse_unknown_statement` E).
- **AST:** `compiler/src/ast.sfn` (`Assignment` node D).
- **Typecheck:** `compiler/src/typecheck.sfn` (`Cast` arm classification A;
  `Unary` arm B; `Assignment` arm D), `compiler/src/typecheck_types.sfn`
  (`classify_fn_cast` split + `make_unparseable_statement_diagnostic` E0817 +
  `make_effectful_raw_diagnostic` E0818), `compiler/src/typecheck_captures.sfn`
  (`Assignment` arm D).
- **Effect checker:** `compiler/src/effect_checker.sfn` (`Assignment` arm D;
  `Unknown` defensive arm E; **E0818 `Raw` flip F**).
- **Ownership:** `compiler/src/ownership_checker.sfn` (`Assignment` arm D).
- **Emit / format:** `compiler/src/emit_native_format.sfn` (`Assignment` arm D),
  `compiler/src/emitter_sailfin_expr.sfn` (`Assignment` arm D).
- **Lowering:** `compiler/src/llvm/expression_lowering/native/lambda_lowering.sfn`
  (`Assignment` capture-rewrite arm D). **No new codegen arm** — Cast/Unary/
  Conditional/Assignment all serialize to the exact text the shadow parser
  already lowers.
- **Tests:** the canaries listed per stage, under `compiler/tests/unit/` and
  `compiler/tests/e2e/`.
- **Docs:** `docs/status.md` (effect fail-closed → shipped), SFEP-0008 (flip
  #1180-c row toward Implemented when this lands), this design note.

---

## Shipped in #1627 (actual scope)

Implementation narrowed the PR to the **cast-shaped effect escape** — the
demonstrated headline hole (`print.info(x) as * i64` fired at runtime with no
`![io]`) and its `as int` sibling — because the other constructs each carry a
distinct, larger blast radius that warrants its own tested PR (see the revised
split below). Delivered:

1. **`Cast` effect arm** (`effect_checker.sfn::collect_effects_from_expression`)
   — walks the cast operand, so `<effectful> as <type>` surfaces the operand's
   effects. Closes the `as int` escape alone.
2. **Pointer cast-target parsing, gated to effect-bearing operands**
   (`parser/expressions.sfn`, the `as` postfix arm) — `<operand> as * T` / `* * T`
   structures into `Cast` (with `target_type.text = "* T"`, which the formatter
   renders back to the identical `(operand) as * T` text the shadow parser
   already lowers) **only when the operand is NOT a bare `Identifier`**. A bare
   identifier carries no effect, so the #1627 escapes (operands are calls/members)
   lose nothing, while `<fn> as * u8` and the dominant in-source `<ptr-value> as
   * u8` spelling keep their exact legacy `Raw` path — fn-reference diagnostics
   and lowering untouched. **(The 2026-06-27 revision Part A removes this gate —
   the always-lift + scoped-E0809 fix supersedes it.)**
3. **The gate (item 2) replaced an earlier fn-reference-cast migration.** First
   attempt structured *every* `<operand> as * T` into `Cast` and moved the
   E0808/E0809 classification onto the `Cast` arm (`check_fn_reference_cast`).
   CI surfaced a regression: the shipped http-server trampoline
   `_sfn_http_trampoline as * u8` (`capsules/sfn/http/src/server.sfn:142`) is a
   **concrete** function whose `fn(OwnedBuf) -> OwnedBuf` signature is struct-ABI,
   not C-ABI-primitive — so `signature_is_c_abi` is false and the migrated check
   newly flagged it E0809. The prior `Raw` path had never flagged it (it sits as
   a call argument, so the whole call was `Raw` and `check_fn_reference_raw`'s
   `head == left` guard bailed). Rather than relax the C-ABI rule (broad blast
   radius) or replicate call-position, the gate keeps bare-identifier fn casts on
   the untouched `Raw` path entirely — zero fn-reference behavior change, and the
   `typecheck.sfn`/`typecheck_types.sfn` migration was reverted. **(2026-06-27
   Part A resolves this at its root: E0809 is scoped to typed `* fn (...)`
   targets; an erased `* u8` carries no convention, so the trampoline classifies
   clean and can be structured — the regression that forced the gate no longer
   exists.)**
4. Regression coverage: `compiler/tests/unit/effect_cast_operand_test.sfn`
   (structural lift over a call operand + effect attribution + the effect-free
   bare-pointer-cast canary + a guard pinning the bare-identifier `Raw` gate).

**Not shipped here — filed as #1180 sub-issues:** prefix `*`/`&` → `Unary`,
ternary → `Conditional`, the blanket `E0818` `Raw` backstop (it requires
structuring *every* Raw-lowerable shape first), and the `E0817` `Unknown` arm
(cleaner at the parser production site). The full staged design (A/B/C/D/E)
below is retained as the roadmap those sub-issues execute against. **The
2026-06-27 revision at the top is the consolidated, current endgame for the
remaining sub-issues (#1180-b and #1180-c) and supersedes the older staging
where they conflict.**

## Problem

After #1186 deleted `collect_effects_from_text`, two AST nodes the effect
checker cannot resolve structurally contribute **zero effects, silently**:

- `Expression.Raw` — `collect_effects_from_expression`
  (`effect_checker.sfn:735`) has no `"Raw"` arm and falls through to `return []`
  (`:980`).
- `Statement.Unknown` — `collect_effects_from_statement`
  (`effect_checker.sfn:531`) has no `"Unknown"` arm and falls through to
  `return []` (`:621`).

Reproduced and confirmed **live end to end** (`build/native/sailfin` 0.7.0-alpha.49):
`fn f() { let x = print.info("hi") as * i64; }` passes `sfn check` (exit 0) with
and without `SAILFIN_EFFECT_ENFORCE=1`, **and fires the side effect at runtime**
(`[info] SIDE EFFECT FIRED`, run exits 0). An effectful operation reaches codegen
with no declared capability — a fail-open hole in the effects pillar.

## Root cause — the lowering shadow parser and the structured-parser gaps

The `.sfn-asm` pipeline is **AST → `format_expression_into` (serialize to text,
`emit_native_format.sfn`) → LLVM lowering re-parse**. The lowering layer
(`llvm/expression_lowering/native/core.sfn:2120-2600+`) is a *complete second
expression parser* operating on text: ternary, cast, raw_address, borrow,
logical/bitwise/comparison/shift/additive/multiplicative precedence climbing,
prefix `!`/`*`, member, index, call (re-parse helpers in
`llvm/expressions_parsing.sfn` and `core_parsing.sfn`). Crucially, the formatter
serializes **structured** nodes back to text too (e.g. `Cast` →
`(operand) as <type>` at `emit_native_format.sfn:192-201`), so the shadow parser
is fed by the formatter for every expression — it is not a `Raw`-only path.

`Raw` (and the effect-escape) only arises where the **front-end structured
parser fails** and degrades to `Raw` (`parser/expressions.sfn:271,278`), OR where
a node parses structurally but the **effect checker has no arm** for it. The
effect-escaping set is **small, enumerable, and was measured directly** (probe:
wrap `print.info(...)` in each construct and check whether `![io]` is required):

| Construct | Node produced | Why effects escape | Probe result |
|---|---|---|---|
| `print.info(x)` | `Member`/`Call` | — (correctly errors) | error (baseline) |
| `(print.info(x))` | structured | — (correctly errors) | error |
| `print.info(x) + 1`, `== 1`, `[i]` | structured | — (correctly errors) | error |
| **`print.info(x) as int`** | **`Cast`** (`ast.sfn:95`) | effect checker has **no `"Cast"` arm** → `[]` | **ok (escaped)** |
| **`print.info(x) as * i64`** | **`Raw`** | cast arm rejects non-ident target (`expressions.sfn:706-708`) | **ok (escaped)** |
| **`print.info(x) ? 1 : 2`** | **`Raw`** | no ternary in structured parser | **ok (escaped)** |
| **`*print.info(x)`** | **`Raw`** | prefix parser handles only `-`/`!` (`expressions.sfn:369-387`) | **ok (escaped)** |
| **`&print.info`** | **`Raw`** | prefix parser handles only `-`/`!` | **ok (escaped)** |

So the "structural lift" is **bounded** — not "reimplement the shadow parser."
It is exactly: (1) add a `Cast` arm to the effect checker; (2) let the cast arm
parse pointer/fn cast targets so `as *T` structures into `Cast` instead of `Raw`;
(3) structure prefix `*` (deref) and `&` (address-of) into `Unary` (already
effect-walked, `effect_checker.sfn:870`); (4) structure ternary `? :` into a node
the effect checker walks. After that, every remaining `Raw` reaching the effect
checker is genuinely unlowerable junk, so a **blanket fail-closed `Raw` arm is
self-host-clean** (zero in-source false positives) and honors the "no text
inspection" constraint.

**Why this is IR-safe by construction:** the formatter already serializes
structured nodes to the exact text the shadow parser consumes (`Cast` →
`(op) as <target.text>`). A newly-structured `Cast{operand, target_type.text="* i64"}`
serializes to `(print.info(...)) as * i64` — *the same text the lowering
`parse_cast_expression` handles today*. Structuring the node changes **what the
effect checker sees**, not what the lowering re-parser receives. The 745 in-source
`as *T` casts lower through the identical text path before and after.

## The constraint that ruled out the cheaper fixes (retained analysis)

A blanket "any non-empty `Raw` is an error" check applied **before** the
structural lift is wrong and breaks self-host: `Raw` is overloaded as the valid
"lowering knows how" channel for `as *T` casts (745 in-source sites,
`grep "as \* " compiler/src runtime` excluding tests), `& fn` /
`<fn> as *T` (`check_fn_reference_raw`, `typecheck_types.sfn:1785`), and
member/index chains. There are only four `Expression.Raw` producers in the parser
(`grep Expression.Raw compiler/src/parser`): `expressions.sfn:75` (the
`success:false` placeholder, never a real node) and `:257,271,278` (the three
`expression_from_tokens` failure paths). The valid casts flow through the *same*
`:271`/`:278` paths as the junk, so **parser-site promotion or a pre-lift blanket
`Raw` check cannot distinguish them** — the distinction is only made by the
lowering re-parse. This is precisely why the fix must first *remove the overload*
(structure the valid shapes) and only then blanket-fail-close.

The earlier **text-anchor floor** (`_raw_contains_effectful_anchor` →
conservative `E0818` only when the Raw text contains an effectful builtin call
anchor) was the self-host-clean option *without* the structural lift. It is
**superseded** by the gate decision in favor of the root fix, because the floor
leaves the `Raw` overload in place (and re-parse divergence latent) whereas the
lift eliminates it. The floor's analysis is what proved the lift is bounded and
safe, so it is retained here for the record.

## Design — the structural lift

### AST (`compiler/src/ast.sfn`)

- **`Cast`** already exists (`:95`): `Cast { operand: Expression, target_type: TypeAnnotation }`. No change needed; `target_type.text` is a free-form string that can hold `* i64` / `* fn(i64) -> i64`.
- **Prefix `*` / `&`** reuse **`Unary`** (`:66`): `Unary { operator: string, operand: Expression }` with `operator ∈ {"*", "&"}`. The effect checker's `Unary` arm (`:870`) already walks the operand, and the formatter's `Unary` arm (`emit_native_format.sfn:108`) already serializes `<op>operand` text the shadow parser's prefix-`*` / borrow handlers consume. **Verify** the formatter emits `&`/`*` prefixes in the exact spelling `parse_borrow_expression` (`&x`) and the `*`-deref handler (`core.sfn:2281`) expect; if the existing `Unary` formatter only covers `-`/`!`, extend it to pass `&`/`*` through verbatim.
- **Ternary** — no node exists. Add **`Conditional { condition: Expression, then_value: Expression, else_value: Expression, span: SourceSpan? }`**. The formatter serializes it as `(condition) ? (then) : (else)` to match the shadow `parse_ternary_expression` (`expressions_parsing.sfn:455`), which scans for top-level `?`/`:`. The effect checker walks all three children (merge). (Alternatively, if a smaller surface is preferred, ternary can stay deferred to #1180-a and #1627 ships casts + prefix `*`/`&` only — see Staging.)

### Parser (`compiler/src/parser/expressions.sfn`)

- **Cast target** (`:700-717`): replace the single-`Identifier`-only target read with a small type-target reader that accepts pointer (`* T`, `* fn(...) -> T`) and bare-identifier targets, capturing the full target text into `TypeAnnotation.text`. On success build `Expression.Cast`; only genuinely unparseable targets fall through to `expression_parse_failure`. Reuse the existing type-annotation parsing path (the same one that parses `let p: * i64`) so `* i64` / `* fn(...) -> T` spellings stay in lockstep with type-annotation grammar.
- **Prefix `*` / `&`** (`parse_prefix_expression`, `:369-387`): extend the symbol set from `{-, !}` to `{-, !, *, &}`, building `Expression.Unary { operator: sym, operand: <parsed at unary_precedence()> }`. The binary `&`/`*` handlers (`binary_precedence` `:1566/:1586`) are unaffected — they only apply in infix position, which `parse_prefix_expression` is not.
- **Ternary** (only if included in #1627): after the precedence-climbing loop yields `left`, peek for a top-level `?`; if present, parse `then`, expect `:`, parse `else`, build `Conditional`. Lowest precedence, so it wraps the whole climbed expression.

### Lowering (`emit_native_format.sfn` + `llvm/...`)

- **`Cast`** already serializes (`:192-201`) and lowers (`parse_cast_expression` → `lower_cast_expression`, `core.sfn:2189-2191`). The only change is upstream (parser now produces `Cast` for `as *T` where it produced `Raw`), and the serialized text is identical, so **no lowering change** is required for casts.
- **`Unary` `*`/`&`**: confirm/extend the `Unary` formatter (`:108`) to emit `*operand` / `&operand`; the shadow parser already lowers `*x` (`core.sfn:2281`) and `&x` (`parse_borrow_expression`). **No new lowering arm** — reuse existing.
- **`Conditional`**: add a formatter arm emitting `(cond) ? (then) : (else)`; lowering already handles it via `parse_ternary_expression` (`core.sfn:2184-2186`). **No new lowering arm.**

The migration is therefore **front-end-only for casts and prefix ops** — the lowering text path is untouched; we only stop feeding it `Raw` and start feeding it the *same text* serialized from a structured node.

### Effect checker (`compiler/src/effect_checker.sfn`)

- Add **`Cast` arm** in `collect_effects_from_expression` (before `:980`): `return collect_effects_from_expression(expression.operand, imports)`. This alone closes the `as int` escape immediately (independent of the parser work).
- `Unary` arm (`:870`) already covers prefix `*`/`&` once the parser emits `Unary`.
- Add **`Conditional` arm** (if shipped): merge effects of `condition`, `then_value`, `else_value`.
- **Blanket fail-closed `Raw` arm** (before `:980`), enabled **only after** the lift lands: any non-empty `Raw` reaching here is unlowerable → emit **`E0818`** ("unstructured expression cannot be analyzed; rewrite so the compiler can parse it"). Empty `Raw{text:""}` returns `[]` (never effectful). The typecheck `Raw` arm's `check_fn_reference_raw` (`typecheck.sfn:1072`) stays as-is for `&fn`/`fn as *T` E0808/E0809 — but note those `&fn` spellings now structure into `Unary`, so re-confirm `check_fn_reference_raw` still receives the inputs it expects (see Risks).
- Add **`Unknown` arm** in `collect_effects_from_statement` (before `:621`): emit **`E0817`** ("unparseable statement reached analysis"), gated so it does not double-fire when the typecheck Unknown arm (`typecheck.sfn:645-660`) already minted removed-AI-keyword / `E0411`, i.e. fire only when `detect_removed_ai_keyword(text).length == 0 && detect_unsupported_statement_keyword(text).length == 0`. Top-level `E0500` (`tools/check.sfn:165`) is on a disjoint node position.

### Diagnostics

Add `make_effectful_raw_diagnostic` (`E0818`) and `make_unparseable_statement_diagnostic` (`E0817`), mirroring `make_parse_error_diagnostic` (`typecheck_types.sfn:573-586`). Surface via the effect-diagnostic stream (so `SAILFIN_EFFECT_ENFORCE`/`[kind: effect]` rendering applies) or, for `E0818`, co-locate in the typecheck `Raw` arm (`typecheck.sfn:1072`) — the implementer picks the site that matches the acceptance criteria's enforcement-gating expectations.

## Staging (each gate self-hosts or at least `sfn check`s)

**Stage A — structure casts + add Cast effect arm (the headline fix).**
1. Effect checker: add `Cast` arm (walk operand). Closes `as int` escape.
2. Parser: extend cast target to accept `* T` / `* fn(...)` → `Cast` instead of `Raw`.
3. No lowering change (serialized text identical).
- **Gate:** `make compile` then IR-diff a sampling of in-source `as *T` casts (see Verification). `sfn check` of the Stage-A probe (`print.info(x) as * i64`) must now require `![io]`.

**Stage B — structure prefix `*` / `&` into `Unary`.**
4. Parser: add `*`,`&` to `parse_prefix_expression`. Formatter: ensure `Unary` emits `*`/`&` verbatim.
- **Gate:** `make compile` + IR-diff in-source `*ptr` / `&x` sites; effect probe for `*print.info(x)` / `&print.info` (the `&fn` value-use should now route through `Unary`→`check`; confirm `check_fn_reference_raw` coverage is preserved or migrated — Risks).

**Stage C — (optional) structure ternary into `Conditional`.** Parser + formatter + effect arm. Gate as above. *May defer to #1180-a if it widens blast radius.*

**Stage D — blanket fail-closed `Raw` arm (`E0818`).** Only after A–C land and `make compile` is green: flip the `Raw` arm from `[]` to `E0818` for non-empty text.
- **Gate:** `make compile` MUST stay green — this is the self-host proof that no in-source `Raw` survives. If it fails, the failing site names a construct still degrading to `Raw` that A–C missed; structure it (or, if it is genuine junk in source, fix the source).

**Stage E — `Unknown` arm (`E0817`) + tests + docs.** Independent of A–D; can land in the same PR.

Stages A+B+D+E are the recommended #1627 scope; **C (ternary) defers to #1180-a if it proves to widen the diff.** All stages ship in **one PR** (bundle): `make compile` builds the new compiler from the old seed and that compiler compiles the runtime/compiler in the same pass — **no seed cut** (per `seed-dependency.md`).

## Self-host risk + evidence

- **Casts (Stage A):** IR-safe by construction — `Cast` serializes to the identical `(op) as <type>` text the shadow parser already lowers; the 745 in-source `as *T` sites are untouched in the lowering text path. Verified `Cast` already round-trips through `emit_native_format.sfn:192-201`.
- **Prefix `*`/`&` (Stage B):** `Unary` already serializes and the shadow parser already lowers `*x`/`&x`. **Residual risk:** `&fn` value-uses currently reach `check_fn_reference_raw` via `Raw`; once `&` structures into `Unary`, that diagnostic input changes. Mitigation: migrate the `&fn`/`fn as *T` E0808/E0809 detection to operate on the structured `Unary`/`Cast` (cleaner) OR keep `check_fn_reference_raw` reachable for the residual `fn as *T` Raw forms. **Must be verified by `make check`** — the `fn`-reference tests (`typecheck` E0808/E0809 coverage) are the canary.
- **Blanket `Raw` (Stage D):** self-host-clean **iff** A–C structured every in-source effect-escaping shape. The `make compile` gate at Stage D is the empirical proof; a failure is a precise, actionable signal (names the unstructured construct). The closure-pair `Raw` marker (`lambda_lowering.sfn:957`) is created **after** typecheck/effect-check, so the Stage-D arm never sees it — confirmed.
- **`Unknown` (Stage E):** zero in-source nodes. No `"Unknown"` arm exists in LLVM lowering (`grep` shows arms only in `emitter_sailfin*.sfn`, the `fmt` round-trip, not codegen), so a nested in-source Unknown would be silently dropped and manifest as missing functionality; the tree self-hosts, so none exist. Top-level Unknown already errors via `E0500`.

## Verification (commands)

- IR-diff harness (Stage A/B): for a sampling of in-source cast/prefix sites (e.g. `runtime/sfn/array.sfn`, `concurrency/scheduler.sfn`), capture `sfn build --emit-llvm` (or the `.ll` under the build cache) **before** and **after** the parser change and assert byte-identical IR for the affected functions. Drive from an `![io]` `*_test.sfn` via `process.run_capture` + `clang`/`diff`, per `.claude/rules/no-bash-e2e.md`.
- `make compile` after each stage; `make check` before declaring shipped.
- Effect probes (the measured table above) as e2e assertions.

## Regression test plan

1. `effect_cast_operand_walk_test.sfn` — `print.info(x) as int` and `as * i64` without `![io]` → `E04xx` ![io] required (Stage A headline).
2. `effect_cast_pointer_clean_test.sfn` — `out as * i64`, `(p as i64 + 16) as * i64` (no effectful operand) → no diagnostic (745-population/self-host canary).
3. `effect_prefix_deref_addr_test.sfn` — `*print.info(x)`, `&print.info` → effect required / fn-value diagnostic preserved (Stage B; pins the `&fn` migration).
4. `cast_ir_identity_test.sfn` — IR-diff a representative in-source `as *T` cast before/after; assert identical (migration-safety).
5. `effect_raw_failclosed_test.sfn` — a genuinely unlowerable expression (post-lift) → `E0818`; and a valid structured expression → clean (Stage D).
6. `effect_unknown_block_level_test.sfn` — nested `@@@ junk !!!` → `E0817`; top-level `@@@` still `E0500`; `while(){}` still `E0411` (dedup proof).
7. `effect_raw_negative_substring_test.sfn` — Raw/structured text mentioning `print` as a non-call substring → no `E0818` (proves no text-scan re-introduction).

Self-host gate: `make compile` + `make check`.

## Final sub-issue split under epic #1180

- **#1627 (this PR), size M — SHIPPED: casts only.** `Cast` effect arm, `as *T`
  cast-target parse, the fn-reference-cast migration (E0808/E0809), diagnostics
  reuse, and `effect_cast_operand_test`. Bundled (no seed cut). Closes the
  demonstrated cast-shaped effect escape; the constructs below are now tracked
  follow-ons rather than part of this PR.
- **#1180-a "Structure ternary `? :` into a `Conditional` AST node" — M —
  SHIPPED (#1690).** A ternary now parses into `Conditional { condition,
  then_value, else_value, span }`; the effect checker unions all three children's
  effects, closing the `cond ? readFile() : x` escape (`E0400`). The `?`/`:`
  disambiguation is two-signal: a `?` is ternary only when the token after it can
  start an expression **and** a nesting-aware top-level `:` follows — the
  expression-start signal is what keeps a try operator immediately before an
  enclosing ternary's colon (`outer ? inner()? : z`) parsing the inner `?` as a
  `TryOperator`. Postfix `a()?` / `a()?.b()?` are untouched (self-host on them is
  preserved). The formatter serializes `(cond) ? (then) : (else)` — the exact text
  the shadow `parse_ternary_expression` already lowers (no new lowering arm); a
  `TryOperator` formatter arm was added for a try left inside a ternary branch
  (the desugarer correctly does **not** hoist branch-tries). `Conditional` arms
  were also added to every structural walker (typecheck, capture analysis,
  ownership scope, lambda-capture rewrite) so the node is fully analyzed, not just
  effect-checked. Regression coverage: `effect_conditional_branch_test.sfn`. The
  compiler/runtime source contains no ternaries, so the path is dormant under
  self-host. **Remaining gap (filed separately):** typecheck does not yet unify
  the then/else branch types, so `cond ? 1 : "s"` is not rejected — a follow-on.
  Cite SFEP-0008.
- **#1180-b "Parser-level parse diagnostic at `Unknown` production sites" — S.**
  A nested `Statement.Unknown` (unparseable statement inside a block) is silently
  dropped — no diagnostic, no effects; top-level gets `E0500`, nested gets
  nothing. Promote `parse_unknown`/`parse_unknown_statement` call sites
  (`declarations.sfn:1793`, `statements.sfn:1511`) to record a parse diagnostic
  with a precise span (analog of `ParseError`, #1531), gated to avoid
  double-firing with `E0500`/`E0411`/removed-keyword. Cleaner than threading a
  top-level flag through the shared `check_statement` walker. Cite SFEP-0008.
  **(2026-06-27: this is Part E above.)**
- **#1180-c "Retire the lowering shadow expression parser; structure remaining
  Raw-lowerable forms + blanket `Raw` fail-closed (`E0818`)" — L (epic-sized).**
  Structure the residual valid-but-`Raw` constructs (prefix `*`/`&` deref/addr —
  prefix `&` interacts with `check_fn_reference_raw`'s `& fn` E0808 path; assign-
  as-expression; generic/fn-pointer cast targets) and lower structured nodes
  directly instead of serializing to text and re-parsing in `core.sfn`. Only once
  **no** valid construct degrades to `Raw` can the blanket `E0818` `Raw` arm be
  enabled self-host-clean (the defense-in-depth that catches unknown/future
  escapes). Also a build-perf win (removes the 745-site text re-parse). Cite
  SFEP-0008 and `0006-build-architecture.md`. **(2026-06-27: the
  blanket-`E0818`-enabling slice is Parts A–D + F above. The "lower structured
  nodes directly instead of re-parsing" build-perf slice remains a separate,
  later effort — Parts A–F deliberately keep the formatter→shadow-parser text
  bridge so the diff stays effect-focused and IR-identical; retiring the shadow
  parser is orthogonal and out of scope for the E0818 flip.)**
- **#1180-d "Stale-comment cleanup for retired text-scan effect path" — XS.**
  `effect_checker.sfn:60`/`:461` still reference the "text-pattern (Raw body)
  path" deleted in #1186. Audit `effect_checker.sfn`/SFEP-0008.
