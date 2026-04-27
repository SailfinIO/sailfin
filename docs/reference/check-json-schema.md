# `sfn check --json` Schema (`sailfin-check/1`)

Status: Locked at `sailfin-check/1`. Shipped April 27, 2026 in Track B PR2 of
`docs/proposals/check-architecture.md`.

`sfn check --json [path...]` emits a single UTF-8 JSON document on stdout. The
human-readable stderr stream is suppressed in this mode. Exit codes match the
human renderer: `0` clean, `1` diagnostics found, `2` setup error (bad path,
slug collision, staging failure).

## Versioning

The first field of every envelope is `schema_version`. Today it is the literal
string `"sailfin-check/1"`. Breaking changes bump this string (e.g.
`"sailfin-check/2"`). Consumers MUST hard-fail on unknown versions rather than
guess at unfamiliar field shapes.

Additive changes (new optional fields, new event kinds) keep the same version
string. The schema-lock test
(`compiler/tests/e2e/test_check_json_schema.sh`) guards the field set so a
silent leak fails CI before it lands.

## Envelope shape

```jsonc
{
  "schema_version": "sailfin-check/1",
  "command": "sfn check",
  "exit_code": 1,
  "summary": {
    "files_checked": 121,
    "errors": 3,
    "warnings": 2,
    "duration_ms": 0
  },
  "events": [
    {
      "kind": "diagnostic",
      "code": "E0400",
      "severity": "error",
      "producer": "effect",
      "file_path": "compiler/src/foo.sfn",
      "message": "function `process` is missing required effects: ![io]\nrequired by:\n  - print/console helper usage requires ![io]\nsuggestion: add ![io] to the function signature",
      "primary": {
        "line": 30,
        "column": 5,
        "lexeme": "print",
        "label": null
      },
      "secondary": [],
      "suggestion": null
    }
  ]
}
```

## Top-level fields

| Field | Type | Notes |
|---|---|---|
| `schema_version` | string | Always first. `"sailfin-check/N"` — consumers must hard-fail on unknown N. |
| `command` | string | Always `"sfn check"` for this surface. Kept for forward compatibility with sibling commands (`sfn vet`, etc.). |
| `exit_code` | number | Mirrors the process exit code: `0` clean, `1` diagnostics, `2` setup error. |
| `summary` | object | Always present even when `events` is empty — consumers reading "did anything happen?" can read just the summary. |
| `events` | array | Flat array. Consumers grouping by file partition on `event.file_path`. |

## `summary`

| Field | Type | Notes |
|---|---|---|
| `files_checked` | number | Count of `.sfn` files analyzed in this run (post-recursive-collection). |
| `errors` | number | Total error-severity diagnostics across all files. Identical to the count that drives the human renderer's "X errors" tally. |
| `warnings` | number | Total warning-severity diagnostics, including W01xx import-context load warnings. |
| `duration_ms` | number | Reserved. Always `0` until wall-clock measurement lands; field is present so consumers can write code today that reads it without a schema bump later. |

## `events[]`

Each event is a JSON object with a fixed field set. The `kind` discriminator
distinguishes program-analysis findings from infrastructure warnings.

| Field | Type | Notes |
|---|---|---|
| `kind` | string | `"diagnostic"` for typecheck / effect / capability findings. `"load_warning"` for W01xx import-context loader output. |
| `code` | string | The diagnostic code. `Exxxx` errors, `Wxxxx` warnings. Locked code ranges (today): `E00xx` (typecheck), `E03xx` (interface), `E04xx` (effect), `W01xx` (load). |
| `severity` | string | One of `"error"`, `"warning"`, `"hint"`, `"info"`. The compiler emits `"error"` and `"warning"` today; `"hint"` and `"info"` are reserved for `sfn vet`. |
| `producer` | string | Which analysis pass minted the event. One of `"typecheck"`, `"effect"`, `"parse"`, `"load"`, `"unknown"`. The classifier maps code ranges to producers; new codes that fall outside the known ranges report `"unknown"` so a future code addition shows up rather than silently claiming the wrong producer. |
| `file_path` | string | Path of the analyzed module. Empty string for diagnostics that genuinely have no source anchor (none today; reserved). |
| `message` | string | Human-readable text. May contain `\n` for multi-line messages (effect violations carry a multi-line "required by" / "suggestion" block). |
| `primary` | object \| null | Source location for the caret. `null` for diagnostics with no AST anchor (W01xx load warnings always; effect violations on `Raw`-text bodies sometimes). |
| `secondary` | array | Reserved. Always `[]` until B5 (Track B) lands. Consumers should iterate it. |
| `suggestion` | object \| null | Reserved. Always `null` until B3 (Track B) lands fix-it suggestions. Consumers should null-check before reading. |

## `primary` / `secondary[]`

Source locations are JSON objects.

| Field | Type | Notes |
|---|---|---|
| `line` | number | 1-indexed source line. |
| `column` | number | 1-indexed source column. |
| `lexeme` | string | The token text the caret points at. Used by renderers to determine caret width. |
| `label` | string \| null | Reserved for B5 secondary spans (e.g. `"first defined here"`, `"this call requires ![io]"`). Always `null` until then. |

## `suggestion`

Reserved. `null` until B3 of Track B lands. Once shipped, the shape will be:

```jsonc
"suggestion": {
  "message": "add ![io] to the function signature",
  "edits": [
    {
      "start_line": 12,
      "start_column": 18,
      "end_line": 12,
      "end_column": 18,
      "replacement": " ![io]"
    }
  ]
}
```

## Producer classification

`producer` is derived from the diagnostic `code` per a fixed table. The mapping
is documented here so consumers can predict which range a future code will
land in:

| Code range | Producer |
|---|---|
| `E00xx` | `typecheck` |
| `E03xx` | `typecheck` |
| `E04xx` | `effect` |
| `W01xx` | `load` |
| (anything else) | `unknown` |

## Examples

### Clean run

```jsonc
{
  "schema_version": "sailfin-check/1",
  "command": "sfn check",
  "exit_code": 0,
  "summary": {
    "files_checked": 1,
    "errors": 0,
    "warnings": 0,
    "duration_ms": 0
  },
  "events": []
}
```

### Single-file effect violation

```jsonc
{
  "schema_version": "sailfin-check/1",
  "command": "sfn check",
  "exit_code": 1,
  "summary": {
    "files_checked": 1,
    "errors": 1,
    "warnings": 0,
    "duration_ms": 0
  },
  "events": [
    {
      "kind": "diagnostic",
      "code": "E0400",
      "severity": "error",
      "producer": "effect",
      "file_path": "/tmp/leak.sfn",
      "message": "function `noisy_helper` is missing required effects: ![io]\nrequired by:\n  - print/console helper usage requires ![io]\nsuggestion: add ![io] to the function signature",
      "primary": {
        "line": 8,
        "column": 5,
        "lexeme": "print",
        "label": null
      },
      "secondary": [],
      "suggestion": null
    }
  ]
}
```

## Consumers

- **MCP server** (`tools/mcp-server/`): exposes `sailfin_diagnostics` which
  shells `sfn check --json <path>` and returns the parsed envelope as
  `structuredContent`. Replaces the unstructured `sailfin_check` for
  agentic/programmatic clients.
- **`sfn lsp`** (planned): the language server's Phase 1 path consumes this
  envelope by running `sfn check --json` per save and translating events into
  `PublishDiagnosticsParams`. Phase 2 moves to in-process for incremental
  performance.
- **CI scrapers**: `jq` is the canonical reader. Examples:
  ```bash
  sfn check --json | jq '.summary'                                # rollup
  sfn check --json | jq '[.events[] | select(.code == "E0400")]'  # E0400 only
  sfn check --json | jq -r '.events[] | "\(.file_path):\(.primary.line // "?"):\(.code) \(.message | split("\n")[0])"'
  ```

## Stability contract

- Field names and types in `sailfin-check/1` are frozen.
- New optional fields will land *with the same version string* — consumers
  must tolerate unknown fields.
- Field renames or type changes bump to `sailfin-check/2`.
- The schema-lock test exercises the curated fixture tree at
  `compiler/tests/e2e/test_check_json_schema.sh` and asserts the field set
  matches this document.
