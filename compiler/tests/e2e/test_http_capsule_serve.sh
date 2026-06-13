#!/usr/bin/env bash
# End-to-end test for the typed sfn/http `serve` (Wave 2, epic #1321,
# issue #1323). Exercises the capsule's `serve(handler: * fn (Request) ->
# Response, port)` on top of the runtime `sfn_serve_framed` accept loop.
#
# The consumer is a real capsule that declares `[dependencies]
# "sfn/http" = "*"` and imports `from "sfn/http"` — that is how a capsule's
# functions are staged into a consumer's codegen (a loose `sfn run file`
# with no manifest does not stage capsule deps). It lives under
# $REPO_ROOT/build/ (gitignored) so workspace discovery finds the repo
# workspace.toml.
#
# Two checks:
#   1. GATE (static, via emit): the imported `serve` must NOT lower to the
#      builtin `@sfn_serve` — it must call the capsule function
#      `@serve__sfn__http__mod` (which calls `@sfn_serve_framed`). The bare
#      builtin `serve` (no import) is covered by test_runtime_serve.sh and
#      must stay green.
#   2. BEHAVIORAL (loopback): the handler's typed `Response.status` and
#      `Response.headers` reach the wire — the whole point of the framed
#      path (plain `sfn_serve` always frames 200 OK).
#
# Usage:
#   compiler/tests/e2e/test_http_capsule_serve.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_http_capsule_serve.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"

# Generated sources must sit inside the repo tree so discover_workspace_root
# finds workspace.toml and resolves the `sfn/http` dependency.
SCRATCH="$(mktemp -d "$REPO_ROOT/build/sfn-http-e2e-XXXXXX")"
APP="$SCRATCH/app"
SERVER_PID=""
cleanup() {
    if [ -n "$SERVER_PID" ]; then
        kill "$SERVER_PID" 2>/dev/null || true
        wait "$SERVER_PID" 2>/dev/null || true
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

# Lay out a consumer capsule that depends on sfn/http and serves a custom
# 403 + header for /secret, 404 otherwise. $1 = listening port.
write_app() {
    local port="$1"
    mkdir -p "$APP/src"
    cat > "$APP/capsule.toml" <<TOML
[capsule]
name = "sfn/http-e2e-app"
version = "0.0.1"
description = "sfn/http serve e2e consumer"

[dependencies]
"sfn/http" = "*"

[capabilities]
required = ["io", "net"]

[build]
entry = "src/main.sfn"
kind = "library"
TOML
    cat > "$APP/src/main.sfn" <<SFN
import { serve, Request, Response, not_found } from "sfn/http";

fn handle(req: Request) -> Response {
    if strings_equal(req.path, "/secret") {
        return Response { status: 403, headers: ["X-Reason: nope"], body: "denied" };
    }
    // Echo the drained request body back (Wave 3 / #1324): proves the
    // runtime drains the Content-Length body before the handler runs.
    if strings_equal(req.path, "/echo") {
        return Response { status: 200, headers: ["X-Echo: 1"], body: req.body };
    }
    return not_found();
}

fn main() -> int ![net, io] {
    serve(handle as * fn (Request) -> Response, ${port});
    return 0;
}
SFN
}

# ---- Test: imported serve lowers to the capsule fn, not the builtin ----
test_gate_not_hijacked() {
    write_app 8080
    local ll="$SCRATCH/main.ll"
    local log="$SCRATCH/emit.log"
    if ! "$BINARY" emit -o "$ll" llvm "$APP/src/main.sfn" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on the consumer entry:"
        cat "$log"
        return 1
    fi
    local bad=0
    # The builtin bespoke lowering must NOT fire for the imported serve.
    if grep -qE "call void @sfn_serve\(" "$ll"; then
        echo "[test]   imported serve was hijacked to the builtin @sfn_serve (gate failed)"
        bad=$((bad + 1))
    fi
    # The call must target the imported capsule serve.
    if ! grep -qE "call void @serve__sfn__http" "$ll"; then
        echo "[test]   expected a call to the capsule serve (@serve__sfn__http...), not found"
        bad=$((bad + 1))
    fi
    return "$bad"
}

# ---- Behavioral: custom status + header reach the wire via the framed path ----
test_loopback_status_and_headers() {
    local port
    port="$(python3 - <<'PYEOF'
import socket
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind(("127.0.0.1", 0))
print(s.getsockname()[1])
s.close()
PYEOF
)"
    if [ -z "$port" ]; then
        echo "[test]   could not allocate a free port"
        return 1
    fi

    write_app "$port"
    local srvlog="$SCRATCH/server.out"
    "$BINARY" run "$APP/src/main.sfn" > "$srvlog" 2>&1 &
    SERVER_PID=$!

    local client="$SCRATCH/client.py"
    cat > "$client" <<PYEOF
import socket, sys, time
port = ${port}
deadline = time.time() + 25
data = None
while time.time() < deadline:
    try:
        c = socket.create_connection(("127.0.0.1", port), timeout=2)
    except OSError:
        time.sleep(0.3)
        continue
    try:
        c.sendall(b"GET /secret HTTP/1.1\r\nHost: localhost\r\nConnection: close\r\n\r\n")
        buf = b""
        while True:
            chunk = c.recv(4096)
            if not chunk:
                break
            buf += chunk
    finally:
        c.close()
    data = buf
    break
if data is None:
    print("NO_RESPONSE", flush=True)
    sys.exit(1)
sys.stdout.write(data.decode("utf-8", "replace"))
sys.stdout.flush()
PYEOF

    local out="$SCRATCH/client.out"
    if ! python3 "$client" > "$out" 2>&1; then
        echo "[test]   client never reached the server:"
        cat "$out"
        echo "[test]   --- server log ---"
        cat "$srvlog"
        return 1
    fi

    local bad=0
    if ! grep -qE "^HTTP/1\.1 403 Forbidden" "$out"; then
        echo "[test]   expected status line 'HTTP/1.1 403 Forbidden', got:"
        cat "$out"
        bad=$((bad + 1))
    fi
    if ! grep -qE "^X-Reason: nope" "$out"; then
        echo "[test]   expected header 'X-Reason: nope' in the response, got:"
        cat "$out"
        bad=$((bad + 1))
    fi
    if ! grep -q "denied" "$out"; then
        echo "[test]   expected body 'denied' in the response, got:"
        cat "$out"
        bad=$((bad + 1))
    fi
    if [ "$bad" -ne 0 ]; then
        echo "[test]   --- server log ---"
        cat "$srvlog"
    fi
    return "$bad"
}

# ---- Behavioral: a POST Content-Length body is drained and reaches req.body ----
# Wave 3 / #1324: the runtime drains the Content-Length body after the
# header terminator, so a POST handler can read it via `req.body`. We
# POST a non-trivial body to /echo and assert it round-trips verbatim.
test_loopback_post_body() {
    # The framed server never returns (one server per process), so start
    # a fresh instance for this case and retire any prior one.
    if [ -n "$SERVER_PID" ]; then
        kill "$SERVER_PID" 2>/dev/null || true
        wait "$SERVER_PID" 2>/dev/null || true
        SERVER_PID=""
    fi

    local port
    port="$(python3 - <<'PYEOF'
import socket
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind(("127.0.0.1", 0))
print(s.getsockname()[1])
s.close()
PYEOF
)"
    if [ -z "$port" ]; then
        echo "[test]   could not allocate a free port"
        return 1
    fi

    write_app "$port"
    local srvlog="$SCRATCH/server_post.out"
    "$BINARY" run "$APP/src/main.sfn" > "$srvlog" 2>&1 &
    SERVER_PID=$!

    local client="$SCRATCH/client_post.py"
    cat > "$client" <<PYEOF
import socket, sys, time
port = ${port}
# A body bigger than one TCP segment is convenient to exercise the
# drain loop, but correctness only needs an exact Content-Length match.
body = ("payload-" * 64) + "END"
raw = (
    "POST /echo HTTP/1.1\r\n"
    "Host: localhost\r\n"
    "Content-Length: %d\r\n"
    "Connection: close\r\n"
    "\r\n" % len(body.encode())
) + body
deadline = time.time() + 25
data = None
while time.time() < deadline:
    try:
        c = socket.create_connection(("127.0.0.1", port), timeout=2)
    except OSError:
        time.sleep(0.3)
        continue
    try:
        c.sendall(raw.encode())
        buf = b""
        while True:
            chunk = c.recv(4096)
            if not chunk:
                break
            buf += chunk
    finally:
        c.close()
    data = buf
    break
if data is None:
    print("NO_RESPONSE", flush=True)
    sys.exit(1)
sys.stdout.write(data.decode("utf-8", "replace"))
sys.stdout.flush()
PYEOF

    local out="$SCRATCH/client_post.out"
    if ! python3 "$client" > "$out" 2>&1; then
        echo "[test]   POST client never reached the server:"
        cat "$out"
        echo "[test]   --- server log ---"
        cat "$srvlog"
        return 1
    fi

    local bad=0
    if ! grep -qE "^HTTP/1\.1 200 OK" "$out"; then
        echo "[test]   expected '200 OK' for POST /echo, got:"
        cat "$out"
        bad=$((bad + 1))
    fi
    if ! grep -qE "^X-Echo: 1" "$out"; then
        echo "[test]   expected header 'X-Echo: 1', got:"
        cat "$out"
        bad=$((bad + 1))
    fi
    # The echoed body must contain the start and end markers of what we
    # sent — proof the full Content-Length body was drained, not truncated.
    if ! grep -q "payload-payload-" "$out" || ! grep -q "END" "$out"; then
        echo "[test]   echoed body did not round-trip the POST payload, got:"
        cat "$out"
        bad=$((bad + 1))
    fi
    if [ "$bad" -ne 0 ]; then
        echo "[test]   --- server log ---"
        cat "$srvlog"
    fi
    return "$bad"
}

# ---- Behavioral: an over-cap Content-Length is rejected with a 500, not a hang ----
# Wave 3 / #1324: bodies over the 1 MiB cap are rejected up front (the
# runtime returns null → the worker frames a 500 and closes) rather than
# allocating unboundedly or blocking on recv.
test_loopback_oversize_rejected() {
    if [ -n "$SERVER_PID" ]; then
        kill "$SERVER_PID" 2>/dev/null || true
        wait "$SERVER_PID" 2>/dev/null || true
        SERVER_PID=""
    fi

    local port
    port="$(python3 - <<'PYEOF'
import socket
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind(("127.0.0.1", 0))
print(s.getsockname()[1])
s.close()
PYEOF
)"
    if [ -z "$port" ]; then
        echo "[test]   could not allocate a free port"
        return 1
    fi

    write_app "$port"
    local srvlog="$SCRATCH/server_big.out"
    "$BINARY" run "$APP/src/main.sfn" > "$srvlog" 2>&1 &
    SERVER_PID=$!

    local client="$SCRATCH/client_big.py"
    cat > "$client" <<PYEOF
import socket, sys, time
port = ${port}
# Declare a 2 MiB body (over the 1 MiB cap) but send only the header —
# the server must reject on the declared length without waiting for the
# body, so a tiny partial send is enough to read back the 500.
header = (
    "POST /echo HTTP/1.1\r\n"
    "Host: localhost\r\n"
    "Content-Length: 2000000\r\n"
    "Connection: close\r\n"
    "\r\n"
).encode()
deadline = time.time() + 25
data = None
while time.time() < deadline:
    try:
        c = socket.create_connection(("127.0.0.1", port), timeout=2)
    except OSError:
        time.sleep(0.3)
        continue
    try:
        try:
            c.sendall(header + b"partial-body")
        except (BrokenPipeError, ConnectionResetError):
            pass
        buf = b""
        try:
            while True:
                chunk = c.recv(4096)
                if not chunk:
                    break
                buf += chunk
        except (ConnectionResetError, socket.timeout):
            pass
    finally:
        c.close()
    data = buf
    break
if data is None:
    print("NO_RESPONSE", flush=True)
    sys.exit(1)
sys.stdout.write(data.decode("utf-8", "replace"))
sys.stdout.flush()
PYEOF

    local out="$SCRATCH/client_big.out"
    if ! python3 "$client" > "$out" 2>&1; then
        echo "[test]   over-cap client never reached the server:"
        cat "$out"
        echo "[test]   --- server log ---"
        cat "$srvlog"
        return 1
    fi

    if ! grep -qE "^HTTP/1\.1 500" "$out"; then
        echo "[test]   expected a 500 for an over-cap Content-Length, got:"
        cat "$out"
        echo "[test]   --- server log ---"
        cat "$srvlog"
        return 1
    fi
    return 0
}

run_test "imported serve lowers to the capsule fn, not the builtin @sfn_serve" test_gate_not_hijacked
run_test "typed serve delivers custom status + headers on the wire" test_loopback_status_and_headers
run_test "POST Content-Length body is drained and reaches req.body" test_loopback_post_body
run_test "over-cap Content-Length is rejected with a 500" test_loopback_oversize_rejected

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
