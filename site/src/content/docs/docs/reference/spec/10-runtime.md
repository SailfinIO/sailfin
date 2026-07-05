---
title: "§10 Runtime"
description: "Sailfin language specification — Runtime."
sidebar:
  order: 10
  label: "§10 Runtime"
---

**Output**:
- `print(value) ![io]` — write to stdout
- `print.err(value) ![io]` — write to stderr
- `print.info/warn/error` — deprecated; use `print()` and `print.err()`

**Filesystem** (require `![io]`):
`fs.read(path)`, `fs.write(path, content)`, `fs.appendFile(path, content)`,
`fs.exists(path)`, `fs.writeLines(path, lines)`

**HTTP client** (prelude, require `![net]`):
`http.get(url)`, `http.post(url, body)` — return a `Response { body, status }`.

**HTTP server + wire layer** (via `sfn/http` capsule, require `![net, io]`):
`serve(handler, port)`, `response(body)`, `response_with_status(status, body)`,
`json_response(body)`, `not_found()`, `parse_request(raw)`, `serialize_response(rsp)`,
`header(req, name)`, `query_param(req, name)`, `reason_phrase(status)`.
See [Standard Library — `sfn/http` capsule](/docs/reference/standard-library#sfnhttp-capsule) for full signatures.

**WebSocket (v0, `ws://` only, require `![net]`)**:
`websocket.connect(url)`, `websocket.send(handle, msg)`, `websocket.close(handle)` —
a client that opens a connection, sends one masked TEXT frame at a
time, and closes it. `websocket.send` additionally requires `![io]` (the
effect checker's conservative, receiver-agnostic `.send(...)` rule, shared
with `channel.send`, applies here too). `websocket.serve(port)` binds/
listens/accepts and runs a single-connection, blocking RFC 6455 echo server
(bind → handshake → echo TEXT/BINARY frames back unmasked → reply to CLOSE).
Neither half handles fragmentation or ping/pong, and there is no `wss://`/TLS
or client-side receive yet — see [Standard Library — `websocket` module](/docs/reference/standard-library#websocket-module)
for the full v0 scope and follow-ups.

**Logging** (via `sfn/log` capsule, require `![io]`):
`log.info(msg)`, `log.warn(msg)`, `log.error(msg)`, `log.debug(msg)`
`log.warn` and `log.error` write to stderr.

**String utilities** (from `runtime/prelude`):
`substring(text, start, end)`, `find_char(text, char, start?)`,
`grapheme_count(text)`, `grapheme_at(text, index)`, `char_code(char)`

See [Standard Library](/docs/reference/standard-library) for full signatures.
