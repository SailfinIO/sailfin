# Decisions

Originally three open questions; all three resolved 2026-05-06 by the
project lead with the directive *"decide based on the long-term health
of the language so it can be a production-ready, performant systems
language competing with modern peers."* Calls and rationale below.
Original analysis preserved beneath each decision as the historical
record.

## Decision summary

| Q | Decision | One-line rationale |
|---|---|---|
| Q1 | **Keep the `test "..." { }` keyword. Do NOT add `@test fn`.** | String-literal test names are strictly better diagnostics than mangled function names; Zig precedent shows the keyword form ships in production systems languages; switching costs weeks for marginal convention alignment with Rust. |
| Q2 | **Soft-deprecate bare `assert` inside `test` blocks (W0210). Outside tests, `assert` stays. Hard-deprecate to error post-1.0 only if `expect()` adoption is universal.** | `expect(x).to_be(y)` produces structurally better failures inside tests; `assert` outside tests is the only debug primitive Sailfin has until `panic!`/`unreachable!` ship. Two-tier deprecation matches Rust's `assert_eq!` evolution. |
| Q3 | **Ship the `pure_assert_*` interim now (P3). Do NOT block the framework on row-polymorphic effects.** | No peer systems language (Rust, Zig, Go) has effect polymorphism, and they all ship test frameworks. Blocking on a perfect-future feature for a 6-12 month slip is the wrong trade for a language fighting for adoption. |

## Long-term health context

The decision criterion was explicitly *"production-ready, performant,
competing with modern systems languages."* That argues for:

- **Don't innovate where convention wins.** Test syntax is not a
  Sailfin differentiator. The three differentiators per `CLAUDE.md` are
  effect system, capability security, structured concurrency. Spend
  novelty budget there.
- **Ship usable surface, then refine.** A test framework gated on
  effect polymorphism is a framework that doesn't exist. A framework
  with two near-identical assertion families exists and works.
- **LLM error rates matter strategically.** If telemetry post-1.0 shows
  agents systematically mis-write `test "name" { }` (because Rust's
  `#[test]` dominates training data), revisit Q1 then. Reversing a
  keyword decision post-1.0 by adding `@test fn` as an alternative form
  is a one-issue parser change. Reversing now to discover it wasn't the
  problem costs weeks.

Each question's full analysis is preserved below.

---

## Q1. Keep `test "..." { }` as a keyword, or migrate to `@test fn ...`?

**Status: DECIDED — keep the keyword. Do NOT add `@test fn` as an alternative form.**

**Rationale (long-term language health).** The `CLAUDE.md` "libraries
over keywords" rule applies most strongly to *new* keywords; this one
exists, has a first-class AST node, lowers through the full pipeline,
and is exercised by ~150 tests in `compiler/tests/` plus every capsule
test. The "boring syntax wins / match Rust" argument cuts the other
way here: Zig — the systems language Sailfin most closely resembles in
positioning — ships exactly this `test "name" { }` form, and Zig is a
production-ready peer. String-literal test names are objectively
better than function-name-mangled forms for failure reporting, JSON
output, `-k` filtering, and human readability — that semantic gain is
the "compelling reason" the design framework calls for. Adding
`@test fn` as an *alternative* form would create two-ways-to-do-X
which the language's design discipline rejects more strongly than
keyword-vs-decorator stylistic uniformity. If post-1.0 telemetry shows
agents systematically mis-write the keyword form, we add `@test fn`
as a one-issue parser change at that point — the keyword stays
canonical regardless.

**Original recommendation (architect): keep the keyword.**

The `TestDeclaration` AST node (`compiler/src/ast.sfn:132,187`) is
already first-class and lowers through the full pipeline. The runner
already produces a normal function `test:<name>`
(`compiler/src/emit_native.sfn:394`) so the runner-as-capsule seam
(Phase 3 issue 3.2) already works without any keyword change.

A migration to `@test fn name() { ... }` would require:
- closures-with-capture for hook composition (not yet shipped)
- rewriting every existing test (~150 in compiler/, dozens in capsules/)
- documenting deprecation, then removing the keyword post-1.0

Cost of keeping: one extra parser keyword (already there).
Cost of switching: weeks of rewrites + a deprecation cycle for marginal
syntactic uniformity.

---

## Q2. Deprecate the `assert` keyword?

**Status: DECIDED — soft-deprecate inside `test` blocks (W0210). Outside tests, `assert` stays. Hard-deprecate to error post-1.0 only if `expect()` adoption is universal in capsule and end-user code.**

**Rationale (long-term language health).** Inside a test, the
diagnostics gap between `assert x == y` (boolean abort, no expected/
actual surfaced) and `expect(x).to_be(y)` (typed expected/actual,
structural diff, file:line:span via P2) is large enough that no
production-ready language has settled on bare boolean assert as the
test-time idiom: Rust pushes `assert_eq!`, Go pushes table-driven
`if got != want`, Swift pushes `XCTAssertEqual`. The W0210 warning
gives existing code a graceful path while making the better idiom the
default for new code. Outside tests, however, `assert` is the only
runtime-checked debug primitive Sailfin currently has — `panic!()` and
`unreachable!()` are not yet shipped. Removing it from non-test code
would create a hole that breaks systems-language ergonomics where
fail-fast invariants matter (parser internal consistency, lowering
preconditions). The two-tier deprecation (warning now, error post-1.0
contingent on universal `expect` adoption) lets the language grow into
the better default without a hard cutover.

**Original recommendation (architect): soft-deprecate inside `test` blocks only (issue 3.3, warning W0210). Outside tests, `assert` stays.**

`assert` is a useful debug primitive and Sailfin doesn't have
`panic!()`/`unreachable!()` macros — taking `assert` away from
non-test code would leave a hole. But inside a test, `expect(x).to_be(y)`
produces vastly better diagnostics than `assert x == y` (typed
expected/actual, structural diff for collections, file:line:span).

The soft deprecation:
- emits `W0210: prefer expect() inside test blocks` for `assert <expr>`
  inside a `TestDeclaration`
- opt-out flag: `--allow-bare-assert`
- removal post-1.0 only if the warning has had two minor releases of
  burn-in and capsule authors haven't pushed back

---

## Q3. Where does `sfn/test` get effect-polymorphism from?

**Status: DECIDED — ship the `pure_assert_*` interim now (P3). Do NOT block the framework on row-polymorphic effects.**

**Rationale (long-term language health).** No peer modern systems
language ships effect polymorphism: not Rust, not Zig, not Go, not
Swift. They all ship usable test frameworks anyway. Blocking Sailfin's
test framework on a roadmap item with no ETA, when peer languages have
demonstrated for years that you can ship without it, is the wrong
trade for a language fighting for adoption. The interim cost is
explicit and bounded: two function families per assertion type
(`assert_eq_int` and `pure_assert_eq_int`), zero runtime overhead,
mechanical to collapse into a single generic `assert_eq<T>` once row
polymorphism lands. The deprecation path is clean: when row
polymorphism ships, `pure_assert_*` becomes a deprecated alias for
the unified `assert_*<E>` for one minor release, then is removed.
Holding the framework hostage to a 6-12 month feature slip — for the
strategic value of saving capsule authors from learning two function
names — is exactly the kind of perfectionism that ships nothing. The
interim API is the production-ready answer; the polymorphic API is the
post-1.0 polish.

**Original recommendation (architect): ship the interim and absorb the API churn when row-polymorphic effects land post-1.0.**

The clean answer is row-polymorphic effects (`![E]` row variable on
the assertion) so a single `assert_eq` works whether the caller is
`![pure]` or `![io]`. That feature is in the *Effect System Hardening*
track without a sized issue and probably ships in 1.x, not 1.0.

The interim (`pure_assert_*` returning `Result<(), AssertFailure>`) is
two extra functions per assertion family, zero runtime cost. When
effect polymorphism lands we collapse the two API tiers and `pure_assert_*`
becomes deprecated aliases.

The alternative is to **block the entire framework on row-polymorphic
effects.** That keeps the API small but slips the framework behind a
roadmap item with no ETA. We'd lose 6-12 months of agent-adoption
runway to avoid two function names.

---

## Smaller questions deferred to grooming

- **Q4. JSON schema location:** extend `site/src/content/docs/docs/reference/spec/11-testing.md` with a "Test runner JSON output" section (the spec uses numbered `NN-name.md` filenames; testing already lives at chapter §11).
- **Q5. Snapshot directory:** `<package>/tests/__snapshots__/<key>.snap` (Vitest convention).
- **Q6. Default `--jobs`:** 1 for Phase 1-3 (serial). Phase 4 ships default `nproc / 2`, configurable via `[test] jobs = N` in `capsule.toml`.
- **Q7. `assert false` runtime hook fd:** propose `fd 3` with scratch-file fallback. Defer to P2 implementation.
- **Q8. Test-only capsule dependencies:** `[dev-dependencies]` in `capsule.toml`. Probably yes, post-1.0 — defer.

---

## Next steps

1. `/groom` this epic into `claude-ready` GitHub issues. Each P1-P6 becomes one issue (`type:feature, size:s|m, priority:high`); each phase issue (1.1-3.5) becomes one issue. Q4-Q8 land as inline notes on the relevant issues.
2. `/pickup` consumes Phase 0 issues immediately — parallelizable across three agents. Phase 0 should land within ~2 weeks; Phase 1 follows.

Issue scope locks in per the Q1-Q3 decisions:

- **1.4 (`expect`):** keyword form `test "..." { }` remains canonical; no `@test fn` parser work.
- **3.3 (assert deprecation):** W0210 inside `test` blocks only. Hard-deprecation post-1.0 is a separate issue contingent on adoption telemetry.
- **P3 (pure assertions):** ships as a complete second API tier, not a placeholder. Both forms documented; tooling treats them as siblings until row polymorphism collapses them.
