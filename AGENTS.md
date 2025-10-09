# Repository Guidelines

## Sailfin Snapshot
- Sailfin is an AI-native language; stage0 in `bootstrap/` records effect lists (`![io, model, net, gpu, rand, clock]`) while strict enforcement remains planned for the Sailfin compiler in `compiler/src/`.
- Models follow `model Name : Model<Input, Output> { ... }`, emit provenance cards, and must show money as numerics with comments (e.g., `0.05 // USD`); examples use `print.info(...)`, and `assert(expr);` plus `is` operate as runtime guards today.

## Project Structure & Source of Truth
- `bootstrap/` holds parser, lexer, AST, code generator, runtime helpers, and tests in `bootstrap/tests/`; verify behavior here before adjusting docs.
- `compiler/src/` mirrors those components in Sailfin; flag gaps as “planned/self-hosted” instead of implying current support.
- Canonical references live in `docs/spec.md` (semantics), `docs/enbf.md` (grammar), `docs/keywords.md`, and `docs/package-management.md`; keep updates synchronized.
- `examples/` provides runnable snippets; omit generated outputs from version control.

## Build, Test, and Development Commands
- `make bootstrap-install` creates or updates the `sailfin-bootstrap` Conda environment (Python 3.13 by default).
- `make bootstrap-test` runs the full pytest suite (set `PYTEST_ARGS=-m unit`, `-m integration`, etc. to filter).
- `make bootstrap-test-unit` / `make bootstrap-test-integration` provide marker shortcuts.
- `conda run -n sailfin-bootstrap python bootstrap/bootstrap.py path/to/file.sfn` compiles Sailfin sources and writes `bootstrap/output.py`.
- `conda run -n sailfin-bootstrap pyinstaller --onefile --name sfn bootstrap/bootstrap.py` builds the CLI into `bootstrap/dist/`.
- When invoking `conda run` directly, call it from the repository root; the Makefile handles the environment selection automatically.

## Coding Style & Language Conventions
- Python code follows PEP 8 with four-space indentation, `snake_case`, and small, testable compiler phases.
- Sailfin modules stay single-purpose (`lexer.sfn`, `token.sfn`), avoid deprecated array sugar (`Vec<Type>`), align effect lists with operations, and use project terminology (`capsule`, `fleet`, `sail.toml`, `fleet.toml`).

## Testing Guidelines
- Tag tests with markers (`unit`, `integration`, `e2e`), add regression coverage for parser/effect/codegen changes, and reuse helpers in `bootstrap/tests/conftest.py` to satisfy coverage.

## Ground Rules & Change Workflow
- Source of truth order: implementation in `bootstrap/`, semantics in `docs/spec.md`, grammar in `docs/enbf.md`, keywords in `docs/keywords.md`; cite them in changes.
- If stage0 lacks a feature (capability policies, full type inference, strict effect checks), label it “planned/self-hosted,” ensure examples match the parsed grammar, align effects with operations, and keep identifiers free of reserved keywords.

## Commit & PR Checklist
- Use Conventional Commits (`docs(spec): …`, `feat(parser): …`) with atomic scope and passing tests.
- In PR descriptions, list verification steps (`conda run -n sailfin-bootstrap pytest`, manual runs) and confirm bootstrap support, `print.info`, aligned effects, consistent terminology, synchronized references, and no generated artifacts.
