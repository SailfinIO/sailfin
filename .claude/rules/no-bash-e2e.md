End-to-end tests are written in Sailfin (`*_test.sfn`) using the
`sfn/test` capsule — **never** as bash scripts. The
`compiler/tests/e2e/*.sh` surface grew 38 → 122 because dropping a new
`.sh` in that directory "just works"; that era is **closed** (test-infra
Phase 3, epic #842 / #840 — complete). Every legacy `test_*.sh` was
migrated to a `*_test.sfn` peer and deleted, and the machinery that ran
them is gone: there is no `compiler/tests/e2e/*.sh` surface, no
`make test-e2e-sh` target, no `e2e-sh-*` CI shards, and no allowlist or
ratchet lint. **Do not add a new `compiler/tests/e2e/*.sh` script** —
there is no allowlist that would make one acceptable. Everything the old
hold-outs needed bash for (HTTP/registry mock via a PATH-injected `curl`
shim, tar/jq archive inspection, `ulimit`/`cwd` control) is reachable from
an `![io]` `*_test.sfn` that drives the subprocess — see "Driving shells
and external tools" below.

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
`compiler/src/cli/commands/test.sfn` — a capsule cannot import
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
- **`cwd` / `ulimit` control** (`run_capture` cannot `chdir` or set an
  rlimit): use a `bash -c "cd <dir> && ..."` / `bash -c "ulimit -v N; exec ..."`
  vehicle as the spawned argv — see `sfn_package_test.sfn` (cd into the
  fixture) and `mem_limit_selfcap_test.sfn` (inherited-cap leg). When you
  build paths for a `cd` vehicle, make them **absolute** (the runner-managed
  `SAILFIN_TEST_SCRATCH` can be the relative `build/sailfin/...`, which a
  post-`cd` relative `--out` would resolve against the wrong directory).
  Native `process` rlimit/`read_link` helpers that would retire the
  `bash -c` / `readlink` subprocess sidesteps are tracked as follow-ups.
