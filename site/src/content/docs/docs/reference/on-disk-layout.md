---
title: On-Disk Layout
description: Every directory Sailfin reads or writes on your machine, and the environment variables that relocate each one.
section: reference
sidebar:
  order: 8
---

Sailfin writes to **three unrelated roots**, not one. `~/.sfn` is only one of
them — a machine with a large toolchain store under
`~/.local/share/sailfin/versions/` and no `~/.sfn` at all is completely normal,
not evidence that nothing is installed.

## At a glance

| Root | Default | Holds | Relocated by |
| --- | --- | --- | --- |
| Config root | `~/.sfn/` | config, credentials, toolchain default, capsule cache | `SAILFIN_CONFIG_DIR` (partially — see below) |
| Toolchain store | `~/.local/share/sailfin/versions/` | installed toolchains + signed index cache | `INSTALL_BASE`, `SAILFIN_HOME` |
| Build cache | `~/.cache/sailfin/` | content-addressed module build cache | `SAILFIN_BUILD_CACHE_DIR`, `[build] cache-dir` |

Each root is relocated independently. Setting one of these variables does not
touch either of the other two roots — see [The relocation
matrix](#the-relocation-matrix) below for the exact boundaries.

## Root 1 — the config root

Defaults to `~/.sfn/`, overridden in full by `SAILFIN_CONFIG_DIR`. It holds
your persisted settings, your registry token, this host's default toolchain,
and the capsule cache:

| Path | Written by | Contents |
| --- | --- | --- |
| the directory itself (mode `0700`) | `sfn config set`, `sfn login` | container |
| `config.toml` (mode `0600`) | `sfn config set`/`unset` | persisted user settings |
| `credentials` (mode `0600`) | `sfn login` | registry bearer token, **plain text** |
| `toolchain-default` | `sfn toolchain default`, `sfn toolchain update` | per-host-triple default toolchain and tracked channel |
| `cache/capsules/<scope>/<name>/<version>/` | `sfn add` | fetched capsule `.sfnpkg` archives, extracted |

**`config.toml` is created lazily.** A user who has never run `sfn config set`
will not have one, and that is entirely normal — `sfn config get` and
`sfn config list` never create it. Both `sfn config set` and
`sfn config unset` create the directory and file on first use. The complete
set of settable keys is:

- `registry` (stored as `[registry] url`)
- `toolchain.update-policy`
- `build.jobs`
- `build.cache-dir`
- `target.<triple>.linker`
- `target.<triple>.cc`

See [`sfn config`](/docs/reference/cli#sfn-config-getsetunsetlist-key-value)
for the command and [Environment Variables](/docs/reference/cli#environment-variables)
for how each of these interacts with its corresponding override variable.

**`credentials` holds the registry token in plain text**, at mode `0600`. This
is a real operational fact worth knowing before treating `~/.sfn` as harmless
to share, back up, or sync. `SFN_TOKEN` in the environment takes precedence
over the file when both are present.

**`toolchain-default` is keyed by host triple.** A home directory that is
shared or roamed across machines carries a separate recorded default per host
triple, not one global default. The record carries a magic header and schema
version, and is written atomically (temp file, then rename), so an interrupted
write can never publish a half-written default. See [Default toolchain and
removal](/docs/reference/cli#default-toolchain-and-removal) for the command
that reads and writes it.

**The capsule cache is the exception that trips people up.** `sfn add` builds
its cache path from your home directory directly, not through the same
resolution as the other three records. That means `SAILFIN_CONFIG_DIR`
relocates `config.toml`, `credentials`, and `toolchain-default`, but **leaves
the capsule cache behind** at `~/.sfn/cache/` under your real home directory.
If you've relocated your config root and a fetched dependency still shows up
under the old `~/.sfn`, this is why. See [Capsules &
Packages](/docs/advanced/capsules) for what the capsule cache holds and how
`sfn add` populates it.

## Root 2 — the toolchain store

Defaults to `~/.local/share/sailfin/versions/`. This is where
`sfn toolchain install` and friends actually put toolchain binaries — a
completely different directory tree from `~/.sfn`, resolved with its own
precedence, highest first:

1. `INSTALL_BASE`
2. `$SAILFIN_HOME/versions`
3. `$HOME/.local/share/sailfin/versions`

Two things worth flagging before you export either variable:

- **`INSTALL_BASE` has no `SAILFIN_` prefix.** It's a short, generic name that
  can collide with an unrelated tool's environment variable of the same name
  in the same shell. Worth checking for before setting it globally.
- **`SAILFIN_HOME` does not move `~/.sfn`,** and does not change home
  directory resolution at all. It is consulted in exactly one place: the
  toolchain store path above. The name invites the opposite assumption, so it
  is worth stating plainly: setting `SAILFIN_HOME` has no effect on
  `config.toml`, `credentials`, `toolchain-default`, the capsule cache, or the
  build cache.

This is also a **different mechanism** from `bootstrap.toml`'s `[store]
install_base`, which configures only the repo-local seed store used by
`sfn dev bootstrap` when self-hosting the compiler itself. That key never
feeds into the toolchain store path above.

### Per-toolchain layout

Each installed toolchain lands host-qualified, at
`<base>/<host-triple>/<version>/`:

| Entry | Notes |
| --- | --- |
| `sailfin` | the compiler binary, mode `0755` |
| `sfn` | alias for the binary — a symlink where the platform allows, a copy otherwise |
| `runtime/` | bundled runtime sources, copied when present |
| `capsules/` | bundled first-party capsules, copied when present |
| `workspace.toml` | copied when present |
| `.install-manifest` | list of installed files |
| `.sha256` | written **last** |

`.sha256` is written last deliberately: it's the readiness marker. Sailfin
only considers a store entry complete when `.sha256` is present and
non-empty, so a half-written or interrupted install can never be mistaken for
a usable toolchain.

**Legacy unqualified entries** at `<base>/<version>/` (no host-triple segment)
still resolve, but only when no host-qualified entry exists for that version —
a qualified entry always wins. `sfn toolchain remove` deliberately refuses to
delete a legacy entry, since it may still be shared across multiple hosts.

Also under this root, **not** under `~/.sfn`, is the signed toolchain index
cache at `<base>/.index/`: `toolchain-index.json`, its detached signature
`toolchain-index.json.sig`, an anti-rollback `sequence` file, and a local
append-only `revocations` ledger. See [Installing a
toolchain](/docs/reference/cli#installing-a-toolchain) for what consults this
cache and why.

### Toolchain subcommands

All nine `sfn toolchain` subcommands are shipped: `install`, `entry-version`,
`run`, `list`, `active`, `verify`, `default`, `update`, and `remove`. This page
only covers where they read and write; for what each one does, see
[Installing a toolchain](/docs/reference/cli#installing-a-toolchain),
[Default toolchain and removal](/docs/reference/cli#default-toolchain-and-removal),
and [Updating a toolchain](/docs/reference/cli#updating-a-toolchain).

## Root 3 — the build cache

Defaults to `~/.cache/sailfin/`. The build cache is a content-addressed cache
of compiled module output, entirely separate from both the config root and
the toolchain store. Resolution order:

1. `SAILFIN_BUILD_CACHE_DIR`
2. the in-tree pin (the compiler's own self-host build only)
3. `config.toml`'s `[build] cache-dir`
4. `$XDG_CACHE_HOME/sailfin`
5. `$HOME/.cache/sailfin`
6. the in-tree `build/cache`, when `$HOME` cannot be resolved at all

`cache-dir` must be an absolute path; a relative value is ignored with a
warning. The compiler's own self-host build always pins the in-tree root and
is unaffected by `sfn cache` or `cache-dir`.

See [`sfn cache`](/docs/reference/cli#sfn-cache-infopruneclean) for the
commands that inspect and prune this root.

## Home resolution

`HOME` (and, on Windows, `USERPROFILE` or `HOMEDRIVE`+`HOMEPATH`) is what
Sailfin's home-directory lookup consults to produce the defaults above.
**`SAILFIN_HOME` is not part of this lookup** — despite the name, it does not
affect home directory resolution; it only feeds the toolchain store path
described in Root 2 above.

## The relocation matrix

| Variable | Moves | Does **not** move |
| --- | --- | --- |
| `SAILFIN_CONFIG_DIR` | `config.toml`, `credentials`, `toolchain-default` | the capsule cache (`~/.sfn/cache/`), the toolchain store, the build cache |
| `INSTALL_BASE` | the whole toolchain store root (all hosts and versions) | `~/.sfn`, the build cache |
| `SAILFIN_HOME` | the toolchain store root, as `$SAILFIN_HOME/versions` | `~/.sfn`, the build cache, home resolution itself |
| `SAILFIN_BUILD_CACHE_DIR` | the build cache root | `~/.sfn`, the toolchain store |
| `HOME` | all three roots' defaults | anything already pinned by the variables above |

`SAILFIN_CONFIG_DIR` is a **total override, not a search path**: when it's
set, the real `~/.sfn` is not consulted for `config.toml`, `credentials`, or
`toolchain-default` at all — there is no read-through fallback to the old
location. Use an absolute path; a relative value resolves against each
process's own working directory, so the same setting could name a different
directory depending on where you run `sfn` from. An empty
`SAILFIN_CONFIG_DIR=` is indistinguishable from unset and falls back to
`~/.sfn`.

One more variable worth knowing about, though it's a read path rather than a
root: `SAILFIN_RUNTIME_ROOT` overrides where the `sfn` binary *looks for* its
bundled runtime. It's a lookup override, not a directory Sailfin writes to,
so it doesn't belong in the table above.

## See also

- [CLI Reference → Environment Variables](/docs/reference/cli#environment-variables)
  for the full variable table, including build-parallelism and toolchain-pin
  controls not covered on this page.
- [Capsules & Packages](/docs/advanced/capsules) for the capsule manifest
  format and the capsule cache `sfn add` populates.
