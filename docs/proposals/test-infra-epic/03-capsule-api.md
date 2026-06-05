# `sfn/test` capsule API at Phase 3 completion

Signatures only, in target syntax (post-`int`/`float`, post-`Result<T,E>`,
post-`${}`). Helper bodies live in legacy syntax (`number`, `{{}}`)
until the global migration sweep completes; the API surface stays
target-syntax so the migration is a body-only edit.

## Module layout

```
capsules/sfn/test/
├── capsule.toml
├── src/
│   ├── mod.sfn              # re-exports + thin shims
│   ├── expect.sfn           # fluent Expectation<T> builder
│   ├── matcher.sfn          # Matcher<T> interface + built-in matchers
│   ├── lifecycle.sfn        # before_each / after_each / before_all / after_all
│   ├── fixtures.sfn         # with_tmp_dir / with_env / with_cwd
│   ├── snapshot.sfn         # to_match_snapshot
│   ├── compile_assert.sfn   # assert_compiles / assert_does_not_compile
│   └── runner.sfn           # run_tests entry point (used by sfn test)
└── tests/                   # one *_test.sfn per src/ module
```

## Core: matchers and expectations

> **Shipped (issue 1.4, #847, 2026-06-02) — free-function form only.**
> The section below documents the aspirational generic `Expectation<T>` surface
> that remains the Phase 3 completion target. What ships today is a per-type
> free-function fan-out in `capsules/sfn/test/src/expect.sfn`:
>
> ```sfn
> fn expect_eq_int(actual: int, expected: int) -> MatchResult ![pure];
> fn expect_eq_str(actual: string, expected: string) -> MatchResult ![pure];
> fn expect_eq_bool(actual: boolean, expected: boolean) -> MatchResult ![pure];
> fn expect_eq_int_array(actual: int[], expected: int[]) -> MatchResult ![pure];
> fn expect_contains_str(haystack: string, needle: string) -> MatchResult ![pure];
> fn expect_contains_int_array(haystack: int[], needle: int) -> MatchResult ![pure];
> fn expect_to_throw(thunk: fn() -> int) -> MatchResult ![pure];
> fn expect_to_throw_with(thunk: fn() -> int, pattern: string) -> MatchResult ![pure];
> ```
>
> `MatchResult { ok: boolean; message: string }` — caller asserts:
> `assert expect_eq_int(x, y).ok;`. Re-exported from `mod.sfn`.
> Covered by `capsules/sfn/test/tests/expect_test.sfn` (19 tests).
>
> **Two frontend gaps block the fluent `expect(x).to_be(y)` form below:**
> (a) no generic-struct monomorphization / `where` clauses — the compiler cannot
> instantiate `Expectation<T>` for each concrete type; (b) cross-module
> struct-method dispatch is miscompiled — `self` is passed incorrectly when a
> method call crosses a module boundary. The generic surface below is aspirational
> until both gaps close. Track progress in
> `docs/proposals/test-infra-epic/02-phases.md` issue 1.4.

```sfn
fn expect<T>(value: T) -> Expectation<T>;

interface Matcher<T> {
    fn check(self: Matcher<T>, actual: T) -> MatchResult;
}

struct MatchResult { ok: boolean; expected: string; actual: string; }
struct AssertFailure { file: string; line: int; col: int; message: string; }

struct Expectation<T> { value: T; negated: boolean; }

// Generic equality (where parser supports T: Equatable; otherwise per-type fan-out).
fn Expectation<T>.to_be(self: Expectation<T>, expected: T) -> () ![pure] where T: Equatable;
fn Expectation<T>.to_equal(self: Expectation<T>, expected: T) -> () ![pure] where T: Equatable;  // structural
fn Expectation<T>.not(self: Expectation<T>) -> Expectation<T>;

// Specialized matchers
fn Expectation<string>.to_contain(self: Expectation<string>, needle: string) -> () ![pure];
fn Expectation<string>.to_match(self: Expectation<string>, pat: string) -> () ![pure];
fn Expectation<string>.to_match_snapshot(self: Expectation<string>, key: string) -> () ![io];
fn Expectation<int>.to_be_greater_than(self: Expectation<int>, threshold: int) -> () ![pure];
fn Expectation<int>.to_be_less_than(self: Expectation<int>, threshold: int) -> () ![pure];
fn Expectation<float>.to_be_close_to(self: Expectation<float>, expected: float, tolerance: float) -> () ![pure];
fn Expectation<boolean>.to_be_true(self: Expectation<boolean>) -> () ![pure];
fn Expectation<boolean>.to_be_false(self: Expectation<boolean>) -> () ![pure];
fn Expectation<T[]>.to_have_length(self: Expectation<T[]>, n: int) -> () ![pure];
fn Expectation<T[]>.to_be_empty(self: Expectation<T[]>) -> () ![pure];
fn Expectation<T[]>.to_equal_array(self: Expectation<T[]>, expected: T[]) -> () ![pure] where T: Equatable;

// Throwing / Result matchers
fn Expectation<fn() -> T>.to_throw(self: Expectation<fn() -> T>) -> () ![pure];
fn Expectation<fn() -> T>.to_throw_with(self: Expectation<fn() -> T>, pat: string) -> () ![pure];
fn Expectation<Result<T, E>>.to_be_ok(self: Expectation<Result<T, E>>) -> () ![pure];
fn Expectation<Result<T, E>>.to_be_err(self: Expectation<Result<T, E>>) -> () ![pure];
```

## Legacy assertion shims (preserved through 1.0; deprecated post-1.0)

Per-type fan-out for the no-generics era. **Two API tiers:** legacy
`assert_eq_*` print on failure (`![io]`); `pure_assert_*` return
`Result<(), AssertFailure>` and stay `![pure]`. The runner reads the
Result via the P2 structured hook. When row-polymorphic effects ship
post-1.0, both tiers collapse into a single `assert_eq<T, E>`
parameterized over the caller's effect row.

```sfn
// Legacy `![io]` shims — print diagnostics on failure
fn assert_eq<T: Equatable>(actual: T, expected: T, label: string) ![io];   // when generics ship
fn assert_eq_int(actual: int, expected: int, label: string) ![io];
fn assert_eq_float(actual: float, expected: float, tolerance: float, label: string) ![io];
fn assert_eq_string(actual: string, expected: string, label: string) ![io];
fn assert_eq_bool(actual: boolean, expected: boolean, label: string) ![io];
fn assert_array_eq<T: Equatable>(actual: T[], expected: T[], label: string) ![io];

// Pure variant — returns rather than prints; runner consumes the Result
fn pure_assert_eq_int(actual: int, expected: int, label: string) -> Result<(), AssertFailure>;
fn pure_assert_eq_string(actual: string, expected: string, label: string) -> Result<(), AssertFailure>;
fn pure_assert_eq_float(actual: float, expected: float, tolerance: float, label: string) -> Result<(), AssertFailure>;
fn pure_assert_eq_bool(actual: boolean, expected: boolean, label: string) -> Result<(), AssertFailure>;
// ... etc
```

## Lifecycle hooks

> **Shipped (issue 2.1a, #975).** Lifecycle hooks are **language syntax**
> (block declarations), *not* a library surface. The earlier draft of this
> section specified a runtime registration API (a `before_each(...)`-style
> function taking a hook closure); that architecture was rejected — see
> "Why not a registration API" below.

A test file declares at most one of each hook kind at module scope:

```sfn
before_all  ![io] { /* runs once, before any test in this file */ }
before_each ![io] { /* runs before every test in this file */ }
after_each  ![io] { /* runs after every test in this file */ }
after_all   ![io] { /* runs once, after all tests in this file */ }
```

The effect list (`![io]` above) is the hook body's own effect row, parsed like
a test block's. Each hook lowers to a `TestDeclaration` carrying `hook_kind`
(`compiler/src/ast.sfn`); `emit_native` emits it under a `hook:<kind>` symbol
kept out of the RUN/PASS test scan. The LLVM test-harness synthesizer
(`compiler/src/llvm/lowering/lowering_core.sfn`) discovers each kind
**statically** and emits **direct calls** into the synthesized `@main`:
`before_all` once before the test loop, `before_each`/`after_each` wrapping each
test call, `after_all` once after. There is no runtime registry and no indirect
dispatch — hook ordering is a static property of the source. A failing
`before_*`/`after_*` is attributable to the surrounding test (or to a
`HOOK before_all` / `HOOK after_all` stderr marker the harness emits).

Hooks are **file-scoped**: one per kind per file (a second of the same kind is a
duplicate-symbol diagnostic), applying only to tests in the declaring file.

### Why not a registration API

A `before_each(hook: fn() ![io])` register-now-call-later surface was rejected
on three independent grounds, any one disqualifying:

1. **Unbuildable today.** It requires storing a `fn` value and calling it back
   later; the frontend cannot store+recall fn-values (see `src/expect.sfn`:
   "a thunk cannot be stored in a struct field and called"). Shipping its
   signatures would be a non-functional, parsed-but-unenforced API.
2. **Slower.** It replaces #975's static direct `call @hook__suffix()` with an
   indirect call through a runtime function-pointer table — defeating inlining
   on code that runs on every `make test` / CI invocation.
3. **Non-deterministic ordering.** Registry order is the runtime registration
   sequence; static block order is an inspectable property of the source.

> **Deferred (post-1.0): cross-capsule composition.** Implicit "a parent
> capsule's `before_each` runs before a child's" is *not* shipped and is not a
> 1.0 goal (most frameworks scope hooks per file/module; implicit cross-module
> inheritance is the surprising choice). If ever pursued, it belongs in the
> harness synthesizer at **compile time** — collect every `hook:<kind>` across
> linked/imported modules and order by import — **not** in a runtime
> registration API.

## Fixtures

Closure-scoped resource setup. All require closures-with-capture
(1.0 critical path Phase 2). `with_tmp_dir` uses `fs.mkdtemp` (P5)
with prefix `sfn-test-` and removes recursively on scope exit;
`with_env` and `with_cwd` save/restore.

```sfn
fn with_tmp_dir<R>(body: fn(dir: string) -> R) -> R ![io];
fn with_env<R>(name: string, value: string, body: fn() -> R) -> R ![io];
fn with_cwd<R>(dir: string, body: fn() -> R) -> R ![io];
```

## Snapshots

```sfn
fn snapshot_file_for(test_name: string, key: string) -> string;
fn Expectation<string>.to_match_snapshot(self: Expectation<string>, key: string) -> () ![io];
```

Snapshots live at `<package>/tests/__snapshots__/<key>.snap`. First run
writes; subsequent runs compare. `sfn test --update-snapshots`
overwrites. Failure prints a unified diff via `sfn/diff` (post-1.0
capsule; until then, line-by-line).

## Compile-as-test

```sfn
struct CompileExpect {
    effects: string[];
    ok: boolean;
    diagnostic_pattern: string;
}

fn assert_compiles(source: string, expect: CompileExpect) -> () ![io];
fn assert_does_not_compile(source: string, diagnostic_pattern: string) -> () ![io];
```

Both shell out to `sfn check --json` via `process.run_capture` (P4)
and parse the JSON diagnostic stream with `sfn/json`. They depend on
the planned `sfn check --json` (`site/src/pages/roadmap.astro:119`).

## Runner entry point

```sfn
struct RunnerOptions {
    json: boolean;
    filter: string;        // -k pattern
    tags: string[];        // --tag list
    jobs: int;             // 1 until Phase 4
    update_snapshots: boolean;
    watch: boolean;
    watch_interval_ms: int;
}

struct RunnerResult {
    passed: int;
    failed: int;
    skipped: int;
    duration_ms: int;
    failures: AssertFailure[];
}

fn run_tests(
    files: string[],
    opts: RunnerOptions,
    compile_test: fn(path: string) -> string,
) -> RunnerResult ![io];
```

The compiler's `sfn test` becomes a thin dispatcher (Phase 3 issue
3.2) that calls `run_tests` with a `compile_test` closure that compiles
+ links one test file to an executable path. External tools (the MCP
server's `sailfin_test_runner` tool) can import `sfn/test` and supply
their own compile callback.

## Effect annotations summary

| Function family | Effect |
|---|---|
| `expect(...).to_*` matchers | `![pure]` (failures recorded via P2 hook, not `print.err`) |
| `pure_assert_*` | `![pure]` (returns `Result`) |
| Legacy `assert_eq` shims | `![io]` (until effect polymorphism replaces) |
| `with_tmp_dir`, `with_env`, `with_cwd` | `![io]` |
| Snapshot matchers | `![io]` (file write on first run / `--update-snapshots`) |
| `assert_compiles` | `![io]` (process.run_capture) |
| `run_tests` | `![io]` |

`capsules/sfn/test/capsule.toml` keeps `required = ["io"]` because
lifecycle/fixture/runner/legacy-shim surfaces use `print.err` and
`process.run`. **Importing `sfn/test` does NOT force `![io]` on the
consumer** — `required` declares what the capsule's own code does, not
what every caller must. A test calling only `expect(...)` or
`pure_assert_*` stays `![pure]`. P3 (`01-preconditions.md`) relies on
this to give pure tests a pure path without splitting the capsule.
Until row-polymorphic effects land, **one capsule, two API tiers**.
