#!/usr/bin/env bash
# Sync GitHub labels for sailfinio/sailfin to the canonical scheme defined
# in .github/labels.yml.
#
# Idempotent. Safe to re-run. Authoritative side: the YAML file.
#
# Usage:
#   scripts/setup-github-labels.sh                  # apply changes
#   scripts/setup-github-labels.sh --dry-run        # preview only, no writes
#   scripts/setup-github-labels.sh --skip-aliases   # don't process aliases or deletes
#   scripts/setup-github-labels.sh --repo owner/repo  # override repo (defaults to origin)
#
# Requirements: gh, jq, yq (mikefarah). All three are pre-installed in
# GitHub Actions ubuntu-latest runners and on most maintainer laptops.

set -euo pipefail

DRY_RUN=0
SKIP_ALIASES=0
REPO=""
LABELS_FILE="$(cd "$(dirname "$0")/.." && pwd)/.github/labels.yml"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run)       DRY_RUN=1; shift ;;
    --skip-aliases)  SKIP_ALIASES=1; shift ;;
    --repo)          REPO="$2"; shift 2 ;;
    --labels-file)   LABELS_FILE="$2"; shift 2 ;;
    -h|--help)
      sed -n '2,/^$/p' "$0" | sed 's/^# \{0,1\}//'
      exit 0
      ;;
    *) echo "unknown arg: $1" >&2; exit 2 ;;
  esac
done

for tool in gh jq yq; do
  command -v "$tool" >/dev/null 2>&1 || { echo "missing dependency: $tool" >&2; exit 2; }
done

[[ -f "$LABELS_FILE" ]] || { echo "labels file not found: $LABELS_FILE" >&2; exit 2; }

if [[ -z "$REPO" ]]; then
  REPO="$(gh repo view --json nameWithOwner -q .nameWithOwner)"
fi

echo "==> repo: $REPO"
echo "==> labels file: $LABELS_FILE"
[[ $DRY_RUN -eq 1 ]] && echo "==> mode: DRY RUN (no writes)"

run() {
  if [[ $DRY_RUN -eq 1 ]]; then
    echo "  DRY: $*"
  else
    echo "  RUN: $*"
    "$@"
  fi
}

# ---------------------------------------------------------------------------
# Load existing labels into a JSON map keyed by name.
# ---------------------------------------------------------------------------
refresh_labels() {
  existing_json="$(gh api -X GET "repos/$REPO/labels" --paginate \
    | jq -s 'add | map({(.name): {color: .color, description: (.description // "")}}) | add // {}')"
}

refresh_labels

label_exists() {
  echo "$existing_json" | jq -e --arg n "$1" 'has($n)' >/dev/null
}

label_attr() {
  echo "$existing_json" | jq -r --arg n "$1" --arg k "$2" '.[$n][$k] // ""'
}

# Detect whether a number is a PR or an issue. The two share a number space
# but only PRs have a `pull_request` field on the GET-issue endpoint.
is_pull_request() {
  local n="$1"
  gh api "repos/$REPO/issues/$n" --jq '.pull_request != null' 2>/dev/null \
    | grep -qx true
}

# ---------------------------------------------------------------------------
# Phase 1: ensure every canonical label exists with the correct color + desc.
# ---------------------------------------------------------------------------
echo
echo "==> Phase 1: canonical labels"

label_count="$(yq '.labels | length' "$LABELS_FILE")"
for ((i=0; i<label_count; i++)); do
  name="$(yq ".labels[$i].name"        "$LABELS_FILE")"
  color="$(yq ".labels[$i].color"       "$LABELS_FILE")"
  desc="$(yq ".labels[$i].description"  "$LABELS_FILE")"

  if ! label_exists "$name"; then
    echo "  + create: $name (#$color)"
    run gh label create "$name" --repo "$REPO" --color "$color" --description "$desc"
    continue
  fi

  cur_color="$(label_attr "$name" color | tr 'A-Z' 'a-z')"
  cur_desc="$(label_attr "$name" description)"
  want_color="$(echo "$color" | tr 'A-Z' 'a-z')"

  if [[ "$cur_color" != "$want_color" || "$cur_desc" != "$desc" ]]; then
    echo "  ~ update: $name (color $cur_color->$want_color, desc drift=$( [[ "$cur_desc" != "$desc" ]] && echo yes || echo no ))"
    run gh label edit "$name" --repo "$REPO" --color "$color" --description "$desc"
  else
    echo "  = ok:     $name"
  fi
done

# Phase 1 may have created new canonical labels (e.g. `type:tech-debt`) that
# are also alias targets in Phase 2. Refresh the map so `label_exists` sees
# them. Skip the refresh in dry-run because no labels were actually created.
if [[ $DRY_RUN -eq 0 ]]; then
  refresh_labels
fi

if [[ $SKIP_ALIASES -eq 1 ]]; then
  echo
  echo "==> --skip-aliases set; not processing aliases or deletes"
  exit 0
fi

# ---------------------------------------------------------------------------
# Phase 2: aliases. For each `from -> to` we always migrate-then-delete:
# add `to` to every issue/PR carrying `from`, remove `from`, then delete
# the `from` label.
#
# The GitHub REST API does support `PATCH /repos/.../labels/{name}` with a
# `new_name` field for rename — we deliberately don't use it because rename
# fails when `to` already exists, and most of our aliases (e.g. `bug` ->
# `type:bug`) target labels that are already in active use. Migrate-then-
# delete is uniform across both pre-existing and newly-created targets.
# ---------------------------------------------------------------------------
echo
echo "==> Phase 2: legacy aliases"

alias_count="$(yq '.aliases | length' "$LABELS_FILE")"
for ((i=0; i<alias_count; i++)); do
  from="$(yq ".aliases[$i].from" "$LABELS_FILE")"
  to="$(yq ".aliases[$i].to"     "$LABELS_FILE")"

  if ! label_exists "$from"; then
    echo "  = ok:     legacy '$from' already absent"
    continue
  fi
  if ! label_exists "$to"; then
    echo "  ! warn:   target '$to' missing for alias '$from->$to' (Phase 1 should have created it). Skipping."
    continue
  fi

  echo "  ~ migrate: '$from' -> '$to'"

  # Find every issue/PR carrying `from`. The Search API folds issues+PRs.
  encoded_from="$(jq -rn --arg s "$from" '$s|@uri')"
  numbers="$(gh api -X GET "search/issues?q=repo:$REPO+label:%22$encoded_from%22&per_page=100" --paginate \
            | jq -r '.items[]?.number')"

  for n in $numbers; do
    # Decide issue-vs-PR up front so dry-run echoes the right command and
    # we don't depend on a `||` fallback (which doesn't fire under dry-run
    # because `run` returns success).
    if is_pull_request "$n"; then
      run gh pr edit "$n" --repo "$REPO" --add-label "$to" --remove-label "$from"
    else
      run gh issue edit "$n" --repo "$REPO" --add-label "$to" --remove-label "$from"
    fi
  done

  echo "    delete legacy label: $from"
  run gh label delete "$from" --repo "$REPO" --yes
done

# ---------------------------------------------------------------------------
# Phase 3: outright deletions (no replacement).
# ---------------------------------------------------------------------------
echo
echo "==> Phase 3: deletions"

del_count="$(yq '.delete | length' "$LABELS_FILE")"
for ((i=0; i<del_count; i++)); do
  name="$(yq ".delete[$i].name"   "$LABELS_FILE")"
  reason="$(yq ".delete[$i].reason" "$LABELS_FILE")"
  if ! label_exists "$name"; then
    echo "  = ok:     '$name' already absent"
    continue
  fi
  echo "  - delete: $name ($reason)"
  run gh label delete "$name" --repo "$REPO" --yes
done

echo
echo "==> done."
