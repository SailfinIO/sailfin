---
title: Installing Sailfin
description: How to install the Sailfin compiler and toolchain.
section: getting-started
order: 1
---

## Requirements

- **Linux** or **macOS** (Windows support via WSL)
- LLVM 17+ (installed automatically by the installer)
- A C compiler (gcc or clang) for linking

## Quick Install

The fastest way to install Sailfin is with the install script:

```bash
curl -fsSL https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.sh | bash
```

This installs the `sailfin` and `sfn` binaries to `~/.local/bin`.

## From Source

If you prefer to build from source:

```bash
git clone https://github.com/SailfinIO/sailfin.git
cd sailfin
make env       # Create the Conda environment
make compile   # Build the compiler (self-hosting from seed)
make install   # Install to ~/.local/bin
```

### Verify Installation

```bash
sfn --version
```

You should see output like:

```
sailfin v0.1.1-alpha
```

## Next Steps

- [Hello, World!](/docs/getting-started/hello-world) — Write your first Sailfin program
- [Tour of Sailfin](/docs/getting-started/tour) — A guided introduction to the language
