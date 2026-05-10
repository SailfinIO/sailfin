---
name: pin-seed
description: Pin the Sailfin seed compiler to a specific released version. Updates .seed-version, fetches the binary, and optionally runs a smoke compile to verify the new seed builds the compiler. Usage: /pin-seed <version> (e.g. /pin-seed v0.5.10-alpha.12 or /pin-seed 0.5.10-alpha.12).
allowed-tools: Bash, Read, Edit
---

# Pin a new seed version

Updates the seed pin in `.seed-version`, downloads the new binary, and verifies it can compile the compiler.

## Steps

### 1. Parse and normalize the version

Strip any leading `v` from the argument — `.seed-version` stores bare versions like `0.5.10-alpha.12`.

```
VERSION="${1#v}"   # strip leading v if present
```

Fail immediately if no version is provided.

### 2. Check current pin

```bash
cat .seed-version
```

Print the current pin so the user can confirm they're moving in the right direction.

### 3. Update the pin file

```bash
.claude/skills/pin-seed/scripts/pin.sh <VERSION>
```

The script writes the normalized version to `.seed-version` (single line, no trailing newline issues).

### 4. Fetch the new seed

```bash
ulimit -v 8388608 && make fetch-seed
```

`make fetch-seed` reads `.seed-version` and downloads the binary into `build/seed/bin/sailfin`. If the release does not exist on GitHub, the fetch fails — restore the previous pin and surface the error to the user.

### 5. Smoke-verify the new seed

```bash
ulimit -v 8388608 && build/seed/bin/sailfin version
```

Confirm the binary prints the expected version string. If it mismatches, abort and restore.

### 6. Optionally compile from the new seed

If the user asked for a full compile verify (`--compile` flag or equivalent):

```bash
ulimit -v 8388608 && make compile
```

This takes ~13 minutes and is optional for a pin-only change. Recommend it before merging the PR.

### 7. Commit

Stage `.seed-version` and commit with a conventional message:

```
chore(seed): pin seed to <VERSION>
```

Do NOT commit build artifacts. Only `.seed-version` changes in this commit.

## Failure handling

| Failure | Action |
|---|---|
| No version argument | Abort with usage message |
| GitHub release not found | Restore old `.seed-version`, surface error |
| Binary version mismatch | Restore old `.seed-version`, surface error |
| Compile failure after pin | Leave pin in place, surface error for investigation |

## Notes

- The version in `.seed-version` must match a published GitHub release tag (with or without `v` prefix — `install.sh` accepts both).
- CI reads `.seed-version` to pin its own seed download; keeping one file in sync means four workflows never drift from each other.
- After pinning, run `make fetch-seed && make compile` locally before pushing to avoid a CI surprise.
