# Sailfin Style & Layout Guide

This guide captures the current Sailfin repository layout and the conventions
the compiler, runtime, and examples follow. Treat it as the source of truth
for naming, organization, and where new work should land.

## Code Formatting

All `.sfn` files in the repository are formatted with `sfn fmt` and CI enforces
this on every pull request. There is one canonical style with no configuration.

```bash
sfn fmt --write compiler/src/   # format files in place
sfn fmt --check compiler/src/   # verify formatting (CI mode)
```

Do not manually adjust indentation, spacing, or brace placement — `sfn fmt`
handles all of it. If you disagree with a formatting decision, file an issue
against the formatter rather than overriding the output.

## Goals

- Keep one major concern per file (lexer, parser, lowering, etc.).
- Make intent obvious from the path and filename.
- Use `mod.sfn` to present stable public APIs within a folder.
- Mirror source and tests so navigation and refactors stay predictable.

## Repository Layout (Current)

```
sailfin/
├─ compiler/
│  ├─ src/                       # self-hosted compiler sources (.sfn)
│  │  ├─ main.sfn                # compiler entry point
│  │  ├─ lexer.sfn
│  │  ├─ parser/                 # parser domain
│  │  │  ├─ mod.sfn              # public parser API
│  │  │  ├─ declarations.sfn
│  │  │  ├─ expressions.sfn
│  │  │  ├─ statements.sfn
│  │  │  └─ types.sfn
│  │  ├─ llvm/                   # native backend lowering
│  │  │  ├─ mod.sfn              # public LLVM backend API
│  │  │  ├─ lowering/
│  │  │  └─ expression_lowering/
│  │  └─ ...                     # typecheck, effects, emitters, utilities
│  ├─ tests/
│  │  ├─ unit/
│  │  ├─ integration/
│  │  └─ e2e/
│  ├─ build/                     # generated bootstrap artifacts (do not edit)
│  └─ *.py                       # legacy bootstrap sources (emergency only)
├─ runtime/
│  ├─ prelude.sfn                # Sailfin-visible runtime surface
│  ├─ native/                    # C runtime implementation
│  └─ (no Python shims)          # Python runtime shims removed pre-1.0
├─ docs/
├─ examples/
├─ scripts/
└─ tools/
```

If a subsystem grows large, give it its own folder under `compiler/src/` with a
`mod.sfn` and keep cross-module imports going through that `mod.sfn`.

## File Naming Conventions

- Use `snake_case` for filenames and keep them short but descriptive.
- Prefer name + role suffixes that match existing usage:
  - `*_utils.sfn` for helpers (`string_utils.sfn`, `token_utils.sfn`)
  - `*_checker.sfn` for validators (`effect_checker.sfn`)
  - `*_lowering.sfn` for lowering passes (`core_ops_lowering.sfn`, `core_literals_lowering.sfn`)
  - `*_ir.sfn` for IR definitions (`native_ir.sfn`)
  - `*_semantics.sfn` for semantic interpretation (`decorator_semantics.sfn`)
- In multi-file domains, use neutral names like `types.sfn`, `utils.sfn`,
  `expressions.sfn`, and keep the public entry point as `mod.sfn`.
- Test files use `_test.sfn` suffixes and live under the matching test tier.

## Module APIs (`mod.sfn`)

Use `mod.sfn` to re-export public APIs for a folder. Keep imports from other
folders pointing at `mod.sfn` so internal files can move freely.

```sfn
// compiler/src/parser/mod.sfn
export { parse_declaration } from "./declarations";
export { parse_expression } from "./expressions";
export { parse_statement } from "./statements";
export { parse_type } from "./types";
```

```sfn
import { parse_expression } from "./parser/mod";
```

## Source Organization

- Keep public exports near the top; helpers follow below.
- Group related helpers in small sections if it improves scanability.
- Prefer additional files over large mixed concerns in a single file.

## Imports

- Use relative imports within a folder (`./utils`, `./types`).
- When crossing a domain boundary (e.g., `parser` to `llvm`), import from that
  folder's `mod.sfn` rather than internal files.

## Tests

- Mirror `compiler/src/` paths under `compiler/tests/`.
- Use `unit/`, `integration/`, and `e2e/` tiers; keep test files suffixed
  `_test.sfn`.
- Keep large fixtures under `compiler/tests/**/data` or `fixtures/` and keep
  test files focused on assertions.

## Documentation Alignment

- Update `docs/status.md` first whenever behavior changes.
- Follow up with the language spec (`site/src/content/docs/docs/reference/spec/` for shipped features, `.../reference/preview/` for planned) and the [roadmap](https://sailfin.dev/roadmap) (`site/src/pages/roadmap.astro`) as needed.
- Add or adjust proposal docs under `docs/proposals/` for future work.

## Sailfin Language Style

- Spell effects explicitly: `fn foo() -> Bar ![io, model]`.
- Order effect lists by impact (most impactful first).
- Use `CamelCase` for models/capsules and `snake_case` for locals.
- Note currency or latency literals as comments until syntax lands.

### Syntax Reform (Pre-1.0)

The following syntax changes are active. See `docs/proposals/colon-type-annotations.md` and the [roadmap](https://sailfin.dev/roadmap) for rationale.

- **Type annotations**: Use `:` (colon) for parameter, variable, and struct
  field types. Function return types use `->`. The parser still accepts `->`
  in annotation positions for backward compatibility, but the in-tree codebase
  has been migrated and new code should use `:` exclusively.

  ```sfn
  fn add(x: number, y: number) -> number { return x + y; }
  let name: string = "Sailfin";
  struct User { id: number; name: string; }
  ```

- **String interpolation**: Current syntax is `{{ expr }}`. This will change to
  `${ expr }` before 1.0. Continue using `{{ }}` until the parser change lands.

- **Numeric types**: `int` and `float` will replace the single `number` type.
  Until this lands, use `number` and add comments where integer semantics matter.

## Comments and Docstrings

- Use `///` doc comments for public items; keep the first sentence a summary.
- Use inline comments only for intent or future syntax gaps.
