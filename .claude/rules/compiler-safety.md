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

**Timeouts still apply** — the memory budget does not guard against hangs. Wrap
single-file invocations with `timeout 60`; `make` targets handle their own.

**Sanitizers are incompatible with any finite address-space cap** — ASAN reserves
~16 TB of virtual address space and aborts before `main()` under the cap. A
sanitizer leg needs both `SAILFIN_MEM_LIMIT=unlimited` and an uncapped shell, and
must *skip* (not fail) when the runtime won't start. Full procedure:
`docs/conventions/sanitizer-tests.md`.
