# `tools/repo-tooling`

Repo-internal Sailfin tooling. **Not published, not installed, not part of the
shipped toolchain.** Design: [SFEP-0074](../../docs/proposals/0074-repo-tooling-ownership.md)
§3 Tier 2, §4, §8.3.

## What belongs here

SFEP-0074 splits repository logic three ways. This capsule is Tier 2: work that
is Sailfin-appropriate but is **not a compiler concern** — release publication,
manifest signing, GitHub/Linear API glue. Shipping that in the compiler binary
would put credential handling and label reconciliation in every end user's
toolchain.

The other two tiers are not here. Logic *about* the compiler, the workspace, or
the build is an `sfn dev <verb>` (Tier 1). Logic that must run before any `sfn`
binary exists on the host is shell (Tier 3), and owes a pure-decision seam so
its decisions are testable from `sfn test`.

## Why it is built from source

SFEP-0074 §4 rejected publishing this as a binary CI pulls. A capability that
lands in a different PR from its consumer cannot be exercised until it reaches
the pinned version — the seed-cut tax that
[`.claude/rules/seed-dependency.md`](../../.claude/rules/seed-dependency.md)
documents. Pulling repo tooling as a published binary rebuilds that tax
voluntarily: a PR changing release verification could not test its own change.

Building from the seed already on the runner costs build time and buys the one
property whose absence created `scripts/` in the first place — repo tooling is
testable in the PR that changes it.

```
# The CI shape: the seed is already on disk at this point.
build/toolchains/seed/versions/<version>/sfn build -p tools/repo-tooling -o <out>
```

## Why it cannot be published

Three independent mechanisms, none of them redundant:

| Mechanism | Where |
|---|---|
| `[capsule] publish = false` → `sfn publish` exits `E0612` before credential discovery | `compiler/src/cli/commands/publish.sfn:108` |
| `[build] kind = "binary"` fails the `kind == "library"` half of the public-member predicate | `scripts/module_layout_fingerprint.sh:244` |
| the release workflow's path filter watches `capsules/**` and `stdlib/**`, never `tools/**` | `.github/workflows/capsule-release.yml:6` |

The capsule name is deliberately outside the `sfn/` scope. Placing it in
`capsules/sfn/*` would name repo-internal automation `sfn/<something>` and read
as a shipped capsule; `tools/` already means "not the compiler".

## The seams

A Tier 2 leaf builds on these rather than re-inventing them. Each keeps its
decision logic pure, so the interesting half is testable with no `![io]`, no
network, and no credentials — which is what makes the acceptance bar
structural rather than a convention.

| Seam | Module | Contract |
|---|---|---|
| Argument | `src/commands.sfn` | One file holds the command tree and the dispatch. Adding a leaf is one edit, not the five SFEP-0074 §2.2 measures for an `sfn dev` verb. |
| Filesystem | `src/repo_fs.sfn` | `RepoFs { root }` scopes every access; `repo_relative_is_safe` is a pure containment gate that rejects absolute paths, `..`, backslashes, and globs. |
| Fixture | `src/fixture.sfn` | Declare a tree as data, get a `RepoFs` over a `mkdtemp` root — the same type production takes, so a test drives the real code path. |
| Deterministic output | `src/deterministic.sfn` | Byte-ordered, LF-only, no clock or PID reachable. `render_report` is file-shaped (trailing LF); `report_lines` is stream-shaped. |
| Credential injection | `src/credentials.sfn` | `credentials_from_env` is the only `![io]` function; everything downstream takes a `Credentials` value. `redact` is pure, so "this secret cannot survive this rendering" is provable without holding one. |

`[capabilities] required = ["io"]` is deliberately narrower than where the
leaves end up. A leaf that needs `net` widens it when it lands; declaring it
now would be a ceiling the tests cannot back.

## Commands

```
repo-tooling env-check --require <NAME> [--require <NAME>...]
repo-tooling paths [--root <dir>] <relative>
```

`env-check` reports presence only — a name and a boolean, never a value — so
its output is safe in a public build log by construction. It exits `1` when any
required name is unset, which is the intended CI preflight: a missing token
fails in one line instead of as an opaque 401.

`paths` resolves a repository-relative path through the containment gate and
exits `2` on an escape. It exists so a Tier 3 shell caller can borrow the gate
during a port instead of re-deriving it.

## Tests

```
build/bin/sfn test tools/repo-tooling
```

No test in this capsule reads the environment, opens a socket, or holds a real
credential.
