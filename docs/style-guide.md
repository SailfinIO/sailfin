# Sailfin Style & Layout Guide
Updated: October 2025

This guide codifies the Sailfin project layout conventions referenced in
`CONTRIBUTING.md` and mirrors the expectations the bootstrap (stage0) and
Sailfin-native (stage1) compilers follow. Use it when creating new capsules,
reorganising modules, or documenting runtime surfaces so that contributors
and agents see a stable, predictable structure.

## Goals

- Keep one major concern per file (lexer, parser, emitter, etc.).
- Ensure filenames and suffixes communicate intent without opening the file.
- Centralise each domain’s public API behind a single `mod.sfn`.
- Mirror source, tests, and docs so searches and renames stay trivial.

## Repository Layout

Canonical single-capsule layout:

```
sailfin/
├─ sail.toml                    # capsule manifest
├─ src/
│  ├─ main.sfn                  # entry point; imports from submodules only
│  ├─ compiler/                 # subsystem (domain) folder
│  │  ├─ mod.sfn                # domain public surface (re-exports)
│  │  ├─ ast.types.sfn          # AST data declarations only
│  │  ├─ ast.visitors.sfn       # visitors & transforms
│  │  ├─ token.types.sfn        # token enums/structs
│  │  ├─ token.util.sfn         # token helpers (builders, EOF sentinel)
│  │  ├─ lexer.scan.sfn         # lexing logic
│  │  ├─ parser.parse.sfn       # parsing logic
│  │  ├─ parser.errors.sfn      # error types & recovery helpers
│  │  ├─ effects.rules.sfn      # effect model & validation rules
│  │  ├─ decorators.semantics.sfn # decorator interpretation
│  │  ├─ emit.sailfin.sfn       # Sailfin→Sailfin emitter
│  │  ├─ emit.python.sfn        # Sailfin→Python emitter (optional backend)
│  │  └─ codegen.core.sfn       # shared codegen utilities
│  └─ runtime/                  # runtime shims or std capsules (optional)
│     ├─ mod.sfn
│     └─ io.sfn
├─ tests/
│  ├─ compiler/
│  │  ├─ lexer.scan.spec.sfn
│  │  ├─ parser.parse.spec.sfn
│  │  ├─ effects.rules.spec.sfn
│  │  └─ emit.sailfin.spec.sfn
├─ docs/
│  ├─ style-guide.md            # this document
│  └─ compiler-architecture.md  # high-level overview (roadmap item)
├─ examples/
│  └─ hello_world/
│     └─ main.sfn
```

When expanding beyond a single capsule, group related domains (e.g.
`runtime/`, `registry/`, `std/`) as siblings under `src/` and give each its
own `mod.sfn`.

## File Naming Conventions

| Suffix          | Purpose                              | Example                    |
|-----------------|--------------------------------------|----------------------------|
| `*.types.sfn`   | Data declarations only               | `ast.types.sfn`            |
| `*.visitors.sfn`| Traversal helpers on the types       | `ast.visitors.sfn`         |
| `*.util.sfn`    | Pure helpers for related types       | `token.util.sfn`           |
| `*.scan.sfn`    | Lexing / scanners                    | `lexer.scan.sfn`           |
| `*.parse.sfn`   | Parsing logic                        | `parser.parse.sfn`         |
| `*.errors.sfn`  | Error types & formatting             | `parser.errors.sfn`        |
| `*.semantics.sfn` | Semantic extraction from syntax    | `decorators.semantics.sfn` |
| `*.rules.sfn`   | Validation and effect rules          | `effects.rules.sfn`        |
| `emit.*.sfn`    | Emitters per backend                 | `emit.python.sfn`          |
| `*.core.sfn`    | Cross-cutting utilities for a domain | `codegen.core.sfn`         |
| `mod.sfn`       | Folder public surface (re-exports)   | `compiler/mod.sfn`         |
| `*.spec.sfn`    | Tests mirroring source filenames     | `parser.parse.spec.sfn`    |

Rule of thumb: data-only declarations live in `*.types.sfn`. Code that mutates
state or performs computation resides in a separate file with the appropriate
suffix.

## Module APIs (`mod.sfn`)

Each domain exposes a single `mod.sfn` that re-exports the “safe” public API so
consumers and refactors have one stable import path:

```sfn
// src/compiler/mod.sfn
// region: public-api
export {
    Program,
    Statement,
    Expression,
    Token,
    TokenKind,
} from "./ast.types";

export { eof_token } from "./token.util";

export { lex } from "./lexer.scan";
export { parse_program } from "./parser.parse";
export { analyze_effects } from "./effects.rules";
export { emit_program as emit_sailfin } from "./emit.sailfin";
export { emit_program as emit_python } from "./emit.python";
// endregion
```

Outside the domain, import only from the corresponding `mod.sfn`:

```sfn
import { parse_program, emit_sailfin } from "./compiler/mod";
```

## Source File Organisation

- Start with a short header comment describing the file’s role.
- Place exports near the top; public routines precede internal helpers.
- Group related sections with lightweight regions for agent editing:

  ```sfn
  // region: helpers
  fn is_whitespace(ch -> string) -> boolean { ... }
  // endregion
  ```

- Define small helper structs/enums locally when they are private to the file.
- Keep internal helper functions at the bottom to preserve top-down read flow.

## Imports

- Use relative paths (`./`) within a domain to reference sibling files.
- When crossing domain boundaries, import exclusively via the domain’s
  `mod.sfn` to keep internal filenames free to move.
- Keep effect vocabularies and decorator metadata centralised; do not duplicate
  constant strings or type aliases across files.

## Testing Layout

- Mirror filenames between `src/` and `tests/`. For example,
  `src/compiler/parser.parse.sfn` pairs with
  `tests/compiler/parser.parse.spec.sfn`.
- Tests should import through the domain `mod.sfn` where possible.
- Prefer table-driven tests—declare a `Case { name, input, expected }[]` and
  iterate—so new cases are agent-friendly.
- Store large golden inputs/outputs under `tests/fixtures/` and keep the spec
  files focused on assertions.

## Documentation Alignment

- Update `docs/status.md` first whenever behaviour changes.
- Keep this guide in sync with active repos (bootstrap vs. self-hosted) and
  note stage-specific differences inline when needed.
- Host subsystem explainers (e.g. compiler architecture) in dedicated docs
  under `docs/` and cross-link them from `README.md` entries.
- Avoid duplicating manifest or capability guidance; defer to `docs/spec.md`
  and `docs/roadmap.md` for language surface area.

## Effects and Decorators

- Centralise recognised effect names in `effects.rules.sfn`. Export a single
  `KNOWN_EFFECTS` (or equivalent) array and helpers for validation.
- Parse and interpret decorators in `decorators.semantics.sfn`; downstream
  phases should consume typed decorator metadata rather than raw syntax.
- When capability manifests grow, introduce `capabilities.types.sfn` and
  `capabilities.rules.sfn` instead of scattering capability checks.

## Comments and Docstrings

- Use triple-slash (`///`) doc comments for public items. The first sentence
  becomes the summary; subsequent paragraphs can call out invariants.
- Include runnable snippets under an `/// Examples:` block so agents can lift
  them directly into tests or documentation.
- Inline comments should clarify intent or future syntax gaps—avoid restating
  obvious operations.

## Migration Notes for the Current Compiler

The existing stage0 files map cleanly onto this layout:

- `ast.sfn` → `src/compiler/ast.types.sfn`
- `token.sfn` → `src/compiler/token.types.sfn`
- `lexer.sfn` → `src/compiler/lexer.scan.sfn`
- `parser.sfn` → `src/compiler/parser.parse.sfn`
- `effect_checker.sfn` → `src/compiler/effects.rules.sfn`
- `decorator_semantics.sfn` → `src/compiler/decorators.semantics.sfn`
- `emitter_sailfin.sfn` → `src/compiler/emit.sailfin.sfn`
- `native_lowering.sfn` (with `emit_native.sfn`) → `src/compiler/emit.python.sfn`
  or `src/compiler/codegen.core.sfn` depending on the contents
- Add `src/compiler/mod.sfn` to re-export the public surface

Follow the same mapping for the Sailfin-native compiler sources under
`compiler/src/` once bootstrap and self-hosted parity lands.

