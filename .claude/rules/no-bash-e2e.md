New end-to-end tests are written in Sailfin (`*_test.sfn`) using the
`sfn/test` capsule — **not** as bash scripts. The `compiler/tests/e2e/*.sh`
surface grew 38 → 122 because dropping a new `.sh` in that directory "just
works"; that era is closing (test-infra Phase 3, epic #842). A warn-first
CI lint (`scripts/lint_no_new_e2e_bash.sh`, allowlist
`scripts/e2e_bash_allowlist.txt`) flags any new off-allowlist script, and
will become a hard failure once the migration backlog is drained.

## Write e2e tests like this

An e2e test is an ordinary `*_test.sfn` with `test "..." { }` blocks. It
runs under `sailfin test compiler/tests/e2e` alongside unit/integration
tests. Use the runtime `process.*` builtins to drive a subprocess and the
`sfn/test` matchers to assert on the result:

See `compiler/tests/e2e/guillermo_test.sfn` for the full canonical
exemplar. The shape:

```sfn
// compiler/tests/e2e/guillermo_test.sfn
import { find } from "sfn/strings";

// The compiler-under-test: $SAILFIN_BIN if set, else the self-hosted
// binary relative to the repo root the runner starts from. This mirrors
// sfn/test's own `_resolve_sfn_bin` (compile_assert.sfn) so CI can point
// the test at any compiler without editing it.
fn _sfn_bin() -> string ![io] {
    let configured = env.get("SAILFIN_BIN");
    if configured.length > 0 { return configured; }
    return "build/native/sailfin";
}

test "guillermo: command exits 0" ![io] {
    let exit = process.run_capture([_sfn_bin(), "guillermo"], []);
    let _ = process.capture_take_stdout();
    let _ = process.capture_take_stderr();
    assert exit == 0;
}

test "guillermo: output contains the mascot greeting" ![io] {
    let _exit = process.run_capture([_sfn_bin(), "guillermo"], []);
    let out = process.capture_take_stdout();
    let err = process.capture_take_stderr();
    assert find(out + err, "Guillermo", 0) >= 0;
}
```

The supported building blocks (all already shipped):

- **Run a subprocess:** `process.run_capture(argv: string[], env: string[]) -> int`,
  then `process.capture_take_stdout()` / `process.capture_take_stderr()`
  (runtime builtins — no capsule import; this is what `sfn/test`'s own
  `assert_compiles` uses).
- **Assert on a compile:** `assert_compiles(source, CompileExpect{...})` /
  `assert_does_not_compile(source, pattern)` from `sfn/test` — frontend
  check (`sfn check --json`) without linking a binary. Prefer these over
  shelling out for "does this snippet compile / produce diagnostic X".
- **Snapshot emitted IR/output:** `expect_snapshot` / `snapshot_match_in`
  from `sfn/test` (refresh with `SAILFIN_UPDATE_SNAPSHOTS=1`).
- **Matchers (pure tests only):** `expect_eq_*` / `expect_contains_str` /
  `expect_to_throw*` from `sfn/test` — `assert expect_*(...).ok;`. These are
  `![pure]`, so the calling test must be `![pure]` too; they **cannot** be
  used from an `![io]` test (subprocess/fs). In an `![io]` test, assert on
  captured output with `sfn/strings::find` or `==`. (Making the matchers
  callable from `![io]` contexts is tracked against #842.)
- **Temp dirs:** `with_tmp_dir(fn(dir) { ... })` from `sfn/test`.
- **Per-child env:** pass `["KEY=value", ...]` as the `run_capture` env
  argument. There is **no** `with_env`/`with_cwd` fixture (process-global
  `setenv`/`chdir` is unsound under the future parallel runner — see
  `fixtures.sfn`); always scope env to the child you spawn.
- **Build a binary to run it:** when a test must compile a fixture to an
  executable (not just frontend-check it), give each nested `sfn build` a
  per-build `--work-dir` inside the test's `with_tmp_dir` — **mandatory**
  under the parallel pool. See the dedicated section below for the why.

## Build-and-run tests must isolate the build (`--work-dir`)

A test that spawns a full `sfn build` (compile a fixture to a binary and
execute it — e.g. `sailfin_main_entry_test.sfn`,
`sailfin_main_panic_test.sfn`) runs inside the parallel `int-e2e-caps`
pool (`sailfin test --jobs N`), so **multiple `sfn build` invocations run
concurrently**. `sfn build` stages the user module's `.sfn-asm` at the
fixed, basename-keyed path `build/native/import-context/<slug>.sfn-asm`
(`capsule_resolver.sfn::_cr_import_context_root`). Two builds whose source
files share a basename — and every test that copies its fixture to
`<tmp>/probe.sfn` does — then **overwrite each other's staged IR**,
producing a cross-contaminated binary (classic symptom: one fixture's
binary emitting another's output). It is non-deterministic and shows up
only under the pool, never in a single-file run.

The fix is mandatory and simple: give every nested build its **own
`--work-dir`** under the test's `with_tmp_dir` scratch, which relocates
the staging per build:

```sfn
let workdir = dir + "/wd";
let exit = process.run_capture(
    [_sfn_bin(), "build", "--work-dir", workdir, "-o", binpath, srcpath], []);
```

`SAILFIN_TEST_SCRATCH` is **not** sufficient — it isolates the `.ll`
scratch (`_cr_scratch_root`) but not the import-context staging. `run` /
bare dispatch has no `--work-dir`, so a bare-dispatch test
(`cli_bare_file_dispatch_test.sfn`) must instead drive a source whose
basename no other test builds and keep its compiling cases sequential
within the one file. The underlying default-path collision (concurrent
same-basename builds without `--work-dir` cross-contaminate) is a
compiler-correctness bug tracked separately; `--work-dir` is the supported
isolation mechanism regardless.

## When bash is still allowed

Only for the named hold-outs in `scripts/e2e_bash_allowlist.txt` that
genuinely cannot be `sfn/test` pre-1.0 (HTTP-server registry mock, tar
archive inspection, docs-sync CI invariants). If you believe a new test
needs bash, add it to the allowlist **with a justification in the PR** so a
reviewer signs off — do not silence the lint without one.

## On pickup of a #842 batch port

Each migrated script: write the `*_test.sfn`, delete the `.sh`, and remove
its line from `scripts/e2e_bash_allowlist.txt` (the lint warns on stale
entries). Drop the Makefile `find -name 'test_*.sh'` branch only when the
directory is empty of non-hold-out scripts.
