# Phase 5a — Arena reset for in-process multi-module tools

> Append target for `docs/build-performance.md`. Pre-1.0 scoped fix
> that reclaims arena memory between iterations of any in-process
> per-file analysis loop. Unblocks `sfn check <dir>`, `sfn test`, and
> future `sfn vet` / `sfn fix` / `sfn lsp` without touching
> `make compile`'s 121-fork architecture (Phase 5 proper stays
> post-1.0).

## 1. Goal

Make `sfn check compiler/src/` (and any in-process loop over N
Sailfin files) run to completion with bounded peak RSS. Today it
SIGSEGVs at ~120 s after ~80 of 132 files because every iteration
leaks parser/typecheck/effect-checker arena allocations that are
only reclaimed at process exit.

## 2. Current state

- `sfn_arena_reset(SfnArena *)` exists at
  `runtime/native/src/sailfin_arena.c:80` and zeroes `page->used` on
  every page in microseconds. No backing pages are freed; they are
  reused on the next allocation burst.
- The arena is **default-on for selfhost** via
  `scripts/build.sh:130 (export SAILFIN_USE_ARENA="${SAILFIN_USE_ARENA:-1}")`.
  It is **not** default-on for installed binaries — end users running
  `sfn check` get malloc unless they export the env var. (The
  "default does not set the flag" prose at
  `docs/build-performance.md:83` is stale; fix it in the same PR.)
- Cross-iteration state in `cli_check.sfn:handle_check_command` —
  the central correctness question — is all populated **before** the
  per-file loop starts: `groups[].interfaces`,
  `groups[].function_effects`, `groups[].capabilities_required`,
  `aggregate_missing/parse_failures/skipped`, `file_group_index`,
  `files`, and (in `--json` mode) the running `results[]`. Per-file
  state (`source`, `result`, parse AST, typecheck tables) is born
  and dies inside one iteration.
- `cli_commands.sfn:handle_test_command` (line 449 onward) has the
  same shape: per-group resolution before the loop, per-test work
  inside it.

## 3. Constraints

- **Self-host invariant.** The seed (sfn 0.5.9) must compile a stage2
  that uses whatever symbol we add. Rules out new keywords, new AST
  nodes, and `extern fn`. Forces use of the existing
  runtime-helper-descriptor path that `fs.exists`,
  `runtime.bounds_check`, etc. already use.
- **Arena off must be a no-op.** Installed binaries on the malloc
  path must not break or pay a meaningful cost.
- **No workarounds.** Production-grade fix, not "skip files past N".
- **API must extrapolate to LSP.** Whatever ships now must also serve
  long-lived multi-tenant usage later.

## 4. Design

### 4.1 Mark / rewind, not reset-all

A blanket `arena.reset_all()` between iterations would invalidate the
group-level state listed in §2 and corrupt the next iteration. The
fix is mark/rewind: take a snapshot before the loop, rewind to it
after each iteration. Pages allocated since the mark stay in the
free chain and get reused on the next burst.

The bump allocator supports this natively — a mark is just
`(SfnArenaPage *page, size_t used)`. Rewind walks pages strictly
after the mark zeroing their `used`, then truncates the mark page's
`used` to the saved value, then resets `arena->current`. No `free()`,
no fragmentation. `sfn_arena_reset` stays as-is for process exit and
the eventual Phase 5 long-lived build process.

### 4.2 C runtime API

In `runtime/native/src/sailfin_arena.h`:

```c
typedef struct SfnArenaMark { SfnArenaPage *page; size_t used; } SfnArenaMark;
SfnArenaMark sfn_arena_mark(SfnArena *arena);
void sfn_arena_rewind(SfnArena *arena, SfnArenaMark mark);
```

Implementation is ~15 LOC next to `sfn_arena_reset`.

### 4.3 Sailfin-side binding

The runtime-helper-descriptor mechanism in
`compiler/src/llvm/runtime_helpers.sfn` already maps targets like
`fs.exists` to C symbols. Add two entries:

```sfn
RuntimeHelperDescriptor {
    target: "runtime.arena_mark",   symbol: "sailfin_runtime_arena_mark",
    return_type: "i64", parameter_types: [], effects: []
},
RuntimeHelperDescriptor {
    target: "runtime.arena_rewind", symbol: "sailfin_runtime_arena_rewind",
    return_type: "void", parameter_types: ["i64"], effects: []
}
```

The `i64` is an opaque handle. The C wrapper encodes the
`SfnArenaMark` as `(page_index << 32) | used` — 4 MiB pages and a
32-bit `used` is enough headroom for any compile we ever run in one
process. Both wrappers call `_runtime_enter()` for parity with every
other exported runtime symbol, and **short-circuit when
`sfn_arena_enabled()` is false**: `mark` returns `0`, `rewind(0)` is
a no-op. This makes the call safe to insert unconditionally.

The seed already handles the helper-descriptor path; stage2 will
reproduce the same call shape. No seed bump required.

### 4.4 Call sites

`cli_check.sfn:handle_check_command`, around the per-file loop at
~line 314:

```sfn
let scratch_mark = runtime.arena_mark();
let mut fi: number = 0;
loop {
    if fi >= files.length { break; }
    // ...existing iteration body, including total_errors += etc...
    if json { results.push(result); }
    fi += 1;
    if !json { runtime.arena_rewind(scratch_mark); }
}
```

`!json` guard: in `--json` mode `results[]` keeps each
`CheckResult.diagnostics` array alive across iterations, so we cannot
rewind. JSON output is consumer-facing structured data and the user
opted into the memory cost. Non-JSON mode (the common path,
including `make check-fast`) already discards the result inside the
iteration; rewind reclaims the arena footprint.

`cli_commands.sfn:handle_test_command`, around the per-test loop at
line 449: same insertion. Test compile/link runs in the loop; clang
runs out-of-process, so cross-iteration arena state is just what the
loop body itself holds, all of which is per-iteration.

Correctness rests on one invariant: every value the loop body reads
from outside the loop was allocated **before** the mark. §2's audit
of `cli_check.sfn` confirms this: groups, aggregates, and
file/group-index arrays are all populated above the mark line.

## 5. Migration plan

Each step lands as a self-hosting commit; run `make compile` between.

1. **C runtime: mark/rewind primitive.** `sailfin_arena.h`,
   `sailfin_arena.c`. Add a unit test that allocates, rewinds, and
   asserts pointer reuse on the second allocation.
2. **C runtime: wrappers.** `sailfin_runtime.c`,
   `runtime/native/include/sailfin_runtime.h`. Pure C; rebuild from
   seed to confirm linkage.
3. **Sailfin: register descriptors.** Two entries in
   `runtime_helper_descriptors`. No callers yet. `make compile` must
   pass.
4. **Sailfin: call from `cli_check.sfn`.** Insert mark + rewind.
   Verify with §6.
5. **Sailfin: call from `cli_commands.sfn:handle_test_command`.**
   Run `make test`.
6. **Doc fix.** Update `docs/build-performance.md` line 83 and add
   a Phase 5a section between Phase 0 and Phase 5.
7. **Followup PR — arena default-on for installed binary.** Either
   default `_arena_enabled` to 1 in `sfn_arena.c` (with
   `SAILFIN_USE_ARENA=0` as opt-out) or set the env var in
   `cli_main.sfn`. Without this, end users running `sfn check
   compiler/src/` still crash; Phase 5a only helps when the arena
   is on. **This is the most important followup.**

## 6. Files affected

| Stage | File | Change |
|---|---|---|
| C runtime | `runtime/native/src/sailfin_arena.h` / `.c` | declare + implement mark/rewind |
| C runtime | `runtime/native/include/sailfin_runtime.h` / `src/sailfin_runtime.c` | wrappers + opaque-handle encoding |
| LLVM lower | `compiler/src/llvm/runtime_helpers.sfn` | two new descriptors |
| Sailfin CLI | `compiler/src/cli_check.sfn` | mark + rewind around per-file loop, gated on `!json` |
| Sailfin CLI | `compiler/src/cli_commands.sfn` | mark + rewind around per-test loop |
| Tests | `compiler/tests/integration/check_directory_test.sfn` (new) | run `sfn check` over a multi-file fixture; assert exit 0 |
| Docs | `docs/build-performance.md` | fix stale arena text; add Phase 5a section |

## 7. Risks

| Risk | Mitigation |
|---|---|
| A cross-iteration value escapes into the scratch region (mutated `groups[]` entry, etc.) | Add an integration test asserting diagnostic output is byte-identical to the no-rewind baseline. If divergence appears, hoist the mutation above the mark or audit the specific site. |
| Page reused holds a stale pointer dereferenced after rewind | Standard arena-reset failure mode. `make test` + `make check` cover it; if shaky, run valgrind on a single `sfn check` invocation. |
| Mark taken under one arena state and rewound under another | Cannot happen — `sfn_arena_enabled()` is set once via `pthread_once`. |
| `runtime.*` namespace collision with user code | Already de-facto reserved (`runtime.bounds_check`). Document explicitly in the runtime spec when written. |

## 8. Verification

```bash
make clean-build && make compile

# The headline scenario:
ulimit -v 8388608
SAILFIN_USE_ARENA=1 timeout 300 build/native/sailfin check compiler/src/
echo "exit=$?"   # must be 0 or 1; never 139

make check && make test
```

Acceptance: `sfn check compiler/src/` completes in <90 s wall, peak
RSS <2 GB, exit code matches a shell loop over the same files.

## 9. Future considerations

- **Phase 5 (long-lived build).** Same primitive carries it: mark at
  process start, rewind between modules. The seed flip is the work;
  the runtime API stays the same.
- **`sfn lsp`.** Mark per request, rewind on response. Long-lived
  workspace state (open docs, symbol index) sits above the mark. If
  LSP later needs nested marks or per-thread arenas, the
  `sfn_arena_*` primitives already take the arena parameter; only
  the global-singleton wrappers hardcode it.
- **Per-thread arenas.** Future parallel `sfn check` swaps the
  `pthread_once` singleton for a `pthread_key_t` lookup; the
  mark/rewind primitives are agnostic.
- **Two-arena split.** If a permanent-vs-scratch split ever becomes
  worth the cost, Phase 5a does not block it — it just defers the
  refactor until a real need shows up.

## 10. Recommendation: ship Phase 5a, do not pull Phase 5 forward

Pulling Phase 5 (long-lived `make compile`) forward is 2-4 weeks
touching `scripts/build.sh`, the per-module entry point, and
parallel-build assumptions. Phase 5a is 1-2 days, ships the same
correctness story for `sfn check` / `sfn test` / `sfn lsp`, and the
mark/rewind primitive is exactly what Phase 5 will need anyway. No
work is wasted.
