# Proposal: Sailfin Capsule & Model Management

Status: Draft (Design)  
Last updated: October 2025  
Owners: Tooling / Registry Working Group

Sailfin ships with a built-in package manager called `sfn`. It manages code
capsules, model artefacts, capability manifests, and reproducible build
metadata. The interface mirrors modern dependency managers but is designed for
deterministic, AI-native projects.

> Implementation note: The Python bootstrap toolchain does not yet ship an `sfn`
> CLI. Registry workflows live in this proposal until the integration work in
> `docs/roadmap.md` lands.

## Getting Started

### Installing Capsules

```bash
sfn add sailfin/http
```

This fetches the `sailfin/http` capsule from the Sailfin registry and records it
in your `sail.toml` manifest. Multiple capsules can be added at once:

```bash
sfn add sailfin/http sailfin/io sailfin/net
```

### The `sail.toml` Manifest

Every capsule contains a `sail.toml` descriptor:

```toml
[package]
name = "my-sailfin-project"
version = "1.0.0"
description = "A simple Sailfin capsule"
entry = "src/main.sfn"

[dependencies]
"sailfin/http" = "^1.0.0"
"sailfin/io"   = "^0.5.0"

[capabilities]
allow = ["io", "net", "model"]

[models]
"openai.summarizer" = "gpt-foo@2.3.1"
```

Capabilities listed here gate which effects the capsule may use; the compiler
rejects code that performs an undeclared effect. Model entries capture provider
versions so builds remain reproducible.

Projects containing multiple capsules are organised as a fleet, defined by a
top-level `fleet.toml`.

### Fleet Manifest Example

Below is an illustrative `fleet.toml` showing how multiple capsules, shared
profiles, and model provenance are declared. (Fields and syntax are evolving.)

```toml
[fleet.meta]
name        = "sailfin"
version     = "0.0.0"
description = "Core language, runtime, and tooling"

[registry]
primary = "https://registry.sailfin.dev"
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

The fleet manifest orchestrates:

- Capsules and their effect capability boundaries
- Reproducible model and dependency locking
- Build profiles for different workflows
- Shared evaluation / provenance policies

Individual capsules still declare their own `sail.toml`; the fleet manifest
aggregates and overrides where necessary.

## Common Commands

- `sfn init`: Scaffold a new capsule with `sail.toml`, `src/`, and mirrored
  `tests/`/`docs/` stubs aligned with `docs/style-guide.md`.
- `sfn add <capsule>`: Add a dependency and record it in the manifest.
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
sfn add sailfin/http
```

Write code using Sailfin syntax:

```sailfin
import { serve } from "sfn/http"

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
sfn publish --registry registry.sailfin.dev
```

## Registry & Provenance

Sailfin capsules and model artefacts are hosted on the central registry at
<https://registry.sailfin.dev>. Uploads include provenance metadata: commit
hashes, generation cards, capability manifests, and evaluator baselines.
Consumers can replay model calls using the bundled cards for deterministic
evaluation.

The registry is live today, but the bootstrap toolchain lacks native commands
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
