#!/usr/bin/env bash
# Sync a single issue to the Sailfin Tracker project (org project #4):
#   - Add the issue to the project (idempotent)
#   - Mirror its priority:* / size:* labels into the project Priority / Size
#     single-select fields (idempotent; clears the field if no matching label
#     is present)
#
# Labels are the source of truth (see .github/labels.yml). This script keeps
# project fields in lockstep so views can group / filter on them.
#
# Usage:
#   scripts/sync-issue-to-project.sh <issue-number>
#   scripts/sync-issue-to-project.sh --all-open                # backfill loop
#   scripts/sync-issue-to-project.sh --dry-run <issue-number>  # preview only
#
# Environment:
#   GH_TOKEN          PAT with `project`, `read:org`, and repo scopes.
#                     Defaults to RELEASE_PAT or GITHUB_TOKEN if set.
#   GH_REPO           Defaults to SailfinIO/sailfin.
#   PROJECT_OWNER     Org login. Defaults to SailfinIO.
#   PROJECT_NUMBER    Project V2 number. Defaults to 4.
#
# Requirements: gh, jq.

set -euo pipefail

DRY_RUN=0
ALL_OPEN=0
ISSUE=""
GH_REPO_DEFAULT="SailfinIO/sailfin"
PROJECT_OWNER="${PROJECT_OWNER:-SailfinIO}"
PROJECT_NUMBER="${PROJECT_NUMBER:-4}"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run)   DRY_RUN=1; shift ;;
    --all-open)  ALL_OPEN=1; shift ;;
    -h|--help)
      sed -n '2,/^$/p' "$0" | sed 's/^# \{0,1\}//'
      exit 0
      ;;
    --) shift; ISSUE="${1:-}"; shift || true ;;
    *)
      if [[ -z "$ISSUE" ]]; then ISSUE="$1"; shift
      else echo "unknown arg: $1" >&2; exit 2
      fi
      ;;
  esac
done

for tool in gh jq; do
  command -v "$tool" >/dev/null 2>&1 || { echo "missing dependency: $tool" >&2; exit 2; }
done

GH_REPO="${GH_REPO:-$GH_REPO_DEFAULT}"
export GH_TOKEN="${GH_TOKEN:-${RELEASE_PAT:-${GITHUB_TOKEN:-}}}"
if [[ -z "${GH_TOKEN:-}" ]]; then
  echo "::error::no GH_TOKEN / RELEASE_PAT / GITHUB_TOKEN available" >&2
  exit 2
fi

run_query() {
  # $1 = jq-style query for variables, $2 = graphql query
  # Reads stdin as variables JSON.
  local query="$1"
  gh api graphql --input - <<EOF
{
  "query": $(printf '%s' "$query" | jq -Rs .),
  "variables": $(cat)
}
EOF
}

# ---- 1) Resolve project metadata once ----------------------------------
PROJECT_META_QUERY='query($owner: String!, $number: Int!) {
  organization(login: $owner) {
    projectV2(number: $number) {
      id
      fields(first: 50) {
        nodes {
          ... on ProjectV2SingleSelectField { id name options { id name } }
        }
      }
    }
  }
}'

PROJECT_META=$(jq -n --arg owner "$PROJECT_OWNER" --argjson number "$PROJECT_NUMBER" \
  '{owner: $owner, number: $number}' | run_query "$PROJECT_META_QUERY")

PROJECT_ID=$(echo "$PROJECT_META" | jq -r '.data.organization.projectV2.id // empty')
if [[ -z "$PROJECT_ID" ]]; then
  echo "::error::could not resolve project ${PROJECT_OWNER}#${PROJECT_NUMBER}" >&2
  echo "$PROJECT_META" >&2
  exit 1
fi

field_id() {
  echo "$PROJECT_META" | jq -r --arg n "$1" \
    '.data.organization.projectV2.fields.nodes[] | select(.name==$n) | .id // empty'
}
option_id() {
  # $1 = field name, $2 = option name
  echo "$PROJECT_META" | jq -r --arg n "$1" --arg o "$2" \
    '.data.organization.projectV2.fields.nodes[]
       | select(.name==$n).options[]
       | select(.name==$o).id // empty'
}

PRIORITY_FIELD_ID=$(field_id "Priority")
SIZE_FIELD_ID=$(field_id "Size")
STATUS_FIELD_ID=$(field_id "Status")
[[ -n "$PRIORITY_FIELD_ID" ]] || { echo "::error::Priority field not found" >&2; exit 1; }
[[ -n "$SIZE_FIELD_ID"     ]] || { echo "::error::Size field not found"     >&2; exit 1; }
[[ -n "$STATUS_FIELD_ID"   ]] || { echo "::error::Status field not found"   >&2; exit 1; }

# label name -> option name
priority_option_for_label() {
  case "$1" in
    priority:critical) echo "Critical" ;;
    priority:high)     echo "High" ;;
    priority:medium)   echo "Medium" ;;
    priority:low)      echo "Low" ;;
    *) echo "" ;;
  esac
}

# Resolve Status from issue state + labels (label-driven; matches the rest of
# the agentic pipeline, which is label-driven). Precedence (first match wins):
#   closed                                       → Done
#   in-progress                                  → In progress
#   blocked                                      → Blocked
#   claude-ready                                 → Ready
#   needs-grooming / needs-design / design-approved → Backlog
#   else                                         → (empty — keep current value;
#                                                   don't bounce items back to
#                                                   To triage on every event)
#
# "In review" is intentionally not auto-set: an issue with `in-progress` keeps
# that status across the PR-open → review → merge → close transitions; the PR
# board (not the issue board) tracks review state.
status_for_issue() {
  local state="$1"; shift
  local labels=("$@")
  # Treat any non-OPEN state as Done. gh returns CLOSED for issues and MERGED
  # for PRs (gh issue view silently falls back to PR data on PR numbers).
  [[ "$state" != "OPEN" ]] && { echo "Done"; return; }
  local l
  for l in "${labels[@]}"; do
    [[ "$l" == "in-progress" ]] && { echo "In progress"; return; }
  done
  for l in "${labels[@]}"; do
    [[ "$l" == "blocked" ]] && { echo "Blocked"; return; }
  done
  for l in "${labels[@]}"; do
    [[ "$l" == "claude-ready" ]] && { echo "Ready"; return; }
  done
  for l in "${labels[@]}"; do
    case "$l" in
      needs-grooming|needs-design|design-approved) echo "Backlog"; return ;;
    esac
  done
  echo ""  # no signal — leave Status alone
}
size_option_for_label() {
  case "$1" in
    size:xs) echo "XS" ;;
    size:s)  echo "S" ;;
    size:m)  echo "M" ;;
    *) echo "" ;;
  esac
}

# ---- 2) Sync one issue --------------------------------------------------
sync_one() {
  local num="$1"
  local node_id labels item_id

  local issue_json state
  issue_json=$(gh issue view "$num" --repo "$GH_REPO" --json number,id,labels,state 2>/dev/null) || {
    echo "::warning::issue #$num not found in $GH_REPO; skipping" >&2
    return 0
  }
  node_id=$(jq -r '.id' <<<"$issue_json")
  labels=$(jq -r '[.labels[].name] | join(",")' <<<"$issue_json")
  state=$(jq -r '.state' <<<"$issue_json")

  IFS=',' read -ra LBLS <<<"$labels"
  local status_opt
  status_opt=$(status_for_issue "$state" "${LBLS[@]}")

  if [[ "$DRY_RUN" -eq 1 ]]; then
    echo "would sync #$num (state: $state, labels: $labels, status: ${status_opt:-<leave alone>})"
    return 0
  fi

  # Add to project (idempotent — addProjectV2ItemById returns the existing item)
  local add_query='mutation($projectId: ID!, $contentId: ID!) {
    addProjectV2ItemById(input: {projectId: $projectId, contentId: $contentId}) {
      item { id }
    }
  }'
  local add_resp
  add_resp=$(jq -n --arg projectId "$PROJECT_ID" --arg contentId "$node_id" \
    '{projectId: $projectId, contentId: $contentId}' | run_query "$add_query")
  item_id=$(jq -r '.data.addProjectV2ItemById.item.id // empty' <<<"$add_resp")
  if [[ -z "$item_id" ]]; then
    echo "::warning::add-to-project failed for #$num" >&2
    echo "$add_resp" >&2
    return 1
  fi

  # Resolve which option each field should be (empty string => clear)
  local priority_opt="" size_opt=""
  for l in "${LBLS[@]}"; do
    local p s
    p=$(priority_option_for_label "$l")
    s=$(size_option_for_label "$l")
    [[ -n "$p" && -z "$priority_opt" ]] && priority_opt="$p"
    [[ -n "$s" && -z "$size_opt"     ]] && size_opt="$s"
  done

  set_or_clear() {
    # $1 = field id, $2 = field name, $3 = option name (or empty to clear)
    local field_id="$1" field_name="$2" opt_name="$3"
    if [[ -n "$opt_name" ]]; then
      local opt_id
      opt_id=$(option_id "$field_name" "$opt_name")
      if [[ -z "$opt_id" ]]; then
        echo "::warning::no option '$opt_name' on field '$field_name'" >&2
        return 0
      fi
      local set_query='mutation($projectId: ID!, $itemId: ID!, $fieldId: ID!, $optionId: String!) {
        updateProjectV2ItemFieldValue(input: {
          projectId: $projectId, itemId: $itemId, fieldId: $fieldId,
          value: { singleSelectOptionId: $optionId }
        }) { projectV2Item { id } }
      }'
      jq -n --arg projectId "$PROJECT_ID" --arg itemId "$item_id" \
            --arg fieldId "$field_id" --arg optionId "$opt_id" \
        '{projectId: $projectId, itemId: $itemId, fieldId: $fieldId, optionId: $optionId}' \
        | run_query "$set_query" >/dev/null
      echo "  → #$num $field_name=$opt_name"
    else
      local clear_query='mutation($projectId: ID!, $itemId: ID!, $fieldId: ID!) {
        clearProjectV2ItemFieldValue(input: {
          projectId: $projectId, itemId: $itemId, fieldId: $fieldId
        }) { projectV2Item { id } }
      }'
      jq -n --arg projectId "$PROJECT_ID" --arg itemId "$item_id" --arg fieldId "$field_id" \
        '{projectId: $projectId, itemId: $itemId, fieldId: $fieldId}' \
        | run_query "$clear_query" >/dev/null
      echo "  → #$num $field_name=(cleared)"
    fi
  }

  set_or_clear "$PRIORITY_FIELD_ID" "Priority" "$priority_opt"
  set_or_clear "$SIZE_FIELD_ID"     "Size"     "$size_opt"

  # Status: only set when we have a signal — never clear, since a maintainer
  # may have manually placed an item in To triage / Backlog and we shouldn't
  # bounce it on every label edit.
  if [[ -n "$status_opt" ]]; then
    set_or_clear "$STATUS_FIELD_ID" "Status" "$status_opt"
  fi
}

# ---- 3) Drive ----------------------------------------------------------
if [[ "$ALL_OPEN" -eq 1 ]]; then
  mapfile -t NUMBERS < <(gh issue list --repo "$GH_REPO" --state open --limit 500 --json number --jq '.[].number')
  echo "syncing ${#NUMBERS[@]} open issues"
  for n in "${NUMBERS[@]}"; do sync_one "$n"; done
  echo "done"
else
  [[ -n "$ISSUE" ]] || { echo "usage: $0 <issue-number> | --all-open" >&2; exit 2; }
  sync_one "$ISSUE"
fi
