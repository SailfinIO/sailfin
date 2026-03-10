# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Sailfin is an AI-native, systems-friendly programming language designed for precision, safety, and introspection. The repository hosts the **self-hosted native compiler** (primary toolchain), plus legacy bootstrap code kept for emergency recovery while marching toward 1.0.

**Current architecture:**

- **Native compiler (primary)**: Self-hosted compiler targeting LLVM with `.sfn-asm` intermediate representation; release artifacts install as `sailfin`/`sfn`.

Note: the codebase may still contain historical `stage2` names in internal paths; prefer “native compiler” terminology.

The runtime currently ships as C under `runtime/native/` and is planned to move into Sailfin for the 1.0 release.

The language features effect types (`![io, net, model, gpu, rand, clock]`), ownership-aware linear/affine types, capability-based security, and first-class AI constructs (models, prompts, pipelines, tools).

## Essential Commands

### Environment Setup

```bash
make env              # Create/update the 'sailfin' Conda environment
```

### Development Workflow

```bash
make compile          # Build the compiler by self-hosting from a released seed (preferred)
make install          # Install the built compiler into PREFIX/bin (default: ~/.local/bin)
make rebuild          # Force a rebuild from a released seed
make smoke            # Rebuild + run smoke tests
make rebuild-asan     # Rebuild with ASAN (diagnostic)
make check            # Compile (if needed) then run the full test suite
make test             # Run full suite
make test-unit        # Run Sailfin-native unit tests
make test-integration # Run Sailfin-native integration tests
```

### Build Artifacts

```bash
make clean            # Remove dist/ artifacts
make clean-build       # Remove build/* artifacts (keeps build/seed by default)
```

## Architecture & Key Concepts

### Compiler Pipeline (native)

The compiler (`compiler/src/`) follows this flow:

1. **Lexer** (`lexer.sfn`) → tokens
2. **Parser** (`parser.sfn`) → AST (`ast.sfn`)
3. **Type Checker** (`typecheck.sfn`) → duplicate symbols, interface conformance
4. **Effect Checker** (`effect_checker.sfn`) → validates `![effect, ...]` annotations
5. **Native Emitter** (`emit_native.sfn`) → `.sfn-asm` IR (`native_ir.sfn`)
6. **LLVM Lowering** (`compiler/src/llvm/lowering/entrypoints.sfn`) → LLVM IR

**Critical files:**

- `compiler/src/main.sfn` — Entry point orchestrating all passes
- `compiler/src/ast.sfn` — Canonical AST node definitions
- `compiler/src/native_ir.sfn` — `.sfn-asm` intermediate representation
- `runtime/prelude.sfn` — Sailfin-native runtime (collections, strings, type checks)
- `runtime/native/` — Current C runtime implementation (planned to move into Sailfin pre-1.0)

### Effect System

Functions/tests/pipelines declare required capabilities:

```sfn
fn fetch_order(id: OrderId) -> Order ![io, net] { ... }
```

**Canonical effects:** `io`, `net`, `model`, `gpu`, `rand`, `clock`

**Bootstrap enforcement** (via `effect_checker.sfn` and `bootstrap/effect_checker.py`):

- `model`: required for `prompt` blocks
- `io`: required for `print.*`, `console.*`, `fs.*`, decorators like `@logExecution`
- `net`: required for `http.*`, `websocket.*`, `serve`
- `clock`: required for `sleep`, `runtime.sleep`

Effect checking walks nested blocks, lambdas, and `routine` scopes. Missing effects emit diagnostics with source spans and fix-it hints.

### Ownership & Borrowing (Native Compiler)

Sailfin uses move-by-default semantics with explicit borrows:

- `Affine<T>`: may be dropped, not duplicated
- `Linear<T>`: must be consumed exactly once
- `&T`: shared (read-only) borrow
- `&mut T`: exclusive mutable borrow

**Bootstrap status:** Parsed but not enforced. The native LLVM backend tracks ownership metadata, rejects conflicting borrows, and flags use-after-move.

### Runtime Bridges

The runtime currently ships as C under `runtime/native/`. Higher-level integration helpers (e.g., runners) still live in Python under `runtime/`.

### Testing Philosophy

- **Unit tests**: `compiler/tests/unit/*_test.sfn`
- **Integration tests**: `compiler/tests/integration/*_test.sfn`
- **E2E tests**: `compiler/tests/e2e/*_test.sfn`

## Common Development Patterns

### Adding a Language Feature

1. Update `compiler/src/parser.sfn` to recognize new syntax
2. Add AST node(s) to `compiler/src/ast.sfn`
3. Update `compiler/src/emit_native.sfn` to emit `.sfn-asm`
4. Extend `compiler/src/llvm/lowering/` (e.g. `entrypoints.sfn`) for LLVM
5. Add regression tests to `compiler/tests/`
6. Update `docs/spec.md` (Part A if shipped, Part B if planned)
7. Update `docs/status.md` with implementation status

### Fixing Effect Checker Issues

Effect diagnostics include source spans and suggested fixes. If a function calls an effectful helper without declaring the effect:

1. Check `compiler/src/effect_checker.sfn` for the inference logic
2. Add the required effect to the function signature: `fn foo() ![io] { ... }`
3. Ensure parent callers also declare transitive effects

### Working with the Native Compiler (LLVM Backend)

Native compiler coverage lives in Sailfin-native tests under `compiler/tests/`:

```bash
make test         # Run unit + integration + e2e suites
make test-unit
make test-integration
make test-e2e
```

**Key files:**

- `compiler/src/llvm/` — LLVM IR generation (lowering, rendering, runtime helpers)
- `compiler/tests/` — Sailfin-native unit/integration/e2e suites
- `runtime/native/` — C runtime linked into the native compiler

### Running Examples

Examples in `examples/` demonstrate language features:

```bash
make compile
./sfn run examples/basics/hello-world.sfn
```

Check `examples/README.md` for capability requirements (`![io]`, `![model]`, etc.).

## Source of Truth Documents

When uncertain about feature status or semantics:

1. **`docs/status.md`** — What ships today (Stage0/1/2 breakdown)
2. **`docs/spec.md`** — Language reference (Part A: bootstrap, Part B: planned)
3. **`docs/roadmap.md`** — Active workstreams and sequencing
4. **`docs/runtime_audit.md`** — Python→Sailfin migration tracker

**Examples are bootstrap-only** unless marked with future syntax comments (e.g., `|>` pipeline operator, currency literals like `$0.05`).

## Stabilization Goals (Pre-1.0)

The project is marching toward a 1.0 release with a **pure Sailfin toolchain** — no Python, no C runtime, no downstream fixup scripts. All compiler improvements must target the compiler source code itself (`compiler/src/*.sfn`), not external workarounds.

### Current Critical Bug

The LLVM lowering of `.loop` / `.if` / `.break` control flow produces broken loop headers where every loop unconditionally enters the body with no exit condition. The bug is in `compiler/src/llvm/lowering/instructions.sfn`. This causes the seedcheck binary to hang on any operation. See `SELFHOST_STABILIZATION_PROMPT.md` for full analysis.

### Development Principles

- **Fix the compiler, not the build script.** `scripts/selfhost_native.py` has ~30 post-processing fixup passes that patch generated LLVM IR. These are technical debt. Every fix should go into the compiler source (`compiler/src/*.sfn`) so the fixup passes can be removed.
- **The seedcheck binary must be a fully functional standalone compiler.** `make check` validates that it can run `hello-world.sfn` and pass the test suite directly — no Python fallbacks, no fallback compilers.
- **Build must be fast and deterministic.** Target: under 5 minutes, zero retries. If the build needs retries, the compiler has a bug to fix.
- **Reduce complexity, don't add it.** The fixup pass count should decrease over time. Don't add new fixup passes — fix the root cause in the compiler source.

### `make check` Validation

`make check` does:
1. Builds seedcheck binary from the first-pass binary
2. Validates the seedcheck can actually run `examples/basics/hello-world.sfn` (fails if it hangs)
3. Runs the full test suite using the seedcheck binary directly (no fallbacks)

If `make check` fails, it means the compiler has a bug. Fix the compiler.

## Important Constraints

### Bootstrap Limitations

- No pipeline operator (`|>`) — use function calls
- No currency literals — use numeric literals with comments (`0.05 // USD`)
- `Affine<T>`/`Linear<T>` parsed but not enforced
- `PII<T>`/`Secret<T>` parsed but no runtime enforcement
- `model` blocks emit metadata only (no `.call()` execution)
- `prompt` blocks are parsed but don't send messages

### Bootstrap (stage1) Readiness Checklist

Before declaring a feature "shipped in Stage1":

1. Parses correctly (`compiler/src/parser.sfn`)
2. Type-checks or effect-checks (`compiler/src/typecheck.sfn`, `compiler/src/effect_checker.sfn`)
3. Emits valid `.sfn-asm` (`compiler/src/emit_native.sfn`)
4. Lowers to LLVM IR (`compiler/src/llvm/lowering/entrypoints.sfn`)
5. Has regression coverage (`compiler/tests/`)
6. Self-hosts (compiler compiles itself)
7. Documented in `docs/status.md` and `docs/spec.md` Part A

### Do Not Use Python Bootstrap (Stage0)

All development goes through the bootstrap compiler (legacy name: stage1) and the self-hosted native compiler (legacy name: stage2):

- To modify the compiler: edit `compiler/src/*.sfn`
- To run tests: `make test` (bootstraps the native compiler as needed)
- To build a native compiler: `make compile`

## Testing Guidance

### Writing Regression Tests

```sfn
// compiler/tests/unit/my_feature_test.sfn
import { parse_program } from "../../src/parser/mod";

test "parser: parses effectful fn" {
    let source = "fn foo() ![io] { print.info(\"hello\"); }";
    let program = parse_program(source);
    assert program.statements.length == 1;
}
```

### Debugging Compilation Failures

1. Isolate the failing `.sfn` source
2. Run `make compile` to see bootstrap compiler errors
3. Run `./sfn test path/to/test_file.sfn` for focused output
4. Review diagnostics for source spans and fix-it hints

### Self-Hosting Invariants

The compiler must always compile itself. Breaking changes require:

1. Implement in Sailfin (`compiler/src/*.sfn`)
2. Ensure the selfhost build still succeeds (`make compile`)
3. Ensure integration coverage still passes (`make test-integration`)

## Versioning & Releases

- **Semantic versioning:** `v0.1.1-alpha.32` (alpha branch), `v0.x.y` (main branch)
- **Version source:** `compiler/src/version.sfn:__version__` (drives `sfn --version`)
- **Release automation:** GitHub Actions + `python-semantic-release`
- **Artifacts:** `dist/` is used for packaged artifacts as part of release tooling

## Current Branch Strategy

- `main`: Stable releases (pre-1.0: breaking changes allowed)
- `alpha`: Prerelease builds with `-alpha` suffix
- Active development typically happens on feature branches merged to `alpha`

## Key Terminology

- **Capsule**: A Sailfin package with `sail.toml` manifest
- **Fleet**: Multi-capsule workspace with shared `fleet.toml` policies
- **Effect**: Capability annotation (`![io]`, `![net]`, etc.)
- **Generation card**: Provenance metadata for model calls (input hashes, cost, latency, seed)
- **Native IR**: `.sfn-asm` textual intermediate representation
- **Prelude**: Core runtime library (`runtime/prelude.sfn`)
- **Stage0/1/2**: Bootstrap (Python) / Self-hosted (Sailfin→Python) / Native (Sailfin→LLVM)
