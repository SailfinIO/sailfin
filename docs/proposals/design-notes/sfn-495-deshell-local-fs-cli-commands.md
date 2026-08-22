# SFN-495 — De-shelling the local-filesystem CLI commands

Single-issue implementation design gate (per `.claude/rules/proposals.md`: this
is a bounded de-shelling migration over already-seeded capabilities plus one new
composed traversal helper, not a forward-looking language or runtime design — no
SFEP number). Design record for the PRs that land SFN-495.

- **Issues:** SFN-495 (this gate), SFN-756 (prerequisite, landing now), SFN-884
  (split out: Windows credential ACLs)
- **Author:** agent:compiler-architect
- **Status:** design-approved
- **Updated:** 2026-08-14
- **Related:** SFN-646 (the POSIX-dependence inventory), SFN-753 (`.tar.gz`,
  the deferred dependency), SFEP-0021 (`../0021-windows-native-selfhost.md`,
  the governing Windows design)

## 1. Summary

`sfn package`, `sfn dev bootstrap`, `sfn config`, and `sfn login` reach the
filesystem by spawning POSIX shell utilities — `mkdir -p`, `rm -rf`, `cp -f`,
`cp -R`, `chmod`, `ln -sfn`, `wc -c`, `uname` — none of which exist on a bare
Windows host. This proposal adds one new primitive, `copy_tree`
(`compiler/src/build/fs_tree.sfn`), plus two small helpers in
`compiler/src/build/fs.sfn` (`_file_size_of`, `_cwd_cmd`), and migrates every
migratable site in those four commands onto already-seeded `fs.*` calls. It
composes entirely over capabilities the pinned seed 0.9.5 already carries —
**no new extern, no new intrinsic, no seed cut**. Two categories are explicitly
deferred with named successors: `tar -czf` (SFN-753) and `date -u` (a new
epoch→civil issue).

## 2. Motivation

### 2.1 The real hard-failure surface

SFN-646 frames `_shell_read_cmd` (35 call sites) as the headline native-Windows
blocker. That framing is wrong in one direction and incomplete in the other.

**Wrong:** `_shell_read_cmd` is *gated*. `compiler/src/build/fs.sfn:419-423`:

```sfn
fn _shell_read_cmd(cmd: string) -> string ![io] {
    if host_is_windows() { return ""; }
    ...
}
```

It never spawns anything on Windows; it degrades to `""`. The header at
`fs.sfn:405-418` states the contract: *"Callers must treat `""` as
'unknown'."*

**Incomplete:** the ungated argv spawns — `process.run(["mkdir", "-p", …])`,
`["rm", "-rf", …]`, `["cp", "-R", …]`, `["ln", "-sfn", …]`, `["chmod", …]` —
have no gate and no binary to spawn. Those are the hard failures.

### 2.2 A correction to *both* framings

The gated set is **not uniformly benign**. `_package_detect_target`
(`compiler/src/cli/commands/package.sfn:164-178`) converts the `""` degrade
into a hard exit:

```sfn
let os = _shell_read_cmd("uname -s");
let arch = _shell_read_cmd("uname -m");
if os.length == 0 { return ""; }          // -> caller prints
if arch.length == 0 { return ""; }        //    "failed to detect platform
                                          //     target" and returns 1
```

So `sfn package` fails on Windows at argument-parse time, *before* reaching a
single `process.run`. The degrade is only benign where the caller honours the
"treat `""` as unknown" contract, and this one does not. `toolchain.sfn`
already fixed the identical bug for `sfn toolchain install` (SFN-857,
`toolchain.sfn:133-147`); `package.sfn` was missed.

**Consequence for scoping:** the migration must fix `_package_detect_target`
even though it is a `_shell_read_cmd` site, not an argv site.

### 2.3 What just unblocked this

`compiler/src/build/fs_tree.sfn:34-36` records the gate:

> `copy_tree` is deliberately still absent: `cp -R`/`cp -a` has no consumer
> here, and the replacement lands with its first real consumer (SFN-495) now
> that `fs.is_directory` makes a correct one writable.

SFN-756 (branch `claude/sfn-756-wire-fs-is-directory`) adds the
`sfn_fs_is_directory` runtime wrapper and switches `walk_dirs` over. Once it
merges, `fs.is_directory` is callable and `copy_tree` is writable. That header
paragraph is this proposal's removal condition.

## 3. Design

### 3.1 `copy_tree` — the new primitive

Lives in `compiler/src/build/fs_tree.sfn`, beside `remove_tree`, sharing
`FS_TREE_MAX_DEPTH` (16) and `FS_TREE_MAX_NODES` (200000). Added to the module
`export` block.

```sfn
fn copy_tree(src: string, dst: string) -> boolean ![io]
```

**Guards** — each returns `false` having copied nothing:

| Condition | Why |
|---|---|
| `src.length == 0` or `dst.length == 0` | mirrors `remove_tree`'s empty-path guard (`fs_tree.sfn:133`) |
| `!fs.exists(src)` | nothing to copy; `remove_tree` returns `true` for the symmetric case because "already gone" satisfies its post-condition — a copy's does not |
| `dst == src` | no-op that would otherwise self-overwrite every file |
| `dst` starts with `src + "/"` | a destination inside the source recurses into its own output; the depth bound would eventually stop it after copying 16 levels of garbage |

**File root.** If `!fs.is_directory(src)`, `ensure_dir_p(_dirname_cmd(dst))`
then `_copy_file(src, dst)` plus the mode carry (§3.1.4), and return that
result. This matches `cp -R <file> <dst>`.

**Directory root.** `dst` is the destination directory **itself**, never a
container: `copy_tree("runtime/sfn", staging + "/sfn")` produces
`staging/sfn/<entries>`. That matches `cp -R src dst` where `dst` does not
exist — which is the shape of every call site, since staging is wiped on entry.
An **existing** `dst` is *merged into*, not replaced: same-named entries are
overwritten, extra entries in `dst` survive. Callers wanting replace semantics
call `remove_tree(dst)` first. Documented, not enforced.

#### 3.1.1 Traversal

BFS over two parallel `string[]` level arrays (`level_src`, `level_dst`),
indexed together — the same parallel-array shape `package.sfn:464-487` already
uses for `dep_queue`/`dep_anchor`. No new struct type; the module stays
type-free.

Each iteration creates the destination directory **before** listing the source,
so creation order *is* discovery order and no reverse pass is needed. This is
the mirror image of `remove_tree`'s reverse-order deletion
(`fs_tree.sfn:139-147`): a delete must empty children before parents, a copy
must create parents before children, and BFS discovery order serves both — one
forwards, one backwards.

Per entry: `fs.is_directory(child_src)` decides. Directory → `ensure_dir_p` its
destination and push the pair onto the next level. File → `_copy_file` +
mode carry.

#### 3.1.2 Entry classification — the third rationale

`fs_tree.sfn`'s header (lines 8-32) enumerates why each function picks its
probe. `copy_tree` needs a fourth bullet:

> `copy_tree` reads but also writes, and its write is not a classification
> probe — creating a directory tells you nothing about whether the source was
> one. So, like `walk_dirs`, it classifies with `fs.is_directory`. Unlike
> `walk_dirs` the extra `stat` is not a cost paid for correctness at empty
> directories; it is the only available answer, because neither destructive
> probe (`fs.deleteFile`, `fs.removeDirectory`) may be pointed at a source
> tree a copy must leave intact.

#### 3.1.3 Symlinks — an explicit divergence from `cp -R`

**`copy_tree` does not preserve symlinks. It copies what they resolve to.**

`fs.is_directory` is `stat` (follows —
`runtime/sfn/adapters/filesystem.sfn:584-586`), `fs.listDirectory` is `opendir`
(follows — `fs_tree.sfn:38-44`). A symlink-to-directory is copied as a real
directory; a symlink-to-file as a real file.

This is a *capability* limit, not a choice: there is no `is_symlink` predicate
and no `lstat`. `fs.read_link` (SFN-46) reads a link's target but cannot tell
you a path *is* a link — it returns `""` for a non-symlink, which is
indistinguishable from a failure (`filesystem.sfn:983-1002`). Link preservation
is not expressible today.

GNU/POSIX `cp -R` **does** preserve symlinks as symlinks, so this is a real
behavioural divergence and must be stated in the module header rather than
implied. It is benign for every consumer in scope — `runtime/sfn`, the runtime
dependency `src/` trees, and `build/compiler/import-context` contain no
symlinks (verified: `find runtime/sfn capsules -type l` is empty) — and it is
*better* for a staging tree destined for a tarball, where a relative symlink
would land dangling in the consumer's install.

A symlink **cycle** terminates on `FS_TREE_MAX_DEPTH` and returns `false`,
having first copied 16 levels of the cycle. The caller's `remove_tree(dst)`
cleans it up. That is the same "degrade, don't spin" contract the module header
already gives for `walk_dirs`.

#### 3.1.4 Permissions

The low-12 mode is carried **per regular file** and never for directories:

```
let mode = fs.get_perms(child_src);
if mode > 0 { fs.set_perms(child_dst, mode); }
```

Exactly the shape `_selfhost_promote_binary` uses
(`compiler/src/cli_selfhost.sfn:444-445`), whose comment at 427 already
documents the `-1`-on-error contract.

- **Why preserve at all:** GNU `cp` sets a regular file's destination mode from
  its source mode. `_copy_file` opens `"wb"`, which yields `0666 & ~umask` and
  silently drops an executable bit. A future consumer copying a `bin/` tree
  would get a non-executable copy and not find out until runtime. This is
  fidelity to the thing being replaced, not speculation.
- **Why not for directories:** carrying a restrictive source mode onto a
  staging directory could make it unreadable to the walk that is still writing
  into it. `ensure_dir_p`'s default is correct and safe.
- **Windows:** `sailfin_intrinsic_fs_get_perms` is a `-1` stub
  (`registry_platform.sfn:296`), so `mode > 0` is false and the whole carry
  self-disables. **No `host_is_windows()` gate is needed — the `-1` is the
  gate.** This is the right answer on the merits too: Windows has no execute
  bit, and `_chmod` can express only the read-only attribute.
- **Cost:** two extra syscalls per file. For `import-context` (1813 files) that
  is 3626 `stat`/`chmod` calls against 1813 file copies — noise.

#### 3.1.5 Failure semantics

**Stop at the first failure, return `false`, delete nothing.**

Not best-effort-continue: continuing multiplies the damage and delays the
report. Not all-or-nothing-with-rollback: `copy_tree` must never delete,
because a pre-existing `dst` it did not create is not its to remove.

On failure `dst` holds a partial tree and **the caller owns cleanup**. Every
call site in scope already does exactly this — `if cp != 0 { rm -rf staging;
return 1; }` — so no call site changes shape.

Hitting `FS_TREE_MAX_DEPTH` or `FS_TREE_MAX_NODES` also returns `false`. This
follows `remove_tree`, not `walk_dirs`: `remove_tree` returns `false` on a
bound because *"a fabricated `true` would let `cache_clean` claim it wiped a
tree that survived"* (`fs_tree.sfn:53-60`). The copy analogue is worse — a
fabricated `true` would let `sfn package` tar a truncated tree and publish it
as a **release artifact**. That is the highest-stakes false success in the
module and the header should say so.

### 3.2 `_file_size_of` — replacing `wc -c`

New in `compiler/src/build/fs.sfn`, beside `_copy_file_counted`:

```sfn
fn _file_size_of(path: string) -> int ![io]
```

`fopen(path, "rb")`, chunked `fread` into a single 64 KiB `malloc` buffer
discarding the bytes, accumulate the count, `ferror` check, `fclose`. Returns
`0` on any failure — matching `_package_size_of_file`'s current contract
(`package.sfn:781`, *"Returns 0 on read failure"*), so no caller changes.
Reuses `_copy_file_counted`'s loop shape and its `max_chunks` guard
(`fs.sfn:307-314`).

**Rejected alternatives**, both worth recording because they look obvious:

- **`fseek(SEEK_END)` + `ftell`.** O(1) instead of O(n), but `ftell` returns
  `long`, which is **32-bit on Win64** — the size silently truncates above
  2 GiB and the correct Windows spelling is `_ftelli64`, a per-platform
  divergence needing a `platform/` sibling. Not worth it for a size probe that
  runs three times per `sfn package`. `runtime/sfn/adapters/filesystem.sfn:76-82`
  already records the project's decision to avoid the seek/tell pair.
- **`_read_file_bytes(path).length`.** Already shipped and correct, but slurps
  the whole file into RAM and hard-fails above its 512 MiB cap
  (`fs.sfn:615`, status `4`). `sfn package` on a large artifact would report
  size `0`.

### 3.3 `_cwd_cmd` — replacing `pwd`

New in `compiler/src/build/fs.sfn`, beside `_mktemp_from_template_cmd`. The
module already owns inline libc externs and documents why (`fs.sfn:10-17`:
*"a plain `extern fn` over a libc symbol resolves against the pinned seed and
needs no seed cut"*).

```sfn
extern fn realpath(path: *u8, resolved: *u8) -> *u8;

fn _cwd_cmd() -> string ![io]
```

`realpath(".", null)` — libc allocates the buffer. Precedent:
`compiler/src/cli/entry.sfn:50` declares this exact extern inline per the
SFN-635 no-cross-module-extern convention. **It already works on Windows**:
`runtime/sfn/platform/realpath_windows.sfn` provides `@realpath` via
`_fullpath`, appended for Windows targets by
`target_condition_runtime_sfn_sources`.

Fallback chain: `realpath(".", null)` → `env.get("PWD")` → `"."`. `PWD` is a
*shell*-maintained variable, absent when `sfn` is spawned by a non-shell parent
and absent on native Windows, so it is the fallback, not the primary — a point
worth noting against the existing `env.get("PWD")` precedent at
`init.sfn:51` and `lock.sfn:61`.

Caveat to document: `_fullpath` returns backslash-separated paths.
`realpath_windows.sfn:43-49` already argues mixed separators are fine because
every consumer concatenates forward-slash suffixes onto the same string and
Win32 accepts both.

`_cwd_cmd` has **three** further consumers outside this scope
(`dev_clean.sfn:202`, `dev_det_sweep.sfn:183` and `:366`). They migrate under
their own issues; the helper simply exists for them. No seed gate either way
(§5).

### 3.4 Windows-branch decisions, per site class

The gate pattern is `host_is_windows()` from `compiler/src/build/target.sfn:65`
— a **runtime** host check, not a compile-time one, so both branches are still
emitted and must still link (`fs.sfn:24-34`). The established short-circuit
shape is `build_cache.sfn:373`:

```sfn
if host_is_windows() { return true; }
```

#### `chmod 700` / `chmod 600` → `fs.set_perms`, Windows short-circuits to success

`fs.set_perms(path, 448)` for `0o700`, `fs.set_perms(path, 384)` for `0o600`.
(`sfn_fs_set_perms` masks to `0o7777` then calls `chmod` —
`filesystem.sfn:852-856`.)

**No new link surface.** `sfn_fs_set_perms` is already linked into every build
via `source_fingerprint.sfn:239` and `cli_selfhost.sfn:445`, so this is not in
the same class as the `close`-style unresolved-symbol hazard documented at
`fs.sfn:24-34`.

**Failure policy diverges by host.** `config.sfn:46-50` treats a non-zero
`chmod` rc as **fatal**. Keep that on POSIX. On Windows, short-circuit to
success *before* the call:

- `_chmod` honours only the read-only attribute; `0o600` and `0o700` are
  inexpressible, so the call is a semantic no-op even when it succeeds.
- A false failure must not block `sfn config set` over a permission Windows
  never had.

**State the security consequence rather than hiding it.** On Windows,
`~/.sfn/credentials` and `~/.sfn/config.toml` are **not** access-restricted.
That is true today (`chmod` is unspawnable there), and this change does not
make it worse — but it must not stay invisible either.

**Decision (owner, 2026-08-14): warn on write, in command output.** A source
comment is not enough. SFN-495's own acceptance criteria requires that "Windows
permission and symlink degradations are documented in `--help` or command
output, not silent," and a silent short-circuit-to-success fails it. On
Windows, `sfn login` prints a notice after writing the credential file:

```
saved credentials to C:\Users\me\.sfn\credentials
note: this file is NOT access-restricted on Windows
      (NTFS ACL support tracked in SFN-884)
```

The `chmod` call still short-circuits to success before `fs.set_perms` on that
host, for the reasons above — the notice is what makes the degradation honest,
not a changed return value. The `login.sfn` header's claim that the
`chmod 700/600` handling is preserved gains the same host qualifier.

**Removal condition: SFN-884**, which lands the real fix (a DACL granting only
the calling user's SID, preferably at `CreateFileW` time so no unprotected
window exists). The PR that satisfies SFN-884 deletes both the notice and the
header qualifier.

#### `ln -sfn` → `fs.symlink`, capability-driven fallback to copy

`_bootstrap_link_bin` (`dev.sfn:124-129`) creates `bin/sfn` and `bin/sailfin`
aliases onto the versioned seed binary.

```
ensure_dir_p(bin_dir)
for each alias:
    fs.deleteFile(alias)                 // the -f half of `ln -sfn`
    if !fs.symlink(abs_bin, alias):
        _copy_file(abs_bin, alias)
        fs.set_perms(alias, 493)         // 0o755
```

- `ln -sfn` is *force* + *no-dereference*: it replaces an existing link even
  when that link points at a directory. `fs.symlink` is bare `symlink(2)` and
  fails `EEXIST` on any existing path, so the `fs.deleteFile` is load-bearing.
  `fs.deleteFile` is `unlink(2)`, which removes a symlink **without following
  it** — the property `fs_tree.sfn:38-40` already documents — so this cannot
  escape into the link's target.
- **Gate on the capability, not the host.** `sailfin_intrinsic_fs_symlink` is a
  hard `false` stub on Windows (`registry_platform.sfn:293`), so the Developer
  Mode / `SeCreateSymbolicLinkPrivilege` question never arises — the call
  simply returns `false`. Branching on the return value rather than on
  `host_is_windows()` also covers a POSIX filesystem that refuses symlinks, and
  leaves nothing to delete when the Windows stub is one day replaced.
- **Copy is the right Windows answer on the merits**, not a concession: the
  alias must be *executable*, and the store entry is immutable and
  version-keyed, so a copy is exactly as correct — it costs one extra binary of
  disk.
- **No staleness hole** from copying instead of linking: `_bootstrap_link_bin`
  is re-run both on the fetch path (`dev.sfn:137`) and on the
  already-present path (`dev.sfn:264`), so a re-pin refreshes the copy.
- `_bootstrap_link_bin` stays `-> void` (best-effort), matching its header at
  `dev.sfn:119-123`.

#### `_bootstrap_abspath`'s absoluteness test

`dev.sfn:88` uses `starts_with(path, "/")`, which does not recognise `C:\…`. On
Windows a relative path is correctly cwd-prefixed, but an absolute one is
double-prefixed. Reuse the drive-letter check already inlined at
`module_paths.sfn:73-84` and `main.sfn:325-338` (letter, `:`, separator). That
duplication wanting a shared helper is a Future consideration (§9), not scope
here.

#### `uname -s` / `uname -m` → `build_host_os()` + a Windows arch leg

`_package_detect_target` (`package.sfn:164-178`) already compares against
`"Linux"` / `"Darwin"` — which are **exactly** the tokens `build_host_os()`
returns (`target.sfn:15`, *"Values are uname-style"*). So:

- `let os = build_host_os();` replaces the `uname -s` shell read verbatim; the
  existing comparison chain is unchanged.
- Add a `"Windows"` arm returning `"windows-x86_64"`, keyed the same way
  `toolchain.sfn:157-158` does: arm64 Windows is not an admitted triple
  (`target.sfn:112-120`), so there is nothing for a probe to distinguish.
- Keep the POSIX `_shell_read_cmd("uname -m")` arch probe unchanged, and keep
  the `"unknown-" + os + "-" + arch` fallback, so nothing `sfn_package_test.sfn`
  pins moves.

Unifying this with `toolchain.sfn`'s `_detect_os`/`_detect_arch` into one
`build/target.sfn` resolver is the obviously right end state — the two token
vocabularies are already identical — but it touches release tooling and belongs
in its own issue (§9).

### 3.5 Site-by-site migration map

`compiler/src/build/fs_tree.sfn::remove_tree` / `ensure_dir_p` and
`compiler/src/build/fs.sfn::_copy_file` are all already shipped.

#### `compiler/src/cli/commands/package.sfn` — 51 sites migrate, 6 deferred

| Lines | Current | Replacement |
|---|---|---|
| 165, 166 | `_shell_read_cmd("uname -s"/"uname -m")` | `build_host_os()` + Windows arch leg (§3.4) |
| 217, 362, 698 | `rm -rf staging` (**entry wipe**) | `remove_tree(staging)` — **check the result** (§3.5.1) |
| 223, 228, 238, 245, 269 | `rm -rf staging` (cleanup/exit) | `remove_tree(staging)`, result ignored |
| 369, 374, 385, 392, 413, 420, 425, 432, 496, 504, 516, 531, 561, 571, 578, 607 | `rm -rf staging` (cleanup/exit) | `remove_tree(staging)`, result ignored |
| 710, 720, 726, 742, 749, 773 | `rm -rf staging` (cleanup/exit) | `remove_tree(staging)`, result ignored |
| 218, 232, 363, 364, 509, 566, 699, 704, 715, 735 | `mkdir -p <d>` | `ensure_dir_p(<d>)` |
| 219, 220, 365, 366, 388, 416, 525, 723, 732, 733 | `cp -f <s> <d>` | `_copy_file(<s>, <d>)` |
| 428 | `cp -R runtime/sfn <staging>/sfn` | `copy_tree(...)` |
| 510 | `cp -R <dep src_dir> <dest>/src` | `copy_tree(...)` |
| 555 | `cp -R build/compiler/import-context <staging>/import-context` | `copy_tree(...)` |
| 786 | `wc -c < <path>` in `_package_size_of_file` | `_file_size_of(path)` — the whole hand-rolled decimal parser at 787-806 is deleted |
| **234, 568, 737** | `tar -czf` | **DEFERRED — SFN-753** (§3.6) |
| **252, 590, 756** | `date -u +%Y-%m-%dT%H:%M:%SZ` | **DEFERRED — new issue** (§3.6) |

Return-code shape: `process.run` returns `int` (`0` == ok), the new helpers
return `boolean`. Each `let cpN = process.run([...]); if cpN != 0 {` becomes
`if !_copy_file(...) {`, keeping the message and the cleanup branch verbatim.

`_package_size_of_file`'s header (`package.sfn:781-784`) and the
`_shell_single_quote_arg` import (`package.sfn:35`) both go — check whether
`_shell_single_quote_arg` is still used elsewhere in the file before dropping
the import.

#### `compiler/src/cli/commands/dev.sfn` — 4 sites

| Line | Current | Replacement |
|---|---|---|
| 89 | `_shell_read_cmd("pwd")` | `_cwd_cmd()` (§3.3); also fix the absoluteness test at 88 (§3.4) |
| 125 | `mkdir -p bin_dir` | `ensure_dir_p(bin_dir)` |
| 127, 128 | `ln -sfn abs_bin <alias>` | `fs.deleteFile` + `fs.symlink` + copy fallback (§3.4) |

Everything else in `dev.sfn` that calls `process.run` spawns the **`sfn` binary
itself** (`:280`, `:374`, `:484`, `:540`) — legitimate, cross-platform, and out
of scope. Do not touch them.

#### `compiler/src/cli/commands/config.sfn` — 2 sites

| Line | Current | Replacement |
|---|---|---|
| 46 | `chmod 700 sfn_dir` (fatal on failure) | `fs.set_perms(sfn_dir, 448)`, Windows short-circuits to success (§3.4) |
| 58 | `chmod 600 path` (fatal on failure) | `fs.set_perms(path, 384)`, same |

#### `compiler/src/cli/commands/login.sfn` — 2 sites

| Line | Current | Replacement |
|---|---|---|
| 109 | `chmod 700 sfn_dir` (rc ignored) | `fs.set_perms(sfn_dir, 448)` |
| 113 | `chmod 600 cred_path` (rc ignored) | `fs.set_perms(cred_path, 384)` |

Also update the header claim at `login.sfn:9-10` with the Windows qualifier
(§3.4).

#### One adjacent one-liner, recommended for inclusion

`compiler/src/capsule_emit_parallel.sfn:650`:
`process.run(["rm", "-f", staged])` → `fs.deleteFile(staged)`.

Outside the four named commands, but semantically identical, in a failure-only
branch, on a hot build path, and one line. Splitting it into its own issue is
exactly the manufactured split the decomposition rules forbid. Bundle it.

#### 3.5.1 One correctness upgrade the shell version could not make

`package.sfn:214-216` explains the entry wipe:

> Staging is wiped on entry AND exit so a prior failed run can't bleed contents
> into this run.

The current code ignores `rm -rf`'s exit status, so a wipe that *fails* lets a
previous run's files into the release tarball silently. `remove_tree` returns
`boolean`. **At the three entry wipes (217, 362, 698), check it** and fail with
a clear message. Leave the cleanup/exit wipes unchecked — an error is already
being reported there and a second one would only obscure it.

### 3.6 Explicitly OUT of scope

| Deferred | Why | Successor |
|---|---|---|
| `tar -czf` (`package.sfn:234, 568, 737`) | needs in-process `.tar.gz` writing | **SFN-753** |
| `date -u` (`package.sfn:252, 590, 756`) | needs epoch→civil formatting, which exists nowhere; `sfn/time` exposes only `now_millis`/`unix_millis` | **new issue** (§3.6.1) |
| `touch` (`build_cache.sfn:374`) | already `host_is_windows()`-short-circuited with a documented removal condition | **SFN-754** |
| `curl` / `tar -x` (`toolchain.sfn`) | network acquisition + extraction, a different problem | own issue under SFN-646 |
| `curl` / `sh -c printf` (`publish.sfn:192, 219`) | registry HTTP, wants `sfn/http` | own issue under SFN-646 |
| `cp -a`, `rm -rf`, `timeout` (`dev_det_sweep.sfn:193-213`) | not one of SFN-495's four commands; `cp -a` also wants timestamp preservation `copy_tree` does not do | own issue under SFN-646 |
| `pwd` (`dev_clean.sfn:202`, `dev_det_sweep.sfn:183, 366`) | `_cwd_cmd` will exist; the migrations are theirs | own issues |
| `uname -m` on POSIX (`toolchain.sfn:159`, and the arch leg here) | a native POSIX arch probe is its own problem (SFN-857 says so explicitly) | own issue |

**Leave the `tar` sites completely alone** — do not add a `host_is_windows()`
pre-flight. The existing `tar_rc != 0` branch already prints
`sfn package: tar failed (exit=N)`, which is accurate; a guard would be a
second thing to delete when SFN-753 lands. Instead add **one line** to
`package.sfn`'s module header stating that `sfn package` remains unusable on
native Windows until SFN-753, so nobody reads this migration as having finished
the job.

#### 3.6.1 The `date -u` successor issue

A pure function, `unix_millis -> "YYYY-MM-DDTHH:MM:SSZ"` (a days-from-civil
inverse). It genuinely belongs elsewhere: it is pure and unit-testable in
isolation, it has **multiple** consumers (three `package.sfn` sites and
SFN-754's cache-mtime formatting), and it has nothing to do with de-shelling
the filesystem. This is a legitimate split under
`.claude/rules/seed-dependency.md`'s multiple-consumers clause, not a
manufactured one. Until it lands, `manifest.build_date` is `""` on Windows —
which is what it already is today.

## 4. Effect & capability impact

None. Every replacement is `![io]`, exactly like the `process.run` it displaces.
No new effect, no taxonomy change, no manifest change. `copy_tree`,
`_file_size_of` and `_cwd_cmd` are all `![io]`; every caller already declares
it.

One incidental improvement: `process.run` spawning an arbitrary named binary is
a broader capability than `fs.*` on a known path. Replacing ~60 spawns with
direct filesystem calls narrows the compiler's own reach — the Reach pillar
applied to the toolchain itself.

## 5. Self-hosting impact

**No compiler pass changes. No seed cut. No split forced.**

Verified against the pinned seed
(`bootstrap.toml [seed].version = "0.9.5"`) by reading its own registry:

```
git show v0.9.5:compiler/src/llvm/runtime_helpers/registry_services.sfn
```

carries rows for `fs.deleteFile`, `fs.createDirectory`, `fs.removeDirectory`,
`fs.set_perms`, `fs.get_perms`, `fs.mkdtemp`, `fs.is_executable`, **`fs.symlink`**,
`fs.read_link`, and **`fs.is_directory`**. Every `fs.*` call this proposal adds
therefore lowers correctly under the seed that compiles `compiler/src`.

`_cwd_cmd`'s `realpath` is a plain libc extern, which
`compiler/src/build/fs.sfn:10-17` documents as resolving against the pinned
seed with no seed cut — the same reason `mkstemp`/`fopen`/`memcpy` are declared
there. `_file_size_of` introduces no extern at all (it reuses `fopen`/`fread`/
`ferror`/`fclose`/`malloc`/`free`, all already declared in that module).

The runtime-source carve-out in `.claude/rules/seed-dependency.md` **does not
apply**: nothing here is runtime source calling a compiler capability the seed
lacks. All consumers are compiler source, compiled by the seed, calling
registry rows the seed already has.

### 5.1 The one real dependency: SFN-756 must merge first

`copy_tree` calls `fs.is_directory`, which lowers to the runtime symbol
`sfn_fs_is_directory`. That wrapper does not exist in `main` yet — it is
uncommitted on `claude/sfn-756-wire-fs-is-directory`
(`runtime/sfn/adapters/filesystem.sfn:587-589`). Without it, `copy_tree`
**link-fails on an undefined `sfn_fs_is_directory`**.

**This is a merge-order dependency on `main`, not a seed gate.** The runtime is
compiled from the *working tree* by the pinned seed
(`_compile_runtime_sfn_sources`, `compiler/src/build/runtime_objs.sfn`), and
the seed already carries both the `sailfin_intrinsic_fs_is_directory` sentinel
(SFN-755, `registry_platform.sfn:317-319`) and the `fs.is_directory` services
row. So the wrapper only has to reach `main`; it does not have to reach a
release.

The SFN-756 working-tree diff to `registry_services.sfn` states the general
rule and confirms this reading: the services row had to reach a *released seed*
before any call site could exist, and it did (0.9.5). This proposal is the
"call site now exists" half.

### 5.2 The feasibility probe — resolved, no probe needed

This section originally called for a probe on the grounds that `fs.symlink`
**"has never had a call site anywhere in the tree."** That is not correct, and
the probe it motivated is unnecessary.

`stdlib/fs/tests/fs_test.sfn` exercises it directly at `:137`, `:152`,
`:170`, `:184`, and `:200` — creating a link, reading through it, a dangling
link (POSIX permits one), the `EEXIST` rejection, and a relative target —
plus `remove_test.sfn:100`. The whole file passed 18/18 during SFN-756
validation on 2026-08-14, so the wrapper, the row, and the sentinel are proven
end-to-end on POSIX by live coverage, not merely declared.

What that coverage does **not** establish is the Windows leg, where
`fs.symlink` is a hard `false` stub. §3.4's design already handles that
correctly by branching on the **return value** rather than the host, so the
copy fallback is reached on any host or filesystem that refuses a link. No
predecessor issue, no split.

Everything else in this design has a live in-tree call site already:
`fs.set_perms` (`source_fingerprint.sfn:239`), `fs.get_perms`
(`cli_selfhost.sfn:444`), `fs.is_directory` (`fs_tree.sfn:110`, via SFN-756),
`fs.deleteFile`/`fs.createDirectory`/`fs.removeDirectory`/`fs.listDirectory`
(throughout `fs_tree.sfn`).

## 6. Alternatives considered

**Keep `process.run(["cp", "-R", …])` and ship a `cp.exe` with the toolchain.**
Rejected: shipping GNU coreutils to make a self-hosted compiler work contradicts
the "no fixup scripts, pure Sailfin toolchain" goal in CLAUDE.md, and it
converts a code problem into a distribution problem.

**Gate the argv sites on `host_is_windows()` and skip them, like
`_shell_read_cmd` does.** Rejected: `_shell_read_cmd`'s degrade is sound
because its callers are *probes* whose `""` means "unknown". Skipping a `cp` or
a `mkdir` does not degrade — it produces a silently incomplete artifact, which
is strictly worse than failing. §2.2 shows the degrade already misbehaves at
the one site whose caller does not honour the contract.

**Put `copy_tree` in the `sfn/fs` capsule instead of `build/fs_tree.sfn`.**
Rejected for now: `sfn/fs` is a public user-facing capsule, so its surface is
an API commitment, and the compiler cannot import a capsule the bootstrap path
does not already resolve. `build/fs_tree.sfn` is where `remove_tree` and
`walk_dirs` live, shares the bounds constants, and shares the classification
rationale header. Promoting the family to `sfn/fs` once the semantics have a
consumer or two is a reasonable post-1.0 move (§9).

**Preserve symlinks in `copy_tree` via `fs.read_link`.** Rejected: not
expressible. `fs.read_link` returns `""` for a non-symlink *and* for a failure,
so it cannot classify; there is no `lstat` and no `is_symlink`. Adding one is a
new intrinsic and therefore a seed cut, for a fidelity nobody in scope needs
(no source tree contains a symlink).

**Best-effort `copy_tree` that continues past failures and reports a count.**
Rejected: every caller wants "did the whole thing land?" before tarring a
release artifact. A count would just be re-derived into a boolean at each site,
with a partial tarball as the cost of getting it wrong.

**`fseek`/`ftell` for `_file_size_of`.** Rejected — see §3.2 (32-bit `long` on
Win64).

**One `host_is_windows()` gate around the symlink creation** instead of
branching on `fs.symlink`'s return. Rejected: the capability check is strictly
more general, covers a POSIX filesystem without symlink support, and leaves
nothing to delete when the Windows stub is replaced.

## 7. Stage1 readiness mapping

- [ ] Parses — no new syntax; existing constructs only
- [ ] Type-checks / effect-checks — all new functions `![io]`; `sfn check` on
      the touched files
- [ ] Emits valid `.sfn-asm` — no new emit path
- [ ] Lowers to LLVM IR — all lowering via registry rows already in the seed
      (§5)
- [ ] Regression coverage — §8
- [ ] Self-hosts — `make compile`; `make clean-build` first if `fs_tree.sfn`'s
      export list changes
- [ ] `sfn fmt --check` clean
- [ ] Documented — `docs/status.md` de-shelling tracker row; the `fs_tree.sfn`
      module header rewrite (§3.1.2, §3.1.3, §3.1.5) is the primary
      documentation artifact

## 8. Test plan

**Unit — `compiler/tests/unit/fs_tree_test.sfn`** (extends the existing 18
tests; use the established `fs.mkdtemp` scratch-root pattern):

- `fs_tree: copy_tree copies a nested tree` — verify every file's content at
  the destination
- `fs_tree: copy_tree with a file source copies one file`
- `fs_tree: copy_tree creates the destination as the tree root, not a container`
  — pins the `cp -R src dst`-where-dst-absent shape (§3.1)
- `fs_tree: copy_tree merges into an existing destination` — pins the
  documented merge semantics
- `fs_tree: copy_tree on a nonexistent source returns false`
- `fs_tree: copy_tree refuses a destination inside the source`
- `fs_tree: copy_tree refuses an empty path`
- `fs_tree: copy_tree preserves a file's executable bit` — `fs.set_perms(src,
  493)`, copy, `assert fs.is_executable(dst)`; mirrors
  `selfhost_diff_test.sfn:256-268`. Skip on Windows (`fs.get_perms` is a `-1`
  stub)
- `fs_tree: copy_tree copies an empty directory` — the SFN-756 property
  `walk_dirs` gained; `fs.listDirectory`-based classification would have
  dropped it

**Unit — `compiler/tests/unit/` for the fs.sfn helpers:**

- `fs: _file_size_of reports the byte count of a file`
- `fs: _file_size_of returns 0 for a missing file`
- `fs: _cwd_cmd returns an absolute path` — assert non-empty and rooted (POSIX
  `/` or a drive letter)

**E2E — existing oracles, mostly unchanged:**

- `compiler/tests/e2e/sfn_package_test.sfn` — all six tests must pass
  byte-identically. This is the parity oracle `package.sfn:11-12` names.
- `compiler/tests/e2e/config_test.sfn:191` and
  `compiler/tests/e2e/login_test.sfn:141` already assert
  `fs.get_perms(...) == 448 / 384` — **already the right oracle**, no rewrite
  needed. Add a `host_is_windows()` skip to both, since `fs.get_perms` returns
  `-1` there (§3.4).
- `compiler/tests/e2e/dev_bootstrap_test.sfn` — unchanged.

**Windows-host leg:** `compiler/tests/unit/windows_build_deshell_test.sfn`
already drives Windows-host branches on a Linux runner via the
`SAILFIN_HOST_OS` seam (see its header, lines 1-31, and
`toolchain_host_detect_test.sfn:6-12`). Add cases there for the
`chmod`-short-circuit and the `_package_detect_target` Windows arm rather than
inventing a new mechanism.

**Commands:**

```
sfn fmt --write <touched files> && sfn fmt --check <touched files>
sfn check compiler/src/build/fs_tree.sfn compiler/src/build/fs.sfn \
          compiler/src/cli/commands/package.sfn \
          compiler/src/cli/commands/dev.sfn \
          compiler/src/cli/commands/config.sfn \
          compiler/src/cli/commands/login.sfn
make clean-build          # fs_tree.sfn's export list changes
make compile
build/bin/sfn test compiler/tests/unit/fs_tree_test.sfn
build/bin/sfn test compiler/tests/e2e/sfn_package_test.sfn
build/bin/sfn test compiler/tests/e2e/config_test.sfn
build/bin/sfn test compiler/tests/e2e/login_test.sfn
build/bin/sfn test compiler/tests/e2e/dev_bootstrap_test.sfn
build/bin/sfn test compiler/tests/unit/windows_build_deshell_test.sfn
make check                # before shipping
```

## 9. Sequencing

**Recommendation: two issues, split by risk class, not by capability.** Neither
gates the other; they touch disjoint files and can land in either order or in
parallel. Neither creates a seed cut. If the owner prefers a single PR, nothing
breaks — but 60 edits plus a new bounded-traversal primitive plus its unit
tests is more than one review should carry, and `remove_tree` (SFN-494) was its
own PR at half the size.

### Issue A — `copy_tree` + `package.sfn` (size M)

The capability bundled with its consumers, per
`.claude/rules/seed-dependency.md`'s default. `copy_tree` has three call sites,
all in `package.sfn`, all in the same session.

Scope: `copy_tree` (§3.1), `_file_size_of` (§3.2), the 51 `package.sfn` sites
(§3.5), the entry-wipe check (§3.5.1), the `fs_tree.sfn` header rewrite, the
`package.sfn` header line about SFN-753.

Acceptance:
- `copy_tree` exported from `build/fs_tree.sfn`; the "deliberately still
  absent" paragraph at `fs_tree.sfn:34-36` is **deleted**, and the header gains
  the classification, symlink-divergence, and bound-returns-false paragraphs
- no `process.run(["mkdir"|"rm"|"cp", …])` remains in `package.sfn`; `tar` and
  `date` remain and are the only shell spawns left
- `_package_size_of_file`'s decimal parser (`package.sfn:787-806`) and the
  `_shell_single_quote_arg` import are gone
- `_package_detect_target` returns a target on a Windows host
- the nine `copy_tree` unit tests pass; `sfn_package_test.sfn` passes unchanged
- `make compile` after `make clean-build`

### Issue B — `config`, `login`, `dev bootstrap` (size S)

Scope: the four `chmod` sites, the two `ln -sfn` sites plus `mkdir -p`, the
`pwd` site, `_cwd_cmd` (§3.3), the absoluteness fix (§3.4), the two e2e host
gates, the `login.sfn` header qualifier, and the
`capsule_emit_parallel.sfn:650` one-liner (§3.5).

**No probe needed** — §5.2's premise was wrong; `fs.symlink` has live passing
coverage. Start directly.

Acceptance:
- `fs.set_perms` replaces all four `chmod` spawns; POSIX failure policy per
  command is unchanged; Windows short-circuits to success **and `sfn login`
  prints the not-access-restricted notice naming SFN-884** (§3.4)
- `_bootstrap_link_bin` produces a symlink on POSIX and a copy on a host that
  refuses one, and is idempotent across re-runs
- `_cwd_cmd` exported from `build/fs.sfn` and consumed by
  `_bootstrap_abspath`; `dev_clean.sfn` / `dev_det_sweep.sfn` are **not**
  touched
- `config_test.sfn`, `login_test.sfn`, `dev_bootstrap_test.sfn` pass; the two
  permission tests carry a Windows skip
- `make compile`

### Follow-up issues to file

1. **Epoch→civil timestamp formatting** (§3.6.1) — unblocks `date -u` here and
   SFN-754's mtime formatting.
2. **NTFS ACL restriction for `~/.sfn/credentials`** — post-1.0; today the
   credential file is unprotected on Windows and the code should say so.
3. **Unify `_detect_os`/`_detect_arch` into `build/target.sfn`** (§3.4) — the
   two release-token vocabularies are already identical.
4. **A shared `is_absolute_path` helper** — `module_paths.sfn:73-84` and
   `main.sfn:325-338` inline the same drive-letter logic twice, and
   `_bootstrap_abspath` would be the third.
5. **A native POSIX arch probe** to retire the last `uname -m` — SFN-857
   deferred it explicitly.

## 10. Risks

| Risk | Mitigation |
|---|---|
| `fs.symlink` has never had a consumer; the first one may hit an ABI/link surprise | the §5.2 probe, before Issue B starts; the copy fallback means the failure mode is degraded, not broken |
| `copy_tree` diverges from `cp -R` on symlinks | no source tree in scope contains one (verified); the divergence is stated in the module header, not implied |
| `import-context` is 1813 files / 54 dirs — 3× the syscalls of one `cp -R` fork | well inside the 16/200000 bounds (measured max depth 5); `_copy_file`'s 64 KiB chunking keeps peak RSS flat; a fork saved offsets much of it |
| SFN-756 not merged when Issue A starts | hard link failure on `sfn_fs_is_directory`, immediately visible at `make compile`; not silent |
| The entry-wipe check (§3.5.1) turns a previously-silent condition into a hard failure | that is the point — a failed wipe currently bleeds a prior run into a release tarball; if it fires spuriously the message names the path |
| `sfn package` still cannot run on Windows after this lands | stated in the `package.sfn` header (§3.6); this removes ~51 of 57 blockers and leaves one named successor |

## 11. References

- SFN-495 — `refactor(cli): de-shell the local filesystem CLI commands`
- SFN-646 — the de-shelling inventory (corrected in §2.2)
- SFN-756 — `fs.is_directory` callable from Sailfin source (§5.1)
- SFN-755 — the `fs.is_directory` intrinsic sentinel
- SFN-494 — `remove_tree` / `walk_dirs` / `ensure_dir_p`, the shape this follows
- SFN-753 — in-process `.tar.gz`
- SFN-754 — the cache mtime reader
- SFN-478, SFN-549, SFN-857 — prior native-Windows de-shelling waves and the
  `host_is_windows()` gate pattern
- SFN-46 — `fs.read_link`
- `.claude/rules/seed-dependency.md` — the bundle-vs-split decision applied in
  §5 and §9
- `compiler/src/build/fs_tree.sfn`, `compiler/src/build/fs.sfn`,
  `compiler/src/build/target.sfn`, `runtime/sfn/adapters/filesystem.sfn`,
  `compiler/capsules/codegen-llvm/src/runtime_helpers/registry_services.sfn`,
  `compiler/capsules/codegen-llvm/src/runtime_helpers/registry_platform.sfn`
