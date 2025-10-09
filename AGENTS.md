# Repository Guidelines

## Project Structure & Module Organization
- `bootstrap/` contains the stage0 Python compiler (lexer, parser, effect checker) with tests in `bootstrap/tests/`; treat this as the operational source of truth.
- `compiler/src/` carries the Sailfin-native front end; note design gaps here but land feature work with matching bootstrap coverage.
- `docs/` houses the spec, ENBF grammar, keywords list, and package docs—update alongside behavior changes.
- `examples/` provides runnable snippets; keep inputs minimal and exclude generated artefacts. Sibling `extensions/` and `registry/` hold auxiliary capsules and registry tooling.

## Build, Test, and Development Commands
- `make bootstrap-install` provisions or updates the `sailfin-bootstrap` Conda env defined in `bootstrap/environment.yml`.
- `make test` or `make bootstrap-test` runs the full pytest suite; pass `PYTEST_ARGS=...` to filter (e.g., `-m unit`).
- `make bootstrap-compile` emits Python modules from `compiler/src/` using the bootstrap compiler.
- `make clean` clears coverage caches under `bootstrap/` when a fresh run is needed.
- if you need to do some debugging, use the /scratch directory and run/place scripts there. for example:
    ```bash
cd /home/michael/github.com/sailfin/sailfin && /home/michael/miniconda3/bin/conda run -n sailfin-bootstrap python scratch/example_script.py
    ```

## Coding Style & Naming Conventions
- Python modules observe PEP 8 with four-space indentation, `snake_case` functions, and narrow compiler passes; share helpers instead of duplicating parsing logic.
- Sailfin files spell effects explicitly (`fn foo() -> Bar ![io, model]`), keep lists ordered by impact, and use `CamelCase` for models or capsules while locals remain `snake_case`.
- Align terminology with `docs/spec.md` (capsule, fleet, provenance card) and note currency or latency literals as comments until syntax support arrives.

## Testing Guidelines
- Tag pytest cases with `unit`, `integration`, or `e2e`; stage tests beside code in `bootstrap/tests/` and mirror intent in `compiler/tests/` when available.
- Prefer slim golden inputs in `examples/` plus targeted fixtures; avoid recording generated output.
- Run `make bootstrap-test` before submitting and capture reproduction steps for regressions.

## Commit & Pull Request Guidelines
- History mixes imperative commits and Conventional Commit prefixes; favor `feat(compiler): …`, `fix(bootstrap): …`, etc., for clarity.
- Keep commits atomic, mention touched capsules, and co-author doc changes in the same PR.
- Pull requests should summarize scope, link issues, list verification commands, and attach screenshots or trace snippets when behavior shifts.
