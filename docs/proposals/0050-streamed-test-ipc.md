---
sfep: 0050
title: Streamed per-test results over a captured pipe (retiring the results.log/fail.bin side-channel)
status: Implemented
type: tooling
created: 2026-07-18
updated: 2026-07-24
author: "agent:compiler-architect; human review"
tracking: "SFN-393"
supersedes:
superseded-by:
graduates-to: site/src/content/docs/docs/reference/spec/11-testing.md
---

# SFEP-0050 — Streamed per-test results over a captured pipe

## 1. Summary

The compiled `*_test.sfn` harness reports its per-test results by writing two
files — `results.log` (tab/newline-framed `T`/`H` records) and `fail.bin` (the
`SFAF` assertion-location record) — into `$SAILFIN_TEST_SCRATCH`, which the
runner reads back after the child exits. That directory is a **single, fixed,
env-var-keyed filesystem path shared by every nesting level**, and it also
doubles as the build-cache root — so the IPC channel collides the moment a
runner nests or runs concurrently. This SFEP replaces the file side-channel with
**structured per-test records streamed over the child's own captured stderr
pipe**, parsed inline by the runner. Because each child's pipe is owned by its
direct parent, no two runs can ever address the same channel — the nesting
collision becomes *structurally impossible* rather than being avoided by
per-caller env-scrubbing. This is the transport a production test binary already
uses (Go's `test2json` reads the test binary's stdout; Rust `libtest
--format json` streams JSON) and it needs **no new runtime plumbing** — the
`process.spawn_with_env` streaming handle and `io.poll_any` already exist.

## 2. Motivation

### The problem

SFN-17 (PR #2411, the recoverable harness) introduced `results.log` as the
runner↔harness channel, keyed on `SAILFIN_TEST_SCRATCH`. That one env var
multiplexes two unrelated concerns:

1. **Harness IPC** — `results.log`, `fail.bin`, `_subframe_summary.json`
   (`runtime/sfn/assert.sfn:166,305`; `cli/commands/test.sfn:1391-1397,1559`).
2. **Build cache / compiler scratch** — `test.ll`, the linked `test` binary,
   dumped sources, and the resolver's staged `capsules/<slug>.ll`
   (`test.sfn:1011-1245`; `capsule_resolver.sfn:477-483`).

Because the channel is *one shared directory path* rather than a per-process
handle, it is fragile in exactly the ways a shared mutable global is:

- **No captured stream to parse.** The runner execs the child with **inherited
  stdio** (`process.run`, `test.sfn:1401`), so it has no stream of its own to
  read — it *must* fall back to a side-channel file. The whole file dance exists
  only because the transport throws the child's output on the floor.
- **Nesting collision.** A test that itself spawns `sfn test` (the
  recoverable-harness and lifecycle meta-tests) makes the nested runner inherit
  the outer `SAILFIN_TEST_SCRATCH` verbatim (`_resolve_test_scratch_root`
  reuses a caller-set value, `test.sfn:1811-1830`) and clear/consume the
  parent's `results.log`, plus objdir/stamp/subframe env leakage.
- **Every caller must re-implement the same band-aid.** SFN-17 shipped a
  test-level fix (`compiler/tests/e2e/recoverable_harness_test.sfn:50-82`): strip
  the full `_pool_child_env` key set and re-scope the nested run into a
  `nested-runner` subdir. `_pool_child_env` (`test.sfn:2829`) does the same strip
  for pooled children. Two hand-maintained copies of the same
  strip-and-rescope, and a caller that forgets it silently cross-contaminates two
  unrelated runs' pass/fail data (the comment records this as a real,
  previously-hit "pool-only 3/3 failure").

This is test-infra only — it does not ship in user programs — but the owner
called the file IPC "a poor choice" and asked for the durable fix, keeping
SFN-17's band-aid only to land that PR. The shared-path coupling already cost a
multi-round CI debug cycle.

### The production-ready bar

A production compiler's test binary streams a machine-readable event per test
over a pipe its parent owns; it does not deposit files in a shared directory and
hope the reader finds them. Go's `cmd/test2json` consumes the test binary's
stdout and recognizes framed events, passing everything else through as output;
Rust's `libtest --format json` emits one JSON object per line on stdout. Both
get per-process isolation *for free* because a pipe is bound to one parent/child
pair. Adopting that shape is what "don't design with the file side-channel going
forward" means concretely: the channel becomes a property of the process tree,
not of a mutable filesystem path.

## 3. Design

### 3.1 Transport — the child's own stderr pipe

The runner spawns each test child through the existing streaming handle
(`process.spawn_with_env`, `runtime/sfn/process.sfn`), which already wires
**separate** stdout and stderr pipes and exposes incremental reads
(`handle_read_line_stdout` / `handle_read_line_stderr`, `handle_stdout_at_eof`,
`handle_wait`) plus `io.poll_any` for readiness. The two streams are split by
role:

- **Child stderr → the record channel.** The harness writes framed result
  records here. The runner reads them line-by-line and classifies inline.
- **Child stdout → user output.** User `print()` calls keep their natural
  stdout destination; the runner captures or forwards them unchanged. This
  retires the `sh -c 'exec "$0" >/dev/null'` wrapper that today discards the
  child's stdout in `--json` mode (`_test_exec_argv`, `test.sfn:2900-2922`).

Records ride stderr rather than stdout for two reasons: user output stays on the
conventional stream, and the record channel is *already* where a hard crash's
spew lands (`sfn_raise_value_error`, ASAN reports, segv backtraces) — so folding
records in there means a crashing test's diagnostics arrive on the same channel
the runner is already reading, instead of vanishing into inherited-stdio noise.
Non-record lines on the channel are passed through as diagnostics (Go's
test2json does the same with unrecognized lines).

Each child's stderr pipe is created by, and readable only from, its direct
parent. A nested `sfn test` gets its *own* pipe from *its* parent. There is no
shared name anywhere in the transport, so **nesting and concurrency collisions
are structurally impossible** — the `_pool_child_env` strip and the SFN-17
`_child_env` band-aid are both deleted, not re-implemented.

### 3.2 Wire format — one framed record type

A record is a single line, tab-separated, prefixed with a control-byte sentinel
and a magic tag so the runner can distinguish records from arbitrary stderr
diagnostics without ambiguity:

```
<US>SFTR\t<schema>\t<kind>\t<status>\t<name>\t<hook>\t<file>\t<line>\t<col>\t<message>\n
```

- `<US>` — ASCII Unit Separator (0x1F), a byte user diagnostics effectively
  never emit; its presence marks a candidate record line.
- `SFTR` — "Sailfin Test Record" magic. A line missing either the sentinel or
  the magic, or with the wrong field arity, is treated as passthrough
  diagnostic output, never a record.
- `<schema>` — record schema version, starts at `1`.
- `<kind>` — `test` | `hook`.
- `<status>` — `pass` | `fail` | `skip`.
- `<name>` — the test name (for a hook, the associated test name, or empty for
  suite-level `before_all`/`after_all`).
- `<hook>` — empty for a `test` record; `before_all` | `before_each` |
  `after_each` | `after_all` for a `hook` record (mirrors the phase tags at
  `assert.sfn:147-149`).
- `<file>` / `<line>` / `<col>` — the assertion location, **folded in from
  `fail.bin`**; empty/`0` when there is no location (a pass, or a hook failure
  without an assert span).
- `<message>` — failure/skip detail; empty for a pass.

This single record unifies the three legacy shapes — the old `T` record, the
`H` record, and the `SFAF` location — into one line. `\n`/`\r` inside names and
messages are stripped to spaces before framing (exactly as
`_assert_write_stripped` does today, `assert.sfn:85`), so a record is always
exactly one line and the framing cannot be broken by user-controlled text.
Keeping the wire format terse and tab-framed (rather than JSON) matches the
harness's deliberate avoidance of string concatenation / `string + i64`
stringification in runtime code (`assert.sfn:63-135`); the runner translates
parsed records into the existing `--json` event schema, which is unchanged.

### 3.3 Crash durability — per-record flush + the file-level child boundary

Each record is written to fd 2 as a **single, fully-flushed write** before the
report call returns, so a longjmp-uncatchable `abort()`/SIGSEGV loses at most the
one in-flight record — the same guarantee the current per-record
open+append+`fclose` gives (`assert.sfn:193,274,297,332`), but without the
per-record `fopen`/`fclose` churn. The existing **file-level child-process
boundary stays as the backstop** (each test file still runs in its own child, so
one crash cannot take down siblings or the runner). A child that dies mid-test
leaves that test with no terminal record; the runner classifies it as an error
via the exit-code path, preserving the #1206 handling that already refuses to
mask a hard non-zero exit as a pass when only passing records were seen
(`test.sfn:1456,1487`).

### 3.4 Runner changes — inline classification

The runner's read-back and classification (`test.sfn:1391-1529,1932-1994`)
change from *read files after exit* to *parse the record stream as it arrives*:

1. Spawn the child via `spawn_with_env`; loop on `io.poll_any` over the child's
   stdout+stderr fds.
2. On each stderr line: if it frames a record, parse it into a
   `TestResultRecord` and update counts/events inline; otherwise buffer it as
   diagnostic output attached to the current test.
3. On each stdout line: forward/capture as user output.
4. Enforce the per-file `timeout` by killing the handle on deadline (the
   streaming handle makes the child directly killable — no reliance on an outer
   `timeout` wrapper for the record path).
5. Reap with `handle_wait`; reconcile the exit code against the terminal records
   (unchanged #1206 gate).

The pre-exec `unlink` of `results.log`/`fail.bin`, the `_consume_test_results_log`
/ `_consume_assert_failure_record` read-then-delete helpers, and the
`SAILFIN_TEST_SCRATCH`-for-IPC coupling are all removed. `SAILFIN_TEST_SCRATCH`
survives as the **build-cache root only**, resolving the dual-purpose overload —
its de-multiplexing is the point of the change.

### 3.5 Parallel-pool subframe aggregation, preserved

Today a pooled/nested child writes aggregate counts to `_subframe_summary.json`,
which the parent scrapes with an ad-hoc `"passed":N` scanner
(`_extract_json_uint_after`, `test.sfn:2951`). Under the streamed channel the
parent already sees the child's per-test records on the child's stderr pipe, so
it **aggregates counts directly from the stream** — the same subframe *semantics*
(parent tallies child results) realized without a third side-channel file.
`_subframe_summary.json` and its scraper are retired. The `--json` output the
parent emits on *its* stdout is byte-for-byte the same schema (v2); only the
internal transport changes. This dovetails with SFEP-0045 §3.5's exec-only
`__run-test-bin` child: that child forwards the prebuilt binary's streamed
records up its own pipe instead of via subframe files, so this SFEP is the
transport that exec-only child rides on.

### 3.6 What is retired

- `results.log` — replaced by the streamed record channel.
- `fail.bin` (`SFAF`) — its `file`/`line`/`col` fold into the `fail` record; the
  `assert_failure.sfn` `SFAF` parser is removed.
- `_subframe_summary.json` — replaced by direct stream aggregation (§3.5).
- The SFN-17 `_child_env` strip/rescope band-aid and the `_pool_child_env`
  IPC-key strip — no longer needed once the channel is per-process.
- The `sh -c '>/dev/null'` `--json` stdout-swallow wrapper (§3.1).

## 4. Effect & capability impact

None new, and the harness side gets *narrower*. The harness writer moves from
`fopen`-ing an env-derived path to writing framed lines on fd 2 — strictly fewer
capabilities (no filesystem open of a caller-controlled path). All runner
changes stay within the existing `![io]` test-driver surface
(`cli/commands/test.sfn`) using process primitives the pinned seed already
ships. No new effect, no capsule-manifest change, no user-visible effect surface
change.

## 5. Self-hosting impact

Passes touched:

- **`runtime/sfn/assert.sfn`** — replace the `results.log`/`fail.bin` file
  writers (`sfn_test_report_pass`/`caught`/`skipped`, `sailfin_assert_fail`) with
  framed-record writes to fd 2. This is the substantive change.
- **`compiler/src/llvm/lowering/lowering_core.sfn`** — the harness only emits
  `call void @sfn_test_report_*(...)` and `@sfn_test_set_phase(...)`
  (`lowering_core.sfn:445-570`); if the extern report signatures are unchanged,
  the emitted IR is unchanged and this file needs **no change**. In scope for the
  record but expected to be a no-op or a minimal edit.
- **`compiler/src/test_results.sfn`** — extend the `TestResultRecord` parser to
  the unified single-line framed format (add `file`/`line`/`col` fields folding
  in the retired `AssertFailure`); tolerate truncated/partial and non-record
  passthrough lines.
- **`compiler/src/cli/commands/test.sfn`** — the runner rewrite of §3.4.
- **`runtime/sfn/process.sfn`** — **no change**; `spawn_with_env`,
  `handle_read_line_*`, `handle_stdout_at_eof`, `io.poll_any`, `handle_wait`
  already exist and ship in the seed.

**Seed dependency: none.** The harness writer (`assert.sfn`) and the runner
reader (`test.sfn`) are both in this repo and rebuilt in one `make compile`: the
old seed builds the new compiler, whose emitted harness writes the new record
format, which the new runner reads — a single self-host pass with no
cross-version format skew. The only capability the pinned seed must already
provide is the `process.*` streaming/poll surface, which it does. Per
`.claude/rules/seed-dependency.md` this is one cohesive capability+consumer
change → **bundle in one PR, no seed cut**. `make check`'s seedcheck runs the
combined suite *through this very runner*, so any writer/reader skew fails the
gate by construction.

### 5.1 Transport-surface correction (supersedes the "no change" claim in §3.1 / §5)

The original §3.1/§5 stated `runtime/sfn/process.sfn` needs **no change**
because `handle_read_line_stderr`, `handle_stderr_at_eof`, and per-fd access
for `io.poll_any` "already ship in the seed." **This is factually incorrect.**
Verified against `runtime/sfn/process.sfn` and
`compiler/src/llvm/runtime_helpers.sfn`: the framed-read family is
**stdout-only** (`handle_read_line_stdout`, `handle_read_bytes_stdout`,
`handle_stdout_at_eof`); `handle_read_stderr` only drains stderr whole-to-EOF
via `_handle_drain_one` and cannot frame a live stream; `io.poll_any` takes
**raw fds** but there is **no accessor** to obtain a handle's stdout/stderr fd
(they live at `SailfinProcessHandle` offsets 8/12); and there is **no
`handle_kill`** — the current per-file deadline is entirely the external
`timeout(1)` wrapper.

**Corrected primitive set.** The records-over-stderr transport requires five
new process-handle builtins, added to `runtime/sfn/process.sfn` with
descriptors in `compiler/src/llvm/runtime_helpers.sfn`:
`process.handle_stdout_fd(h) -> int` and `process.handle_stderr_fd(h) -> int`
(raw fds for `io.poll_any`); `process.handle_read_bytes_stderr(h, n) -> string`
(single-`read(2)` chunk mirror of `handle_read_bytes_stdout`);
`process.handle_stderr_at_eof(h) -> bool` (mirror of `handle_stdout_at_eof`);
and `process.handle_kill(h) -> int` (SIGKILL via a new `kill(2)` extern) for
runner-owned deadlines. Chunk-level stderr reads are **mandatory, not
stylistic**: a hypothetical `read_line_stderr` inherits
`handle_read_line_stdout`'s internal fill-loop, which blocks on `read(2)` and
would reintroduce the cross-pipe deadlock `poll_any` exists to prevent. The
runner accumulates chunks and frames SFTR records itself. Windows carries
degraded-but-linking stubs for the five in
`runtime/sfn/platform/process_windows.sfn` (fds → `-1`, chunk read → empty,
`stderr_at_eof` → `true`, kill → `-1`), consistent with the module's
`spawn_with_env` failure-sentinel posture.

**Self-hosting / seed-cut consequence** (supersedes the "no seed cut" claim in
§5). Because the compiler's own runner does not yet call these builtins, the
primitives ship in a **predecessor PR** that self-hosts on the current pinned
seed — they add only additive runtime bodies + inert descriptor data + Windows
stubs + one predecessor test, with no `compiler/src` call site, so the seed
never needs to know the new builtins. That PR is `seed-blocker`; a **seed cut +
`/pin-seed`** follows. The consumer PR (SFTR writer + parser + runner rewrite)
then self-hosts against the new seed. This is a real seed-cut gate, not a
bundleable single-consumer capability; the owner has approved the cut.

## 6. Alternatives considered

**Alt 1 — dedicated fd 3 for records (the issue's other sketch).** Give the
child an inherited fd 3 the harness writes records to, keeping stderr fully free
for diagnostics. *Rejected:* it requires **new runtime plumbing** the stderr
channel does not — the map of `runtime/sfn/process.sfn` shows only fd 1/2 are
ever `posix_spawn_file_actions_adddup2`'d, and `SailfinProcessHandle`'s fixed
64-byte layout (flagged as byte-identical to a partially-C-owned producer) has no
slot for a fourth fd. Adding one means widening that ABI struct, a new
file-actions close/dup pair, and a new `process.*` builtin descriptor in the
lowering, i.e. touching the spawn ABI and plausibly forcing a seed dependency on
the new builtin. The stderr channel already has a dedicated, separately-captured
pipe and achieves the same per-process isolation with zero ABI change. The
marginal benefit (records never share a stream with crash spew) is outweighed;
mixing them is in fact *useful* for surfacing crash diagnostics on the channel
the runner already reads.

**Alt 2 — records on stdout, Go `test2json` style, user `print()` also on
stdout.** One stream carries both records and user output. *Rejected:* it forces
the framing to be collision-proof against arbitrary user output on the same
stream. Since `spawn_with_env` already gives a *separate* stderr pipe, putting
records there and user output on stdout removes the collision risk entirely at no
cost — strictly better than sharing one stream.

**Alt 3 — keep files, just namespace the IPC dir per-process (never inherit).**
Generalize the SFN-17 band-aid: always mint a fresh IPC subdir and never reuse a
caller's. *Rejected:* it treats the symptom (the shared path) not the shape (a
file side-channel). It keeps the post-exit read-back, the `mktemp` scratch churn,
the three-file triplet, and the per-record `fopen`/`fclose`, and it delivers
neither inline streaming, per-test liveness, nor the perf win. It leaves the
runner exec'ing with inherited stdio and throwing the child's output away.

**Alt 4 — JSON-per-line as the wire format (reuse the `test_runner_json`
schema).** Emit the runner's `--json` event objects directly from the harness.
*Rejected as the wire format* (retained as the runner's *output* format): the
harness is compiled runtime code that deliberately avoids string concatenation
and `string + i64` stringification (`assert.sfn:63-135`), so emitting JSON there
is heavier and more error-prone than terse tab-framed fields. The runner already
owns the JSON translation; keep the child's job minimal.

## 7. Stage1 readiness mapping

Tooling/runtime-driver change; no user-facing language surface.

- [x] Parses — N/A (no new syntax; record framing is a byte format)
- [x] Type-checks / effect-checks — `assert.sfn`, `test.sfn`, `test_results.sfn`
      pass `sfn check`
- [x] Emits valid `.sfn-asm` — exercised by `make compile` (harness emission
      unchanged in structure)
- [x] Lowers to LLVM IR — exercised by `make compile`
- [x] Regression coverage — see §8
- [x] Self-hosts — `make compile`, then **`make check`** over the combined
      suite (unit+integration+e2e+capsules in one invocation — the seedcheck
      runs through this runner, so a writer/reader skew fails here)
- [x] `sfn fmt --check` clean — on every touched `.sfn`
- [x] Documented in `docs/status.md` — the test-runner IPC change; this SFEP is
      the design record; `reference/spec/11-testing.md` notes the transport if it
      documents IPC at all (the `--json` schema is unchanged)

## 8. Test plan

- **Unit — `compiler/tests/unit/test_record_parse_test.sfn`** (`![pure]`): parse
  the framed record — well-formed `test`/`hook` × `pass`/`fail`/`skip`, empty
  optional fields, embedded-tab/newline-in-message stripping, a truncated final
  line (mid-crash), and a non-record diagnostic line ignored as passthrough.
- **e2e — `compiler/tests/e2e/harness_stream_records_test.sfn`** (`![io]`):
  compile+run a fixture exercising pass, fail (with assertion location), skip,
  and every hook phase; assert the runner classifies from the streamed records
  and that **no `results.log`/`fail.bin`/`_subframe_summary.json` is written
  anywhere** under the scratch root.
- **e2e — `compiler/tests/e2e/nested_runner_no_collision_test.sfn`** (`![io]`):
  the SFN-17 scenario **without** the `_child_env` band-aid — a nested `sfn test`
  inheriting the ambient env; assert both the outer and nested results are
  correct with no env-scrubbing, proving the collision is structurally gone. This
  is the direct regression that authorizes deleting the band-aid in
  `recoverable_harness_test.sfn`.
- **e2e — `compiler/tests/e2e/harness_crash_durability_test.sfn`** (`![io]`): a
  fixture that runs one passing test then `abort()`s mid-test; assert the passing
  test's record survived (per-record flush) and the crash is reported as an
  error, not silently dropped or masked as a pass (#1206 gate).
- **e2e — `compiler/tests/e2e/subframe_aggregation_stream_test.sfn`** (`![io]`):
  a pooled multi-file run; assert the parent aggregates child counts from the
  streamed records (subframe semantics preserved) and that the `--json` summary
  the parent emits matches a per-file baseline.
- **Preserved gates:** `check_build_agree_module_global_test.sfn` and the
  existing `--json` schema tests continue to gate output correctness — the
  `--json` shape is explicitly out of scope and must not change.
- **Self-host gate:** `make compile` then `make check` over the combined suite.

## 9. References

- **SFN-393** — this issue; owner requested the durable fix ("file IPC is a poor
  choice") while keeping SFN-17's band-aid to land PR #2411.
- **SFN-17 / PR #2411** — introduced `results.log`/`fail.bin`; the band-aid lives
  in `compiler/tests/e2e/recoverable_harness_test.sfn:50-82`.
- **SFEP-0010** (`docs/proposals/0010-test-infra/`) — the Sailfin-native
  test-infra epic this runner belongs to; the `--json` schema goal.
- **SFEP-0045** (`docs/proposals/0045-shared-frontend-test-runner.md`) — §3.5's
  exec-only `__run-test-bin` child forwards streamed records up its pipe; this
  SFEP is its transport.
- **SFEP-0014** (`docs/proposals/0014-agent-output-orchestration.md`) —
  agent-legible build/test output; the `--json` event schema (v2) consumed here.
- **#1206** — the hard-crash-must-not-be-masked-as-pass gate preserved in §3.3.
- **#1333** — per-child scratch isolation; this SFEP removes the *IPC* half of
  `SAILFIN_TEST_SCRATCH`, leaving the build-cache half.
- Key code paths: `runtime/sfn/assert.sfn:166,180,199,282,305` (the file
  writers); `runtime/sfn/process.sfn` (`spawn_with_env`, `handle_read_line_*`,
  `handle_stdout_at_eof`, `io.poll_any`, `handle_wait` — the transport, already
  shipped); `cli/commands/test.sfn:1401` (`process.run`, inherited stdio),
  `:1391-1529` (classification), `:1811-1830` (`_resolve_test_scratch_root`),
  `:2829` (`_pool_child_env`), `:2900-2922` (`_test_exec_argv` json wrapper),
  `:2951` (`_extract_json_uint_after`); `compiler/src/test_results.sfn`
  (`TestResultRecord`); `compiler/src/assert_failure.sfn` (`SFAF` parser, retired);
  `compiler/src/llvm/lowering/lowering_core.sfn:445-570` (harness emission);
  `compiler/src/test_runner_json.sfn` (`--json` schema v2, unchanged). Prior art:
  Go `cmd/test2json`, Rust `libtest --format json`.
