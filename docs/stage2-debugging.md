# Stage2 Debugging Status (Jan 2025)

## Overview

The stage2 self-hosting pipeline still segfaults when invoked via `Stage2Runner`. The crash happens the moment we call `compile_to_sailfin` inside the native JIT. Most of the up-front IR hygiene issues have been fixed, so the remaining work is to drop into the generated LLVM and catch the exact bad write/read.

This note captures what has been completed so far and the concrete next steps needed to resume the investigation.

## Completed Fixes

- **`Program` value handling** – `compiler/src/main.sfn` now stores and reuses the parsed `Program` struct instead of mishandling it as an `i8*`. Regenerated `compiler/build/main.py` mirrors the change.
- **Enum variant globals** – `scripts/bootstrap_stage2.py` synthesises `@.enum.*` string constants for every referencing module, appends them to both the `string_constants` table and the emitted IR, and pushes the definitions through Stage2Runner. `bootstrap_stage2` now finishes cleanly and each `.ll` file defines its own `@.enum.…variant`.
- **Array literal lowering** – `lower_array_literal` allocates heap storage (no more stack pointers escaping the function) and guards zero-length allocations.
- **Stage2 harness improvements** – `scratch/verify_stage2_runner.py` can build the compiler, create a `Stage2Runner`, and (with `WAIT_FOR_DEBUGGER=1`) pause at start-up until a `scratch/continue_stage2_debug` sentinel file appears. This lets us attach before invoking the native entry points.
- **Runtime stubs (partial)** – A placeholder C runtime (`runtime/stage2_runtime_stub.c`) implements the frequently referenced `sailfin_runtime_*` helpers so that a stand-alone `lli` session can be set up after we export the post-Stage2Runner modules.

## Outstanding Issues

1. **No native debugger access**  
   The host denies debugserver/PTY requests, so attaching a native debugger is not an option. We must rely on harness logging and `lli` reproductions for visibility.

2. **`lli` linking still hits duplicate globals**  
   When we link the raw `.ll` files plus the stub runtime we get `symbol multiply defined` errors (e.g. `_add`). Stage2Runner rewrites the modules in-memory to avoid these conflicts, so the files on disk are not sufficient for `llvm-link`/`lli`.

3. **Segfault cause still unknown**  
   With no debugger and no `lli` reproduction we haven’t seen the exact function or instruction that corrupts memory.

### 2025-02-14 update – native reproduction and findings

Using the rewritten Stage2 modules (`scratch/stage2_patched/…`) plus the driver/runtime stub, we can now reproduce the crash entirely inside `lli`:

```bash
/opt/homebrew/opt/llvm/bin/llvm-link \
  scratch/stage2_patched/0{0..9}__string_.bc \
  scratch/stage2_patched/1{0..5}__string_.bc \
  scratch/stage2_runtime_stub.bc \
  scratch/stage2_driver_parse.bc \
  -o scratch/stage2_combined_parse.bc

/opt/homebrew/opt/llvm/bin/lli --entry-function=stage2_parse_entry scratch/stage2_combined_parse.bc
```

Instrumenting `lex`, `parse_tokens`, `append_token`, and the runtime helpers shows:

- The very first call to `char_code` should see `'f'` from the source (`"fn greet"`), but the value passed into the C stub is an empty string. Our logging prints `[stage2-debug] [lex] buffer byte=102` for the stack copy **and** `char_code ptr=… char=0x00` for the pointer handed to Stage2 – it’s the wrong representation.
- Because `is_letter`/`is_identifier_start` fail, the lexer immediately falls into the “unknown token” path and appends an `EndOfFile` token (kind `7`). The parser then spins forever on duplicate EOF tokens and eventually hits the sandbox kill.
- The LLVM IR shows string helpers such as `slice` and `char_at` returning values via `sailfin_runtime_substring`. Stage2 expects those helpers to return a struct-like blob, not a raw `char *`.

**Root cause:** the C runtime stub (`runtime/stage2_runtime_stub.c`) still treats Stage2 strings as bare `char *`. Stage2 code is actually passing around richer values (pointer + length). When our stub returns a plain heap buffer the subsequent runtime helpers (`string_length`, `char_code`, etc.) read zero and the lexer collapses.

### Action items

1. Update the C stub to mirror Stage2’s string layout:

   - Define a `struct Stage2String { char *data; int64_t length; }` (or whatever layout we infer from the IR; the `%StringConstant` struct is a good starting point).
   - Make `sailfin_runtime_substring`, `sailfin_runtime_concat`, `sailfin_runtime_append_string`, `sailfin_runtime_string_length`, and `sailfin_runtime_char_code` allocate/populate that struct rather than returning a raw C string.
   - Continue to accept raw `char *` only at the external API boundary (`parse_program`). Once Stage2 calls into the runtime, we must hand back `Stage2String` values.

2. Rebuild the stub (`clang -emit-llvm -c runtime/stage2_runtime_stub.c -o scratch/stage2_runtime_stub.bc`) and rerun the `lli` harness. The expected successful log should show `[parse_tokens] kind=0` for the first token and only a single EOF appended at the end.

3. With the lexer working, rerun the updated harness to confirm there’s no remaining native fault, then re-enable `runtime/stage2_runner.py` to verify the full Python harness completes.

### 2025-10-27 update – string runtime alignment

- `runtime/stage2_runner.py` now marshals strings as `{ data, length }` structs when bridging native helpers. The adapter keeps the backing UTF-8 buffer, the struct, and its pointer alive for the duration of the runner so native code sees stable addresses.
- `runtime/stage2_runtime_stub.c` implements `SailfinString`/`SailfinStringArray` helpers, with every string-producing runtime helper returning a heap-allocated struct (and helpers such as `string_length`, `substring`, `char_code`, and `append_string` rewritten to respect the new layout).
- To refresh the lli harness, rebuild the stub bitcode: `clang -O0 -g -emit-llvm -c runtime/stage2_runtime_stub.c -o scratch/stage2_runtime_stub.bc`.
- Next step: rerun the linked Stage2 bundle under `lli` (or `scratch/verify_stage2_runner.py`) and capture the lexer logs; the first `char_code` call should now report `'f'` instead of `0x00`.

### 2025-10-28 update – harness state and debugger setup

- `scratch/verify_stage2_runner.py` now feeds the Stage2 runner with a raw UTF-8 buffer (null terminated) because `ctypes` cannot currently express the `%Program` struct return type; we still pass the resulting pointer back into `typecheck_program` and `emit_program` as `ctypes.c_void_p`.
- Running the harness with `SAILFIN_STAGE2_DEBUG_LOG=scratch/stage2_runner_debug.log conda run python scratch/verify_stage2_runner.py` shows the runner laying out all 16 modules, skipping the aggregate return path for `parse_program`, and then segfaulting inside `Stage2Runner.invoke` as soon as the call is issued. No runtime helper logging appears before the crash, so the fault happens before helpers such as `sailfin_runtime_string_length` run.
- The host environment prevents debugger attachment, so rely on `WAIT_FOR_DEBUGGER=1` only as a synchronisation aid. Log output still streams to `SAILFIN_STAGE2_DEBUG_LOG`, and `touch scratch/continue_stage2_debug` resumes execution once instrumentation is configured.
- `scratch/verify_stage2_runner.py` lazy-loads Stage2 modules via `importlib` after it has appended the repo root to `sys.path`. This avoids `ModuleNotFoundError` when the script is launched from tools that skip our virtualenv activation. Double-check that you’re running the up-to-date harness if modules still fail to resolve.
- Immediate next step: capture detailed logging from this segfaulting call so we know which native frame fails before any runtime helper interaction. If the harness still exits too quickly, run the generated bundle under `lli` with additional instrumentation to trace the failing call.

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

### 1. Capture Detailed Instrumentation

- Enable verbose logging with `SAILFIN_STAGE2_DEBUG_LOG=...` and use `WAIT_FOR_DEBUGGER=1` solely to pause execution while probes are configured.
- Add targeted prints or `printf` instrumentation inside the runtime stubs and regenerated LLVM to narrow the failing call prior to the segfault.

### 2. Re-create Stage2Runner’s Linked Module for `lli`

- Dump the _rewritten_ modules from `Stage2Runner._modules` (after `_compile_ir` runs). You can adapt the earlier `scratch/dump_stage2_modules.py` to call `module.as_bitcode()` and `module.__str__()` for each in-memory module.
- Link those `.bc` files with `stage2_driver.ll` and `stage2_runtime_stub.bc`, then run under `/opt/homebrew/opt/llvm/bin/lli`. Because the rewritten modules have unique globals, the linker should succeed and `lli` can execute `compile_to_sailfin`.
- Once that works, iterate with `lli` and additional logging to single-step conceptually through the native function without the Python boundary.

### 3. Expand Runtime Stubs As Needed

If unresolved symbols remain after linking the rewritten modules, add the missing helper signatures to `runtime/stage2_runtime_stub.c`. The current stub covers:

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
- `runtime/stage2_runtime_stub.c` – runtime helper stubs; compile to bitcode (`clang -c -O0 -emit-llvm`).
- `scripts/bootstrap_stage2.py` – now responsible for materialising enum variant constants.
- `scratch/stage2_driver.c` → `stage2_driver.ll` – simple driver that calls `compile_to_sailfin` from native code.

Keep this document updated as new findings come in so the next person can jump straight into the remaining work. Good luck!
