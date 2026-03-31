---
title: CLI Reference
description: Complete reference for the sfn command-line interface and Makefile build system.
section: reference
order: 6
---

## Overview

The `sfn` binary is the primary interface to the Sailfin toolchain. It compiles, runs, and tests Sailfin programs. The binary is also available as `sailfin`; both names refer to the same executable.

```bash
sfn <command> [options] [arguments]
```

The current version can always be confirmed with `sfn --version`.

---

## Commands

### `sfn run <file>`

Compile and execute a Sailfin source file in a single step. The file is compiled to a temporary binary and executed immediately. No output file is produced.

**Usage:**

```bash
sfn run <file.sfn> [-- program-args...]
```

**Examples:**

```bash
sfn run hello.sfn
sfn run examples/basics/hello-world.sfn
sfn run src/main.sfn -- --port 8080
```

**Behavior:**

- Compiles the source file from scratch on each invocation.
- Effect annotations are checked at compile time; missing effects produce diagnostics with source spans and fix-it hints.
- The program runs in the same terminal session; stdout and stderr are connected to the calling terminal.
- Exit code of `sfn run` reflects the exit code of the program.

---

### `sfn test [path]`

Discover and run Sailfin test files. Test files follow the `*_test.sfn` naming convention. Without a path argument, `sfn test` discovers all `*_test.sfn` files under the current directory.

**Usage:**

```bash
sfn test [path] [--filter <pattern>]
```

**Options:**

| Flag | Description |
|---|---|
| `--filter <pattern>` | Run only tests whose name matches `pattern` (substring match) |

**Examples:**

```bash
sfn test                                  # run all *_test.sfn files found
sfn test compiler/tests/unit/             # run tests in a specific directory
sfn test compiler/tests/unit/arrays_test.sfn  # run a single test file
sfn test --filter "substring"             # run tests whose name contains "substring"
```

**Test file conventions:**

- Test files must be named `*_test.sfn`.
- Each test is declared with the `test` keyword:

```sfn
test "addition is commutative" {
    assert add(2, 3) == add(3, 2);
}
```

- Test results are reported with pass/fail counts and source locations for failures.
- A non-zero exit code is returned if any test fails.

---

### `sfn compile <file>`

Compile a Sailfin source file without running it. Writes an executable to the output path (default: the source filename without `.sfn` in the current directory).

**Usage:**

```bash
sfn compile <file.sfn> [-o <output>]
```

**Options:**

| Flag | Description |
|---|---|
| `-o <output>` | Write the compiled binary to `output` instead of the default path |

**Examples:**

```bash
sfn compile src/main.sfn
sfn compile src/main.sfn -o build/myapp
```

**Subcommand: `emit native`**

The native compiler also supports emitting `.sfn-asm` intermediate representation for inspection:

```bash
sfn emit native compiler/src/version.sfn
```

This is primarily used by the self-hosting build scripts.

---

### `sfn --version`

Display the compiler version string and exit with code 0.

**Usage:**

```bash
sfn --version
```

**Example output:**

```
sailfin v0.4.0
```

The version string follows semantic versioning: `v<major>.<minor>.<patch>` for stable releases, `v<major>.<minor>.<patch>-alpha.<n>` for pre-releases.

---

## Planned CLI Commands

The following commands are planned for a future release. They are not available today.

| Command | Description |
|---|---|
| `sfn init [name]` | Scaffold a new Sailfin capsule with a `capsule.toml` manifest |
| `sfn add <capsule>` | Add a dependency to the current capsule |
| `sfn publish` | Publish the current capsule to the package registry |
| `sfn fmt [path]` | Format Sailfin source files in place |
| `sfn check [path]` | Type-check and effect-check without compiling to a binary |

---

## Build System

The repository Makefile provides higher-level build orchestration for the self-hosting workflow. These targets are for working on the Sailfin compiler itself; end users generally only need `sfn run` and `sfn test`.

### Complete target reference

| Target | Description |
|---|---|
| `make compile` | Build the native compiler binary from a released seed, using the self-hosting pipeline. Skips rebuild if the binary is up to date. |
| `make rebuild` | Force a rebuild from a released seed regardless of timestamps. Uses `BUILD_DRIVER` to select the shell or Python build driver (default: `sh`). |
| `make rebuild-sh` | Force rebuild using the shell build driver (`scripts/build.sh`). No Python or Conda required. |
| `make rebuild-py` | Force rebuild using the legacy Python build driver (`scripts/selfhost_native.py`). Requires the `sailfin` Conda environment. |
| `make install` | Install the built compiler binary into `$(BINDIR)` (default: `~/.local/bin`). Requires `make compile` to have run first. |
| `make check` | Compile (if needed), build a `sailfin-seedcheck` binary, verify it can run `hello-world.sfn`, then run the full test suite against it. This is the authoritative CI gate. |
| `make smoke` | Rebuild + run smoke tests (hello-world + emit-llvm-file). Faster than `make check`. |
| `make smoke-sh` | Smoke test using the shell build driver. |
| `make smoke-py` | Smoke test using the Python build driver. |
| `make test` | Run the full Sailfin-native test suite (unit + integration + e2e). Requires `make compile` first. |
| `make test-unit` | Run unit tests from `compiler/tests/unit/*_test.sfn`. |
| `make test-integration` | Run integration tests from `compiler/tests/integration/*_test.sfn`. |
| `make test-e2e` | Run end-to-end tests from `compiler/tests/e2e/*_test.sfn`. |
| `make package` | Build and package native artifacts into `dist/`. Used for release artifacts. |
| `make fetch-seed` | Download the latest released seed compiler from GitHub Releases into `build/seed/`. Requires `GITHUB_TOKEN`. |
| `make env` | Create or update the `sailfin` Conda environment from `environment.yml`. Only needed when `BUILD_DRIVER=py`. |
| `make rebuild-asan` | Rebuild with AddressSanitizer instrumentation for memory error diagnostics. Requires the Python build driver. |
| `make clean` | Remove `dist/` packaged artifacts. Does not remove build intermediates. |
| `make clean-build` | Remove `build/` artifacts (keeps `build/seed/` by default). Pass `KEEP_SEED=0` to also remove the downloaded seed. |
| `make clean-all` | Remove both `dist/` and `build/` artifacts completely. |
| `make help` | Print a summary of available targets. |

---

### Build driver selection

The self-hosting build supports two drivers:

| Driver | Selection | Requirements | Notes |
|---|---|---|---|
| `sh` | `BUILD_DRIVER=sh` (default) | `clang`, `bash` | No Python or Conda required. Preferred for most development. |
| `py` | `BUILD_DRIVER=py` | Python, Conda, `sailfin` env | Legacy driver. Used in some CI configurations. |

Switch drivers:

```bash
make rebuild BUILD_DRIVER=sh   # shell driver (default)
make rebuild BUILD_DRIVER=py   # Python driver
```

---

### Parallelism

The build orchestrator compiles modules in parallel. Control the job count:

```bash
make rebuild BUILD_JOBS=4
```

The default is `BUILD_JOBS=1` to keep peak memory usage conservative. Increase on machines with abundant RAM.

---

## Environment Variables

These environment variables influence the behavior of `sfn` and the Makefile build system.

| Variable | Scope | Description |
|---|---|---|
| `SAILFIN_RUNTIME_ROOT` | `sfn` binary | Override the directory where `sfn` looks for the bundled C runtime. By default, the runtime is resolved relative to the executable. |
| `PREFIX` | Makefile | Installation prefix. Defaults to `$HOME/.local`. The binary is installed to `$(PREFIX)/bin`. |
| `GLOBAL_BIN_DIR` | Installer script | Override the installation bin directory directly (takes precedence over `PREFIX`). |
| `GITHUB_TOKEN` | `make fetch-seed` | GitHub personal access token used to download seed releases from the `SailfinIO/sailfin` repository. Required for `make fetch-seed`. |
| `BUILD_DRIVER` | Makefile | Select the build driver: `sh` (default, no Python) or `py` (legacy Python). |
| `BUILD_JOBS` | Makefile | Number of parallel compile jobs. Default: `1`. |
| `BUILD_ARGS` | Makefile | Extra arguments passed through to the build orchestrator script. |
| `SEED` | Makefile | Path to (or name of) the seed compiler used as the bootstrap. Defaults to `sfn` (resolved from `PATH`). |
| `SEED_VERSION` | Makefile | Version tag of the seed to fetch. Defaults to `latest`. |
| `NATIVE_OPT` | Makefile | Optimization level passed to `clang` when compiling LLVM IR. Defaults to `-O2`. |
| `CLANG` | Makefile | `clang` executable to use. Defaults to `clang`. |
| `KEEP_SEED` | `make clean-build` | Set to `0` to delete `build/seed/` during `make clean-build`. Defaults to `1` (seed is preserved). |

### Debug and trace variables

These variables enable verbose runtime diagnostics. They are intended for compiler development and troubleshooting, not end-user programs.

| Variable | Description |
|---|---|
| `SAILFIN_TRACE_ARGV` | Print the argument vector received by the native driver on startup. |
| `SAILFIN_TRACE_EMIT_LLVM` | Trace LLVM IR emission. |
| `SAILFIN_TRACE_EMIT_LLVM_PATH` | Write emitted LLVM IR to the given file path. |
| `SAILFIN_TRACE_CRASH` | Enable extended crash diagnostics. |
| `SAILFIN_TRACE_ALLOC_STATS` | Print allocation statistics on exit. |
| `SAILFIN_TRACE_LARGE_ARRAY_BACKTRACE` | Capture backtraces for unusually large array allocations. |
| `SAILFIN_DEBUG_DUMP_BUDGET` | Control debug-dump output budget. |

---

## Exit Codes

| Code | Meaning |
|---|---|
| `0` | Success — compilation and execution (or tests) completed without errors. |
| `1` | General failure — compilation error, runtime error, or test failure. |
| non-zero | Any non-zero exit code indicates failure. The specific value reflects the program's own exit code when using `sfn run`. |

When `sfn test` is used, a non-zero exit code means at least one test failed. All test results are printed before the process exits.

---

## File Conventions

| Convention | Description |
|---|---|
| `*.sfn` | Sailfin source files |
| `*_test.sfn` | Test files — discovered automatically by `sfn test` and `make test-*` |
| `capsule.toml` | Capsule manifest — declares name, version, dependencies, and required capabilities |
| `workspace.toml` | Workspace manifest — shared policies for multi-capsule projects |
| `*.sfn-asm` | Native IR intermediate representation produced by `sfn emit native` |
| `build/native/sailfin` | Default output path for the self-hosted compiler binary |
| `build/seed/bin/sailfin` | Default path for the downloaded seed compiler |
| `dist/` | Release packaging output directory |

---

## Examples

**Compile and run a hello-world program:**

```bash
sfn run examples/basics/hello-world.sfn
```

**Build the compiler from source:**

```bash
make compile
```

**Run the full test suite:**

```bash
make test
```

**Install the compiler locally:**

```bash
make compile
make install
# compiler is now at ~/.local/bin/sfn
```

**Force a fresh rebuild:**

```bash
make rebuild
```

**Run only unit tests with a name filter:**

```bash
build/native/sailfin test compiler/tests/unit/ --filter "substring"
```

**Run the CI validation gate locally:**

```bash
make check
```

**Fetch a fresh seed compiler:**

```bash
GITHUB_TOKEN=<your-token> make fetch-seed
```

---

*See [Capsules and Packages](/docs/advanced/capsules) for documentation on `capsule.toml` and the planned package registry commands.*
