---
sfep: 0054
title: Low-Precision Numeric Substrate
status: Accepted
type: language
created: 2026-07-19
updated: 2026-07-19
author: "agent:compiler-architect; project owner sign-off"
tracking: "#2484, SFN-423, SFN-426"
supersedes:
superseded-by:
graduates-to: reference/preview/low-precision-numerics.md
---

# SFEP-0054 — Low-Precision Numeric Substrate

## 1. Summary

Sailfin will add five distinct low-precision floating-point types: `f16`,
`bf16`, `fp8e4m3fn`, `fp8e5m2`, and `tf32`. They have fixed encodings,
round-to-nearest-ties-to-even conversion, explicit cross-type conversion, and
no implicit promotion between stored numeric values. Scalar arithmetic returns
its operand type, while reductions and contractions over low-precision inputs
accumulate in at least `f32`. LLVM lowering uses `half` and `bfloat` directly,
an `i8` storage plus checked helper boundary for the two FP8 formats, and a
quantized `float` representation for TF32. This supplies the numeric foundation
required by SFEP-0052 without introducing effects, accelerator mapping, or
vector semantics.

## 2. Motivation

Modern training and inference do not use `f32` or `f64` uniformly. FP16 and
BF16 reduce bandwidth and increase arithmetic throughput; FP8 formats trade
range against precision for weights and activations; TF32 preserves the range
of `f32` while reducing input significand precision for contractions. Treating
these formats as aliases for `float` would discard the facts required to check
conversion, select an accumulator, calculate storage layout, or compare a CPU
reference with an accelerator result.

Sailfin currently recognizes `f32` and `f64`, and its LLVM type mapper lowers
them to `float` and `double`. It has no source representation for the formats
above and no rule for an expression such as a BF16 activation multiplied by an
FP8 weight. Without a language-level contract, each tensor backend would have
to invent its own rounding and promotion policy. Results would then vary by
backend, and the scalar CPU path could not serve as the numerical oracle
required by SFEP-0053.

The substrate must therefore fix three things before tensor lowering begins:
the exact value sets, the points at which rounding occurs, and the precision of
intermediate accumulation. It must also keep the compiler self-hosting on an
ordinary CPU and avoid implying that LLVM scalar operations are tensor-core
instructions.

## 3. Design

### 3.1 Source types and value formats

The following are closed primitive scalar types. They are not aliases for one
another or for `f32`, even when their LLVM storage uses the same-width carrier.

| Sailfin type | Encoding | Exponent / fraction bits | Special values | LLVM scalar representation |
|---|---|---:|---|---|
| `f16` | IEEE 754 binary16 | 5 / 10 | signed zero, subnormal, infinity, NaN | `half` |
| `bf16` | bfloat16 | 8 / 7 | signed zero, subnormal, infinity, NaN | `bfloat` |
| `fp8e4m3fn` | finite-only E4M3, bias 7 | 4 / 3 | signed zero, subnormal, canonical NaN; no infinity | `i8` storage + helpers |
| `fp8e5m2` | IEEE-like E5M2, bias 15 | 5 / 2 | signed zero, subnormal, infinity, NaN | `i8` storage + helpers |
| `tf32` | `f32` sign/exponent with 10 stored fraction bits | 8 / 10 | signed zero, subnormal, infinity, NaN | invariant-carrying `float` |

Their positive finite boundaries are fixed as follows; negative boundaries are
symmetric.

| Type | Smallest subnormal | Smallest normal | Largest finite |
|---|---:|---:|---:|
| `f16` | 2^-24 | 2^-14 | 65504 |
| `bf16` | 2^-133 | 2^-126 | (2 - 2^-7) × 2^127 |
| `fp8e4m3fn` | 2^-9 | 2^-6 | 448 |
| `fp8e5m2` | 2^-16 | 2^-14 | 57344 |
| `tf32` | 2^-136 | 2^-126 | (2 - 2^-10) × 2^127 |

The `fn` suffix in `fp8e4m3fn` is semantic: the format has no infinity. The
bare spellings `fp8`, `fp8e4m3`, and `fp8e5` are rejected because they do not
fully identify an encoding. There are no short aliases in the first release.
The canonical names match through annotations, casts, diagnostics, tensor dtype
metadata, and artifact serialization.

All formats preserve signed zero and subnormals. NaN payload propagation is not
part of the portable contract: every conversion into a low-precision type may
canonicalize a NaN while preserving that it is a NaN. This makes the CPU oracle
independent of target-specific payload behavior. `fp8e4m3fn` overflow saturates
to the largest finite value of the same sign; formats with infinity overflow to
the corresponding infinity.

TF32 is a real source type even though its carrier is LLVM `float`. A valid
`tf32` value has the low 13 `f32` fraction bits cleared, except for the chosen
canonical NaN encoding. Conversion into TF32 establishes that invariant.
Loading, storing, returning, or passing a TF32 value preserves it; scalar TF32
arithmetic re-quantizes the result before it becomes another TF32 value.

### 3.2 Type-system representation

The checked type model records the five canonical names as distinct primitive
kinds. A later structured type representation should use enum variants
`F16`, `BF16`, `FP8E4M3FN`, `FP8E5M2`, and `TF32`; it must not collapse them to
the current coarse string kind `"float"`. Type equality is exact. In
particular, `f16 != bf16`, the FP8 variants are unequal, and `tf32 != f32`.

The implementation issue will make these exact changes in
`compiler/src/typecheck_types.sfn`:

- extend the primitive accept/classification table in
  `classify_declared_primitive` with all five canonical spellings, returning a
  distinct kind for each rather than the shared `"float"` kind;
- extend `is_extern_primitive_type`'s explicit accept-list with the same five
  spellings only after the corresponding LLVM mappings are present, preserving
  the function's fail-closed ordering invariant;
- teach mixed-arithmetic, assignment, argument, and return checks that the five
  kinds are numeric but do not implicitly coerce to each other or to
  `f32`/`f64`; and
- reject ambiguous FP8 spellings with `E0910` rather than treating them as user
  types that later fall through to pointer lowering.

Extern ABI representations are exactly the LLVM representations in §3.1.
FP8 extern parameters and returns are one raw encoded byte, and TF32 uses the
ordinary 32-bit float ABI with the TF32 invariant required on both sides. A
foreign declaration using one of these types is an explicit agreement with
that representation; it is not an assertion that a platform C compiler has a
matching source type.

Arrays, optionals, fields, parameters, returns, and generic substitutions retain
the exact element type. Their storage widths are 2 bytes for `f16`/`bf16`, 1
byte for either FP8 type, and 4 bytes for `tf32`. Pointer identity never erases
the pointee format.

### 3.3 Literals

This proposal adds no literal suffix and no lexer production. An unsuffixed
decimal literal keeps today's default type outside a low-precision context. It
becomes low precision only through an expected type or an explicit cast:

```sfn
let learning_rate: f16 = 0.001;
let scale = 0.125 as bf16;
let weight: fp8e4m3fn = -1.75;
let contraction_input = 3.14159265 as tf32;
```

Expected-type conversion is permitted only for a literal itself. It is not a
general implicit conversion: assigning an existing `f32` variable to `f16`
still requires `as f16`. Literal conversion parses the decimal mathematical
value and rounds it directly to the destination format using
round-to-nearest-ties-to-even. It must not first round through `f64`, because
double rounding can change a boundary result. Hexadecimal bit-pattern literals
and payload-selecting NaN literals are outside this proposal.

Literal underflow produces a correctly rounded subnormal or signed zero.
Overflow follows the destination rules in §3.1. These are values, not compile
errors. Tests must cover exact halfway cases on both sides of an even/odd least
significant retained bit.

### 3.4 Explicit conversions

`as` is the only conversion between an existing value of a low-precision type
and another numeric type. The rules are:

- widening to `f32` or `f64` is exact for every finite low-precision value;
- narrowing from `f32`, `f64`, or another low-precision format rounds once to
  the destination with round-to-nearest-ties-to-even;
- conversion to TF32 rounds the `f32` value to ten fraction bits; conversion
  from `f64` first computes the correctly rounded TF32 result directly;
- conversion from a signed or unsigned integer uses the same destination
  rounding and overflow rules as a decimal literal;
- conversion from a low-precision value to an integer follows Sailfin's
  existing float-to-integer rule and must diagnose the same invalid NaN,
  infinity, or out-of-range cases; and
- boolean, pointer, string, object, and function values do not convert to or
  from these types.

A conversion is observable even when the source and destination share an LLVM
carrier. `f32 as tf32` inserts quantization, while `tf32 as f32` widens without
re-quantizing. Conversion between the two FP8 formats decodes to the
mathematical value and rounds once to the destination; it is not a byte
reinterpretation. Bit reinterpretation, if later needed, requires a separately
specified intrinsic.

### 3.5 Scalar arithmetic and comparison

Unary `-`, `+`, `-`, `*`, and `/` are available for `f16`, `bf16`, and `tf32`
when both binary operands have the same exact type. The operation is evaluated
with sufficient intermediate precision to produce the correctly rounded result
in that type, and the result has the same type. Comparisons accept two values of
the same exact type and return `bool`, following the existing unordered-NaN and
signed-zero rules for floats.

The first FP8 phase requires conversion, storage, load/store, equality/order
comparison, and tensor use. General scalar FP8 arithmetic is rejected with
`E0914`; silently widening it would hide expensive helpers and make scalar code
appear to have hardware semantics it does not have. A later SFEP may admit a
specific scalar FP8 operator set.

There is no precision ranking for stored-value expressions. `f16 + bf16`,
`bf16 + f32`, `tf32 + f32`, and operations mixing the two FP8 variants are
errors. The programmer selects the computation type explicitly:

```sfn
let total: f32 = (activation as f32) + (weight as f32);
```

A bare numeric literal used as one operand may adopt the other operand's exact
type under §3.3. That is contextual literal typing, not promotion of an already
typed value.

### 3.6 Mixed-precision accumulation

Reduction and contraction operations distinguish input, accumulator, and
result dtypes. For any operation whose input dtype is one of the five types in
this proposal:

1. the default accumulator dtype is `f32`;
2. an explicit accumulator may be `f32` or `f64`, but never a type narrower
   than `f32`;
3. each input is decoded or widened to the accumulator domain before the
   arithmetic step;
4. multiplication for a contraction occurs in `f32` when the accumulator is
   `f32`, including for TF32 inputs, then addition rounds in the accumulator
   dtype after each specified step;
5. the default result dtype is the accumulator dtype; requesting a
   low-precision result adds one explicit final conversion; and
6. changing reduction order, reassociating additions, contracting through a
   wider hidden accumulator, or enabling flush-to-zero is not permitted by this
   substrate contract.

Tensor IR defined by SFEP-0053 must therefore carry an explicit
`accumulator_dtype` on reductions and contractions. Its scalar reference
lowering uses a deterministic logical iteration order and performs the same
input and output conversions. Accelerator exits may use a different physical
schedule only when their documented numerical mode satisfies the equivalence
envelope in §8; exact bit equality is not inferred from associativity.

Elementwise mixed-precision operations do not acquire an accumulator. Their
operands must already have the same dtype, and their result dtype is explicit.
This prevents a backend from choosing a promotion policy based on available
hardware.

### 3.7 LLVM lowering and helper boundary

The implementation will make the following exact changes in
`compiler/src/llvm/type_mapping.sfn`:

- `map_type_annotation`: map `f16 -> half`, `bf16 -> bfloat`,
  `fp8e4m3fn -> i8`, `fp8e5m2 -> i8`, and `tf32 -> float` before the unknown
  user-type fallback;
- `ends_with_pointer_suffix`: add `half` and `bfloat` to the non-pointer
  primitive fast path; `i8` and `float` already cover the FP8 carrier and TF32;
- `is_copy_type`: classify `half`, `bfloat`, and `float` carriers as copy types;
- `numeric_type_kind`: recognize LLVM `half` and `bfloat` as floating numeric
  carriers, while source-aware checks retain the exact dtype before this
  carrier-only helper runs; keep carrier-only `i8` and `float` from making an
  arbitrary byte FP8 or an arbitrary `f32` TF32; and
- `default_value_for_llvm_type` plus the native statement/literal mapping seams:
  emit correctly typed zero values and preserve the source dtype through
  lowering instead of recovering it from carrier width.

Direct LLVM `half`/`bfloat` arithmetic and conversion instructions are used
only where the pinned LLVM version and target give the specified semantics.
The CPU reference may call small Sailfin-native bit-conversion helpers when
that is required for deterministic rounding. FP8 always crosses typed helpers
for encode, decode, compare, and tensor scalar-reference work; an `i8` operand
alone is never enough to select a format. TF32 lowering inserts a canonical
quantization helper or equivalent mask-and-round sequence on every conversion
into TF32 and after every scalar TF32 result.

The custom helper boundary is part of generated user-program support, not C
runtime startup or compiler bootstrap. Helper names include the full format
name so E4M3FN and E5M2 cannot be interchanged accidentally.

### 3.8 Diagnostic reservation

A repository-wide
`rg -o --no-filename '[EW][0-9]{4}' compiler runtime docs site | sort -u`
before allocation found existing diagnostic use through `E0907` and no use of
`E0910`–`E0915`. This proposal reserves that range:

| Code | Meaning |
|---|---|
| `E0910` | ambiguous or non-canonical low-precision type spelling |
| `E0911` | mixed-precision arithmetic without an explicit conversion |
| `E0912` | implicit non-literal low-precision binding, argument, or return conversion |
| `E0913` | accumulator dtype is narrower than `f32` or otherwise invalid |
| `E0914` | scalar operation is unavailable for the selected low-precision dtype |
| `E0915` | selected target/backend cannot honor the declared low-precision representation |

Diagnostics must name both source types, show the relevant source span, and
suggest an explicit destination cast when one is unambiguous. `E0915` is a
fail-closed backend diagnostic; it must not trigger a silent widening or pointer
fallback.

### 3.9 Phased implementation

Phase 1 implements `f16` and `bf16`: exact type classification, contextual
literals and casts, `half`/`bfloat` mapping, scalar operations, arrays and ABI
layout, diagnostics, and the CPU reference conversion tests. It must self-host
before the formats are enabled as tensor dtypes.

Phase 2 implements `fp8e4m3fn`, `fp8e5m2`, and `tf32`: custom FP8 encode/decode
helpers, TF32 invariant enforcement, storage/layout, casts and comparisons,
mixed-precision accumulation tests, and tensor dtype integration. Phase 2 may
land in smaller implementation issues, but neither FP8 format nor TF32 is
reported as shipped until its CPU oracle and lowering path are complete.

Vectorization, tensor-core instruction selection, StableHLO precision
configuration, and vendor-library mapping are later backend work. Their absence
does not change the scalar or tensor dtype semantics fixed here.

## 4. Effect & capability impact

None. Literal formation, conversion, scalar arithmetic, and CPU reference
helpers are pure and add no effect. The types require no capsule capability and
do not imply `![gpu]` or `![model]` merely because accelerator hardware commonly
uses them.

A later operation that dispatches a tensor to a device must still declare and
satisfy `![gpu]`; its element dtype neither grants nor suppresses that effect.
Likewise, conversions do not declassify tainted values or alter any future
`PII<T>`/`Secret<T>` propagation rule.

## 5. Self-hosting impact

The compiler remains an ordinary scalar CPU program and need not use any of the
new types in its own source. The implementation touches primitive
classification in `typecheck_types.sfn`, literal/cast checking, native emission,
`llvm/type_mapping.sfn`, scalar expression lowering, and Sailfin-native numeric
helpers. It does not change the build driver or require GPU, MLIR, StableHLO, or
vendor libraries.

Phase 1 must update the type mapper before extending
`is_extern_primitive_type`, so an accepted annotation can never fall through to
`i8*`. Phase 2 must retain source dtype metadata wherever FP8 shares the `i8`
carrier or TF32 shares `float`; carrier-only inference would violate type
identity. Each compiler-source phase runs `make compile` before targeted tests,
and helper code remains available through the existing Sailfin-native runtime
path. A structural helper-module split requires `make clean-build` once before
rebuilding.

## 6. Alternatives considered

### 6.1 Treat low precision as tensor metadata only

Rejected. Scalar constants, casts, function boundaries, buffers, and the CPU
oracle all need the same format identity. Backend-only metadata would allow the
frontend and ABI to disagree about width and rounding.

### 6.2 Alias every format to `f32`

Rejected. It loses storage size and conversion points, makes FP8 variants
indistinguishable, and cannot express TF32 input quantization or f32
accumulation as separate facts.

### 6.3 Define an implicit promotion lattice

Rejected for the initial substrate. No single ordering captures the tradeoff:
BF16 has more exponent range than FP16 but fewer fraction bits, and TF32 is a
quantized input format rather than a conventional narrow storage float.
Explicit conversion makes source intent and backend behavior stable.

### 6.4 Expose one parameterized `fp8<e, m>` type

Rejected. Only standardized, backend-interoperable encodings are admitted.
Arbitrary exponent/fraction parameters would multiply conversion, NaN, ABI,
and substrate cases without a hardware contract. Distinct canonical primitive
names also produce clearer diagnostics and artifacts.

### 6.5 Use LLVM's newest native FP8 types immediately

Deferred. LLVM FP8 spelling, operation coverage, and target support vary across
versions. An explicit byte encoding and typed helper boundary is portable under
the pinned toolchain. A future toolchain SFEP may replace the carrier when the
representation and semantics are proven equivalent; the Sailfin source types
will not change.

### 6.6 Flush subnormals or enable fast math

Rejected as the portable default. Either would make the CPU oracle
target-dependent and permit transformations outside the language contract.
An opt-in numerical mode may be proposed later with its own artifact and
diagnostic semantics.

## 7. Stage1 readiness mapping

SFEP-0054 is an Accepted design, not an implementation claim. All readiness
items remain pending for the follow-on implementation work:

- [ ] Parses — all five names are accepted in every type position.
- [ ] Type-checks / effect-checks — exact identity, literals, casts, scalar
  operators, and accumulator rules are enforced; effects remain unchanged.
- [ ] Emits valid `.sfn-asm` — source dtype survives native emission.
- [ ] Lowers to LLVM IR — direct and custom mappings in §3.7 execute correctly.
- [ ] Regression coverage — representation, rounding, diagnostics, ABI, and
  CPU-reference equivalence tests pass.
- [ ] Self-hosts — compiler rebuilds without accelerator dependencies.
- [ ] `sfn fmt --check` clean — every touched `.sfn` file is formatted.
- [ ] Documented in `docs/status.md` + spec — status and reference docs change
  only as each phase ships.

The SFEP remains `Accepted` until every applicable format clears the full bar.

## 8. Test plan

Implementation issues add Sailfin-native unit and integration tests beside the
current numeric/type-mapping coverage. The CPU reference suite is the canonical
oracle and uses table-driven bit patterns, not host-language casts.

For each format, exhaustive tests cover every source encoding for both FP8
variants and stratified boundary sets for FP16, BF16, and TF32: positive and
negative zero, smallest/largest subnormal, smallest normal, adjacent values
around one, largest finite, infinities where present, canonical and noncanonical
NaNs, and values immediately around every tested rounding midpoint. Conversion
tests cover every pair among the five types plus `f32`, `f64`, signed integers,
and unsigned integers. Decimal literal tests include cases that would fail if
the compiler rounded through `f64` first.

Scalar arithmetic tests compare the resulting encoded bits with a
format-independent reference encoder. Negative tests assert `E0910`–`E0915`
at the correct spans, including mixed formats, implicit variable conversions,
FP8 scalar arithmetic, invalid accumulators, and a deliberately unsupported
target configuration.

Numerical-equivalence integration tests execute the same reduction and
contraction through:

1. an unfused CPU scalar reference using decoded inputs and the exact ordered
   `f32`/`f64` accumulator rules from §3.6;
2. the tensor scalar-reference lowering from SFEP-0053; and
3. each enabled production substrate exit.

Conversions and elementwise operations require bit equality after
canonicalizing NaNs. Ordered reductions and contractions require bit equality
with the CPU reference when the backend preserves the specified order. A
backend that documents a different legal reduction tree instead compares each
finite output against a test-specific bound derived from input dtype,
accumulator dtype, operation count, and `f32` unit roundoff; it must also match
NaN/infinity classification and signed-zero rules. A single blanket epsilon is
not sufficient. The suite includes cancellation, overflow, underflow,
subnormal, long-accumulation, FP8 range, and TF32 midpoint cases.

Phase 1 acceptance runs the targeted typecheck, LLVM mapping, conversion, and
scalar tests plus `make compile`. Phase 2 adds exhaustive FP8 encodings and
tensor CPU-equivalence cases. No GPU is required for the compiler's self-host
gate; accelerator comparisons run only in their backend-specific environment.

## 9. References

- [SFEP-0052 — Accelerated ML strategy](./0052-ml-acceleration-strategy.md),
  especially §3.1(1).
- [SFEP-0053 — Shape-Typed Tensor IR and Fusion](./0053-shape-typed-tensor-ir.md),
  especially the scalar-reference oracle and explicit dtype rules.
- [SFEP-0001 — SFEP purpose and process](./0001-sfep-process.md).
- Linear SFN-423 — this design gate; GitHub #2484 — its public mirror.
- Linear SFN-426 — Phase 1 `f16`/`bf16` implementation.
- IEEE 754-2019 binary floating-point formats and rounding directions.
- OpenXLA StableHLO element types and conversion semantics.
- NVIDIA Hopper architecture documentation for E4M3, E5M2, and TF32.
- ONNX float8 type definitions for E4M3FN and E5M2 interoperability.
