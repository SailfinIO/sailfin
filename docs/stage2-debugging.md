# Stage2 Debugging Status (Jan 2025)

## Overview

The stage2 self-hosting pipeline still segfaults when invoked via `Stage2Runner`. The crash happens the moment we call `compile_to_sailfin` inside the native JIT. Most of the up-front IR hygiene issues have been fixed, so the remaining work is to drop into the generated LLVM and catch the exact bad write/read.

This note captures what has been completed so far and the concrete next steps needed to resume the investigation.

## Completed Fixes

- **`Program` value handling** – `compiler/src/main.sfn` now stores and reuses the parsed `Program` struct instead of mishandling it as an `i8*`. Regenerated `compiler/build/main.py` mirrors the change.
- **Enum variant globals** – `scripts/bootstrap_stage2.py` synthesises `@.enum.*` string constants for every referencing module, appends them to both the `string_constants` table and the emitted IR, and pushes the definitions through Stage2Runner. `bootstrap_stage2` now finishes cleanly and each `.ll` file defines its own `@.enum.…variant`.
- **Array literal lowering** – `lower_array_literal` allocates heap storage (no more stack pointers escaping the function) and guards zero-length allocations.
- **Stage2 harness improvements** – `scratch/verify_stage2_runner.py` can build the compiler, create a `Stage2Runner`, and (with `WAIT_FOR_DEBUGGER=1`) pause at start-up until a `scratch/continue_stage2_debug` sentinel file appears. This lets us attach before invoking the native entry points.
- **Runtime stubs (partial)** – A placeholder C runtime (`scratch/stage2_runtime_stub.c`) implements the frequently referenced `sailfin_runtime_*` helpers so that a stand-alone `lli` session can be set up after we export the post-Stage2Runner modules.

## Outstanding Issues

1. **Debugger attach fails**  
   All `lldb` attempts (both Homebrew and Xcode builds) exit immediately with “no such process”. The host denies debugserver/PTY requests, so we can’t yet obtain a stack trace from the crashing process.

2. **`lli` linking still hits duplicate globals**  
   When we link the raw `.ll` files plus the stub runtime we get `symbol multiply defined` errors (e.g. `_add`). Stage2Runner rewrites the modules in-memory to avoid these conflicts, so the files on disk are not sufficient for `llvm-link`/`lli`.

3. **Segfault cause still unknown**  
   With no debugger and no `lli` reproduction we haven’t seen the exact function or instruction that corrupts memory.

## How to Reproduce the Current Crash

```bash
# Rebuild stage2 output
conda run -n sailfin python scripts/bootstrap_stage2.py \
  --out scratch/stage2_artifacts --quiet --no-validate

# Run the stage2 harness (crashes inside runner.invoke)
conda run -n sailfin python scratch/verify_stage2_runner.py
```

With `WAIT_FOR_DEBUGGER=1` the script pauses before invoking `parse_program`. Touch `scratch/continue_stage2_debug` to resume.

## Suggested Next Steps

### 1. Obtain a Native Backtrace

- Run the harness on a machine where `lldb`/`debugserver` is allowed, or adjust sandbox entitlements to permit debugging.
- Use the waiting harness:
  ```bash
  WAIT_FOR_DEBUGGER=1 conda run -n sailfin python scratch/verify_stage2_runner.py
  ```
  Attach with `lldb -n python` (or `-p <pid>`), set breakpoints if desired, `touch scratch/continue_stage2_debug` to continue, and capture the crash backtrace.

### 2. Re-create Stage2Runner’s Linked Module for `lli`

- Dump the *rewritten* modules from `Stage2Runner._modules` (after `_compile_ir` runs). You can adapt the earlier `scratch/dump_stage2_modules.py` to call `module.as_bitcode()` and `module.__str__()` for each in-memory module.
- Link those `.bc` files with `stage2_driver.ll` and `stage2_runtime_stub.bc`, then run under `/opt/homebrew/opt/llvm/bin/lli`. Because the rewritten modules have unique globals, the linker should succeed and `lli` can execute `compile_to_sailfin`.
- Once that works, run `lli` under `lldb` to single-step through the native function without the Python boundary.

### 3. Expand Runtime Stubs As Needed

If unresolved symbols remain after linking the rewritten modules, add the missing helper signatures to `scratch/stage2_runtime_stub.c`. The current stub covers:

```
sailfin_runtime_bounds_check
sailfin_runtime_string_length
sailfin_runtime_string_concat
sailfin_runtime_substring
char_code / sailfin_runtime_char_code
sailfin_runtime_grapheme_count / grapheme_at
… (basic type checks, logging, concat helpers, capability stubs)
```

Fill in any additional helpers that `lli` complains about.

### 4. Diagnose the Actual Fault

Once a debugger or `lli` is running:

- Compare registers/pointers right before the fault to Stage1 output.
- Inspect arrays/structs returned by the failing function; pay attention to heap allocations introduced in stage2 (array literals, enum payloads, etc.).
- Capture the problematic module/IR snippet and add it to the doc or a tracked issue.

## Useful Paths & Scripts

- `scratch/verify_stage2_runner.py` – stage2 harness (supports debugger wait).
- `scratch/stage2_runtime_stub.c` – runtime helper stubs; compile to bitcode (`clang -c -O0 -emit-llvm`).
- `scripts/bootstrap_stage2.py` – now responsible for materialising enum variant constants.
- `scratch/stage2_driver.c` → `stage2_driver.ll` – simple driver that calls `compile_to_sailfin` from native code.

Keep this document updated as new findings come in so the next person can jump straight into the remaining work. Good luck!
