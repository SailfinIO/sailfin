---
title: Capsules & Packages
description: Sailfin's package management system.
section: advanced
order: 1
---

Capsules are Sailfin's package format. Each capsule has a `capsule.toml` manifest.

## Creating a Capsule

```bash
sfn init my-capsule
```

This generates:

```
my-capsule/
├── capsule.toml
├── src/
│   └── main.sfn
└── tests/
```

## capsule.toml

```toml
[capsule]
name = "my-capsule"
version = "0.1.0"
edition = "2025"

[dependencies]
http-client = "^1.2.0"

[capabilities]
required = ["io", "net"]
```

## Dependencies

```bash
sfn add http-client         # Add a dependency
sfn remove http-client      # Remove it
sfn update                  # Update all dependencies
```

Dependencies are resolved from [registry.sailfin.dev](https://registry.sailfin.dev).

## Publishing

```bash
sfn publish
```

## Capability Auditing

```bash
sfn capabilities audit
```

Lists all capabilities required by your capsule and its dependency tree.

## Model Dependencies

Capsules can declare model dependencies:

```toml
[models]
gpt4o = { provider = "openai", model = "gpt-4o", version = "2025-01-01" }
```

```bash
sfn add-model openai:gpt-4o
sfn models sync
```

---

*Package management CLI integration is planned for post-1.0. The registry at [registry.sailfin.dev](https://registry.sailfin.dev) is live.*
