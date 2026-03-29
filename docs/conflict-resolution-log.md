# Conflict Resolution Log: PR #27 — beta → rc

**PR:** [#27](https://github.com/SailfinIO/sailfin/pull/27) `chore(release): 0.2.0-beta.1`  
**Merging:** `beta` (v0.2.0-beta.1) → `rc` (v0.1.2-rc.1)  
**Resolved by:** Copilot coding agent  
**Date:** 2026-03-29

---

## Summary

Three files had merge conflicts when merging `beta` into `rc`. All conflicts have been resolved and committed as a proper two-parent merge commit.

- **Parent 1:** `03bab062` (origin/rc tip — `chore(release): 0.1.2-rc.1`)
- **Parent 2:** `93ce72ee` (origin/beta tip — `chore(release): 0.2.0-beta.1`)

---

## Conflict Resolutions

### 1. `compiler/src/version.sfn`

| | Version |
|---|---|
| `rc` (HEAD) | `0.1.2-rc.1` |
| `beta` | `0.2.0-beta.1` |
| **Resolved** | **`0.2.0-beta.1`** |

**Decision:** Use beta's version string. We are merging beta features into rc for release candidate testing. The version should reflect the upcoming beta release that is being validated.

---

### 2. `CHANGELOG.md`

| | Content |
|---|---|
| `rc` (HEAD) | v0.1.2-rc.1 entry + dependabot bump entries |
| `beta` | v0.2.0-beta.1 + v0.2.0-alpha.3 through v0.1.1-alpha.136 entries |
| **Resolved** | **Both sections combined** |

**Decision:** Preserve both sets of changelog entries. Beta's newer entries (v0.2.0-beta.1 through v0.1.1-alpha.136) are placed first (chronologically newer), followed by rc's entries (v0.1.2-rc.1 and related maintenance entries), followed by the shared history.

**Ordering:**
1. Beta entries: v0.2.0-beta.1, v0.2.0-alpha.3, v0.2.0-alpha.2, v0.2.0-alpha.1, v0.1.1-alpha.142 through v0.1.1-alpha.136
2. RC entries: v0.1.2-rc.1 (conflict resolution fix, dependabot bumps)
3. Shared history: v0.1.1-beta.2, v0.1.1-alpha.135, and older

---

### 3. `.github/workflows/release-tag.yml`

| | Version |
|---|---|
| `rc` (HEAD) | 4-space YAML indentation; `actions/checkout@v6`, `upload-artifact@v7`, `download-artifact@v8` (from dependabot PRs); no Windows cross-compile |
| `beta` | 2-space YAML indentation (GitHub Actions standard); `actions/checkout@v4`; **Windows cross-compile steps** (MinGW-w64) |
| **Resolved** | **Beta's version** |

**Decision:** Use beta's version of the file. Rationale:
- Beta uses consistent 2-space YAML indentation, which is the GitHub Actions standard and matches all other workflow files in the repo.
- The rc version introduced broken indentation through dependabot PRs (steps were indented as if inside a nested block, making the YAML structurally inconsistent).
- Beta adds new Windows cross-compile capability (`Install MinGW-w64 cross-compiler`, `Cross-compile for Windows`) which is a critical new feature.
- The remainder of the file (non-conflicting sections) already uses beta's 2-space style and `@v4` versions, so using rc's `@v6/@v7/@v8` in only the conflicting section would be inconsistent.

**Preserved from beta:**
- Windows cross-compile steps for `linux-x86_64` matrix entry
- Correct YAML indentation throughout
- `Upload installer archive` step correctly placed in build job

---

## Key Changes Brought from Beta

The merge introduces 173 changed files, ~44,200 additions, ~8,000 deletions from beta:

| Category | Changes |
|---|---|
| `site/` | New Astro-based documentation website (50+ pages) |
| `capsules/sfn/*` | 9 new standard library capsules (crypto, fmt, fs, http, json, log, os, sync, time) |
| `runtime/native/` | New base64 and SHA-256 runtime modules |
| `compiler/src/` | Significant LLVM lowering improvements, new parser features, toml parser |
| `install.ps1` | New Windows PowerShell installer |
| `install.sh` | Updated Linux/macOS installer |
| `scripts/` | New test and selfhost scripts |
| Docs | Updated spec, status, EBNF, and proposals |
| CI | Windows cross-compile in release workflow |

---

## RC Branch Changes Preserved

| Change | Status |
|---|---|
| `chore(release): 0.1.2-rc.1` commit | ✅ Preserved (parent 1 of merge commit) |
| Dependabot: actions/checkout @v4→@v6 | ⚠️ Superseded by beta's `@v4` (consistent with rest of file) |
| Dependabot: upload-artifact @v4→@v7 | ⚠️ Superseded by beta's `@v4` (consistent with rest of file) |
| Dependabot: download-artifact @v4→@v8 | ⚠️ Superseded by beta's `@v4` (consistent with rest of file) |
| CHANGELOG v0.1.2-rc.1 entry | ✅ Preserved in combined CHANGELOG |

> **Note on action version regressions:** The dependabot-bumped action versions from rc (`@v6`, `@v7`, `@v8`) were not carried forward because beta's version of the file uses `@v4` consistently throughout, and merging only part of the file with higher versions would create an inconsistent state. These can be re-applied via dependabot after the merge is stabilized.
