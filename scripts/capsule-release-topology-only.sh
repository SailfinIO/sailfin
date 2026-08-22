#!/usr/bin/env bash
set -euo pipefail

# Classify one Git rename as release-neutral SFEP-0072 topology work.
# R100 moves are neutral when canonical identity and capsule-relative path stay
# fixed. A lower-similarity rename is neutral only when normalizing both the
# old and new physical member roots makes the two blobs byte-identical.
# Any ambiguity fails closed as a source change in capsule-release.yml.

if [ "$#" -ne 8 ]; then
  echo "usage: $0 BEFORE AFTER BEFORE_PUBLIC CAPSULE_NAME CAPSULE_DIR STATUS OLD_PATH NEW_PATH" >&2
  exit 2
fi

before="$1"
after="$2"
before_public="$3"
capsule_name="$4"
capsule_dir="$5"
status="$6"
old_path="$7"
new_path="$8"

case "$status" in
  R[0-9][0-9][0-9]) ;;
  *) exit 1 ;;
esac

case "$new_path" in
  "$capsule_dir"/*) relative="${new_path#"$capsule_dir"/}" ;;
  *) exit 1 ;;
esac

old_count="$(awk -F '\t' -v identity="$capsule_name" \
  '$1 == identity { count += 1 } END { print count + 0 }' "$before_public")"
if [ "$old_count" -ne 1 ]; then
  exit 2
fi
old_root="$(awk -F '\t' -v identity="$capsule_name" \
  '$1 == identity { print $2; exit }' "$before_public")"
old_external="$(awk -F '\t' -v identity="$capsule_name" \
  '$1 == identity { print $3; exit }' "$before_public")"

if [ "$status" = "R100" ] && [ -n "$old_external" ] && \
   [ "$old_path" = "$old_external" ]; then
  exit 0
fi

case "$old_path" in
  "$old_root"/*) old_relative="${old_path#"$old_root"/}" ;;
  *) exit 1 ;;
esac
if [ "$old_relative" != "$relative" ]; then
  exit 1
fi
if [ "$status" = "R100" ]; then
  exit 0
fi

# Git's name-status stream already assumes ordinary repository paths. Keep the
# byte-normalization command equally strict instead of interpreting delimiter
# or replacement metacharacters in a workspace member path.
case "$old_root$capsule_dir" in
  *'|'*|*'&'*|*\\*) exit 1 ;;
esac

temp_parent="${RUNNER_TEMP:-${TMPDIR:-/tmp}}"
temp_root="$(mktemp -d "$temp_parent/capsule-release-topology.XXXXXX")"
cleanup() {
  rm -rf "$temp_root"
}
trap cleanup EXIT

git show "$before:$old_path" > "$temp_root/before"
git show "$after:$new_path" > "$temp_root/after"
root_token="__SAILFIN_CAPSULE_MEMBER_ROOT__"
LC_ALL=C sed -e "s|$old_root|$root_token|g" \
  -e "s|$capsule_dir|$root_token|g" \
  "$temp_root/before" > "$temp_root/before-normalized"
LC_ALL=C sed -e "s|$old_root|$root_token|g" \
  -e "s|$capsule_dir|$root_token|g" \
  "$temp_root/after" > "$temp_root/after-normalized"
cmp -s "$temp_root/before-normalized" "$temp_root/after-normalized"
