# Bootstrap Compiler (Stage0)

> **Archived**: Stage1 is the production toolchain. This directory preserves
> the historical Python bootstrap for reference and regression hunting only.

The Python bootstrap compiler parses Sailfin source, performs conservative
effect validation, and emits runnable Python that targets
`Legacy/stage0/runtime_support.py`.

Key components:

- `lexer.py` / `parser.py` — Recursive-descent front end for the bootstrap
  language subset.
- `effect_checker.py` — Validates `model`, `io`, and `net` requirements
  before code generation.
- `code_generator.py` — Emits Python 3 source and runtime bindings.
- `runtime_support.py` — Mocked runtime helpers (console, fs, http, spawn).
- `tests/` — Unit and integration coverage for the lexer, parser, code
  generator, effect checker, and language examples.

The implementation surface tracked here feeds into the canonical status
document (`../docs/status.md`).

## Tooling

- Create or update the (legacy) Conda environment:

  ```bash
  conda env update --file Legacy/stage0/environment.yml --name sailfin-stage0
  ```

- Compile Sailfin sources to Python (legacy flow):

  ```bash
  conda run -n sailfin-stage0 python Legacy/stage0/bootstrap.py path/to/file.sfn
  ```

- Produce a standalone `sfn` binary with PyInstaller:

  ```bash
  conda run -n sailfin-stage0 pyinstaller --onefile --name sfn Legacy/stage0/bootstrap.py
  ```

Outputs live under `Legacy/stage0/dist/` and reuse the runtime preamble bundled in
this directory.

## Test Suite

Run the full pytest suite (unit + integration):

```bash
make bootstrap-test
```

Relevant markers:

- `-m unit` — lexer, parser, effect checker.
- `-m integration` — end-to-end generation + execution of examples.

Tests ensure every `.sfn` file in `examples/` and `compiler/src/` parses and
generates Python successfully with enforced effects.
