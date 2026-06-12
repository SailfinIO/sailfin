The compiler manages its own memory budget — no caller-side prefix is needed.

On Linux, every `sfn` invocation self-applies an **8 GiB `RLIMIT_AS`** at
startup (`runtime/sfn/platform/rlimit.sfn`, called from `fn main` in
`compiler/src/cli_main.sfn`) so a runaway compile cannot exhaust the host.
The limit is inherited by child processes (per-module emit subprocesses,
`clang`, `llvm-link`). Compiled user programs are not capped — only the
toolchain self-caps. The historical `ulimit -v 8388608` prefix ritual and
the PreToolUse hook that enforced it are retired.

The contract:

- `SAILFIN_MEM_LIMIT=<bytes>` overrides the default (bytes only, no K/M/G
  suffixes; values < 1 MiB are rejected as misconfiguration and the
  default is kept).
- `SAILFIN_MEM_LIMIT=unlimited` (or `off` / `0`) disables the self-cap.
  Never disable it for ordinary builds or tests — it exists because
  uncapped memory regressions have killed CI runners and WSL instances
  outright (issue #1245).
- An inherited external cap (`ulimit -v` in a CI step or user shell)
  always wins — the compiler never loosens it.
- `SAILFIN_TRACE_MEM_LIMIT=1` prints the decision to stderr.
- **macOS:** Darwin does not honor `RLIMIT_AS`, so the self-cap is a
  no-op there (gated on a `/proc` probe) — the same platform scope the
  old `ulimit -v` rule had. The budget is load-bearing on Linux/WSL only.

**Timeouts still apply.** Wrap single-file compiler invocations with
`timeout 60` (e.g. `timeout 60 build/native/sailfin run file.sfn`) — the
memory budget does not guard against hangs. `make` targets handle their
own timeouts.

**Transition caveat:** the pinned seed predates the self-cap, so
`make compile` / `make rebuild` runs the seed uncapped until the next
`/pin-seed` carries `runtime/sfn/platform/rlimit.sfn`. CI workflows keep
their step-level `ulimit -v 8388608` lines as defense in depth until then.

**Sanitizers (ASAN/TSAN) are incompatible with any finite address-space
cap.** AddressSanitizer reserves ~16 TB of *virtual* address space for its
shadow memory at startup (ThreadSanitizer uses the same shadow-reservation
model). Under the self-cap or any external `ulimit -v`, that reservation
aborts before `main()` runs, with `ReserveShadowMemoryRange failed ...
Perhaps you're using ulimit -v`. Sanitizer-instrumented runs therefore
need **both** `SAILFIN_MEM_LIMIT=unlimited` **and** an uncapped shell.
This is not a use-after-free or a sanitizer finding — it is the cap
killing the process at startup (it burned a CI cycle on PR #1262,
e2e-sh-1, before being diagnosed).

Tests that want a sanitizer leg must therefore:

- **Gate the sanitizer run on `ulimit -v` reporting `unlimited`** and skip
  (not fail) otherwise — the plain, uninstrumented run still provides
  coverage. Reference pattern in
  `compiler/tests/e2e/test_escape_promotion_boundaries.sh`:

  ```bash
  vmem_cap="$(ulimit -v 2>/dev/null || echo unlimited)"
  if [ "$vmem_cap" != "unlimited" ]; then
      echo "[test]   virtual-memory cap active (ulimit -v ${vmem_cap}) — ASAN shadow reservation cannot run; plain roundtrip still passed"
      return 0
  fi
  ```

  (Sanitizer legs should also export `SAILFIN_MEM_LIMIT=unlimited` so the
  instrumented binary's own self-cap does not abort the shadow
  reservation.)

- **Only a genuine `ERROR: AddressSanitizer:` report may fail the test.**
  A failure to start the sanitizer runtime (missing compiler-rt archives,
  or a vmem cap) is a skip, not a failure.
