---
sfep: 0071
title: In-Process .tar.gz Reader and Writer (sfn/archive)
status: Accepted
type: tooling
created: 2026-08-15
updated: 2026-08-15
author: "agent:compiler-architect; human review"
tracking: SFN-753
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0071 — In-Process `.tar.gz` Reader and Writer (`sfn/archive`)

## 1. Summary

Add a new pure-Sailfin library capsule, `sfn/archive`, implementing CRC-32
(RFC 1952 §8), DEFLATE decompression and compression (RFC 1951), gzip framing
(RFC 1952), and POSIX ustar archive reading and writing — with a mandatory
path-traversal guard on extraction. The capsule retires every `process.run`
invocation of external `tar` from the toolchain: one read site
(`compiler/src/cli/commands/toolchain.sfn:418`) and three write sites
(`compiler/src/cli/commands/package.sfn:259`, `:586`, `:759`). It introduces no
new builtin, no new intrinsic, and no compiler-pass change, so it lands without
a seed cut. Beyond removing the last hard dependency blocking a shell-free
native Windows toolchain, it makes `sfn package` output **byte-reproducible**:
the writer stores computed canonical modes and zeroed mtime/uid/gid rather than
host observations, so the same tree yields the same archive bytes and the
`.sha256` sidecar becomes a real content identity rather than a per-build
accident.

## 2. Motivation

### 2.1 The Windows bootstrap is broken at the unpack step

`sfn toolchain install` downloads a release asset, verifies its signed manifest
and SHA-256 digest, and then shells out:

```
compiler/src/cli/commands/toolchain.sfn:418
    let tar_rc = process.run(["tar", "-xzf", tarball, "-C", extract_dir]);
```

Native TLS shipped (SFN-340/341/808/811/824), so the *fetch* half is already
in-process — `_download_to` at `toolchain.sfn:252` is a thin wrapper over
`http.download` with no `curl`. `tar` is the only remaining external program on
the seed-acquisition path. A Windows user who cannot unpack a seed cannot
bootstrap at all, so this single `process.run` is the critical-path blocker for
the chain `SFN-753 → SFN-493 (de-shell seed acquisition) → SFN-57 (native
Windows seed + release leg) → SFN-55/SFN-58`.

The writer side is symmetric and already flagged in-tree
(`compiler/src/cli/commands/package.sfn:86`): "native Windows host: the three
`tar -czf` sites remain unmigrated pending in-process `.tar.gz` writing
(SFN-753)."

### 2.2 The restriction-vs-power test

Removing a dependency is, on its own, a *restriction* — it forbids something
(spawning `tar`) and hands the payer nothing. Two attached powers make this
proposal pass the test in `CLAUDE.md`:

- **A stock-Windows install runs the whole toolchain.** No MSYS, no Git Bash, no
  `System32\tar.exe` version roulette. That is a product capability, not a
  policy.
- **Reproducible artifacts.** `tar -czf` stores the host mtime in every ustar
  header *and* in the gzip MTIME field, so two builds of an identical tree
  produce different bytes and different digests. Our writer computes what it
  stores (§3.7), so `sfn package` output is bit-identical across rebuilds and
  hosts. That is the "same program yields the same bits" pillar applied to the
  distribution artifact.

### 2.3 Why the status quo cannot be patched

`tar.exe` has shipped in Windows since 10 1803, and invoking it was the obvious
cheap fix. **The owner has ruled for full self-containment; the external-tar
option is retired, not deferred** (§6.1). It was rejected on product grounds — a
stock-Windows install must run the whole toolchain — not on pillar grounds:
`tar` was never on the `sfn build -p compiler` path, so it never contaminated a
capability manifest.

## 3. Design

### 3.1 Placement: a library capsule, not runtime source

`sfn/archive` lands at `capsules/sfn/archive/`, modelled on
`capsules/sfn/crypto/` — pure Sailfin, `capsule.toml` with
`[build] entry = "src/mod.sfn"` and `kind = "library"`, tests in a sibling
`tests/` directory.

Three facts settle this against the `runtime/` alternative:

1. **No new compiler capability is required** (§3.2), so the seed-dependency
   carve-out in `.claude/rules/seed-dependency.md` — runtime source that *calls*
   a compiler capability the seed lacks must land alone, `seed-blocker` — does
   not apply and must not be invited. Runtime source is compiled by the **pinned
   seed**; capsule source is compiled by the freshly built compiler in the same
   `make compile` pass. Choosing `runtime/` would convert a zero-gate change
   into a seed-gated one for no benefit.
2. **Link surface.** `compiler/src/build/runtime_selection.sfn` selects runtime
   modules per program; capsule modules are staged only when reachable
   (`compiler/src/capsule_resolver/reachability.sfn:166-168` — a bare capsule
   spec names only the entry module, and SFN-833 filters the rest). A program
   that never imports `sfn/archive` pays nothing.
3. **Test discovery is free.** `make test-capsules`
   (`Makefile:420-435`) walks every nested `tests/` directory under `capsules/`,
   and `workspace.toml:22-27` declares members as `capsules/sfn/*` — a glob the
   pinned seed already expands
   (`capsule_resolver/workspace.sfn::_cr_expand_member_globs`). **A new capsule
   under `capsules/sfn/` needs no `workspace.toml` edit and no `Makefile` edit.**

The one manifest change outside the capsule is a dependency row in
`compiler/capsule.toml` (§5.2).

#### Module layout

```
capsules/sfn/archive/
  capsule.toml
  src/mod.sfn          // barrel: the public API and nothing else
  src/bytes.sfn        // libc-backed byte buffer + cursor; the only unsafe interior
  src/error.sfn        // ArchiveError + ArchiveErrorKind
  src/crc32.sfn        // RFC 1952 §8 CRC-32, table-driven
  src/inflate.sfn      // RFC 1951 decompressor (stored / fixed / dynamic)
  src/deflate.sfn      // RFC 1951 compressor (fixed Huffman + greedy LZ77)
  src/gzip.sfn         // RFC 1952 framing, read + write
  src/ustar.sfn        // header encode/decode, checksum, typeflags, GNU/PAX
  src/path_guard.sfn   // the extraction path policy — pure, no ![io]
  src/tar_read.sfn     // streaming iteration + extraction to disk  ![io]
  src/tar_write.sfn    // tree walk + archive creation               ![io]
  tests/*_test.sfn
```

The layering is load-bearing, not cosmetic: `crc32` + `deflate` + `inflate` are
exactly the pieces a future `.zip` container or an `sfn/http`
`Content-Encoding: gzip` path would reuse unchanged (§10).

Every module stays inside the ~1,500-line soft budget
(`.claude/rules/code-style.md`); `inflate.sfn` is the largest at an estimated
~800 lines.

### 3.2 No new builtin, no new intrinsic — verified

The capsule needs three things the language does not give it directly: read a
byte at a raw address, write a byte at a raw address, and read/write a file as
bytes rather than as a NUL-terminated `string`. All three have proven,
already-in-tree spellings that resolve against the pinned **0.9.5** seed
(`bootstrap.toml:16`):

| Need | Spelling | Proven at |
|---|---|---|
| Byte read | `load_byte(addr: int) -> int` builtin | `runtime/sfn/string.sfn:126`; lowering at `compiler/capsules/codegen-llvm/src/byte_load.sfn`. Seed 0.7.0-alpha.41 carries it, so 0.9.5 does. |
| Byte read (fallback) | `sailfin_intrinsic_pointer_read_i32(ptr) & 255` | `capsules/sfn/crypto/src/rand.sfn:57` — **from capsule code**. Over-reads 3 bytes, so the buffer carries 4 bytes of slack (same file, `:38-41`). |
| Byte write | `memset(p, value, 1)` via `extern fn memset` | `capsules/sfn/os/src/mod.sfn:296` — from capsule code. |
| Byte write (faster) | masked word RMW on `*i64` | `runtime/sfn/string.sfn:890` (`_num_put_byte`). Requires 8-aligned, multiple-of-8 storage — the `owned_buf_new` discipline. |
| File bytes in/out | `extern fn fopen/fread/fwrite/fclose/malloc/realloc/free` | `compiler/src/build/fs.sfn:774-858` (`_read_file_bytes`); `capsules/sfn/crypto/src/rand.sfn:30-32` declares `malloc`/`free` from a capsule. |

A plain `extern fn` over a libc symbol resolves against the pinned seed and
needs no seed cut; a new builtin is a compiler-emitted sentinel plus a registry
row the seed cannot resolve (`E0420`) and *would* force one. That reasoning is
already written down at `compiler/src/build/fs.sfn:9-17`, and this design
follows it exactly.

**Implementation step 0 is a feasibility probe, not an assumption.** `load_byte`
and the masked-word-store idiom have never been spelled from *capsule* source —
only from `runtime/` and `compiler/src/`. Phase A1 opens with a throwaway
capsule module that calls both and runs `sfn check` on it. If either does not
resolve from a capsule, the fallbacks in the table above are already proven from
capsule code (`rand.sfn`), so the outcome is a constant-factor difference, never
a blocker and never a seed-blocker predecessor.

### 3.3 The byte container: `ByteBuf`, not `int[]`

`int[]` is what `sfn/crypto` uses for binary (`string_to_bytes` at
`capsules/sfn/crypto/src/bits.sfn:19`), and it is the right call there — hash
inputs are small. It is the wrong call here: an `int` element is 8 bytes, so a
100 MB member costs 800 MB before `push` growth copies, against a shared 8 GiB
process cap (`.claude/rules/compiler-safety.md`).

`src/bytes.sfn` defines a libc-backed buffer addressed by `i64`, mirroring the
`OwnedBuf` shape at `runtime/sfn/memory/ownedbuf.sfn:114-119` (capsules already
re-declare that struct locally — `capsules/sfn/os/src/mod.sfn:77`,
`capsules/sfn/http/src/server.sfn:50` — so re-declaring is the house pattern,
not a new one):

```sfn
// A growable, libc-backed byte buffer. `addr` is the storage address (an
// unsafe interior — never handed out past the owner), `len` the bytes
// written, `cap` the bytes allocated. Capacity is always a multiple of 8
// with 8 bytes of slack past `cap`, so a masked word store at any index is
// in-bounds — the `owned_buf_new` discipline (ownedbuf.sfn file header).
struct ByteBuf {
    addr: i64;
    len: int;
    cap: int;
}

// A non-owning read cursor over a byte range. `pos` is the read offset;
// bounds are checked on every access, so a truncated archive errors instead
// of reading past the allocation.
struct ByteCursor {
    addr: i64;
    len: int;
    pos: int;
}
```

Ownership is manual (`bytes_free`), matching `capsules/sfn/os::owned_buf_free`
and `capsules/sfn/crypto/src/rand.sfn`'s `malloc`/`free` discipline. Every
public entry point owns its allocations end to end and frees on every exit path
including errors; no `ByteBuf` crosses the capsule boundary. SFEP-0064's
reclamation seam is the eventual home for this discipline, not a prerequisite.

`int[]` interop stays available at the test boundary only
(`bytes_from_int_array` / `bytes_to_int_array`), so published RFC vectors can be
written as literal arrays.

### 3.4 API shape: streaming, with whole-buffer helpers for vectors

Peak memory must not scale with archive size. The seed tarball is small (~4.4 MB
binary, 6.1 MB unpacked for 0.9.5) but `sfn package` trees are unbounded, and
the fan-out budgets in `.claude/rules/compiler-safety.md` leave no room for an
archive-sized transient.

tar is strictly sequential — a 512-byte header, then `ceil(size/512)*512` bytes
of body — and DEFLATE is a streaming format with a 32 KiB history window. So the
whole pipeline streams with **O(window + chunk) ≈ 100 KiB peak, independent of
archive size**. The extraction path never materializes a member in memory; it
copies decompressed bytes straight to the output `FILE*` in 64 KiB chunks.

Public surface (`src/mod.sfn`). **Every export carries a module prefix.**
Imported names are matched without provenance across the compiler tree — that is
why `sfn/http` is deliberately *not* a compiler dependency, because its `get`
collides with `sfn/cli`'s (`compiler/capsule.toml:63-68`, revisit at SFN-893).
A bare `extract` or `create` from this capsule would be the same landmine.

```sfn
// --- Streaming primitives -------------------------------------------

// Open `path` as a gzip stream. Holds the FILE*, a 64 KiB input chunk, a
// 32 KiB history window, and the inflate state. The caller closes with
// `gzip_reader_close`, which is safe to call on a failed open.
fn gzip_reader_open(path: string) -> Result<GzipReader, ArchiveError> ![io];

// Fill up to `n` decompressed bytes at `dst`. Returns the count read, `0`
// at end of stream, and an error for a corrupt or truncated stream — a
// short read is never silently treated as EOF.
fn gzip_read(r: GzipReader, dst: i64, n: int) -> Result<int, ArchiveError> ![io];

fn gzip_reader_close(r: GzipReader) -> void ![io];

fn gzip_writer_open(path: string, opts: DeflateOptions) -> Result<GzipWriter, ArchiveError> ![io];

fn gzip_write(w: GzipWriter, src: i64, n: int) -> Result<int, ArchiveError> ![io];

// Flush the final block, then the CRC-32 and ISIZE trailer. A writer
// dropped without `gzip_writer_finish` leaves an invalid stream, so the
// tar layer finishes on every exit path.
fn gzip_writer_finish(w: GzipWriter) -> Result<int, ArchiveError> ![io];

// --- Archive layer ---------------------------------------------------

// Extract `archive_path` beneath `dest_dir`. Every member is checked
// against the path policy (§3.6) before any filesystem call; the first
// rejection aborts and leaves no further members written. Returns a
// summary the caller can print.
fn targz_extract(archive_path: string, dest_dir: string, opts: ExtractOptions)
    -> Result<ExtractSummary, ArchiveError> ![io];

// Create `archive_path` from `root_dir`. `entries` are paths relative to
// `root_dir`; an empty list means the whole tree. Members are emitted in
// the given order, or in sorted order for a whole-tree walk, so the output
// is reproducible.
fn targz_create(archive_path: string, root_dir: string, entries: string[], opts: CreateOptions)
    -> Result<CreateSummary, ArchiveError> ![io];

// List members without writing anything. Backs `sfn package --list` and
// the interop tests.
fn targz_list(archive_path: string) -> Result<ArchiveEntry[], ArchiveError> ![io];

// --- Pure codec layer (no effects — this is why it is separated) -----

fn crc32(cursor: ByteCursor) -> int;

fn inflate_all(src: ByteCursor, max_output: int) -> Result<ByteBuf, ArchiveError>;

fn deflate_all(src: ByteCursor, opts: DeflateOptions) -> Result<ByteBuf, ArchiveError>;

fn ustar_decode_header(block: ByteCursor) -> Result<UstarHeader, ArchiveError>;

fn ustar_encode_header(h: UstarHeader, out: ByteBuf) -> Result<ByteBuf, ArchiveError>;

// Validate a member name against the extraction path policy. Pure, so the
// whole rejection table is a unit test with no filesystem.
fn archive_check_member_path(name: string, host_is_windows: boolean)
    -> Result<string, ArchiveError>;
```

`inflate_all` / `deflate_all` take an explicit `max_output` / implicit cap and
exist for RFC vectors and small in-memory uses. They are **not** what `targz_*`
call.

Options and summaries:

```sfn
struct ExtractOptions {
    // Materialize symlink members as copies instead of links. Forced true
    // on Windows, where `fs.symlink` is a documented no-op (§3.5).
    copy_instead_of_link: boolean;
    // Apply stored permission bits via `fs.set_perms`. No-op on Windows.
    apply_modes: boolean;
    // Refuse an archive whose total decompressed size exceeds this, so a
    // decompression bomb fails closed rather than filling the disk.
    max_total_bytes: int;
    max_members: int;
}

struct CreateOptions {
    // Paths (relative to `root_dir`) to mark executable regardless of what
    // the host reports. `sfn package` knows its binaries; Windows cannot
    // answer `access(X_OK)` meaningfully.
    exec_paths: string[];
    link_policy: LinkPolicy;   // Preserve | Dereference
    deflate: DeflateOptions;
}

struct DeflateOptions {
    // `Fixed` today; `Dynamic` is the §6.7 follow-up and changes no
    // signature. `Stored` exists for the incompressible fallback and for
    // debugging a suspected encoder bug against a known-good container.
    strategy: DeflateStrategy;
}
```

### 3.5 Symlink and hard-link policy

The seed tree ships a real symlink `sfn -> sailfin` (ustar typeflag `2`), and
Windows cannot create one without elevation or Developer Mode. SFN-493 already
states the intent: prefer a copy over a link on that host.

**Reading (typeflag `2`, symlink):**

- The link target is validated by the *same* path policy as the member name
  (§3.6). An absolute target, a target containing a `..` component, or an empty
  target is a **hard error** — not a skip. Extracting a link to `/etc` from a
  downloaded archive is precisely the escalation the guard exists to stop.
- On POSIX with `copy_instead_of_link == false`: `fs.symlink(target, path)`
  (`capsules/sfn/fs/src/mod.sfn:147`).
- On Windows, or with `copy_instead_of_link == true`: copy the target's bytes.
  Because tar order is not guaranteed to place the target before the link,
  link members are **deferred** — collected during the main pass and replayed
  after it. A target still missing after the deferred pass is a **hard error**,
  never a dangling stub: a seed store whose `sfn` is missing is a silent
  bootstrap break, and silence is the worst outcome here.

**Reading (typeflag `1`, hard link):** treated identically to a symlink under
`copy_instead_of_link` semantics on *every* host — the target's content is
copied. We never produce hard links, copying is always correct by content, and
this avoids `link(2)` entirely.

**Writing:**

- `LinkPolicy.Preserve` (default): a symlink whose target is relative and
  escape-free is emitted as typeflag `2` with `size = 0` and the target in the
  `linkname` field. An absolute or escaping target is a **hard error** — we
  refuse to write an archive our own extractor would reject.
- `LinkPolicy.Dereference`: the pointed-to content is written as a regular file.
  This is what a Windows staging tree produces naturally, since the links there
  are already copies.
- Hard links are never emitted; a second path to the same inode becomes a second
  regular member. We do not stat inodes.

Symlink detection on the write path uses `fs.read_link`
(`capsules/sfn/fs/src/mod.sfn:155`, `readlink(2)`, `""` for a non-symlink) —
`fs.is_directory` follows symlinks and cannot answer this.

### 3.6 The extraction path policy (mandatory)

Extraction runs with the user's privileges over content fetched from the
network. The policy is enforced in `src/path_guard.sfn`, is **pure** (so its
whole rejection table is a unit test with no filesystem), and runs on the raw
header bytes **before any filesystem call**.

A member name — and any link target that will be materialized — is accepted
only if all of the following hold:

1. Non-empty after ustar `prefix` + `/` + `name` joining, and at most 4096 bytes.
2. Contains no NUL byte within the joined name (ustar fields are NUL-padded; the
   name is the bytes up to the first NUL — a NUL *after* that point is padding
   and fine, a NUL *inside* is a truncation attack).
3. Not absolute: does not begin with `/`; does not begin with `\`; does not begin
   with `\\` (UNC); and byte 1 is not `:` (a drive-letter prefix such as `C:x`).
   The Windows-shaped checks run on **every** host — an archive is extracted on
   whatever host downloads it, and a rule that only fires on Windows is a rule
   that was not tested on Linux.
4. Contains no `\` anywhere. Rejected outright rather than normalized: `a\..\..\x`
   splits into one component under a POSIX-only `/` split, passes rule 5, and
   then escapes on Windows.
5. Split on `/`: no component equals `..`. Components equal to `.` and empty
   components (from `//`) are dropped. A trailing `/` is accepted only for
   typeflag `5`.
6. On Windows only: no component is a reserved device name — `CON`, `PRN`, `AUX`,
   `NUL`, `COM1`–`COM9`, `LPT1`–`LPT9` — compared case-insensitively and ignoring
   any extension. Accepted on POSIX, where they are ordinary names.
7. After joining to `dest_dir`, the result is lexically beneath `dest_dir`.
   Rules 3–5 already guarantee this; the check runs anyway and a failure is
   reported as an internal invariant violation, because a guard that can only
   be right is a guard nobody notices going wrong.
8. Parent directories are created without following an existing symlink. Combined
   with the §3.5 rule that a symlink member's target may not escape, this closes
   the "member `a` is a symlink to `/etc`, member `a/b` writes through it" hole
   that rules 1–7 alone do not.

**Deliberately not used: `sfn/path::normalize`** (`capsules/sfn/path/src/mod.sfn:93`).
A normalizer's job is to collapse `..` into a shorter path; the guard's job is
to notice `..` and refuse. Routing a security check through a convenience
function that resolves the thing being checked is how these bugs happen. The
capsule declares no dependency on `sfn/path`.

**Error surface.** The capsule returns `Result<T, ArchiveError>` — **not** a
`Diagnostic`. A `Diagnostic` carries an `E0xxx` code and a source span over
*user source* (`.claude/rules/code-style.md`); a downloaded tarball is neither.
`Result<T, string>` is the established capsule convention
(`capsules/sfn/crypto/src/aead_aes_gcm.sfn:119`), and this is the structured
version of it:

```sfn
enum ArchiveErrorKind {
    Io,
    Truncated,
    BadMagic,
    BadChecksum,
    UnsupportedFeature,
    CorruptStream,
    PathRejected,
    LinkRejected,
    LimitExceeded,
}

struct ArchiveError {
    kind: ArchiveErrorKind;
    // Human-readable, already fully specific — the CLI prints it verbatim.
    message: string;
    // The offending member name, or "" for a stream-level failure.
    member: string;
    // Byte offset into the archive, or -1 when not meaningful.
    offset: int;
}
```

The **CLI consumer** owns the user-facing code. `compiler/src/cli/commands/toolchain.sfn`
renders any `ArchiveError` from an install-path extraction as **`E0615`** —
"archive member rejected or archive malformed during toolchain extraction". The
`E05xx`–`E06xx` range is build/check tooling with CLI-homed precedent (`E0612`
in `cli/commands/publish.sfn`, `E0614` in `cli/commands/build.sfn`); `E0600` and
`E0610`–`E0614` are taken, so `E0615` is the next free number. **`E11xx` is not
available** — it is numerical/behavioural contracts, with `E1100`–`E1114`
reserved by SFEP-0062 (`docs/style-guide.md:229`). The style-guide table gains
an `E0615` entry in the same PR that allocates it.

### 3.7 Round-trip fidelity and mode bits, reconciled

SFN-753's acceptance criteria ask for a byte-identical round-trip "including
modes", and Windows has no executable bit. The reconciliation: **round-trip
identity is defined over archive bytes, not over host filesystem state**, and it
holds on every host because the writer stores a *computed canonical* mode rather
than an observed one.

Canonical mode:

| Member | Stored mode |
|---|---|
| Directory (`5`) | `0755` |
| Regular file (`0`), executable | `0755` |
| Regular file (`0`), not executable | `0644` |
| Symlink (`2`) | `0777` (what GNU tar stores) |

"Executable" is decided by, in order: membership in `CreateOptions.exec_paths`;
otherwise `fs.is_executable` (`capsules/sfn/fs/src/mod.sfn:123`, `access(X_OK)`)
on POSIX; otherwise false. `sfn package` already knows which staged entries are
binaries, so the Windows answer is supplied, not guessed.

Everything else that varies by host is **zeroed**: `uid = 0`, `gid = 0`,
`uname = ""`, `gname = ""`, `mtime = 0` unless the caller supplies one, and the
gzip header carries `MTIME = 0`, `XFL = 0`, `OS = 255` (unknown). This is what
makes §2.2's reproducibility claim true.

On extraction, `fs.set_perms` applies the stored mode masked to `0777` on POSIX
and is a documented no-op on Windows (`capsules/sfn/fs/src/mod.sfn:93-100`). The
extractor forces the executable bit for any `0755` member on POSIX — that bit is
the entire reason the extracted `sfn` runs.

So the three claims, stated precisely:

- `targz_create` over the same tree, twice, on any host: **byte-identical archives**.
- `targz_create` after `targz_extract` of an archive we wrote: **byte-identical
  to the original archive** on POSIX. On Windows, identical except that symlink
  members become regular files (§3.5) — an intended, documented divergence, and
  the reason `LinkPolicy.Dereference` exists.
- Content bytes of every regular member: **identical on every host**, always.

### 3.8 ustar conformance: what we read, what we write, what we refuse

**Read-supported:**

- ustar POSIX.1-1988 (`magic == "ustar\0"`, `version == "00"`), with
  `prefix` + `/` + `name` joining.
- v7 old-tar (all-NUL magic): accepted; `prefix` ignored.
- GNU (`magic == "ustar  \0"`): accepted as ustar, but `prefix` is **not**
  joined — GNU does not use that field.
- **Header checksum: verified.** Both the unsigned-byte sum (standard) and the
  signed-byte sum (historical writers) are accepted; a mismatch against both is a
  hard error. This is the standard leniency and it is what makes us readable-from
  rather than brittle.
- Typeflags `0` and `\0` (regular), `5` (directory), `2` (symlink), `1` (hard
  link) per §3.5.
- **GNU `L` / `K` long-name extensions: read-supported.** They are how GNU tar
  encodes a path longer than 100 bytes that does not split into `prefix`/`name`,
  and a real published tarball can contain them. The `L`/`K` body is a
  NUL-terminated path, buffered to at most 4096 bytes (longer is a hard error)
  and applied to the *next* header.
- **PAX per-file extended headers (typeflag `x`): read-supported for the `path`,
  `linkpath`, and `size` keywords only.** Every other keyword is skipped. bsdtar
  — the default `tar` on macOS — emits `x` records routinely, so refusing them
  would leave us unable to read a Mac-produced archive.
- **PAX global headers (typeflag `g`): read and skipped.** No keyword we honour
  is legitimately global.
- **Two-block EOF marker:** the first all-zero header block ends the archive. A
  present second zero block is verified; an *absent* one is accepted and noted in
  the summary, matching GNU tar's tolerance for a stream cut at a block boundary.
  Non-zero trailing data after the marker is a hard error.

**Hard errors on read:**

- Typeflags `3` (char device), `4` (block device), `6` (FIFO), `7` (contiguous).
  No Sailfin artifact contains one, and materializing a device node out of a
  downloaded archive is exactly the shape the path guard exists to prevent. `7`
  could safely alias to regular; failing closed is the honest answer for a
  typeflag we never write.
- **GNU base-256 numeric fields** (high bit set in byte 0 of a numeric field):
  *detected* and rejected with a specific message. They only appear for values
  exceeding octal range — a member above 8 GiB — and `ExtractOptions.max_total_bytes`
  already fails such an archive closed.
- A member `size` that would take total output past `max_total_bytes`, or a
  member count past `max_members` (decompression-bomb guard).
- Any block read that returns short of 512 bytes mid-archive (truncation).

**What we write:** ustar `magic = "ustar\0"`, `version = "00"`; typeflags `0`,
`5`, `2` only; names split into `prefix`/`name` when longer than 100 bytes;
**`L`/`K` never emitted** — a path that cannot be split is a hard error, and no
`sfn package` or seed-tree path comes close; no PAX records; unsigned checksum;
exactly two zero blocks followed by NUL padding to a 10240-byte (20-block)
record boundary, matching GNU tar's default.

### 3.9 The DEFLATE encoder: fixed Huffman first, and why

**We take the fixed-Huffman first cut, with greedy LZ77 matching and a
stored-block fallback.** Concretely, per block:

1. Run a greedy LZ77 matcher over a 32 KiB window with a hash chain (a
   `head[1 << 15]` + `prev[1 << 15]` pair of `int` tables ≈ 512 KiB, allocated
   once per stream), producing literal/length/distance symbols.
2. Encode with the RFC 1951 §3.2.6 fixed code tables.
3. If the encoded block would be larger than the raw input, emit a **stored**
   block instead — so incompressible input never grows by more than 5 bytes per
   65535-byte block.

**Fixed Huffman without LZ77 would be a bug, not a simplification.** The fixed
literal code is near-flat (8 bits for 0–143, 9 bits for 144–255), so a
literals-only stream *expands* binary data by roughly 12.5%. The matcher is what
produces compression under the fixed code; it is not the optional half.

Expected ratio on a compiler tarball: roughly 2.5–3x versus `gzip -6`'s ~3.5x.
The output is valid RFC 1951 and universally readable — GNU tar, bsdtar, 7-Zip,
Python `tarfile`, and every browser will read it.

**Upgrade path:** dynamic Huffman (RFC 1951 §3.2.7) is a self-contained addition
*inside* `src/deflate.sfn`: histogram the literal/length and distance symbols,
build canonical length-limited codes, emit the code-length alphabet, and pick the
smaller of fixed/dynamic/stored per block. It changes **no signature** — it is
`DeflateStrategy.Dynamic` behind `CreateOptions.deflate`. It is filed as a
follow-up (§9 phase A6) and does **not** gate SFN-753. The decompressor supports
dynamic Huffman from day one regardless, because we must read `gzip -6` output.

### 3.10 Worked example — the `sfn toolchain install` cutover

Before (`compiler/src/cli/commands/toolchain.sfn:416-425`):

```sfn
let extract_dir = tmp + "/extract";
process.run(["mkdir", "-p", extract_dir]);
let tar_rc = process.run(["tar", "-xzf", tarball, "-C", extract_dir]);
if tar_rc != 0 {
    print("error: failed to extract " + asset + " (tar exit "
        + int_to_string(tar_rc)
        + ")");
    process.run(["rm", "-rf", tmp]);
    return 1;
}
```

After:

```sfn
// Extraction runs with the user's privileges over network-fetched bytes,
// so the path policy is not optional and a rejection aborts the install
// rather than skipping a member (SFEP-XXXX §3.6).
let extract_dir = tmp + "/extract";
fs.mkdir(extract_dir);
let opts = ExtractOptions {
    copy_instead_of_link: host_is_windows(),
    apply_modes: true,
    max_total_bytes: 1073741824,
    max_members: 65536
};
let extracted = targz_extract(tarball, extract_dir, opts);
if extracted.is_err() {
    let e = extracted.unwrap_err();
    print("error [E0615]: failed to extract " + asset);
    print("  " + e.message);
    if e.member.length > 0 { print("  member: " + e.member); }
    process.run(["rm", "-rf", tmp]);
    return 1;
}
```

The surrounding `mkdir -p` / `rm -rf` / `cp -f` / `chmod` shell-outs in this
function are SFN-493's other half, not this proposal's scope; the `fs.mkdir`
swap above is incidental to removing the tar call.

## 4. Effect & capability impact

**No change to the effect system, the taxonomy, or capability enforcement.** The
capsule is a consumer of the existing model, not an extension of it.

- The pure codec layer — `crc32.sfn`, `inflate.sfn`, `deflate.sfn`,
  `ustar.sfn` (header encode/decode), `path_guard.sfn`, `bytes.sfn` — is
  **effect-free**. That separation is deliberate: the entire path-guard rejection
  table and every RFC vector are testable without `![io]`, which is what makes
  the security-relevant half cheap to test exhaustively.
- Only `tar_read.sfn`, `tar_write.sfn`, and the `gzip_*` stream openers carry
  `![io]`. No `![net]`: the capsule never fetches. Effect lists are single-effect
  here, so the alphabetical rule (`.claude/rules/code-style.md`) is trivially met.
- `capsules/sfn/archive/capsule.toml` declares `[capabilities] required = ["io"]`.
  Note that `capsules/sfn/crypto/capsule.toml` declares `required = []` while
  exporting a `![rand]` function, so capsule-manifest enforcement is evidently
  not yet capsule-wide; the implementer declares `["io"]` as the honest answer
  and matches the crypto precedent if the resolver rejects it (`E0403`).
- **The compiler's own manifest does not widen.** `compiler/capsule.toml` already
  declares `required = ["clock", "io", "net"]`; the extraction path is `![io]`,
  which is inside it. Removing the `process.run(["tar", ...])` calls in fact
  *narrows* real-world reach — the compiler stops handing an argv to an external
  program with the user's full authority — even though the declared manifest is
  unchanged. That is the capability model working as intended, and it is worth
  saying out loud on a proposal whose headline is "removes a dependency."

## 5. Self-hosting impact

### 5.1 No compiler pass changes

Lex, parse, AST, typecheck, effects, emit (`.sfn-asm`), lowering, and rendering
are **all unchanged**. The capsule is ordinary Sailfin source using constructs
the pinned 0.9.5 seed already compiles: structs, enums, `Result<T, E>` + `?`,
`extern fn` over libc, `load_byte`, and `sailfin_intrinsic_pointer_read_i32`.
No new builtin, no new intrinsic, no new syntax (§3.2).

### 5.2 No seed cut

Per `.claude/rules/seed-dependency.md`: `make compile` self-hosts against the
seed pinned at `bootstrap.toml:16` (0.9.5). A capsule under `capsules/sfn/` is
compiled by the **freshly built compiler** within the same pass, so a capability
and its consumer bundle cleanly and there is no gate — this is exactly the case
the rule says to bundle. The carve-out (a capability consumed by *runtime*
source, where the pinned seed does the compiling) does not apply: nothing in
`runtime/` imports `sfn/archive`, and nothing should.

Compiler-source changes are confined to:

| File | Change | Phase |
|---|---|---|
| `compiler/capsule.toml` | add `"sfn/archive" = "*"` under `[dependencies]` | A3 |
| `compiler/src/cli/commands/toolchain.sfn:416-425` | replace the `tar -xzf` call | A3 |
| `compiler/src/cli/commands/package.sfn:259`, `:586`, `:759` | replace the three `tar -czf` calls | A5 |
| `compiler/src/cli/commands/package.sfn:86` | delete the workaround comment naming SFN-753 | A5 |
| `docs/style-guide.md:224` | add the `E0615` entry | A3 |

`workspace.toml` needs no edit — `members` includes `capsules/sfn/*` and the
pinned seed expands the glob (`workspace.toml:15-19`). The `Makefile` needs no
edit — `test-capsules` walks nested `tests/` directories under `capsules/`
(`Makefile:415-435`).

### 5.3 Build-time cost

Reachability filtering means the capsule's modules are staged only for programs
that name it (`compiler/src/capsule_resolver/reachability.sfn:166-168`). After
A3 the compiler imports it, so `make compile` gains ~8 modules of compile time —
comparable to a slice of `sfn/crypto`'s 33-38 modules, which is a known and
tolerated cost. Every other program pays nothing.

### 5.4 Name collisions

Imported names are matched without provenance across the compiler tree; that is
why `sfn/http` cannot be a compiler dependency (`compiler/capsule.toml:63-68`,
SFN-893). Every `sfn/archive` export therefore carries a module prefix
(`targz_*`, `gzip_*`, `ustar_*`, `crc32*`, `inflate_*`, `deflate_*`,
`archive_*`) — no bare `read`, `write`, `extract`, `create`, `list`, or `open`.
This is a hard review criterion on A1, because the cost of getting it wrong
surfaces only at A3 when the compiler first imports the capsule.

## 6. Alternatives considered

### 6.1 Invoke Windows' bundled `System32\tar.exe` — **retired by owner ruling**

**Decided: rejected. This option is retired, not deferred.** The reasoning is
product, not pillar: a stock-Windows install must run the whole toolchain, and
delegating unpack to a host binary means the bootstrap works only on Windows 10
1803+ with a bsdtar whose version and PAX behaviour we do not control. It was
never a pillar violation — `tar` is not on the `sfn build -p compiler` path and
never contaminated a capability manifest — so the rejection rests entirely on
self-containment. It also solves only half the problem: `sfn package` still needs
a *writer*, and `tar.exe` cannot be argv-driven into producing reproducible
output (§2.2).

### 6.2 Link zlib / libarchive through the C ABI

Rejected. It reintroduces a C dependency the project explicitly retired
(`CLAUDE.md`: "no Python, no C runtime, no fixup scripts"), and the per-platform
link matrix is strictly harder than the code it saves: MSVC ships no system
zlib, so Windows — the target that motivates this work — would need a vendored
build. ~2,500 lines of pure Sailfin against a frozen 1996 spec with published
vectors is the cheaper and more durable side of that trade.

### 6.3 Ship an uncompressed `.tar` seed asset

Rejected. 4.4 MB becomes ~14 MB per asset per target, it invalidates every
published `.sha256` and the existing installer, and it does nothing for
`sfn package`, whose consumers expect `.tar.gz`. It also merely defers the
decompressor, since we must still *read* historical `.tar.gz` seeds.

### 6.4 Invent a simpler Sailfin-native container format

Rejected on "boring syntax wins" applied to formats. Published seed tarballs are
`.tar.gz`; the GitHub release UI, `curl | tar`, and every user's muscle memory
expect it. A bespoke format would require us to ship *and* read `.tar.gz` anyway
for the historical assets, so it is strictly additive work.

### 6.5 Put the implementation in `runtime/`

Rejected. Nothing forces it there — no new intrinsic is needed (§3.2) — and
choosing `runtime/` converts a zero-gate change into a seed-gated one, because
the **pinned seed** compiles working-tree runtime source
(`.claude/rules/seed-dependency.md`). It would also add ~2,500 lines to the
runtime link-selection surface (`compiler/src/build/runtime_selection.sfn`) for
every program, and forfeit the automatic `make test-capsules` discovery.

### 6.6 Whole-buffer-only API

Rejected on the memory budget. A whole-buffer extract peaks at compressed +
decompressed + written tree simultaneously; `sfn package` trees are unbounded and
the fan-out budgets in `.claude/rules/compiler-safety.md` reserve 2.5–3 GiB per
job. Streaming costs roughly 150 extra lines and makes peak memory independent
of archive size (§3.4). The whole-buffer helpers survive for RFC vectors, where
inputs are bytes, not megabytes.

### 6.7 Dynamic Huffman in the first cut

**Deferred, not rejected.** It is a pure ratio improvement behind an existing
options field with no signature change (§3.9). Shipping fixed Huffman first gets
the Windows unblock sooner, and the decompressor supports dynamic Huffman from
day one regardless because it must read `gzip -6`. Filed as phase A6.

### 6.8 `int[]` as the byte container

Rejected: 8 bytes of storage per byte plus `push` growth copies. A 100 MB member
would need ~1.6 GB peak against a shared 8 GiB cap. `int[]` interop survives at
the test boundary so RFC vectors stay readable as array literals (§3.3).

## 7. Stage1 readiness mapping

This proposal adds no language construct, so several checklist rows are
satisfied by "nothing changed" rather than by new work. Stating that explicitly
is the honest form — an unqualified tick would imply new pipeline coverage that
does not exist.

- [ ] **Parses** — n/a: no new syntax. The capsule is ordinary Sailfin the
      pinned 0.9.5 seed already parses.
- [ ] **Type-checks / effect-checks** — the capsule must pass `sfn check` on
      every module, with the pure layer proven effect-free and `![io]` confined
      to `tar_read.sfn` / `tar_write.sfn` / the stream openers.
- [ ] **Emits valid `.sfn-asm`** — n/a: no emitter change. Covered transitively
      by the capsule compiling.
- [ ] **Lowers to LLVM IR** — n/a: no lowering change. The one novelty is
      `load_byte` and a masked word store spelled from *capsule* source, which
      the §3.2 probe settles in phase A1.
- [ ] **Regression coverage** — §8. The path guard and inflate carry the
      exhaustive tables; interop tests are the acceptance evidence.
- [ ] **Self-hosts** — `make compile` after A3 (compiler imports the capsule)
      and again after A5; `make check` before declaring the epic done.
- [ ] **`sfn fmt --check` clean** — every `.sfn` under `capsules/sfn/archive/`
      and the touched `compiler/src/cli/commands/*.sfn`.
- [ ] **Documented in `docs/status.md` + spec** — `docs/status.md` gains an
      `sfn/archive` row; `E0615` is added to `docs/style-guide.md:224`. No spec
      chapter: this is a library, not a language feature.

The proposal reaches **Accepted** on owner approval of this design and
**Implemented** only when phases A1–A5 are all merged, `make check` is green,
and the four `tar` call sites are gone from `compiler/src/`.

## 8. Test plan

### 8.1 Unit — `capsules/sfn/archive/tests/` (auto-discovered by `make test-capsules`)

- **`crc32_test.sfn`** — the zlib/RFC 1952 check value `crc32("123456789") ==
  0xCBF43926`; empty input `== 0`; a 1 MiB generated pattern against a
  precomputed constant; incremental-vs-whole equivalence.
- **`inflate_test.sfn`** — RFC 1951 coverage: stored block; fixed-Huffman block;
  dynamic-Huffman block; back-reference at distance 1 (run-length fill);
  distance at the 32768 window edge; the length-258 / distance-32768 maxima;
  a stream ending mid-symbol (**errors, does not hang** — guard counters per
  `.claude/rules/code-style.md`); an over-subscribed code-length tree
  (**rejected, does not crash**); an incomplete tree; a distance code pointing
  before the start of output.
- **`gzip_test.sfn`** — RFC 1952 framing: minimal header; `FNAME`, `FCOMMENT`,
  `FEXTRA`, `FHCRC` present individually and together; bad magic; `CM != 8`;
  CRC-32 mismatch; ISIZE mismatch; a concatenated multi-member stream
  (`cat a.gz b.gz` is legal and must read as one logical stream).
- **`ustar_test.sfn`** — checksum accepted under both the unsigned and signed
  sums; rejected on mismatch; `prefix` + `name` join; GNU `L` and `K` long
  names; PAX `path` / `linkpath` / `size`; PAX `g` skipped; the two-block EOF
  marker and the single-block tolerance; each of typeflags `3`/`4`/`6`/`7`
  rejected; a base-256 numeric field rejected with its specific message.
- **`path_guard_test.sfn`** — the full rejection table, filesystem-free because
  the guard is pure: `/etc/passwd`, `../x`, `a/../../x`, `a/./b` (**accepted**,
  normalizes to `a/b`), `C:\x`, `c:x`, `\\server\share\x`, `a\..\..\x`, a name
  with an embedded NUL, a 4097-byte name, `CON` and `com1.txt` under the Windows
  flag (rejected) and under POSIX (accepted), a symlink target of `/etc`, a
  symlink target of `../..`, and an empty symlink target.
- **`deflate_test.sfn`** — `inflate(deflate(x)) == x` over: empty; 1 byte; 65535
  bytes (the stored-block boundary); 65536; a highly repetitive buffer; an
  incompressible pseudorandom buffer (**must fall back to stored and never grow
  by more than 5 bytes per 65535-byte block**); a buffer containing all 256 byte
  values; and a buffer whose best match sits exactly at the window edge.
- **`bytes_test.sfn`** — `ByteBuf` growth, `ByteCursor` bounds rejection at both
  ends, and the byte round-trip through whichever read/write spelling the §3.2
  probe selected.

### 8.2 E2E — `compiler/tests/e2e/*_test.sfn`

Sailfin test files driving subprocesses via `process.run_capture` — **never
bash** (`.claude/rules/no-bash-e2e.md`). Each nested build threads
`clean_runner_env(nested_runner_scratch("<label>"))` and each tool probe follows
the existing `tool_present("tar")` skip pattern at
`compiler/tests/e2e/sfn_package_test.sfn:211`, so a host without GNU tar skips
rather than fails.

- **`archive_gnu_tar_interop_test.sfn`** — our writer's output is listed
  (`tar -tzf`) and extracted (`tar -xzf`) by the host `tar`, and by `bsdtar`
  when present, with content compared byte for byte. This is the "GNU tar and
  bsdtar can both read our writer's output" acceptance criterion.
- **`archive_reads_gnu_tar_test.sfn`** — the host `tar -czf` archives a fixture
  tree containing a nested directory, an executable file, a non-executable file,
  a >100-byte path (forcing `prefix` or `L`), and a relative symlink; we extract
  it and compare content, modes, and link shape.
- **`archive_reads_published_seed_test.sfn`** — extract the **actual pinned seed
  tarball** and assert the `sailfin` binary and the `sfn -> sailfin` link
  materialize correctly. Gated on the asset already being present in the local
  seed store; the test never downloads.
- **`archive_roundtrip_reproducible_test.sfn`** — `targz_create` over the same
  tree twice yields byte-identical archives, and the SHA-256 matches across the
  two runs. This is the §2.2 reproducibility claim under test.
- **`archive_path_traversal_reject_test.sfn`** — a hand-built malicious archive
  (constructed with our own writer's low-level header encoder, bypassing the
  writer's own refusal) containing `../escape`, `/etc/escape`, and a symlink to
  `/tmp` is rejected, and **nothing is written outside `dest_dir`** — asserted
  by checking the sibling directory is empty afterward, not merely by checking
  the return code.
- **`sfn_package_no_tar_test.sfn`** — run `sfn package` with a `PATH` containing
  `clang` and its linker but **not** `tar`, and assert a valid archive is still
  produced. This is the product claim, tested directly.
- **`sfn_toolchain_install_no_tar_test.sfn`** — the extraction half of the same,
  against a locally-staged archive with no network.

### 8.3 Test oracles that deliberately keep using `tar`

`compiler/tests/e2e/sfn_package_test.sfn:89` and
`compiler/tests/e2e/build_hash_matches_sha256sum_test.sfn:87` invoke `tar` as a
verification oracle. Those **stay**. Cross-checking our output against the real
GNU tar is the point of an interop test, and replacing the oracle with our own
implementation would make the test assert only that we agree with ourselves.

### 8.4 Commands

```
build/bin/sfn check capsules/sfn/archive/src/*.sfn
build/bin/sfn fmt --check capsules/sfn/archive/src/*.sfn capsules/sfn/archive/tests/*_test.sfn
make compile                                   # after A3 and after A5
build/bin/sfn test capsules/sfn/archive/tests
make test-capsules
build/bin/sfn test compiler/tests/e2e/archive_gnu_tar_interop_test.sfn
build/bin/sfn test compiler/tests/e2e/sfn_package_no_tar_test.sfn
make check                                     # before declaring the epic done
```

## 9. Phasing

Reader-first: the reader half is what unblocks SFN-493 → SFN-57, and the writer
half serves `sfn package`, which no Windows user needs before they can bootstrap.

Per the decomposition discipline, **a capability is bundled with its single
consumer**. A3 and A5 each pair a capability with the only call sites that will
ever use it, in one PR. Nothing here is seed-gated (§5.2), so no split would buy
a seed cut back — and none should be manufactured.

| Phase | Scope | Size | Blocked by |
|---|---|---|---|
| **A1** | Capsule skeleton (`capsule.toml`, `mod.sfn`), `bytes.sfn`, `error.sfn`, `crc32.sfn`, `gzip.sfn` **header parse only**; the §3.2 byte-primitive probe; `crc32_test.sfn`, `bytes_test.sfn`, `gzip_test.sfn`. Establishes the prefixed-export rule (§5.4). | S/M | — |
| **A2** | `inflate.sfn` — full RFC 1951 decompression (stored, fixed, dynamic), wired to `gzip_read`. `inflate_test.sfn`. **Not bundled with anything**: it is the largest correctness surface in the epic and is independently testable against published vectors. | M | A1 |
| **A3** | `ustar.sfn` read, `path_guard.sfn`, `tar_read.sfn`, **and** the `toolchain.sfn:418` cutover + `compiler/capsule.toml` dependency + `E0615` allocation. Bundled: the ustar reader's only consumer is the extractor, whose only consumer today is that one call site. `ustar_test.sfn`, `path_guard_test.sfn`, and the four read-side E2E tests. | M | A2 |
| **A4** | `deflate.sfn` — fixed Huffman + greedy LZ77 + stored fallback — and `gzip.sfn` write. `deflate_test.sfn`. | M | A1 |
| **A5** | `ustar.sfn` write, `tar_write.sfn` tree walk, **and** the three `package.sfn` cutovers (`:259`, `:586`, `:759`) plus deleting the workaround comment at `:86`. Bundled for the same reason as A3. Interop + reproducibility E2E tests. | M | A3, A4 |
| **A6** | Dynamic Huffman behind `DeflateStrategy.Dynamic`. **Follow-up — does not gate SFN-753.** | S/M | A4 |

Acceptance criteria, per phase:

- **A1** — `make test-capsules` green; `crc32("123456789") == 0xCBF43926`; the
  RFC 1952 header field matrix parses; `make compile` unaffected (the capsule is
  not yet a compiler dependency); the probe's outcome recorded in a `//` comment
  in `bytes.sfn` naming which spelling was chosen and why.
- **A2** — every §8.1 inflate vector passes; a truncated stream and an
  over-subscribed tree both **error** rather than hang or crash; decompressing a
  100 MB fixture holds peak RSS to window + chunk.
- **A3** — `compiler/src/cli/commands/toolchain.sfn` contains no `process.run`
  naming `tar`; `archive_reads_published_seed_test.sfn` and
  `archive_path_traversal_reject_test.sfn` pass; `make compile` green;
  `E0615` present in `docs/style-guide.md`. **This is the phase that closes out
  SFN-493's tar half.**
- **A4** — `inflate(deflate(x)) == x` over the §8.1 corpus; incompressible input
  never grows by more than 5 bytes per 65535-byte block.
- **A5** — all three `tar -czf` sites gone; GNU tar and bsdtar both read our
  output; two `targz_create` runs are byte-identical;
  `sfn_package_no_tar_test.sfn` passes; `make check` green.

## 10. Future considerations

- **`.zip` for Windows distribution.** A `.zip` writer reuses `crc32.sfn` and
  `deflate.sfn` unchanged and needs only a new container module (local file
  headers + central directory). This is the strongest single argument for the
  layered module split in §3.1, and worth remembering before anyone proposes
  collapsing `crc32` into `gzip`.
- **`Content-Encoding: gzip` in `sfn/http`.** `inflate.sfn` is the whole
  requirement; the HTTP client currently cannot accept a compressed response.
- **Registry artifacts.** `sfn publish` / `sfn add` will move capsule tarballs;
  a reproducible writer means a capsule's content digest is stable across
  publishers, which is a precondition for any future content-addressed cache
  (SFEP-0040 adjacency).
- **Reclamation.** The manual `bytes_free` discipline is exactly the pattern
  SFEP-0064's reclamation seam exists to absorb. When that lands, `ByteBuf`
  should be among the first adopters; until then, the discipline is enforced by
  review and by the fact that every allocation is confined to one module.
- **Dynamic Huffman ratio parity** (A6) matters most for release-asset size
  across N targets; measure before assuming the ~15% is worth a session.
- **Zstd is not on this path.** It would need its own decompressor and buys
  nothing until we control both ends of a distribution channel.

## 11. References

- **SFN-753** — in-process `.tar.gz` reader/writer (this proposal's tracking issue)
- **SFN-493** — de-shell seed acquisition (the direct consumer of phase A3)
- **SFN-57 / SFN-55 / SFN-58** — native Windows seed, release leg, and follow-ons
- **SFN-340 / SFN-341 / SFN-808 / SFN-811 / SFN-824** — native TLS (done; the
  reason `curl` is no longer a blocker)
- **SFN-893** — provenance-aware name resolution (why every export is prefixed)
- **SFEP-0021** — Native Windows Self-Host, §4.3 bootstrap sequence
- **SFEP-0048** — Native crypto (the house model for a pure-Sailfin capsule
  implementing a frozen spec against published vectors)
- **SFEP-0064** — Reclamation seam (future home for the manual free discipline)
- **SFEP-0062** — Numerical contracts (reserves `E1100`–`E1114`; why `E11xx` is
  unavailable here)
- `.claude/rules/seed-dependency.md` — bundle-vs-split and the runtime carve-out
- `.claude/rules/compiler-safety.md` — the 8 GiB cap and the fan-out budgets
- `.claude/rules/no-bash-e2e.md` — E2E tests are `*_test.sfn`
- **RFC 1950** (zlib), **RFC 1951** (DEFLATE), **RFC 1952** (gzip) — the frozen
  specs, with the CRC-32 check value and the fixed Huffman tables
- **POSIX.1-1988 ustar** and the GNU tar manual's "Basic Tar Format" chapter —
  header layout, the `L`/`K` extensions, and PAX `x`/`g` records
