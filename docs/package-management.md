# Sailfin Package Management

Sailfin ships with a built-in package manager called **`sail`**. The tool manages dependencies, publishes libraries, and orchestrates project workflows in a way that mirrors familiar JavaScript tooling while remaining fully self-hosted.

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

Paths in `sail.json` use the `.sfn` extension for Sailfin source files.

## Common Commands

| Command | Description |
| ------- | ----------- |
| `sail init` | Scaffold a new project with `sail.json` and a `src/` directory. |
| `sail install <pkg>` | Add a dependency and write it to the manifest. |
| `sail update` | Resolve the latest compatible versions for all dependencies. |
| `sail remove <pkg>` | Remove a dependency and tidy the manifest. |
| `sail run` | Build and execute the current project. |
| `sail test` | Run test declarations across the codebase. |
| `sail publish` | Publish the current package to the registry. |

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

5. Publish when ready:

   ```bash
   sail publish
   ```

## Registry Information

Sailfin packages are hosted on the central registry at <https://sailpkg.org>. The registry provides discovery, semantic version resolution, secure publishing, and provenance metadata for reproducible builds.

## Local Cache

The package manager maintains a local cache to accelerate installs:

- Unix-like systems: `~/.sail/cache`
- Windows: `%USERPROFILE%/.sail/cache`

Clear the cache when necessary:

```bash
sail cache clear
```
