---
title: Capsules & Packages
description: Sailfin's package format — structure, manifests, dependencies, imports, and publishing.
section: advanced
order: 1
---

A **capsule** is Sailfin's fundamental unit of packaging and distribution. Every Sailfin project — whether a single-file script or a large application — lives inside a capsule. If you are familiar with other languages, a capsule is analogous to a crate in Rust, a module in Go, or a package in Node.js.

Capsules are directories. The presence of a `capsule.toml` manifest file at the root of a directory is what makes it a capsule. Everything else — source files, tests, build artifacts — lives alongside that manifest.

## What a Capsule Is

A capsule has two responsibilities:

1. **It defines a unit of compilation.** The Sailfin compiler resolves imports at capsule boundaries and uses the manifest to locate dependencies.
2. **It defines a unit of trust.** The `[capabilities]` section of `capsule.toml` declares which effects the capsule uses. Workspaces and runtime enforcement use this declaration to audit and restrict what each capsule is allowed to do.

A capsule can be one of two things:

- **A library capsule** — exposes a public API through `export` declarations; no `fn main()` entry point. Other capsules can depend on it.
- **An application capsule** — has a `fn main() ![...]` entry point and is meant to be run directly.

Both types use the same `capsule.toml` format. The distinction is simply whether a `main` function is present.

## Capsule Structure

A typical library capsule looks like this:

```
my-capsule/
├── capsule.toml          # manifest (required)
├── src/
│   ├── mod.sfn           # public API entry point
│   └── lib.sfn           # internal implementation
└── tests/
    └── lib_test.sfn      # regression tests
```

A typical application capsule:

```
my-app/
├── capsule.toml
├── src/
│   ├── main.sfn          # entry point with fn main()
│   ├── config.sfn
│   └── handlers.sfn
└── tests/
    └── handlers_test.sfn
```

The compiler does not enforce any particular directory layout beyond the presence of `capsule.toml`. The `entry` field in `[build]` controls where compilation starts.

## The `capsule.toml` Manifest

Every capsule is defined by its `capsule.toml` manifest. Here is a comprehensive example:

```toml
[capsule]
name = "my-capsule"
version = "1.0.0"
description = "A helpful capsule that fetches and logs data"
authors = ["Jane Dev <jane@example.com>"]
license = "MIT"
repository = "https://github.com/org/my-capsule"

[dependencies]
"sfn/log" = "^0.1"
"sfn/http" = "^0.2"

[capabilities]
required = ["io", "net"]
# unsafe = false  (default — set to true only if the capsule uses unsafe blocks)

[build]
entry = "src/mod.sfn"
```

### Field Reference

#### `[capsule]`

| Field | Type | Required | Description |
|---|---|---|---|
| `name` | string | yes | The capsule's identifier. Must be lowercase, hyphen-separated. Used to identify the capsule in the registry and in `import` paths. |
| `version` | string | yes | Semantic version string (`MAJOR.MINOR.PATCH`). Follows [semver](https://semver.org). |
| `description` | string | recommended | A short human-readable summary of what the capsule does. |
| `authors` | array of strings | no | List of author names and optional email addresses in `"Name <email>"` format. |
| `license` | string | recommended | SPDX license identifier (e.g., `"MIT"`, `"Apache-2.0"`, `"BSD-3-Clause"`). |
| `repository` | string | no | URL of the source repository. Used by the registry for discoverability. |

#### `[dependencies]`

A table mapping dependency names to version constraint strings. See the [Dependencies](#dependencies) section for detail on constraint syntax and resolution.

#### `[capabilities]`

Declares which effects this capsule uses. See the [Capability Declarations](#capability-declarations) section for full detail.

| Field | Type | Default | Description |
|---|---|---|---|
| `required` | array of strings | `[]` | Effects this capsule requires. Valid values: `"io"`, `"net"`, `"model"`, `"gpu"`, `"rand"`, `"clock"`, `"unsafe"`. |

#### `[build]`

| Field | Type | Default | Description |
|---|---|---|---|
| `entry` | string | `"src/mod.sfn"` | The source file the compiler starts from when building this capsule. For application capsules this is typically `"src/main.sfn"`. |

## Capability Declarations

The `[capabilities]` section of `capsule.toml` lists the effects the capsule's code is permitted to use. This declaration has two purposes.

**For the compiler:** When a function in your capsule uses `print()` or reads from the filesystem, the compiler checks that `"io"` is in your `required` list. If it is not, you get a diagnostic with a suggested fix. Without the declaration, effect-annotated functions cannot compile in capsule context.

**For workspaces and audits:** A workspace can inspect the declared capabilities of every member capsule and enforce policies — for example, preventing any capsule other than a designated networking capsule from declaring `"net"`, or requiring that all `"unsafe"` capsules have passed a security review.

```toml
[capabilities]
required = ["io", "net"]
```

Valid capability values:

| Capability | Required for |
|---|---|
| `io` | `print()`, `print.err()`, `fs.*`, `console.*`, `@logExecution` |
| `net` | `http.*`, `websocket.*`, `serve` |
| `model` | `prompt` blocks, model inference |
| `gpu` | GPU compute kernels |
| `rand` | random number generation |
| `clock` | `sleep`, `runtime.sleep`, wall-clock reads |
| `unsafe` | `unsafe` blocks, `unsafe extern fn` calls |

**Current status:** The capability manifest format is designed and the field is parsed. Compile-time enforcement against the manifest (rejecting capsule builds that use effects not listed in `required`) is planned for the native compiler.

## Dependencies

The `[dependencies]` table lists other capsules your capsule depends on. Dependency names are the capsule's registry identifier, and values are version constraint strings.

```toml
[dependencies]
"sfn/log" = "^0.1"
"sfn/http" = "^0.2"
"sfn/json" = "~1.2"
"sfn/crypto" = "1.0.0"
```

### Version Constraint Syntax

| Constraint | Meaning |
|---|---|
| `"^1.0"` | Compatible with 1.0: allows `>=1.0.0, <2.0.0`. The most common constraint. Use when you want to receive minor and patch updates but not breaking changes. |
| `"^0.2"` | For pre-1.0 versions: allows `>=0.2.0, <0.3.0`. The minor version is treated as the major version boundary. |
| `"~1.2"` | Patch-compatible: allows `>=1.2.0, <1.3.0`. Use when you need a specific minor version. |
| `"1.0.0"` | Exact version only. Use sparingly — it makes dependency resolution more difficult for consumers. |

### Adding Dependencies

Use `sfn add <capsule>` to record a dependency in `capsule.toml` and pre-fetch the package into `~/.sfn/cache/`. Pass `--dev` for dev-only dependencies and `--update` to pick up a newer version instead of honoring the lockfile:

```bash
sfn add http                  # add sfn/http (stdlib)
sfn add --dev test            # dev dependency
sfn add acme/router           # third-party scoped capsule
sfn add --update acme/router  # ignore lockfile, fetch latest
```

The build system fetches capsules from the configured registry (`pkg.sfn.dev` by default; override with `sfn config set registry <url>` or `SFN_REGISTRY`).

### Dependency Resolution

The Sailfin resolver uses a version-constraint solver similar to Cargo's. It selects the highest version of each dependency that satisfies all constraints across the dependency graph. When a workspace is present, resolution is performed across all member capsules simultaneously to avoid version conflicts (see [Workspaces](./workspaces)).

## Imports Within a Capsule

Sailfin uses a single `import` syntax for all import kinds. The form of the module path determines how it is resolved.

### Relative Imports

Use `"./path"` or `"../path"` to import from files within the same capsule:

```sfn
// src/lib.sfn
fn compute(x: number) -> number {
    return x * x;
}
```

```sfn
// src/mod.sfn
import { compute } from "./lib";

export fn process(values: number[]) -> number[] ![io] {
    let results = values.map(compute);
    print("{{results}}");
    return results;
}
```

The compiler resolves `"./lib"` to `./lib.sfn` relative to the importing file.

### Registry Capsule Imports

Use the capsule's registry name to import from a declared dependency:

```sfn
import { log } from "sfn/log";
import { get, post } from "sfn/http";

fn fetch_data(url: string) -> string ![net, io] {
    log.info("fetching: " + url);
    let response = get(url);
    return response.body;
}
```

The capsule name (`"sfn/log"`) must appear in your `[dependencies]` table.

### Workspace Imports

When capsules live in the same workspace, one capsule can import from another using the target capsule's name:

```sfn
// In capsule "api", importing from capsule "core"
import { UserRecord, validate_user } from "core";

fn handle_login(req, res) ![io, net] {
    let user = validate_user(req.body);
    // ...
}
```

The importing capsule must list the dependency in its own `capsule.toml`:

```toml
[dependencies]
"core" = { path = "../core" }
```

The `path` key tells the resolver to use the local directory rather than fetching from the registry.

## Exporting a Public API

A library capsule's public surface is defined by what it `export`s. Anything not exported is internal to the capsule and cannot be imported by other capsules.

```sfn
// src/mod.sfn — the public entry point for capsule "my-capsule"

import { compute_inner } from "./lib";        // internal, not re-exported
import { format_output } from "./formatter";  // internal

// This type is part of the public API
export struct ComputeResult {
    value: number;
    steps: number;
}

// This function is part of the public API
export fn compute(input: number) -> ComputeResult {
    let raw = compute_inner(input);
    return ComputeResult { value: raw, steps: 1 };
}

// This helper is internal — NOT exported
fn debug_repr(r: ComputeResult) -> string {
    return "ComputeResult({{r.value}})";
}
```

Consumers of this capsule can import `ComputeResult` and `compute`, but not `debug_repr` or anything from `./lib` or `./formatter`.

**Design rule:** Keep your public API small. Export only the types and functions that form a stable, intentional interface. Internal implementation details are free to change without breaking consumers.

## Application Capsule vs Library Capsule

### Application Capsule

An application capsule has a `fn main()` entry point. The build system calls `main` when the capsule is run. Effects used by `main` must be declared both in the function signature and in the capsule's `[capabilities]`.

```toml
# capsule.toml for an application
[capsule]
name = "my-app"
version = "0.1.0"

[capabilities]
required = ["io", "net"]

[build]
entry = "src/main.sfn"
```

```sfn
// src/main.sfn
import { log } from "sfn/log";
import { serve } from "http";

fn handle_request(req, res) ![io] {
    print("Received: {{req.path}}");
    res.send("OK");
}

fn main() ![io, net] {
    log.info("Starting server on :8080");
    serve(handle_request, { port: 8080 });
}
```

### Library Capsule

A library capsule has no `main`. It exports types and functions for other capsules to use.

```toml
# capsule.toml for a library
[capsule]
name = "my-lib"
version = "0.1.0"

[capabilities]
required = ["io"]

[build]
entry = "src/mod.sfn"
```

```sfn
// src/mod.sfn
export struct Config {
    debug: boolean;
    log_level: string;
}

export fn load_config(path: string) -> Config ![io] {
    // read from filesystem
    let raw = fs.read(path);
    return parse_config(raw);
}

fn parse_config(raw: string) -> Config {
    // internal — not exported
    return Config { debug: false, log_level: "info" };
}
```

## Using the `sfn/log` Capsule

The `sfn/log` capsule is the canonical logging dependency for Sailfin programs. Here is how to use it end-to-end.

### Add the dependency

```toml
[dependencies]
"sfn/log" = "^0.1"

[capabilities]
required = ["io"]
```

### Import and use

```sfn
import { log } from "sfn/log";

fn process_order(order_id: number) ![io] {
    log.info("Processing order {{order_id}}");

    // ... processing logic ...

    if order_id < 0 {
        log.error("Invalid order ID: {{order_id}}");
        return;
    }

    log.debug("Order processed successfully");
}
```

`sfn/log` uses the `io` effect because it writes to standard output and standard error. Any function that calls a `log.*` method must declare `![io]` in its signature, and the capsule must list `"io"` in its `[capabilities]`.

### Available log levels

| Function | Output stream | Intended use |
|---|---|---|
| `log.debug(msg)` | stdout | Detailed developer-facing trace |
| `log.info(msg)` | stdout | Normal operational events |
| `log.warn(msg)` | stderr | Recoverable anomalies |
| `log.error(msg)` | stderr | Failures and errors |

## Building and Running

Once your capsule is set up, use the `sailfin` binary (or `sfn`) to build and run:

```bash
# Run an application capsule's main entry point
sfn run src/main.sfn

# Run all tests in the capsule
sfn test

# Run tests in a specific file
sfn test tests/lib_test.sfn

# Build the native binary (output to dist/)
sfn build
```

When `sfn run` or `sfn build` is invoked, the build system:

1. Reads `capsule.toml` to identify dependencies and the entry point.
2. Resolves all `import` statements to source files or cached registry capsules.
3. Type-checks and effect-checks the entire program.
4. Emits `.sfn-asm` IR and lowers to LLVM IR.
5. Links the native binary.

If a dependency is not yet in the local cache, the build system fetches it from the configured registry (`pkg.sfn.dev` by default) before proceeding.

## Writing Tests

Tests live in `tests/` by convention. Each test file uses `.sfn` extension and contains `test` blocks:

```sfn
// tests/lib_test.sfn
import { compute } from "../src/mod";

test "compute: squares the input" {
    let result = compute(4);
    assert result.value == 16;
    assert result.steps == 1;
}

test "compute: handles zero" {
    let result = compute(0);
    assert result.value == 0;
}
```

Run with:

```bash
sfn test
```

All test blocks in the capsule's test files are discovered and run. Tests that require effects must declare them:

```sfn
test "loads config from disk" ![io] {
    let config = load_config("fixtures/test_config.toml");
    assert config.debug == true;
}
```

## Publishing

The default Sailfin package registry is live at [pkg.sfn.dev](https://pkg.sfn.dev). Enterprise users who need to host capsules behind a firewall can stand up a private registry and point their local toolchain at it:

```bash
# Persist per-user (writes ~/.sfn/config.toml)
sfn config set registry https://registry.acme.internal

# Or override just for the current shell
export SFN_REGISTRY=https://registry.acme.internal
```

Resolution order, highest priority first: `SFN_REGISTRY` env var → `~/.sfn/config.toml` → compiled-in default (`https://pkg.sfn.dev`).

Publishing a capsule is a two-step flow:

```bash
sfn login                       # save your auth token to ~/.sfn/credentials (600)
sfn publish                     # package the current capsule and upload it
sfn publish path/to/capsule     # or package a capsule from a specific path
```

`sfn publish` bundles the capsule source (`capsule.toml` + `src/**/*.sfn`) into a SFNPKG payload, computes a SHA-256 digest, and POSTs it to `<registry>/api/publish` using the bearer token from `SFN_TOKEN` or `~/.sfn/credentials`. The registry URL is resolved through the same precedence as `sfn add` (`SFN_REGISTRY` → `~/.sfn/config.toml` → default). Capability auditing and signed provenance are in progress on the [roadmap](https://sailfin.dev/roadmap).

The planned publication flow:

```bash
# Planned — not yet implemented
sfn publish
```

Before publishing, the toolchain will:

1. Run `sfn test` and fail if any tests fail.
2. Verify `capsule.toml` has `name`, `version`, `description`, and `license`.
3. Check that declared `[capabilities]` match the effects used in source.
4. Package the source (excluding `tests/`, build artifacts, and `.gitignore`d files).
5. Upload to the registry under your authenticated account.

Capsule versions are immutable once published. To update a capsule, increment the version in `capsule.toml` and publish again.

## Summary

| Concept | Quick reference |
|---|---|
| Capsule root | Directory containing `capsule.toml` |
| Entry point | `[build] entry = "src/mod.sfn"` |
| Public API | Functions and types with `export` keyword |
| Dependency | Entry in `[dependencies]` + `import` in source |
| Capability | Effect declared in `[capabilities] required = [...]` |
| Import (relative) | `import { X } from "./module"` |
| Import (registry) | `import { X } from "sfn/log"` |
| Import (workspace) | `import { X } from "core"` |
| Run | `sfn run src/main.sfn` |
| Test | `sfn test` |
| Publish | `sfn publish` (planned) |
