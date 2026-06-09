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
#   e2e-sh-1..N   the 94 legacy compiler/tests/e2e/test_*.sh, strided
#
# The e2e-sh scripts are far costlier per item than *_test.sfn (each does
# a full compile+run, ~18s on macOS), so 94 in one shard was the critical
# path (~31 min on macOS). They are split N ways (E2E_SH_SHARDS) to match
# the ~7-min test budget of the other shards. The .sh scripts still run
# through `make test-e2e-sh` (one banner format for log scrubbers); this
# script only owns their *partitioning*.
#
# Commands:
#   test_shards.sh names                 # all shard names (sfn + sh)
#   test_shards.sh sfn-names             # just the *_test.sfn shard names
#   test_shards.sh list  <shard>         # print the shard's files, one per line
#   test_shards.sh run   <shard> <bin>   # run an *_test.sfn shard via <bin>
#   test_shards.sh cover                 # assert the union == full surface

set -euo pipefail

# Number of e2e-sh sub-shards. Bump if the .sh suite grows; the cover
# lint guarantees the strides still partition the full set exactly.
E2E_SH_SHARDS="${E2E_SH_SHARDS:-4}"

SFN_SHARDS="unit-a unit-b int-e2e-caps"

_sh_shard_names() {
	local i
	for i in $(seq 1 "$E2E_SH_SHARDS"); do
		printf 'e2e-sh-%s\n' "$i"
	done
}

_all_shard_names() {
	printf '%s ' $SFN_SHARDS
	_sh_shard_names | tr '\n' ' '
	printf '\n'
}

# Every *_test.sfn the unified runner discovers under `make test`'s paths.
_all_sfn() {
	find compiler/tests/unit compiler/tests/integration compiler/tests/e2e \
		-name '*_test.sfn' -print 2>/dev/null
	find capsules -path '*/tests/*_test.sfn' -print 2>/dev/null
}

# Every legacy e2e shell script (the e2e-sh-* shards).
_all_sh() {
	find compiler/tests/e2e -name 'test_*.sh' -print 2>/dev/null
}

# Stride partition: emit the i-th of n lines (1-based i) from stdin.
_stride() {
	awk -v i="$1" -v n="$2" '(NR - 1) % n == (i - 1)'
}

list() {
	local shard="$1"
	case "$shard" in
	unit-a)
		find compiler/tests/unit -name '*_test.sfn' -print | sort | _stride 1 2
		;;
	unit-b)
		find compiler/tests/unit -name '*_test.sfn' -print | sort | _stride 2 2
		;;
	int-e2e-caps)
		{
			find compiler/tests/integration compiler/tests/e2e -name '*_test.sfn' -print
			find capsules -path '*/tests/*_test.sfn' -print
		} | sort
		;;
	e2e-sh-*)
		local i="${shard#e2e-sh-}"
		if ! [ "$i" -ge 1 ] 2>/dev/null || [ "$i" -gt "$E2E_SH_SHARDS" ]; then
			echo "[test_shards] e2e-sh index out of range: $shard (1..$E2E_SH_SHARDS)" >&2
			exit 2
		fi
		_all_sh | sort | _stride "$i" "$E2E_SH_SHARDS"
		;;
	*)
		echo "[test_shards] unknown shard: $shard (want: $(_all_shard_names))" >&2
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
	case "$shard" in
	e2e-sh-*)
		echo "[test_shards] $shard runs via 'make test-e2e-sh E2E_SH_FILES=...', not 'run'" >&2
		exit 3
		;;
	esac
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

	# --- e2e-sh-* shards partition the full test_*.sh set. ---
	local sh_concat sh_full sh_dups sh_missing sh_extra
	sh_concat="$(while IFS= read -r s; do list "$s"; done < <(_sh_shard_names))"
	sh_full="$(_all_sh | sort -u)"
	sh_dups="$(printf '%s\n' "$sh_concat" | sort | uniq -d)"
	if [ -n "$sh_dups" ]; then
		echo "[shard-cover] FAIL: test_*.sh in more than one e2e-sh shard:" >&2
		printf '  %s\n' $sh_dups >&2
		rc=1
	fi
	sh_missing="$(comm -23 <(printf '%s\n' "$sh_full") <(printf '%s\n' "$sh_concat" | sort -u))"
	if [ -n "$sh_missing" ]; then
		echo "[shard-cover] FAIL: test_*.sh not covered by any e2e-sh shard:" >&2
		printf '  %s\n' $sh_missing >&2
		rc=1
	fi
	sh_extra="$(comm -13 <(printf '%s\n' "$sh_full") <(printf '%s\n' "$sh_concat" | sort -u))"
	if [ -n "$sh_extra" ]; then
		echo "[shard-cover] FAIL: e2e-sh shard lists a file outside test_*.sh:" >&2
		printf '  %s\n' $sh_extra >&2
		rc=1
	fi

	if [ "$rc" -eq 0 ]; then
		local n_sfn n_sh
		n_sfn="$(printf '%s\n' "$sfn_full" | grep -c . || true)"
		n_sh="$(printf '%s\n' "$sh_full" | grep -c . || true)"
		echo "[shard-cover] ok: $n_sfn *_test.sfn across $SFN_SHARDS; $n_sh test_*.sh across $E2E_SH_SHARDS e2e-sh shards; no gaps or overlaps"
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
