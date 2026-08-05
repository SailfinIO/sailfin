---
name: sailfin-pin-seed
description: Update and verify the pinned seed version in bootstrap.toml and compiler/capsule.toml.
---

# Sailfin Pin Seed Skill

Updates the seed pin in `bootstrap.toml` (`[seed].version`) and `compiler/capsule.toml` (`[toolchain].sfn`), fetches the binary, and verifies it builds the compiler.

## Steps

1. Parse target version (e.g. `0.5.10-alpha.12` or `v0.5.10-alpha.12`).
2. Update `bootstrap.toml [seed].version` and `compiler/capsule.toml [toolchain].sfn`.
3. Fetch the new seed: `make fetch-seed`.
4. Smoke check: `build/toolchains/seed/bin/sfn version`.
5. Optional full verification: `make compile`.
6. Commit changes: `chore(seed): pin seed to <VERSION>`.
