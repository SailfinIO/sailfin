---
applyTo: "compiler/**"
---

# Compiler Instructions

When working in the compiler directory:

- The compiler is self-hosted in Sailfin (`.sfn`). All source lives in `compiler/src/`.
- Follow the pipeline order: lexer → parser → AST → type check → effect check → emit → LLVM lowering.
- Every change must preserve self-hosting: `make compile` must succeed after your edits.
- Add regression tests in `compiler/tests/` for every change.
- Spell effects explicitly and list them alphabetically: `fn foo() -> Bar ![io, model]`.
- Coding conventions (naming, comments, error handling, file-size budgets) are defined in `docs/style-guide.md` — follow it; `PascalCase` types, `snake_case` functions/locals, `_underscore` private helpers.
- Fix bugs in the compiler source, never by adding fixup passes to the build driver. (The prior `scripts/build.sh` orchestrator was retired in Stage E PR7 / #383; the same rule applies to the driver in `compiler/src/cli_main.sfn` + `compiler/src/capsule_resolver.sfn`.)
- Reference `docs/status.md` for current feature implementation status.
