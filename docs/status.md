# Status

This document tracks what works today and what is in progress.

## Compiler Pipeline (Current)

- The self-hosted native compiler is the primary toolchain; `make compile` produces `build/native/sailfin`.
- The legacy Stage1 (Python) bootstrap pipeline is kept for emergency recovery, but it is no longer the primary developer path.
- Experimental LLVM JIT execution remains available for targeted backend coverage.
- Stage1 Python lowering no longer blocks compilation on heuristic fallback checks; diagnostics still surface.
- CI uses the native build/release workflows (`.github/workflows/build.yml`, `.github/workflows/release.yml`); Stage1 release workflow has been retired.
- Native compiler self-hosted tests live in `compiler/tests/{unit,integration,e2e}` and run via `sfn test` (repo-local: `./sfn test .`; build output: `build/native/sailfin test .`; `make test-unit`, `make test-integration`, `make test-e2e`).
- Native AOT builds do not rely on any `aot-prepare` text rewrite step; the native compiler emits link-safe LLVM IR directly.

## Runtime (Current)

- The runtime is implemented in C under `runtime/native/` and linked into the native compiler binary.
- The native CLI locates a bundled runtime next to the executable (override with `SAILFIN_RUNTIME_ROOT`) when building or running programs.
- The runtime is planned to be reimplemented in Sailfin for the 1.0 release.

## Installer (Current)

- The installer defaults to `/usr/local/bin` on macOS when `GLOBAL_BIN_DIR` is unset and uses `~/.local/bin` on other platforms (override with `GLOBAL_BIN_DIR`).

## Near-Term Goals

- Keep the native compiler stable as the primary compiler.
- Retire Stage1/bootstrap steps from the build pipeline in the 1.0 release.
