---
title: Workspaces
description: Multi-capsule projects with shared policies.
section: advanced
order: 2
---

Workspaces let you manage multiple capsules in a single repository with shared configuration.

## workspace.toml

```toml
[workspace]
members = [
    "core",
    "http-server",
    "cli",
]

[workspace.policies]
max-effects = ["io", "net", "model"]
require-tests = true

[workspace.profiles.release]
optimization = "aggressive"
strip = true
```

## Structure

```
my-project/
├── workspace.toml
├── core/
│   ├── capsule.toml
│   └── src/
├── http-server/
│   ├── capsule.toml
│   └── src/
└── cli/
    ├── capsule.toml
    └── src/
```

## Shared Policies

Workspaces enforce policies across all members:

- **Effect limits**: Restrict which effects any capsule can use
- **Test requirements**: Enforce test coverage
- **Provenance**: Require generation cards for model calls
- **Dependency constraints**: Shared version pinning

---

*Workspace support is specified but not yet fully implemented in the CLI. See the [package management proposal](https://github.com/SailfinIO/sailfin/blob/main/docs/proposals/package-management.md).*
