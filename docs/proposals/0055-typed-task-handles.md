---
sfep: 0055
title: Typed task handles (Task<T>) and ordered multi-await (join_all)
status: Accepted
type: language
created: 2026-07-22
updated: 2026-07-22
author: "agent:compiler-architect; human review"
tracking: "SFN-440, SFN-441"   # SFN-440 design (this SFEP); SFN-441 implementation
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0055 — Typed task handles (`Task<T>`) and ordered multi-await (`join_all`)

## 1. Summary

Sailfin's structured concurrency has no **user-writable type for a spawned
task's result handle**. A `spawn fn() -> T { ... }` today produces an opaque
future pointer that the compiler distinguishes only by a compile-time
"future-kind" string tag (`void`/`number`/`int`/`bool`/`string`/`ptr`) carried
on the `Spawn`/`Await` AST nodes — never a nameable, annotatable type
(`compiler/src/ast.sfn:182-204`, `docs/status.md:468`). The immediate
consequence is that a program cannot annotate a collection of handles: `let mut
hs = []` is an inferred-empty array whose element slot lowers as `double`, so
pushing a future pointer through it corrupts the pointer, and SFN-386 correctly
made that case fail closed with **E0831** (`typecheck_types.sfn:1215-1233`,
fired from `typecheck.sfn:1997-2007`). E0831's own diagnostic states the gap
outright: *"there is no writable handle type to annotate."* This SFEP defines
that type — a nominal, generic, single-use **`Task<T>`** — and an ordered
multi-await standard-library operation, **`join_all(handles: Task<T>[]) ->
T[]`**, that awaits a dynamic collection of tasks and returns their results in
**input order**. The two together unblock the natural "spawn many, then await in
input order" program shape that Sailfin's structured-concurrency surface
currently rejects (the 0/4 one-shot Track A family in SFN-437 / PR #2519),
**without** changing the runtime's execution semantics, the six-future-kind ABI,
or the E0831 invalid-IR protection for the still-ambiguous un-annotated case.
This is a **typing/ergonomics** design, scoped deliberately to the same
pointer-width `T` ceiling the rest of the concurrency surface already lives
under; runtime fault propagation (cancel-on-fault) stays the property of the
concurrency-maturity SFEP (SFN-124, `draft-concurrency-cancellation.md`).

This proposal is the **design record for SFN-440** and **blocks SFN-441** (the
implementation leaf). It is **SFEP-0055** (registry maximum was 0054; SFEP-0001
§2 assigns `max + 1` at merge) and `Accepted` at the design gate (owner sign-off,
2026-07-22). It graduates to `Implemented` when SFN-441 clears the Stage1 bar
end-to-end and self-hosts.

## 2. Motivation

### 2.1 The gap, concretely

The program shape a structured-concurrency user reaches for first — fan out a
*dynamic* number of tasks, collect their handles, then await results in a
deterministic order — does not type-check today:

```sfn
// What a user writes (and what Track A generated). Rejected today.
fn fetch_all(ids: int[]) -> int[] ![io] {
    let mut handles = [];                       // inferred-empty: element kind unknown
    for id in ids {
        handles.push(spawn fn() -> int ![io] { return fetch(id); });   // E0831
    }
    let mut results: int[] = [];
    for h in handles { results.push(await h); }
    return results;
}
```

`handles.push(spawn ...)` raises **E0831**: the inferred-empty `[]` bakes the
array's LLVM element type as `double`, so a future pointer stored through a
`double` slot is bit-corrupted; SFN-386 rejects this rather than silently
miscompile (`typecheck_types.sfn:1215-1224`). The diagnostic's own remediation
is a pair of workarounds:

1. **Seed the array non-empty:** `let mut handles = [spawn fn() -> int { ... }];`
   — fixes the element type but forces an awkward "prime the pump" first task and
   does not fit a `for`-loop that spawns zero-or-more.
2. **`await` each handle at the spawn site** — collapses fan-out to sequential
   execution, defeating the point of spawning.

Both are documented and tested (`compiler/tests/e2e/spawn_empty_array_push_test.sfn`).
Neither expresses "spawn N, then await N in order," because **the array has no
element type a user can write**. That missing type is the whole of this SFEP's
motivation. `docs/status.md:469` names the parallel-side symptom directly:
`parallel [...]` ships but "**Typed result-array collection (`results[i]`)
pending**."

### 2.2 Who hits it, how often

SFN-437 / PR #2519 benchmarked Sailfin 0.8.0 GA against the v2.8 OpenAI Track A
corpus; the **structured-concurrency family was 0/4 one-shot** — every case
tripped the missing-handle-type gap and needed the seeding/immediate-await
workaround to compile. Structured concurrency is a marketed **pillar**
(`CLAUDE.md`), so a natural fan-out/await program failing to compile is a
first-order adoption defect for the exact users (LLMs generating idiomatic code)
the language optimizes for. The runtime is sound — `spawn`/`await` execute
correctly on the thread pool (`spawn_await_concurrent_execution_test.sfn`,
#1474); the defect is purely the absent *language surface*.

### 2.3 Why now, and why bounded

The generics foundation this needs is already `Implemented`: SFEP-0038 (generic
constraints + monomorphization) supports generic structs and functions over
**pointer-width `T`** (int/float/bool/string/ptr and pointer/boxed struct refs),
proven end-to-end by `examples/advanced/generic-structures.sfn` and
`generic_struct_monomorphization_test.sfn`. Every one of the six existing future
kinds is pointer-width, so a `Task<T>` restricted to that same ceiling needs **no
new generics substrate** — it fits inside the machinery that already ships. That
alignment is what makes this a bounded, single-leaf design rather than a wait on
the arbitrary-by-value-aggregate / generic-collections work
(`draft-generic-collections.md`, still `Draft`).

## 3. Design

### 3.1 `Task<T>` — a nominal, single-use, pointer-width handle

`Task<T>` is a **prelude-defined generic struct** (like `Result<T, E>` in
`runtime/prelude.sfn`), not a keyword — *libraries over keywords*
(`CLAUDE.md` design framework). It is a **phantom-typed newtype over the raw
opaque future pointer**: the runtime representation is exactly today's handle (a
pointer-width value returned by `sfn_spawn_<kind>_ctx`,
`runtime/sfn/concurrency/future.sfn`), and `T` exists for the compiler's
type/kind bookkeeping at **zero runtime cost**. Conceptually:

```sfn
// Prelude (illustrative shape; the field carries the opaque runtime handle).
struct Task<T> {
    handle: ptr,   // the sfn_spawn_<kind> future pointer; T is phantom
}
```

The changes that make it *writable*:

- **`spawn fn() -> T { ... }` has type `Task<T>`** instead of an untyped
  kind-tagged value. The future kind that the typecheck resolver already computes
  (`typecheck_types.sfn` `spawn_future_kind`, `typecheck.sfn` `check_spawn_kind`)
  becomes the `T` of the produced `Task<T>`. `T` is constrained to the six
  pointer-width kinds; a `spawn` whose body returns an arbitrary by-value
  aggregate is out of scope (same ceiling as today — see §3.7).
- **`let mut handles: Task<int>[] = []` is legal.** The array's element type is
  now the concrete pointer-width `Task<int>`, so the empty literal no longer
  defaults its element slot to `double`; pushed handles are stored through a
  pointer-width slot correctly. This removes the E0831 corruption precondition
  for annotated handle arrays (§3.5).
- **`await h` where `h: Task<T>` produces `T`.** The kind is read from the
  handle's static `Task<T>` type — exactly the mechanism `Channel<T>` already
  uses to bind the receive kind (`channel_typed_binding_test.sfn`, E0815,
  #1942), **not** the general expression-type inferencer that #829 tracks. An
  explicit `Task<T>` annotation is the frontend's source of truth for the kind,
  so this ships without the live inferencer, complementing the channel-receive
  half that landed in #1944.

### 3.2 Single-use (affine) ownership + movement

A future is joined exactly once by the runtime; the task and its result are
freed after the join. `Task<T>` therefore models that reality as an **affine,
single-use** handle, reusing the ownership floor already in the compiler
(`ownership_checker.sfn`, `Affine<T>` single-use `E0901`/`E0907`; epic #1209):

- Awaiting a handle — directly (`await h`) or via `join_all` — **consumes** it.
  A second await of the same handle is **use-after-move → E0834**
  (double-await). This is the concurrency-specific surfacing of the existing
  affine single-use rule.
- A handle is **movable** (into an array, as a `join_all` argument) but **not
  copyable**. Storing `spawn ...` into a `Task<T>[]` moves the handle into the
  array; `join_all` consumes the whole array.

### 3.3 Nursery lifetime

A `Task<T>` is valid only within the **dynamic extent in which its task was
spawned**. Storing handles in a `Task<T>[]` and awaiting/`join_all`-ing them
**within that extent** is the supported shape; letting a live handle **escape**
that extent (returning it, or storing it in a binding that outlives the
enclosing `routine { }` nursery) is rejected — **E0835**. This *extends* the
existing fail-closed rejection of non-local exit out of a `routine` body
(`instructions_routine.sfn:105-177`, `collect_routine_escape_diagnostics`): today
control flow may not escape a nursery; this SFEP adds that a *task handle* may not
outlive the scope that owns its task's lifetime. Handles spawned **outside** any
`routine { }` follow the ambient function scope, exactly as bare `spawn`/`await`
do today.

### 3.4 `join_all` — ordered multi-await

```sfn
// Standard-library generic fn (prelude / sfn/sync surface), pointer-width T.
fn join_all<T>(handles: Task<T>[]) -> T[]
```

Semantics, precisely specified for the three observable cardinalities the
acceptance criteria require:

- **Empty input (`[]`)** → returns `[]` immediately. No task is awaited; no
  runtime call is required. (This is the zero case that makes a `for`-loop that
  spawns *zero-or-more* well-defined.)
- **Singleton (`[h]`)** → returns `[await h]` — a one-element array.
- **Multiple (`[h0, h1, ... hn-1]`)** → returns `[r0, r1, ... rn-1]` where
  `ri` is the result of `hi`, in **input (index) order**, regardless of the
  order in which the tasks actually complete. The tasks were already running
  concurrently on the scheduler pool from their `spawn`; `join_all` imposes a
  deterministic *result* ordering over that concurrent execution — it does not
  serialize execution.

`join_all` **consumes** every handle in the array (§3.2). `T` is a value-producing
pointer-width kind; `Task<void>` is **excluded** from `join_all` (a `void[]` result
is meaningless — use the `routine { }` nursery's implicit join-all for
side-effecting void tasks). A `Task<T>[]` may hold only `Task<T>` handles of a
single `T`; a heterogeneous push (`Task<string>` into a `Task<int>[]`) is an
element-type mismatch — **E0836** (a concurrency-specific message; it otherwise
falls out of ordinary array homogeneity once the element type is a concrete
`Task<T>`).

Runtime lowering reuses the shape `parallel [...]` already has: the
order-preserving fan-out/join combinator `sfn_parallel(fn_ptrs, ctxs, count)`
(`runtime/sfn/concurrency/parallel.sfn`, order preservation proven by
`runtime_parallel_combinator_test.sfn`) is the direct precedent. `join_all` over
*already-spawned* handles lowers to a sibling combinator `sfn_join_all(handles,
count) -> results` that walks the handle array in index order, `sfn_await`-s
each, and writes results to the same index — the "typed result-array collection"
that `docs/status.md:469` records as pending, now delivered for the handle-array
case.

### 3.5 E0831 migration — open the annotated path, keep the fail-closed guard

This is the load-bearing correctness reconciliation. E0831 exists because an
**un-annotated** inferred-empty `[]` has a `double` element slot that corrupts a
pushed future pointer. `Task<T>` does not weaken that guard; it **removes the
precondition** for the annotated case and **narrows E0831 to exactly the case
that is still ambiguous**:

| Program | Before this SFEP | After |
|---|---|---|
| `let mut hs: Task<int>[] = []` then `hs.push(spawn ...)` | *impossible to write* (no handle type) | **legal** — element type is pointer-width `Task<int>`, no `double` slot, no corruption |
| `let mut hs = []` (un-annotated) then `hs.push(spawn ...)` | **E0831** | **E0831, unchanged** — still no element type, still corrupts, still fails closed |

The migration is therefore *additive and monotone*: annotate the array with
`Task<T>` to opt into the working path; the un-annotated shape keeps its
invalid-IR protection verbatim. The only change to E0831 is its **message**,
which gains the primary remediation ("annotate the array: `let mut hs:
Task<int>[] = []`") ahead of the two existing fallbacks (seed non-empty / await
directly). The `[fatal]` lowering backstop for any future→scalar-slot shape the
frontend rule does not enumerate (`spawn_empty_array_push_test.sfn:148-159`)
**stays** as defense-in-depth. **No invalid-IR protection is removed.**

### 3.6 Worked examples

```sfn
// The §2.1 program, now well-typed.
fn fetch_all(ids: int[]) -> int[] ![io] {
    let mut handles: Task<int>[] = [];               // writable handle type
    for id in ids {
        handles.push(spawn fn() -> int ![io] { return fetch(id); });
    }
    return join_all(handles);                        // input-ordered results
}

// Zero / one / many are all well-defined:
let a: int[] = join_all([]);                          // []           (empty)
let b: int[] = join_all([spawn fn() -> int { 41 }]);  // [41]         (singleton)
let c: int[] = join_all([                             // [1, 2, 3] in input order
    spawn fn() -> int { slow(1) },                    //   even if slow(1) finishes last
    spawn fn() -> int { 2 },
    spawn fn() -> int { 3 },
]);

// Ownership: a double-await is rejected.
let h = spawn fn() -> int { 7 };
let x = await h;
let y = await h;                                      // E0834: use-after-move (double-await)

// Lifetime: a handle may not escape its nursery.
fn leak() -> Task<int> ![io] {
    routine { return spawn fn() -> int { 1 }; }       // E0835: handle escapes nursery scope
}
```

### 3.7 Scope ceiling (stated to bound the implementation)

`T` is restricted to the **six pointer-width future kinds** the concurrency
surface already supports (`void` excluded from `join_all` per §3.4). An
arbitrary by-value aggregate `T` (a struct/enum whose size ≠ 8) is **out of
scope** — it depends on the by-value-aggregate layout and generic-collections
substrate that `draft-generic-collections.md` (still `Draft`) will land, and it
is out of scope for the whole concurrency surface today (`docs/status.md:453`).
When that substrate ships, `Task<T>`/`join_all` widen to it mechanically with no
redesign, because the phantom-newtype representation does not change. Keeping the
ceiling here is what lets this land as one M leaf now.

## 4. Effect & capability impact

- **No new effect.** `Task<T>` and `join_all` are a typing/scheduling surface;
  the canonical six effects are locked at 1.0 (`effect_taxonomy.sfn`, SFEP-0008).
- **`join_all` is effect-transparent (join-side).** `await` today contributes no
  effect of its own — it recurses into its operand (`effect_checker.sfn` ~1535,
  SFEP-0049 §3.1). `join_all` follows the identical join-side model: it
  contributes **nothing** of its own; the task bodies' effects were already
  attributed at their `spawn` sites (effect-transparently, SFEP-0049 — a pure
  body requires nothing, an `![io]` body still requires `![io]`). A `join_all`
  over pure-bodied tasks is pure. **The general join-side effect-propagation
  question** — whether a nursery/`join_all` should *aggregate* its children's
  effects at the join point — is explicitly the property of SFN-124
  (`draft-concurrency-cancellation.md`, the "join half" SFEP-0049 deferred), and
  this SFEP does not pre-empt it: v1 attribution matches `await`'s (no own
  effect).
- **Capability enforcement unchanged.** A task that does I/O still surfaces
  `![io]` via its body walk; `Task<T>`/`join_all` fabricate no capability
  requirement and remove none.

## 5. Self-hosting impact

**Passes touched** (narrow; no lexer change, no new syntax):

- **Parser — none.** `Task<T>` is an ordinary generic type annotation and
  `join_all(...)` an ordinary call; both already parse
  (`parser/expressions.sfn`, generic type annotations per SFEP-0038). `spawn`
  parsing is unchanged (`parser/expressions.sfn:601-735`).
- **AST — none structural.** `Task<T>` is a nominal type resolved through the
  normal type machinery, not a new node. The `Spawn`/`Await`/`Parallel` nodes and
  their `kind` tag stay (`ast.sfn:182-204`).
- **Prelude / stdlib.** Add the `Task<T>` struct to `runtime/prelude.sfn` and the
  `join_all<T>` surface (prelude or the `sfn/sync` capsule the concurrency
  constructs already anticipate, `docs/status.md:520`).
- **Typecheck (`typecheck.sfn`, `typecheck_types.sfn`).** `spawn` produces
  `Task<T>` (map the resolved future kind to `T`); `await` of a `Task<T>` yields
  `T`; `join_all(Task<T>[]) -> T[]`; the new **E0834** (double-await), **E0835**
  (nursery escape), **E0836** (heterogeneous handle array); the E0831 refinement
  (§3.5). E-codes E0834–E0836 are free (verified: no existing use;
  `docs/style-guide.md` E08xx table stops at E0833).
- **Ownership (`ownership_checker.sfn`).** `Task<T>` classified affine/single-use,
  reusing the `E0901`/`E0907` single-use floor (#1209); the E0835 escape check
  extends `collect_routine_escape_diagnostics` (`instructions_routine.sfn`).
- **Emit / LLVM lowering.** A `join_all` lowering arm mirroring the `parallel`
  result-array collection (`instructions_routine.sfn` / expression lowering),
  targeting a new runtime combinator `sfn_join_all` in
  `runtime/sfn/concurrency/parallel.sfn` (sibling to `sfn_parallel`). A builtin
  descriptor row for `join_all` in `llvm/runtime_helpers.sfn`, following the
  `spawn`/`parallel`/`channel` registry pattern (#1655).
- **Monomorphization.** `Task<T>` for pointer-width `T` is SFEP-0038 v1 scope; no
  new monomorphization capability.

**Additive / self-host-safe.** The compiler itself does not *use* `Task<T>` or
`join_all`; the new surface is exercised only by user/test code. So the pinned
seed compiles the new compiler, and that compiler compiles the consumer in the
same self-host pass.

**Seed-cut discipline (`.claude/rules/seed-dependency.md`).** `Task<T>`/`join_all`
are compiler-source capabilities (typecheck + lowering + prelude). Their only
consumer is the concurrency tests + user code, worked in the same session as
SFN-441 → **BUNDLE**: SFN-441 lands the type + `join_all` + diagnostics + tests +
docs in one PR. `make compile` builds the new compiler from the old seed, which
compiles the consumer in the same pass — **no seed cut, no `/pin-seed`**.

## 6. Alternatives considered

- **Do nothing (keep the opaque kind-tagged handle + E0831 workarounds).**
  Rejected: it permanently rejects the natural "spawn many, await in order"
  shape, which is a documented adoption defect in a pillar (SFN-437, 0/4).
- **General `Task<T>` over arbitrary by-value `T`.** Rejected *now*: needs the
  by-value-aggregate layout + generic-collections substrate
  (`draft-generic-collections.md`, `Draft`). The pointer-width ceiling matches
  the entire existing concurrency surface and ships without new generics work;
  the design widens mechanically when that substrate lands (§3.7).
- **Name it `Future<T>` (or `JoinHandle<T>`).** Rejected in favor of `Task<T>`:
  it matches the runtime's own `struct Task` (`scheduler.sfn:91-99`) and the
  structured-concurrency vocabulary (`routine`/nursery), and it is the boring,
  LLM-legible choice. `Future<T>` connotes the Rust poll-model; `JoinHandle<T>`
  is a std-thread borrowing that carries no upside here.
- **Array-await syntax (`await [h1, h2]`, or awaiting an array directly).**
  Rejected: it overloads `await` on arrays with new special-case semantics. A
  named `join_all` function is a library (no keyword), makes ordering explicit in
  its name, and composes with ordinary array values — *libraries over keywords*.
- **Bake cancel-on-fault / first-fault rethrow into `join_all` now.** Rejected:
  child-fault propagation is entangled with cancellation-scope semantics, the
  `Task`/`Nursery` fault-slot layout, and cooperative checkpoints — the whole
  subject of SFN-124 (`draft-concurrency-cancellation.md`). Folding it in here
  would turn a bounded typing change into a runtime-semantics change and
  duplicate SFN-124's design. §7 states the deferral precisely.
- **A `handles` keyword or a magic array element type.** Rejected: a prelude
  generic struct reuses shipped machinery (SFEP-0038) and adds no keyword that
  could never become a variable name.

## 7. Child-failure behavior and the SFN-124 boundary

The acceptance criteria require `join_all`'s child-failure behavior to be
specified. It is specified as **exactly today's nursery behavior in v1, with a
normative forward-reference to SFN-124**, so this SFEP remains a typing change:

- **Today**, a child that throws is invisible to the join: its trampoline
  discards the body's error and the task is joined as if clean
  (`draft-concurrency-cancellation.md` §2, `future.sfn` trampolines;
  `docs/status.md:465` "v0: join-all (no cancel-on-fault)"). `join_all`
  **inherits this unchanged** — it awaits every handle in order and returns
  results; it introduces **no** new fault semantics and **no** cancellation.
- **SFN-124** (`draft-concurrency-cancellation.md`, Phase 1) adds cancel-on-fault:
  a faulting child cancels its siblings and the scope rethrows the first fault.
  `join_all` is **designed to slot into that**: each per-handle `await` inside
  `sfn_join_all` is a cancellation checkpoint (the same `await` checkpoint
  SFN-124 §3 defines), so when SFN-124 lands, `join_all` participates in
  cancel-on-fault and first-fault propagation **automatically**, with no
  `join_all` redesign. This SFEP neither implements nor blocks that; it only
  guarantees the surface is compatible with it.

This boundary keeps SFN-440/441 aligned with the issue's framing: *"Existing
`spawn`/`await` execution remains sound; this issue is language/API design, not a
confirmed runtime defect."*

## 8. Stage1 readiness mapping

Tracked for the **implementation** (SFN-441); this SFEP is the design that
precedes it. All boxes are unchecked here and become SFN-441's exit gate.

- [ ] **Parses** — no new syntax; `Task<T>` annotation and `join_all(...)` call
      already parse.
- [ ] **Type-checks / effect-checks** — `spawn: Task<T>`, `await Task<T> -> T`,
      `join_all(Task<T>[]) -> T[]`, E0834/E0835/E0836, E0831 refinement;
      `join_all` effect-transparent.
- [ ] **Emits valid `.sfn-asm`** — `join_all` emission mirroring `parallel`.
- [ ] **Lowers to LLVM IR** — `sfn_join_all` combinator + builtin descriptor;
      handle arrays lower through a pointer-width element slot.
- [ ] **Regression coverage** — §9; all existing concurrency tests stay green;
      E0831 still fires for the un-annotated case.
- [ ] **Self-hosts** — additive; old seed compiles new compiler; bundle with
      consumer (no seed cut).
- [ ] **`sfn fmt --check` clean** — every touched `.sfn`.
- [ ] **Documented in `docs/status.md` + spec** — SFN-441 flips the `spawn`/
      `await` (line 468) and `parallel` (line 469) rows and the concurrency
      preview chapter to describe `Task<T>`/`join_all`; adds E0834–E0836.

## 9. Test plan

Regression coverage SFN-441 must add (`compiler/tests/{unit,integration,e2e}/`),
alongside keeping the existing structured-concurrency suite green:

- **Parse/typecheck:** `let mut hs: Task<int>[] = []` binds a pointer-width
  handle-array element type; `spawn fn() -> int {...}` has type `Task<int>`;
  `await h` (h: `Task<int>`) yields `int`; `join_all(Task<int>[]) -> int[]`.
  (Unit, extending `concurrency_typecheck_test.sfn`.)
- **Ordered execution (the crux):** `join_all` over three tasks that complete
  **out of order** returns results in **input order** (extends
  `parallel_concurrent_execution_test.sfn` / `runtime_parallel_combinator_test.sfn`
  order-preservation). Empty → `[]`; singleton → one element (e2e exec).
- **E0831 migration:** the annotated `Task<int>[]` push path builds and runs
  (retarget the "seeded-handle-array" case in
  `spawn_empty_array_push_test.sfn`); the **un-annotated** `let mut hs = []` push
  still fails closed with E0831 (unchanged); the `[fatal]` lowering backstop still
  fires on the unenumerated future→scalar shape.
- **Ownership:** double-await (`await h; await h;`) → **E0834**; a handle escaping
  a `routine { }` → **E0835**; a heterogeneous handle-array push → **E0836**
  (unit `does_not_compile` negatives).
- **Effect:** `join_all` over pure-bodied tasks requires no effect; over an
  `![io]`-bodied task, `io` is required (from the body, at spawn) — a
  `concurrency_effect_test.sfn` positive/negative pair.
- **Self-host:** `make compile` from the pinned seed, then `make check` (the
  concurrency surface is compiler + runtime).

## 10. Implementation split and blocker graph

- **SFN-440** (this SFEP) — design record. Blocks **SFN-441**.
- **SFN-441** (estimate 3 / M) — the implementation leaf: `Task<T>` prelude type +
  `spawn: Task<T>` typing + `await`/`join_all` + `sfn_join_all` combinator +
  E0831 refinement + E0834/E0835/E0836 + tests + docs. **Assessment: this remains
  a single M leaf.** The ownership diagnostics reuse the shipped affine single-use
  floor (`E0901`/`E0907`, #1209) and the existing non-local-exit escape machinery
  (`collect_routine_escape_diagnostics`), so they are incremental, not a new
  subsystem; the `join_all` combinator reuses the `sfn_parallel` shape. No further
  split is required. **Contingency:** if, at pickup, the ownership diagnostics
  (E0834/E0835) prove larger than a bounded reuse of the affine floor, split them
  into a follow-up leaf (typed handles + `join_all` land first; the diagnostics
  harden second) and record the new blocker in Linear — do not silently grow
  SFN-441.

## 11. References

- **SFN-440** — this design issue. **SFN-441** — the implementation leaf it blocks.
- **SFN-386** (`typecheck_types.sfn:1215-1233`, `typecheck.sfn:1997-2007`) — the
  E0831 fail-closed rule this SFEP migrates without weakening;
  `compiler/tests/e2e/spawn_empty_array_push_test.sfn` is its regression suite.
- **SFN-437 / PR #2519** — the clean 0.8.0 GA benchmark where the
  structured-concurrency family was 0/4 one-shot; the motivating evidence.
- **SFN-439** — successor benchmark corpus (related; out of scope here).
- **SFEP-0038** (`0038-generic-constraints.md`, Implemented) — the generic
  constraints + monomorphization foundation; the pointer-width `T` ceiling.
- **`draft-generic-collections.md`** (Draft) — by-value-aggregate + generic
  collections; the substrate that later widens `Task<T>` beyond pointer-width.
- **SFEP-0049** (`0049-concurrency-effect-transparency.md`, Implemented) — the
  leaf effect-transparency model `join_all` follows on the join side.
- **SFN-124 / `draft-concurrency-cancellation.md`** — cancel-on-fault + async
  I/O; the home for `join_all`'s child-failure/cancellation semantics (§7).
- **#829** — the live expression-type inferencer (not required here; `Task<T>`
  binds the kind via annotation, as `Channel<T>` does).
- **#1655** — the runtime-descriptor registry (`llvm/runtime_helpers.sfn`) the
  `join_all` builtin row follows.
- `compiler/src/ast.sfn:182-204` — `Spawn`/`Await`/`Parallel`/`Channel` nodes and
  the `kind` tag.
- `runtime/sfn/concurrency/{future,scheduler,nursery,parallel}.sfn` — the v0
  runtime surface (`sfn_spawn_<kind>`, `struct Task`, nursery join-all,
  `sfn_parallel`) `Task<T>`/`join_all` build over.
- `docs/status.md:465-469` — the documented concurrency contract SFN-441 updates.
- `docs/style-guide.md` (E08xx table) — the diagnostic-code range; E0834–E0836
  reserved by this SFEP.
