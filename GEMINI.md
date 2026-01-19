# Gemini Guidelines for the Sailfin Project

This document provides guidelines for using Gemini to assist with development in the Sailfin project.

## About this Project

Sailfin is an AI-native, systems-friendly programming language designed for precision, safety, and introspection. Its type system unifies deterministic computation, effect isolation, and capability-aware security to make large-scale model-driven software reliable by default.

For a comprehensive overview of the project, please refer to the [README.md](README.md).

The primary compiler is the self-hosted native compiler (legacy name: stage2); stage1 and bootstrap steps still exist for now but are slated for removal by the 1.0 release. The runtime currently ships in C and is planned to move into Sailfin for 1.0.

## Getting Started

To get started with the Sailfin project, please refer to the [README.md](README.md) for a project overview and the [docs/README.md](docs/README.md) for the documentation navigation map.

Before you begin, ensure you have the `sailfin` Conda environment set up:

```bash
make env
```

## Development Workflow

The primary workflow for development is as follows:

1.  **Select a Task**: Choose a task from the [roadmap.md](docs/roadmap.md).
2.  **Implement the Task**: Make the necessary code changes to complete the task.
3.  **Compile and Test**: Re-compile the language and run the test suite to ensure that your changes have not introduced any regressions.
    ```bash
    make compile
    make test
    ```
4.  **Update Documentation**: Update the [roadmap.md](docs/roadmap.md), [docs/status.md](docs/status.md), and any other relevant documentation to reflect the changes you have made.
5.  **Add New Tasks**: If you discover any new tasks during the development process, add them to the [roadmap.md](docs/roadmap.md).

### Development Commands

The following commands are available for development:

 - `make env`: Create or update the Conda environment used for the compiler.
 - `make install`: Install the built compiler into `PREFIX/bin` (default: `/usr/local/bin`).
- `make test`: Run the full suite.
- `make compile`: Build the native compiler by self-hosting from a released seed (preferred).
- `make clean`: Remove packaged artifacts (`dist/`).
- `make native-debug`: Build the native compiler with debug symbols for lldb (bootstrap-built).
- `make native-asan`: Build the native compiler with AddressSanitizer (bootstrap-built).
- `make selfhost-smoke-native`: Run a fast smoke rebuild of the native compiler from a released seed.
- `make check-native-determinism`: Rebuild native compiler twice and diff outputs.

## Documentation

The `docs` folder is a critical part of the Sailfin project. It contains the project's roadmap, status, specification, and other important documentation. It is essential to keep the documentation up-to-date with the latest changes to the language.

Key documents include:

- [docs/roadmap.md](docs/roadmap.md): The project's roadmap, which tracks tasks and future development.
- [docs/status.md](docs/status.md): The source of truth for what ships today (native compiler primary; legacy name stage2) versus what is still in progress.
- [docs/spec.md](docs/spec.md): The bootstrap language reference with design-preview callouts.

## Testing

The project has a comprehensive test suite. You can run the full test suite with:

```bash
make test
```

You can also run specific test suites:

- `make test-unit`: Run fast Sailfin-focused unit coverage.
- `make test-integration`: Run Sailfin-native integration tests.

Note: the repo still contains historical `stage2` naming in targets and artifact paths; docs prefer “native compiler” terminology going forward.

Before submitting any changes, please ensure that all tests pass.

## Contributions

We welcome contributions to the Sailfin project. Please follow these guidelines when contributing:

- **Branch & scope**: Keep work focused; reference open issues or roadmap items when possible.
- **Testing**: Add or update unit tests under `compiler/tests/` for compiler changes.
- **Documentation**: Reflect behavior updates in `docs/status.md` and the relevant module docs.
- **Commits**: Use clear, atomic commits. Conventional prefixes (`feat(compiler):`, `fix(bootstrap):`) are encouraged but not mandatory.
- **Pull Requests**: Each PR should include a summary of the change, verification commands, and notes on documentation updates.

For more detailed information on contributing, please refer to the [CONTRIBUTING.md](CONTRIBUTING.md) file.
