# `sfn symbols --json` Schema (`sailfin-symbols/1`)

Status: Locked at `sailfin-symbols/1`. Shipped for SFN-444.

`sfn symbols [--json] [--capsule SLUG]` emits a single UTF-8 JSON document on
stdout: a versioned, deterministic index of Sailfin's public callable
surface — the auto-imported prelude globals plus the free functions declared
in each in-tree `sfn/*` capsule. `--json` is the default output mode (v1 emits
JSON only; there is no human-renderer fallback to suppress). Exit codes:
`0` success, `1` an unresolvable `--capsule` slug (a structured error, not a
crash).

## Versioning

The first field of every envelope is `schema_version`. Today it is the
literal string `"sailfin-symbols/1"`. Breaking changes bump this string (e.g.
`"sailfin-symbols/2"`). Consumers MUST hard-fail on unknown versions rather
than guess at unfamiliar field shapes.

Additive changes (new optional fields, new `kind`/`form` variants) keep the
same version string. The schema-lock test
(`compiler/tests/e2e/symbols_json_test.sfn`) guards the envelope shape and
byte-stability so a silent leak fails CI before it lands.

## Envelope shape

### Success

```jsonc
{
  "schema_version": "sailfin-symbols/1",
  "compiler_version": "0.8.0",
  "symbols": [
    {
      "name": "parse_int",
      "kind": "function",
      "origin": "capsule",
      "import_path": "sfn/strings",
      "form": "free",
      "signature": "parse_int(text: string) -> Result<int, string>",
      "parameters": [
        { "name": "text", "type": "string" }
      ],
      "return_type": "Result<int, string>",
      "effects": []
    },
    {
      "name": "array_filter",
      "kind": "function",
      "origin": "prelude",
      "import_path": null,
      "form": "free",
      "signature": "array_filter(items: any[], predicate: any) -> any[]",
      "parameters": [
        { "name": "items", "type": "any[]" },
        { "name": "predicate", "type": "any" }
      ],
      "return_type": "any[]",
      "effects": []
    }
  ],
  "parse_failures": []
}
```

The compact form emitted on stdout has no whitespace — the pretty-printed
form above is for readability in this document only.

### Error (unresolvable `--capsule`)

```jsonc
{
  "schema_version": "sailfin-symbols/1",
  "error": {
    "code": "E_SYMBOLS_UNRESOLVED_CAPSULE",
    "message": "capsule not found: sfn/nope",
    "capsule": "sfn/nope"
  }
}
```

An error envelope has no `symbols`/`parse_failures` fields — check for the
presence of `error` before reading either shape.

## Top-level fields (success envelope)

| Field | Type | Notes |
|---|---|---|
| `schema_version` | string | Always first. `"sailfin-symbols/N"` — consumers must hard-fail on unknown N. |
| `compiler_version` | string | The running compiler's version (`resolve_compiler_version`), e.g. `"0.8.0"` or a `+dev.<hash>` local build. |
| `symbols` | array | Flat array of symbol entries, see below. Totally ordered — see Determinism. |
| `parse_failures` | array | Reserved. Always `[]` today — see below. |

## `symbols[]`

Each entry is a JSON object with a fixed field set, in this order:

| Field | Type | Notes |
|---|---|---|
| `name` | string | The callable's bare name. |
| `kind` | string | `"function"` in v1. `"struct"` / `"enum"` / `"intrinsic"` are reserved for future schema-compatible extension. |
| `origin` | string | `"prelude"` for auto-imported prelude globals, `"capsule"` for an in-tree `sfn/*` capsule free function. |
| `import_path` | string \| null | `null` for prelude origin (nothing to import — it's already in scope). For capsule origin, the canonical `import { name } from "<slug>"` path, e.g. `"sfn/strings"`. |
| `form` | string | `"free"` in v1 (a free function, not a method). `"method"` is reserved. |
| `signature` | string | Rendered as `name(p1: T1, p2: T2) -> R ![effects]`. **No leading `fn `.** The `-> R` segment is omitted for a void return; the `![...]` segment is omitted when the symbol has no effects. |
| `parameters` | array | `{ "name": string, "type": string \| null }` per parameter, in declaration order. `type` is the raw source type text, or `null` if the parameter has no written annotation. |
| `return_type` | string \| null | Raw source return-type text, or `null` for a void return. |
| `effects` | array | Effect names, alphabetically sorted (e.g. `["io", "net"]`). `[]` for a pure symbol. |

## Determinism

`symbols[]` is totally ordered by the tuple `(origin, import_path, name,
signature)`, compared **lexicographically as plain strings** — this is *not*
a "prelude first" or "capsule first" semantic ordering, it's a byte-wise sort
of the tuple fields. Because `"capsule" < "prelude"` lexicographically,
capsule-origin symbols sort before prelude-origin symbols in the output.

Given an unchanged compiler binary and an unchanged in-tree source tree, two
invocations of `sfn symbols --json` (with the same `--capsule` filter, or
none) produce **byte-identical** stdout. There is no wall-clock timestamp,
no map/set iteration-order leak, and no reliance on filesystem directory
listing order beyond what the total order above already pins down.

## `parse_failures[]`

Reserved, always `[]` in v1. The symbol indexer has no error-recovery
channel of its own — it defers to the same parser `sfn check` uses. A
capsule whose `src/mod.sfn` declares no free functions (a comment-only or
type-only module, e.g. `sfn/sync`) legitimately contributes zero entries to
`symbols[]`; that is not a failure and is not reported here. The field
exists today so consumers can write code that reads it without a schema
bump once a real failure channel (e.g. a malformed `mod.sfn` under
`--capsule`) is wired up.

## v1 limitations

- **`src/mod.sfn` top-level only.** Only the free functions declared
  directly in each capsule's `src/mod.sfn` are indexed. A capsule that
  re-exports symbols from a submodule surfaces only what `mod.sfn` declares
  directly — a submodule function reached only via re-export is not yet
  enumerated.
- **`--capsule` filters the in-tree `capsules/` set.** On an installed
  toolchain with no in-tree `capsules/` directory available, a named
  `--capsule <slug>` lookup is unavailable and returns the same
  `E_SYMBOLS_UNRESOLVED_CAPSULE` structured error as a genuinely unknown
  slug. Default (unfiltered) enumeration on such a toolchain is
  prelude-only — it has no capsule tree to walk.
- **No intrinsic/ABI surface.** The compiler's intrinsic and runtime-ABI
  layer (`*u8`/`i64` raw helpers used for lowering, not meant to be called
  from user source) is intentionally excluded — it is not part of the
  user-callable surface this index describes.

## Examples

### Default enumeration

```jsonc
{
  "schema_version": "sailfin-symbols/1",
  "compiler_version": "0.8.0",
  "symbols": [
    { "name": "parse_int", "kind": "function", "origin": "capsule", "import_path": "sfn/strings", "form": "free", "signature": "parse_int(text: string) -> Result<int, string>", "parameters": [{ "name": "text", "type": "string" }], "return_type": "Result<int, string>", "effects": [] },
    { "name": "array_filter", "kind": "function", "origin": "prelude", "import_path": null, "form": "free", "signature": "array_filter(items: any[], predicate: any) -> any[]", "parameters": [{ "name": "items", "type": "any[]" }, { "name": "predicate", "type": "any" }], "return_type": "any[]", "effects": [] }
  ],
  "parse_failures": []
}
```

### Unresolvable `--capsule`

```jsonc
{
  "schema_version": "sailfin-symbols/1",
  "error": {
    "code": "E_SYMBOLS_UNRESOLVED_CAPSULE",
    "message": "capsule not found: sfn/nope",
    "capsule": "sfn/nope"
  }
}
```

## Stability contract

- Field names, types, and the fixed per-symbol field order in
  `sailfin-symbols/1` are frozen.
- New optional fields, and new `kind`/`form` values, will land *with the
  same version string* — consumers must tolerate unknown fields and unknown
  enum values.
- Field renames, type changes, or reordering the fixed per-symbol field set
  bump to `sailfin-symbols/2`.
- The gate test at `compiler/tests/e2e/symbols_json_test.sfn` exercises the
  envelope shape, the `--capsule` success and error paths, and
  byte-stability across repeated invocations.
