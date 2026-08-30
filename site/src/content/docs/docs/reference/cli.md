---
title: CLI Reference
description: Complete reference for the sfn command-line interface.
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

### Global options

Global options appear before the command name:

```bash
sfn --color always check src
sfn --color=never build src/main.sfn
```

| Flag | Description |
|---|---|
| `--color <auto\|always\|never>` | Control ANSI styling for human terminal diagnostics. The default is `auto`, which enables color only for a terminal; `NO_COLOR` with any non-empty value disables it. JSON output remains unstyled. |

---

## Commands

### `sfn run [file]`

Compile and execute a Sailfin program in a single step. With no file argument,
the command reads `[build].entry` from `capsule.toml` in the current directory.
Passing a source file keeps the standalone-file workflow.

**Usage:**

```bash
sfn run [<file.sfn>]
```

**Options:**

| Flag | Description |
|---|---|
| `--skip-toolchain-check` | Bypass the `[toolchain]` pin check for this invocation — see [Toolchain Pinning Flags](#toolchain-pinning-flags) |

**Examples:**

```bash
sfn run
sfn run hello.sfn
sfn run examples/basics/hello-world.sfn
sfn run src/main.sfn
```

**Behavior:**

- With no argument, requires `capsule.toml` in the current directory and runs
  its `[build].entry`; only a `kind = "binary"` capsule can be run.
- Resolves the project/workspace root and verifies the `[toolchain]` pin, if any, before compiling (see [Toolchain Pinning Flags](#toolchain-pinning-flags)).
- Compiles the source file from scratch on each invocation.
- Effect annotations are checked at compile time; missing effects produce `effects.missing` diagnostics with fix-it hints.
- The program runs in the same terminal session; stdout and stderr are connected to the calling terminal.
- Exit code of `sfn run` reflects the exit code of the program.

---

### `sfn test [path...]`

Discover and run Sailfin test files. Test files follow the `*_test.sfn` naming convention. Without a path argument, `sfn test` discovers all `*_test.sfn` files under the current directory.

Multiple path arguments group tests into named **suites** for reporting: each path becomes a suite labelled by its basename, and the runner emits a per-suite `═══ <name>: N/M passed, K failed ═══` banner at end-of-run. `sfn test` uses this to run unit / integration / e2e / capsule tests in one invocation.

Every explicitly named path must exist. If any does not, `sfn test` prints `error: path not found: <path>` for each missing one and exits 2 **without compiling or running anything**. Exit 2 marks a malformed invocation, distinct from exit 1 for a failing suite — so a typo'd path in CI is never mistaken for a red test run. A path that exists but contains no `*_test.sfn` files is not an error: it reports `no *_test.sfn files found under <path>` and exits 0.

**Usage:**

```bash
sfn test [--json] [-k NAME] [--tag TAG] [--update-snapshots] [--no-test-cache] [--jobs N] [--slowest N] [--shard I/N] [--skip-toolchain-check] [path...]
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
| `-k NAME` | Only run tests whose name contains `NAME`. Exits non-zero if it matches no tests. |
| `--tag TAG` | Only run tests carrying `@tag("TAG")`. Exits non-zero if it matches no tests. |
| `--update-snapshots` | Re-baseline snapshot golden files. |
| `--no-test-cache` | Bypass the per-test linked-binary cache and the shared runtime object cache, so the run rebuilds the runtime from source. |
| `--jobs N` | Run up to `N` per-file test children concurrently. |
| `--slowest N` | Print the `N` slowest test files after a multi-file run (default `5`; `0` disables the summary; range `[0, 1000]`, out-of-range exits `2`). |
| `--shard I/N` | Run only the `I`-th of `N` file-count-balanced shards. |
| `--skip-toolchain-check` | Bypass the `[toolchain]` pin check for this invocation — see [Toolchain Pinning Flags](#toolchain-pinning-flags) |

> **Note:** `--filter` is not yet supported. To narrow test scope, pass a specific file or directory path.

**Timing output** (human output only — unaffected, and not emitted, under `--json`; the JSON schema is unchanged):

- Each file's `PASS`/`FAIL` line is appended with its wall-clock elapsed time, e.g. `[test] PASS: foo_test.sfn (1.23s)` or `[test] FAIL: bar_test.sfn (exit code 1) (2.10s)`.
- A run with at least two timed files ends with a slowest-files summary listing up to `--slowest N` entries (default `5`), slowest first. `--slowest 0` disables the summary; a single-file run never prints one regardless of the flag.
- Files with no captured timing — for example one that failed at the compile or link stage before it could run — are excluded from the summary.
- The unit is per-file, deliberately: a file's binary executes all of its tests in one process, so per-test wall time isn't directly observable. `--json`'s per-test `duration_ms` remains an even distribution of the file total, not a measurement.

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

Every path must exist. If any does not, `sfn fmt` prints `error: path not found: <path>` for each missing one and exits 1 **without formatting anything** — including the paths that do exist, so a mixed invocation is all-or-nothing and never leaves the tree half-formatted. `sfn fmt` never creates a file that was not already there.

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
2. **Type check** — `typecheck_diagnostics()` reports duplicate symbols (`E0001`), unresolved value identifiers in checked function-body expressions (`E0014`), an unresolvable field access naming a member the receiver's proven type does not declare (`E0015`), missing interface members (`E0301`), interface type-argument mismatches (`E0302`), proven primitive mismatches (`E0309`), and scope violations.
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

Typecheck codes (`E0001`, `E0014`, `E0015`, `E0301`, `E0302`, `E0309`) are shared with the regular compilation pipeline.

**Exit codes:**

| Code | Meaning |
|---|---|
| `0` | No diagnostics |
| `1` | One or more diagnostics were produced (or no `.sfn` files were found) |
| `2` | Usage error (bad flag or path not found) |

**Why:** A full `sfn dev bootstrap build` takes many minutes; `sfn check` gives you the parse/typecheck/effect verdict in seconds. Use it during editing, wire it into pre-commit hooks, or run it from CI as an early-gate before the full build.

**Limitations — `check` is not a build oracle:** `sfn check` runs *parse + typecheck + effect-check only*. It never emits `.sfn-asm`/LLVM IR or invokes `clang`/the linker, so by construction it cannot catch failures that surface only during codegen or linking. A `check` green therefore does **not** guarantee `sfn build` succeeds — run `sfn build` (or `sfn dev bootstrap build`) for that. The historical instance of this gap (runtime-evaluated module globals such as `let mut xs: int[] = [];` checking green but failing at link with `use of undefined value '@sailfin_module_init__'`) was fixed in the emitter, so `check` and `build` now agree on that class; the agreement is locked by `compiler/tests/e2e/check_build_agree_module_global_test.sfn`.

---

### `sfn symbols [--json] [--capsule SLUG]`

Emit a versioned, deterministic JSON index of Sailfin's public callable
surface — the auto-imported prelude globals plus the free functions declared
in each in-tree `sfn/*` capsule's `src/mod.sfn`. Intended for agents and
external tooling that need a machine-readable symbol table without parsing
`sfn check` diagnostics or grepping source.

**Usage:**

```bash
sfn symbols --json                        # index the full prelude + capsules surface
sfn symbols --json --capsule sfn/strings  # restrict to one capsule
```

**Options:**

| Flag | Description |
|---|---|
| `--json` | Emit the JSON envelope. The default and, in v1, the only output mode. |
| `--capsule SLUG` | Restrict the index to one capsule (e.g. `sfn/strings`). An unresolvable slug produces a structured error. |

**Exit codes:**

| Code | Meaning |
|---|---|
| `0` | Success — the JSON envelope was written to stdout. |
| `1` | `--capsule` named a slug that could not be resolved. |

**Example output** (trimmed):

```json
{"schema_version":"sailfin-symbols/1","compiler_version":"0.8.0","symbols":[{"name":"parse_int","kind":"function","origin":"capsule","import_path":"sfn/strings","form":"free","signature":"parse_int(text: string) -> Result<int, string>","parameters":[{"name":"text","type":"string"}],"return_type":"Result<int, string>","effects":[]}],"parse_failures":[]}
```

See [`sfn symbols --json` Schema](https://github.com/SailfinIO/sailfin/blob/main/docs/reference/symbols-json-schema.md) for the full field-by-field reference, the error envelope shape, and the determinism/versioning contract.

---

### `sfn build [file]`

Compile a Sailfin source file or capsule without running it. With no argument
in a capsule directory, the command reads `[build].entry` and `[build].kind`
from `capsule.toml`, equivalent to `sfn build -p .`. At a workspace root with
no local capsule manifest, it builds the workspace default members.

**Usage:**

```bash
sfn build [<file.sfn> | -p <capsule-path>] [-o <output>]
```

**Options:**

| Flag | Description |
|---|---|
| `-o <output>` | Write the compiled binary to `output` instead of the default path |
| `-p <capsule-path>` | Build the capsule at this directory or manifest path, using its `[build]` configuration |
| `--skip-toolchain-check` | Bypass the `[toolchain]` pin check for this invocation — see [Toolchain Pinning Flags](#toolchain-pinning-flags) |

**Examples:**

```bash
sfn build
sfn build -p path/to/capsule
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

### `sfn dev bootstrap build [--force] [-- <build-arg>...]`

Build and install the compiler with the exact released seed pinned by
`bootstrap.toml`. By default, an unchanged source fingerprint and an existing
`build/bin/sfn` allow the command to return without rebuilding.

```bash
sfn dev bootstrap build
sfn dev bootstrap build --force
sfn dev bootstrap build -- --no-cache --cache-trace
```

`--force` is consumed by the bootstrap command and bypasses its fingerprint
short-circuit. Supplying seed-build arguments also bypasses that short-circuit.
A bare `--` ends bootstrap option parsing; every later token is appended
unchanged to the pinned seed's `build -p compiler` invocation. This provides
the native cache-diagnostic and future build-flag passthrough directly on the
command line.

---

### `sfn dev bootstrap install [--from <path>] [--prefix <dir>] [--destdir <dir>]`

Publish an already-built local compiler. With no install-path flags, the
command preserves the self-host build contract and writes `build/bin/sfn`
(`build/bin/sfn.exe` on Windows). `--prefix` instead writes the host-named
executable under `<dir>/bin`; `--destdir` prepends a packaging staging root.
When `--destdir` is supplied without `--prefix`, the prefix defaults to
`~/.local`, matching the historical `make install` default.

```bash
sfn dev bootstrap install
sfn dev bootstrap install --from build/bin/sfn --prefix "$HOME/.local"
sfn dev bootstrap install --prefix /usr/local --destdir /tmp/sfn-package
```

`--from` copies the named runnable binary without rebuilding. A direct prefix
or staged install also copies the compiler's resolved runtime and capsule
dependency closure beside the executable, including its installed workspace
manifest, so `build` and `run` work after leaving the checkout. A direct
prefix install records a SHA-256 ownership sidecar beside the executable. A
later invocation may replace that entry only while the sidecar still matches;
an unmarked or externally changed executable is refused because it may be
owned by a package manager. Remove such an entry explicitly before replacing
it with a local self-build. Non-root DESTDIR installs are staging output and
do not carry the live-entry ownership sidecar; parent components in the staged prefix
or DESTDIR are rejected and path aliases are normalized. POSIX staging links
are rejected; Windows reparse points are physically resolved and must remain
beneath the resolved staging root. A filesystem root used as DESTDIR retains
the live-entry guard. Bundle publication is staged on the destination
filesystem and atomically claims the executable without replacing a
concurrently published entry. Before that claim, failures restore captured
paths. After it, rollback preserves every occupied live name and restores
backups only to names that remain absent; a late companion or marker failure
can therefore require explicit cleanup or retry. A prefixed or staged install
never updates the repo-local source-fingerprint record for `build/bin/sfn`.

---

### `sfn dev clean <build|dist|all>`

Remove the **repo-local** build artifacts of a compiler checkout — covering
`build/`, `dist/`, or both in one command. This is a different tree from `sfn cache clean`, which owns the
global content-addressed cache above: `sfn dev clean` never touches that root,
and `sfn cache clean` never touches `build/`.

**Subcommands:**

| Form | Description |
|---|---|
| `sfn dev clean build [--include-seed] [--dry-run]` | Remove every top-level entry under `build/` except the fetched seed toolchain store, so a following build does not re-download a seed. |
| `sfn dev clean dist [--dry-run]` | Remove the packaged-release output directory `dist/`. |
| `sfn dev clean all [--include-seed] [--dry-run]` | Both of the above. |

**Usage:**

```bash
sfn dev clean build --dry-run            # list what would go; remove nothing
sfn dev clean build                      # keep the fetched seed toolchain store
sfn dev clean build --include-seed       # also remove the seed store
sfn dev clean all                        # build/ and dist/ together
```

**Behavior:**

- The preserved store is **derived** from `bootstrap.toml [store].install_base` / `bin_dir` (default `build/toolchains`), not hard-coded, and is preserved unless `--include-seed` or `SAILFIN_CLEAN_KEEP_SEED=0` is set.
- It refuses to run unless the current directory is a compiler checkout — `bootstrap.toml` must be present *and* parse with a `[seed].version`.
- It takes no path argument. Every target is a literal repo-relative `build/`/`dist/` path, checked against traversal and absolute-path escape before anything is unlinked, and symlinked entries are unlinked rather than followed.
- An absent tree is a clean no-op (exit 0), not an error, and the tree is not recreated.

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

Scaffold a new Sailfin capsule in the current directory. Writes a `capsule.toml` manifest (with the capsule name inferred from the directory) and a starter `src/main.sfn`. The generated manifest includes both `[toolchain] sfn = "<version>"` (the compatibility floor) and `version = "<version>"` (the exact toolchain selected for this root) set to the release version of the `sfn` binary running `init`, with any local `+dev.<hash>` build stamp stripped — see [Toolchain Pinning Flags](#toolchain-pinning-flags).

**Usage:**

```bash
sfn init
```

Fails with a non-zero exit if `capsule.toml` already exists — `sfn init` never overwrites existing manifests.

The generated capsule is immediately runnable and buildable from the same
directory:

```bash
sfn run
sfn build
```

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

`sfn build`, `sfn run`, `sfn check`, and `sfn test` all verify a project's `[toolchain]` manifest floor (`capsule.toml` / `workspace.toml`) before doing any other work — floor semver + optional stability `channel`, with a member `capsule.toml` overriding a `workspace.toml` pin per field. See [Capsules & Packages → Toolchain Pinning](/docs/advanced/capsules#toolchain-pinning) for the manifest syntax and gate semantics. `sfn init` writes the floor (and the exact `version` below) for you (see [`sfn init`](#sfn-init) above).

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
| `auto` (**default**) | Ensure the pinned toolchain is present in the host-qualified version store — fetching it via `sfn toolchain install` (Ed25519-signature + SHA-256 verified, fail-closed) if it isn't — then transparently **re-exec** it with the original argv. A fresh clone plus `sfn build` just works with zero manual steps. |
| `local` | Verify only, never fetch: print the mismatch diagnostic above and exit non-zero. |
| `<version>` | Force that exact version as the dispatch target, regardless of the pin. |
| `off` (or `0`) | Skip the gate entirely — same as `--skip-toolchain-check`: warn and proceed on the running toolchain. |

New installs land at `versions/<host-triple>/<version>/`, so a shared home can hold the same release for multiple hosts. Auto-dispatch prefers that qualified entry. A pre-SFEP-0073 flat `versions/<version>/` entry is a read-only legacy fallback only when no qualified entry exists; its archive marker does not authenticate the extracted files, so it is treated as unverified and is never moved or blessed. Running `sfn toolchain install <version>` online migrates safely by downloading and normally verifying a fresh host asset, building a complete sibling staging directory, and atomically committing the qualified entry while leaving the legacy entry untouched.

Auto-dispatch (`auto`) is the default because every newly fetched toolchain is verified and published fail-closed. A **re-entrancy guard** (`SAILFIN_TOOLCHAIN_DISPATCHED=<version>`) is set before re-exec, so a dispatched toolchain that still doesn't satisfy its own pin hard-fails loudly instead of looping. Offline, an already-stored qualified toolchain — or the explicit read-only legacy fallback above — still dispatches without a network request; offline with nothing stored, `sfn` falls back to the diagnostic above naming the exact `sfn toolchain install <version>` command to run once back online.

**Escape hatches** — any one of the following downgrades the hard error to a one-line warning on stderr and lets the command proceed on the running toolchain, without dispatching:

| Form | Scope |
|---|---|
| `--skip-toolchain-check` | This invocation only |
| `SAILFIN_SKIP_TOOLCHAIN_CHECK=1` | Every `sfn` invocation in the current shell/CI job |
| `SAILFIN_TOOLCHAIN=off` (or `=0`) | Every `sfn` invocation in the current shell/CI job |

A project with no `[toolchain]` section is unaffected — the gate is a no-op.

### Exact toolchain selection

Alongside the `sfn` compatibility floor, `[toolchain]` accepts an optional exact `version` field (SFEP-0073 §3.2):

```toml
[toolchain]
sfn = "0.10.4"       # compatibility floor (minimum), unchanged
version = "0.10.4"   # exact compiler this root selects
channel = "stable"   # minimum stability, unchanged
```

`version` is exact, not a floor — a selected `0.10.4` is not satisfied by `0.10.5`. It is independent of `sfn`: changing `version` never raises or lowers the floor, and vice versa. `version` must be a complete release semver, optionally with prerelease identifiers; build metadata (`0.10.4+dev.abc123`), an incomplete version (`0.10`), and a channel alias (`stable`, `latest`) are all rejected as `invalid [toolchain] version` before any fetch. An exact `version` that does not itself satisfy this root's own `sfn` floor or `channel` is rejected the same way. Workspace/member precedence is per-field, same as `sfn`/`channel`.

Selection is resolved once, from the current working directory, before the full command tree is parsed — so it applies uniformly to `version`, `init`, `fmt`, `check`, `build`, `run`, `test`, `emit`, `bench`, and `package`, including a command a given toolchain doesn't recognize. `sfn dev ...` and `sfn toolchain ...` are never project-dispatched: `dev` is the self-hosting driver, and `toolchain` has to stay reachable to repair a broken or missing selected payload. Highest precedence first:

1. A one-shot CLI selector: `sfn +<version> <command> ...` (equivalently `sfn toolchain run <version> [--] <command> ...`).
2. An explicit `SAILFIN_TOOLCHAIN=<version>` (a mode word — `auto`/`local`/`off`/`0` — does not count as a selector here; see the table above).
3. The active root's exact `[toolchain] version`.
4. The entry toolchain on `PATH`.

Whichever candidate wins still has to satisfy this root's `sfn` floor and `channel` constraint — an explicitly selected compiler below the floor is a hard error unless one of the [escape hatches](#toolchain-pinning-flags) downgrades it to a warning. Dispatch works in both directions: a newer entry toolchain re-execs an older exact `version`, and an older entry hands the command to a newer one.

`sfn toolchain active` reports the resolved exact field as an `exact:` line (alongside the `requires:` floor line) when this root sets one, and the `sailfin-toolchains/1` JSON envelope's `requirement.version` carries the same value (see [`docs/reference/toolchains-json-schema.md`](https://github.com/SailfinIO/sailfin/blob/main/docs/reference/toolchains-json-schema.md)).

No command besides `sfn init` writes `version` into a manifest today — `sfn toolchain update`, channel selectors resolving into a project `version`, and the per-user default are later SFEP-0073 slices, not shipped.

### Installing a toolchain

`sfn toolchain install <version | channel> [--allow-yanked]` fetches, verifies, and stores a toolchain in the host-qualified version store. `<version>` is an exact release semver (e.g. `0.10.6`); `<channel>` is one of `stable`, `rc`, `beta`, `alpha`, or the `latest` alias for `stable`, resolved to an exact release for the current host through the signed toolchain index.

Before any release-specific download, the install command fetches and authenticates the signed index (Ed25519 signature over canonical JSON, a key-transition chain walked from the pinned trust root, and an anti-rollback sequence check — a clock that can't be read refuses rather than being treated as "not expired") and checks the requested version against it:

| Index state | Behavior |
|---|---|
| **Revoked** | Refused, with no override. A revoked release or its signing key is unsafe; `--allow-yanked` does not apply. |
| **Yanked** | Refused unless `--allow-yanked` is passed; the warning is repeated in the install result. An already-installed yanked toolchain still runs. |
| **Advisory** | Installed normally; the indexed severity, affected range, and fixed version print as a warning. |
| **Listed, not yanked/revoked** | Installed. The index's asset name and SHA-256 for the current host bind the install; when the index and the release-specific `SHA256SUMS` manifest both name a digest for that asset, they must agree or the install is refused. |
| **Not listed** | Installed. The index carries live releases, not history, so a version aged out of it falls back to SFEP-0046's release-specific signed-manifest verification alone. |

A revoked identity is additionally recorded in a local, append-only revocation ledger (`<versions_base>/.index/revocations`) that a later index can never un-revoke. A cached-known-revoked toolchain refuses to execute — through `sfn toolchain install`, ordinary pin dispatch, or management routing — even fully offline, since enforcement reads only that local ledger. A ledger that exists on disk but fails to parse is treated as "cannot tell" rather than "nothing is revoked": every command that would consult it refuses instead of proceeding.

The bootstrap seed path (`bootstrap.toml [seed].version`, SFEP-0047) does not consult the signed index — gating the self-host build on index liveness would couple it to the index's expiry.

> **Not yet shipped:** default update tracks, `sfn toolchain update`, opportunistic update notification, `sfn toolchain default`, and `sfn toolchain remove` are designed in SFEP-0073 but not implemented.
>
> **Testing boundary:** channel resolution, yank handling, and index-listed asset binding are covered at unit level only — an end-to-end test cannot forge a signature against the pinned release-signing trust root. Offline execution refusal for an already-known-revoked release is covered end-to-end, since it consults only the local ledger and needs no signature to verify.

### Management-command routing

`sfn toolchain ...` (any leaf) is intercepted as a raw argv prefix before `sfn`'s command tree is built, so an older entry executable on `PATH` can hand a management leaf it was never built to parse to a newer installed payload — the mechanism that lets native lifecycle commands (`list`, `active`, `verify`, `install`, and future leaves) evolve without a package manager needing to overwrite the entry executable.

Routing walks the host-qualified version store plus the running entry itself and picks the **newest candidate whose recorded `management_protocol` this entry can speak** — a store entry with no `.install-manifest` (a legacy or pre-SFEP-0073 install) is never a candidate, and a payload no newer than the running entry loses, so routing only ever moves forward. Only the chosen candidate is hash-verified; a verification failure warns and falls through to the next-newest so one corrupt payload can't strand management commands. A payload whose protocol is *above* what this entry can route to can never become the management payload — if a compatible payload also exists the entry warns and routes to it instead; if none does, the entry refuses (exit `2`) with bootstrap-installer / package-manager upgrade guidance, sparing exactly one repair path: `sfn toolchain install <exact-version>`.

`sfn toolchain entry-version` bypasses routing entirely and always answers from the executable actually invoked — it's the diagnostic that still works when routing itself is broken:

```
$ sfn toolchain entry-version
version: 0.10.6
host: x86_64-unknown-linux-gnu
executable: /path/to/sfn
management-protocol: 1-1
```

Management routing never reads the project `[toolchain]` pin, so `sfn toolchain ...` commands stay reachable even when ordinary selection (above) is broken or unsatisfiable. A payload the local revocation ledger knows to be revoked is excluded from the survey, offline included — see [Installing a toolchain](#installing-a-toolchain).

> **Not yet shipped:** `sfn toolchain remove`, the per-user default (`sfn toolchain default`), and channel/update discovery (`sfn toolchain update`) are designed in SFEP-0073 but not implemented. See [`docs/status.md`](https://github.com/SailfinIO/sailfin/blob/main/docs/status.md) for current per-leaf status.

---

## Build System

`sfn dev` provides higher-level build orchestration for the self-hosting workflow. These commands are for working on the Sailfin compiler itself; end users generally only need `sfn run` and `sfn test`.

For host dependencies, OpenSSL setup, and the full source-build environment
guide, see
[`docs/development-setup.md`](https://github.com/SailfinIO/sailfin/blob/main/docs/development-setup.md).

### Complete command reference

| Task | Native command |
|---|---|
| Build the native compiler binary from a released seed, using the self-hosting pipeline. Skips rebuild if the binary is up to date. | `sfn dev bootstrap build` |
| Force a rebuild from a released seed regardless of timestamps. Routes through `<seed> build -p compiler`. | `sfn dev bootstrap build --force` |
| Compile (if needed), verify the first-pass binary can run `hello-world.sfn`, build a `build/bin/sfn-seedcheck` binary, then run the full test suite against it. This is the authoritative CI gate. | `sfn dev verify` |
| Same as verify, but a seedcheck/fixed-point rebuild mismatch is fatal. | `sfn dev verify --strict` |
| Run `sfn check` over the workspace maintainer-source inventory without codegen or clang. | `sfn dev verify --fast` |
| Run the full Sailfin-native test suite (unit + integration + e2e + capsule tests). | `sfn test` |
| Run unit tests from `compiler/tests/unit/*_test.sfn`. | `sfn test compiler/tests/unit` |
| Run integration tests from `compiler/tests/integration/*_test.sfn`. | `sfn test compiler/tests/integration` |
| Run end-to-end tests from `compiler/tests/e2e/*_test.sfn`. | `sfn test compiler/tests/e2e` |
| Run per-capsule tests under `capsules/`. | `sfn test $(sfn dev inventory member-tests)` |
| Build and package native artifacts into `dist/`. | `sfn package --out dist --compiler-bin build/bin/sfn` (add `--installer` for the installer bundle) |
| Download the pinned seed compiler (`bootstrap.toml [seed].version`) from GitHub Releases into `build/toolchains/seed/`. Set `GITHUB_TOKEN` to raise GitHub API rate limits. | `sfn dev bootstrap fetch` |
| Benchmark compiler per-module compile time and memory. | `sfn bench --compiler --import-context build/compiler/import-context` |
| Benchmark compiled-program runtime execution. | `sfn bench benchmarks/runtime` |
| Benchmark consumer-build cold/warm compile time and output-artifact size for fixtures under `benchmarks/consumer`. | `sfn bench --consumer` |
| Build the Sailfin MCP server under `tools/mcp-server/`. | `cd tools/mcp-server && npm ci && npm run build` (no native equivalent) |
| Remove `dist/` packaged artifacts. Does not remove build intermediates. | `sfn dev clean dist` |
| Remove `build/` artifacts (keeps the seed toolchain under `build/toolchains/` by default). Pass `--include-seed` to also remove it. | `sfn dev clean build` (`sfn dev clean build --include-seed` to also remove the seed) |
| Remove both `dist/` and `build/` artifacts completely. | `sfn dev clean all` |
| Print a summary of available commands. | `sfn --help`, `sfn dev --help` |

---

### Parallelism and validation shape

`sfn dev bootstrap build --force` routes through `<seed> build -p compiler`; the Sailfin-native
driver owns compiler module scheduling. The driver reads
`SAILFIN_BUILD_JOBS`; set it to a positive integer for build-parallelism
bisects or memory-constrained hosts.

`sfn test` and `sfn dev shard run` auto-detect parallelism from CPU and memory
(`min(cores, ((RAM * 80%) - 5 GiB) / 3 GiB)`, floor 1, cap 16, with a macOS cap
of 2) — the 3 GiB per-job reserve matches a measured pooled test child, and the
5 GiB term reserves the parent runner itself, which compiles the whole
dependency closure in-process before fanning out (SFN-547, re-sized SFN-626,
re-sized SFN-781). An explicit `--jobs N` wins over `SAILFIN_TEST_JOBS=N`; use
`--jobs 1` for the serial path.
When neither is passed, `sfn test` and `sfn dev verify`'s cold seedcheck suite
both size their pool from the same native auto-budget; `SAILFIN_TEST_JOBS=N`
overrides both. `sfn dev verify` also takes `--test-timeout N` for the
per-test timeout. Use `sfn dev verify --strict` when a seedcheck/fixed-point
rebuild mismatch must fail the run. Pooled test children (`--jobs N` with
`N > 1`) spawn with `SAILFIN_BUILD_JOBS=1` so a child's own per-module emit
fan-out cannot nest inside the test pool and multiply the peak; an explicitly
inherited `SAILFIN_BUILD_JOBS` still wins, and the serial path is unaffected.

---

## Environment Variables

These environment variables influence the behavior of `sfn`.

| Variable | Scope | Description |
|---|---|---|
| `SAILFIN_RUNTIME_ROOT` | `sfn` binary | Override the directory where `sfn` looks for the bundled runtime. By default, the runtime is resolved relative to the executable. |
| `SAILFIN_MEM_LIMIT` | `sfn` binary | Override the compiler's Linux self-applied 8 GiB virtual-memory cap. Use bytes, `unlimited`, `off`, or `0`. |
| `SAILFIN_BUILD_JOBS` | `sfn build -p compiler` | Override compiler module scheduling inside the build driver. Use `1` for serial bisects or a small value on memory-constrained hosts. |
| `SAILFIN_TEST_JOBS` | `sfn test` / `sfn dev shard run` | Override the native CPU/RAM-aware per-file worker default. An explicit `--jobs N` takes precedence; use `1` for serial execution. |
| `SFN_REGISTRY` | `sfn add` / `sfn publish` | Override the package registry base URL for this shell. Takes precedence over `~/.sfn/config.toml`. See [`sfn config`](#sfn-config-getsetunsetlist-key-value). |
| `SFN_TOKEN` | `sfn publish` | Bearer token used when uploading a capsule. Takes precedence over `~/.sfn/credentials` written by `sfn login`. |
| `SAILFIN_SKIP_TOOLCHAIN_CHECK` | `sfn build`/`run`/`check`/`test` | Set to `1` to downgrade a `[toolchain]` pin mismatch from a hard error to a warning for every invocation in the shell/CI job. See [Toolchain Pinning Flags](#toolchain-pinning-flags). |
| `SAILFIN_TOOLCHAIN` | `sfn build`/`run`/`check`/`test` | Controls the toolchain-pin mismatch response: `auto` (default) fetches + verifies + re-execs the pinned toolchain; `local` verifies only and errors on mismatch; `<version>` forces that dispatch target; `off` (or `0`) has the same effect as `SAILFIN_SKIP_TOOLCHAIN_CHECK=1`. See [Toolchain Pinning Flags](#toolchain-pinning-flags). |
| `SAILFIN_TOOLCHAIN_DISPATCHED` | `sfn build`/`run`/`check`/`test` | Set automatically by `sfn` before re-exec'ing a dispatched toolchain (`=<version>`) as a re-entrancy guard; not intended to be set by hand. |
| `SAILFIN_TOOLCHAIN_MANAGEMENT` | `sfn toolchain ...` | Set automatically by `sfn` before re-exec'ing a routed management payload (`=<version>`) as a re-entrancy guard; not intended to be set by hand. See [Management-command routing](#management-command-routing). |
| `SAILFIN_TOOLCHAIN_RELEASE_BASE` | `sfn toolchain install` | Override the release host for air-gapped mirrors (signature/digest verification stays mandatory). Also serves the signed toolchain index and its detached signature that `sfn toolchain install <version \| channel>` consults before any release-specific fetch — see [Installing a toolchain](#installing-a-toolchain). |
| `SAILFIN_CLEAN_KEEP_SEED` | `sfn dev clean build`/`all` | Set to `0` (equivalent to `--include-seed`) to also delete the seed toolchain store. Defaults to `1` (the seed toolchain is preserved). |
| `SAILFIN_TEST_SCRATCH` | `sfn test` | Override the scratch directory a test's subprocess builds are isolated into. |
| `SAILFIN_EFFECT_ENFORCE` | `sfn` binary | Control runtime effect-enforcement (the seal, SFEP-0016); partial on macOS arm64 (#613). |
| `GLOBAL_BIN_DIR` | Installer script | Override the installation bin directory directly (takes precedence over `PREFIX`). |
| `GITHUB_TOKEN` | installer / `sfn dev bootstrap fetch` | GitHub token used to raise API rate limits and access release assets. |
| `SAILFIN_CC` | `sfn` binary (native macOS final links) | Explicit Darwin clang-driver override. Defaults to `/usr/bin/clang`; object assembly still follows `PATH`. |

`sfn dev bootstrap build -- <arg>...` replaces the retired `BUILD_ARGS` Makefile
variable — arguments after a bare `--` are appended unchanged to the pinned
seed's `build -p compiler` invocation, e.g.
`sfn dev bootstrap build -- --no-cache --cache-trace`. The retired `SEED`,
`SEED_NATIVE`, `NATIVE_BIN`, `NATIVE_OUT`, `CLANG`, and `CLANG_LL_FLAGS`
variables have no native replacement — the seed path, output path, and clang
executable used for final links are no longer independently overridable. The
retired `SEED_VERSION` variable is still controllable, just not via an env
var: edit the `[seed].version` pin in `bootstrap.toml` directly, or use
`sfn dev bootstrap pin <version>`. The
retired `CHECK_TEST_TIMEOUT`, `CHECK_FULL_PASS1`, `SELFHOST_STRICT`, and
`JSON=1` variables are now flags: `sfn dev verify --test-timeout N`,
`sfn dev verify --full-pass1`, `sfn dev verify --strict`, and `--json` on
`sfn test` / `sfn check` / `sfn dev verify` respectively.

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
| `*_test.sfn` | Test files — discovered automatically by `sfn test` |
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

**Build the compiler from source** (clean checkout — no `sfn` installed yet, so
the installer provides a released `sfn` to drive the build; that build then
fetches the seed pinned in `bootstrap.toml` itself):

```bash
git clone https://github.com/SailfinIO/sailfin.git && cd sailfin
./install.sh                 # installs a released sfn to drive the build
sfn dev bootstrap build      # self-hosts -> build/bin/sfn
```

**Run the full test suite:**

```bash
sfn test
```

**Install the compiler locally:**

```bash
sfn dev bootstrap build
build/bin/sfn dev bootstrap install --from build/bin/sfn --prefix "$HOME/.local"
# compiler is now at ~/.local/bin/sfn
```

**Force a fresh rebuild:**

```bash
sfn dev bootstrap build --force
```

**Run only unit tests in a specific directory:**

```bash
build/bin/sfn test compiler/tests/unit/
```

**Run the CI validation gate locally:**

```bash
sfn dev verify
```

**Fetch a fresh seed compiler:**

```bash
GITHUB_TOKEN=<your-token> sfn dev bootstrap fetch
```

---

*See [Capsules and Packages](/docs/advanced/capsules) for documentation on `capsule.toml` and the planned package registry commands.*
