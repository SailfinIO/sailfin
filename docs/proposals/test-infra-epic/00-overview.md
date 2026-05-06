# Epic: Sailfin-native test infrastructure

**Status:** proposed (planning only — no code changes in this PR)
**Author:** compiler-architect (briefed by the test-capsule review session)
**Last updated:** 2026-05-06
**Branch of record:** `claude/review-test-capsule-w1XEK`

## Vision

A Sailfin user runs `sfn new my-app && cd my-app && sfn test` and gets
a test framework that feels like Vitest or `cargo test`: tests live in
`tests/` next to `src/`, import from their own capsule via
`import { Order } from "../src/mod"`, get rich assertion failures with
file:line:span, run in parallel with deterministic output, and emit
machine-readable JSON for CI tooling. Bash test scripts collapse to
zero. The `sfn/test` capsule is a normal capsule with no special
compiler privileges — the same way an end user's `mycorp/test-helpers`
capsule would work.

### Sample target test (post-syntax-reform)

```sfn
import { hash_password, verify } from "../src/auth";
import { expect, before_each, with_tmp_dir } from "sfn/test";

test "auth: hashes and verifies round-trip" ![pure] {
    let h = hash_password("hunter2");
    expect(verify("hunter2", h)).to_be_true();
    expect(verify("wrong", h)).to_be_false();
}

test "auth: rejects empty password" ![pure] {
    expect(|| hash_password("")).to_throw_with("password must be non-empty");
}

test "auth: stores hash to disk" ![io] {
    with_tmp_dir(|dir: string| {
        let path = dir + "/creds";
        save_creds(path, "alice", hash_password("hunter2"));
        expect(fs.read(path)).to_contain("alice:");
    });
}
```

### Sample `sfn test --json` line (jsonl, one event per line)

```json
{"event":"test","name":"auth: hashes and verifies round-trip","file":"tests/auth_test.sfn","line":4,"status":"pass","duration_ms":12,"effects":["pure"]}
```

## Non-negotiables

1. **Self-hosting:** every phase leaves `make compile && make check`
   green. No phase can require a feature the released seed can't compile.
2. **Bounded C runtime growth:** the framework itself adds no C
   runtime code beyond the explicitly-scoped Phase 0 extern bindings
   listed in `01-preconditions.md` (P2's `sailfin_assert_fail` hook,
   P4's `process.run_capture` extern, P5's fs perms/mkdtemp/symlink
   externs). Those are the only C-side additions; everything else
   comes from existing or near-term Sailfin/capsule features. Phase
   1+ contains no new C entries — once Phase 0 closes, the C surface
   freezes for the rest of the epic.
3. **One framework, all consumers:** the compiler's tests, the
   `sfn/runtime-native` capsule's tests (post-port), every
   `capsules/sfn/*` test, and every end-user capsule test all use the
   exact same `sfn/test` capsule. No compiler-internal helper file.
4. **Pre-1.0 syntax reform aware:** the API surface is designed in
   `int`/`float`/`:`/`${}`/`Result<T, E>` form. Helper bodies stay in
   the legacy form (`number`, `{{}}`) until the global migration sweep,
   so the capsule remains buildable on the current parser.
5. **DRY:** no duplicate `_number_to_string`, no duplicate `run_test()`,
   no duplicate scratch-dir bash. The current `sfn/test/src/mod.sfn`
   reimplements helpers that already exist in `sfn/strings`/`sfn/fmt`;
   the cleanup is Phase 1, not deferred.

## Success metrics

- Zero `*_test.sh` files under `compiler/tests/e2e/` outside the
  explicit cross-language allowlist in `04-bash-collapse.md`
  (target ≤ 3 hold-outs).
- Zero inline copies of capsule structs in capsule test files
  (`capsules/sfn/json/tests/json_test.sfn` imports from `../src/mod`
  instead of duplicating `JsonValue`).
- `sfn test --json` ships with a versioned schema documented under
  `site/src/content/docs/docs/reference/spec/`.
- The compiler's existing `test "..." { }` blocks all use `sfn/test`
  matchers (or explicit bare `assert` for trivial booleans, with
  `W0210` warning emitted).
- `make test` becomes a one-liner that invokes `sfn test compiler/tests
  capsules`. The four bespoke loops in `Makefile:194-291` collapse.
- Per-capsule wall-clock test runtime improves ≥ 4× once parallel
  execution lands (Phase 4); structured failure reports are available
  starting Phase 1.

## Document layout

| File | Contents |
|---|---|
| `00-overview.md` | this file: vision, non-negotiables, metrics |
| `01-preconditions.md` | the six P-issues that must close first |
| `02-phases.md` | phased issue list (Phase 1, 2, 3, sketch of 4) |
| `03-capsule-api.md` | the `sfn/test` API surface at Phase 3 completion |
| `04-bash-collapse.md` | 38-script migration table, hold-outs justified |
| `05-roadmap-delta.md` | how this epic moves on `sailfin.dev/roadmap` |
| `06-open-questions.md` | original 3 decisions, now resolved (2026-05-06) — keep `test` keyword, soft-deprecate `assert` in tests, ship `pure_assert_*` interim |

## Reading order

If you only have ten minutes, read this file plus `02-phases.md` for
the phased issue list. The decisions in `06-open-questions.md` are
locked in — calls were made on long-term language-health grounds —
so the next step is `/groom` to break this epic into `claude-ready`
issues and start Phase 0.
