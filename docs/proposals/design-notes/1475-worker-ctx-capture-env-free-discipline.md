# #1475 — worker-ctx capture-env move/free discipline (ASAN-gated)

Design doc for the design gate. **Design only — no edits made.** Epic #1466,
follows #1474 (DONE: spawn/await + `parallel [...]` execute concurrently on the
pool). Successor: #1476 (OwnedBuf/string-buffer capture ABI).

---

## 1. Goal

A spawned worker takes ownership of the heap environment backing a capturing
task lambda and frees it **exactly once** after the task body runs — no
double-free, no leak — on both spawn paths (`sfn_spawn_<kind>_ctx` trampoline
and `sfn_parallel` direct), with the sender's binding statically `Moved`
(#1220). Verified by an ASAN-interleave gate over N concurrent capturing tasks.

---

## 2. Current state (file:line, verified this pass)

### Capture env allocation — capturing non-spawn lambdas (works)
- `compiler/src/llvm/closures.sfn:425` `emit_closure_env_alloc`: GEP-sizeof on a
  null base (`:450`) → `ptrtoint` (`:456`) → **`call noalias i8* @sfn_alloc_struct(i64 %size)`**
  (`:461`) → bitcast to `%sfn_closure_env_<N>*` (`:467`) → per-field GEP+store.
  Layout from `synthesize_closure_env_struct` (`:334`); strings are stored as the
  `i8*` data-pointer container only — the length word is shed
  (`closure_field_llvm_type` `:325`).
- `runtime/sfn/memory/mem.sfn:240` `sfn_alloc_struct`: **arena-routed when
  `sfn_arena_enabled()`** (`:249`, the shipped default), else libc `calloc`
  (`:254`). **This is the symmetry landmine** — see §3.
- `compiler/src/llvm/closures.sfn:527` `emit_closure_env_load_prologue`: the
  lifted body reads its env via the hidden first param `__env: i8*`, bitcast +
  GEP + load per field. **It does not free the env.** Nobody frees the env today
  for any lambda — synchronous capturing lambdas leak it (out of #1475 scope;
  the env there is short-lived and arena-reclaimed).

### Spawn / parallel lowering (`compiler/src/llvm/expression_lowering/native/core.sfn`)
- `spawn:<kind>` (`:1144`): if the operand lowers to `{i8*, i8*}`
  (`:1209`), `extractvalue` slot0 = fn (`:1212`), slot1 = env (`:1217`) →
  `call i8* @sfn_spawn_<kind>_ctx(i8* fn, i8* env)` (`:1222`). Non-capturing env
  = null; capturing env = heap ptr. The 1480-comment defers env ownership here.
- `parallel [tasks]` (`:1485`): per task, `{i8*, i8*}` → `extractvalue` →
  `ptrtoint` fn (`:1527`) and env (`:1531`) into two `[N x i64]` stack arrays →
  `sfn_parallel(fns_i8, ctxs_i8, N)` (`:1639` onward).

### `_ctx` trampolines (`runtime/sfn/concurrency/future.sfn`)
- Six families. Canonical `_sfn_trampoline_int_ctx` (`:223`): `ctx` IS a 16-byte
  pair `[fn_ptr][user_ctx]`; loads both, calls `fn_ptr(user_ctx)`, then
  **`free(ctx)` — frees the PAIR only; the env behind `user_ctx` LEAKS.**
- Packers `sfn_spawn_<kind>_ctx` (e.g. `:240`): `malloc(16)`, store
  `[fn_ptr][env]`, `sfn_spawn(trampoline, pair, sz)`.

### `sfn_parallel` (`runtime/sfn/concurrency/parallel.sfn:83`)
- **Bypasses the pair**: `sfn_spawn(fn_addr, ctx_val, 8)` (`:132`) with env as a
  raw i64 `Task.ctx`. `sfn_task_run` (`runtime/sfn/concurrency/scheduler.sfn:585`)
  calls `Task.fn_ptr(Task.ctx)` directly (`:591`). **No pair, no free** — env leaks.

### Task / worker ABI (`scheduler.sfn`)
- `Task` (`:113`): `{fn_ptr:i64, ctx:i64, result:i64, done:i64, cond(48), mutex(64)}`.
- `sfn_task_run` (`:585`): `result = fn_ptr(ctx)`; then under `mutex` stores
  `t.result = result as i64` (`:604`), sets atomic `done` (`:605`), signals.
- `sfn_task_join` (`:617`): waits `done`, reads `t.result` (`:634`), returns.
  **The result is an i64 VALUE copy** — `sfn_task_run` already snapshots it into
  the Task before any free could run. The joiner never re-reads the env.

### Static move (#1220)
- `ownership_checker.sfn:465` `_consume_spawn_captures`: reuses `analyze_lambda`
  to get free vars, `_consume_identifier` marks each `Moved`. Fires on
  `Spawn.Lambda` (`:943`) and `Parallel.Lambda` (`:964`). No-op for
  non-capturing lambdas (empty free set).

### Self-host check
- The compiler source contains only the spawn/parallel **implementation**
  (parser/typecheck/lowering/runtime). It never **uses** `spawn`/`await`/
  `parallel` in its own logic (grep confirmed). **No seed-cut gate** for #1475.

### Test surface
- `compiler/tests/e2e/escape_promotion_channel_send_test.sfn` is the only ASAN
  template (build `-fsanitize=address`; skip if it can't start; fail only on
  `ERROR: AddressSanitizer:`). `closure_capture_test.sfn` proves synchronous
  capture. **No spawn/parallel test exercises a capturing lambda** — the leak is
  untested.

---

## 3. Constraints

1. **Allocator/free symmetry (the #1205-class landmine).** The env is
   `sfn_alloc_struct`'d, which is **arena-routed under the default arena mode**.
   Handing an arena pointer to libc `free` corrupts glibc chunk metadata
   (`sfn_mem_free` itself no-ops under arena precisely to avoid this —
   `mem.sfn:187`). So the trampoline's existing `free(ctx)` on a 16-byte
   `malloc`'d pair is *correct for the pair* but **must never be aimed at an
   arena-routed env.** Any free path for the env must match its alloc path
   byte-for-byte regardless of arena mode.
2. **Exactly-once across two structurally different paths.** The pair path
   (`_ctx` trampolines) and the raw-ctx path (`sfn_parallel`) reach the worker
   differently. The free must be exactly-once on each without a shared owner.
3. **Worker-frees-before-join is safe only because the result is a value.**
   `sfn_task_run` snapshots `result` into `Task.result` (an i64) before the
   trampoline returns; the joiner reads the snapshot. A pointer result that
   *aliases into the env* would be a use-after-free — see §6 (the string caveat).
4. **No new IR-width hazards.** All env/ctx values already travel as i64/`i8*`;
   the design must not introduce an aggregate-through-i64 truncation.
5. **Self-host green at every increment** (`make compile`), full gate at the end
   (`make check`).

---

## 4. Design

### 4.1 Free-discipline decision (the core ABI call)

**Decision: a dedicated, malloc-backed `sfn_env_alloc` / `sfn_env_free` pair,
owned by the env; the worker frees the env exactly once after the body runs,
inside the trampoline (pair path) and inside a thin worker-side wrapper
(parallel path).**

Rationale, point by point:

**(a) Dedicated allocator, NOT `sfn_alloc_struct` + libc `free`.**
Reusing `sfn_alloc_struct` for the capture env means the block is arena-routed
under the default, and there is **no matching free** — `sfn_mem_free` no-ops
under arena, so a captured env allocated this way is *unfreeable without leaking*
and a libc `free` on it corrupts the heap. We therefore introduce:

```
// runtime/sfn/memory/mem.sfn (new, malloc-backed, arena-independent)
fn sfn_env_alloc(size_bytes: i64) -> * u8   // calloc(1, size); OOM-abort like sfn_alloc_struct
fn sfn_env_free(ptr: * u8) -> void          // null-safe libc free, NO arena gate
```

`sfn_env_alloc` is *unconditionally* `calloc` (never the arena) so its block is
*always* a libc-owned, individually-freeable allocation — `sfn_env_free` is then
an unconditional libc `free` with a null guard. Alloc and free are symmetric and
arena-mode-independent by construction. This sidesteps the landmine structurally
rather than threading an arena-mode flag through the worker.

> Why not "free into the arena"? The capture env outlives the spawning frame and
> is owned by a *worker on another thread*; arena bulk-reclaim has no per-object
> free and no cross-thread ownership story. A per-object malloc/free is the only
> correct lifetime for a moved, thread-crossing env.

**(b) Emission switches the env alloc symbol for the *spawn/parallel* path only.**
`emit_closure_env_alloc` (`closures.sfn:461`) currently always emits
`@sfn_alloc_struct`. Capturing lambdas that are **spawned** must instead allocate
through `@sfn_env_alloc` so the worker can free with `@sfn_env_free`. Synchronous
capturing lambdas keep `@sfn_alloc_struct` (arena-reclaimed, never freed — status
quo, out of scope). This requires the closure-pair build to know whether the
lambda is a spawn target. Two viable wiring options:

- **Option A (preferred): tag the env-alloc call at the closure-pair site.**
  The lifting marker already distinguishes a closure pair; the *spawn/parallel
  lowering arm* is the only consumer that routes a `{i8*, i8*}` operand to a
  `_ctx`/parallel call. Thread a boolean `spawn_owned` into
  `emit_closure_env_alloc` (default false → `sfn_alloc_struct`; true →
  `sfn_env_alloc`) and set it true when the closure pair is built for a
  spawn/parallel operand. Concretely, the marker the lambda-lowering emits for a
  spawn-target closure (`<closure_pair ... env_alloc ...>`) gains an
  `owned_env=1` attribute that `emit_closure_env_alloc`'s caller reads.
- **Option B (fallback): always allocate spawnable envs with `sfn_env_alloc`.**
  Simpler but makes *every* capturing lambda's env malloc-backed (loses arena
  fast-path for synchronous closures). Acceptable as a stopgap if the marker
  plumbing in Option A proves invasive, but A is the right end state. **Recommend
  A**; if the closure-pair marker cannot cheaply carry the flag in increment 2,
  ship B and tighten to A in a follow-up — both are free-correct.

**(c) Who frees, and when — both paths, exactly once, after the body.**

- **Pair path (`_ctx` trampolines).** Today the trampoline frees only the 16-byte
  pair. Change each `_sfn_trampoline_<kind>_ctx` to **also** free the env:
  ```
  let user_ctx = atomic_load(ctx_slot);   // the env ptr
  let val = entry(user_ctx as * u8);       // run body — snapshots result by value
  sfn_env_free(user_ctx as * u8);          // NEW: free the moved env exactly once
  free(ctx);                               // free the 16-byte pair (unchanged)
  return packed;
  ```
  A **null `user_ctx` is the non-capturing case** — `sfn_env_free` is null-safe,
  so non-capturing spawns are unaffected (free(null) = no-op). Exactly-once: the
  trampoline runs once per task; the env is reachable only through this `user_ctx`.

- **Parallel path (`sfn_parallel`).** `sfn_parallel` passes the env as the raw
  `Task.ctx` and `sfn_task_run` calls `fn_ptr(ctx)` directly — there is **no
  trampoline** to host the free. Rather than special-case `sfn_task_run` (which
  must stay env-agnostic — it also runs non-capturing and channel tasks), wrap
  each parallel task in the **same pair+trampoline mechanism the spawn path uses**.
  See §4.2 — unifying onto the pair path is the clean fix and gives parallel the
  env-free for free.

**(d) Free before or after the joiner reads?** **Before.** `sfn_task_run`
snapshots the worker's return value into `Task.result` (an i64) *before* the
trampoline returns (`scheduler.sfn:604` happens-after `entry()` returns at
`:592`). The env free happens inside the trampoline, between `entry()` returning
and the trampoline returning — i.e. strictly before `sfn_task_run` publishes
`done`. The joiner only ever reads the i64 snapshot, never the env. So
worker-frees-before-publish is sound **for value results**. (Fire-and-forget
spawns that are never awaited are likewise fine — the worker still frees the env;
nothing else references it.) The one exception — a pointer result aliasing into
the env — is the §6 string caveat and is excluded from #1475 by the move rule
plus a documented boundary.

**Double-free / leak argument (#1205).** The env has exactly one owner at any
time: the spawning frame holds it until the closure pair is built, at which point
#1220 marks the sender binding `Moved` (no further sender access compiles). The
env address then lives only inside the pair's `user_ctx` slot (or, post-§4.2, the
parallel pair). The worker is the sole reader of that slot and frees it once. No
other code path holds the address ⇒ no double-free. The worker always frees ⇒ no
leak. Symmetric `sfn_env_alloc`/`sfn_env_free` ⇒ no allocator mismatch.

### 4.2 Path unification

**Decision: route `sfn_parallel` tasks through the pair+trampoline path, so a
single free site (the trampoline) covers both surfaces.**

Today `parallel` lowering (`core.sfn:1485`) ptrtoints the lifted fn and env into
`[N x i64]` arrays and calls `sfn_parallel`, which `sfn_spawn`s each fn with the
env as the raw ctx (no pair, no free). To unify:

- **Lowering (`core.sfn` parallel arm):** for a `{i8*, i8*}` task, instead of
  passing `(lifted_fn_addr, env_addr)`, pass `(trampoline_addr, env_addr)` where
  `trampoline_addr` is the same `_sfn_trampoline_<kind>_ctx` the spawn arm uses —
  **but** the pair allocation must happen somewhere. Cleanest: keep the parallel
  ABI `(fns[], ctxs[], N)` and have **`sfn_parallel` build the 16-byte pair per
  task** before `sfn_spawn`, exactly as `sfn_spawn_<kind>_ctx` does, when the
  task is a capturing one.

  Because `sfn_parallel` is type-agnostic (it stores raw `i8*` results), it can
  use the **`_ptr` trampoline uniformly**: a parallel worker's result is already
  treated as a raw `i8*`-as-i64 by the join loop (`parallel.sfn:161`). So:
  - The parallel lowering passes `fns[i] = ptrtoint(_sfn_trampoline_ptr_ctx)` and
    a **per-task pair pointer** as `ctxs[i]`, OR
  - `sfn_parallel` itself wraps: for each task, `malloc(16)` a pair
    `[lifted_fn][env]`, spawn `_sfn_trampoline_ptr_ctx` with the pair. The
    trampoline frees env + pair. The join is unchanged.

  **Recommend the runtime-side wrap inside `sfn_parallel`** (the second form): it
  keeps the parallel lowering's `(fns, ctxs, N)` ABI intact (`fns[i]` = the
  lifted worker addr, `ctxs[i]` = env addr or 0), and confines the pair/free
  mechanics to one place. `sfn_parallel` gains: for each task with a non-zero
  ctx, allocate a pair, store `[fn_addr][ctx]`, and spawn
  `_sfn_trampoline_ptr_ctx` with the pair; for a zero ctx, spawn the fn directly
  (current behavior — non-capturing). This needs **no lowering change** beyond
  what #1474 already emits, and reuses the existing `_sfn_trampoline_ptr_ctx`
  free path (which §4.1c extends to free the env).

  > Trade-off: this makes every *capturing* parallel task allocate a 16-byte pair
  > on the producer thread. Widths are tiny (fan-out is small); the cost is in the
  > noise and buys a single free site.

- **Runtime fns that change:** `future.sfn` six `_sfn_trampoline_<kind>_ctx`
  (add `sfn_env_free(user_ctx)`); `parallel.sfn` `sfn_parallel` (pair-wrap
  capturing tasks through `_sfn_trampoline_ptr_ctx`); `mem.sfn`
  (`sfn_env_alloc`/`sfn_env_free`).

  > Note: `_sfn_trampoline_ptr_ctx` reuse for parallel requires the lifted
  > parallel worker to be `fn(i8*) -> i8*`-shaped. Lifted lambda workers already
  > take `__env: i8*` and return the kind's LLVM type; for the `ptr`/`void`/`int`
  > kinds the return packs into i64 as the existing typed trampolines do. If a
  > parallel task's lifted return is non-pointer (e.g. `int`), the `_ptr`
  > trampoline still works because the result is reinterpreted by the typed
  > `await_*` at the join site — *but the parallel join is type-erased*, so the
  > caller's downstream reinterpret must match. This already holds in #1474's
  > parallel result handling; confirm in increment 4's IR test that the
  > reinterpret is unchanged.

### 4.3 Sender-side move verification (#1220 on a *capturing* spawn)

`_consume_spawn_captures` (`ownership_checker.sfn:465`) already fires on
`Spawn.Lambda` / `Parallel.Lambda`, but the AC calls out that this is **untested
for a real capturing spawn** (the synchronous `closure_capture_test.sfn` doesn't
exercise spawn). The risk: the free vars surfaced by `analyze_lambda` for a
*spawned* lambda might differ from the captures the env actually allocates (e.g.
a name that is captured-by-env but not flagged free, or vice-versa) — a mismatch
would either leave a sender binding usable after move (unsound) or over-consume.

**This is a real gap to close with tests, not new code** (the wiring exists):
add unit coverage in `ownership_checker`/spawn that asserts E0901 fires on reuse
of a binding captured by a `spawn`/`parallel` lambda, for the same capture shapes
the env layout supports (a `let`-bound owned local; an owned local captured into
a `parallel [...]` task). If a shape compiles where reuse should be rejected, that
is a real #1220 gap surfaced by #1475 and is fixed there (extend
`_consume_spawn_captures` to align with the env capture set), but the expectation
is the existing walk already covers it — the test is the deliverable.

### 4.4 String / aggregate capture caveat — **boundary recommendation**

The env stores a captured `string` as the `i8*` **data pointer only**, dropping
the length word (`closure_field_llvm_type` `closures.sfn:325`). Two distinct
concerns:

1. **Does freeing the env free the string's backing buffer?** No, and it must
   not. `sfn_env_free` frees the **env struct** (the array of field slots),
   not the buffers those `i8*` fields point at. A captured string's backing
   bytes are a *separate* allocation (arena-owned or rc-managed) whose lifetime
   is governed by the existing string/drop machinery, not by the env. So
   `sfn_env_free` correctly releases only the env container — no double-free of
   string bytes.

2. **Does the worker's *result* alias into a captured string buffer?** This is
   the only soundness-relevant interaction. If a worker returns a string it
   *built from* a captured buffer that the env free (or the sender's drop) would
   release, the value-snapshot-then-free reasoning (§4.1d) breaks. **This is
   exactly #1476's OwnedBuf/string-buffer capture ABI.**

**Recommended boundary:** #1475 owns the **env-container** lifetime (the struct
allocated by `sfn_env_alloc`, freed by `sfn_env_free`) for **value-typed and
pointer-identity captures** where the result does not alias captured heap. The
**owned-string / OwnedBuf capture lifetime** (length-carrying buffers,
cross-thread buffer ownership transfer, result-aliases-capture) is **deferred to
#1476**. #1475's tests therefore capture **int/bool/value** fields (and a bare
`i8*` identity capture) — *not* an owned string whose buffer crosses the thread
boundary. Document this boundary in the env-alloc comment and the #1476 issue so
the string-buffer ABI lands knowing the container free is already in place.

---

## 5. Staging — committed, self-host-green ≤M increments (ordered)

Each increment self-hosts (`make compile`) on its own; the gate (`make check`)
runs at the end. No seed cut anywhere (compiler never spawns).

**Increment 1 (S) — env allocator/free pair + unit coverage.**
`runtime/sfn/memory/mem.sfn`: add `sfn_env_alloc` (unconditional `calloc`,
OOM-abort mirroring `sfn_alloc_struct`) and `sfn_env_free` (null-safe libc
`free`, no arena gate). No emission change yet — pure runtime addition; nothing
calls them, so it is inert and trivially self-hosts. Unit/round-trip test that
alloc+free balances under ASAN in isolation.

**Increment 2 (M) — spawn path frees the env.**
(a) Emission: route the *spawn-target* capture env through `@sfn_env_alloc`
(Option A flag on the closure-pair marker; Option B if A is too invasive) in
`closures.sfn` + the closure-pair lowering. (b) Runtime: extend the six
`_sfn_trampoline_<kind>_ctx` in `future.sfn` to `sfn_env_free(user_ctx)` before
`free(ctx)`. Self-host. IR test: a capturing `spawn:int` task emits
`@sfn_env_alloc` for its env and the trampoline path is taken.

**Increment 3 (M) — parallel path frees the env (unification).**
`parallel.sfn`: `sfn_parallel` pair-wraps capturing tasks through
`_sfn_trampoline_ptr_ctx` (non-capturing tasks unchanged). Confirm parallel join
result reinterpret is unchanged. Self-host. IR/runtime test: a capturing
`parallel [...]` task frees its env.

**Increment 4 (S) — sender-side move tests (#1220 on real captures).**
Unit tests asserting E0901 on reuse-after-spawn and reuse-after-parallel for a
capturing lambda. Close the §4.3 gap if a test surfaces one.

**Increment 5 (S) — ASAN-interleave e2e gate + status/spec.**
The N-task ASAN test (§6); `docs/status.md` + concurrency spec note; `sfn fmt`.

> Increments 2+3 could bundle if reviewer prefers a single "both paths" PR; they
> are split here only because the parallel unification (3) is independently
> testable and isolates the §4.2 trade-off. Keep them separate unless review
> pressure favors one M.

---

## 6. ASAN-interleave gate test design

New `compiler/tests/e2e/spawn_capture_env_free_test.sfn`, templated on
`escape_promotion_channel_send_test.sfn` (reuse `_sfn_bin`, `_child_env`,
`_scratch_dir`, `_asan_env`, the build-then-`-fsanitize=address`-then-run ladder,
and the **only-`ERROR: AddressSanitizer:`-fails / startup-abort-skips** verdict).

**Fixture (`.sfn`):** a `main` that spawns N (=16) capturing tasks, each
capturing a distinct owned **value** local (int), and joins all. Two shapes,
one per path:
- `spawn:int` in a loop, collecting futures, awaiting each (exercises the
  `_ctx` trampoline free).
- a `parallel [...]` of capturing tasks (exercises the `sfn_parallel` wrap free).

Each task body returns a value derived from its captured int (so the worker
result is a value, never an env alias — staying inside the §4.4 boundary). The
test asserts the joined results equal the expected per-task values (correctness)
**and** runs the binary under ASAN+LSAN.

**Leak-check (balanced alloc/free):** link/run with
`ASAN_OPTIONS=detect_leaks=1` (override the channel test's `detect_leaks=0`,
since the *point* here is that the env is freed). A leaked env surfaces as a
LeakSanitizer report; an interleaved double-free surfaces as
`ERROR: AddressSanitizer: ... double-free`. Both contain `ERROR: AddressSanitizer:`
/ `ERROR: LeakSanitizer:` → **fail only on those lines**.

**Skip discipline (unchanged from the template):**
- ASAN build fails → skip (`assert true; return`).
- Run exits non-zero **with** an `ERROR: AddressSanitizer:` / `ERROR: LeakSanitizer:`
  line → `assert false`.
- Any other non-zero exit (shadow reservation aborting under a vmem cap, missing
  compiler-rt) → skip.
- Child env: `SAILFIN_MEM_LIMIT=unlimited` (`_asan_env`) so the ~16 TB shadow
  reservation isn't aborted by the self-cap; the gate also needs an uncapped
  shell (`ulimit -v unlimited`) per `.claude/rules/compiler-safety.md`.

The plain (non-ASAN) leg still runs unconditionally and asserts result
correctness, so coverage exists even where ASAN can't start.

> Because this builds a binary inside the parallel pool, thread
> `SAILFIN_TEST_SCRATCH` + `PATH` + `HOME` + `TMPDIR` via `_child_env` (the
> template already does) so the nested `program.ll` build-cache doesn't collide
> (#1333) and clang's linker resolves.

---

## 7. Risks / self-host hazards

- **No seed-cut gate.** The compiler never uses `spawn`/`await`/`parallel`
  (grep-confirmed; matches are all implementation). New runtime fns and emission
  flags are inert until a *user* program spawns a capturing lambda. `make compile`
  from the current seed builds the new compiler, which compiles the new runtime
  in the same pass. Call out: **no `/pin-seed` needed between any increment.**
- **Allocator mismatch (the landmine) — mitigated by design.** Using
  `sfn_env_alloc` (unconditional `calloc`) for spawnable envs makes free
  arena-independent. The hazard reappears only if increment 2's emission change
  *misses a spawn-target site* and leaves it on `sfn_alloc_struct` — then the
  trampoline's `sfn_env_free` libc-frees an arena pointer. **Detect:** the ASAN
  gate's double-free/corruption signal fires immediately under arena mode (the
  default). Add an IR assertion that a spawned capturing env emits `@sfn_env_alloc`
  (not `@sfn_alloc_struct`) so the miss is caught at emit time, not only at ASAN.
- **IR-width / ABI pitfalls.** Env and pair values travel as `i8*`/i64
  throughout; the design adds no aggregate-through-i64 path. The one width
  subtlety is the parallel `_ptr` trampoline reinterpreting non-pointer results —
  unchanged from #1474, but pin it with the increment-3 IR test.
- **Non-capturing regression.** `sfn_env_free(null)` must be a no-op (null guard)
  so the existing non-capturing `_ctx` and direct `sfn_parallel` tasks (env = 0)
  are untouched. Covered by keeping the null guard and by the plain non-capturing
  spawn tests already in the suite.
- **String-buffer aliasing out of scope.** If a #1475 test accidentally captures
  an owned string whose buffer the worker returns, it would expose the #1476 gap
  as a false #1475 failure. **Mitigate:** the gate fixture captures values only
  (§6); the boundary is documented (§4.4).
- **Synchronous capturing-lambda leak unchanged.** #1475 does not free the env
  of a *non-spawned* capturing lambda (still arena-reclaimed). That is the status
  quo and out of scope; note it so a future LSAN sweep over synchronous closures
  doesn't read it as a #1475 regression.

---

## 8. Files affected (by stage)

**Runtime (Sailfin):**
- `runtime/sfn/memory/mem.sfn` — add `sfn_env_alloc` / `sfn_env_free` (inc. 1).
- `runtime/sfn/concurrency/future.sfn` — six `_sfn_trampoline_<kind>_ctx` free
  the env (inc. 2).
- `runtime/sfn/concurrency/parallel.sfn` — `sfn_parallel` pair-wraps capturing
  tasks through `_sfn_trampoline_ptr_ctx` (inc. 3).

**Emission (LLVM lowering):**
- `compiler/src/llvm/closures.sfn` — `emit_closure_env_alloc` routes
  spawn-target envs to `@sfn_env_alloc` (inc. 2). Closure-pair marker carries the
  `owned_env` flag (Option A).
- `compiler/src/llvm/expression_lowering/native/core.sfn` — set the
  spawn-owned flag when building a closure pair for a `spawn:`/`parallel` operand
  (inc. 2); parallel arm unchanged if §4.2 runtime-wrap is chosen (inc. 3).
- `compiler/src/llvm/expression_lowering/native/lambda_lowering.sfn` — emit
  `owned_env=1` on the spawn-target closure marker (inc. 2, Option A).

**Ownership (already wired — tests only):**
- `compiler/src/ownership_checker.sfn` — only if increment 4 surfaces a real
  capture-set gap in `_consume_spawn_captures`.

**Tests / docs:**
- `compiler/tests/unit/` — env alloc/free balance (inc. 1); spawn-target env
  emits `@sfn_env_alloc` IR assertion (inc. 2); E0901 on capturing spawn/parallel
  reuse (inc. 4).
- `compiler/tests/e2e/spawn_capture_env_free_test.sfn` — ASAN-interleave gate
  (inc. 5).
- `docs/status.md` + concurrency spec — capture-env ownership note (inc. 5).

---

## 9. Verification

- Per increment: `make compile` (self-host green); `sfn check` the touched
  `.sfn`; `sfn fmt --check` the touched files.
- Inc. 1: unit alloc/free-balance test (ASAN clean in isolation).
- Inc. 2: IR test — capturing `spawn:int` emits `@sfn_env_alloc` and routes
  `@sfn_spawn_int_ctx`; trampoline path frees env.
- Inc. 3: IR/runtime test — capturing `parallel [...]` task frees its env;
  parallel join reinterpret unchanged.
- Inc. 4: `sailfin test` the ownership unit tests — E0901 on reuse-after-spawn
  and reuse-after-parallel.
- Inc. 5 (final): `make clean-build && make check` clean. The ASAN-interleave
  e2e: under `ulimit -v unlimited` + `SAILFIN_MEM_LIMIT=unlimited`, N concurrent
  capturing tasks report **no `ERROR: AddressSanitizer:` and no
  `ERROR: LeakSanitizer:`**; SKIP (pass) when the vmem cap is active or ASAN
  can't start; the plain leg asserts result correctness regardless.

---

## 10. Future considerations

- **#1476 (next):** owned-string / OwnedBuf capture ABI — length-carrying buffer
  capture and result-aliases-capture. #1475's env-container free is a prerequisite
  it can build on; the §4.4 boundary is the explicit handoff.
- **Synchronous capturing-lambda env reclaim:** today arena-reclaimed and never
  individually freed. If a future phase wants deterministic synchronous-closure
  free, the `sfn_env_alloc`/`sfn_env_free` pair generalizes to it (route all
  capture envs through it and free at closure-scope exit) — but that is a
  separate decision, not #1475.
- **Nursery-owned spawn:** `sfn_spawn` already registers tasks with the current
  nursery (`future.sfn:146`). The env free living in the trampoline composes with
  nursery join unchanged (the trampoline runs once per task regardless of who
  joins). No interaction to design now.
