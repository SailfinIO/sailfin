# Writing e2e tests

E2E tests are Sailfin `*_test.sfn` files driven by the `sfn/test` capsule —
never bash scripts. The hard constraint and the two traps that bite most often
are in `.claude/rules/no-bash-e2e.md`; this is the full pattern reference.

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
    return "build/bin/sfn";
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
- **Per-child env / cwd:** pass `["KEY=value", ...]` as the `run_capture`
  env argument, and a cwd path as its third argument (`""` inherits). The
  `with_env(args, env, body)` (#1166) and `with_cwd(args, env, cwd, body)`
  (#1168) fixtures in `sfn/test` wrap this per-child shape. There is **no**
  process-global `setenv`/`chdir` fixture (process-global mutation is unsound
  under the future parallel runner — see `fixtures.sfn`); always scope env
  and cwd to the child you spawn.
- **Build a binary to run it:** when a test must compile a fixture to an
  executable (not just frontend-check it), thread `SAILFIN_TEST_SCRATCH`
  through to the spawned compiler so its staging stays per-invocation —
  **mandatory** under the parallel pool. See the dedicated section below
  for the why.

## Build-and-run tests must isolate the build

A test that spawns a full `sfn build` (compile a fixture to a binary and
execute it — e.g. `sailfin_main_entry_test.sfn`,
`sailfin_main_panic_test.sfn`) or uses bare dispatch / `sfn run` to
compile+run a file (`cli_bare_file_dispatch_test.sfn`) runs inside the
parallel `int-e2e-caps` pool (`sailfin test --jobs N`), so **multiple
compiles run concurrently**. A compile writes the top-level module's IR
to `<cache-dir>/program.ll`, where `<cache-dir>` defaults to the fixed
`build/sailfin` (`cli_main.sfn::_resolve_sailfin_cache_dir_for_work`).
Two builds of different sources then **overwrite each other's
`build/sailfin/program.ll`**, producing a cross-contaminated binary
(classic symptom: one fixture's binary emitting another's output). It is
non-deterministic and shows up only under the pool.

`run_capture`'s empty `env` array is the *empty* environment (**not**
"inherit"), so a build-spawning test must thread the variables the nested
compile needs explicitly — most importantly **`PATH`**: the nested build
runs `clang` and its linker (`mold`/`lld`/`ld`), and with no `PATH` the
linker is not found (`clang: error: ... "ld" doesn't exist`) and the build
fails. Also thread `SAILFIN_TEST_SCRATCH`: the compiler routes the
`program.ll` build-cache dir under it (#1333), so a parallel run
(`--jobs N>1`) does not collide on the fixed `build/sailfin`.

```sfn
fn _child_env() -> string[] ![io] {
    let mut e: string[] = [];
    let path = env.get("PATH");
    if path.length > 0 { e.push("PATH=" + path); }
    let home = env.get("HOME");
    if home.length > 0 { e.push("HOME=" + home); }
    let tmpdir = env.get("TMPDIR");
    if tmpdir.length > 0 { e.push("TMPDIR=" + tmpdir); }
    let scratch = env.get("SAILFIN_TEST_SCRATCH");
    if scratch.length > 0 { e.push("SAILFIN_TEST_SCRATCH=" + scratch); }
    return e;
}
// ...
let exit = process.run_capture(
    [_sfn_bin(), "build", "-o", binpath, srcpath], _child_env());
```

This works for `sfn build`, `sfn run`, and bare dispatch alike (it is the
only lever for the latter two, which have no `--work-dir`). For a caller
*outside* the test runner (no `SAILFIN_TEST_SCRATCH`), `sfn build
--work-dir <dir>` is the equivalent explicit per-invocation isolation.

### A nested `sfn test`/`build`/`run` must not thread raw `process.environ()`

An e2e that spawns a **nested full runner** — `sfn test`, `sfn build`, or
`sfn run` as a subprocess of a test that is itself running under `sailfin
test` — must not build that child's env from a raw `process.environ()`
inheritance. `process.environ()` carries the *parent* pool's per-child
orchestration keys (`SAILFIN_TEST_SCRATCH`, `SAILFIN_TEST_JSON_SUBFRAME`,
`SAILFIN_TEST_RUNTIME_OBJDIR` / `_STAMP`, `SAILFIN_UPDATE_SNAPSHOTS`), and
leaking any of them into the nested runner binds it to the parent's private
state: the nested run adopts the parent's `SAILFIN_TEST_SCRATCH` and
clobbers its harness-IPC files, emits as a JSON subframe under
`SAILFIN_TEST_JSON_SUBFRAME` (routing its `summary` off stdout), or binds
the nested build to the parent's shared runtime object cache/stamp nonce.
These symptoms are **pool-only** — they evade a local serial run, so a raw
`process.environ()` leak in this position can sit undetected until CI runs
the file under `--jobs N>1` (SFN-401, PR #2411).

Use the shared `sfn/test` helpers instead of hand-rolling this:

```sfn
import { clean_runner_env, nested_runner_scratch } from "sfn/test";
// ...
let exit = process.run_capture(argv, clean_runner_env(nested_runner_scratch("<label>")));
```

`nested_runner_scratch(label)` mints an isolated per-invocation scratch dir
(a subdir of the outer `SAILFIN_TEST_SCRATCH` when present, else a fresh
temp dir), and `clean_runner_env(nested_scratch)` returns
`process.environ()` with the pool-managed keys stripped and
`SAILFIN_TEST_SCRATCH` re-pointed at `nested_scratch`. The stripped key set
in `fixtures.sfn::_pool_managed_keys()` **must mirror** `_pool_child_env` in
`compiler/src/cli/commands/test/pool.sfn` — a capsule cannot import
compiler-internal modules, so it is a deliberate paired copy; if a new pool
key is ever added there, add it to `_pool_managed_keys()` too. A caller that
needs one otherwise-managed key back (e.g. a nested build binding its own
`SAILFIN_TEST_RUNTIME_OBJDIR`, or a test threading a one-off trace flag)
pushes it onto the returned array after the call.

This is orthogonal to the hand-built minimal envs above (`PATH`/`HOME`/
`TMPDIR` + a few explicit keys) — those never call raw `process.environ()`
in the first place, so they carry no pool-key leak and don't need
`clean_runner_env`.

## Driving shells and external tools from a `*_test.sfn`

There is no separate "bash is allowed" carve-out — an `![io]` test can do
everything the old hold-out scripts did by spawning the tool via
`process.run_capture`. Established patterns (all in-tree as of the #840
migration):

- **External tools** (`tar`, `jq`, `sha256sum`, `readlink`, `ln`, `clang`):
  call them as the subprocess argv and parse the captured stdout with
  `sfn/strings` — e.g. `sfn_package_test.sfn` shells `tar -tzf` / `jq -r`,
  `llms_txt_sync_test.sfn` shells `readlink -f`. Guard with a `--version`
  probe and *skip* (`assert true`) when the tool is absent, mirroring the
  old `command -v` SKIP.
- **Shell shims** (fake `curl`/`uname` on `PATH`): write the shim with
  `fs.writeFile`, `chmod +x` it via `run_capture(["chmod","+x",path], env)`,
  then prepend its dir to the child's `PATH` entry — see `publish_test.sfn`
  (curl shim) and `clock_monotonic_id_sentinel_test.sfn` (uname shim).
- **C harnesses** (link against emitted `.ll`, fork/pthread, ASAN):
  `fs.writeFile` the `.c`, `run_capture(["clang", ...])`, run the binary —
  see `runtime_memory_arena_test.sfn` and `escape_promotion_channel_send_test.sfn`.
- **`cwd` control**: use the native cwd argument — `process.run_capture_cwd(argv,
  env, cwd)` (or `os::run_capture(args, env, cwd)` / the `sfn/test` fixture
  `with_cwd(args, env, cwd, body)` that wraps it), not a spawned shell.
  `run_bounded_in(argv, env, cwd, deadline_ms)` from `sfn/test` (see
  "Bounding and scoping child processes" below) is the deadline-aware sibling
  when the child also needs a wall-clock bound. The legacy `bash -c "cd <dir>
  && ..."` vehicle predates `run_capture_cwd`/#1167 and is retained only where
  it already existed (e.g. `sfn_package_test.sfn`) — **new tests must not
  copy it.**
- **RLIMIT_AS control**: use `process.run_capture_rlimit_as(argv, env, bytes)`
  (SFN-45) — see `mem_limit_selfcap_test.sfn`. This retired the caller-side
  `bash -c "ulimit -v N; exec ..."` vehicle for the address-space cap.
  **One gap remains**: RLIMIT_FSIZE has no native form, so a test that needs
  to bound a child's max file size still shells `bash -c "ulimit -f N; ..."`
  — see `append_file_short_write_test.sfn`.

Two native gaps are now closed (cwd, RLIMIT_AS); the one still open is
RLIMIT_FSIZE, above. Arbitrary-signal delivery (e.g. SIGTERM rather than
SIGKILL) also has no native form — see the next section.

## Bounding and scoping child processes

`sfn/test`'s `process_control.sfn` (SFEP-0010 §3.2) gives a test control over
a child's *lifetime*, closing the two remaining reasons a test used to reach
for a shell: bounding a blocking child in time, and tearing one down on
demand. A test using any of these declares `![clock, io]` (the deadline path
reads `monotonic_millis()`/`sleep()`, both `![clock]`).

- **Bound a child in wall-clock time**: `run_bounded(argv, env, deadline_ms)`
  (plus `run_bounded_in` for a cwd and `run_bounded_stdin` to pipe input) runs
  the child to completion, draining both streams, and kills + reaps it on
  expiry. This replaces the `timeout <secs> ...` argv vehicle outright — no
  `command -v timeout`/`gtimeout` probe, and **no skip-when-absent branch**;
  the old probe silently disabled coverage on any host without coreutils.
  `run_bounded`'s `env` array has the same empty-means-empty contract as
  `process.run_capture` — see "Build-and-run tests must isolate the build"
  above for what a nested compiler child needs.
- **The child's stdin is closed** by `run_bounded`/`run_bounded_in`/
  `start_background`, giving it `< /dev/null` semantics. The spawn always
  creates a stdin pipe, so without that close a child which reads stdin
  (`sort`, `cat`, anything not on a tty) would block on a pipe that never
  reaches EOF — a permanent hang when `deadline_ms <= 0`.
- **`run_bounded_stdin` has two limits the caller must respect**, because the
  write happens before the deadline clock starts and neither can be enforced
  from inside. `input` must fit the pipe buffer (64 KiB on Linux) unless the
  child drains promptly — feed anything larger through a file. And if the
  child exits without reading, the write raises SIGPIPE, which the runtime
  does not ignore, so it kills the **test process** with exit 141. Pass
  `input` only to a child known to read it.
- **Exactly one `stop_background` per `start_background`.** The reap frees the
  handle, and `Background` is a plain copyable struct — a second stop is a
  use-after-free plus a double-free. In particular, never call it from inside
  a `with_background` body; that fixture already stops the child on scope exit.
- **`timed_out` is the deadline discriminator — never exit code `137`.** A
  SIGKILLed child's exit is `128 + 9 = 137`, indistinguishable by exit code
  alone from a kernel OOM kill. `ChildOutcome.timed_out` is the boolean that
  actually says "the deadline fired"; `describe_outcome(outcome)` renders a
  one-line diagnostic that keeps the two apart.
- **Scope a blocking server's lifetime**: `with_background(argv, env, cwd,
  label, body)` starts the child, runs `body` against the live `Background`,
  and kills + reaps on scope exit — including when `body` throws. A test can
  no longer orphan a server by returning early or failing an assertion, and
  no longer needs the `timeout`-vehicle's wall-clock backstop as its only
  teardown. Use the unscoped `start_background`/`stop_background` pair only
  when the scoped form's structure doesn't fit.
- **Poll for readiness**: `wait_until(probe, deadline_ms, interval_ms)` polls
  a `fn () -> boolean` probe against a wall-clock budget using the prelude's
  in-process `sleep(ms)`. This replaces a hand-rolled retry loop that shelled
  `process.run(["sleep", "0.5"])` between attempts — a fork+exec per poll
  tick — with an in-process wait.

What still needs a shell after this: **arbitrary signal delivery** (SIGTERM,
SIGHUP, etc.) — `process.handle_kill` is SIGKILL-only, so a test that needs a
graceful-shutdown signal still shells out to `kill -TERM` — and **RLIMIT_FSIZE**
(above). Do not overclaim beyond these two.
