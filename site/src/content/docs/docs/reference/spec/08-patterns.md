---
title: "§8 Pattern Matching"
description: "Sailfin language specification — Pattern Matching."
sidebar:
  order: 8
  label: "§8 Pattern Matching"
---

> **Note**: `match` is parsed by the compiler and emits IR, but LLVM lowering of numeric and enum variant patterns may be unreliable in the current release. String and wildcard patterns are more stable. See the stability note in §4.

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
- **Exhaustiveness** — the compiler requires all cases be covered (or a `_` wildcard)
