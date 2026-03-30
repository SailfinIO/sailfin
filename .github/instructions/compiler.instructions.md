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
- Fix bugs in the compiler source, never by adding fixup passes to `scripts/selfhost_native.py`.
- Reference `docs/status.md` for current feature implementation status.
