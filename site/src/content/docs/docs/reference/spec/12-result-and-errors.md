---
title: "§12 Result and the ? Operator"
description: "Sailfin language specification — typed error handling with Result<T, E> and the postfix ? propagation operator."
sidebar:
  order: 12
  label: "§12 Result and ?"
---

Sailfin's typed error-handling path pairs the prelude `Result<T, E>` enum with a
postfix `?` operator that propagates the error arm to the enclosing function's
return. It is a value-based, effect-free channel that complements the existing
`try` / `catch` / `throw` machinery (§4) without depending on the exception
runtime.

## 12.1 The `Result<T, E>` type

`Result<T, E>` is an ordinary generic enum declared in the prelude — it is not a
compiler-magic primitive, and it resolves implicitly (no import required):

```sfn
// runtime/prelude.sfn
enum Result<T, E> {
    Ok { value: T },
    Err { error: E }
}

struct Error {
    message: string;
}
```

The prelude also ships a concrete default `Error` struct. `E` is **unconstrained**
— any type may be the error arm — so `Result<int, Error>`, `Result<Config, MyErr>`,
and `Result<string, int>` are all legal.

Construction uses Sailfin's qualified enum-variant form, and the payload is a
named field:

```sfn
return Result.Ok { value: 5 };
return Result.Err { error: Error { message: "boom" } };
```

The generic payloads monomorphise per instantiation, so `value` and `error` are
read by value (not type-erased to `i8*`).

## 12.2 Inspecting a `Result` with `match`

A `Result` is destructured like any other payload-carrying enum (§8), using
`Pattern => expr` match arms:

```sfn
fn describe(result: Result<int, Error>) -> string {
    match result {
        Result.Ok { value } => return "ok",
        Result.Err { error } => return "error: " + error.message
    }
}
```

## 12.3 The postfix `?` operator

`?` is an **expression-level postfix** operator that unwraps the success value of
a `Result`, or short-circuits the enclosing function by returning the error arm.

```sfn
fn parse_int(s: string) -> Result<int, Error> {
    if s == "" {
        return Result.Err { error: Error { message: "empty" } };
    }
    return Result.Ok { value: string_to_int(s) };
}

fn sum_two(a: string, b: string) -> Result<int, Error> {
    let x = parse_int(a)?;   // unwrap, or early-return the Err
    let y = parse_int(b)?;
    return Result.Ok { value: x + y };
}
```

`?` works on any `Result`-typed expression — a call, a variable, a field — and
left-associates in a postfix chain, so `a()?.b()?` parses as `((a()?).b())?`.

### 12.3.1 Desugaring (pure control flow)

`x?` desugars, before emission, to a `match` over the operand whose `Err` arm is
an early `return`. Sailfin has no `match`-*expression* (only a `match`
*statement*), so the emitter performs a **continuation-style** rewrite: the
operand is hoisted into a `match` statement whose `Ok` arm binds the unwrapped
value and carries the remainder of the enclosing block, while the `Err` arm
performs the early return. So `let x = parse_int(a)?;` followed by the rest of
the block rewrites (illustratively) to:

```sfn
match parse_int(a) {
    Result.Err { error } => return Result.Err { error: error },
    Result.Ok { value } => {
        let x = value;
        // ... the remainder of the enclosing block continues here ...
    }
}
```

This is the same zero-cost lowering Rust uses for `?`: a discriminant test plus a
branch. It does **not** touch the exception runtime — there is no `setjmp`, no
`sailfin_runtime_throw`, and no thread-local poll. `?` introduces **no effect**;
the effect checker (§7) ignores it entirely, because the capability surface
belongs to the call that produces the `Result` (e.g. an `![io]` read), not to the
propagation.

## 12.4 Where `?` may be used (the exact-`E` rule)

`?` is only legal inside a function whose declared return type is `Result<U, F>`,
and the error type of the propagated `Result` must match the enclosing function's
error type **exactly**. There is no `From<E>` coercion: the operand's `E` is
returned verbatim.

The type checker enforces three rules, each with a dedicated diagnostic:

| Rule | Diagnostic | Condition |
|---|---|---|
| Operand must be a `Result<T, E>` | `E0810` | `?` applied to a non-`Result` value |
| Enclosing fn must return `Result<U, F>` | `E0811` | `?` used in a function not returning `Result` |
| `E` must equal `F` exactly | `E0812` | operand error type differs from the function's error type |

The type of the whole `x?` expression is `T`, the unwrapped success type.

The current generic-constraint scope does not yet provide the `From<E>`
coercion form or an `E: Error` bound for `Result`. Mixed error types must be
converted manually (for example, `match` the inner `Result` and re-wrap the
error).

## 12.5 Disambiguating the two `?`s

Sailfin uses the `?` glyph for two unrelated constructs. They never overlap,
because they are parsed in disjoint positions:

| Position | Meaning | Parsed by | Example |
|---|---|---|---|
| **Type suffix** | nullable type | type-annotation parser | `let x: Config?`, `field: Cell?` |
| **Expression postfix** | propagate `Err` | expression parser | `let x = read()?;` |

The type-annotation `?` is only consumed after `:` / `->`, inside `<...>`, or
after a field name; the expression postfix `?` only appears in value position.
They can coexist in a single statement without ambiguity:

```sfn
let x: Config? = load()?;   // type-suffix ? on Config; postfix ? on load()
```

## 12.6 Relationship to `try` / `catch` / `throw`

`Result` and the exception system (§4) coexist. Inside a `Result`-returning
function a `throw` remains an exception — it is **not** auto-converted to an
`Err`. `Result` is the preferred, typed path for new code; `try` / `catch` /
`throw` remain available for unrecoverable conditions and for code that has not
migrated. The two are orthogonal: `?` never interacts with the exception frame,
and `throw` never produces a `Result`.
