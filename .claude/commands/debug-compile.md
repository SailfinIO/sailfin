# Debug a Compilation Failure

Systematically diagnose and fix why a Sailfin source file or build step fails to compile.

## Target: $ARGUMENTS

---

## Phase 1: ISOLATE

Run the failing file directly to capture the diagnostic output:

```bash
ulimit -v 8388608 && timeout 60 build/native/sailfin emit native <file>
```

Read the output carefully — Sailfin diagnostics include source spans and fix-it hints.

If the target is a build failure (not a single file), reproduce the failure:
```bash
ulimit -v 8388608 && make compile 2>&1 | tail -80
```

Identify: which module fails, the exact error message, and which pipeline stage produced it.

---

## Phase 2: TRACE

Determine which compiler pass fails:
- Parse error → `compiler/src/parser/`
- Type error → `compiler/src/typecheck.sfn`
- Effect error → `compiler/src/effect_checker.sfn`
- Emit error → `compiler/src/emit_native.sfn`
- LLVM IR error (clang rejects `.ll`) → `compiler/src/llvm/`
- Link error (undefined/duplicate symbols) → `compiler/src/llvm/lowering/emission_header.sfn`, `module_globals.sfn`

For LLVM-level failures, inspect the generated intermediate representations:
```bash
ulimit -v 8388608 && timeout 60 build/native/sailfin emit native <file>   # .sfn-asm
ulimit -v 8388608 && timeout 60 build/native/sailfin emit llvm <file>     # LLVM IR
```

If a similar feature works on a different file, compare the working and broken IR to spot the divergence.

**If the bug is shallow** (obvious from the trace — wrong string, missing case, typo), proceed directly to Phase 4.

**If the bug is deep** (unclear root cause, cross-module, affects self-hosting), proceed to Phase 3.

---

## Phase 3: DEEP DIAGNOSIS

Spawn the **seed-stabilizer** agent (Opus) to perform deep root cause analysis. Provide it with:
- The exact error message and failing module
- The pipeline stage identified in Phase 2
- Any IR snippets or comparisons you've gathered
- What you've ruled out so far

The seed-stabilizer will trace the code path through the compiler source, identify the root cause, and propose a fix with risk assessment.

If the proposed fix is non-trivial (touches multiple files or pipeline stages), spawn the **compiler-architect** agent to validate the approach and check for second-order effects before implementing.

---

## Phase 4: FIX

Implement the fix in `compiler/src/*.sfn`. Keep the change minimal and focused.

After the fix, verify:
```bash
ulimit -v 8388608 && make compile    # self-hosting still works
ulimit -v 8388608 && make test       # no regressions
```

If the fix addresses a pattern that could recur, add a regression test in `compiler/tests/`.

---

## Phase 5: VERIFY

Spawn the **test-runner** agent to run the full test suite and confirm:
1. The original failure is resolved
2. No regressions were introduced
3. Self-hosting still works

---

## Constraints

- Always use `ulimit -v 8388608` and `timeout 60` when running the compiler
- Fix the compiler source, never the build script — `scripts/build.sh` is orchestration only
- Do not add workarounds — find and fix the root cause
- If the fix is structural, run `make clean-build` before rebuilding
