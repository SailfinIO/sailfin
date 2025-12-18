# Status Matrix

This document tracks what works today and what is in progress.

## Compiler & Runtime

| Area                                      | Status       | Notes                                                                                                                                              |
| ----------------------------------------- | ------------ | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| Stage1 (Python) compile pipeline          | Shipped      | Primary build/test path today (`make test`, `make compile`).                                                                                       |
| Stage2 (llvmlite JIT) self-host execution | Experimental | Current path uses llvmlite + Python callbacks; under active development/debugging.                                                                 |
| Stage2 (native AOT) self-host execution   | In progress  | Initial scaffolding exists (`make native-stage2`) to rewrite stage2 IR and AOT-compile it with a minimal native runtime. Not feature-complete yet. |

## Self-hosting Goal

Target: Sailfin builds and runs its own compiler without Python.

Near-term milestone: AOT-compile stage2 LLVM IR into a native binary linked against a native runtime library that provides the Stage2 ABI.
