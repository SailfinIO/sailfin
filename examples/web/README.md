# Web & Network Examples

Demonstrates server construction, REST-style routing, WebSockets, and async fetching patterns. These align with planned `net` / `http` capabilities and effect tracking (`![net,io]`).

## Files

- **`http-server.sfn`** – Minimal HTTP server responding to root and fallback paths.
- **`static-site.sfn`** – A rendered HTML page plus assets served off disk, with escaping on anything that came from the request.
- **`rest-api.sfn`** – Method-based request dispatch using a `match` on `req.method`.
- **`async.sfn`** – Simple async fetch pattern encapsulating `await`.
- **`fetch-data.sfn`** – External HTTP GET with lightweight status handling.
- **`websocket-chat.sfn`** – Broadcast / echo style WebSocket server with client iteration.

## Notes

- `serve`, `http.get` and `websocket.serve` are real: `sfn/http` ships a
  pure-Sailfin HTTP/1.1 wire layer with a blocking `serve`/`serve_tls`, and
  `![io, net]` is enforced against the capsule's capability manifest. Each
  example still needs a consumer `capsule.toml` declaring
  `"sfn/http" = "*"` — capsule functions are only staged into a consumer's
  codegen through a declared dependency, so a loose `sfn run` of a
  manifest-less file cannot resolve them.
- Combine these patterns with channels (see `concurrency/`) for backpressure-aware streaming pipelines.
