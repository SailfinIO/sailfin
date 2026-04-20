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
