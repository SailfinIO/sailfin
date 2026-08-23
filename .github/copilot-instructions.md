# GitHub Copilot Instructions for Sailfin

## Project Overview

Sailfin is a compiled systems language with effect type annotations for capabilities. Every function declares what it can do (IO, network, clock, etc.); effect annotations are supported today, while full enforcement (compilation gating) is the top priority on the roadmap. The language targets LLVM, produces native single-binary executables, and is designed so that code capabilities are verifiable at compile time.

**Primary toolchain:** The self-hosted native compiler (`compiler/src/` plus `compiler/capsules/`) targeting LLVM via a `.sfn-asm` intermediate representation. Release artifacts install as `sailfin`/`sfn`.

> Note: the codebase may still contain historical `stage2` names in some internal paths; prefer "native compiler" terminology in new code and docs.

The runtime is fully Sailfin-owned: `runtime/native/` is deleted (#822); the runtime capsule root is `runtime/` (manifest at `runtime/capsule.toml`), with Sailfin sources under `runtime/sfn/` and `runtime/prelude.sfn`.

Key language features:

- Effect types (`![io, net, model, gpu, rand, clock]`) — the core differentiator
- Capability-based security via capsule manifests
- Self-hosted compiler targeting LLVM
- Pragmatic TypeScript/Rust-like syntax

Deferred features (parsed but not enforced, post-1.0):
- Ownership types (`Affine<T>`, `Linear<T>`)
- Taint tracking (`PII<T>`, `Secret<T>`)
- AI constructs (`model`/`prompt`/`tool`/`pipeline`) — migrating to `sfn/ai` library capsule

## Repository Layout

| Path | Purpose |
|---|---|
| `compiler/src/`, `compiler/capsules/` | Self-hosted native compiler sources (`.sfn`) |
| `compiler/tests/` | Unit, integration, and e2e test suites |
| `runtime/` | Runtime capsule root (manifest: `runtime/capsule.toml`; Sailfin sources: `runtime/sfn/`, `runtime/prelude.sfn`) |
| `runtime/prelude.sfn` | Sailfin-native runtime (collections, strings, type checks) |
| `docs/` | Spec, status matrix, roadmap, grammar, keyword references |
| `docs/proposals/` | Future-facing designs (leave here until status page marks them shipped) |
| `examples/` | Minimal golden inputs demonstrating language features |

## Build, Test, and Development Commands

```bash
sfn check <files>     # Fast static analysis (parse + typecheck + effect-check) — the inner loop
sfn dev bootstrap build         # Build the compiler by self-hosting from a released seed
sfn dev bootstrap build --force # Rebuild even when the source fingerprint is unchanged
sfn dev verify                  # Triple-pass self-host validation + full test suite
sfn test                        # Run workspace tests
sfn test compiler/tests/unit    # Run Sailfin-native unit tests
sfn test compiler/tests/integration # Run Sailfin-native integration tests
sfn dev clean dist              # Remove dist/ artifacts
sfn dev clean build             # Remove build/* artifacts; keep the seed by default
sfn dev clean all --dry-run     # Preview cleaning build/ and dist/
```

System installation writes outside the repository and is not an agent-default
workflow.

Use the validation ladder consistently: `sfn check <files>` for the fast
parse/type/effect loop; `sfn dev bootstrap build` for compiler self-hosting;
targeted `build/bin/sfn test <path>` / `-k <name>` for issue acceptance; and
`sfn dev verify` only for shipped, release, structural, or otherwise high-risk
work. Run `sfn dev clean build` before rebuilding after structural compiler
changes.

For debugging, place scripts in `/scratch`.

## Compiler Pipeline

The compiler in `compiler/src/` and `compiler/capsules/` follows this flow:

1. **Lexer** (`lexer.sfn`) → tokens
2. **Parser** (`parser.sfn`) → AST (`ast.sfn`)
3. **Type Checker** (`typecheck/`) → duplicate symbols, interface conformance
4. **Effect Checker** (`effect_checker.sfn`) → validates `![effect, ...]` annotations
5. **Native Emitter** (`emit_native.sfn`) → `.sfn-asm` IR (`native_ir.sfn`)
6. **LLVM Lowering** (`compiler/capsules/codegen-llvm/src/lowering/entrypoints.sfn`) → LLVM IR

Critical files:

- `compiler/src/main.sfn` — Entry point orchestrating all passes
- `compiler/capsules/syntax/src/ast.sfn` — Canonical AST node definitions
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

`docs/style-guide.md` is the single source of truth for coding conventions. Headline rules:

- **Formatting:** `sfn fmt --write` then `sfn fmt --check` on every touched `.sfn` file; never hand-tune what the formatter owns.
- **Naming:** `snake_case` functions/locals/files, `PascalCase` types and enum variants, `_underscore` module-private helpers, `SCREAMING_SNAKE_CASE` module-level constants.
- **Effects:** spelled explicitly and listed alphabetically — `![io, net]`, never `![net, io]`.
- **Comments:** `//` only, explain *why* not *what*, cite issues/SFEPs (`(#1234)`, `SFEP-0027`) — no `TODO`s, no commented-out code, no "this commit"/"this PR" language.
- Align terminology with the language spec at `site/src/content/docs/docs/reference/spec/` (capsule, fleet, provenance card).

## Adding a Language Feature

1. Update `compiler/capsules/syntax/src/parser/mod.sfn` to recognize new syntax
2. Add AST node(s) to `compiler/capsules/syntax/src/ast.sfn`
3. Update `compiler/capsules/codegen/src/emit_native.sfn` to emit `.sfn-asm`
4. Extend `compiler/capsules/codegen-llvm/src/lowering/entrypoints.sfn` for LLVM
5. Add regression tests to `compiler/tests/`
6. Update the language spec: `site/src/content/docs/docs/reference/spec/NN-*.md` chapter if shipped, `.../reference/preview/*.md` page if planned
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

While iterating, run `sfn check <the-files-you-touched>` for immediate parse / typecheck / effect-check feedback (seconds, no rebuild). Run targeted `sfn test <path>` coverage before submitting; reserve the full workspace `sfn test` and `sfn dev verify` for explicit full-gate or high-risk work. `sfn check` is a fast static lint, not a self-host gate — it does not replace `sfn dev bootstrap build` when compiler sources change.

## Documentation

Update documents in this order when behaviour changes:

1. `docs/status.md` — keep the feature matrix authoritative
2. Language spec — `site/src/content/docs/docs/reference/spec/NN-*.md` for shipped features, `.../reference/preview/*.md` for planned
3. `site/src/pages/roadmap.astro` — adjust the [roadmap](https://sailfin.dev/roadmap) for sequencing changes
4. Relevant folder `README` (`compiler/README.md`, `runtime/README.md`, etc.)

## Commit & Pull Request Guidelines

- Use Conventional Commit prefixes: `feat(compiler): …`, `fix(bootstrap): …`, etc.
- PR titles completing a Linear leaf append the issue id: `feat(compiler): … (SFN-NNN)` so `SFN-NNN` is visible in the PR list (omit the suffix only when there's no backing issue; see `docs/conventions/issue-naming.md` § 1); the body still carries `Fixes SFN-NNN`.
- Keep commits atomic; mention touched capsules; co-author doc changes in the same PR.
- PRs must include: scope summary, exact verification commands (`sfn test <path>` for targeted runs), and notes on doc updates.
- Releases are manually triggered via `.github/workflows/release.yml` (pure bash) — use `fix:` or `feat:` prefixes in commit messages.

## Source of Truth Documents

| Document | Purpose |
|---|---|
| `docs/status.md` | What ships today (Stage0/1/2 breakdown) |
| `site/src/content/docs/docs/reference/spec/` | Language reference, chapter files §1–§11 (current language); `.../reference/preview/` holds planned features |
| [sailfin.dev/roadmap](https://sailfin.dev/roadmap) | Active workstreams and sequencing (source: `site/src/pages/roadmap.astro`) |
| `docs/status.md` (Runtime Migration table) | C→Sailfin migration tracker |

## Important Constraints

**Bootstrap limitations (do not use in new code without a comment):**

- No pipeline operator (`|>`) — use function calls
- No currency literals — use numeric literals with a `// USD` comment
- `Affine<T>`/`Linear<T>` parsed but not enforced
- `PII<T>`/`Secret<T>` parsed but no runtime enforcement
- `model` blocks emit metadata only (no `.call()` execution)
- `prompt` blocks are parsed but do not send messages

**Self-hosting invariant:** the compiler must always compile itself. Breaking changes require:

1. Implement in Sailfin (`compiler/src/` or `compiler/capsules/`)
2. Verify selfhost build (`sfn dev bootstrap build`)
3. Verify integration coverage (`sfn test compiler/tests/integration`)

**Do not use the Python bootstrap (Stage0)** — all new development goes through the self-hosted native compiler.

## Key Terminology

| Term | Meaning |
|---|---|
| Capsule | A Sailfin package with `capsule.toml` manifest |
| Workspace | Multi-capsule project with shared `workspace.toml` policies |
| Effect | Capability annotation (`![io]`, `![net]`, etc.) — the language's core differentiator |
| Native IR | `.sfn-asm` textual intermediate representation |
| Prelude | Core runtime library (`runtime/prelude.sfn`) |
