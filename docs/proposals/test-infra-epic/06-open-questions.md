# Open questions for the user

These three decisions cannot be made by the architect alone. They are
all reversible, but the migration costs differ. Each has a recommended
answer with one-sentence justification — say "approve" / "reject" /
"discuss" on each and we can `/groom` the epic into individual issues.

---

## Q1. Keep `test "..." { }` as a keyword, or migrate to `@test fn ...`?

**Recommendation: keep the keyword.**

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

**Decision needed:** approve "keep keyword" / propose alternative.

---

## Q2. Deprecate the `assert` keyword?

**Recommendation: soft-deprecate inside `test` blocks only (issue 3.3,
warning W0210). Outside tests, `assert` stays.**

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

**Decision needed:** approve "soft-deprecate inside tests only" /
propose alternative scope.

---

## Q3. Where does `sfn/test` get effect-polymorphism from?

**Recommendation: ship the `pure_assert_*` interim now (issue P3) and
absorb the API churn when row-polymorphic effects land post-1.0.**

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

**Decision needed:** approve "ship interim" / approve "block on row
polymorphism" / propose alternative.

---

## Other questions raised but not blocking

These are smaller decisions that can be made during grooming, listed
here so the user has visibility:

- **Q4. JSON schema location:** propose
  `site/src/content/docs/docs/reference/spec/§9-test-json.md`
  (sibling of the planned `sfn check --json` schema). Defer to whoever
  owns the spec layout.
- **Q5. Snapshot directory:** `<package>/tests/__snapshots__/<key>.snap`
  (Vitest convention). Trivially renamable.
- **Q6. Default `--jobs`:** 1 for Phase 1-3 (serial). Phase 4 ships
  default `nproc / 2`. Configurable per-capsule via
  `[test] jobs = N` in `capsule.toml`.
- **Q7. `assert false` runtime hook fd:** propose `fd 3` (test-runner
  reserves) with fallback to a scratch file. Defer to P2 implementation.
- **Q8. Test-only capsule dependencies:** add `[dev-dependencies]`
  section to `capsule.toml`? Today `sfn/test` would be a regular dep.
  Probably yes, but post-1.0 — defer.

---

## What happens after the user answers Q1-Q3

Once we have decisions on Q1-Q3:

1. Run `/groom` against this epic to break each phase into individual
   `claude-ready` GitHub issues.
2. Each precondition (P1-P6) becomes one issue under
   `type:feature, size:s|m, priority:high`.
3. Each phase issue (1.1, 1.2, ..., 3.5) becomes one issue.
4. Q4-Q8 become inline notes on the relevant issues; no separate
   tracking needed.
5. `/pickup` can start consuming issues from Phase 0 immediately —
   they're parallelizable across three agents.

Phase 0 should land within ~2 weeks at 3 agents. Phase 1 follows.
