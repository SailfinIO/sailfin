# Sail Package Management

Sail includes a built-in package manager called **`sail`**. This tool allows developers to:

- Install, update, and remove dependencies.
- Initialize new projects with a `sail.json` configuration file.
- Publish packages to a central registry.
- Resolve and cache dependencies for fast builds.

## Getting Started

### Installing a Package

To install a package, use the `sail install` command:

```bash
sail install sail/http
```

This command fetches the http package from the Sail package registry and adds it to the dependencies section of your sail.json file.

Example: Installing Multiple Dependencies

```bash
sail install sail/http sail/io sail/net
```

## The `sail.json` File

The `sail.json` file is the configuration file for your Sail project. It contains information about your project, such as the name, version, and dependencies.

Example `sail.json` File:

```json
{
  "name": "my-sail-project",
  "version": "1.0.0",
  "description": "A simple Sail project",
  "main": "src/main.sail",
  "dependencies": {
    "sail/http": "^1.0.0",
    "sail/io": "^0.5.0"
  }
}
```

## Common Commands

### Initialize a New Project

To create a new Sail project, use the `sail init` command:

```bash
sail init
```

This command initializes a new project with a `sail.json` file and a `src` directory.

### Add a Dependency

To add a new dependency to your project, use the `sail install` command:

```bash
sail install sail/http
```

This command fetches the http package from the Sail package registry and adds it to your dependencies.

### Update Dependencies

To update all dependencies to their latest versions, use the `sail update` command:

```bash
sail update
```

This command fetches the latest versions of all dependencies and updates the `sail.json` file.

### Remove a Dependency

To remove a dependency from your project, use the `sail remove` command:

```bash
sail remove sail/http
```

This command removes the http package from your dependencies.

### Publish a Package

To publish a package to the Sail package registry, use the `sail publish` command:

```bash
sail publish
```

This command publishes your package to the registry, making it available for other developers to install.

## Example Workflow

1. Initialize a new project:

```bash
sail init
```

2. Add dependencies to your project:

```bash
sail install sail/http
```

3. Write your code in the `src` directory.

```bash
import { serve } from "sail/http";

fn main() {
    serve(fn(req, res) {
        res.send("Hello, Sail!");
    }, { port: 8080 });
}
```

4. Build and run your project:

```bash
sail run
```

5. Publish your package to the registry:

```bash
sail publish
```

## Registy Information

Sail packages are hosted on a central registry: https://sailpkg.org.
The registry supports:

- Package search and discovery.
- Versioning and dependency resolution.
- Secure package publishing and distribution.

## Local Cache

Sail maintains a local cache of packages to speed up builds and reduce network requests.

- The cache is located at `~/.sail/cache` on Unix systems and `%USERPROFILE%/.sail/cache` on Windows.
- To clear the cache:

```bash
sail cache clear
```
