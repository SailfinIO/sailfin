# Bootstrap

This directory contains the bootstrap compiler for the Sailfin language. The bootstrap compiler is written in Python and is used to compile the Sailfin compiler written in Sailfin itself.

## Building the Compiler

To build the `sfn` executable, run the following command from the project root:

```bash
pyinstaller --onefile --name sfn --hidden-import=__future__ --hidden-import=typing --hidden-import=dataclasses --hidden-import=collections --hidden-import=functools --hidden-import=asyncio --hidden-import=time bootstrap/bootstrap.py
```

This will generate the `sfn` executable in the `bootstrap/dist/` directory.

## Installing the Compiler

To install the compiler globally on your system, copy the binary to a directory in your PATH:

```bash
# macOS/Linux
sudo cp bootstrap/dist/sfn /usr/local/bin/

# Or to your local bin directory
cp bootstrap/dist/sfn ~/.local/bin/
```

## Usage

The `sfn` compiler provides a clean, professional CLI interface:

```bash
sfn [options] <source_file.sfn>
```

### Options

- `-h, --help` - Show help message and exit
- `-o OUTPUT, --output OUTPUT` - Specify output file path (default: output.py)
- `-c, --compile-only` - Compile only, don't execute the output
- `-v, --verbose` - Enable verbose output for debugging

### Examples

```bash
# Compile and run a Sailfin file (quiet mode)
sfn examples/basics/hello-world.sfn

# Compile only, don't execute
sfn -c examples/basics/conditionals.sfn

# Compile with custom output file
sfn -o my_program.py examples/basics/functions.sfn

# Verbose mode for debugging
sfn -v examples/advanced/web-server-with-concurrency.sfn

# Show help
sfn --help
```

### Behavior

- **Default (quiet) mode**: Only shows program output or error messages
- **Verbose mode** (`-v`): Shows detailed compilation steps and debug information
- **Error handling**: Provides clear error messages and proper exit codes
- **File validation**: Ensures source files have `.sfn` extension

## Development

The bootstrap compiler is written in Python 3.13. To install the required dependencies, run the following command:

```bash
poetry install
```

### Running Tests

To test all Sailfin examples:

```bash
python bootstrap/test_all_examples.py
```

Or use the VS Code task:

```bash
# In VS Code Command Palette (Ctrl+Shift+P)
Tasks: Run Task -> Test All Examples
```

### Testing Individual Files

You can test individual Sailfin files using either the Python script directly or the compiled binary:

```bash
# Using Python script (development)
python bootstrap/bootstrap.py examples/basics/conditionals.sfn

# Using compiled binary (production)
./bootstrap/dist/sfn examples/basics/conditionals.sfn
```
