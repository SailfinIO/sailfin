---
title: Compiler Architecture
description: How the Sailfin compiler works internally.
section: contributing
sidebar:
  order: 2
---

## Pipeline

The compiler follows a multi-stage pipeline:

```
Source (.sfn)
  → Lexer (lexer.sfn) → Tokens
  → Parser (parser.sfn) → AST (ast.sfn)
  → Type Checker (typecheck.sfn) → Validated AST
  → Effect Checker (effect_checker.sfn) → Effect-safe AST
  → Native Emitter (emit_native.sfn) → .sfn-asm IR (native_ir.sfn)
  → LLVM Lowering (llvm/lowering/) → LLVM IR
  → LLVM → Native Binary
```

## Key Files

| File | Role |
|------|------|
| `compiler/src/main.sfn` | Entry point, orchestrates all passes |
| `compiler/src/lexer.sfn` | Tokenizer |
| `compiler/src/parser.sfn` | Parser → AST |
| `compiler/src/ast.sfn` | AST node definitions |
| `compiler/src/typecheck.sfn` | Type checking, interface conformance |
| `compiler/src/effect_checker.sfn` | Effect validation |
| `compiler/src/emit_native.sfn` | Emit `.sfn-asm` IR |
| `compiler/src/native_ir.sfn` | IR representation |
| `compiler/src/llvm/lowering/entrypoints.sfn` | LLVM IR generation |

## Runtime

The binary's entry point is the Sailfin-emitted `@main` (M5, #451; shipped 2026-05-25) — no C code participates in startup. Supporting helpers under `runtime/native/src/` remain in C until M3 ports them into Sailfin.

- `runtime/prelude.sfn` — Sailfin-native prelude (collections, strings, type checks)
- `runtime/sfn/` — Sailfin-native runtime modules (`clock.sfn`, `memory/arena.sfn`, `memory/rc.sfn`, `process.sfn`, `type_meta.sfn`, …)
- `runtime/native/` — Supporting C helpers pending M3 (strings, arrays, exceptions, the C arena, crypto)

## Self-Hosting

The compiler compiles itself. The build process:

1. A **seed binary** (a previously compiled version) bootstraps the build
2. The seed compiles the current source into a **first-pass binary**
3. The first-pass binary compiles the source again into the **seedcheck binary**
4. `make check` validates the seedcheck can run programs and pass tests

## Intermediate Representation

`.sfn-asm` is a textual IR that sits between the AST and LLVM IR. It represents:

- Function declarations and bodies
- Basic blocks and control flow
- Type metadata
- Effect annotations

---

*For details on the LLVM lowering passes, see `compiler/src/llvm/lowering/`.*
