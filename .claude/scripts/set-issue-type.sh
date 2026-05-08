#!/usr/bin/env bash
# Set the GitHub native issue Type field for a single issue.
#
# Usage:
#   .claude/scripts/set-issue-type.sh <issue-number> <Feature|Task|Bug>
#
# The type is set via the GraphQL updateIssue mutation.  The type IDs below
# are stable for the SailfinIO org.  Resolve them with:
#   gh api graphql -f query='query{repository(owner:"SailfinIO",name:"sailfin"){issueTypes(first:10){nodes{id name}}}}'
#
# Mapping (from type:* labels):
#   type:feature                          → Feature
#   type:bug                              → Bug
#   type:refactor / type:perf / type:docs
#     / type:tech-debt / epic / tracking  → Task
#
# Exits non-zero on API failure so callers can surface it in reports.

set -euo pipefail

REPO="${SAILFIN_REPO:-SailfinIO/sailfin}"

TYPE_FEATURE="IT_kwDOCLW9dM4BOQXt"
TYPE_TASK="IT_kwDOCLW9dM4BOQXm"
TYPE_BUG="IT_kwDOCLW9dM4BOQXp"

if [[ $# -lt 2 ]]; then
  echo "usage: $0 <issue-number> <Feature|Task|Bug>" >&2
  exit 2
fi

issue_number="$1"
type_name="$2"

case "$type_name" in
  Feature) type_id="$TYPE_FEATURE" ;;
  Bug)     type_id="$TYPE_BUG" ;;
  Task)    type_id="$TYPE_TASK" ;;
  *)
    echo "error: unknown type '$type_name'; expected Feature, Task, or Bug" >&2
    exit 2
    ;;
esac

node_id="$(gh api "repos/$REPO/issues/$issue_number" --jq '.node_id')"

gh api graphql -f query="
  mutation {
    updateIssue(input: { id: \"$node_id\", issueTypeId: \"$type_id\" }) {
      issue { number issueType { name } }
    }
  }" --jq '.data.updateIssue.issue | "issue #\(.number) type → \(.issueType.name)"'
