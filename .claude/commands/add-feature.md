# Add a Language Feature

Orchestrate the full pipeline for adding a new language feature to Sailfin, from design through documentation.

## Feature: $ARGUMENTS

---

## Phase 1: DESIGN

Spawn the **compiler-architect** agent to produce a design plan for this feature. The architect will:
- Read `docs/roadmap.md`, `docs/status.md`, and `docs/spec.md` for context
- Trace the current compiler pipeline to identify every file that needs changes
- Produce a concrete plan covering: AST representation, type rules, IR representation, LLVM lowering, self-hosting migration strategy, and test cases
- Identify dependencies and risks

**Present the architect's plan to the user and wait for approval before proceeding.** Do not write any code until the user approves the design. If the user requests changes to the plan, iterate on the design before moving on.

---

## Phase 2: IMPLEMENT

Implement the feature **one pipeline stage at a time**, following the architect's plan in order:

1. **Parser** (`compiler/src/parser/`) — new syntax recognition
2. **AST** (`compiler/src/ast.sfn`) — new node types
3. **Type Checker** (`compiler/src/typecheck.sfn`) — type rules and constraints
4. **Effect Checker** (`compiler/src/effect_checker.sfn`) — if this involves effects
5. **Native Emitter** (`compiler/src/emit_native.sfn`) — `.sfn-asm` emission
6. **LLVM Lowering** (`compiler/src/llvm/`) — LLVM IR generation
7. **Tests** — unit tests in `compiler/tests/unit/`, integration tests in `compiler/tests/integration/`

After each stage, run targeted tests to verify:
```bash
ulimit -v 8388608 && make test-unit
```

After all stages are complete, verify self-hosting:
```bash
ulimit -v 8388608 && make compile
```

If any step fails, diagnose the root cause before proceeding. Do not skip stages or batch multiple stages without testing.

---

## Phase 3: REVIEW

Spawn the **code-reviewer** agent to review all changes. The reviewer will check:
- Self-hosting safety
- Pipeline completeness (all stages covered)
- Effect system correctness
- LLVM IR correctness
- Test coverage adequacy
- Convention compliance

If the reviewer flags issues, fix them before proceeding. Re-run the reviewer after fixes to confirm resolution.

---

## Phase 4: VALIDATE

Spawn the **test-runner** agent to run the full validation suite:

```bash
ulimit -v 8388608 && make test
```

Then verify self-hosting still works:
```bash
ulimit -v 8388608 && make compile
```

If tests fail, diagnose and fix. Do not proceed to documentation with failing tests.

---

## Phase 5: DOCUMENT

Spawn the **docs-updater** agent to update documentation in this order:
1. `docs/status.md` — update the feature matrix
2. `docs/spec.md` — add to Part A if fully shipped, Part B if partial
3. `docs/roadmap.md` — update progress markers

---

## Constraints

- The compiler must self-host after every stage (`make compile` must pass)
- Keep changes minimal and focused — do not refactor surrounding code
- Always apply `ulimit -v 8388608` before running the compiler
- Never proceed past the design gate without user approval
- If the feature requires a self-hosting migration (new syntax used by the compiler itself), the architect's plan must include the seed transition strategy
