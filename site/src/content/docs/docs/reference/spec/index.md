---
title: Language Specification
description: Authoritative reference for the Sailfin language as implemented by the self-hosted native compiler.
sidebar:
  order: 0
  label: Overview
---

This is the authoritative web reference for the Sailfin language as
implemented by the self-hosted native compiler. It covers syntax, semantics,
the type system, the effect system, and the runtime contract.

The specification is split across chapters for readability:

- [§1 Lexical Structure](/docs/reference/spec/01-lexical)
- [§2 Modules and Imports](/docs/reference/spec/02-modules)
- [§3 Declarations](/docs/reference/spec/03-declarations)
- [§4 Statements and Control Flow](/docs/reference/spec/04-statements)
- [§5 Expressions and Operators](/docs/reference/spec/05-expressions)
- [§6 Type System](/docs/reference/spec/06-types)
- [§7 Effect System](/docs/reference/spec/07-effects)
- [§8 Pattern Matching](/docs/reference/spec/08-patterns)
- [§9 String Interpolation](/docs/reference/spec/09-strings)
- [§10 Runtime](/docs/reference/spec/10-runtime)
- [§11 Testing](/docs/reference/spec/11-testing)

For planned-but-not-yet-shipped features, see the [Design Preview](/docs/reference/preview/).

The canonical source lives in
[`docs/spec.md`](https://github.com/SailfinIO/sailfin/blob/main/docs/spec.md);
this site is the rendered form.
