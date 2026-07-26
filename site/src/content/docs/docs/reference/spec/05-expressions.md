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
| Type-guard | `is` |
| Borrow | `&expr` `&mut expr` |
| Cast | `expr as Type` |

`&&` and `||` short-circuit. `is` tests whether an enum value is a specific variant (see §5 "Type-guard operator") and returns `bool`.

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

## Anonymous functions (lambdas)

An anonymous function is written with a leading `fn`, a parenthesized parameter list, an optional `-> ReturnType`, and a body. The body is either a `{ ... }` **block** or, for the additive expression-bodied **short form**, `=> expr`:

```sfn
let sq  = fn(x: int) -> int { return x * x; };  // block form
let sq2 = fn(x) => x * x;                        // short form — equivalent
let add = fn(x: int, y: int) => x + y;          // typed head, expr body
numbers.map(fn(x) => x * x);                     // the callback idiom
```

The short form is **purely additive**: `fn(x) => expr` desugars to a single-`return` block (`fn(x) { return expr; }`), so the two forms are equivalent and the block form is unchanged. The `fn` lead-in keeps lambda recognition zero-lookahead, so the body `=>` never collides with the `match`-arm separator (`Pattern => body`, §8).

A lambda's parameter and return types may be **omitted** when it is passed directly as a callback: the compiler infers them from the callee's expected function type. For a user higher-order function whose parameter is declared `fn(int) -> int`, or for the builtin `int[]` methods `.map` / `.filter` / `.reduce` (§10), `numbers.map(fn(x) => x * x)` types `x` and the result from the mapper signature. A lambda that is already annotated keeps its annotations. (Inference is currently limited to these call-site positions and `int`-element arrays; other element types follow generic constraints.)

## Cast operator (`as`)

`expr as Type` performs an explicit numeric or pointer-shape conversion. The cast is postfix-bound (tighter than any binary operator) and left-associative — `x as i32 as i64` parses as `((x as i32) as i64)`.

### Numeric cast pairs

| Source → Target | LLVM op | Notes |
|---|---|---|
| `i8`/`i16`/`i32`/`i64` (signed) → wider int | `sext` | Sign-extends |
| `u8`/`u16`/`u32`/`u64`/`usize` (unsigned) → wider int | `zext` | Zero-extends |
| `bool` → wider int | `zext` | `true` → 1, not -1 |
| `int` (any width) → narrower int | `trunc` | Truncates high bits, sign-independent |
| Signed int → `float`/`double` | `sitofp` | Signed integer to FP |
| Unsigned int → `float`/`double` | `uitofp` | Unsigned integer to FP |
| `bool` → `float`/`double` | `uitofp` | `true` → 1.0, not -1.0 |
| `float`/`double` → signed int | `fptosi` | Truncates toward zero |
| `float`/`double` → unsigned int | `fptoui` | Truncates toward zero |
| `f32` → `float` (`double`) | `fpext` | FP widening |
| `float` (`double`) → `f32` | `fptrunc` | FP narrowing |
| `*T` → `*U` | `bitcast` | Pointer reinterpret |
| `int` → `*T` | `inttoptr` | Address-from-integer |
| `*T` → `int` | `ptrtoint` | Address-as-integer |
| same → same | identity | No-op |

### Rejected casts

`expr as bool` is rejected at the LLVM lowering level for any operand type — pointers, integers, and floats alike. The compiler emits a fix-it suggesting an explicit comparison: `x != null` for pointers, `x != 0` for integers, `x != 0.0` for floats. Reinterpreting bit patterns into `i1` is almost always a bug; the comparison is the operation users actually want.

### Known limitations (Slice D, 2026-05-03)

- **Source-level signedness is recovered only for a plain identifier or parameter operand.** Sailfin's `i8`/`u8`/`i16`/`u16`/`i32`/`u32`/`i64`/`u64`/`usize` annotations all collapse to LLVM's signless `i8`/`i16`/`i32`/`i64`, so the cast lowering recovers sign from the operand's source-level annotation via its local/parameter binding: `255u8 as u64` now lowers as `zext` and produces `255` (SFN-503). A **compound operand** — `s.field as u64`, `xs[i] as u64`, `f() as u64`, `(a + b) as u64` — carries no source annotation available to the lowering pass and still selects the signed forms (`sext`/`sitofp`/`fptosi`), so an unsigned compound expression can still produce a sign-extended result. Closing that gap needs the checker's inferred type threaded through expression lowering, scoped to the typecheck slice of SFEP-0058 §3.3 (SFN-501).
- **Mixed `int` + `float` in a binary op (without an explicit cast) still silently widens to `double`** — the architect-planned `dominant_type` tightening that would reject this rides on Slice E (`number` retirement). Workaround today: spell the cast (`x as float + y` or `x + y as int`). Tracked in [issue #296](https://github.com/SailfinIO/sailfin/issues/296).

## Type-guard operator (`is`)

`expr is Variant` tests whether a named `enum` value is a specific variant. It is an infix binary operator with the same precedence as comparison operators, and it returns `bool`.

```sfn
enum Input {
    Text { value: string },
    Number { amount: int }
}

fn process(input: Input) ![io] {
    if input is Text {
        print("It's a string: {{input.value}}");
    } else {
        print("It's a number: {{input.amount}}");
    }
}
```

### Semantics

- **Discriminant test.** `x is Variant` lowers to the enum's discriminant tag comparison — the same check `match` uses for an enum-variant arm.
- **Flow-sensitive narrowing (then-branch).** Inside the `if`-`is` then-branch the compiler narrows the operand's type to the tested variant. Member accesses against the narrowed binding (`input.value` above) resolve against that variant's payload fields — the same narrowing `match` applies to a destructured arm.
- **Effect transparency.** The effect checker walks the operand of `is`. If the operand expression itself requires effects (e.g. `readFile() is T`), those effects must be declared on the enclosing function. The operator adds no effects of its own.
- **Returns `bool`.** The result is an ordinary boolean expression usable in any boolean context — `if`, `&&`/`||`, `let b = x is Variant`, etc.

### v1 scope and limitations

The current implementation supports `is` on **named `enum` operands only**. The following are not yet supported and are deferred:

- Non-enum operands: inline union types (`string | int`), primitives, and plain structs.
- Else-branch complement narrowing: the else-branch does not narrow the operand to the complement set of variants.

These limitations exist because the typecheck pass does not yet perform general expression-type inference ([#829](https://github.com/SailfinIO/sailfin/issues/829)), and the lowering's narrowing machinery is enum-discriminant-based. Non-enum narrowing will be addressed when expression-type inference lands.

The worked example is `examples/advanced/type-guards.sfn`.
