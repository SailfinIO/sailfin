# Sailfin Compiler (Self-Hosting Effort)

The long-term goal is a native, self-hosting Sailfin toolchain built entirely in Sailfin.  
The current Python bootstrap (stage0) enables experimentation; from here, we progressively re-implement each component until the compiler can produce its own runnable binary.

This directory contains the first steps of that journey. Expect rapid iteration and frequent boundary adjustments while we refine the ergonomics of a substantial Sailfin codebase.

## Architectural Sketch

1. **Front-End (Parsing + AST)**  
   - Port the bootstrap tokenizer and parser into Sailfin.  
   - Encode the high-level AST with native structs and enums so later phases are shared between the bootstrap and self-hosted builds.

2. **Semantic Analysis**  
   - Re-implement name resolution, type inference, and effect checking in Sailfin.  
   - Leverage pattern matching and the effect system to keep the implementation declarative and verifiable.

3. **Code Generation**  
   - Initially target the Python back-end (mirroring the bootstrap emitter) for quick correctness validation.  
   - Gradually introduce native back-ends: LLVM, WASM, and incremental build targets.

4. **Runtime and Tooling**  
   - Re-implement the runtime helpers used by generated code (console, scheduler, capability guards).  
   - Provide a Sailfin-native CLI wrapper `sfn` that mirrors the bootstrap UX.

## Capsule and Fleet Structure

All sources currently live under `src/` while we establish internal module boundaries.  
Once stable, we’ll introduce individual `sail.toml` manifests and organize the compiler, runtime, and tooling into **capsules** within a unified **fleet**.

Each capsule declares its kind (`lib`, `bin`, `backend`, `runtime`, or `tool`) and its allowed effects:

```toml
[package]
name = "compiler.frontend"
version = "0.1.0"
kind = "lib"

[capabilities]
allow = ["io", "clock"]

[dependencies]
"compiler.syntax" = "0.1"
"shared.diag"     = "0.1"
```

The fleet is defined by `fleet.toml`, which coordinates capsules, profiles, and reproducible build settings.

### Early Project Layout

```
compiler/
  README.md
  src/
    main.sfn        # temporary entry point
    lexer.sfn       # early-stage tokenizer
    token.sfn       # token data structures
```

The initial Sailfin sources do not yet compile independently.  
We bootstrap by compiling these `.sfn` files with the existing Python toolchain, allowing tests in Python to exercise the new Sailfin modules.

### Next Milestones

- Expand `token.sfn` and `lexer.sfn` into a fully featured scanner.
- Port the bootstrap parser into Sailfin module by module.
- Introduce Sailfin-native testing so unit tests run without Python.

### Recent Progress

- The Sailfin parser now emits structured nodes for enums, interfaces, type
   aliases, and prompt statements, preserving generics on function and method
   signatures to stay diffable with the bootstrap AST.

### Future Layout (Illustrative)

```
/sailfin
  /bootstrap             # stage0 compiler in Python
  /compiler              # self-hosting compiler in Sailfin
    /src
      lexer.sfn          # tokenizer implementation
      token.sfn          # token data structures
      parser.sfn         # (future) parser port
      ast.sfn            # (future) AST definitions
      typecheck.sfn      # (future) semantic analysis and effect checking
      emit_py.sfn        # (future) Python emitter for validation
      emit_native.sfn    # (future) native code emitter
    /runtime             # runtime helpers for compiled Sailfin code
    /tools
      /sfn               # CLI front-end for the compiler
```

## The Road Ahead

When the self-hosted compiler can emit a working binary, it becomes the new stage0, and Sailfin becomes self-sustaining.  
From there we can iterate on performance, incremental compilation, richer diagnostics, and a more expressive runtime.

Stay tuned—this is where the language begins to compile itself.
