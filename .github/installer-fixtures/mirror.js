// Static file server for the offline installer fixtures (SFN-1034).
//
// The fixtures need a release mirror whose contents can be mutated -- a
// removed SHA256SUMS, a flipped signature byte, a tampered archive -- so that
// `install.sh` and `install.ps1` can be driven through every fail-closed
// branch without a network or a test signing key. `SAILFIN_RELEASE_BASE`
// points at this server; it changes only WHERE bytes come from, never what is
// verified, so a fixture cannot accidentally weaken the thing under test.
//
// Deliberately not a signing oracle: the mirror is seeded from a REAL
// published release, so the happy path exercises the real production key and
// the negative paths are mutations of genuinely valid material. There is no
// test keypair to leak, rotate, or diverge from the trust anchor.
//
// Node rather than python3: it is present on every GitHub runner image for all
// three operating systems this job matrixes over, and the repo does not carry
// a Python dependency.
//
// Usage: node mirror.js <root-dir> <port>
// Serves <root-dir>/<path> for GET, 404 for anything missing or escaping root.

const http = require("http");
const fs = require("fs");
const path = require("path");

const root = path.resolve(process.argv[2]);
const port = Number(process.argv[3]);

if (!root || !Number.isInteger(port)) {
  console.error("usage: node mirror.js <root-dir> <port>");
  process.exit(2);
}

const server = http.createServer((req, res) => {
  const rel = decodeURIComponent((req.url || "/").split("?")[0]);
  const target = path.resolve(path.join(root, rel));

  // Containment check before any stat: a fixture path is attacker-shaped by
  // construction (it comes from a URL), and this process runs beside the real
  // checkout on the runner.
  if (target !== root && !target.startsWith(root + path.sep)) {
    res.writeHead(404).end("not found");
    return;
  }
  if (!fs.existsSync(target) || !fs.statSync(target).isFile()) {
    res.writeHead(404).end("not found");
    return;
  }

  const body = fs.readFileSync(target);
  res.writeHead(200, {
    "Content-Length": body.length,
    "Content-Type": "application/octet-stream",
  });
  res.end(body);
});

server.listen(port, "127.0.0.1", () => {
  console.log(`mirror listening on 127.0.0.1:${port} serving ${root}`);
});
