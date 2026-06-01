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

## Function calls and name resolution

A call expression `callee(args...)` whose `callee` is a bare identifier is **name-resolved at compile time**. The identifier must resolve to one of:

1. **An in-scope binding** — a parameter, a local `let`/`let mut`, a top-level `fn` or `extern fn` in the same module, or a name introduced by an `import { … }` specifier.
2. **A builtin** in the language's fixed call envelope: `print`, `console`, `assert`, `spawn`, `sleep`, `serve`, `channel`, `send`, `receive`, `await`, and the atomic intrinsics `atomic_load`, `atomic_store`, `atomic_add`, `atomic_sub`, `atomic_cas`, `atomic_fence`.
3. **An implicit runtime global** — a top-level declaration of the prelude (`runtime/prelude.sfn`) or the `runtime/sfn/**` tree, which is linked into every binary and so is callable without an explicit `import`.
4. **An imported free function** carried in the module's localized import table.

A callee that resolves to **none** of the above is rejected:

```
error[E0420]: undefined function `notarealfunction`
  --> app.sfn:2:5
   |
 2 |     notarealfunction("hi");
   |     ^^^^^^^^^^^^^^^^
  [kind: typecheck]
```

`sfn check` and the build path (`sfn build`/`sfn run`/`sfn test`) both exit non-zero on `E0420`. Defining the function — or importing it — clears the diagnostic:

```sfn
fn greet() {}

fn main() {
    greet();  // ok — resolves to the top-level declaration
}
```

**Out of scope for `E0420`:** member/method callees (`obj.method()`) are not name-resolved here — the member name is never flagged; undefined *variable* references (a bare identifier used as a value, not a callee) are a separate concern; and argument *types* are not checked by this rule.

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
