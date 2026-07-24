# SFN-393 — Runner-side transport rewrite (SFEP-0050 consumer)

Implementation design note for the runner half of SFEP-0050
(`docs/proposals/0050-streamed-test-ipc.md`). The harness writer + parser
foundation (SFTR records on fd 2, `test_results.sfn` per-line parser,
`assert_failure.sfn` `AssertFailure` struct retained / SFAF parser retired) is
being implemented in parallel and is assumed to land as specified. This note
designs the rewrite of `compiler/src/cli/commands/test.sfn` and resolves the
byte-identical-`--json` tension.

All line anchors are against the current `compiler/src/cli/commands/test.sfn`
(3095 lines) unless noted. **No `.sfn` source is edited by this note** — it is a
spec the runner engineer codes from directly.

---

## 0. Foundation assumptions (from the parallel harness/parser work)

The runner is designed against this foundation contract. If any of it changes,
re-check §b.

1. **Two-channel multiplex on the SFTR stream (fd 2 of the compiled test
   binary).** `sfn_test_report_pass/caught/skipped` emit `test`/`hook` records
   that carry **classification only** (kind/status/name/hook/message, *no*
   location). `sailfin_assert_fail` emits a **separate `assert`-kind record**
   carrying `file`/`line`/`col`/`message` — the exact payload the retired
   `fail.bin` SFAF record used to hold. On the non-harness-frame abort path,
   `sailfin_assert_fail` still emits its `assert` record before aborting.
2. **`compiler/src/test_results.sfn`** exposes a per-line parser
   `parse_test_record_line(line: string) -> TestResultRecord?` (returns `null`
   for a non-record / truncated / non-SFTR line) in addition to the whole-blob
   `parse_test_results_log`. `TestResultRecord` gains `file: string`,
   `line: int`, `col: int`. Internal `kind` is normalized to `"T"` (test),
   `"H"` (hook), and `"A"` (assert); status normalized to
   `"pass"`/`"fail"`/`"skip"`. **The `"A"` tag is the coordination point** — the
   runner's split (§b) filters on it, so the parser and runner must agree on the
   exact tag string. (If the parser uses a different sentinel than `"A"`, change
   `_STREAM_ASSERT_KIND` in the runner accordingly.)
3. **`compiler/src/assert_failure.sfn`** keeps `AssertFailure`,
   `_empty_assert_failure`; the SFAF parser + `_af_*` helpers are deleted.
   `_synthetic_assert_failure` stays in `test.sfn`.
4. **`runtime/sfn/process.sfn`** ships the five SFEP-0050 primitives, already
   present and registered in `compiler/src/llvm/runtime_helpers.sfn:914-926`:
   `process.handle_stdout_fd(h) -> int`, `process.handle_stderr_fd(h) -> int`,
   `process.handle_read_bytes_stderr(h, n) -> string`,
   `process.handle_stderr_at_eof(h) -> bool`, `process.handle_kill(h) -> int`.
   Plus the pre-existing `process.spawn_with_env`,
   `process.handle_read_bytes_stdout`, `process.handle_stdout_at_eof`,
   `process.handle_wait`, and `io.poll_any(fds: int[], timeout_ms) -> int`
   (returns the first ready fd `>= 0`, or `-1` on timeout/empty/error;
   `timeout_ms < 0` blocks). These live in the **pinned seed** already
   (predecessor `seed-blocker` PR merged), so this consumer self-hosts against
   the current seed — no seed cut for the runner rewrite.

---

## a. Baseline `--json` pinning tests (inventory)

Two classes pin `--json`. **Neither pins multi-failure assertion *locations*.**

### Renderer contract (unit) — unaffected by transport

`compiler/tests/integration/test_runner_json_test.sfn` is the golden pin for the
wire schema. It calls `render_start_event` / `render_summary_event` /
`render_test_event` / `render_assert_failure_json` / `render_hook_event` /
`collect_test_entries` / `locate_failing_test` **directly** with hand-built
inputs and asserts exact bytes (e.g. `test_runner_json_test.sfn:57,73,99,121`).
It never drives the binary and never exercises the runner's record ingestion, so
the transport rewrite cannot change its inputs. Schema version pinned at `2`
(`:49`). **Must stay green unchanged** — the runner keeps calling these
renderers with the same arguments.

### End-to-end (drives the actual binary) — what each asserts

| File | Asserts | Pins a 2nd/3rd-failure location? |
|---|---|---|
| `compiler/tests/e2e/runner_json_multifile_test.sfn` | valid jsonl (every line starts `{`), one `start` + one `summary`, `"total":3`/`"passed":3`, presence of `"status":"fail"`, `"failed":0` absent on failure | **No** — counts + presence only |
| `compiler/tests/e2e/runner_jobs_parallel_test.sfn` | `--jobs 1`≡`--jobs 4`: one `start`+`summary`, `"total":6`/`"passed":6`/`"failed":0`, exactly 6 `test` events, human `"4/4 passed"` banner, invalid `--jobs`→exit 2 | **No** — counts + event *count* only |
| `compiler/tests/e2e/recoverable_harness_test.sfn` | continue-after-fail: `"passed":2,"failed":1,"skipped":0`; before_each: `"passed":0,"failed":2,"skipped":0`; after_all: `"event":"hook"`,`"hook":"after_all"`,`"passed":2`; test names present | **No** — counts + names + hook attribution |
| `compiler/tests/e2e/crash_attribution_test.sfn` | SIGSEGV single-file: human `[test] FAIL:` present, crashed filename present, exit≠0; agent verdict `"failure":"crash"` | **No** — presence + classification |

`compiler/tests/e2e/check_json_schema_test.sfn` and
`dx_transfer_ergonomics_gate_test.sfn` assert `"line":N,"column":N` on
**compiler diagnostics** (`sfn check --json`), not on the test-runner event
stream — out of scope.

**Verdict for the byte-identical design:** no test asserts the `assertion`
`{file,line,col}` object of a *second or third* failing test within one file, nor
the exact assertion location of any streamed failing test. The only
location-bearing assertions are on the compiler-diagnostic path. This means the
byte-identical bar is a self-imposed safety property, not a test-enforced one —
but the two-channel design below satisfies it *by construction* anyway.

---

## b. Byte-identical verdict — CONFIRMED

The coordinator's two-channel harness maps **exactly** onto the pre-existing
two-file semantics the runner already consumes:

| Old (retired) | New (SFTR stream) |
|---|---|
| `results.log` → `parse_test_results_log` → `records` (`T`/`H`, report messages, no location) | `test`/`hook` SFTR records → same `T`/`H` `TestResultRecord`s (report messages, location fields empty) |
| `fail.bin` → `_parse_assert_failure_record` → first SFAF → `failure: AssertFailure` (raw file/line/col, **raw** message) | `assert` SFTR records → **first** one → `failure: AssertFailure` (raw file/line/col, **raw** message) |

The runner therefore:

1. ingests the full parsed record list from the child's stderr;
2. **splits** it into `assert_records` (kind `"A"`) and `test_hook_records`
   (kind `"T"`/`"H"`), preserving order within each;
3. reconstructs `failure` = `_assert_failure_from_record(assert_records[0])`
   (or `_empty_assert_failure()` when none) — the exact analog of "first SFAF
   from `fail.bin`";
4. passes `test_hook_records` as `records` and that `failure` to the **unchanged**
   `_emit_results_events` (test.sfn:1968-2055), and to the unchanged crash /
   non-zero fall-through branch (1500-1542).

**Why this is byte-identical (not merely count-identical).** The single field
`_emit_results_events` reads off `failure` is `failure.message`
(`test.sfn:2014,2031`), correlated against each `T`-record's message to decide
real-location vs `_synthetic_assert_failure(test_path, r.message)` (0:0). Because
the `assert` record carries the **raw** assert message (identical to what
`fail.bin` stored) and the `test`/`hook` records carry the **report** message
(identical to what `results.log` stored — including the
`"hook before_each failed: "` prefix that `sfn_test_report_caught` adds), every
`failure.message == r.message` comparison yields the **same boolean** as the old
two-file path, for every case:

- single test-body failure → `failure.message` == that record's raw message →
  real location (unchanged);
- N failing bodies, same message → `failure.message` (from first `assert`) ==
  every same-message record → all get the first location (the old quirk,
  reproduced);
- N failing bodies, different messages → only the first matches → real loc for
  #1, synthetic for the rest (unchanged);
- `before_each`-caused `T fail` → its record message is prefixed and never
  equals the raw `failure.message` → synthetic 0:0 (**unchanged**; this is the
  sub-case a naive location-fold would have broken — the separate `assert` record
  is precisely what keeps it byte-identical);
- `H` records (before_all/after_each/after_all) → rendered via
  `render_hook_event`, never consult `failure` → unchanged.

**No divergence identified.** The earlier concern (folding a real location into
every fail record) does not apply because the coordinator's implementation keeps
location on a *separate* record — restoring the old two-channel contract exactly.
`_emit_results_events` and all call sites keep **zero logic change**; the only
edit is *where the two inputs come from* (stream split instead of two file
reads). This is the strongest possible guarantee: the classifier's inputs are
bit-for-bit the same values it received before.

**Crash-gate corollary (#1206), confirmed:**
- SIGSEGV (no assert call): no `assert` and no `test`/`hook` record → `records`
  empty, `failure` absent → `results.length > 0` false → falls to `if run_rc != 0`
  crash branch (1500). Unchanged.
- non-frame `abort()` from an assert: **one `assert` record, no `test`/`hook`
  record** → `records` empty (`_records_have_failure` not even consulted),
  `failure` present → crash branch prints `test failed: <loc>` via
  `failure.present` (1533-1535). Matches old `fail.bin` behavior.
- pass-then-crash: `records` = `[T pass]`, `_records_have_failure` = false,
  `run_rc != 0` → `results_explain` false → crash branch, **not** masked as pass
  (the #1206 invariant). Unchanged.

---

## c. Level 3 → Level 2 demux (the compiled-binary exec)

Replaces `process.run(_test_exec_argv(...))` at **test.sfn:1414** (and the retry
re-run at **1447**) plus `_consume_assert_failure_record` (**1906-1912**) and
`_consume_test_results_log` (**1918-1924**).

### New types + helpers

```sfn
// Module-private: the parser's normalized kind tag for an assert-location
// record. MUST equal the tag test_results.sfn emits for an `assert` SFTR record.
// (see §0.2)
// let _STREAM_ASSERT_KIND: string = "A";   // SCREAMING_SNAKE constant

struct TestBinResult {
    rc: int,                    // handle_wait exit code, 124 if deadline-killed
    records: TestResultRecord[],// T/H only (assert split out)
    failure: AssertFailure,     // first assert record, or _empty_assert_failure()
    deadline_killed: boolean
}
```

`_test_exec_env` — replaces the `env KEY=VAL` argv prefix of `_test_exec_argv`.
`spawn_with_env` takes the child's **entire** environment (empty ≠ inherit), so
snapshot the parent env and override the two test-runner keys. `SAILFIN_TEST_SCRATCH`
is still read by the compiled binary via `sfn/test` fixtures (`with_tmp_dir`,
`nested_runner_scratch` — `capsules/sfn/test/src/fixtures.sfn:185`), and
`SAILFIN_UPDATE_SNAPSHOTS` by `snapshot.sfn:50`, so both must be threaded.

```sfn
fn _test_exec_env(scratch_root: string, update_snapshots: boolean) -> string[] ![io] {
    let base = process.environ();            // full parent env (already used by _pool_env_snapshot)
    let mut env_flat: string[] = [];
    let mut i: int = 0;
    loop {
        if i >= base.length { break; }
        let e = base[i];
        // Drop inherited copies of the keys we re-set (POSIX getenv takes the first).
        if !_env_entry_has_key(e, "SAILFIN_TEST_SCRATCH")
            && !_env_entry_has_key(e, "SAILFIN_UPDATE_SNAPSHOTS") {
            env_flat.push(e);
        }
        i += 1;
    }
    env_flat.push("SAILFIN_TEST_SCRATCH=" + scratch_root);
    if update_snapshots { env_flat.push("SAILFIN_UPDATE_SNAPSHOTS=1"); }
    return env_flat;
}
```

### The demux loop (pseudo-Sailfin)

Reads **only the fd `poll_any` reports ready** each iteration — the chunk reads
are blocking `read(2)` mirrors, so reading a not-ready fd would deadlock; and the
fds go to `-1` at EOF, so re-fetch them every iteration.

```sfn
fn _run_test_binary(exe_path: string, scratch_root: string,
                    update_snapshots: boolean, json_output: boolean,
                    deadline_ms: int) -> TestBinResult ![io] {
    let env = _test_exec_env(scratch_root, update_snapshots);
    let h = process.spawn_with_env([exe_path], env);
    if h == 0 {
        // spawn failure — mirror process.run's 127 missing-command convention
        return TestBinResult { rc: 127, records: [], failure: _empty_assert_failure(), deadline_killed: false };
    }

    let mut all: TestResultRecord[] = [];   // both A and T/H, in stream order
    let mut err_buf: string = "";           // stderr line-accumulator
    let mut deadline_killed: boolean = false;
    let start_ms = monotonic_millis();

    loop {
        if process.handle_stdout_at_eof(h) && process.handle_stderr_at_eof(h) { break; }

        // Deadline → SIGKILL. deadline_ms <= 0 means "no deadline" (poll blocks).
        let mut poll_to: int = -1;
        if deadline_ms > 0 {
            let remaining = deadline_ms - (monotonic_millis() - start_ms) as int;
            if remaining <= 0 {
                process.handle_kill(h);
                deadline_killed = true;
                break;
            }
            poll_to = remaining;
        }

        let out_fd = process.handle_stdout_fd(h);   // re-fetch: -1 after EOF
        let err_fd = process.handle_stderr_fd(h);
        let mut fds: int[] = [];
        if out_fd >= 0 { fds.push(out_fd); }
        if err_fd >= 0 { fds.push(err_fd); }
        if fds.length == 0 { break; }

        let ready = io.poll_any(fds, poll_to);
        if ready < 0 {
            // -1 = timeout or transient (EINTR); only kill on genuine deadline.
            if deadline_ms > 0 && (monotonic_millis() - start_ms) as int >= deadline_ms {
                process.handle_kill(h);
                deadline_killed = true;
                break;
            }
            continue;
        }

        if ready == out_fd {
            let chunk = process.handle_read_bytes_stdout(h, 65536);
            // User output. Human mode: forward to level-2 stdout. JSON mode: drop
            // (retires the `sh -c 'exec "$0" >/dev/null'` swallow wrapper).
            if chunk.length > 0 && !json_output { _emit_captured_stream(chunk, false); }
        } else if ready == err_fd {
            let chunk = process.handle_read_bytes_stderr(h, 65536);
            if chunk.length > 0 {
                err_buf = err_buf + chunk;
                loop {
                    let nl = index_of(err_buf, "\n");
                    if nl < 0 { break; }
                    let line = substring(err_buf, 0, nl);
                    err_buf = substring(err_buf, nl + 1, err_buf.length);
                    _ingest_child_stderr_line(line, all);
                }
            }
        }
    }

    // Truncated final line (mid-crash): try to frame it, else forward as diagnostic.
    if err_buf.length > 0 { _ingest_child_stderr_line(err_buf, all); }

    let rc0 = process.handle_wait(h);   // sole reaper/free path — always call
    let mut rc = rc0;
    if deadline_killed { rc = 124; }    // preserve timeout==124; avoid OOM/crash-137 confusion (§f)

    return TestBinResult {
        rc: rc,
        records: _test_hook_records(all),
        failure: _first_assert_failure(all),
        deadline_killed: deadline_killed
    };
}

// One complete stderr line → record or forwarded diagnostic.
fn _ingest_child_stderr_line(line: string, all: TestResultRecord[]) -> void ![io] {
    let rec = parse_test_record_line(line);   // test_results.sfn, §0.2
    if rec != null {
        let r: TestResultRecord = rec;
        all.push(r);
    } else {
        // Non-record diagnostic (compiler errors, crash spew, harness breadcrumbs)
        // — forward to level-2 stderr, as inherited stdio did before.
        print.err(line);
    }
}

fn _first_assert_failure(all: TestResultRecord[]) -> AssertFailure {
    let mut i: int = 0;
    loop {
        if i >= all.length { break; }
        if strings_equal(all[i].kind, "A") { return _assert_failure_from_record(all[i]); }
        i += 1;
    }
    return _empty_assert_failure();
}

fn _assert_failure_from_record(r: TestResultRecord) -> AssertFailure {
    return AssertFailure { present: true, file: r.file, line: r.line, col: r.col, message: r.message };
}

fn _test_hook_records(all: TestResultRecord[]) -> TestResultRecord[] {
    let mut out: TestResultRecord[] = [];
    let mut i: int = 0;
    loop {
        if i >= all.length { break; }
        if !strings_equal(all[i].kind, "A") { out.push(all[i]); }
        i += 1;
    }
    return out;
}
```

`_emit_captured_stream(text, false)` (test.sfn:2837) is reused for the human-mode
stdout forward; it strips a single trailing `\n` and re-emits — byte-faithful for
the line-oriented chunk. (Simpler than a raw writer; the child's user output is
line-oriented.)

### Call-site rewrite at test.sfn:1398-1457

Delete the pre-exec `fail.bin`/`results.log` unlink block (**1398-1411**) and the
in-retry unlink block (**1441-1446**) — no files exist anymore. The exec+retry
collapses to:

```sfn
let deadline_ms = _test_deadline_ms();     // §f
let mut br = _run_test_binary(exe_path, scratch_root, update_snapshots, json_output, deadline_ms);
if _should_retry_test(br.rc, retries_disabled) {       // br.rc is 124 (not 137) on deadline → no retry
    if !json_output {
        print("[test] RETRY: " + _package_basename(path) + " (exit code "
            + number_to_string(br.rc) + ", retrying once)");
    }
    br = _run_test_binary(exe_path, scratch_root, update_snapshots, json_output, deadline_ms);
}
let run_rc = br.rc;
let failure = br.failure;      // was _consume_assert_failure_record(scratch_root)
let results = br.records;      // was _consume_test_results_log(scratch_root)
```

Everything from **1458** (`file_elapsed_ms`) through **1565** is **unchanged** —
`results_explain`, `_records_have_failure`, `_emit_results_events`, the crash
fall-through, and the arena rewind all consume `results`/`failure` exactly as
before.

---

## d. Level 2 → Level 1 subframe aggregation (Channel B)

**Chosen approach: option (c) — the subframe child emits its `summary` jsonl line
on its own stderr; the parent extracts counts from it during the reap demux and
does not forward it.** Rationale over the alternatives:

- Option (b) "count the forwarded per-test events on stdout" cannot recover the
  `cache` counters (`test_bin_hits`/`test_bin_misses`) — they live only in the
  child's summary, and the aggregate summary's `"cache":{...}` object is part of
  schema v2 (pinned by `test_runner_json_test.sfn:73`). Dropping them changes the
  final summary bytes.
- Option (a) "child re-emits SFTR records up its stderr" duplicates the per-test
  events (already on the child's stdout) and invents a second record emitter.
- Option (c) is the **minimal delta** from today: the child already renders the
  exact `render_summary_event(...)` line — today it `fs.writeFile`s it into
  `_subframe_summary.json`; now it `print.err`s it. The parent already knows how
  to scrape it (`_extract_json_uint_after`). The single-frame contract holds: the
  child still suppresses its stdout `start` (test.sfn:1203, unchanged) and now
  routes its `summary` to **stderr** (consumed by the parent, never forwarded to
  the shared stdout), so the parent still emits exactly one `start` + all
  forwarded per-test events + one aggregate `summary`.

### Child-side edits (the level-2 runner, `json_subframe` branch)

- **test.sfn:1566-1573** — replace the file write with a stderr emit:

```sfn
if json_subframe {
    print.err(summary_line);          // was fs.writeFile(scratch_root + "/_subframe_summary.json", ...)
} else { print(summary_line); }
```

- **test.sfn:632-638** (empty-discovery subframe path) — same swap:
  `if json_subframe { print.err(render_summary_event(0,0,0,0,0,0)); } else { ... }`.

### `_extract_json_uint_after` — RETAINED (correction to the delete-list)

The scraper (**test.sfn:2925-2939**) is **kept**, repurposed from reading the
`_subframe_summary.json` file to reading the summary line off the child's stderr
inside `_reap_test_child`. Its comment header is updated (no longer "sub-frame
summary file"). This is the one deviation from the coordinator's proposed
delete-list — the *file* retires, the *reader* survives.

### `_reap_test_child` rewrite

Currently (**test.sfn:2859-2867**) it blocking-drains via `handle_read_stdout` /
`handle_read_stderr` then `handle_wait`, and returns only `rc`; the caller then
reads `_subframe_summary.json`. New shape returns a `ReapResult` and does the
poll-demux (so it can both extract the summary from stderr and enforce the
deadline via `handle_kill`, retiring the outer `timeout(1)`):

```sfn
struct ReapResult {
    rc: int, passed: int, failed: int, skipped: int,
    tb_hits: int, tb_misses: int,
    summary_seen: boolean, deadline_killed: boolean
}

fn _reap_test_child(handle: int, deadline_ms: int, json_output: boolean) -> ReapResult ![io] {
    if handle == 0 {
        return ReapResult { rc: 127, passed: 0, failed: 0, skipped: 0,
            tb_hits: 0, tb_misses: 0, summary_seen: false, deadline_killed: false };
    }
    let mut out_buf: string = "";     // level-2 stdout (per-test events / human output) — forward verbatim
    let mut err_buf: string = "";     // level-2 stderr line-accumulator
    let mut passed: int = 0; let mut failed: int = 0; let mut skipped: int = 0;
    let mut tb_hits: int = 0; let mut tb_misses: int = 0;
    let mut summary_seen: boolean = false;
    let mut deadline_killed: boolean = false;
    let start_ms = monotonic_millis();

    loop {
        if process.handle_stdout_at_eof(handle) && process.handle_stderr_at_eof(handle) { break; }
        let mut poll_to: int = -1;
        if deadline_ms > 0 {
            let remaining = deadline_ms - (monotonic_millis() - start_ms) as int;
            if remaining <= 0 { process.handle_kill(handle); deadline_killed = true; break; }
            poll_to = remaining;
        }
        let out_fd = process.handle_stdout_fd(handle);
        let err_fd = process.handle_stderr_fd(handle);
        let mut fds: int[] = [];
        if out_fd >= 0 { fds.push(out_fd); }
        if err_fd >= 0 { fds.push(err_fd); }
        if fds.length == 0 { break; }
        let ready = io.poll_any(fds, poll_to);
        if ready < 0 {
            if deadline_ms > 0 && (monotonic_millis() - start_ms) as int >= deadline_ms {
                process.handle_kill(handle); deadline_killed = true; break;
            }
            continue;
        }
        if ready == out_fd {
            let chunk = process.handle_read_bytes_stdout(handle, 65536);
            if chunk.length > 0 { out_buf = out_buf + chunk; }   // buffer → emit once at end (grouped per file)
        } else if ready == err_fd {
            let chunk = process.handle_read_bytes_stderr(handle, 65536);
            if chunk.length > 0 {
                err_buf = err_buf + chunk;
                loop {
                    let nl = index_of(err_buf, "\n");
                    if nl < 0 { break; }
                    let line = substring(err_buf, 0, nl);
                    err_buf = substring(err_buf, nl + 1, err_buf.length);
                    if json_output && _is_subframe_summary_line(line) {
                        passed   += _extract_json_uint_after(line, "\"passed\":");
                        failed   += _extract_json_uint_after(line, "\"failed\":");
                        skipped  += _extract_json_uint_after(line, "\"skipped\":");
                        tb_hits  += _extract_json_uint_after(line, "\"test_bin_hits\":");
                        tb_misses+= _extract_json_uint_after(line, "\"test_bin_misses\":");
                        summary_seen = true;                 // consumed, NOT forwarded
                    } else {
                        print.err(line);                     // forward diagnostic to level-1 stderr
                    }
                }
            }
        }
    }
    if err_buf.length > 0 {
        // trailing partial stderr line: never a summary (summary ends with \n); forward.
        if !(json_output && _is_subframe_summary_line(err_buf)) { print.err(err_buf); }
        else {
            passed += _extract_json_uint_after(err_buf, "\"passed\":"); /* ...same five... */
            summary_seen = true;
        }
    }

    let rc0 = process.handle_wait(handle);
    let mut rc = rc0;
    if deadline_killed { rc = 124; }

    // Emit level-2 stdout grouped per file, in file order (never interleaved
    // mid-file) — reap is in-order and fully drains each child before returning.
    _emit_captured_stream(out_buf, false);

    return ReapResult { rc: rc, passed: passed, failed: failed, skipped: skipped,
        tb_hits: tb_hits, tb_misses: tb_misses, summary_seen: summary_seen, deadline_killed: deadline_killed };
}

fn _is_subframe_summary_line(line: string) -> boolean {
    return index_of(line, "{\"event\":\"summary\"") == 0;
}
```

Buffering level-2 stdout and emitting once at the end (not streaming line-by-line)
keeps the pooled-output-grouped-per-file guarantee byte-identical to today's
`_emit_captured_stream(child_stdout, false)` — the poll loop is only there to
drain both pipes concurrently (deadlock avoidance) and to skim the summary line
off stderr. Non-summary stderr is forwarded line-by-line as it arrives (crash
diagnostics stay live).

### Aggregation call-site rewrites

**Pool path (jobs>1).** At **test.sfn:834** drop the `timeout_cmd, timeout_secs`
from `_pool_child_argv`; the spawn is otherwise unchanged. Replace the reap +
file-scrape block (**840, 873-888**):

```sfn
let reap = _reap_test_child(handles[ti], deadline_ms, json_output);
let rc = reap.rc;
// ... _should_retry_test(rc, sub_retries_disabled) gate unchanged (rc is 124 on deadline) ...
if json_output {
    if reap.summary_seen {
        sf_passed += reap.passed; sf_failed += reap.failed; sf_skipped += reap.skipped;
        sf_tb_hits += reap.tb_hits; sf_tb_misses += reap.tb_misses;
    } else { sf_failed += sf_counts[ti]; }   // child died before summary — unchanged fallback
}
```

The serial retry tail (**901-951**) gets the same treatment: its `_reap_test_child`
call takes `(retry_handle, deadline_ms, json_output)`, and the file-scrape at
**941-948** becomes the `reap.summary_seen` aggregation above. The stale
`_subframe_summary.json` unlink at **921-922** is deleted (no file).

**Serial multi-file path (jobs==1, test.sfn:953-1010).** Convert from
`_run_test_child` (blocking `process.run`, inherited stdio — which would leak the
child's stderr summary line) to spawn+reap:

```sfn
let child_env = _pool_child_env(pool_base_env, child_scratch, sub_root, stamp_nonce, update_snapshots, json_output);
let handle = process.spawn_with_env(_pool_child_argv(self_exe, path, name_filter, tag_filter, json_output, no_test_cache), child_env);
let mut reap = _reap_test_child(handle, deadline_ms, json_output);
if _should_retry_test(reap.rc, sub_retries_disabled) {
    if !json_output { print("[test] RETRY: " + _package_basename(path) + " ..."); }
    let rh = process.spawn_with_env(...same argv..., ...same env...);
    reap = _reap_test_child(rh, deadline_ms, json_output);
}
let rc = reap.rc;
// pass/fail accounting (980-992) unchanged; json aggregation (993-1007) → reap.summary_seen block above.
```

`pool_base_env` (test.sfn:809) is currently pool-only; hoist its
`_pool_env_snapshot()` init so the serial branch can build `_pool_child_env` too
(one `process.environ()` call, negligible). This unifies both multi-file paths on
`spawn_with_env` + `_reap_test_child`, which is required because the summary now
rides stderr and must be captured, not inherited.

---

## e. Delete list + env/wrapper retirement

### Deleted symbols (test.sfn)

| Symbol / block | Anchor | Replacement |
|---|---|---|
| `_test_exec_argv` (incl. `sh -c 'exec "$0" >/dev/null'` swallow) | 2874-2896 | `_test_exec_env` + direct `spawn_with_env([exe_path], env)` |
| `_consume_assert_failure_record` | 1906-1912 | `TestBinResult.failure` from stream split |
| `_consume_test_results_log` | 1918-1924 | `TestBinResult.records` from stream split |
| `_run_test_child` | 2690-2732 | `_spawn_test_child` inline (spawn+reap in serial branch) |
| `_resolve_timeout_cmd` | 2623 | retired — deadline enforced by `handle_kill` (verify no other caller before deleting) |
| pre-exec `fail.bin`/`results.log` unlink | 1398-1411 | none (no files) |
| in-retry unlink | 1441-1446 | none |
| `_subframe_summary.json` write (empty-discovery) | 634 | `print.err(...)` |
| `_subframe_summary.json` write (main) | 1572 | `print.err(summary_line)` |
| pool file-scrape | 879-887 | `reap.summary_seen` aggregation |
| retry-tail file-scrape + stale unlink | 921-922, 941-948 | `reap.summary_seen` aggregation |
| serial file-scrape | 999-1007 | `reap.summary_seen` aggregation |

### Modified signatures

- `_reap_test_child(handle: int)` → `_reap_test_child(handle: int, deadline_ms: int, json_output: boolean) -> ReapResult` (2859).
- `_pool_child_argv(timeout_cmd, timeout_secs, self_exe, path, ...)` → `_pool_child_argv(self_exe, path, name_filter, tag_filter, json_output, no_test_cache)` (2741) — drop the two timeout params + the leading `if timeout_cmd.length>0` push.
- New `_test_deadline_ms() -> int ![io]` (§f).

### Retained (do NOT delete)

- `_extract_json_uint_after` (2925) — repurposed onto the stderr summary line.
- `_emit_captured_stream` (2837) — reused by both demux functions.
- `_synthetic_assert_failure` (2303), `AssertFailure` / `_empty_assert_failure`.
- `_test_timeout_secs` (2612) — feeds `_test_deadline_ms`.
- `_pool_env_snapshot` / `_pool_child_env` / `_env_entry_has_key`.

### Env keys (`_pool_child_env`, test.sfn:2803-2828) — all STAY

| Key | Status | Why |
|---|---|---|
| `SAILFIN_TEST_SCRATCH` | **stay** (strip+rescope) | now build-cache root + `sfn/test` fixture temp dirs; per-child isolation still required |
| `SAILFIN_TEST_RUNTIME_OBJDIR` / `_STAMP` | stay | runtime object cache, unrelated to IPC |
| `SAILFIN_UPDATE_SNAPSHOTS` | stay | snapshot rebaseline (`snapshot.sfn:50`) |
| `SAILFIN_TEST_JSON_SUBFRAME` | **stay** | now means "route `summary` to stderr, suppress stdout `start`" — still the subframe discriminator |

No key retires, so **`_pool_child_env` and the paired
`capsules/sfn/test/src/fixtures.sfn::_pool_managed_keys()` (fixtures.sfn:159-160)
are UNCHANGED.** State this explicitly in the PR so a reviewer does not expect a
fixtures edit. (The SFN-17 `_child_env` band-aid deletion in
`recoverable_harness_test.sfn` that SFEP-0050 §3.6 anticipates is a *test-side*
follow-up gated on the new `nested_runner_no_collision_test.sfn` — out of scope
for this runner rewrite; do not remove it here.)

---

## f. Retry / crash / deadline interaction

### Deadline vs OOM, both 137 — disambiguated by RC remap

`handle_kill` sends SIGKILL, so `handle_wait` on a deadline-killed child returns
`128 + 9 = 137`, indistinguishable at the syscall level from an OOM SIGKILL. The
runner tracks `deadline_killed` locally and **remaps the deadline case to 124**
(the historical `timeout(1)` exit code) inside both `_run_test_binary` and
`_reap_test_child` before returning. Consequences, all desirable and requiring
**no change to `_should_retry_test` / `_classify_test_retry`** (2498-2522):

- A **deadline kill** surfaces as `rc == 124` → `_classify_test_retry(124)` =
  `RetryPolicy.None` → **not retried** (a timeout is a real failure, not a
  transient). `_is_signal_exit(124)` is false (124 ≤ 128) → no spurious crash
  diagnostic. It propagates as `overall_rc = 124` exactly like the old wrapper.
- A **genuine OOM SIGKILL** (child died, not deadline) keeps `rc == 137`
  (`deadline_killed == false`) → `_should_retry_test(137)` true → **still
  retried once**, preserving the #845/#1303 transient-OOM self-heal.
- **SIGSEGV** stays `139` → retried once (unchanged).

The `deadline_killed` boolean is retained in both result structs for clarity and
so a future human-mode "timeout" banner can be gated on it, but the RC remap is
the load-bearing mechanism — do not additionally special-case 137 anywhere.

### `_test_deadline_ms`

```sfn
fn _test_deadline_ms() -> int ![io] {
    // Reuse the existing per-file cap (_test_timeout_secs, 2612), parsed to ms.
    // <= 0 (unset / "0") → no deadline: poll_any blocks, matching today's
    // single-file top-level path which had no timeout wrapper at all.
    let secs = _parse_int_or_zero(_test_timeout_secs());
    if secs <= 0 { return 0; }
    return secs * 1000;
}
```

The level-2→level-3 exec now *gains* a deadline (single-file top-level `sfn test
<file>` was previously unbounded), and the level-1→level-2 spawn *keeps* its
deadline but via `handle_kill` instead of a `timeout(1)` argv wrapper. Both use
`_test_deadline_ms()`; the inner (run) deadline being equal to the outer
(compile+link+run) deadline is fine — the outer fires first for a compile/link
hang, the inner bounds a runaway test body.

### #1206 crash gate

Covered in §b (crash corollary) — the assert/test-hook split leaves `records`
(T/H only) empty on a hard crash, so `results_explain` is false and control
falls to the crash branch (test.sfn:1500), never masking a non-zero exit as a
pass. No change to that branch.

---

## Files affected (by pipeline stage)

- **Runner (this note):** `compiler/src/cli/commands/test.sfn` — new
  `_run_test_binary`/`TestBinResult`/`_test_exec_env`/`_first_assert_failure`/
  `_assert_failure_from_record`/`_test_hook_records`/`_ingest_child_stderr_line`,
  rewritten `_reap_test_child`/`ReapResult`/`_is_subframe_summary_line`/
  `_test_deadline_ms`, modified `_pool_child_argv`, serial-branch spawn+reap,
  summary-to-stderr swaps, deletions per §e.
- **Parser (parallel work, assumed):** `compiler/src/test_results.sfn`
  (`parse_test_record_line`, `TestResultRecord.file/line/col`, `"A"` kind).
- **Struct (parallel work, assumed):** `compiler/src/assert_failure.sfn` (SFAF
  parser deleted, struct retained).
- **Harness (parallel work, assumed):** `runtime/sfn/assert.sfn`.
- **Unchanged:** `compiler/src/test_runner_json.sfn` (renderers),
  `capsules/sfn/test/src/fixtures.sfn` (`_pool_managed_keys`),
  `runtime/sfn/process.sfn` (primitives in seed).

---

## Dependencies

1. Foundation §0 lands first *within the same PR/commit series* (writer + parser
   + struct). Bundle with this runner rewrite in **one PR** — `make compile`
   builds the new compiler (emitting the SFTR harness) from the old seed, and
   that compiler runs the suite *through this new runner*, so writer/reader skew
   fails the gate by construction. No seed cut (the five `process.*` primitives
   are already in the pinned seed).
2. The `"A"` kind tag string must be agreed between `test_results.sfn` and the
   runner split (§0.2).

---

## Implementation sequence (checkpoint after each)

1. **Level 3 → 2 core.** Add `TestBinResult`, `_test_exec_env`,
   `_run_test_binary`, `_first_assert_failure`, `_assert_failure_from_record`,
   `_test_hook_records`, `_ingest_child_stderr_line`, `_test_deadline_ms`. Rewire
   test.sfn:1398-1457 to `_run_test_binary`. Delete `_consume_*`, `_test_exec_argv`.
   *Checkpoint:* `sfn check compiler/src/cli/commands/test.sfn`; after
   `make compile`, `build/bin/sfn test compiler/tests/e2e/crash_attribution_test.sfn`
   and a single-file pass + single-file fail fixture.
2. **Subframe summary → stderr.** Swap test.sfn:632-638 and 1566-1573 to
   `print.err`. Update `_extract_json_uint_after` header comment. *Checkpoint:*
   `sfn check`.
3. **Level 2 → 1 reap.** Add `ReapResult`, `_is_subframe_summary_line`; rewrite
   `_reap_test_child`; drop timeout params from `_pool_child_argv`; rewire pool
   spawn (834) + reap/aggregate (840, 873-888) + retry tail (901-951). *Checkpoint:*
   `sfn check`; after `make compile`,
   `build/bin/sfn test compiler/tests/e2e/runner_jobs_parallel_test.sfn` and
   `runner_json_multifile_test.sfn`.
4. **Serial multi-file → spawn+reap.** Hoist `pool_base_env`; convert 953-1010;
   delete `_run_test_child`, `_resolve_timeout_cmd` (after confirming no other
   caller via grep). *Checkpoint:* `sfn check`; `build/bin/sfn test
   compiler/tests/e2e/recoverable_harness_test.sfn`.
5. **Self-host + full gate.** `make compile`; targeted
   `build/bin/sfn test compiler/tests/integration/test_runner_json_test.sfn`
   (renderer pins must be untouched); then `make check`.

---

## Risks + the test that catches each

| Risk | Detection |
|---|---|
| Blocking read on a not-ready fd (cross-pipe deadlock) if the loop reads any fd other than `poll_any`'s returned `ready` | any `--json` multi-file run hangs — `runner_jobs_parallel_test.sfn`, `runner_json_multifile_test.sfn` (wall-clock via `make check`) |
| `"A"` kind tag mismatch between parser and runner split → assert records leak into `records` (miscount) or `failure` never reconstructed (0:0 locations) | `test_runner_json_test.sfn` renderer pins + a single-fail e2e; add a unit that feeds a known `assert`+`test` line pair through the split |
| Summary line not filtered from forwarded stderr → a stray `{"event":"summary"...}` on level-1 stderr, or double-counted | `runner_json_multifile_test.sfn` single-frame assertions (`== 1` start/summary) + `--jobs 1`≡`--jobs 4` counts (`runner_jobs_parallel_test.sfn`) |
| Deadline 137 mis-remapped → a timeout retried (doubled wall-clock) or misreported as crash | a fixture with an infinite-loop test under a low `_test_timeout_secs`; assert single run, `rc == 124`, no RETRY banner |
| OOM/SIGSEGV 137/139 no longer retried after refactor | `crash_attribution_test.sfn` (139 path) + the #1303 seedcheck memory-pressure retry under `make check` |
| Crash masked as pass (records-explain regression) | `crash_attribution_test.sfn` + `check_build_agree_module_global_test.sfn` |
| Buffered level-2 stdout re-emission drops/duplicates a trailing newline → jsonl line boundary corruption | `runner_json_multifile_test.sfn` "every line starts with `{`" |
| `SAILFIN_TEST_SCRATCH` not threaded to level-3 env → `sfn/test` `with_tmp_dir`/`nested_runner_scratch` fixtures fault | `recoverable_harness_test.sfn`, `crash_attribution_test.sfn` (both use nested scratch) |

---

## Future considerations

- **SFEP-0045 exec-only `__run-test-bin` child** rides this transport directly:
  `_run_test_binary` is exactly the "exec a prebuilt binary and forward its
  streamed records" primitive that child needs — factor it so SFEP-0045 can call
  it without the compile/link preamble.
- **Per-record locations** now carried in `TestResultRecord.file/line/col` are
  unused by `_emit_results_events` (kept byte-identical). A future schema bump
  could let each failing `test` event use its *own* record location instead of
  the correlated first-`assert` location — retiring the `failure.message == r.message`
  correlation entirely. That is a deliberate, separately-gated schema change, not
  part of this note.
- **Nested-collision band-aid removal** (`recoverable_harness_test.sfn`,
  `_child_env`) is unblocked by the per-process pipe channel but stays a
  follow-up under the new `nested_runner_no_collision_test.sfn`.
