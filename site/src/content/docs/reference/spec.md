---
title: Language Specification
description: The complete Sailfin language specification.
section: reference
order: 1
---

> This page will contain the full Sailfin language specification. The canonical source is [`docs/spec.md`](https://github.com/SailfinIO/sailfin/blob/main/docs/spec.md) in the Sailfin repository.

The specification is organized in two parts:

## Part A — Current Language

What ships and works today in the self-hosted native compiler:

- **Lexical Structure** — Identifiers, keywords, literals, comments
- **Modules & Imports** — Module system and capability imports
- **Declarations** — Variables, functions, structs, interfaces, enums, type aliases, models, prompts, pipelines, tools
- **Statements & Control Flow** — If/else, match, try/catch, loops, for-in
- **Concurrency** — Async/await, routines, channels, accelerators
- **Type System** — Primitives, composites, vectors, tensors, wrapper types (PII, Secret, Affine, Linear)
- **Ownership & Borrowing** — Move semantics, shared/mutable references, unsafe FFI, raw pointers
- **Capability-Based Security** — Effect annotations, intrinsic declarations, transitive enforcement
- **String Interpolation** — `{{ expression }}` syntax
- **Runtime Semantics** — Prelude, printing, logging, string utilities
- **Testing** — Test declarations, evaluators, replay

## Part B — Design Preview

Features that are specified but not yet fully implemented:

- Native backend layout descriptors
- Hierarchical effect system
- Pipeline operator (`|>`)
- Currency literals

---

*Full specification content will be published here as part of the 1.0 documentation effort. For now, refer to the [source spec](https://github.com/SailfinIO/sailfin/blob/main/docs/spec.md).*
