# Debug a Compilation Failure

Systematically diagnose why a Sailfin source file fails to compile.

## Target: $ARGUMENTS

## Diagnostic Steps

1. **Isolate** — Run the failing file directly:
   ```
   ulimit -v 8388608
   timeout 60 build/native/sailfin emit native <file>
   ```
   Read the diagnostic output carefully — Sailfin emits source spans and fix-it hints.

2. **Narrow the stage** — Determine which compiler pass fails:
   - Parse error → check `compiler/src/parser.sfn`
   - Type error → check `compiler/src/typecheck.sfn`
   - Effect error → check `compiler/src/effect_checker.sfn`
   - Emit error → check `compiler/src/emit_native.sfn`
   - LLVM error → check `compiler/src/llvm/lowering/`

3. **Inspect IR** — If the error is in lowering, emit intermediate representations:
   ```
   timeout 60 build/native/sailfin emit native <file>   # .sfn-asm
   timeout 60 build/native/sailfin emit llvm <file>     # LLVM IR
   ```

4. **Compare** — If a similar feature works, compare the working and broken IR to spot the divergence.

5. **Report** — Summarize: which pass fails, the error message, the relevant source location, and a proposed fix.

## Important

- Always use `ulimit -v 8388608` and `timeout` when running the compiler.
- Never run the compiler without a memory cap.
