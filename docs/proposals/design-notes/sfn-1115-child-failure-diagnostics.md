# SFN-1115 — child-failure diagnostics in the e2e tree

Design gate for SFN-1115. Genre is a single-issue design note, not an SFEP
(`.claude/rules/proposals.md`): no language feature, no runtime/ABI design, no
toolchain design — this is a test-infrastructure convention plus a mechanical
sweep. The durable *rule* it establishes belongs in
`docs/conventions/e2e-tests.md`; this note is the record of why the sweep took
this shape and why the two ambient alternatives were rejected. Sibling
precedent: `sfn-393-runner-transport.md` (the transport this note reasons
about) and `sfn-1092-windows-child-deadline.md`.

Blocks: SFN-981 (wiring `sfn test` into Windows CI).

---

## 1. Goal

When an e2e test fails because a child process it spawned failed, the tier log
— the only artifact CI produces — must contain the child's exit code and both
of its streams. Today it contains a file:line and the words `assertion
failed`, and nothing else, for 120 of 141 observed Windows failures.

Secondary goal, and the one the issue actually asks about: make the fix
**structural**, so the gap cannot reopen one new test file at a time.

---

## 2. Corrected problem statement — the runner is innocent

**The issue title ("The e2e runner swallows child stderr") is wrong, and any
implementation that acts on it will change the wrong code.** State this
correction in the PR body.

### 2.1 Measured: nothing is swallowed

A probe run on a native Windows host:

```sfn
test "probe: stderr and stdout before a failing assert" ![io] {
    print.err("PROBE-STDERR-MARKER");
    print("PROBE-STDOUT-MARKER");
    assert 1 == 2;
}
```

Both markers appeared in the tier log above the `FAIL` line. That matches the
transport as designed: the test binary's stderr is the SFTR record channel, and
`_ingest_child_stderr_line` (`compiler/src/cli/commands/test/exec.sfn:300-303`)
parses each complete line as a record **or forwards it verbatim to the runner's
stderr**. stdout is buffered and re-emitted at end of file in human mode
(`exec.sfn:329-341`). Nothing a test prints before a failing assert is lost.

**Consequence: no change to `compiler/src/cli/commands/test/` is in scope.**
The runner code is correct.

### 2.2 The actual defect is in the tests' own code

The idiom, verbatim, at
`compiler/tests/e2e/aarch64_bootstrap_probe_test.sfn:29-33`:

```sfn
let exit = process.run_capture([sfn_bin_path(), "run", fixture], child_env);
let stdout = process.capture_take_stdout();
let stderr = process.capture_take_stderr();
assert exit == 0;
assert contains(stdout + stderr, "aarch64 bootstrap probe ok");
```

When the child fails, `exit != 0` trips the third line and the test dies with
`stdout` and `stderr` sitting unread in locals. The runner had nothing to
forward because the test never printed anything.

### 2.3 Measured coverage gap

Counted on `main` at the time of writing:

| quantity | count |
|---|---|
| `*_test.sfn` files under `compiler/tests/e2e/` | 363 |
| …that call `process.run_capture(` | 343 |
| …that also call `report_child_failure` (`capsules/sfn/test/src/child_diag.sfn:14`) | 25 |
| **files spawning children with no diagnostic** | **318** |
| `process.run_capture(` occurrences across the tree | 1176 |
| `process.capture_take_*` occurrences | 2154 |
| offender files carrying the narrow `assert <ident> == 0;` shape | 191 |
| offender files using some other shape (helper return, `if exit != 0`, struct field) | 127 |

`capture_take_*` occurring at ~1.8x the `run_capture` count is the load-bearing
number: **virtually every site already drains both streams into locals.** That
single fact is what decides the option comparison in §4.

---

## 3. Constraints

1. **`assert` is a language construct.** Hooking its failure path is a change
   to `runtime/sfn/assert.sfn:395` (`sailfin_assert_fail`), which every user
   program and every test binary in the repo links. Blast radius is the whole
   toolchain.
2. **The `assert` must stay at the call site.** `sailfin_assert_fail` receives
   the `file`/`line`/`col` of the *lexical* assert. Moving the assert into a
   capsule helper relocates every failure's attribution to that helper's line —
   which is exactly the defect SFN-1096 fixed
   (`compiler/tests/e2e/harness_assert_pairing_test.sfn`). Any design whose
   helper contains the `assert` regresses attribution repo-wide.
3. **Effect discipline.** `report_child_failure` is `![io]` and cannot be built
   from the `![pure]` `expect_*` matchers — see the header comment at
   `capsules/sfn/test/src/child_diag.sfn:12-13`. Effect lists stay alphabetical.
4. **Tests that expect a non-zero child must stay silent on success.**
   Non-record stderr is forwarded *unconditionally*, pass or fail
   (`exec.sfn:302`), so a diagnostic added at a site whose child is *supposed*
   to fail becomes permanent noise on a green run.
5. **No `panic()`, no new E-codes.** This touches no user-source diagnostic
   path.
6. **Reviewable, self-hostable, POSIX-neutral.** The change must not alter any
   POSIX-observable behaviour of a passing test.
7. **One PR, bundled with the other Windows test fixes.** The mechanical part
   must partition cleanly across parallel implementer agents.

---

## 4. Options

### (a) Helper + mechanical sweep

Add nothing new (the helper already ships); insert one unconditional
`report_child_failure(tag, exit, out, err);` before each success-asserting
`assert`, at ~318 files.

- Cost: a ~640-edit, ~318-file diff.
- Blast radius: **test files only.** No compiler source, no runtime source, no
  seed dependency, no self-host risk.
- Weakness as filed: per-call-site, therefore re-openable.

### (b) Ambient last-child recording — **rejected, and not for the reason the issue supposes**

The issue proposes that the capture path record the most recent child's streams
and the assert-failure path flush them. Two independent facts kill it.

**(b1) The naive form records nothing.** `process.run_capture` does not return
the streams; it stashes them in two runtime process-globals
(`runtime/sfn/process.sfn:465`, `:467`) which `capture_take_stdout` /
`capture_take_stderr` (`process.sfn:1204`, `:1211`) hand off **and clear**.
340 of the 343 capturing files call `capture_take_*`, at 2154 sites. By the
time any assert fails, the ambient stash is empty at essentially every site in
the tree. A `sailfin_assert_fail` hook that reads "pending captured output"
would print nothing, for ~all 318 broken files.

**(b2) The non-naive form is a runtime memory-ownership change on the hottest
path in the toolchain.** To make ambient work you must retain a *second*,
take-immune copy of both streams inside `_run_capture_impl`
(`process.sfn:916`), freed only at the next capture. That means:

- `capture_take_stdout` returns the malloc'd buffer pointer directly
  (`process.sfn:1204-1209`, `return_type: "i8*"` per
  `compiler/capsules/codegen-llvm/src/runtime_helpers/registry_process.sfn:98`)
  and the Sailfin `string` takes it from there. Retaining an aliasing pointer in
  a diagnostic slot is a use-after-free waiting to happen; retaining a *copy*
  doubles peak transient bytes for every capture.
- Every capture in the toolchain pays it, not just tests. `sfn build -p
  compiler` fans out per-module emit through `run_capture`
  (`compiler/src/capsule_emit_parallel.sfn:166-167`) under an 8 GiB
  `RLIMIT_AS`. Retaining a spare copy of the largest child's output for the
  lifetime of every build is a real, unbudgeted cost against
  `.claude/rules/compiler-safety.md`.
- The flush point is `runtime/sfn/assert.sfn:395`, linked into every user
  program. Gating it on `_test_records_enabled()` narrows the audience but not
  the code's reach.

**(b3) Even if built, it is imprecise.** A test that captures twenty children
retains only the last; an assert about the third would print the twentieth's
output under a heading that claims relevance. And it prints for tests that
legitimately expect a non-zero child, violating constraint 4 with no per-site
way to opt out.

Rejected. The cost is a runtime-wide ownership change, and the payoff is a
diagnostic that is *less* accurate than the one-line-per-site form.

### (c) Considered and folded in, not adopted whole: a typed `ChildRun` API

The honest long-term fix is that `run_capture`'s split return (exit code
returned, streams left in a global that must be explicitly drained) is what
makes discarding the default. A `sfn/test` wrapper —

```sfn
struct ChildRun { exit: int; out: string; err: string; }
fn run_child(tag: string, argv: string[], env: string[]) -> ChildRun ![io]
```

— removes the drain ceremony entirely and would make the whole class
unexpressible. It is **not** this PR: it rewrites 1176 call sites, it interacts
with every `_child_env()` / `clean_runner_env` / cwd variant in the tree, and
it must not absorb the `assert` (constraint 2). It is recorded in §9 as the
successor, and the design below is deliberately shaped so the sweep's output is
exactly what `run_child` would later absorb.

### Deciding tradeoff

(b)'s appeal is "zero test-file edits." §2.3's take-count destroys that: the
zero-edit version records nothing, and the version that records is a runtime
ownership change with a worse diagnostic. (a)'s weakness is "re-openable" —
which is a *guard* problem, not an architecture problem, and §7 solves it with
a source-scanning ratchet of exactly the kind already shipped in
`compiler/tests/e2e/no_shell_tool_probe_test.sfn`.

**Recommendation: (a), with three targeted capsule changes (§5) that make the
uniform edit cheaper than the discard it replaces, plus the §7 ratchet.**

---

## 5. Design

### 5.1 Capsule changes — `capsules/sfn/test/src/child_diag.sfn`

The file is 21 lines today. Three changes, all confined to it plus the barrel
export.

**(5.1a) Clip each stream.** At 25 call sites, dumping a whole child's output
was free. At ~640, a Windows run with 141 failing files could dump megabytes
into the tier log and bury the signal. Add a file-private
`_clip_stream(text: string) -> string` that, when `text.length` exceeds the
budget, emits the first `budget/2` bytes, a marker line
`... <N> bytes elided ...`, and the last `budget/2` bytes. Budget default
8192 bytes per stream, overridable by `SAILFIN_TEST_CHILD_DIAG_BYTES`
(bytes only, `0` = unlimited, matching the `SAILFIN_MEM_LIMIT` convention of
rejecting unit suffixes). Head *and* tail because a compiler child's real error
is usually at the tail and its invocation banner at the head.

**(5.1b) Explain `exit == -1`.** Both `run_capture` backends return `-1` for a
setup/spawn/reap failure with **both streams empty** —
`_run_capture_impl` (`runtime/sfn/process.sfn:916`, the `return -1` arms) and
`_pw_run_capture_impl` (`runtime/sfn/platform/process_windows.sfn:738`,
`:750`). On Windows this is the single most likely code for the SFN-1115
failure class, because a missing `bash` / `tar` / `chmod` / `rm` in a test's
argv is a spawn failure, not a child error. Without a hint, the swept
diagnostic reads `child failed exit=-1 stdout:\n\nstderr:\n` and teaches the
reader nothing. Add, on the `-1` branch only:

> `exit=-1 means run_capture could not spawn or reap the child (argv[0] not
> found on PATH, not executable, or a pipe/spawn failure). The child never
> ran, so both streams are empty. Check argv[0] and the child env's PATH.`

**(5.1c) Add `report_child_failure_pending(tag: string, exit: int) ![io]`.**
It calls `process.capture_take_stdout()` and `process.capture_take_stderr()`
**unconditionally** (so the drain semantics are byte-identical to the two
`let _o` / `let _e` lines it replaces, on the success path too), then forwards
to `report_child_failure`. This is the edit for the discard class (§6, case ii):
it turns three lines into one instead of forcing a rename. It is also the
default a *new* test should reach for — the point being that after this change,
capturing the diagnostic is strictly less typing than discarding it. That is
the structural half of the answer to "so this cannot regress one call site at a
time"; the ratchet in §7 is the enforcing half.

Do **not** use it where the streams are needed afterwards — it drains them.
Say so in its header comment.

`report_child_failure`'s existing no-op-on-zero guard
(`child_diag.sfn:15`) is retained and exploited: every swept call site is an
**unconditional** call, never wrapped in an `if`. That is what makes the sweep
uniform enough to parallelize.

**Barrel:** extend the export at `capsules/sfn/test/src/mod.sfn:442` to
`export { report_child_failure, report_child_failure_pending } from
"./child_diag";` and extend the section comment at `mod.sfn:435-441` to name
the drain-vs-borrow distinction and the clipping budget.

**Do not hand-edit `capsules/sfn/test/capsule.toml`.** Versions are bumped by
`.github/workflows/capsule-release.yml` (see commit `0d0c6ada`).

**Capsule tests** — extend `capsules/sfn/test/tests/child_diag_test.sfn`,
reusing its existing `_run_probe` subprocess harness:

- `report_child_failure: clips an oversized stream and states the elision` —
  probe body passes a >8 KiB stdout, assert head marker present, tail marker
  present, `bytes elided` present, and a mid-string marker absent.
- `report_child_failure: exit -1 names spawn failure, not child failure` —
  assert the hint text and that it is absent for `exit == 7`.
- `report_child_failure_pending: drains both streams on success` — probe body
  runs a child that prints, calls `report_child_failure_pending("t", 0)`, then
  calls `capture_take_stdout()` and asserts it is empty. This pins the
  behavioural equivalence with the two `let _o`/`let _e` lines.
- `report_child_failure_pending: surfaces both streams on a non-zero exit`.

### 5.2 The call-site idiom (the thing being swept in)

Borrowing form — when the streams are used afterwards:

```sfn
let exit = process.run_capture(argv, env);
let out = process.capture_take_stdout();
let err = process.capture_take_stderr();
report_child_failure("<tag>", exit, out, err);
assert exit == 0;
```

Draining form — when they are not:

```sfn
let exit = process.run_capture(argv, env);
report_child_failure_pending("<tag>", exit);
assert exit == 0;
```

**Tag convention.** The tag is the only thing correlating a forwarded stderr
line with its `[test] FAIL:` line, because the two arrive by different routes:
the report is forwarded live off the child's stderr (`exec.sfn:302`) while the
`FAIL` line is printed after the whole file's records are collected
(`compiler/src/cli/commands/test/reporting.sfn:155`). They are not adjacent in
the log. So the tag must be self-locating:

> `"<kebab topic> <phase>"`, plus a discriminator when the site sits in a loop
> or a shared helper.

Topic = the file stem minus `_test`, kebabbed. Phase = `build` / `run` /
`emit` / `check` / `link` / the external tool's name. Discriminator = the
helper's `label`/`path`/`tag` parameter. Shipped precedent to copy:
`"bench --compiler summary"` (`bench_compiler_test.sfn:34`),
`"closure-capture run " + path` (`closure_capture_test.sfn:59`),
`"objkey-race round " + number_to_string(round)`
(`concurrent_runtime_objkey_race_test.sfn:79`).

---

## 6. The sweep

### 6.1 The unit of decision is the **capture site**, not the assert

Do not scan for `assert x == 0`. §2.3 shows 127 of 318 offender files do not
contain that shape at all — they check the exit inside a helper and return a
sentinel, so the assert that ultimately fails is about a string or a struct
field, and the diagnostic must be emitted where the child was captured.

For **each** `process.run_capture(` occurrence in an assigned file, ask one
question:

> **Is a non-zero exit at this site a bug?**

and classify:

| case | recognizer | edit |
|---|---|---|
| **(i) success required, streams bound to usable names** | the exit binding is later asserted `== 0`, or compared `!= 0` to return a sentinel / set a failure flag; the two `capture_take_*` results are bound to non-`_` names that are read later | insert one unconditional `report_child_failure(tag, exit, out, err);` immediately after the second take |
| **(ii) success required, streams discarded** | same exit handling as (i), but the take results are bound to `_`-prefixed names (`_o`, `_e`, `_err`, `_stdout`) that appear exactly once in the file | delete both `let _… = process.capture_take_*();` lines; insert `report_child_failure_pending(tag, exit);` in their place |
| **(iii) non-zero expected** | the exit binding flows into `assert <id> != 0;`, `assert <id> == <non-zero literal>;`, `assert <id> > 0`, or a struct field asserted non-zero at the call site; and/or the enclosing `test "…"` name says *rejects* / *refuses* / *fails* / *diagnostic* / *traversal* / *denied* | **leave alone** |
| **(iv) fire-and-forget setup** | the exit is bound to a `_`-prefixed name (`let _exit = …`) that appears exactly once in the file — a `chmod` / `rm -rf` / `cp` whose result is never consulted | **leave alone** |

**Why (iv) is excluded, not swept.** Non-record stderr is forwarded regardless
of the test's outcome (`exec.sfn:302`). A `chmod` that returns non-zero on a
host where the test still passes would print on every green run. Constraint 4.

**Why the `_` prefix is safe to rename or delete.** Sailfin has no
unused-variable diagnostic (there is no such check under
`compiler/capsules/analyzer/src/`); `_o` is pure convention, so
dropping the binding entirely in case (ii) cannot break the build. Verify with
`sfn check` per file anyway (§8).

**Ambiguity rule.** If a site does not fall cleanly into one of the four, leave
it alone and list it in the batch report. A missed site is a status-quo bug; a
wrong one is CI noise on a green run. Do not guess.

**Import.** Add `report_child_failure` and/or `report_child_failure_pending`
to the file's existing `import { … } from "sfn/test";` list, alphabetically
(`report_child_failure` sorts before `report_child_failure_pending`). Files
that currently import nothing from `sfn/test` are rare in this set — most
already import `sfn_bin_path` / `default_scratch_dir`.

### 6.2 Before / after — real files in the tree

**Case (i), streams already bound —
`compiler/tests/e2e/aarch64_bootstrap_probe_test.sfn:29-33`:**

```sfn
    let exit = process.run_capture([sfn_bin_path(), "run", "compiler/tests/e2e/fixtures/aarch64_bootstrap_probe.sfn"], child_env);
    let stdout = process.capture_take_stdout();
    let stderr = process.capture_take_stderr();
    assert exit == 0;
    assert contains(stdout + stderr, "aarch64 bootstrap probe ok");
```

becomes

```sfn
    let exit = process.run_capture([sfn_bin_path(), "run", "compiler/tests/e2e/fixtures/aarch64_bootstrap_probe.sfn"], child_env);
    let stdout = process.capture_take_stdout();
    let stderr = process.capture_take_stderr();
    report_child_failure("aarch64-bootstrap probe run", exit, stdout, stderr);
    assert exit == 0;
    assert contains(stdout + stderr, "aarch64 bootstrap probe ok");
```

The sibling site at `:16-20` in the same file takes the same edit with tag
`"aarch64-bootstrap self-path run"`.

**Case (ii), discarded streams inside a helper —
`compiler/tests/e2e/array_filter_closure_test.sfn:29-35`:**

```sfn
fn _run_fixture(path: string) -> RunOut ![io] {
    let exit = process.run_capture([sfn_bin_path(), "run", path], _child_env());
    let out = process.capture_take_stdout();
    let _err = process.capture_take_stderr();
    return RunOut { exit: exit, out: trim_right(out) };
}
```

Here `out` is borrowed (returned) but `_err` is discarded, so the draining form
does not apply — this is case (i) with a rename:

```sfn
fn _run_fixture(path: string) -> RunOut ![io] {
    let exit = process.run_capture([sfn_bin_path(), "run", path], _child_env());
    let out = process.capture_take_stdout();
    let err = process.capture_take_stderr();
    report_child_failure("array-filter run " + path, exit, out, err);
    return RunOut { exit: exit, out: trim_right(out) };
}
```

The `assert r.exit == 0;` at `:39` is **untouched** — attribution stays at the
call site (constraint 2), and the diagnostic now precedes it in the log under
the tag `array-filter run …`.

**Case (ii), pure discard —
`compiler/tests/e2e/array_aggregate_shape_test.sfn:53-58`:**

```sfn
    let exit = process.run_capture([sfn_bin_path(), "emit", "-o", ll, "llvm", "compiler/tests/e2e/fixtures/array_aggregate_shape.sfn"], _child_env());
    let _o = process.capture_take_stdout();
    let _e = process.capture_take_stderr();
    if exit != 0 { return ""; }
```

becomes

```sfn
    let exit = process.run_capture([sfn_bin_path(), "emit", "-o", ll, "llvm", "compiler/tests/e2e/fixtures/array_aggregate_shape.sfn"], _child_env());
    report_child_failure_pending("array-aggregate-shape emit " + tag, exit);
    if exit != 0 { return ""; }
```

This is the exact silent class the narrow `assert exit == 0` scan would miss:
the child's failure currently surfaces four frames later as
`assert ir.length > 0`.

**Case (iii), leave alone —
`compiler/tests/e2e/harness_assert_pairing_test.sfn:74-79`:** the fixture is
*built to fail*, `assert exit != 0;`, and the captured text is the subject of
the test. No edit.

**Case (iv), leave alone —
`compiler/tests/e2e/aarch64_binfmt_probe_test.sfn:59-61`:**
`let _exit = process.run_capture(["chmod", "000", …], _plain_env());` — the
exit is never consulted. No edit.

### 6.3 Parallelization

The 318 files are disjoint and touch no shared symbol, so N agents can work
concurrently with zero cross-talk **provided §5 lands first**. Sequence:

- **Step 0 — one owner, lands first on the branch.** §5.1 capsule changes +
  capsule tests + the `docs/conventions/e2e-tests.md` section (§8.3). Nothing
  else may start until `report_child_failure_pending` is exported, because
  case-(ii) edits call it.
- **Step 1 — N agents in parallel, disjoint batches.** Six batches of 53 files,
  alphabetical by basename over the offender list (regenerate it with the §7
  guard's own predicate so it cannot drift):

  | batch | first file | last file |
  |---|---|---|
  | 1 | `aarch64_binfmt_probe_test.sfn` | `check_effect_try_block_escape_test.sfn` |
  | 2 | `check_json_schema_test.sfn` | `exe_path_intrinsic_test.sfn` |
  | 3 | `exe_path_reader_test.sfn` | `nested_function_declaration_test.sfn` |
  | 4 | `nested_lambda_capture_test.sfn` | `runtime_dir_capsule_link_test.sfn` |
  | 5 | `runtime_exception_frames_test.sfn` | `spawn_empty_array_push_test.sfn` |
  | 6 | `st_mode_arch_layout_test.sfn` | `workspace_member_declaration_test.sfn` |

  Each agent commits its own batch separately (`test(e2e): report child failures
  — batch <n>/6`) so review can proceed range by range. Each agent's report must
  list: files edited, sites edited per case (i)/(ii), sites deliberately left as
  (iii)/(iv), and any ambiguous site it declined.
- **Step 2 — one owner, lands last.** The §7 guard. It must land after the
  sweep or it fails CI on its own branch.

`c` (50 files) and `r` (54) dominate the alphabet, hence uneven letter spans;
the row boundaries above are by count, not by letter.

---

## 7. Regression guard

New file: `compiler/tests/e2e/child_failure_diagnostics_test.sfn`. Model it
directly on `compiler/tests/e2e/no_shell_tool_probe_test.sfn` — same
`_collect_test_files` recursive walk, same offender-list-then-`assert
offenders.length == 0` shape, same "build the needles by runtime concatenation
so the guard can scan itself" discipline.

Two rules, both zero-target.

**Rule A — site-level, precise, no exemptions.** Parse the file for
`let <id> = process.run_capture(` bindings, recording `<id>` and its line
number. For every later line matching `assert <id> == 0;` where `<id>` is such
a binding, require that `report_child_failure` appears on some line between the
binding and the assert. This is the exact 85%-class shape from §2.2 and it has
no legitimate exception: if a non-zero exit is asserted to be a bug, its
diagnostic is mandatory.

**Rule B — file-level, coarse, with an in-file exemption.** A file containing
`process.run_capture(` must contain `report_child_failure` **or** a line
containing the marker `no-child-diagnostic:` followed by a reason. Rule B is
what catches a *new* file that copies the helper-return shape Rule A cannot
see. The exemption is a marker comment in the file, not a central allowlist,
deliberately: an allowlist entry is invisible at the point of the copy-paste,
whereas a marker forces the author to write the sentence "every capture here
expects a non-zero child" where the reviewer will read it. Expected marker
population after the sweep: the all-(iii)/(iv) files (archive-traversal
rejection, diagnostic-shape tests, binfmt probes) — on the order of dozens, and
each one reviewable.

On failure both rules print the offender list then the fix hint, e.g.:

> `fix: call report_child_failure / report_child_failure_pending from sfn/test
> (capsules/sfn/test/src/child_diag.sfn) before asserting a child's exit — see
> docs/conventions/e2e-tests.md`

If Rule B's marker population turns out larger than ~40 files during
implementation, ship Rule A alone and file the Rule B follow-up rather than
land a guard whose exemption list is bigger than its enforcement.

---

## 8. Files affected

### 8.1 Test capsule (`sfn/test`)

| file | change |
|---|---|
| `capsules/sfn/test/src/child_diag.sfn` | `_clip_stream` + budget env; `exit == -1` hint; new `report_child_failure_pending` |
| `capsules/sfn/test/src/mod.sfn:435-442` | extend the section comment and the export |
| `capsules/sfn/test/tests/child_diag_test.sfn` | four new cases (§5.1) |
| `capsules/sfn/test/capsule.toml` | **no manual edit** — automated bump |

### 8.2 e2e tree

| file | change |
|---|---|
| 318 files under `compiler/tests/e2e/` | §6 sweep |
| `compiler/tests/e2e/child_failure_diagnostics_test.sfn` | new, §7 guard |

### 8.3 Docs

| file | change |
|---|---|
| `docs/conventions/e2e-tests.md` | new `## A test that spawns a child must report its failure` section between `## Gating a test that cannot run` (:98) and `## Build-and-run tests must isolate the build` (:148): the two idiom forms from §5.2, the tag convention, the (iii)/(iv) exclusions, and a pointer to the §7 guard |
| this note | the record |

### 8.4 Explicitly **not** touched

`compiler/src/cli/commands/test/**` (§2.1), `runtime/sfn/assert.sfn`,
`runtime/sfn/process.sfn`, `runtime/sfn/platform/process_windows.sfn` (§4b).
`compiler/tests/integration/` and `compiler/tests/unit/` — 11 files call
`run_capture` there; out of scope for SFN-1115, and the §7 guard is scoped to
`compiler/tests/e2e` to match.

---

## 9. Dependencies, seed impact, verification

### 9.1 Seed impact: **none**

Nothing here is compiler source. `capsules/sfn/test` is compiled by the freshly
built `build/bin/sfn` when tests run, not by the pinned seed, and it is not in
the compiler's build closure. No new builtin, no new intrinsic, no runtime
change — so neither the bundling default nor the runtime carve-out in
`.claude/rules/seed-dependency.md` applies. Per that rule's bundle-by-default
guidance the capsule change and its 318 consumers ship in **one PR**; splitting
them would gate the sweep on nothing and buy nothing.

### 9.2 Verification

Per-file, per agent, during the sweep (rung 1 of the ladder):

```
sfn fmt --write <touched files>
sfn fmt --check <touched files>
sfn check <touched files>
```

After Step 0:

```
build/bin/sfn test capsules/sfn/test/tests/child_diag_test.sfn
```

After Step 2:

```
build/bin/sfn test compiler/tests/e2e/child_failure_diagnostics_test.sfn
```

Behavioural proof that the fix works, on Linux — pick any swept file, break its
fixture, and confirm the child's stderr now appears above the FAIL line:

```
build/bin/sfn test compiler/tests/e2e/array_filter_closure_test.sfn
```

Because the branch is bundled with other Windows fixes that *do* touch compiler
source, the branch as a whole still owes `sfn dev bootstrap build` before it is
done (`.claude/rules/selfhost-invariant.md`) — but no step in *this* design
requires it, so the sweep agents must not spend an hour on one.

Acceptance for SFN-1115: on the native Windows host, re-run
`sfn test compiler/tests/e2e` and confirm the fraction of failures whose log
contains only a file:line drops from 120/141 to near zero. Failures with
`exit=-1` and empty streams are *expected* to remain — but now carry the §5.1b
spawn-failure hint, which is the actionable form.

### 9.3 Risks

| risk | mitigation |
|---|---|
| Log volume explodes on a heavily-failing run | §5.1a per-stream clipping, 8 KiB default |
| Report line and its `FAIL` line are far apart in the log (different routes, §5.2) | self-locating tag convention |
| A child's output contains an ASCII `0x1F` + `SFTR` prefix and is misparsed as a record (`compiler/src/test_results.sfn:120`) | vanishingly unlikely for compiler/tool output; accepted, documented here |
| A misclassified (iii)/(iv) site adds noise to a green run | ambiguity rule (§6.1): leave alone and report; guard Rule A never fires on those shapes |
| A 318-file diff is hard to review | uniform one-line edit, six separately-committed batches, `fmt --check` gate, guard proves completeness better than reading 640 hunks |
| Sweep drifts from the guard's predicate | regenerate the batch list from the guard's own Rule B predicate before assigning batches |

---

## 10. Future considerations

1. **`run_child` (§4c) is the successor.** Every line this sweep adds is
   exactly the line `run_child` would absorb, so the sweep is not throwaway
   work — it is the census that makes the later mechanical rewrite safe. File
   it after SFN-981 is green, when the Windows signal is trustworthy enough to
   validate a 1176-site rewrite.
2. **`report_child_failure` should eventually carry `argv`.** The tag is a
   hand-maintained stand-in for the command that failed, and it will drift. A
   `run_child` wrapper owns the argv and can print it for free; do not add an
   argv parameter to the 4-arg helper in the interim.
3. **Rule A generalizes.** The identifier-binding scan in §7 is a small,
   reusable "which local came from which call" primitive. `assert <id> != 0;`
   with no diagnostic anywhere is the same latent gap in the (iii) population,
   and can be added to the guard later without new machinery.
4. **`compiler/tests/integration` and `unit`** (11 files) inherit the
   convention the day someone widens the guard's root; that is a one-line change
   to the guard and a ~11-file sweep.
