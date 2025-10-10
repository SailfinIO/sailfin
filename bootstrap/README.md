# Bootstrap Compiler (Stage0)

The Python bootstrap compiler is Sailfin’s production toolchain today. It
parses Sailfin source, performs conservative effect validation, and emits
runnable Python that targets `bootstrap/runtime_support.py`.

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

- Create or update the Conda environment:

  ```bash
  make bootstrap-install
  ```

- Compile Sailfin sources to Python (self-hosted experiments):

  ```bash
  conda run -n sailfin-bootstrap python bootstrap/bootstrap.py path/to/file.sfn
  ```

- Produce a standalone `sfn` binary with PyInstaller:

  ```bash
  conda run -n sailfin-bootstrap pyinstaller --onefile --name sfn bootstrap/bootstrap.py
  ```

Outputs live under `bootstrap/dist/` and reuse the runtime preamble bundled in
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
