---
title: Grammar (EBNF)
description: The formal grammar of the Sailfin language in Extended Backus-Naur Form.
section: reference
order: 2
---

> The complete EBNF grammar is maintained in [`docs/enbf.md`](https://github.com/SailfinIO/sailfin/blob/main/docs/enbf.md).

The grammar covers:

- **Program structure** — Top-level declarations and module layout
- **Imports & exports** — Module dependencies and public API surfaces
- **Declarations** — Struct, enum, interface, function, pipeline, tool, model, test, type alias
- **Statements** — Variable declarations, control flow, error handling, async
- **Expressions** — Lambda, pipeline operator, logical/arithmetic operations, type casts
- **Pattern matching** — Destructuring and match arms
- **Effect lists** — `![effect, ...]` capability tokens
- **Prompt blocks** — system/user/assistant/tool message composition
- **Type system** — Unions, optionals, references, pointers, generics
- **Literals & operators** — String, numeric, boolean, collection literals

---

*Full EBNF will be rendered here. For now, refer to the [source grammar](https://github.com/SailfinIO/sailfin/blob/main/docs/enbf.md).*
