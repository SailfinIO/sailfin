# Shared test-support modules

Where a helper shared by several `*_test.sfn` files lives, and why it is safe
to put it under a `tests/` directory. Established by SFN-665, which collapsed
54 copy-pasted helper definitions in `capsules/sfn/crypto/tests/` — in four
mutually-incompatible variants — down to one.

---

## The rule

A helper used by more than one test file goes in a **non-`_test.sfn` module
under the same `tests/` tree**, and the tests import it by relative path:

```
capsules/<ns>/<capsule>/tests/support/<topic>.sfn   // the shared helper
capsules/<ns>/<capsule>/tests/<area>_test.sfn       // import { h } from "./support/<topic>";
```

Use `support/` for helpers (code the assertions call) and `fixtures/` for data
or modules a test compiles and runs as a subject — `compiler/tests/e2e/fixtures/`
is the existing example of the latter.

Do **not** solve the duplication by moving a test helper onto the capsule's
shipped API surface. A test helper and a production function with a similar
name usually have different contracts: `sfn/crypto`'s `eq_bytes` is a plain
comparison for assertions, while `src/bits.sfn`'s `ct_eq_bytes` is
constant-time-hardened for secrets. Putting the naive one next to the hardened
one on the exported surface invites the wrong call site.

## Why a non-test file under `tests/` is safe

The runner's target collector selects files by filename suffix alone —
`_looks_like_test_file_cmd` in
`compiler/src/cli/commands/test/discovery.sfn` returns
`_ends_with_cmd(name, "_test.sfn")`. A file that does not end in `_test.sfn` is
skipped by the walk: it is never collected as a target and never run on its
own. It enters a build only when a test file imports it, at which point the
resolver pulls it in as an ordinary dependency module.

Import closure still applies — see
[`unit-test-import-envelope.md`](./unit-test-import-envelope.md). Keep a
support module's own imports light; a helper that drags a heavy closure onto
every test that touches it is worse than the duplication it replaced.

## Normalise the contract when you collapse copies

Copies drift. Deduplicating is the moment to pick the behaviour deliberately
rather than keeping whichever variant is most numerous — the majority is just
the one that got copied most, not the one that is most correct. Prefer the
fail-closed reading, and state the contract in a comment on the surviving
function: what it accepts, what it does with malformed input, and whether it
returns or traps. SFN-665's `hexb` is the worked example — it accepts both
cases, returns `[]` (never a partial decode) for odd-length or non-hex input,
and says so in its header.

Cover the normalised edges with a test. The point of collapsing to one
definition is that a future copy cannot silently reintroduce a weaker
contract, and only a test enforces that.
