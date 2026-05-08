---
applyTo: "compiler/**"
---

# Compiler Instructions

When working in the compiler directory:

- The compiler is self-hosted in Sailfin (`.sfn`). All source lives in `compiler/src/`.
- Follow the pipeline order: lexer → parser → AST → type check → effect check → emit → LLVM lowering.
- Every change must preserve self-hosting: `make compile` must succeed after your edits.
- Add regression tests in `compiler/tests/` for every change.
- Spell effects explicitly: `fn foo() -> Bar ![io, model]`.
- Use `CamelCase` for types, `snake_case` for functions and locals.
- Fix bugs in the compiler source, never by adding fixup passes to the build driver. (The prior `scripts/build.sh` orchestrator was retired in Stage E PR7 / #383; the same rule applies to the driver in `compiler/src/cli_main.sfn` + `compiler/src/capsule_resolver.sfn`.)
- Reference `docs/status.md` for current feature implementation status.
