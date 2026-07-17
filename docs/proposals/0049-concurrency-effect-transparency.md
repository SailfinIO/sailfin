---
sfep: 0049
title: Effect-transparency for concurrency-primitive leaves (spawn / parallel / channel send·receive)
status: Implemented
type: language
created: 2026-07-17
updated: 2026-07-17
author: "agent:compiler-architect; human review"
tracking: "SFN-86, #1702"
supersedes:
superseded-by:
graduates-to: "docs/status.md (§concurrency); site/src/content/docs/docs/reference/preview/concurrency.md"
---

# SFEP-0049 — Effect-transparency for concurrency-primitive leaves (spawn / parallel / channel send·receive)

## 1. Summary

The three in-process concurrency-primitive *leaves* — `spawn`, `parallel`, and
channel `send`/`receive` — currently attribute a hardcoded `![io]` effect to
their caller regardless of what the spawned/sent body actually does. That `io`
is a deliberate **conservative placeholder** (`runtime_helpers.sfn` lines
~1118–1161, #1655), not a real capability the primitives exercise: the v0
scheduler primitives are pure pthread mutex/condvar/MPMC-queue code that touch
no fs, net, console, or clock. This SFEP makes those three leaves
**effect-transparent**: the primitive itself contributes *no* effect, and the
caller inherits exactly the effects of the body it spawns/sends. A `spawn` /
`parallel` / channel op over a **pure** body requires **no** effect; over an
`![io]` body, `io` propagates. This closes a spot where the flagship effect
checker lies about concurrency — a pure fan-out is pure, as it is in Go — while
preserving the #1655 "registry rows and checker arms agree by construction"
invariant. This is the **leaf half** of SFN-86 (#1702); the **join half**
(`await` and nursery/`routine {}` exit effect propagation) is explicitly
deferred to the concurrency-cancellation SFEP (SFN-124).

This proposal is **SFEP-0049** (registry maximum was 0048; SFEP-0001 §2 assigns
`max + 1` at merge) and `Accepted` at the design gate (owner sign-off, 2026-07-17).

## 2. Motivation

Sailfin markets **effects** as its headline pillar — compile-time capability
enforcement is the whole differentiator. That claim is only as strong as the
effect checker's honesty. Today the checker attaches `io` to any `spawn`,
`parallel`, or channel `send`/`receive`, so a function whose only "impure" act
is fanning a *pure* computation across threads is forced to declare `![io]` and,
transitively, so is every one of its callers. Concretely:

```sfn
// Pure fan-out of a pure computation. There is no I/O anywhere here.
fn sum_in_parallel(a: int, b: int) -> int ![io] {   // ← the ![io] is a lie
    let joined = parallel [
        fn () -> int { return a * a; },
        fn () -> int { return b * b; },
    ];
    return joined[0] + joined[1];
}
```

Nothing in `sum_in_parallel` performs I/O — `parallel` here is a scheduling
mechanism over two pure closures. Go treats goroutine spawn as effect-free (a
pure fan-out is pure); the same should hold in Sailfin. The phantom `io` makes
the checker over-attribute a capability, which (a) teaches users that "effects
are approximate" — corrosive to the pillar — and (b) forces `io` to bubble up
call chains that never touch a capability, defeating the fine-grained enforcement
the effect system exists to provide.

**Why now.** #1655 deliberately parked this as a placeholder pending #829
(frontend concurrency typing) — the design was "ahead of the foundation." That
soft gate has effectively closed: typed `Channel<T>` (SFN-111) and live
await-result typing (SFN-113) both landed in 2026-07, so the concurrency
frontend is now typed enough to reason about spawned/sent bodies. This SFEP is
the principled end state the #1655/#1702 comment block names outright:
"effect-transparency (the spawned body's own effects propagate, the primitive
adds nothing)." It is a self-contained, mostly-single-file correctness fix that
directly strengthens the language's flagship guarantee.

## 3. Design

### 3.1 Scope boundary — leaf only

This SFEP covers the **effect attribution of the in-process primitive leaves**:

- **IN:** `spawn <expr>` / `spawn(...)`, `parallel [...]`, channel `.send(v)`,
  channel `.receive()`.
- **OUT (deferred to the concurrency-cancellation SFEP / SFN-124 "join half"):**
  the join-side counterpart — `await <future>` and nursery-exit (`routine {}`)
  effect propagation. `await` today only *recurses* into its operand and
  contributes no effect of its own (`effect_checker.sfn` line ~1535), and
  `routine {}` exit has no dedicated effect arm; giving those join points their
  own effect semantics (e.g. propagating a joined task's effects at the await
  site, or a nursery aggregating its children's effects at exit) is a distinct
  design entangled with cancel-on-fault and future-result typing. That work is
  the natural home for the join-side rules and is called out as such in the
  cancellation SFEP's cross-reference. Drafting the leaf half now delivers the
  honest-attribution win without waiting on the join-side redesign.

### 3.2 Core change

The three placeholder registry rows drop their `io` to `effects: []`, and the
checker arms — which **already recurse into the body** — propagate the body's
own collected effects unchanged.

**Registry** (`compiler/src/llvm/runtime_helpers.sfn`, `_rh_descriptors_08`):

| target | before | after |
|---|---|---|
| `spawn_task` | `effects: ["io"]` | `effects: []` |
| `channel_send` | `effects: ["io"]` | `effects: []` |
| `channel_receive` | `effects: ["io"]` | `effects: []` |

`parallel_join` is already `effects: []` and stays so. **No `parallel`
descriptor row is added** — the `Parallel` arm continues to route its effect
through the `spawn_task` row (which now resolves to `[]`), preserving the
fail-closed rejection of the unimplemented `sfn/sync` paren-call `parallel(...)`
that a dedicated row would make resolvable (`sync_rejects_unimplemented_
concurrency_test.sfn`). `channel_create`/`channel_close` remain `effects: []`
(unchanged — no checker arm consults them).

**Checker** (`compiler/src/effect_checker.sfn`): **no logic edits are required**.
The four arms already do the right thing once the rows are empty, because each
arm already walks the body and then appends the (now-empty) builtin effects:

- `Spawn` arm (line ~1527): `collect_effects_from_expression(expression.operand,
  imports)` collects the spawned body's effects, then
  `_append_builtin_effects(required, "spawn_task", …)` appends `[]`. Net: the
  operand's effects, and nothing else.
- `Parallel` arm (line ~1542): merges every `expression.tasks[i]`'s effects,
  then appends the `spawn_task` `[]`. Net: the union of the task bodies' effects.
- Channel `send`/`receive` Member arm (line ~1343): appends the
  `channel_send`/`channel_receive` `[]`; the **argument walk** in the enclosing
  `Call` branch (line ~1368) already propagates any effects in the argument
  expression (e.g. `ch.send(fs.read(p)?)` still requires `io` from `fs.read`).
- `spawn` Call-form / member-call arm (line ~1289): unchanged; the callee-effect
  recursion and `_propagate_imported_callee_effects` already carry the body's
  effects.

This is the whole point of the #1655 refactor: because the arms derive their
requirement *from the registry via `_append_builtin_effects`*, flipping the rows
to `[]` is sufficient and the "rows and arms agree by construction" invariant is
preserved with zero arm edits.

**Decision — keep the `_append_builtin_effects(…, "spawn_task"/"channel_*", …)`
calls in place** (appending `[]`), do **not** delete them; only update the
comments citing #1655/#1702 to describe the effect-transparent end state. Deleting
them would re-hardcode into the arm what #1655 deliberately made registry-driven:
the linkage is the mechanism, so that if a real scheduler-level effect ever lands
on the `spawn_task` row, the arm picks it up mechanically with no arm edit. The
no-op append is the correct architectural state, not dead weight to prune.

### 3.3 Worked behavior

```sfn
// Pure body → no effect required.
fn fan_pure() -> int {                     // no ![…] needed after this SFEP
    let r = parallel [ fn () -> int { return 1; }, fn () -> int { return 2; } ];
    return r[0] + r[1];
}

// io body → io propagates from the body, not from the primitive.
fn fan_io() ![io] {                        // ![io] comes from print, correctly
    spawn fn () ![io] { print.info("hi"); };
}

// channel over pure element → no effect; effect comes only from the argument.
fn send_pure(ch: Channel<int>) { ch.send(42); }              // pure
fn send_io(ch: Channel<int>, p: string) ![io] {              // io from fs.read
    ch.send(read_len(fs.read(p)?));
}
```

### 3.4 Callee-resolution subtlety (must be stated precisely)

"Pure body ⇒ no effect" is exact for the cases the checker can *see* the body,
and conservative — falling back to the import table, never a phantom `io` — for
the cases it cannot:

- **Inline lambda body** (`spawn fn () ![io] { … }`, `parallel [ fn()->T {…} ]`):
  fully handled. `collect_effects_from_expression` on a `Lambda` recurses into
  `collect_effects_from_block(body, …)`, so the body's effects propagate exactly.
- **Intra-module named target** (`spawn worker()` where `worker` is a top-level
  `fn` in the same module): handled. The per-program localized table
  (`_merge_local_functions` / `localize_import_symbols_for_program`) carries the
  module's own top-level functions as `origin == "local"`, and
  `_propagate_imported_callee_effects` propagates their declared effects (as the
  in-module `E0400` family).
- **Imported named target** (`spawn some_mod.fn()` / `spawn imported_fn()`):
  handled to the extent the import table carries the callee's declared effects —
  the same resolution `serve`-of-an-imported-function already uses (SFN-29 /
  #1329), rendering `E0402` cross-module.
- **Unresolved / genuinely cross-module bare target** the localized table does
  **not** contain: the checker sees no effect for it and therefore attributes
  **nothing** — it falls back to whatever the import table carries, **not** a
  phantom `io`. General type-directed cross-module callee resolution is #1184 and
  is **scoped OUT** of this SFEP. The consequence is precisely stated: a `spawn`
  of an unresolved callee under-attributes (contributes nothing) rather than the
  old behavior of over-attributing a fixed `io`. This is the correct
  conservative direction for an *additive, honesty-improving* change — it never
  invents a capability the code does not visibly use — and it is exactly the
  behavior #1184 will tighten when it lands full callee resolution. The existing
  `_make_spawn_routine` test fixture (a `spawn worker()` over an *unresolved*
  `worker` with an empty import table) is the canonical witness of this case and
  is retargeted accordingly (see §8).

This trade — exact for visible bodies, "inherit the import table, never phantom
`io`" for invisible ones — is the load-bearing decision of the SFEP.

**Soundness note.** This aligns `spawn`/`parallel`/channel-op attribution with the
checker's *existing* cross-module resolution limit (#1184): a direct call
`worker()` to an unresolved cross-module effectful `worker` already under-attributes
today, and after this SFEP `spawn worker()` behaves identically. The change
therefore neither opens nor closes a soundness gap *beyond the one direct calls
already have* — it removes a coincidental over-approximation on one construct and
makes the two paths consistent; #1184 tightens both together. The blanket `io` was
never a principled fail-closed guard (it covered only the spawn path, not direct
calls), so keeping it would cement an inconsistent, false requirement rather than
buy real safety.

## 4. Effect & capability impact

This SFEP **is** an effect-system change; that is its entire subject.

- **No new effect.** The canonical six `[clock, gpu, io, model, net, rand]` are
  locked at 1.0 (`effect_taxonomy.sfn` lines 29–31, SFEP-0008). A dedicated
  `conc` / concurrency effect is **rejected** — see §6.
- **Direction of the change is strictly *narrowing* attribution.** After this
  SFEP, `spawn`/`parallel`/channel-op over a pure body requires *fewer* effects
  (none) than before (`io`). It never *adds* a requirement. Over-declaration is
  not an error in Sailfin — the checker enforces that *used* effects are
  *declared* (under-declaration is the error), not that declared effects are
  used — so functions that keep an independent `io` source (e.g. `print`) and
  still declare `![io]` remain valid. The only user-visible change is that some
  functions that previously *had* to declare `![io]` no longer do.
- **`excess_effects`** (`effect_checker.sfn` line 130) tracks effects declared
  *outside the capsule capability surface*, not effects declared-but-unused, so
  this change does not newly trip it.
- **Capability enforcement is unchanged in kind.** A body that genuinely does
  I/O inside a spawned closure still surfaces `io` (via the body walk); the
  capsule manifest gate is untouched. The primitive stops *fabricating* a
  capability requirement; it does not stop *enforcing* real ones.

## 5. Self-hosting impact

- **Passes touched:** effect checker (`effect_checker.sfn`) and the runtime
  descriptor registry (`llvm/runtime_helpers.sfn`) only. **No** lexer, parser,
  AST, native-emitter, or LLVM-lowering change — the primitives already parse,
  type-check, emit, and lower; only the *effect attribution* of the registry rows
  changes. `spawn`/`parallel`/channel ops are ordinary constructs the current
  seed already compiles.
- **Additive / self-host-safe.** The change relaxes an effect requirement. The
  compiler tree self-hosts today under the *stricter* placeholder (`io`
  everywhere), so it self-hosts a fortiori under the relaxed rule — no
  compiler-source function loses a declaration it still needs (any `io` the
  compiler's own concurrency use requires comes from real I/O in the body, which
  still surfaces). `make compile` from the pinned seed builds the new checker,
  and that checker re-checks the whole tree in the same pass.
- **Seed-cut discipline (`.claude/rules/seed-dependency.md`).** This is a
  compiler-source capability (an effect-checker/registry behavior change). Its
  only consumers are the effect-checker regression tests and any user/example
  code — all worked in the same session. **Bundle the registry+checker change
  with its retargeted tests in one PR.** `make compile` builds the new compiler
  from the old seed; that compiler compiles the retargeted tests in the same
  self-host pass, so **no seed cut and no `/pin-seed` is required.** Nothing
  downstream needs this behavior *present in the pinned seed* before it can build.
- **Invariant preserved.** The #1655 "rows and arms agree by construction"
  contract is the mechanism that makes this a one-line-per-row change instead of
  four scattered edits — it is strengthened, not bypassed.

## 6. Alternatives considered

- **Do nothing (keep the `io` placeholder).** Rejected: it keeps the flagship
  checker lying about a pure fan-out. #1655 always framed the `io` as a temporary
  placeholder pending the frontend-typing gate that has now closed; leaving it in
  permanently cements a documented falsehood in the headline pillar.
- **A dedicated `conc` (concurrency) effect.** Rejected on two independent
  grounds. (1) The canonical six effects are **locked at 1.0** (`effect_taxonomy.
  sfn` 29–31, SFEP-0008); a seventh effect breaks the lock and needs its own RFC.
  (2) It is semantically wrong: `spawn` is a *scheduling mechanism*, not a
  *capability*. A pure computation fanned across threads accesses no resource the
  single-threaded version does not; there is no capability to gate. Effects gate
  access to the outside world (io/net/clock/…), and concurrency touches none of
  it. Go agrees — goroutine spawn is effect-free.
- **Keep `io` on channel ops only** (on the theory that a channel is "I/O-ish").
  Rejected: a v0 channel is a pure in-process pthread MPMC queue
  (`runtime/sfn/concurrency/channel.sfn`) — mutex/condvar over a heap ring
  buffer. It touches no fd, no fs, no socket. Its effect is exactly the effect of
  the value flowing through it, which the argument walk already captures.
- **Resolve *all* callees first (fold #1184 into this SFEP).** Rejected as
  scope-inflating: full type-directed cross-module callee resolution is a large,
  separate lift (#1184). This SFEP is correct and shippable with the conservative
  "inherit the import table, never phantom `io`" fallback for unresolved callees,
  and it composes cleanly with #1184 when that lands (the fallback simply narrows
  further). Bundling would gate a small honesty fix behind a large resolution
  project.
- **Fail-closed on unresolved callees** (keep `io` *only* when the spawn target
  cannot be resolved). Rejected: it reintroduces the phantom `io` for an arbitrary
  subset and makes `spawn worker()` require `io` while the direct call `worker()`
  requires nothing — an inconsistency that itself teaches "spawn is I/O-ish." It
  buys no real soundness, because the identical under-resolution already exists on
  the direct-call path (§3.4 soundness note); #1184 is the principled closure for
  both. The transparent fallback keeps the two paths consistent.
- **Ship the join half (`await`/`routine`) in the same SFEP.** Rejected: join-
  side effect semantics are entangled with cancel-on-fault and future-result
  typing (the concurrency-cancellation SFEP / SFN-124). Splitting the leaf half
  lets the honest-attribution win land now without waiting on that redesign.

## 7. Stage1 readiness mapping

- [x] **Parses** — no new syntax; `spawn`/`parallel`/`channel`/`.send`/`.receive`
      already parse into their AST nodes/Member calls.
- [x] **Type-checks / effect-checks** — the substance of this SFEP: the four arms
      attribute the body's effects and no phantom `io`. Verified by the retargeted
      `effect_detection_test.sfn` / `effect_checker_test.sfn` / `concurrency_effect_test.sfn`
      assertions (§8).
- [x] **Emits valid `.sfn-asm`** — unchanged; the emitter/lowering for the
      primitives is untouched, only their effect metadata changes.
- [x] **Lowers to LLVM IR** — unchanged; `sfn_spawn_task`/`sfn_channel_send`/
      `sfn_channel_recv` symbols and their call lowering are unaffected.
- [x] **Regression coverage** — three effect test files retargeted, each with a
      positive (io-body/io-arg propagates → `E0400`) and negative (pure op requires
      nothing) case per primitive (§8).
- [x] **Self-hosts** — `make compile` from the pinned seed passes; the change is a
      strict relaxation, so the tree self-hosts a fortiori.
- [x] **`sfn fmt --check` clean** — every touched `.sfn` (`runtime_helpers.sfn`,
      `effect_checker.sfn`, the three effect tests) formatted.
- [x] **Documented in `docs/status.md` + spec** — the concurrency rows/effect notes
      in `docs/status.md` and the preview `concurrency.md` chapter flipped from the
      `![io]`-placeholder wording to the effect-transparent description.

## 8. Test plan

Gates (specified, not run here): `make compile` (self-host invariant for the
`compiler/src` change) then `make check` (full triple-pass + suite). Inner loop:
`sfn check compiler/src/effect_checker.sfn compiler/src/llvm/runtime_helpers.sfn`
and `build/bin/sfn test compiler/tests/unit/effect_detection_test.sfn` /
`effect_checker_test.sfn`.

**Retarget `compiler/tests/unit/effect_detection_test.sfn`** — the current
assertions bake in the phantom `io`:

- `"detect: spawn(...) -> io (Spawn node, real source)"` (line ~140): change from
  `_assert_detects("spawn(task)", "io")` to assert the Spawn variant still routes
  (`_probe_expr(...).variant == "Spawn"`) but the pure-body/bare-identifier spawn
  attributes **no** effect (add an `_assert_no_detect` helper, or assert the
  requirement set is empty). Add a paired positive: a spawn of an *inline io
  lambda* (`spawn fn () ![io] { print("x"); }`) **does** attribute `io`.
- `"detect: spawn(...) -> io (defensive Call+Identifier arm)"` (line ~149):
  retarget so the bare `spawn` Call-arm over no effectful argument attributes
  nothing.
- `"detect: parallel [...] -> io (Parallel node, registry-driven, #1655)"`
  (line ~157): keep the `variant == "Parallel"` routing assertion; change the
  effect assertion so `parallel [task]` over a pure task attributes **nothing**,
  and add a positive over an io task body that attributes `io`.
- `"detect: channel .send(...) -> io"` / `"detect: channel .receive() -> io"`
  (lines ~168/174): change to assert a **pure** `ch.send(v)` / `ch.receive()`
  attributes nothing, and add a positive `ch.send(fs.read(p)?)` (or an io-typed
  argument) that attributes `io` via the argument walk.

**Retarget `compiler/tests/unit/effect_checker_test.sfn`:**

- `"effect violation: spawn prefix requires io"` (line ~237) — flips: with
  `_make_spawn_routine("launcher", [], …)` spawning an **unresolved** `worker()`
  under an empty import table, the enclosing fn now type-checks **clean** (no
  effect required). Rewrite as `"spawn of an unresolved/pure body requires no
  effect"` asserting no diagnostic. This is the canonical witness of the §3.4
  "never phantom `io`" fallback.
- `"effect violation: spawn declaring io type-checks clean"` (line ~247) — stays
  clean (over-declaration remains legal); keep as a non-regression guard.
- Add a **positive** counterpart: a `_make_spawn_routine`-style helper whose
  spawned body is an inline lambda calling `print` (or a local `fn` declaring
  `![io]`), declared with `[]` → **must** raise the missing-`io` diagnostic
  (E0400), proving io-body propagation still enforces.
- `"effect violation: bare spawn() Call carets at the callee identifier"`
  (line ~607) and the span/caret tests (line ~836): audit — any assertion that
  depends on `spawn` *itself* producing the requirement must move the requirement
  onto the *body* (the caret/trigger tests can retarget to an io-body spawn so a
  diagnostic still exists to caret).

**Blast-radius audit — `examples/concurrency/*.sfn` (verified by reading each):**
all six retain an independent `io` source, so **none breaks**:

| file | primitive over | independent io source | breaks? |
|---|---|---|---|
| `channels.sfn` | `messages.send(42)` / `.receive()` (pure int) | `print("Received…")` | no |
| `dynamic-task-scheduling.sfn` | `tasks.send(fn(){print…})`, `await …receive()` | send-body `print` **and** later `print` | no |
| `parallel.sfn` | `parallel [pure closures]` | `print.info("Total…")` | no |
| `producer-consumer.sfn` | `buffer.send(i)` / `await …receive()` | `print("Producing/Consumed…")` | no |
| `routine-spawn-await.sfn` | `spawn fn()->int { 40+2 }` (pure) | `print("Result…")` | no |
| `routines.sfn` | `routine { print(…) }` (join-side, OUT) | `print` | no |

`parallel.sfn` (pure task bodies) and `routine-spawn-await.sfn` (pure spawn body)
are the two witnesses where the primitive stops contributing `io` yet the file
still needs `![io]` from its `print` — exactly the intended narrowing, and proof
the change is safe against the shipped examples. (No file requires `io` *solely*
from a pure spawn/parallel/channel op, which is what would have forced an edit.)

## 9. References

- **SFN-86 / #1702** — the tracking issue; this SFEP is its **leaf half**.
- **#1655** — the registry-as-single-source-of-truth unification that installed
  the `io` placeholder rows and the "rows and arms agree by construction"
  invariant this SFEP flips and preserves.
- **#1184** — cross-module type-directed callee resolution; the predecessor that
  will tighten the §3.4 unresolved-callee fallback (scoped OUT here).
- **#829** — frontend concurrency typing soft gate (now effectively closed by
  typed `Channel<T>` / SFN-111 and live await-result typing / SFN-113), which is
  what unblocks doing this now.
- **SFN-124 / `docs/proposals/draft-concurrency-cancellation.md`** — the
  concurrency-maturity SFEP; the home for the **join-side** effect semantics
  (`await` / nursery-exit) deferred by this SFEP.
- **SFEP-0008** (`0008-effect-validation.md`) — effect validation as a build gate;
  the taxonomy lock that rejects a dedicated `conc` effect.
- **SFEP-0017** (`0017-hierarchical-effects.md`) — the subsumption model this
  attribution feeds into.
- `compiler/src/llvm/runtime_helpers.sfn` (~1118–1161, 1685) — the descriptor
  rows and `effects_for_callee_target`.
- `compiler/src/effect_checker.sfn` (~1289, 1334–1360, 1527–1558, 1261) — the
  spawn/parallel/channel arms and `_append_builtin_effects`.
- `compiler/src/effect_taxonomy.sfn` (29–31) — the canonical-six lock.
- `runtime/sfn/concurrency/{channel,nursery,parallel,scheduler}.sfn` — the pure
  pthread primitives that are the factual basis for "the primitive contributes no
  effect."
- `compiler/tests/unit/{effect_detection_test,effect_checker_test}.sfn` — the
  retarget surface.
