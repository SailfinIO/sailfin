---
title: "§5 Expressions and Operators"
description: "Sailfin language specification — Expressions and Operators."
sidebar:
  order: 5
  label: "§5 Expressions and Operators"
---

| Category | Operators |
|----------|-----------|
| Arithmetic | `+` `-` `*` `/` `%` |
| Comparison | `==` `!=` `<` `>` `<=` `>=` |
| Logical | `&&` `\|\|` `!` |
| Compound assignment | `+=` `-=` `*=` `/=` |
| Type check | `is` |
| Borrow | `&expr` `&mut expr` |
| Cast | `expr as Type` |

`&&` and `||` short-circuit. `is` performs a runtime type check and returns `boolean`.

Operator precedence: unary > multiplicative > additive > comparison > equality > `&&` > `||` > assignment.

## Cast operator (`as`)

`expr as Type` performs an explicit numeric or pointer-shape conversion. The cast is postfix-bound (tighter than any binary operator) and left-associative — `x as i32 as i64` parses as `((x as i32) as i64)`.

### Numeric cast pairs

| Source → Target | LLVM op | Notes |
|---|---|---|
| `int` (any width) → wider int | `sext` | Sign-extends |
| `bool` → wider int | `zext` | `true` → 1, not -1 |
| `int` (any width) → narrower int | `trunc` | Truncates high bits |
| `int` (any width) → `float`/`double` | `sitofp` | Signed integer to FP |
| `bool` → `float`/`double` | `uitofp` | `true` → 1.0, not -1.0 |
| `float`/`double` → `int` (any width) | `fptosi` | Truncates toward zero |
| `f32` → `float` (`double`) | `fpext` | FP widening |
| `float` (`double`) → `f32` | `fptrunc` | FP narrowing |
| `*T` → `*U` | `bitcast` | Pointer reinterpret |
| `int` → `*T` | `inttoptr` | Address-from-integer |
| `*T` → `int` | `ptrtoint` | Address-as-integer |
| same → same | identity | No-op |

### Rejected casts

`expr as bool` is rejected at the LLVM lowering level for any operand type — pointers, integers, and floats alike. The compiler emits a fix-it suggesting an explicit comparison: `x != null` for pointers, `x != 0` for integers, `x != 0.0` for floats. Reinterpreting bit patterns into `i1` is almost always a bug; the comparison is the operation users actually want.

### Known limitations (Slice D, 2026-05-03)

- **Source-level signedness is not tracked through casts.** Sailfin's `i8`/`u8`/`i16`/`u16`/`i32`/`u32` annotations all collapse to LLVM `i8`/`i16`/`i32`, so `255_u8 as u64` lowers as `sext` and produces `-1` instead of `255`. Tracked in [issue #295](https://github.com/SailfinIO/sailfin/issues/295)/[#296](https://github.com/SailfinIO/sailfin/issues/296) follow-ups.
- **Mixed `int` + `float` in a binary op (without an explicit cast) still silently widens to `double`** — the architect-planned `dominant_type` tightening that would reject this rides on Slice E (`number` retirement). Workaround today: spell the cast (`x as float + y` or `x + y as int`). Tracked in [issue #296](https://github.com/SailfinIO/sailfin/issues/296).
