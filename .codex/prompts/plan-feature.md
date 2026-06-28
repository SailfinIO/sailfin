# Codex Feature Planning Prompt

```text
Plan a Sailfin language/compiler/runtime feature before implementation.

Read AGENTS.md, docs/status.md, docs/proposals/0001-sfep-process.md, any relevant SFEPs under docs/proposals/, the relevant language spec files under site/src/content/docs/docs/reference/, and the compiler/runtime source surface under compiler/src/ and runtime/sfn/. Produce an implementation plan in pipeline order (lexer/parser, AST, type checker, effect checker, native emitter, LLVM lowering, runtime/prelude if needed, tests, docs). Identify whether the change requires a new or updated SFEP, self-hosting risks, seed dependencies, and verification commands. Do not edit code until I approve the plan.
```
