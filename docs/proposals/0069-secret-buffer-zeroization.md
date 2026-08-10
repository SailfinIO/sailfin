---
sfep: 69
title: Non-Elidable Zeroization for Uniquely Owned Secret Buffers
status: Accepted
type: runtime
created: 2026-08-08
updated: 2026-08-08
author: "agent:compiler-architect; human review"
tracking: SFN-703, SFN-782, SFN-783, SFN-784, SFN-785, SFN-786, SFN-787, SFN-788, SFN-789, SFN-790, SFN-791
supersedes:
superseded-by:
graduates-to: reference/preview/ownership-enforcement.md
---

# SFEP-0069 — Non-Elidable Zeroization for Uniquely Owned Secret Buffers

## 1. Summary

Add a concrete, move-only `SecretBuf` byte-buffer type whose backing allocation
is wiped before it is released, reused, or abandoned by a supported Sailfin
control-flow exit. `SecretBuf` extends SFEP-0018's existing `OwnedBuf` ownership
lattice: assignment, parameter passing, returns, and explicit
zeroization consume the owner; no second live alias is permitted. The compiler
lowers the wipe to a target-neutral LLVM loop containing `store volatile i8 0`
for every byte of the allocation, and optimized-IR tests make retention of that
operation a shipping gate. A per-thread cleanup registry, tied to stable
exception-frame epoch markers, makes the same cleanup run on normal scope exit,
early return, `?` propagation, caught or uncaught `throw`, and rethrow.

The promise is deliberately narrow: Sailfin erases the uniquely owned backing
allocation. It does not promise to erase registers, optimizer-created scalar
temporaries or spills, copies intentionally released through `unsafe`/FFI, or
ordinary `int[]` values. It also does not claim protection against an attacker
who can read live process memory.

## 2. Motivation

SFN-699's Ed25519 signer materializes a seed expansion, clamped scalar, prefix,
deterministic nonce, challenge, and intermediate scalar products as ordinary
`int[]` values (`capsules/sfn/crypto/src/ed25519_sign.sfn`). The TLS 1.3 key
schedule likewise stores its early, handshake, master, and traffic secrets in
ordinary arrays and in the long-lived handshake state
(`capsules/sfn/crypto/src/tls13_schedule.sfn` and `tls13_handshake.sfn`). Those
arrays may alias, carry no deterministic destructor, and are overwritten only
if application code remembers to do so. Even an ordinary final `memset` is not a
contract: a dead-store pass may delete it after proving the bytes are never read
again.

The prerequisite ownership substrate now exists. `OwnedBuf`, `Affine<T>`, and
`Linear<T>` are move-tracked by `compiler/capsules/analyzer/src/ownership_checker.sfn`; the
memory/string core uses the consume-and-return `OwnedBuf` API; and concurrency
captures move owned values. What does not exist is the stronger secrecy
contract:

- `OwnedBuf` may be arena-backed and has no wipe-on-drop rule.
- libc-backed growth copies to a new allocation without freeing or wiping the
  old one; arena growth and reset likewise leave old bytes resident.
- deterministic drop emission is still RC-only (`docs/status.md`,
  "Deterministic drop emission").
- `lower_throw_instruction` currently calls `sfn_throw` without emitting scope
  drops, and `setjmp`/`longjmp` can bypass several native frames.
- plain structs still have the aliasing ambiguity tracked by SFN-692. A secret
  owner must be a compiler-recognized owned family member, not an ordinary
  struct that merely happens to contain a pointer.

The status quo cannot support an honest secure-erasure claim. This proposal
defines the smallest contract that can.

## 3. Design

### 3.1 Threat model and guarantee boundary

For a live `SecretBuf` allocation, safe Sailfin guarantees:

1. **One source-level owner.** Rebinding, passing, or returning moves
   the descriptor; the old binding is dead. Safe code cannot obtain a mutable or
   escaping alias to the backing allocation.
2. **Non-elidable backing-store wipe.** Before the allocation is freed or made
   available for reuse, every byte in `[ptr, ptr + cap)` is written with zero by
   a volatile LLVM store. Wiping `cap`, not only `len`, covers truncated bytes
   and bytes left in spare capacity by prior growth.
3. **Deterministic supported exits.** Cleanup runs on lexical fallthrough,
   explicit return, an error branch produced by `?`, `throw` into `catch`,
   rethrow, and an uncaught Sailfin throw before process termination.
4. **No implicit declassification.** Formatting, interpolation, logging,
   conversion to `string`, conversion to `int[]`, and conversion to `OwnedBuf`
   are rejected unless code calls the explicitly named copying declassifier.

The guarantee covers heap memory owned by the buffer after the last supported
use. It does **not** guarantee erasure of:

- values still needed by a live computation;
- CPU registers, vector registers, optimizer-created scalar values, stack
  spills, or calling-convention save areas;
- bytes copied into an ordinary value by `declassify_copy`, or reconstructed
  manually from explicitly declassified scalar reads;
- copies retained by code reached through an `unsafe` block or FFI;
- ordinary arrays, strings, structs, `OwnedBuf`, or raw pointers merely because
  they contain key material;
- process swap, hibernation images, core dumps, debugger snapshots, DMA, or
  hardware/HSM/secure-enclave storage.

Active process compromise, an OS kill, power loss, memory corruption, and
immediate `abort`/fatal-signal paths are out of scope. A normal uncaught Sailfin
`throw` is in scope because it remains a language-controlled exit. This is a
best-possible backing-storage guarantee, not a claim that all historical
representations of a mathematical secret can be found and erased.

### 3.2 Source type and API

`SecretBuf` is a concrete byte owner rather than `Zeroizing<OwnedBuf>`.

The declaration below is the compiler-sealed trusted runtime layout, not a
struct literal surface available to safe source:

```sfn
struct SecretBuf {
    ptr_addr: i64;
    len: i64;
    cap: i64;
    cleanup_token: i64;
}

fn secret_buf_new(capacity: i64) -> SecretBuf;
fn secret_buf_len(self: SecretBuf) -> i64;
fn secret_buf_declassify_byte(self: SecretBuf, index: i64) -> i64;
fn secret_buf_set(self: SecretBuf, index: i64, value: i64) -> SecretBuf;
fn secret_buf_append(self: SecretBuf, value: i64) -> SecretBuf;
fn secret_buf_zeroize(self: SecretBuf) -> void;
fn secret_buf_declassify_copy(self: SecretBuf) -> OwnedBuf;
```

The exact method/free-function spelling follows the existing `OwnedBuf` family;
the semantic rules do not depend on that spelling. Mutating operations use the
same consume-and-return shape as `owned_buf_append`, so a possible relocation
never creates two owners. `secret_buf_len` and `secret_buf_declassify_byte` are
the only v1 non-consuming queries: the compiler treats each as a non-escaping
read borrow for the duration of the call, and their scalar-only implementations
cannot retain the pointer. An ordinary user-defined function parameter still
consumes the owner. Each `secret_buf_declassify_byte` call is an explicit
one-byte declassification. The resulting scalar, its register/spill, and any
ordinary array, string, or log reconstructed from such scalars are outside the
erasure guarantee in §3.1. `E0908` prevents accidental whole-value conversion;
it cannot prevent a caller from deliberately assembling explicit scalar
declassifications. The API does not expose `Slice` because Phase U view
lifetimes do not yet ship.

`secret_buf_declassify_copy` is intentionally long and explicit. It allocates a
fresh ordinary `OwnedBuf`, copies `len` bytes, then zeroizes and consumes the
source. The resulting ordinary buffer is outside this SFEP's guarantee. There
is no zero-copy downgrade, since transferring the same allocation to a
non-zeroizing type would make the guarantee depend on the caller's later
discipline.

`SecretBuf` is a sealed nominal compiler/runtime type, not an ordinary source
struct even though the trusted runtime implementation has the four-field layout
shown above. The compiler identifies it by the canonical runtime declaration,
not by the spelling `SecretBuf`. Outside that trusted implementation, safe
source cannot construct a literal, project or update a representation field,
destructure it, reflect or serialize its representation, or cast another value
to it. Those operations raise `E0916` (sealed secret representation). Unsafe
platform adapters may inspect the representation only inside the trusted
runtime implementation; an arbitrary user declaration with the same name gets
ordinary struct semantics.

The sealed type is compiler-recognized as owned, like `OwnedBuf`, regardless of
the eventual decision for ordinary struct assignment in SFN-692. Its descriptor
may be copied mechanically by the ABI, but safe source semantics treat that
transport as a move and permit only one live binding. The backing bytes are
never copied by a move.

The implementation lands dormant: the canonical declaration remains
module-private and is not importable by safe source while the runtime, checker,
normal-drop, or exception-drop slices are incomplete. SFN-790 is the atomic
activation slice. Its single merge both exports the sealed type and lands the
full conformance gate after all enforcement predecessors pass; no earlier issue
may expose `SecretBuf` as a usable public type.

The existing intrinsic spelling `Secret<T>` is not used for this contract. It
currently defaults to the copyable ownership class in `type_interner.sfn` and
does not define storage or cleanup. Retrofitting arbitrary `T` would expand this
design beyond the concrete byte-buffer consumer.

### 3.3 Ownership, aliases, slices, FFI, and concurrency

The ownership checker extends its existing `Owned` / `Moved` / `Freed` lattice:

- assignment, ordinary argument passing, and return consume a `SecretBuf`;
- `secret_buf_zeroize` transitions the binding to `Freed`; later use is the
  existing `E0903`, worded as use-after-zeroize for this type;
- a second binding or use after a move uses existing `E0904` / `E0901`;
- interpolation, formatting, `print`, `toString`, and implicit conversion to a
  text or ordinary buffer type raise new `E0908` (secret declassification
  requires `secret_buf_declassify_copy`);
- capture by `spawn`/`parallel`, storage in a shared container, and cross-thread
  channel transfer raise new `E0909` in v1. The cleanup registry is thread-local;
  cross-thread movement remains prohibited until a follow-up defines atomic
  cleanup-record migration. A task may create and consume secrets entirely on
  its own worker thread;
- constructing or inspecting the sealed representation raises `E0916` as
  specified in §3.2;
- arrays, maps, sets, channels, and other variable-length containers whose
  element type is secret-bearing raise `E0917` in v1. Fixed-layout structs and
  enums use the transitive rules in §3.4.

There is no safe `SecretSlice` in v1. A future lexical view must use the planned
`Borrowed` state and may neither outlive nor move independently of the owner.
Ordinary `Slice` cannot point into secret storage.

FFI exposure is an `unsafe` boundary. An implementation may provide an internal
`secret_buf_unsafe_ptr` for platform adapters, but it is callable only inside
`unsafe { }`, and safe code cannot return or store the raw pointer. Once an
unsafe callee receives the pointer, Sailfin cannot prove that it did not retain
or copy bytes; the guarantee excludes such copies. Passing a `SecretBuf`
descriptor itself to an `extern fn` is rejected.

`SecretBuf` introduces no implicit `Clone`, equality rendering, hashing,
serialization, inspection, or debugger-friendly formatter. Constant-time
cryptographic behavior is a separate contract: zeroizing storage does not make
an algorithm constant-time.

### 3.4 Secret-bearing aggregate semantics

A fixed-layout struct or enum is **secret-bearing** when any live field or
payload recursively contains `SecretBuf`. This classification is structural
and transitive, while the leaf identity remains the sealed nominal type from
§3.2. Secret-bearing aggregates are affine owners:

- constructing one consumes every secret-bearing input field; assignment,
  argument passing, return, and whole-value pattern binding move the aggregate;
- a whole-aggregate move rehomes every live contained cleanup record to the
  destination epoch, without copying backing bytes;
- a secret-bearing field is a place. Moving it out marks that field partially
  moved; the parent cannot be read, moved whole, returned, formatted, or
  serialized until the field is replaced;
- assignment over a live secret-bearing binding or field raises `E0918` (live
  secret owner must be retired before replacement). A field may be restored
  only after its old value was moved out or explicitly zeroized; assigning the
  already-evaluated replacement then consumes it and clears the partial-move
  flag;
- drop state carries a per-field/per-payload live flag. Dropping an aggregate
  recursively drains only live records, once each, in reverse declaration
  order; moved-out fields are skipped;
- `E0908` formatting/declassification, `E0909` concurrency, and `E0918` live
  overwrite restrictions apply to the whole aggregate.

Non-secret fields may be projected normally when doing so does not expose a
sealed representation or consume a partially moved parent. Trusted scalar
queries borrow a secret field only for the call. Variable-length secret-bearing
containers are rejected by `E0917`; supporting their dynamic element drop maps
is explicitly deferred. These rules permit TLS/crypto state structs while
avoiding an implicit copy or alias of the descriptor under SFN-692.

### 3.5 Allocation and cleanup records

V1 `SecretBuf` backing storage is **libc-backed only** (`malloc`/`free`, or the
equivalent owned platform allocator). It is not routed through the global arena
and its descriptor deliberately omits `arena_addr`. Each successful allocation
also creates a non-secret cleanup record in a per-thread intrusive stack:

```text
cleanup node = { previous, kind, ptr, cap, state }
```

An owner node has `kind = owner`; the `cleanup_token` points to it. Every
exception frame embeds a distinct non-owner `epoch_marker` node in its own
stable frame storage and links that node at `try` entry. No separate marker
allocation can fail. The marker remains linked until that frame exits, so moving
or zeroizing the owner that happened to be the pre-try stack head cannot
invalidate the exception boundary.

Every ownership move across cleanup epochs rehomes each live owner node to the
destination binding's active marker region, whether the destination is newer or
older. A same-region move keeps the node in place; a move into a `try`/callee
region places it above the relevant marker; a return or move into a pre-existing
outer binding reinserts it below every marker the destination predates. Thus a
pre-try secret moved into a same-frame try-local or throwing callee is drained,
while a secret created in a `try` and moved into a pre-try outer owner survives
the throw and remains owned by the catch. Rehoming is part of the move
transaction and applies recursively to secret-bearing aggregates.

Normal cleanup performs, in order:

1. mark the record as draining (double-drop guard);
2. wipe all `cap` bytes through the non-elidable primitive;
3. free the libc allocation;
4. unlink and free the cleanup record;
5. zero the descriptor fields where they remain addressable.

Allocation failure returns a canonical empty `SecretBuf` with token zero; its
drop is a no-op. If backing allocation succeeds but cleanup-record allocation
fails, construction wipes and frees the backing block before returning empty.
A growth operation updates the record only after the new allocation and byte
transfer succeed. The old allocation is wiped before it is freed, so relocation
does not leave an historical copy. If `secret_buf_declassify_copy` cannot
allocate its ordinary destination, it returns a canonical empty `OwnedBuf`
after wiping and consuming the source; no partial ordinary copy escapes.

**Arena-backed behavior is different and intentionally prohibited in v1.**
`secret_buf_new` accepts no arena, `SecretBuf` cannot be constructed from an
arena-backed `OwnedBuf`, and an arena allocator cannot return the secret type.
Arena storage cannot be individually reclaimed and the current global arena has
no typed live-owner relation that makes reset safe. A future `SecretArenaBuf`
may register extents with an arena and wipe them before rewind/reset, but that is
not an alias for this type and is not required by this proposal. Ordinary
secret bytes placed in an arena through `unsafe` remain outside the guarantee.

### 3.6 Backend contract: volatile byte stores

The compiler owns a target-neutral `secure_zero(ptr, len)` lowering. It emits a
counted LLVM loop whose body is structurally:

```llvm
%byte = getelementptr i8, ptr %ptr, i64 %index
store volatile i8 0, ptr %byte, align 1
```

LLVM's volatile-memory contract says optimizers must not change the number of
volatile operations or their ordering relative to other volatile operations.
The byte-store loop is preferred over a platform call and over relying on the
less precisely specified access details of volatile `llvm.memset`. It also
avoids an external helper or crypto dependency.

The same IR is normative on Linux, Darwin, and Windows. `explicit_bzero` on BSD
libcs and `SecureZeroMemory`/`RtlSecureZeroMemory` on Windows are valid prior art
but are not the Sailfin ABI: choosing them would add availability, header, and
linkage branches to a guarantee LLVM can express uniformly. They remain
possible target-specific lowering optimizations only if optimized IR/object
tests prove an equivalent non-elidable write and the language-level contract is
unchanged.

The shipping assertion runs the normal optimized pipeline and proves, within
each cleanup body:

- a reachable `store volatile i8 0` remains;
- the store address walks exactly `[ptr, ptr + cap)` under a zero-length guard;
- every `free` of that allocation is control-dependent on completion of the
  wipe loop, with no release/reuse edge before it;
- the Linux, Darwin, and Windows target-emission paths retain the same shape;
- final assembly/object inspection proves the volatile writes precede the
  allocator release call. If any selected pipeline cannot preserve that order,
  its lowering must insert a compiler memory barrier before `free`.

A source-text assertion before optimization is insufficient.

### 3.7 Cleanup on every supported exit

The compiler treats `SecretBuf` cleanup as an ownership destructor, not a
library convention.

- **Lexical fallthrough:** emit cleanup for every live secret leaving the scope,
  in reverse acquisition order.
- **Explicit/early return:** extend `emit_drops_for_scope_chain` so live secret
  records drain before `ret`; a returned `SecretBuf` is rehomed rather than
  wiped. An ignored owning return value is a temporary owner and drains at the
  end of the full expression.
- **`?` propagation:** `emit_native.sfn` desugars `?` to a match plus early
  `Result.Err` return. The same return cleanup therefore runs on the error edge;
  tests pin this rather than adding a second ad-hoc `?` path.
- **`try`/`throw`:** every emitted exception frame owns the stable
  `epoch_marker` pushed at try entry. Before `sfn_throw` performs `longjmp`, it
  drains owner nodes and unlinks abandoned nested-frame markers above the target
  marker, never the target marker itself. This happens before their stack frames
  become invalid. The target marker remains active through catch/finally, so
  secrets created there stay in the same frame region. Normal completion or
  return first drains/rehomes live owners, then unlinks each embedded marker
  before releasing its frame storage, innermost-first. Rethrow drains above the
  current marker, unlinks that marker/frame, and repeats against the next outer
  marker. Nested tries therefore have distinct stable boundaries even if every
  pre-try owner node moves or is freed. A fresh `throw` from `catch` or
  `finally` targets the outer active exception frame; traversal drains owners in
  the current catch/finally region and unlinks its crossed non-target marker
  before the outer `longjmp`.
- **Uncaught Sailfin throw:** drain every owner node in the current thread and
  unlink all embedded marker nodes before the normal uncaught-exception
  termination path releases frame storage.
- **`finally`:** cleanup happens before control reaches the catch/finally edge;
  existing finally lowering still runs exactly once. A new secret created in
  `finally` follows its own lexical/throw rules.

The cleanup operation is idempotent at the record level, so an explicit
`zeroize` followed by an enclosing scope exit cannot wipe or free twice. The
ownership checker still diagnoses source use after the explicit consume.
Overwriting a live owner is `E0918`; explicit zeroize or an ownership move must
retire the old record before replacement. `E0906` keeps its existing meaning:
unsafe/extern ownership escape.

This design does not retrofit arbitrary destructors. The cleanup registry is
initially private to `SecretBuf`; the generic reclamation seam in SFEP-0064 may
later absorb it only if that proposal preserves the stronger non-elision and
exception-marker requirements here.

### 3.8 Migration sequence

Implementation is deliberately staged:

1. Land the compiler-owned volatile wipe primitive and optimized-IR gates as a
   standalone `seed-blocker` capability.
2. Publish that compiler in the normal scheduled seed cadence. Runtime source
   calls the capability, so `.claude/rules/seed-dependency.md` requires it in
   the pinned seed; bundling cannot cross this boundary.
3. Land the dormant internal libc-backed `SecretBuf`/cleanup-record
   implementation and explicit zeroize/declassify operations.
4. Land dormant sealed-construction, ownership, conversion, FFI, and concurrency
   diagnostics.
5. Add transitive classification, partial-move/live-field metadata, and drop
   plans for fixed-layout secret-bearing aggregates.
6. Wire normal return/`?` cleanup, then exception markers and uncaught-throw
   draining.
7. Atomically export the sealed public type together with the independent full
   conformance gate. The dormant implementation is not safe-source accessible
   before this activation slice merges.
8. Migrate Ed25519 seed decoding and the signer temporaries: expanded seed,
   clamped scalar, prefix, nonce input, nonce, challenge input, challenge, and
   scalar-product scratch. The public key, encoded point, and signature remain
   ordinary public outputs.
9. Migrate the TLS 1.3 schedule and handshake state: PSK/private scalar/shared
   secret, early/handshake/master secrets, traffic secrets, Finished keys, and
   AEAD keys/IV material. Retire each predecessor secret as soon as RFC 8446 no
   longer needs it rather than waiting for handshake teardown.
10. Migrate X25519 private scalars and release-signing key parsing after those
   two acceptance-critical consumers.

Each consumer migration must remove the corresponding ordinary-array secret;
copying into `SecretBuf` while retaining the original `int[]` does not satisfy
this SFEP.

### 3.9 Implementation issue fan-out

All leaves trace to and are initially blocked by SFN-703 because implementation
must not begin before this design is accepted. Additional dependencies preserve
the seed and semantic ordering:

| Issue | Deliverable | Depends on | Narrow verification |
|---|---|---|---|
| SFN-782 | compiler volatile secure-zero lowering | SFN-703 | optimized Linux/Darwin/Windows IR + `make check` |
| SFN-783 | dormant internal libc `SecretBuf` and cleanup records | SFN-782 **in the pinned seed** | internal runtime surface and instrumented allocation tests |
| SFN-784 | sealed-type ownership/declassification/FFI/concurrency diagnostics | SFN-783 | unit + integration ownership fixtures |
| SFN-791 | transitive aggregate classification and drop plans | SFN-784 | whole/partial move and drop-plan metadata tests |
| SFN-785 | lexical, return, and `?` recursive cleanup | SFN-783, SFN-784, SFN-791 | scope/return/Result/aggregate exit-path tests |
| SFN-786 | throw, rethrow, finally, and uncaught cleanup | SFN-785 | structural rebuild, exception e2e, `make check` |
| SFN-790 | atomic public activation + full contract conformance gate | SFN-786 | optimized IR/output, every exit path, full `make check` |
| SFN-787 | Ed25519 secret migration | SFN-790 | RFC 8032 sign/verify/tamper vectors |
| SFN-788 | TLS 1.3 HKDF/HMAC schedule migration | SFN-790 | RFC 5869/8448 and schedule vectors |
| SFN-789 | TLS handshake/traffic-secret lifecycle | SFN-788 | handshake, Finished, record-layer tests |

SFN-782 is labelled `seed-blocker`. SFN-783 carries the exact
`## Required in pinned seed` section required by the repository's runtime-source
consumer policy; it queues behind the normal seed cadence rather than triggering
an ad-hoc cut.

## 4. Effect & capability impact

Zeroization is a memory-safety operation and adds no effect atom. Allocation and
drop remain effect-neutral under the same runtime convention as `OwnedBuf`.
File reads, networking, random generation, and logging retain their existing
effects; storing their result in a `SecretBuf` neither grants nor suppresses a
capability.

Capability enforcement benefits indirectly because safe formatting/logging and
serialization cannot consume `SecretBuf`. `unsafe` and FFI remain explicit
authority boundaries, not capability atoms, and must not be described as
preserving the no-copy guarantee.

## 5. Self-hosting impact

The implementation touches `ownership_checker.sfn`, native-IR emission, LLVM
lowering, scope-drop emission, exception-frame lowering, and Sailfin-native
runtime memory/exception modules. It does not require lexer or parser syntax.

The seed boundary is load-bearing. The compiler wipe capability lands first and
can self-host from the old seed because compiler source does not consume
`SecretBuf`. The runtime consumer must carry:

```text
## Required in pinned seed: SFN-<wipe-capability>
```

and cannot be claimed until `bootstrap.toml` pins a release containing that
capability. This is the runtime-consumer carve-out in
`.claude/rules/seed-dependency.md`; a freshly built compiler cannot help because
the pinned seed compiles working-tree runtime sources.

Every compiler-source slice runs `make compile` before targeted tests. The
exception-layout slice is structural and runs `make clean-build` before its
final rebuild. `make check` is required before declaring the feature shipped.

## 6. Alternatives considered

### 6.1 Ordinary overwrite or `memset`

Rejected. A non-volatile dead store may be deleted, and ordinary arrays provide
neither uniqueness nor deterministic cleanup.

### 6.2 `explicit_bzero` / `SecureZeroMemory` as the language ABI

Rejected as normative. The platform functions are useful prior art, but a
different symbol/header/availability contract on Unix and Windows expands the
trusted surface. A volatile LLVM byte-store loop is uniform across all three
targets and directly testable after optimization.

### 6.3 Volatile `llvm.memset`

Rejected for v1 in favor of explicit volatile stores. LLVM identifies a true
`isvolatile` argument as a volatile operation but cautions that the detailed
access behavior is not cleanly specified. The byte loop depends only on the
better-defined volatile-store rule. It may be revisited if LLVM strengthens the
intrinsic contract.

### 6.4 `Zeroizing<OwnedBuf>` generic wrapper

Rejected for v1. Aggregate generic layout still has restrictions, a wrapper can
accidentally expose the inner non-zeroizing owner, and `OwnedBuf`'s arena-backed
mode conflicts with the v1 allocation guarantee. A concrete family member gives
the checker and runtime one closed contract without changing `OwnedBuf`.

### 6.5 Arena-backed secret buffers

Deferred. Wiping an extent without reclaiming it is possible, but safe arena
reset requires a typed relation between the arena and every live secret owner.
The global arena does not provide one. Libc-backed storage makes individual
wipe-before-free exact and keeps v1 auditable.

### 6.6 Compiler-only lexical drops

Rejected as incomplete. `setjmp`/`longjmp` can bypass entire native frames, so
lexical insertion alone cannot cover a throw from a deeper callee. Stable
exception markers in a cleanup registry cover the skipped frames.

### 6.7 Erase registers and all spills

Rejected as an unsupportable promise under the current LLVM pipeline and general
calling conventions. The SFEP states that residual limit explicitly rather than
marketing a stronger guarantee than the backend can prove.

## 7. Stage1 readiness mapping

- [ ] Parses — no new syntax; the concrete library type must parse under the
  pinned seed.
- [ ] Type-checks / effect-checks — sealed `SecretBuf`, transitive aggregates,
  and `E0908`/`E0909`/`E0916`/`E0917`/`E0918` rules.
- [ ] Emits valid `.sfn-asm` — destructor and cleanup-record operations retained.
- [ ] Lowers to LLVM IR — volatile byte-store loop and cleanup control flow.
- [ ] Regression coverage — ownership, optimized IR, exit paths, allocation,
  and consumer migrations.
- [ ] Self-hosts — fixed-point compiler and runtime build.
- [ ] `sfn fmt --check` clean.
- [ ] Documented in `docs/status.md` and the preview/spec once shipped.

All implementation boxes remain open after acceptance. The approved design and
issue fan-out authorize implementation; they do not make the feature
Implemented.

## 8. Test plan

1. **Ownership/typecheck:** accept move/return/explicit zeroize and explicit
   scalar declassification; reject alias, use-after-move, use-after-zeroize,
   sealed literals/projection/update/destructuring/casts, implicit
   `string`/format/log conversion, ordinary `Slice`, FFI descriptor escape,
   variable-length secret containers, live-owner overwrite (`E0918`), and
   cross-thread capture/send. Prove a
   caller can manually rebuild ordinary bytes only through the visibly named
   scalar declassifier, and classify that copy outside the guarantee.
2. **Optimized IR:** compile fixtures through the production optimization
   pipeline for Linux, Darwin, and Windows; assert the volatile byte loop spans
   `cap` and dominates `free`/reuse.
3. **Normal exits:** instrument a test allocator and prove exactly one wipe on
   fallthrough, early return, each `?` error edge, success return, ignored
   owning return, explicit zeroize, overwrite rejection, and relocation/growth
   of a non-empty buffer.
4. **Exceptions:** prove wipe on same-frame throw, callee throw across multiple
   frames, catch, finally, rethrow, and uncaught throw; prove a pre-try secret
   that remains owned by the catch is not wiped; prove one moved into the
   throwing same-frame try-local or callee is wiped; prove a try-created secret
   moved into a pre-try outer owner is rehomed below the marker and survives
   the throw. Prove the stable marker remains valid when the pre-try cleanup
   head is explicitly zeroized or moved before a later secret throws, including
   nested try, normal pop, and rethrow. With an outer handler, prove a fresh
   throw from catch and a fresh throw from finally each drain a live local,
   unlink the crossed inner marker, and preserve the outer target marker.
5. **Aggregates:** recursively classify structs/enums containing `SecretBuf`;
   prove whole moves rehome every live record, partial moves block parent use,
   replacement restores validity, and reverse-order drop skips moved fields and
   drains every other field exactly once. Apply formatting and concurrency
   rejection to the whole aggregate.
6. **Storage:** prove all `cap` bytes, including truncated/spare capacity, are
   zero before libc free. Reject arena construction and conversion.
7. **Crypto:** retain RFC 8032 signing and RFC 8448/TLS schedule vectors while
   test hooks prove each named secret allocation drains at its last protocol
   use. Public signature/transcript outputs remain byte-identical.
8. **Self-hosting:** `make compile`, targeted suites, and finally `make check`.

Tests must inspect memory before the allocator reuses it; reading after `free`
is not a valid assertion strategy.

## 9. References

- SFN-703 — design issue and implementation fan-out.
- SFN-699 — Ed25519 signing consumer that exposed the gap.
- SFN-692 — ordinary struct reference/aliasing semantics.
- SFEP-0018 — ownership lattice and `OwnedBuf` family.
- SFEP-0064 — draft generic reclamation seam; subordinate to this proposal's
  stronger wipe contract if the designs later converge.
- `compiler/capsules/analyzer/src/ownership_checker.sfn` — shipped move/UAF enforcement.
- `compiler/src/llvm/lowering/instructions_try.sfn` and
  `runtime/sfn/exception.sfn` — current `setjmp`/`longjmp` exception path.
- [LLVM Language Reference: volatile memory accesses](https://llvm.org/docs/LangRef.html#volatile-memory-accesses)
  and [`llvm.memset`](https://llvm.org/docs/LangRef.html#llvm-memset-intrinsics).
- [OpenBSD `explicit_bzero(3)`](https://man.openbsd.org/explicit_bzero.3).
- [Microsoft `RtlSecureZeroMemory`](https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/wdm/nf-wdm-rtlsecurezeromemory).
