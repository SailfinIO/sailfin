# Sailfin Compiler (Self-Hosting Effort)

The long-term goal for Sailfin is a native, self-hosting toolchain written in
Sailfin itself. The Python bootstrap has carried us far enough to comfortable
experimentation; from here on we can gradually re-implement the compiler in its
own language and use the bootstrap as the stage0 builder until the new compiler
can generate a runnable binary.

This directory captures the first steps of that effort. Expect rapid iteration
and frequent renegotiation of module boundaries while we figure out the
ergonomics of a sizable Sailfin code base. Everything lives under `src/` for
now; once the layout stabilises we can introduce a `sail.json` package manifest
and split the compiler, runtime, and tooling into crates.

## Architectural Sketch

1. **Front-end (parsing + AST)**
   - Port the bootstrap tokeniser and parser into Sailfin.
   - Encode the high-level AST using native structs/enums so later phases can be
     shared between the bootstrap and the self-hosting version.
2. **Semantic analysis**
   - Rebuild name resolution, effect checking, and type analysis in Sailfin.
   - Leverage the language’s pattern matching and effect system to keep the
     implementation declarative.
3. **Code generation**
   - Initially target a Python back-end (matching the bootstrap emitter) so we
     can validate correctness quickly.
   - Long term we will add a native LLVM back-end plus incremental builds.
4. **Runtime + tooling**
   - Re-implement the small runtime helpers used by generated code (console,
     task scheduling, capability guards).
   - Provide a CLI wrapper (`sfn`) that mirrors the bootstrap UX.

## Project Scaffolding

```
compiler/
  README.md            # This document
  src/
    main.sfn           # Temporary entry point while we wire up modules
    lexer.sfn          # Early-stage tokenizer sketch
    token.sfn          # Token data structures shared across the front-end
```

The initial Sailfin sources do *not* compile the full language yet. Instead we
bootstrap by compiling these `.sfn` files with the existing Python toolchain,
allowing us to write tests in Python that exercise the new Sailfin modules.

Over the next few iterations we will:

- Flesh out `token.sfn` and `lexer.sfn` into a fully featured scanner.
- Port the bootstrap parser into Sailfin, module by module.
- Introduce a Sailfin-native testing story so we can run unit tests without
  round-tripping through Python.

Stay tuned – this is the fun part where the language starts compiling itself.
