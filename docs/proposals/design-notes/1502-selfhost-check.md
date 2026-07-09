# `sfn` owns triple-pass self-host validation (SPIKE for #1502)

**Status:** Accepted (design gate passed 2026-06-26) — implemented in the #1502 PR.
**Issue:** #1502 "feat(check): sfn owns stage2/stage3 fixed-point self-host validation" (epic #513, Phase 1).
**Author:** compiler-architect spike, 2026-06-26.
**Kind:** single-issue implementation design gate (per `.claude/rules/proposals.md` — design-notes, not a numbered SFEP).

---

## Design gate decisions (ratified 2026-06-26)

The owner ratified the spike with two refinements to §1/§8:

- **O1 — grammar:** `sfn selfhost` (the new verb), **but exposed as an
  internal/undocumented command** — it is NOT added to `_usage()` (the
  user-facing `sfn --help`). Rationale: Go (`cmd/dist`, reachable only via
  `go tool dist`) and Rust (`x.py` / `src/bootstrap`) both keep self-host
  validation out of the public compiler CLI; an end user compiling their own
  capsule has no reason to run it. Epic #513's "`sfn` owns the logic" mandate is
  still satisfied (the logic moves from bash into type/effect-checked Sailfin
  that self-hosts) — it is simply undocumented. The verb still works for anyone
  who types it; it is just not advertised. This supersedes the spike's §1 plan to
  add a `self-hosting:` section to `_usage()`.
- **O2 — mismatch severity:** **preserve today's warn-default**; a fixed-point
  mismatch prints the per-module divergence and exits 0 (so `make check` stays
  green, parity with `Makefile:607`). `--strict` opts into a hard non-zero exit.
  Because the default is warn, folding the binary-sha comparison into the diff
  (the "strictly stronger" check, §4) is safe: a benign binary-only divergence is
  a non-fatal info line, never a build break.
- **O4 — AC wording:** flagged to the issue author on the PR (the "one-line"
  criterion is reworded to "the build/diff/promote core is one `sfn selfhost`
  call; the suite legs + first-pass `make compile` stay Make-driven").

Implementation deltas from the spike body below: the timeout flag is
`--smoke-timeout SECS` (default 10) and wraps only the smoke gate (the Makefile
never wrapped the stage builds); the new module is `compiler/src/cli_selfhost.sfn`
(a peer of `cli_check.sfn`), exporting `handle_selfhost_command`.

This note closes the three spike questions from epic #513 Risk 2, settles the
command grammar (now that #351 is dead), fixes the orchestration and per-stage
isolation model, and specifies the `check-impl` end-shape so any
acceptance-criterion drift can be flagged to the issue author before code.

---

## 0. TL;DR resolutions

- **Grammar:** a **new verb `sfn selfhost`**, NOT `sfn check --selfhost`.
  `sfn check` is contractually "no codegen, no clang, no link" (the fast static
  analyzer); a triple full-build belongs under its own verb. (D1/Q-grammar.)
- **Q1 (scratch roots):** `sfn selfhost` **owns the paths internally** under a
  single `--work-dir` root (default `build/selfhost`), deriving
  `<root>/native-seedcheck/scratch` and `<root>/native-stage3/scratch`. It
  redirects the per-module `.ll` scratch by setting `SAILFIN_TEST_SCRATCH` **on
  each child** via the established `sh -c "VAR=… <cmd>"` env-injection vehicle —
  the same mechanism `_emit_runtime_sfn_source` already uses (`cli_main.sfn:1197`).
- **Q2 (three binaries):** `sfn selfhost` **shells out to the produced binaries
  as subprocesses**, exactly as the Makefile does — it does NOT self-invoke for
  the stage builds. First-pass build stays in Make (`make compile`); `selfhost`
  drives stage2 (built by the first-pass binary = the running `sfn`'s sibling)
  and stage3 (built by the stage2 binary). Children inherit the 8 GiB
  `RLIMIT_AS`; each sub-build is wrapped with a timeout.
- **Q3 (suite legs):** **CONFIRMED** — suite legs stay Make-driven this pass.
  `sfn selfhost` owns **build + fixed-point diff + promote**. `check-impl`
  becomes: `make compile` → `make test` (first-pass) → **one `sfn selfhost`
  call** → `make test` (seedcheck). The "one-line" acceptance criterion is true
  *of the selfhost core only*; flag the wording (see §6).

---

## 1. Grammar decision (D1): `sfn selfhost`, not `sfn check --selfhost`

`#351` (CLI modularization) was closed `not_planned` on 2026-06-26, so the
"coordinate final grammar with #351" instruction in the issue body is void; we
settle it here.

**Three candidates considered:**

| Candidate | Verdict |
|---|---|
| `sfn check --selfhost` | **Rejected.** `sfn check` (`cli_check.sfn:178 handle_check_command`) is the fast static analyzer: parse + typecheck + effect-check, **no codegen, no clang, no link** (`Makefile:634-648` documents this contract explicitly; CLAUDE.md's validation ladder makes it load-bearing). Bolting three full self-host builds + clang links + a binary promotion onto `check` violates that contract semantically — a user running `sfn check --selfhost` on their capsule would be astonished. The flag would also need `--work-dir`/timeout plumbing that `check` has no other use for. |
| `sfn build --selfhost-check` | **Rejected.** `sfn build` builds *one* artifact from *one* input. Selfhost is a fixed-`-p compiler`, three-binary, fixed-point *meta-build* — it has no single `-o` output in the `build` sense (it promotes seedcheck over the canonical binary). Overloading `build` muddies the determinism precedent (`build --check-determinism`) which IS a single-input double-build. |
| **`sfn selfhost`** | **Chosen.** A distinct verb whose noun *is* "validate the compiler self-hosts." Mirrors `make check`'s intent name. It is compiler-specific by definition (`-p compiler` is implicit), so it carries no general-purpose-build baggage. New verbs are cheap here (the dispatch is a flat `strings_equal(cmd, …)` ladder in `cli_main.sfn:1987-1996`); this is not a keyword. |

**Settled surface:**

```
sfn selfhost [--work-dir DIR] [--first-pass BIN] [--seedcheck-out BIN]
             [--stage3-out BIN] [--promote-to BIN] [--timeout SECS]
             [--json] [--no-promote]
```

Defaults reproduce the current Makefile paths byte-for-byte:
- `--work-dir build/selfhost`
- `--first-pass build/bin/sfn` (the binary `make compile` produced; also
  the running `sfn` — but we take it as a flag so the seed-vs-self distinction
  is explicit and testable)
- `--seedcheck-out build/bin/sfn-seedcheck`
- `--stage3-out build/bin/sfn-stage3`
- `--promote-to build/bin/sfn`
- `--timeout` = unset (no per-build timeout) unless provided; Make threads its
  `TIMEOUT_CMD` budget in.

Help text is added to `_usage()` (`cli_main.sfn:161`) under a new
`self-hosting:` section.

---

## 2. Q1 — per-stage scratch roots and `.ll` redirection

### Who owns the paths
`sfn selfhost` owns them. It derives, under `--work-dir`:
- stage2: `<work_dir>/native-seedcheck`, scratch `<work_dir>/native-seedcheck/scratch`
- stage3: `<work_dir>/native-stage3`, scratch `<work_dir>/native-stage3/scratch`

It `mkdir -p`s each stage dir and **deletes any pre-existing
`scratch/capsules/*.ll`** before that stage's build (reproducing
`Makefile:559-561` and `592-594`), so a stale `.ll` from a prior run can't
poison the fixed-point hash.

### How the `.ll` scratch is redirected from *inside* the driver
This is the load-bearing subtlety. The per-module `.ll` scratch root is **not**
controlled by `--work-dir`. It is resolved by
`capsule_resolver.sfn:461 _cr_scratch_root()`, which reads the
`SAILFIN_TEST_SCRATCH` env var (via a `printf` shell read) and falls back to
`build/sailfin`. For the compiler self-host the `[capsule].name` is `"sailfin"`
(single-segment), so every module takes the **legacy flat path**
`_cr_legacy_ll_path` → `<SAILFIN_TEST_SCRATCH>/capsules/<mangled>.ll`
(`capsule_resolver.sfn:473-475`). `--work-dir` alone leaves this at
`build/sailfin/capsules/`, which is exactly why the Makefile sets
`SAILFIN_TEST_SCRATCH` per stage — without it stage3 would clobber stage2's
`.ll` and the hash-diff would be vacuous (the Makefile comment at
`:546-550` says exactly this).

**Mechanism:** `sfn selfhost` does NOT try to set its *own* env (process-global
`setenv` is unsound and the runtime exposes no `with_env`). Instead it sets
`SAILFIN_TEST_SCRATCH` **on the spawned child** through the existing
`sh -c "SAILFIN_TEST_SCRATCH=<quoted> <self_exe> build …"` vehicle — the exact
pattern `_emit_runtime_sfn_source` (`cli_main.sfn:1197-1207`) and
`_emit_runtime_capsule_object` (`:1293-1301`) already use to clear toggles for
children. The scratch value is `_shell_single_quote_arg`-escaped
(`cli_commands_utils.sfn:512`). This keeps the driver *pure orchestration* — it
sets a child's environment, it does not post-process any emitted artifact.

> Alternative considered and rejected: adding a `--ll-scratch DIR` flag to
> `sfn build` that overrides `_cr_scratch_root`. That is a cleaner long-term
> API than reading an env var, **but** it expands the `build` subcommand surface
> and the resolver plumbing in the same PR, breaking the "minimize scope" lean.
> Recommend it as a **follow-up** (see §8 open question O3); this pass uses the
> env vehicle that already works in the Makefile.

---

## 3. Q2 — driving three binaries that are produced mid-run

### Model: subprocess orchestration, no self-invoke for stage builds
`sfn selfhost` is invoked *after* `make compile` has produced the first-pass
binary. The orchestration is a straight port of the Makefile data-flow:

1. **First-pass binary** = `--first-pass` (already on disk; `make compile` built
   it). `selfhost` does NOT build it.
2. **Stage2 (seedcheck) build:** spawn
   `sh -c "SAILFIN_TEST_SCRATCH=<s2-scratch> <first_pass> build --no-cache -p compiler --work-dir <s2-dir> -o <seedcheck-out>"`.
   The orchestrator may itself BE the first-pass binary (`make compile`
   promotes it to `build/bin/sfn`), but it still spawns the named binary
   as a subprocess rather than re-entering its own `build` codepath — this keeps
   the three stages as three honest, separately-resolvable binaries (mirrors
   `_run_determinism_pass2`'s "spawn the resolved self_exe" model,
   `cli_main.sfn:573-599`).
3. **Smoke gate:** spawn `<seedcheck-out> run examples/basics/hello-world.sfn`,
   capture stdout+stderr via `process.run_capture` + `capture_take_*`, assert
   the output contains `Hello, Sailfin!` (port of `Makefile:566-580`). Use
   `run_capture` here (not `process.run`) because we need to inspect output.
4. **Stage3 build:** spawn
   `sh -c "SAILFIN_TEST_SCRATCH=<s3-scratch> <seedcheck-out> build --no-cache -p compiler --work-dir <s3-dir> -o <stage3-out>"`.
   Note the **stage2 binary** drives stage3 (`Makefile:595-598`).
5. **Fixed-point diff** (§4).
6. **Promote** `<seedcheck-out>` → `<promote-to>` unless `--no-promote`
   (port of `Makefile:629-632`).

### Memory + timeout
Children inherit the parent's 8 GiB `RLIMIT_AS` automatically
(`.claude/rules/compiler-safety.md`; `runtime/sfn/platform/rlimit.sfn` sets it in
`fn main`, inherited by `posix_spawn` children). For a per-build wall-clock
guard, when `--timeout SECS` is set the child argv is wrapped as
`sh -c "SAILFIN_TEST_SCRATCH=… timeout <SECS> <self_exe> build …"` (the Makefile
already owns `TIMEOUT_CMD` and passes `--timeout` through). `timeout` absence is
tolerated (Make passes nothing → no wrapper), matching `Makefile:568-572`.

### Why not self-invoke
Self-invoking (calling the in-process `build` handler in a loop) would (a) reuse
the *running* binary for all three stages, defeating the entire point of
stage2≠stage1 / stage3-built-by-stage2 fixed-point reasoning, and (b) share
arena/global state across "stages." Subprocess spawning is the only model that
preserves the bootstrap semantics.

---

## 4. Fixed-point diff — reuse vs. new

The Makefile's fixed-point check is an **aggregate hash of all `*.ll` under each
stage's `scratch/capsules`** (`Makefile:600-623`): sort per-file hashes,
hash-of-hashes, compare; on mismatch, per-file short-hash divergence + "missing
in stage3".

**Can we reuse `--check-determinism`'s machinery?** Partially:

- **Reuse the rendering/diff *shape*:** `DeterminismDiff` /
  `DeterminismModuleDiff` and `determinism_diff_to_text/json`
  (`build_report.sfn:333-348, 455-529`) are a good fit and unit-tested. We can
  populate a `DeterminismDiff`-shaped result and render it the same way for
  consistent `--json`.
- **Do NOT reuse `compare_for_determinism` as-is for the snapshot source.** It
  keys modules on the **sidecar `manifest.json` slug+cache_key**
  (`build_report.sfn:399`, fed by `_read_sidecar_modules`,
  `cli_main.sfn:615`). The compiler self-host emits **no sidecar** (`name =
  "sailfin"` is single-segment → `_sidecar_path_for_capsule` returns `""`,
  `cli_main.sfn:403-408`), so `--check-determinism` on the compiler degrades to a
  pure binary-sha256 compare. That is strictly weaker than the Makefile's
  per-`.ll` hash diff and would lose the per-module divergence report.

**Decision:** add a **new snapshot loader** that enumerates `*.ll` under a stage's
`scratch/capsules` (via `fs.listDirectory`, mirroring `_collect_sfn_files_cmd`,
`cli_commands_utils.sfn:447`) and sha256s each file (`_sha256_of_file_cmd`,
`cli_commands_utils.sfn:532`), keyed by `.ll` basename. Feed those into the
existing `compare_for_determinism` by mapping `slug=basename`,
`cache_key=<per-file-sha>` — the comparator's set-equality-with-paired-values
logic is exactly right for "same modules, same content," and the `only_in_a` /
`only_in_b` kinds already render the "missing in stage3" case. The binary
sha256 fields stay populated from `<seedcheck-out>` vs `<stage3-out>` so the
diff also asserts the two **binaries** match (a strictly stronger check than the
Makefile, which only hashed `.ll`).

This means **no new comparator and no new renderer** — only a new I/O loader
(`_selfhost_snapshot_from_ll_dir`) that builds a `DeterminismSnapshot` from a
scratch dir. The pure comparator stays unit-tested as-is.

> Mismatch policy: the Makefile treats `.ll` mismatch as a **WARN** (non-fatal,
> `Makefile:607`). Recommend `sfn selfhost` keep that as a **warning by default**
> for behavioral parity (the migration must not start failing builds that pass
> today), with a `--strict` flag (or `SAILFIN_SELFHOST_STRICT=1`) to promote it
> to a hard non-zero exit. Flag this to the owner (O2, §8) — it's the one place
> the migration could silently change CI semantics.

---

## 5. Orchestration entry point and where logic lands

New file **`compiler/src/cli_selfhost.sfn`** (peer of `cli_check.sfn`),
exporting `handle_selfhost_command(args: string[], binary_dir: string) -> int ![io]`.
Dispatched from `cli_main.sfn` next to the other verbs:

- `cli_main.sfn:1996` area: add `let is_selfhost = strings_equal(cmd, "selfhost");`
- `cli_main.sfn:2827` area: add `if is_selfhost { return handle_selfhost_command(args, binary_dir); }`

`handle_selfhost_command` contains: arg parse → stage2 build (spawn) → smoke
gate (run_capture) → stage3 build (spawn) → snapshot both scratch dirs → diff →
render → promote. It imports `_shell_single_quote_arg`, `_sha256_of_file_cmd`
from `cli_commands_utils`, the `DeterminismDiff` family +
`determinism_diff_to_{text,json}` + `compare_for_determinism` from
`build_report`, and `_resolve_self_path` from `cli_main` (or a shared util).

The new `.ll`-dir snapshot loader (`_selfhost_snapshot_from_ll_dir`) lives in
`cli_selfhost.sfn` (it is selfhost-specific I/O).

---

## 6. Make end-shape (and acceptance-criterion reconciliation)

`check-impl` (`Makefile:531-632`, ~100 lines) collapses to roughly:

```make
check-impl:
	@$(MAKE) compile NATIVE_OPT="$(SELFHOST1_OPT)"
	@echo "[check] running test suite on first-pass binary (early gate)..."
	@$(MAKE) test NATIVE_BIN=build/bin/sfn TEST_BIN_CACHE_FLAGS=--no-test-cache TEST_JOBS=$(CHECK_TEST_JOBS)
	@echo "[check] verifying self-host (stage2/stage3 fixed point)..."
	@build/bin/sfn selfhost \
		--work-dir build/selfhost \
		--first-pass build/bin/sfn \
		--seedcheck-out build/bin/sfn-seedcheck \
		--stage3-out build/bin/sfn-stage3 \
		--promote-to build/bin/sfn \
		$(SELFHOST_TIMEOUT_FLAG)
	@echo "[check] running test suite with seedcheck binary..."
	@$(MAKE) test NATIVE_BIN=build/bin/sfn-seedcheck TEST_BIN_CACHE_FLAGS=--no-test-cache TEST_JOBS=$(CHECK_TEST_JOBS)
```

The **build + smoke + fixed-point diff + promote core is one `sfn selfhost`
call.** The two `make test` suite legs and `make compile` remain in Make (Q3).

**Acceptance-criterion drift to flag:** the issue says "`check-impl` collapses to
a one-line `sfn` invocation." Literally false under the confirmed Q3 boundary —
the *selfhost core* is one call, but `check-impl` is ~5 meaningful lines
(compile + 2 suite legs + selfhost). Recommend the issue author reword the AC to:
*"the stage2/stage3 build + fixed-point + promote logic is a single `sfn selfhost`
invocation; the suite legs and first-pass `make compile` remain Make-driven this
pass (suite migration is out of scope per `Out:`)."* This is consistent with the
issue's own `Out:` scope and §513 Risk 2.

---

## 7. Stage1 readiness mapping (D4)

This is a CLI-orchestration feature, so several pipeline points are N/A:

| # | Checkpoint | Applies? | Notes |
|---|---|---|---|
| 1 | Parses (`parser.sfn`) | **N/A** | No new syntax — a CLI verb, parsed as a string arg. |
| 2 | Type/effect-checks | **Yes (trivially)** | New `![io]` functions must typecheck/effect-check; the spawn helpers are `![io]`. `sfn check compiler/src/cli_selfhost.sfn` covers it. |
| 3 | Emits `.sfn-asm` | **N/A** | No emitter change. |
| 4 | Lowers to LLVM IR | **N/A** | No lowering change. |
| 5 | Regression coverage | **Yes** | See test plan below. |
| 6 | Self-hosts | **Yes** | The feature IS the self-host validator; it must self-host (and validate itself). `make check` is the meta-test. |
| 7 | `sfn fmt --check` | **Yes** | Format `cli_selfhost.sfn` + any touched file. |
| 8 | Docs | **Yes** | `_usage()`, `docs/status.md` (toolchain), and a note in `docs/proposals/0006-build-architecture.md` (build perf) that the selfhost validator moved into the compiler. |

### Test plan (D4)

The fixed-point **diff logic** is the part with real branching, so it gets the
most coverage:

1. **Unit (`compiler/tests/unit/selfhost_diff_test.sfn`):** the new `.ll`-dir
   snapshot loader + `compare_for_determinism` integration on hand-built fixture
   dirs — assert (a) identical `.ll` sets → `matched=true`; (b) one file
   differs → `kind="differ"` for that basename; (c) a file present in stage2 but
   absent in stage3 → `kind="only_in_a"` ("missing in stage3"); (d) binary sha
   mismatch → `binary_match=false`. Pure-ish: write fixture `.ll` files into a
   `with_tmp_dir`. The comparator itself is already covered by
   `build_report_determinism_test.sfn`; this test covers the **loader**.
2. **Integration (`compiler/tests/integration/selfhost_arg_parse_test.sfn`):**
   `handle_selfhost_command` arg parsing — default paths, `--work-dir` override,
   `--no-promote`, unknown flag → usage/exit 2. No actual build (fast).
3. **e2e (`compiler/tests/e2e/selfhost_smoke_test.sfn`):** an `![io]`
   `*_test.sfn` (never bash — `.claude/rules/no-bash-e2e.md`) that spawns
   `<sfn-bin> selfhost --work-dir <scratch> --no-promote` against a **tiny
   fixture capsule** (NOT the full compiler — too slow for the suite) and
   asserts: exit 0, fixed-point reported, no promotion side-effect. Thread
   `PATH`/`HOME`/`TMPDIR`/`SAILFIN_TEST_SCRATCH` into the child env per the
   build-and-run isolation rule. Gate behind a skip if the fixture build is too
   heavy for CI; the authoritative full-compiler exercise is `make check` itself.
4. **Make-level:** `make check` green (the binary promotion + both suite legs)
   remains the end-to-end gate — it exercises the real three-binary path.

---

## 8. Risks & open questions for the design gate (D5)

- **O1 — grammar (DECISION NEEDED):** `sfn selfhost` (recommended) vs
  `sfn check --selfhost` (issue's working name). I recommend the new verb on the
  `check`-contract grounds in §1. The owner should ratify before code, since the
  issue title says `sfn check --selfhost`.
- **O2 — mismatch severity (DECISION NEEDED):** the Makefile treats a `.ll`
  fixed-point mismatch as **WARN/non-fatal** (`Makefile:607`). Keep that as the
  default (parity, no new CI failures) with an opt-in `--strict`? Or make
  `sfn selfhost` fail hard on mismatch (stronger, but could red CI runs that are
  green today)? Recommend default-warn + `--strict`; ratify.
- **O3 — `--ll-scratch` flag follow-up:** this pass redirects the `.ll` scratch
  via the `SAILFIN_TEST_SCRATCH` env vehicle on children. A cleaner future API is
  a `sfn build --ll-scratch DIR` flag overriding `_cr_scratch_root`. Out of scope
  here; file as a follow-up so the env coupling isn't permanent.
- **O4 — AC wording drift:** §6 — "one-line" is false under the confirmed Q3
  boundary; the issue AC should be reworded. Flag to author.
- **R1 — opt-level parity:** the driver hardcodes `-O2` for the link step
  (`Makefile:555-557` warns `NATIVE_OPT` overrides are ignored). `sfn selfhost`
  inherits this limitation; stage2/stage3 are always `-O2`. Not a regression
  (Make has the same gap today), but document it so nobody expects
  `--opt` to flow through.
- **R2 — promotion safety:** promotion `cp -f seedcheck → build/bin/sfn`
  overwrites the canonical binary mid-`make check`. If `sfn selfhost` is itself
  `build/bin/sfn` (the running process), overwriting its own on-disk image
  is safe on Linux (the running inode persists), but `--no-promote` in tests
  avoids the question entirely. Keep promotion as the **last** step after the
  diff renders.
- **R3 — scope creep into suite legs:** resist moving the `make test` legs into
  `selfhost` this pass (Q3 / issue `Out:`). They depend on the full test-runner
  surface and would balloon the PR.
