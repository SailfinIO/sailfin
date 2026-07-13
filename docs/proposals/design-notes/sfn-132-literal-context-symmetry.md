# Design note — SFN-132: bidirectional literal-context propagation in native lowering

This is a design-note, not an SFEP: it does **not** change the shipped strict
int↔float refusal policy (spec §06-types, `docs/status.md` "strict int↔float
refusal with `as` fix-it"), introduces no new syntax/ABI/parser surface, and has
no seed dependency. It records the *why* behind making an existing,
implementation-only mechanism positionally symmetric. The refusal rule for two
**typed** operands is untouched.

## Problem

Sailfin's LLVM lowering lets a bare numeric literal adopt a sibling operand's
kind ("literal-context propagation"), so `0` beside a `float` lowers as `double`
rather than `i64`. That hint was one-directional — it only flowed left→right —
so the same expression with operands swapped diverged:

```sfn
fn f(x: float) -> float {
    let a = x - 0;   // OK    — `0` adopts `x`'s double kind
    let b = 0 - x;   // FATAL — "ABI primitive mismatch: arithmetic mixes
                     //          i64 (int) and double (float)"
    return b;
}
```

Root-caused during SFN-119 / PR #1976: `lower_binary_operation` and
`lower_comparison_operation`
(`compiler/src/llvm/expression_lowering/native/core_ops_lowering.sfn`) lowered
the **left** operand first with `expected_type = ""`, then propagated the left's
resulting LLVM type to the **right** operand only (Slice B / Slice E.3b). A bare
literal on the left therefore lowered with no context, defaulted to `i64`, and a
typed float sibling then tripped the (correct) refusal in `harmonise_operands`
(`core_operands.sfn`). `dominant_type` / `harmonise_operands` are symmetric by
construction and needed no change — the asymmetry was entirely in *what got fed
to `lower_expression`* upstream.

## Decision: make propagation symmetric (resolution 1); rejected document-only (resolution 2)

When exactly one operand is a bare numeric literal (`is_number_literal`), lower
the **typed** (non-literal) operand first regardless of source position and feed
its resulting type back as the literal's `expected_type`. This is scoped to the
two functions in `core_ops_lowering.sfn`; the comparison path keeps its
numeric-kind guard (Slice E.3b, #556) so a pointer-shaped sibling still skips the
hint and `null` lowers via its default `i8*` seam.

**Why this is narrow, not a policy reversal.** It only affects cases already
lenient in one direction (`x - 0` worked), making the *other* direction match. It
concerns literal-context inference, which the spec's coercion-rules table does
not address — the refusal is about two *typed* operands disagreeing, and that
stays rejected in both positions. A **float** literal beside an **int** variable
still fatals symmetrically (`x - 1.5` and `1.5 - x` both refuse), because a float
literal cannot take an integer target; only an integer literal adopting a float
sibling is made positionally consistent.

**Why not resolution 2 (leave it strict, document the wart).** Every mainstream
language accepts `0 - x` for float `x`. Under the project's "boring syntax wins /
AI agents are users" framework, a positional wart is a systematic error source
for LLM-generated Sailfin. Documenting it institutionalizes a surprise that the
narrow fix removes outright.

**Reconciliation with the tighter trajectory.** `draft-sized-integer-types.md`
argues against implicit widening of *typed* operands ("explicit `as`-cast"). This
note stays inside that boundary: it does not widen typed operands, only fixes the
direction of the pre-existing literal-context mechanism.

## Safety of reordering

Reordering is only triggered when the left operand is a bare numeric literal,
which has no side effects. The typed side is therefore the only operand that can
emit observable IR, so evaluating it first leaves observable order unchanged. The
two lowering results are rebound to `left_result` / `right_result` so downstream
(which reads `left_result.operand` and `right_result.{operand, lines,
temp_index}`) is untouched; the last-lowered result carries the merged
`lines`/`temp_index`.

## Test plan

`compiler/tests/e2e/numeric_literal_position_test.sfn` lowers `0 - x`, `x - 0`,
`0 < x`, `x > 0` (float `x`) via `sfn emit llvm` and pins `fsub double` / `fcmp
double` with no `sitofp` leak and no ABI-mismatch fatal. The pre-fix failure is a
lowering-stage fatal invisible to the frontend `sfn check`, so a real emit is
required. Self-hosting (`make compile`) plus the full suite (`make test`) gate the
change.

## References

- SFN-132 (this note's issue); SFN-119 / PR #1976 (surfaced the asymmetry).
- `compiler/src/llvm/expression_lowering/native/core_ops_lowering.sfn`
  (`lower_binary_operation`, `lower_comparison_operation`),
  `core_operands.sfn` (`dominant_type` / `harmonise_operands`).
- spec §06-types "Scalar coercion rules"; `docs/status.md` (strict refusal — Shipped).
- `docs/proposals/draft-sized-integer-types.md` (coercion trajectory).
