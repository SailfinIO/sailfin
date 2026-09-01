# `sfn toolchain --json` Schema (`sailfin-toolchains/1`)

Status: Locked at `sailfin-toolchains/1`. Shipped in SFN-1066
(`docs/proposals/0073-toolchain-lifecycle.md` §3.4). `requirement.version` is
populated as of SFN-1070 (§3.9 slice 2), `default`/the `"default"` role
are populated as of SFN-1068 (§3.4 slice 3), and `update` is populated as of
SFN-1071 (§3.4 slice 4) — no schema bump for any of the three, since all were
already reserved and `null`/unassigned.

`sfn toolchain list --json`, `sfn toolchain active --json`,
`sfn toolchain verify --json`, and `sfn toolchain update --check --json` emit
a single UTF-8 JSON document on stdout.
Under `--json`, stdout carries **only** the envelope; all human-readable
diagnostics go to stderr. The exit matrix follows SFEP-0003: `0` means the
inspection completed with no actionable finding; `1` means the inspection
completed and found an actionable condition — a `partial` or `corrupt` store
entry; `2` means a setup, selection, policy, or CLI-usage failure.
**Availability and state are data, never an error exit** — an unfetched
toolchain, an unselected version, or a `null` update field never by itself
produces a non-zero exit.

A setup or pre-flight failure — most commonly an unresolvable toolchain
store — emits **no envelope at all**: empty stdout paired with a non-zero
exit code, mirroring `sfn bench`'s documented pre-flight behaviour. Consumers
must treat empty-stdout-with-nonzero-exit as a setup error rather than assume
every invocation yields a parseable document.

## Versioning

The first field of every envelope is `schema_version`. Today it is the
literal string `"sailfin-toolchains/1"`. Breaking changes bump this string
(e.g. `"sailfin-toolchains/2"`). Consumers MUST hard-fail on unknown versions
rather than guess at unfamiliar field shapes.

Additive changes (new optional fields) keep the same version string. The
schema-lock test (`compiler/tests/e2e/toolchain_inspect_json_test.sfn`)
guards the field set so a silent leak fails CI before it lands.

## Envelope shape

```jsonc
{
  "schema_version": "sailfin-toolchains/1",
  "operation": "active",
  "host": "aarch64-apple-darwin",
  "entry": { "version": "0.10.4", "path": "/.../sfn" },
  "selected": {
    "version": "0.10.3",
    "path": "/.../aarch64-apple-darwin/0.10.3/sfn",
    "source": "workspace.toml",
    "installed": true,
    "integrity": "verified"
  },
  "requirement": {
    "minimum": "0.10.0",
    "version": "0.10.3",
    "channel": "stable",
    "source": "workspace.toml"
  },
  "fetch_policy": "auto",
  "default": null,
  "update": null,
  "toolchains": [],
  "diagnostics": []
}
```

## Top-level fields

| Field | Type | Notes |
|---|---|---|
| `schema_version` | string | Always first. `"sailfin-toolchains/N"` — consumers must hard-fail on unknown N. |
| `operation` | string | The leaf that produced the envelope: `"list"`, `"active"`, `"verify"`, or `"update"`. |
| `host` | string \| null | The current host triple. `null` only if host identity could not be resolved. |
| `entry` | object | The PATH entry toolchain's identity. See `entry`. |
| `selected` | object | What the current directory resolves to, with no fetch performed. See `selected`. |
| `requirement` | object | The project's `[toolchain]` requirement, as read from `workspace.toml`/`capsule.toml`. See `requirement`. |
| `fetch_policy` | string | One of `"auto"`, `"local"`, `"off"`, derived from `SAILFIN_TOOLCHAIN`. |
| `default` | object \| null | The per-user default recorded for the current host triple (SFN-1068). `{"version": ..., "track": ...}` when this host has a recorded default, `null` otherwise. See `default`. |
| `update` | object \| null | Update-check results. Populated only by `sfn toolchain update --check --json`; `null` for every other operation. See `update`. |
| `toolchains` | array | Every store entry this inspection enumerated. `[]` when the store is empty, and always `[]` for `active` and for `verify <version>` — neither enumerates the store. Only `list` and `verify --all` populate it. See `toolchains[]`. |
| `diagnostics` | array | One coded entry per non-`complete` store entry. `[]` when everything is `complete`. See `diagnostics[]`. |

## `entry`

| Field | Type | Notes |
|---|---|---|
| `version` | string | The PATH entry toolchain's own version. Never empty. |
| `path` | string \| null | The entry executable's resolved path. `null` if unresolvable. |

## `selected`

| Field | Type | Notes |
|---|---|---|
| `version` | string \| null | The version the current directory resolves to. `null` only if resolution failed entirely. |
| `path` | string \| null | The selected executable's path. `null` when the selected version is not installed. |
| `source` | string | Where the selection came from: `"entry"`, `"environment"` (`SAILFIN_TOOLCHAIN`), `"user default"` (the per-host record set by `sfn toolchain default`), or the project pin's source (e.g. `"workspace.toml"`). Never empty. |
| `installed` | boolean | Whether the selected version has a ready store entry. |
| `integrity` | string | One of `"verified"`, `"unverified"`, `"failed"`. See the `integrity` vocabulary below. |

## `default`

The per-user default toolchain record (SFEP-0073 §3.5, SFN-1068), keyed by
the current host triple — a default recorded for one host is never reported
under another. `null` when this host has no recorded default.

| Field | Type | Notes |
|---|---|---|
| `version` | string | The recorded default version. Always a string when the `default` object is present. |
| `track` | string \| null | The recorded update track, if any. `null` when no track was recorded — distinct from the empty string. |

## `update`

Populated only by `sfn toolchain update --check --json` (SFEP-0073 §3.4,
SFN-1071); `null` for `list`, `active`, and `verify`. Field order below is
normative — it matches `_ij_render_update_object`
(`compiler/src/toolchain/inspect_json.sfn`) and is locked by
`compiler/tests/unit/toolchain_inspect_json_test.sfn`, beside the e2e
schema-lock reference in `compiler/tests/e2e/toolchain_inspect_json_test.sfn`.

| Field | Type | Notes |
|---|---|---|
| `policy` | string | The effective `toolchain.update-policy` value: `"notify"`, `"manual"`, or `"disabled"`, or the verbatim unrecognized value from a hand-edited `~/.sfn/config.toml`. A `disabled` or unrecognized policy refuses the operation before any envelope is produced, so in practice this field is `"notify"` or `"manual"` whenever an `update` envelope exists. |
| `channel` | string | The canonical channel checked (`"stable"`, `"rc"`, `"beta"`, or `"alpha"` — `"latest"` resolves to `"stable"`). |
| `available` | boolean | Whether the channel's head is strictly newer than `current` by semver precedence. |
| `current` | string | The version an update would replace: the recorded user default, the project's exact `[toolchain] version` under `--project`, or the entry toolchain. |
| `candidate` | string \| null | The channel's strictly-newer head. `null` exactly when `available` is `false` — an equal, older, or channel-regressed head is never a candidate. |
| `advisory` | string \| null | The first indexed advisory line for `current`, if any, or the release-state refusal text if `current` is revoked or yanked. `null` when neither applies. |

## `requirement`

| Field | Type | Notes |
|---|---|---|
| `minimum` | string \| null | The project's floor version (today's pin semantics). `null` when the project declares no requirement. |
| `version` | string \| null | The project's *exact* `[toolchain] version` (SFEP-0073 §3.2, SFN-1070). Independent of `minimum` — an exact `0.10.3` is not satisfied by `0.10.4`. `null` when the project declares no exact version. |
| `channel` | string \| null | The project's declared update channel, if any. |
| `source` | string \| null | Which file supplied the requirement (e.g. `"workspace.toml"`). `null` when there is no requirement. |

## `toolchains[]`

Each entry is a JSON object with a fixed field set, one per store entry this
inspection enumerated (host-qualified entries plus the read-only flat legacy
tree).

| Field | Type | Notes |
|---|---|---|
| `version` | string | The store entry's version. Never empty. |
| `host` | string \| null | The host triple this entry is qualified under. `null` for a legacy flat-tree entry with no host qualification. |
| `path` | string \| null | The entry's on-disk directory. `null` only if unresolvable. |
| `state` | string | One of `"complete"`, `"partial"`, `"corrupt"`. See the `state` vocabulary below. |
| `integrity` | string | One of `"verified"`, `"unverified"`, `"failed"`. See the `integrity` vocabulary below. |
| `roles` | array | Zero or more of `"entry"`, `"selected"`, `"project"`, `"default"`, `"management"`, always emitted in that fixed order. `[]` when the entry holds none. `"management"` (SFEP-0073 §3.5) remains reserved and is never assigned in this slice. |

### `state` vocabulary

- `complete` — a fully committed, runnable entry.
- `partial` — an install that never committed: the installer writes the
  `.sha256` marker last, so a missing or empty marker means the payload was
  never published, not that it decayed.
- `corrupt` — a committed entry whose recorded payload failed verification
  against its install manifest.

### `integrity` vocabulary

- `verified` — the payload was hashed against its recorded install manifest
  and matched.
- `unverified` — covers the documented SFN-1064 legacy boundary: an entry
  installed before install manifests existed carries no records to check
  against, and is neither trusted nor condemned.
- `failed` — the payload was hashed and did not match its recorded manifest.

**`list` and `verify` both perform a full, uncached payload hash of every
committed entry.** `integrity: "verified"` is a claim that the payload was
actually hashed against its recorded install manifest, not merely that a
manifest exists. This has a real cost: `list` is **O(total installed payload
bytes)**, not O(entry count) — it re-hashes every committed toolchain's full
payload on every invocation.

## `diagnostics[]`

One object per actionable finding: each `toolchains[]` entry whose `state` is
not `complete`, plus `E0620` when the selected toolchain is not installed
(which `active` can report with an empty `toolchains` array). Uses
SFEP-0061's coded severity/message shape.

| Field | Type | Notes |
|---|---|---|
| `code` | string | `"E0619"` for a `partial` entry, `"E0618"` for a `corrupt` entry, `"E0620"` when the selected toolchain is not installed. |
| `severity` | string | Always `"error"` in this slice. |
| `message` | string | `<version>: <detail>` — the entry's version and its classification detail. |

## Examples

### Clean `active` run

```jsonc
{
  "schema_version": "sailfin-toolchains/1",
  "operation": "active",
  "host": "x86_64-unknown-linux-gnu",
  "entry": { "version": "0.10.4", "path": "/home/user/.local/share/sailfin/versions/x86_64-unknown-linux-gnu/0.10.4/sfn" },
  "selected": {
    "version": "0.10.4",
    "path": "/home/user/.local/share/sailfin/versions/x86_64-unknown-linux-gnu/0.10.4/sfn",
    "source": "entry",
    "installed": true,
    "integrity": "verified"
  },
  "requirement": {
    "minimum": null,
    "version": null,
    "channel": null,
    "source": null
  },
  "fetch_policy": "auto",
  "default": null,
  "update": null,
  "toolchains": [],
  "diagnostics": []
}
```

Exit code: `0`. Note `toolchains` is `[]`: `active` explains the *selection*,
not the store, so it does not enumerate entries. Use `list` for the store.

### `list` run with one corrupt and one partial entry

```jsonc
{
  "schema_version": "sailfin-toolchains/1",
  "operation": "list",
  "host": "x86_64-unknown-linux-gnu",
  "entry": { "version": "0.10.4", "path": "/home/user/.local/share/sailfin/versions/x86_64-unknown-linux-gnu/0.10.4/sfn" },
  "selected": {
    "version": "0.10.4",
    "path": "/home/user/.local/share/sailfin/versions/x86_64-unknown-linux-gnu/0.10.4/sfn",
    "source": "entry",
    "installed": true,
    "integrity": "verified"
  },
  "requirement": {
    "minimum": null,
    "version": null,
    "channel": null,
    "source": null
  },
  "fetch_policy": "auto",
  "default": null,
  "update": null,
  "toolchains": [
    {
      "version": "0.10.4",
      "host": "x86_64-unknown-linux-gnu",
      "path": "/home/user/.local/share/sailfin/versions/x86_64-unknown-linux-gnu/0.10.4",
      "state": "complete",
      "integrity": "verified",
      "roles": ["entry", "selected"]
    },
    {
      "version": "0.10.3",
      "host": "x86_64-unknown-linux-gnu",
      "path": "/home/user/.local/share/sailfin/versions/x86_64-unknown-linux-gnu/0.10.3",
      "state": "corrupt",
      "integrity": "failed",
      "roles": []
    },
    {
      "version": "0.10.5",
      "host": "x86_64-unknown-linux-gnu",
      "path": "/home/user/.local/share/sailfin/versions/x86_64-unknown-linux-gnu/0.10.5",
      "state": "partial",
      "integrity": "unverified",
      "roles": []
    }
  ],
  "diagnostics": [
    {
      "code": "E0618",
      "severity": "error",
      "message": "0.10.3: payload hash does not match recorded install manifest"
    },
    {
      "code": "E0619",
      "severity": "error",
      "message": "0.10.5: install never completed (no committed .sha256 marker)"
    }
  ]
}
```

Exit code: `1`.

### `update --check` run

```jsonc
{
  "schema_version": "sailfin-toolchains/1",
  "operation": "update",
  "host": "x86_64-unknown-linux-gnu",
  "entry": { "version": "0.10.6", "path": "/home/user/.local/share/sailfin/versions/x86_64-unknown-linux-gnu/0.10.6/sfn" },
  "selected": {
    "version": "0.10.6",
    "path": "/home/user/.local/share/sailfin/versions/x86_64-unknown-linux-gnu/0.10.6/sfn",
    "source": "user default",
    "installed": true,
    "integrity": "verified"
  },
  "requirement": {
    "minimum": null,
    "version": null,
    "channel": null,
    "source": null
  },
  "fetch_policy": "auto",
  "default": { "version": "0.10.6", "track": "stable" },
  "update": {
    "policy": "notify",
    "channel": "stable",
    "available": true,
    "current": "0.10.6",
    "candidate": "0.10.7",
    "advisory": null
  },
  "toolchains": [],
  "diagnostics": []
}
```

Exit code: `0` — `update --check` never fails on the *presence* of an update; only a
setup, usage, or policy failure does. A `toolchain.update-policy` refusal
(`disabled`, or an unrecognized configured value) or any other preflight
failure — an unresolvable host triple, `SAILFIN_TOOLCHAIN=local`, `--project`
with no explicit channel, or a project with no exact `[toolchain] version`
under `--project` — emits **no envelope at all**, the same empty-stdout
contract as any other setup failure: check the exit code, not the presence of
`update`, before parsing.

## Consumers

- **CI scrapers / agentic tooling**: `jq` is the canonical reader. Examples:
  ```bash
  sfn toolchain list --json | jq '.toolchains[] | select(.state != "complete")'
  sfn toolchain active --json | jq '.selected'
  sfn toolchain verify --json | jq '.diagnostics'
  sfn toolchain update --check --json | jq '.update'
  ```
- **`sfn toolchain` human renderer** shares the same underlying
  `ToolchainInspectReport` (`compiler/src/toolchain/inspect.sfn`) so the
  human and `--json` surfaces never disagree about what was found — only how
  it is presented.

## Stability contract

- Field names and types in `sailfin-toolchains/1` are frozen.
- New fields must be optional (or the new/reserved `null` shape already
  documented above) or the schema bumps to `sailfin-toolchains/2`.
- Field renames or removals bump to `sailfin-toolchains/2`.
- The schema-lock test
  (`compiler/tests/e2e/toolchain_inspect_json_test.sfn`) exercises the field
  set against this document and fails CI on drift.
