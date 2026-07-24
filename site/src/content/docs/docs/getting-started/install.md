---
title: Installing Sailfin
description: Install the Sailfin compiler and toolchain on Linux, macOS, or Windows.
section: getting-started
sidebar:
  order: 1
---

> **Just want the binary?** Head to the [Downloads](/dl) page for pre-built
> binaries for every supported platform, or keep reading for the recommended
> install script.

## Requirements

Sailfin runs on the following platforms:

| Platform | Architectures |
|---|---|
| Linux | x86_64, arm64 |
| macOS | x86_64, arm64 (Apple Silicon) |
| Windows | x86_64 |

WSL (Windows Subsystem for Linux) and Git Bash on Windows are also supported and
use the Linux install path.

### Compiler and linker tools

The installer only downloads and places the released `sfn` binary. To compile,
run, or test Sailfin programs, the current backend still needs LLVM tools 17+
or 18+ plus `clang` and the platform linker. Release binaries do not bundle
LLVM/clang.

The installer script itself also requires `curl`, `tar`, `uname`, `mktemp`, and
`jq` on Linux/macOS because it selects release assets through the GitHub API.

If you are building Sailfin itself from source, you also need `bash`, `make`,
OpenSSL development libraries, and the source-build dependencies listed in
[Building from source](#building-from-source).

---

## Quick Install (recommended)

### Linux and macOS

Paste the following into a terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.sh | bash
```

The script will:
1. Detect your OS and architecture
2. Download the latest matching release binary from GitHub Releases
3. Install `sailfin` and `sfn` to `~/.local/bin`
4. Print confirmation when complete

> **Bootstrap security:** The install script embeds the Sailfin release-signing
> public key and verifies the release before extracting anything: it downloads
> `SHA256SUMS` and `SHA256SUMS.sig`, checks the Ed25519 manifest signature and
> the archive's SHA-256 digest, and aborts on any mismatch. It warns and
> continues only when verification is unavailable (an older unsigned release, or
> no OpenSSL with raw-Ed25519 support). To verify manually instead, follow
> [Verifying Your Download](/docs/getting-started/verify-download). Subsequent
> `sfn toolchain install` downloads verify both the Ed25519 signature and SHA-256
> digest automatically (fail-closed).

Example output:

```
Detected: linux/x86_64
Downloading sfn <version>...
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
Downloading sfn <version>...
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
sfn <version>
```

If the command is not found, see [Troubleshooting](#troubleshooting) below.

---

## Pinning a Version

Sailfin is pre-1.0, so pin exact release versions in CI and reproducible setup
scripts. Omit `VERSION` for the latest release asset that matches your platform.
Compiler repository development uses the exact seed version in
[`bootstrap.toml`](https://github.com/SailfinIO/sailfin/blob/main/bootstrap.toml),
not a hard-coded docs-page version.

### Linux and macOS

Replace the example version with the release you want to pin:

```bash
VERSION=0.8.0-alpha.5
curl -fsSL https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.sh | VERSION="$VERSION" bash
```

You can also pass the version as an install-script argument:

```bash
VERSION=0.8.0-alpha.5
curl -fsSL https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.sh | bash -s -- --version "$VERSION"
```

### Windows (PowerShell)

Replace the example version with the release you want to pin:

```powershell
$env:VERSION = "0.8.0-alpha.5"
irm https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.ps1 | iex
```

Set `$env:VERSION` before invoking `iex` so the script reads it.

> **Why pin?** The Sailfin project is marching toward a 1.0 release. Alpha
> builds may include regressions as large parts of the compiler and runtime are
> rewritten. Pinning gives CI and onboarding scripts a reproducible toolchain.

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
curl -fsSL https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.sh | GLOBAL_BIN_DIR=/usr/local/bin bash
```

### Confirming the binaries are on PATH

```bash
which sfn
# /home/you/.local/bin/sfn

sfn --version
# sfn <version>
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
can download and place the binary manually. The [Downloads](/dl) page lists
every platform binary with direct download links.

### Step 1: Find the release asset

Go to the [Downloads](/dl) page or directly to
[github.com/SailfinIO/sailfin/releases](https://github.com/SailfinIO/sailfin/releases)
and locate the release you want to install. Release assets follow this naming
convention:

```
sailfin_<version>_<os>_<arch>.tar.gz
```

Examples:

| Asset name | Platform |
|---|---|
| `sailfin_${VERSION}_linux_x86_64.tar.gz` | Linux x86_64 |
| `sailfin_${VERSION}_macos_arm64.tar.gz` | macOS Apple Silicon |
| `sailfin_${VERSION}_windows_x86_64.tar.gz` | Windows x86_64 |

### Step 2: Verify the download

Download the tarball together with `SHA256SUMS` and `SHA256SUMS.sig`, then
verify the manifest signature and the tarball digest before extracting it. The
[download verification guide](/docs/getting-started/verify-download) provides
copy-pasteable OpenSSL commands and publishes the canonical signing key and
fingerprint.

```bash
VERSION=0.8.0

# Download (replace the filename with the one that matches your platform)
curl -LO "https://github.com/SailfinIO/sailfin/releases/download/v${VERSION}/sailfin_${VERSION}_linux_x86_64.tar.gz"
curl -LO "https://github.com/SailfinIO/sailfin/releases/download/v${VERSION}/SHA256SUMS"
curl -LO "https://github.com/SailfinIO/sailfin/releases/download/v${VERSION}/SHA256SUMS.sig"
```

Do not extract the archive unless both verification steps succeed.

### Step 3: Extract and place the binary

```bash
VERSION=0.8.0

# Extract
tar -xzf "sailfin_${VERSION}_linux_x86_64.tar.gz"

# The archive contains bin/sailfin and bin/sfn
# Move them to a directory on your PATH
mkdir -p ~/.local/bin
cp bin/sailfin ~/.local/bin/sailfin
cp bin/sfn     ~/.local/bin/sfn
chmod +x ~/.local/bin/sailfin ~/.local/bin/sfn
```

### Step 4: Verify the installed command

```bash
sfn --version
# sfn <version>
```

---

## Building from Source

Building from source is useful when:
- You are contributing to the compiler
- You need a build for an unsupported platform
- You want to test unreleased changes

### Prerequisites

- `git`, `bash`, `make`
- `curl`, `tar`, `mktemp`, `uname`, `jq`
- LLVM tools 17+ or 18+ (`llvm-link`, `llvm-as`)
- `clang` and the platform linker
- OpenSSL development libraries (`libssl-dev`, `openssl-devel`, or Homebrew `openssl@3`)
- `shasum -a 256` or `sha256sum`

See the
[compiler/runtime development setup](https://github.com/SailfinIO/sailfin/blob/main/docs/development-setup.md)
for per-platform package commands and the complete supported build flag table.

### Steps

```bash
# Clone the repository
git clone https://github.com/SailfinIO/sailfin.git
cd sailfin

# Build the native compiler by self-hosting from the released seed pinned in bootstrap.toml
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
build/bin/sfn --version
```

> **Note:** `make compile` routes through `<seed> build -p compiler` — the
> Sailfin-native driver — and requires `bash`, `clang`, LLVM tools, `jq`, and
> OpenSSL development libraries. The prior `scripts/build.sh` orchestrator is
> no longer in-tree.

---

## Updating

To update to the latest release, re-run the install script. It overwrites the
existing binaries in-place:

```bash
# Linux / macOS: update to latest
curl -fsSL https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.sh | bash

# Linux / macOS: update to a specific version
VERSION=0.8.0-alpha.5
curl -fsSL https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.sh | VERSION="$VERSION" bash
```

```powershell
# Windows: update to latest
irm https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.ps1 | iex
```

As with the initial install, pinning to a known release version is recommended
for CI and reproducible environments.

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

### Missing LLVM, clang, or OpenSSL during a build

Install the source-build dependencies for your platform:

```bash
# Ubuntu / Debian
sudo apt-get install clang-18 llvm-18 libssl-dev jq

# Fedora / RHEL
sudo dnf install clang llvm llvm-devel openssl-devel jq

# macOS (Homebrew)
brew install jq llvm openssl@3
```

If Homebrew LLVM is installed but `llvm-link` is not detected, put it on `PATH`:

```bash
export PATH="$(brew --prefix llvm)/bin:$PATH"
```

If macOS cannot find OpenSSL at link time, set:

```bash
export SAILFIN_OPENSSL_PREFIX="$(brew --prefix openssl@3)"
```

### GitHub API rate limiting during install

The install script calls the GitHub Releases API to find the latest version. If
you hit rate limits (common in CI environments), set a GitHub token:

```bash
curl -fsSL https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.sh | GITHUB_TOKEN=ghp_your_token_here bash
```

Alternatively, pin the version explicitly with `VERSION=<version>` — this
constructs the asset name directly and can avoid the release-list lookup.

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

- [Downloads](/dl) — Pre-built binaries for every platform
- [Verifying Your Download](/docs/getting-started/verify-download) — Verify release signatures and checksums
- [Editor Setup](/docs/getting-started/editor-setup) — Install the Sailfin VS Code extension for syntax highlighting and snippets
- [Hello, World!](/docs/getting-started/hello-world) — Write and run your first Sailfin program
- [Tour of Sailfin](/docs/getting-started/tour) — A guided introduction to the language
