The compiler manages its own memory budget — **no caller-side prefix is needed.**

Every `sfn` invocation self-applies an **8 GiB `RLIMIT_AS`** at startup on Linux
(`runtime/sfn/platform/rlimit.sfn`, from `fn main` in `cli/entry.sfn`), inherited
by child processes (per-module emit, `clang`, `llvm-link`). Compiled user
programs are not capped — only the toolchain self-caps. The historical
`ulimit -v` prefix ritual and its enforcing hook are retired.

- `SAILFIN_MEM_LIMIT=<bytes>` overrides the default (bytes only, no K/M/G;
  values under 1 MiB are rejected as misconfiguration).
- `SAILFIN_MEM_LIMIT=unlimited` (or `off`/`0`) disables the cap. **Never disable
  it for ordinary builds or tests** — uncapped memory regressions have killed CI
  runners and WSL instances outright (#1245).
- An inherited external cap always wins; the compiler never loosens it.
- `SAILFIN_TRACE_MEM_LIMIT=1` prints the decision to stderr.
- **macOS:** Darwin ignores `RLIMIT_AS`, so the cap is a no-op there. The budget
  is load-bearing on Linux/WSL only.

**The cap bounds a process, not a fleet — it does not make a parallel suite
safe.** `N` concurrent `sfn` children each self-apply their own 8 GiB cap, so
the aggregate ceiling is `N x 8 GiB`, and nothing enforces it. Any fan-out must
budget host RAM itself: `_test_jobs_budget`
(`compiler/src/cli/commands/test/arg_and_jobs.sfn`) and its bash twin
`scripts/detect_test_jobs.sh` reserve **3 GiB/job out of (80% of RAM - 5 GiB)**
for the test pool — 3 GiB matches a measured pooled test child, and the 5 GiB
term reserves the parent runner itself (SFN-781). `_cr_ram_budget_jobs`
(`compiler/src/capsule_emit_parallel.sfn`) sizes the per-module emit fan-out
separately and unchanged, still **2.5 GiB/job out of 66% of RAM** (SFN-626) —
the two fan-outs are deliberately sized against different workloads. Pooled
test children are pinned to `SAILFIN_BUILD_JOBS=1` so the two fan-outs cannot
nest and multiply (SFN-547). Never raise a job count past those budgets on the
theory that the self-cap will catch it; it will not, and the failure mode is a
hard host kill, not an `sfn` error.

**Timeouts still apply** — the memory budget does not guard against hangs. Wrap
single-file invocations with `timeout 60`; `make` targets handle their own.

**Sanitizers are incompatible with any finite address-space cap** — ASAN reserves
~16 TB of virtual address space and aborts before `main()` under the cap. A
sanitizer leg needs both `SAILFIN_MEM_LIMIT=unlimited` and an uncapped shell, and
must *skip* (not fail) when the runtime won't start. Full procedure:
`docs/conventions/sanitizer-tests.md`.
