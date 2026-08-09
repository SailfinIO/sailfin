---
sfep: 10
title: Sailfin-Native Test Infrastructure
status: Accepted
type: tooling
created: 2026-05-06
updated: 2026-08-05
author: "agent:compiler-architect (2026-05 epic); agent:Sailbot (2026-08 rewrite); human review"
tracking: "#965, #839, #842, #840 (historical intake); SFN-17"
supersedes:
superseded-by:
graduates-to: site/src/content/docs/docs/reference/spec/11-testing.md
---

# SFEP-0010 — Sailfin-Native Test Infrastructure

> **Amendment, 2026-08-05.** This SFEP began as a six-file epic directory
> (`0010-test-infra/`) written before the SFEP process existed, and carried its
> planning apparatus into the proposal system: sized issue tables, calendar-week
> estimates, a precondition list, a roadmap-edit instruction, and a bash-migration
> audit. Those are Linear and `archive/` genres, not design (SFEP-0001 §1). They
> are retired to `docs/proposals/archive/` and this single file is now canonical.
>
> The rewrite also fixes two accuracy failures. The directory's Phase 4 asserted
> that parallel test execution was "post-1.0, gated on `routine`/`spawn`"; that
> premise was wrong, and [§6.5](#65-why-the-runner-forks-instead-of-sharing-a-process)
> records what was actually true. Its bash-collapse file argued for three
> justified `.sh` hold-outs; the real outcome was **zero**
> (`.claude/rules/no-bash-e2e.md`). Citations are now **file + symbol** rather
> than `file:line` — every line range in the original had rotted, most of them
> pointing at `compiler/src/cli_commands.sfn`, a file that no longer exists.

## 1. Summary

Sailfin ships its own test framework rather than delegating to an external one.
A test is **language syntax** — `test "name" ![effects] { … }`, with
`before_all` / `before_each` / `after_each` / `after_all` hook blocks in the same
form — discovered and driven by the built-in `sfn test` runner. Assertions,
matchers, fixtures, snapshots, and compile-as-test helpers live in `sfn/test`, an
**ordinary capsule with no compiler privileges**, exactly as a third party's
`mycorp/test-helpers` capsule would. One framework serves the compiler's own
suite, the `capsules/sfn/*` suites, and end-user capsules.

This SFEP is the durable *why*. The normative user-facing reference is
[spec §11 Testing](../../site/src/content/docs/docs/reference/spec/11-testing.md);
where the two disagree, the spec is authoritative for behaviour and this document
for intent.

## 2. Motivation

**The starting state (2026-05) had three concrete failures**, each of which the
framework exists to close:

1. **Pass/fail was decided by grepping stdout.** A bash wrapper scanned test
   output for the words `pass`/`ok`/`success` against `fail`/`error`/`panic`/
   `abort`. Any test that legitimately printed the word "panic" was reported as
   failing. Correctness of the entire suite rested on a regex over prose.
2. **A capsule could not test itself.** The runner passed an empty resolver
   consumer, so a test file had no capsule context —
   `capsules/sfn/json/tests/json_test.sfn` inlined a copy of `JsonValue` rather
   than importing it. If in-tree capsules could not do this, neither could users.
3. **The bash e2e surface grew without friction.** Dropping in a new `.sh`
   "just worked," so the surface went 38 → 122 scripts. Bash was load-bearing
   because Sailfin lacked subprocess capture, temp-dir handling, and filesystem
   permission primitives.

**Agents are users, and this is the second half of their loop.** `sfn check`
lets a model verify that generated code *compiles*; only a test runner with a
machine-readable contract lets it verify that the code *behaves*. Without
`sfn test --json`, Sailfin is a compile-time linter with no behavioural
feedback edge — which forecloses the agent-adoption argument the project rests
on. This is why the framework was pulled onto the pre-1.0 path rather than
left in post-1.0 "Platform & Ecosystem" where it originally sat.

## 3. Design

### 3.1 Tests and hooks are language syntax, not a library

`test` is a first-class declaration with its own AST node (`TestDeclaration` in
`compiler/capsules/syntax/src/ast.sfn`), carrying a string-literal name and an effect row parsed
exactly like a function's. Hook blocks reuse the node with a `hook_kind`
discriminant.

```sfn
before_each ![io] { reset_fixture_dir(); }

test "auth: hashes and verifies round-trip" ![pure] {
    let h = hash_password("hunter2");
    assert expect_eq_bool(verify("hunter2", h), true).ok;
}
```

`emit_native.sfn` emits a hook under a `hook:<kind>` symbol, deliberately kept
out of the RUN/PASS test scan so hooks never count as tests. The LLVM harness
synthesizer (`compiler/src/llvm/lowering/lowering_core/test_harness.sfn`)
discovers each kind **statically** and emits **direct calls** into the
synthesized `@main`.

Two properties follow from doing this statically, and both are the reason for the
choice: hook ordering is an inspectable property of the source rather than of
runtime registration order, and the calls inline. Hooks are file-scoped — one per
kind per file, a second being a duplicate-symbol diagnostic.

### 3.2 `sfn/test` is an ordinary capsule

The framework has **no compiler-internal helper file and no privileged import**.
It is `capsules/sfn/test/`, resolved like any other capsule:

| Module | Surface |
|---|---|
| `mod.sfn` | the two assertion tiers — `assert_*`, `pure_assert_*`, `AssertFailure` — plus barrel re-exports of everything below |
| `expect.sfn`, `matcher.sfn` | `expect_eq_*`, `expect_contains_*`, `expect_to_throw*` → `MatchResult` |
| `fixtures.sfn` | `with_tmp_dir`, `with_env`, `with_cwd`, `clean_runner_env`, `nested_runner_scratch` |
| `snapshot.sfn` | `expect_snapshot`, `snapshot_match_in` |
| `compile_assert.sfn` | `assert_compiles` / `assert_does_not_compile`, over `sfn check --json` |
| `child_diag.sfn` | `report_child_failure` |

This is a hard constraint, not an aesthetic one: the moment the compiler's own
tests use a privileged path that a user's capsule cannot, the framework stops
being evidence that the language is testable.

### 3.3 Two assertion tiers, and the condition for collapsing them

`sfn/test` exposes the same assertions twice:

- **`assert_*`** — `![io]`, prints a diagnostic on failure.
- **`pure_assert_*`** — `![pure]`, *returns* an `AssertFailure` rather than
  printing; the runner renders it.

This duplication is not an oversight, it is the cost of not having
row-polymorphic effects. A single `assert_eq` cannot serve both a `![pure]` and
an `![io]` caller without an effect row variable, and a purely arithmetic test
should not be forced to declare `![io]` merely to assert. See
[§6.3](#63-blocking-the-framework-on-row-polymorphic-effects) for why we shipped
the duplication instead of waiting.

**The collapse condition is explicit**: when row-polymorphic effects land, both
tiers become one `assert_eq` parameterized over the caller's effect row,
`pure_assert_*` becomes a deprecated alias for exactly one minor release, and is
then removed. Until that lands, two tiers is the design, not a defect.

A load-bearing manifest subtlety makes this work: `capsules/sfn/test/capsule.toml`
declares `required = ["io"]` because the fixture, snapshot, and legacy-shim
surfaces genuinely perform I/O — but **importing `sfn/test` does not force
`![io]` onto the consumer.** `required` describes what the capsule's own
functions do, not what every caller must declare. A test calling only
`pure_assert_*` or `expect_*` stays `![pure]`. The interim tier depends entirely
on this being true.

### 3.4 Output contracts

`sfn test --json` emits JSON Lines — one event per line, schema-versioned, with
stdout reserved for the stream. The event shapes, field semantics, status
attribution, timing model, versioning policy, and stream contract are all
**normative in spec §11** and are not restated here. The rendering lives in
`compiler/src/test_runner_json.sfn`.

### 3.5 What this SFEP does not own

Six proposals now touch test infrastructure. Prior to this rewrite the boundary
between them was unstated, and SFEP-0003 §3.1 listed four of them in a single
undifferentiated row — omitting SFEP-0050 entirely. This table is the boundary;
cite it rather than re-litigating ownership.

| Territory | Owner |
|---|---|
| Test/hook syntax, the `sfn/test` capsule contract, assertion tiers | **this SFEP** |
| Runner performance internals — link window, invocation-scoped runtime identity, in-process sha256 | SFEP-0044 |
| Runner *architecture* — whether children re-run the frontend or the parent compiles once | SFEP-0045 (`Draft`) |
| Harness↔runner IPC, the streamed sub-frame protocol | SFEP-0050 |
| Test-artifact caching and deterministic suite partitioning | SFEP-0011 |
| Agent-legible failure taxonomy, `build/agent-report.json` | SFEP-0014 |
| Normative user-facing behaviour of `sfn test` | spec §11 (not an SFEP) |
| Shard map, job counts, CI gate placement | `docs/conventions/ci-test-topology.md` (not an SFEP) |

## 4. Effect and capability impact

Substantial, in both directions.

**Tests carry effect rows, so a test cannot silently exceed the reach of the code
it exercises.** A `![pure]` test that calls an `![io]` helper fails
effect-checking like any other caller. This makes the suite itself an instance of
the Reach pillar rather than a hole in it — a test cannot be the place where an
undeclared capability leaks in.

**The framework motivated an explicit non-entry.** `pure` is recognized by
`compiler/src/effect_taxonomy.sfn` as a sentinel meaning "declares no effects" —
deliberately *outside* the canonical taxonomy, because it is not a capability a
manifest can grant or deny, and folding it into `canonical_effects()` would
conflate the two concepts. That file cites this proposal's interim-tier rationale
directly as the reason the marker is needed at all.

**Capability enforcement is unchanged.** `sfn/test` declares its `required`
capabilities in its manifest and is subject to the same capsule-manifest checks
as any dependency; it receives no exemption from the seal (SFEP-0016). The
fixture surface (`with_env`, `with_cwd`, `with_tmp_dir`) is `![io]` precisely
because it manipulates process and filesystem state that the capability model
must see.

## 5. Self-hosting impact

The syntax half touches parser (block declarations), `ast.sfn`
(`TestDeclaration.hook_kind`), `emit_native.sfn` (`hook:<kind>` symbol), and the
LLVM harness synthesizer. The runner half lives in
`compiler/src/cli/commands/test/`, plus `compiler/src/test_runner_json.sfn` and
`compiler/src/test_runner_state.sfn`, and touches no language surface.

**The invariant is self-enforcing here in a way it is not elsewhere**: the
compiler's own ~642 test files are written in this framework, so a regression in
test syntax or harness synthesis cannot reach `main` without breaking the suite
that would detect it. That is a genuine advantage of the framework being
in-language, and it is worth stating because it is also a hazard — a change that
breaks the harness breaks the ability to observe that it broke the harness. Such
changes want `make clean-build` and a seed-built comparison, not a fast rung.

**Seed dependency.** `test` and hook syntax must exist in the *pinned seed* for
the working tree's own tests to build. New test-syntax surface is therefore
subject to `.claude/rules/seed-dependency.md`, and lands with its consumers
rather than split from them.

## 6. Alternatives considered

### 6.1 `@test fn name()` instead of the `test "…"` keyword

**Rejected — keep the keyword.** String-literal test names are strictly better
than mangled function names for failure reporting, `--json` payloads, `-k`
filtering, and readability, and that semantic gain is the "compelling reason" the
CLAUDE.md boring-syntax rule requires before deviating. Zig — the peer Sailfin
most resembles in positioning — ships this exact form in production. Adding
`@test fn` as an *alternative* would create two ways to do one thing, which the
design discipline rejects more strongly than keyword-vs-decorator uniformity.

Reversibility was part of the call: if post-1.0 evidence shows agents
systematically mis-write the keyword form (Rust's `#[test]` dominates training
data), adding `@test fn` later is a one-issue parser change. Reversing the other
direction is not.

### 6.2 Removing the `assert` keyword outright

**Rejected — soft-deprecate inside test blocks only (W0210).** Inside a test the
diagnostics gap between `assert x == y` and a matcher carrying actual/expected is
large, and no production language has settled on bare boolean assert as the
test-time idiom. But outside tests `assert` is currently the *only* runtime-checked
debug primitive the language has — `panic!` / `unreachable!` do not exist —
so removing it would leave a hole exactly where systems code needs fail-fast
invariants. Hence: warn in tests, leave ordinary code alone, and treat hard
deprecation as a post-1.0 question contingent on adoption rather than a
scheduled removal.

### 6.3 Blocking the framework on row-polymorphic effects

**Rejected.** The clean answer to §3.3's duplication is an effect row variable.
No peer systems language ships effect polymorphism — not Rust, Zig, Go, or Swift
— and all of them ship test frameworks anyway. Holding the framework hostage to a
feature with no ETA, to spare capsule authors one extra function name, trades a
bounded and mechanically-reversible cost for an unbounded slip. The interim tier
is the production answer; the polymorphic one is post-1.0 polish.

### 6.4 A runtime registration API for lifecycle hooks

**Rejected on three independent grounds, any one disqualifying.** A
`before_each(hook: fn() ![io])` register-now-call-later surface (a) cannot be
built today — it requires storing and later invoking an `fn` value, which the
frontend cannot do, so shipping its signatures would be a parsed-but-unenforced
API; (b) replaces a static direct call with an indirect call through a
function-pointer table, on code that runs on every `make test`; and (c) makes
hook ordering depend on runtime registration sequence rather than source order.

Cross-capsule hook composition remains deferred. If it is ever pursued it belongs
in the harness synthesizer at **compile time** — collecting `hook:<kind>` across
imported modules and ordering by import — never in a runtime registry.

### 6.5 Why the runner forks instead of sharing a process

Recorded here because the original directory got this wrong and the error
propagated into SFEP-0011. Its Phase 4 held that parallel test execution was
blocked on the `routine`/`spawn` runtime and must wait for post-1.0.

**That premise was false in both halves.** Parallel execution shipped as
subprocess fan-out (`process.spawn_with_env`) with no structured-concurrency
dependency whatsoever, and `routine`/nursery has since partly landed without
being what the runner uses. The actual reason for one child process per test file
is **per-file resolver isolation** — a positive design property, not a
concurrency workaround. Any future move to in-process execution must answer for
that isolation, which is why the question belongs to SFEP-0045 rather than being
a scheduling matter.

## 7. Stage1 readiness mapping

- [x] Parses — `test` and all four hook block forms
- [x] Type-checks / effect-checks — effect rows on tests and hooks
- [x] Emits valid `.sfn-asm` — tests as `test:<name>`, hooks as `hook:<kind>`
- [x] Lowers to LLVM IR — harness synthesizer emits direct hook calls
- [x] Regression coverage — see §8
- [x] Self-hosts — the compiler's own suite is written in this framework
- [x] `sfn fmt --check` clean
- [x] Documented in `docs/status.md` + spec §11
- [ ] **§3.3's committed collapse of the two assertion tiers** — not a Stage1
      checklist item, listed here so the eight boxes above are not misread as
      clearing the bar

**Status remains `Accepted`, not `Implemented`**, on one specific ground: §3.3
commits to collapsing the two assertion tiers when row-polymorphic effects land,
and that collapse is part of this design rather than a follow-on. A design with
an unsatisfied commitment in its own body has not shipped end-to-end.

This is a **deliberately stricter reading than SFEP-0001 §4**, which defines the
`Implemented` bar as exactly the Stage1 checklist — and by that letter, the eight
boxes above would suffice. The stricter reading is the one consistent with
"parsed but not enforced is not shipped": a proposal should not be able to reach
`Implemented` while its own body still describes a future API change. Flip this
to `Implemented` when the tiers collapse, not before.

**Ledger.**

| Item | State |
|---|---|
| `test` / hook block syntax, harness synthesis | Shipped |
| `sfn/test` capsule: matchers, fixtures, snapshots, compile-as-test | Shipped |
| Two assertion tiers | Shipped |
| Capsule-relative imports from a test file | Shipped |
| Structured failure records replacing stdout grep | Shipped |
| `--json` event stream, `-k` / `--tag` filtering | Shipped |
| Bash e2e collapse | Shipped — to **zero**, exceeding the target of ≤3 hold-outs |
| Collapse of the two tiers under effect polymorphism | **Pending** — the one thing holding this at `Accepted` |
| Migration of `AssertFailure` / `MatchResult` onto the shipped `Result<T, E>` | **Pending, unblocked.** Both are hand-rolled stand-ins predating SFEP-0012; `ok`/`present` map to `Ok(())`/`Err(failure)` with no call-site change. Independent of the row above |
| Cross-capsule hook composition | **Deferred**, post-1.0, explicitly not a 1.0 goal |

**Retracted from this SFEP** — carried by the original directory as pending work,
now removed rather than left to age:

- **The fluent generic `expect(x).to_be(y)` builder** and the `Equatable<T>`
  interface stub. Both need generic-struct monomorphization and `where` clauses.
  That is SFEP-0038's territory; carrying an aspirational generic API surface
  here made this proposal permanently un-implementable and violated the
  "parsed but not enforced is not shipped" rule in spirit. The shipped
  free-function form is the design.
- **The runner-as-capsule seam** (`run_tests` exported from `sfn/test` with an
  injected compile callback). Superseded: the runner lives in
  `compiler/src/cli/commands/test/`, SFEP-0020 makes compiler sub-capsules
  `publish = false`, and runner architecture is now SFEP-0045's question.
- **`sfn test --watch`.** Unshipped and still reasonable, but it carries no
  design controversy and needs no proposal — SFEP-0001 §1: small work needs only
  an issue.

## 8. Test plan

Coverage exists and is load-bearing rather than aspirational:

- **Framework self-tests** — `capsules/sfn/test/tests/` covers `expect`,
  `matcher`, `fixtures`, `snapshot`, `compile_assert`, and `child_diag`.
- **The assertion tiers** — `mod.sfn`'s `assert_*` / `pure_assert_*` surface is
  covered from outside the capsule, by
  `compiler/tests/integration/pure_assert_smoke_test.sfn`. That asymmetry is
  worth closing: the tier §3.3 treats as central is the one module with no
  in-capsule test.
- **Lifecycle proof** — `capsules/sfn/test/tests/lifecycle_test.sfn` asserts hook
  ordering and file scoping.
- **The suite itself** — ~642 `*_test.sfn` files across
  `compiler/tests/{unit,integration,e2e}` plus 66 capsule test files, 5,285
  `test` blocks. Any harness or syntax regression fails these.
- **Isolation regressions** — nested-runner tests must use
  `clean_runner_env(nested_runner_scratch(…))`; see `.claude/rules/no-bash-e2e.md`
  for the two pool-only traps that pass serially and fail under `--jobs N`.

A change to hook synthesis or test lowering warrants `make clean-build` before
`make check`, per §5.

## 9. References

- **Spec** — [`spec/11-testing.md`](../../site/src/content/docs/docs/reference/spec/11-testing.md)
  (normative); `spec/03-declarations.md` §3.8 for the declaration grammar
- **Related SFEPs** — SFEP-0011 (test-artifact caching and partitioning),
  SFEP-0044 (runner invocation cache), SFEP-0045 (runner architecture, `Draft`),
  SFEP-0050 (streamed test IPC), SFEP-0014 (agent-legible output),
  SFEP-0038 (generic constraints — gates the retracted fluent surface),
  SFEP-0016 (the seal), SFEP-0003 §3.1 (toolchain territory map)
- **Conventions** — `docs/conventions/ci-test-topology.md`,
  `docs/conventions/e2e-tests.md`,
  `docs/conventions/unit-test-import-envelope.md`,
  `docs/conventions/sanitizer-tests.md`
- **Rules** — `.claude/rules/no-bash-e2e.md`, `.claude/rules/seed-dependency.md`,
  `.claude/rules/compiler-safety.md`
- **Retired planning material** — `docs/proposals/archive/0010-test-infra-phases.md`
  (phased issue tables and preconditions) and
  `docs/proposals/archive/0010-bash-collapse.md` (the completed 38-script
  migration audit). Neither is live design; see `archive/README.md`.
- **Historical intake** — GitHub #965, #839, #842, #840 (pre-Linear provenance)
