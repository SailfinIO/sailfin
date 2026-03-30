---
title: Roadmap
description: Sailfin's development roadmap and planned features.
section: contributing
order: 4
---

> Canonical source: [`docs/roadmap.md`](https://github.com/SailfinIO/sailfin/blob/main/docs/roadmap.md)

## 1.0 Priorities

### Release Pipeline & Distribution
- Installer hardening (Linux, macOS, Windows/WSL)
- Binary distribution and versioning
- Package registry CLI integration

### Compiler Stability & Diagnostics
- Fix LLVM lowering for control flow (loop/if/break)
- Improve error messages with source spans and fix-it hints
- Reduce fixup pass count to zero

### Sailfin-Native Runtime
- Migrate C runtime to Sailfin
- Implement native ABI (strings, arrays, slices)
- Native exception handling (replace setjmp/longjmp)
- Concurrency runtime (channels, spawn, parallel)

### Tooling & Developer Workflow
- VS Code extension improvements
- Language server protocol (LSP)
- Debugger integration

### Documentation
- Public website at sailfin.dev
- Complete language specification
- Tutorial series
- Standard library documentation

## Post-1.0

- Async runtime
- Runtime diagnostics and profiling
- Full package registry CLI
- Native test framework improvements
- WebAssembly target
- GPU tensor operations
- Model training support

## Exploration Backlog

- Unsafe FFI formalization
- Notebook / REPL
- Cross-compilation targets

---

*See [`docs/roadmap.md`](https://github.com/SailfinIO/sailfin/blob/main/docs/roadmap.md) for the complete roadmap with sequencing details.*
