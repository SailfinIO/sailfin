---
title: "§8 Pattern Matching"
description: "Sailfin language specification — Pattern Matching."
sidebar:
  order: 8
  label: "§8 Pattern Matching"
---

Literal patterns, `_`, guards, and enum-variant destructuring lower
end-to-end. Compile-time exhaustiveness checking remains partial, so emitted
matches retain a runtime backstop for an uncovered value.

```sfn
match value {
    0               => print("zero"),
    n if n < 0      => print("negative"),
    Response.Ok { value } => process(value),
    Response.Error { code, message } => print.err("{{ code }}: {{ message }}"),
    _               => print("other"),
}
```

Pattern forms:
- **Literal** — `0`, `"hello"`, `true`
- **Variable capture** — any identifier binds the value
- **Wildcard** — `_` matches anything, discards
- **Enum destructuring** — `Variant { field }` extracts payload fields
- **Guard** — `pattern if condition` adds a boolean filter
- **Exhaustiveness** — compile-time checking is partial; use a `_` wildcard
  when the known variants do not cover every possible value
