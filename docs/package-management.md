# Sailfin Package & Model Management

Sailfin ships with a built-in package manager called **`sail`**. The tool manages
code dependencies, model artefacts, capability manifests, and reproducible build
metadata. It feels familiar if you have used JavaScript tooling, but it is
designed for deterministic, AI-native projects.

## Getting Started

### Installing Packages

```bash
sail install sail/http
```

The command fetches the `sail/http` package from the Sailfin registry and records it in your `sail.json` manifest. Multiple packages can be installed at once:

```bash
sail install sail/http sail/io sail/net
```

### The `sail.json` Manifest

Every project contains a `sail.json` descriptor:

```json
{
  "name": "my-sailfin-project",
  "version": "1.0.0",
  "description": "A simple Sailfin project",
  "main": "src/main.sfn",
  "dependencies": {
    "sail/http": "^1.0.0",
    "sail/io": "^0.5.0"
  }
}
```

Paths in `sail.json` use the `.sfn` extension for Sailfin source files. The
manifest also records **capabilities** and **model pinning**:

```json
{
  "capabilities": ["io", "net", "model"],
  "models": {
    "openai/summarizer": "gpt-foo@2.3.1"
  }
}
```

Capabilities listed here gate what effects the package may use; the compiler
will reject code that performs an undeclared effect. Model entries capture the
exact provider version so builds remain reproducible.

## Common Commands

| Command | Description |
| ------- | ----------- |
| `sail init` | Scaffold a new project with `sail.json` and a `src/` directory. |
| `sail install <pkg>` | Add a dependency and write it to the manifest. |
| `sail update` | Resolve the latest compatible versions for all dependencies. |
| `sail remove <pkg>` | Remove a dependency and tidy the manifest. |
| `sail run` | Build and execute the current project with capability checks. |
| `sail test` | Run `test` declarations, including golden and adversarial suites. |
| `sail publish` | Publish the current package to the registry. |
| `sail add model <provider>:<name>@<ver>` | Pin and fetch a model artefact. |
| `sail models sync` | Refresh local caches and provenance cards for models. |

## Managing Model Artefacts

The package manager treats models as first-class dependencies. Use `sail add
model` to pin a model version and download its schema and evaluation metadata:

```bash
sail add model openai:summarizer@2.3.1
```

Model metadata lives under `.sail/models/` and is embedded into build outputs as
generation-card templates. `sail models sync` re-fetches provider signatures,
cost caps, and evaluator baselines.

## Capability Bundles & Policies

`sail capabilities audit` reports which modules require effects (`io`, `net`,
`model`, `gpu`, etc.) and ensures policies exist for taint-tracked types such as
`PII<T>` or `Secret<T>`. Policy bundles ship alongside packages so downstream
consumers inherit redaction rules, retention windows, and consent flows.

## Example Workflow

1. Initialise the project:

   ```bash
   sail init
   ```

2. Install dependencies:

   ```bash
   sail install sail/http
   ```

3. Write code using the Sailfin syntax:

```sailfin
import { serve } from "sail/http";

fn main() {
    serve(fn(req, res) {
        res.send("Hello, Sailfin!");
    }, { port: 8080 });
}
```

4. Run the application:

```bash
sail run
```

5. Add a model dependency and run tests with deterministic seeds:

```bash
sail add model openai:summarizer@2.3.1
sail test --scope seed=42 --scope temperature=0.2
```

6. Publish when ready:

```bash
sail publish
```

## Registry & Provenance

Sailfin packages and model artefacts are hosted on the central registry at
<https://sailpkg.org>. Each upload includes provenance metadata: commit hashes,
generation cards, capability manifests, and evaluator baselines. Consumers can
replay model calls using the bundled cards.

## Local Cache

The package manager maintains a local cache to accelerate installs and model
downloads:

- Unix-like systems: `~/.sail/cache`
- Windows: `%USERPROFILE%/.sail/cache`

Clear the cache when necessary:

```bash
sail cache clear
```

Use `sail cache cards --replay <trace>` to materialise generation cards for
postmortems without contacting the provider.
