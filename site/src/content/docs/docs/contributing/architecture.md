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
  → Type Checker (typecheck/) → Validated AST
  → Effect Checker (effect_checker.sfn) → Effect-safe AST
  → Native Emitter (emit_native.sfn) → .sfn-asm IR (native_ir.sfn)
  → LLVM Lowering (llvm/lowering/) → LLVM IR
  → clang + platform linker → Native Binary
```

## Key Files

| File | Role |
|------|------|
| `compiler/src/main.sfn` | Entry point, orchestrates all passes |
| `compiler/src/lexer.sfn` | Tokenizer |
| `compiler/src/parser.sfn` | Parser → AST |
| `compiler/src/ast.sfn` | AST node definitions |
| `compiler/src/typecheck/` | Type checking, interface conformance |
| `compiler/src/effect_checker.sfn` | Effect validation |
| `compiler/src/emit_native.sfn` | Emit `.sfn-asm` IR |
| `compiler/src/native_ir.sfn` | IR representation |
| `compiler/src/llvm/lowering/entrypoints.sfn` | LLVM IR generation |

## Runtime

The binary's entry point is the Sailfin-emitted `@main` (M5, #451; shipped
2026-05-25), and no C runtime participates in startup. Runtime source is
Sailfin-native; platform services are declared with `extern fn` and resolved
from linked libraries such as libc, pthreads, and OpenSSL. The backend still
lowers through LLVM, and clang plus the platform linker provide the native
last mile.

- `runtime/prelude.sfn` — Sailfin-native prelude (collections, strings, type checks)
- `runtime/sfn/` — Sailfin-native runtime modules (`clock.sfn`, `memory/arena.sfn`, `memory/rc.sfn`, `process.sfn`, `type_meta.sfn`, …)
- `runtime/capsule.toml` — Runtime capsule manifest, including platform link libraries
- `runtime/ir/` — Narrow target-specific LLVM IR support; not a C runtime

## Self-Hosting

The Sailfin-native build driver self-hosts the compiler from the exact released
seed pinned in `bootstrap.toml`:

1. The pinned **seed binary** compiles current source into a **first-pass binary**.
2. The first-pass binary compiles the same source into a **seedcheck binary**.
3. The seedcheck binary rebuilds the compiler once more; `make check` compares
   the two generated LLVM IR sets to prove a fixed point.
4. The gate runs a program smoke test and the Sailfin-native test suites against
   the validated seedcheck binary.

## Intermediate Representation

`.sfn-asm` is a textual IR that sits between the AST and LLVM IR. It represents:

- Function declarations and bodies
- Basic blocks and control flow
- Type metadata
- Effect annotations

---

*For details on the LLVM lowering passes, see `compiler/src/llvm/lowering/`.*
