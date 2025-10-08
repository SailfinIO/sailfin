# AI Examples

These examples showcase Sailfin's AI-oriented workflows using the bootstrap compiler's current surface area.

- **`effectful-model-call.sfn`** – Demonstrates effect annotations (`![model, io]`), simple redaction helpers, and golden tests that run alongside executable code.
- **`model-workflow.sfn`** – Captures model declarations, prompt blocks, tools, pipelines, and scoped effect controls in a single workflow.

> The bootstrap runtime mocks model behaviour; replace the `call_model` helper with real bindings once the model runtime lands.
