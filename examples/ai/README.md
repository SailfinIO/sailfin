# AI Examples

Illustrates Sailfin's AI‑native primitives: model declarations, prompt composition, effect annotations, tools, pipelines, and deterministic scopes. These map to §§3.6–3.8 & 8 in `docs/spec.md`.

- **`effectful-model-call.sfn`** – Minimal effectful model invocation with a redaction helper and a `test` validating string composition.
- **`model-workflow.sfn`** – End‑to‑end workflow: model declaration, prompt blocks (`prompt system` / `prompt user`), a `tool`, a `pipeline`, and scoped determinism helpers (`with seed(...), temperature(...)`).

> The bootstrap runtime currently mocks model behaviour. Generation cards, provenance, capability enforcement, and evaluator suites will activate in the self‑hosted runtime—treat these examples as forward‑looking scaffolds.
