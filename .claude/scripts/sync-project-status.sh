#!/usr/bin/env bash
# Sync the Sailfin Tracker (org project SailfinIO/4) Status field for an issue.
#
# Usage:
#   .claude/scripts/sync-project-status.sh <issue-number> [--from-labels|--status <name>]
#
# Defaults to --from-labels when no mode is given.
#
# Label precedence (when --from-labels):
#   in-progress  > blocked > needs-grooming > claude-ready
#
# Status names accepted with --status:
#   triage | backlog | ready | blocked | in-progress | in-review | done
#
# Idempotent: adds the issue to the project if not already there, then sets Status.
# Exits non-zero on real failures so callers can surface drift in their reports.

set -euo pipefail

# Project + field IDs are stable per project; resolved once via:
#   gh project field-list 4 --owner SailfinIO
#   gh api graphql -f query='query{node(id:"<status-field-id>"){...on ProjectV2SingleSelectField{options{id name}}}}'
PROJECT_ID="PVT_kwDOCLW9dM4BTN6N"
STATUS_FIELD_ID="PVTSSF_lADOCLW9dM4BTN6NzhAhbTE"
REPO="${SAILFIN_REPO:-SailfinIO/sailfin}"

if [[ $# -lt 1 ]]; then
  echo "usage: $0 <issue-number> [--from-labels|--status <name>]" >&2
  exit 2
fi

issue_number="$1"
shift

mode="from-labels"
forced_status=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --from-labels) mode="from-labels"; shift ;;
    --status)      mode="forced"; forced_status="${2:-}"; shift 2 ;;
    *) echo "error: unknown arg '$1'" >&2; exit 2 ;;
  esac
done

option_id_for() {
  case "$1" in
    triage|"To triage")        echo "f971fb55" ;;
    backlog|"Backlog")         echo "f75ad846" ;;
    ready|"Ready")             echo "856cdede" ;;
    blocked|"Blocked")         echo "8cc85b1a" ;;
    in-progress|"In progress") echo "47fc9ee4" ;;
    in-review|"In review")     echo "5ef0dc97" ;;
    done|"Done")               echo "98236657" ;;
    *) return 1 ;;
  esac
}

if [[ "$mode" == "forced" ]]; then
  status_name="$forced_status"
  option_id="$(option_id_for "$status_name")" || {
    echo "error: unknown status '$status_name'" >&2
    echo "valid: triage|backlog|ready|blocked|in-progress|in-review|done" >&2
    exit 2
  }
else
  # Derive from current labels with strict precedence.
  labels_json="$(gh api "repos/$REPO/issues/$issue_number" --jq '[.labels[].name]')"
  has() { echo "$labels_json" | jq -e --arg n "$1" 'index($n) != null' >/dev/null; }

  if has "in-progress"; then
    status_name="In progress"; option_id="47fc9ee4"
  elif has "blocked"; then
    status_name="Blocked"; option_id="8cc85b1a"
  elif has "needs-grooming"; then
    status_name="To triage"; option_id="f971fb55"
  elif has "claude-ready"; then
    status_name="Ready"; option_id="856cdede"
  else
    echo "issue #$issue_number has no status-bearing label; leaving project status untouched" >&2
    exit 0
  fi
fi

issue_node_id="$(gh api "repos/$REPO/issues/$issue_number" --jq .node_id)"

item_id="$(gh api graphql \
  -f query='mutation($project:ID!,$content:ID!){
    addProjectV2ItemById(input:{projectId:$project,contentId:$content}){item{id}}
  }' \
  -f project="$PROJECT_ID" \
  -f content="$issue_node_id" \
  --jq '.data.addProjectV2ItemById.item.id')"

gh api graphql \
  -f query='mutation($project:ID!,$item:ID!,$field:ID!,$value:String!){
    updateProjectV2ItemFieldValue(input:{
      projectId:$project, itemId:$item, fieldId:$field,
      value:{singleSelectOptionId:$value}
    }){projectV2Item{id}}
  }' \
  -f project="$PROJECT_ID" \
  -f item="$item_id" \
  -f field="$STATUS_FIELD_ID" \
  -f value="$option_id" \
  --jq '.data.updateProjectV2ItemFieldValue.projectV2Item.id' >/dev/null

echo "issue #$issue_number → $status_name"
