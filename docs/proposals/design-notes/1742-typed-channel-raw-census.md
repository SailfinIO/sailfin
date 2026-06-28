# Design note — #1742: typed `channel:Type` structuring + tests-inclusive `Raw` census

- **Issue:** #1742 (structure typed `channel:Type` / `spawn:Type`; tests-inclusive `Raw` census)
- **Epic:** #1692 (sub-track of #1180); prerequisite for the blanket `E0818` flip
- **Design record extended:** SFEP-0008 (`docs/proposals/0008-effect-validation.md`)
  and the companion note `1627-fail-closed-raw-unknown-effects.md` (the E0818 endgame)
- **Author:** agent:Sailbot (orchestrator)
- **Status:** Draft (single-issue design gate; not a new SFEP)
- **Date:** 2026-06-28

---

## 1. What shipped in this PR

`channel:Type(N)` (the typed-channel constructor, e.g. `channel:OwnedBuf(2)`) now
parses into a **structured `Expression.Channel`** node instead of degrading to
`Expression.Raw`. The parser populates the long-reserved `element_type:
TypeAnnotation?` and `kind: string` fields on `Channel` from the `:Type`
annotation; the bare-type name is captured **verbatim** (e.g. `"OwnedBuf"`)
because the native lowering (`lower_channel_typed_expression` in
`compiler/src/llvm/expression_lowering/native/core.sfn`) slices the element kind
out of the serialized `channel:<kind>(` text to drive the `owned` flag and ring
stride.

Because the `emit_native_format.sfn` `Channel` arm already serializes a node with
`kind.length > 0` as exactly `channel:<kind>(<cap>)` — byte-identical to the text
the shadow re-parser already lowers — **no new lowering arm, AST field, effect-checker
arm, typecheck arm, or formatter arm was required.** The single change is in the
parser (`compiler/src/parser/expressions.sfn`): the `channel` dispatch now commits
on the `channel:<Ident>(` form, and `parse_channel_expression` consumes the optional
`:Type` before the argument list.

**Effect:** the structured `Channel` node is now walked by the effect checker
(`collect_effects_from_expression`'s `Channel` arm recurses into `capacity`) and
the typechecker, closing the soundness gap where an effectful capacity argument
(`channel:OwnedBuf(io_call())`) inside a typed channel silently contributed zero
effects via the `Raw` fall-through.

`spawn:Type` is **not** a `Raw` producer: `spawn` followed by `:` is an explicit
hard `ParseError` (issue #1531 — `spawn:<type>` is internal native-IR notation,
not user syntax). The concurrency test exercises the structured `Spawn` via the
bare `spawn fn() -> int { ... }` form, whose `kind` is derived from the lambda
return type. No change was needed for `spawn`.

### Verification

- `concurrency_lowering_ir_test` — 7/7 pass, incl. `channel:OwnedBuf(2)` →
  `elem_size 32, owned 1`.
- `concurrency_ownedbuf_asan_interleave_test` — 2/2 pass.
- `string_append_test` — 12/12 pass (a cited #1737 over-fire offender).
- `make compile` self-hosts.

---

## 2. Tests-inclusive `Raw` census

**Method.** A throwaway sentinel was wrapped around the `emit_native_format.sfn`
`Raw` arm (`out.push("RAWCENSUS<<" + text + ">>")`), the compiler was rebuilt, and
`sfn emit native` was run over every `.sfn` in `compiler/tests/`, `examples/`, and
`capsules/` (578 files); the self-host build of `compiler/src` + `runtime` was its
own census leg (a non-empty `Raw` would lower the sentinel text and break the
build — it did not). The sentinel was then reverted; **only the parser change ships.**

The emitter sentinel surfaces `Raw` at the *serialization* layer, which is a
**superset** of the effect-checker-visible `Raw`. Two emit-layer-only categories
were filtered out as non-concerns and cross-checked against the parser/effect-checker
by direct tracing (`compiler-explorer`):

- **Emitter-synthesized closure directives** (`<closure_pair …>`,
  `<closure_env_load_prologue …>`) — created during lambda *lowering*, after
  effect-check; never reach `collect_effects_from_expression`.
- (Re-classified — see below) match-arm patterns.

### Census results

| Set | Valid-but-`Raw` reaching the effect checker |
|---|---|
| `compiler/src` + `runtime` (self-host set) | **Zero** — clean self-host under the sentinel proves it |
| `compiler/tests` + `examples` + `capsules` | The residual classes in the table below |

| Construct | Hits | Reaches `collect_effects_from_expression`? | Shipped status | Disposition |
|---|---|---|---|---|
| **`channel:Type(N)`** | — | was `Raw`, now `Channel` | shipped | **Structured (this PR).** |
| `spawn:Type` | — | hard `ParseError` (not `Raw`) | n/a (#1531) | Not a `Raw` producer. |
| Match-arm patterns `Result.Ok { value }`, `Shape.Circle { radius }`, … | 56 | **Yes** (`collect_effects_from_match_case` → `collect_effects_from_expression(case.pattern)`) | **shipped, core** | **Deferred to the E0818 flip.** Patterns are a *binding* position, not an effectful expression; the flip must structure patterns into a dedicated `Pattern` node (or skip the pattern position in `collect_effects_from_match_case`). Out of #1742's named `In:` scope. |
| `value is string` type-guards | 2 | Yes (if-condition) | parsed, **not enforced** | Incomplete feature — `is` has no parser arm; degrades to `Raw`. Follow-up: structure the `is` operator (or gate it). |
| slice `value[start: end]` | 1 | Yes | **unsupported** (`:` unparsed in `[]`) | Slice syntax is not shipped; degrades to `Raw`. Follow-up if/when slices ship. |
| `&raw value` | 1 | Yes | **design-stage** (examples/README) | Future syntax → genuine residual. |
| named `routine "x" { … }` | 1 | Yes (expression-statement) | **deferred concurrency** | Not-shipped syntax → genuine residual. (Unnamed `routine { … }` is structured as `RoutineStatement` and is fine.) |

### Implication for the blanket E0818 flip

The census's purpose (per #1742) is to ensure the blanket `E0818` backstop can flip
without false positives. It cannot yet: **match-arm patterns** are a shipped,
ubiquitous construct that degrades to `Raw` and is walked by the effect checker via
the match-case path. Flipping `E0818` today would over-fire on every
`Result.Ok { value }` arm. The remaining residuals are either incomplete (`is`,
slice) or genuinely future/deferred (`&raw`, named `routine`).

**Recommended sequencing before the E0818 flip (separate sub-issue(s)):**

1. Structure match-arm patterns into a dedicated `Pattern` AST node (or exclude the
   pattern position from effect collection) — the dominant blocker.
2. Decide `is` type-guards: structure or gate behind a diagnostic.
3. `&raw` / named `routine` / slice: these are not-yet-shipped syntax; the E0818
   arm should treat them as the intended fail-closed targets (they are exactly the
   "unstructured construct — rewrite so the compiler can parse it" case), or they
   stay junk until their features ship.

`channel:Type` is removed from this list by this PR.
