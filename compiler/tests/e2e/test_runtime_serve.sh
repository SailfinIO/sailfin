#!/usr/bin/env bash
# End-to-end test for runtime/sfn/concurrency/serve.sfn — the
# Sailfin-native `serve` HTTP/1.1 server (M4 #1092, epic #965).
# Replaces the no-op C stub / never-defined sailfin_adapter_serve_*
# symbols with a real blocking accept-loop that dispatches each
# connection to the M4.1 thread pool (HTTP only, no TLS, no async).
#
# Mirrors test_runtime_adapter_http.sh's structure, inverted to the
# server side: typecheck + fmt + emit-shape on the source module, an
# IR routing probe that `serve(handler, port)` lowers to `@sfn_serve`
# (not the legacy `@sailfin_adapter_serve_start`), and a behavioral
# loopback round-trip — a real HTTP request from a Python client
# against an in-process Sailfin server through the `sfn run` link
# path.
#
# Usage:
#   compiler/tests/e2e/test_runtime_serve.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_runtime_serve.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
MODULE="$REPO_ROOT/runtime/sfn/concurrency/serve.sfn"

SCRATCH="$(mktemp -d -t sfn-runtime-serve-XXXXXX)"
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

# ---- Test: source module typechecks cleanly ----
test_check_clean() {
    local log="$SCRATCH/check.log"
    if ! "$BINARY" check "$MODULE" > "$log" 2>&1; then
        echo "[test]   sfn check exited non-zero on serve.sfn:"
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

# ---- Test: emitted IR carries a `define` for the serve exports ----
test_emit_define_shape() {
    local ll="$SCRATCH/serve.ll"
    local log="$SCRATCH/emit.log"
    if ! "$BINARY" emit -o "$ll" llvm "$MODULE" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on runtime/sfn/concurrency/serve.sfn:"
        cat "$log"
        return 1
    fi
    local missing=0
    for sym in sfn_serve sfn_serve_handler_dispatch; do
        if ! grep -qE "^define .* @${sym}\(" "$ll"; then
            echo "[test]   missing 'define ... @${sym}(' in serve.ll"
            missing=$((missing + 1))
        fi
    done
    # The BSD-sockets server surface must lower to libc declares.
    for sym in socket bind listen accept send recv close; do
        if ! grep -qE "^declare .* @${sym}\(" "$ll"; then
            echo "[test]   missing 'declare ... @${sym}(' in serve.ll"
            missing=$((missing + 1))
        fi
    done
    # The pool-dispatch path must reference the scheduler externs.
    for sym in sfn_taskqueue_create sfn_task_create sfn_taskqueue_enqueue sfn_scheduler_create; do
        if ! grep -qE "@${sym}\(" "$ll"; then
            echo "[test]   missing reference to @${sym}( in serve.ll"
            missing=$((missing + 1))
        fi
    done
    return "$missing"
}

# ---- Test: compiled probe routes serve(handler, port) → @sfn_serve ----
test_probe_flipped() {
    local probe="$SCRATCH/serve_probe.sfn"
    cat > "$probe" <<'PROBE'
fn handle(req: string) -> string {
    return "ok";
}

fn main() -> int ![net, io] {
    serve(handle, 8080);
    return 0;
}
PROBE
    local ll="$SCRATCH/serve_probe.ll"
    local log="$SCRATCH/serve_probe.log"
    if ! "$BINARY" emit -o "$ll" llvm "$probe" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on serve_probe.sfn:"
        cat "$log"
        return 1
    fi
    local missing=0
    # Anchor on a non-identifier follow char (portable across GNU/BSD
    # grep — see the http adapter test for the `\b` caveat).
    if ! grep -qE "call void @sfn_serve\(" "$ll"; then
        echo "[test]   serve_probe.sfn does not lower to a @sfn_serve call"
        missing=$((missing + 1))
    fi
    # Legacy never-defined adapter symbol must not be CALLED anymore.
    if grep -qE "@sailfin_adapter_serve_start\(" "$ll"; then
        echo "[test]   serve_probe.sfn still references @sailfin_adapter_serve_start (expected the #1092 flip)"
        missing=$((missing + 1))
    fi
    return "$missing"
}

# ---- Behavioral: HTTP loopback round-trip against an in-process server ----
#
# Picks a free TCP port, starts a Sailfin `serve(handler, port)`
# program in the background (the handler returns a fixed body), waits
# for it to listen, then drives a Python HTTP/1.1 client through one
# request and asserts the handler's body comes back. Exercises the
# full server stack — bind / listen / accept / pool dispatch /
# handler call / response framing — end to end.
test_loopback_round_trip() {
    # Find a free port: bind to 0, read it back, release it. A brief
    # TOCTOU window before the Sailfin server rebinds it is tolerable
    # on a quiet runner (the http adapter test uses the same idiom).
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

    local server="$SCRATCH/server.sfn"
    cat > "$server" <<PROBE
fn handle(req: string) -> string {
    return "HELLO_FROM_SERVE";
}

fn main() -> int ![net, io] {
    serve(handle, ${port});
    return 0;
}
PROBE

    local srvlog="$SCRATCH/server.out"
    "$BINARY" run "$server" > "$srvlog" 2>&1 &
    SERVER_PID=$!

    # Wait until the server is accepting (max ~15s — `sfn run`
    # compiles + links the program before the listen).
    local client="$SCRATCH/client.py"
    cat > "$client" <<PYEOF
import socket, sys, time
port = ${port}
deadline = time.time() + 15
body = None
while time.time() < deadline:
    try:
        c = socket.create_connection(("127.0.0.1", port), timeout=2)
    except OSError:
        time.sleep(0.2)
        continue
    try:
        c.sendall(b"GET / HTTP/1.1\r\nHost: localhost\r\nConnection: close\r\n\r\n")
        data = b""
        while True:
            chunk = c.recv(4096)
            if not chunk:
                break
            data += chunk
    finally:
        c.close()
    head, _, payload = data.partition(b"\r\n\r\n")
    body = payload
    break
if body is None:
    print("NO_RESPONSE", flush=True)
    sys.exit(1)
sys.stdout.write(body.decode("utf-8", "replace"))
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
    if ! grep -q "HELLO_FROM_SERVE" "$out"; then
        echo "[test]   expected 'HELLO_FROM_SERVE' in the response body, got:"
        cat "$out"
        echo "[test]   --- server log ---"
        cat "$srvlog"
        return 1
    fi
    return 0
}

run_test "sfn check runtime/sfn/concurrency/serve.sfn passes" test_check_clean
run_test "sfn fmt --check runtime/sfn/concurrency/serve.sfn is canonical" test_fmt_clean
run_test "sfn emit llvm defines sfn_serve + sfn_serve_handler_dispatch + socket/scheduler refs" test_emit_define_shape
run_test "serve(handler, port) lowers to @sfn_serve (not the legacy adapter symbol)" test_probe_flipped
run_test "HTTP loopback round-trip returns the handler's body" test_loopback_round_trip

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
