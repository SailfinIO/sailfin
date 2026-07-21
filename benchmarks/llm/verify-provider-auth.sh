#!/bin/sh
set -eu

repo=$(CDPATH= cd -- "$(dirname "$0")/../.." && pwd)
runner="$repo/build/sfn350"

if [ ! -x "$runner" ]; then
    echo "missing benchmark runner: $runner" >&2
    exit 1
fi

tmp=$(mktemp -d "${TMPDIR:-/tmp}/sfn350-auth-test.XXXXXX")
trap 'rm -rf "$tmp"' EXIT
mkdir -p "$tmp/bin" "$tmp/auth" "$tmp/results"

cat > "$tmp/bin/curl" <<'MOCK'
#!/bin/sh
set -eu

for arg in "$@"; do
    case "$arg" in
        *sfn350-openai-sentinel*|*sfn350-anthropic-sentinel*)
            echo "credential leaked into curl argv" >&2
            exit 91
            ;;
    esac
done

header_file=""
body_file=""
endpoint=""
expect_header=0
expect_body=0
for arg in "$@"; do
    if [ "$expect_header" -eq 1 ]; then
        case "$arg" in
            @*) header_file=${arg#@} ;;
        esac
        expect_header=0
        continue
    fi
    if [ "$expect_body" -eq 1 ]; then
        case "$arg" in
            @*) body_file=${arg#@} ;;
        esac
        expect_body=0
        continue
    fi
    case "$arg" in
        -H) expect_header=1 ;;
        --data-binary) expect_body=1 ;;
        https://api.openai.com/v1/responses) endpoint=openai-responses ;;
        https://api.openai.com/v1/chat/completions) endpoint=openai-chat ;;
        https://api.anthropic.com/*) endpoint=anthropic ;;
    esac
done

if [ -z "$header_file" ] || [ ! -f "$header_file" ]; then
    echo "missing temporary header file" >&2
    exit 92
fi
if [ -z "$body_file" ] || [ ! -f "$body_file" ]; then
    echo "missing provider request body" >&2
    exit 95
fi

count=1
if [ -n "${SFN350_MOCK_STATE:-}" ]; then
    previous=0
    if [ -f "$SFN350_MOCK_STATE" ]; then
        previous=$(cat "$SFN350_MOCK_STATE")
    fi
    count=$((previous + 1))
    printf '%s\n' "$count" > "$SFN350_MOCK_STATE"
fi

if [ "$endpoint" = openai-responses ]; then
    grep -q '^Authorization: Bearer sfn350-openai-sentinel$' "$header_file"
    if [ "${SFN350_MOCK_MODE:-}" = overload_always ]; then
        printf '%s\n' '{"error":{"type":"overloaded_error","message":"Overloaded"}}'
    elif [ "${SFN350_MOCK_MODE:-}" = deny_after_schema ] && [ "$count" -gt 1 ]; then
        printf '%s\n' '{"error":{"type":"invalid_request_error","message":"You have insufficient permissions for this operation."}}'
    elif [ "${SFN350_MOCK_MODE:-}" = success_then_deny ] && [ "$count" -gt 1 ]; then
        printf '%s\n' '{"error":{"type":"invalid_request_error","message":"You have insufficient permissions for this operation."}}'
    elif [ "${SFN350_MOCK_MODE:-}" = success_then_deny ]; then
        printf '%s\n' '{"output":[{"type":"message","content":[{"type":"output_text","text":"```python\nimport sys\n\ndef run_length(nums):\n    out = []\n    for n in nums:\n        if out and out[-1][0] == n:\n            out[-1] = (n, out[-1][1] + 1)\n        else:\n            out.append((n, 1))\n    return out\n\nline = sys.stdin.readline().strip()\nnums = [int(x) for x in line.split()] if line else []\nprint(\" \".join(f\"{v}:{c}\" for v, c in run_length(nums)))\n```"}]}],"usage":{"input_tokens":100,"output_tokens":100}}'
    else
        printf '%s\n' '{"output":[{"type":"message","content":[{"type":"output_text","text":"OK"}]}],"usage":{"input_tokens":7,"output_tokens":1}}'
    fi
elif [ "$endpoint" = openai-chat ]; then
    grep -q '^Authorization: Bearer sfn350-openai-sentinel$' "$header_file"
    printf '%s\n' '{"choices":[{"message":{"content":"OK"}}],"usage":{"prompt_tokens":7,"completion_tokens":1}}'
elif [ "$endpoint" = anthropic ]; then
    grep -q '^x-api-key: sfn350-anthropic-sentinel$' "$header_file"
    grep -q '"thinking":{"type":"adaptive"}' "$body_file"
    grep -q '"output_config":{"effort":"medium"}' "$body_file"
    if grep -q 'budget_tokens' "$body_file" \
        || grep -q '"type":"enabled"' "$body_file"; then
        echo "obsolete Anthropic thinking schema" >&2
        exit 96
    fi
    if [ "${SFN350_MOCK_MODE:-}" = anthropic_schema_error ]; then
        printf '%s\n' '{"type":"error","error":{"type":"invalid_request_error","message":"thinking.type.enabled is not supported for this model"}}'
    elif [ "${SFN350_MOCK_MODE:-}" = overload_once ] && [ "$count" -eq 1 ]; then
        printf '%s\n' '{"type":"error","error":{"type":"overloaded_error","message":"Overloaded"}}'
    else
        printf '%s\n' '{"content":[{"type":"text","text":"OK"}],"usage":{"input_tokens":7,"output_tokens":1}}'
    fi
else
    echo "unknown endpoint" >&2
    exit 93
fi
MOCK
chmod +x "$tmp/bin/curl"

PATH="$tmp/bin:$PATH" TMPDIR="$tmp/auth" \
    OPENAI_API_KEY=sfn350-openai-sentinel \
    "$runner" --adapter openai --model gpt-5.6-terra \
    --reasoning-effort medium --schema-probe \
    --results-dir "$tmp/results/openai"

PATH="$tmp/bin:$PATH" TMPDIR="$tmp/auth" \
    ANTHROPIC_API_KEY=sfn350-anthropic-sentinel \
    "$runner" --adapter anthropic --model claude-sonnet-5 \
    --schema-probe --results-dir "$tmp/results/anthropic"

overload_once_state="$tmp/overload-once-state"
PATH="$tmp/bin:$PATH" TMPDIR="$tmp/auth" \
    SFN350_MOCK_MODE=overload_once SFN350_MOCK_STATE="$overload_once_state" \
    ANTHROPIC_API_KEY=sfn350-anthropic-sentinel \
    "$runner" --adapter anthropic --model claude-sonnet-5 \
    --schema-probe --results-dir "$tmp/results/overload-once"

if PATH="$tmp/bin:$PATH" TMPDIR="$tmp/auth" \
    SFN350_MOCK_MODE=anthropic_schema_error \
    ANTHROPIC_API_KEY=sfn350-anthropic-sentinel \
    "$runner" --track b --adapter anthropic --model claude-sonnet-5 \
    --model-family anthropic-sonnet --contamination-probe \
    --results-dir "$tmp/results/anthropic-contamination-error"; then
    echo "provider-error contamination probe unexpectedly succeeded" >&2
    exit 97
fi

overload_exhausted_state="$tmp/overload-exhausted-state"
PATH="$tmp/bin:$PATH" TMPDIR="$tmp/auth" \
    SFN350_MOCK_MODE=overload_always SFN350_MOCK_STATE="$overload_exhausted_state" \
    OPENAI_API_KEY=sfn350-openai-sentinel \
    "$runner" --adapter openai --model gpt-5.6-terra \
    --reasoning-effort medium --task logic-001-runlength --arm sailfin \
    --results-dir "$tmp/results/overload-exhausted"

schema_state="$tmp/schema-state"
PATH="$tmp/bin:$PATH" TMPDIR="$tmp/auth" \
    SFN350_MOCK_MODE=deny_after_schema SFN350_MOCK_STATE="$schema_state" \
    OPENAI_API_KEY=sfn350-openai-sentinel \
    "$runner" --adapter openai --model gpt-5.6-terra \
    --reasoning-effort medium --schema-probe \
    --results-dir "$tmp/results/intermittent-schema"
PATH="$tmp/bin:$PATH" TMPDIR="$tmp/auth" \
    SFN350_MOCK_MODE=deny_after_schema SFN350_MOCK_STATE="$schema_state" \
    OPENAI_API_KEY=sfn350-openai-sentinel \
    "$runner" --adapter openai --model gpt-5.6-terra \
    --reasoning-effort medium --task logic-001-runlength --arm sailfin \
    --results-dir "$tmp/results/intermittent-paid"

arm_state="$tmp/arm-state"
PATH="$tmp/bin:$PATH" TMPDIR="$tmp/auth" \
    SFN350_MOCK_MODE=success_then_deny SFN350_MOCK_STATE="$arm_state" \
    OPENAI_API_KEY=sfn350-openai-sentinel \
    "$runner" --adapter openai --model gpt-5.6-terra \
    --reasoning-effort medium --task logic-001-runlength \
    --arm python --arm sailfin --results-dir "$tmp/results/intermittent-arm"

python3 - "$tmp/results/intermittent-paid" "$tmp/results/intermittent-arm" \
    "$tmp/results/overload-once" "$tmp/results/overload-exhausted" \
    "$tmp/results/anthropic-contamination-error" <<'PY'
import json
import pathlib
import sys

for root, expected_records in ((pathlib.Path(sys.argv[1]), 1), (pathlib.Path(sys.argv[2]), 2)):
    run_dir = next(root.glob("run-*"))
    manifest = json.loads((run_dir / "run.json").read_text())
    analysis = json.loads((run_dir / "analysis.json").read_text())
    records = json.loads((run_dir / "records.json").read_text())
    assert manifest["run_valid"] is False
    assert manifest["invalid_reason"] == "provider_setup_auth_permission"
    assert analysis["run_valid"] is False
    assert analysis["decision_authorized"] is False
    assert len(records) == expected_records
    failed = records[-1]
    assert "provider_auth_permission" in failed["fail_categories"]
    failure = json.loads((run_dir / "attempts" / failed["attempt_id"] / "provider-failure.json").read_text())
    assert failure["classification"] == "auth_permission"
    assert failure["setup_class"] is True

overload_once = next(pathlib.Path(sys.argv[3]).glob("run-*"))
schema = json.loads((overload_once / "schema-probe.json").read_text())
assert schema["provider_attempts"] == 2
assert schema["error"] == ""
retry = json.loads((overload_once / "provider-retry-0-try-1.json").read_text())
assert retry["classification"] == "transport_transient"
assert retry["next_provider_attempt"] == 2

overload_exhausted = next(pathlib.Path(sys.argv[4]).glob("run-*"))
manifest = json.loads((overload_exhausted / "run.json").read_text())
analysis = json.loads((overload_exhausted / "analysis.json").read_text())
records = json.loads((overload_exhausted / "records.json").read_text())
assert manifest["run_valid"] is False
assert manifest["invalid_reason"] == "provider_transport_retry_exhausted"
assert analysis["decision_authorized"] is False
assert len(records) == 1
assert records[0]["language_denominator"] is False
assert "provider_transport_transient" in records[0]["fail_categories"]
failure = json.loads((overload_exhausted / "attempts" / records[0]["attempt_id"] / "provider-failure.json").read_text())
assert failure["provider_attempts"] == 3
assert failure["classification"] == "transport_transient"

contamination = next(pathlib.Path(sys.argv[5]).glob("run-*")) / "contamination-probe"
report = json.loads((contamination / "report.json").read_text())
assert report["status"] == "provider_error"
assert report["clearance_eligible"] is False
assert report["cleared"] is False
assert len(report["responses"]) == 1
assert report["responses"][0]["provider_error"]
probe = contamination / "control-x"
assert next(probe.glob("request-*-try-*.json")).is_file()
assert next(probe.glob("response-*-try-*.json")).is_file()
assert (probe / "provider.error").is_file()
PY

if find "$tmp/auth" -type f -print -quit | grep -q .; then
    echo "temporary provider header was not removed" >&2
    exit 94
fi

echo "provider credential transport, symmetric transient retry, and setup-failure verification passed"
