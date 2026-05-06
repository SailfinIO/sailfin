# Roadmap delta

## What moves where

The current roadmap (`site/src/pages/roadmap.astro`) has exactly one
test-related row, in the **post-1.0 Platform & Ecosystem** category at
line 163:

```js
{ label: "Native test framework — golden, adversarial, and replay test types", status: "planned" },
```

This epic argues that the **first half** of that work (a usable native
test framework with assertions, fixtures, structured output, and bash
collapse) belongs in the **pre-1.0 critical path**, not after the 1.0
release. The **second half** (golden/adversarial/replay/property/fuzz)
stays post-1.0 as a follow-up.

### Proposed roadmap edits

Rename the existing line 163 row to:

```js
{ label: "Test framework — Phase 4 (property, fuzz, replay, adversarial)", status: "planned" },
```

Add a new row in the existing **Tooling & Developer Experience**
section (where `sfn lsp`, `sfn audit`, etc. live):

```js
{ label: "Native test framework (Phases 0–3) — sfn/test capsule, expect()/lifecycle/fixtures, --json output, bash collapse", status: "planned" },
```

Mark it as a sibling of the planned `sfn check --json` row at line 119
— both share the JSON schema and both are consumed by the MCP server.

## Promotion justification

The user's framing is: a language without a usable test framework is
not adoptable as the *"verification layer for AI-generated code"* that
`CLAUDE.md` markets. LLMs writing `.sfn` code need a contract for
verifying generated code passes; `sfn test --json` *is* that contract.
Without it, the MCP server's `sailfin_check` tool has no failure-aware
companion, and human developers have no realistic way to ship
production code in Sailfin (because they cannot test it).

The 1.0 critical path in `CLAUDE.md` already lists:
- "Effect enforcement as compilation gate" (the #1 LLM lever)
- "llms.txt" (training-context lever)
- "Structured diagnostics (--json)" (machine-readable diagnostics)
- "MCP server" (agent tool surface)
- "Training data presence" (Rosetta Code etc.)

A test framework is the missing fifth lever. Without it, an LLM
generating Sailfin code can compile-check but cannot verify behaviour.
The compile-check / behaviour-verify loop is the agentic feedback
cycle — both halves are required for the language to be a real
verification layer rather than just a compile-time linter.

## Effort vs. cost

This epic is **~12 calendar weeks at 3 agents** (see `02-phases.md`
sequencing summary). Comparable to the *Phase 1 — Systems primitives*
row of the runtime-enablement track. It runs parallel to runtime
enablement because they share two precondition stdlib gap-fills (P4
`process.run_capture` and P5 `fs.set_perms` family).

Slipping it post-1.0 keeps the language formally compileable but
practically untestable, which is the same shape as shipping the
compiler without `sfn check`. We don't ship `sfn check` post-1.0; we
shouldn't ship `sfn test` post-1.0 either.

## Roadmap row text proposals

For the `roadmapV1Tooling` (or whichever pre-1.0 tooling section) entry:

```js
{
  label: "Native test framework (Phases 0–3) — sfn/test capsule, expect()/lifecycle/fixtures, --json output, bash collapse",
  status: "planned",
  link: "/docs/proposals/test-infra-epic/",
}
```

For the post-1.0 follow-up entry (replacing line 163):

```js
{
  label: "Test framework — Phase 4 (property, fuzz, replay, adversarial)",
  status: "planned",
  link: "/docs/proposals/test-infra-epic/02-phases#phase-4",
}
```

## Status doc edits

Add a new section in `docs/status.md` under the existing tooling
status table once Phase 0 starts:

```
### Native test framework
| Item | Status |
| sfn/test capsule (assertions, dormant) | shipped — capsule exists at capsules/sfn/test/ but has zero consumers |
| Capsule-relative imports inside sfn test | precondition P1 — open |
| Structured assertion diagnostics | precondition P2 — open |
| Pure-effect assertion family | precondition P3 — open |
| process.run_capture | precondition P4 — open |
| fs perms / mkdtemp / symlink | precondition P5 — open |
| sfn test --json | precondition P6 — open |
| expect() builder | Phase 1 issue 1.4 — open |
| Lifecycle hooks | Phase 2 issue 2.1 — open |
| Snapshot tests | Phase 2 issue 2.4 — open |
| Bash e2e collapse | Phase 3 issue 3.1 — open |
| Parallel execution | Phase 4 — gated on routine/spawn |
```

## Cross-references in `llms.txt`

Once Phase 3.5 ships, `llms.txt` gains a "Testing your capsule" section
covering:
- Where tests live (`tests/` next to `src/`)
- The `test "<name>" { }` block + `expect()` API
- Lifecycle hooks, fixtures
- `sfn test --json` for tooling
- Common patterns (snapshot, compile-as-test, with_tmp_dir)

This makes the framework discoverable for AI agents writing Sailfin
code, closing the loop on the "AI agents are users" design principle
in `CLAUDE.md`.
