# Bootstrap Testing

This directory contains test scripts for validating the Sailfin bootstrap compiler.

## Test Scripts

### `test_all_examples.py`

Comprehensive test that runs against all example directories and provides a detailed breakdown of what's working vs. what needs implementation.

**Usage:**

```bash
python test_all_examples.py
```

**Output:**

- Shows status for each directory (✅ fully implemented, ⚠️ partially implemented, ❌ not yet implemented)
- Provides overall statistics
- Useful for tracking progress on language feature implementation

## VS Code Tasks

Two tasks are configured in `.vscode/tasks.json`:

- **Test All Examples**: Runs the comprehensive test suite

You can run these from VS Code via `Ctrl+Shift+P` > "Tasks: Run Task"

## Current Status

As of the last test run:

- ✅ **basics** (13/13) - All core language features working
- ✅ **algorithms** (1/1) - Basic algorithms working
- ⚠️ **advanced** (2/13) - Some advanced features work, others need syntax implementation
- ❌ **concurrency, functional, io, types, web** - Need feature implementation

## Adding New Tests

To add new test examples:

1. Create `.sfn` files in the appropriate `examples/` subdirectory
2. Run the test scripts to verify they work with the current compiler
3. If they fail, the scripts will show the specific errors to help with debugging
