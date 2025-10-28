# Stage2 Debugging Status (Feb 2025)

## Current Outlook

Stage2 bootstrapping continues to abort the moment we invoke `compile_to_sailfin` through the native JIT. We no longer see raw segfaults—the crash now happens because the runtime stub calls `abort()`. Instrumentation shows that Stage2 is passing valid pointers into the runtime helpers, but the stub returns the wrong string representation, so the lexer mis-classifies tokens and the pipeline dies.

This note records the fixes that have landed, what we can reliably reproduce today, and the remaining work required to get Stage2 through the self-hosted compiler tests.

## What’s Fixed

- **Runner instrumentation**
  - `Stage2Runner` now logs every `malloc`/`free`, tracks tracked allocations, and records whether string pointers are “tracked”, “alloc”, or “unknown”.
  - `_ptr_to_str` can recover strings from both tracked buffers and arbitrary heap pointers, logging the path it takes (`reuse`, `struct decode`, or `cstring decode/fallback`).
  - New helper `Stage2Runner.encode_host_string(text)` registers host strings so the runtime can recognise them during string-length calls.

- **Test harness updates**
  - All Stage2 self-host tests call `runner.encode_host_string(...)` instead of constructing raw `ctypes.create_string_buffer` objects.
  - `scratch/stage2_repro.py` builds the Stage2 compiler, instantiates a `Stage2Runner`, and directly calls `compile_to_sailfin`. This reproduces the abort without pytest overhead.
  - `scratch/inspect_recursive_enum.py` and `scratch/analyze_stage2_runner.py` remain available for inspecting targeted IR and execution-engine state.

- **Stage2 string diagnostics**
  - The debug log (`SAILFIN_STAGE2_DEBUG_LOG`) captures every `runtime string_length` call, along with the pointer status and the decoded length.
  - Unknown pointers no longer segfault; they return `""` after logging a warning, ensuring we see the upstream fallout instead of crashing immediately.

## What We Observe Now

1. **String ABI is `cstring`**  
   Stage2 chooses the legacy C-string ABI when it loads the compiled modules. All helper decoding paths confirm we are dealing with `char* + nul` buffers, not the struct-based layout.

2. **Host strings are tracked correctly**  
   Pointers originating from `encode_host_string` are logged as `status=tracked` with the expected length, so the pipeline receives the correct source text initially.

3. **Runtime stub returns inconsistent data**  
   When Stage2 calls helpers such as `sailfin_runtime_substring`, `sailfin_runtime_concat`, or `sailfin_runtime_char_code`, the stub still allocates raw `malloc` buffers and sometimes returns handles instead of strings. The subsequent `string_length` calls see unexpected values (often empty strings), causing the lexer to emit incorrect tokens. The parser then loops until the sandbox kills the process.

4. **Abort comes from the stub**  
   The crash is now an explicit `abort()` inside `runtime/stage2_runtime_stub.c` (e.g. `sailfin_runtime_raise_value_error`). No `[stage2-runtime] value error` messages appear because the stub doesn’t print context before aborting.

5. **`debug_marker` probes reach 1001 repeatedly**  
   Our IR instrumentation inserts `stage2_debug_marker` calls throughout the `lex` function. The log shows code `1001` firing in a tight loop, matching the observation that the lexer is spinning on bad tokens.

## Next Steps

1. **Fix the runtime stub’s string model**
   - Mirror the ABI that Stage2 expects. Based on the LLVM IR, each helper should return either:
     - A raw `i8*` buffer with the lexeme contents (nul-terminated), or
     - A struct containing `{ i8*, i64 }`.  
     Confirm which one the IR uses by inspecting `%StringConstant`, `struct` definitions, and function signatures. Stage2 currently assumes `cstring`, so returning a bare `char*` for every helper is acceptable *only if the pointer stays valid and nul-terminated*.
   - Update helpers like `sailfin_runtime_substring`, `sailfin_runtime_concat`, `sailfin_runtime_append_string`, `sailfin_runtime_to_debug_string`, and `sailfin_runtime_string_length` so they:
     1. Allocate buffers of the correct length (`len + 1` for the terminator).
     2. Store the pointer in a map if the stub needs to hand it back later.
     3. Return pointers that outlive the helper call (do not return the address of stack locals).

2. **Add diagnostics before `abort()`**
   - Print the message and pointer involved before calling `abort()` in `sailfin_runtime_raise_value_error` and other failure paths. This will tell us exactly which code path triggers the fatal error.

3. **Rebuild the stub and rerun the native repro**
   ```bash
   clang -O0 -g -emit-llvm -c runtime/stage2_runtime_stub.c -o scratch/stage2_runtime_stub.bc
   SAILFIN_STAGE2_DEBUG_LOG=scratch/stage2_debug.log \
     conda run -n sailfin python scratch/stage2_repro.py
   ```
   The expected outcome is that `compile_to_sailfin` completes without aborting, and the log shows token kinds progressing past the initial `debug_marker 1001` loop.

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
  - `runtime/stage2_runtime_stub.c` – runtime helpers (needs ABI fixes).
  - `compiler/tests/test_stage2_self_hosted_compiler.py` – Stage2 pytest coverage using the new helper API.

Keep this document updated as new findings land so the next person can continue from the latest state rather than rediscovering the same issues. Good luck!
