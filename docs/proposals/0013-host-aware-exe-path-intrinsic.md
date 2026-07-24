---
sfep: 13
title: "Host-Aware exe_path Intrinsic"
status: Implemented
type: runtime
created: 2026-06-02
updated: 2026-07-24
author: "agent:compiler-architect"
tracking:
supersedes:
superseded-by:
graduates-to:
---

# Host-Aware `exe_path` Intrinsic — Self-Path Resolution on macOS arm64

Status: proposal (design only — no implementation in this doc)
Epic: #390 (M3: Capability Adapters in Sailfin + Delete C Runtime)
Thread: #468 / #473 (exe-path wire-up)
Author: compiler-architect
Date: 2026-06-02

---

## 1. Goal

Make `sfn run` / `sfn build` / `sfn test` resolve the running binary's own
absolute path on macOS arm64 (and Windows), natively — no new C — by extending
the host-aware intrinsic-registry-sentinel pattern (proven for `errno()` in
#877/#901) to the executable-path primitive, so the false "link failed (clang
exit=1)" and the infinite `sfn run` self-re-exec disappear at their root.

---

## 2. Current state (the bug)

Install seed `0.7.0-alpha.19` on macOS arm64 (binary at
`~/.local/share/sailfin/versions/.../sailfin`, symlinked from `~/.local/bin/sfn`),
then `sfn run examples/basics/hello-world.sfn`:

```
sfn build: cannot resolve self path for runtime sfn-source emit
           tried: <binary_dir>/sailfin (binary_dir="."), then readlink -f /proc/self/exe
link failed (clang exit=1)
run: native link failed; attempting seed fallback via `sfn run`   (repeats forever)
```

Four stacked root causes, all verified in source:

1. **`exe_path()` is Linux-only.** `runtime/sfn/platform/exec.sfn:214-230`
   only calls `readlink("/proc/self/exe", …)`. macOS has no `/proc`, so the
   call returns `n <= 0` and the function returns `""`. The Darwin extern that
   would fix it, `_NSGetExecutablePath`, is declared at
   `runtime/sfn/platform/libc.sfn:223` but is **declaration-only by design**:
   the long comment at `libc.sfn:187-225` pins the "declares parse on Linux,
   never called there" contract because Sailfin has no `cfg(target_os)` and a
   *static `call`* to an unresolved Darwin/Windows symbol from a **Linux** build
   would fail at link time. Calling it from the shared `exe_path()` body would
   break the Linux self-host link.

2. **`fn main` argv[0] fallback collapses to `"."`.**
   `compiler/src/cli_main.sfn:2236-2256`: when `exe_path()==""`, it tries
   `realpath(argv[0], null)`. Invoked as the bare PATH name `sfn`,
   `argv[0]=="sfn"`, so `realpath` resolves it against CWD, fails (returns
   null), and `exe_str` stays `"sfn"`. `binary_dir("sfn")` then collapses to
   `"."`.

3. **The last-ditch shell fallback is doubly Linux-only.**
   `compiler/src/cli_main.sfn:903 _resolve_self_path` (and its duplicate
   `compiler/src/cli_commands.sfn:749 _resolve_test_self_path`) shell out to
   `readlink -f /proc/self/exe`. On macOS there is no `/proc`, and BSD
   `readlink` has no `-f` flag — the command fails and returns `""`. So
   `_resolve_self_path("." )` finds no `./sailfin` and the shell fallback yields
   nothing → the runtime-sfn-source emit loop is skipped, the runtime objects
   are never produced, and the final `clang` link fails for real (missing
   runtime symbols) — surfacing as the misleading `link failed (clang exit=1)`.

4. **Seed fallback recurses infinitely.** `compiler/src/cli_main.sfn:2040`
   runs `process.run(["sfn", "run", input_path])`. `sfn` *is* the just-installed
   binary, so the child re-runs the identical failing path. **Decision: leave
   this alone.** Once self-path resolution works, the link succeeds and this
   branch never fires. It becomes dead-by-construction; no change here.

The fix targets cause **#1** at its root (and lets us collapse **#3**); causes
**#2** and **#4** become unreachable once `exe_path()` works on every platform.

---

## 3. Constraints / invariants

- **No new C.** Adding C cuts against epic #390 (delete the C runtime). The
  Windows C stubs at `runtime/native/src/sailfin_runtime.c:61-102` should
  *shrink*, not grow.
- **Linux self-host must stay green.** The emitted IR must be target-neutral:
  only the *host's* concrete symbol may get a `declare`+`call`. This is exactly
  the property the errno sentinel relies on (`core_call_emission.sfn:650-677`,
  `rendering.sfn:194-204`).
- **Memory cap / timeout:** every compiler invocation `ulimit -v 8388608`,
  single files `timeout 60`.
- **Formatting:** `sfn fmt --write` then `--check` on every touched `.sfn`.
- **Fix the compiler, never the driver.** No build fixups.
- **Stage1 7-point bar** before "shipped": parse, typecheck/effect, emit,
  lower, tests, self-host, fmt, docs.
- **macOS validation requires CI.** We develop on Linux and cannot reproduce
  the actual bug locally. Every place a Mac runner must confirm behavior is
  flagged `[MAC-CI]` below.

---

## 4. Design

### 4.1 Why the errno symbol-swap is not enough

The errno sentinel works because its three concrete locators
(`__errno_location`, `__error`, `_errno`) share one signature `i32*()`
(`runtime_helpers.sfn:248-279`). The sentinel lowering is therefore a *pure
symbol swap*: pick the name, emit `call i32* @<sym>()`
(`core_call_emission.sfn:659-664`).

The exe-path primitives do **not** share a shape:

| Target  | Primitive                                  | Signature                         | Result semantics                                  |
|---------|--------------------------------------------|-----------------------------------|---------------------------------------------------|
| Linux   | `readlink("/proc/self/exe", buf, size)`    | `(i8*, i8*, i64) -> i64`          | byte count; not NUL-terminated; already canonical |
| Darwin  | `_NSGetExecutablePath(buf, *size)`         | `(i8*, i32*) -> i32`              | 0=ok; size in/out; may be symlink/non-canonical   |
| Windows | `GetModuleFileNameA(NULL, buf, size)`      | `(i8*, i8*, i32) -> i32`         | byte count; handle arg                             |

A pure symbol swap cannot bridge these: arity, the extra `/proc/self/exe`
string operand on Linux, the in/out size pointer on Darwin, and the
post-`_NSGetExecutablePath` `realpath` canonicalization all differ.

### 4.2 Chosen design: option (a) — one sentinel, per-target emission sequence

**Adopt a single sentinel `sailfin_intrinsic_exe_path` with a uniform Sailfin
signature, lowered to a small per-target emission *sequence*** — mirroring how
`sailfin_intrinsic_pointer_read_i32` lowers to an inline `load` sequence rather
than a plain symbol swap (`core_call_emission.sfn:679-726`).

**Reject option (b)** (thin symbol-swap sentinel + per-platform normalization
left in `exec.sfn` Sailfin source). It cannot work: the normalization in
`exec.sfn` would have to reference all three concrete externs
(`readlink`/`_NSGetExecutablePath`/`GetModuleFileNameA`) by name in source, and
*any* of those references that the Sailfin compiler lowers to a `call` on the
non-host platform re-introduces the exact unresolved-symbol link failure that
`libc.sfn:187-225` documents. The only way to guarantee only the host symbol is
ever `call`ed is to make the *compiler* choose at emit time — i.e. option (a).
The `pointer_read` precedent confirms a sentinel may legitimately lower to a
multi-instruction sequence, so (a) is also the more consistent choice.

**Uniform sentinel signature (Sailfin-visible):**

```
sailfin_intrinsic_exe_path(buf: *u8, size: i64) -> i64
```

Contract: writes up to `size` bytes of the running binary's path into `buf`
(NUL-terminated when it fits), returns the **byte length written excluding the
NUL** on success, or `-1` on failure. `exec.sfn` keeps ownership of `buf`.

This signature is deliberately the *Linux* shape (the dominant leg) so the
Linux emission is a direct `call` with no shimming. The Darwin and Windows
legs normalize *inside the dispatcher's emitted IR* to honor this contract.

### 4.3 Registry descriptors (`runtime_helpers.sfn`, in `runtime_helper_descriptors()`)

Add a sentinel row plus three internal concrete rows, immediately after the
errno block (`runtime_helpers.sfn:248-279`), following its exact conventions
(dotted internal targets so `runtime_helper_call_names()` does **not** seed
them as bare source globals — `runtime_helpers.sfn:1135-1146` skips dotted
targets via `_rh_has_dot`):

```
// sentinel — seeded as a source-level call name (no dot)
{ target: "sailfin_intrinsic_exe_path",          symbol: "sailfin_intrinsic_exe_path",
  return_type: "i64", parameter_types: ["i8*", "i64"], effects: ["io"],
  native_signature: null, c_abi_return_type: null }

// concrete, internal-only (dotted targets ⇒ not bare globals)
{ target: "intrinsic.exe_path.linux",   symbol: "readlink",
  return_type: "i64", parameter_types: ["i8*", "i8*", "i64"], effects: [],
  native_signature: null, c_abi_return_type: null }
{ target: "intrinsic.exe_path.darwin",  symbol: "_NSGetExecutablePath",
  return_type: "i32", parameter_types: ["i8*", "i32*"], effects: [],
  native_signature: null, c_abi_return_type: null }
{ target: "intrinsic.exe_path.mingw",   symbol: "GetModuleFileNameA",
  return_type: "i32", parameter_types: ["i8*", "i8*", "i32"], effects: [],
  native_signature: null, c_abi_return_type: null }
```

Notes:
- The sentinel carries `effects: ["io"]` — observing the process path is an
  environment read, gated like the rest of `exec.sfn` (`![io]`). (errno chose
  empty effects because reading errno is not a capability; reading the
  executable path *is* environmental.) Confirm against the existing `![io]` on
  `exe_path()` at `exec.sfn:214`.
- The three concrete rows exist **only** so the post-lowering call-target scan
  (`collect_runtime_helper_targets_from_lines`) emits a matching `declare` for
  whichever symbol the dispatcher actually emitted a `call` to — identical
  mechanism to the errno concrete rows. `readlink` and `realpath` already have
  externs in `libc.sfn`; the concrete rows' `declare`s are harmless duplicates
  the renderer already de-dups, but the dotted-target mechanism is what keeps
  the *non-host* symbols from being declared/called at all.

### 4.4 Declare-loop skip (`rendering.sfn`)

Add the sentinel target to the `_preamble_inlined` skip list alongside the
errno sentinel (`rendering.sfn:194-204`):

```
if descriptor.target == "sailfin_intrinsic_exe_path" { _preamble_inlined = true; }
```

Rationale identical to errno: the sentinel name never appears as a real `call`;
the dispatcher emits the concrete symbol instead, and the concrete descriptor's
`declare` is emitted by the line scan. The three dotted concrete rows are never
in `runtime_helper_call_names()`, so they cannot leak as source globals.

### 4.5 Dispatcher (`core_call_emission.sfn`)

Add a new branch after the errno branch (`core_call_emission.sfn:677`), gated
on `helper_descriptor.symbol == "sailfin_intrinsic_exe_path"`. The branch reads
the host via a new selector `exe_path_locator()` (see §4.6) and emits one of
three sequences. `final_operands[0]` is `buf` (`i8*`), `final_operands[1]` is
`size` (`i64`). The branch returns an `ExpressionResult` whose operand is the
`i64` byte count, exactly like the existing return shapes in this file.

Pseudo-IR per target (temps via `format_temp_name(result_temp)`; bump
`result_temp` after each):

**Linux** (`os == "Linux"` / default) — emit the `/proc/self/exe` string
constant, then a 3-arg `readlink` call. The string constant must be threaded
through `collected_string_constants` (the same return field used elsewhere in
this function) so the global is materialized:

```llvm
; %buf = final_operands[0], %size = final_operands[1]
; %procpath = i8* to the interned "/proc/self/exe\00" global
%t0 = call i64 @readlink(i8* %procpath, i8* %buf, i64 %size)
; operand: { llvm_type: "i64", value: %t0 }   ; byte count, -1 on failure
```

Implementation note: interning a string constant here mirrors how other
string-bearing call lowerings in `core_call_emission.sfn` build
`collected_string_constants`. If interning a fresh constant inside this branch
proves awkward, the cleaner alternative is to keep passing `/proc/self/exe`
from the `exec.sfn` source as the first arg of the sentinel call on the Linux
leg only — but that breaks the uniform 2-arg sentinel signature. **Prefer
interning here**; the constant is a compile-time literal owned by the
dispatcher, keeping the sentinel signature uniform across targets.

**Darwin** (`os == "Darwin"`): `_NSGetExecutablePath` takes `i8* buf` and
`i32* size_inout`. We must (1) stack-allocate an `i32`, (2) store the truncated
`size`, (3) call, (4) on success compute the byte length. Because the result
"may be a symlink / non-canonical," **canonicalization via `realpath` happens
in `exec.sfn` source** (see §4.7), not in the dispatcher — keeping the
dispatcher's job to "fill buf, return length-or-(-1)".

```llvm
%szslot = alloca i32
%sz32   = trunc i64 %size to i32
store i32 %sz32, i32* %szslot
%rc     = call i32 @_NSGetExecutablePath(i8* %buf, i32* %szslot)
; rc == 0 => success; buf now holds a NUL-terminated path.
; rc != 0 => buffer too small; *szslot holds the required size and buf
;            contents are UNSPECIFIED — do NOT read buf on this path.
%ok     = icmp eq i32 %rc, 0
br i1 %ok, label %exe_ok, label %exe_fail
exe_ok:
  ; strlen is computed ONLY on the success path, where buf is a defined,
  ; NUL-terminated C string. Emitting it unconditionally (e.g. via a flat
  ; `select`) would execute `call @strlen` even on failure, scanning a
  ; buffer with unspecified contents.
  %len = call i64 @strlen(i8* %buf)
  br label %exe_done
exe_fail:
  br label %exe_done
exe_done:
  %out = phi i64 [ %len, %exe_ok ], [ -1, %exe_fail ]
; operand: { llvm_type: "i64", value: %out }
```

`strlen` extern: it is **not** currently declared in `libc.sfn` (only mentioned
in a comment there); it is separately re-externed as `extern fn strlen(s: * u8)
-> usize` in `process.sfn`, `exception.sfn`, `adapters/filesystem.sfn`, and
`adapters/http.sfn`. The Darwin leg therefore must ensure a `declare i64
@strlen(i8*)` is emitted alongside its `call` (add `strlen` to `libc.sfn` as the
canonical home — issue #967 — and optionally dedupe the four ad-hoc re-externs
in a later cleanup). `strlen` is a pure POSIX symbol present on every target, so
declaring/calling it does not trigger the cross-platform link problem; it is
gated into the success block above purely for memory-safety, not linkage.
`phi`/`br`/`icmp`/`alloca`/`trunc`/`store` are plain LLVM and target-neutral.

> Note: `exec.sfn` zero-fills `buf` before the sentinel call (§4.7), so in
> practice a stray `strlen` on the failure path would still terminate within the
> allocation. The success-only structure above does not rely on that — it keeps
> the dispatcher correct independent of caller behavior.

**Windows** (`os == "Windows"`, via `SAILFIN_TARGET_OS`):

```llvm
%sz32 = trunc i64 %size to i32
%n    = call i32 @GetModuleFileNameA(i8* null, i8* %buf, i32 %sz32)
; n == 0 => failure; else n = bytes written (NUL-terminated when < size)
%fail = icmp eq i32 %n, 0
%n64  = sext i32 %n to i64
%neg1 = i64 -1
%out  = select i1 %fail, i64 %neg1, i64 %n64
; operand: { llvm_type: "i64", value: %out }
```

Only the host's branch is ever emitted, so only `readlink` (Linux), or
`_NSGetExecutablePath`+`strlen` (Darwin), or `GetModuleFileNameA` (Windows)
appears in the IR. The other two concrete symbols are never `call`ed or
`declare`d → no cross-platform unresolved-symbol link error. This is the same
guarantee the errno sentinel provides.

### 4.6 Host selector (`lowering_debug_state.sfn`)

Add `exe_path_locator() -> string ![io]` next to `errno_locator_symbol()`
(`lowering_debug_state.sfn:161-171`), with the identical resolution order and
caching (lazy-init dual-boolean cache, `SAILFIN_TARGET_OS` then `uname -s`):

```
"Darwin"  -> "darwin"
"Windows" -> "mingw"
otherwise -> "linux"
```

Returning a short tag (rather than the concrete symbol) lets the dispatcher
switch on the *leg* while the concrete symbol names live in the registry rows.
Alternatively reuse a single shared selector that returns the raw `uname`
string and let the dispatcher map it; pick whichever reads cleanest against the
errno precedent — the dual-boolean cache pattern is the load-bearing part.

### 4.7 `exec.sfn::exe_path()` rewrite

Replace the body at `exec.sfn:214-230` so it calls the sentinel and performs
**only** platform-neutral post-processing (canonicalization), since the
dispatcher guarantees a filled buffer + length contract on every target:

```
fn exe_path() -> string ![io] {
    let buf_size: usize = 4096 as usize;
    let buf: *u8 = malloc(buf_size);
    if buf as i64 == 0 { return ""; }
    memset(buf, 0, buf_size);
    // Reserve the final byte as a guaranteed NUL terminator: pass
    // buf_size - 1 as the usable size. readlink() never NUL-terminates
    // and writes up to `size` bytes; _NSGetExecutablePath / GetModuleFileNameA
    // include the terminator in their size accounting. Capping the usable
    // size one byte short of the allocation means the zero-filled last byte
    // always terminates the string, so `buf as string` can never read past
    // the allocation even when the path fills the buffer.
    let usable: i64 = (buf_size as i64) - 1;
    let n: i64 = sailfin_intrinsic_exe_path(buf, usable);
    if n <= 0 { free(buf); return ""; }
    // n == usable means the path was (or may have been) truncated: readlink
    // truncates silently, returning exactly `size`. Treat it as failure so
    // callers fall back rather than acting on a partial path. (A path longer
    // than 4095 bytes is pathological; a future revision could retry with a
    // larger buffer — _NSGetExecutablePath even reports the required size in
    // *szslot — but failing here is safe because callers layer their own
    // fallback, e.g. SAILFIN_RUNTIME_ROOT and the binary_dir path.)
    if n >= usable { free(buf); return ""; }
    // Darwin's _NSGetExecutablePath may return a non-canonical /
    // symlinked path; realpath is portable POSIX and already used by
    // resolve_runtime_root. Linux's /proc/self/exe is already canonical
    // but realpath is idempotent there, so this is safe on every target.
    let canon: *u8 = realpath(buf, null);
    if canon as i64 != 0 { free(buf); return canon as string; }
    return buf as string;   // realpath failed; raw path is still usable
}
```

Notes:
- The Darwin non-canonical concern is handled here once, portably, via
  `realpath` (already externed at `libc.sfn:141` and already used by
  `resolve_runtime_root`). This keeps the dispatcher minimal and avoids a
  Darwin-only `realpath` chain in IR.
- The seed cast-quirk note in the old body (the `/proc/self/exe` literal
  mis-lowering) no longer applies — the literal is gone from `exec.sfn`; the
  dispatcher interns it. Confirm the new `buf as string` / `canon as string`
  casts lower correctly (they are alloca-backed / malloc-returned pointers,
  which the module header says cast cleanly — the broken case was the *literal*
  path only).
- The `realpath(buf, null)` leaks `canon` on success, matching the documented
  leak contract in `resolve_runtime_root` (`exec.sfn:258-265`). Acceptable at a
  single startup call site.

### 4.8 Cleanup this enables

**Shell `readlink -f` fallbacks collapse.** Once `exe_path()` works on every
platform, `_resolve_self_path` (`cli_main.sfn:903-910`) and
`_resolve_test_self_path` (`cli_commands.sfn:749-755`) no longer need the
`_shell_read_cmd("readlink -f /proc/self/exe")` last-ditch leg. Both can fall
back to `exe_path()` instead:

```
fn _resolve_self_path(binary_dir: string) -> string ![io] {
    if binary_dir.length > 0 {
        let candidate = _path_join(binary_dir, "sailfin");
        if fs.exists(candidate) { return candidate; }
    }
    let self_raw: *u8 = exe_path() ...   // or call the exec.sfn helper
    return self_raw as string;           // "" if it failed
}
```

Caveat: `cli_main.sfn` / `cli_commands.sfn` are *compiler* sources, not
`runtime/sfn`. Confirm `exe_path` is importable there (it lives in
`runtime/sfn/platform/exec.sfn`; the compiler already imports runtime platform
helpers — verify the import graph). If a direct import is awkward, the
`cli_main.sfn::fn main` argv[0] fallback (`cli_main.sfn:2236-2256`) already
calls `exe_path()` and threads `binary_dir`, so in practice `binary_dir` is
non-empty by the time these helpers run; the shell leg is then pure dead code
and can simply be deleted (return `""`). **Prefer deleting the shell leg**
(replace with `return "";`) over re-plumbing an import, to keep the blast
radius minimal — the `binary_dir` arg is the real resolution path and now
derives from a working `exe_path()`. This is a judgment the implementer
confirms against the import graph.

**Windows C stubs become deletable.** `runtime/native/src/sailfin_runtime.c:61-102`
provides `readlink` (always returns -1) and `realpath` (forwards to `_fullpath`)
only because `exec.sfn` previously emitted unconditional `call`s to `readlink`
on Windows. After this change the Windows leg emits `GetModuleFileNameA`
instead of `readlink`, so the `readlink` stub is no longer reached. `realpath`
is still called by the new `exe_path()` body and by `resolve_runtime_root`, so
the `_fullpath` forwarder must stay (or be re-expressed). **Decision:** delete
the `readlink` stub; **keep** the `realpath`→`_fullpath` forwarder until a
follow-up natively replaces `realpath` on Windows. This is a *net reduction* in
C, consistent with #390. `[MAC-CI]` is not the gate here — Windows
cross-compile (`make ci-cross-windows`) is, but the readlink-stub deletion is
verifiable by confirming no `call @readlink` appears in the Windows-target IR.

---

## 5. Migration plan (ordered; each step self-hosts)

1. **Registry + selector + dispatcher + render-skip (compiler-side only).**
   Add the four descriptor rows (§4.3), `exe_path_locator()` (§4.6), the
   dispatcher branch (§4.5), and the `rendering.sfn` skip (§4.4). At this point
   the sentinel exists and lowers correctly, but nothing *calls* it yet — the
   Linux self-host is unaffected (no `exec.sfn` change, no new `call` in the
   compiler's own IR). `make compile` + `make check` stays green on Linux.
   `[MAC-CI]` not required yet (no behavior change on the build host); CI
   IR-shape test (§6) validates all three legs via `uname` shim.

2. **Cut `exec.sfn::exe_path()` over to the sentinel (§4.7).** This is the
   functional change. On Linux the emitted IR is `call i64 @readlink(...)` —
   identical effective behavior to today, so self-host stays green. This is the
   step that, on macOS, makes `exe_path()` return a real path. **`[MAC-CI]`
   required**: this is the first step whose correctness can only be confirmed
   on a Mac runner (the e2e acceptance gate, §6).

3. **Collapse the shell `readlink -f` fallbacks (§4.8).** Delete the
   `_shell_read_cmd("readlink -f /proc/self/exe")` legs in
   `_resolve_self_path` / `_resolve_test_self_path`. Self-host green on Linux
   (the `binary_dir` leg already handles the dev tree). `[MAC-CI]` confirms the
   test runner still self-spawns on macOS.

4. **Delete the Windows `readlink` C stub (§4.8).** Keep the `realpath`
   forwarder. Validate via `make ci-cross-windows` (no `call @readlink` in IR;
   link succeeds). Independent of steps 2–3 once step 1 lands.

Steps 2, 3, 4 are independently revertible. Step 1 must precede all of them.

---

## 6. Test strategy

- **IR-shape unit/e2e per target** — clone `compiler/tests/e2e/test_errno_locator_platform.sh`
  into `test_exe_path_intrinsic_platform.sh`. Fixture calls
  `sailfin_intrinsic_exe_path(buf, 4096)`. Use the `uname` shim + `SAILFIN_TARGET_OS`
  to force each leg and assert:
  - Linux: emitted IR contains `call i64 @readlink(`, no `@_NSGetExecutablePath`,
    no `@GetModuleFileNameA`.
  - Darwin: `call i32 @_NSGetExecutablePath(`, `alloca i32`, `call i64 @strlen(`,
    no `@readlink`.
  - Windows: `call i32 @GetModuleFileNameA(`, no `@readlink`,
    no `@_NSGetExecutablePath`.
  - No leg emits `call`/`declare` to `sailfin_intrinsic_exe_path` (sentinel must
    vanish into the concrete symbol).
  This test is host-independent and runs on the Linux CI runner.
- **exec-path reader test** — clone `errno_reader_test.sfn` into
  `test_exe_path_reader.sh`, pinning the shape of the *real* shipped
  `exec.sfn::exe_path()` body per forced target (locator call + `realpath`
  canonicalization). Host-independent, runs on Linux CI.
- **`[MAC-CI]` e2e acceptance gate (the real bug)** — a macOS arm64 runner job
  that: builds the compiler, installs it via `install.sh` to the
  `versions/<v>/sailfin` + `~/.local/bin/sfn` symlink layout, then runs
  `sfn run examples/basics/hello-world.sfn` invoked as the **bare PATH name
  `sfn`** (reproducing argv[0]=="sfn"). Assert: exit 0, hello-world output, and
  **no** `cannot resolve self path` / `link failed` / `attempting seed
  fallback` lines. This is the only place the original bug reproduces.
- **Windows cross gate** — `make ci-cross-windows`: assert link succeeds with
  the `readlink` stub deleted and `GetModuleFileNameA` in the IR.

---

## 7. Self-host risk

Low on the build host (Linux). Step 1 adds inert registry rows + a dispatcher
branch reached only by a sentinel nothing calls yet. Step 2's Linux leg emits
`call i64 @readlink(i8* @"/proc/self/exe", i8* %buf, i64 %size)` — semantically
identical to the current hand-written body, so the self-hosting binary resolves
its own path exactly as before. The one Linux-specific risk is the
string-constant interning in the dispatcher (§4.5): if the `/proc/self/exe`
global is not correctly threaded through `collected_string_constants`, the
Linux build breaks immediately and visibly at `make compile`. Mitigation: the
IR-shape test asserts the interned global appears.

macOS risk is real but uncatchable on Linux — hence the `[MAC-CI]` gate is the
acceptance criterion for step 2, not Linux self-host.

---

## 8. Rollback

Each step is independently revertible:
- Revert step 2 (the `exec.sfn` cutover) → `exe_path()` returns to Linux-only
  `readlink`, restoring exactly today's behavior. The macOS bug returns but the
  Linux self-host is unaffected.
- Step 1's registry rows are inert if step 2 is reverted (nothing calls the
  sentinel), so step 1 need not be reverted to restore the prior state.
- Steps 3/4 revert independently by restoring the shell leg / the C `readlink`
  stub.

---

## 9. Future considerations

- This is the second host-aware sentinel (after errno). If a third primitive
  needs the same treatment, factor `errno_locator_symbol()` / `exe_path_locator()`
  into a shared `host_os_tag()` selector in `lowering_debug_state.sfn` — out of
  scope here, noted for the post-#390 cleanup.
- Once cross-module import of *defined* runtime functions lands (the open item
  in `errno.sfn:36-52`), `cli_main.sfn` / `cli_commands.sfn` could import a
  single `exe_path()` instead of duplicating self-path resolution — folding
  §4.8 fully.
- Deleting the `realpath`→`_fullpath` Windows forwarder is a natural follow-up
  once a native Windows path-canonicalizer exists under #390; not in scope.
