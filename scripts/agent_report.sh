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
# Design: docs/proposals/agent-output-orchestration.md §1 (tail contract),
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

detect_check_phase() {
	# Echo the last phase whose start-marker appears in the log. Markers are
	# the human banners `make check` already prints (Makefile check: target).
	local phase="null"
	out_has '\[check\] running test suite on first-pass binary' && phase="first-pass-tests"
	out_has 'proceeding to seedcheck build|verifying seed selfhost \(stage2\)' && phase="seedcheck-build"
	out_has 'validating seedcheck binary can run programs' && phase="seedcheck-smoke"
	out_has 'running test suite with seedcheck binary' && phase="seedcheck-tests"
	out_has 'building stage3 for fixed-point' && phase="stage3-build"
	out_has 'comparing stage2 vs stage3' && phase="fixed-point"
	# If nothing matched yet we're still in the compile phase.
	[ "$phase" = "null" ] && phase="compile"
	printf '%s' "$phase"
}

detect_first_error() {
	# Best-effort `file:line` (or `file:line:col`) pointer. Full extraction by
	# parsing tool JSON is Phase 3; here we scrape the first source location.
	local loc
	loc="$(grep -Eo '[A-Za-z0-9_./-]+\.sfn:[0-9]+(:[0-9]+)?' "$OUTFILE" 2>/dev/null | head -n1)"
	printf '%s' "$loc"
}

classify() {
	# Nondeterminism is a non-fatal WARN even though `make check` exits 0.
	# Surface it without flipping the exit code.
	if out_has '\[check\]\[WARN\] stage2 != stage3'; then
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
	elif [ "$RC" -eq 124 ] || [ "$RC" -eq 137 ]; then
		FAILURE="timeout"
	elif out_has "missing seed compiler|is not invokable|SEED_VERSION is empty|\[fetch-seed\]\[error\]|No such file or directory|run: make compile|run 'make compile'|GITHUB_TOKEN"; then
		FAILURE="setup-error"
	elif out_has 'passed, [1-9][0-9]* failed|\[check\]\[FAIL\]|assertion failed|[0-9]+ failed ═══'; then
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

# --- full report file (#1119) ------------------------------------------------
# Write a minimal, well-formed report at REPORT_PATH. Phase 2 scaffolding:
# `phases` is an empty array stub here; issue E composes real per-phase content
# from tool JSON. The report mirrors the verdict block's fields and adds a
# self-referential `report` (its own path) plus `phases`. Best-effort: a write
# failure must never break the verdict block, so it degrades silently.
write_report_file() {
	{
		printf '{"schema_version":"sailfin-make/1",'
		printf '"target":%s,' "$(json_val "$TARGET")"
		printf '"status":%s,' "$(json_val "$STATUS")"
		printf '"failure":%s,' "$(json_val "$FAILURE")"
		printf '"phase":%s,' "$(json_val "$PHASE")"
		printf '"first_error":%s,' "$(json_val "$FIRST_ERROR")"
		printf '"report":%s,' "$(json_val "$REPORT_PATH")"
		printf '"phases":[]}\n'
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
	if [ "$RC" -eq 0 ] && [ "$trap_rc" -ne 0 ]; then
		RC="$trap_rc"
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

# trap emit_verdict fires here on normal exit.
exit "$RC"
