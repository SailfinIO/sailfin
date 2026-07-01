---
sfep: TBD
title: Sized Integer Types and Overflow Semantics
status: Draft
type: language
created: 2026-07-01
updated: 2026-07-01
author: "agent:compiler-architect; human review"
tracking:
supersedes:
superseded-by:
graduates-to: reference/spec/06-types.md
---

# SFEP-XXXX — Sized Integer Types and Overflow Semantics

## 1. Summary

Sailfin recognises `int` (i64), `float` (f64), and a partial sized family
(`i8`/`i16`/`i32`/`i64`, `u8`/`u16`/`u32`/`u64`, `usize`/`isize`, `f32`/`f64`)
as type-name strings, and all of them already lower to real LLVM `iN`/`double`/
`float` types through `map_primitive_type`
([`compiler/src/llvm/type_mapping.sfn:859-897`](../../compiler/src/llvm/type_mapping.sfn#L859-L897)).
But the family is only *half* real: unsigned widths collapse onto their signed
LLVM twins (`u32`→`i32`, `u8`→`i8`), so the compiler **cannot tell signed from
unsigned**; there is **no defined overflow behaviour**; there is **no
literal-fits-in-type checking**; and there are **no typed literal suffixes**.
This SFEP finishes the family into a first-class, sign-tracked set with defined
overflow semantics (wrap in release / trap in debug, matching Rust), explicit
`as`-cast conversions (no implicit widening or narrowing), and a `wrapping_*` /
`checked_*` / `saturating_*` **library** surface (no new operators). It is
foundational plumbing — "fix the foundation first" — and is deliberately
independent of the generics workstream.

## 2. Motivation

**A "systems language" without a working sized-integer family is an outlier.**
Rust, Go, Swift, Zig, and C all ship the full `{i,u}{8,16,32,64}` family with
defined conversion and overflow rules. Sailfin's status matrix marks the numeric
types "Shipped"
([`docs/status.md:184`](../../docs/status.md#L184)), but that row describes the
`int`/`float` (i64/f64) core plus bitwise/shift ops and the `as` matrix — not a
sound sized family. Three concrete gaps make the current state unsafe to build
on:

1. **Signedness is silently lost.** `map_primitive_type` maps `u32`→`i32`,
   `u16`→`i16`, `u8`→`i8`, `u64`→`i64`
   ([`type_mapping.sfn:877-895`](../../compiler/src/llvm/type_mapping.sfn#L877-L895)).
   The cast-lowering matrix documents the resulting footgun in a standing
   "KNOWN LIMITATION" comment
   ([`core_literals_lowering.sfn:1837-1845`](../../compiler/src/llvm/expression_lowering/native/core_literals_lowering.sfn#L1837-L1845)):

   > "source-level unsigned widths (`u8`/`u16`/`u32`) collapse to `i8`/`i16`/`i32`
   > … `255_u8 as u64` therefore lowers as `sext` and becomes `-1` (sign-
   > extended) rather than `255` (zero-extended)."

   Every `u*`→wider conversion is wrong today. `u8` value `255` widened to `u64`
   yields `-1`. This is a miscompile, not a missing feature.

2. **Overflow is undefined.** No `overflow`, `wrapping_*`, `checked_*`, or
   `saturating_*` machinery exists anywhere in `compiler/src`
   (a repo-wide search finds only unrelated build-cache/lifetime hits). Integer
   arithmetic emits bare `add`/`sub`/`mul` with no defined behaviour on wrap and
   no way for a user to *request* wrap, trap, or checked arithmetic. For a
   memory-safety-floor language (ownership epic #1209) this is a hole: an
   overflow that produces a bad index or length is exactly the class of bug the
   ownership floor otherwise closes.

3. **Literals are not range-checked and cannot be typed.** The lexer captures a
   number as one generic `NumberLiteral` lexeme with no suffix support
   ([`lexer.sfn:190-280`](../../compiler/src/lexer.sfn#L190-L280));
   a trailing `u8`/`i16` lexes as a *separate* `Identifier` token. There is no
   parse-time or check-time bounds check, so `let x: u8 = 300` compiles and
   truncates silently. Rust/Swift reject this at compile time.

**Who hits it:** anyone doing FFI (libc `mode_t`/`uid_t` are `u32`, `dev_t` is
`u64`, `ssize_t` is `isize`), byte/buffer work (`u8` for bytes), bit-packing,
checksums/hashing, and anyone porting Rust/Go/C code — which is the LLM-generated
majority (AI agents are users; they emit `u32`/`usize`/`wrapping_add` from muscle
memory and get silent miscompiles). The spec already *advertises* the family for
"FFI and low-level use"
([`spec/06-types.md:21-22`](../../site/src/content/docs/docs/reference/spec/06-types.md#L21-L22)),
so the safety claim is being made without the enforcement behind it — precisely
the "parsed but not enforced" anti-pattern.

## 3. Design

### 3.0 Scope split (1.0 vs. deferred)

- **In 1.0 (this SFEP):** the full sized family as *distinct sign-tracked
  types*; typed literal suffixes; literal-fits-in-type checking; explicit
  `as`-cast conversions with correct sign/zero-extension and truncation; a
  **defined default overflow semantics** (wrap in release / trap in debug); and
  the `wrapping_*` overflow-safe method family as the escape valve for the
  default trap. `f32` completes the float side.
- **Deferred (post-1.0, designed here so the 1.0 surface doesn't paint us into
  a corner):** `checked_*` (which needs `Result`/`Option` return shapes gated on
  generics) and `saturating_*`. These are library methods, addable without any
  syntax or new keyword once generic returns land.

The core principle throughout: **libraries over keywords.** Overflow *policy*
(wrap/checked/saturate) is expressed as method calls, never as new operators or
keywords. Only the *default* behaviour and the type names are language-level.

### 3.1 The type family (types are strings; add sign+width metadata)

Sailfin threads type annotations as raw strings end-to-end (`TypeAnnotation {
text: string }` at [`ast.sfn:12-14`](../../compiler/src/ast.sfn#L12-L14);
`NativeFunction.return_type: string` at
[`native_ir.sfn:73-77`](../../compiler/src/native_ir.sfn#L73-L77)). We keep that
model — **no structured width field is added to the AST or IR.** Signedness and
width are *derived* from the type-name string at each site that needs them, the
same way `map_primitive_type` already resolves by string match. This is the
minimal-blast-radius choice and keeps the `.sfn-asm` wire format unchanged.

The canonical family, its LLVM lowering, and its signedness:

| Sailfin type | LLVM type | Signed? | Notes |
|---|---|---|---|
| `i8` `i16` `i32` `i64` | `i8` `i16` `i32` `i64` | signed | `int` is an alias for `i64` |
| `u8` `u16` `u32` `u64` | `i8` `i16` `i32` `i64` | **unsigned** | same LLVM repr; sign tracked in the frontend |
| `usize` `isize` | `i64` | unsigned / signed | pointer-width; `i64` on all current 64-bit targets |
| `f32` `f64` | `float` `double` | — | `float` is an alias for `f64`; `number` a deprecated alias for `float` |
| `bool` | `i1` | — | distinct scalar kind (§spec 06); unchanged |

**Sign is a frontend concept, not an LLVM concept.** LLVM integers are
sign-agnostic; signedness lives in the *operations* (`sext` vs `zext`, `sdiv`
vs `udiv`, `icmp slt` vs `icmp ult`). So the design adds a single source-of-truth
helper — `integer_type_is_signed(name: string) -> boolean` and
`integer_type_width(name: string) -> int` — colocated with `map_primitive_type`,
and routes every width/sign-sensitive lowering decision through it. The `i*`
names are signed, the `u*` names unsigned, `usize` unsigned, `isize` signed.

**Recognition** extends the existing string-match resolvers rather than adding a
new mechanism:

- `is_extern_primitive_type`
  ([`typecheck_types.sfn:1057-1075`](../../compiler/src/typecheck_types.sfn#L1057-L1075))
  already accepts the whole family — no change needed for the FFI boundary.
- The general type surface already flows through `map_type_annotation` →
  `map_primitive_type`, which already maps every family member — so `let x: u16`
  in ordinary (non-extern) code *already lowers*. The gap this SFEP closes is
  correctness (sign) and safety (overflow, literal bounds), not mere recognition.

### 3.2 Literals: default `i64`, optional typed suffix, range-checked

**Default type.** An unsuffixed integer literal is `int` (i64); an unsuffixed
decimal/exponent literal is `float` (f64). Unchanged — this is already the shipped
default ([`spec/06-types.md:24-30`](../../site/src/content/docs/docs/reference/spec/06-types.md#L24-L30)).

**Typed suffixes.** A literal may carry a type suffix to fix its type without an
`as` cast: `100u8`, `-5i16`, `0xffu32`, `1_000_000i64`, `3.5f32`. Grammar: the
suffix is one of the ten integer names (`i8 i16 i32 i64 u8 u16 u32 u64 usize
isize`) or the two float names (`f32 f64`) immediately following the digit run
(and after any `_` separators / fraction / exponent). An optional single `_`
before the suffix is accepted for readability (`100_u8`) to match Rust and to
sidestep the `e`-exponent ambiguity (`1e2` vs a hypothetical `1_e...`).

**Lexer change.** Today the number scanner stops at the last digit/exponent byte
and the suffix would lex as a separate `Identifier`
([`lexer.sfn:274-280`](../../compiler/src/lexer.sfn#L274-L280)). Extend the
scanner: after the numeric run, if the next bytes (optionally preceded by one
`_`) spell one of the twelve suffix names, consume them into the same
`NumberLiteral` lexeme. The token kind stays `NumberLiteral`; the suffix travels
in the lexeme and is split off downstream (mirroring how the parser already
disambiguates numeric literals). This is additive — a suffix-free literal lexes
byte-for-byte identically, preserving self-host.

**Literal-fits-in-type checking (`E0824`).** When a literal's type is fixed
(either by suffix, or by a same-statement annotation such as
`let x: u8 = 300`), the checker verifies the value fits the type's range:
`u8 ∈ [0, 255]`, `i8 ∈ [-128, 127]`, `u16 ∈ [0, 65535]`, etc. Out-of-range is a
compile error `E0824` with the type's range in the message and a fix-it
suggesting the next-wider type. This is a new typecheck rule (there is no
literal-bounds check anywhere today); it is a pure frontend check with no codegen
dependency, and it mirrors the existing string-driven diagnostic style in
`typecheck_types.sfn` (e.g. the `?`-operator rules at
[`typecheck_types.sfn:402-438`](../../compiler/src/typecheck_types.sfn#L402-L438)).

```sfn
let a = 100u8;          // u8, in range — ok
let b: u16 = 65535;     // in range — ok
let c: u8 = 300;        // E0824: literal 300 out of range for `u8` (0..=255)
let d = -5i16;          // i16 — ok
let e = 4_000_000_000u32; // in range for u32 (max 4_294_967_295) — ok
let f: i32 = 3_000_000_000; // E0824: out of range for `i32` (-2_147_483_648..=2_147_483_647)
```

### 3.3 Conversions: explicit `as` only (no implicit widening/narrowing)

**No implicit conversions between integer types** — matching Rust's systems
discipline. A `u16` does not implicitly become a `u32`; a value of one integer
type flowing into a binding, argument, field, or arithmetic operand of a
*different* integer type is an error with an `as` fix-it. This tightens today's
behaviour: `dominant_type` currently *silently widens* same-kind pairs
(`i8 ↔ i64` → `i64`) with explicit branches only for `i8`/`i32`/`i64`
([`core_operands.sfn:2495-2557`](../../compiler/src/llvm/expression_lowering/native/core_operands.sfn#L2495-L2557))
and no branches for `i16`/the whole `u*` family (they fall through to the
`return first` catch-all — a latent ABI-mismatch bug the status note at
[`status.md`](../../docs/status.md) already flags). Under this SFEP:

- **Arithmetic and comparison require both operands to be the same integer
  type.** Mixed integer widths/signs produce a `[fatal]` ABI-mismatch diagnostic
  with an `as` fix-it — reusing the exact mechanism that already rejects
  `int ↔ float`
  ([`core_operands.sfn:2597-2607`](../../compiler/src/llvm/expression_lowering/native/core_operands.sfn#L2597-L2607)),
  extended from the int/float kind-split to a per-`(width, sign)` identity.
- **`dominant_type` stops silently widening across integer types.** Its
  same-kind widening branches are removed for the integer family; only exact
  identity (already the `first == second` fast path) passes without an explicit
  cast. This is the tightening the spec's "coercion within a kind" note
  ([`spec/06-types.md:32-54`](../../site/src/content/docs/docs/reference/spec/06-types.md#L32-L54))
  currently permits and this SFEP retracts for integers (float `f32→f64` widening
  via `fpext` is retained as a follow-on decision; see §6).

**`as`-cast semantics (the correctness fix).** The `Cast` AST node already exists
([`ast.sfn:95`](../../compiler/src/ast.sfn#L95)) and the effect checker already
walks the operand
([`effect_checker.sfn:888-897`](../../compiler/src/effect_checker.sfn#L888-L897),
#1627). The lowering matrix
([`core_literals_lowering.sfn:1823-1888`](../../compiler/src/llvm/expression_lowering/native/core_literals_lowering.sfn#L1823-L1888))
is extended to choose the extend/truncate opcode from the **source type's
signedness**, closing the standing KNOWN LIMITATION:

| From → To | Rule | LLVM op |
|---|---|---|
| narrower → wider, **source signed** | sign-extend | `sext` |
| narrower → wider, **source unsigned** | zero-extend | `zext` |
| wider → narrower (any sign) | truncate | `trunc` |
| same width, sign flip (`i32`↔`u32`) | bit-reinterpret, no instruction | (identity) |
| int → float | signed → `sitofp`, unsigned → `uitofp` | |
| float → int | signed target → `fptosi`, unsigned target → `fptoui` | |
| `f32`↔`f64` | `fpext` / `fptrunc` | |
| `bool` (i1) → int | `zext` (true→1) | (unchanged) |
| any → `bool` via `as` | rejected; use a comparison | (unchanged, `E0537`-style) |

The lowering already emits `sext`/`trunc`/`sitofp`/`fptosi`/`fpext`/`fptrunc`
correctly *by width* — the only change is selecting `zext` vs `sext` and `uitofp`/
`fptoui` vs the signed forms by consulting `integer_type_is_signed` on the
**source** (for extension) and **target** (for float↔int). Because sign is
tracked in the frontend, the lowering needs the source *Sailfin* type, not just
the `LLVMOperand.llvm_type` (which is sign-agnostic). This is threaded via the
already-present `parse.type_annotation` on the cast plus the operand's inferred
Sailfin type; where the operand's Sailfin type is not available (untyped
temporaries), the checker's inferred-type annotation carries it — the same
kind-tag threading `spawn_future_kind` already relies on
([`typecheck_types.sfn:464-481`](../../compiler/src/typecheck_types.sfn#L464-L481)).

Truncation is defined as keeping the low N bits (two's-complement wrap);
`300u16 as u8 == 44`. Sign/zero extension is defined by the **source** sign.
These are the standard C/Rust `as` semantics and are documented normatively in
the spec chapter.

### 3.4 Overflow: default = trap in debug / wrap in release; `wrapping_*` escape

**Default overflow semantics.** Integer `+`/`-`/`*` (and negation, `<<`) that
overflow the operand type:

- **trap in debug builds** (a runtime panic with a clear message, e.g.
  `attempt to add with overflow (i32)`), and
- **wrap (two's-complement) in release builds.**

This is **Rust's model**, chosen deliberately over the three alternatives (§6):
it gives developers a loud signal during development (catching the overflow bug
where it happens) while paying zero steady-state cost in release. It composes
cleanly with the ownership memory-safety floor (an overflowed length/index traps
instead of silently producing an out-of-bounds value).

**Build-mode plumbing.** The compiler already distinguishes build configurations
through the driver; overflow-checking is gated on a debug/release flag threaded
into `TypeContext`/lowering. In debug, integer `add`/`sub`/`mul` lower to the
LLVM overflow intrinsics (`llvm.sadd.with.overflow.iN` / `uadd` per sign) and
branch to a trap block calling a runtime `sfn_panic_int_overflow` helper; in
release they lower to plain `add`/`sub`/`mul` (wrap). The per-sign choice
(`sadd` vs `uadd`, `sdiv`/`udiv`, `icmp slt`/`ult` for comparisons) is again
driven by `integer_type_is_signed`. Division/remainder by zero already needs a
trap and rides the same helper path.

**The `wrapping_*` escape valve (in 1.0).** To *request* wrap explicitly even in
debug, integer types expose method-call helpers — **library functions in the
prelude/runtime, not operators or keywords**:

```sfn
let a: u8 = 250;
let b = a.wrapping_add(10u8);   // 4, never traps
let c = a.wrapping_sub(255u8);  // wraps, never traps
```

`wrapping_add`/`wrapping_sub`/`wrapping_mul`/`wrapping_neg`/`wrapping_shl`/
`wrapping_shr` are concrete per-width runtime functions (`sfn_wrapping_add_u8`,
… `_i64`) dispatched by method call on an integer receiver — the same
receiver-method dispatch the runtime already uses. They lower to plain wrapping
LLVM ops regardless of build mode. Being ordinary functions, they add no
keyword and can never shadow a variable name.

**Deferred to post-1.0 (designed, not built):** `checked_add` → `Result`/
`Option` (needs generic returns, gated on the generic-constraints foundation),
and `saturating_add` → clamp to the type's min/max. Both are pure library
additions requiring no further language change once generic returns exist.

### 3.5 Worked end-to-end example

```sfn
fn checksum(bytes: u8[]) -> u32 ![pure] {
    let mut sum: u32 = 0u32;
    let mut i: int = 0;
    loop {
        if i >= bytes.length { break; }
        // bytes[i] is u8; widen explicitly (zero-extend) to u32 to add
        sum = sum.wrapping_add(bytes[i] as u32);
        i += 1;
    }
    return sum;
}

fn narrow(x: u32) -> u8 ![pure] {
    return x as u8;      // trunc — keeps low 8 bits, defined
}

// Rejected cases:
//   let n: u8 = 300;              // E0824 — literal out of range for u8
//   let s: u32 = an_i32_value;    // E0825 — implicit int-type conversion; use `as`
//   let m = a_u16 + a_u32;        // [fatal] ABI mismatch — mixed integer widths; use `as`
```

## 4. Effect & capability impact

**None to the effect system's semantics.** Integer types, casts, literals, and
overflow policy are effect-free: a cast/arithmetic node carries no effect of its
own, and the effect checker already walks the operand of `Cast`
([`effect_checker.sfn:888-897`](../../compiler/src/effect_checker.sfn#L888-L897))
so an effectful operand's requirement (`readByte() as u32`) still surfaces
correctly. The `wrapping_*` methods are `![pure]` (arithmetic only). The
debug-mode overflow **trap** is a runtime panic (like existing bounds/match
backstops), not an effect — it needs no capability, exactly as
`match_exhaustive_failed` and index-bounds traps do not. The canonical six
effects and the taxonomy lock (SFEP-0017) are untouched.

## 5. Self-hosting impact

Passes that change, in pipeline order:

1. **Lexer** (`lexer.sfn`) — number scanner consumes an optional trailing type
   suffix into the `NumberLiteral` lexeme. **Additive:** suffix-free literals lex
   identically, so the old seed and new source agree on every existing token.
2. **Parser** (`parser/expressions.sfn`) — splits the suffix off the literal
   lexeme and records the literal's fixed type. Additive; no grammar the old
   seed rejects.
3. **Typecheck** (`typecheck_types.sfn`, `typecheck.sfn`) — new
   `integer_type_is_signed`/`integer_type_width` helpers; literal-range check
   (`E0824`); implicit-integer-conversion rejection (`E0825`); the new
   mixed-integer arithmetic rejection.
4. **Emit / lowering** (`llvm/type_mapping.sfn`,
   `llvm/expression_lowering/native/core_literals_lowering.sfn`,
   `.../core_operands.sfn`) — sign-aware `as` opcodes (closes the KNOWN
   LIMITATION), sign-aware `sdiv`/`udiv` and `icmp slt`/`ult`, and the
   debug-mode overflow-intrinsic path with the release wrap fallback.
5. **Runtime prelude** (`runtime/sfn/…`) — `sfn_wrapping_*_{i,u}{8,16,32,64}`
   helpers and `sfn_panic_int_overflow`.

**Self-hosting is preserved by additivity and staging.** The lexer/parser changes
are additive (the old seed's tokenisation of the current, suffix-free compiler
source is unchanged), and the compiler source does **not** adopt typed suffixes,
`u*` types, or `wrapping_*` in the same PR that introduces them — the seed
transition is:

- **PR 1 (this capability):** land recognition + literal checking + sign-aware
  casts + overflow default + `wrapping_*` in the compiler, **without using any of
  it in `compiler/src`**. `make compile` builds the new compiler from the old
  seed (which needs none of the new features to compile the *unchanged* compiler
  source), then that new compiler self-hosts. No seed cut required — this bundles
  the capability with a no-op consumer.
- **After a seed cut** that pins the new binary: subsequent PRs may migrate
  `compiler/src` FFI/byte code to real `u*`/`usize` spellings and `wrapping_*`.
  Those migrations are gated behind the pinned seed per the seed-dependency rule.

Because the *default* overflow behaviour in **release** is wrap (identical to
today's bare `add`/`sub`/`mul`), and the compiler is built in release, turning on
the overflow default does not change the emitted IR for the existing compiler
source until debug builds opt in — the fixed-point self-host (`make check`) stays
byte-identical for the release build.

## 6. Alternatives considered

- **Leave the family half-real (status quo).** Rejected: the `u*`→wider `sext`
  miscompile is a live correctness bug (`255u8 as u64 == -1`), and the spec
  already advertises the family — shipping the syntax without the semantics is
  the "parsed but not enforced" anti-pattern.
- **Structured width/sign field on `TypeAnnotation`/IR** instead of deriving from
  the type-name string. Rejected: it would churn the AST, the `.sfn-asm` wire
  format, and every pass that threads type strings, for zero expressiveness gain
  — the rest of the compiler already resolves types by string match, and a
  derive-on-demand helper is strictly less blast radius while giving the same
  answer.
- **Overflow default = always wrap (Go/C unsigned model).** Rejected as the
  *default*: silent wrap hides real bugs (the class the ownership floor is
  otherwise closing). Wrap remains available explicitly via `wrapping_*` and is
  the *release* behaviour, but debug traps so bugs are found. Matching Rust here
  also matches what LLM-generated code expects.
- **Overflow default = always trap (Swift model).** Rejected as the *default*:
  a trap on every release-build arithmetic imposes a steady-state branch cost and
  a panic surface in hot paths (checksums, hashing) where wrap is the intended
  semantics. Debug-trap / release-wrap gives the safety signal without the
  release cost.
- **Overflow default = saturate.** Rejected: saturation is a domain choice (DSP,
  graphics), not a sane silent default for general arithmetic; it is offered as
  an explicit `saturating_*` method post-1.0.
- **`wrapping_*`/`checked_*` as operators or keywords** (e.g. `+%`, `+?`).
  Rejected: violates "libraries over keywords" — a keyword can never be a
  variable name, and these are expressible as ordinary methods with no
  expressiveness loss. Boring, conventional method names also match Rust exactly,
  reducing LLM error rates.
- **Ship `checked_*`/`saturating_*` in 1.0.** Deferred: `checked_*` needs a
  `Result`/`Option` return, which depends on the generic-constraints foundation
  (companion `draft-generic-constraints.md`). Defining the default overflow
  semantics and `wrapping_*` now is the load-bearing 1.0 slice; the checked/
  saturating library methods slot in later with no language change.
- **Retract `f32→f64` implicit widening too.** Left as a follow-on: floats are a
  single kind in the current spec coercion model, and `fpext` widening is
  lossless; this SFEP scopes the *integer* implicit-conversion retraction and
  leaves the float-widening decision to the spec's existing kind rules.

## 7. Stage1 readiness mapping

- [ ] **Parses** — typed suffixes lex+parse (`lexer.sfn`, `parser/expressions.sfn`).
- [ ] **Type-checks / effect-checks** — literal-range `E0824`, implicit-conversion
      `E0825`, mixed-width arithmetic rejection; effect checker already walks
      `Cast` operands (no change needed).
- [ ] **Emits valid `.sfn-asm`** — type strings ride the existing string channel;
      no wire-format change.
- [ ] **Lowers to LLVM IR** — sign-aware `sext`/`zext`/`uitofp`/`fptoui`,
      sign-aware `sdiv`/`udiv`/`icmp`, debug overflow-intrinsic path + release
      wrap; `wrapping_*` runtime helpers.
- [ ] **Regression coverage** — see §8.
- [ ] **Self-hosts** — additive lexer/parser; compiler source unchanged in the
      landing PR; migration behind a pinned seed (§5).
- [ ] **`sfn fmt --check` clean** — formatter round-trips suffixed literals.
- [ ] **Documented** — `docs/status.md` numeric rows updated;
      `reference/spec/06-types.md` gains the sized-family, conversion, and
      overflow sections.

Per SFEP-0001 §4, this stays **Accepted** (not Implemented) until every box is
checked and it self-hosts — the overflow *trap* especially must be enforced
end-to-end, not merely parsed.

## 8. Test plan

Unit (`compiler/tests/unit/`):

- `lexer_int_suffix_test.sfn` — `100u8`, `-5i16`, `0xffu32`, `1_000i64`,
  `3.5f32`, `100_u8`; and that `1e` / `1e2` (exponent) still lex as float, not a
  suffix.
- `typecheck_int_literal_range_test.sfn` — `u8 = 300` → `E0824`; boundary values
  (`255u8` ok, `256u8` error; `-128i8` ok, `-129i8` error; `u32` max ok / +1
  error).
- `typecheck_int_implicit_conversion_test.sfn` — `let s: u32 = an_i32` → `E0825`
  with `as` fix-it; `a_u16 + a_u32` → ABI-mismatch `[fatal]`; same-type ops ok.
- `sign_helpers_test.sfn` — `integer_type_is_signed`/`integer_type_width` truth
  table for all ten integer names + `usize`/`isize`.

Integration / e2e (`compiler/tests/e2e/`):

- `int_cast_sign_test.sfn` — **the regression that closes the KNOWN
  LIMITATION:** `255u8 as u64 == 255` (zext), `(-1i8) as i64 == -1` (sext),
  `300u16 as u8 == 44` (trunc), `(-1i32) as u32` bit-reinterpret, `3.5f64 as i32
  == 3`, `(-1i32) as f64 == -1.0`. Assert on runtime output via
  `process.run_capture`.
- `int_overflow_default_test.sfn` — a debug build of `i32` `add` that overflows
  **traps** with the overflow message (build the fixture with the debug flag,
  assert non-zero exit + message); the release build **wraps** to the two's-
  complement value. Follows the build-and-run isolation rules
  (`SAILFIN_TEST_SCRATCH`, threaded `PATH`).
- `int_wrapping_methods_test.sfn` — `250u8.wrapping_add(10u8) == 4`,
  `wrapping_sub`/`wrapping_mul`/`wrapping_neg` per width; never traps in debug.
- `int_unsigned_arithmetic_test.sfn` — `u32` division/comparison use `udiv`/
  `icmp ult` (a large `u32` compares `>` a small one where the signed
  interpretation would flip).

Snapshot: an IR snapshot (`expect_snapshot`) over a small module exercising
`u8→u64` (zext), `i8→i64` (sext), and a debug overflow-checked `add` to lock the
opcode selection.

## 9. References

- **Code (the gap):**
  `compiler/src/llvm/type_mapping.sfn:859-897` (the u*→signed collapse),
  `compiler/src/llvm/expression_lowering/native/core_literals_lowering.sfn:1837-1845`
  (the standing "KNOWN LIMITATION" comment),
  `compiler/src/llvm/expression_lowering/native/core_operands.sfn:2495-2557`
  (`dominant_type` — i8/i32/i64-only branches, silent same-kind widening),
  `compiler/src/lexer.sfn:190-280` (no suffix support),
  `compiler/src/typecheck_types.sfn:1057-1075` (`is_extern_primitive_type`
  accept-list), `:464-481` (string-driven kind resolution precedent),
  `compiler/src/ast.sfn:12-14` (`TypeAnnotation` is text), `:95` (`Cast` node),
  `compiler/src/effect_checker.sfn:888-897` (Cast operand walk, #1627),
  `compiler/src/native_ir.sfn:73-77` (string-threaded types).
- **Status / spec:** `docs/status.md:184-185` (numeric types + bitwise ops
  "Shipped"), `site/src/content/docs/docs/reference/spec/06-types.md`
  (primitive table, sized-family FFI note, scalar coercion kinds).
- **Related SFEPs / work:** SFEP-0025 §3.7 (`0025-native-runtime-architecture.md`,
  the `int`/`float` numeric-types decision this extends), SFEP-0017
  (`0017-hierarchical-effects.md`, the taxonomy lock this leaves untouched),
  companion `draft-generic-constraints.md` (the generics foundation that
  `checked_*` → `Result`/`Option` depends on — deferred post-1.0), `.claude/rules/
  seed-dependency.md` (the bundle-vs-split seed rule applied in §5).
- **Prior art:** Rust integer types + `as` semantics + debug-trap/release-wrap
  overflow + `wrapping_*`/`checked_*`/`saturating_*`; Swift trapping arithmetic
  and `&+` wrapping operators; Go's fixed-size `intN`/`uintN` with defined wrap.
