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
        https://api.openai.com/*) endpoint=openai ;;
        https://api.anthropic.com/*) endpoint=anthropic ;;
    esac
done

if [ -z "$header_file" ] || [ ! -f "$header_file" ]; then
    echo "missing temporary header file" >&2
    exit 92
fi

if [ "$endpoint" = openai ]; then
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

if find "$tmp/auth" -type f -print -quit | grep -q .; then
    echo "temporary provider header was not removed" >&2
    exit 94
fi

echo "provider credential transport verification passed"
