# SFN-1073 — Bounding the opportunistic update check to 500 ms

Design gate for SFN-1073, under SFEP-0073 §3.6 / §4 / §8. Genre is a
single-issue design note, not an SFEP (`.claude/rules/proposals.md`): SFEP-0073
already carries the feature design; this note decides exactly one mechanism —
how `sfn` performs a single signed-index request bounded to **500 ms of total
additional wall time including DNS, connect, TLS, and body read**.

It decides nothing else. The policy gate, TTY/CI suppression, lease,
eligibility timestamp, and notice text are SFEP-0073 §3.6 and out of scope here.

---

## 1. Decision

**Out-of-process deadline.** The command that is eligible to notify spawns a
child `sfn` that performs the whole check, polls it against a
`monotonic_millis()` deadline, and `SIGKILL`s it at 500 ms. This is the
`_dv_run_bounded` pattern (`compiler/src/cli/commands/dev_verify.sfn:348`) and
`_reap_test_child` (`compiler/src/cli/commands/test/pool.sfn:309`), narrowed.

Rejected: threading a deadline through the HTTP path (§4) and sub-second socket
timeouts (§5). The first is a seed-blocker that also cannot bound DNS; the
second cannot bound wall time at all.

## 2. Why the bound is real, including DNS

`sfn_process_handle_kill` sends signal `9`
(`runtime/sfn/process.sfn:1925`). `SIGKILL` is not blockable and not deferrable
by a thread parked in `getaddrinfo`, `connect`, an OpenSSL handshake, or `recv`.
The bound therefore does not depend on any property of the HTTP client — it is
enforced by the kernel against a process that has no other work to protect.

The parent starts the clock *before* `process.spawn_with_env`, so process
creation, dynamic linking, and CLI startup are charged against the same 500 ms
rather than added to it. The user-visible worst case is 500 ms plus the reap
(`handle_wait` on an already-killed pid).

The check is a single leaf process: the child does no spawning on this path, so
there are no grandchildren to orphan past the kill.

Deadline observability by platform:

- **POSIX** — the poll loop blocks in `io.poll_any(fds, remaining)`
  (`runtime/sfn/process.sfn:836`), which returns at the remaining budget.
- **Windows** — `sfn_io_poll_any` is implemented over HANDLEs
  (`runtime/sfn/platform/process_windows.sfn:2265`); the framed-read fallback is
  bounded by `PW_FRAMED_POLL_BUDGET_MS`, so the deadline check is reached
  (SFN-1092). `handle_kill` is `TerminateProcess`
  (`runtime/sfn/platform/process_windows.sfn:2146`).

The honest claim is therefore the full acceptance criterion as written in
SFEP-0073 §8 — *a timeout adds no more than 500 milliseconds* — with no carve-out
for DNS. What is **not** claimed is that the network operation is *cancelled*
gracefully: it is terminated. A killed child may have an open socket and a
half-written cache temp file; both are reclaimed by the OS, and the cache write
is atomic (§3), so a kill can never publish torn state.

## 3. Shape

Parent (the eligible command's epilogue, after the lease and the eligibility
advance SFEP-0073 §3.6 already specifies):

1. Resolve the self executable — the `_resolve_test_self_path(binary_dir)`
   pattern in `compiler/src/cli/commands/test/exec.sfn`, preferring
   `ctx.compiler_path` when the driver prefix set it.
2. `start = monotonic_millis()`, then `process.spawn_with_env(argv, env)`.
3. Poll for child EOF or deadline; on overrun `process.handle_kill(handle)`.
4. `process.handle_wait(handle)` unconditionally — the sole reaper, even after a
   kill, or the child is left a zombie.
5. On a clean, in-budget exit, parse the child's single stdout line and emit the
   notice. Any other outcome — timeout, non-zero exit, unparsable line — is
   silent and does not touch the command's exit status.

Child: a hidden, unlisted `toolchain` leaf (precedent: the unlisted `guillermo`
registration noted at `compiler/src/cli/main.sfn:138`). It fetches and verifies
the signed index through the existing `toolchain_fetch_index`
(`compiler/src/toolchain/install.sfn:601`), writes the cache/advisory state via
temp-file + atomic rename, prints one machine-readable line, and exits.

**The child must not re-dispatch.** Two routers sit in front of a `toolchain`
argv:

- Project/default selection (rank 3/4) is already excluded — `head == "toolchain"`
  returns false from `_v2_project_selection_applies`
  (`compiler/src/cli/main.sfn:~430`). No project pin can make the child re-exec.
- Management routing (SFEP-0073 §3.5) *does* claim any `toolchain`-headed argv
  (`toolchain_is_management_prefix`, `compiler/src/toolchain/management.sfn:275`).
  Exclude the hidden leaf there the same way `entry-version` is excluded, rather
  than by setting `SAILFIN_TOOLCHAIN_DISPATCHED` in the child env
  (`management.sfn:407`) — the marker means "I was dispatched into", and lying
  with it would also suppress routing for anything the leaf later grows.

With both suppressed, the child pays one `execve` and CLI startup and nothing
else. Measured on this container, warm: `sfn --version` is 10 ms, ~2% of the
budget. Cold start on a user machine is worse — assume 50–100 ms — which still
leaves 400 ms for a small signed index over a healthy link, and the failure mode
of a slow link is silence, which SFEP-0073 §3.6 already mandates. The
recommendation does not turn on the exact figure: it degrades continuously into
"no notice this week", never into a slow command.

## 4. Rejected: a deadline threaded through the HTTP path

Would require a new/extended runtime helper (`sfn_http_download` plus a budget
parameter, `runtime/sfn/adapters/http.sfn:1954`), a new
`RuntimeHelperDescriptor`
(`compiler/capsules/codegen-llvm/src/runtime_helpers/registry_values.sfn:333`),
and an entry in `builtin_member_arity`
(`compiler/capsules/analyzer/src/typecheck/call_signature.sfn:167`).

That is a compiler capability whose only consumer is
`compiler/src/toolchain/install.sfn:154` — and `compiler/src/` is compiled by the
**pinned seed**, not by the freshly built compiler. Bundling does not help. The
precedent is recorded in the runtime itself, at
`runtime/sfn/process.sfn:1423`: `spawn_with_env_cwd` was added as *a new symbol,
not a wider `spawn_with_env`*, precisely so "the existing 2-arg builtin keeps its
arity (no seed cut) — only the freshly-built compiler emits this 3-arg call,
exclusively from `sfn/os`." A compiler-source consumer has no such escape.

It also would not deliver the guarantee. `_host_ip4` → `_resolve_dns`
(`runtime/sfn/adapters/http.sfn:341`) calls blocking `getaddrinfo` with no
timeout knob; `_connect_tcp_ex` (line 486) can resolve twice per hop (two
sockaddr layouts), and `_http_send_rc` (line 1161) follows up to 5 redirects. A
between-stages deadline check would observe an overrun only *after* the blocking
call returned. Bounding DNS in-process needs either a resolver rewrite
(non-blocking UDP DNS) or a thread — Sailfin exposes neither today.

## 5. Rejected: sub-second socket timeouts

`_http_io_timeout_secs()` (`runtime/sfn/adapters/http.sfn:402`) arms
`SO_RCVTIMEO`/`SO_SNDTIMEO`, which bound **one** `recv`/`send`, not the request.
A drip-feeding server resets the timer on every byte, so the recv loop is
unbounded in wall time; up to 6 requests (1 + 5 redirect hops) multiply it; and
`getaddrinfo` is not covered at all. It is also a module-global shared by every
HTTP caller in the compiler — including `sfn add`
(`compiler/src/cli/commands/add.sfn:109`) and toolchain installs, for which 500 ms
is a regression, not a fix. Refuted as a mechanism; unchanged by this issue.

## 6. Seed dependency and delivery shape

**Does not trip `.claude/rules/seed-dependency.md`.** Every primitive the design
uses — `process.spawn_with_env`, `handle_kill`, `handle_wait`,
`handle_std*_fd`/`_at_eof`, `handle_read_bytes_*`, `io.poll_any`,
`monotonic_millis`, `fs.*` — is already registered and already called from
`compiler/src/` today by `dev_verify.sfn` and `test/pool.sfn`. No new builtin, no
new descriptor, no `builtin_member_arity` row, no runtime-source call to a
capability the seed lacks. The runtime-source carve-out does not fire because no
runtime source changes at all.

SFN-1073 lands as **one ordinary bundled PR**, no `seed-blocker`, no
`## Required in pinned seed`.

## 7. Effect signature

SFEP-0073 §4 requires that `sfn --version` not acquire `net` merely because
update support exists. The mechanism satisfies this **structurally**: the parent
path is `![clock, io]` — the same effect row `_dv_run_bounded` carries — because
the network lives in a different process. The `![clock, io, net]` row stays on
the child leaf and on `toolchain_fetch_index`, where SFEP-0073 §4 already places
it.

This is worth stating plainly rather than treating as a win to bank: process
spawn is an existing `io`-level authority in this language (`sfn build` spawns
`clang` the same way), and the effect system's boundary is the process. The
mechanism does not weaken any claim the effect system makes; it also does not
strengthen one, and the notice hook must not be sold as "net-free" beyond what
that boundary already means.

## 8. Verification

- Unit: deadline arithmetic and child-line parsing —
  `build/bin/sfn test compiler/tests/unit/<...>_test.sfn -k <name>`.
- E2E (`![io]`, `process.run_capture`, per `.claude/rules/no-bash-e2e.md`):
  point the release base override at a black-hole endpoint, run an eligible
  command, and assert (a) elapsed wall time under a ~1 s ceiling, (b) the
  command's exit status and stdout are byte-identical to the same command with
  the check disabled, (c) no notice is printed. Isolate with
  `clean_runner_env(nested_runner_scratch("<label>"))`.
- A connect-hang case (non-routable address) and an accept-then-never-respond
  local listener cover the two deterministically reproducible stalls; the DNS
  stall is covered by construction (§2) rather than by a flaky resolver fixture.
- Then `sfn dev bootstrap build`, and `sfn fmt --check` on touched files.
