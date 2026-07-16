---
title: CLI Reference
description: Complete reference for the sfn command-line interface and Makefile build system.
section: reference
sidebar:
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

**Options:**

| Flag | Description |
|---|---|
| `--skip-toolchain-check` | Bypass the `[toolchain]` pin check for this invocation — see [Toolchain Pinning Flags](#toolchain-pinning-flags) |

**Examples:**

```bash
sfn run hello.sfn
sfn run examples/basics/hello-world.sfn
sfn run src/main.sfn
```

**Behavior:**

- Resolves the project/workspace root and verifies the `[toolchain]` pin, if any, before compiling (see [Toolchain Pinning Flags](#toolchain-pinning-flags)).
- Compiles the source file from scratch on each invocation.
- Effect annotations are checked at compile time; missing effects produce `effects.missing` diagnostics with fix-it hints.
- The program runs in the same terminal session; stdout and stderr are connected to the calling terminal.
- Exit code of `sfn run` reflects the exit code of the program.

---

### `sfn test [path...]`

Discover and run Sailfin test files. Test files follow the `*_test.sfn` naming convention. Without a path argument, `sfn test` discovers all `*_test.sfn` files under the current directory.

Multiple path arguments group tests into named **suites** for reporting: each path becomes a suite labelled by its basename, and the runner emits a per-suite `═══ <name>: N/M passed, K failed ═══` banner at end-of-run. The repository `make test` target uses this to run unit / integration / e2e / capsule tests in one invocation.

**Usage:**

```bash
sfn test [--json] [-k NAME] [--tag TAG] [--update-snapshots] [--no-test-cache] [--jobs N] [--shard I/N] [--skip-toolchain-check] [path...]
```

**Examples:**

```bash
sfn test                                  # run all *_test.sfn files found
sfn test compiler/tests/unit/             # one suite, banner labelled "unit"
sfn test compiler/tests/unit/arrays_test.sfn  # single file (no banner)
sfn test compiler/tests/unit compiler/tests/integration capsules  # three suites
```

**Options** (selected — see the suite discovery/filtering flags above):

| Flag | Description |
|---|---|
| `--json` | Emit a JSONL event stream. |
| `-k NAME` | Only run tests whose name contains `NAME`. |
| `--tag TAG` | Only run tests carrying `@tag("TAG")`. |
| `--update-snapshots` | Re-baseline snapshot golden files. |
| `--no-test-cache` | Bypass the per-test linked-binary cache. |
| `--jobs N` | Run up to `N` per-file test children concurrently. |
| `--shard I/N` | Run only the `I`-th of `N` file-count-balanced shards. |
| `--skip-toolchain-check` | Bypass the `[toolchain]` pin check for this invocation — see [Toolchain Pinning Flags](#toolchain-pinning-flags) |

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
| `--skip-toolchain-check` | Bypass the `[toolchain]` pin check for this invocation — see [Toolchain Pinning Flags](#toolchain-pinning-flags) |
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

**Limitations — `check` is not a build oracle:** `sfn check` runs *parse + typecheck + effect-check only*. It never emits `.sfn-asm`/LLVM IR or invokes `clang`/the linker, so by construction it cannot catch failures that surface only during codegen or linking. A `check` green therefore does **not** guarantee `sfn build` succeeds — run `sfn build` (or `make compile`) for that. The historical instance of this gap (runtime-evaluated module globals such as `let mut xs: int[] = [];` checking green but failing at link with `use of undefined value '@sailfin_module_init__'`) was fixed in the emitter, so `check` and `build` now agree on that class; the agreement is locked by `compiler/tests/e2e/check_build_agree_module_global_test.sfn`.

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
| `--skip-toolchain-check` | Bypass the `[toolchain]` pin check for this invocation — see [Toolchain Pinning Flags](#toolchain-pinning-flags) |

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

### `sfn cache <info|prune|clean>`

Inspect and garbage-collect the content-addressed build artifact cache (the
same store `sfn build`/`sfn run`/`sfn check`/`sfn test` read and write
through, keyed on source + dependency hashes + compiler version + flags).
`sfn cache` is an `![io]` command; it never runs implicitly during a normal
build.

**Subcommands:**

| Form | Description |
|---|---|
| `sfn cache info` | Print the resolved cache root, entry count, and total on-disk size. |
| `sfn cache prune [--max-size <bytes>] [--max-age <days>]` | LRU eviction: remove entries older than `--max-age` days, then delete oldest-first (by last-hit time) until total size is under `--max-size`. |
| `sfn cache clean [--all-schemas]` | Remove the current cache schema tree. With `--all-schemas`, also sweep stale sibling schema-version trees left behind by a compiler upgrade. |

**Usage:**

```bash
sfn cache info
sfn cache prune                          # conservative defaults (~5 GiB / 30 days)
sfn cache prune --max-size 1000000000    # cap the cache at 1 GB
sfn cache prune --max-age 7              # evict anything not hit in 7 days
sfn cache prune --max-size 0             # empty the cache
sfn cache clean                          # remove the current schema tree
sfn cache clean --all-schemas            # also remove stale prior-schema trees
```

**Behavior:**

- `prune` is explicit and opt-in — it never runs automatically on `sfn build`/`sfn run`/`sfn check`/`sfn test`. With neither `--max-size` nor `--max-age` given, conservative defaults apply (~5 GiB total size, 30-day max age).
- Eviction order is a true LRU: a cache *hit* touches the entry directory's mtime, so `prune` evicts by last-use recency rather than creation time.
- The cache root follows the same resolution as the build cache generally: `$SAILFIN_BUILD_CACHE_DIR`, then `$XDG_CACHE_HOME/sailfin`, then `$HOME/.cache/sailfin`, falling back to the in-tree `build/cache` when `$HOME` is unresolvable. The compiler's own self-host build always pins the in-tree root and is unaffected by `sfn cache`.

---

### `sfn --version`

Display the compiler version string and exit with code 0.

**Usage:**

```bash
sfn --version
```

**Example output:**

```
sfn <version>
```

The version string follows semantic versioning: `<major>.<minor>.<patch>` for stable releases, `<major>.<minor>.<patch>-alpha.<n>` for pre-releases. Local dev builds include a git hash suffix: `<version>+dev.<hash>`.

The version is read from `compiler/capsule.toml` at runtime. For installed binaries where that file is not available, a baked-in fallback is used.

---

## Package Management

Sailfin ships with package-management commands that target a default public registry at [`pkg.sfn.dev`](https://pkg.sfn.dev). All registry-touching commands (`sfn add`, `sfn publish`) resolve the registry URL through the same three-tier precedence — see [`sfn config`](#sfn-config-getsetunsetlist-key-value) below for how to redirect the toolchain at a private registry.

### `sfn init`

Scaffold a new Sailfin capsule in the current directory. Writes a `capsule.toml` manifest (with the capsule name inferred from the directory) and a starter `src/main.sfn`. The generated manifest includes a `[toolchain] sfn = "<version>"` pin set to the version of the `sfn` binary running `init` — see [Toolchain Pinning Flags](#toolchain-pinning-flags).

**Usage:**

```bash
sfn init
```

Fails with a non-zero exit if `capsule.toml` already exists — `sfn init` never overwrites existing manifests.

---

### `sfn add [--dev] [--update] <capsule>`

Add a capsule dependency to the current project. The manifest (`capsule.toml`) is updated, the package is pre-fetched into `~/.sfn/cache/capsules/<scope>/<name>/<version>/`, and `capsule.lock` records the resolved version and SHA-256 integrity hash.

**Flags:**

- `--dev` — add to `[dev-dependencies]` instead of `[dependencies]`.
- `--update` — ignore the existing lockfile entry and resolve the latest version from the registry.

**Usage:**

```bash
sfn add http                  # stdlib capsule (resolved to sfn/http)
sfn add --dev test            # dev-only dependency
sfn add acme/router           # third-party scoped capsule
sfn add --update acme/router  # force a fresh lookup
```

If a `capsule.lock` entry already exists and `--update` is not passed, the locked version is used without contacting the registry.

When you add a (non-dev) dependency, its `[capabilities] required` set is merged into your project's `[capabilities] required` so the consumer manifest reflects the capability surface it actually pulls in. Adding an `io`+`net` capsule, for example, records `io` and `net` (deduplicated against what you already declared) and prints the capabilities it propagated. Dev dependencies are build/test-time only and are not folded into the consumer's runtime surface.

---

### `sfn publish [path]`

Package a capsule (current directory by default, or the provided path) into the SFNPKG format and upload it to the configured registry.

**Usage:**

```bash
sfn publish                     # package and upload the capsule at cwd
sfn publish path/to/capsule     # or publish a capsule elsewhere on disk
```

**Authentication:** the command reads your bearer token from the `SFN_TOKEN` environment variable first, then falls back to `~/.sfn/credentials` (written by `sfn login`). If neither is set, publishing fails with a clear error.

**Payload:** the capsule's `capsule.toml` and every `src/**/*.sfn` file are concatenated into a SFNPKG/1 bundle, SHA-256 digested, base64-encoded, and POSTed as JSON to `<registry>/api/publish`. Non-2xx HTTP responses are surfaced with the server error message.

---

### `sfn login [token]`

Store a registry bearer token at `~/.sfn/credentials` (mode 600, inside `~/.sfn/` which is created at mode 700). This is the token `sfn publish` uses when `SFN_TOKEN` is not set.

**Usage:**

```bash
sfn login                       # prompts and reads one line from stdin
sfn login <token>               # or pass the token as an argument
echo "<token>" | sfn login      # or pipe it in
```

Rejects empty tokens. Overwrites any existing credentials file.

---

### `sfn config <get|set|unset|list> [key] [value]`

Persist per-user toolchain settings to `~/.sfn/config.toml` (mode 600). The only supported key today is `registry`, which controls where `sfn add` and `sfn publish` look for capsules.

**Subcommands:**

| Form | Description |
|---|---|
| `sfn config list` | Print every resolved setting. |
| `sfn config get <key>` | Print the resolved value for a single key. |
| `sfn config set <key> <value>` | Persist `<value>` for `<key>`. |
| `sfn config unset <key>` | Remove the key from `~/.sfn/config.toml`, reverting to the default. |

**Usage:**

```bash
sfn config set registry https://registry.acme.internal   # point at a private registry
sfn config get registry                                   # https://registry.acme.internal
sfn config list                                           # registry = https://registry.acme.internal
sfn config unset registry                                 # back to the default
```

**Resolution order** for the registry URL (highest priority first):

1. `SFN_REGISTRY` environment variable — a one-shot override useful for CI.
2. `[registry] url` in `~/.sfn/config.toml` — persisted by `sfn config set`.
3. Compiled-in default: `https://pkg.sfn.dev`.

The URL must start with `http://` or `https://` and may not contain whitespace, quotes, or shell metacharacters. Invalid values are rejected at `sfn config set` and silently ignored (with a warning to stderr) when coming from the environment or a hand-edited config file.

**Enterprise example:** host a mirror behind your firewall and opt everyone in by adding a single line to your shell profile:

```bash
export SFN_REGISTRY=https://registry.acme.internal
```

Or put it in `~/.sfn/config.toml` once per workstation with `sfn config set registry ...` — no shell changes required.

---

## Toolchain Pinning Flags

`sfn build`, `sfn run`, `sfn check`, and `sfn test` all verify a project's `[toolchain]` manifest pin (`capsule.toml` / `workspace.toml`) before doing any other work — floor semver + optional stability `channel`, with a member `capsule.toml` overriding a `workspace.toml` pin per field. See [Capsules & Packages → Toolchain Pinning](/docs/advanced/capsules#toolchain-pinning) for the manifest syntax and gate semantics. `sfn init` writes the pin for you (see [`sfn init`](#sfn-init) above).

On a mismatch, the command exits non-zero with a diagnostic of this shape:

```
error: toolchain mismatch
  this project pins sfn >= 0.8.0-alpha.2 (capsule.toml [toolchain])
  but the running toolchain is 0.7.4-alpha.1
  install the pinned toolchain, or re-run with --skip-toolchain-check to override
```

That diagnostic is what you see under `SAILFIN_TOOLCHAIN=local` (verify-only) or when the gate is otherwise unable to dispatch (see below). By default, though, `sfn` doesn't just error — it fetches and re-execs the pinned toolchain for you.

**`SAILFIN_TOOLCHAIN` controls what happens on a mismatch:**

| `SAILFIN_TOOLCHAIN` | Behavior |
|---|---|
| `auto` (**default**) | Ensure the pinned toolchain is present in the version store — fetching it via `sfn toolchain install` (Ed25519-signature + SHA-256 verified, fail-closed) if it isn't — then transparently **re-exec** it with the original argv. A fresh clone plus `sfn build` just works with zero manual steps. |
| `local` | Verify only, never fetch: print the mismatch diagnostic above and exit non-zero. |
| `<version>` | Force that exact version as the dispatch target, regardless of the pin. |
| `off` (or `0`) | Skip the gate entirely — same as `--skip-toolchain-check`: warn and proceed on the running toolchain. |

Auto-dispatch (`auto`) is the default because verification is mandatory and fail-closed whenever a toolchain is fetched or dispatched — `sfn` never silently runs unverified code. A **re-entrancy guard** (`SAILFIN_TOOLCHAIN_DISPATCHED=<version>`) is set before re-exec, so a dispatched toolchain that still doesn't satisfy its own pin hard-fails loudly instead of looping. Offline, an already-stored toolchain still dispatches (its completeness marker is re-verified locally, no network needed); offline with nothing stored, `sfn` falls back to the diagnostic above naming the exact `sfn toolchain install <version>` command to run once back online.

**Escape hatches** — any one of the following downgrades the hard error to a one-line warning on stderr and lets the command proceed on the running toolchain, without dispatching:

| Form | Scope |
|---|---|
| `--skip-toolchain-check` | This invocation only |
| `SAILFIN_SKIP_TOOLCHAIN_CHECK=1` | Every `sfn` invocation in the current shell/CI job |
| `SAILFIN_TOOLCHAIN=off` (or `=0`) | Every `sfn` invocation in the current shell/CI job |

A project with no `[toolchain]` section is unaffected — the gate is a no-op.

---

## Build System

The repository Makefile provides higher-level build orchestration for the self-hosting workflow. These targets are for working on the Sailfin compiler itself; end users generally only need `sfn run` and `sfn test`.

For host dependencies, OpenSSL setup, and the full source-build environment
guide, see
[`docs/development-setup.md`](https://github.com/SailfinIO/sailfin/blob/main/docs/development-setup.md).

### Complete target reference

| Target | Description |
|---|---|
| `make compile` | Build the native compiler binary from a released seed, using the self-hosting pipeline. Skips rebuild if the binary is up to date. |
| `make rebuild` | Force a rebuild from a released seed regardless of timestamps. Routes through `<seed> build -p compiler`. |
| `make install` | Install the built compiler binary into `$(BINDIR)` (default: `~/.local/bin`). Requires `make compile` to have run first. |
| `make check` | Compile (if needed), build a `sailfin-seedcheck` binary, verify it can run `hello-world.sfn`, then run the full test suite against it. This is the authoritative CI gate. |
| `make check-strict` | Same as `make check`, but a stage2/stage3 fixed-point mismatch is fatal. |
| `make check-fast` | Run `sfn check` over `compiler/src/` and `runtime/` without codegen or clang. |
| `make test` | Run the full Sailfin-native test suite (unit + integration + e2e + capsule tests). Builds first if `build/bin/sfn` is missing. |
| `make test-unit` | Run unit tests from `compiler/tests/unit/*_test.sfn`. |
| `make test-integration` | Run integration tests from `compiler/tests/integration/*_test.sfn`. |
| `make test-e2e` | Run end-to-end tests from `compiler/tests/e2e/*_test.sfn`. |
| `make test-capsules` | Run per-capsule tests under `capsules/`. |
| `make package` | Build and package native artifacts into `dist/`. |
| `make fetch-seed` | Download the pinned seed compiler (`bootstrap.toml [seed].version`, override with `SEED_VERSION`) from GitHub Releases into `build/toolchains/seed/`. Set `GITHUB_TOKEN` to raise GitHub API rate limits. |
| `make bench` | Benchmark compiler per-module compile time and memory. |
| `make bench-runtime` | Benchmark compiled-program runtime execution. |
| `make mcp-server` | Build the Sailfin MCP server under `tools/mcp-server/`. |
| `make clean` | Remove `dist/` packaged artifacts. Does not remove build intermediates. |
| `make clean-build` | Remove `build/` artifacts (keeps the seed toolchain under `build/toolchains/` by default). Pass `KEEP_SEED=0` to also remove `build/toolchains/`. |
| `make clean-all` | Remove both `dist/` and `build/` artifacts completely. |
| `make help` | Print a summary of available targets. |

---

### Parallelism and validation shape

`make rebuild` routes through `<seed> build -p compiler`; the Sailfin-native
driver owns compiler module scheduling. The driver reads
`SAILFIN_BUILD_JOBS`; set it to a positive integer for build-parallelism
bisects or memory-constrained hosts.

`sfn test` and `sfn dev shard run` auto-detect parallelism from CPU and memory
(`min(cores, RAM/384 MiB)`, floor 1, cap 16, with a macOS cap of 2). An explicit
`--jobs N` wins over `SAILFIN_TEST_JOBS=N`; use `--jobs 1` for the serial path.
The Makefile compatibility layer forwards its `TEST_JOBS` budget, while
`make check` uses `CHECK_TEST_JOBS` for its cold seedcheck suite and
`CHECK_TEST_TIMEOUT` for the per-test timeout. Use
`SELFHOST_STRICT=1` or `make check-strict` when a stage2/stage3 fixed-point
mismatch must fail the run.

---

## Environment Variables

These environment variables influence the behavior of `sfn` and the Makefile build system.

| Variable | Scope | Description |
|---|---|---|
| `SAILFIN_RUNTIME_ROOT` | `sfn` binary | Override the directory where `sfn` looks for the bundled runtime. By default, the runtime is resolved relative to the executable. |
| `SAILFIN_MEM_LIMIT` | `sfn` binary | Override the compiler's Linux self-applied 8 GiB virtual-memory cap. Use bytes, `unlimited`, `off`, or `0`. |
| `SAILFIN_OPENSSL_PREFIX` | build/link | Override macOS OpenSSL discovery. The driver expects libraries under `$SAILFIN_OPENSSL_PREFIX/lib`. |
| `SAILFIN_BUILD_JOBS` | `sfn build -p compiler` | Override compiler module scheduling inside the build driver. Use `1` for serial bisects or a small value on memory-constrained hosts. |
| `SAILFIN_TEST_JOBS` | `sfn test` / `sfn dev shard run` | Override the native CPU/RAM-aware per-file worker default. An explicit `--jobs N` takes precedence; use `1` for serial execution. |
| `SFN_REGISTRY` | `sfn add` / `sfn publish` | Override the package registry base URL for this shell. Takes precedence over `~/.sfn/config.toml`. See [`sfn config`](#sfn-config-getsetunsetlist-key-value). |
| `SFN_TOKEN` | `sfn publish` | Bearer token used when uploading a capsule. Takes precedence over `~/.sfn/credentials` written by `sfn login`. |
| `SAILFIN_SKIP_TOOLCHAIN_CHECK` | `sfn build`/`run`/`check`/`test` | Set to `1` to downgrade a `[toolchain]` pin mismatch from a hard error to a warning for every invocation in the shell/CI job. See [Toolchain Pinning Flags](#toolchain-pinning-flags). |
| `SAILFIN_TOOLCHAIN` | `sfn build`/`run`/`check`/`test` | Controls the toolchain-pin mismatch response: `auto` (default) fetches + verifies + re-execs the pinned toolchain; `local` verifies only and errors on mismatch; `<version>` forces that dispatch target; `off` (or `0`) has the same effect as `SAILFIN_SKIP_TOOLCHAIN_CHECK=1`. See [Toolchain Pinning Flags](#toolchain-pinning-flags). |
| `SAILFIN_TOOLCHAIN_DISPATCHED` | `sfn build`/`run`/`check`/`test` | Set automatically by `sfn` before re-exec'ing a dispatched toolchain (`=<version>`) as a re-entrancy guard; not intended to be set by hand. |
| `PREFIX` | Makefile | Installation prefix. Defaults to `$HOME/.local`. The binary is installed to `$(PREFIX)/bin`. |
| `BINDIR` | Makefile | Installation bin directory. Defaults to `$(PREFIX)/bin`. |
| `INSTALL_NAME` | Makefile | Installed binary name. Defaults to `sfn`. |
| `DESTDIR` | Makefile | Staging prefix for packaging-style installs. |
| `GLOBAL_BIN_DIR` | Installer script | Override the installation bin directory directly (takes precedence over `PREFIX`). |
| `GITHUB_TOKEN` | installer / `make fetch-seed` | GitHub token used to raise API rate limits and access release assets. |
| `BUILD_ARGS` | Makefile | Extra arguments passed through to `sfn build -p compiler`, for example `--no-cache --cache-trace`. |
| `SEED` | Makefile | Path to (or name of) the seed compiler used as the bootstrap. Defaults to the fetched repo-local seed alias, `build/toolchains/seed/bin/sfn` (`sfn.exe` on Windows). |
| `SEED_VERSION` | Makefile | Version tag of the seed to fetch. Defaults to `bootstrap.toml [seed].version`. |
| `SEED_NATIVE` | Makefile | One-off path to the seed used by `make rebuild`, taking precedence over `SEED`. |
| `NATIVE_BIN` | Makefile | Compiler binary used by test, check, and bench targets. Defaults to `build/bin/sfn`. |
| `NATIVE_OUT` | Makefile | Output path for `make rebuild`. Defaults to `build/bin/sfn`. |
| `CLANG` | Makefile | `clang` executable to use. Defaults to `clang`. |
| `SAILFIN_CC` | Makefile on macOS | Target of the local clang shim used by seed/built compiler subprocesses. Defaults to `/usr/bin/clang`. |
| `CLANG_LL_FLAGS` | Makefile | Extra flags when compiling `.ll` files with clang. |
| `TEST_JOBS` | Makefile | Parallel `sfn test --jobs N` children for `make test*`. Defaults to auto-detected CPU/memory budget. |
| `CHECK_TEST_JOBS` | Makefile | Parallelism for `make check` test legs. Defaults to `TEST_JOBS`. |
| `CHECK_TEST_TIMEOUT` | Makefile | Per-test timeout for `make check`'s cold full-suite leg. Defaults to `1800`. |
| `CHECK_FULL_PASS1` | Makefile | Set to `1` to restore the older full first-pass suite before seedcheck. |
| `SELFHOST_STRICT` | Makefile | Set to `1` to make stage2/stage3 fixed-point mismatch fatal. |
| `JSON=1` | Makefile | Enable structured agent reports for agent-facing targets. |
| `KEEP_SEED` | `make clean-build` | Set to `0` to also delete `build/toolchains/` during `make clean-build`. Defaults to `1` (the seed toolchain is preserved). |

### Debug and trace variables

These variables enable verbose runtime diagnostics. They are intended for compiler development and troubleshooting, not end-user programs.

| Variable | Description |
|---|---|
| `SAILFIN_TRACE_ARGV` | Print the argument vector received by the CLI entry point. |
| `SAILFIN_TRACE_LINK` | Print resolved clang/link command details. |
| `SAILFIN_CACHE_TRACE` | Print build cache hit/miss diagnostics; equivalent to `--cache-trace` on build/run paths. |
| `SAILFIN_TEST_TIMEOUT` | Override the per-test timeout used by `sfn test`. |
| `SAILFIN_TEST_KEEP_SCRATCH` | Keep `sfn test` scratch directories for post-mortem debugging. |
| `SAILFIN_TRACE_LOWERING` | Enable LLVM lowering trace output for compiler debugging. |
| `SAILFIN_DUMP_ARENA_STATS` | Print runtime arena statistics on exit. |
| `SAILFIN_DEBUG_FORCE_PANIC` | Force an internal panic in a named compiler stage for ICE-path testing. |
| `SAILFIN_INJECT_FAULT` | Inject transient emit failures for retry-path testing. |

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
| `build/bin/sfn` | Default output path for the self-hosted compiler binary |
| `build/toolchains/seed/bin/sfn` | Default path for the downloaded seed compiler |
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
build/bin/sfn test compiler/tests/unit/
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
