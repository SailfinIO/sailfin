#!/usr/bin/env bash
# scripts/linear-priority-sync.sh
#
# Backfills Linear-native priority and estimate on the Sailfin team's issue
# mirrors — the CI-side complement to the /groom and /triage skills, which set
# these fields interactively. Priority and estimate are Linear-native fields,
# not GitHub labels (see docs/conventions/issue-naming.md § Reflecting state
# into Linear), so the GitHub-side regression filers (build-quality.yml,
# perf-history.yml) cannot set them at `gh issue create` time: the Linear
# mirror of a new GitHub issue is created asynchronously by the GitHub<->Linear
# integration. This sweep runs on a schedule and fills that gap.
#
# What it sets (conservative and deterministic — it never guesses a human
# priority, and never overrides an already-set value):
#   * estimate — from the `size:*` label when the mirror has no estimate
#                (size:xs -> 1, size:s -> 2, size:m -> 3, on the team's
#                Linear 1-5 scale).
#   * priority — only for the auto-filed regression classes while they sit at
#                No priority: `build-quality-regression` -> Urgent (1),
#                `perf-regression` -> Medium (3).
#
# Because it acts only when estimate is unset or priority is 0-with-a-known
# regression-label, it is idempotent and safe to run repeatedly.
#
# Requires: LINEAR_API_KEY (write scope) in the environment; curl + jq.

set -euo pipefail

TEAM_ID="${SAILFIN_LINEAR_TEAM_ID:-dd644ba0-5c93-40a9-8c01-ceccae9dce7b}"
API="https://api.linear.app/graphql"

if [ -z "${LINEAR_API_KEY:-}" ]; then
  echo "[linear-sync] LINEAR_API_KEY not set; skipping (no-op)."
  exit 0
fi

gql() {
  # $1 = JSON request body. Echoes the raw response.
  curl -sS -X POST "$API" \
    -H "Authorization: ${LINEAR_API_KEY}" \
    -H "Content-Type: application/json" \
    --data "$1"
}

# --- Fetch open issues (paginated) ------------------------------------------
cursor="null"
nodes_file="$(mktemp)"
: > "$nodes_file"
page=0
while :; do
  page=$((page + 1))
  if [ "$page" -gt 40 ]; then
    echo "[linear-sync] pagination guard hit at page $page; stopping."
    break
  fi
  req="$(jq -n --arg t "$TEAM_ID" --argjson c "$cursor" '{
    query: "query($t:String!,$c:String){ team(id:$t){ issues(first:100, after:$c, filter:{ state:{ type:{ nin:[\"completed\",\"canceled\"] } } }){ nodes{ id identifier priority estimate labels{ nodes{ name } } } pageInfo{ hasNextPage endCursor } } } }",
    variables: { t: $t, c: $c }
  }')"
  resp="$(gql "$req")"
  if echo "$resp" | jq -e '.errors' >/dev/null 2>&1; then
    echo "[linear-sync] query error:"
    echo "$resp" | jq -c '.errors'
    exit 1
  fi
  echo "$resp" | jq -c '.data.team.issues.nodes[]' >> "$nodes_file"
  hasNext="$(echo "$resp" | jq -r '.data.team.issues.pageInfo.hasNextPage')"
  endCur="$(echo "$resp" | jq -r '.data.team.issues.pageInfo.endCursor')"
  if [ "$hasNext" = "true" ]; then
    cursor="\"$endCur\""
  else
    break
  fi
done

# --- Compute + apply changes ------------------------------------------------
# jq emits one TSV row per issue that needs a change: id, identifier, priority
# (number or "null"), estimate (number or "null"). "null" means leave that
# field unchanged.
changed=0
failed=0
while IFS=$'\t' read -r id ident prio est; do
  [ -z "$id" ] && continue
  input="$(jq -n --argjson p "$prio" --argjson e "$est" '
    ({} + (if $p != null then {priority: $p} else {} end)
        + (if $e != null then {estimate: $e} else {} end))')"
  req="$(jq -n --arg id "$id" --argjson input "$input" '{
    query: "mutation($id:String!,$input:IssueUpdateInput!){ issueUpdate(id:$id, input:$input){ success } }",
    variables: { id: $id, input: $input }
  }')"
  resp="$(gql "$req")"
  if echo "$resp" | jq -e '.data.issueUpdate.success == true' >/dev/null 2>&1; then
    echo "[linear-sync] updated ${ident} <- ${input}"
    changed=$((changed + 1))
  else
    echo "[linear-sync] FAILED ${ident}: $(echo "$resp" | jq -c '.errors // .')"
    failed=$((failed + 1))
  fi
done < <(
  jq -r -s '
    .[] |
    ([.labels.nodes[].name]) as $l |
    (if .estimate == null then
       (if   ($l | index("size:xs")) then 1
        elif ($l | index("size:s"))  then 2
        elif ($l | index("size:m"))  then 3
        else null end)
     else null end) as $e |
    (if .priority == 0 then
       (if   ($l | index("build-quality-regression")) then 1
        elif ($l | index("perf-regression"))          then 3
        else null end)
     else null end) as $p |
    select($e != null or $p != null) |
    [.id, .identifier, ($p // "null"), ($e // "null")] | @tsv
  ' "$nodes_file"
)

rm -f "$nodes_file"
echo "[linear-sync] done; ${changed} updated, ${failed} failed."
[ "$failed" -eq 0 ]
