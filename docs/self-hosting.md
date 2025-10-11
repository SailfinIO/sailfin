# Sailfin Compiler (Self-Hosting Effort)

The long-term goal is a native, self-hosting Sailfin toolchain built entirely in
Sailfin. The Python bootstrap (stage0) compiler remains the production path; the
files under `compiler/src/` mirror its behaviour so we can transition when the
Sailfin implementation is complete. For an up-to-date snapshot of supported
features, see `../docs/status.md`.

## Current Capabilities

- **Lexer & tokens** — `token.sfn`, `lexer.sfn` replicate the bootstrap token
  stream for identifiers, literals, decorators, and prompts.
- **AST definitions** — `ast.sfn` models structs, enums, functions, prompts,
  and effect metadata so higher passes align with stage0.
- **Parser** — `parser.sfn` parses top-level declarations, parameter lists,
  decorators, and prompt statements, recording block tokens for later analysis.
- **Decorator semantics** — `decorator_semantics.sfn` interprets decorators and
  infers `io` when `@trace` appears.
- **Effect checker** — `effect_checker.sfn` scans blocks for prompts and known
  runtime helpers, reporting missing effects.
- **Semantic analysis** — `typecheck.sfn` now walks top-level and scoped blocks,
  enforcing duplicate checks across globals, parameters, and locals while
  plumbing diagnostics back through `compile_to_sailfin`.
- **Emitters** — `emitter_sailfin.sfn` reprints parsed programs back into
  canonical Sailfin while `emit_native.sfn` plus `native_lowering.sfn` produce
  executable Python scaffolding (with `native_llvm_lowering.sfn` sketching the
  future LLVM backend).
- **Runtime prelude** — `runtime/prelude.sfn` forwards bootstrap runtime calls
  so generated Sailfin code can execute today.

Unit tests now live under `compiler/tests/`; they bootstrap the Sailfin
compiler into an isolated directory and exercise the entire stage1 pipeline.

## Workflow with the Bootstrap Toolchain

While we are still leaning on the Python toolchain, you can materialise the
generated Python modules for the Sailfin sources with:

```bash
conda run -n sailfin-bootstrap python -m bootstrap.compile_self_host
```

The command writes `.py` files under `compiler/build/`, mirroring the structure
of `compiler/src/`. Point it at individual files or directories to iterate on a
subset:

```bash
conda run -n sailfin-bootstrap python -m bootstrap.compile_self_host compiler/src/parser.sfn
```

These helpers will disappear once the Sailfin-based backend is ready, but they
keep the workflow ergonomic in the meantime.

### Sailfin-to-Sailfin Round-Tripping

`compiler/src/main.sfn` now exposes `compile_to_sailfin(source)` which parses
Sailfin input with the native parser, runs the typechecker, and re-emits
canonical Sailfin using the new emitter. Diagnostics are surfaced through the
bootstrap toolchain whenever duplicate declarations are encountered. The output
includes imports from `sailfin/runtime`, which is backed by the stub runtime
prelude. As we expand the runtime surface we can swap these stubs for fully
effect-aware implementations while keeping the round-trip contract stable.

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

Roadmap milestones that affect this directory live in `../docs/roadmap.md`.
