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
endpoint=""
expect_header=0
for arg in "$@"; do
    if [ "$expect_header" -eq 1 ]; then
        case "$arg" in
            @*) header_file=${arg#@} ;;
        esac
        expect_header=0
        continue
    fi
    case "$arg" in
        -H) expect_header=1 ;;
        https://api.openai.com/v1/responses) endpoint=openai-responses ;;
        https://api.openai.com/v1/chat/completions) endpoint=openai-chat ;;
        https://api.anthropic.com/*) endpoint=anthropic ;;
    esac
done

if [ -z "$header_file" ] || [ ! -f "$header_file" ]; then
    echo "missing temporary header file" >&2
    exit 92
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
    if [ "${SFN350_MOCK_MODE:-}" = deny_after_schema ] && [ "$count" -gt 1 ]; then
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
    printf '%s\n' '{"content":[{"type":"text","text":"OK"}],"usage":{"input_tokens":7,"output_tokens":1}}'
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

python3 - "$tmp/results/intermittent-paid" "$tmp/results/intermittent-arm" <<'PY'
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
PY

if find "$tmp/auth" -type f -print -quit | grep -q .; then
    echo "temporary provider header was not removed" >&2
    exit 94
fi

echo "provider credential transport and setup-failure verification passed"
