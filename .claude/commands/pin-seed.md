# Pin the Seed Version

Bump `bootstrap.toml [seed].version` (the repo-root seed pin consumed by
`sfn dev bootstrap fetch`, `ci.yml`, `nightly-selfhost.yml`, and
`release-branches.yml`) — and the compiler `[toolchain].sfn` floor — to a
newer Sailfin release.

Seed pinning is **automatic** on the routine path: `cadence-seed-pin.yml`
bumps the pin after every green release and auto-merges once its own CI is
green. `/pin-seed` exists only for an **off-cadence or hotfix pin** — e.g. a
just-closed `seed-blocker` that downstream work needs before the next cadence
bump lands it. See `docs/conventions/issue-naming.md` "Seed pinning" for the
convention.

## Target: $ARGUMENTS

Parse `$ARGUMENTS` as an optional target version (with or without
leading `v`) plus optional flags:

- `--dry-run` — print intended actions but don't write or commit.

If no version arg is given, pick the **most recently published release
tag** (this is the most recent prerelease for the project; not the
"latest stable" non-prerelease that `gh release view --json` would
return).

Examples:
- `/pin-seed` — pin to the most recently published release
- `/pin-seed v0.5.10-alpha.12` — pin to a specific version
- `/pin-seed --dry-run` — preview only

---

## Phase 1: RESOLVE TARGET

1. Read the current pin:
   ```bash
   awk '
     /^\[[^]]+\]/ { section=$0 }
     section == "[seed]" && /^version[[:space:]]*=/ { gsub(/"/, "", $3); print $3; exit }
   ' bootstrap.toml
   ```
2. If `$ARGUMENTS` provides a version, use it (strip leading `v`).
   Otherwise, list recent releases and pick the most recent:
   ```
   mcp__github__list_releases owner=SailfinIO repo=sailfin perPage=5
   ```
   Take `items[0].tag_name`, strip the leading `v`. Do not use
   `get_latest_release` — it returns only non-prereleases, which
   doesn't match Sailfin's alpha cadence.
3. Verify the target release has a binary uploaded. The release-tag
   workflow (`release-tag.yml`) takes a few minutes after `release.yml`
   finishes — check that the release has assets:
   ```bash
   gh release view "v<TARGET>" --json assets --jq '.assets | length'
   ```
   If 0 assets, `release-tag.yml` hasn't finished — abort with
   "binaries not yet uploaded for v<TARGET>; retry once
   release-tag.yml completes" and stop. Don't pin against a release
   the seed-fetch can't actually download.
4. If `target == current`: report no-op and stop.

---

## Phase 2: VERIFY THE SEED FETCHES

Before committing, confirm the target binary actually downloads and
smoke-verify it:

```bash
.claude/skills/pin-seed/scripts/pin.sh "<target>"
sfn dev bootstrap fetch
build/toolchains/seed/bin/sfn version
```

`pin.sh` updates `bootstrap.toml [seed].version` and the compiler toolchain floor
before the native fetch reads the new pin. `sfn dev bootstrap fetch` installs
into `build/toolchains/seed/versions/`. If the fetch fails (404, checksum,
network), restore both edited manifests and abort. If the smoke-verify
mismatches the expected version string, restore both manifests and abort.

If `--dry-run`, skip this phase.

---

## Phase 3: GATHER CONTEXT FOR THE COMMIT MESSAGE

1. **Closed `seed-blocker` issues since the last pin.** Use the
   commit timestamp of the last `bootstrap.toml` change as the
   since-date:
   ```bash
   last_pin_at="$(git log -1 --format=%cI bootstrap.toml)"
   ```
   Then:
   ```
   mcp__github__search_issues query='repo:SailfinIO/sailfin is:issue is:closed label:seed-blocker closed:>=<last_pin_at>'
   ```
   Surface the list — these are usually *why* the pin is being bumped.

2. **Open `seed-blocker` issues.** Note them as "still open after this
   pin" — they may be intentional (their fix lands in a future seed)
   or accidental (the pin is being made before they close, in which
   case ask the user to confirm).

3. **Compare URL.** `https://github.com/SailfinIO/sailfin/compare/v<current>...v<target>`

---

## Phase 4: COMMIT DIRECTLY

No branch, no PR — pin directly on the current branch, mirroring
`.claude/skills/pin-seed/SKILL.md`.

```bash
git add bootstrap.toml compiler/capsule.toml
git commit -m "$(cat <<'EOF'
chore: bump seed to v<TARGET>

Closed seed-blocker issues since the last pin:
- #<N> — <title>
(or "None")

Still open after this pin:
- #<N> — <title> (intentional / will be addressed in a later seed)
(or "None")

Comparison: https://github.com/SailfinIO/sailfin/compare/v<current>...v<target>
EOF
)"
```

Phase 2's `pin.sh` invocation rewrites `bootstrap.toml [seed].version` and the compiler
`[toolchain].sfn` floor in lockstep (SFEP-0047 §3.4). It leaves
`[capsule].version` alone (a release-time bump) and prints a reminder.

If `--dry-run`, stop here without committing.

Report:
- The current → target version bump and the commit hash.
- Any closed/open `seed-blocker` issues surfaced in Phase 3.
- A reminder to run `sfn dev bootstrap build` locally before pushing, per the
  failure-handling table below.

---

## Failure handling

| Failure | Action |
|---|---|
| No version argument | Abort with usage message |
| GitHub release not found / 0 assets | Abort, don't pin |
| Fetch failure (404, checksum, network) | Restore old `bootstrap.toml` / `compiler/capsule.toml`, surface error |
| Binary version mismatch on smoke-verify | Restore old `bootstrap.toml` / `compiler/capsule.toml`, surface error |
| `sfn dev bootstrap build` failure after pin | Leave pin in place, surface error for investigation |

---

## Constraints

- **Never bump the pin to a version whose binary hasn't uploaded.**
  This breaks `sfn dev bootstrap fetch` for everyone. Phase 1 step 3 enforces
  this.
- **Don't bundle other changes.** The pin is its own commit. If the
  user wants to drag in other fixes, they do so separately.
- **In `--dry-run`, make zero writes.**

---

## When NOT to run /pin-seed

- The new release is a routine alpha that fixes nothing the working
  set needs — the cadence auto-pin will pick it up on schedule.
- A `seed-blocker` issue is still open and the pin would skip past it
  without resolving (unless the user explicitly wants to defer).
- `release-tag.yml` is still running for the target release — wait
  for it.
- The current pin is < 5 alphas behind and CI/nightly are green —
  the pin is doing its job; don't churn it.

## When to run /pin-seed

- A `seed-blocker` issue just closed and downstream work needs it
  before the next scheduled cadence bump lands it.
- Downstream work needs a feature/fix that landed in a recent alpha.
- A `bump=patch` was just cut (almost always implies a hotfix-pin).
- The pin is far enough behind `main` that nightly self-host shows
  drift between seed and trunk.
