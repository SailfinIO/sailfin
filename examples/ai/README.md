# AI Examples

Illustrates how Sailfin gates AI-flavoured code paths through the `![model]` effect. Richer AI functionality — model declarations, prompt composition, tool dispatch, provenance tracking — is being delivered as a post-1.0 library capsule (`sfn/ai`) rather than language syntax.

- **`effectful-model-call.sfn`** — Minimal effectful model invocation behind a helper function. Demonstrates how a caller must declare `![model]` to invoke anything that performs model work.

The `![model]` effect is the only AI-specific construct that stays in the language. It acts as a compile-time capability gate for any code path that reaches an AI backend.
