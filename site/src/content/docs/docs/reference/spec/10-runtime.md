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

**Logging** (via `sfn/log` capsule, require `![io]`):
`log.info(msg)`, `log.warn(msg)`, `log.error(msg)`, `log.debug(msg)`
`log.warn` and `log.error` write to stderr.

**String utilities** (from `runtime/prelude`):
`substring(text, start, end)`, `find_char(text, char, start?)`,
`grapheme_count(text)`, `grapheme_at(text, index)`, `char_code(char)`

See [Standard Library](/docs/reference/standard-library) for full signatures.
