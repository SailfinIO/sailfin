#!/usr/bin/env bash
#
# Single source of truth for the CI test-shard map.
#
# Phase 1 of docs/proposals/ci-test-speed.md (#843 Track A): the PR test
# suite is the long pole (~90% of CI wall time, serial). We fan it across
# parallel CI legs. This script owns the shard -> file-set mapping so the
# runner, the Makefile, and the cover lint can never drift apart.
#
# Shards (disjoint; their union == `make test`'s surface):
#   unit-a        odd-indexed  compiler/tests/unit/*_test.sfn
#   unit-b        even-indexed compiler/tests/unit/*_test.sfn
#   int-e2e-caps  integration + e2e + capsules *_test.sfn
#   e2e-sh        compiler/tests/e2e/test_*.sh   (run via `make test-e2e-sh`)
#
# Commands:
#   test_shards.sh names                 # print the shard names
#   test_shards.sh list  <shard>         # print the shard's files, one per line
#   test_shards.sh run   <shard> <bin>   # run the shard's *_test.sfn via <bin>
#   test_shards.sh cover                 # assert the union == full surface
#
# `run` rejects e2e-sh: the legacy .sh scripts keep running through
# `make test-e2e-sh` (one banner format for log scrubbers); this script
# only owns their *mapping* (for the cover lint), not their execution.

set -euo pipefail

SHARD_NAMES="unit-a unit-b int-e2e-caps e2e-sh"

# Every *_test.sfn the unified runner discovers under `make test`'s paths.
_all_sfn() {
	find compiler/tests/unit compiler/tests/integration compiler/tests/e2e \
		-name '*_test.sfn' -print 2>/dev/null
	find capsules -path '*/tests/*_test.sfn' -print 2>/dev/null
}

# Every legacy e2e shell script (the e2e-sh shard).
_all_sh() {
	find compiler/tests/e2e -name 'test_*.sh' -print 2>/dev/null
}

list() {
	local shard="$1"
	case "$shard" in
	unit-a)
		find compiler/tests/unit -name '*_test.sfn' -print | sort | awk 'NR % 2 == 1'
		;;
	unit-b)
		find compiler/tests/unit -name '*_test.sfn' -print | sort | awk 'NR % 2 == 0'
		;;
	int-e2e-caps)
		{
			find compiler/tests/integration compiler/tests/e2e -name '*_test.sfn' -print
			find capsules -path '*/tests/*_test.sfn' -print
		} | sort
		;;
	e2e-sh)
		_all_sh | sort
		;;
	*)
		echo "[test_shards] unknown shard: $shard (want: $SHARD_NAMES)" >&2
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
	if [ "$shard" = "e2e-sh" ]; then
		echo "[test_shards] e2e-sh runs via 'make test-e2e-sh', not 'run'" >&2
		exit 3
	fi
	local files
	files="$(list "$shard")"
	if [ -z "$files" ]; then
		echo "[test_shards] shard '$shard' matched no files" >&2
		exit 1
	fi
	echo "[test_shards] shard '$shard': $(printf '%s\n' "$files" | wc -l | tr -d ' ') file(s)"
	# Word-splitting is intentional: pass the file list as positionals.
	# shellcheck disable=SC2086
	exec "$native" test $files
}

cover() {
	local rc=0 union full concat dups missing extra
	union="$( { list unit-a; list unit-b; list int-e2e-caps; } | sort)"
	full="$(_all_sfn | sort -u)"
	concat="$( { list unit-a; list unit-b; list int-e2e-caps; } )"

	# 1. No file covered by more than one .sfn shard.
	dups="$(printf '%s\n' "$concat" | sort | uniq -d)"
	if [ -n "$dups" ]; then
		echo "[shard-cover] FAIL: file(s) in more than one shard:" >&2
		printf '  %s\n' $dups >&2
		rc=1
	fi

	# 2. Every discovered .sfn test is in exactly one shard (no gaps).
	missing="$(comm -23 <(printf '%s\n' "$full") <(printf '%s\n' "$union" | sort -u))"
	if [ -n "$missing" ]; then
		echo "[shard-cover] FAIL: discovered test(s) not covered by any shard:" >&2
		printf '  %s\n' $missing >&2
		rc=1
	fi

	# 3. No shard lists a file the runner would not discover.
	extra="$(comm -13 <(printf '%s\n' "$full") <(printf '%s\n' "$union" | sort -u))"
	if [ -n "$extra" ]; then
		echo "[shard-cover] FAIL: shard(s) list file(s) outside the test surface:" >&2
		printf '  %s\n' $extra >&2
		rc=1
	fi

	# 4. The e2e-sh shard == the full legacy .sh set.
	local sh_shard sh_full
	sh_shard="$(list e2e-sh | sort -u)"
	sh_full="$(_all_sh | sort -u)"
	if [ "$sh_shard" != "$sh_full" ]; then
		echo "[shard-cover] FAIL: e2e-sh shard does not equal the discovered test_*.sh set" >&2
		rc=1
	fi

	if [ "$rc" -eq 0 ]; then
		local n_sfn n_sh
		n_sfn="$(printf '%s\n' "$full" | grep -c . || true)"
		n_sh="$(printf '%s\n' "$sh_full" | grep -c . || true)"
		echo "[shard-cover] ok: $n_sfn *_test.sfn across 3 shards + $n_sh test_*.sh in e2e-sh, no gaps or overlaps"
	fi
	exit "$rc"
}

cmd="${1:-}"
case "$cmd" in
names) echo "$SHARD_NAMES" ;;
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
