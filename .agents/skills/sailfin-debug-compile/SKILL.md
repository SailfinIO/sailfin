---
name: sailfin-debug-compile
description: Systematically diagnose why a Sailfin source file or self-hosting build step fails to compile.
---

# Sailfin Debug Compile Skill

Diagnose, fix, and verify a Sailfin compilation failure without chasing symptoms.

## Phase 1 — ISOLATE

### If the target is a single `.sfn` file

```bash
build/bin/sfn compile --emit=asm,llvm path/to/file.sfn
```

Or use the helper script if available: `.claude/skills/debug-compile/scripts/isolate.sh path/to/file.sfn`

### If the target is a self-hosting build

```bash
make compile
```

Read stderr and captured logs for diagnostic spans.

## Phase 2 — TRACE

Map the diagnostic to the failing pipeline stage:
- Lexer (`compiler/src/lexer.sfn`)
- Parser (`compiler/src/parser/`)
- AST (`compiler/src/ast.sfn`)
- Typecheck (`compiler/src/typecheck/`)
- Effect Checker (`compiler/src/effect_checker.sfn`)
- Emit Native (`compiler/src/emit_native.sfn`)
- LLVM Lowering (`compiler/src/llvm/lowering/entrypoints.sfn`)

If a similar construct works in another module, diff the `.sfn-asm` or `.ll` outputs to find the first point of divergence.

## Phase 3 — FIX

Edit the canonical source file under `compiler/src/*.sfn`. After the fix:

```bash
make compile
build/bin/sfn test compiler/tests/unit/
```

If the bug represents a pattern that could recur, add a regression test under `compiler/tests/unit/`.

## Phase 4 — VERIFY

Run targeted tests for the affected component, and `make check` for structural fixes.
