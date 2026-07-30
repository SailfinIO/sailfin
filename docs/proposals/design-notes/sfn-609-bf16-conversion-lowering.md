# SFN-609 — bf16 conversion lowering

Design doc for the design gate of SFN-609. The *design record* is SFEP-0054
(`../0054-low-precision-numerics.md` §3.3/§3.4/§3.7) with the tolerance rule
from SFEP-0062 (`../0062-numerical-contracts.md` §3.4); this note is the
single-issue implementation gate, so it carries no SFEP number. It records how
those rules are discharged on a target whose LLVM backend cannot express them
directly.

---

## Summary

Emit every `bf16` conversion as an explicit bit-manipulation sequence instead of
LLVM's `fpext`/`fptrunc`/`sitofp`/`llvm.*.sat.*.bf16` instructions, on **all**
targets. LLVM 18's AArch64 backend has no selection pattern for any `bfloat`
conversion, so the advisory `linux-arm64` lane aborts instruction selection on
the existing `bf16` string-concatenation test. The replacement sequences are
correctly rounded per SFEP-0054 §3.4 and verified bit-identical to a
single-step oracle.

## Motivation

`Build + Test [linux-arm64 / advisory]` fails reproducibly with:

```text
fatal error: error in backend: Cannot select: ... f64,ch = load<..., anyext from bf16> ...
Running pass 'AArch64 Instruction Selection'
```

The crash is not specific to string concatenation, and not specific to the
load-folding the message happens to name. Measured on LLVM 18.1.3:

| IR form | AArch64 | x86_64 |
|---|---|---|
| `load bfloat` / `store bfloat` (no conversion) | OK | OK |
| `fpext bfloat -> float` / `-> double` | **Cannot select** | OK |
| `fpext` from a `bfloat` *argument* (no load) | **Cannot select** | OK |
| `fptrunc float`/`double -> bfloat` | **Cannot select** | OK |
| `sitofp i32`/`i64 -> bfloat` | **Cannot select** | OK |
| `llvm.fptosi.sat.i32.bf16` | **Cannot select** | OK |

The equivalent `half` forms all select on AArch64 — the target has native FP16
conversion hardware — which is why the structurally identical `f16` test passes.
The carrier type is unaffected; only conversions are broken.

The compiler emits seven `bf16` conversion forms and all seven crash. The
failing test is therefore one symptom of a general gap, not the whole defect.

## Design

`bf16` is bit-identical to the high 16 bits of `f32`: same 8-bit exponent, same
bias 127. Widening is an exact mantissa zero-extend; narrowing is a
round-to-nearest-ties-to-even on the discarded low half.

SFEP-0054 §3.7 authorises the substitution directly — "The CPU reference may
call small Sailfin-native bit-conversion helpers when that is required for
deterministic rounding." The sequences live in
`compiler/src/llvm/expression_lowering/native/core_bf16_lowering.sfn`.

### Emitted unconditionally, not gated on the target triple

One lowering on every target keeps x86_64 and AArch64 bit-identical by
construction, halves the test matrix, and lets the x86-primary CI gate exercise
the same code the ARM lane runs. It also improves attestability: SFEP-0062 §3.3
records `compiler_version`, `toolchain_pin`, and `target_triple` in provenance,
but *not* which compiler-rt/libgcc build supplied a soft-float helper such as
`__truncdfbf2`. A conversion whose result depends on an unrecorded input cannot
honestly discharge `determinism_class: Bitwise`; an IR-level bit sequence can.

That argument justifies *where* the sequence runs. It does **not** justify a
cheaper, less accurate sequence — both a correctly-rounded and a double-rounded
implementation would be equally deterministic, so determinism does not
discriminate between them. Accuracy is settled by §3.4 below, not by
determinism.

### Rounding

SFEP-0054 §3.4 requires that narrowing "rounds once to the destination with
round-to-nearest-ties-to-even", and §3.3 rules out an intermediate hop
explicitly: it "must not first round through `f64`, because double rounding can
change a boundary result."

That forbids the obvious `f64 -> f32 -> bf16` chain. The f64 path therefore
rounds the intermediate to **odd** rather than to nearest: by Boldo–Melquiond,
`RN_p1(odd_p2(x)) == RN_p1(x)` whenever `p2 >= p1 + 2`, and here `p2 = 24` (f32)
against `p1 = 8` (bf16). Round-to-odd is "of the two `f32` neighbours, take the
one with an odd significand"; `fptrunc` yields one neighbour for free, and the
correction moves to the other when the RNE result is even and the conversion was
inexact. The step is `magnitude ± 1`, **not** `| 1` — when RNE rounded away from
zero, the odd neighbour lies one *below* in magnitude.

Boundary reasoning: bf16's entire subnormal range (`2⁻¹³³ … 2⁻¹²⁶`) sits inside
f32's, whose granularity is `2⁻¹⁴⁹`, so bf16 midpoints and one bit below them are
exactly representable in f32. `f32max` exceeds bf16's overflow threshold, so
round-to-odd's "never overflow to Inf" behaviour still lands on Inf at the bf16
step.

`i64`/`u64` sources get the same treatment one level up: they do not fit f64's
53-bit significand, so the magnitude is pre-rounded to odd at the `2¹¹` grid
before `sitofp`/`uitofp`. Round-to-odd composes, so the
`2¹¹`-grid → f32 → bf16 chain remains a single effective rounding. Narrower
integer types are exact in f64 and pass through untouched.

NaN is guarded separately in each narrowing sequence, because the rounding bias
add can carry a NaN's exponent into infinity. The f64 path reads its guard from
the **pre-correction** bits: for a NaN the inexactness test is true, and the
round-to-odd correction could carry magnitude `0x7FFFFFFF` to `0x80000000`,
turning a NaN into `-0.0`. SFEP-0054 §3.1 places NaN payloads outside the
portable contract, so forwarding the quieted `f32` payload is legal.

## Verification

| Sequence | Corpus | Result |
|---|---|---|
| bf16 → f32/f64 widen | **exhaustive**, all 65,536 bit patterns | 0 differences vs `fpext bfloat`, NaN payloads included |
| f32 → bf16 narrow | 116,080,198 sampled f32 | 0 differences vs `fptrunc float to bfloat` |
| f64 → bf16 narrow | 6,917,525, incl. a stratified sweep of every bf16 midpoint and its f64 neighbours | 0 differences vs `fptrunc double to bfloat` |
| i64 → bf16 | 4,000,016 vs an **exact integer oracle** | this sequence 0 wrong; LLVM's own `sitofp i64 to bfloat` **31 wrong** |
| i64 → bf16, pre-step justification | 8,221,211 incl. a targeted sweep of the `2¹¹`-grid tie window | pre-step changed the result **3,066** times, and was right every time: this sequence 0 wrong, plain `i64 → f64 → bf16` **3,066 wrong** |

The last row is the one that justifies the integer pre-step specifically. Most
`i64` values round identically with or without it — uniformly random draws
almost never land in the double-rounding window — so a witness has to be taken
from near a `2¹¹`-grid tie to exercise it. `18084767253659649` is one:
correctly `0x5A81`, but `0x5A80` if rounded through `f64` first.

All replacement sequences select on `aarch64-unknown-linux-gnu` and
`x86_64-pc-linux-gnu`, at `-O0` and `-O2`.

## Behaviour change on x86_64

1. **`d as bf16` and `let x: bf16 = <literal>` are unchanged.** x86_64 previously
   called `__truncdfbf2` (correctly rounded, single step); the replacement is
   also correctly rounded and single step, and matches it on every value tested.
   The definition moves from compiler-rt into our IR; the results do not move.
   Had the naive `f64 → f32 → bf16` chain been used instead, roughly 1.2e-6 of
   inputs would have changed — that is the reason it was rejected.
2. **`int as bf16` from an `i64` source changes in the `|n| ≥ 2⁵³` window.** This
   is a correction: the new result matches an exact oracle, the old one did not.
   It is a §3.4 conformance fix, not a regression.
3. **NaN payload output may change.** Both old and new results are NaNs;
   SFEP-0054 §3.1 leaves payloads outside the portable contract.
4. **Emitted IR grows for bf16 paths** (~27 instructions per `f64 → bf16` site
   instead of one call). `bf16` appears in tests only, never in compiler source,
   so build time is unaffected; at `-O1`+ the whole sequence constant-folds.

## Rejected alternatives

- **Two-step `fpext bfloat -> float -> double`.** Still unselectable: AArch64
  fails on the `bfloat` operand regardless of destination width.
- **Target-conditional lowering.** Would leave x86_64 and AArch64 on different
  arithmetic and hide the ARM path from the primary CI gate.
- **Emitting a `bfloat` constant for the literal binding.** `bfloat 0xRXXXX` is
  valid LLVM syntax, but a plain decimal is accepted only when exactly
  representable — `bfloat 0.001` is a hard parse error — and the compiler has no
  correctly-rounded decimal→binary parser to compute the `0xR` form. That parser
  *is* the deferred SFEP-0054 §3.3 work and must serve `f16` too.
- **Accepting the double-rounded `f64 → f32 → bf16` chain.** Rejected by §3.4's
  "rounds once" and by SFEP-0062 §3.4, whose elementwise tolerance
  `u(bf16) = 2⁻⁸` is the correctly-rounded half-ULP bound; a double-rounded
  conversion's worst case is a full ULP and would violate the compiler's own
  derived tolerance.

## Out of scope

- **Single-rounding decimal → low-precision literals** (SFEP-0054 §3.3). The
  decimal → f64 step is still a separate rounding, for `f16` and `bf16` alike.
  Already recorded as owed in `docs/status.md`.
- **`f16` conversions.** They select on AArch64 by hardware support rather than
  by contract. `int as f16` from an `i64` source has the same double-rounding
  window and should be audited under the same lens.
- **Direct `half` ↔ `bfloat` casts** and the `E0910`–`E0915` exact-identity work,
  both already deferred SFEP-0054 items.
