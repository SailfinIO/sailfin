# Proposal: Borrow / Ownership Checking as a 1.0 Memory-Safety Requirement for the Native Runtime

Status: **Approved — decisions D1–D9 locked 2026-06-09 (repo owner)**. See "Decisions Locked" below. Implementation tracked by epic #1209.
Date: 2026-06-09 (drafted via `/pickup #1207`; decisions locked same day)
Authors: compiler-architect (Sailbot session)
Closes: #1207
Motivated by: [#1205](https://github.com/SailfinIO/sailfin/issues/1205) (systemic in-place-aliasing corruption, present in **both** the C runtime and its Sailfin-native port)
Related: [#965](https://github.com/SailfinIO/sailfin/issues/965) (M4 structured concurrency / safe sharing), [#822](https://github.com/SailfinIO/sailfin/issues/822) (M4.7 C-runtime deletion), [#322](https://github.com/SailfinIO/sailfin/issues/322) (M1.5 conservative drop emission)
Companion docs: [`docs/runtime_audit.md`](../runtime_audit.md), [`docs/proposals/hierarchical-effects.md`](./hierarchical-effects.md), [`docs/proposals/result-and-question-operator.md`](./result-and-question-operator.md)

> **What this issue produces:** the proposal document and a recommended path.
> It does **not** implement enforcement. A follow-up epic (#1209), spawned from
> the recommendation in §9, owns the implementation. No `compiler/src/*.sfn`
> behavior changes here; `make compile` is unaffected.

---

## Decisions Locked (2026-06-09, repo owner)

The nine decision points in §8 are resolved — all on this proposal's recommended
path. Implementation is groomed into epic **#1209** (sub-issues #1210–#1220).

| # | Decision | Resolution |
|---|---|---|
| **D1** | Adopt the stance reversal? | **Yes** — ownership/aliasing checking is enforced on the native runtime for 1.0 as a soundness floor (**not** a fourth pillar). **Expansion mandate (below).** |
| **D2** | Enforced subset | **Option C** — unique-ownership / no-aliased-mutation / no-use-after-free over `OwnedBuf` + affine values, runtime-scoped. |
| **D3** | Blocker vs quality bar | **1.0 blocker**, satisfied narrowly by **Phase R1** (memory/string core enforced + #1205 determinism regression green). |
| **D4** | Ordering vs #822 | **Fix the aliasing contract before #822** deletes the C bodies. |
| **D5** | `OwnedBuf` type | **Yes** — new owned-buffer / `Slice` type **family** (extensible, not a one-off). |
| **D6** | `unsafe` boundary | **First-class `unsafe { }` / `unsafe fn`** (the block already parses; give it aliasing-boundary semantics). |
| **D7** | Pass placement | **Standalone `ownership_checker.sfn`** after effect-check. |
| **D8** | M4 coupling | **M4 #965 consumes this ownership substrate** for channel-send / spawn-capture safe sharing. |
| **D9** | Doc surface | **`reference/preview/` chapter** at 1.0; promote to a numbered spec chapter when Phase U (user-facing enforcement) ships. |

### The expansion mandate (load-bearing refinement of D1)

The repo owner adopted Option C **explicitly as the first rung of a deliberately
extensible model — not a ceiling.** Sailfin's ownership/borrowing story is
expected to *grow over time* as a modern, agentic-development-era exploration of
memory safety. **Sailfin does not have to be Rust**, and the 1.0 subset is a
floor we build *upward* from, not a terminal design.

Concretely, this reclassifies what the rest of this document calls "post-1.0
maybe" into a **named, intended forward path**:

- The `Borrowed` lattice state (§3.2) and shared-borrow semantics are the
  **planned next widening**, not a speculative aside.
- `Slice` / view lifetimes (§4.3) are designed to deepen toward
  borrowed-view lifetimes.
- "Phase U" (§5.2) — user-facing ownership — is a committed direction, gated on
  sequencing, not on whether we want it.

**Design constraint this imposes on the epic:** E3 (`OwnedBuf`/`Slice`) and E4
(the ownership pass) must be built so the model **widens without a rewrite** —
the lattice, the type family, and the diagnostic surface all leave room for
shared borrows and richer ownership to be added incrementally. Extensibility is
a 1.0 *implementation* requirement, even though the *enforced surface* at 1.0 is
deliberately narrow.

---

## 0. The line this proposal must hold (read first)

This proposal argues for **promoting enforced ownership/aliasing checking to a
1.0 non-negotiable** — but it does so **without adding a fourth pillar**.

The three differentiators stay exactly as they are:

1. **Effect types** — compile-time capability enforcement.
2. **Capability-based security** — capsule manifests + dependency auditing.
3. **Structured concurrency** — planned (M4, #965).

Ownership checking is proposed here as a **soundness requirement on the native
runtime and the language substrate** — the same category as "the type checker
rejects calling a `string` where an `int` is expected." It is a *correctness
floor*, not a marketed feature. We do not put it on the landing page, we do not
call it a pillar, and we do not let it dilute the effects/capabilities/
concurrency story. We ship it because **a systems language whose own runtime
nondeterministically corrupts memory is not 1.0-ready**, and #1205 proves the
current toolchain is exactly that.

### What stance this reverses

`CLAUDE.md` today states, in "Deferred / Not Yet Shipped":

> `Affine<T>` / `Linear<T>` parsed but **not enforced** (post-1.0). … Sailfin's
> safety story is effects and capabilities, **not** borrow checking.

That sentence was written before #1205 established that the C→Sailfin runtime
migration **reproduces** the unsound optimization rather than eliminating it.
This proposal recommends changing that stance for 1.0 **narrowly**: not "Sailfin
is now a borrow-checked language like Rust," but "Sailfin enforces a bounded
no-aliased-mutation / no-use-after-free analysis sufficient to make the native
runtime sound." The precise `CLAUDE.md` / roadmap / spec edits the new stance
requires are enumerated in §4-bis and §9.

---

## 1. Problem statement & motivation

### 1.1 The concrete failure (generalized from #1205)

The recurring, nondeterministic IR corruption tracked through
#740 → #741 → #892 → #1205 has a single structural cause: **an in-place buffer
mutation that assumes non-aliasing it cannot prove.** The "grow-if-at-tip"
`string_append` optimization extends an arena buffer in place and returns the
*same pointer*, on the theory that the buffer is a uniquely-owned intermediate.
When that theory is wrong — when a still-live `lines: string[]` element (or a
`declare`-line collection entry, or a struct-field type-name string) aliases the
same buffer — the in-place write stomps unrelated emitted IR text. The classic
signature is a `0x40`→`0xE7` byte clobber: an `@` or `%` flips to a UTF-8 lead
byte, rendering as a CJK glyph (e.g. `缯`), and `clang` rejects the resulting
`program.ll` with `expected type`. It is nondeterministic because it only fires
under specific heap-layout shifts, so a clean rebuild "fixes" it.

It has been patched **three times at the call-site layer** (#741 made the
`declare`-collection case deterministic; #892 patched the effects/`declare`
substring-view path; the 2026-06 recurrence hit struct-field type-name rendering
in `core_member_lowering.sfn`) and **keeps recurring in new paths**, because each
fix patches one aliasing call-site while the underlying unsound optimization
stays live.

### 1.2 The migration does not fix it — it carries it forward

The critical 2026-06-09 finding in #1205: this is **not** a "delete the C runtime
and it goes away" bug. The Sailfin-native runtime already reimplements the exact
optimization in raw `* u8`:

- **`runtime/sfn/memory/arena.sfn:sfn_arena_sfn_realloc`** (`:312-358`) —
  grow-if-at-tip in-place extend. The body comment (`:313-318`) is explicit:
  *"implements the grow-if-at-tip optimization the `string_append` hot path
  depends on. When `ptr + old_size` is exactly the current page's bump tip and
  the page has room for the delta, extend the bump cursor in place — no copy."*
  The in-place extend is `:345-349`:

  ```sfn
  if ptr_addr + old_size_i == tip_addr {
      if used + extra <= page.capacity {
          page.used = used + extra;
          return ptr;          // ← same pointer, no copy: aliasing assumed
      }
  }
  ```

  There is no check that `ptr` is uniquely owned. Any live alias of the bytes in
  `[ptr, ptr+old_size)` is now silently extended into.

- **`runtime/sfn/string.sfn:sfn_str_sfn_append`** (`:206-208`) is the proof-of-life
  hook for that grow-at-tip path. *Today its body still trampolines to the C
  helper* `sailfin_runtime_string_append` (`:84`) — the native
  `sfn_arena_sfn_realloc` grow-at-tip exists but is not yet called from
  `string.sfn`, and the architect spec comment (`:198-201`) names
  `sfn_arena_realloc`'s grow-if-at-tip as the *intended* chained-concat fast lane
  (M2.4b). The module still `extern`s the legacy C helpers (`:82`
  `sailfin_runtime_string_concat`, `:84` `sailfin_runtime_string_append`). The
  point for this proposal: whether the append rides the C body now or the native
  `sfn_arena_sfn_realloc` after M2.4b, **both targets are the same unsound
  grow-at-tip** — so fixing the aliasing contract (not just the migration) is what
  matters.

- The equivalent C bodies are still live in tree: `sailfin_runtime.c:3837+`
  (`string_append`) over `sailfin_arena.c:208-245` (`sfn_arena_realloc`
  grow-at-tip).

So the optimization **assumes non-aliasing it cannot prove, in either language.**
M4.7/#822 deleting the C files will not fix this, because the Sailfin arena/string
carry it forward. An enforced ownership/aliasing model is the structural fix:
either **prove** the buffer is uniquely owned (making in-place mutation sound) or
**force the copy path**.

### 1.3 Quantifying the surface — how much of `runtime/sfn/**` is exposed

The pattern is **systemic, not a one-off.** The Sailfin-native runtime is written
in a raw-pointer / manual-lifetime dialect: `* u8` payloads, pointer arithmetic
over `i64`-typed address slots, and explicit `malloc` / `free`. A survey of
`runtime/sfn/**` (the modules already migrated under M2/M3/M4):

| Module | Raw-pointer / manual-memory surface | Aliasing-hazard class |
|---|---|---|
| `memory/arena.sfn` | `Arena`/`ArenaPage` as `i64` address slots; `malloc`/`free`/`memcpy` externs; bump cursor arithmetic; **grow-at-tip in-place realloc** (`:345`) | **Direct #1205 cause** — in-place mutation of possibly-aliased buffer |
| `string.sfn` | `* u8` payloads; `sfn_str_sfn_append` over grow-at-tip; externs C concat/append | **Direct #1205 cause** — append aliases stored strings |
| `memory/rc.sfn` | 16-byte `{refcount, drop_fn_addr}` prefix at `payload - 16`; `atomicrmw` retain/release; raw `free` at zero | Use-after-free if a live alias outlives the release-to-zero |
| `memory/mem.sfn` | `sfn_mem_copy_bytes` / `_bounds_check` / `_get_field` / `_free` over raw pointers (#927) | Out-of-bounds / UAF on mis-sized copies |
| `array.sfn` | `* u8` element storage, header/canary convention, in-place push/grow | In-place grow aliases a stored array view |
| `concurrency/scheduler.sfn` | pthread pool, per-task raw `ctx` pointers | Data race / UAF on shared `ctx` across threads |
| `concurrency/serve.sfn` | blocking accept loop, per-connection raw request/response `* u8` (#1092) | UAF if a response buffer aliases a freed request |
| `concurrency/channel.sfn`, `parallel.sfn` | raw element pointers crossing thread boundaries | Send-after-free / shared-mutable-alias across threads |

The common denominator across **every** one of these is: *a raw `* u8` (or
`i64` address) whose unique-ownership the compiler does not track, mutated or
freed on the assumption that no other live binding aliases it.* That assumption
is exactly what an ownership/aliasing analysis exists to verify. The arena and
string cases are the ones that have already bitten (#1205); the RC, scheduler,
channel, and serve cases are latent instances of the same class that will bite as
M4 concurrency lands more sharing.

> **Scoping note for the survey.** The numbers above are a structural census
> (which modules use the hazardous pattern), not a line count. The follow-up
> epic (§9) should produce a precise per-file inventory of in-place-mutation and
> manual-`free` sites as its first sub-issue, because that inventory is the
> migration checklist.

### 1.4 Why this is a 1.0 concern specifically

Three of the four "hard prerequisites" for the runtime rewrite in
`docs/runtime_audit.md` §"Compiler Prerequisites" are already shipped (integer
types #556, `extern fn`, atomic intrinsics #323). The runtime is being written
*now*, in raw pointers, **without** the one guarantee that would make its core
optimizations sound. Every module added to `runtime/sfn/**` between now and 1.0
deepens the migration debt. The cost of retrofitting an ownership model grows
monotonically with the size of the raw-pointer runtime surface. The cheapest
time to fix the aliasing contract is **before** M4.7/#822 deletes the C bodies
and locks the Sailfin runtime in as the only implementation.

---

## 2. What subset to enforce for 1.0

The design space runs from "nothing" (status quo) to "full Rust." We evaluate
three enforceable points and recommend one.

### Option A — Full Rust-style borrow checker (moves + shared/unique borrows + lifetimes)

*What it proves:* every reference has a statically-known lifetime; `&mut` is
exclusive; `&` is shared-immutable; no reference outlives its referent.

| Pros | Cons |
|---|---|
| Strongest guarantee; provably eliminates the entire aliasing-hazard class | Requires a lifetime-inference engine (region/lifetime variables, NLL-style dataflow) — a multi-quarter compiler subsystem |
| Industry-proven soundness model | Forces lifetime syntax (`'a`) or sophisticated elision into a language whose pillars are elsewhere; high learning curve; **LLM training-data-poor** (violates "AI agents are users") |
| | Existential lifetimes interact badly with the arena model the runtime *wants* (region-scoped allocation) without `'arena`-style annotations |
| | Massive blast radius on existing `.sfn` — every signature passing a reference must be lifetime-checked |

**Verdict: rejected for 1.0.** Disproportionate to the problem. The hazard is
*aliased in-place mutation and use-after-free in runtime code*, not arbitrary
reference graphs in user code. A full borrow checker is the right tool for a
language whose central promise is memory safety via borrowing; Sailfin's central
promises are elsewhere. Building it would dilute the three pillars by consuming
the entire pre-1.0 compiler budget.

### Option B — Affine / linear types only (move-only, no aliased mutation)

*What it proves:* an `Affine<T>` value is used **at most once** (move-only; no
implicit copy, no second use after move); a `Linear<T>` value is used **exactly
once** (must be consumed). No shared mutable aliasing because there is never more
than one live binding to an affine value.

This **builds directly on the existing parse surface.** `Affine<T>` / `Linear<T>`
already parse and are stripped in seven compiler locations before type
classification:

- `compiler/src/typecheck_types.sfn:487-498` (`strip` before `spawn_future_kind`)
- `compiler/src/llvm/type_mapping.sfn:85-98`, `:289-296` (`unwrap_move_wrapper`)
- `compiler/src/llvm/expressions_helpers.sfn:131-138`
- `compiler/src/llvm/expression_lowering/native/{core_type_mapping,statement_type_mapping}.sfn`
- `compiler/src/llvm/lowering/type_descriptors.sfn`

Today these wrappers are *transparent* — stripped and ignored. Option B makes
them *load-bearing*: the move-checker enforces single-use on values wrapped in
them.

| Pros | Cons |
|---|---|
| Reuses the existing `Affine`/`Linear` parse surface — no new syntax to design | Move-only is awkward for the runtime's actual pattern: the arena *wants* to hand out a buffer, keep allocating, and later extend that same buffer in place. Pure affinity forbids the second reference even when it is sound |
| Affine = "no aliased mutation" by construction; directly forbids the #1205 pattern when the buffer is `Affine` | Does not by itself express "uniquely-owned, mutable, growable buffer" — that needs a *unique mutable borrow*, which is borrow-checking, not just affinity |
| Move semantics are familiar (C++ `unique_ptr`, Rust moves); reasonable LLM coverage | Whole-language affinity would reject huge amounts of existing user `.sfn` that freely copies values |
| Composable with effects: an affine value threaded through an effectful call is still single-use | Requires a *copy/clone* story (when is duplication allowed?) and a *consume-on-drop* story |

**Verdict: necessary but not sufficient on its own.** Affinity is the right
*ownership* primitive, but the runtime's grow-at-tip optimization specifically
needs a **uniquely-owned mutable buffer that can be mutated in place and handed
back** — i.e. unique *mutability*, which is one controlled borrow beyond pure
affinity. Option B is a building block of the recommendation, not the whole
answer.

### Option C — Narrow "no use-after-free / no aliased in-place mutation" analysis, scoped initially to runtime code (RECOMMENDED)

*What it proves:* for values of a designated **uniquely-owned buffer type**, the
compiler proves there is **no live alias** at the point of in-place mutation or
`free`. Concretely:

1. A safe, owned, growable buffer abstraction — call it `OwnedBuf` (working name;
   §4 fixes the surface) — that the compiler treats as **unique**: assigning it
   moves it (the source binding is dead afterward), and taking a second live
   reference is an error.
2. In-place mutation (`grow`, `append`, `set`) and disposal (`free`/drop) are
   permitted **only** through the unique owner. Because the owner is unique, the
   grow-at-tip optimization is *sound by construction* — there is no other live
   binding to stomp.
3. The analysis is a **dedicated ownership pass** (§3) that runs on a bounded
   surface: first `runtime/sfn/**`, then opt-in for user code. It does **not**
   impose lifetimes or borrows on ordinary `.sfn`.

This is a **strict subset of Rust's model** — affine ownership (Option B) plus a
*unique mutable access* discipline, minus shared borrows, minus lifetime
variables. It is exactly enough to make the runtime's hot-path optimizations
sound and to eliminate the #1205 hazard class, and **no more**.

| Pros | Cons |
|---|---|
| Smallest model that actually fixes #1205 (proves unique ownership → grow-at-tip is sound) | Still a new analysis pass to build and maintain |
| Scoped rollout (runtime-first, then opt-in) bounds blast radius and lets the runtime migrate incrementally | "No shared borrow" means read-only sharing of an owned buffer needs an explicit copy-to-view or a (later) slice type |
| Builds on `Affine`/`Linear` parse surface (Option B) for the ownership half | Requires the escape-hatch/FFI boundary (§4) to be designed carefully so raw runtime code can still call libc |
| Stays out of user code by default → does not dilute pillars, does not break existing `.sfn` | Defers full borrow checking (shared `&`/unique `&mut` for arbitrary user types) to post-1.0 — acceptable, because that is a *feature*, not a *soundness floor* |
| Composes cleanly with the effect checker (both are post-typecheck dataflow passes over the same IR) | |

**Recommendation: Option C, with Option B's affine types as its ownership
substrate.** Enforce a *unique-ownership / no-aliased-mutation / no-use-after-free*
analysis on a designated owned-buffer type and on `Affine`/`Linear`-wrapped
values, scoped first to `runtime/sfn/**`, opt-in for user code, with a defined
`unsafe`/`extern` escape hatch. This is the minimal subset that makes the native
runtime sound without turning Sailfin into a borrow-checked language or touching
the three pillars.

---

## 3. Enforcement model

### 3.1 Where it lives in the pipeline

A **new ownership pass**, after typecheck and effect-check, before native-IR
emission:

```
lexer → parser → ast → typecheck → effect_checker → [ownership_checker] → emit_native → llvm/lowering
```

Rationale for a *separate* pass rather than folding into typecheck:

- **Typecheck is duplicate-detection + conformance today** (per `runtime_audit.md`:
  "the typecheck symbol table is duplicate-detection-only"); it is not a
  full dataflow engine. Ownership analysis is fundamentally a **dataflow /
  liveness** problem (is this binding live at this use?), which wants its own
  pass with a CFG view, not the AST-walking shape of typecheck.
- **It mirrors the effect checker's architecture.** `effect_checker.sfn` already
  walks nested blocks, lambdas, and `routine` scopes computing a per-scope
  capability set and emitting span-anchored diagnostics. The ownership checker is
  the same *shape* of pass — walk the same scopes, compute a per-binding
  **ownership/liveness state** instead of an effect set — so it can reuse the
  scope-walking infrastructure (`compiler/src/effect_checker.sfn`) and the
  diagnostic-emission plumbing (spans + fix-it hints).
- **Separability of risk.** A new pass can be gated behind a flag and rolled out
  on `runtime/sfn/**` first without perturbing user compilation. Folding into
  typecheck would make every `sfn check` carry the analysis from day one.

New file: `compiler/src/ownership_checker.sfn`, invoked from
`compiler/src/main.sfn` between the effect-check and emit stages.

### 3.2 What it proves (the dataflow lattice)

Per owned binding, the pass tracks an **ownership state** through the CFG:

- `Owned` — the binding uniquely owns its value; in-place mutation and drop are
  legal here.
- `Moved` — ownership transferred out (by assignment, by passing to a consuming
  parameter, by `return`); **any subsequent use is an error.**
- `Borrowed(shared)` — (post-1.0 extension point) a read-only view exists; no
  mutation or move until the borrow ends.

For the 1.0 runtime-soundness subset, only `Owned` / `Moved` are required. The
core theorems the pass establishes:

1. **Unique ownership at mutation.** When code calls an in-place mutator
   (`OwnedBuf.grow`, `.append`, `.set`) or a disposer (`free`, drop), the
   receiver must be in state `Owned` and have **no other live binding** aliasing
   it. This is what makes grow-at-tip sound: the arena hands out an `OwnedBuf`,
   and the only way to reach the grow path is through the unique owner.
2. **No use-after-move.** Reading or mutating a `Moved` binding is rejected.
3. **No use-after-free.** A binding whose value was passed to a disposer
   transitions to `Moved`/`Dropped`; later use is rejected. (This directly
   forbids the RC release-to-zero-then-use hazard in `rc.sfn`.)

### 3.3 Diagnostics — error-code family + fix-its

Following the established diagnostic conventions (effect diagnostics; the
`E08xx` extern-ABI family `E0801`–`E0806` in `typecheck_types.sfn`), reserve a
new **`E09xx` ownership family**:

| Code | Condition | Fix-it hint |
|---|---|---|
| `E0901` | Use of a moved value | `value moved here at <span>; clone it before the move, or restructure so the second use precedes the move` |
| `E0902` | In-place mutation of a possibly-aliased buffer | `'<name>' may be aliased by '<other>' (created at <span>); take a unique OwnedBuf, or use the copying concat path` |
| `E0903` | Use after free / after drop | `'<name>' was freed at <span>; do not use it after disposal` |
| `E0904` | Second live reference to a unique value | `'<name>' is uniquely owned; this creates a second live binding — move it or take an explicit copy` |
| `E0905` | Returning a reference to a value that does not outlive the caller | `'<name>' is local to this function; return an owned value or copy into the caller's buffer` |
| `E0906` | Ownership violation across an `unsafe`/`extern` boundary without the required acknowledgement | `raw-pointer escape requires the call site to be inside an \`unsafe\` block / the buffer to be released to FFI` |

Each diagnostic carries a **source span** (the offending use) **plus the span of
the move/free that invalidated it** — the two-span shape that makes
use-after-move diagnostics actionable (the same quality bar the effect checker
hits with its "declared here / required here" pairs).

### 3.4 How it composes with the effect checker

The two passes are **orthogonal and complementary**, and run back-to-back over
the same scope structure:

- The **effect checker** answers *"is this code allowed to perform this
  capability?"* (a permission question over a capability lattice).
- The **ownership checker** answers *"is this memory access sound?"* (a liveness
  question over an ownership lattice).

They share infrastructure (scope/CFG walking, span-anchored diagnostics) but not
semantics. A function can be effect-correct and ownership-unsound, or vice versa;
both must pass. Crucially, ownership does **not** introduce a new effect atom —
the taxonomy stays locked at the canonical six (`clock`, `gpu`, `io`, `model`,
`net`, `rand`; see `effect_taxonomy.sfn` and `docs/proposals/hierarchical-effects.md`).
Ownership is a separate axis, exactly as the three-pillars line in §0 requires.

### 3.5 What it deliberately does *not* do (1.0 scope fence)

- No lifetime variables (`'a`), no lifetime elision rules.
- No shared `&` / unique `&mut` borrow syntax for arbitrary user types (the
  `Borrowed` state is a reserved extension point, not 1.0 surface).
- No whole-program alias analysis; the unique-ownership guarantee comes from the
  *type* (`OwnedBuf` / `Affine<T>`), not from inferring aliasing on raw `* u8`.
- No enforcement on raw `* u8` itself — raw pointers stay in the `unsafe`/`extern`
  escape hatch (§4). The analysis proves soundness of the *safe* owned-buffer
  abstraction that wraps them.

---

## 4. Raw-pointer / `extern fn` / escape-hatch story

Runtime code fundamentally needs raw pointers and FFI: `arena.sfn` calls
`malloc`/`free`/`memcpy`; `string.sfn` calls `memcmp`/`memchr`/`strtod`;
`platform/*.sfn` declares the entire libc/pthread/posix surface. An ownership
model that forbids raw pointers outright cannot express the runtime at all. The
escape hatch is therefore **load-bearing, not optional.**

### 4.1 The `unsafe` boundary

`extern fn` already parses with an optional `unsafe` prefix (per
`runtime_audit.md` §"extern fn", shipped 2026-05-01: *"`extern fn` parses with
optional `unsafe` prefix"*). Extend that into a coherent boundary:

- **Raw `* T` is "unsafe-typed."** Constructing, dereferencing, doing pointer
  arithmetic on, or `free`-ing a raw `* T` is permitted **only**:
  - inside an `extern fn` body, or
  - inside an explicit `unsafe { … }` block — the syntax **already parses today**
    as a block statement (`compiler/src/parser/statements.sfn:287-298`) but
    carries **no ownership semantics yet**; this proposal gives it the
    aliasing-boundary meaning, or
  - inside a function marked `unsafe fn` (the `unsafe` prefix already parses on
    `extern fn`; see `parser/declarations.sfn:896-902`).
- The ownership checker **does not analyze** the interior of an `unsafe` region
  for aliasing — it is the author's asserted responsibility, exactly as in Rust.
  What it *does* enforce is the **boundary**: a raw pointer may not silently
  escape into safe code as an aliasable mutable handle. It must be wrapped into
  an `OwnedBuf` (transferring unique ownership) or copied out.
- `E0906` fires when safe code touches a raw pointer outside an `unsafe` region.

This keeps the runtime's libc calls legal (they live behind `extern`/`unsafe`)
while drawing a bright line: *the unsound assumptions live in named, auditable
`unsafe` regions, not diffused across every `* u8` in the codebase.*

### 4.2 A sound expression of grow-at-tip: the `OwnedBuf` abstraction

The whole point is to express the grow-at-tip optimization **soundly** rather
than ban it. The mechanism is a uniquely-owned mutable buffer type:

```sfn
// Sketch — exact surface fixed by the follow-up epic.
// OwnedBuf is a unique, growable byte buffer. The ownership checker
// guarantees there is at most one live binding to any OwnedBuf, so
// in-place mutation through it cannot stomp an alias.
struct OwnedBuf {
    // raw storage lives behind the unsafe boundary; the safe API is the
    // only way to touch it from runtime code.
    ptr_addr: i64;   // unsafe-typed interior
    len: i64;
    cap: i64;
    arena_addr: i64; // owning arena, for grow
}

// Consumes `self` (move), returns the (possibly relocated) buffer.
// Because `self` is unique and moved, grow-at-tip is SOUND: no live
// alias of the old bytes can exist. No effect clause: a memory
// primitive declares no effects (same discipline as arena.sfn).
fn owned_buf_append(self: OwnedBuf, suffix: Bytes) -> OwnedBuf {
    // grow-at-tip when `self` is at the arena bump tip, else copy;
    // sound either way because `self` is uniquely owned.
}
```

The key move: `owned_buf_append` **consumes** its `self` (affine/move semantics,
Option B) and **returns** the new buffer. The caller's old binding is `Moved` and
dead. The arena's grow-at-tip path inside the body is now provably sound — the
ownership checker has established there is no other live binding to the bytes, so
extending in place cannot corrupt anything. When uniqueness *cannot* be proven
(the buffer was shared into a `string[]`), the value is not an `OwnedBuf` in the
first place — it is a copied view, and the append takes the copying concat path.

This is the structural fix #1205 asks for, stated positively: **grow-at-tip stays,
but only on values the compiler has proven unique.** The corruption becomes
*unrepresentable* rather than *patched at each call site*.

### 4.3 Slice / view companion (read-only sharing)

For read-only sharing without copying (e.g. `sfn_str_sfn_slice`'s spec intent of
a non-owning `SfnSlice { data, len }`), a `Slice<T>` / `BufView` type provides a
**non-owning, immutable** view. Views cannot mutate or free; they borrow
read-only from an `OwnedBuf` whose owner outlives the view. In the 1.0 subset,
view lifetimes are kept trivial (function-local, no escape) — `E0905` rejects a
view that outlives its backing buffer. Full borrowed-view lifetimes are the
post-1.0 extension point (§3.2 `Borrowed` state).

---

## 5. Migration impact on `runtime/sfn/**`

### 5.1 What must change, by module

| Module | Change required | Rough effort |
|---|---|---|
| `memory/arena.sfn` | `sfn_arena_sfn_realloc` grow-at-tip (`:345`) moves behind `OwnedBuf`; raw pointer interior wrapped in `unsafe`; bump arithmetic stays `unsafe`-internal | **M** — the arena is the trust root; careful but bounded |
| `string.sfn` | `sfn_str_sfn_append` takes/returns `OwnedBuf` (move); concat returns owned; slice returns `Slice`; externs stay behind `unsafe` | **M** — touches the hot path; needs the determinism regression from #1205 as the gate |
| `memory/rc.sfn` | release-to-zero path proves no live alias before `free` (`E0903`); retain/release stay `atomicrmw`; drop_fn invocation gated on uniqueness | **S–M** — mostly boundary annotations |
| `memory/mem.sfn` | `copy_bytes`/`bounds_check`/`get_field`/`free` annotated `unsafe` or re-expressed over `OwnedBuf`/`Slice` | **S** — thin helpers |
| `array.sfn` | in-place push/grow behind unique ownership; element storage `unsafe`-internal | **M** — mirrors the string/arena work |
| `concurrency/{scheduler,channel,parallel,serve}.sfn` | per-task/per-connection raw `ctx` and request/response buffers become moved-across-boundary owned values (ties into M4 #965 safe sharing — see §6) | **M–L** — co-designed with M4, not before |

Aggregate: the **memory + string core** (arena, string, rc, mem, array) is the
1.0-critical surface — roughly **M-sized per module, 4–5 modules**. The
concurrency modules are **M4-coupled** and should migrate *with* M4, not ahead of
it (§6, §7).

### 5.2 Gradual vs. whole-language

**Strongly recommend gradual, runtime-first:**

1. **Phase R0** — land the ownership pass *dormant* (parses `OwnedBuf`/`unsafe`,
   builds the dataflow, emits diagnostics **as warnings**, enforced on nothing).
   Self-host must stay green (no behavior change). This is the analog of the
   "ship the consumer dormant" pattern the runtime migration already uses
   (`_compile_runtime_sfn_sources` shipped dormant in #308).
2. **Phase R1** — flip enforcement **on for `runtime/sfn/memory/**` and
   `string.sfn`** (the #1205 hot path). Migrate those modules to `OwnedBuf`.
   The #1205 determinism regression is the acceptance gate.
3. **Phase R2** — extend enforcement to the rest of `runtime/sfn/**`
   (array, then concurrency with M4).
4. **Phase U (post-1.0)** — opt-in for user code (`Affine<T>`/`Linear<T>` become
   enforced when used; ordinary code is unaffected unless it opts in). Whole-
   language enforcement, shared borrows, and lifetime syntax are all post-1.0.

### 5.3 Back-compat for existing `.sfn` and capsules

- **User code is unaffected at 1.0.** Ownership enforcement is runtime-scoped
  (Phases R1–R2). Existing `.sfn` files and published capsules that never name
  `OwnedBuf` / `unsafe` / enforced `Affine` compile exactly as before. This is
  the same back-compat posture the hierarchical-effects proposal takes ("every
  existing annotation stays valid verbatim").
- `Affine<T>` / `Linear<T>` are currently *stripped and ignored* in seven
  compiler sites (§2 Option B). Turning them load-bearing is **opt-in**: code
  that does not use them sees no change; code that does gets the single-use
  guarantee. No existing program uses them meaningfully today (they are
  parse-only), so there is no silent breakage.
- The seed/self-host story: because Phase R0 ships dormant and R1 flips a bounded
  surface, each phase is a normal `make compile` + `make check` self-host gate.
  No triple-bootstrap workaround is needed.

---

## 6. Concurrency interaction (M4 / #965)

#965 (M4 structured concurrency) lists **"Affine/Linear for safe sharing"** as
*out-of-scope / post-1.0*. This proposal's recommendation **partially pulls that
forward** — and that is a feature, not a conflict:

- The ownership substrate (Option B affine types + Option C unique ownership) is
  *exactly* the mechanism M4 needs to make `channel` send and `spawn` capture
  sound. Sending an `OwnedBuf` across a channel is a **move**: the sender's
  binding is `Moved`/dead, the receiver gets unique ownership — no shared-mutable
  alias across threads, which is the classic data-race hazard. `spawn`'s closure
  capture (a runtime prerequisite, `runtime_audit.md` §3) of an owned value is
  likewise a move.
- So the ownership pass is a **shared dependency** of both runtime soundness
  (this proposal) and safe concurrent sharing (M4). Building it once, runtime-
  first, gives M4 its safe-sharing primitive for free when the scheduler/channel
  modules reach Phase R2.

**Recommendation:** build the ownership pass under this proposal's epic, scoped to
the memory/string core first (R1), and have M4 #965 **consume** it for channel/
spawn safe-sharing rather than inventing a parallel mechanism. The concurrency
modules (`scheduler`, `channel`, `parallel`, `serve`) migrate to enforced
ownership **with** M4 (Phase R2), not before — their raw-`ctx` patterns are best
re-expressed as moves at the same time the concurrency semantics are finalized.
This proposal does **not** pull M4's *concurrency* surface forward; it pulls the
*ownership substrate* forward and shares it.

---

## 7. Sequencing vs. 1.0 and M4

### 7.1 Blocker or quality bar?

**Recommendation: a 1.0 _blocker_, but a tightly-scoped one.**

The argument that it is a blocker: #1205 is a `seed-blocker`-class bug that can
red-CI any PR shifting heap layout (it has bitten #890→#892 and a test run on
PR #1204). A toolchain that nondeterministically corrupts its own emitted IR is
not shippable as 1.0. The call-site whack-a-mole has failed three times. The only
demonstrated structural fix is proving uniqueness (or forcing the copy).

The argument that keeps it *scoped*: the blocker is satisfied by **Phase R1**
(enforced ownership on `runtime/sfn/memory/**` + `string.sfn`, #1205 determinism
regression green), **not** by whole-language borrow checking. Everything beyond
R1 — user-code opt-in, shared borrows, lifetimes — is explicitly post-1.0. So the
1.0 gate is narrow and achievable, not "ship a borrow checker."

### 7.2 Relationship to M4.7 / #822 (C deletion) — fix the contract first

**Recommendation: fix the aliasing contract _before_ #822 deletes the C bodies.**

Reasoning: while both the C and Sailfin runtimes carry the bug, the C path is
still linked and provides a (buggy but) fallback. Once #822 deletes
`sailfin_runtime.c` / `sailfin_arena.c`, the Sailfin `arena.sfn` / `string.sfn`
grow-at-tip is the **only** implementation, and any latent aliasing corruption
has no alternative path. Landing the `OwnedBuf` soundness (Phase R1) *before* the
C deletion means #822 deletes C bodies whose Sailfin replacements are already
sound — de-risking the deletion. #1205's own scope note agrees: *"deleting C does
not by itself fix the bug"* and *"this de-risks it."*

Concrete ordering:

```
#1205 interim fix (copy-on-alias / drop grow-at-tip, BOTH runtimes)   ← stops the bleeding now
        │
        ▼
this proposal's epic, Phase R0 (dormant pass) → R1 (enforce memory/string core)
        │   (OwnedBuf makes grow-at-tip sound; #1205 determinism regression is the gate)
        ▼
M4.7 / #822 (delete C runtime bodies)   ← now safe: Sailfin replacements are sound
        │
        ▼
Phase R2 (rest of runtime/sfn/**, concurrency with M4 #965)
        │
        ▼
Phase U (post-1.0: user-code opt-in, shared borrows, lifetimes)
```

### 7.3 Phasing recommendation (summary)

- **Now (separate, #1205):** interim copy-on-alias or drop grow-at-tip in both
  runtimes — unblocks CI; not this proposal's deliverable.
- **1.0 blocker (this epic, R0→R1):** ownership pass + `OwnedBuf`, enforced on the
  memory/string core. Land before #822.
- **1.0, M4-coupled (R2):** concurrency modules migrate with M4 #965, consuming
  the same ownership substrate.
- **Post-1.0 (Phase U):** user-facing ownership, shared borrows, lifetimes.

---

## 8. Decision points (require the maintainer's call)

1. **D1 — Adopt the stance reversal?** Approve promoting enforced
   ownership/aliasing checking to a 1.0 soundness requirement (not a pillar),
   reversing the current `CLAUDE.md` "not borrow checking" line? *(Yes/no gates
   the whole epic.)*
2. **D2 — Subset.** Accept the §2 recommendation (Option C: unique-ownership /
   no-aliased-mutation / no-UAF, on `OwnedBuf` + affine types, runtime-scoped),
   or prefer a different point on the A–C spectrum?
3. **D3 — Blocker vs. quality bar.** Accept §7's "1.0 blocker, satisfied by
   Phase R1" framing, or treat it as a post-1.0 quality bar (accepting that 1.0
   ships with the latent #1205 hazard class in the Sailfin runtime)?
4. **D4 — Ordering vs. #822.** Confirm "fix the contract before deleting the C
   bodies" (§7.2), or allow #822 to proceed first?
5. **D5 — `OwnedBuf` surface.** Greenlight a new owned-buffer type, or require
   the model to be expressed purely through enforced `Affine<T>`/`Linear<T>`
   wrappers over existing types (no new named type)?
6. **D6 — `unsafe` keyword.** Promote `unsafe` to a first-class block/`fn`
   modifier (beyond the existing `extern fn` prefix), or confine raw-pointer ops
   to `extern fn` bodies only?
7. **D7 — Pass placement.** Confirm a standalone `ownership_checker.sfn` pass
   after effect-check (§3.1), vs. folding into typecheck?
8. **D8 — M4 coupling.** Confirm M4 #965 consumes this ownership substrate for
   safe sharing (vs. M4 owning its own mechanism)?
9. **D9 — Doc surface.** Ship the user-facing description as a **preview** chapter
   (`reference/preview/`) at 1.0 since user enforcement is Phase U / post-1.0,
   keeping the runtime-internal enforcement out of the marketed spec until it is
   user-facing? *(See §4 reconciliation below.)*

---

## 4-bis. Reconciliation with the three pillars + required doc edits

*(Acceptance-criterion: "explicitly reconciles with the three pillars and
specifies the `CLAUDE.md` / roadmap / spec-or-preview edits the new stance
requires.")*

**Reconciliation.** Ownership checking is a *soundness floor on the
implementation*, in the same category as type checking — not a marketed
differentiator. The pillars (effects, capabilities, concurrency) are unchanged.
We never describe Sailfin as "a borrow-checked language"; we describe it as "a
language whose runtime is memory-safe by construction." The analysis stays
runtime-scoped at 1.0 (Phase R1–R2); user-facing ownership is post-1.0 and
clearly a *library/feature* concern, not a fourth pillar.

**Required documentation edits (made by the implementing epic, not this issue):**

- **`CLAUDE.md`** — edit two places:
  - "Deferred / Not Yet Shipped": change the `Affine<T>`/`Linear<T>` line from
    *"parsed but not enforced (post-1.0) … Sailfin's safety story is effects and
    capabilities, **not** borrow checking"* to a statement that a **bounded
    ownership/aliasing analysis is enforced on the native runtime for 1.0**
    (memory safety floor), while *user-facing* ownership and full borrow checking
    remain post-1.0. Keep the "not a fourth pillar" line explicit.
  - "Design Decision Framework" → "Don't ship unfinished safety claims": note
    that runtime ownership enforcement is the exception that *is* shipped
    end-to-end (Phase R1), so it may be documented as enforced once it is.
- **Roadmap (`site/src/pages/roadmap.astro`)** — add the ownership-checking epic
  under the 1.0 critical path / runtime-hardening workstream, sequenced before
  #822 (§7.2). Cross-link #1205 and #965.
- **`docs/runtime_audit.md`** — update the "in-place optimization notes" and the
  M1.5/ownership prerequisite discussion (§"Memory Management Crisis",
  §"Compiler Prerequisites" item 5) to reference enforced unique ownership as the
  structural fix, superseding the "ownership types deferred post-1.0; runtime
  trusts compiler-emitted drops" framing for the runtime surface specifically.
- **Spec vs. preview:** ship the user-facing description as a **preview** chapter
  (`site/src/content/docs/docs/reference/preview/ownership.md`) at 1.0, since
  user enforcement is Phase U. The *runtime-internal* enforcement is documented
  in `runtime_audit.md` / `runtime_architecture.md`, not the marketed spec, until
  it becomes user-facing — honoring "never market or document an unenforced
  feature" (it is enforced for the runtime, previewed for users). Promote to a
  numbered spec chapter (`reference/spec/`) only when Phase U enforcement ships.

---

## 9. Proposed epic breakdown (skeleton for grooming)

A follow-up **epic** (`type:epic`, `area:compiler`, `area:architecture`) —
working title *"Ownership/aliasing enforcement for native-runtime memory
safety"* — decomposed into pickable sub-issues. Sizes per the issue contract
(XS/S/M, never L). Sequenced so each is a clean `/pickup`.

| # | Sub-issue (working title) | Type | Size | Depends on | Notes |
|---|---|---|---|---|---|
| E1 | **Precise hazard inventory** of `runtime/sfn/**` — every in-place-mutation and manual-`free` site, tabulated | refactor | S | — | The migration checklist; refines §1.3 from census to line-cited list |
| E2 | **`unsafe` boundary design + parse** — `unsafe { }` block / `unsafe fn` beyond the existing `extern` prefix (gated on D6) | feature | M | D6 | Parser + AST only; no enforcement yet |
| E3 | **`OwnedBuf` / `Slice` type surface** (gated on D5) — struct + safe API sketch in §4 made concrete; parse + typecheck | feature | M | D5 | The sound grow-at-tip vehicle |
| E4 | **Ownership pass skeleton** — `ownership_checker.sfn` after effect-check; CFG/scope walk reusing effect-checker infra; **dormant** (warnings only) | feature | M | E2 | Phase R0; self-host stays green |
| E5 | **Ownership dataflow: move/use-after-move** — `Owned`/`Moved` lattice, `E0901`/`E0904` | feature | M | E4 | Core analysis |
| E6 | **In-place-mutation + UAF rules** — `E0902`/`E0903`, unique-receiver check for mutators/disposers | feature | M | E5 | Closes the #1205 hazard class |
| E7 | **Enforce affine `Affine<T>`/`Linear<T>`** — flip the seven strip-sites to load-bearing single-use | feature | M | E5 | Option B substrate; opt-in |
| E8 | **Migrate `memory/arena.sfn` + `string.sfn` to `OwnedBuf`** — grow-at-tip behind unique ownership; **Phase R1 enforcement on** | refactor | M | E3,E6 | #1205 determinism regression is the gate; land before #822 |
| E9 | **Migrate `rc.sfn` / `mem.sfn` / `array.sfn`** | refactor | M | E8 | Rest of memory core |
| E10 | **Diagnostics polish + docs** — `E09xx` fix-its, `CLAUDE.md`/roadmap/`runtime_audit.md` edits (§4-bis), preview chapter | docs | S | E6,E8 | The stance-reversal doc edits |
| E11 | **M4 coupling** — channel-send / spawn-capture as moves; concurrency modules to Phase R2 | feature | M | E8, #965 | Co-designed with M4; not before |

**Ordering rationale:** E1 (inventory) → E2/E3 (escape hatch + owned type) →
E4–E7 (the pass, dormant then enforcing move + mutation + affine) → E8 (the
#1205-closing runtime migration, the 1.0 blocker) → E9–E10 (rest of core +
docs) → E11 (M4, post-blocker). E8 is the milestone that satisfies D3's "1.0
blocker, satisfied by Phase R1" and must precede #822 per D4.

---

## Appendix A — File citations (grounding)

- In-place grow-at-tip, Sailfin: `runtime/sfn/memory/arena.sfn:312-358`
  (in-place extend `:345-349`).
- Append over grow-at-tip, Sailfin: `runtime/sfn/string.sfn:198-208`; legacy C
  externs `:82-84`.
- C equivalents (still linked): `runtime/native/src/sailfin_runtime.c:3837+`,
  `runtime/native/src/sailfin_arena.c:208-245`.
- RC release-to-zero `free`: `runtime/sfn/memory/rc.sfn` (`sfn_rc_sfn_release`).
- `Affine`/`Linear` strip sites (parse surface to make load-bearing):
  `compiler/src/typecheck_types.sfn:487-498`,
  `compiler/src/llvm/type_mapping.sfn:85-98, 289-296`,
  `compiler/src/llvm/expressions_helpers.sfn:131-138`,
  `compiler/src/llvm/expression_lowering/native/core_type_mapping.sfn:170-173`,
  `compiler/src/llvm/expression_lowering/native/statement_type_mapping.sfn:32-35`,
  `compiler/src/llvm/lowering/type_descriptors.sfn`.
- Effect checker (pass to mirror): `compiler/src/effect_checker.sfn`.
- Effect taxonomy lock (six atoms; ownership must not add a seventh):
  `compiler/src/effect_taxonomy.sfn:18-22`.
- Extern-ABI diagnostic family `E0801`–`E0806` (numbering precedent for `E09xx`):
  `compiler/src/typecheck_types.sfn:check_extern_signature`.
- Runtime prerequisites + M1.5 drop emission: `docs/runtime_audit.md`
  §"Compiler Prerequisites", item 5 (#322).
