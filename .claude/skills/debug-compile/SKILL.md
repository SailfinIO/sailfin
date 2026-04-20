---
name: debug-compile
description: Systematically diagnose why a Sailfin source file or self-hosting build step fails to compile. Isolates the failure, identifies the pipeline stage, escalates to seed-stabilizer or compiler-architect when the fix is non-trivial, and verifies via test-runner. Use whenever `make compile` fails, a .sfn file won't build, or LLVM rejects generated IR.
allowed-tools: Bash, Read, Grep, Glob
---

# Debug a compilation failure

Diagnose, fix, and verify a Sailfin compilation failure without chasing symptoms. Always fix the compiler, never the build script.

## Phase 1 — ISOLATE

### If the target is a single `.sfn` file

```bash
.claude/skills/debug-compile/scripts/isolate.sh path/to/file.sfn
```

This emits both `.sfn-asm` and LLVM IR under `build/debug/<basename>.{asm,ll,stderr}` with `ulimit -v 8388608` + `timeout 60` applied. Read the stderr for the diagnostic span.

### If the target is a self-hosting build

```bash
.claude/skills/debug-compile/scripts/tail-build.sh
```

Captures the full `make compile` log, prints the last 80 lines, and saves the full log for later grep.

## Phase 2 — TRACE

Map the diagnostic to the failing pipeline stage using the lookup in `references/pipeline-stages.md`. The table covers lex / parse / AST / typecheck / effects / emit / LLVM lowering / linker / runtime, with the canonical source file for each.

If a similar construct works in another module, diff the two `.sfn-asm` or `.ll` outputs — the first divergence usually points at the bug.

- **Shallow bug** (obvious from the trace — wrong case, typo, missing branch): proceed to Phase 4.
- **Deep bug** (unclear root cause, cross-module, self-hosting regression): Phase 3.

## Phase 3 — DEEP DIAGNOSIS

Spawn `seed-stabilizer` (Opus) with:

- exact error message and failing module,
- pipeline stage identified in Phase 2,
- IR snippets / diffs gathered so far,
- what you've ruled out.

If the proposed fix touches multiple passes or requires a migration, spawn `compiler-architect` to validate the approach before implementing.

## Phase 4 — FIX

Edit the canonical source file under `compiler/src/*.sfn`. Keep the diff minimal; don't refactor surrounding code. After the fix:

```bash
ulimit -v 8388608 && make compile
ulimit -v 8388608 && make test-unit
```

If the bug represents a pattern that could recur, add a regression test under `compiler/tests/unit/`.

## Phase 5 — VERIFY

Spawn `test-runner` for the full suite. Confirm:

1. Original failure resolved.
2. No regressions.
3. Self-hosting still works (`make compile`).
4. For structural fixes, also run the `check` skill.

## Constraints

- Always use `ulimit -v 8388608`; the `PreToolUse` hook will block compiler invocations without it.
- Fix the compiler, never `scripts/build.sh`.
- Do not add workarounds — find and fix the root cause.
- If the fix is structural, run `make clean-build` before rebuilding.
