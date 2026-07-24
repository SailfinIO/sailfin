---
sfep: 21
title: Native Windows Self-Host (MSVC ABI)
status: Accepted
type: runtime
created: 2026-06-22
updated: 2026-07-06
author: "agent:compiler-architect"
tracking: "#1485"
supersedes:
superseded-by:
graduates-to:
---

# Epic Design: Native Windows Self-Host (MSVC ABI)

Status: DESIGN GATE — not implemented. Decomposition / sequencing for review.
Author: compiler architect
Date: 2026-06-22

> This is a design deliverable. No compiler code is written here. It enumerates
> the port surface, the ordered milestones, and the replace-vs-coexist call.

---

## 1. Goal

Make the Sailfin compiler **self-host natively on a `windows-latest` runner**,
producing a **native MSVC-ABI** binary (`clang -target x86_64-pc-windows-msvc`,
`lld-link`, MSVC CRT / UCRT), replacing the current cross-compile-from-Linux
mingw path (`make ci-cross-windows`). The end state: a `windows-latest` CI job
that runs `<seed> build -p compiler` natively, passes the suite, and verifies
the self-host fixed point — mirroring the Linux/macOS build+test+selfhost shape.

---

## 2. Current state (verified this session)

### 2.1 The runtime is already fully Sailfin — there is no C runtime to port

The premise in the task brief that C helpers under `runtime/native/src/` must be
made MSVC-compatible is **stale**. `runtime/native/` was deleted (#823); the
runtime capsule manifest declares `c-sources = []` and `ll-sources = []`
(`runtime/capsule.toml:34-35`). Every runtime symbol is now a Sailfin module
under `runtime/sfn/**` plus `runtime/prelude.sfn`
(`runtime/capsule.toml:49`). The compiler emits LLVM IR for these and links them
into every binary.

**Consequence:** the "ABI port surface" (task item 1) is *not* a C-source port.
It is (a) which target triple the emitted IR / clang compile uses, and (b) the
handful of platform-divergent legs the compiler bakes at emit time. This
collapses the single highest-risk unknown the brief worried about.

The only non-Sailfin artifact in the Windows link is
`runtime/ir/windows_stubs.ll` (hand-written LLVM IR, 83 lines), compiled only by
the mingw cross target and excluded from the runtime capsule
(`runtime/ir/windows_stubs.ll:1-18`).

### 2.2 The mingw cross path

`make ci-cross-windows` (`Makefile:994-1144`) consumes Linux-emitted
`build/native/raw/*.ll`, `llvm-link`s them, compiles the linked bitcode with
`clang -target x86_64-w64-mingw32` (`Makefile:1040`), re-emits a curated
`RUNTIME_MODS` list with `SAILFIN_TARGET_OS=Windows` for clock/exec/filesystem
(`Makefile:1067,1087-1093`), links `windows_stubs.o` + runtime objects + the
program with `x86_64-w64-mingw32-gcc -static -lws2_32` (`Makefile:1123-1128`).
TLS is emulated via `-femulated-tls` (PR #1481, `Makefile` ~1040/1094). The
exe boots and runs the full frontend; `--version` and `check` exit 0.

The mingw path is **IR-cross from Linux**, not a self-host: the Windows exe never
compiles anything on Windows. Self-host is what this epic adds.

### 2.3 The four native-build blockers (root causes traced)

| # | Symptom | Root cause (file:line) |
|---|---|---|
| 1 | `enumerate_binary_capsule_sources hit iteration cap (4096)` | `fs.listDirectory` → `sfn_fs_list_dir` walks POSIX `opendir`/`readdir` and reads `dirent.d_name` at a **hardcoded POSIX byte offset** (`runtime/sfn/adapters/filesystem.sfn:660-696`, offsets `19`/`21` at `:274-276`). mingw's `readdir` has a *different* `struct dirent` layout, so names come back garbage/empty; the BFS in `capsule_resolver.sfn:3219-3261` re-enqueues bogus dirs and hits the cap at `:3221`. |
| 2 | `The system cannot find the path specified.` ×3 | Subprocess/path. Two sub-causes: (a) emit-time host detection shells out (`_shell_read_cmd("uname -s")`, `_get_env_cmd` → `printf`), and **`run_capture` is a stub on Windows** returning `-1` (`runtime/sfn/platform/process_windows.sfn:182-184`); (b) `process.run` (CreateProcessA) works but is invoked with POSIX path/flag assumptions for clang/linker. |
| 3 | `cannot resolve self path ... binary_dir="."` (#1482) | `exe_path()` returns `""` so `binary_dir` falls back to `.`. The Windows leg lowers `GetModuleFileNameA` (`core_call_emission.sfn:805-820`) but `_resolve_self_path` joins `<dir>/sailfin` with **no `.exe` suffix** (`cli_main.sfn:1046-1052`). Even with a correct path, the join misses the executable. |
| 4 | env-flag reads fail (#1483) | `_get_env_cmd` shells `printf '%s' "$NAME"` (`cli_commands_utils.sfn:147`) via `_shell_read_cmd` → `run_capture` (stubbed on Windows). `_env_flag` (`cli_commands_utils.sfn:240`) and the emit-time locators (`lowering_debug_state.sfn:193,224,248,267`) all route through it. Note `env.get`/`getenv` (`runtime/sfn/io.sfn:97`) works natively — only the **shell-out** path is broken. |

### 2.4 Toolchain reality

- **Windows host:** LLVM 22.1.8 (clang default target `x86_64-pc-windows-msvc`,
  `lld`/`lld-link`), MSYS2, GnuWin32 make 3.81 (too old for this Makefile), WSL.
- **CI `windows-latest`:** ships MSVC Build Tools + Windows SDK (UCRT) and can
  install LLVM via choco/winget. No mingw needed for the MSVC path.

### 2.5 Seed / CI plumbing

- `.seed-version` = `0.7.0-alpha.46`; one pin, read by Makefile + 4 workflows
  (`Makefile:257`, `ci.yml:148-163`). `make fetch-seed` runs `install.sh`
  (`Makefile:270-291`) and downloads a **Linux/macOS** seed; there is no Windows
  seed asset today.
- `release-tag.yml` builds per-OS via a matrix (`release-tag.yml:43-55`) and
  produces the Windows installer **only as a mingw cross-build artifact** off the
  linux leg (`release-tag.yml:240-265`). No native Windows release leg exists.
- `ci.yml` has `build-compiler-linux` (`:139`) and `build-compiler-macos`
  (`:276`) as the self-host build jobs; Windows is a cross-build step on the
  linux job (`:183-246`) plus the smoke job PR #1481 adds.

---

## 3. Constraints

1. **Self-host invariant.** Every milestone must leave a compiler that still
   self-hosts on Linux/macOS. Windows-specific changes must be *additive* —
   emit-time legs selected by target, never replacing the POSIX leg.
2. **Three pillars untouched.** Effects/capabilities/concurrency semantics do
   not change. This is a backend/runtime-platform epic.
3. **Memory cap is Linux-only.** `apply_default_mem_limit` is a no-op on Windows
   (`windows_stubs.ll:28-30`); `compiler-safety.md` confirms Darwin/Windows are
   no-ops. No change needed, but timeouts still apply.
4. **No new bash e2e.** Windows CI cannot rely on `bash`; tests are `*_test.sfn`
   (`no-bash-e2e.md`). The emit-time host-detection rewrite (blocker 4) is what
   makes this possible — it removes the compiler's own dependency on `uname`/`sh`.
5. **Seed chicken-and-egg.** A native Windows self-host needs a Windows seed that
   can already do native builds. Today's only Windows binary is the mingw cross,
   which *cannot* native-build (blockers 1–4). Bootstrap must thread through it.
6. **TOML arrays single-line** (`runtime/capsule.toml:27-33`) — any manifest edit
   stays single-line.

---

## 4. Design

### 4.1 ABI port surface (MSVC) — concrete enumeration

Because the runtime is pure Sailfin IR, the MSVC port is a **target-triple +
emit-leg** change, not a C-source port. Item by item:

| Surface | mingw today | MSVC target | Work |
|---|---|---|---|
| **Compile target** | `clang -target x86_64-w64-mingw32` (`Makefile:1040`) | `clang -target x86_64-pc-windows-msvc` (host default) | Driver must pass the MSVC triple (or omit `-target` to use host default) when compiling emitted `.ll` → `.o`. |
| **Linker** | `x86_64-w64-mingw32-gcc -static` (`Makefile:1123`) | `clang` driving `lld-link` (MSVC CRT) | `_clang_link_multi_with_opt` (`cli_main.sfn:1645-1745`) appends `-lm -lpthread` (POSIX-only). On MSVC these must be dropped; `-fuse-ld=lld` and no `-static` (MSVC CRT is dynamic by default; `/MT` static-CRT optional). |
| **CRT** | mingw libc (`-lm -lpthread -lws2_32`) | UCRT / MSVCRT | `link-libs` in `runtime/capsule.toml:51` is `["-lm", "-lpthread"]` — POSIX. Need a target-conditioned link-lib set (Windows: none required; `ws2_32`/`kernel32` are auto-linked by clang-cl). |
| **Exception model** | `setjmp`/`longjmp` on a 256-byte heap jmp_buf (`exception.sfn:136-138,199-213`) | Same — `setjmp`/`longjmp` are CRT functions on MSVC too | The Sailfin exception runtime calls libc `setjmp`/`longjmp` and **does not use SEH**. MSVC UCRT provides `setjmp`/`longjmp`; the 256-byte buffer oversizes the MSVC `jmp_buf` (`exception.sfn:52-57`). **No SEH interaction** — this is the single biggest risk-reducer vs. the brief's worry. Caveat: MSVC `setjmp` is a macro (`_setjmp`/`_setjmpex`); the emitted `call @setjmp` must bind to the CRT's actual symbol — see Risk R1. |
| **TLS** | `-femulated-tls` (PR #1481) because native PE TLS faulted on the IR-cross image | **Re-test native MSVC TLS.** The fault was specific to the mingw IR-cross image's uninitialized PE TLS directory. A native clang-msvc compile emits a proper `.tls` section + `_tls_index`; native TLS likely works. **Keep `-femulated-tls` as the safe default for milestone 1, drop it once native TLS is verified** (own milestone). `thread_local sfn_exception_frame_head_addr` (`exception.sfn:182`) is the only TLS global. |
| **Name mangling / calling conv** | mingw uses SysV-ish + cdecl on x64 | MSVC x64 ABI | x86_64 Windows has **one** calling convention (Microsoft x64) for both ABIs, and Sailfin emits C-ABI `i8*`/`i64`/`double` signatures with no name mangling (bare `@sfn_*`). Emitted IR is ABI-neutral at the LLVM level; clang's backend applies the MSVC x64 ABI when given the msvc triple. **No source change** — but verify struct-by-value ABI (the channel `channel:<struct>` work, #1472) lowers correctly under the MSVC struct-return rules (Risk R3). |
| **`windows_stubs.ll`** | provides `apply_default_mem_limit`, `sailfin_runtime_serve`, `realpath`→`_fullpath`, assert handlers (`windows_stubs.ll:28-82`) | Same gaps exist under MSVC | Re-audit each stub under MSVC: `_fullpath` is UCRT (OK); `realpath` shim still needed; the no-op stubs are target-neutral IR (OK). The file stays Windows-only. **Migrate it from a Makefile-only artifact into the driver's Windows link path** (see 4.2) so native self-host links it. |
| **Emitted code C-ABI** | bare `i8*`/`i64`/`double`, no mangling | identical | Already ABI-neutral. The emit-time *legs* (errno symbol, exe_path, fs sentinels, clock id) are the only target-divergent pieces — all selected in `lowering_debug_state.sfn` and `core_call_emission.sfn` (`:805-820` exe_path, `:906-1088` fs sentinels). These already have a Windows leg; the work is making the **selector** not shell out (blocker 4). |

**Net ABI work:** target-triple + link-flag conditioning in the driver; verify
TLS + setjmp symbol + struct-by-value ABI; no C porting.

### 4.2 Build-driver changes

The driver (`cli_main.sfn` + `capsule_resolver.sfn`) is the bulk of the epic.
Sub-items:

**(A) Target-aware clang/linker invocation** — `_clang_link_multi_with_opt`
(`cli_main.sfn:1645-1745`), `_clang_compile_runtime_capsule_objects`
(`:894-1012`), `_emit_runtime_sfn_to_obj` (`:1145-1193`):
- Introduce a single `_host_target_os()` accessor (the non-shelling one from
  blocker 4) and a `_target_triple()` / `_target_link_libs()` / `_target_no_static()`
  helper set. On Windows: omit `-lm`/`-lpthread` (read from
  `runtime/capsule.toml` `link-libs` but filter POSIX-only), omit `-static`,
  prefer `-fuse-ld=lld` (`_resolve_linker` already probes lld — `cli_main.sfn:1692`
  via `cli_commands_utils.sfn` `_linker_on_path`, which also shells out → must be
  de-shelled together with blocker 4).
- Add `windows_stubs.ll` to the Windows runtime link inputs in
  `assemble_runtime_capsule_link_inputs` (`cli_main.sfn:1485-1531`) — currently
  only the Makefile cross target links it. This is what lets a *native* link
  resolve `realpath`/assert/serve stubs without the mingw Makefile.
- Add `process_windows.sfn` to the Windows runtime source set (it's already in
  the mingw `RUNTIME_MODS` at `Makefile:1067` but **not** in
  `runtime/capsule.toml:49`). The native driver reads the capsule manifest, so
  the manifest needs a Windows-conditioned module set, OR the driver swaps
  `process.sfn`↔`process_windows.sfn` and excludes `rlimit.sfn` by target. (See
  R4 — this list-sync is currently guarded by a cross-windows e2e test.)

**(B) fs-enumeration fix (blocker 1)** — `runtime/sfn/adapters/filesystem.sfn`:
- `sfn_fs_list_dir` (`:666-696`) must use the Win32 `FindFirstFileA`/
  `FindNextFileA`/`FindClose` family on Windows instead of `opendir`/`readdir`.
  This is the **same module-split pattern** `process_windows.sfn` uses: either a
  per-target leg via the existing `sailfin_intrinsic_fs_*` sentinel seam
  (`core_call_emission.sfn:906+`) — add a `sailfin_intrinsic_fs_list_dir`
  sentinel whose Windows leg lowers `FindFirstFileA`, or a
  `filesystem_windows.sfn` sibling in the Windows runtime set. **Recommend the
  sentinel seam** — it keeps one `filesystem.ll` and matches the existing fs
  intrinsic dispatch (`mkdtemp`/`symlink`/`get_perms`/`exists` already do this).
  The `WIN32_FIND_DATA.cFileName` offset replaces the dirent offset.
- `_fs_dirent_dname_offset` (`:660-664`) probes `/proc/self/status` to pick
  Linux vs Darwin — on Windows this is moot once the Win32 leg lands.

**(C) subprocess/path-spawn fix (blocker 2)** — two parts:
- The clang/linker spawn uses `process.run` (CreateProcessA, real on Windows —
  `process_windows.sfn:68-165`). It works; the failure is path-shaped. Audit
  every constructed path/arg in the link/emit path for `/` vs `\` and for the
  `.exe` self-invocation (the child compiler is spawned as `<self> emit ...` —
  `cli_main.sfn:1057,1064-1067`). The child-spawn currently wraps in
  `sh -c "..."` (`cli_main.sfn:1064-1066`) to clear env vars — **this `sh -c`
  wrapper is itself a Windows blocker.** Replace it with `process.run_capture`'s
  per-child env array (which the runtime supports) so no shell is needed.
- `run_capture` on Windows is a stub (`process_windows.sfn:182-208`). The
  child-compiler emit path and the `_shell_read_cmd` host probes both need it.
  **Implement real `sfn_process_run_capture` on Windows** (CreatePipe +
  CreateProcessA with redirected stdout/stderr handles + ReadFile). This is the
  largest single runtime item; it un-stubs the whole capture family.

**(D) self-path (#1482, blocker 3)** — `cli_main.sfn:1046-1052`:
- `_resolve_self_path` must try `<binary_dir>/sailfin.exe` (and `sfn.exe`) on
  Windows. Cleanest: have `fn main` thread the **already-resolved `exe_path()`**
  straight into `_resolve_self_path` rather than re-deriving `<dir>/sailfin` —
  `exe_path()` returns the real running-binary path including `.exe`. The Windows
  `GetModuleFileNameA` leg (`core_call_emission.sfn:805-820`) already returns the
  full path; the bug is the driver discarding it and reconstructing a suffixless
  name. Fix: store the full exe path in a module global at `fn main` entry and
  use it as the self-invocation argv[0] for child emits.

**(E) env-flag de-shell (#1483, blocker 4)** — `cli_commands_utils.sfn:147` and
all locators in `lowering_debug_state.sfn`:
- Replace `_get_env_cmd` (printf via `_shell_read_cmd`) with a direct
  `env.get(name)` (`runtime/sfn/io.sfn` `sfn_getenv`, which works on Windows).
  This is a strict improvement on **all** platforms (no fork per env read) and is
  the keystone fix — it removes the compiler's dependency on `sh`/`printf` for
  flags.
- Replace the `_shell_read_cmd("uname -s")` host probe in the four locators
  (`lowering_debug_state.sfn:194,224,249,268`) with a non-shelling host-OS
  detector. Options: (a) a `sailfin_intrinsic_host_os` sentinel the compiler
  resolves at its own build time (the host *is* known when the compiler is
  compiled); (b) read a compile-baked constant. **Recommend a `host_os()`
  runtime helper** that uses a platform primitive (`GetVersion`/file probe) so a
  single binary stays correct, mirroring how `_fs_dirent_dname_offset` probes
  `/proc`. The `SAILFIN_TARGET_OS` override (read via `env.get` now) stays for
  cross-compile.

### 4.3 Bootstrapping / seed

The chicken-and-egg: native self-host needs a Windows seed that can native-build,
but the only Windows binary today (mingw cross) cannot (blockers 1–4).

**Bootstrap sequence:**

1. **Stage 0 (today):** mingw-cross exe boots + runs the frontend (PR #1481).
   It cannot native-build.
2. **Stage 1 — make the *cross* exe native-build-capable.** Land blockers 1–4
   (fs-enum, run_capture, self-path, env de-shell) in `compiler/src` +
   `runtime/sfn`. Because these are compiler/runtime *source* changes, the
   **Linux self-host builds the new compiler from the old seed**, and the
   mingw-cross of *that* new compiler is now a Windows exe that can native-build.
   No Windows seed needed yet — the cross exe is the bootstrap seed.
3. **Stage 2 — native MSVC build from the cross seed.** On `windows-latest`,
   take the Stage-1 mingw-cross exe as the seed, run `<seed> build -p compiler`
   with the MSVC target. Output: the **first native MSVC compiler** (pass-1).
4. **Stage 3 — native MSVC self-host.** Pass-1 builds pass-2 (seedcheck). Verify
   pass-2 == fixed point and runs hello-world. This is the self-host proof.
5. **Stage 4 — publish a native Windows seed.** Once Stage 3 is green in CI,
   `release-tag.yml` publishes a native MSVC `sailfin-windows-x86_64` asset.
   `/pin-seed` bumps `.seed-version`; `make fetch-seed` / `install.sh` learn to
   download the Windows asset (`EXE_EXT=.exe`, the Makefile already has the var
   at `Makefile:268`). From here, native Windows self-host uses a native seed and
   the mingw-cross seed is retired.

**Key insight:** the mingw-cross exe is the *bootstrap vehicle*, not a permanent
dependency. It only needs to live long enough to build the first native exe
(Stage 2). The cross path retires after Stage 5 (see replace-vs-coexist, §6).

**`.seed-version` / fetch-seed / release-tag evolution:**
- `install.sh` + `make fetch-seed`: add a Windows asset name + `.exe` handling.
  The `FETCHED_SEED` var already accounts for `$(EXE_EXT)` (`Makefile:268`).
- `release-tag.yml`: add a native `windows-x86_64` matrix leg
  (`runs-on: windows-latest`) that self-host-builds + packages the `.exe`
  installer, replacing the linux-leg mingw cross artifact (`:240-265`).
- Seed-blocker discipline: blockers 1–4 + the run_capture port carry the
  `seed-blocker` label — they must be in the pinned seed before a native
  Windows seed is cut.

### 4.4 CI architecture

Mirror the per-OS build-compiler job shape:

- **New `build-compiler-windows` job** (`ci.yml`, sibling of `build-compiler-macos`
  at `:276`): `runs-on: windows-latest`, install LLVM (clang+lld) via choco,
  fetch the seed (Stage 1 cross exe initially; native exe after Stage 4), run the
  sailfin-build action with `target: windows-x86_64`, upload the build tree.
- **New `build-test-windows` shard job** (sibling of `build-test-linux` at
  `:368`): consume the Windows build tree, run the suite, run the triple-pass
  self-host verify (the `selfhost1`/`selfhost2` shape at `ci.yml:623-632`).
- **Makefile:** the GnuWin32 make 3.81 on the host is too old; CI should drive
  the build through the **sailfin-build composite action** (already used by
  Linux/macOS — `ci.yml:172`) or a thin PowerShell script, not the Makefile's
  bash-heavy targets. The `ci-cross-windows` target stays for the bootstrap
  window only.

### 4.5 Recommended replace-vs-coexist call

**Coexist during the transition, then replace.** Concretely:
- Keep `ci-cross-windows` + the smoke job through Stages 1–3 — it is the only
  thing producing a Windows binary and is the bootstrap seed source.
- Once `build-test-windows` (native MSVC self-host) is green for one full release
  cycle and a native Windows seed is published (Stage 4–5), **retire
  `ci-cross-windows`, the `RUNTIME_MODS` Makefile loop, and the
  `release-tag.yml` linux-leg Windows artifact.** Keep `windows_stubs.ll` and
  `process_windows.sfn` (now consumed by the native driver). Delete
  `-femulated-tls` only after native TLS is verified (its own milestone).

Rationale: replacing before the native path proves out would leave Windows with
*no* working binary if the MSVC path hits an unknown. The cross path is cheap to
keep (one Makefile target) and is the safety net.

---

## 5. Phasing & sequencing (milestone table)

Sizes are XS/S/M (never L per issue contract). "Blocked by" gives the DAG.

| # | Milestone | Scope | Size | Blocked by |
|---|---|---|---|---|
| **M0** | env-flag de-shell (#1483) | Replace `_get_env_cmd` printf shell-out with `env.get`; de-shell `_linker_on_path`. Keystone — removes `sh`/`printf` dep on all platforms. | S | — |
| **M1** | host-OS detection de-shell | Replace `_shell_read_cmd("uname -s")` in the 4 locators (`lowering_debug_state.sfn`) with a non-shelling `host_os()` (sentinel or runtime probe). | S | M0 |
| **M2** | self-path `.exe` (#1482) | Thread `exe_path()` full path into `_resolve_self_path`; handle `.exe`. | XS | M0 |
| **M3** | Windows `run_capture` | Real `sfn_process_run_capture` (CreatePipe + CreateProcessA + ReadFile) in `process_windows.sfn`; un-stub the capture family. | M | — |
| **M4** | child-spawn de-shell | Replace the `sh -c "..."` env-clearing child-emit wrapper (`cli_main.sfn:1064-1066`) with `run_capture` per-child env. | S | M0, M3 |
| **M5** | fs enumeration (blocker 1) | `sailfin_intrinsic_fs_list_dir` sentinel + Win32 `FindFirstFile` leg; fix the dirent-offset enumeration on Windows. **Landed (seed-gated split):** sentinel capability SFN-51 / PR #2355 (in the pinned seed since `v0.8.0`); runtime consumer flip SFN-374. | M | M1 |
| **M6** | driver target conditioning | `_target_triple`/`_target_link_libs`/no-`static`/lld for MSVC; add `windows_stubs.ll` + `process_windows.sfn` to the native Windows link/runtime set. | M | M0, M1 |
| **M7** | **first native MSVC build (booting)** | On `windows-latest`, cross-seed → `<seed> build -p compiler` MSVC → a booting native exe (`--version`, `check`). **Smallest first natively-built booting binary.** | S | M2, M4, M5, M6 |
| **M8** | native self-host fixed point | pass-1 → pass-2 == fixed point; hello-world runs. | S | M7 |
| **M9** | CI `build-compiler-windows` + `build-test-windows` | Mirror macOS jobs; suite + triple-pass selfhost verify. | M | M8 |
| **M10** | native TLS (drop `-femulated-tls`) | Verify native MSVC PE TLS for the one `thread_local`; drop the flag. | S | M7 |
| **M11** | native Windows seed + release | `release-tag.yml` native leg, `install.sh`/`fetch-seed` `.exe`, `/pin-seed`. | M | M9 |
| **M12** | retire mingw cross | Delete `ci-cross-windows`, RUNTIME_MODS loop, linux-leg Windows artifact. | S | M11 (+1 cycle) |

**Smallest first deliverable that yields a natively-built, booting Windows
binary:** **M7**, gated by M2+M4+M5+M6 (and transitively M0/M1/M3). M0 is the
true unblocker — almost everything depends on de-shelling.

**Mapping the brief's issues:** #1482 → M2; #1483 → M0. New issues: M1
(host-OS), M3 (run_capture), M4 (child-spawn), M5 (fs-enum), M6 (driver target),
M7–M12 (build/toolchains/seed/CI).

**Bundling note (decomposition discipline):** M5's fs-enum *capability* (the
`fs_list_dir` sentinel) and its runtime consumer were **split**, not bundled:
`runtime/sfn/adapters/filesystem.sfn` is the compiler's own runtime, so `sfn
build -p compiler` compiles it with the *pinned seed*, which cannot resolve a
brand-new intrinsic (`E0420`) — the sentinel must ship in the seed first. So the
capability landed alone (SFN-51 / PR #2355, `seed-blocker`) and the consumer flip
followed after a seed bump carried it (SFN-374). Same for M3's `run_capture`
runtime body + M4's consumer — but M4 also depends on M0, so they are honestly
separable. M0+M1+M2 are independent small wins that could
ship as one "de-shell the compiler" PR if grooming prefers, but M0 alone is the
load-bearing one and is worth landing first to de-risk everything else.

---

## 6. Risks & invariants

**Invariants preserved:** self-host (every milestone keeps Linux/macOS green —
all changes are additive emit-legs/target-conditions); three pillars untouched
(backend epic); memory cap (Windows no-op, unchanged); no bash e2e (M0/M1 remove
the compiler's own `sh` dependency, *enabling* this).

**What could regress Linux/macOS:** M0/M1 (env + host-OS) touch hot,
all-platform code paths. `env.get` must match the printf-capture semantics
exactly (empty vs unset, trailing-newline trim — `_shell_read_cmd` trims via
`_toml_trim_cmd`, `cli_commands_utils.sfn:144`). M6's link-flag filtering must
not drop `-lm`/`-lpthread` on POSIX. Both gated by full `make check` on
Linux+macOS before merge.

**Top 3 risks + mitigations:**

1. **R1 — `setjmp`/`longjmp` symbol binding under MSVC UCRT.** MSVC's `setjmp`
   is a macro expanding to `_setjmp`/`_setjmpex` with a second frame-pointer
   argument; the runtime emits a bare `call i32 @setjmp(i8*)`
   (`exception.sfn:136`). If clang-msvc does not redirect `@setjmp` to the
   2-arg CRT entry, the exception runtime corrupts on first `try`. **Mitigation:**
   verify in M7 with a minimal try/throw fixture; if it mis-binds, add a
   Windows-leg sentinel (like errno) that emits the correct `_setjmpex` call, or
   provide a `windows_stubs.ll` `setjmp` shim. Detection: the existing exception
   e2e (`test_runtime_exception_frames` lineage) on the native exe.

2. **R2 — `run_capture` (M3) is the deepest unknown.** The whole self-host build
   spawns the child compiler and captures output; the Win32 pipe + redirected-
   handle dance (CreatePipe, SetHandleInformation, overlapped vs blocking reads,
   deadlock on full pipe buffers) is subtle and currently entirely stubbed.
   **Mitigation:** land M3 standalone with a dedicated `*_test.sfn` that spawns a
   known child and asserts captured stdout *before* it's on the self-host
   critical path; model on the POSIX body's pipe/poll structure
   (`process.sfn:499+`). Use blocking reads with both pipes drained on separate
   reads to avoid the classic full-buffer deadlock.

3. **R3 — struct-by-value ABI divergence (Microsoft x64).** Recent concurrency
   work added by-value struct channel elements (#1472) and struct returns. The
   Microsoft x64 ABI passes/returns aggregates differently from SysV (>8/16-byte
   structs go by hidden pointer; specific size rules differ). If the emitter's
   IR assumes SysV aggregate lowering anywhere, MSVC codegen silently mismatches.
   **Mitigation:** the emitter produces typed LLVM aggregates and lets clang's
   backend apply the target ABI, so this *should* be transparent — but verify
   with a struct-channel + struct-return fixture in M7/M8. Detection: a value
   round-trip test; failure mode is garbage struct fields, caught by an equality
   assert.

**Honorable mention (downgraded by §2.1):** the brief's headline risk — C
runtime MSVC incompatibility — is **largely retired**: there is no C runtime.
The residual is `windows_stubs.ll` (4 small IR stubs, target-neutral) and the
emit-time legs, both already partially Windows-aware.

---

## 7. Verification

Per-milestone (run on the relevant OS):

- **M0/M1/M2:** `sfn check compiler/src/`, then `make check` on Linux **and**
  macOS — these touch all-platform code; the gate is no Linux/macOS regression.
- **M3:** new `process_run_capture_windows_test.sfn` on `windows-latest` spawns a
  child that prints a sentinel and asserts captured stdout == sentinel.
- **M4:** child-emit path produces byte-identical `.o` on Linux (no behavior
  change) + works on Windows.
- **M5:** `enumerate_binary_capsule_sources` over `compiler/src` returns the full
  module set on Windows (no iteration-cap warning); assert count == Linux count.
- **M6:** native `clang -target x86_64-pc-windows-msvc` compile of one emitted
  `.ll` links with `lld-link`; no `-lm`/`-lpthread`/`-static`.
- **M7:** `<cross-seed> build -p compiler` on `windows-latest` → exe; exe
  `--version` and `check examples/basics/hello-world.sfn` exit 0; try/throw +
  struct-channel fixtures pass (R1/R3 gate).
- **M8:** triple-pass — pass1 builds pass2, `fc /b` (binary compare) or hash-equal
  fixed point; `sailfin run examples/basics/hello-world.sfn` exit 0.
- **M9:** CI `build-test-windows` green (full suite + selfhost verify).
- **M10:** M7 fixtures pass with `-femulated-tls` removed.
- **M11:** `make fetch-seed` downloads the Windows `.exe`; `<native-seed> build -p
  compiler` self-hosts.
- **Final:** Linux + macOS + Windows all run `make check`-equivalent self-host
  fixed point green; mingw cross retired (M12).

---

## 8. Future considerations (1.0 interactions)

- **Concurrency runtime (pillar 3).** The structured-concurrency work
  (`runtime/sfn/concurrency/*`, recent #1472/#1474/#1477) uses POSIX threads
  (`-lpthread`). Windows needs a Win32-threads or C11-threads leg; the
  `process_windows.sfn` split pattern is the template. **This epic does not block
  on it** (the scheduler/nursery modules are in `capsule.toml:49` but the Windows
  runtime set can stub them initially via the `windows_stubs.ll` `serve` no-op
  precedent), but full Windows concurrency is a follow-on epic. Flag it so M6's
  runtime-set decision leaves room.
- **`runtime/capsule.toml` per-target source sets.** This epic forces a
  target-conditioned runtime module list (process vs process_windows, rlimit
  exclusion, stubs). That mechanism (a `[target.windows]` overlay or driver-side
  swap) is reusable for the concurrency-leg work and for any future
  `sfn build --target` cross-compile — design M6's mechanism to generalize, not
  to special-case Windows inline.
- **`sfn build --target=x86_64-pc-windows-msvc`.** The Makefile comments
  repeatedly promise that a real `--target` flag retires the cross hack
  (`Makefile:988`, `windows_stubs.ll:18`). M6's target-conditioning is exactly
  the foundation for that flag; landing it as a first-class `--target` (not a
  Windows special-case) pays forward to Linux→Windows and macOS→Windows
  cross-compile without re-architecting.
- **Multi-line TOML arrays.** The single-line constraint
  (`runtime/capsule.toml:27-33`) will fight a `[target.*]` overlay; the parser
  extension is a small predecessor if M6 chooses the manifest-overlay route over
  the driver-swap route.
