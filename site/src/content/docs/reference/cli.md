---
title: CLI Reference
description: The sfn command-line interface reference.
section: reference
order: 6
---

## Overview

The `sfn` binary is the primary interface to the Sailfin toolchain. It compiles, runs, and tests Sailfin programs.

## Commands

### `sfn run <file>`

Compile and run a Sailfin source file:

```bash
sfn run hello.sfn
sfn run examples/basics/hello-world.sfn
```

### `sfn test [path]`

Run tests:

```bash
sfn test                           # Run all tests
sfn test path/to/test.sfn          # Run specific file
sfn test --filter "pattern"        # Filter by test name
```

### `sfn --version`

Display the compiler version:

```bash
sfn --version
# sailfin v0.1.1-alpha
```

### `sfn compile <file>`

Compile without running:

```bash
sfn compile src/main.sfn
```

## Build System

The Makefile provides higher-level build commands:

| Command | Description |
|---------|-------------|
| `make compile` | Build the compiler (self-hosting from seed) |
| `make install` | Install to `~/.local/bin` |
| `make test` | Run full test suite |
| `make test-unit` | Run unit tests |
| `make test-integration` | Run integration tests |
| `make test-e2e` | Run e2e tests |
| `make check` | Build + validate seedcheck binary |
| `make smoke` | Rebuild + smoke tests |
| `make clean` | Remove dist/ artifacts |
| `make env` | Create/update Conda environment |

---

*Additional CLI commands for package management (`sfn add`, `sfn publish`, etc.) are planned for post-1.0. See [Capsules & Packages](/docs/advanced/capsules).*
