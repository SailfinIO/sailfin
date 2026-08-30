---
title: Capsules & Packages
description: Sailfin's package format — structure, manifests, dependencies, imports, and publishing.
section: advanced
sidebar:
  order: 1
---

A **capsule** is Sailfin's fundamental unit of packaging and distribution. Every Sailfin project — whether a single-file script or a large application — lives inside a capsule. If you are familiar with other languages, a capsule is analogous to a crate in Rust, a module in Go, or a package in Node.js.

Capsules are directories. The presence of a `capsule.toml` manifest file at the root of a directory is what makes it a capsule. Everything else — source files, tests, build artifacts — lives alongside that manifest.

## What a Capsule Is

A capsule has two responsibilities:

1. **It defines a unit of compilation.** The Sailfin compiler resolves imports at capsule boundaries and uses the manifest to locate dependencies.
2. **It defines a unit of trust.** The `[capabilities]` section of `capsule.toml` declares which effects the capsule uses. Today the compiler enforces this declaration **at compile time** — a capsule whose functions declare an effect outside a non-empty surface fails the build (`E0403`), and workspaces audit it. *Runtime* capability enforcement (gating effects at the syscall boundary in the running binary) is a 1.0 target, not yet shipped.

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

[toolchain]
sfn = "0.8.0-alpha.3"
channel = "alpha"
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
| `required` | array of strings | `[]` | Canonical effects or recognized dotted refinements this capsule requires. Roots: `"io"`, `"net"`, `"model"`, `"gpu"`, `"rand"`, `"clock"`; `"unsafe"` is a separate parsed annotation. |

#### `[build]`

| Field | Type | Default | Description |
|---|---|---|---|
| `entry` | string | `"src/mod.sfn"` | The source file the compiler starts from when building this capsule. For application capsules this is typically `"src/main.sfn"`. |
| `full-runtime` | boolean | `false` | Opts this artifact out of demand-driven `sfn-sources` selection ([sfn-source-gates]) entirely, forcing every gated runtime source to compile regardless of the build's declared effect surface. Runtime-provider artifacts (the compiler binary itself) set this because they must carry every runtime module regardless of what their own sources declare (SFN-882). |

#### `[sfn-source-gates]`

Runtime-only: applies to `runtime/capsule.toml` (`kind = "runtime"`), not to library or application capsules. By default, every source listed in `[build] sfn-sources` compiles unconditionally into every artifact — including runtime subsystems, like the TLS 1.3 stack, that a given build never exercises. `[sfn-source-gates]` narrows that: it is a table keyed by canonical effect name (`"io"`, `"net"`, `"model"`, `"gpu"`, `"rand"`, `"clock"`), each value an array of `sfn-sources` paths gated behind that effect.

```toml
[sfn-source-gates]
net = [
  "sfn/platform/tls.sfn",
  "sfn/platform/tls_record.sfn",
  # ...
]
```

A gated source compiles only when the build's demand set — the union of the project manifest's `[capabilities] required` and every effect token appearing in an `![...]` annotation across the unfiltered source set, each normalized through `effect_root()` — contains the gating effect. A source named in no gate always compiles. `[sfn-source-gates]` must be the last table in `runtime/capsule.toml`: the TOML reader scans from a section header to the next header to collect an array, so a section inserted before it would truncate `sfn-sources` under the pinned seed and break `sfn dev bootstrap build`.

Two environment overrides:

| Variable | Effect |
|---|---|
| `SAILFIN_RUNTIME_SOURCE_GATES=off` (also `0`/`false`) | Disables selection — every gated source compiles, reproducing the pre-gating artifact set. Useful for bisecting a regression against gating itself. |
| `SAILFIN_TRACE_RUNTIME_GATES=1` | Prints the computed demand set to stderr. |

Selection changes which sources reach the link line for a given build; it does not change binary size on its own (gated modules were already dead-strippable) and has no effect on `sfn check`, which never links. `sfn build -p compiler` always retains every runtime source (see `full-runtime` above), so it is unaffected by this table. Design: `docs/proposals/design-notes/runtime-demand-driven-sources.md` (SFN-882).

#### `[toolchain]`

Pins the `sfn` toolchain this capsule requires. See [Toolchain Pinning](#toolchain-pinning) for full detail.

| Field | Type | Required | Description |
|---|---|---|---|
| `sfn` | string | no | A semver floor — the running/selected `sfn` must be `>=` this version. |
| `version` | string | no | An exact release version this root selects — `0.10.4` is not satisfied by `0.10.5`. Independent of `sfn`; must itself satisfy `sfn`/`channel`. |
| `channel` | string | no | Minimum acceptable stability channel: `"stable"`, `"rc"`, `"beta"`, or `"alpha"`. |

## Capability Declarations

The `[capabilities]` section of `capsule.toml` lists the effects the capsule's code is permitted to use. This declaration has two purposes.

**For the compiler:** When a function in your capsule uses `print()` or reads from the filesystem, the compiler checks that `"io"` is in your `required` list. If it is not, you get a diagnostic with a suggested fix. When the surface is non-empty, an out-of-surface declaration fails with `E0403`. An absent or empty surface skips this compatibility cross-check; it is not deny-all.

**For workspaces and audits:** An opt-in workspace capability envelope enforces each member manifest's declared surface. It does not yet infer the complete source effect surface across the workspace.

```toml
[capabilities]
required = ["io", "net"]
```

Valid capability values:

| Capability | Required for |
|---|---|
| `io` | `print()`, `print.err()`, `fs.*`, `console.*`, `@logExecution` |
| `net` | `http.*`, `websocket.*`, `serve` |
| `model` | Reserved for the post-1.0 `sfn/ai` API; no shipped runtime API |
| `gpu` | Reserved for future accelerator APIs; no detector yet |
| `rand` | `sfn/crypto::random_bytes`; no general RNG detector |
| `clock` | `sleep`, `runtime.sleep`, wall-clock reads |
| `unsafe` | `unsafe` blocks, `unsafe extern fn` calls |

**Current status:** Compile-time manifest enforcement is shipped. Declared function effects must fit a non-empty `required` surface (`E0403`), using sub-effect subsumption: `"io"` covers `io.*`, while `"io.fs"` excludes sibling `io.console`. Runtime syscall enforcement remains a 1.0 target.

## Toolchain Pinning

The `[toolchain]` section declares which `sfn` toolchain builds this capsule — the downstream-project analogue of Go's `go 1.22` directive or `rust-toolchain.toml`. It is optional; a manifest with no `[toolchain]` section is unaffected (unpinned projects keep working exactly as before).

```toml
[toolchain]
sfn = "0.10.4"       # compatibility floor: the selected toolchain must be >= this
version = "0.10.4"   # exact compiler this root selects (independent of the floor)
channel = "stable"   # optional: reject a lower-stability selected toolchain
```

**`sfn` is a compatibility floor, not an exact pin (Go-style).** The selected `sfn` must be `>=` the stated version, ordered by semver precedence (build metadata after `+` is ignored for comparison). A floor of `0.8.0-alpha.2` is satisfied by `0.8.0-alpha.2`, `0.8.0-alpha.3`, `0.8.0`, or `0.9.0`, and is rejected by `0.8.0-alpha.1` or any `0.7.x` toolchain.

**`version` is an exact selection, independent of the floor (SFEP-0073 §3.2).** Unlike `sfn`, `version` must match exactly — a selected `0.10.4` is *not* satisfied by `0.10.5`. It answers a different question than the floor: `sfn` states the oldest compiler this capsule is intended to support; `version` states the exact compiler this root actually builds with today. Changing one never raises or lowers the other. `version` must be a complete release semver, optionally with prerelease identifiers — build metadata (`0.10.4+dev.abc123`), an incomplete version (`0.10`), and a moving channel alias (`stable`, `latest`) are all rejected with `invalid [toolchain] version` before any fetch is attempted. An exact `version` that does not itself satisfy this root's own `sfn` floor or `channel` constraint is also a manifest error, reported the same way, before any network access.

**`channel`** additionally requires a minimum stability level, ranked `stable` > `rc` > `beta` > `alpha`. `channel = "stable"` rejects any `-alpha`/`-beta`/`-rc` selected toolchain regardless of its core version number. It is independent of (and additive to) the `sfn` floor, and an exact `version` must also clear it.

**Workspace vs. member precedence.** In a multi-capsule project, a `workspace.toml` `[toolchain]` pin is the default for every member; a member's own `capsule.toml` `[toolchain]` overrides it **per field** (a member can override just `sfn`, just `version`, just `channel`, or any combination). See [Workspaces](./workspaces#toolchain-pinning).

**Selection precedence.** When more than one toolchain input applies, the highest-ranked one wins:

1. A one-shot CLI selector — `sfn +<version> <command> ...` (equivalently `sfn toolchain run <version> -- <command> ...`).
2. An explicit `SAILFIN_TOOLCHAIN=<version>` (a mode word like `auto`/`local`/`off` does not count as a selector here).
3. This root's exact `[toolchain] version`, resolved from the current working directory before any command is parsed — it applies to every ordinary command whose output can vary with the compiler (`version`, `init`, `fmt`, `check`, `build`, `run`, `test`, `emit`, `bench`, `package`, and the capsule-management commands), plus commands this toolchain does not recognize. (`sfn dev ...`, `sfn toolchain ...`, `sfn config`, `sfn login`, and `sfn completion` are never project-dispatched, so the self-hosting driver, the management/repair surface, and the entry-level configuration commands all keep working even when a selection is broken.)
4. The entry toolchain found on `PATH`.

Every selected candidate — however it was chosen — still has to clear this root's `sfn` floor and `channel` constraint; the three existing escape hatches below are the only way past a failing check.

**The gate.** `sfn build`, `sfn run`, `sfn check`, and `sfn test` verify the pin after resolving the project/workspace root, before doing any other work. On a satisfied pin, the command proceeds silently. On a mismatch, the default behavior (`SAILFIN_TOOLCHAIN=auto`) is to transparently fetch (if not already in the version store) and re-exec the pinned toolchain — a fresh clone plus `sfn build` just works with no manual install step. Under `SAILFIN_TOOLCHAIN=local`, or when auto-dispatch itself can't proceed (offline with nothing stored), the command instead fails with a non-zero exit and a diagnostic:

```
error: toolchain mismatch
  this project pins sfn >= 0.8.0-alpha.2 (capsule.toml [toolchain])
  but the running toolchain is 0.7.4-alpha.1
  install the pinned toolchain, or re-run with --skip-toolchain-check to override
```

Override the gate for a single invocation with `--skip-toolchain-check`, or for a whole shell/CI job with `SAILFIN_SKIP_TOOLCHAIN_CHECK=1` or `SAILFIN_TOOLCHAIN=off` (`=0` also works) — any of the three downgrade the hard error to a one-line warning and let the build proceed on the running toolchain, without dispatching. See the [CLI reference](/docs/reference/cli#toolchain-pinning-flags) for the full flag/env list and the `SAILFIN_TOOLCHAIN` knob modes (`auto`/`local`/`<version>`/`off`).

**`sfn init` scaffolding.** `sfn init` writes both `sfn` and `version` to the release version of the `sfn` binary doing the scaffolding (stripping any local `+dev.<hash>` build stamp), so a freshly created capsule is born with an explicit floor *and* pinned to the exact toolchain it was created with — matching `cargo new` stamping the edition and `go mod init` writing the `go` line. No command besides `sfn init` writes `version` into a manifest yet; editing it by hand is the only other way in.

**Inspecting the selection.** `sfn toolchain active` prints an `exact:` line naming this root's `version` field (beside the `requires:` floor line) when one is set, and the `sailfin-toolchains/1` JSON envelope's `requirement.version` carries the same value — see the [CLI reference](/docs/reference/cli#installing-a-toolchain).

**Current status:** declare, verify, and fetch + re-exec dispatch for the `sfn` floor (SFEP-0046 §3.1–3.5) are all implemented, as is exact project-root selection via `version` (SFEP-0073 §§3.2–3.3, "exact roots" slice). Not yet shipped: channel selectors/`latest` resolution in a project `version` field, the per-user default (`sfn toolchain default`), and `sfn toolchain update`. The proposal itself stays `Accepted` rather than `Implemented` until every slice lands — see `docs/status.md` for the current per-slice breakdown.

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

This requirement applies when your capsule has its own `capsule.toml` and is
not a member of a workspace that already ships the capsule. Inside a workspace,
membership alone resolves the import; see
[Workspace Imports](#workspace-imports) below.

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

Workspace membership is what resolves this import. The importing capsule does
**not** need to declare `"core"` in its own `[dependencies]` for the import to
compile — the resolver matches the specifier against the workspace's member
list directly.

Declaring it anyway is still worth doing:

```toml
[dependencies]
"core" = "*"
```

Declare a workspace sibling when you want the dependency pinned explicitly, or
when the capsule may later be **published and consumed outside this
workspace**. A capsule that has its own `capsule.toml` but is not a workspace
member resolves scoped imports only through `[dependencies]` — so an
undeclared import that compiles for you will fail for that consumer.

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
import { serve, Request, Response, response } from "sfn/http";

fn handle_request(req: Request) -> Response {
    log.info("Received: {{req.path}}");
    return response("OK");
}

fn main() ![io, net] {
    log.info("Starting server on :8080");
    serve(handle_request as * fn (Request) -> Response, 8080);
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

The registry and `sfn publish` upload path are shipped. The current command
validates the manifest, packages `capsule.toml` and `src/**/*.sfn`, and uploads
the payload. Automatic pre-publish tests, inferred capability auditing, broader
ignore-file packaging rules, and signed provenance remain future hardening.

Capsule versions are immutable once published. To update a capsule, increment the version in `capsule.toml` and publish again.

## Summary

| Concept | Quick reference |
|---|---|
| Capsule root | Directory containing `capsule.toml` |
| Entry point | `[build] entry = "src/mod.sfn"` |
| Public API | Functions and types with `export` keyword |
| Dependency | Entry in `[dependencies]` + `import` in source |
| Capability | Effect declared in `[capabilities] required = [...]` |
| Toolchain pin | `[toolchain] sfn = "<floor>"` (+ optional `channel`); gated on `build`/`run`/`check`/`test` |
| Import (relative) | `import { X } from "./module"` |
| Import (registry) | `import { X } from "sfn/log"` |
| Import (workspace) | `import { X } from "core"` |
| Run | `sfn run src/main.sfn` |
| Test | `sfn test` |
| Publish | `sfn publish [path]` |
