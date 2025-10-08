# Web & Network Examples

Demonstrates server construction, REST-style routing, WebSockets, and async fetching patterns. These align with planned `net` / `http` capabilities and effect tracking (`![net,io]`).

## Files

- **`http-server.sfn`** – Minimal HTTP server responding to root and fallback paths.
- **`rest-api.sfn`** – Method-based request dispatch using a `match` on `req.method`.
- **`async.sfn`** – Simple async fetch pattern encapsulating `await`.
- **`fetch-data.sfn`** – External HTTP GET with lightweight status handling.
- **`websocket-chat.sfn`** – Broadcast / echo style WebSocket server with client iteration.

## Notes

- Networking helpers (`serve`, `http.get`, `websocket.serve`) are placeholders; real implementations will enforce `net` effects and capability manifests.
- Combine these patterns with channels (see `concurrency/`) for backpressure-aware streaming pipelines.
