# Contributing to Sailfin

Thank you for helping shape Sailfin. This guide covers the workflow, testing
expectations, and documentation process for contributions to the pre-release
repository.

## 1. Getting Started

- See `README.md` for a project overview and `docs/README.md` for the doc
  navigation map.
- Review `docs/status.md` to understand which features are implemented in the
  Python bootstrap compiler (stage0) versus the Sailfin-native prototypes.
- Familiarise yourself with `docs/style-guide.md` for Sailfin module layout,
  file naming, and doc/test mirroring conventions.
- Ensure you have the `sailfin-bootstrap` Conda environment:

  ```bash
  make bootstrap-install
  ```

## 2. Coding Workflow

1. **Branch & scope** — Keep work focused; reference open issues or roadmap
   items when possible.
2. **Development commands**
   - Run tests: `make bootstrap-test` (use `PYTEST_ARGS=-m unit` or
     `-m integration` to scope).
   - Compile Sailfin sources: `make bootstrap-compile`.
3. **Testing expectations**
   - Add or update unit tests under `bootstrap/tests/` for stage0 changes.
   - Mirror semantics in Sailfin-native tests when relevant
     (`compiler/src/**`, `bootstrap/tests/test_compiler_sources.py`).
   - Run `make bootstrap-test` before submitting.

## 3. Documentation Process

When behaviour, coverage, or roadmap status changes:

1. Update `docs/status.md` first — keep the feature matrix authoritative.
2. Sync `docs/spec.md` (bootstrap reference) and note new design work in the
   Part B preview if needed.
3. Adjust `docs/roadmap.md` for sequencing changes.
4. Touch the relevant folder README (e.g., `bootstrap/README.md`,
   `compiler/README.md`, `examples/README.md`) so local guidance stays accurate.
5. For future-facing designs, add or amend proposals under `docs/proposals/`.

Please reference the updated documents in your pull request description.

## 4. Commit & Review Style

- Use clear, atomic commits. Conventional prefixes (`feat(compiler):`, `fix(bootstrap):`)
  are encouraged but not mandatory.
- Document how you validated the change (commands, tests, screenshots).
- When behaviour shifts, include reproduction steps and link to the relevant
  roadmap/status entries.

## 5. Pull Requests

Each PR should include:

- Summary of the change and impacted areas.
- Verification commands (`make bootstrap-test`, targeted pytest runs, etc.).
- Notes on documentation updates (status/spec/roadmap).

Reviewers will check for:

- Test coverage and passing CI.
- Alignment with docs/status and roadmap.
- Clear rollback path if needed.

## 6. Code Style

- Python: PEP 8, four-space indentation, prefer shared helpers in bootstrap
  compiler modules.
- Sailfin (`.sfn`): explicit effect lists, `CamelCase` for models/capsules,
  `snake_case` locals, and comment future syntax when used for illustration.
  Follow the module and file conventions in `docs/style-guide.md` (one concern
  per file, `mod.sfn` re-exports, mirrored `*.spec.sfn` tests).
- Examples: keep inputs minimal, avoid generated artefacts, and annotate
  future-only constructs.

## 7. Questions & Help

For questions about design direction or roadmap priorities, start with
`docs/status.md` and `docs/roadmap.md`. If additional context is required, open
an issue referencing the relevant section or proposal.

Welcome aboard, and thanks for advancing Sailfin! ***!
