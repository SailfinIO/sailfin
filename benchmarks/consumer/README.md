# Consumer-build benchmark fixtures

Fixtures for `sfn bench --consumer` (SFN-830). Each is a minimal capsule that
`sfn bench --consumer` builds (never runs) twice — once against an empty
build cache ("cold") and once against the cache the cold run just populated
("warm") — to measure end-to-end consumer-build cost: wall time, module
staging/compilation counts, cache hit/miss counts, stripped binary size, and
`.init_array` constructor-slot count.

Three fixtures, each isolating a different point on the dependency surface:

- **`hello/`** — no dependencies beyond the runtime closure itself. The bare
  floor: whatever `hello` stages and compiles is the fixed cost every
  consumer build pays regardless of what it imports.
- **`hello_lib/`** — depends on `sfn/json`, deliberately chosen over
  `sfn/strings`: `strings` is already inside the runtime's own closure, so a
  `strings` fixture would stage the same module count as bare `hello` and
  measure nothing. `sfn/json` sits just outside that closure, so this
  fixture isolates the cost of pulling in exactly one library capsule.
- **`tls_client/`** — depends on `sfn/http`, the only fixture that legitimately
  reaches crypto (TLS) through its dependency graph. The harness only ever
  *builds* fixtures, never executes them, so this needs no live network
  access — `get("https://example.invalid/")` never runs.
