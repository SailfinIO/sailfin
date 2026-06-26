# Design note — #1627: fail-closed enforcement for effect-opaque `Raw` / `Unknown` nodes

- **Issue:** #1627 (effect-system hardening)
- **Epic:** #1180
- **Design record extended:** SFEP-0008 (`docs/proposals/0008-effect-validation.md`)
- **Author:** agent:compiler-architect
- **Status:** Draft (single-issue design gate; not a new SFEP)
- **Date:** 2026-06-26
- **Decision:** **Structural lift (root fix)** chosen at the design gate. The
  earlier text-anchor "floor" (`_raw_contains_effectful_anchor`) is **superseded**
  and retained below only as the analysis that led to the root-fix decision.

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
   and lowering untouched.
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
   `typecheck.sfn`/`typecheck_types.sfn` migration was reverted.
4. Regression coverage: `compiler/tests/unit/effect_cast_operand_test.sfn`
   (structural lift over a call operand + effect attribution + the effect-free
   bare-pointer-cast canary + a guard pinning the bare-identifier `Raw` gate).

**Not shipped here — filed as #1180 sub-issues:** prefix `*`/`&` → `Unary`,
ternary → `Conditional`, the blanket `E0818` `Raw` backstop (it requires
structuring *every* Raw-lowerable shape first), and the `E0817` `Unknown` arm
(cleaner at the parser production site). The full staged design (A/B/C/D/E)
below is retained as the roadmap those sub-issues execute against.

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
- **#1180-a "Structure ternary `? :` into a `Conditional` AST node" — M.**
  `cond ? readFile() : x` degrades to `Raw` and escapes `![io]` (confirmed live).
  Needs a new `Conditional` node + `?`/`:` lookahead disambiguation that does
  **not** regress postfix `TryOperator` (`a()?`, used throughout compiler source —
  a regression breaks self-host), formatter (→ `cond ? a : b`, shadow parser
  already lowers it), effect arm. Self-contained but precedence-delicate; its own
  tested PR. Cite SFEP-0008.
- **#1180-b "Parser-level parse diagnostic at `Unknown` production sites" — S.**
  A nested `Statement.Unknown` (unparseable statement inside a block) is silently
  dropped — no diagnostic, no effects; top-level gets `E0500`, nested gets
  nothing. Promote `parse_unknown`/`parse_unknown_statement` call sites
  (`declarations.sfn:1793`, `statements.sfn:1511`) to record a parse diagnostic
  with a precise span (analog of `ParseError`, #1531), gated to avoid
  double-firing with `E0500`/`E0411`/removed-keyword. Cleaner than threading a
  top-level flag through the shared `check_statement` walker. Cite SFEP-0008.
- **#1180-c "Retire the lowering shadow expression parser; structure remaining
  Raw-lowerable forms + blanket `Raw` fail-closed (`E0818`)" — L (epic-sized).**
  Structure the residual valid-but-`Raw` constructs (prefix `*`/`&` deref/addr —
  prefix `&` interacts with `check_fn_reference_raw`'s `& fn` E0808 path; assign-
  as-expression; generic/fn-pointer cast targets) and lower structured nodes
  directly instead of serializing to text and re-parsing in `core.sfn`. Only once
  **no** valid construct degrades to `Raw` can the blanket `E0818` `Raw` arm be
  enabled self-host-clean (the defense-in-depth that catches unknown/future
  escapes). Also a build-perf win (removes the 745-site text re-parse). Cite
  SFEP-0008 and `0006-build-architecture.md`.
- **#1180-d "Stale-comment cleanup for retired text-scan effect path" — XS.**
  `effect_checker.sfn:60`/`:461` still reference the "text-pattern (Raw body)
  path" deleted in #1186. Audit `effect_checker.sfn`/SFEP-0008.
