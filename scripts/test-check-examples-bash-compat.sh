#!/usr/bin/env bash
# Regression coverage for the check-examples ratchet under macOS Bash 3.2.

set -u

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
system_bash="/bin/bash"
[ -x "$system_bash" ] || system_bash="$(command -v bash)"

scratch="$(mktemp -d "${TMPDIR:-/tmp}/sfn_examples_compat.XXXXXX")" || {
    echo "error: mktemp failed" >&2
    exit 2
}
trap 'rm -rf "$scratch"' EXIT

mkdir -p "$scratch/bin"

cat > "$scratch/bin/timeout" <<'EOF'
#!/usr/bin/env bash
shift
exec "$@"
EOF

cat > "$scratch/bin/sfn" <<'EOF'
#!/usr/bin/env bash
case "${FAKE_SFN_RESULT:-pass}:$1" in
    fail:check) exit 1 ;;
    *:check) exit 0 ;;
    *:run) printf 'example output\n' ;;
    *) exit 2 ;;
esac
EOF

chmod +x "$scratch/bin/timeout" "$scratch/bin/sfn"

empty_gate="$repo_root/scripts/check-examples.sh"
known_gate="$scratch/check-examples-known.sh"
awk '
    { print }
    $0 == "KNOWN_FAILING=(" { print "    \"examples/example.sfn\"" }
' "$empty_gate" > "$known_gate"

run_case() {
    name="$1"
    gate="$2"
    fake_result="$3"
    expected_rc="$4"
    expected_status="$5"
    case_root="$scratch/$name"
    output="$scratch/$name.out"

    mkdir -p "$case_root/examples"
    : > "$case_root/examples/example.sfn"

    (
        cd "$case_root" || exit 2
        PATH="$scratch/bin:$PATH" \
            SAILFIN_BIN="$scratch/bin/sfn" \
            FAKE_SFN_RESULT="$fake_result" \
            "$system_bash" "$gate"
    ) > "$output" 2>&1
    actual_rc=$?

    if [ "$actual_rc" -ne "$expected_rc" ]; then
        echo "$name: expected exit $expected_rc, got $actual_rc" >&2
        cat "$output" >&2
        return 1
    fi
    if ! grep -q "$expected_status" "$output"; then
        echo "$name: missing status $expected_status" >&2
        cat "$output" >&2
        return 1
    fi
}

"$system_bash" --version | head -n 1
run_case empty "$empty_gate" pass 0 PASS || exit 1
run_case regression "$empty_gate" fail 1 REGRESSION || exit 1
run_case xfail "$known_gate" fail 0 XFAIL || exit 1
run_case xpass "$known_gate" pass 1 XPASS || exit 1
echo "check-examples Bash compatibility: PASS"
