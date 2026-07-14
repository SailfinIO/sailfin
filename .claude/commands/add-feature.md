# Add a Language Feature

Orchestrate the full pipeline for adding a new language feature to Sailfin, from design through documentation.

## Feature: $ARGUMENTS

---

## Phase 1: DESIGN

Spawn the **compiler-architect** agent to produce a design plan for this feature. The architect will:
- Read `site/src/pages/roadmap.astro` (the [roadmap](https://sailfin.dev/roadmap)), `docs/status.md`, and the language spec under `site/src/content/docs/docs/reference/spec/` (chapter files §1–§11) plus `.../reference/preview/` for context
- Trace the current compiler pipeline to identify every file that needs changes
- Produce a concrete plan covering: AST representation, type rules, IR representation, LLVM lowering, self-hosting migration strategy, and test cases
- Identify dependencies and risks
- **Persist the design as an SFEP** — for any non-trivial feature, the architect writes the plan to `docs/proposals/draft-<slug>.md` (status `Draft`) per `.claude/rules/proposals.md`. This is the durable design record; later phases and `/pickup` read it instead of redoing design.

**Present the architect's plan to the user and wait for approval before proceeding.** Do not write any code until the user approves the design. If the user requests changes to the plan, iterate on the design (and the draft SFEP) before moving on. **On approval, the design gate is the SFEP's `Accepted` transition** — run `/sfep status <slug-or-N> Accepted` (assigns the number, adds the registry row) before implementation begins.

---

## Phase 2: IMPLEMENT

Implement the feature **one pipeline stage at a time**, following the architect's plan in order:

1. **Parser** (`compiler/src/parser/`) — new syntax recognition
2. **AST** (`compiler/src/ast.sfn`) — new node types
3. **Type Checker** (`compiler/src/typecheck.sfn`) — type rules and constraints
4. **Effect Checker** (`compiler/src/effect_checker.sfn`) — if this involves effects
5. **Native Emitter** (`compiler/src/emit_native.sfn`) — `.sfn-asm` emission
6. **LLVM Lowering** (`compiler/src/llvm/`) — LLVM IR generation
7. **Tests** — unit tests in `compiler/tests/unit/`, integration tests in `compiler/tests/integration/`. End-to-end tests go in `compiler/tests/e2e/` as `*_test.sfn` using `sfn/test` — **never** new bash scripts (the `compiler/tests/e2e/*.sh` surface was fully migrated and deleted; see `.claude/rules/no-bash-e2e.md` for the native e2e recipe, e.g. `guillermo_test.sfn`)

After each stage, run the narrowest targeted test that covers that stage:
```bash
build/bin/sfn test <relevant_test_file.sfn>
```

After all stages are complete, verify self-hosting:
```bash
make compile
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

Spawn the **test-runner** agent to run the issue's verification commands and the
smallest sufficient broader gate. For ordinary feature leaves, this is usually:

```bash
build/bin/sfn test <relevant_test_file_or_dir>
```

Then verify self-hosting still works:
```bash
make compile
```

Use `make test` or `make check` here only when the issue explicitly asks for a
full gate, the feature is being declared shipped, or the change is structural or
release-facing. If tests fail, diagnose and fix. Do not proceed to documentation
with failing tests.

---

## Phase 5: DOCUMENT

Spawn the **docs-updater** agent to update documentation in this order:
1. `docs/status.md` — update the feature matrix
2. Language spec:
   - If fully shipped: update or add content in the appropriate `site/src/content/docs/docs/reference/spec/NN-*.md` chapter
   - If partial/planned: update or add a page under `site/src/content/docs/docs/reference/preview/`
3. `site/src/pages/roadmap.astro` — update progress markers on the [roadmap](https://sailfin.dev/roadmap)
4. **Graduate the SFEP** — if the feature fully shipped and clears the Stage1 bar, run `/sfep graduate <N>` to flip the proposal to `Implemented`, set `graduates-to`, and sync the registry. If only partially shipped, leave it `Accepted`.

---

## Constraints

- The compiler must self-host after every stage (`make compile` must pass)
- Keep changes minimal and focused — do not refactor surrounding code
- The compiler self-caps memory (8 GiB on Linux); see `.claude/rules/compiler-safety.md`
- Never proceed past the design gate without user approval
- If the feature requires a self-hosting migration (new syntax used by the compiler itself), the architect's plan must include the seed transition strategy
