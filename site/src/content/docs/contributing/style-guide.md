---
title: Style Guide
description: Code conventions and repository organization for the Sailfin project.
section: contributing
order: 3
---

> Canonical source: [`docs/style-guide.md`](https://github.com/SailfinIO/sailfin/blob/main/docs/style-guide.md)

## Goals

- One concern per file
- Intent-obvious naming
- Use `mod.sfn` for public API surfaces

## Repository Layout

```
compiler/          # The self-hosted compiler
  src/             # Compiler source (.sfn)
  tests/           # Unit, integration, and e2e tests
runtime/           # Runtime libraries
  prelude.sfn      # Sailfin-native prelude
  native/          # C runtime (pre-1.0)
docs/              # Language documentation
examples/          # Example programs
scripts/           # Build and release tooling
tools/             # Developer tooling
```

## File Naming

- **snake_case** for all files: `http_client.sfn`, `effect_checker.sfn`
- **Role suffixes**: `*_utils.sfn`, `*_checker.sfn`, `*_lowering.sfn`, `*_ir.sfn`, `*_semantics.sfn`
- **`mod.sfn`** for module public API re-exports

## Sailfin Code Style

- `CamelCase` for types: `UserProfile`, `HttpResponse`
- `snake_case` for functions and variables: `fetch_data`, `user_count`
- `UPPER_SNAKE_CASE` for constants: `MAX_RETRIES`
- Effect annotations on same line: `fn save(data: String) ![io] {`
- Doc comments with `///`

## Import Conventions

- Relative imports within a module folder
- Cross-domain imports via `mod.sfn`

## Documentation Updates

When changing language behavior, update in order:
1. `docs/status.md` — What ships today
2. `docs/spec.md` — Language reference
3. The [roadmap](/roadmap) — If it affects planned work
