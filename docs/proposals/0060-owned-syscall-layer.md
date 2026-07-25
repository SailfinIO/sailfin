---
sfep: 60
title: The Owned Syscall Layer (Axis 3, tier-1 Linux x86-64)
status: Accepted
type: runtime
created: 2026-07-25
updated: 2026-07-25
author: "agent:compiler-architect; project owner (design gate 2026-07-25)"
tracking: "SFN-510, SFN-513, SFN-515, SFN-516, SFN-518, SFN-520, SFN-521, SFN-522, SFN-523, SFN-524, SFN-525"
supersedes:
superseded-by:
graduates-to: reference/runtime-abi.md
---

# SFEP-0060 — The Owned Syscall Layer (Axis 3, tier-1 Linux x86-64)

> Implementation design for SFEP-0015 §8 Stage 4(a) / Axis 3, and the
> enforcement chokepoint SFEP-0016 §3 depends on. SFEP-0015 says *what*
> ("drop libc on tier-1") and SFEP-0016 says *why* ("one chokepoint the
> compiler controls"). Neither says *which calls*, *what primitive*, or
> *in what order* — this does.

## 1. Summary

Sailfin reaches the operating system through ~170 `extern fn` declarations in
`runtime/`. This proposal classifies that surface, establishes that only about
**thirty** of those symbols are effect-bearing kernel entries, and specifies a
compiler-owned primitive — a `syscall1`…`syscall6` builtin, restricted by a
module allowlist to exactly one runtime module — through which those thirty
route on Linux x86-64. macOS and Windows keep their vendor-library leg behind
the same Sailfin-level seam so the gate mediates uniformly on all tier-1
targets (SFEP-0015 §10).

The load-bearing claim is not "raw syscalls are faster or purer." It is that
**an effect annotation is only enforceable if every path to the kernel passes
through Sailfin source the compiler can see.** Today `![net]` is a promise the
compiler makes and then hands to `libc.so`, which will issue `connect(2)` for
anybody. After this proposal, `connect(2)` exists at exactly one address in the
binary, in a Sailfin function the compiler emitted, with an effect annotation on
it and a gate hook inside it.

## 2. Motivation

### 2.1 The surface, classified

Enumerated from `runtime/sfn/platform/*.sfn`, `runtime/sfn/io.sfn`,
`runtime/sfn/process.sfn`, `runtime/sfn/exception.sfn`, `runtime/sfn/array.sfn`,
and `runtime/sfn/adapters/*.sfn`. Excluding runtime-internal `sfn_*` symbols
(runtime-to-runtime FFI, not a libc dependency) and the Windows/Darwin-only
legs, the libc/POSIX surface partitions cleanly into three classes.

**Class A — thin kernel entries (a `syscall` instruction is a faithful
replacement).** These are libc functions whose entire body is "load registers,
`syscall`, translate the return into `-1`/`errno`":

| Subsystem | Symbols |
|---|---|
| fd I/O | `read`, `write`, `close`, `open`, `pipe`, `poll` |
| fs metadata | `stat`, `unlink`, `mkdir`, `rmdir`, `chmod`, `access`, `symlink`, `readlink` |
| net | `socket`, `bind`, `listen`, `accept`, `connect`, `send`, `recv`, `setsockopt`, `getsockname` |
| process | `execve`, `waitpid`/`wait4`, `kill`, `exit` |
| clock / entropy | `clock_gettime`, `nanosleep`, `getentropy` |
| limits | `getrlimit`, `setrlimit` |

That is ~30 symbols and it is, exactly, the effect-bearing surface: every
`![io]`, `![net]`, and `![clock]` capability in the language bottoms out here.
**Class A is the entire seal.**

**Class B — pure computation, never enters the kernel.** `memcpy`, `memset`,
`memcmp`, `memchr`, `strlen`, `strnlen`, `strchr`, `strrchr`, `strstr`,
`strcasestr`, `strcmp`, `strtod`, `strtoll`, `atoi`. These carry no capability
and cannot be used to escape one: a byte copy is not an authority. Replacing
them advances "no libc in the link," not "the seal holds," and it carries a
non-obvious hazard — LLVM's idiom recognizer synthesizes calls to `memcpy` /
`memset` / `memcmp` / `strlen` from ordinary loops, so a Sailfin function *named*
`memcpy` will be rewritten into a call to itself unless its definition carries
`"no-builtins"`. Class B stays on libc until the gate in §3.7 opens.

**Class C — needs real libc semantics; each needs its own strategy.**

| Symbol(s) | Why it is not a syscall | Strategy, and the gate that opens it |
|---|---|---|
| `malloc`/`free`/`realloc`/`calloc` | Allocator, not a kernel call | Sailfin allocator over `mmap`/`munmap`; gate: `runtime/sfn/memory/arena.sfn` owning its own page acquisition |
| `setjmp`/`longjmp` | Register save/restore; no syscall exists | Needs a compiler-owned unwind primitive; gate: an unwind design that replaces `runtime/sfn/exception.sfn`'s jmp_buf |
| `getenv`, `environ` | Populated by the dynamic loader from the initial stack | Requires owning `_start`; gate: a `-nostdlib` link (§3.7) |
| `pthread_*` | `clone` + futex + TLS + per-thread stacks | Scheduler-owned; gate: `runtime/sfn/concurrency/scheduler.sfn` owning thread creation |
| **`getaddrinfo`/`freeaddrinfo`** | **NSS + DNS; issues its own un-gated `socket`/`sendto`** | **Sailfin A-record resolver over owned sockets — see §2.2** |
| `fopen`/`fread`/`fwrite`/`fclose` | stdio buffering | Own buffering over owned `open`/`read`/`write`; gate: none technical — sequenced after fs metadata |
| `popen`/`pclose` | Forks `/bin/sh` with full ambient authority | See §2.2 |
| `posix_spawnp` + `posix_spawn_file_actions_*` | libc-internal file-actions state machine over `clone`/`execve` | Sailfin `fork`/`execve` + explicit fd plumbing |
| `opendir`/`readdir`/`closedir` | Buffered wrapper over `getdents64` with per-libc `struct dirent` layout | Sailfin `getdents64` walk — *removes* the `DIRENT_DNAME_OFFSET` per-platform hack in `runtime/sfn/platform/sizes_linux.sfn` |
| `realpath`, `mkdtemp` | libc algorithms over `readlink`/`stat`/`mkdir` | Sailfin reimplementation over Class A |
| `sysconf` | auxv-derived | Already sentinel-ized (`sailfin_intrinsic_sc_nprocessors_onln`) |
| OpenSSL `SSL_*` | Vendor library with its own syscalls | See §2.2 |

### 2.2 Three holes the classification exposes

These are not implementation details; they bound what the seal can honestly
claim, and SFEP-0016 §8 does not currently name them.

1. **`getaddrinfo` bypasses the gate.** Every `sfn/net` DNS resolution today
   enters libc, which opens its own UDP socket and talks to port 53. Routing
   `connect(2)` through an owned stub while `getaddrinfo` still runs inside
   libc means a `![net]`-free capsule that resolves a hostname has already made
   a network syscall the gate never saw. **`![net]` cannot be enforced to the
   syscall until DNS is Sailfin source.**
2. **`popen` spawns a shell.** `runtime/sfn/io.sfn::sailfin_runtime_shell_capture`
   forks `/bin/sh`, and the compiler's own build driver uses it
   (`compiler/src/emit_helpers.sfn`, `compiler/src/build/fs.sfn`). A sealed
   process that can spawn a shell has no seal.
3. **OpenSSL is linked native code.** `runtime/capsule.toml` links `-lssl
   -lcrypto` into *every* Sailfin binary. Those objects contain their own
   `syscall` paths. This is the concrete instance of SFEP-0016 open question 4,
   and it is unanswered: a byte-level "no raw `syscall` opcode in linked
   objects" rule rejects OpenSSL, and a rule permissive enough to admit OpenSSL
   admits everything.

## 3. Design

### 3.1 The primitive: `syscall1`…`syscall6` builtins

There is no way to express a raw syscall in Sailfin today: there is no inline
asm, and `compiler/src/llvm/` contains no `syscall` emission. The primitive must
be added, and the precedent is exact — `load_byte`
(`compiler/src/llvm/byte_load.sfn`) and the six atomic intrinsics
(`compiler/src/llvm/atomics.sfn`, SFEP-0025 §3.9.4) are reserved names that
bypass call resolution and lower straight to LLVM instructions.

```sfn
// Signature family (all operands and the result are `int` / i64).
syscall1(n: int, a1: int) -> int
syscall2(n: int, a1: int, a2: int) -> int
// … through syscall6
```

Address operands cross as `i64`, matching the established runtime byte idiom
(`load_byte(addr: int)`, `_num_put_byte(addr: i64, …)`); callers write
`buf as i64`.

**Return convention — the one semantic difference from libc.** A raw Linux
syscall returns the result in `rax`, with failures encoded as `-errno` in the
range `[-4095, -1]`. It does **not** touch the thread-local `errno` slot. The
stub layer (§3.3) converts `-errno` into whatever shape the adapter above it
already expects, so nothing above `runtime/sfn/platform/` changes. The existing
`errno()` reader (`runtime/sfn/platform/errno.sfn`) stays valid for the calls
still on libc, and is simply not consulted for owned calls.

**LLVM lowering (Linux x86-64 only).** A new `compiler/src/llvm/syscall.sfn`,
structured like `byte_load.sfn`, emits SysV inline asm — `rax`/`rdi`/`rsi`/
`rdx`/`r10`/`r8`/`r9` in, `rax` out, clobbering `rcx`, `r11`, and memory. The
exact constraint string is load-bearing and gets an IR-shape regression test.
On any other target the builtin **fails lowering with a diagnostic**; it never
degrades silently to a call.

### 3.2 The allowlist is not hygiene — it is the static half of the seal

The builtin carries **no effects**. `syscall3(41, …)` is `socket(2)` and the
effect checker cannot know that from an integer. If any Sailfin module could
call it, `![net]` would be one integer literal away from meaningless.

Therefore typecheck restricts the builtin to a single blessed module path:
`runtime/sfn/platform/syscall_linux.sfn`. Every other caller is a hard
diagnostic. The per-syscall wrappers *in* that module carry the real effect
annotations (`![io]`, `![net]`, `![clock]`), and because they are the only way
to reach the instruction, those annotations become load-bearing rather than
advisory. The allowlist is what converts "the compiler emitted a syscall" into
"the compiler knows which capability that syscall spends."

### 3.3 The stub modules

Two modules with identical signatures, selected by
`target_condition_runtime_sfn_sources` (`compiler/src/build/target.sfn`):

- `runtime/sfn/platform/syscall_linux.sfn` — syscall-number constants, the
  per-call wrappers, the `-errno` translation, and the gate hook. The only
  module permitted to call the builtin.
- `runtime/sfn/platform/syscall_posix.sfn` — the same wrapper names and
  effects, implemented over the existing libc externs. This is the macOS and
  Windows leg SFEP-0015 §10 requires: neither platform exposes a stable
  raw-syscall ABI, and **the gate hook lives in both legs**, so capability
  mediation is uniform even where the kernel entry is not owned.

Consumers (`io.sfn`, `adapters/filesystem.sfn`, `adapters/net.sfn`,
`clock.sfn`, `platform/rand.sfn`, `process.sfn`) call the wrapper names and
never the builtin. Cross-module import of a *defined* function between runtime
`sfn-sources` works today — `runtime/sfn/string.sfn` imports `owned_buf_new`
from `./memory/ownedbuf` — so the fan-out needs no new compiler capability.
(The contrary claims in the header comments of `runtime/sfn/platform/errno.sfn`
and `sizes_linux.sfn` predate the sibling-staging work in `runtime_objs.sfn`
and are stale.)

### 3.4 The gate hook

Each wrapper opens with a check against the process's sealed capability mask
before issuing the instruction. v0 is a process-wide mask derived from the
linked capsule manifest and emitted as a module global; per-task attenuation
(SFEP-0016 §5) replaces the mask read with a scheduler-context read without
changing any wrapper's shape. A denied call returns a capability-violation
result — it traps, it does not segfault, and it does not fall through to libc.

### 3.5 Sequencing, and why `io.sfn` is the beachhead

`write(2)` / `read(2)` on file descriptors is the first conversion:

- **Cleanest mapping.** `SYS_write` is 1, `SYS_read` is 0; three integer
  arguments each; no struct layouts, no allocator, no TLS, no dynamic-loader
  interaction.
- **The best oracle in the repo.** Every `print` in every Sailfin program flows
  through `sfn_print` → `_sfn_write_all` → `write`. The entire existing test
  suite is a differential harness for this one change, at zero authoring cost.
- **Already effect-annotated.** `sfn_write_fd` is `![io]`, so the gate hook has
  a natural home on the first try.

Order after that, by decreasing oracle quality and increasing coupling: fs
metadata → directory enumeration → sockets → clock/entropy → process
spawn/wait. Sockets rank high despite the coupling because they are the seal's
marquee demonstration (`![net]` enforced at the instruction).

**Libc is the oracle, which makes this work unusually agent-amenable.** For
every Class A symbol there is a reference implementation on the same machine
with identical observable semantics, so each conversion has a mechanical,
falsifiable acceptance test: run the same fixture against the libc leg and the
owned leg and compare return values, errno values, and externally visible
state. This is the same differential-testing property SFEP-0015 §5 credits for
compressing the seal-sufficient backend timeline, and it applies at least as
strongly here.

### 3.6 Self-hosting: exactly one seed gate

`make compile` self-hosts against the pinned seed, and the seed compiles the
**working-tree runtime** (`runtime/capsule.toml` `sfn-sources`, via
`_compile_runtime_sfn_sources` in `compiler/src/build/runtime_objs.sfn`).
A builtin used by runtime source must therefore exist in the *seed*, not merely
in the freshly built compiler. `runtime/sfn/string.sfn` records the precedent
verbatim: "seed 0.7.0-alpha.41 carries the `load_byte` builtin."

This is the one case where `.claude/rules/seed-dependency.md`'s bundling default
cannot apply: bundling the builtin with its consumer does not help, because the
consumer is compiled by the old seed in the same pass. The builtin therefore
lands alone, marked `seed-blocker`, and every consumer carries
`## Required in pinned seed:`. The mitigation is to cross the gate **once**: the
builtin PR lands the full `syscall1`…`syscall6` family and the allowlist, not a
per-subsystem trickle that would force a seed cut per conversion.

### 3.7 What stays on libc, and the gate that removes it

The link stays dynamic against libc after every conversion in §3.5. Removing it
requires a `-nostdlib` static link, which is gated on **all** of: an owned
allocator (Class C `malloc`), an owned unwind primitive (Class C `setjmp`), an
owned `_start` that captures `argc`/`argv`/`envp` (Class C `getenv`), owned
thread creation (Class C `pthread_*`), and a resolution of the OpenSSL question
in §2.2. Until that link exists, libc remains reachable through the PLT and the
seal's claim is bounded to "Sailfin-authored code cannot make an un-gated
syscall" — which is a real, testable claim, but is **not** the stronger claim in
SFEP-0016 §8 ("even via FFI or dynamically loaded native code"). That stronger
claim must not be marketed before the `-nostdlib` link ships.

## 4. Effect & capability impact

This is the interaction. The effect system gains a physical enforcement point:
after §3.2, the set of instructions in a Sailfin binary that can enter the
kernel is finite, enumerable, and annotated. `![io]` / `![net]` / `![clock]`
stop being erased at codegen for the Sailfin-authored half of the program.

Two honesty constraints follow. First, the builtin itself is effect-free by
construction, so the allowlist is a *correctness* requirement, not a style
preference. Second, until §2.2's three holes close, the enforcement boundary is
"Sailfin source," not "the process" — `docs/status.md` and any public wording
must say so.

## 5. Self-hosting impact

Passes touched: **typecheck** (`compiler/src/typecheck_types.sfn` — builtin
recognition alongside the atomics, plus the module allowlist),
**LLVM lowering** (new `compiler/src/llvm/syscall.sfn`; pre-resolution dispatch
hook in `compiler/src/llvm/expression_lowering/native/core_call_lowering.sfn`),
and **build/target conditioning** (`compiler/src/build/target.sfn` for the
Linux/POSIX stub-module swap). The parser, AST, `.sfn-asm`, and effect checker
are unchanged — a builtin is an ordinary call expression syntactically.

The invariant is preserved by §3.6: the builtin PR is additive (no runtime or
compiler source uses it, so the seed compiles an unchanged tree), and consumers
land only after the seed carries it.

## 6. Alternatives considered

- **General inline asm.** Strictly more expressive and strictly worse here: a
  user-reachable `asm` block makes SFEP-0016 §8's "no un-gated syscall path"
  unenforceable by construction, and it is a permanent language surface added
  for one runtime module. Rejected — a keyword can never become a variable name
  (CLAUDE.md), and a hole can never be un-punched.
- **Hand-written per-arch assembly objects (the Go model).** Go ships `.s`
  syscall stubs. For Sailfin this reintroduces non-Sailfin source into a
  toolchain whose stated end state has none, and it moves the chokepoint outside
  the compiler's view — the opposite of the point.
- **A registry sentinel** (`sailfin_intrinsic_syscall6`, the
  `sailfin_intrinsic_pointer_read_i32` pattern in
  `compiler/src/llvm/runtime_helpers.sfn`). Viable and nearly equivalent. The
  builtin form was chosen because the arity family needs arity/type diagnostics
  and a caller allowlist, which is what `atomics.sfn` and `byte_load.sfn`
  already model; the registry is shaped for symbol-to-symbol routing.
- **Convert the whole Class A surface in one change.** Rejected on review
  surface: ~30 syscalls across six adapters in one PR has no reviewable failure
  boundary, and the per-subsystem oracles are what make each step cheap.
- **Convert Class B first** (the mechanically easiest). Rejected: it advances no
  capability claim, and it walks straight into the LLVM `"no-builtins"` recursion
  hazard for no seal benefit.

## 7. Stage1 readiness mapping

- [ ] Parses — no new syntax; a builtin is an ordinary call
- [ ] Type-checks / effect-checks — arity/type diagnostic + caller allowlist
- [ ] Emits valid `.sfn-asm` — unchanged call node
- [ ] Lowers to LLVM IR — `compiler/src/llvm/syscall.sfn`, pinned IR shape
- [ ] Regression coverage — per §8
- [ ] Self-hosts — `make compile` after each conversion
- [ ] `sfn fmt --check` clean
- [ ] Documented in `docs/status.md` + the runtime ABI reference

## 8. Test plan

- `compiler/tests/unit/` — builtin arity/type diagnostics; allowlist rejection
  from a non-blessed module.
- `compiler/tests/e2e/` — pinned IR shape for the inline-asm constraint string;
  non-Linux/non-x86-64 lowering diagnostic.
- `compiler/tests/e2e/` — one differential fixture per converted subsystem: the
  libc leg and the owned leg produce identical return values, error codes, and
  externally visible state (`docs/conventions/e2e-tests.md`; never a `.sh`).
- The existing suite is the implicit oracle for the `io.sfn` beachhead: every
  test's stdout traverses the converted path.

## 9. References

- SFEP-0015 §8 Stage 4, §10 (tier-1 scoping), §3 (dependency map)
- SFEP-0016 §3 (the chokepoint), §7 (dependency chain), §8 (threat model),
  §9 open question 4 (link-time sealing)
- SFEP-0025 §3.9.4 (atomic intrinsics — the builtin precedent), §3.9.5 (`extern
  fn` lowering), §3.9.7 (runtime helper registry)
- `compiler/src/llvm/byte_load.sfn`, `compiler/src/llvm/atomics.sfn`
- `runtime/sfn/platform/`, `runtime/capsule.toml`
- `.claude/rules/seed-dependency.md` (and §3.6 above, the exception it does not
  cover)
