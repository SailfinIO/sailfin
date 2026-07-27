# SFN-558 — Arena thread-safety strategy

> Single-issue design note (no SFEP number). Records which of the three options
> SFN-558 listed was chosen to make the bump allocator sound under shipped
> structured concurrency, and why. Design context: SFEP-0025 `#321-arenas`
> (native runtime architecture); SFEP-0004 §Q4 work item B7, which this gates.

## 1. Decision

**Per-thread arenas via `thread_local`.** Both lazy globals in
`runtime/sfn/memory/arena.sfn` — `_sfn_arena_enabled_state` and
`_sfn_arena_global_addr` — become `thread_local`, so each thread lazily creates
and privately owns its own `Arena`. Neither a lock nor an atomic CAS is
introduced; the bump path stays exactly as it is and becomes sound because
nothing is shared.

The `sfn_arena_global` symbol name is retained (it is the linker-visible entry
point every allocation site binds to) and now means per-thread storage.

Rejected: atomic CAS on the bump pointer; a lock around allocation. §3.

## 2. What was actually broken

SFN-558's summary is accurate but understates the slow path. There are four
unsynchronized read-modify-writes, not one:

| Site | Mutation |
|---|---|
| `arena.sfn:273` | `page.used = offset + size_i` — the in-page bump the issue quotes |
| `arena.sfn:295`, `:318` | `a.current_addr` retarget |
| `arena.sfn:316-317` | `new_page.next_addr` then `page.next_addr` — a two-word linked-list splice |
| `arena.sfn:537` | `page.used = used + extra` — `realloc`'s grow-if-at-tip |

The splice matters for option selection: it is a multi-word update, so no single
CAS covers it (§3).

A second, unrecorded hazard sat in the lazy-init path. `sfn_arena_enabled()`
publishes a provisional `0` before probing `SAILFIN_USE_ARENA`
(`arena.sfn:404`) as a re-entrancy guard, and `sfn_mem_free`
(`runtime/sfn/memory/mem.sfn:187`) no-ops *only while the arena is enabled*.
With shared state, a thread freeing an arena pointer during another thread's
probe window would observe `enabled == false` and hand that pointer to libc
`free`, corrupting glibc chunk metadata — the same `#1205`-class failure
`sfn_mem_free`'s guard exists to prevent. Per-thread state confines the window
to the one thread inside it, where it is straight-line code that frees nothing.

The stale justification (`arena.sfn:361-376` pre-fix) deferred all of this to
"the structured-concurrency runtime is not yet shipped (see CLAUDE.md
'Deferred / Not Yet Shipped')". Both halves had expired: `routine`/`spawn`/
`parallel`/`Task<T>` ship as v0 (`docs/status.md:536-541`), and that CLAUDE.md
section no longer exists. Per `.claude/rules/code-style.md`, the PR satisfying a
workaround's stated removal condition deletes the comment with it.

## 3. Why not a lock, and why not a CAS

**A lock around `alloc` is correct and was rejected on cost.** Every struct
literal, string concatenation and array growth in every Sailfin program routes
through `sfn_alloc_struct` → `sfn_arena_alloc`. Serializing the runtime's
hottest path across all threads negates the arena's entire rationale — the
reason it exists instead of `calloc`. It would also not help the downstream
consumer: SFEP-0004 B7 wants *parallel* `sfn check`, and a global allocation
lock reserializes exactly the work B7 parallelizes.

**A CAS on the bump pointer is insufficient, not merely contended.** The issue
frames it as the smaller change. It is not: `atomic_cas` is `i64`-only
(`compiler/src/llvm/atomics.sfn:22-23`), so it can guard `page.used`, but the
fresh-page path splices a linked list and retargets `a.current_addr` — a
multi-word update needing its own mutual exclusion underneath. The result is a
CAS *and* a lock, more moving parts than either alone, with contention added to
the fast path.

**Per-thread ownership removes both races by construction.** No atomic, no lock,
no new intrinsic. The fast path is unchanged and stays lock-free. It also
matches the precedent the codebase already set for cross-thread allocation:
`sfn_env_alloc` (`mem.sfn:301-317`) routes spawn/parallel capture environments
around the arena to `calloc` precisely because the arena has no cross-thread
ownership story (#1475). The established answer here is "don't share the arena",
and per-thread arenas generalize it.

## 4. Lifetime contract: a thread's arena is never destroyed

This is the load-bearing consequence and the one way the design could have been
worse than the bug.

Arena memory has no per-object free. A struct a worker allocates and returns
through `parallel`/`await`, or sends over a `channel`, remains valid only as
long as the allocating thread's arena does. Freeing worker arenas at thread exit
would convert a data race into a use-after-free.

So per-thread arenas leak until process exit — deliberately. This needs no
mechanism: a `thread_local` lowers to an `internal thread_local global`
(`compiler/src/llvm/lowering/module_globals.sfn:253-259`) with no TLS destructor
hook, so there is nowhere cleanup could run. It also preserves the existing
lifetime exactly — the single shared arena was never destroyed either
(`sfn_arena_sfn_destroy` has no production caller; only IR-shape tests call it).

`mark`/`rewind` inherit the same binding and become per-thread, which is what
makes the encoded mark safe under concurrency. `page_index << 32 | used`
(`arena.sfn:645`) is meaningful only against the chain it was taken from; a mark
taken on one thread and rewound against another's arena would decode to a
nonsensical page walk and bail silently. Today that is unreachable because there
is one arena; after this change it is unreachable because the handle is private.
Note this makes rewind *strictly narrower* than before: previously a driver
rewind reclaimed whatever any thread had allocated past the mark.

## 5. Costs, stated rather than absorbed

- **Address space:** one 4 MiB initial page per allocating thread. The pool caps
  at 32 workers (`runtime/sfn/concurrency/scheduler.sfn:446`), bounding this at
  ~128 MiB of VA against the 8 GiB `RLIMIT_AS` (`.claude/rules/compiler-safety.md`).
  Pages are demand-faulted, so RSS still tracks real use. A uniform 4 MiB was
  kept over a smaller worker-specific page size because sizing by thread
  ordinal needs a shared atomic counter — machinery bought for no measured gain.
- **One `getenv` per allocating thread**, since the `SAILFIN_USE_ARENA` cache is
  now per-thread. The probe reads one immutable env var, so every thread
  computes the same answer; negligible against creating a 4 MiB arena.
- **Telemetry narrows:** `sfn_arena_telemetry_dump` (`cli/entry.sfn:250`)
  reports the calling thread's arena only. Worker arenas are not aggregated.
  Acceptable because the only consumer is the single-threaded compiler driver.
- **Compiler behaviour is unchanged.** The driver is single-threaded: one
  thread, one arena, identical to the shared design.

## 6. No seed dependency

Per `.claude/rules/seed-dependency.md`, runtime source is compiled by the
**pinned seed**, so a compiler capability that `runtime/` *calls* must exist in
the seed rather than merely in the freshly-built compiler — which would force a
lone `seed-blocker` PR and a seed cut.

That gate does not apply here. `thread_local let mut` on a module global is
shipped and seed-compilable (`docs/status.md:514`), already load-bearing in
seed-compiled runtime source at `runtime/sfn/concurrency/nursery.sfn:105` and
`runtime/sfn/exception.sfn:181`, and lowers to an `internal thread_local global`
via `module_globals.sfn:253-259`. No new intrinsic is introduced, so the fix and
its test land in one PR.

One subtlety checked rather than assumed: every prior `thread_local` in tree
initializes to `0`, whereas `_sfn_arena_enabled_state` starts at `-1`. A
non-constant-foldable initializer would set `needs_init`
(`module_globals.sfn:324`), emitting a module-init store that initializes only
the main thread's copy and leaving every worker at the type default `0` —
silently disabling the arena on all workers. `is_integer_literal`
(`compiler/src/llvm/utils.sfn:205-212`) accepts a leading `-`, so `-1` folds
into the TLS template and every thread starts at `-1`. Verified before relying
on it.

## 7. Verification

Deterministic aliasing detection was chosen over a sanitizer as the primary
gate: it proves the *consequence* (two live objects at one address) rather than
the *symptom* (a reported race), and there is no TSAN leg anywhere in the repo
to copy — only ASAN patterns exist (`docs/conventions/sanitizer-tests.md`).
Inventing TSAN infrastructure was out of scope for a bug fix.

`compiler/tests/e2e/arena_concurrent_alloc_test.sfn` drives a compiled fixture
on the real thread pool with `SAILFIN_THREADS=8`. Each worker allocates 2,000
4-field structs tagged uniquely by `(worker, index)`, then re-reads its own
allocations and counts any field that no longer carries its own tag. Aliasing is
unambiguous: two threads handed the same address means the second writer
overwrites the first, and the first worker's re-read sees a foreign tag. A
string-concatenation phase covers `sfn_arena_realloc`'s grow-if-at-tip path. An
ASAN leg follows the existing skip-not-fail verdict logic from
`runtime_memory_arena_test.sfn:432-526`.

The test must fail against the pre-fix tree; that it does is recorded on the
implementing PR.
