# Stage2 Debugging Status (Feb 2025)

## Current Outlook

Stage2 bootstrapping continues to abort the moment we invoke `compile_to_sailfin` through the native JIT. We no longer see raw segfaults—the crash now happens because the runtime stub calls `abort()`. Instrumentation shows that Stage2 is passing valid pointers into the runtime helpers, and the stub now mirrors the expected C-string ABI, yet the lexer still mis-classifies tokens, so the pipeline dies.

This note records the fixes that have landed, what we can reliably reproduce today, and the remaining work required to get Stage2 through the self-hosted compiler tests.

## What’s Fixed

- **Runner instrumentation**
  - `Stage2Runner` now logs every `malloc`/`free`, tracks tracked allocations, and records whether string pointers are “tracked”, “alloc”, or “unknown”.
  - `_ptr_to_str` can recover strings from both tracked buffers and arbitrary heap pointers, logging the path it takes (`reuse`, `struct decode`, or `cstring decode/fallback`). `sailfin_runtime_string_length` now records pointer status, length, and a 40-character preview to make lex traces easier to read.
  - New helper `Stage2Runner.encode_host_string(text)` registers host strings so the runtime can recognise them during string-length calls.

- **Test harness updates**
  - All Stage2 self-host tests call `runner.encode_host_string(...)` instead of constructing raw `ctypes.create_string_buffer` objects.
  - `scratch/stage2_repro.py` builds the Stage2 compiler, instantiates a `Stage2Runner`, and directly calls `compile_to_sailfin`. This reproduces the abort without pytest overhead.
  - `scratch/inspect_recursive_enum.py` and `scratch/analyze_stage2_runner.py` remain available for inspecting targeted IR and execution-engine state.

- **Stage2 string diagnostics**
  - The debug log (`SAILFIN_STAGE2_DEBUG_LOG`) captures every `runtime string_length` call, along with the pointer status and the decoded length.
  - Unknown pointers no longer segfault; they return `""` after logging a warning, ensuring we see the upstream fallout instead of crashing immediately.
- **Runtime stub alignment**
  - `runtime/stage2_runtime_stub.c` now treats strings as raw C strings (`char*`), matching the signatures emitted in the Stage2 LLVM (`i8*`).
  - Helpers such as `substring`, `concat`, and `append_string` allocate nul-terminated buffers and clone inputs as needed. Arrays are represented as `{ i8**, i64 }`, mirroring the IR declarations.
  - Compiled artifacts live under `runtime/build/` (`stage2_runtime_stub.bc` / `.ll`) instead of `scratch/` so they can be reused by scripts and checked into CI artefact caches if needed.

## What We Observe Now

1. **String ABI is `cstring`**  
   Stage2 chooses the legacy C-string ABI when it loads the compiled modules. All helper decoding paths confirm we are dealing with `char* + nul` buffers, not the struct-based layout.

2. **Host strings are tracked correctly**  
   Pointers originating from `encode_host_string` are logged as `status=tracked` with the expected length, so the pipeline receives the correct source text initially.

3. **Runtime stub now mirrors the c-string ABI**  
   The rebuilt stub returns proper nul-terminated buffers for every helper. `Stage2Runner` logs confirm we see the full hello-world source as well as the lexeme tables (`0123456789`, `abcdefghijklmnopqrstuvwxyz`, …). Despite this, the lexer still gets stuck in the `debug_marker` 1001 loop, so the root cause is higher up the stack (likely a logic bug rather than an ABI mismatch).

4. **Abort comes from the stub**  
   The crash is now an explicit `abort()` inside `runtime/stage2_runtime_stub.c` (e.g. `sailfin_runtime_raise_value_error`). No `[stage2-runtime] value error` messages appear because the stub doesn’t print context before aborting.

5. **`debug_marker` probes reach 1001 repeatedly**  
   Our IR instrumentation inserts `stage2_debug_marker` calls throughout the `lex` function. The log shows code `1001` firing in a tight loop, matching the observation that the lexer is spinning on bad tokens.

## Next Steps

1. **Add diagnostics before `abort()`**
   - Print the message and pointer involved before calling `abort()` in `sailfin_runtime_raise_value_error` and other failure paths. This will tell us exactly which code path triggers the fatal error.
2. **Instrument the failure path**
   - With the ABI confirmed, the remaining abort is likely triggered by a runtime panic inside the lexer/parser. Add logging inside the C stub (and/or the Python bridge) to capture the offending token kind, lexeme, and source position before `abort()` so we know which branch misbehaves. Consider augmenting the `stage2_debug_marker` instrumentation with additional identifiers so we can map the infinite loop to a specific case in `lexer.sfn`.

3. **Rebuild the stub and rerun the native repro**
   ```bash
   mkdir -p runtime/build
   clang -O0 -g -emit-llvm -c runtime/stage2_runtime_stub.c -o runtime/build/stage2_runtime_stub.bc
   clang -S  -O0 -emit-llvm runtime/stage2_runtime_stub.c -o runtime/build/stage2_runtime_stub.ll

   SAILFIN_STAGE2_DEBUG_LOG=scratch/stage2_debug.log \
     conda run -n sailfin python scratch/stage2_repro.py
   ```
   The goal is to capture richer logging (ideally the failing token/lexeme) and, ultimately, to see `compile_to_sailfin` complete without aborting. Watch for the `stage2_debug_marker` codes advancing past the 1000/1001 loop.

4. **Re-run the Stage2 pytest subset**
   Once the stub returns correct strings, run:
   ```bash
   SAILFIN_STAGE2_DEBUG_LOG=scratch/stage2_debug.log \
   make test PYTEST_ARGS='compiler/tests/test_stage2_self_hosted_compiler.py::test_stage2_compile_to_sailfin_roundtrip -vv -s'
   ```
   Follow up with the full Stage2 suite if the roundtrip passes.

5. **Document the verified ABI**
   After confirming the working layout, record it in the spec (e.g. `docs/spec.md` or a dedicated runtime ABI reference) so future changes don’t regress the helpers.

## Quick Reference

- **Key scripts**
  - `scratch/stage2_repro.py` – minimal reproduction of the Stage2 abort.
  - `scratch/analyze_stage2_runner.py` – inspects the LLVM modules loaded into the runner and lists unresolved symbols.
  - `scratch/inspect_recursive_enum.py` – compiles small snippets and executes their `main` via MCJIT for isolated testing.

- **Crucial files**
  - `runtime/stage2_runner.py` – instrumentation and host-string registration.
  - `runtime/stage2_runtime_stub.c` – runtime helpers (now aligned with the c-string ABI; update and rebuild as improvements land).
  - `compiler/tests/test_stage2_self_hosted_compiler.py` – Stage2 pytest coverage using the new helper API.

Keep this document updated as new findings land so the next person can continue from the latest state rather than rediscovering the same issues. Good luck!
