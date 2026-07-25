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

The older `{{ expr }}` form is **deprecated** but still accepted during a
migration window; using it emits a non-fatal `W0212` deprecation warning at
`sfn check` time. It will be removed in a later phase.

A literal-`${` escape (`\${`) is **not yet available** — it is deferred to a
follow-up (SFEP-0057 Phase 4 / SFN-483) — so a string that needs a literal
`${` should currently be assembled another way (e.g. concatenation) rather
than relying on an escape.

Primitive optional unions such as `int | null` render the active non-null
payload in direct, flow-narrowed, and match-bound positions.
