#!/usr/bin/env bash
#
# Agent-tail verdict block emitter (epic #1056 Phase 1, issue #1059).
#
# Wraps an agent-facing `make` target so that — on success AND on failure —
# the LAST lines of output are a single greppable verdict block:
#
#   ===SAILFIN-RESULT===
#   {"schema_version":"sailfin-make/1","target":"check","status":"fail",...}
#   ===END-SAILFIN-RESULT===
#
# An agent greps the (last) `===SAILFIN-RESULT===` marker and parses the one
# JSON line that follows to learn {target, status, failure-class, phase,
# first-error} from a tail-truncated log, with zero upthread scrolling.
# Schema: docs/reference/make-result-schema.md (`sailfin-make/1`).
#
# Design: docs/proposals/0014-agent-output-orchestration.md §1 (tail contract),
# §2 (failure taxonomy), Phase 1.
#
# Usage:
#   scripts/agent_report.sh --target <name> -- <command> [args...]
#
# Behaviour:
#   - The command's combined stdout+stderr is streamed through unchanged and
#     also captured for best-effort classification.
#   - A `trap ... EXIT` guarantees the verdict block is emitted last even if
#     a phase aborts or the wrapper itself is interrupted.
#   - An interrupted run is never reported as a pass. If the wrapper is
#     terminated before the wrapped command finishes, the verdict is
#     `status:"fail"` / `failure:"timeout"` (see the abort-detection block).
#   - SAILFIN_INNER guard: a nested invocation (e.g. `make check`'s inner
#     `make test`) runs transparently and emits NO sentinel — only the outer
#     target's verdict is printed. This wrapper sets SAILFIN_INNER=1 for the
#     command it runs, so any wrapped sub-target it spawns is suppressed.
#
# Phase 1 is best-effort for `phase` and `first_error`; precise file:line
# extraction by parsing tool JSON is Phase 3. This file touches no compiler
# source — it is build orchestration only.

set -uo pipefail

# --- argument parsing --------------------------------------------------------
TARGET=""
while [ $# -gt 0 ]; do
	case "$1" in
		--target)
			TARGET="${2:-}"
			shift 2
			;;
		--)
			shift
			break
			;;
		*)
			echo "agent_report.sh: unexpected argument '$1'" >&2
			echo "usage: agent_report.sh --target <name> -- <command> [args...]" >&2
			exit 2
			;;
	esac
done

if [ -z "$TARGET" ] || [ $# -eq 0 ]; then
	echo "usage: agent_report.sh --target <name> -- <command> [args...]" >&2
	exit 2
fi

# --- nested-invocation guard -------------------------------------------------
# A wrapped target reached from inside another wrapped target (e.g. `make
# check` -> `make test`) must NOT emit its own sentinel. Run transparently.
if [ -n "${SAILFIN_INNER:-}" ]; then
	exec "$@"
fi
# We are the outermost agent-facing target: claim the verdict and suppress
# any nested wrapped targets the command spawns.
export SAILFIN_INNER=1

# --- report-file gate (#1119) ------------------------------------------------
# JSON=1 / SAILFIN_AGENT_REPORT=1 (set by the Makefile, exported into our env)
# activates a per-target full report file at build/agent-report.<target>.json.
# When the gate is off REPORT_PATH stays empty: no file is written and the
# verdict block's `report` field stays null. The path is target-specific so
# parallel CI shards (e.g. `make test` + `make compile`) never collide. This
# guard sits AFTER the SAILFIN_INNER early-return above, so nested wrapped
# targets never reach it and never write a file.
REPORT_PATH=""
if [ "${SAILFIN_AGENT_REPORT:-}" = "1" ]; then
	# Only enable the report path once its directory exists. If `build` can't
	# be created (read-only or unwritable workspace), REPORT_PATH stays empty
	# so the verdict block keeps `report` null instead of advertising a path no
	# file could be written to.
	if mkdir -p build 2>/dev/null; then
		REPORT_PATH="build/agent-report.${TARGET}.json"
	fi
fi

# --- output capture ----------------------------------------------------------
# Capture combined output for classification. If mktemp fails (e.g. /tmp full
# or unwritable) fall back to /dev/null: the command still streams through and
# a verdict is still emitted (best-effort classification degrades to exit-code
# only, since there's no captured text to scan).
OUTFILE="$(mktemp "${TMPDIR:-/tmp}/sailfin-agent-report.XXXXXX" 2>/dev/null || echo /dev/null)"
RC=0

# --- abort detection (#2817) -----------------------------------------------
# RC is assigned only AFTER the wrapped pipeline returns. If a terminating
# signal lands before that — CI job cancellation, a runner/VM shutdown, an
# external `timeout`, or a developer's Ctrl-C — bash runs the EXIT trap with
# `$?` still 0, so the wrapper emitted `"status":"pass"` for a target that
# never finished. That false green is the one failure this contract must not
# have: an agent (and `build-quality.yml`'s own triage path) reads the tail
# block and concludes the suite passed while the log shows it stopped a tenth
# of the way in.
#
# COMMAND_COMPLETED flips to 1 only once PIPESTATUS has been read, so
# emit_verdict can distinguish "finished with rc 0" from "was killed before
# finishing" no matter which path aborted the run. SIGNAL_RC records the
# signal's 128+signo code when we caught the signal ourselves.
COMMAND_COMPLETED=0
SIGNAL_RC=0
ABORTED=0

on_terminating_signal() {
	# Exit with the shell's own 128+signo convention; the EXIT trap below turns
	# that into a fail verdict.
	SIGNAL_RC="$1"
	exit "$SIGNAL_RC"
}
trap 'on_terminating_signal 129' HUP
trap 'on_terminating_signal 130' INT
trap 'on_terminating_signal 143' TERM

cleanup_outfile() {
	# Only remove a real temp file — never the /dev/null fallback. Guarding on
	# a regular file also keeps any rm error off the stream after the verdict.
	if [ -f "$OUTFILE" ] && [ "$OUTFILE" != "/dev/null" ]; then
		rm -f "$OUTFILE" 2>/dev/null || true
	fi
}

# --- classification ----------------------------------------------------------
# Best-effort. Reads $OUTFILE and $RC; sets STATUS / FAILURE / PHASE /
# FIRST_ERROR. Patterns are deliberately conservative; the closed enums are
# locked in docs/reference/make-result-schema.md.
STATUS="pass"
FAILURE="null"
PHASE="null"
FIRST_ERROR="null"

# Match helper: case-insensitive fixed-ish regex over the captured output.
out_has() { grep -Eiq -- "$1" "$OUTFILE" 2>/dev/null; }

# Match helper for a FIXED (non-regex) marker literal. The check-phase table
# below is matched with this so its entries can be compared byte-for-byte
# against the producer that prints them.
out_has_fixed() { grep -Fiq -- "$1" "$OUTFILE" 2>/dev/null; }

# --- check phase ledger (SFN-724) --------------------------------------------
# The ordered `make check` ledger, and the producer banner marking entry into
# each phase. ONE declaration drives both detect_check_phase and
# compose_check_phases so the two can no longer drift apart.
#
# Each record is `<phase-name>[|<literal>...]`; a phase is "reached" when ANY of
# its literals appears in the captured output. Literals are FIXED strings, each
# a verbatim substring of the producer that prints it — the Makefile
# `check-impl` target or `sfn selfhost` (compiler/src/cli_selfhost.sfn). Each
# stops short of any `$(...)` the Makefile interpolates, so the recorded text is
# what actually reaches the log.
#
# compiler/tests/e2e/check_phase_ledger_test.sfn asserts that
# verbatim-substring property against both producers, so rewording a banner
# without re-syncing this table fails the suite. That assertion is the point:
# the drift this table repairs (#1502 moved the self-host stages into
# `sfn selfhost`, changing every banner) went unnoticed for two releases
# because the previous test manufactured its own inputs from the old wording.
#
# `compile` heads the list with no literal — `check-impl` runs `make compile`
# before printing anything, so it is always reached.
#
# Order is the real pipeline order: `sfn selfhost` runs stage2 -> smoke ->
# stage3 -> fixed-point as one internal chain, and the seedcheck suite runs
# AFTER that chain (Makefile `check-impl`), not before stage3.
#
# `pass1-smoke` carries two literals because the gate has two forms: the
# default hello-world + `sfn/test` capsule smoke, and the full first-pass suite
# under `CHECK_FULL_PASS1=1`. They are mutually exclusive and occupy the same
# ordinal, so one record with both literals keeps the ledger strictly linear.
# `fixed-point` likewise carries all three of `sfn selfhost`'s outcome lines.
#
# This layer is interim: SFEP-0014 Phase 6 replaces banner-scraping with a
# native verb that cannot drift (SFN-725).
CHECK_PHASE_MARKERS=(
	'compile'
	'pass1-smoke|[check] pass1 smoke gate: hello-world + sfn/test capsule tests|[check] CHECK_FULL_PASS1=1: running full suite on first-pass binary'
	'seedcheck-build|[selfhost] building stage2 (seedcheck)...'
	'seedcheck-smoke|[selfhost] validating seedcheck binary runs hello-world...'
	'stage3-build|[selfhost] building stage3 (driven by seedcheck) for fixed-point check...'
	'fixed-point|[selfhost] stage2 == stage3: compiler is a fixed point|[selfhost] stage2 == stage3: every module IR digest matched|[selfhost] stage2 != stage3: compiler output is not yet a fixed point'
	'seedcheck-tests|[check] running full test suite with seedcheck binary'
)

# The lone non-fatal signal: `sfn selfhost` prints this and still exits 0,
# promoting the validated seedcheck binary anyway (cli_selfhost.sfn's
# exit/promotion policy). `--strict` (`make check-strict`) makes the same
# mismatch fatal — see the rc guard in classify().
CHECK_MARKER_NONDETERMINISM='[selfhost] stage2 != stage3: compiler output is not yet a fixed point'

# True when any literal of a `<name>|<lit>|...` record appears in the captured
# output. A record with no literal (`compile`) is unconditionally reached.
check_phase_reached() {
	local record="$1" rest lit
	rest="${record#*|}"
	[ "$rest" = "$record" ] && return 0
	while [ -n "$rest" ]; do
		lit="${rest%%|*}"
		if [ "$lit" = "$rest" ]; then rest=""; else rest="${rest#*|}"; fi
		[ -n "$lit" ] && out_has_fixed "$lit" && return 0
	done
	return 1
}

# 1-based index of the latest phase reached. `compile` guarantees at least 1.
check_last_reached() {
	local i last=1
	for i in "${!CHECK_PHASE_MARKERS[@]}"; do
		check_phase_reached "${CHECK_PHASE_MARKERS[$i]}" && last=$((i + 1))
	done
	printf '%s' "$last"
}

detect_check_phase() {
	local names last
	names=("${CHECK_PHASE_MARKERS[@]%%|*}")
	last="$(check_last_reached)"
	printf '%s' "${names[$((last - 1))]}"
}

detect_first_error() {
	# Best-effort `file:line` (or `file:line:col`) pointer. Full extraction by
	# parsing tool JSON is Phase 3; here we scrape the first source location.
	local loc
	loc="$(grep -Eo '[A-Za-z0-9_./-]+\.sfn:[0-9]+(:[0-9]+)?' "$OUTFILE" 2>/dev/null | head -n1)"
	printf '%s' "$loc"
}

classify() {
	# An aborted run outranks every output-derived class. The wrapped command
	# did not finish, so whatever the captured text says — a passing tally so
	# far, a fixed-point warning, a stray `error:` — describes a prefix of a run
	# that no longer has a verdict of its own. `timeout` is the class because
	# the operator action is identical to a wall-clock kill: re-run, or escalate
	# if it repeats.
	if [ "$ABORTED" -eq 1 ]; then
		STATUS="fail"
		FAILURE="timeout"
		if [ "$TARGET" = "check" ]; then
			PHASE="$(detect_check_phase)"
		else
			PHASE="$TARGET"
		fi
		local fe
		fe="$(detect_first_error)"
		if [ -n "$fe" ]; then
			FIRST_ERROR="$fe"
		else
			FIRST_ERROR="$PHASE"
		fi
		return
	fi

	# Nondeterminism is a non-fatal WARN even though `make check` exits 0.
	# Surface it without flipping the exit code. Gated on rc == 0 because
	# `make check-strict` passes `--strict` to `sfn selfhost`, where the very
	# same mismatch line is followed by a fatal exit — that run is a `fail`
	# with a real failure class, not a `warn`.
	# Scoped to `check` because `fixed-point` is a check-only phase name: every
	# other classification path routes non-check targets through PHASE=$TARGET,
	# so an unscoped match here could report `"target":"test"` with a phase
	# that target does not have.
	if [ "$TARGET" = "check" ] && [ "$RC" -eq 0 ] \
		&& out_has_fixed "$CHECK_MARKER_NONDETERMINISM"; then
		STATUS="warn"
		FAILURE="nondeterminism"
		PHASE="fixed-point"
		return
	fi

	if [ "$RC" -eq 0 ]; then
		STATUS="pass"
		FAILURE="null"
		PHASE="null"
		return
	fi

	# rc != 0 -> a real failure. Classify into the closed set.
	STATUS="fail"

	# OOM before timeout: an OOM-killed process can exit 137 (== timeout's
	# SIGKILL code), so a memory signature wins the tie.
	if out_has 'out of memory|cannot allocate memory|std::bad_alloc|bad_alloc|memory exhausted|virtual memory exhausted|LLVM ERROR: out of memory'; then
		FAILURE="oom"
	# Crash (#1206): a test child killed by a hard fault — SIGSEGV (139),
	# SIGBUS (135), SIGFPE (136), SIGILL (132) — or an explicit
	# `Segmentation fault` / `core dumped` signature. Classified ABOVE
	# both `timeout` and `setup-error`: a fault exit (139) is not a
	# wall-clock timeout, and a post-crash `No such file or directory` (a
	# missing fail.bin / _subframe_summary.json the crashed child never
	# wrote) must not win `setup-error` for what is really a crash.
	#
	# SIGABRT (134) is deliberately EXCLUDED here: a clean `assert` aborts
	# with 134 (and the multi-file runner even prints `child terminated by
	# signal` for it), so a bare 134 is a `test-failure`, not a crash. OOM
	# still wins above (a 137 with a memory signature is an OOM-kill); a
	# bare SIGKILL 137 with no crash signature stays a `timeout` below.
	elif out_has 'Segmentation fault|SIGSEGV|SIGBUS|SIGFPE|SIGILL|core dumped' \
		|| [ "$RC" -eq 139 ] || [ "$RC" -eq 135 ] || [ "$RC" -eq 136 ] || [ "$RC" -eq 132 ]; then
		FAILURE="crash"
	# A signal-killed child (`_emit_crash_diagnostic`'s `child terminated
	# by signal`) that left NO assertion attribution — the genuine
	# multi-file crash the in-process FAIL banner couldn't pin. Gated on
	# the ABSENCE of a clean-assert signature (`assertion failed` /
	# `test failed:`) so a normal `assert` (which also exits 134 and emits
	# the `child terminated by signal` line) stays a `test-failure`.
	elif out_has 'child terminated by signal' && ! out_has 'assertion failed|test failed:'; then
		FAILURE="crash"
	elif [ "$RC" -eq 124 ] || [ "$RC" -eq 137 ] || [ "$RC" -eq 143 ]; then
		FAILURE="timeout"
	elif out_has "missing seed compiler|is not invokable|SEED_VERSION is empty|\[fetch-seed\]\[error\]|(seed|bootstrap\.toml|fetch-seed|SEED=)[^[:cntrl:]]*No such file or directory|run: make compile|run 'make compile'|GITHUB_TOKEN"; then
		FAILURE="setup-error"
	# The `═══ <suite>: N/M passed, K failed ═══` banner is printed for EVERY
	# suite regardless of outcome (cli/commands/test/reporting.sfn), so the
	# count must be anchored non-zero here exactly as in the first alternative.
	# With `[0-9]+` a plain `make check` matched its own passing pass1 banner,
	# and every later failure — stage2/stage3 build, seedcheck smoke, a strict
	# fixed-point abort — classified as `test-failure`, sending the agent to
	# hunt a test that never failed (SFN-724).
	elif out_has 'passed, [1-9][0-9]* failed|\[check\]\[FAIL\]|assertion failed|[1-9][0-9]* failed ═══'; then
		FAILURE="test-failure"
	elif out_has 'error:|\[rebuild\]\[error\]|sfn build failed|cannot resolve|lowering error|parse error|type error|effect error'; then
		FAILURE="compile-error"
	else
		# Unmatched: fall back to the target's most likely class.
		case "$TARGET" in
			test|test-unit|test-integration|test-e2e|test-capsules) FAILURE="test-failure" ;;
			*) FAILURE="compile-error" ;;
		esac
	fi

	# Best-effort phase + first_error.
	if [ "$TARGET" = "check" ]; then
		PHASE="$(detect_check_phase)"
	else
		PHASE="$TARGET"
	fi
	local fe
	fe="$(detect_first_error)"
	if [ -n "$fe" ]; then
		FIRST_ERROR="$fe"
	else
		FIRST_ERROR="$PHASE"
	fi
}

# --- JSON emission -----------------------------------------------------------
# Emit a JSON value: the literal `null`, or a properly escaped string.
json_val() {
	local v="$1"
	if [ "$v" = "null" ]; then
		printf 'null'
		return
	fi
	# Escape backslash, double-quote, and control chars for a JSON string.
	v="${v//\\/\\\\}"
	v="${v//\"/\\\"}"
	v="${v//$'\t'/\\t}"
	v="${v//$'\n'/\\n}"
	v="${v//$'\r'/\\r}"
	printf '"%s"' "$v"
}

# --- tool-artifact composition (#1123) ---------------------------------------
# Map the wrapped target to the tool JSON artifact the Makefile captured under
# the same JSON=1 gate: the BuildReport from #1120 (compile/rebuild), the test
# jsonl from #1121 (test*), the check-fast envelope from #1122 (check-fast).
# Echoes the path, or empty for a target with no single-tool artifact. `check`
# has none but is handled separately by compose_check_phases (#1124); an empty
# result here therefore means an unexpected target outside the wrapped set.
tool_artifact_path() {
	case "$TARGET" in
		compile | rebuild) printf '%s' "build/native/.build-report.json" ;;
		test | test-unit | test-integration | test-e2e | test-capsules)
			printf '%s' "build/agent-test.${TARGET}.jsonl"
			;;
		check-fast) printf '%s' "build/agent-check-fast.json" ;;
		*) printf '' ;;
	esac
}

# True for the test targets whose artifact is a `sfn test --json` jsonl stream
# carrying `summary` events with passed/failed counters.
is_test_target() {
	case "$TARGET" in
		test | test-unit | test-integration | test-e2e | test-capsules) return 0 ;;
		*) return 1 ;;
	esac
}

# Sum the `passed`/`failed` counters across every `summary` event in a test
# jsonl artifact (a single invocation may emit more than one). jq when present
# (it also validates each line); a grep/sed tally otherwise — mirroring the
# jq-or-sed `json_field` pattern in
# compiler/tests/e2e/test_make_result_contract.sh. Emits "<passed> <failed>" on
# stdout, or nothing when the file carries no summary event (caller degrades to
# phases:[]).
tally_test_counts() {
	local file="$1"
	if command -v jq >/dev/null 2>&1; then
		# -R/-n + inputs reads the file line-by-line as raw strings so a stray
		# non-JSON banner line (none expected on the teed stream, but be
		# defensive) is skipped via `fromjson?` rather than aborting the tally.
		jq -rR -n '
			[inputs | fromjson? | select(.event == "summary")] as $s
			| if ($s | length) == 0 then empty
			  else "\($s | map(.passed // 0) | add) \($s | map(.failed // 0) | add)"
			  end' "$file" 2>/dev/null
		return
	fi
	local passed=0 failed=0 found=0 line p f
	while IFS= read -r line; do
		case "$line" in
		*'"event":"summary"'*) ;;
		*) continue ;;
		esac
		found=1
		p="$(printf '%s' "$line" | sed -nE 's/.*"passed":([0-9]+).*/\1/p')"
		f="$(printf '%s' "$line" | sed -nE 's/.*"failed":([0-9]+).*/\1/p')"
		[ -n "$p" ] && passed=$((passed + p))
		[ -n "$f" ] && failed=$((failed + f))
	done <"$file"
	[ "$found" -eq 1 ] && printf '%s %s' "$passed" "$failed"
}

# Lightweight structural sanity check for a non-test JSON artifact when `jq`
# is unavailable. jq (when present) is the real validator; this best-effort
# fallback rejects an obviously broken artifact (empty, not a JSON object, or
# truncated mid-stream) so a `jq`-less host still degrades to phases:[] rather
# than dangling a `report` pointer at unparseable JSON. Returns 0 when the
# artifact looks structurally intact, non-zero otherwise.
artifact_looks_intact_no_jq() {
	local file="$1" first last
	[ -s "$file" ] || return 1
	# A BuildReport/check envelope is a JSON object carrying schema_version.
	first="$(head -c 1 "$file" 2>/dev/null)"
	[ "$first" = "{" ] || return 1
	grep -q '"schema_version"' "$file" 2>/dev/null || return 1
	# Last non-whitespace byte is the closing brace — catches truncation.
	last="$(tr -d '[:space:]' <"$file" 2>/dev/null | tail -c 1)"
	[ "$last" = "}" ] || return 1
	return 0
}

# Compose the seven-phase `make check` ledger (#1124). Echoes a JSON array of
# `{"name":<phase>,"status":<s>}` entries in pipeline order, derived from the
# CHECK_PHASE_MARKERS table above (the same marker set `detect_check_phase`
# keys off):
#   - phases the run advanced PAST (a later phase's banner appeared) -> pass
#   - the last-reached phase -> `fail` when the verdict failed, else `pass`
#   - phases never reached -> skipped
# `compile` is the first thing check-impl runs, so it is always reached, and
# seedcheck-smoke fails independently of the build/test phases.
#
# The fixed-point `stage2 != stage3` mismatch is the lone phase `warn`, and it
# is pinned to `fixed-point` rather than mirrored onto the last-reached phase:
# `sfn selfhost` prints the mismatch and continues, so the seedcheck suite
# still runs (and passes) after it. Mirroring would park the warn on
# `seedcheck-tests` and report `fixed-point` as a clean pass — inverting the
# one signal the warn exists to carry.
compose_check_phases() {
	local last i idx pstatus names out="[" first=1
	names=("${CHECK_PHASE_MARKERS[@]%%|*}")
	last="$(check_last_reached)"

	for i in "${!names[@]}"; do
		idx=$((i + 1))
		if [ "$idx" -gt "$last" ]; then
			pstatus="skipped"
		elif [ "$STATUS" = "warn" ] && [ "${names[$i]}" = "fixed-point" ]; then
			pstatus="warn"
		elif [ "$idx" -eq "$last" ] && [ "$STATUS" = "fail" ]; then
			pstatus="fail"
		else
			pstatus="pass"
		fi
		[ "$first" -eq 1 ] || out="${out},"
		first=0
		out="${out}{\"name\":$(json_val "${names[$i]}"),\"status\":$(json_val "$pstatus")}"
	done
	printf '%s]' "$out"
}

# Compose the phases[] array. `check` gets the seven-phase ledger (#1124);
# every other wrapped target gets the one-element entry (#1123) composed from
# the captured tool artifact:
#   - non-test target, artifact present + parseable:
#       [{"name":<target>,"status":<s>,"report":<artifact>}]
#   - test target, jsonl present with a summary event:
#       [{"name":<target>,"status":<s>,"passed":N,"failed":N,"report":<jsonl>}]
#   - artifact expected but missing/unparseable: "[]" (graceful degrade).
#   - no tool artifact and not `check` (unexpected target): a synthetic single
#       entry [{"name":<target>,"status":<s>}].
# Phase status mirrors the verdict: "fail" when STATUS is fail, else "pass"
# (a `warn` target — check's nondeterminism — ran every phase, so the
# single-tool phase itself is "pass"; the warn signal lives on the top-level
# status).
compose_phases() {
	# `make check`'s seven-phase ledger supersedes the single synthetic entry.
	if [ "$TARGET" = "check" ]; then
		compose_check_phases
		return
	fi

	local phase_status="pass"
	[ "$STATUS" = "fail" ] && phase_status="fail"
	local name_json status_json
	name_json="$(json_val "$TARGET")"
	status_json="$(json_val "$phase_status")"

	local artifact
	artifact="$(tool_artifact_path)"

	# No single-tool artifact and not `check` (unexpected target). Emit a
	# synthetic one-element phase from the verdict so the report is never empty.
	if [ -z "$artifact" ]; then
		printf '[{"name":%s,"status":%s}]' "$name_json" "$status_json"
		return
	fi

	# Artifact expected but absent: degrade to [] (e.g. an up-to-date `compile`
	# that never rebuilt, or the missing-artifact path of AC #4).
	if [ ! -f "$artifact" ]; then
		printf '[]'
		return
	fi

	if is_test_target; then
		local counts
		counts="$(tally_test_counts "$artifact")"
		# No summary event -> unparseable for our purpose; degrade to [].
		if [ -z "$counts" ]; then
			printf '[]'
			return
		fi
		local passed="${counts%% *}" failed="${counts##* }"
		printf '[{"name":%s,"status":%s,"passed":%s,"failed":%s,"report":%s}]' \
			"$name_json" "$status_json" "$passed" "$failed" "$(json_val "$artifact")"
		return
	fi

	# Non-test artifact (BuildReport / check-fast envelope). Validate it parses
	# as JSON when jq is available; degrade to [] when it doesn't. Without jq,
	# fall back to a lightweight structural check so a truncated/garbage
	# artifact still degrades to [] rather than dangling a `report` pointer at
	# unparseable JSON.
	if command -v jq >/dev/null 2>&1; then
		if ! jq -e . "$artifact" >/dev/null 2>&1; then
			printf '[]'
			return
		fi
	elif ! artifact_looks_intact_no_jq "$artifact"; then
		printf '[]'
		return
	fi
	printf '[{"name":%s,"status":%s,"report":%s}]' \
		"$name_json" "$status_json" "$(json_val "$artifact")"
}

# --- full report file (#1119, composed in #1123) -----------------------------
# Write a well-formed report at REPORT_PATH mirroring the verdict block's fields
# plus a self-referential `report` (its own path) and a composed `phases[]`. The
# `phases[]` is a single entry derived from the matching tool artifact (#1120/
# #1121/#1122); it degrades to `[]` when that artifact is missing or
# unparseable. Best-effort: a write failure must never break the verdict block,
# so it degrades silently.
write_report_file() {
	local phases
	phases="$(compose_phases)"
	{
		printf '{"schema_version":"sailfin-make/1",'
		printf '"target":%s,' "$(json_val "$TARGET")"
		printf '"status":%s,' "$(json_val "$STATUS")"
		printf '"failure":%s,' "$(json_val "$FAILURE")"
		printf '"phase":%s,' "$(json_val "$PHASE")"
		printf '"first_error":%s,' "$(json_val "$FIRST_ERROR")"
		printf '"report":%s,' "$(json_val "$REPORT_PATH")"
		printf '"phases":%s}\n' "$phases"
	} >"$REPORT_PATH" 2>/dev/null || true
}

emit_verdict() {
	# Capture the status that triggered the trap as the very first action —
	# any later command would clobber $?. If we were interrupted (signal,
	# internal error) before RC was captured from PIPESTATUS, RC is still its
	# initial 0; inherit the trap's status so an aborted run isn't misreported
	# as a pass (which would also write a passing report file under the gate).
	local trap_rc=$?
	# Fired via trap on EXIT so the block is always the final output, even if
	# the command aborts a phase or the wrapper is interrupted.
	trap - EXIT
	if [ "$SIGNAL_RC" -ne 0 ]; then
		# We caught the terminating signal ourselves: its 128+signo code is the
		# most accurate thing we know about this run.
		RC="$SIGNAL_RC"
	elif [ "$RC" -eq 0 ] && [ "$trap_rc" -ne 0 ]; then
		RC="$trap_rc"
	fi
	# Backstop for every abort path that leaves no non-zero code behind — an
	# uncaught fatal signal, or bash tearing down mid-pipeline. The wrapped
	# command never reached its PIPESTATUS read, so a zero RC here means "was
	# killed", not "passed". Report the SIGTERM code rather than a pass the
	# target never earned.
	if [ "$COMMAND_COMPLETED" -eq 0 ] && [ "$RC" -eq 0 ]; then
		RC=143
	fi
	if [ "$COMMAND_COMPLETED" -eq 0 ]; then
		ABORTED=1
	fi
	classify
	# Report-file field: the per-target path when gated, else null. Write the
	# file before the verdict so a consumer that follows the `report` pointer
	# finds it already on disk. Only advertise the path if the file is actually
	# present after the write — a failed mkdir/write must leave `report` null
	# rather than dangle a pointer to a missing file.
	local report_field="null"
	if [ -n "$REPORT_PATH" ]; then
		write_report_file
		if [ -f "$REPORT_PATH" ]; then
			report_field="$(json_val "$REPORT_PATH")"
		fi
	fi
	{
		printf '===SAILFIN-RESULT===\n'
		printf '{"schema_version":"sailfin-make/1",'
		printf '"target":%s,' "$(json_val "$TARGET")"
		printf '"status":%s,' "$(json_val "$STATUS")"
		printf '"failure":%s,' "$(json_val "$FAILURE")"
		printf '"phase":%s,' "$(json_val "$PHASE")"
		printf '"first_error":%s,' "$(json_val "$FIRST_ERROR")"
		printf '"report":%s}\n' "$report_field"
		printf '===END-SAILFIN-RESULT===\n'
	}
	cleanup_outfile
	exit "$RC"
}

trap emit_verdict EXIT

# --- run the wrapped command -------------------------------------------------
# Stream combined output through unchanged while capturing it for
# classification. PIPESTATUS[0] is the command's real exit code.
"$@" 2>&1 | tee "$OUTFILE"
RC="${PIPESTATUS[0]}"
COMMAND_COMPLETED=1

# trap emit_verdict fires here on normal exit.
exit "$RC"
