---
title: Installing Sailfin
description: Install the Sailfin compiler and toolchain on Linux, macOS, or Windows.
section: getting-started
order: 1
---

## Requirements

Sailfin runs on the following platforms:

| Platform | Architectures |
|---|---|
| Linux | x86_64, arm64 |
| macOS | x86_64, arm64 (Apple Silicon) |
| Windows | x86_64 |

WSL (Windows Subsystem for Linux) and Git Bash on Windows are also supported and
use the Linux install path.

### LLVM

LLVM 17+ is required by the Sailfin compiler. **The installer and release binaries do not bundle LLVM/clang** — you must have them installed on your system even when installing via the script. If you are building the compiler from source, see the [Building from source](#building-from-source) section below for additional details.

### C toolchain / linker

To install Sailfin via the script or a prebuilt release binary, you do **not** need a C toolchain; the installer does not invoke `gcc` or `clang`.

However, the Sailfin CLI uses a C toolchain (typically `clang` plus a system linker) to produce native executables. If you plan to compile, run, or test Sailfin programs on Linux or macOS, you must have a working `clang`/LLVM toolchain installed.

A C linker is also required when building the Sailfin compiler itself from source. See [Building from source](#building-from-source) for details.

---

## Quick Install (recommended)

### Linux and macOS

Paste the following into a terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.sh | bash
```

The script will:
1. Detect your OS and architecture
2. Download the latest stable release binary from GitHub Releases
3. Install `sailfin` and `sfn` to `~/.local/bin`
4. Print confirmation when complete

Example output:

```
Detected: linux/x86_64
Downloading sailfin v0.1.1-alpha.135...
Installed sailfin -> /home/you/.local/bin/sailfin
Installed sfn    -> /home/you/.local/bin/sfn
Done. Run 'sfn --version' to verify.
```

### Windows (PowerShell)

Paste the following into a PowerShell terminal (PowerShell 5.1+ or PowerShell 7+):

```powershell
irm https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.ps1 | iex
```

The script installs `sailfin.exe` and `sfn.exe` to
`%LOCALAPPDATA%\sailfin\bin` and adds that directory to your user `PATH`
automatically. You do not need to run PowerShell as Administrator.

Example output:

```
Detected: windows/x86_64
Downloading sailfin v0.1.1-alpha.135...
Installed sailfin.exe -> C:\Users\you\AppData\Local\sailfin\bin\sailfin.exe
Installed sfn.exe     -> C:\Users\you\AppData\Local\sailfin\bin\sfn.exe
Added C:\Users\you\AppData\Local\sailfin\bin to user PATH.
Done. Restart your terminal, then run 'sfn --version' to verify.
```

> **Windows users:** Restart your terminal after installation so that the updated
> `PATH` takes effect. If you use Windows Terminal, close and reopen the window.

---

## Verifying the Installation

After installing, run:

```bash
sfn --version
```

Expected output:

```
sailfin v0.1.1-alpha.135
```

If the command is not found, see [Troubleshooting](#troubleshooting) below.

---

## Pinning a Version

The pinned stable version for Sailfin development is **`v0.1.1-alpha.135`**.
Releases past this point are pre-stabilization builds and may have known issues.
Unless you have a specific reason to use a newer build, pin to the stable version.

### Linux and macOS

```bash
VERSION=0.1.1-alpha.135 curl -fsSL https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.sh | bash
```

Note the placement of `VERSION=...` before `curl`. This passes the variable into
the curl subprocess's environment, which the install script reads.

### Windows (PowerShell)

```powershell
$env:VERSION = "0.1.1-alpha.135"
irm https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.ps1 | iex
```

Set `$env:VERSION` before invoking `iex` so the script reads it.

> **Why pin?** The Sailfin project is marching toward a 1.0 release. Intermediate
> alpha builds may include regressions as large parts of the compiler are rewritten.
> `v0.1.1-alpha.135` is the version CI uses as its seed compiler and is the most
> thoroughly validated build available.

---

## What Gets Installed

The installer places two binaries in the install directory. They are identical —
`sfn` is a shorter alias for `sailfin`:

| Binary | Purpose |
|---|---|
| `sailfin` | The full compiler and toolchain |
| `sfn` | Alias for `sailfin`; most examples and docs use `sfn` |

### Default install locations

| Platform | Directory |
|---|---|
| Linux / macOS | `~/.local/bin` |
| Windows | `%LOCALAPPDATA%\sailfin\bin` |

You can override the install directory by setting `GLOBAL_BIN_DIR` before running
the script:

```bash
GLOBAL_BIN_DIR=/usr/local/bin curl -fsSL https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.sh | bash
```

### Confirming the binaries are on PATH

```bash
which sfn
# /home/you/.local/bin/sfn

sfn --version
# sailfin v0.1.1-alpha.135
```

On Windows:

```powershell
Get-Command sfn
# CommandType  Name   Source
# Application  sfn    C:\Users\you\AppData\Local\sailfin\bin\sfn.exe
```

---

## Manual Installation

If you cannot run the install script (e.g., in an air-gapped environment), you
can download and place the binary manually.

### Step 1: Find the release asset

Go to [github.com/SailfinIO/sailfin/releases](https://github.com/SailfinIO/sailfin/releases)
and locate the release for `v0.1.1-alpha.135`. Release assets follow this naming
convention:

```
sailfin_<version>_<os>_<arch>.tar.gz
```

Examples:

| Asset name | Platform |
|---|---|
| `sailfin_0.1.1-alpha.135_linux_x86_64.tar.gz` | Linux x86_64 |
| `sailfin_0.1.1-alpha.135_linux_arm64.tar.gz` | Linux arm64 |
| `sailfin_0.1.1-alpha.135_darwin_x86_64.tar.gz` | macOS Intel |
| `sailfin_0.1.1-alpha.135_darwin_arm64.tar.gz` | macOS Apple Silicon |
| `sailfin_0.1.1-alpha.135_windows_x86_64.tar.gz` | Windows x86_64 |

### Step 2: Extract and place the binary

```bash
# Download (replace the filename with the one that matches your platform)
curl -LO https://github.com/SailfinIO/sailfin/releases/download/v0.1.1-alpha.135/sailfin_0.1.1-alpha.135_linux_x86_64.tar.gz

# Extract
tar -xzf sailfin_0.1.1-alpha.135_linux_x86_64.tar.gz

# The archive contains bin/sailfin and bin/sfn
# Move them to a directory on your PATH
mkdir -p ~/.local/bin
cp bin/sailfin ~/.local/bin/sailfin
cp bin/sfn     ~/.local/bin/sfn
chmod +x ~/.local/bin/sailfin ~/.local/bin/sfn
```

### Step 3: Verify

```bash
sfn --version
# sailfin v0.1.1-alpha.135
```

---

## Building from Source

Building from source is useful when:
- You are contributing to the compiler
- You need a build for an unsupported platform
- You want to test unreleased changes

### Prerequisites

- `git`
- LLVM 17+ (`llvm-17` or `llvm-18` packages on most Linux distributions; Homebrew `llvm` on macOS)
- A C compiler: `gcc` or `clang`
- `make`

### Steps

```bash
# Clone the repository
git clone https://github.com/SailfinIO/sailfin.git
cd sailfin

# Build the native compiler by self-hosting from the released seed
make compile

# Install to ~/.local/bin (or set PREFIX to override)
make install
```

After `make install`, verify with:

```bash
sfn --version
```

You can also run the binary directly without installing:

```bash
build/native/sailfin --version
```

> **Note:** `make compile` uses the shell build driver by default
> (`BUILD_DRIVER=sh`), which runs `scripts/build.sh`. To match CI's Python
> self-host path (`scripts/selfhost_native.py`), set `BUILD_DRIVER=py`, for
> example: `BUILD_DRIVER=py make compile`.

---

## Updating

To update to the latest release, re-run the install script. It overwrites the
existing binaries in-place:

```bash
# Linux / macOS: update to latest
curl -fsSL https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.sh | bash

# Linux / macOS: update to a specific version
VERSION=0.1.1-alpha.135 curl -fsSL https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.sh | bash
```

```powershell
# Windows: update to latest
irm https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.ps1 | iex
```

As with the initial install, pinning to a known stable version is recommended
over updating to the absolute latest build.

---

## Uninstalling

Delete the binaries from the install directory:

```bash
# Linux / macOS
rm ~/.local/bin/sailfin ~/.local/bin/sfn
```

```powershell
# Windows
Remove-Item "$env:LOCALAPPDATA\sailfin\bin\sailfin.exe"
Remove-Item "$env:LOCALAPPDATA\sailfin\bin\sfn.exe"
```

You may also want to remove `%LOCALAPPDATA%\sailfin` (Windows) or the now-empty
`~/.local/bin` entries from your shell profile, if applicable.

---

## Troubleshooting

### `sfn: command not found` after installation

The install directory is not on your `PATH`. Check which shell you are using and
add the directory:

**bash** (`~/.bashrc` or `~/.bash_profile`):

```bash
export PATH="$HOME/.local/bin:$PATH"
```

**zsh** (`~/.zshrc`):

```zsh
export PATH="$HOME/.local/bin:$PATH"
```

After editing the file, reload it:

```bash
source ~/.bashrc   # or ~/.zshrc
```

On macOS, if you installed globally to `/usr/local/bin`, that directory is usually
already on PATH. Confirm with `echo $PATH`.

### Permission denied when running the binary (Linux / macOS)

The binary may not be marked executable. Fix it:

```bash
chmod +x ~/.local/bin/sailfin ~/.local/bin/sfn
```

### `LLVM not found` error

This error only occurs when **building from source**. Install LLVM 17+:

```bash
# Ubuntu / Debian
sudo apt-get install llvm-17 clang-17

# Fedora / RHEL
sudo dnf install llvm17 clang17

# macOS (Homebrew)
brew install llvm
```

If LLVM is installed but not detected, set the path explicitly:

```bash
LLVM_PREFIX=/usr/lib/llvm-17 make compile
```

Pre-built release binaries require LLVM 17+ to be installed on your system
(see [LLVM](#llvm) above).

### GitHub API rate limiting during install

The install script calls the GitHub Releases API to find the latest version. If
you hit rate limits (common in CI environments), set a GitHub token:

```bash
GITHUB_TOKEN=ghp_your_token_here curl -fsSL https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.sh | bash
```

Alternatively, pin the version explicitly with `VERSION=0.1.1-alpha.135` — this
skips the API call and downloads the asset directly.

### Windows: script execution policy

If PowerShell refuses to run the install script, you may need to allow remote
scripts for the current session:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
irm https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.ps1 | iex
```

This change only affects the current PowerShell session and does not persist.

---

## Next Steps

- [Editor Setup](/docs/getting-started/editor-setup) — Install the Sailfin VS Code extension for syntax highlighting and snippets
- [Hello, World!](/docs/getting-started/hello-world) — Write and run your first Sailfin program
- [Tour of Sailfin](/docs/getting-started/tour) — A guided introduction to the language
