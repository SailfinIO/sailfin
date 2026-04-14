#!/usr/bin/env bash
# End-to-end tests for `sfn publish`.
#
# Usage:
#   compiler/tests/e2e/test_publish.sh <compiler-binary>
#
# Tests argument handling, capsule discovery, SFNPKG packaging, and digest
# format.  Network-dependent tests use a tiny HTTP stub so the real registry
# is never contacted.

set -euo pipefail

BINARY="$(cd "$(dirname "${1:?usage: test_publish.sh <compiler-binary>}")" && pwd)/$(basename "$1")"
PASS=0
FAIL=0

# Prevent the real SFN_TOKEN from leaking into tests — each test that needs
# a token provides one explicitly via credentials file or env override.
unset SFN_TOKEN 2>/dev/null || true

# Portable sha256 and base64 helpers (GNU vs macOS)
_sha256() { sha256sum "$@" 2>/dev/null || shasum -a 256 "$@"; }
_b64decode() { base64 -d 2>/dev/null || base64 -D; }

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

run_test() {
    local name="$1"
    shift
    if "$@"; then
        echo "[test] PASS: $name"
        PASS=$((PASS + 1))
    else
        echo "[test] FAIL: $name"
        FAIL=$((FAIL + 1))
    fi
}

# Helper: create a minimal capsule directory
make_capsule() {
    local dir="$1"
    local name="${2:-test/pkg}"
    local version="${3:-1.0.0}"
    mkdir -p "$dir/src"
    cat > "$dir/capsule.toml" <<EOF
[capsule]
name = "$name"
version = "$version"

[dependencies]

[capabilities]
required = ["io"]

[build]
entry = "src/mod.sfn"
EOF
    cat > "$dir/src/mod.sfn" <<'EOF'
fn hello() -> string {
    return "hello";
}
EOF
}

# ---- Test 1: publish with too many args shows usage ----
test_publish_too_many_args() {
    local home="$tmpdir/t1"
    mkdir -p "$home"
    local output
    output="$(HOME="$home" "$BINARY" publish a b 2>&1 || true)"
    echo "$output" | grep -qi "usage" || { echo "expected usage message, got: $output"; return 1; }
}

# ---- Test 2: publish with no capsule.toml fails ----
test_publish_no_capsule_toml() {
    local home="$tmpdir/t2"
    local workdir="$tmpdir/t2_work"
    mkdir -p "$home/.sfn" "$workdir"
    echo "fake-token" > "$home/.sfn/credentials"
    local output
    output="$(cd "$workdir" && HOME="$home" "$BINARY" publish 2>&1 || true)"
    echo "$output" | grep -q "no capsule.toml found" || { echo "expected 'no capsule.toml found', got: $output"; return 1; }
}

# ---- Test 3: publish with path arg finds capsule.toml ----
test_publish_path_finds_capsule() {
    local home="$tmpdir/t3"
    local workdir="$tmpdir/t3_work"
    mkdir -p "$home/.sfn" "$workdir"
    echo "fake-token" > "$home/.sfn/credentials"
    make_capsule "$workdir/my/capsule"
    # Run from tmpdir — not inside the capsule — with a path arg.
    # It will fail at the curl step (no registry), but the output should show
    # the packaging message which proves it found capsule.toml via the path.
    local output
    output="$(cd "$tmpdir" && HOME="$home" "$BINARY" publish "$workdir/my/capsule" 2>&1 || true)"
    echo "$output" | grep -q "packaging test/pkg@1.0.0" \
        || { echo "expected 'packaging test/pkg@1.0.0', got: $output"; return 1; }
}

# ---- Test 4: publish with trailing-slash path still works ----
test_publish_trailing_slash() {
    local home="$tmpdir/t4"
    local workdir="$tmpdir/t4_work"
    mkdir -p "$home/.sfn" "$workdir"
    echo "fake-token" > "$home/.sfn/credentials"
    make_capsule "$workdir/cap"
    local output
    output="$(cd "$tmpdir" && HOME="$home" "$BINARY" publish "$workdir/cap/" 2>&1 || true)"
    echo "$output" | grep -q "packaging test/pkg@1.0.0" \
        || { echo "expected packaging message with trailing slash path, got: $output"; return 1; }
}

# ---- Test 5: publish without path uses cwd ----
test_publish_cwd() {
    local home="$tmpdir/t5"
    local workdir="$tmpdir/t5_work"
    mkdir -p "$home/.sfn"
    echo "fake-token" > "$home/.sfn/credentials"
    make_capsule "$workdir" "my/cap" "2.0.0"
    local output
    output="$(cd "$workdir" && HOME="$home" "$BINARY" publish 2>&1 || true)"
    echo "$output" | grep -q "packaging my/cap@2.0.0" \
        || { echo "expected 'packaging my/cap@2.0.0', got: $output"; return 1; }
}

# ---- Test 6: publish with no token fails ----
test_publish_no_token() {
    local home="$tmpdir/t6"
    local workdir="$tmpdir/t6_work"
    mkdir -p "$home"
    make_capsule "$workdir"
    local output
    output="$(cd "$workdir" && HOME="$home" "$BINARY" publish 2>&1 || true)"
    echo "$output" | grep -q "no auth token found" \
        || { echo "expected 'no auth token found', got: $output"; return 1; }
}

# ---- Test 7: digest in payload has sha256: prefix ----
test_publish_digest_format() {
    local home="$tmpdir/t7"
    local workdir="$tmpdir/t7_work"
    mkdir -p "$home/.sfn"
    echo "fake-token" > "$home/.sfn/credentials"
    make_capsule "$workdir"
    # Run publish — it will build the JSON payload then fail at curl.
    # Inspect the payload temp file before cleanup by racing it.
    # Safer approach: just check that /tmp/.sfn_publish_body_tmp was written
    # with the correct digest prefix by pausing curl with a bogus URL.
    #
    # We override the registry URL by pointing curl at localhost:0 which
    # will fail fast but the body file is written before curl runs.
    # Actually, the body file is cleaned up after curl. Instead, copy it
    # in a wrapper.
    #
    # Simplest: build the payload ourselves and verify the format.
    (cd "$workdir" && HOME="$home" "$BINARY" publish 2>&1 || true)
    # The temp files are cleaned up, so instead we reconstruct and verify
    # the digest computation matches what the code would produce.
    local payload_content
    payload_content="SFNPKG/1
--- path: capsule.toml
$(cat "$workdir/capsule.toml")
--- path: src/mod.sfn
$(cat "$workdir/src/mod.sfn")
"
    local expected_hex
    expected_hex="$(printf '%s' "$payload_content" | _sha256 | cut -d' ' -f1)"
    local expected_digest="sha256:$expected_hex"

    # Now verify the format by checking what the binary would produce.
    # Write the same payload to a temp file and confirm sha256 output.
    local verify_tmp="$tmpdir/t7_verify"
    printf '%s' "$payload_content" > "$verify_tmp"
    local actual_hex
    actual_hex="$(_sha256 "$verify_tmp" | cut -d' ' -f1)"
    [ "$actual_hex" = "$expected_hex" ] \
        || { echo "digest hex mismatch: expected $expected_hex, got $actual_hex"; return 1; }
    # The key assertion: the code prepends "sha256:" — we can verify this by
    # intercepting the body file. Use a shim that copies it before cleanup.
    local shim_dir="$tmpdir/t7_shim"
    local captured_body="$tmpdir/t7_body"
    mkdir -p "$shim_dir"
    # Create a curl shim that captures the body file before the real curl runs
    cat > "$shim_dir/curl" <<'SHIM'
#!/usr/bin/env bash
# Extract -d @<path> argument and copy the body
for i in "${!args[@]}"; do : ; done
body_file=""
for arg in "$@"; do
    if [[ "$arg" == @* ]]; then
        body_file="${arg#@}"
        break
    fi
done
if [ -n "$body_file" ] && [ -f "$body_file" ]; then
    cp "$body_file" "${CAPTURE_BODY_TO}"
fi
# Fail so publish doesn't actually succeed
exit 1
SHIM
    chmod +x "$shim_dir/curl"
    CAPTURE_BODY_TO="$captured_body" PATH="$shim_dir:$PATH" \
        HOME="$home" "$BINARY" publish "$workdir" 2>&1 || true
    if [ ! -f "$captured_body" ]; then
        echo "curl shim did not capture request body"
        return 1
    fi
    # Check digest field in the JSON payload
    if ! grep -qo '"digest":"sha256:[0-9a-f]\{64\}"' "$captured_body"; then
        local got
        got="$(grep -o '"digest":"[^"]*"' "$captured_body" || echo '<not found>')"
        echo "expected digest with sha256: prefix, got: $got"
        return 1
    fi
}

# ---- Test 8: SFNPKG paths are relative even with path arg ----
test_publish_relative_paths_in_payload() {
    local home="$tmpdir/t8"
    local workdir="$tmpdir/t8_work"
    mkdir -p "$home/.sfn"
    echo "fake-token" > "$home/.sfn/credentials"
    make_capsule "$workdir/nested/cap"

    local shim_dir="$tmpdir/t8_shim"
    local captured_body="$tmpdir/t8_body"
    mkdir -p "$shim_dir"
    cat > "$shim_dir/curl" <<'SHIM'
#!/usr/bin/env bash
body_file=""
for arg in "$@"; do
    if [[ "$arg" == @* ]]; then
        body_file="${arg#@}"
        break
    fi
done
if [ -n "$body_file" ] && [ -f "$body_file" ]; then
    cp "$body_file" "${CAPTURE_BODY_TO}"
fi
exit 1
SHIM
    chmod +x "$shim_dir/curl"
    CAPTURE_BODY_TO="$captured_body" PATH="$shim_dir:$PATH" \
        HOME="$home" "$BINARY" publish "$workdir/nested/cap" 2>&1 || true

    if [ ! -f "$captured_body" ]; then
        echo "curl shim did not capture request body"
        return 1
    fi
    # Decode content_b64 from the JSON and check paths are relative
    local content_b64
    content_b64="$(grep -o '"content_b64":"[^"]*"' "$captured_body" \
        | sed 's/"content_b64":"//;s/"$//')"
    local decoded
    decoded="$(echo "$content_b64" | _b64decode)"
    # Should contain "--- path: src/mod.sfn", not the absolute/prefixed path
    echo "$decoded" | grep -q "^--- path: src/mod.sfn" \
        || { echo "expected relative path 'src/mod.sfn' in SFNPKG, got:"; echo "$decoded" | grep "^--- path:"; return 1; }
    # Should NOT contain the workdir prefix in any path entry
    if echo "$decoded" | grep "^--- path:.*nested/cap"; then
        echo "SFNPKG contains absolute/prefixed path — should be relative"
        return 1
    fi
}

# ---- Test 9: publish surfaces HTTP error details ----
test_publish_surfaces_http_error() {
    local home="$tmpdir/t9"
    local workdir="$tmpdir/t9_work"
    mkdir -p "$home/.sfn"
    echo "fake-token" > "$home/.sfn/credentials"
    make_capsule "$workdir"

    local shim_dir="$tmpdir/t9_shim"
    mkdir -p "$shim_dir"
    # Create a curl shim that writes a 400 response body and header
    cat > "$shim_dir/curl" <<'SHIM'
#!/usr/bin/env bash
# Parse -o and -D flags to write response body and headers
out_file=""
hdr_file=""
prev=""
for arg in "$@"; do
    if [ "$prev" = "-o" ]; then out_file="$arg"; fi
    if [ "$prev" = "-D" ]; then hdr_file="$arg"; fi
    prev="$arg"
done
if [ -n "$out_file" ]; then
    echo '{"error":"Digest mismatch: expected sha256:abc, got sha256:def"}' > "$out_file"
fi
if [ -n "$hdr_file" ]; then
    printf 'HTTP/1.1 400 Bad Request\r\nContent-Type: application/json\r\n\r\n' > "$hdr_file"
fi
exit 0
SHIM
    chmod +x "$shim_dir/curl"
    local output
    output="$(cd "$workdir" && PATH="$shim_dir:$PATH" HOME="$home" "$BINARY" publish 2>&1 || true)"
    echo "$output" | grep -q "HTTP 400" \
        || { echo "expected 'HTTP 400' in output, got: $output"; return 1; }
    echo "$output" | grep -q "Digest mismatch" \
        || { echo "expected 'Digest mismatch' in server error, got: $output"; return 1; }
}

run_test "publish too many args shows usage" test_publish_too_many_args
run_test "publish with no capsule.toml fails" test_publish_no_capsule_toml
run_test "publish with path arg finds capsule" test_publish_path_finds_capsule
run_test "publish with trailing slash works" test_publish_trailing_slash
run_test "publish without path uses cwd" test_publish_cwd
run_test "publish with no token fails" test_publish_no_token
run_test "publish digest has sha256: prefix" test_publish_digest_format
run_test "publish paths are relative with path arg" test_publish_relative_paths_in_payload
run_test "publish surfaces HTTP error details" test_publish_surfaces_http_error

echo ""
echo "publish tests: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
