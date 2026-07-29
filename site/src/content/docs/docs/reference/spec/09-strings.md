---
title: "§9 String Interpolation"
description: "Sailfin language specification — String Interpolation."
sidebar:
  order: 9
  label: "§9 String Interpolation"
---

```sfn
let name = "Sailfin";
let greeting = "Hello, ${ name }!";          // "Hello, Sailfin!"
let math = "2 + 2 = ${ 2 + 2 }";            // "2 + 2 = 4"
let nested = "User: ${ user.name.trim() }"; // arbitrary expressions
```

`${ expr }` opens an interpolation. Whitespace at the edges is insignificant:
`${name}` and `${ name }` are equivalent. A bare `$` not followed by `{` is
literal (`"Total: $5"`). Nested braces inside the expression are matched by
depth, so `"${ f({a: 1}) }"` parses as a single interpolation. The compiler
lowers interpolated strings into segment arrays evaluated at runtime.

`{{ expr }}` has no special meaning and appears verbatim in the output —
`"{{ name }}"` renders as the literal text `{{ name }}`, not an interpolation.

A literal-`${` escape (`\${`) produces the two literal characters `${` without
opening an interpolation. Escaped backslashes compose normally:
`"\\${name}"` produces a literal backslash followed by the interpolated value.

The recognized string escapes are `\"`, `\\`, `\n`, `\r`, `\t`, and `\$`.
The `$` escape is only necessary before `{`; a bare `$` is already literal.
For compatibility, an otherwise unknown escape drops its backslash, so `\z`
decodes to `z`.

Primitive optional unions such as `int | null` render the active non-null
payload in direct, flow-narrowed, and match-bound positions.

## Concatenating a numeric or boolean operand (`+`)

`string + <int | float | bool>` (either operand order) concatenates by
stringifying the non-string operand, rather than requiring an explicit cast:

```sfn
let n = 42;
let f = 1.5;
let t = true;

let a = "n=" + n;       // "n=42"
let b = "f=" + f;       // "f=1.5"
let c = "t=" + t;       // "t=true"
let d = n + " items";   // "42 items" -- works with the string on either side
```

This is defined as sugar for `string + (x as string)` — the same display
lowering the `as string` cast uses — so the two cannot diverge. Booleans render
`"true"`/`"false"` through concatenation, `as string`, and interpolation.

Indexing a string still yields a single-character string (`s[i]`), not a
numeric code point, so concatenating an indexed character (`"c=" + s[1]`)
is unaffected and continues to concatenate the character itself.

Raw pointer arithmetic (`*u8 + int`) is a distinct operation and is **not**
concatenation — it still lowers to pointer offsetting, never stringification.
