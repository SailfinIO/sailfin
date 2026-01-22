# Status

This document tracks what works today and what is in progress.

## Compiler Pipeline (Current)

- The self-hosted native compiler in `compiler/src/` is the primary toolchain; `make compile` produces `build/native/sailfin`.
- Legacy Python compiler artifacts under `compiler/build/` are kept for emergency recovery only and are slated for removal before 1.0.
- Experimental LLVM JIT execution remains available for targeted backend coverage.
- CI uses the native build workflow (`.github/workflows/ci.yml`) to build, test, and attach release assets.
- Native compiler tests live in `compiler/tests/{unit,integration,e2e}` and run via `sfn test` (repo-local: `./sfn test .`; build output: `build/native/sailfin test .`; `make test-unit`, `make test-integration`, `make test-e2e`).
- The test runner inlines relative imports (including `compiler/src/*`) into a single compilation unit to avoid missing symbols when executing `sfn test`.
- Native AOT builds do not rely on any `aot-prepare` text rewrite step; the native compiler emits link-safe LLVM IR directly.

## Runtime (Current)

- The runtime is implemented in C under `runtime/native/` and linked into the native compiler binary.
- The native CLI locates a bundled runtime next to the executable (override with `SAILFIN_RUNTIME_ROOT`) when building or running programs.
- Legacy Python runtime shims have been removed; the 1.0 toolchain does not rely on `runtime/*.py` helpers.
- The native filesystem adapter supports `readFile`, `writeFile`, `appendFile`, `writeLines`, and directory helpers.
- The runtime will be reimplemented in Sailfin before the 1.0 release.

## Installer (Current)

- The installer defaults to `/usr/local/bin` on macOS when `GLOBAL_BIN_DIR` is unset and uses `~/.local/bin` on other platforms (override with `GLOBAL_BIN_DIR`).

## Near-Term Goals

- Keep the native compiler stable as the primary compiler.
- Deliver the Sailfin-native runtime and remove C runtime dependencies before 1.0.
- Ship Sailfin-native filesystem, HTTP, and model adapters before 1.0.
- Finalize the Sailfin-native ABI spec in `docs/runtime_abi.md`.
- Remove all Python tooling/shims from production pipelines and release artifacts.
- Remove Python-generated compiler artifacts from the 1.0 toolchain.
