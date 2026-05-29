#!/usr/bin/env bash
# End-to-end test for runtime/sfn/adapters/http.sfn — the
# Sailfin-native HTTP/1.1 socket client adapter (M3 #818, epic
# #390). Replaces the curl-subprocess HTTP path with a pure-Sailfin
# socket client (HTTP only, no TLS for v0).
#
# Mirrors test_runtime_adapter_filesystem.sh's structure: typecheck
# + fmt + emit-shape on the source module, an IR routing probe that
# the flipped `http.get_body` registry row lowers to `@sfn_http_get`
# (not the legacy curl `@sailfin_runtime_http_get`), and a
# behavioral round-trip — a real GET against a localhost listener
# through the `sfn run` link path.
#
# Usage:
#   compiler/tests/e2e/test_runtime_adapter_http.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_runtime_adapter_http.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
MODULE="$REPO_ROOT/runtime/sfn/adapters/http.sfn"

SCRATCH="$(mktemp -d -t sfn-runtime-http-XXXXXX)"
LISTENER_PID=""
cleanup() {
    if [ -n "$LISTENER_PID" ]; then
        kill "$LISTENER_PID" 2>/dev/null || true
        wait "$LISTENER_PID" 2>/dev/null || true
    fi
    rm -rf "$SCRATCH"
}
trap cleanup EXIT

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

# ---- Test: source module typechecks cleanly ----
test_check_clean() {
    local log="$SCRATCH/check.log"
    if ! "$BINARY" check "$MODULE" > "$log" 2>&1; then
        echo "[test]   sfn check exited non-zero on http.sfn:"
        cat "$log"
        return 1
    fi
    if ! grep -q "checked .* ok" "$log"; then
        echo "[test]   sfn check did not report 'ok':"
        cat "$log"
        return 1
    fi
    return 0
}

# ---- Test: source module is fmt-canonical ----
test_fmt_clean() {
    if ! "$BINARY" fmt --check "$MODULE" > /dev/null 2>&1; then
        echo "[test]   $MODULE needs formatting (run: sfn fmt --write $MODULE)"
        return 1
    fi
    return 0
}

# ---- Test: emitted IR carries a `define` for every sfn_http_* export ----
test_emit_define_shape() {
    local ll="$SCRATCH/http.ll"
    local log="$SCRATCH/emit.log"
    if ! "$BINARY" emit -o "$ll" llvm "$MODULE" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on runtime/sfn/adapters/http.sfn:"
        cat "$log"
        return 1
    fi
    local missing=0
    for sym in sfn_http_get sfn_http_post sfn_http_post2 sfn_http_download; do
        if ! grep -qE "^define .* @${sym}\(" "$ll"; then
            echo "[test]   missing 'define ... @${sym}(' in http.ll"
            missing=$((missing + 1))
        fi
    done
    # The BSD-sockets surface must lower to libc declares.
    for sym in socket connect send recv close; do
        if ! grep -qE "^declare .* @${sym}\(" "$ll"; then
            echo "[test]   missing 'declare ... @${sym}(' in http.ll"
            missing=$((missing + 1))
        fi
    done
    return "$missing"
}

# ---- Test: compiled probe routes http.get_body through @sfn_http_get ----
test_probe_flipped() {
    local probe="$SCRATCH/http_probe.sfn"
    cat > "$probe" <<'PROBE'
fn fetch(url: string) -> string ![net] {
    return http.get_body(url);
}

fn main() -> int ![net, io] {
    let body = fetch("http://127.0.0.1:9/");
    print(body);
    return 0;
}
PROBE
    local ll="$SCRATCH/http_probe.ll"
    local log="$SCRATCH/http_probe.log"
    if ! "$BINARY" emit -o "$ll" llvm "$probe" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on http_probe.sfn:"
        cat "$log"
        return 1
    fi
    local missing=0
    # Anchor on a non-identifier follow char (portable across GNU/BSD
    # grep — see the filesystem adapter test for the `\b` caveat).
    if ! grep -qE "@sfn_http_get([^A-Za-z0-9_]|$)" "$ll"; then
        echo "[test]   http_probe.sfn does not reference @sfn_http_get"
        missing=$((missing + 1))
    fi
    # Legacy curl entrypoint must not be CALLED (declares tolerated for
    # seed compat; only call sites are forbidden).
    if grep -qE "call [^\"]*@sailfin_runtime_http_get\(" "$ll"; then
        echo "[test]   http_probe.sfn still calls @sailfin_runtime_http_get (expected the sfn_http_* flip)"
        missing=$((missing + 1))
    fi
    return "$missing"
}

# ---- Behavioral: GET + POST round-trip against a localhost listener ----
#
# Starts a Python TCP listener that loops one-response-per-connection,
# speaking just enough HTTP/1.1 to answer the adapter (echoing POST
# bodies back), then compiles + runs a probe that GETs and POSTs
# through the flipped registry rows. Exercises the full socket stack —
# connect / send / recv / status-check / body-extraction — for both
# `sfn_http_get` and `sfn_http_post`.
test_get_round_trip() {
    local server="$SCRATCH/server.py"
    cat > "$server" <<'PYEOF'
import socket, sys
srv = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
srv.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
# Bind to an ephemeral port (0) and report it — avoids flaky
# collisions with whatever else is live on a shared CI runner.
srv.bind(("127.0.0.1", 0))
srv.listen(4)
srv.settimeout(20)
print("PORT=%d" % srv.getsockname()[1], flush=True)
print("ready", flush=True)
try:
    while True:
        conn, _ = srv.accept()
        data = b""
        while b"\r\n\r\n" not in data:
            chunk = conn.recv(4096)
            if not chunk:
                break
            data += chunk
        head, _, rest = data.partition(b"\r\n\r\n")
        clen = 0
        for line in head.split(b"\r\n"):
            if line.lower().startswith(b"content-length:"):
                clen = int(line.split(b":", 1)[1].strip())
        while len(rest) < clen:
            more = conn.recv(4096)
            if not more:
                break
            rest += more
        if head.startswith(b"POST"):
            body = b"POST_BODY:" + rest
        else:
            body = b"GET_OK"
        resp = b"HTTP/1.1 200 OK\r\nContent-Length: %d\r\nConnection: close\r\n\r\n%s" % (len(body), body)
        conn.sendall(resp)
        conn.close()
except Exception:
    pass
PYEOF
    local ready="$SCRATCH/ready.log"
    python3 "$server" > "$ready" 2>&1 &
    LISTENER_PID=$!

    # Wait for the listener to report ready (max ~5s).
    local waited=0
    while ! grep -q "ready" "$ready" 2>/dev/null; do
        sleep 0.2
        waited=$((waited + 1))
        if [ "$waited" -gt 25 ]; then
            echo "[test]   listener never reported ready:"
            cat "$ready"
            return 1
        fi
    done

    local port
    port="$(grep -oE 'PORT=[0-9]+' "$ready" | head -1 | cut -d= -f2)"
    if [ -z "$port" ]; then
        echo "[test]   listener did not report a port:"
        cat "$ready"
        return 1
    fi

    local probe="$SCRATCH/get_probe.sfn"
    cat > "$probe" <<PROBE
fn main() -> int ![net, io] {
    let body = http.get_body("http://127.0.0.1:${port}/hello");
    print(body);
    let posted = http.post_json("http://127.0.0.1:${port}/echo", "{\"k\":\"v\"}", "");
    print(posted);
    return 0;
}
PROBE
    local out="$SCRATCH/get_probe.out"
    if ! "$BINARY" run "$probe" > "$out" 2>&1; then
        echo "[test]   sfn run get_probe.sfn failed:"
        cat "$out"
        return 1
    fi
    if ! grep -q "GET_OK" "$out"; then
        echo "[test]   expected 'GET_OK' in the GET response body, got:"
        cat "$out"
        return 1
    fi
    # The listener echoes the POST body back as POST_BODY:<body>.
    if ! grep -q 'POST_BODY:{"k":"v"}' "$out"; then
        echo "[test]   expected 'POST_BODY:{\"k\":\"v\"}' in the POST response body, got:"
        cat "$out"
        return 1
    fi
    return 0
}

run_test "sfn check runtime/sfn/adapters/http.sfn passes" test_check_clean
run_test "sfn fmt --check runtime/sfn/adapters/http.sfn is canonical" test_fmt_clean
run_test "sfn emit llvm defines every sfn_http_* export + socket declares" test_emit_define_shape
run_test "http.get_body lowers to @sfn_http_get (not the curl path)" test_probe_flipped
run_test "GET + POST round-trip against a localhost listener returns the body" test_get_round_trip

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
