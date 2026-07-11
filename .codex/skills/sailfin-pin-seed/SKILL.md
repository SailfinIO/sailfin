---
name: sailfin-pin-seed
description: Pin the Sailfin seed compiler to a published release and verify the seed binary.
---

# Sailfin Pin Seed Skill

Use this skill when asked to update the seed pin in `bootstrap.toml`.

## Workflow

1. Normalize the requested version by stripping a leading `v`/`V`; `bootstrap.toml [seed].version` stores the bare version.
2. Show the current pin by reading `[seed].version` from `bootstrap.toml`:
   ```bash
   awk '
     /^\[[^]]+\]/ { section=$0 }
     section == "[seed]" && /^version[[:space:]]*=/ { gsub(/"/, "", $3); print $3; exit }
   ' bootstrap.toml
   ```
3. Update `bootstrap.toml [seed].version` and the compiler `compiler/capsule.toml [toolchain].sfn` floor in lockstep (SFEP-0047 §3.4). Leave `[capsule].version` (the compiler source version) alone — that is a release-time bump.
4. Run `make fetch-seed` to download the matching release binary (it reads `bootstrap.toml [seed].version`).
5. Run `build/toolchains/seed/bin/sfn version` and confirm it reports the expected version.
6. If requested or needed before merge, run `make compile`.
7. Commit only `bootstrap.toml` and `compiler/capsule.toml` with `chore(seed): pin seed to <VERSION>`.

## Failure handling

- If the release is missing or the binary version mismatches, restore the previous `bootstrap.toml` / `compiler/capsule.toml` and report the failure.
- Do not commit build artifacts.
- A compile failure after pinning should be investigated as a compiler/seed issue, not papered over in build orchestration.
