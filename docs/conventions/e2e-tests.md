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
import { sfn_bin_path } from "sfn/test";

test "guillermo: command exits 0" ![io] {
    let exit = process.run_capture([sfn_bin_path(), "guillermo"], []);
    let _ = process.capture_take_stdout();
    let _ = process.capture_take_stderr();
    assert exit == 0;
}

test "guillermo: output contains the mascot greeting" ![io] {
    let _exit = process.run_capture([sfn_bin_path(), "guillermo"], []);
    let out = process.capture_take_stdout();
    let err = process.capture_take_stderr();
    assert find(out + err, "Guillermo", 0) >= 0;
}
```

`sfn_bin_path() -> string ![io]` (`sfn/test`, `sfn_bin.sfn`) is the single,
host-conditioned resolver for the compiler-under-test: `$SAILFIN_BIN` wins
verbatim when set, else `build/bin/sfn` on POSIX or `build/bin/sfn.exe` on a
Windows host — a payoff a hand-copied POSIX literal never had. A test must
**not** define its own binary-path helper; SFN-977 deleted 317 hand-copied
`_sfn_bin()` twins in favor of this one shared import.

`sfn_bin_abs_path() -> string ![io]` (`sfn/test`, `sfn_bin.sfn`, SFN-995) is
the same idea for a test that spawns the compiler from a shifted `cwd` (a
scratch repo, a nested `sfn` invocation): `sfn_bin_path()` absolutized
against the cwd via `realpath` when it isn't already absolute. A test must
**not** hand-roll its own `_sfn_bin_abs()` — SFN-995 deleted 15 hand-copied
twins, every one of them a POSIX-only `bin[0] == "/"` absoluteness check
(misclassifying a Windows drive path such as `C:\...` as relative) that
mostly shelled out to `pwd` besides. Use `sfn_bin_abs_path()` outright.

`scratch_root() -> string ![io]` (`sfn/test`, `scratch.sfn`, SFN-978) is the
same shape for a test's own scratch directory: `$SAILFIN_TEST_SCRATCH` wins
verbatim when set, else the host-conditioned `default_scratch_dir()` —
`$TMPDIR`/`/tmp` on POSIX, `%TEMP%`/`%TMP%`/`.` on a Windows host (never a
hardcoded system path such as `C:\Windows\Temp`, which a non-elevated
process frequently cannot write). A test must **not** hand-roll its own
`"/tmp"` fallback — that literal is POSIX-only and unrunnable on a native
Windows host, the exact regrowth `test_scratch_dir_regrowth_guard_test.sfn`
fails the build on. Prefer `scratch_root()` outright; call
`default_scratch_dir()` instead only when the surrounding code already reads
`SAILFIN_TEST_SCRATCH` itself (for example inside the fallback arm of an
existing `if scratch.length == 0 { ... }`), so the env var isn't read twice.

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

## Gating a test that cannot run

Use `skip(reason: string) -> void ![io]` (`sfn/test`,
`capsules/sfn/test/src/skip.sfn`, SFN-815) whenever a test needs to bail out
because a precondition isn't met — no network, a missing tool, an
unsupported platform. It is the **required** way to gate a test; the old
`if !cond { assert true; return; }` idiom is banned.

That old idiom is not a lesser form of skip — it's a silent pass. The body
runs, `assert true` succeeds, and the test is recorded **pass**, so a test
that never actually exercised anything is indistinguishable from one that
did. That gap is exactly what let SFN-807 (the system CA trust store never
loading) survive a full release cycle:
`compiler/tests/e2e/http_redirect_download_test.sfn` gated on a connectivity
probe that, with TLS wholly broken, always returned empty — so the test that
existed to catch the regression reported pass on every single run. It was
dormant, not passing.

```sfn
test "download: follows a cross-host redirect" ![io, net] {
    if !network_available() { skip("no outbound network"); }
    // ...
}
```

What to know before using it:

1. **`skip()` does not return.** The synthesized test harness reports an
   unconditional `pass` the moment a test body returns normally, so a skip
   has to leave the body by unwinding rather than by falling through. Write
   it as an early exit — `if <gate> { skip("reason"); }` — never as
   `skip("reason"); return;`; any statement after the call is unreachable.
2. **A declared skip never affects the exit code.** It does not increment
   the harness failure counter, so a skipped run still exits 0.
3. **Where it's honored**: from a test body, and from `before_each` (where
   it gates the one test that hook is running for). `before_all`,
   `after_each`, and `after_all` have no single test to attribute the skip
   to, so calling it there is reported as a hook failure instead — don't use
   it in those hooks.
4. **How it surfaces**: the test is reported `skip`, not `pass`. Human mode
   prints `[test] SKIP: <name> (<reason>)` per test plus a run-level
   `[test] N skipped` line. `--json` mode emits `"status":"skip"` with a
   `"skip_kind":"declared"` qualifier and the reason on the
   `assertion.message` field.
5. **`skip_kind` distinguishes voluntary from involuntary skips** in the
   `--json` stream: `"declared"` means the body called `skip()`, versus the
   runner-synthesized `"setup_failed"` (the file failed to compile/link),
   `"after_failure"` (an earlier test in the file aborted the process), and
   `"not_run"` (declared but no record produced).

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

**Use `clean_runner_env`, not a hand-rolled allowlist.**

```sfn
import { clean_runner_env, nested_runner_scratch, sfn_bin_path } from "sfn/test";

fn _child_env() -> string[] ![io] {
    return clean_runner_env(nested_runner_scratch("my-label"));
}
// ...
let exit = process.run_capture(
    [sfn_bin_path(), "build", "-o", binpath, srcpath], _child_env());
```

`clean_runner_env` *filters* `process.environ()` — it strips the pool-managed
and caller-override keys and re-points `SAILFIN_TEST_SCRATCH`, passing
everything else through. That is the difference that matters: an allowlist can
only carry the variables whoever wrote it thought of, and a toolchain needs
variables that are not obvious.

The concrete case (SFN-1115): on a native Windows host `clang` locates the
MSVC toolchain by reading
`%ProgramData%\Microsoft\VisualStudio\Packages\_Instances\<id>\state.json`. A
`PATH`/`HOME`/`TMPDIR` allowlist omits `ProgramData`, so the child gets no
MSVC headers and no import libraries — the nested build dies at the link with
`lld-link: error: could not open 'libcmt.lib'`, which the driver then reports
as an internal compiler error. Measured: `ProgramData` alone is necessary and
sufficient; `SystemRoot` does nothing for discovery.

An allowlist would have to grow that entry, and the next one nobody has hit
yet. A filter never needed it. **Do not hand-roll the array below** — it is
recorded only so the shape is recognisable when you meet it in an older test:

```sfn
// Legacy shape. Do not copy — see SFN-1115.
fn _child_env() -> string[] ![io] {
    let mut e: string[] = [];
    let path = env.get("PATH");
    if path.length > 0 { e.push("PATH=" + path); }
    // ... HOME, TMPDIR, SAILFIN_TEST_SCRATCH
    return e;
}
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
`SAILFIN_TEST_RUNTIME_OBJDIR` / `_STAMP`, `SAILFIN_UPDATE_SNAPSHOTS`,
`SAILFIN_TEST_FRAME_TIMING`), and
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
`clean_runner_env`. Do not use such a minimal env for an external C compiler:
it silently drops Darwin SDK/toolchain inputs. The optional C-oracle contract
below owns that distinct case.

## Driving shells and external tools from a `*_test.sfn`

There is no separate "bash is allowed" carve-out — an `![io]` test can do
everything the old hold-out scripts did by spawning the tool via
`process.run_capture`. Established patterns (all in-tree as of the #840
migration):

- **External tools** (`tar`, `jq`, `sha256sum`, `ln`):
  call them as the subprocess argv and parse the captured stdout with
  `sfn/strings` — e.g. `sfn_package_test.sfn` shells `tar -tzf` / `jq -r`.
  Guard with the shared
  `tool_present(tool)` / `first_present_tool(candidates)` helpers exported
  from `sfn/test` (`capsules/sfn/test/src/tool_probe.sfn`, SFN-840) and call
  `skip("<tool> not on PATH")` when the tool is absent, rather than
  hand-rolling a `--version` probe:

  ```sfn
  if !tool_present("jq") { skip("jq not on PATH"); }
  ```

  See "Gating a test that cannot run" above for why `skip()`, not
  `assert true`, is the required form. `tool_present` is a faithful
  `command -v`: it
  reports true once the binary resolves on `PATH` and executes — including
  a tool that runs but rejects `--version` — so a hand-rolled `exit == 0`
  check is *stricter* than `command -v` and silently skips coverage on
  such a host; don't write one. `first_present_tool(["timeout",
  "gtimeout"])` is the "whichever of these exists" shape, for coreutils on
  Linux vs. Homebrew's `g`-prefixed spelling on macOS.
- **Shell shims** (fake `curl`/`uname` on `PATH`): write the shim with
  `fs.writeFile`, `chmod +x` it via `run_capture(["chmod","+x",path], env)`,
  then prepend its dir to the child's `PATH` entry — see `publish_test.sfn`
  (curl shim) and `clock_monotonic_id_sentinel_test.sfn` (uname shim).
- **Optional external C test oracles** (C harnesses, differential LLVM
  comparisons, ASAN relinks): import `run_external_c_oracle` from `sfn/test`,
  write the `.c`, call the helper with compiler arguments only, then consume
  `process.capture_take_*` and run the binary. The helper resolves
  `SAILFIN_TEST_C_COMPILER` when explicitly configured; otherwise it selects
  Apple clang through `/usr/bin/xcrun` on Darwin and `clang` on other hosts.
  It passes the complete parent environment and materializes `SDKROOT` from
  the active Apple toolchain when needed, so Homebrew LLVM earlier on `PATH`
  cannot hide the macOS SDK. An absent or deterministically poisoned compiler
  is an explicit `skip`. A compile/link failure after successful resolution is
  returned to the caller: required harness legs fail it, while explicitly
  best-effort capability legs such as sanitizer and cross-target probes may
  skip it. This boundary is a test oracle only: it does not own or participate
  in Sailfin's production Assemble or Link roles, foreign `c-sources`,
  bootstrap, packaging, or released-asset paths. The source ratchet in
  `no_shell_tool_probe_test.sfn` rejects new direct `clang`, `gcc`, or `cc`
  subprocesses in E2E tests.
- **`cwd` control**: use the native cwd argument — `process.run_capture_cwd(argv,
  env, cwd)` (or `os::run_capture(args, env, cwd)` / the `sfn/test` fixture
  `with_cwd(args, env, cwd, body)` that wraps it), not a spawned shell.
  `os::run_bounded(argv, env, cwd, deadline_ms)` (see "Bounding and scoping
  child processes" below) takes the cwd directly when the child also needs a
  wall-clock bound. The legacy `bash -c "cd <dir> && ..."` vehicle predates
  `run_capture_cwd`/#1167 and is retained only where it already existed (e.g.
  `sfn_package_test.sfn`) — **new tests must not copy it.**
- **RLIMIT_AS control**: use `process.run_capture_rlimit_as(argv, env, bytes)`
  (SFN-45) — see `mem_limit_selfcap_test.sfn`. This retired the caller-side
  `bash -c "ulimit -v N; exec ..."` vehicle for the address-space cap.
  **One gap remains**: RLIMIT_FSIZE has no native form, so a test that needs
  to bound a child's max file size still shells `bash -c "ulimit -f N; ..."`
  — see `append_file_short_write_test.sfn`.

Two native gaps are now closed (cwd, RLIMIT_AS); the one still open is
RLIMIT_FSIZE, above. Arbitrary-signal delivery (e.g. SIGTERM rather than
SIGKILL) also has no native form — see the next section.

### Inline `sh -c` is the same violation as a `.sh` file

`.claude/rules/no-bash-e2e.md` bans a **dependency on a POSIX shell**, not
a file extension. Moving the pipeline out of a banned
`compiler/tests/e2e/*.sh` and into a Sailfin string literal —
`process.run(["sh", "-c", "<pipeline>"])` — does not satisfy the rule: a
native Windows host has no `sh`, so an inline `sh -c` fails there exactly
as the `.sh` file it replaced would have. Everything that spawns a shell
falls into one of three categories, and only one of them is the
violation:

- **WORKAROUND-INLINE (banned)**: spawning a shell to do work the
  stdlib/runtime should do directly — a `PATH` lookup, a `find | grep -q`
  existence check, `ls -a | grep -q`, a `sha256sum || shasum | cut`
  pipeline, a shell `for` loop driving `clang`. If you're reaching for
  `sh -c`, the question to ask is "which primitive am I missing" — then
  either use it (several are listed in the bullets above and below) or
  file the capability gap. Don't launder the bash into a string literal.
- **SANCTIONED-SHIM (fine)**: the shell script *is* the test fixture or
  the subject under test. Two shapes qualify: a fake `curl`/`uname`/seed
  stub that the test itself writes and puts on the child's `PATH`,
  because the shim is the thing under test — see "Shell shims" above
  (`publish_test.sfn`, `clock_monotonic_id_sentinel_test.sfn`) — and a
  thin `.sfn` wrapper whose whole job is to drive a checked-in
  `scripts/*.sh` that is itself the subject under test, e.g.
  `perf_history_compare_test.sfn` covering `scripts/perf_history.sh` or
  `aarch64_seed_mode_test.sfn` covering the release-verify scripts. These
  are regression coverage for the shim or the script, not a rule
  violation, and go obsolete only when the shim or script they cover
  does.
- **The discriminator**, in one line: is the shell doing work a Sailfin
  primitive should do (banned), or is the shell script itself the thing
  being tested or faked (fine)?

## Bounding and scoping child processes

Process-lifetime control over a child now splits across two capsules, and the
split is deliberate rather than historical: `sfn/os` owns process
*mechanics* — spawning, a wall-clock deadline, stdout/stderr demux via
`io.poll_any`, kill-on-expiry, the single reap — and `sfn/test`
(`process_control.sfn`, SFEP-0010 §3.2) owns test *structure* built on top of
it: a scoped fixture whose distinguishing guarantee is that teardown happens
even when the test body throws, plus readiness polling. `sfn/test`
deliberately does not wrap `sfn/os`'s bounded-run functions — a second
`run_bounded` in a second capsule would be an ambiguity at every call site
importing both. A test using anything below declares `![clock, io]` (the
deadline/polling paths read `monotonic_millis()`/`sleep()`, both `![clock]`).

- **Bound a child in wall-clock time**: `os::run_bounded(argv, env: Env, cwd,
  deadline_ms) -> ProcessDrain` runs the child to completion, draining both
  streams via `os::drain_to_exit`, and kills + reaps it on expiry. This
  replaces the `timeout <secs> ...` argv vehicle outright — no
  `command -v timeout`/`gtimeout` probe, and **no skip-when-absent branch**;
  the old probe silently disabled coverage on any host without coreutils.
  `env` is the typed `os::Env` (`os::env_from_current()`/`os::env_empty()`
  build one), not a flat `string[]`; a `run_bounded` call still needs to
  supply the child's environment explicitly the same way `process.run_capture`
  does — see "Build-and-run tests must isolate the build" above for what a
  nested compiler child needs. `sfn/test` does not wrap `run_bounded` — call
  it directly from `sfn/os`.
- **The child's stdin is closed** by `os::run_bounded`/`os::drain_to_exit`/
  `sfn/test`'s `start_background`, giving it `< /dev/null` semantics. The
  spawn always creates a stdin pipe, so without that close a child which
  reads stdin (`sort`, `cat`, anything not on a tty) would block on a pipe
  that never reaches EOF — a permanent hang when `deadline_ms <= 0`. There is
  no bounded-run helper that also pipes input; a caller needing both a
  deadline and stdin input composes `os::spawn_with_env` +
  `os::handle_write` (before draining) + `os::drain_to_exit` directly, and
  owns the same pipe-buffer (64 KiB on Linux) and SIGPIPE-on-early-exit
  hazards that shape used to warn about.
- **`os::run_bounded` returns exit `127` on spawn failure**, mirroring
  `process.run`'s missing-command code, without ever calling
  `drain_to_exit` — there was no child to reap.
- **`timed_out` is the deadline discriminator — never exit code `137`.** A
  SIGKILLed child's exit is `128 + 9 = 137`, indistinguishable by exit code
  alone from a kernel OOM kill. `ProcessDrain.timed_out` (`sfn/os`) is the
  boolean that actually says "the deadline fired"; `sfn/test`'s
  `describe_outcome(outcome)` renders a one-line diagnostic that keeps the
  two apart.
- **Scope a blocking server's lifetime**: `sfn/test`'s `with_background(argv,
  env: Env, cwd, label, body)` starts the child (via `os::spawn_with_env`,
  wrapped in a `Background { handle: ProcessHandle, label }`), runs `body`
  against the live `Background`, and kills + reaps on scope exit — including
  when `body` throws. A test can no longer orphan a server by returning
  early or failing an assertion, and no longer needs the `timeout`-vehicle's
  wall-clock backstop as its only teardown. Use the unscoped
  `start_background`/`stop_background` pair only when the scoped form's
  structure doesn't fit.
- **Exactly one `stop_background` per `start_background`.** The reap frees
  the handle, and `Background` is a plain copyable struct — a second stop is
  a use-after-free plus a double-free. In particular, never call it from
  inside a `with_background` body; that fixture already stops the child on
  scope exit.
- **Poll for readiness**: `sfn/test`'s `wait_until(probe, deadline_ms,
  interval_ms)` polls a `fn () -> boolean` probe against a wall-clock budget
  using the prelude's in-process `sleep(ms)`. This replaces a hand-rolled
  retry loop that shelled `process.run(["sleep", "0.5"])` between attempts —
  a fork+exec per poll tick — with an in-process wait.

What still needs a shell after this: **arbitrary signal delivery** (SIGTERM,
SIGHUP, etc.) — `process.handle_kill`/`os::handle_kill` is SIGKILL-only, so a
test that needs a graceful-shutdown signal still shells out to `kill -TERM` —
and **RLIMIT_FSIZE** (above). Do not overclaim beyond these two.
