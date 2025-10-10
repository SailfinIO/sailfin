# Repository Guidelines

## Project Structure & Module Organization
- `bootstrap/` contains the stage0 Python compiler (lexer, parser, effect checker) with tests in `bootstrap/tests/`; treat this as the operational source of truth.
- `compiler/src/` carries the Sailfin-native front end; note design gaps here but land feature work with matching bootstrap coverage.
- `docs/` now has a navigation guide (`docs/README.md`), the canonical status matrix (`docs/status.md`), roadmap (`docs/roadmap.md`), bootstrap spec (`docs/spec.md`), grammar, and keyword references. Update the status doc first whenever behaviour changes, then adjust the spec/roadmap accordingly.
- `docs/proposals/` holds future-facing designs (e.g., package management); leave implementation notes there until the status page marks them shipped.
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
- Do not under any circumstances use  here-doc (<<'PY') commands. They WILL NOT WORK in your environment. Use scratch files instead.

## Coding Style & Naming Conventions
- Python modules observe PEP 8 with four-space indentation, `snake_case` functions, and narrow compiler passes; share helpers instead of duplicating parsing logic.
- Sailfin files spell effects explicitly (`fn foo() -> Bar ![io, model]`), keep lists ordered by impact, and use `CamelCase` for models or capsules while locals remain `snake_case`.
- Align terminology with `docs/spec.md` (capsule, fleet, provenance card) and note currency or latency literals as comments until syntax support arrives.

## Testing Guidelines
- Tag pytest cases with `unit`, `integration`, or `e2e`; stage tests beside code in `bootstrap/tests/` and mirror intent in `compiler/tests/` when available.
- Prefer slim golden inputs in `examples/` plus targeted fixtures; avoid recording generated output.
- Run `make bootstrap-test` before submitting and capture reproduction steps for regressions.
- When adding language surface or runtime behaviour, extend coverage in both the bootstrap suite and Sailfin-native tests, and reflect the change in `docs/status.md`.

## Commit & Pull Request Guidelines
- History mixes imperative commits and Conventional Commit prefixes; favor `feat(compiler): …`, `fix(bootstrap): …`, etc., for clarity.
- Keep commits atomic, mention touched capsules, and co-author doc changes in the same PR.
- Pull requests should summarize scope, link issues, list verification commands, and attach screenshots or trace snippets when behavior shifts.
