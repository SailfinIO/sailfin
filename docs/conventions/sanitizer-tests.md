# Sanitizer (ASAN/TSAN) test legs

Sanitizers cannot run under a finite address-space cap. The memory-budget
contract itself is in `.claude/rules/compiler-safety.md`; this is the full
procedure for writing a sanitizer leg.

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

- **Skip the sanitizer leg unless ASAN actually starts** — the plain,
  uninstrumented run still provides coverage. The native e2e tests are
  `*_test.sfn` and cannot read `ulimit -v`, so the pattern (see
  `compiler/tests/e2e/runtime_memory_arena_test.sfn` and
  `escape_promotion_channel_send_test.sfn`) is: build with
  `-fsanitize=address`; if the build fails → skip; run with
  `SAILFIN_MEM_LIMIT=unlimited` and `ASAN_OPTIONS=detect_leaks=0` in the
  child env; if the run exits non-zero **with** an `ERROR: AddressSanitizer:`
  line → fail; any other non-zero exit (the shadow reservation aborting at
  startup under a vmem cap, or a missing compiler-rt runtime) → skip.

  ```sfn
  let exit = process.run_capture([asan_bin], _asan_env());  // SAILFIN_MEM_LIMIT=unlimited
  let out = process.capture_take_stdout();
  let err = process.capture_take_stderr();
  if exit != 0 && contains(out + err, "ERROR: AddressSanitizer:") {
      assert false;  // a genuine sanitizer finding
  }
  // otherwise: clean run or a startup/abort skip — both pass.
  ```

- **Only a genuine `ERROR: AddressSanitizer:` report may fail the test.**
  A failure to start the sanitizer runtime (missing compiler-rt archives,
  or a vmem cap) is a skip, not a failure.
