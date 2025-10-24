# Sailfin Compiler (Self-Hosting Effort)

The Sailfin-written stage1 compiler now ships as the production toolchain. The
Python bootstrap (stage0) compiler is retained only for archaeology and targeted
regression hunting, while the Sailfin sources under `compiler/src/` continue to
expand coverage and retire the final Python bridges. For the day-to-day feature
matrix, see `../docs/status.md`.

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
Remaining runtime helpers that still defer to Python are tracked in
`../docs/runtime_audit.md`.

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

These helpers will disappear as the remaining capability bridges move into
Sailfin, but they keep the workflow ergonomic in the meantime.

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

With stage1 active, the next milestone is eliminating the residual Python
dependencies so the Sailfin runtime and capability bridges are fully native.
From there we can iterate on performance, incremental compilation, richer
diagnostics, and a more expressive runtime.

Stay tuned—this is where the language begins to compile itself.

Roadmap milestones that affect this directory live in `../docs/roadmap.md`.

## Stage2 Bootstrap (LLVM Self-Hosting)

As of October 2025, Sailfin supports bootstrapping the Stage2 self-hosted compiler that compiles all compiler sources to native LLVM IR. This represents a major milestone toward full self-hosting.

### Quick Start

Bootstrap the Stage2 compiler to LLVM:

```bash
make bootstrap-stage2
```

This compiles all `compiler/src/*.sfn` and `runtime/prelude.sfn` modules using the Stage2 LLVM backend, generating `.ll` (LLVM IR) files in `build/stage2/`.

Expected output:

```
[stage2-bootstrap] starting Stage2 self-hosting compilation...
[stage2-bootstrap] compiled 16 module(s) to build/stage2
[stage2-bootstrap] ✓ Stage2 bootstrap completed successfully
```

### Linking a Stage2 binary

The Stage1 helper now exposes a Stage2 mode that bundles the generated LLVM
modules into a standalone executable (using the host `clang` toolchain). Run:

```bash
python tools/compile_with_stage1.py --stage2 --stage2-binary build/stage2/sailfin-stage2
```

By default the linker adds `-Wl,-undefined,dynamic_lookup` on macOS so unresolved
runtime helpers can be provided at load time; additional linker flags may be
supplied via repeated `--stage2-ldflag` arguments (and the compiler can be
overridden with `--stage2-clang`).

### What Gets Generated

For each source file `X.sfn`, the bootstrap process generates:

- **LLVM IR module**: `build/stage2/X.ll` — Human-readable intermediate representation that can be compiled to machine code or executed with LLVM tools

Example output:

```
build/stage2/
├── ast.ll (1.4 KB)
├── parser.ll (235 KB)
├── native_llvm_lowering.ll (479 KB)
├── main.ll (44 KB)
└── ... (16 modules total)
```

### Validation

Run tests to verify bootstrap integrity:

```bash
pytest compiler/tests/test_stage2_bootstrap.py -v
```

Tests validate:

- All expected LLVM modules are generated
- Generated IR has valid LLVM structure
- Module sizes are reasonable (not empty or corrupt)

Recent work tightened runtime safety: Stage2 array and slice indexing now emit
`sailfin_runtime_bounds_check` calls that raise `IndexError` when an index
escapes the recorded length. This matches Stage1 behaviour during self-hosted
compilation runs and removes the temporary TODO marker that only logged a
diagnostic comment.

### Current Limitations

Stage2 bootstrap currently:

- ✅ Compiles all compiler sources to LLVM IR
- ✅ Generates valid (though incomplete) LLVM modules
- ✅ Passes validation tests
- ⚠️ Linked binaries rely on dynamic lookup for runtime adapters (the `clang`
  invocation defaults to `-Wl,-undefined,dynamic_lookup` on macOS); missing adapters
  will surface at runtime
- ❌ Does not yet resolve cross-module imports
- ❌ Does not yet compile IR to native binaries
- ❌ Cannot yet replace Stage1 as the primary compiler

### Known Issues

The bootstrap process emits many warnings about unsupported Stage2 features (array indexing, some control flow patterns, etc.). These are expected and tracked in the roadmap. The compiler still generates valid LLVM IR for supported features.

### Next Steps

See the [Stage2 delivery roadmap](roadmap.md#active-workstreams-do-now) for upcoming work:

- Module linking and cross-module resolution
- Native binary generation with `llc`
- Self-hosted compiler execution and validation
- CI integration and distribution packaging
