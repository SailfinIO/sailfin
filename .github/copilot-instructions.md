# GitHub Copilot Instructions for Sailfin

## Project Overview

Sailfin is an AI-native, systems-friendly programming language designed for precision, safety, and introspection. Its type system unifies deterministic computation, effect isolation, and capability-aware security to make large-scale model-driven software reliable by default.

**Primary toolchain:** The self-hosted native compiler (`compiler/src/`) targeting LLVM via a `.sfn-asm` intermediate representation. Release artifacts install as `sailfin`/`sfn`.

> Note: the codebase may still contain historical `stage2` names in some internal paths; prefer "native compiler" terminology in new code and docs.

The runtime currently ships as C under `runtime/native/` and is planned to move into Sailfin before the 1.0 release.

Key language features:

- Effect types (`![io, net, model, gpu, rand, clock]`)
- Ownership-aware linear/affine types
- Capability-based security
- First-class AI constructs (models, prompts, pipelines, tools)

## Repository Layout

| Path | Purpose |
|---|---|
| `compiler/src/` | Self-hosted native compiler sources (`.sfn`) |
| `compiler/tests/` | Unit, integration, and e2e test suites |
| `runtime/native/` | C runtime implementation |
| `runtime/prelude.sfn` | Sailfin-native runtime (collections, strings, type checks) |
| `docs/` | Spec, status matrix, roadmap, grammar, keyword references |
| `docs/proposals/` | Future-facing designs (leave here until status page marks them shipped) |
| `examples/` | Minimal golden inputs demonstrating language features |

## Build, Test, and Development Commands

```bash
make compile          # Build the compiler by self-hosting from a released seed (preferred)
make install          # Install the built compiler into PREFIX/bin (default: /usr/local/bin)
make rebuild          # Force a rebuild from a released seed
make check            # Compile (if needed) then run the full test suite
make test             # Run unit + integration + e2e suites
make test-unit        # Run Sailfin-native unit tests
make test-integration # Run Sailfin-native integration tests
make clean            # Remove dist/ artifacts
make clean-build      # Remove build/* artifacts (keeps build/seed by default)
```

For debugging, place scripts in `/scratch`.

## Compiler Pipeline

The compiler in `compiler/src/` follows this flow:

1. **Lexer** (`lexer.sfn`) → tokens
2. **Parser** (`parser.sfn`) → AST (`ast.sfn`)
3. **Type Checker** (`typecheck.sfn`) → duplicate symbols, interface conformance
4. **Effect Checker** (`effect_checker.sfn`) → validates `![effect, ...]` annotations
5. **Native Emitter** (`emit_native.sfn`) → `.sfn-asm` IR (`native_ir.sfn`)
6. **LLVM Lowering** (`compiler/src/llvm/lowering/entrypoints.sfn`) → LLVM IR

Critical files:

- `compiler/src/main.sfn` — Entry point orchestrating all passes
- `compiler/src/ast.sfn` — Canonical AST node definitions
- `compiler/src/native_ir.sfn` — `.sfn-asm` intermediate representation

## Effect System

Functions, tests, and pipelines declare required capabilities:

```sfn
fn fetch_order(id: OrderId) -> Order ![io, net] { ... }
```

Canonical effects: `io`, `net`, `model`, `gpu`, `rand`, `clock`

Bootstrap enforcement rules:

- `model` — required for `prompt` blocks
- `io` — required for `print.*`, `console.*`, `fs.*`, `@logExecution`
- `net` — required for `http.*`, `websocket.*`, `serve`
- `clock` — required for `sleep`, `runtime.sleep`

Effect checking walks nested blocks, lambdas, and `routine` scopes. Missing effects emit diagnostics with source spans and fix-it hints.

## Coding Style & Naming Conventions

- **Python:** PEP 8, four-space indentation, `snake_case` functions, narrow passes; share helpers instead of duplicating parsing logic.
- **Sailfin (`.sfn`):** Spell effects explicitly, keep effect lists ordered by impact, `CamelCase` for models/capsules, `snake_case` for locals, annotate future syntax as comments until the compiler supports it.
- Align terminology with `docs/spec.md` (capsule, fleet, provenance card).

## Adding a Language Feature

1. Update `compiler/src/parser.sfn` to recognize new syntax
2. Add AST node(s) to `compiler/src/ast.sfn`
3. Update `compiler/src/emit_native.sfn` to emit `.sfn-asm`
4. Extend `compiler/src/llvm/lowering/entrypoints.sfn` for LLVM
5. Add regression tests to `compiler/tests/`
6. Update `docs/spec.md` (Part A if shipped, Part B if planned)
7. Update `docs/status.md` with implementation status

## Testing

- **Unit tests:** `compiler/tests/unit/*_test.sfn`
- **Integration tests:** `compiler/tests/integration/*_test.sfn`
- **E2E tests:** `compiler/tests/e2e/*_test.sfn`

Example test:

```sfn
// compiler/tests/unit/my_feature_test.sfn
import { parse_program } from "../../src/parser/mod";

test "parser: parses effectful fn" {
    let source = "fn foo() ![io] { print.info(\"hello\"); }";
    let program = parse_program(source);
    assert program.statements.length == 1;
}
```

Run `make test` before submitting and capture reproduction steps for regressions.

## Documentation

Update documents in this order when behaviour changes:

1. `docs/status.md` — keep the feature matrix authoritative
2. `docs/spec.md` — sync bootstrap reference (Part A shipped, Part B planned)
3. `site/src/pages/roadmap.astro` — adjust the [roadmap](https://sailfin.dev/roadmap) for sequencing changes
4. Relevant folder `README` (`compiler/README.md`, `runtime/README.md`, etc.)

## Commit & Pull Request Guidelines

- Use Conventional Commit prefixes: `feat(compiler): …`, `fix(bootstrap): …`, etc.
- Keep commits atomic; mention touched capsules; co-author doc changes in the same PR.
- PRs must include: scope summary, verification commands (`make test`, targeted runs), and notes on doc updates.
- Releases are manually triggered via `.github/workflows/release.yml` (pure bash) — use `fix:` or `feat:` prefixes in commit messages.

## Source of Truth Documents

| Document | Purpose |
|---|---|
| `docs/status.md` | What ships today (Stage0/1/2 breakdown) |
| `docs/spec.md` | Language reference (Part A: bootstrap, Part B: planned) |
| [sailfin.dev/roadmap](https://sailfin.dev/roadmap) | Active workstreams and sequencing (source: `site/src/pages/roadmap.astro`) |
| `docs/runtime_audit.md` | Python→Sailfin migration tracker |

## Important Constraints

**Bootstrap limitations (do not use in new code without a comment):**

- No pipeline operator (`|>`) — use function calls
- No currency literals — use numeric literals with a `// USD` comment
- `Affine<T>`/`Linear<T>` parsed but not enforced
- `PII<T>`/`Secret<T>` parsed but no runtime enforcement
- `model` blocks emit metadata only (no `.call()` execution)
- `prompt` blocks are parsed but do not send messages

**Self-hosting invariant:** the compiler must always compile itself. Breaking changes require:

1. Implement in Sailfin (`compiler/src/*.sfn`)
2. Verify selfhost build (`make compile`)
3. Verify integration coverage (`make test-integration`)

**Do not use the Python bootstrap (Stage0)** — all new development goes through the self-hosted native compiler.

## Key Terminology

| Term | Meaning |
|---|---|
| Capsule | A Sailfin package with `sail.toml` manifest |
| Fleet | Multi-capsule workspace with shared `fleet.toml` policies |
| Effect | Capability annotation (`![io]`, `![net]`, etc.) |
| Generation card | Provenance metadata for model calls (input hashes, cost, latency, seed) |
| Native IR | `.sfn-asm` textual intermediate representation |
| Prelude | Core runtime library (`runtime/prelude.sfn`) |
| Stage0/1/2 | Bootstrap (Python) / Self-hosted (Sailfin→Python) / Native (Sailfin→LLVM) |
