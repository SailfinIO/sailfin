---
name: sailfin-debug-compile
description: Systematically diagnose Sailfin compilation, self-hosting, or LLVM lowering failures without adding build-driver workarounds.
---

# Sailfin Debug Compile Skill

Use this skill whenever `sfn check`, `make compile`, a single `.sfn` build, or LLVM/linking fails.

## Phase 1 — Isolate

- For frontend errors, start with `sfn check <file>` or `build/bin/sfn check <file>`.
- For a direct compile/run reproduction, wrap the compiler invocation with `timeout 60`.
- For self-hosting failures, capture the failing `make compile` output and preserve the log path.

## Phase 2 — Trace

Map the symptom to the canonical pipeline stage:

1. Lexer/parser: `compiler/src/lexer.sfn`, `compiler/src/parser.sfn`
2. AST/type/effects: `compiler/src/ast.sfn`, `compiler/src/typecheck.sfn`, `compiler/src/effect_checker.sfn`
3. Native IR/emitter: `compiler/src/native_ir.sfn`, `compiler/src/emit_native.sfn`
4. LLVM lowering: `compiler/src/llvm/lowering/`
5. Runtime/prelude: `runtime/prelude.sfn`, `runtime/sfn/`
6. Build orchestration: `compiler/src/cli_main.sfn`, `compiler/src/capsule_resolver.sfn` (orchestration only; no fixups)

If a similar construct works elsewhere, compare emitted `.sfn-asm` or `.ll` and look for the first divergence.

## Phase 3 — Fix

- Edit canonical source under `compiler/src/` or `runtime/sfn/`; keep the diff minimal.
- Never patch the build driver to mask a compiler/runtime bug.
- Add a focused regression test under `compiler/tests/` when the failure pattern can recur.

## Phase 4 — Verify

- Run `sfn check <touched .sfn files>` for the fast parse/type/effect loop.
- Run `sfn fmt --write` and `sfn fmt --check` on touched `.sfn` files under `compiler/src/` or `runtime/`.
- Run `make compile` for compiler-source changes.
- Run targeted tests. Use `make test` or `make check` only when the issue asks
  for a full gate or the fix is structural, release-facing, or high-risk.

## Constraints

- The compiler self-caps memory on Linux; no `ulimit` prefix is needed.
- Timeouts still apply to direct single-file compiler invocations.
- Structural compiler changes should use `make clean-build` before rebuilding.
