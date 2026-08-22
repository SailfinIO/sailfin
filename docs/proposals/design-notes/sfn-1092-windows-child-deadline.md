# SFN-1092 — a child deadline that fires on Windows

Design gate for SFN-1092. Genre is a single-issue design note, not an SFEP
(`.claude/rules/proposals.md`); the sibling precedent is
`sfn-393-runner-transport.md`, which this note extends.

## 1. Goal

A parent draining a child's stdout/stderr must observe its own wall-clock
deadline on Windows, so `sfn test` cannot hang forever on a silent child.

## 2. Current state

Five call sites carry the same copy-pasted drain loop. All five branch on
`fds.length == 0`, which is the Windows leg:

| site | deadline | compiled by | consequence on Windows |
|---|---|---|---|
| `compiler/src/cli/commands/test/exec.sfn:327-394` | `deadline_ms` | seed | silent test hangs forever |
| `compiler/src/cli/commands/test/pool.sfn:335-411` | `deadline_ms` | seed | the path CI actually uses |
| `compiler/src/cli/commands/dev_verify.sfn:398-442` | `deadline_ms` | seed | `dev verify` hangs |
| `compiler/src/capsule_emit_parallel.sfn:406-458` | none (`io.poll_any(fds, -1)`) | seed | a wedged emit child hangs the build |
| `capsules/sfn/os/src/mod.sfn:469-537` | `deadline_ms` | fresh compiler | `sfn/os::run_bounded` hangs |

The fifth site was missing from the original recon. It matters because
`capsules/sfn/os` is a *library* capsule compiled by the freshly built
compiler, not by the pinned seed — the only one of the five that can consume a
new builtin in the same PR that adds it.

Why the Windows leg is untimed:

- `sfn_process_handle_stdout_fd` / `_stderr_fd` return `-1` by design
  (`runtime/sfn/platform/process_windows.sfn:1518-1520`) — a Win32 `HANDLE`
  has no fd numbering space.
- `sfn_io_poll_any` is a `-1` stub there
  (`runtime/sfn/platform/process_windows.sfn:1648`).
- So the loop falls into `read_out = !at_eof(...)` and calls the framed reads,
  which call `_pw_h_pump(h, want_err, 0)`
  (`runtime/sfn/platform/process_windows.sfn:983-1031`) — a `PeekNamedPipe` +
  `Sleep(1)` loop with **no exit other than a byte or EOF**. A wholly silent
  child parks the parent inside that loop and the top-of-loop deadline check is
  never reached.

The enabling fact: the Windows read is already a poll loop, not a blocking
read. `_pw_read_chunk` (`:587-606`) is non-blocking; `_pw_h_pump_once`
(`:952-969`) pumps both pipes in one non-blocking pass. Bounding the wait is a
parameter on an existing loop.

## 3. The seed constraint — bundling does NOT work

`process.handle_wait_readable` would be a new runtime-helper *target*. An
unregistered target is fatal at lowering:
`compiler/capsules/codegen-llvm/src/expression_lowering/native/runtime_call.sfn:184-201`
raises `E1008` when `find_runtime_helper(target)` returns null and no
return-type override is supplied.

`make compile` builds the working-tree compiler **with the pinned seed**. Four
of the five call sites are `compiler/src/` — so the seed, not the freshly built
compiler, lowers them. A new builtin plus a `compiler/src` call site in one PR
fails pass 1 of the self-host.

This is not a judgement call; it is the recorded precedent. SFEP-0050 §5.1
(`docs/proposals/0050-streamed-test-ipc.md:299-307`) states it verbatim for the
sibling primitives:

> Because the compiler's own runner does not yet call these builtins, the
> primitives ship in a **predecessor PR** … with no `compiler/src` call site,
> so the seed never needs to know the new builtins. That PR is `seed-blocker`;
> a **seed cut + `/pin-seed`** follows.

Git confirms the shape: `d4312521` (SFN-402) added
`process.handle_stderr_fd` / `handle_read_bytes_stderr` / `handle_kill` with
only a registry entry, runtime bodies, Windows stubs and one integration test;
the `compiler/src` consumer landed separately in `c6d5810e` (SFN-393).

`.claude/rules/seed-dependency.md`'s bundling default assumes the consumer is
*not* compiler source. It is here. So the primitive is seed-gated.

## 4. Design — two phases

Phase 1 fixes SFN-1092 with **no new builtin and no seed cut**. Phase 2 is the
unification the seed cut buys, filed separately and not gating Phase 1.

### 4.1 Phase 1 — bound the Windows pump

Entirely inside `runtime/sfn/platform/process_windows.sfn`, which the pinned
seed compiles as ordinary Sailfin (externs are a language feature the seed
already has; no compiler capability is added).

Add a locally-redeclared monotonic clock. `clock_windows.sfn:47-55` blesses
cross-module redeclaration of a Win32 symbol explicitly, and this file already
externs `Sleep` (`:129`) and `PeekNamedPipe` (`:116`):

```sfn
extern fn QueryPerformanceCounter(out_count: *i64) -> i32;
extern fn QueryPerformanceFrequency(out_freq: *i64) -> i32;
```

Do not reach for `monotonic_millis` — that is the compiler builtin
`runtime_monotonic_millis_fn`, and the runtime's own pipe pump should not
depend on a helper descriptor.

Rename the existing loop body to `_pw_h_pump_bounded(h, want_err, budget_ms)`,
where `budget_ms < 0` means unbounded. `_pw_h_pump(h, want_err, to_eof)` keeps
its signature and delegates with `budget_ms = -1`, so **every existing caller
is byte-for-byte unchanged** — in particular
`sfn_process_handle_read_line_stdout` (`:1552-1566`), whose line framing must
never see a spurious `""`.

Changes inside the bounded loop:

- accumulate elapsed via QPC; break out when `budget_ms >= 0` and the budget is
  spent, leaving the stash and both pipe handles untouched;
- replace the flat `Sleep(1)` on an idle pass with a 1 → 2 → 4 → 8 ms backoff,
  capped at 8 ms and reset to 1 ms on any pass that appended bytes. A 900 s
  wait at `Sleep(1)` is ~900k wakeups; at the cap it is ~112k, and a chatty
  child still gets sub-millisecond turnaround.

Only the two chunk readers take a budget:

```sfn
let _PW_FRAMED_POLL_BUDGET_MS: i64 = 25;
```

`sfn_process_handle_read_bytes_stdout` (`:1527`) and `_stderr` (`:1568`) call
`_pw_h_pump_bounded(h, want_err, _PW_FRAMED_POLL_BUDGET_MS)` instead of
`_pw_h_pump(h, want_err, 0)`.

**Contract delta, Windows only.** `handle_read_bytes_stdout` /
`_stderr` may now return `""` for a live-but-silent child. `*_at_eof` remains
the sole EOF oracle — which is already what the header at `:1522-1526`
instructs callers to consult, and what all five loops already do. Update that
header. `handle_read_line_stdout` is unaffected. POSIX is untouched by
construction: no file under `runtime/sfn/process.sfn` changes.

**Call-site delta: none.** All five loops already re-check their termination
condition and their deadline at the top of each iteration; a prompt-returning
read is exactly what makes those checks reachable. Only the stale comment
blocks change (`exec.sfn:348-363`, `pool.sfn:356-371`,
`dev_verify.sfn:415-420`, `capsule_emit_parallel.sfn:419-425`,
`capsules/sfn/os/src/mod.sfn:490-504`) — each currently ends with a sentence
asserting the deadline cannot fire, which becomes false.

Observation latency: one loop iteration reads both streams, so a deadline is
observed within ~2 × 25 ms = 50 ms plus scheduler slop. Against the 900 s
default (`exec.sfn:128-132`) that is 0.006%. Idle cost per silent child is
~80 `PeekNamedPipe` pairs/s — negligible, and only paid by a child that is
producing nothing.

`capsule_emit_parallel.sfn` gains nothing from Phase 1 (it has no deadline) and
loses only the parked wait, becoming a slow poll. Giving it a real deadline is
out of scope for SFN-1092; see §4.3.

### 4.2 Phase 2 — `process.handle_wait_readable` (seed-blocker)

The unifying primitive. Ships **alone**, `seed-blocker`, with no `compiler/src`
call site; the four compiler-source conversions follow after the seed pin.

```
process.handle_wait_readable(handle: int, timeout_ms: int) -> int
```

*Ready* means a subsequent `handle_read_bytes_*` returns without blocking —
bytes, or `""` at EOF. That is `poll(2)`'s `POLLIN|POLLHUP` restated in handle
terms.

| return | meaning |
|---|---|
| `-1` | error: `handle == 0`, or an internal allocation failure. Not fatal — the caller re-checks its own deadline and loops. |
| `0` | timeout: neither stream became ready within `timeout_ms`. |
| `1` | stdout ready |
| `2` | stderr ready |
| `3` | both ready |

`timeout_ms < 0` waits indefinitely; `0` polls and returns immediately.
A bitmask, not a single stream id, because both pipes routinely become ready in
the same pass — returning one would strand the other for an extra iteration.
Both-at-EOF returns `3`, so the caller's `(r & 1)` / `(r & 2)` reads fire, get
`""`, and the existing top-of-loop `at_eof` check ends the loop. No fourth
sentinel is needed.

POSIX body in `runtime/sfn/process.sfn`, next to `sfn_io_poll_any` (`:836`),
reusing this module's `poll` extern, `PollSlot` overlay, `SFN_EINTR`,
`_poll_err_retryable` and `_clamp_poll_timeout_ms`. It folds in the two facts
`poll` cannot see:

- a non-empty stash (offset 16 / 40) is ready *now*, no syscall;
- a closed fd (`stdout_fd < 0`) with an empty stash is ready (EOF).

Only when neither holds does it arm a two-slot `POLLIN` poll with the same
EINTR/Darwin-EAGAIN retry the existing bodies use.

This is a deliberate, contract-level *improvement* over today's POSIX loop, not
a regression: it removes the "re-fetch the fds every iteration because a read
clears them to `-1` at EOF" invariant from all five callers by making it
internal. If a zero-delta POSIX path is preferred, the conservative variant is
a bare two-slot poll over `h.stdout_fd` / `h.stderr_fd` with no stash/EOF fold
— but then the callers keep the invariant, which is most of what makes the
copy-paste fragile.

Windows body in `process_windows.sfn`: `_pw_h_wait_readable(h, timeout_ms)`,
the §4.1 bounded pump with `budget_ms = timeout_ms`, returning the bitmask from
`ogb.len > 0 || h_stdout_rd == 0` and the stderr twin. Once this lands, the
§4.1 fixed budget on `read_bytes_*` can revert to unbounded, restoring the
"empty ⇒ EOF" Windows contract, because the caller owns the deadline again.

Registration — two points, both verified as the complete set (`handle_kill`
appears in exactly these two files plus its call sites):

1. `compiler/capsules/codegen-llvm/src/runtime_helpers/registry_process.sfn`,
   after the `process.handle_kill` descriptor at `:196-198`:

   ```sfn
   descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor {
       target: "process.handle_wait_readable", symbol: "sfn_process_handle_wait_readable", return_type: "i64", parameter_types: ["i64", "i64"], native_signature: "sfn_process_handle_wait_readable", c_abi_return_type: null
   });
   ```

2. `compiler/capsules/ir/src/intrinsic_effects.sfn`, after `:85`:

   ```sfn
   table = append_intrinsic_effects(table, "process.handle_wait_readable", ["io"]);
   ```

   `["io"]`, not `["clock", "io"]`. `io.poll_readable` / `io.poll_any` (`:87-88`)
   also take a timeout and carry `["io"]` alone; only `run_capture_metered`
   (`:67`), which *measures* time, carries `clock`. Adding `clock` would force
   `![clock]` onto `_run_test_binary` and `_reap_test_child` (both `![io]`
   today) and transitively up the CLI for no capability the caller does not
   already have.

`compiler/capsules/codegen-llvm/src/lowering/lowering_helpers.sfn` needs
**no** entry: `process.handle_kill` and `process.handle_stdout_fd` are absent
from that always-declare list and link correctly, so `process.*` targets are
auto-collected from the emitted call lines. *Uncertain*: `io.poll_any` is in the
list (`:1501`) and the reason for the asymmetry is not documented. If a
separate-compilation module consuming the new builtin fails clang with "use of
undefined value", add
`helpers = append_unique_effect(helpers, "process.handle_wait_readable");`
beside `:1486`.

### 4.3 Rewritten call site (Phase 2), `exec.sfn:327-394`

```sfn
    let mut deadline_killed: boolean = false;
    let mut wait_errs: int = 0;
    let start_ms = monotonic_millis();
    loop {
        if process.handle_stdout_at_eof(h) && process.handle_stderr_at_eof(h) {
            break;
        }
        let mut wait_to: int = -1;
        if deadline_ms > 0 {
            let remaining: int = deadline_ms - ((monotonic_millis() - start_ms) as int);
            if remaining <= 0 {
                process.handle_kill(h);
                deadline_killed = true;
                break;
            }
            wait_to = remaining;
        }
        // `0` (timeout) and `-1` (error) both mean "nothing to read this
        // pass"; neither is fatal, so fall through to the deadline
        // re-check above. The guard bounds a persistently failing wait
        // when `deadline_ms <= 0`, where nothing else would.
        let ready = process.handle_wait_readable(h, wait_to);
        if ready <= 0 {
            if ready < 0 {
                wait_errs += 1;
                if wait_errs > 1024 {
                    process.handle_kill(h);
                    break;
                }
            }
            continue;
        }
        wait_errs = 0;
        if (ready & 1) != 0 {
            let chunk = process.handle_read_bytes_stdout(h, 65536);
            if chunk.length > 0 && !json_output { out_buf = out_buf + chunk; }
        }
        if (ready & 2) != 0 {
            let chunk = process.handle_read_bytes_stderr(h, 65536);
            if chunk.length > 0 {
                err_buf = err_buf + chunk;
                loop {
                    let nl = index_of(err_buf, "\n");
                    if nl < 0 { break; }
                    let line = substring(err_buf, 0, nl);
                    err_buf = substring(err_buf, nl + 1, err_buf.length);
                    _ingest_child_stderr_line(line, all);
                }
            }
        }
    }
```

Gone: `handle_stdout_fd` / `handle_stderr_fd` / `fds` / `io.poll_any` / the
`fds.length == 0` branch — 20 lines per site, 5 sites. The guard counter is new
at four of the five sites (only `capsules/sfn/os/src/mod.sfn:467` has one
today) and is required by `.claude/rules/code-style.md`.

`capsule_emit_parallel.sfn` converts the same way with `wait_to = -1` and keeps
its existing `poll_failures > 64` escape; a real deadline for emit children is
a separate issue, and if it is wanted it should ride **this** PR pair rather
than pay a second seed cut (`.claude/rules/seed-dependency.md`: cross an
unavoidable gate once).

## 5. Rejected alternatives

**A real Windows `io.poll_any`.** No. The fd is the leak, not the multiplexer.
Windows anonymous-pipe read ends are `HANDLE`s; mingw's `poll`/`WSAPoll` covers
sockets only, and `WaitForMultipleObjects` does not signal an anonymous pipe on
data-available. A genuine readiness wait would require rebuilding `_pw_spawn`'s
pipes as named pipes with overlapped I/O and events, then minting a synthetic
fd space with no lifetime owner, to reach an API that is strictly less
expressive than the handle-shaped one. Leave `sfn_io_poll_any`
(`process_windows.sfn:1642-1648`) as the `-1` stub and add one line to its
header pointing at `handle_wait_readable`.

**Encoding the handle into the fd accessors** so the existing `io.poll_any`
target could be reused with no seed gate. Rejected: it breaks the documented
`-1` contract at `process_windows.sfn:1509-1520`, which is pinned by
`compiler/tests/e2e/process_handle_windows_test.sfn:278-279` and
`compiler/tests/integration/process_stderr_stream_test.sfn:21-22`, and it makes
`io.poll_any` mean different things per platform — invisibly.

## 6. Backward compatibility

Nothing is removed. `handle_stdout_fd` / `handle_stderr_fd` keep their POSIX
bodies and their Windows `-1`; `io.poll_any` keeps both bodies; the POSIX
`process.sfn` framed reads are untouched in both phases. The only behavioural
delta is Phase 1's Windows `read_bytes_*` empty-return, scoped to a platform
whose callers already consult `*_at_eof`.

## 7. Test plan

A deadline test needs a child that is **silent and long-lived** without a
nested build. `sfn login` with no positional argument
(`compiler/src/cli/commands/login.sfn:105-124`) prints one line, then blocks in
`io.read_line(0)` until stdin closes — and `spawn_with_env` gives the child a
stdin pipe the parent never closes. Portable, zero-build, and it exercises the
harder path: the deadline must fire *after* bytes have already flowed.

Assert both `timed_out == true` **and** elapsed ≥ `deadline_ms`, so a child that
died early (e.g. if `read(2)` on fd 0 reported EOF under mingw) fails loudly
instead of passing vacuously. Cap the deadline at ~2 s; whole test ≈ 3 s.

- **New, Phase 1** — `capsules/sfn/os/tests/` (this drives site 5,
  `run_bounded`, on both platforms with no compiler-source change):
  `test "run_bounded: a silent child is killed at the deadline"`.
- **New, Phase 2** — `compiler/tests/integration/process_wait_readable_test.sfn`:
  zero-handle → `-1`; both-at-EOF → `3`; a child that has written → the right
  bit set; `timeout_ms = 0` on a silent child → `0`.
- **Must not regress**: `capsules/sfn/os/tests/handle_framed_stdio_test.sfn`
  (empty-at-EOF, blank-line-vs-EOF framing),
  `compiler/tests/integration/process_framed_stdio_test.sfn`,
  `compiler/tests/integration/process_stderr_stream_test.sfn`,
  `compiler/tests/e2e/process_handle_windows_test.sfn`.

Commands:

```
sfn fmt --write <touched files> && sfn fmt --check <touched files>
sfn check runtime/sfn/platform/process_windows.sfn
make compile
build/bin/sfn test capsules/sfn/os/tests/handle_framed_stdio_test.sfn
build/bin/sfn test compiler/tests/integration/process_framed_stdio_test.sfn
build/bin/sfn test compiler/tests/integration/process_stderr_stream_test.sfn
```

Windows leg: the deadline behaviour is only observable on a Windows runner, so
the acceptance evidence is the Windows CI job, not a local Linux run.

## 8. Boundary — what this does not fix

`compiler/tests/e2e/build_json_schema_test.sfn` wedges on Windows for a reason
not diagnosed here. Phase 1 makes that wedge *survivable* — the runner kills it
at the deadline and reports 124 — not *correct*. SFN-1092 closes on "a silent
child is killed at its deadline on Windows"; the wedge is a separate issue and
must not be folded into this one's acceptance.
