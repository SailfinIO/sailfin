# Gemini Guidelines for the Sailfin Project

This document provides guidelines for using Gemini to assist with development in the Sailfin project.

## About this Project

Sailfin is an AI-native, systems-friendly programming language designed for precision, safety, and introspection. Its type system unifies deterministic computation, effect isolation, and capability-aware security to make large-scale model-driven software reliable by default.

For a comprehensive overview of the project, please refer to the [README.md](README.md).

The primary compiler is the native stage2 toolchain; stage1 and bootstrap steps still exist for now but are slated for removal by the 1.0 release. The runtime currently ships in C and is planned to move into Sailfin for 1.0.

## Getting Started

To get started with the Sailfin project, please refer to the [README.md](README.md) for a project overview and the [docs/README.md](docs/README.md) for the documentation navigation map.

Before you begin, ensure you have the `sailfin` Conda environment set up:

```bash
make install
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

- `make install`: Create or update the Conda environment used for the compiler.
- `make test`: Run the full pytest suite. You can pass `PYTEST_ARGS` to filter the tests (e.g., `make test PYTEST_ARGS="-m unit"`).
- `make compile`: Build the native sailfin-stage2 compiler via the current stage1 → stage2 bootstrap pipeline.
- `make clean`: Remove packaged artifacts (`dist/`).
- `make native-stage2-debug`: Build native stage2 with debug symbols for lldb.
- `make native-stage2-asan`: Build native stage2 with AddressSanitizer.
- `make stage2-native-sanity`: Build + compile hello-world as a smoke test.
- `make stage2-native-roundtrip`: Build + run on `compiler/src/main.sfn`.
- `make stage2-native-fixed-point`: Ensure Stage3→Stage4 is a stable fixed-point.

## Documentation

The `docs` folder is a critical part of the Sailfin project. It contains the project's roadmap, status, specification, and other important documentation. It is essential to keep the documentation up-to-date with the latest changes to the language.

Key documents include:

- [docs/roadmap.md](docs/roadmap.md): The project's roadmap, which tracks tasks and future development.
- [docs/status.md](docs/status.md): The source of truth for what ships today (stage2 primary) versus what is still in progress.
- [docs/spec.md](docs/spec.md): The bootstrap language reference with design-preview callouts.

## Testing

The project has a comprehensive test suite. You can run the full test suite with:

```bash
make test
```

You can also run specific test suites:

- `make test-unit`: Run fast Sailfin-focused unit coverage.
- `make test-integration`: Run integration tests (stage1 artifact, self-host checks, etc.).
- `make test-stage2`: Run LLVM/native backend coverage.

Before submitting any changes, please ensure that all tests pass.

## Contributions

We welcome contributions to the Sailfin project. Please follow these guidelines when contributing:

- **Branch & scope**: Keep work focused; reference open issues or roadmap items when possible.
- **Testing**: Add or update unit tests under `compiler/tests/` for stage1 changes.
- **Documentation**: Reflect behavior updates in `docs/status.md` and the relevant module docs.
- **Commits**: Use clear, atomic commits. Conventional prefixes (`feat(compiler):`, `fix(bootstrap):`) are encouraged but not mandatory.
- **Pull Requests**: Each PR should include a summary of the change, verification commands, and notes on documentation updates.

For more detailed information on contributing, please refer to the [CONTRIBUTING.md](CONTRIBUTING.md) file.
