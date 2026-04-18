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
sfn run <file.sfn>
```

**Examples:**

```bash
sfn run hello.sfn
sfn run examples/basics/hello-world.sfn
sfn run src/main.sfn
```

**Behavior:**

- Compiles the source file from scratch on each invocation.
- Effect annotations are checked at compile time; missing effects produce `effects.missing` diagnostics with fix-it hints.
- The program runs in the same terminal session; stdout and stderr are connected to the calling terminal.
- Exit code of `sfn run` reflects the exit code of the program.

---

### `sfn test [path]`

Discover and run Sailfin test files. Test files follow the `*_test.sfn` naming convention. Without a path argument, `sfn test` discovers all `*_test.sfn` files under the current directory.

**Usage:**

```bash
sfn test [path]
```

**Examples:**

```bash
sfn test                                  # run all *_test.sfn files found
sfn test compiler/tests/unit/             # run tests in a specific directory
sfn test compiler/tests/unit/arrays_test.sfn  # run a single test file
```

> **Note:** `--filter` is not yet supported. To narrow test scope, pass a specific file or directory path.

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

### `sfn fmt [options] <path...>`

Format Sailfin source files. One style, no configuration — like `gofmt` for Sailfin.

The formatter operates on the token stream (not the AST), so it works on any syntactically valid file including partial or experimental code. It preserves all comments and produces deterministic, idempotent output.

**Usage:**

```bash
sfn fmt <file.sfn>             # print formatted output to stdout
sfn fmt --write <path...>      # format files in place
sfn fmt --check <path...>      # exit 1 if any file would change (CI mode)
```

**Options:**

| Flag | Description |
|---|---|
| `--write` | Overwrite files in place with formatted output |
| `--check` | Check if files are formatted; exit 1 if any differ (no modifications) |

`--check` and `--write` are mutually exclusive. Without either flag, formatted output is printed to stdout.

Paths can be individual `.sfn` files or directories. When given a directory, `sfn fmt` recursively discovers all `.sfn` files (up to 10 levels deep).

**Examples:**

```bash
# Format a single file and see the result
sfn fmt src/main.sfn

# Format all compiler sources in place
sfn fmt --write compiler/src/

# CI check — fails if any file is unformatted
sfn fmt --check compiler/src/ runtime/
```

**Formatting rules:**

- **Indentation:** 4 spaces per level (no tabs)
- **Spacing:** Spaces around operators and after keywords; no space before `:`, `;`, or `?` (optional suffix); no space after unary `!` and `-`
- **Braces:** K&R style — opening brace on the same line as the declaration
- **Blank lines:** Exactly one between top-level declarations; suppress at block boundaries
- **Imports:** Sorted by path (standard library first, then relative), specifiers sorted alphabetically within each import
- **Inline blocks:** Single-statement blocks stay on one line when they fit (e.g., `if x { return true; }`); multi-statement blocks and struct/enum declarations always expand
- **Comments:** Preserved exactly as written; leading and trailing comments kept attached to their tokens
- **Wrapping:** Import specifier lists and struct literals wrap at 80 characters

**Known limitations:**

| Limitation | Description |
|---|---|
| No expression wrapping | Long expressions stay on one line; the formatter does not break at operator boundaries |
| No `--diff` mode | Cannot show inline diff between original and formatted; use `diff` externally |
| Bulk OOM on many files | `sfn fmt --write <large-directory>` may OOM when processing hundreds of files in a single invocation; use a per-file loop as workaround (see below) |
| No semantic formatting | Cannot reorder match arms, inline function bodies, or restructure code |
| Comment-blank-line collapse | Blank lines between section-divider comments and declarations may be normalized away |

**Workaround for bulk formatting:**

```bash
# Per-file loop avoids OOM on large codebases
find compiler/src runtime -name '*.sfn' | while read f; do
    sfn fmt --write "$f"
done
```

---

### `sfn check [options] [path...]`

Run the compiler's analysis passes — parse, typecheck, and effect-check — **without** emitting `.sfn-asm`, LLVM IR, or invoking `clang`. Used as a fast inner-loop "does this file still look sane?" gate. Returns in seconds rather than the minutes a full build takes.

**Usage:**

```bash
sfn check                        # check every .sfn file under the current directory
sfn check compiler/src           # check a specific directory
sfn check compiler/src/main.sfn  # check a single file
sfn check src lib                # check multiple paths in one invocation
sfn check --quiet compiler/src   # suppress diagnostic output; exit code only
```

**Options:**

| Flag | Description |
|---|---|
| `--quiet`, `-q` | Suppress diagnostic output; only the summary and exit code are produced |
| `-h`, `--help` | Print usage and exit |

**What gets checked:**

1. **Parse** — `parse_program()` builds the AST (parser recovers from most errors; a future enhancement will surface parse-stage diagnostics).
2. **Type check** — `typecheck_diagnostics()` reports duplicate symbols (`E0001`), missing interface members (`E0301`), interface type-argument mismatches (`E0302`), and scope violations.
3. **Effect check** — `validate_effects()` reports routines that call effectful APIs (`print.*`, `fs.*`, `http.*`, `sleep`, `@logExecution`, …) without declaring the matching `![...]` effect.

All three passes run regardless of earlier failures — you see every diagnostic in one pass rather than fix-one / rerun cycles.

**Output format:**

Diagnostics are printed to **stderr**, one `error[CODE]:` header per finding with source context and a caret. Effect violations list the triggering calls and a suggested fix. A summary line is printed to **stdout**:

```
checked 120 files: ok
checked 120 files: 3 errors
```

**Error codes introduced by `sfn check`:**

| Code | Meaning |
|---|---|
| `E0400` | Function calls effectful APIs without declaring `![...]` |
| `E0401` | Decorator (`@trace`, `@logExecution`) requires `![io]` but function doesn't declare it |

Typecheck codes (`E0001`, `E0301`, `E0302`) are shared with the regular compilation pipeline.

**Exit codes:**

| Code | Meaning |
|---|---|
| `0` | No diagnostics |
| `1` | One or more diagnostics were produced (or no `.sfn` files were found) |
| `2` | Usage error (bad flag or path not found) |

**Why:** A full `make compile` takes many minutes; `sfn check` gives you the parse/typecheck/effect verdict in seconds. Use it during editing, wire it into pre-commit hooks, or run it from CI as an early-gate before the full build.

---

### `sfn build <file>`

Compile a Sailfin source file without running it. Writes an executable to the output path (default: the source filename without `.sfn` in the current directory).

**Usage:**

```bash
sfn build <file.sfn> [-o <output>]
```

**Options:**

| Flag | Description |
|---|---|
| `-o <output>` | Write the compiled binary to `output` instead of the default path |

**Examples:**

```bash
sfn build src/main.sfn
sfn build src/main.sfn -o build/myapp
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
sfn 0.5.1
```

The version string follows semantic versioning: `<major>.<minor>.<patch>` for stable releases, `<major>.<minor>.<patch>-alpha.<n>` for pre-releases. Local dev builds include a git hash suffix: `<version>+dev.<hash>` (e.g. `sfn 0.5.1+dev.abc1234`).

The version is read from `compiler/capsule.toml` at runtime. For installed binaries where that file is not available, a baked-in fallback is used.

---

## Planned CLI Commands

The following commands are planned for a future release. They are not available today.

| Command | Description |
|---|---|
| `sfn init [name]` | Scaffold a new Sailfin capsule with a `capsule.toml` manifest |
| `sfn add <capsule>` | Add a dependency to the current capsule |
| `sfn publish` | Publish the current capsule to the package registry |

---

## Build System

The repository Makefile provides higher-level build orchestration for the self-hosting workflow. These targets are for working on the Sailfin compiler itself; end users generally only need `sfn run` and `sfn test`.

### Complete target reference

| Target | Description |
|---|---|
| `make compile` | Build the native compiler binary from a released seed, using the self-hosting pipeline. Skips rebuild if the binary is up to date. |
| `make rebuild` | Force a rebuild from a released seed regardless of timestamps. Uses `scripts/build.sh` (pure shell). |
| `make install` | Install the built compiler binary into `$(BINDIR)` (default: `~/.local/bin`). Requires `make compile` to have run first. |
| `make check` | Compile (if needed), build a `sailfin-seedcheck` binary, verify it can run `hello-world.sfn`, then run the full test suite against it. This is the authoritative CI gate. |
| `make test` | Run the full Sailfin-native test suite (unit + integration + e2e). Requires `make compile` first. |
| `make test-unit` | Run unit tests from `compiler/tests/unit/*_test.sfn`. |
| `make test-integration` | Run integration tests from `compiler/tests/integration/*_test.sfn`. |
| `make test-e2e` | Run end-to-end tests from `compiler/tests/e2e/*_test.sfn`. |
| `make package` | Build and package native artifacts into `dist/`. Used for release artifacts. |
| `make fetch-seed` | Download the latest released seed compiler from GitHub Releases into `build/seed/`. Requires `GITHUB_TOKEN`. |
| `make clean` | Remove `dist/` packaged artifacts. Does not remove build intermediates. |
| `make clean-build` | Remove `build/` artifacts (keeps `build/seed/` by default). Pass `KEEP_SEED=0` to also remove the downloaded seed. |
| `make clean-all` | Remove both `dist/` and `build/` artifacts completely. |
| `make help` | Print a summary of available targets. |

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

**Run only unit tests in a specific directory:**

```bash
build/native/sailfin test compiler/tests/unit/
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
