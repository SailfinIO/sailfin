# Codex Feature Planning Prompt

```text
Plan a Sailfin language/compiler feature before implementation.

Read docs/status.md, the relevant language spec files under site/src/content/docs/docs/reference/, and the compiler pipeline under compiler/src/. Produce an implementation plan in pipeline order (lexer/parser, AST, type checker, effect checker, emitter, LLVM lowering, tests, docs). Identify self-hosting risks, seed dependencies, and verification commands. Do not edit code until I approve the plan.
```
