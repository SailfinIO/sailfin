---
name: pin-seed
description: Pin the Sailfin seed compiler to a specific released version. Updates bootstrap.toml [seed].version and the compiler [toolchain] floor, fetches the binary, and optionally runs a smoke compile to verify the new seed builds the compiler. Usage: /pin-seed <version> (e.g. /pin-seed v0.5.10-alpha.12 or /pin-seed 0.5.10-alpha.12).
allowed-tools: Bash, Read, Edit
---

# Pin a new seed version

Updates the seed pin in `bootstrap.toml` (`[seed].version`) and the compiler's public `[toolchain].sfn` floor, downloads the new binary, and verifies it can compile the compiler.

## Steps

### 1. Parse and normalize the version

The version comes from `$ARGUMENTS` (what the user typed after `/pin-seed`). Strip any leading `v` or `V` — `bootstrap.toml [seed].version` stores bare versions like `0.5.10-alpha.12`. Fail immediately if no version is provided or if the result after stripping is empty.

### 2. Check current pin

```bash
awk '
  /^\[[^]]+\]/ { section=$0 }
  section == "[seed]" && /^version[[:space:]]*=/ { gsub(/"/, "", $3); print $3; exit }
' bootstrap.toml
```

Print the current pin so the user can confirm they're moving in the right direction.

### 3. Update the pin

```bash
.claude/skills/pin-seed/scripts/pin.sh $ARGUMENTS
```

The script rewrites `bootstrap.toml [seed].version` and `compiler/capsule.toml [toolchain].sfn` in place (SFEP-0047 §3.4). `[capsule].version` — the compiler *source* version — is a release-time bump, not a seed-pin one; the script prints a reminder rather than touching it.

### 4. Fetch the new seed

```bash
make fetch-seed
```

`make fetch-seed` reads `bootstrap.toml [seed].version` and downloads the binary into `build/toolchains/seed/bin/sfn`. If the release does not exist on GitHub, the fetch fails — restore the previous pin and surface the error to the user.

### 5. Smoke-verify the new seed

```bash
build/toolchains/seed/bin/sfn version
```

Confirm the binary prints the expected version string. If it mismatches, abort and restore.

### 6. Optionally compile from the new seed

If the user asked for a full compile verify (`--compile` flag or equivalent):

```bash
make compile
```

This takes ~13 minutes and is optional for a pin-only change. Recommend it before merging the PR.

### 7. Commit

Stage `bootstrap.toml` and `compiler/capsule.toml` and commit with a conventional message:

```
chore(seed): pin seed to <VERSION>
```

Do NOT commit build artifacts. Only `bootstrap.toml` and `compiler/capsule.toml` change in this commit.

## Failure handling

| Failure | Action |
|---|---|
| No version argument | Abort with usage message |
| GitHub release not found | Restore old `bootstrap.toml` / `compiler/capsule.toml`, surface error |
| Binary version mismatch | Restore old `bootstrap.toml` / `compiler/capsule.toml`, surface error |
| Compile failure after pin | Leave pin in place, surface error for investigation |

## Notes

- The version in `bootstrap.toml [seed].version` must match a published GitHub release tag (with or without `v` prefix — `install.sh` accepts both).
- CI reads `bootstrap.toml [seed].version` to pin its own seed download; keeping one key in sync means the Makefile and every workflow never drift from each other.
- After pinning, run `make fetch-seed && make compile` locally before pushing to avoid a CI surprise.
