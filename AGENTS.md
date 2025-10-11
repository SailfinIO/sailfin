# Repository Guidelines

## Project Structure & Module Organization
- `Legacy/stage0/` archives the historical Python bootstrap compiler.
- `compiler/src/` carries the Sailfin-native front end; keep feature work here and back it with stage1 coverage.
- `docs/` now has a navigation guide (`docs/README.md`), the canonical status matrix (`docs/status.md`), roadmap (`docs/roadmap.md`), bootstrap spec (`docs/spec.md`), grammar, and keyword references. Update the status doc first whenever behaviour changes, then adjust the spec/roadmap accordingly.
- `docs/proposals/` holds future-facing designs (e.g., package management); leave implementation notes there until the status page marks them shipped.
- `examples/` provides runnable snippets; keep inputs minimal and exclude generated artefacts. Sibling `extensions/` and `registry/` hold auxiliary capsules and registry tooling.

## Build, Test, and Development Commands
- `make install` provisions or updates the `sailfin` Conda env defined in `environment.yml`.
- `make test` runs the stage1 pytest suite; pass `PYTEST_ARGS=...` to filter (e.g., `-m integration`).
- `make compile` emits Python modules from `compiler/src/` using the stage1 pipeline (`compiler/build/`).
- `make clean` removes packaged artifacts (`dist/`); use `make clean-stage1` if you intentionally want to delete `compiler/build/` (requires an installed stage1 to rebuild).
- if you need to do some debugging, use the /scratch directory and run/place scripts there. for example:
    ```bash
cd /home/michael/github.com/sailfin/sailfin && /home/michael/miniconda3/bin/conda run -n sailfin python scratch/example_script.py
    ```
- Do not under any circumstances use  here-doc (<<'PY') commands. They WILL NOT WORK in your environment. Use scratch files instead.

## Coding Style & Naming Conventions
- Python modules observe PEP 8 with four-space indentation, `snake_case` functions, and narrow compiler passes; share helpers instead of duplicating parsing logic.
- Sailfin files spell effects explicitly (`fn foo() -> Bar ![io, model]`), keep lists ordered by impact, and use `CamelCase` for models or capsules while locals remain `snake_case`.
- Align terminology with `docs/spec.md` (capsule, fleet, provenance card) and note currency or latency literals as comments until syntax support arrives.

- Tag pytest cases with `unit`, `integration`, or `e2e`; stage tests beside the code in `compiler/tests/` and mirror intent in `docs/status.md` when available.
- Prefer slim golden inputs in `examples/` plus targeted fixtures; avoid recording generated output.
- Run `make test` before submitting and capture reproduction steps for regressions.
- When adding language surface or runtime behaviour, extend coverage in the Sailfin-native tests and reflect the change in `docs/status.md`.

## Commit & Pull Request Guidelines
- History mixes imperative commits and Conventional Commit prefixes; favor `feat(compiler): …`, `fix(bootstrap): …`, etc., for clarity.
- Keep commits atomic, mention touched capsules, and co-author doc changes in the same PR.
- Pull requests should summarize scope, link issues, list verification commands, and attach screenshots or trace snippets when behavior shifts.
