---
title: Reference
description: Language specification, grammar, standard library, CLI, and runtime ABI reference.
sidebar:
  order: 0
  label: Overview
---

The reference section is the authoritative source for how Sailfin works.

## Specification

- **[Language Specification](/docs/reference/spec/)** — Syntax, semantics,
  type system, and effect system, split by chapter (§1–§11). This is the
  normative reference for the current language.
- **[Design Preview](/docs/reference/preview/)** — Planned features not yet
  shipped. Informative only.

## Grammars and Vocabulary

- **[Grammar (EBNF)](/docs/reference/grammar)** — Formal grammar in Extended
  Backus–Naur Form.
- **[Keywords](/docs/reference/keywords)** — All reserved words with
  descriptions.

## Subsystems

- **[Effect System](/docs/reference/effects)** — Canonical effects, inference
  rules, and diagnostics.
- **[Standard Library](/docs/reference/standard-library)** — Built-in modules
  and APIs.
- **[CLI Reference](/docs/reference/cli)** — `sailfin` command-line flags and
  subcommands.
- **[Runtime ABI](/docs/reference/runtime-abi)** — Low-level interface between
  compiled Sailfin code and the runtime.

## Canonical Source

The specification's canonical source lives in the site content under
[`site/src/content/docs/docs/reference/`](https://github.com/SailfinIO/sailfin/tree/main/site/src/content/docs/docs/reference)
in the repository. This site is the rendered form.
