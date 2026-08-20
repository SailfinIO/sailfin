# SFN-974 — an atomic exclusive-create filesystem primitive

Single-issue implementation design gate. **Design only — no compiler code
written.** Not an SFEP: this adds one runtime primitive and migrates one
consumer, which `.claude/rules/proposals.md` puts below the SFEP bar. If the
follow-up in §6.2 grows into a general portable-staging redesign, that one may
warrant an SFEP.

Issue: `SFN-974` — "no atomic exclusive-create primitive exists, so nothing can
claim a unique path on a Windows host".

**Could not verify:** the Linear issue body and its measurement comment. No
`mcp__Linear__*` tool was reachable from this session (`get_issue`,
`list_issues`, `list_projects` all resolved to "No such tool available"). Every
statement below attributed to the issue comes from the task brief, not from
Linear directly. The maintainer's measurement — that two concurrent `sfn run`
invocations in one directory collide on the same stem **every time** on Linux —
is taken as given and is consistent with the code read in §1.

---

## 0. Executive summary — three places the issue's framing is wrong

Stated up front because two of them change the delivery shape.

1. **This is not a Windows bug.** It is a live, every-time, all-platform data
   loss: under a shared stem the first `sfn run` to finish deletes the
   executable the second is about to `process.run`
   (`compiler/src/cli/commands/run.sfn:318`). The Windows link failure is a
   second-order symptom. Title and priority should follow the POSIX bug.

2. **"Multiple consumers, so it lands standalone" is not supported by the
   tree.** A census (§6.1) finds exactly **one** check-then-act path-mint site
   in the whole compiler: `_unique_run_stem`. Everything else already mints
   atomically through `fs.mkdtemp` or libc `mkstemp`. Under
   `.claude/rules/seed-dependency.md` the default therefore applies:
   **bundle the primitive with its single consumer in one PR.** Splitting here
   would manufacture a release cycle for nothing.

3. **"No seed cut" is the right conclusion, but not for the reason given.**
   The issue's reasoning ("only `extern fn` plus Sailfin") is incomplete — it
   misses that this change edits `target_condition_runtime_sfn_sources`, which
   *is* compiler source baked into the seed. The claim still holds, for the
   two specific reasons in §4. It stops holding the day a native Windows seed
   is released.

One more finding that is not a framing error but matters for §6.2: the comment
justifying `_mktemp_from_template_cmd`'s Windows degrade —
`compiler/src/build/fs.sfn:130`, *"A Windows host has no POSIX `mkstemp`"* — is
**stale**. It landed 2026-07-25 (`d70ea4e4`, #2629);
`runtime/sfn/platform/mkstemp_windows.sfn` landed 2026-07-30 (`620f31be`,
#2723) and supplies that exact symbol on a Windows target. The degrade is still
*defensible* (MSDN caps `_mktemp_s` at 26 unique names per template per
process — recorded at `runtime/sfn/platform/mkdtemp_windows.sfn:23-25`) but the
stated reason is no longer true.

---

## 1. Current state

### 1.1 The racing mint

`compiler/src/cli/commands/run.sfn:100-111`:

```
fn _unique_run_stem(run_cache_dir: string) -> string ![clock, io] {
    let base = run_cache_dir + "/run-" + int_to_string(monotonic_millis());
    let mut candidate = base;
    let mut attempt = 1;
    loop {
        if !fs.exists(target_exe_name(candidate, build_target_os())) && !fs.exists(candidate
            + ".ll") { return candidate; }
        if attempt > 1000 { return candidate; }
        candidate = base + "-" + int_to_string(attempt);
        attempt += 1;
    }
}
```

The header at `run.sfn:78-99` already documents the hole verbatim: *"the
`fs.exists` probe only rules out a STALE name still on disk from an earlier
invocation — it is NOT an atomic claim"*, and names SFN-974 as the fix. It also
names both alternatives it rejected: `sfn_fs_mkdir` discards `mkdir`'s return,
and `_mktemp_from_template_cmd` returns `""` on Windows.

Call site, `run.sfn:206-210`:

```
let run_exe_unguarded = env.get("SAILFIN_TEST_SCRATCH").length == 0;
let mut run_stem = run_cache_dir + "/run";
if run_exe_unguarded { run_stem = _unique_run_stem(run_cache_dir); }
let exe_path = target_exe_name(run_stem, build_target_os());
let ll_path = run_stem + ".ll";
```

### 1.2 The consequence the issue did not anticipate

`run.sfn:318` and `run.sfn:324`:

```
if run_exe_unguarded && fs.exists(exe_path) { fs.deleteFile(exe_path); }
...
if run_exe_unguarded && fs.exists(ll_path) { fs.deleteFile(ll_path); }
```

The comment above line 318 states the invariant this relies on: *"Delete only
this invocation's own path — never a sweep of the shared directory."* Under a
shared stem that invariant is false. Invocation A finishes `process.run` and
deletes what it believes is its own executable; invocation B is still between
its link and its `process.run` and hits `run.sfn:314`'s
`sfn run: no binary at <path>` with a bare non-zero exit. Both invocations also
write the same `ll_path`, so B can link IR that A clobbered mid-flight — the
exact hazard `run.sfn:194-201` records SFN-1004 as having closed for the
*guarded* branch.

This is consistent with the nightly failure the brief cites at
`compiler/tests/e2e/run_exe_isolation_test.sfn:152` (`assert exit_a == 0;` in
*"run: two overlapping invocations in one directory both succeed"*), on
`68e0cc8e`, run `32395904891`. **Not confirmed** — no log was available to this
session — but the failure mode matches exactly, and that test's own header
(`run_exe_isolation_test.sfn:143-151`) notes the last such failure carried no
diagnostic because both children's stderr was discarded.

### 1.3 The primitives that already exist, and why none of them fits

| Primitive | Where | Atomic? | Why it does not close this |
|---|---|---|---|
| `fs.exists` | builtin | no | check-then-act; this *is* the bug |
| `sfn_fs_mkdir` | `runtime/sfn/adapters/filesystem.sfn:637` | create is, report is not | discards `mkdir`'s return and treats a later existence probe as success (`filesystem.sfn:617-619`) — cannot say "I created it" vs "it was there" |
| `mkstemp` | `compiler/src/build/fs.sfn:36`, POSIX libc + `platform/mkstemp_windows.sfn` | yes | mints a name of *its* choosing from an `XXXXXX` template; cannot claim a caller-chosen name. Gated off on a Windows host at `fs.sfn:130` |
| `fs.mkdtemp` / `sfn_fs_mkdtemp` | `filesystem.sfn`, `platform/mkdtemp_windows.sfn` | yes | mints a **directory** of its own choosing; see §3.5 for why it is not the answer here |
| `sfn_rename_replace` | `runtime/sfn/platform/rename_ops.sfn:37` | yes | replaces unconditionally — the opposite predicate |

So the gap is real and precisely shaped: **claim a caller-chosen path, and
report created-vs-existed-vs-error distinguishably.**

### 1.4 The mechanisms this design must fit into

- **Sibling-module conditioning.** `target_condition_runtime_sfn_sources`
  (`compiler/src/build/target.sfn:451-583`) rewrites the runtime source list
  for a Windows target. It does two different things: **swaps** a POSIX module
  for a `_windows.sfn` sibling (`rlimit`, `terminal`, `rand`, `fs_exec_mode`,
  `fd_io`, `socket_ops`, `rename_ops`, `cert_roots`, and `process`), and
  **appends** siblings that have no POSIX counterpart to swap from
  (`realpath`, `clock`, `pthread`, `popen`, `mkstemp`, `strcasestr`, `opendir`,
  `mkdtemp` — `target.sfn:549-582`).
- **The no-cross-module-extern convention (SFN-635 / SFN-720).** A runtime
  symbol is reached by re-declaring it as a local `extern fn`, never by
  importing it. `compiler/src/build/fs.sfn:62-64` does this for
  `sfn_rename_replace`; `runtime/sfn/adapters/filesystem.sfn:989` does it for
  `_sfn_fs_access_exec_mode`, proving the convention applies *within* the
  runtime too, not only compiler→runtime. `runtime/sfn/platform/errno.sfn:37-53`
  records the underlying cause: the runtime `sfn-source` emit path resolves
  imported *extern* signatures but not imported *defined* functions.
- **Errno from runtime source.** Reachable by inlining the sentinel chain
  `sailfin_intrinsic_pointer_read_i32(sailfin_intrinsic_errno_location())`.
  In-tree, in modules the seed already compiles:
  `runtime/sfn/platform/socket_ops.sfn:154`, `runtime/sfn/process.sfn:621,691`,
  `runtime/sfn/clock.sfn:281`. The locator sentinel lowers per target —
  `__errno_location` / `__error` / `_errno` (`errno.sfn:8-17`).
- **Linux-vs-Darwin divergence inside one shared source.** Resolved by a
  **runtime probe**, not an emit-time split: `_fs_dirent_dname_offset()`
  (`runtime/sfn/adapters/filesystem.sfn:757-761`) probes
  `/proc/self/status` for Linux and falls through to Darwin; `build_host_os()`
  (`compiler/src/build/target.sfn:58-59`) uses the same probe plus
  `/System/Library/CoreServices` for Darwin.
- **Decimal-only integer constants.** Hex literals silently fold to 0 on the
  pinned seed (`runtime/sfn/process.sfn:38`, restated at
  `runtime/sfn/platform/mkstemp_windows.sfn:21-24`). Octal has no literal form
  either — `runtime/sfn/adapters/filesystem.sfn:632` spells `0o777` as `511`.
  Unary `-1` *is* fine in runtime source (`runtime/sfn/string.sfn:324`); the
  `0 - 1` spelling in the `_windows` modules is stylistic, not required.

---

## 2. Constraints

1. **Self-hosting.** Whatever lands must be compilable by seed `0.10.1`
   (`bootstrap.toml [seed].version`) against the working-tree runtime.
2. **One shared POSIX source for Linux and macOS.** No `cfg`; a Darwin module
   swap would be a genuine seed dependency on a macOS host (§4.3).
3. **No new builtin/intrinsic.** A `fs.*` registry row is a compiler-emitted
   sentinel the seed cannot resolve (`E0420`) — the exact carve-out in
   `.claude/rules/seed-dependency.md`, and it would gate this behind a seed
   cut. `compiler/src/build/fs.sfn:13-18` argues this at length for the
   existing externs.
4. **No bash e2e** (`.claude/rules/no-bash-e2e.md`), and any test that spawns
   builds must isolate them and thread `clean_runner_env` /
   `nested_runner_scratch`.
5. **Memory budget.** Any test that fans out concurrent `sfn` children pays
   ~3 GiB/child against the pool's budget (`.claude/rules/compiler-safety.md`);
   the 8 GiB self-cap bounds a process, not a fleet.
6. **A mis-detected platform must fail loudly, never silently.** `open`'s
   `O_CREAT`/`O_EXCL` values differ between Linux and Darwin (§3.2); a wrong
   guess can *truncate a peer's file and report success*. That failure mode is
   unacceptable and the design must make it structurally impossible.

---

## 3. Design

### 3.1 Where it lives — a swapped sibling pair in `runtime/sfn/platform/`

**Decision: a new swapped pair,
`runtime/sfn/platform/exclusive_create.sfn` (POSIX) and
`runtime/sfn/platform/exclusive_create_windows.sfn`, modelled line-for-line on
`rename_ops.sfn` / `rename_ops_windows.sfn`.**

Not `runtime/sfn/adapters/filesystem.sfn`. That module is deliberately *not*
target-conditioned — its header (`filesystem.sfn:86-90`) states that the single
`filesystem.ll` is compiled for Linux, macOS arm64, *and* the Windows cross
target, which is why every platform-divergent operation there routes through a
`sailfin_intrinsic_fs_*` sentinel. Putting this in `filesystem.sfn` therefore
forces either a new sentinel (a compiler capability — seed-blocker, constraint
3) or a divergence that module's whole design excludes.

**Swap, not append.** The existing table encodes a rule worth naming explicitly,
because it decides this correctly on its own:

> **Append when the symbol is libc's. Swap when the symbol is ours.**

The eight appended siblings (`target.sfn:549-562`) all satisfy a *bare libc
symbol* that POSIX supplies for free — `realpath(3)`, `clock_gettime`,
`mkstemp(3)`, `opendir`, `mkdtemp(3)`. There is nothing to swap from because
POSIX has no Sailfin-authored module. The nine swapped modules all define a
*Sailfin-authored* symbol whose body differs per target. `sfn_create_exclusive`
is ours, so it is a swap — the same shape, and for the same reason, as
`sfn_rename_replace`.

**Rejected: folding into `rename_ops.sfn`.** Tempting, because it costs zero
table changes. Rejected: `rename_ops.sfn`'s name and entire header
(`rename_ops.sfn:1-31`) are one operation, and renaming the module to something
broader is itself a table change (the swap matches on basename,
`target.sfn:464`), so the "free" version does not exist. A module named
`rename_ops` containing a create primitive is worse than the table edit.

**Naming.** `sfn_create_exclusive`, matching `sfn_rename_replace` /
`sfn_socket_send` / `sfn_sleep` — the `platform/` family convention — rather
than the `sfn_fs_*` prefix, which in this tree specifically means "adapter
backing a `fs.*` builtin registry row". Promotion to a builtin later needs no
rename: `native_signature` is a free-form symbol string
(`compiler/capsules/codegen-llvm/src/runtime_helpers/registry_services.sfn:44`).

### 3.2 The signature and the return contract

```
// runtime/sfn/platform/exclusive_create.sfn
fn sfn_create_exclusive(path: *u8, mode: i32) -> i32 ![io]
```

**Three distinguishable results, and nothing else:**

| Return | Meaning | Caller's obligation |
|---|---|---|
| `0` | **Created.** `path` did not exist; it does now, as a regular file of length 0, and this process is the unique creator. | The caller owns `path` until it deletes it. Nothing is left open. |
| `1` | **Exists.** `path` was already taken (by a file, a directory, or anything else occupying the name). Nothing was created, opened, truncated, or modified. | Pick another name, or treat it as a lost race. Never assume the existing file is yours. |
| `-1` | **Error.** A real filesystem failure: missing parent directory, permission denied, read-only filesystem, name too long, descriptor exhaustion, an unsupported host (§3.4). | Fail loudly. **Do not retry with another name** — the fault is not the name. |

Three properties are load-bearing:

- **No handle is returned.** The primitive closes what it opens. Every consumer
  wants a *name reservation*, not an open file: `_unique_run_stem` hands the
  path to `clang -o`, and `_mktemp_from_template_cmd` already closes its
  descriptor immediately (`compiler/src/build/fs.sfn:147`), noting that
  reopening by path is not a TOCTOU window because the name is already
  exclusively ours. Returning a handle would also force a cross-platform close
  primitive: POSIX `open` yields an `int` fd, Win32 `CreateFileA` yields a
  `HANDLE`, and the UCRT cannot `_close` the latter. Both consumers would then
  immediately discard it. If a future lock-file consumer genuinely needs to
  hold and write the descriptor, that is a *second* function
  (`sfn_open_exclusive`), not a change to this one.
- **`mode` is a POSIX creation mode, ignored on Windows.** Named, not implicit,
  because the two current consumers want different modes and the difference is
  correctness-relevant (§3.6). The Windows leg ignores it for the reason
  `runtime/sfn/platform/fs_exec_mode_windows.sfn:9-13` already gives: Windows
  has no execute permission bit, and `compiler/src/build/fs.sfn:198` records
  that `0o600`/`0o700` are inexpressible there.
- **Errno never crosses the boundary.** The caller gets a classification, not a
  platform error code, so the two legs are interchangeable and no consumer
  grows a `#ifdef`-shaped branch.

**POSIX leg** — `open(path, O_WRONLY|O_CREAT|O_EXCL, mode)`:

```
extern fn open(path: *u8, flags: i32, mode: i32) -> i32;
extern fn close(fd: i32) -> i32;
extern fn access(path: *u8, mode: i32) -> i32;
```

- `open` is variadic in C; the fixed 3-arity extern is ABI-compatible on
  x86-64 SysV and AArch64 AAPCS. `runtime/sfn/platform/rand.sfn:28` already
  declares a **2-arity** `open` for `O_RDONLY`, with the same note. The two
  declarations never share a module and the runtime is compiled to one object
  **per module** (`_compile_runtime_sfn_sources`,
  `compiler/src/build/runtime_objs.sfn:1622`), so each emits its own `declare`
  into its own `.ll`/`.o` and both resolve against libc's single variadic
  symbol at link. *Verify during implementation* that no `llvm-link` step
  merges the two runtime modules into one module; the per-module object plan
  says it does not.
- On `fd >= 0`: `close(fd)`, return `0`.
- On `fd < 0`: read errno via the sentinel chain. `EEXIST` (17 — identical on
  Linux and Darwin) → `1`. `EINTR` (4, as pinned at
  `runtime/sfn/platform/socket_ops.sfn:126`) → retry under a guard counter.
  Anything else → `-1`.

**Windows leg** — `CreateFileA(..., CREATE_NEW, ...)`:

```
extern fn CreateFileA(path: *u8, desired_access: i32, share_mode: i32,
                      security: *u8, creation: i32, flags: i32,
                      template_file: i64) -> i64;
extern fn CloseHandle(handle: i64) -> i32;
extern fn GetLastError() -> i32;
extern fn GetFileAttributesA(path: *u8) -> i32;
```

Constants, decimal per §1.4: `GENERIC_WRITE` 1073741824; share mode
`FILE_SHARE_READ|WRITE|DELETE` = 7; `CREATE_NEW` 1;
`FILE_ATTRIBUTE_NORMAL` 128; `INVALID_HANDLE_VALUE` -1;
`ERROR_ACCESS_DENIED` 5; `ERROR_FILE_EXISTS` 80;
`ERROR_ALREADY_EXISTS` 183; `INVALID_FILE_ATTRIBUTES` -1.

Three Win32 details that are decisions, not transcription:

1. **`CreateFileA`, not `CreateFileW`.** The issue says `CreateFileW`. Every
   Win32 call in this runtime is the ANSI variant — `MoveFileExA`
   (`rename_ops_windows.sfn:70`), `CreateDirectoryA`
   (`mkdtemp_windows.sfn:45`), `CreateProcessA` (`process_windows.sfn:98`),
   `GetFileAttributesA` (`filesystem.sfn:208`), `FindFirstFileA`,
   `CertOpenSystemStoreA`. Sailfin `string` is a NUL-terminated byte buffer;
   the `W` variant would need a UTF-8→UTF-16 conversion this runtime has
   nowhere. Going `W` here alone would be an unpaired deviation and a
   non-UTF-8-path story nothing else in the tree tells. If wide paths are
   wanted, that is a whole-runtime migration, not this issue.
2. **Share mode 7, not 0.** The handle is held for microseconds, but with
   share mode 0 a concurrent peer's `CreateFileA` on the same name fails
   `ERROR_SHARING_VIOLATION` (32) instead of `ERROR_FILE_EXISTS` (80) — a lost
   race misreported as a real error, which under §3.3 aborts the caller instead
   of advancing. Share mode 7 keeps the peer's answer stable.
3. **A post-failure `GetFileAttributesA` probe, and why it is not a TOCTOU
   reintroduction.** `CreateFileA` with `CREATE_NEW` against an existing
   *directory* returns `ERROR_ACCESS_DENIED` (5), not 80/183, where POSIX
   `open(O_CREAT|O_EXCL)` returns `EEXIST`. Left alone the two legs would
   disagree on a real case. So when the create has already failed with
   something other than 80/183, probe `GetFileAttributesA(path)`; a result
   other than `INVALID_FILE_ATTRIBUTES` means the name is occupied → return
   `1`, else `-1`. This is exactly the argument
   `runtime/sfn/platform/rename_ops_windows.sfn:57-61` makes for its own
   unconditional fallback: *"it is only entered where the atomic form already
   returned failure, so it can only turn a failure into a success — it never
   weakens a call that succeeds today."* The atomic decision has already been
   made and lost; the probe only classifies the loss.

### 3.3 The one genuine hazard: `O_CREAT`/`O_EXCL` differ on Linux and Darwin

This is the sharpest technical risk in the change and the issue does not
mention it.

| Flag | Linux | Darwin |
|---|---|---|
| `O_WRONLY` | 1 | 1 |
| `O_CREAT` | 64 (`0100`) | 512 (`0x0200`) |
| `O_EXCL` | 128 (`0200`) | 2048 (`0x0800`) |
| **combined** | **193** | **2561** |

The runtime compiles one shared POSIX source for both targets (constraint 2),
so the flag word cannot be a literal. Worse, a *wrong* word is not inert:

- Linux's 193 interpreted on Darwin is `O_WRONLY|O_ASYNC|O_SYNC` — opens an
  existing file for writing, no create, no exclusivity.
- Darwin's 2561 interpreted on Linux is `O_WRONLY|O_TRUNC|O_NONBLOCK` — opens
  **and truncates** an existing file.

Both would report "created" for a name a peer owns, after destroying it. That
rules out the "issue both encodings and see which succeeds" pattern
`socket_ops.sfn` uses for `SO_RCVTIMEO`: here a wrong encoding *succeeds*.

**Resolution: a memoized two-marker host probe that refuses to guess.**

```
// Resolved once per process. -1 = not yet resolved; 0 = unsupported host.
let mut _excl_open_flags_memo: i32 = -1;

fn _excl_open_flags() -> i32 ![io] {
    if _excl_open_flags_memo != 0 - 1 { return _excl_open_flags_memo; }
    let mut resolved: i32 = 0;
    let linux_marker: string = "/proc/self/status";
    let darwin_marker: string = "/System/Library/CoreServices";
    if access(linux_marker as *u8, 0) == 0 {
        resolved = 193;
    } else if access(darwin_marker as *u8, 0) == 0 {
        resolved = 2561;
    }
    _excl_open_flags_memo = resolved;
    return resolved;
}
```

and `sfn_create_exclusive` returns `-1` immediately when the resolution is `0`.

Why this is sound rather than a guess:

- Both markers are the tree's own established discriminators, used for exactly
  this purpose. `build_host_os()` (`compiler/src/build/target.sfn:58-59`) uses
  the same two, in the same order; `_fs_dirent_dname_offset()`
  (`runtime/sfn/adapters/filesystem.sfn:757-761`) uses the Linux one to pick a
  `struct dirent` offset, where a wrong answer produces garbage filenames.
- **It fails closed, not open.** The existing single-probe form
  (`present ⇒ Linux, absent ⇒ Darwin`) would hand a Linux host with no `/proc`
  the Darwin word, i.e. the truncating one. Requiring a *positive* marker for
  each platform and returning `-1` when neither answers converts that
  environment from silent corruption into a loud, immediate, first-call error.
  This is the reason for the second probe; do not simplify it back to one.
- `access(path, 0)` — `F_OK` is 0 on both POSIX targets, and 0 is also the only
  mode the UCRT accepts (`runtime/sfn/platform/fs_exec_mode_windows.sfn:27`),
  though the POSIX leg never runs on Windows.
- The memo is a benign race: concurrent threads compute and store the same
  value. Same posture as `_mkdtemp_windows_counter`
  (`mkdtemp_windows.sfn:55`) and `_sfn_concat_limit_state`
  (`runtime/sfn/string.sfn:533`).
- One `access(2)` per process, not per call.

The Windows leg has no analogue of this problem: `CREATE_NEW` and the error
codes are stable Win32 constants.

### 3.4 How `compiler/src` reaches it

**Confirmed: a module-local `extern fn` in `compiler/src/build/fs.sfn`, not an
import.** This is the SFN-635 / SFN-720 convention and `fs.sfn:62-64` is the
exact precedent:

```
// Publish-into-place, replacing an existing destination. Defined by
// `runtime/sfn/platform/rename_ops.sfn` and swapped for its Windows
// sibling per target — declared as an extern here rather than imported,
// matching the SFN-635 cross-module workaround the runtime modules use
// (SFN-720). Returns 0 on success, like `rename(2)`.
extern fn sfn_rename_replace(src: *u8, dst: *u8) -> i32;
```

It is also the only route that works: `errno.sfn:37-53` records that the
runtime `sfn-source` emit path resolves imported *extern* signatures but not
imported *defined* functions, so an `import` of `sfn_create_exclusive` fails
lowering with *"callee signature is not known to the compiler"*.

Added to `compiler/src/build/fs.sfn`, beside the `sfn_rename_replace` block:

```
extern fn sfn_create_exclusive(path: *u8, mode: i32) -> i32;

let CREATE_EXCLUSIVE_CREATED: i32 = 0;
let CREATE_EXCLUSIVE_EXISTS: i32 = 1;
let CREATE_EXCLUSIVE_ERROR: i32 = 0 - 1;

// POSIX creation modes. Decimal because Sailfin has no octal literal
// (`runtime/sfn/adapters/filesystem.sfn:632` spells 0o777 as 511):
// 384 = 0o600, 448 = 0o700. Ignored on a Windows target.
let CREATE_EXCLUSIVE_MODE_FILE: i32 = 384;
let CREATE_EXCLUSIVE_MODE_EXE: i32 = 448;

fn _create_exclusive_cmd(path: string, mode: i32) -> i32 ![io] {
    return sfn_create_exclusive(path as *u8, mode);
}
```

Everything stays `i32` so no caller needs a width cast. `path as *u8`, never
`.ptr` — `fs.sfn:20-23` records that `.ptr` typechecks green and lowers to
nothing.

`build/fs.sfn` is the right home: it is already the compiler's filesystem-
primitive module, already declares the whole libc extern block
(`fs.sfn:36-86`), and already owns `_mktemp_from_template_cmd` and
`_atomic_rename_into_place` — the §6.2 follow-up's consumer.

Export `_create_exclusive_cmd` and all five constants from `fs.sfn`'s export
block.

### 3.5 Alternatives considered and rejected

- **`fs.mkdtemp(run_cache_dir + "/run-")`, then use `<dir>/run` as the stem.**
  Ships today, is atomic, has a Windows sibling, and would fix `sfn run` in one
  line. Rejected: it mints a directory of the runtime's choosing, so it cannot
  serve `_mktemp_from_template_cmd` (which needs a *file* to rename onto a
  destination) or any future lock file; it leaves the Windows staging degrade
  in place; and it swaps a leaked file for a leaked directory needing recursive
  cleanup. It is the cheap substitute the brief rules out, and it leaves the
  tree with no general claim primitive.
- **`mkdir(2)` / `CreateDirectoryA` as the claim.** Genuinely attractive:
  atomic everywhere, and — unlike `open` — carries **no platform-divergent
  constants at all**, so §3.3 evaporates. Rejected on the same ground: a
  directory claim serves `sfn run` and nothing else. If `_unique_run_stem` were
  the only consumer forever, this would be the better primitive; it is worth
  re-reading if §6.2 is ever abandoned.
- **`mkstemp` + `link(2)` + `unlink`.** The classic NFS-safe idiom, and also
  free of divergent constants (`EEXIST` is 17 on both targets). Rejected: three
  syscalls instead of one on a build hot path, a leaked temp file if the
  process dies mid-sequence, string construction of a template inside a
  `platform/` module, and a dependency on hardlink support.
- **A `fs.createExclusive` builtin.** The eventual right shape for user-facing
  Sailfin, and reachable later without renaming the symbol (§3.1). Rejected
  now: a registry row is a compiler-emitted sentinel the seed cannot resolve,
  which converts this from a same-day fix into a seed-gated one (constraint 3).
- **A Darwin module swap for the flag word.** Rejected — it is a genuine
  seed-blocker on macOS; see §4.3.
- **Finer-grained time (`tv_nsec`) or a pid in the stem.** Pre-ruled-out by the
  brief, and correctly: both narrow the window without closing it. Note that
  §3.3's design deliberately keeps *entropy* out of the primitive entirely —
  candidate generation is the caller's policy, and correctness comes only from
  the atomic create.

### 3.6 Why the exe claim uses mode `0o700`, not `0o600`

`_unique_run_stem` claims the executable's own path with a zero-byte
placeholder, and `clang -o` later writes the real binary over it. Linkers
differ in how they do that: LLD's `FileOutputBuffer` writes a temp and renames
(the placeholder's mode is discarded), mold unlinks the output first, but GNU
`ld` opens the existing output `O_RDWR|O_TRUNC` and **preserves the existing
mode**. A `0o600` placeholder under GNU `ld` would therefore yield a
non-executable `run-<n>`, and `process.run` would fail.

Claiming with `0o700` makes every linker path produce an executable file, and
costs nothing. The staging consumer in §6.2 keeps `0o600`, matching what
`mkstemp` gives today, so cache artifacts do not become executable. **This is
the entire reason `mode` is a parameter** rather than a fixed constant inside
the primitive.

*Verify during implementation* on the actual configured linker (`mold`/`lld`
auto-detect plus the `SAILFIN_LINKER` override); the e2e test in §7.3 catches a
regression here loudly, because it executes the produced binary.

---

## 4. Seed-dependency analysis — verified, not inherited

The issue asserts no seed cut is needed. **The conclusion is right; the stated
reason is not sufficient.** The brief's specific worry — that the swap table
lives in compiler source while the seed compiles the working-tree runtime — is
the real question, and it resolves benignly for two separate reasons.

### 4.1 The POSIX file is free

`runtime/capsule.toml` is **data the pinned seed reads at build time**
(`toml_get_string_array` via `compiler/src/toml_parser.sfn`; the manifest says
so at `runtime/capsule.toml:31-36`), and `_compile_runtime_sfn_sources`
(`compiler/src/build/runtime_objs.sfn:1622`) compiles whatever it lists. Adding
`"sfn/platform/exclusive_create.sfn"` to `sfn-sources` therefore needs no
compiler change at all.

The seed can compile that file: it uses only `extern fn`, `as *u8` / `as i64`
casts, `i32` arithmetic, a module-level `let mut`, and the two errno sentinels —
every one of which appears in a module the seed already compiles
(`socket_ops.sfn:154`, `process.sfn:621`, `clock.sfn:281`, `string.sfn:533`).

Two selection mechanisms must be respected but need no change:

- **Demand gating (SFN-882).** Do **not** add the module to
  `[sfn-source-gates]`; ungated means always compiled, which is what a
  primitive the compiler itself calls requires.
- **Reachability filtering.** An ungated runtime module whose only reference is
  an `extern fn` in compiler source survives — `rename_ops.sfn` is exactly that
  shape and has shipped since SFN-720.

### 4.2 The swap-table edit is inert everywhere a seed runs

`target_condition_runtime_sfn_sources` short-circuits at
`compiler/src/build/target.sfn:452`:

```
if !target_os_is_windows(target_os) { return sources; }
```

So on every Linux and macOS build — which is every build a seed performs — the
seed's table is never consulted, and the fact that it lacks the new branch is
unobservable.

For the Windows target, `target.sfn:571-580` already records the reasoning
verbatim, added for the `mkdtemp_windows.sfn` append (SFN-993):

> The compiler that emits the Windows leg is always CURRENT-TREE, never the
> pinned seed: there is no released native Windows seed yet
> (`docs/runbooks/windows-native.md`), so this append carries no seed
> dependency … Once a real Windows seed ships, a change to Windows-leg codegen
> itself … acquires a genuine seed dependency and this reasoning stops holding.

That comment covers an *append*; the same argument covers a *swap*, and for the
same reason. **The removal condition is explicit: the day a native Windows seed
is released, re-derive this.** Note it in the new modules' headers.

### 4.3 Where a seed cut *would* have been forced — and how this avoids it

Worth recording, because it was the design's real fork. Resolving the
Linux/Darwin flag divergence by **swapping in a Darwin sibling** would place the
discrimination in `target_condition_runtime_sfn_sources`. On a macOS host the
pinned seed compiles the working-tree runtime with *its own* table, which has no
Darwin branch, and would hand macOS the Linux-flagged module — silent
corruption, not a build error. That is precisely
`.claude/rules/seed-dependency.md`'s carve-out ("a compiler capability that
runtime source *calls* must exist in the **seed**"), and it would have made this
`seed-blocker`, queued behind a cadence seed bump.

§3.3's runtime probe avoids it entirely by keeping the discrimination *inside*
the runtime module, where the seed's table is irrelevant.

### 4.4 Delivery shape — bundle, do not split

`.claude/rules/seed-dependency.md`: bundle a capability with its single consumer
by default; split only for multiple consumers, genuine independence, or large
blast radius. The census in §6.1 finds **one** migrating consumer. There is no
seed gate to cross (§4.1–4.2), so a split would buy nothing and cost a release
cycle.

**One PR:** the two runtime modules, the manifest entry, the swap-table branch,
the `Makefile` `RUNTIME_MODS` entry, the `build/fs.sfn` wrapper, the
`_unique_run_stem` migration, and the tests. No `seed-blocker` label, no
`needs-seed-cut`, no `## Required in pinned seed:` line.

---

## 5. `_unique_run_stem` after the change

The loop's meaning inverts: it stops *probing* and starts *claiming*, so the
budget-exhausted and error paths must now fail rather than return a name the
caller does not own.

```
// SFN-719 / SFN-974: claim a per-invocation exe path so a nested or
// concurrent `sfn run` never targets the same file as another still-running
// one. `monotonic_millis()` seeds the candidate; the claim is what makes it
// unique — `_create_exclusive_cmd` creates the executable's own path
// atomically, so exactly one of two invocations starting in the same
// millisecond can win a given name and the loser advances the ordinal.
//
// Returns an extensionless STEM, not a path, so this invocation's executable
// and its `.ll` cannot disagree about which invocation they belong to
// (SFN-1004). Only the EXE name is claimed: the `.ll` is derived from the
// won stem, so a unique stem makes it unique too.
//
// Returns "" when no name could be claimed. The two ways that happens are
// deliberately not distinguished by the return value — both are fatal to the
// invocation and the caller reports one message.
fn _unique_run_stem(run_cache_dir: string) -> string ![clock, io] {
    let base = run_cache_dir + "/run-" + int_to_string(monotonic_millis());
    let target_os = build_target_os();
    let mut candidate = base;
    let mut attempt: int = 1;
    loop {
        let claim = _create_exclusive_cmd(target_exe_name(candidate, target_os), CREATE_EXCLUSIVE_MODE_EXE);
        if claim == CREATE_EXCLUSIVE_CREATED { return candidate; }
        // A real filesystem fault (unwritable cache dir, missing parent) is
        // not about this name, so advancing the ordinal would just repeat it
        // 1000 times before failing anyway.
        if claim == CREATE_EXCLUSIVE_ERROR { return ""; }
        if attempt > 1000 { return ""; }
        candidate = base + "-" + int_to_string(attempt);
        attempt += 1;
    }
}
```

Deletions this makes mandatory, per `.claude/rules/code-style.md` ("the PR that
satisfies a workaround comment deletes both"):

- The entire residual-race paragraph at `run.sfn:83-93`, including the
  `SFN-974` reference and the `sfn_fs_mkdir` / `_mktemp_from_template_cmd`
  survey. It is the removal condition and it is now satisfied.
- The `.ll` staleness probe (`run.sfn:105-106`). A stale `.ll` with no
  surviving exe is unowned by definition, and the paragraph at `run.sfn:95-99`
  explaining why both names are probed goes with it.
- `build_target_os()` moves out of the loop; today it is an `env`/probe read
  per attempt.

**Caller** (`run.sfn:206-210`) gains a failure branch — new behaviour, because
the old function could not fail:

```
let mut run_stem = run_cache_dir + "/run";
if run_exe_unguarded {
    run_stem = _unique_run_stem(run_cache_dir);
    if run_stem.length == 0 {
        print.err("sfn run: could not claim a unique executable name under " + run_cache_dir);
        return 1;
    }
}
```

**Releasing the claim.** The claim now exists from before the compile until
cleanup, so every exit path after line 208 must release it — otherwise the
error paths leak a zero-byte file where they previously leaked nothing. One
helper replaces the two open-coded deletes at `run.sfn:318` and `run.sfn:324`:

```
// Delete the artifacts this invocation claimed. No-op on the guarded
// (`SAILFIN_TEST_SCRATCH`) branch, which keeps the fixed `run` name and
// claims nothing. `keep_ll` is true only on the link-failure path, where
// the SFN-34 backend-failure banner names the IR file.
fn _release_run_stem(claimed: boolean, exe_path: string, ll_path: string, keep_ll: boolean) -> void ![io] {
    if !claimed { return; }
    if fs.exists(exe_path) { fs.deleteFile(exe_path); }
    if keep_ll { return; }
    if fs.exists(ll_path) { fs.deleteFile(ll_path); }
}
```

Call sites, all with `claimed = run_exe_unguarded`:

| `run.sfn` line | Path | `keep_ll` |
|---|---|---|
| 244 | `!run_capsule_result.success` | `false` |
| 250-253 | `compile_to_llvm_file_...` failed | `false` |
| 291 | link failed | **`true`** — the banner at 285 names `ll_path` |
| 318 / 324 | success, after `process.run` | `false` |

The line-244 and line-250 cases are a deliberate small behaviour change: the
partial `.ll` a failed compile used to leave behind is now removed, because the
invocation owns it and nothing references it (unlike the link-failure banner).

---

## 6. Consumers

### 6.1 Census — the TOCTOU surface is exactly one site

Searched: every `attempt`/`candidate` retry loop in `compiler/src`, every
`monotonic_millis()` use, and every `fs.mkdtemp` / `_mktemp_*` call.

| Site | Mechanism today | Verdict |
|---|---|---|
| `_unique_run_stem`, `compiler/src/cli/commands/run.sfn:100-111` | `fs.exists` probe, 1000-attempt bound | **The only check-then-act mint in the compiler. Migrates now.** |
| `_mktemp_from_template_cmd`, `compiler/src/build/fs.sfn:128-152` | libc `mkstemp` (atomic) on POSIX; `""` degrade on a Windows host at `fs.sfn:130` | Atomic where it runs; **the Windows degrade is a follow-up (§6.2)** |
| `_mktemp_sibling_cmd`, `fs.sfn:160-162` and its 15 call sites (`capsule_emit_parallel.sfn:553,653`, `capsule_resolver/staging.sfn:118,268,373,725,758`, `build/clang_argv.sfn:164`, `emit_helpers.sfn:237`, `native_emit_subprocess.sfn:11`, `build_cache.sfn:854`, `cli_selfhost.sfn:447`, `build/fs.sfn:299`) | delegates to the above | inherits whatever `_mktemp_from_template_cmd` does; no per-site change ever |
| `cli/commands/test/cache_scratch.sfn:55`, `capsules/sfn/test/src/fixtures.sfn:56,208`, `compile_assert.sfn:259`, `capsules/sfn/fs/src/mod.sfn:120` | `fs.mkdtemp` (atomic, Windows sibling ships) | already correct; no change |
| `cli/commands/test/multi_file_run.sfn:108` | `monotonic_millis()` as a cache **nonce**, not a path | not a claim; no change |

This table is the evidence for §0 item 2. It also shows why the primitive must
not be shaped around `sfn run`: the *other* real consumer needs a file with a
caller-chosen mode, which is exactly what §3.2 provides and what a directory
claim would not.

### 6.2 Follow-up (file a separate issue): retire the Windows staging degrade

`_mktemp_from_template_cmd` returns `""` on a Windows host, and every
`_mktemp_sibling_cmd` caller then degrades to a direct non-atomic write, giving
up crash atomicity for every object, `.sfn-asm`, cache entry and manifest the
build publishes. With `sfn_create_exclusive` the body becomes a portable
candidate loop with no `mkstemp`, no `calloc`/`memcpy`/`free` buffer dance, and
no host gate:

```
fn _mktemp_from_template_cmd(template: string) -> string ![io]
// candidate = <dirname(template)>/.sfn_stage.<counter>
// loop { _create_exclusive_cmd(candidate, CREATE_EXCLUSIVE_MODE_FILE) ... }
```

Deliberately **not** in this PR, for three reasons:

1. It is on the build hot path with 15 call sites and its own `XXXXXX`-template
   contract; a rewrite there wants to be independently reviewable and
   independently revertible, not carried by a bug fix that reproduces every
   time on Linux today.
2. Candidate generation needs entropy that distinguishes *processes*, not just
   iterations — the per-module emit fan-out spawns sibling `sfn` children whose
   module-local counters all start at zero. `monotonic_millis()` is `![clock]`
   and would propagate a new effect through 15 call sites and their callers.
   That question deserves its own design pass; the atomic claim makes a
   colliding counter merely slow, not wrong, so nothing is unsafe in the
   meantime.
3. It is Windows-only correctness, and no current release gate depends on it.

The DRY line is drawn at the **primitive**, not at the retry loop: the two
consumers' candidate policies genuinely differ (millis + ordinal vs. template +
counter), and folding them into one parameterized helper would produce a helper
whose parameters each serve one caller. That is worse DRY, not better.

Also worth folding into that issue: `mkstemp_windows.sfn` may become
unreferenced once `fs.sfn:36`'s `extern fn mkstemp` is deleted — check for other
declarers before removing it and its `target.sfn` append.

---

## 7. Test strategy

The issue's AC ("two sequential claims of the same name yield exactly one
success") is necessary but weak on two counts: it never runs two claims
concurrently, and it never distinguishes *error* from *existed*, which is half
the contract. Four layers.

### 7.1 `compiler/tests/unit/create_exclusive_test.sfn` — the tri-state contract

Imports `_create_exclusive_cmd` and the constants from `"../../src/build/fs"`
(precedent: `compiler/tests/unit/windows_build_deshell_test.sfn:21` imports
`_mktemp_sibling_cmd` the same way). Scratch dir from `scratch_root()`
(`sfn/test`).

- `test "fs: exclusive create claims a free path"` — fresh path returns
  `CREATE_EXCLUSIVE_CREATED`; `fs.exists` is true afterwards.
- `test "fs: exclusive create reports an occupied path as existing"` — a second
  claim on the same path returns `CREATE_EXCLUSIVE_EXISTS`.
- `test "fs: exclusive create never truncates an occupied path"` — write
  `"keep"` between the two claims; the second returns `EXISTS` **and**
  `fs.readFile` still yields `"keep"`. *This is the assertion that catches a
  wrong `O_CREAT`/`O_EXCL` encoding (§3.3), which is otherwise invisible.*
- `test "fs: exclusive create distinguishes a real error from an occupied path"`
  — a path under a nonexistent parent directory returns
  `CREATE_EXCLUSIVE_ERROR`, not `EXISTS`. This is the discrimination the AC
  omits and the one `_unique_run_stem` branches on.
- `test "fs: exclusive create reports an existing directory as occupied"` —
  claim a path that is an existing directory; expect `EXISTS` on both legs
  (POSIX `EEXIST`; Windows via the §3.2(3) attribute probe).
- `test "fs: exclusive create honours the POSIX creation mode"` — claim with
  `CREATE_EXCLUSIVE_MODE_EXE` and with `CREATE_EXCLUSIVE_MODE_FILE`, assert
  `fs.get_perms` returns 448 / 384. Skip on a Windows host (`sfn/test`'s skip
  helper), where the mode is documented as ignored.

### 7.2 `compiler/tests/unit/create_exclusive_race_test.sfn` — the atomic property

The only test that actually demonstrates atomicity rather than sequencing.

Shape: a module-level `let mut _race_path: string` set by the test body, a
top-level `fn _claim_once() -> int ![io]` that returns
`_create_exclusive_cmd(_race_path, CREATE_EXCLUSIVE_MODE_FILE)`, and a
`routine { }` that spawns it N=16 times by name (`spawn _claim_once()`),
collecting `Task<int>` handles and folding them with `join_all`. Assert:
**exactly one** `CREATED`, **fifteen** `EXISTS`, **zero** `ERROR`.

Nurseries are real pthreads (`runtime/sfn/concurrency/nursery.sfn` over
`platform/pthread.sfn`), so this is genuine concurrency, and it is in-process,
so it costs no extra `sfn` children against the pool's memory budget.

Two feasibility items to probe **before** writing it, per the FFI-assumption
discipline — neither is confirmed by this design pass:

- The `spawn <fn>()` *named-function* form is the shipped one;
  `compiler/tests/unit/routine_nursery_test.sfn:13-17` states plainly that the
  inline-lambda spawn surface is "a separate, still-incomplete codegen path".
  Hence the module-global + named-function shape above rather than a capturing
  lambda.
- A module-global `string` read from a worker thread must actually work. If it
  does not, fall back to `sfn_parallel`/`parallel.sfn`'s indexed form, or drop
  this layer and rely on 7.3 — **do not** substitute a sequential loop and call
  it a race test.

### 7.3 `compiler/tests/e2e/run_exe_isolation_test.sfn` — end-to-end regression

Extend the existing *"two overlapping invocations"* test (currently
`run_exe_isolation_test.sfn:121-158`) to **three** concurrent children, not two
and not four: three is enough to demonstrate N-way claiming, and each extra
child costs ~3 GiB against the pool budget
(`.claude/rules/compiler-safety.md`), so doubling is not free.

- Assert all three exit 0 and all three print `"7"`. **This is the deterministic
  core** — per the maintainer's measurement it fails every time today.
- Add a distinct-name assertion that is robust rather than timing-dependent:
  poll the directory every 50 ms from spawn to join, unioning every observed
  `run-`-prefixed non-`.ll` entry into a set, and assert the set has three
  members. This is reliable *because of* the design: the claim happens before
  the compile, so each name is on disk for the whole compile + link + run
  window (seconds), not just the 1500 ms fixture sleep.
- After all three join, assert `_count_run_exe_entries(dir) == 0` **and** that
  no `run-*.ll` remains — the release path in §5 leaks nothing.
- Keep the SFN-1004 stderr echo at `run_exe_isolation_test.sfn:143-151`; extend
  it to the third child.
- `_count_run_exe_entries` (`run_exe_isolation_test.sfn:63-77`) needs no change
  — a claimed placeholder is a regular file with a `run-` prefix and no `.ll`
  suffix, which is exactly what it counts.

### 7.4 Drift guards for the new conditioning entries

- `compiler/tests/unit/runtime_source_gates_test.sfn:294-301` — bump the pinned
  `assert sources.length == 38;` to 39 and update the comment, which explicitly
  says the literal "must be updated deliberately whenever a source is genuinely
  added".
- `compiler/tests/e2e/cross_windows_runtime_modules_test.sfn` — add the pair's
  four membership contracts in the shape the `rename_ops` block
  (`:151-165`) uses: manifest contains `"sfn/platform/exclusive_create.sfn"`;
  Makefile does not; Makefile contains
  `runtime/sfn/platform/exclusive_create_windows.sfn`; manifest does not
  contain `exclusive_create_windows`. The substring test is exact in both
  directions because `exclusive_create.sfn` is not a substring of
  `exclusive_create_windows.sfn`.
- Mirror the SFN-721 source-drift guard in the same file: assert the POSIX
  module contains `/proc/self/status` and not `CreateFileA`, and the Windows
  sibling contains `CreateFileA` and not `/proc/self/status`. A Linux runner
  cannot execute the Windows leg; this at least pins that the two have not
  drifted into each other.

---

## 8. Files affected, by pipeline stage

**Runtime (new):**
- `runtime/sfn/platform/exclusive_create.sfn`
- `runtime/sfn/platform/exclusive_create_windows.sfn`

**Runtime manifest:**
- `runtime/capsule.toml` — add `"sfn/platform/exclusive_create.sfn"` to
  `sfn-sources`. **Do not** add anything to `[sfn-source-gates]`, and **do not**
  name the `_windows` sibling anywhere in this file — the manifest's own
  comment block (`runtime/capsule.toml`, `[sfn-source-gates]` header) explains
  that both are actively harmful, and `[sfn-source-gates]` must stay the last
  section.

**Build driver / target conditioning:**
- `compiler/src/build/target.sfn` — a new `else if base == "exclusive_create.sfn"`
  swap branch beside the `rename_ops.sfn` branch at `:518-526`, plus the file
  header's swap inventory at `:410-450` and the removal condition from §4.2.

**Compiler-side primitive:**
- `compiler/src/build/fs.sfn` — the `extern fn`, five constants,
  `_create_exclusive_cmd`, and the export-block additions.

**Consumer (CLI):**
- `compiler/src/cli/commands/run.sfn` — `_unique_run_stem` rewrite, the
  stale-comment deletions, the caller failure branch, `_release_run_stem`, and
  its four call sites.

**Cross-Windows bridge:**
- `Makefile:1260` — add
  `exclusive_create_windows:runtime/sfn/platform/exclusive_create_windows.sfn`
  to `RUNTIME_MODS`. Missing this leaves the mingw bridge with an undefined
  `@sfn_create_exclusive`, which is exactly how the `fs_exec_mode` pair was
  caught (`cross_windows_runtime_modules_test.sfn:118-121`).

**Tests:**
- `compiler/tests/unit/create_exclusive_test.sfn` (new)
- `compiler/tests/unit/create_exclusive_race_test.sfn` (new, subject to §7.2)
- `compiler/tests/e2e/run_exe_isolation_test.sfn` (extend)
- `compiler/tests/unit/runtime_source_gates_test.sfn` (count bump)
- `compiler/tests/e2e/cross_windows_runtime_modules_test.sfn` (drift contracts)
- `compiler/tests/shard_weights.tsv` — add rows for the two new test files if
  the suite requires them.

**Docs:**
- `docs/status.md` needs **no** change: the primitive is compiler-internal, not
  a `fs.*` builtin, so the `sfn/fs` capability row at `docs/status.md:1118`
  still describes the public surface accurately. Revisit if §3.1's builtin
  promotion ever happens.

---

## 9. Dependencies

None. No predecessor issue, no seed advance, no `seed-blocker` label, no
`## Required in pinned seed:` line (§4.4). The only external assumption is that
seed `0.10.1` compiles the constructs in §4.1, all of which it demonstrably
already compiles in shipped runtime modules.

---

## 10. Risks

| # | Risk | Severity | Mitigation |
|---|---|---|---|
| R1 | Wrong `O_CREAT`/`O_EXCL` word silently truncates a peer's file | **critical** | §3.3's two-marker probe fails closed with `-1` when neither marker answers, so the only reachable outcomes are "correct" or "loud error". Pinned by the never-truncates test in §7.1. |
| R2 | The linker preserves the placeholder's mode and produces a non-executable binary | high | Claim with `0o700` (§3.6). §7.3 executes the produced binary, so a regression fails loudly rather than silently. Verify against the configured linker during implementation. |
| R3 | Error paths in `run.sfn` leak a zero-byte claim | medium | `_release_run_stem` at all four exits (§5). |
| R4 | `Makefile` `RUNTIME_MODS` forgotten → undefined `@sfn_create_exclusive` on the mingw bridge | medium | §7.4's drift contracts fail on the omission, and this is the precise failure the `fs_exec_mode` pair already produced once. |
| R5 | `runtime_source_gates_test.sfn`'s pinned count fails | low | Deliberate; bump it (§7.4). |
| R6 | Two `open` declarations of different arity in one link | low | Per-module objects (`runtime_objs.sfn:1622`), matching C's own variadic `open`. Confirm no `llvm-link` merge of runtime modules. |
| R7 | The nursery race test is infeasible on the current spawn surface | low | §7.2's feasibility probe; 7.1 + 7.3 stand alone if it is dropped. Never substitute a sequential loop. |
| R8 | Three concurrent `sfn run` children exceed the pool's memory budget | low | Three, not four (§7.3); each self-caps at 8 GiB. Watch the shard weight. |
| R9 | A native Windows seed ships and §4.2's reasoning silently expires | low | Record the removal condition in both new module headers and in the `target.sfn` branch comment, matching `target.sfn:571-580`. |

---

## 11. Verification

Ordered by the validation ladder in `CLAUDE.md`; do not skip upward.

```
# Rung 0 — formatting (CI gate)
build/bin/sfn fmt --write runtime/sfn/platform/exclusive_create.sfn \
  runtime/sfn/platform/exclusive_create_windows.sfn \
  compiler/src/build/fs.sfn compiler/src/build/target.sfn \
  compiler/src/cli/commands/run.sfn \
  compiler/tests/unit/create_exclusive_test.sfn \
  compiler/tests/unit/create_exclusive_race_test.sfn \
  compiler/tests/e2e/run_exe_isolation_test.sfn
build/bin/sfn fmt --check <same list>

# Rung 1 — typecheck / effects, seconds
build/bin/sfn check compiler/src/build/fs.sfn compiler/src/build/target.sfn \
  compiler/src/cli/commands/run.sfn

# Rung 2 — self-host. STRUCTURAL (new runtime modules + manifest change),
# so clean first.
make clean-build

# Rung 3 — targeted
build/bin/sfn test compiler/tests/unit/create_exclusive_test.sfn
build/bin/sfn test compiler/tests/unit/create_exclusive_race_test.sfn
build/bin/sfn test compiler/tests/unit/runtime_source_gates_test.sfn
build/bin/sfn test compiler/tests/e2e/cross_windows_runtime_modules_test.sfn
build/bin/sfn test compiler/tests/e2e/run_exe_isolation_test.sfn

# Rung 3b — reproduce the reported bug directly, before and after.
# Expect: BEFORE, one of the two fails with `sfn run: no binary at ...`;
# AFTER, both exit 0 and two distinct run-* names appear.
mkdir -p /tmp/sfn974 && cd /tmp/sfn974
printf 'fn main() -> int ![clock, io] {\n    sleep(1500);\n    print("7");\n    return 0;\n}\n' > m.sfn
timeout 300 build/bin/sfn run m.sfn & timeout 300 build/bin/sfn run m.sfn & wait

# Rung 3c — the cross-Windows bridge actually links the new symbol
make ci-cross-windows

# Rung 4 — ship gate
make check
```

Windows-native verification (`docs/runbooks/windows-native.md`) is **not** a
merge gate here — no native Windows seed exists and CI has no native Windows
leg — but the Win32 constants and the `CreateFileA`-on-a-directory behaviour in
§3.2(3) should be confirmed against a real Windows host before the Windows leg
is claimed as shipped, in the same "measured, not assumed" style
`rename_ops_windows.sfn:11-25` and `fs_exec_mode_windows.sfn:23-27` use. Until
then the Windows leg is *written*, not *proven*, and `docs/status.md` should not
claim otherwise.

---

## 12. Future considerations

- **`fs.createExclusive` as a real builtin.** The natural 1.0 surface for user
  Sailfin, and a prerequisite for user-space lock files and `sfn/fs`
  completeness. It is a registry row plus a `native_signature` pointing at this
  same symbol (`registry_services.sfn:44` is the template), which means it is a
  seed-blocker and belongs in a batched seed advance, not here.
- **`sfn_open_exclusive`** — the handle-returning sibling, if a lock-file
  consumer ever needs to hold and write the descriptor. It needs a
  cross-platform close primitive to go with it; do not retrofit it onto
  `sfn_create_exclusive`.
- **A general "leased scratch name" abstraction.** Once §6.2 lands, both
  consumers claim-then-release. If a third appears, that is the moment to
  extract a shared lease helper — not before.
- **The `access`-based host probe is now used in three places** (`target.sfn`,
  `filesystem.sfn`, and this module). If a fourth appears, it is worth a single
  `platform/host_os.sfn` — but note that consolidating it requires the
  cross-module *defined*-function resolution that `errno.sfn:37-53` is still
  waiting on, so it cannot be done today.
- **Windows wide paths.** §3.2(1) chooses `CreateFileA` to match the whole
  runtime. The day Sailfin wants non-ASCII Windows paths, that is a
  runtime-wide `A`→`W` migration with a UTF-8→UTF-16 layer, and this module is
  one of ten sites, not a special case.
