# Sailfin-native tests

This folder contains Sailfin-native tests that are executed by the self-hosted native compiler CLI.

Preferred invocations:

- `./sfn test <path>` (repo-local wrapper; picks the best available compiler)
- `build/native/sailfin test <path>` (stable local alias produced by `make compile`)

Legacy note: releases and some build artifacts still use the historical binary name `sailfin-stage2`.

The test runner discovers files named `*_test.sfn` under `<path>` (recursively), compiles each file with a synthesized harness, and executes it.

## Suites

- `unit/` — fast, deterministic, refactor-friendly checks (no filesystem/network/model effects by default).
- `integration/` — multi-subsystem or effectful tests (async/runtime bridging, capability enforcement, IO/net/model adapters).
- `e2e/` — CLI-level and test-runner-level behavior (file discovery, relative import inlining, exit codes).

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
