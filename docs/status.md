# Status

This document tracks what works today and what is in progress.

## Compiler Pipeline (Current)

- Stage2 (native AOT) self-host compiler is the primary toolchain; `make compile` produces the `build/native/sailfin-stage2` binary.
- Stage1 (Python) compile pipeline is still part of the build and test flow to bootstrap stage2, but it is no longer the primary developer path.
- Stage2 (llvmlite JIT) self-host execution remains experimental and is used for targeted backend coverage.
- Stage1 Python lowering no longer blocks compilation on heuristic fallback checks; diagnostics still surface.

## Runtime (Current)

- The runtime is implemented in C under `runtime/native/` and linked into the native stage2 binary.
- The runtime is planned to be reimplemented in Sailfin for the 1.0 release.

## Installer (Current)

- The installer defaults to `/usr/local/bin` on macOS when `GLOBAL_BIN_DIR` is unset and uses `~/.local/bin` on other platforms (override with `GLOBAL_BIN_DIR`).

## Near-Term Goals

- Keep the native stage2 compiler stable as the primary compiler.
- Retire stage1/bootstrap steps from the build pipeline in the 1.0 release.
