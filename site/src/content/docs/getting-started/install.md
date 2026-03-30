---
title: Installing Sailfin
description: How to install the Sailfin compiler and toolchain.
section: getting-started
order: 1
---

## Requirements

- **Linux**, **macOS**, or **Windows** (native Windows binaries available; WSL and Git Bash also supported)
- LLVM 17+ (installed automatically by the installer)
- A C compiler (gcc or clang) for linking (Linux/macOS only)

## Quick Install

### Linux / macOS

The fastest way to install Sailfin is with the install script:

```bash
curl -fsSL https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.sh | bash
```

This installs the `sailfin` and `sfn` binaries to `~/.local/bin`.

### Windows (PowerShell)

Sailfin ships native Windows binaries (`.exe`). Install with PowerShell:

```powershell
irm https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.ps1 | iex
```

To pin a specific version:

```powershell
$env:VERSION = "0.1.1-alpha.135"
irm https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.ps1 | iex
```

This installs `sailfin.exe` and `sfn.exe` to `%LOCALAPPDATA%\sailfin\bin` and adds that directory to your user `PATH`.

> **WSL / Git Bash users:** You can also run the `install.sh` script from WSL or Git Bash on Windows.

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

- [Editor Setup](/docs/getting-started/editor-setup) — Install the Sailfin VS Code extension
- [Hello, World!](/docs/getting-started/hello-world) — Write your first Sailfin program
- [Tour of Sailfin](/docs/getting-started/tour) — A guided introduction to the language
