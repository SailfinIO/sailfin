---
sfep: 67
title: "Platform Access Ownership — the `-nostdlib` Program"
status: Draft
type: runtime
created: 2026-08-06
updated: 2026-08-06
author: "agent:Sailbot; project owner (strategic direction 2026-08-06)"
tracking:
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0067 — Platform Access Ownership — the `-nostdlib` Program

> **Nothing in this document is enforced today, and none of it is built.** It is
> the owner for four prerequisites SFEP-0060 §3.7 names and assigns to nobody.
> The claim discipline in CLAUDE.md applies with full force: the trajectory
> table in §3.1 exists precisely so that partial progress cannot be reported as
> "Sailfin owns its platform access."

## 1. Summary

Sailfin reaches the operating system through **528 `extern fn` declarations
across 46 files** under `runtime/` (`docs/backend-independence.md` §1).
SFEP-0060 classifies that surface and converts the ~30 effect-bearing kernel
entries on tier-1 Linux. It then names five prerequisites for the `-nostdlib`
static link that would remove libc entirely — and assigns an owner to none of
them. SFEP-0048 owns the fifth (OpenSSL). **This proposal owns the other four:**
an allocator over `mmap`, a compiler-owned unwind primitive, an owned `_start`,
and owned thread creation. It adds the extern trajectory those gates unlock, a
ratchet that keeps the count monotonically falling, and the reconciliation of
three Accepted proposals that currently break against `runtime/capsule.toml`.

The load-bearing claim is not "libc is slow" or "libc is impure." It is that
**every claim Sailfin wants to make about a binary — reach, cost, and the seal —
terminates at a boundary it does not own.** SFEP-0016 §3.1's *fully sealed* tier
is gated on `-nostdlib`; SFEP-0060 §3.7 bounds the honest claim until then to
"Sailfin-authored code cannot make an un-gated syscall" and states the stronger
claim "must not be marketed before the `-nostdlib` link ships." Four unowned
gates are the distance between those two sentences.

## 2. Motivation

### 2.1 The four orphaned gates

SFEP-0060 §3.7 states that removing libc

> requires a `-nostdlib` static link, which is gated on **all** of: an owned
> allocator (Class C `malloc`), an owned unwind primitive (Class C `setjmp`), an
> owned `_start` that captures `argc`/`argv`/`envp` (Class C `getenv`), owned
> thread creation (Class C `pthread_*`), and a resolution of the OpenSSL
> question in §2.2.

Those five appear once more each, in SFEP-0060's own Class C strategy table, and
nowhere else in the corpus. Grepping `docs/` for the gate phrasings hits only
SFEP-0060 lines 86 and 254. `mmap` appears in two SFEPs (0022, 0060); `futex` in
two (0060, 0065); `_start` meaningfully in one. They are forward references with
no destination:

| Gate | Kills | Lands in | Owner before this SFEP |
|---|---|---|---|
| Owned allocator | `malloc`/`free`/`realloc`/`calloc` | `runtime/sfn/memory/arena.sfn` over `mmap`/`munmap` | none |
| Owned unwind | `setjmp`/`longjmp` | replaces the `jmp_buf` in `runtime/sfn/exception.sfn`; **needs a compiler primitive** | none |
| Owned `_start` | `getenv`, `environ` | new entry stub; captures `argc`/`argv`/`envp` from the initial stack | none |
| Owned thread creation | `pthread_*` | `runtime/sfn/concurrency/scheduler.sfn` over `clone` + futex + TLS | none |
| OpenSSL resolution | `SSL_*` (24 externs) | `runtime/sfn/platform/tls.sfn` | **SFEP-0048** |

This is not a gap in SFEP-0060. That proposal is correctly scoped: one class,
one target, one primitive, and it says so. The gap is that its exit condition
was never picked up.

### 2.2 Why the status quo is insufficient, in the project's own words

SFEP-0025 §3.1.2 set the standing contract: "The runtime reaches OS services
through `extern fn` declarations… No C source is authored." That was the right
call for eliminating C, and Axis 1 finished on its own terms.
`docs/backend-independence.md` §1 has already retired it as guidance:

> Axis 1 "deliberately kept libc… That was the right call for getting off C, and
> it is **no longer adequate as standing guidance.**"

The direction is the project owner's, recorded at the 2026-08-06 design
conversation: the externs were a method to get off the ground, calling out to
libc; the target is native architectures; several designs are carried over from
when the compiler and runtime were Python and then C rather than native Sailfin;
and the goal is to own the whole path, because that is what permits ambition in
the designs above it and control over the language, compiler, runtime, and
capsule ecosystem.

### 2.3 The two arcs are orthogonal — and that is the good news

The most common conflation in this area is that owning platform access requires
owning code generation. It does not. `docs/backend-independence.md` §2 is
explicit: "**Axis 3 is blocked on writing a runtime body, not on owning a
backend.**" SFEP-0066 §3.5 records the same correction from the codegen side.

The one plausible counter-argument is Class B. SFEP-0060 §2.1 notes that LLVM's
idiom recognizer synthesizes calls to `memcpy`/`memset`/`memcmp`/`strlen` from
ordinary loops, "so a Sailfin function *named* `memcpy` will be rewritten into a
call to itself unless its definition carries `"no-builtins"`." That reads like a
dependency on owning instruction selection, and it is not: the mitigation is an
LLVM function attribute available today. `"no-builtins"` currently appears
nowhere in `compiler/src/` or `runtime/` — only in SFEP-0060 prose at lines 79
and 311 — so **emitting it is unimplemented work this proposal owns**, but it is
an afternoon of lowering, not a code generator.

Consequence for sequencing: this program does not wait on `sfn/codegen-native`.
The two arcs share a destination and no critical path.

### 2.4 A large extern class that is not libc at all

The 528 figure conflates two populations. Under the SFN-635 "no cross-module
extern import" convention, runtime modules re-declare `extern fn` for symbols
another **runtime** module defines: `sfn_taskqueue_create` is defined in
`concurrency/future.sfn` and separately `extern`-declared in `parallel.sfn`,
`websocket.sfn`, and `serve.sfn`. The same holds for `sfn_arena_*`, `sfn_str_*`,
`sfn_socket_*`, `tls_*`, and `sfn_spawn`/`sfn_await`.

These are the runtime talking to itself through the linker, because the module
system cannot resolve a cross-module Sailfin body. Two consequences:

1. No `-nostdlib` gate applies. This class is convertible **now**.
2. Every re-declaration is a hand-copied signature with **no cross-check**. This
   is exactly the prelude-mirror hazard of SFEP-0035 — 6 rows, latent, guarded
   by `abi_hash` — replicated across dozens of sites with no guard at all. A
   drift is invisible on a normal build and surfaces as a silent ABI mismatch.

This class is in scope for the trajectory and the ratchet (§3.1, §3.6). Its
*conversion* is a separate, ungated slice and is called out as such in §3.7 step
0 so it is not held hostage to the gates.

### 2.5 The bootstrap paradox

SFEP-0016 §6 calls this "the hard case" and leaves it open: a fully sealed
compiler cannot spawn a shell, but the build driver does
(`compiler/src/build/fs.sfn`, `compiler/src/cli_selfhost.sfn`, via
`runtime/sfn/io.sfn::sailfin_runtime_shell_capture`). Worse, SFEP-0016 §3.5's
digest-based admission rule computes sha256 **by spawning a shell**, so the
mechanism that admits link inputs depends on the authority it is meant to
constrain. SFEP-0048 Phase E retires the `sha256sum`/`shasum` shell-out and is
therefore a hard prerequisite of the admission rule, independent of OpenSSL
removal.

No proposal resolves the paradox. §3.5 does.

## 3. Design

### 3.1 The trajectory table — the normative centerpiece

Every independence claim must name the class it concerns and the gate that
unlocked it. Counts are as of 2026-08-06 and are budgets, not estimates.

| Class | Population | Gate that removes it | Owner | Honest claim once done |
|---|---|---|---|---|
| **R — intra-runtime** | runtime symbols re-declared `extern` across runtime modules (SFN-635) | none; module-system facades | **this SFEP** §3.7 step 0 | "the runtime's internal ABI is checked, not hand-copied" |
| **A — kernel entries** | ~30 | the `syscall1`…`syscall6` allowlist | **SFEP-0060** | "Sailfin-authored code cannot make an un-gated syscall" (= provenance-sealed) |
| **C1 — allocator** | `malloc`/`free`/`realloc`/`calloc` | owned allocator over `mmap` | **this SFEP** §3.2 | contributes to `-nostdlib`; no standalone claim |
| **C2 — unwind** | `setjmp`/`longjmp`, `abort` | compiler-owned unwind primitive | **this SFEP** §3.3 | contributes to `-nostdlib` |
| **C3 — process env** | `getenv`, `environ` | owned `_start` | **this SFEP** §3.4 | contributes to `-nostdlib` |
| **C4 — threads** | `pthread_*` | owned thread creation over `clone`+futex+TLS | **this SFEP** §3.5 | contributes to `-nostdlib` |
| **C5 — TLS/crypto** | 24 `SSL_*` | native TLS stack | **SFEP-0048** D | removes the largest TCB member |
| **C6 — remaining libc algorithms** | stdio, `getaddrinfo`, `popen`, `posix_spawnp`, dirent walk, `realpath`, `mkdtemp` | per-item, over Class A | **SFEP-0060** §2.1 table | closes SFEP-0016 §4.2 holes 1 and 2 |
| **B — pure computation** | ~14 (`memcpy`, `strlen`, `strtod`, …) | `-nostdlib` + `"no-builtins"` emission | **this SFEP** §3.6 | "no libc in the link" |

**The claim ladder this feeds.** `-nostdlib` requires C1–C5 *and* B. Only then
does SFEP-0016 §3.1's *fully sealed* tier become reachable, and only alongside
its other conditions (no foreign executable input, dynamic loading disabled).
Until every row above is done, the honest claim is the provenance-sealed one,
and per SFEP-0060 §3.7 the stronger phrasing is not to be used.

### 3.2 C1 — the allocator over `mmap`

`runtime/sfn/memory/arena.sfn` (944 lines) already owns a bump allocator with a
linked list of pages; it acquires those pages from `malloc`. The conversion is
therefore page acquisition only, not an allocator design: `mmap`/`munmap` via
the Class A wrappers, with the existing arena semantics unchanged.

Two constraints carry over and must not be broken. SFEP-0043 §6: an arena
`string[]` spine cannot be relocated across a rewind — only flat `{data,len}`
strings. SFN-558: the arena is `thread_local`, which means page acquisition is
per-thread and interacts with C4; sequence C1 before C4 so the thread work
inherits an owned allocator rather than the reverse.

`realloc` has no `mmap` equivalent with the same semantics; the arena's existing
`sfn_arena_realloc` grow path becomes the only implementation, which is a
simplification rather than new surface.

### 3.3 C2 — the unwind primitive (a compiler capability, and a seed crossing)

This is the only gate that requires a **compiler** change, and SFEP-0060's Class
C table says so: "Needs a compiler-owned unwind primitive; gate: an unwind
design that replaces `runtime/sfn/exception.sfn`'s jmp_buf."

`runtime/sfn/exception.sfn` (494 lines) implements explicit exception frames
over `setjmp`/`longjmp` per SFEP-0025 §3.5 — a deliberate choice over LLVM
landing pads, and one this proposal keeps. What changes is the primitive
underneath: `setjmp`/`longjmp` save and restore callee-saved registers and the
stack pointer, and no syscall can do that. The compiler must emit the
save/restore directly.

The precedent is exact and twice-established: `load_byte`
(`compiler/src/llvm/byte_load.sfn`), the six atomics
(`compiler/src/llvm/atomics.sfn`), and `syscall1`…`syscall6`
(`compiler/src/llvm/syscall.sfn`) are reserved names dispatched at
`compiler/src/llvm/expression_lowering/native/core_call_resolution/builtin_dispatch.sfn`
before call resolution. The unwind primitive joins them.

**This is a seed crossing.** Per `.claude/rules/seed-dependency.md`, runtime
source is compiled by the *pinned seed*, so a compiler capability that runtime
source calls must exist in the seed — bundling does not help, because the old
seed is the one compiling `exception.sfn`. The rule says cross the gate **once**
with the complete capability family; SFEP-0060 §3.6 is the precedent, crossing
once for all six `syscall` arities. Land the full unwind family — save, restore,
and whatever frame accessor the design needs — in one `seed-blocker` PR. Per the
SFEP-0026 2026-07-18 amendment, `cadence-seed-pin.yml` auto-pins on every green
release, so the crossing costs days rather than a cadence cycle.

The primitive's design is deferred to its own design note; this SFEP fixes only
that it is compiler-owned, that it lands as one family, and that it does not
change `exception.sfn`'s frame *semantics*.

### 3.4 C3 — the owned `_start`

`getenv` and `environ` are not syscalls. The dynamic loader populates them from
the initial process stack, which is why SFEP-0060 classifies them as needing
`-nostdlib` rather than a wrapper. Owning them means owning the entry point: a
`_start` that reads `argc`, `argv`, and `envp` off the initial stack per the
SysV ABI, establishes the stack frame, and calls the Sailfin `@main` that
`runtime/prelude.sfn`'s link already produces.

This is where `-nostdlib` stops being a link flag and becomes a runtime
responsibility: without CRT objects there is no `Scrt1.o` to provide `_start`,
and `compiler/src/build/direct_link.sfn` currently resolves
`Scrt1.o`/`crti.o`/`crtn.o` explicitly and falls back to clang when any is
missing. That resolution logic is what an owned `_start` replaces, not
supplements.

`sysconf` needs no gate and appears in no class above: SFEP-0060 §2.1 records it
as already sentinel-ized, and the tree confirms a descriptor for
`sailfin_intrinsic_sc_nprocessors_onln`
(`compiler/src/llvm/runtime_helpers/registry_platform.sfn:211`) resolved at emit
time. It is noted here only because it is auxv-derived and an owned `_start`
already has the auxv pointer, so a future non-sentinel implementation has a home
rather than needing a new one.

### 3.5 C4 — owned thread creation, and the bootstrap paradox

`clone` + futex + per-thread stacks + TLS replaces `pthread_create`/`_join` and
the mutex/cond surface used by `runtime/sfn/concurrency/scheduler.sfn`,
`channel.sfn`, and `nursery.sfn`. `runtime/sfn/platform/pthread_layout.sfn`
already encodes opaque mutex and cond byte layouts, which exists precisely
because the runtime does not own these objects; owning them deletes that file
rather than porting it.

SFEP-0016 §3.3 places the per-task capability context in the scheduler — scoped,
inherited, attenuated, revocable. C4 is therefore the gate on that half of the
seal as well as on `-nostdlib`, and the two designs must be co-developed: a
capability context whose lifetime ends deterministically at scope exit interacts
with SFEP-0064's reclamation seam.

**The bootstrap paradox (SFEP-0016 §6, unresolved until now).** A sealed
compiler cannot spawn `/bin/sh`, and the build driver does. The resolution is to
separate the two roles rather than to seal the driver:

1. **The driver is not a sealed artifact and never claims to be.** It is the
   toolchain, it holds `![io]`/`![clock]`/`![net]` per SFEP-0020 §4, and the
   seal is a property of the binaries it *produces*. Any claim that the compiler
   itself is sealed requires the compiler to stop shelling out, which is a
   separate and later objective.
2. **The admission rule must not depend on the authority it constrains.** The
   sha256 that SFEP-0016 §3.5 uses is computed by shelling out today. SFEP-0048
   Phase E retires that in favour of the native digest in `capsules/sfn/crypto`.
   Until Phase E lands, the admission rule's own integrity rests on a shell
   invocation, so **SFEP-0048 Phase E is a hard prerequisite of SFEP-0016
   §3.5**, independent of OpenSSL removal. That dependency is currently
   unrecorded in either proposal.
3. **`sailfin_runtime_shell_capture` is not on the `-nostdlib` critical path.**
   It is Class C6 (`popen`), owned by SFEP-0060, and its conversion to
   `fork`/`execve` over Class A removes the ambient-shell hole without requiring
   the driver to stop using subprocesses.

### 3.6 B — pure computation, and the `"no-builtins"` obligation

Class B carries no authority; SFEP-0060 is right that converting it advances "no
libc in the link" and not "the seal holds." It is nevertheless in scope, because
the goal is to own the path and because `-nostdlib` does not link a library that
still has undefined references to `strlen`.

The obligation this proposal adds is the mitigation SFEP-0060 identified and
left unbuilt: **the compiler must emit `"no-builtins"` on the definition of any
runtime function whose name collides with an LLVM-recognized libc idiom.**
Without it, LLVM rewrites the body of `memcpy` into a call to `memcpy` and the
program recurses to a stack overflow at the first array copy. `"no-builtins"`
appears nowhere in `compiler/src/` or `runtime/` today.

Two safer alternatives are rejected in §6: renaming the functions (fails,
because the recognizer synthesizes calls by *signature-shape* pattern, not only
by an existing call), and `-fno-builtin` on the link line (fails, because the
runtime is compiled per-module by a child compiler and the flag is not a
link-time property).

### 3.7 Sequence

Step 0 is independent of every gate and should not queue behind them.

0. **Class R.** Replace SFN-635 extern self-reference with checked cross-module
   imports or capsule facades. Ungated, immediately available, and it removes
   the largest unguarded ABI-drift surface in the tree. If the module system
   cannot resolve cross-module Sailfin bodies today, that limitation is itself
   the deliverable and must be fixed first — establish which before scoping.
1. **Manifest truth** (§3.8). Make `runtime/capsule.toml` enumerate what is
   linked and declare a capability set that is not a check-skipping empty.
   Prerequisite for the ratchet and for SFEP-0016 §3.5's provenance root.
2. **C1 allocator**, before C4 so the thread work inherits it.
3. **C2 unwind.** One `seed-blocker` PR, complete family, one crossing.
4. **C3 `_start`.** Replaces the CRT-object resolution in `direct_link.sfn`.
5. **C4 threads.** Co-designed with SFEP-0016 §3.3's per-task context.
6. **B + `"no-builtins"`.**
7. **The `-nostdlib` link.** Only now, and only with SFEP-0048 D and SFEP-0060's
   C6 items complete, does the flag flip. Measure and record the claim tier.

### 3.8 Manifest truth and the ratchet

**Inventory.** `runtime/capsule.toml`'s `sfn-sources` lists 30 files; 51 exist
under `runtime/sfn/`. The remainder arrive via
`target_condition_runtime_sfn_sources` (`compiler/src/build/target.sfn:198-235`,
7 swaps and 6 appends on Windows — owned by SFEP-0021 §4.2(A), cited not
re-proposed) and by import closure. A manifest that does not enumerate what gets
linked cannot be the provenance root SFEP-0016 §3.5's `vetted-link-inputs`
requires. The declared set must equal the linked set, per target.

**Capabilities.** `runtime/capsule.toml:6-10` declares `required = []` with a
comment that effects "don't gate clang/llvm-as invocations." Per SFEP-0002 §4 an
empty `[capabilities]` **skips** the `E0403` cross-check; it is not deny-all.
The runtime carries 195 effect-annotated functions. Two Accepted proposals
collide with this: SFEP-0059 §3.4 makes grant mismatch **fail-closed** (a
function whose effects require an ungranted authority must reject the module),
and SFEP-0051 Phase 4b computes inferred surfaces precisely to catch
under-reporting, with `runtime` a first-class workspace member. **This must be
resolved before either ships**, and the resolution belongs here because the
runtime is the capsule every program links. The proposed answer: the runtime
declares the union of its adapters' authorities explicitly, and the empty set is
reserved for capsules where it is true.

**The ratchet.** Each class in §3.1 carries a recorded count. A test asserts the
per-class count never rises. This is the mechanism that makes the trajectory a
program rather than an aspiration, and it is why the classes are normative
rather than descriptive. `docs/conventions/runtime-helpers.md` currently
*entrenches* externs — "extend Sailfin's extern/lowering support or add a
sentinel" — and must be amended to route new platform access through the owned
layer instead.

### 3.9 Platform scope

Tier-1 Linux x86-64 only, matching SFEP-0060 §3.1 and `docs/status.md:939`.
macOS arm64 and Windows x86-64 keep the mediated vendor-library leg: neither
exposes a stable raw-syscall ABI, and per SFEP-0060 §3.3 the gate hook lives in
**both** legs so capability mediation is uniform even where the kernel entry is
not owned. `docs/strategy/decision-brief.md` §8 governs the honest phrasing:
adding a base platform does not multiply seal work, and a sealed macOS is not
promised. `-nostdlib` is not proposed for non-tier-1 targets.

## 4. Effect & capability impact

The proposal changes no Sailfin effect semantics, and that is the problem it is
partly addressing. Per SFEP-0025 §3.8 rule 4 and `E0804`, `extern fn`
declarations carry **no** effects and may not declare them; enforcement happens
at the adapter above them, by convention rather than by construction. That is
the hole `docs/strategy/decision-brief.md` §7 item 6 names as "the one design
gate blocking all three pillars simultaneously," and SFEP-0016 §4.4 Q3 leaves
unresolved.

This proposal does not resolve it — it makes it smaller by construction. Every
class in §3.1 that reaches zero is a set of extern declarations that no longer
exists to be wrapped voluntarily. At the end state the only remaining
platform-reaching code is the Class A wrapper module, which SFEP-0060 §3.2
already restricts by allowlist and annotates with real effects. **The extern
effect question is therefore an interim-state question**, and the interim is
bounded by this program.

What remains open, and is flagged for the owner's design gate in §9: whether
`extern` should be capability-typed, forbidden outside blessed modules, or
something else *during* the interim, and what the rule is for user code, which
this proposal does not touch.

## 5. Self-hosting impact

Every slice touches `runtime/` source and therefore runs against the pinned
seed.

- **C2 is `seed-blocker`** and is the only slice that is. It lands alone with
  the
  complete unwind family; consumers carry `## Required in pinned seed:
  #<predecessor>`. Per `.claude/rules/seed-dependency.md` this is the structural
  carve-out, not a judgement call.
- **C1, C3, C4, B, and step 0** call no new compiler capability and bundle
  normally with their consumers.
- Step 0 and any capsule split are **structural**: `make clean-build` before
  rebuilding, per `.claude/rules/selfhost-invariant.md`.
- The `-nostdlib` flip changes the link line for every produced binary including
  the compiler. It requires `make check` and a determinism comparison; a
  compiler that cannot rebuild itself under the new link is a failed slice, not
  a new baseline.
- Compiler passes changed: only `compiler/src/llvm/` (the unwind primitive's
  lowering, `"no-builtins"` emission) and `compiler/src/build/` (CRT resolution
  in `direct_link.sfn`, link-line construction). No lexer, parser, AST,
  typecheck, or effect-checker change, except the reserved-name registration for
  the unwind family alongside the existing `load_byte`/atomics/`syscall`
  entries.

## 6. Alternatives considered

### Decompose the runtime into capability-layered capsules instead

Rejected as the framing, though it may follow. The runtime is 52 files and
22,634 lines against the compiler's 351 and 145,292, and its folder layout
already tracks responsibility — so a SFEP-0020-style role decomposition would be
answering a question the runtime does not pose. It also collides immediately
with the `link-libs` monopoly (§9): only a `kind = "runtime"` capsule's
`link-libs` reaches the link, which is why SFEP-0036 §6 rejected an `sfn/tls`
library capsule. An owned allocator and owned threads change what a "core" layer
even means, so decomposition after these gates is a better-informed decision
than decomposition before them. Note the possibly-elegant consequence: at the
`-nostdlib` end state there are no `link-libs` at all, and the monopoly problem
dissolves rather than needing a redesign.

### Keep libc and capability-type `extern` instead

Rejected as a *substitute*, retained as an interim question (§4).
Capability-typed externs make voluntary wrapping mandatory, which is a real
improvement, but they cannot make libc's internals visible: `getaddrinfo` opens
its own UDP socket whatever its Sailfin declaration says (SFEP-0016 §4.2 hole
1). Typing the declaration constrains the caller, not the callee.

### Rename Class B functions to avoid the idiom recognizer

Rejected. LLVM's recognizer synthesizes calls from loop *shape*, not only from
an existing call by name, so a renamed `sfn_memcpy` containing a byte-copy loop
can still be rewritten into a `memcpy` call — which then resolves to libc,
silently reintroducing the dependency the rename was meant to remove.
`"no-builtins"` on the definition is the mitigation SFEP-0060 identified and it
is the correct one.

### `-fno-builtin` on the link line

Rejected. The runtime is compiled per-module by a child compiler
(`_compile_runtime_sfn_sources`), and builtin recognition happens during that
per-module compile, not at link. A link-line flag arrives too late.

### Own the backend first, then platform access

Rejected on the evidence. `docs/backend-independence.md` §2 states Axis 3 is
blocked on writing a runtime body, not on owning a backend, and §2.3 above shows
the one apparent counter-example (Class B) is mitigated by a function attribute.
Sequencing platform access behind a code generator would delay a quarters-scale
program behind a years-scale one for no correctness benefit.

### Do nothing; accept libc as the boundary

Rejected, and worth stating plainly because it was the standing position.
SFEP-0025's `extern fn` contract was correct for eliminating C and is explicitly
retired as guidance by `docs/backend-independence.md` §1. Accepting the boundary
means SFEP-0016's *fully sealed* tier is permanently unreachable and the
capability pillar tops out at provenance-sealed.

## 7. Stage1 readiness mapping

Interpreted as preservation plus one new primitive. The proposal changes
platform access, not language surface.

- [ ] Existing programs parse identically (no syntax change; the unwind family
  registers as reserved names alongside `load_byte`/atomics/`syscall`).
- [ ] Type/effect checks unchanged, except the unwind primitive's arity and
  target diagnostics (modelled on `E1019`).
- [ ] `.sfn-asm` unchanged for all existing constructs.
- [ ] The unwind primitive lowers to valid LLVM IR with an IR-shape regression
  test; `"no-builtins"` appears on every colliding runtime definition.
- [ ] Per-gate regression coverage per §8.
- [ ] The compiler self-hosts after each slice, and under `-nostdlib` at the
  end.
- [ ] All touched `.sfn` files pass `sfn fmt --check`.
- [ ] `docs/status.md` support tiers and `docs/backend-independence.md` role
  table reflect each completed class. No language-spec change.

Remains **Draft** until the design gates in §9 are decided; remains **Accepted**
until every class in §3.1 reaches its gate. Partial conversion is not
`Implemented`, and per §3.1 no partial state licenses the stronger seal claim.

## 8. Test plan

**Differential oracle per gate.** The existing suite is free differential
coverage — SFEP-0060 §3.5 makes `io.sfn`'s `write`/`read` the beachhead for
exactly this reason. Each gate converts behind an unchanged public signature, so
the pre-conversion suite is the oracle. A gate whose conversion changes
observable behaviour has a bug, not a new baseline.

- **C1:** arena page-acquisition tests over `mmap`; the SFEP-0043 §6 no-relocate
  invariant; thread-local acquisition under the SFN-558 arena.
- **C2:** IR-shape test for the unwind primitive's emitted save/restore; the
  existing `exception.sfn` frame suite unchanged; a nested-frame and
  early-exit-pop case (see `design-notes/sfn-400-try-frame-early-exit-pop.md`).
- **C3:** `argc`/`argv`/`envp` round-trip from an owned `_start`; auxv-derived
  `sysconf` parity against the sentinel.
- **C4:** the full scheduler/channel/nursery suite unchanged; a `clone`-vs-
  `pthread_create` differential under `--jobs N`.
- **B:** a `"no-builtins"` presence assertion on every colliding definition,
  plus
  a self-recursion guard test that fails loudly if the attribute is dropped.
- **Ratchet:** a per-class extern-count test that fails on any increase.
- **Manifest completeness:** declared `sfn-sources` set equals the linked set,
  per target — the test that closes §3.8's inventory gap.
- **`-nostdlib`:** a link-and-run e2e per `.claude/rules/no-bash-e2e.md` (a
  `*_test.sfn` driving the subprocess via `process.run_capture`, never a `.sh`),
  plus `make check` and a determinism comparison.

## 9. Design gates and required amendments

### Owner decisions required before this leaves `Draft`

1. **The `extern` interim rule.** `docs/strategy/decision-brief.md` §7 item 6
   calls `extern` "the one design gate blocking all three pillars
   simultaneously"; SFEP-0016 §4.4 Q3 and SFEP-0008 §7.9 both leave it open. §4
   argues this program makes it an interim-state question, but the interim is
   multi-quarter and user code is untouched. Capability-typed, blessed-module-
   restricted, or unchanged?
2. **Scope of step 0 (Class R).** Whether the SFN-635 conversion belongs in this
   SFEP or as a standalone predecessor, which turns on whether the module system
   can resolve cross-module Sailfin bodies today.
3. **The runtime's capability declaration** (§3.8) — the resolution of the
   three-way conflict, since it changes an Accepted proposal's assumption.

### Amendments this proposal requires elsewhere

| Target | Reason |
|---|---|
| SFEP-0025 §3.1.2 | Its "platform via `extern fn`, no C authored" contract is already called "no longer adequate as standing guidance" by `docs/backend-independence.md` §1. The SFEP should record its own supersession as guidance while remaining the architecture record. |
| SFEP-0036 §6 | Its rejection of a library capsule for `link-libs` reasons is era-correct but becomes moot at the `-nostdlib` end state. Record the expiry condition. |
| SFEP-0026 | The runtime seed carve-out lives only in `.claude/rules/seed-dependency.md`, which cites SFEP-0026 WS-B as its design record but goes materially beyond it. The canonical technical statement is SFEP-0060 §3.6. The rule needs SFEP-level authority. |
| SFEP-0016 §3.5 | Record the unstated hard prerequisite on SFEP-0048 Phase E: the digest that admits link inputs is computed by shelling out (§3.5 above). |
| `docs/conventions/runtime-helpers.md` | Currently entrenches externs as the platform-access convention; must route new access through the owned layer. |
| `docs/backend-independence.md` §2 | Add the four gates to the role table with this SFEP as owner, so the "Platform access" row has a destination. |

## 10. References

- SFEP-0016 — The Capability-Sealed Runtime (§3.1 claim ladder, §3.3 per-task
  context, §3.5 admission rule, §4.2 the four holes, §6 the bootstrap paradox)
- SFEP-0025 — Native Runtime Architecture (the contract this program retires as
  guidance; §3.5 explicit unwind frames, §3.8 rule 4, §3.9.4 the builtin
  precedent)
- SFEP-0035 — Prelude-Mirror Signature Derivation (the ABI-drift hazard Class R
  replicates)
- SFEP-0043 — Phase-Scoped Arena Reclamation (§6 the no-relocate invariant)
- SFEP-0048 — Native crypto + TLS (Phase D owns C5; Phase E is a prerequisite of
  SFEP-0016 §3.5)
- SFEP-0051 — Workspace Manifest (Phase 4b inferred capability surfaces)
- SFEP-0059 — Typed SSA Activation (§3.4 fail-closed grant mismatch)
- SFEP-0060 — The Owned Syscall Layer (§2.1 the classification, §3.2 the
  allowlist, §3.7 the five gates this proposal adopts four of)
- SFEP-0064 — Generic resource-reclamation seam (interacts with C4's capability
  context lifetime)
- SFEP-0066 — Codegen Provider Ownership (§3.5 the orthogonality correction)
- `docs/backend-independence.md` — the three axes; the 528/46 figure; "Axis 3 is
  blocked on writing a runtime body, not on owning a backend"
- `docs/strategy/decision-brief.md` — §7 item 6 the `extern` gate; §8 base vs
  sealed support
- `.claude/rules/seed-dependency.md` — the runtime carve-out governing C2
