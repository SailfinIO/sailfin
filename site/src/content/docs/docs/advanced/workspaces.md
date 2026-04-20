---
title: Workspaces
description: Multi-capsule projects with shared dependency resolution and capability policies.
section: advanced
sidebar:
  order: 2
---

A **workspace** is a collection of related capsules that are developed, built, and governed together. Workspaces are Sailfin's answer to the monorepo: they let you keep multiple packages in a single repository while giving you shared dependency resolution, unified test runs, and — critically — shared security policies that restrict which capsules may use which capabilities.

A workspace is defined by a `workspace.toml` file at the root of the repository. Each member capsule retains its own `capsule.toml` for its own metadata and dependencies.

**Note:** The workspace tooling and the `[policies.*]` enforcement are designed and specified. Full CLI integration is planned for a future release. The `workspace.toml` format described here is the target design.

## When to Use a Workspace

Use a workspace when:

- You have multiple capsules in a single repository that depend on each other.
- You want to share a dependency version across all capsules (pin once, use everywhere).
- You need to enforce security policies — for example, ensuring only one designated capsule can make network requests or use `unsafe`.
- You want to run tests across the entire codebase with a single command.

Do **not** use a workspace for single-capsule projects. A workspace adds coordination overhead that has no benefit if there is only one capsule. A standalone `capsule.toml` is sufficient.

## Workspace Structure

A workspace is a directory containing a `workspace.toml` and one or more capsule subdirectories:

```
my-workspace/
├── workspace.toml          # workspace manifest
├── core/
│   ├── capsule.toml        # capsule manifest
│   └── src/
│       ├── mod.sfn
│       └── types.sfn
├── api/
│   ├── capsule.toml
│   └── src/
│       ├── mod.sfn
│       └── handlers.sfn
└── cli/
    ├── capsule.toml
    └── src/
        └── main.sfn
```

Each subdirectory listed under `members` in `workspace.toml` is an independent capsule. It has its own `capsule.toml`, its own version, and its own public API. The workspace merely coordinates them.

## The `workspace.toml` Manifest

```toml
[workspace]
members = ["core", "api", "cli"]
resolver = "v1"

[policies.unsafe]
allowed_capsules = ["core"]
require_annotation = "@security-reviewed"

[policies.net]
allowed_capsules = ["api", "cli"]

[policies.model]
allowed_capsules = ["api"]

[shared-dependencies]
"sfn/log" = "^0.1"
"sfn/json" = "^1.0"
```

### Field Reference

#### `[workspace]`

| Field | Type | Required | Description |
|---|---|---|---|
| `members` | array of strings | yes | Relative paths to capsule directories. Each path must contain a `capsule.toml`. The resolver processes all members together. |
| `resolver` | string | no | Dependency resolver version. Currently `"v1"`. This field exists for forward compatibility. |

#### `[policies.<capability>]`

Each `[policies.*]` section restricts use of one capability across the workspace. The key after `policies.` is any valid capability name: `unsafe`, `net`, `io`, `model`, `gpu`, `rand`, `clock`.

| Field | Type | Description |
|---|---|---|
| `allowed_capsules` | array of strings | Only these capsules may declare this capability in their `[capabilities]` section. Any other capsule that declares it will cause a policy violation. |
| `require_annotation` | string | Any function using this capability must carry this annotation decorator. Useful for requiring code-review sign-off on security-sensitive code. |

If a `[policies.<capability>]` section is absent for a given capability, that capability is unrestricted within the workspace.

#### `[shared-dependencies]`

A table of dependency name → version constraint that applies to every member capsule. When a capsule's own `capsule.toml` declares the same dependency, the workspace version is used as the floor: the resolver selects the highest version satisfying both constraints.

If a capsule needs to override the shared version, it can declare a stricter constraint in its own `capsule.toml`. It cannot declare a version that conflicts with the workspace constraint.

## Shared Policies

Policies are the primary reason to use a workspace in a security-conscious project. They enforce security boundaries at the package level, before code review and before runtime.

### Restricting `unsafe`

In most applications, only a small portion of the codebase should ever touch raw pointers or call C functions. A workspace policy can encode this:

```toml
[policies.unsafe]
allowed_capsules = ["core"]
require_annotation = "@security-reviewed"
```

With this policy in place:

- Only the `core` capsule may list `"unsafe"` in its `[capabilities] required`.
- The `api` and `cli` capsules will fail the workspace policy check if they declare `"unsafe"`, even if the compiler would otherwise accept it.
- Every `unsafe` block inside `core` must be on a function decorated with `@security-reviewed`.

### Restricting network access

For compliance or supply-chain security, you may want only explicitly nominated capsules to make outbound network calls:

```toml
[policies.net]
allowed_capsules = ["api", "cli"]
```

If a future developer adds `sfn/http` to `core` without realizing it violates policy, the workspace check catches it before the change is merged.

### Restricting model inference

In an application that handles sensitive data, you may want only the designated AI capsule to invoke language models:

```toml
[policies.model]
allowed_capsules = ["api"]
```

## Shared Dependencies

The `[shared-dependencies]` table pins versions once for the whole workspace. This solves the "diamond dependency" problem: if `api` and `cli` both depend on `sfn/json`, without a workspace they might resolve different minor versions, producing subtle incompatibilities. With shared dependencies they are guaranteed to use the same resolved version.

```toml
[shared-dependencies]
"sfn/log" = "^0.1"
"sfn/json" = "^1.0"
"sfn/crypto" = "^0.3"
```

### Per-Capsule Overrides

A capsule can declare a more specific constraint in its own `capsule.toml`:

```toml
# core/capsule.toml
[dependencies]
"sfn/json" = "~1.2"   # requires at least 1.2.x, not just any 1.x
```

The resolver takes the intersection: it must satisfy both `^1.0` from the workspace and `~1.2` from the capsule, so it will pick the highest version in `>=1.2.0, <1.3.0`. A capsule cannot widen the shared constraint — if the workspace pins `^1.0`, a capsule cannot request `^2.0`.

## Intra-Workspace Imports

A capsule within a workspace can import from any other member capsule, as long as the dependency is declared. The import syntax is the same as a registry import, using the target capsule's name.

### Declaring the Intra-Workspace Dependency

In `api/capsule.toml`:

```toml
[capsule]
name = "api"
version = "0.1.0"

[dependencies]
"core" = { path = "../core" }
"sfn/log" = "^0.1"

[capabilities]
required = ["io", "net"]
```

The `path` key tells the resolver to use the local directory instead of the registry.

### Importing in Source

```sfn
// api/src/handlers.sfn
import { UserRecord, validate_user } from "core";
import { log } from "sfn/log";

fn handle_login(req: Request) -> Response ![io, net] {
    let user: UserRecord = validate_user(req.body);
    match user {
        UserRecord { id, name } => {
            log.info("Login success: {{name}}");
            return Response { status: 200, body: "Welcome, {{name}}" };
        },
    }
}
```

### Cyclic Dependencies

Cyclic dependencies between workspace members are not allowed. If `api` depends on `core`, then `core` must not depend on `api`. The resolver will report a cycle error if it detects one.

The typical layering for a three-capsule workspace is:

```
cli ──depends on──> api ──depends on──> core
```

`core` has no intra-workspace dependencies. `api` depends only on `core`. `cli` may depend on both `api` and `core`.

## Running Workspace Commands

The planned `sfn workspace` subcommand will operate across all member capsules:

```bash
# Planned — not yet implemented

# Run tests in all member capsules
sfn workspace test

# Build all member capsules
sfn workspace build

# Build one specific capsule and its dependencies
sfn workspace build api

# Check policy compliance across the workspace
sfn workspace check-policies
```

In the current toolchain, you can run per-capsule commands from each capsule's directory:

```bash
cd core && sfn test
cd api && sfn test
cd cli && sfn test
```

Or write a `Makefile` or shell script to orchestrate them at the workspace level.

## Complete Example

Here is a complete workspace showing how all the pieces fit together.

### `workspace.toml`

```toml
[workspace]
members = ["core", "api", "cli"]
resolver = "v1"

[policies.unsafe]
allowed_capsules = ["core"]
require_annotation = "@security-reviewed"

[policies.net]
allowed_capsules = ["api"]

[shared-dependencies]
"sfn/log" = "^0.1"
```

### `core/capsule.toml`

```toml
[capsule]
name = "core"
version = "0.1.0"
description = "Business logic and data types"

[capabilities]
required = ["io", "unsafe"]
```

### `api/capsule.toml`

```toml
[capsule]
name = "api"
version = "0.1.0"
description = "HTTP API layer"

[dependencies]
"core" = { path = "../core" }

[capabilities]
required = ["io", "net"]
```

### `cli/capsule.toml`

```toml
[capsule]
name = "cli"
version = "0.1.0"
description = "Command-line interface"

[dependencies]
"core" = { path = "../core" }

[capabilities]
required = ["io"]
```

This configuration enforces:

- Only `core` can use `unsafe` (and only on functions annotated with `@security-reviewed`).
- Only `api` can make network calls.
- `cli` can only do local I/O.

## Summary

| Concept | Quick reference |
|---|---|
| Workspace root | Directory containing `workspace.toml` |
| Members | `[workspace] members = ["core", "api", "cli"]` |
| Capability restriction | `[policies.unsafe] allowed_capsules = ["core"]` |
| Shared dependency | `[shared-dependencies] "sfn/log" = "^0.1"` |
| Intra-workspace dep | `"core" = { path = "../core" }` in capsule's `[dependencies]` |
| Intra-workspace import | `import { X } from "core"` |
| Workspace tests | `sfn workspace test` (planned) |
