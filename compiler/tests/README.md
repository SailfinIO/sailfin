# Sailfin-native tests

This folder contains Sailfin-native tests that are executed by the self-hosted native compiler CLI.

Preferred invocations:

- `build/bin/sfn test <path>` (built binary produced by `make compile`)
- `sfn test <path>` (installed compiler on PATH, e.g. after `make install`)

The test runner discovers files named `*_test.sfn` under `<path>` (recursively), compiles each file with a synthesized harness, and executes it.

## Suites

- `unit/` — fast, deterministic, refactor-friendly checks (no filesystem/network/model effects by default).
- `integration/` — multi-subsystem or effectful tests (async/runtime bridging, capability enforcement, IO/net/model adapters).
- `e2e/` — CLI-level and test-runner-level behavior (file discovery, relative import inlining, exit codes).

Capsule-flavored tests (functions, types, and behaviors that belong to a
capsule, not the compiler itself) live under
`capsules/<scope>/<name>/tests/*_test.sfn` and are run by `make test-capsules`
(also rolled into `make test`). Use the compiler test suites here only for
tests that exercise compiler features (lexer/parser/typecheck/effects/emit/IR).

## File naming

- Use `*_test.sfn` (required for discovery).
- Prefer `topic_test.sfn` within a suite folder.
  - Examples: `token_test.sfn`, `string_concat_test.sfn`, `async_await_test.sfn`.

## Test naming

Use the format:

- `test "<area>: <behavior>" { ... }`

Where `<area>` is a stable subsystem name (e.g. `token`, `string`, `async`, `test_runner`).
Avoid encoding the suite (`unit`, `integration`, `e2e`) in the test name; the folder already communicates that.

## Helper functions

- Prefer private helpers prefixed with `_` (e.g. `_contains`, `_index_of`).
- Keep helpers local to a file unless a shared fixture is required.
- If you add fixtures used via relative imports, put them under `e2e/fixtures/` or `unit/fixtures/` and keep names specific to reduce symbol collision risk when imports are inlined.

## Transfer-ergonomics gate

`e2e/dx_transfer_ergonomics_gate_test.sfn` (SFN-445) is a deterministic,
**non-scored** developer-experience gate. It holds a public corpus of minimal,
independently authored "transfer" patterns — the shapes a developer arriving
from another language naively writes — and, for each, asserts that the
unsupported form is rejected at `check` with a stable `E`-code (and a span where
the diagnostic carries one) while a canonical corrected form checks, builds, and
runs in agreement. It is a compiler/tooling expectations gate, **not** a model
benchmark: it holds no model scores and is independent of the hidden/scored
corpus under `benchmarks/llm/` — never encode benchmark answers here.

To add a new transfer pattern, append one `TransferCase` to `_corpus()`:

1. Write a minimal **unsupported** source from first principles (do **not**
   consult the hidden benchmark fixtures).
2. Observe its stable code with `build/bin/sfn check --json <src>`; record the
   `code` in `expected_code`.
3. Record that diagnostic's span fragment (e.g. `"line":2,"column":13`) in
   `expected_span`, or leave it `""` when the diagnostic has a null `primary`
   (import-resolution and some typecheck codes carry no span today). Set
   `span_label` to the human token shown in the summary.
4. Write a canonical **corrected** source (a complete program with
   `fn main() ![io]`) and confirm it check/build/runs.

The gate prints a wall-clock-free summary that compares byte-for-byte across
runs; verify with `build/bin/sfn test e2e/dx_transfer_ergonomics_gate_test.sfn`
run twice.
