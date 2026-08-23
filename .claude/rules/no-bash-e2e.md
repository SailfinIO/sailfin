E2E tests are Sailfin `*_test.sfn` files using the `sfn/test` capsule — **never**
bash scripts. The `compiler/tests/e2e/*.sh` surface grew 38 → 122 because
dropping in a new `.sh` "just works"; that era is closed (#842 / #840). There is
no `.sh` surface, no shell-e2e compatibility command, and no allowlist that
would make a new one
acceptable. Everything the old hold-outs needed bash for — `curl`/`uname` shims,
tar/jq inspection, `ulimit`/`cwd` control — is reachable from an `![io]` test
that drives the subprocess via `process.run_capture`.

**Full pattern reference: `docs/conventions/e2e-tests.md`** (subprocess driving,
shims, C harnesses, temp dirs, env/cwd threading). Read it before writing one.

Two traps worth knowing up front, because both are **pool-only** — they pass a
serial local run and fail under CI's parallel `--jobs N`:

- **A test that spawns a build must isolate it.** Compiles write the top-level
  module's IR to `<cache-dir>/program.ll`, defaulting to a fixed `build/sailfin`,
  so concurrent builds overwrite each other and produce cross-contaminated
  binaries. Thread `SAILFIN_TEST_SCRATCH` — and `PATH`, since `run_capture`'s
  empty env is *empty*, not inherited, and the nested build needs `clang` and its
  linker.
- **A nested `sfn test`/`build`/`run` must not thread raw `process.environ()`.**
  It carries the parent pool's orchestration keys and binds the child to the
  parent's private state. Use
  `clean_runner_env(nested_runner_scratch("<label>"))` from `sfn/test` (SFN-401).
