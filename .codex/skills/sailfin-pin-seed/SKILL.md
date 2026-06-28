---
name: sailfin-pin-seed
description: Pin the Sailfin seed compiler to a published release and verify the seed binary.
---

# Sailfin Pin Seed Skill

Use this skill when asked to update `.seed-version`.

## Workflow

1. Normalize the requested version by stripping a leading `v`/`V`; `.seed-version` stores the bare version.
2. Show the current pin with `cat .seed-version`.
3. Update only `.seed-version`.
4. Run `make fetch-seed` to download the matching release binary.
5. Run `build/seed/bin/sailfin version` and confirm it reports the expected version.
6. If requested or needed before merge, run `make compile`.
7. Commit only `.seed-version` with `chore(seed): pin seed to <VERSION>`.

## Failure handling

- If the release is missing or the binary version mismatches, restore the previous `.seed-version` and report the failure.
- Do not commit build artifacts.
- A compile failure after pinning should be investigated as a compiler/seed issue, not papered over in build orchestration.
