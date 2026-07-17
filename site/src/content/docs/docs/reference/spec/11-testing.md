---
title: "§11 Testing"
description: "Sailfin language specification — Testing."
sidebar:
  order: 11
  label: "§11 Testing"
---

```sfn
test "name" ![effects] {
    assert expression;
    assert actual == expected;
}
```

- `test` is a first-class keyword — no external framework needed
- Effects are declared just like on functions
- Test files are named `*_test.sfn` and discovered automatically by `sfn test`
- `assert expr;` is a statement form (no parens) and fails with the expression text

---

## `expect()` is preferred over a bare `assert` (W0210)

A bare `assert` inside a `test` block is **soft-deprecated**: `sfn check`
emits the warning `W0210: prefer expect() over a bare assert inside a test
block`, pointing at the `assert` keyword. A bare assert only reports the
expression text on failure, whereas the `sfn/test` matchers
(`expect_eq_int`, `expect_eq_str`, `expect_contains_str`, …) carry a
descriptive `actual` vs `expected` message:

```sfn
test "addition" ![pure] {
    assert 2 + 2 == 4;                 // W0210 — works, but a thin failure
    assert expect_eq_int(2 + 2, 4).ok; // preferred — descriptive on failure
}
```

W0210 is a **warning only** — it never fails a build or changes an exit
code — and fires solely inside `test` blocks; an `assert` in ordinary code
is unaffected. Pass `sfn check --allow-bare-assert` to suppress it. Removal
of the bare `assert` form is a post-1.0 consideration, not a current plan.

---

## Filtering which tests run

Two flags narrow a `sfn test` run to a subset of the discovered tests.
They filter per **test**, not per file — a file containing both matching
and non-matching tests runs only the matches.

```sfn
@tag("slow")
test "auth refresh round-trips a token" ![io] {
    assert refresh("old").length > 0;
}
```

```bash
sfn test -k auth            # run only tests whose name contains "auth"
sfn test --tag slow         # run only tests carrying @tag("slow")
sfn test -k auth --tag slow # both filters compose (a test must match both)
```

- `-k <substring>` keeps tests whose name **contains** `<substring>`
  (plain substring match, not a glob or regex).
- `--tag <value>` keeps tests carrying a `@tag("<value>")` decorator
  (see [§3.8 Test Declarations](/docs/reference/spec/03-declarations/)).
- When both are given, a test must satisfy **both** to run.
- A filter that matches nothing is not an error: the run reports
  `0/0 passed` and exits `0`.

---

## Lifecycle hooks

A test file may declare lifecycle-hook blocks that run setup/teardown
around its tests. They use the same block form as `test`, introduced by a
hook keyword instead of a quoted name:

```sfn
before_all ![io]  { print.info("once, before any test"); }
before_each ![io] { print.info("before every test"); }
after_each ![io]  { print.info("after every test"); }
after_all ![io]   { print.info("once, after every test"); }

test "alpha" ![io] { print.info("body"); }
test "beta"  ![io] { print.info("body"); }
```

Within a file the runner wraps each test in the order:

```
before_all → (before_each → test → after_each)* → after_all
```

- `before_all` / `after_all` run **once per file**, around the whole set
  of tests.
- `before_each` / `after_each` run **once per test**, immediately around
  each test body.
- Hooks are not tests: they carry no name, are excluded from the
  `-k` / `--tag` filters (they always run for the surviving tests), and
  do **not** count toward the `all N tests passed` summary.
- Hook bodies declare effects exactly like tests and functions.

**Limitations (current):**

- **One hook per kind per file.** Declaring two `before_each` blocks in
  one file is a duplicate-symbol error. (Composition across imported
  files and multiple hooks per kind are planned.)

**Hook-failure classification (SFN-17).** The synthesized harness recovers
from a failed assertion inside a test or hook instead of aborting the
suite process, so remaining tests in the file still run:

- A failing `before_each` marks each affected test `fail` with a message
  naming the hook (`hook before_each failed: <message>`).
- A failing `before_all` marks every test in the file `fail` (its setup
  never completed).
- A failing `after_each` / `after_all` is attributed to the hook, not to a
  test, and surfaces as a `hook` event in the `--json` stream.

A genuine crash (SIGSEGV / non-assertion `abort()`) is not recoverable and
is still reported at the file level via the crash-attribution path.

---

## Test runner JSON output

`sfn test --json` emits a machine-readable [JSON Lines](https://jsonlines.org/)
event stream on stdout — one event per line, with no human banner output.
Stderr remains usable for compiler-internal diagnostics that don't fit the
schema (e.g. "compiler crashed" stack traces, `[trace]` runner logs).

The stream is the canonical contract that CI tooling, the planned MCP
`sailfin_test_runner` tool, and the `assert_compiles` integration consume to
verify generated code passes its tests without scraping human-readable
output.

### Event shapes

Four event kinds, schema-versioned:

```jsonc
// First line — exactly once per run.
{"event":"start","total":42,"schema_version":2}

// One per test, in source order.
{"event":"test","name":"answer is 42","file":"path/to/foo_test.sfn",
 "line":3,"status":"pass","duration_ms":12,"effects":["io"]}

// `assertion` is attached when status == "fail" or when the runner
// synthesised a skip/fail reason (compile failure, link failure,
// process aborted before this test ran).
{"event":"test","name":"breaks","file":"path/to/foo_test.sfn",
 "line":7,"status":"fail","duration_ms":3,"effects":[],
 "assertion":{"file":"path/to/foo_test.sfn","line":8,"col":12,
              "message":"expected x == 42, got 41"}}

// One per failing lifecycle hook (SFN-17). `hook` is the kind
// (before_all / before_each / after_each / after_all); `test` is the
// associated test name for after_each, empty for before_all/after_all.
{"event":"hook","hook":"after_all","test":"","status":"fail",
 "message":"assertion failed"}

// Last line — exactly once per run. The `cache` object reports the
// per-test binary cache (see "Per-test binary cache" below).
{"event":"summary","passed":40,"failed":1,"skipped":1,"duration_ms":1284,
 "cache":{"test_bin_hits":36,"test_bin_misses":6,"test_bin_hit_rate":0.8571}}
```

### Field semantics

| Event     | Field            | Type      | Meaning                                                         |
|-----------|------------------|-----------|-----------------------------------------------------------------|
| `start`   | `total`          | integer   | Count of test declarations the runner discovered up front.      |
| `start`   | `schema_version` | integer   | Currently `2`. Bumped only on a breaking change.                |
| `test`    | `name`           | string    | The literal `test "..."` name from source.                      |
| `test`    | `file`           | string    | Source file path, as discovered by `sfn test`.                  |
| `test`    | `line`           | integer   | 1-based source line of the `test` keyword.                      |
| `test`    | `status`         | string    | `"pass"`, `"fail"`, or `"skip"`.                                |
| `test`    | `duration_ms`    | integer   | Wall-clock time approximation; see *Timing approximation* below.|
| `test`    | `effects`        | string[]  | Effects declared on the test, e.g. `["io", "net"]`.             |
| `test`    | `assertion`      | object?   | Present on `"fail"` and on synthesised `"skip"` reasons.        |
| `summary` | `passed`         | integer   | Tests with `status == "pass"`.                                  |
| `summary` | `failed`         | integer   | Tests with `status == "fail"`.                                  |
| `summary` | `skipped`        | integer   | Tests with `status == "skip"`.                                  |
| `summary` | `duration_ms`    | integer   | Wall-clock time of the entire `sfn test --json` invocation.     |
| `summary` | `cache`          | object    | Per-test binary cache counters; see *Per-test binary cache*.    |

The `cache` object mirrors the `sfn build --json` report's `cache` field:

| Field                | Type    | Meaning                                                              |
|----------------------|---------|----------------------------------------------------------------------|
| `test_bin_hits`      | integer | Tests served from the cached linked binary (lower+link skipped).     |
| `test_bin_misses`    | integer | Tests that cold lower+linked, then populated the cache.              |
| `test_bin_hit_rate`  | number  | `hits / (hits + misses)`, floored to four decimals; `0.0000` when no lookups were attempted (e.g. `--no-test-cache`). |

The optional `assertion` object carries the typed
[`AssertFailure`](https://github.com/SailfinIO/sailfin/blob/main/compiler/src/assert_failure.sfn)
record:

```jsonc
{"file":"...","line":N,"col":N,"message":"..."}
```

When the runner cannot pin a failure to a specific source location (e.g. the
file's compile or link step failed, or the test process aborted with no
`fail.bin` record), `line` and `col` are `0` and `message` carries a
synthesised reason (`"compile failed"`, `"link failed (clang exit=1)"`,
`"test process exited with code 134"`, etc.).

### Status attribution rule

The Sailfin test runner compiles every `test "..." { ... }` block in a file
into a single binary harness; an `assert false;` aborts the process via
`abort()` and unblocks no later tests. The JSON attribution rule reflects
that:

- Tests in a file whose binary exits `0` are all marked `"pass"`.
- When the binary exits non-zero with a `fail.bin` record, the runner
  matches the assertion's `line` to the test whose `line` is the largest
  ≤ the failure line (the closest preceding test in source order). That
  test is marked `"fail"`; tests earlier in the file are marked `"pass"`;
  tests later in the file are marked `"skip"`.
- When the binary exits non-zero with no `fail.bin` record, the first test
  in the file is marked `"fail"` with a synthesised `assertion.message`,
  and the rest are marked `"skip"`.
- When a file's compile or link fails, every test in that file is marked
  `"skip"` with a synthesised `assertion.message`. The runner continues to
  the next file so consumers see a full per-test stream.

### Timing approximation

`duration_ms` on a `test` event is the file's wall-clock execution time
divided evenly across the file's tests. Per-test wall time is not
directly observable today because every test in a file runs inside one
process; consumers should treat `duration_ms` as an indication of
roughly-balanced cost rather than a precise per-test measurement. The
`summary.duration_ms` field is the total wall time of the `sfn test --json`
invocation and is exact.

### Schema version policy

`schema_version` is a monotonically increasing integer attached to the
`start` event. The current version is `2`.

- Adding optional fields to existing events is **not** a breaking change.
  Consumers are expected to ignore unknown fields.
- Adding new event kinds is **not** a breaking change. Consumers should
  ignore unknown `event` discriminators rather than fail.
- Removing fields, repurposing field types, changing field semantics, or
  changing event ordering is breaking. The version is bumped in lockstep.

Consumers SHOULD hard-fail (refuse to process the stream) on an unknown
`schema_version` rather than try to compatibilize forward-incompatible
output.

### Stream contract

For any `sfn test --json` invocation:

- The first line on stdout is always a `start` event.
- The last line on stdout is always a `summary` event.
- Every line between is a `test` event in source-discovery order.
- Stdout contains nothing else — no human banners, no progress lines.
- Stderr may contain anything (compiler diagnostics, runner traces).

Consumers that pipe into `jq -c` can rely on every line being a complete
JSON object with no trailing whitespace.

## Per-test binary cache

`sfn test` content-addresses each test's linked native binary so an
unchanged test skips LLVM lowering and the `clang` link — the dominant
per-test cost — and just re-runs the cached executable. The cache key is

```
sha256(
  sha256(test_source_bytes)
  || sha256(sorted(hash of each transitive dep the link consumes))
  || compiler_identity        // commit-stable capsule version
  || runtime_identity         // content hash of the runtime link inputs
  || canonical(clang_flags)
  || schema_version
)
```

The dependency set is the resolver output the link already consumes for
the test's own closure, so a change to the test or any transitive
dependency changes the key and misses the cache. On a hit the cached
binary is still **run** (never a cached pass/fail result), so a
flaky-at-runtime test always surfaces.

`compiler_identity` is the **commit-stable** capsule version: the build
stamp's `+dev.<hash>` build metadata is stripped, so two commits at the
same version produce the same identity. This is what lets a `push:main`
baseline cache warm a PR's first run and a PR's second push reuse the
first's binaries — without it, the per-commit git hash busted every
entry on every commit. The test's own dep closure (hashed by content)
still captures any compiler codegen change that affects that test, so a
codegen-affecting change still misses; only commits that change nothing
in the test's closure hit across commits.

`runtime_identity` folds the assembled runtime capsule's link inputs
into the key by **content**: the runtime `.c`/`.ll`/`.sfn` sources, the
prelude entry, and the `.h` headers under each include root (each hashed
off disk, folded as `<path>@<sha256>` so distinct inputs never alias),
plus the include-dir paths and the declared link libraries (folded by
value). A runtime edit — including a header-only change or an
include-root change — therefore busts the key directly, no longer relying
on a compiler rebuild changing the stamp. `--no-test-cache` (which
`make check` and the nightly full suite pass) remains the cold-build
backstop at the merge gate.

Cached binaries live under `build/cache/test-bin/<schema>/` (alongside
the module IR cache, under `$SAILFIN_BUILD_CACHE_DIR` when set) and are
written atomically (temp + rename), so concurrent runs on the same key
never corrupt an entry. The `cache` object in the `--json` summary
reports the per-run `test_bin_hit_rate`.

`--no-test-cache` bypasses both the read and the write, forcing a cold
lower+link for every test (`test_bin_hit_rate` is then `0.0000`). The
`make check` full-suite gate passes it so a test-compile regression can
never be masked by a stale hit.

---
