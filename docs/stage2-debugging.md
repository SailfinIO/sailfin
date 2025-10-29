# Stage2 Debugging Status (Feb 2025)

## Current Outlook

Stage2 bootstrapping continues to abort the moment we invoke `compile_to_sailfin` through the native JIT. We no longer see raw segfaults—the crash now happens because the runtime stub calls `abort()`. Instrumentation shows that Stage2 is passing valid pointers into the runtime helpers, the stub mirrors the expected C-string ABI, and the lexer produces the correct tokens; however, the parser immediately falls back to `parse_unknown`, classifying the entire source file as an `Unknown` statement. The pipeline therefore aborts before `typecheck_program` ever runs.

This note records the fixes that have landed, what we can reliably reproduce today, and the remaining work required to get Stage2 through the self-hosted compiler tests.

## What’s Fixed

- **Runner instrumentation**
  - `Stage2Runner` now logs every `malloc`/`free`, tracks tracked allocations, and records whether string pointers are “tracked”, “alloc”, or “unknown”.
  - `_ptr_to_str` can recover strings from both tracked buffers and arbitrary heap pointers, logging the path it takes (`reuse`, `struct decode`, or `cstring decode/fallback`). `sailfin_runtime_string_length` now records pointer status, length, and a 40-character preview to make lex traces easier to read.
  - New helper `Stage2Runner.encode_host_string(text)` registers host strings so the runtime can recognise them during string-length calls.
  - Additional IR instrumentation now drops debug markers throughout `compile_to_sailfin`, `parse_tokens`, `parse_block`, and `parse_unknown`, making it easy to correlate log output with parser progress (`2000+`, `6000+`, `8000+`, `10000+`/`11000+`/`13000+` ranges).

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

3. **Pipeline halts inside `parse_unknown`**  
   Additional IR instrumentation (markers 2000+, 6000+, 10000+) shows `compile_to_sailfin` calling `parse_program`, but never `typecheck_program`. `parse_tokens` emits a single iteration (marker `6000`), then hands control to `parse_statement`, which immediately calls `parse_unknown`. Markers `10000+idx` confirm the entire `fn main … { … }` block is consumed as an unknown statement.

4. **Token stream is correct, but statement dispatch fails**  
   While `parse_unknown` runs, the token-kind markers (`11000+variant`) report the expected sequence: comment → whitespace → `NumberLiteral` (the `fn` token) → identifiers/symbols for the function signature. Depth markers (`13000+depth`) stay at zero, so `parse_unknown` exits only at EOF. This indicates `parse_statement` never recognises the leading `fn` identifier, despite the lexer providing it.

5. **Abort still originates in the stub**  
   The crash is still the explicit `abort()` inside `runtime/stage2_runtime_stub.c` (`sailfin_runtime_raise_value_error`). Thanks to the new abort adapter we now log the call path, but the root cause remains the parser producing an empty/invalid AST.

## Next Steps

1. **Log `parse_statement` dispatch**  
   - Extend the instrumentation (either via Sailfin or IR patch) to emit the token variant/value seen after `skip_trivia` inside `parse_statement`. We need to confirm whether the token arriving at the dispatcher is still a comment/whitespace, or an identifier with an empty `value` field.

2. **Verify `skip_trivia` and token payloads**  
   - If `parse_statement` still sees trivia, inspect `skip_trivia` and `is_trivia_token` to ensure comment and whitespace tokens are being advanced.  
   - If the token is an identifier but the `value` field is empty, inspect the Stage2 `TokenKind.Identifier` payload and the stage1-generated lexer to ensure we populate the identifier text.

3. **Patch `parse_statement` to recognise `fn`**  
   - Once we understand the token mismatch, adjust `identifier_matches`/`parse_statement` so the leading `fn` is recognised and routed to `parse_function`. That should unblock `parse_tokens` and allow `typecheck_program` to run.

4. **Re-run the native repro with logging**  
   - After the parser change, rerun:
     ```bash
     SAILFIN_STAGE2_DEBUG_LOG=scratch/stage2_debug.log \
       conda run -n sailfin python scratch/stage2_repro.py
     ```
     Confirm markers progress through 2000 → 2001 and beyond, and that `parse_unknown` markers disappear.

5. **Escalate to Stage2 tests**  
   - When the parser emits proper ASTs, run the focused stage2 pytest (`test_stage2_compile_to_sailfin_roundtrip`) followed by the wider suite.

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
