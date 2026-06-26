#!/usr/bin/env bash
#
# Single source of truth for the CI test-shard map.
#
# Phase 1 of docs/proposals/0011-ci-test-speed.md (#843 Track A): the PR test
# suite is the long pole (~90% of CI wall time, serial). We fan it across
# parallel CI legs. This script owns the shard -> file-set mapping so the
# runner, the Makefile, and the cover lint can never drift apart.
#
# Shards (disjoint; their union == `make test`'s surface):
#   unit-a/b/c    compiler/tests/unit/*_test.sfn, strided 1..3 of 3
#   int-caps      integration + capsules *_test.sfn
#   e2e-a/b/c/d   compiler/tests/e2e/*_test.sfn, strided 1..4 of 4
#
# Why this split (#1529 follow-on): the former single `int-e2e-caps` leg
# ran ~212 *_test.sfn files SERIALLY (the runner is `--jobs 1`), and ~140
# of them spawn a full `sfn build`/`run` (compile fixture -> clang ->
# link -> run). On the slower macOS-arm64 toolchain that one leg ran
# >60 min and blocked iteration. e2e is the heavy bulk (132/140 are
# build-spawners), so it is striped 4 ways; integration+capsules ride
# their own leg; unit is striped 3 ways (it was the other ~30 min pole).
# Each leg still runs serially INTERNALLY, so per-leg memory stays
# bounded (no re-OOM) — the parallelism is across CI runners, not within
# a process. The `cover` lint guarantees the union still equals the full
# surface.
#
# (The legacy `e2e-sh-*` shards were retired when the bash e2e suite was
# fully migrated to `*_test.sfn` peers — Phase 3.1, epic #840.)
#
# Commands:
#   test_shards.sh names                 # all shard names
#   test_shards.sh sfn-names             # just the *_test.sfn shard names
#   test_shards.sh list  <shard>         # print the shard's files, one per line
#   test_shards.sh run   <shard> <bin>   # run an *_test.sfn shard via <bin>
#   test_shards.sh cover                 # assert the union == full surface

set -euo pipefail

SFN_SHARDS="unit-a unit-b unit-c int-caps e2e-a e2e-b e2e-c e2e-d"

_all_shard_names() {
	printf '%s\n' "$SFN_SHARDS"
}

# Every *_test.sfn the unified runner discovers under `make test`'s paths.
_all_sfn() {
	find compiler/tests/unit compiler/tests/integration compiler/tests/e2e \
		-name '*_test.sfn' -print 2>/dev/null
	find capsules -path '*/tests/*_test.sfn' -print 2>/dev/null
}

# Stride partition: emit the i-th of n lines (1-based i) from stdin.
_stride() {
	awk -v i="$1" -v n="$2" '(NR - 1) % n == (i - 1)'
}

list() {
	local shard="$1"
	case "$shard" in
	unit-a)
		find compiler/tests/unit -name '*_test.sfn' -print | sort | _stride 1 3
		;;
	unit-b)
		find compiler/tests/unit -name '*_test.sfn' -print | sort | _stride 2 3
		;;
	unit-c)
		find compiler/tests/unit -name '*_test.sfn' -print | sort | _stride 3 3
		;;
	int-caps)
		{
			find compiler/tests/integration -name '*_test.sfn' -print
			find capsules -path '*/tests/*_test.sfn' -print
		} | sort
		;;
	e2e-a)
		find compiler/tests/e2e -name '*_test.sfn' -print | sort | _stride 1 4
		;;
	e2e-b)
		find compiler/tests/e2e -name '*_test.sfn' -print | sort | _stride 2 4
		;;
	e2e-c)
		find compiler/tests/e2e -name '*_test.sfn' -print | sort | _stride 3 4
		;;
	e2e-d)
		find compiler/tests/e2e -name '*_test.sfn' -print | sort | _stride 4 4
		;;
	*)
		echo "[test_shards] unknown shard: $shard (want: $SFN_SHARDS)" >&2
		exit 2
		;;
	esac
}

run() {
	local shard="$1" native="${2:-}"
	if [ -z "$native" ]; then
		echo "[test_shards] run: missing compiler binary path" >&2
		exit 2
	fi
	local files
	files="$(list "$shard")"
	if [ -z "$files" ]; then
		echo "[test_shards] shard '$shard' matched no files" >&2
		exit 1
	fi
	echo "[test_shards] shard '$shard': $(printf '%s\n' "$files" | wc -l | tr -d ' ') file(s)"
	# JSON-report gate (#1235, additive / default-off). When
	# SAILFIN_AGENT_REPORT=1 (the repo-wide JSON=1 gate, exported by the
	# Makefile and set directly by the macOS measurement legs in
	# .github/actions/sailfin-build), forward `--json` and tee the runner's
	# JSONL stream — whose `summary` event carries `cache.test_bin_hit_rate`
	# (#1230) — to a per-shard sidecar so CI can dump the per-test-binary
	# cache hit-rate without a second test pass. `set -o pipefail` preserves
	# the runner's real exit status across the tee (the `exec` form below
	# would lose it to `tee`). The default path stays the byte-identical
	# `exec "$native" test $files` so normal local/Linux runs are unchanged.
	# Word-splitting is intentional: pass the file list as positionals.
	# shellcheck disable=SC2086
	if [ "${SAILFIN_AGENT_REPORT:-}" = "1" ]; then
		mkdir -p build
		local sidecar="build/agent-test.shard-${shard}.jsonl"
		set -o pipefail
		"$native" test $files --json | tee "$sidecar"
		exit "${PIPESTATUS[0]}"
	fi
	exec "$native" test $files
}

cover() {
	local rc=0

	# --- *_test.sfn shards partition the full *_test.sfn surface. ---
	local sfn_concat sfn_full sfn_dups sfn_missing sfn_extra
	sfn_concat="$(for s in $SFN_SHARDS; do list "$s"; done)"
	sfn_full="$(_all_sfn | sort -u)"
	sfn_dups="$(printf '%s\n' "$sfn_concat" | sort | uniq -d)"
	if [ -n "$sfn_dups" ]; then
		echo "[shard-cover] FAIL: *_test.sfn in more than one shard:" >&2
		printf '  %s\n' $sfn_dups >&2
		rc=1
	fi
	sfn_missing="$(comm -23 <(printf '%s\n' "$sfn_full") <(printf '%s\n' "$sfn_concat" | sort -u))"
	if [ -n "$sfn_missing" ]; then
		echo "[shard-cover] FAIL: *_test.sfn not covered by any shard:" >&2
		printf '  %s\n' $sfn_missing >&2
		rc=1
	fi
	sfn_extra="$(comm -13 <(printf '%s\n' "$sfn_full") <(printf '%s\n' "$sfn_concat" | sort -u))"
	if [ -n "$sfn_extra" ]; then
		echo "[shard-cover] FAIL: shard lists *_test.sfn outside the test surface:" >&2
		printf '  %s\n' $sfn_extra >&2
		rc=1
	fi

	if [ "$rc" -eq 0 ]; then
		local n_sfn
		n_sfn="$(printf '%s\n' "$sfn_full" | grep -c . || true)"
		echo "[shard-cover] ok: $n_sfn *_test.sfn across $SFN_SHARDS; no gaps or overlaps"
	fi
	exit "$rc"
}

cmd="${1:-}"
case "$cmd" in
names) _all_shard_names ;;
sfn-names) printf '%s\n' "$SFN_SHARDS" ;;
list)
	shift
	list "${1:?usage: test_shards.sh list <shard>}"
	;;
run)
	shift
	run "${1:?usage: test_shards.sh run <shard> <bin>}" "${2:-}"
	;;
cover) cover ;;
*)
	echo "usage: test_shards.sh {names|list <shard>|run <shard> <bin>|cover}" >&2
	exit 2
	;;
esac
