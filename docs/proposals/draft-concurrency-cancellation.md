---
sfep: TBD
title: Concurrency runtime maturity — cancel-on-fault and async I/O
status: Draft
type: runtime
created: 2026-07-06
updated: 2026-07-06
author: "agent:compiler-architect; human review"
tracking: "#1540, #1963"   # #1540 origin (MCP-proxy, gap C5); #1963 tracking epic
supersedes:
superseded-by:
graduates-to:
---

# SFEP-XXXX — Concurrency runtime maturity: cancel-on-fault and async I/O

## 1. Summary

Sailfin's structured-concurrency v0 works end-to-end — `spawn`/`await`,
`channel()`, `parallel [...]`, and the `routine { }` nursery all run on a real
pthread pool — but it is **join-all only** and **blocking (no task
suspension)**: tasks are queued onto a fixed worker pool, so a task that blocks
(e.g. a keep-alive connection waiting on I/O) pins its worker for the duration.
This SFEP
proposes maturing the concurrency runtime along two axes that gap C5 of epic
#1540 (MCP-proxy enablement) routed out as design-heavy: (1) **cancel-on-fault**
— when one child in a `routine { }` nursery faults, its siblings are cancelled
rather than the nursery merely join-waiting on them; and (2) **async I/O / event
loop** — an epoll/kqueue-driven reactor so thousands of idle long-lived sessions
(e.g. stdio MCP proxies, keep-alive HTTP connections) do not each pin a pool
thread. The work is **multi-phase**: cancel-on-fault (Phase 1) is a bounded,
self-contained extension of the existing nursery/task machinery and ships first;
the async-I/O reactor (Phase 2) is a larger scheduler restructure that depends on
Phase 1's cancellation plumbing and on suspendable tasks. This is the
structured-concurrency **pillar** graduating from v0 to a real concurrency
substrate, not a new feature — cancel-on-fault is table stakes for "structured".

## 2. Motivation

### The status quo (real baseline, not the stale #1540 text)

The #1540 epic text says the worker pool "floors at 2 / caps at 4." **That is no
longer true** and this SFEP starts from the corrected baseline: the scheduler
sizes the pool to `clamp(online_cores, 2, 32)`, overridable via `SAILFIN_THREADS`
(with a `1024` hard ceiling), in `sfn_scheduler_resolve_thread_count`
(`runtime/sfn/concurrency/scheduler.sfn`, `_sfn_scheduler_default_max() = 32`).
The pool-size problem was already closed; the remaining C5 gaps are cancellation
semantics and the I/O-scaling model, which no pool size fixes.

What exists today (grounding, `docs/status.md` §concurrency, lines 314–318, 382–401):

- **Nursery** (`nursery.sfn`): `routine { }` lowers to `sfn_nursery_enter` /
  `sfn_nursery_register` / `sfn_nursery_exit`. Exit is an **unconditional
  join-all barrier** — it walks every registered `Task` and calls
  `sfn_task_join`, discarding results. Its header explicitly scopes out
  cancel-siblings-on-fault. The only fault seam is `Nursery.faulted`, set on an
  OOM that prevented a registration; `sfn_nursery_exit` returns it so a future
  lowering can rethrow. **A child that throws is invisible to the nursery** — the
  trampolines in `future.sfn` discard the body's error and the nursery joins the
  (already-returned) task as if clean.
- **Task** (`scheduler.sfn` `struct Task`): `fn_ptr`, `ctx`, `result`, `done`
  (atomic completion flag), embedded `cond`/`mutex`, `detached`. **There is no
  fault field and no cancellation field.**
- **Scheduler** (`scheduler.sfn`): fixed pthread pool over a mutex-guarded MPMC
  `TaskQueue`; workers block in `sfn_taskqueue_dequeue` on `not_empty`. Blocking,
  no reactor.
- **serve** (`serve.sfn`): a blocking `accept(2)` loop that enqueues **one
  `Task` per connection** onto the shared pool; each connection worker runs a
  blocking `recv → dispatch → send` keep-alive loop and **pins a pool thread for
  the connection's whole lifetime** (header line 49: "blocking accept — NO async
  I/O (v0)").

### Who hits this, and why v0 is insufficient

- **Cancel-on-fault.** A `routine { }` that spawns N siblings where one throws
  today runs every other sibling to completion and swallows the fault — the
  opposite of the structured-concurrency contract ("a nursery is the dynamic
  extent of its children; a child failure cancels the group"). For the MCP proxy,
  a fan-out of upstream calls where one upstream errors should abort the batch,
  not wait on the slow-but-doomed siblings. This is a **soundness gap in a
  pillar**, not a nice-to-have.
- **Async I/O.** The MCP-proxy wedge is **stdio sessions**: thousands of
  long-lived agent↔tool connections, each mostly idle, each blocked in `recv`.
  Thread-per-connection means each idle session consumes a pool thread (and an
  8 MiB-default thread stack); at the `32`-worker default the 33rd idle session
  starves, and even at the `1024` ceiling the memory floor is untenable. The same
  limit throttles keep-alive HTTP (gap B5) and any high-fan-out `serve`. Scaling
  idle connections requires decoupling a *connection* from a *thread* — an event
  loop that parks idle fds and only wakes a worker when an fd is readable.

## 3. Design

The design is two phases. Phase 1 is shippable and self-contained; Phase 2
builds on it. Each phase is groomed under the tracking epic with its own phase
tracker.

### Phase 1 — Cancel-on-fault (nursery fault propagation + cooperative cancellation)

**Model.** A nursery becomes the *cancellation scope* for its children. When any
child faults (throws, or its trampoline records a non-zero fault), the nursery
enters a **cancelled** state and requests cancellation of all live siblings.
Cancellation is **cooperative** (checkpoint-polled), never preemptive — see the
rationale below. `sfn_nursery_exit` then joins all children (cancelled ones
return promptly at their next checkpoint) and, if the scope faulted, **rethrows
the first-observed child fault** on the owning thread instead of returning 0.

**Task state extension.** Add two i64 slots to `struct Task` (both appended
**after `detached`** so no existing offset dependency moves — the same layout
discipline the `detached` slot followed, and the `channel.sfn::sfn_spawn_task`
mirror and `_sfn_task_struct_size` must be updated in lockstep):

- `fault: i64` — 0 = clean, non-zero = the body threw. Written by the trampoline
  after the body returns/unwinds; read by the joiner. The concrete fault payload
  (error code / pointer) is carried in `result` under a fault discriminant, or in
  a third `fault_payload` slot if `result` is needed for the clean value —
  decide at implementation against the current error-lowering ABI (Sailfin's
  throw path lowers through a runtime error channel; the trampoline is where the
  body's `throw` surfaces).
- `cancel: i64` — a per-task atomic cancellation flag (0 = live, 1 =
  cancellation requested). A task polls its own flag at checkpoints. Sibling
  cancellation sets each live sibling's `cancel`.

**Nursery cancellation state.** Add to `struct Nursery` a `cancelled: i64`
atomic flag and a `first_fault: i64` slot (the fault code/payload of the first
child to fault, latched once under the existing `mutex`). Layout grows by two
i64s appended after `faulted`; update `_sfn_nursery_struct_size`.

**How a faulting task signals siblings.** Two seams, whichever fires first:

1. *At join (already-completed fault).* `sfn_nursery_exit` reads each child's
   `fault` slot as it joins. On the first non-zero fault it latches
   `Nursery.first_fault`, sets `Nursery.cancelled`, and walks the registration
   list setting `cancel = 1` on every not-yet-joined sibling. (This is the
   minimal, fully-cooperative shape and requires no worker-side callback.)
2. *Eager (running fault).* For faster fault-out, the trampoline, after recording
   its own `fault`, calls a new `sfn_nursery_notify_fault(nursery, code)` that
   latches `first_fault`/`cancelled` and fans `cancel` out to siblings *before*
   the owning thread reaches `exit`. This requires the child to know its owning
   nursery — thread the `Nursery*` into the task's captured ctx at
   `sfn_nursery_register` time (a new `owner_nursery` slot on `Task`, or a
   pointer stashed in the env). Eager notification is the design target; the
   at-join seam is the correctness floor that ships even if eager lands second.

**Cooperative cancellation checkpoints.** A cancelled task must reach a
checkpoint to observe the flag and unwind. Checkpoints:

- **`await`** — `sfn_await`/`sfn_task_join` on a future whose owning scope is
  cancelled returns a cancellation sentinel instead of blocking indefinitely.
- **Channel `send`/`receive`** — the bounded-channel wait loops
  (`channel.sfn`) gain a cancellation check in their `pthread_cond_wait`
  recheck: a cancelled waiter wakes and returns a `Cancelled` status rather than
  blocking on `not_full`/`not_empty`. This needs the channel op to know the
  current task's `cancel` flag (thread-local "current task" pointer, mirroring
  `_sfn_g_current_nursery`).
- **An explicit intrinsic** `cancellation_requested() -> bool` (lowered to a
  read of the current task's `cancel` flag) so long compute loops can cooperate
  voluntarily. Boring shape; no new keyword — a registered builtin like the
  existing concurrency surface.
- **Interruptible blocking syscalls.** A task blocked in `recv`/`poll`/`read`
  cannot see the flag. Wake it with a **self-pipe** (or `eventfd` on Linux):
  cancellation writes one byte to the task's wake-fd; the task's blocking wait is
  a `poll` over {real fd, wake-fd} rather than a bare blocking `recv`. This
  reuses the `poll`/`EINTR` machinery already in `process.sfn` and the
  `io.poll_readable` (#1580) surface, and it is the bridge into Phase 2.

**Why cooperative, not preemptive.** `pthread_cancel` / async signal delivery is
**unsound** against the current runtime: a preempted task can be holding the
arena allocator lock, an RC refcount mid-update (#1094), a channel/queue mutex,
or a libc lock — cancelling there deadlocks or corrupts. Cooperative
checkpointing is the only safe model until/unless the runtime grows
cancellation-safe critical sections. This matches Trio/Kotlin structured
concurrency (cooperative cancellation at suspension points) and is the boring,
correct choice.

**Non-local exit interaction.** Today a `throw`/`return` out of a `routine` body
is rejected fail-closed. With cancel-on-fault, a `throw` **inside** the routine
body on the owning thread should: set `cancelled`, fan `cancel` to children, run
`sfn_nursery_exit` (join the now-cancelling children), then rethrow. This is a
lowering change at the `routine` exit path, not a parser change — the fail-closed
rejection of *escaping* control flow can stay; what changes is that a fault
*within* the dynamic extent tears the scope down cleanly.

```sfn
// Phase 1 target semantics (illustrative)
routine {
    spawn fn() -> int ![io] { fetch(a) }   // sibling 1
    spawn fn() -> int ![io] { fetch(b) }   // sibling 2 — throws
    spawn fn() -> int ![io] {              // sibling 3 — cooperatively cancelled
        loop {
            if cancellation_requested() { return 0; }   // observes sibling 2's fault
            step();
        }
    }
}   // routine exit rethrows sibling 2's fault after joining the cancelled group
```

### Phase 2 — Async I/O / event-loop reactor

**Goal.** Decouple an idle connection from a pool thread so N idle sessions cost
O(1) threads, not O(N). Introduce a **reactor** (event loop) over
epoll (Linux) / kqueue (macOS/BSD) that owns non-blocking fds and dispatches a
worker only when an fd is ready.

**Extern surface (platform-split, per the existing convention).** Sailfin has no
`cfg` conditional compilation yet, so — mirroring `sizes_linux.sfn` /
`process_windows.sfn` and the pthread max-sized-handle discipline — the reactor
externs live behind a thin platform seam:

- **Linux:** `epoll_create1(flags: i32) -> i32`, `epoll_ctl(epfd, op, fd,
  event: * u8) -> i32`, `epoll_wait(epfd, events: * u8, maxevents, timeout) ->
  i32`; overlay the `epoll_event` struct as a byte buffer (the `pollfd` overlay
  precedent in `process.sfn`).
- **macOS/BSD:** `kqueue() -> i32`, `kevent(kq, changelist: * u8, nchanges,
  eventlist: * u8, nevents, timeout: * u8) -> i32`; overlay `struct kevent`.
- Shared, platform-neutral Sailfin wrapper: `sfn_reactor_create()`,
  `sfn_reactor_register(reactor, fd, interest)`,
  `sfn_reactor_modify/deregister`, `sfn_reactor_wait(reactor, timeout_ms) ->
  ready-set`. The platform split is a runtime-symbol dispatch (like the
  `_sfn_scheduler_sc_nprocessors_onln` sentinel folding, #1480), collapsed to
  one backend at link.
- **Non-blocking fds:** need `fcntl(fd, F_SETFL, O_NONBLOCK)` — a new extern
  (libc, no new dependency), plus `O_NONBLOCK` as a platform-conditional
  constant.

**Scheduler integration — suspendable tasks.** The hard part: a task that blocks
on I/O must **yield the worker thread** and be resumed when its fd is ready. Two
strategies, decided in Phase 2 design:

1. **State-machine tasks (stackless).** An `async fn` that awaits I/O lowers to a
   resumable state machine; on a would-block, it registers its fd with the
   reactor and returns control to the worker. Requires real `async fn` codegen
   (today `async fn` is structural-only, #829/#1944) — a substantial frontend
   lift.
2. **Reactor-fronted blocking (stackful-lite).** Keep task bodies as ordinary
   blocking code, but route their I/O waits through the reactor: a dedicated
   **reactor thread** owns the epoll/kqueue set; a task issuing a would-block I/O
   parks its continuation as a small heap record keyed by fd, and the worker
   returns to the pool; on readiness the reactor re-enqueues the task's
   continuation. For `serve`, this is tractable *without* general `async fn`
   because the connection state is a fixed recv/dispatch/send loop that can be
   expressed as an explicit per-connection state struct.

Strategy 2 is the pragmatic first target (it scales `serve`/stdio without the
full `async fn` transform); strategy 1 is the general end state and folds in the
`async fn` typecheck/lowering work (#1944) as a predecessor.

**serve migration.** `sfn_serve` moves from "blocking accept → one Task per
connection" to "non-blocking listener registered with the reactor → on
`accept`-ready, accept and register the new conn fd → on conn-readable, dispatch
a worker for one recv/dispatch/send turn, then re-park the fd." Idle keep-alive
and idle stdio sessions hold only a reactor slot + a small state struct, not a
thread. The blocking `sfn_serve` path stays as a compatibility fallback until the
reactor path is proven.

**Cancellation ⇄ reactor synergy.** Phase 1's self-pipe/wake-fd checkpoint is
exactly a reactor registration: a cancelled task's wake-fd becomes readable, the
reactor wakes it, it observes `cancel` and unwinds. Phase 1's interruptible-wait
plumbing is the seed of Phase 2's reactor — which is why cancel-on-fault ships
first and the reactor builds on it, not the reverse.

## 4. Effect & capability impact

- **No new effects.** Cancellation and the reactor are mechanisms under the
  existing surface. `spawn`/`parallel` remain `![io]` (the `spawn_task` registry
  row, #1655); channel `send`/`receive` remain `![io]` (#1655); `serve` remains
  `![net, io]`. `cancellation_requested()` is a pure read of task-local state and
  should be **`![pure]`** (or effect-free) so a compute loop can poll it without
  widening its effect row — verify against the effect-checker's builtin
  classification.
- **Cancellation is not a capability leak.** A cancelled task returning a
  `Cancelled` sentinel from `await`/channel ops introduces a new result state but
  no new capability; effect enforcement is unchanged.
- **Reactor externs** (`epoll_*`/`kqueue`/`kevent`/`fcntl`) sit under `![io]`/
  `![net]` runtime paths exactly as `poll`/`accept`/`recv` do today — no new
  effect row; the registry rows for `serve`/channel already gate the surface.
- **Ownership interaction.** A cancelled/faulted task still owns its captured env
  (`sfn_env_alloc` env, #1475); the trampoline must free it on the cancellation
  path exactly once, same as the normal-return path. The E11 spawn-capture-move
  analysis (#1220) is unaffected — cancellation changes *when* the worker body
  returns, not the capture ABI.

## 5. Self-hosting impact

**Phase 1 is almost entirely a runtime-source change** — the bulk lands in
`runtime/sfn/concurrency/{nursery,scheduler,future,channel}.sfn` (Task/Nursery
struct fields, trampoline fault capture, nursery notify/cancel fan-out, channel
checkpoint), which the current seed already compiles (they use only the
`extern fn` pthread/atomic surface the seed supports). The compiler-source
touches are narrow:

- `cancellation_requested()` and the `Cancelled` sentinel need a **registered
  builtin** (`runtime_helpers.sfn` descriptor + emit routing), analogous to how
  `channel`/`spawn`/`serve` are lowered — a small `emit_native.sfn` /
  lowering-core addition, **no parser/AST change** (it is a call, not new syntax).
- The `routine` **exit lowering** changes to thread the rethrow-on-fault path
  (lowering-core / expression lowering where `routine` currently emits
  `sfn_nursery_exit`). No new AST node; `routine {}` already parses.

Because the compiler itself does not *use* nurseries/cancellation, adding this
surface is **additive** — the old seed compiles the new compiler, and the new
runtime symbols are only exercised by user/test code. **Seed-cut discipline
(`.claude/rules/seed-dependency.md`):** the `cancellation_requested()` builtin is
a compiler-source capability with exactly one class of consumer (the runtime
cancellation tests + user code) worked in the same phase — **bundle the builtin
lowering with its runtime + test consumer in one PR** so `make compile` builds
the new compiler from the old seed and that compiler compiles the consumer in the
same self-host pass, **avoiding a seed cut**. Only if the reactor's `async fn`
lowering (Phase 2 strategy 1) is split from its consumer does a seed cut become
necessary — queue it against the cadence bump, don't cut reactively.

**Phase 2** adds the platform reactor externs (runtime-source, seed-compilable)
and, for strategy 1, real `async fn` codegen — a genuine compiler-pass change
(typecheck #1944 + lowering) that is its own predecessor with its own SFEP-worthy
surface. Strategy 2 (reactor-fronted blocking) keeps the frontend untouched and
is therefore the self-hosting-cheap first target.

**Platform caveat.** Effect enforcement and the runtime are first-class on Linux
x86_64; macOS arm64 is partial (#613). The reactor's kqueue backend and the
`![io]` self-pipe path must be validated on both self-hosting targets; the
max-sized-handle / sentinel-folding conventions already in `scheduler.sfn` are
the template for the platform split.

## 6. Alternatives considered

- **Preemptive cancellation (`pthread_cancel`/signals).** Rejected: unsound
  against the arena allocator, RC refcounts, and held mutexes (a preempted task
  mid-critical-section deadlocks/corrupts). Every mature structured-concurrency
  runtime (Trio, Kotlin, Swift) is cooperative for this reason.
- **Nursery join-all forever (do nothing).** Rejected: leaves a soundness hole in
  a marketed pillar — "structured concurrency" that cannot cancel a failed group
  is not structured. The #1540 MCP fan-out case is a concrete failure.
- **Raise the pool ceiling instead of an event loop.** Already done
  (`min(cores,32)`, `SAILFIN_THREADS`, `1024` ceiling). A bigger pool does not
  fix idle-connection thread-pinning — 10k idle stdio sessions at one thread each
  is memory-bound regardless of ceiling. The event loop is the structural fix.
- **`select(2)`/`poll(2)`-based loop instead of epoll/kqueue.** `poll` is O(N) per
  wait over all fds; fine for the handful of fds in `process.sfn`'s pipe
  forwarding, untenable for thousands of connections. epoll/kqueue is O(ready).
  `poll` remains the right tool for the small-fixed-fd Track A stdio-proxy case;
  the reactor is for the large-fd `serve` case.
- **General `async fn` first (strategy 1 before strategy 2).** Rejected as the
  *first* deliverable: it forces the #1944 `async fn` frontend lift before any
  I/O-scaling value ships. Strategy 2 delivers `serve`/stdio scaling with no
  frontend change; strategy 1 generalizes later.
- **Cross-thread nursery inheritance to cancel grandchildren.** Deferred (v0
  already scopes it out): Phase 1 cancels the direct children registered on the
  owning thread's nursery; a child that opens its own inner `routine` cancels its
  own subtree via the same mechanism. Full transitive cross-thread inheritance is
  a Phase 2+ follow-up.

## 7. Stage1 readiness mapping

Phase 1 (cancel-on-fault):

- [ ] Parses — no new syntax; `routine {}` and `spawn`/`await` already parse.
      `cancellation_requested()` is an ordinary call.
- [ ] Type-checks / effect-checks — `cancellation_requested()` classified
      effect-free/`![pure]`; `Cancelled` sentinel typed on `await`/channel ops.
- [ ] Emits valid `.sfn-asm` — new builtin descriptor + `routine`-exit rethrow
      lowering in `emit_native.sfn`.
- [ ] Lowers to LLVM IR — builtin call lowering; runtime symbols resolve.
- [ ] Regression coverage — see Test plan.
- [ ] Self-hosts — additive; old seed compiles new compiler; runtime-only bulk.
- [ ] `sfn fmt --check` clean — every touched `.sfn`.
- [ ] Documented in `docs/status.md` (flip the `routine {}` / `spawn` rows from
      "join-all (no cancel-on-fault)" to enforced) + concurrency spec chapter.

Phase 2 (reactor) tracks the same checklist under its own phase issues; strategy
1 additionally depends on the `async fn` readiness items (#1944).

## 8. Test plan

Phase 1 (`compiler/tests/{unit,integration,e2e}/`):

- **Cancel-on-fault, at-join seam:** a `routine {}` with three spawned children
  where child 2 throws; assert children 1/3 observe cancellation and the routine
  rethrows child 2's fault (not a silent join). Extends the existing
  `spawn_await_concurrent_execution_test.sfn` / nursery coverage.
- **Cooperative checkpoint via intrinsic:** a compute-loop child polling
  `cancellation_requested()` returns promptly after a sibling faults; assert it
  did not run to its natural completion (witness via a shared counter/channel).
- **Channel checkpoint:** a child blocked in `receive`/`send` on a bounded
  channel wakes with `Cancelled` when its nursery is cancelled, rather than
  blocking forever (guard with a timeout so a regression hangs the test, not CI).
- **Interruptible blocking wait:** a child blocked in a `poll`/`recv` wakes via
  the self-pipe on cancellation (reuses the `process.sfn` poll/EINTR pattern).
- **Env-free-once on the cancel path:** an ASAN-interleave test
  (mirroring `concurrency_ownedbuf_asan_interleave_test.sfn`, #1567) proving a
  cancelled capturing task frees its `sfn_env_alloc` env exactly once — no leak,
  no double-free.
- **Effect-checker:** `cancellation_requested()` callable from a `![pure]`/
  effect-free context without widening the effect row (a `does_not_compile`
  negative if it wrongly demands `![io]`).

Phase 2:

- **Reactor roundtrip:** register a non-blocking listener + a client fd, drive
  `sfn_reactor_wait`, assert readiness dispatch (linked epoll/kqueue smoke, per
  platform, skip-if-unavailable like the sanitizer legs).
- **Idle-connection scaling:** open K keep-alive/stdio connections that stay
  idle, assert live thread count stays O(pool), not O(K) (thread-count witness).
- **serve reactor loopback:** the `serve_loopback_test.sfn` round-trip passes on
  the reactor path with keep-alive, no per-connection thread pinning.

## 9. References

- **#1540** — Epic: MCP-proxy enablement; **gap C5** ("concurrency runtime
  maturity") is the origin of this SFEP. (Corrects C5's stale "caps at 4"
  baseline — pool is now `min(cores, 32)` / `SAILFIN_THREADS`.) Related gaps:
  B4 (keep-alive), B5 (concurrency ceiling / scalable I/O), A2/A3 (stdio
  poll/read, #1580).
- **#1963** — Epic: concurrency runtime maturity — the tracking epic this SFEP
  designs; Phase 1 (#1964) and Phase 2 (#1965) are its phase trackers.
- **#1385** — Epic: close the REST-server dogfooding gaps (serve request
  delivery, router, closure handlers) — the `serve` reactor migration overlaps.
- **#1944** — `async fn` typecheck wiring (`await` not in the live walk);
  predecessor for Phase 2 strategy 1 (state-machine tasks).
- **#829** — `await` typing not wired into the live typecheck walk.
- **#613** — macOS arm64 effect-enforcement / runtime partiality (platform
  validation caveat for the reactor).
- `docs/status.md` — concurrency status (`routine {}` line 314, `await` 315,
  `channel()` 316, `spawn`/`await` 317, `parallel` 318; runtime summary 382–401).
- `runtime/sfn/concurrency/{nursery,scheduler,future,channel,parallel,serve}.sfn`
  — the v0 surface this SFEP matures.
- `docs/proposals/0025-native-runtime-architecture.md` §"scheduler and
  concurrency" — the fixed-pool + MPMC-queue design this extends.
- `.claude/rules/seed-dependency.md` — bundle-vs-split for the
  `cancellation_requested()` builtin (bundle with its consumer; no seed cut).
