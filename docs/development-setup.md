# Compiler and runtime development setup

This page is the source-oriented setup guide for people working on the Sailfin
compiler (`compiler/src/`) and Sailfin-native runtime (`runtime/prelude.sfn`,
`runtime/sfn/`). End users who only need a released `sfn` binary should use the
install guide on the docs site.

The compiler self-hosts from the exact released seed pinned in
`bootstrap.toml [seed].version`. The build downloads that seed into
`build/toolchains/seed/` and produces the local compiler at `build/bin/sfn`.

## Supported hosts

Linux and macOS are the primary development hosts for compiler/runtime work.
Windows release artifacts are built through the cross-Windows target from
Linux; for day-to-day compiler work on Windows, use WSL or a Linux/macOS
machine unless you are specifically working on the Windows toolchain path.

Windows x86_64 is a **Tier 3 — best effort** target
(`docs/conventions/target-tiers.md`): there is no supported native Windows
build of the compiler from source, and neither `make compile` nor the test
suite runs on Windows. Native MSVC self-hosting is tracked by SFEP-0021.
Treat WSL as the supported path — it runs the Tier 1 Linux x86_64 toolchain.

The current backend lowers Sailfin IR through LLVM and links with the platform
toolchain. LLVM/clang independence is planned work, not the current build path.

## Required tools

Install these before running `make compile`:

| Tool | Why it is needed |
|---|---|
| `git` | Clone and inspect the repository. |
| `bash` | The Makefile intentionally runs recipes under bash. |
| `make` | Top-level build and validation targets. |
| `curl`, `tar`, `mktemp`, `uname` | Release installer and seed download plumbing. |
| `jq` | GitHub release JSON parsing in `install.sh` / `make fetch-seed`. |
| OpenSSL 3.0+ | `install.sh` signature verification (Ed25519 `pkeyutl -rawin`, SFN-1034); probed via `$SAILFIN_OPENSSL`, `PATH`, or a Homebrew `openssl@3` keg. |
| LLVM tools 17+ or 18+ | LLVM IR validation and assembly tools such as `llvm-as`. |
| `clang` | Assemble LLVM IR and link native executables. |
| `shasum` or `sha256sum` | Seed/self-host hash checks. `shasum -a 256` is the portable default. |

Optional tools:

| Tool | Why it is useful |
|---|---|
| GNU `timeout` (`timeout` / `gtimeout`) | Bounds direct compiler invocations and some Makefile validation paths. |
| `npm` | Required only for the TypeScript MCP server under `tools/mcp-server/`. |
| `x86_64-w64-mingw32-gcc` | Required for `sfn build --target=x86_64-w64-mingw32`. |

## Install dependencies

### Ubuntu / Debian

```bash
sudo apt-get update
sudo apt-get install -y \
  bash build-essential clang-18 curl git jq lld make \
  tar llvm-18
```

If your distribution does not package LLVM 18, LLVM 17 is acceptable:

```bash
sudo apt-get install -y clang-17 llvm-17
```

Set `CLANG=clang-17` or `CLANG=clang-18` when you need to force a specific
compiler binary.

### Fedora / RHEL

```bash
sudo dnf install -y \
  bash clang git jq llvm llvm-devel make tar
```

Package names vary across Fedora/RHEL releases. The important checks are that
`clang`, `llvm-link`, `llvm-as`, and `jq` are available on `PATH` or the system
library search path.

### macOS

```bash
xcode-select --install
brew install jq llvm
```

Add Homebrew LLVM tools to your shell path so `llvm-link` and `llvm-as` are
available:

```bash
export PATH="$(brew --prefix llvm)/bin:$PATH"
```

The native build driver uses the PATH-selected LLVM tools for object assembly,
but resolves final Darwin links through Apple's `/usr/bin/clang`. This lets
Homebrew LLVM stay first on `PATH` without handing its clang driver ownership of
the macOS SDK/linker contract, and it survives the Makefile's retirement.
Override the final-link driver with `SAILFIN_CC=/path/to/clang` only when you
know the replacement can link system libraries. The Makefile's transitional
shim applies the same default while it still exists.

## Build and verify

```bash
git clone https://github.com/SailfinIO/sailfin.git
cd sailfin

# Download the exact seed pinned by bootstrap.toml, if it is not present.
make fetch-seed

# Build build/bin/sfn from the released seed.
make compile

# Fast parse/type/effect check over compiler + runtime sources.
make check-fast

# Run the full Sailfin-native test suite with the built compiler.
make test

# Full self-host validation gate. This is the authoritative pre-merge check.
make check
```

`make compile` fetches the pinned seed automatically when needed, so running
`make fetch-seed` first is optional. It is useful when validating network or
GitHub token setup separately.

After a successful build:

```bash
build/bin/sfn --version
build/bin/sfn run examples/basics/hello-world.sfn
build/bin/sfn fmt --check compiler/src runtime
```

Install the built compiler into `~/.local/bin` through the native toolchain:

```bash
build/bin/sfn dev bootstrap install --from build/bin/sfn --prefix "$HOME/.local"
```

Change `--prefix` to install somewhere else. Packagers can stage the same
layout with `--destdir <staging-root>`; for example,
`--prefix /usr/local --destdir /tmp/sfn-package` writes
`/tmp/sfn-package/usr/local/bin/sfn` (`.exe` on Windows). A direct prefix
install refuses to overwrite an unmarked or externally changed entry because
it may be package-manager-owned. The command also installs the local runtime
and compiler dependency closure beside the binary, so the PATH command can
build and run programs outside this checkout.

## Common workflows

| Task | Command |
|---|---|
| Fast compiler/runtime sanity check | `make check-fast` |
| Rebuild after compiler/runtime edits | `make compile` |
| Force rebuild from the seed | `make rebuild` |
| Full validation before PR | `make check` |
| CI-strict self-host fixed point | `make check-strict` or `make check SELFHOST_STRICT=1` |
| Unit tests only | `make test-unit` |
| Integration tests only | `make test-integration` |
| End-to-end tests only | `make test-e2e` |
| Capsule tests only | `make test-capsules` |
| Format touched compiler/runtime files | `build/bin/sfn fmt --write <files>` then `build/bin/sfn fmt --check <files>` |
| Package release artifacts | `make package` |
| Build MCP server | `(cd tools/mcp-server && npm ci --no-audit --no-fund && npm run build)` |
| Cross-compile Windows artifact | `build/bin/sfn build --target=x86_64-w64-mingw32 -p compiler -o build/windows/sailfin.exe` |

Before committing changes under `compiler/src/` or `runtime/`, run
`make compile` before test-only validation so tests do not run against a stale
compiler binary.

## Supported Makefile overrides

These are the supported knobs for source builds and local validation. Prefer
command-line Make variables for one-off runs and environment variables for
shell-wide behavior.

`make test`/`make check` invocations (and direct `sfn test` calls) auto-size
their per-file worker pool from CPU and RAM. Pin `SAILFIN_TEST_JOBS=N` for a
shell or CI job — it covers `make check`'s cold seedcheck leg too — or pass
`--jobs N` for one invocation; the explicit flag wins, and `--jobs 1` selects
the serial path.

| Override | Applies to | Default | Notes |
|---|---|---|---|
| `SEED_VERSION` | `make fetch-seed` | `bootstrap.toml [seed].version` | Fetch a different released seed intentionally. Normal development should use the checked-in pin. |
| `SEED` | `make rebuild` | `build/toolchains/seed/bin/sfn` | Path or command name for the seed compiler. |
| `SEED_NATIVE` | `make rebuild` | unset | One-off seed path override used by CI and seed-bisect work. Takes precedence over `SEED` inside `rebuild`. |
| `BUILD_ARGS` | `make rebuild` | empty | Extra args passed to `sfn build -p compiler`, for example `BUILD_ARGS="--no-cache --cache-trace"`. |
| `JSON=1` | agent-facing Make targets | off | Writes structured reports under `build/agent-report.*.json` and related JSONL files. |
| `NATIVE_BIN` | test/bench/check targets | `build/bin/sfn` | Select which built compiler binary those targets run. |
| `NATIVE_OUT` | `make rebuild` | `build/bin/sfn` | Destination path for the rebuilt compiler. |
| `CLANG` | Makefile clang calls | `clang` | Clang executable for Makefile-owned compilation/link steps. On Linux CI this is often `clang-18`. |
| `SAILFIN_CC` | Native macOS final links and transitional Makefile recipes | `/usr/bin/clang` | Explicit Darwin clang-driver override; object assembly still follows `PATH`. |
| `CLANG_LL_FLAGS` | LLVM IR compilation | empty | Extra flags when compiling `.ll`; use only for platform quirks such as opaque-pointer mode. |
| `NATIVE_LL_TIMEOUT_SECONDS` | LLVM IR compilation | `600` | Wall-clock cap for individual clang jobs when `timeout` is available. |
| `CHECK_TEST_TIMEOUT` | `make check` | `1800` | Per-test timeout for the cold full-suite leg. |
| `CHECK_FULL_PASS1=1` | `make check` | off | Restores the older full first-pass suite before seedcheck; useful for bisects. |
| `SELFHOST_STRICT=1` | `make check` | off locally | Makes a seedcheck/fixed-point rebuild mismatch fatal. `make check-strict` sets it. |
| `TEST_BIN_CACHE_FLAGS` | `make test` | empty | Extra flags for `sfn test`; `make check` sets `--no-test-cache`. |
| `BENCH_ARGS` | `make bench` | empty | Extra args for compiler compile-time benchmarks. |
| `BENCH_RUNTIME_ARGS` | `make bench-runtime` | empty | Extra args for runtime execution benchmarks. |
| `ARENA_ARGS` | `make test-arena` | empty | Args forwarded to the native arena IR gate (`sfn dev arena`), e.g. `--all` or a module path. |
| `KEEP_SEED=0` | `make clean-build` | keep seed | Also removes `build/toolchains/` during cleanup. |

`BUILD_JOBS`, `NATIVE_OPT`, and `SELFHOST1_OPT` still exist in the Makefile for
legacy/CI compatibility, but the normal self-host build now routes through
`sfn build -p compiler`; do not rely on those as user-facing tuning knobs for a
local source build unless you are changing the build driver itself.

## Supported `sfn build` flags

These are the build flags exposed by the compiler CLI:

```text
sfn build [-o OUTPUT] [-p PATH] [--target=<triple>] [--no-cache] [--clean] [--cache-trace] [--json] [--work-dir DIR] [--check-determinism] [--skip-toolchain-check] (<file.sfn> | -p <capsule-path>)
```

| Flag | Meaning |
|---|---|
| `-o OUTPUT` | Write the built executable to `OUTPUT`. |
| `-p <capsule-path>` | Build a capsule by path instead of a single file. |
| `--target=<triple>` | Build for a supported target triple, including `x86_64-w64-mingw32`. |
| `--no-cache` | Bypass the build artifact cache for this invocation. |
| `--clean` | Clean build outputs before compiling. |
| `--cache-trace` | Print cache hit/miss diagnostics. |
| `--json` | Emit the structured build report. Used by CI and agent report tooling. |
| `--work-dir DIR` | Use `DIR` for build scratch/output state. |
| `--check-determinism` | Run the build determinism check. |
| `--skip-toolchain-check` | Bypass the `[toolchain]` pin check for this invocation. |

Related compiler commands expose their own flags:

| Command | Supported flags |
|---|---|
| `sfn check` | `--quiet`, `--json`, `--allow-bare-assert`, `--skip-toolchain-check` |
| `sfn run` | `--no-cache`, `--clean`, `--cache-trace`, `--skip-toolchain-check` |
| `sfn test` | `--json`, `-k NAME`, `--tag TAG`, `--update-snapshots`, `--no-test-cache`, `--jobs N`, `--shard I/N`, `--skip-toolchain-check` |
| `sfn fmt` | `--check`, `--write` |
| `sfn emit` | `--timing`, `-o OUTPUT`, `--module-name SLUG`, `--import-context DIR`, `--attempts N`, `--no-retry`, `--validate`, `--no-validate`, `--no-resolve-gate` |
| `sfn package` | `--target T`, `--out DIR`, `--compiler-bin PATH`, `--installer`, `-p <capsule-path>` |

## Runtime and toolchain environment variables

| Variable | Values | Notes |
|---|---|---|
| `SAILFIN_MEM_LIMIT` | bytes, `unlimited`, `off`, `0` | Linux compiler invocations self-apply an 8 GiB virtual-memory cap by default. This overrides or disables it. |
| `SAILFIN_TRACE_MEM_LIMIT` | `1` | Trace memory-limit setup. |
| `SAILFIN_RUNTIME_ROOT` | path | Override where `sfn` resolves bundled runtime sources. Usually only for packaging/debugging. |
| `SAILFIN_TOOLCHAIN` | `auto`, `local`, `<version>`, `off`, `0` | Toolchain pin dispatch policy for user capsules. Use `off` only for seed-transition work. |
| `SAILFIN_SKIP_TOOLCHAIN_CHECK` | `1` | Downgrade a user capsule `[toolchain]` mismatch to a warning. |
| `SAILFIN_BUILD_JOBS` | positive integer | Override compiler module scheduling inside `sfn build -p compiler`; use `1` for serial bisects or a small value on memory-constrained hosts. |
| `SAILFIN_BUILD_CACHE_DIR` | path | Override the content-addressed build artifact cache root for user builds/tests. |
| `SAILFIN_EFFECT_ENFORCE` | `error`, `warning`, `off` | Transitional effect checker severity; default is error. |
| `SAILFIN_TRACE_LINK` | `1` | Print resolved clang/link command details. |
| `SAILFIN_CACHE_TRACE` | `1` | Equivalent cache tracing path used by build/run internals. |
| `SAILFIN_TEST_TIMEOUT` | seconds | Per-test timeout consumed by `sfn test`; `make check` sets this from `CHECK_TEST_TIMEOUT`. |
| `SAILFIN_TEST_KEEP_SCRATCH` | `1` | Keep `sfn test` scratch directories for post-mortem debugging. |
| `SAILFIN_TEST_SCRATCH` | path | Force the scratch root for tests/self-host isolation. |

Debug and fault-injection variables under `SAILFIN_TRACE_*`,
`SAILFIN_DEBUG_*`, and `SAILFIN_INJECT_*` are compiler-internal unless a doc or
runbook explicitly marks them supported.

## Troubleshooting

### `Required command 'jq' is not installed`

Install `jq`. The installer uses it for GitHub release selection, including
repo-local seed downloads.

### `llvm-link` or `llvm-as` is not found

Install LLVM 17+ or 18+ and make sure its `bin` directory is on `PATH`. On
macOS with Homebrew:

```bash
export PATH="$(brew --prefix llvm)/bin:$PATH"
```

### `make compile` says the compiler is up to date

`make compile` skips rebuilds when `build/bin/sfn` is newer than all
`compiler/src/**/*.sfn` and `runtime/**/*.sfn` files. Use `make rebuild` to
force a rebuild from the seed.

### Source changes fail tests unexpectedly

If you touched `compiler/src/` or `runtime/`, rebuild first:

```bash
make compile
make test
```

For structural changes such as file splits, renamed exports, or module graph
changes, start with a clean build:

```bash
make clean-build
make compile
```
