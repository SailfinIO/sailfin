---
title: "§1 Lexical Structure"
description: "Sailfin language specification — Lexical Structure."
sidebar:
  order: 1
  label: "§1 Lexical Structure"
---

**Identifiers** begin with a letter or `_` and may contain ASCII letters, digits, or `_`.
Identifiers are case-sensitive. Reserved keywords may not be used as identifiers.

**Keywords** — see [Keywords Reference](/docs/reference/keywords) for the full list with descriptions.

**Literals**:

| Kind | Examples | Notes |
|------|----------|-------|
| Integer | `42`, `0`, `1_000_000` | Underscores allowed as separators |
| Float | `3.14`, `0.5`, `1.0e6` | 64-bit IEEE 754 |
| String | `"hello"`, `"line\n"` | UTF-8, escape sequences, `{{ }}` interpolation |
| Boolean | `true`, `false` | |
| Null | `null` | Explicit absence of a value |

Currency literals (`$0.05`) are **not yet parsed** — use `0.05 // USD` as a comment annotation.
Time literals (`1s`, `150ms`) are **not yet parsed** — use numeric milliseconds.

**Comments**:
- `//` single-line
- `/* ... */` multi-line
- `///` doc comments (on declarations)

**Effect annotations** — `![effect, ...]` after a function/test/pipeline signature:

```sfn
fn fetch(url: string) -> string ![io, net] { ... }
```

Canonical effects: `io`, `net`, `model`, `gpu`, `rand`, `clock`, plus `unsafe`, `read`, `mut`.
