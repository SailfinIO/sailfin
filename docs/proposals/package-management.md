# Proposal: Sailfin Capsule & Model Management

Status: Draft (Design)  
Last updated: October 2025  
Owners: Tooling / Registry Working Group

Sailfin ships with a built-in package manager called `sfn`. It manages code
capsules, model artefacts, capability manifests, and reproducible build
metadata. The interface mirrors modern dependency managers but is designed for
deterministic, AI-native projects.

> Implementation note: The `sfn` CLI is in active development. Registry
> workflows live in this proposal until the integration work on the
> [roadmap](https://sailfin.dev/roadmap) lands.

## Getting Started

### Installing Capsules

```bash
sfn add http
```

Standard library capsules use bare names (`http`, `fs`, `json`, etc.).
Third-party capsules use scoped names (`acme/router`, `myorg/utils`).
Multiple capsules can be added at once:

```bash
sfn add http fs json
```

Dev dependencies (test frameworks, benchmarks) are added with `--dev`:

```bash
sfn add --dev test bench
```

### The `capsule.toml` Manifest

Every capsule contains a `capsule.toml` descriptor:

```toml
[capsule]
name = "my-sailfin-project"
version = "1.0.0"
description = "A simple Sailfin capsule"

[dependencies]
"http" = "^1.0.0"
"fs"   = "^0.5.0"

[dev-dependencies]
"test" = "^0.1.0"

[build]
entry = "src/main.sfn"

[capabilities]
required = ["io", "net", "model"]

[models]
"openai.summarizer" = "gpt-foo@2.3.1"
```

Capabilities listed here gate which effects the capsule may use; the compiler
rejects code that performs an undeclared effect. Model entries capture provider
versions so builds remain reproducible.

Projects containing multiple capsules are organised as a workspace, defined by a
top-level `workspace.toml`.

### Workspace Manifest Example

Below is an illustrative `workspace.toml` showing how multiple capsules, shared
profiles, and model provenance are declared. (Fields and syntax are evolving.)

```toml
[workspace.meta]
name        = "sailfin"
version     = "0.0.0"
description = "Core language, runtime, and tooling"

[registry]
primary = "https://pkg.sfn.dev"
cache   = "~/.sfn/cache"

[build]
opt_level = "z"
incremental = true
diagnostics = "rich"

[provenance]
lock_capsules = true
lock_models = true
provenance_strict = true
signing = true

[profiles.base]
incremental = true
diagnostics = "rich"

[profiles.dev]
inherits = ["base"]
incremental = true
diagnostics = "rich"

[profiles.ci]
incremental  = false
diagnostics  = "compact"
fail_on_warn = true

[[capsule]]
name  = "compiler.frontend"
path  = "compiler/src"
kind  = "lib"
group = "compiler"
allow = ["io", "clock"]
deps  = ["std.core", "shared.diag"]

[[capsule]]
name  = "runtime.core"
path  = "runtime/core"
kind  = "runtime"
group = "runtime"
allow = ["io", "net", "clock", "model"]

[[modelpack]]
name    = "openai.summarizer"
version = "3.1.0"
digest  = "sha256:deadbeef..."
evaluators = [ Faithfulness, LatencyBudget(150ms) ]
cost_cap = 0.05 # USD (currency literal support forthcoming)
```

The workspace manifest orchestrates:

- Capsules and their effect capability boundaries
- Reproducible model and dependency locking
- Build profiles for different workflows
- Shared evaluation / provenance policies

Individual capsules still declare their own `capsule.toml`; the workspace manifest
aggregates and overrides where necessary.

## Common Commands

- `sfn init`: Scaffold a new capsule with `capsule.toml`, `src/`, and mirrored
  `tests/`/`docs/` stubs aligned with `docs/style-guide.md`.
- `sfn add <capsule>`: Add a dependency and record it in the manifest. Standard
  library capsules use bare names (`http`, `fs`); third-party use scoped names
  (`acme/router`).
- `sfn add --dev <capsule>`: Add a dev-only dependency (test, bench, etc.).
- `sfn update`: Resolve the latest compatible versions for all dependencies.
- `sfn remove <capsule>`: Remove a dependency and tidy the manifest.
- `sfn run`: Build and execute the current capsule with capability checks.
- `sfn test`: Run test declarations, including golden and adversarial suites.
- `sfn publish`: Publish the current capsule or model pack to the registry.
- `sfn add-model <provider>:<name>@<ver>`: Pin and fetch a model artefact.
- `sfn models sync`: Refresh local caches and provenance cards for models.

## Managing Model Artefacts

The package manager treats models as first-class dependencies.

```bash
sfn add-model openai:summarizer@2.3.1
```

Model metadata is stored under `.sfn/models/` and embedded into build outputs as
generation-card templates. `sfn models sync` re-fetches provider signatures,
cost caps, and evaluator baselines.

## Capability Bundles & Policies

`sfn capabilities audit` reports which modules require effects (`io`, `net`,
`model`, `gpu`, etc.) and ensures that policies exist for taint-tracked types
such as `PII<T>` or `Secret<T>`. Policy bundles ship alongside capsules, so
downstream consumers inherit redaction rules, retention windows, and consent
flows.

## Example Workflow

Initialise the capsule:

```bash
sfn init
```

Install dependencies:

```bash
sfn add http
```

Write code using Sailfin syntax:

```sailfin
import { serve } from "http"

fn main() {
    serve(fn(req, res) {
        res.send("Hello, Sailfin!")
    }, { port: 8080 })
}
```

Run the application:

```bash
sfn run
```

Add a model dependency and run tests deterministically:

```bash
sfn add-model openai:summarizer@2.3.1
sfn test --scope seed=42 --scope temperature=0.2
```

Publish when ready:

```bash
sfn publish
```

## Registry & Provenance

Sailfin capsules and model artefacts are hosted on the default central
registry at <https://pkg.sfn.dev>. Users can point the toolchain at any
alternate registry (e.g. a private enterprise mirror) via
`sfn config set registry <url>` or the `SFN_REGISTRY` environment variable.
Uploads include provenance metadata: commit hashes, generation cards,
capability manifests, and evaluator baselines. Consumers can replay model
calls using the bundled cards for deterministic evaluation.

The registry is live today, but the current toolchain lacks native commands
for interacting with it; the flows above remain design targets until the CLI
arrives.

## Local Cache

`sfn` maintains a local cache to accelerate installs and model downloads.

- Unix-like: `~/.sfn/cache`
- Windows: `%USERPROFILE%\.sfn\cache`

Clear the cache when needed:

```bash
sfn cache clear
```

Inspect stored generation cards or replay traces:

```bash
sfn cache cards --replay <trace>
```
