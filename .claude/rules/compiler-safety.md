When running the Sailfin compiler (build/native/sailfin) or any make target that invokes it:

- Always set `ulimit -v 8388608` before the command to cap memory at 8GB
- Always wrap compiler invocations with `timeout` (60s for single files, no limit needed for make targets which handle their own timeouts)
- Never run the compiler without a memory cap — runaway compilation can crash the entire WSL instance and IDE
- **macOS exception:** Darwin does not honor `ulimit -v` (RLIMIT_AS) — `ulimit -v 8388608` fails with "setrlimit failed: invalid argument". The `check-ulimit.sh` hook therefore skips enforcement on macOS, and the cap is unenforceable there; the rule above is load-bearing on Linux/WSL only.

**Sanitizers (ASAN/TSAN) are incompatible with `ulimit -v`.** AddressSanitizer
reserves ~16 TB of *virtual* address space for its shadow memory at startup
(ThreadSanitizer uses the same shadow-reservation model). Under any `ulimit -v`
cap that reservation aborts before `main()` runs, with
`ReserveShadowMemoryRange failed ... Perhaps you're using ulimit -v`. Because
the 8 GB vmem cap above is mandatory for every compiler/test invocation on
Linux, **sanitizer-instrumented binaries can never run in capped CI or capped
local shells.** This is not a use-after-free or a sanitizer finding — it is the
cap killing the process at startup (it burned a CI cycle on PR #1262, e2e-sh-1,
before being diagnosed).

Tests that want a sanitizer leg must therefore:

- **Gate the sanitizer run on `ulimit -v` reporting `unlimited`** and skip
  (not fail) otherwise — the plain, uninstrumented run still provides coverage.
  Reference pattern in `compiler/tests/e2e/test_escape_promotion_boundaries.sh`:

  ```bash
  vmem_cap="$(ulimit -v 2>/dev/null || echo unlimited)"
  if [ "$vmem_cap" != "unlimited" ]; then
      echo "[test]   virtual-memory cap active (ulimit -v ${vmem_cap}) — ASAN shadow reservation cannot run; plain roundtrip still passed"
      return 0
  fi
  ```

- **Only a genuine `ERROR: AddressSanitizer:` report may fail the test.** A
  failure to start the sanitizer runtime (missing compiler-rt archives, or the
  vmem cap above) is a skip, not a failure.
