# Add a Language Feature

Walk through the full pipeline for adding a new language feature to Sailfin. This follows the checklist from CLAUDE.md.

## Feature: $ARGUMENTS

Before writing any code, create a plan covering each stage of the compiler pipeline:

1. **Parser** (`compiler/src/parser.sfn`) — What new syntax needs to be recognized?
2. **AST** (`compiler/src/ast.sfn`) — What new node types are needed?
3. **Type Checker** (`compiler/src/typecheck.sfn`) — Any new type rules or constraints?
4. **Effect Checker** (`compiler/src/effect_checker.sfn`) — Does this involve effects?
5. **Native Emitter** (`compiler/src/emit_native.sfn`) — How does this emit to `.sfn-asm`?
6. **LLVM Lowering** (`compiler/src/llvm/lowering/entrypoints.sfn`) — How does this lower to LLVM IR?
7. **Tests** — Unit tests in `compiler/tests/unit/`, integration tests in `compiler/tests/integration/`

## Workflow

1. Present the plan and wait for approval before writing code.
2. Implement one pipeline stage at a time, running `make test-unit` after each stage.
3. After all stages are done, run `make test` to verify nothing is broken.
4. Run `make compile` to verify the compiler still self-hosts.
5. Update `docs/spec.md` and `docs/status.md` if the feature is shipping.

## Constraints

- The compiler must still self-host after your changes (`make compile` must pass).
- Do not refactor surrounding code — keep changes minimal and focused.
- Always apply `ulimit -v 8388608` before running the compiler.
