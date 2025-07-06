# Sailfin Build System

This directory contains the complete build and CI system for the Sailfin programming language.

## 🚀 Quick Start

### One-Line Installation

```bash
curl -sSL https://raw.githubusercontent.com/sailfin/sailfin/main/install.sh | bash
```

### Manual Build

```bash
# Clone the repository
git clone https://github.com/sailfin/sailfin.git
cd sailfin

# Run the complete build pipeline
./build.sh
```

## 📁 Structure

```
sailfin/
├── build.sh                 # Complete build and test pipeline
├── install.sh               # One-line installer for users
├── Makefile                 # Make targets for common operations
├── .github/workflows/       # CI/CD pipelines
│   ├── sailfin-ci-cd.yml   # Main CI/CD pipeline
│   └── sailfin-release.yml # Legacy release workflow
├── bootstrap/               # Python bootstrap compiler
├── compiler/                # Self-hosting Sailfin compiler
├── examples/                # Example Sailfin programs
├── docs/                   # Documentation
├── build/                  # Build output directory
└── dist/                   # Distribution packages
```

## 🔧 Build Commands

### Complete Build Pipeline

```bash
./build.sh              # Run full build and test
./build.sh build         # Same as above
```

### Individual Components

```bash
./build.sh compiler      # Build self-hosting compiler only
./build.sh test          # Test compiler and examples
./build.sh examples      # Test all examples only
./build.sh release       # Create release package
./build.sh clean         # Clean build directory
```

### Using Make

```bash
make build               # Full build and test
make test                # Run tests
make examples            # Test examples
make clean               # Clean build directory
make install             # Install via curl (requires internet)
```

## 🏗️ Build Process

The Sailfin build system follows these steps:

1. **Prerequisites Check**: Verify Python 3 and required tools are available
2. **Bootstrap Phase**: Use the Python-based bootstrap compiler in `/bootstrap`
3. **Self-Hosting Compilation**: Compile the Sailfin compiler from `/compiler/*.sfn` files
4. **Testing**: Run basic compiler tests and example compilation tests
5. **Packaging**: Create release archives with compiler, examples, and documentation

### Bootstrap Compiler

The bootstrap compiler (`/bootstrap`) is written in Python and provides:

- Lexical analysis and parsing of Sailfin source code
- AST generation and validation
- Code generation to Python or assembly
- Module loading and dependency resolution

### Self-Hosting Compiler

The self-hosting compiler (`/compiler`) is written in Sailfin itself:

- `main.sfn` - Entry point and CLI handling
- `lexer.sfn` - Lexical analyzer
- `parser.sfn` - Parser and AST builder
- `ast.sfn` - AST node definitions
- `codegen.sfn` - Code generation backend

## 🎯 Supported Platforms

The build system supports:

- **macOS**: Apple Silicon (ARM64) and Intel (x86_64)
- **Linux**: x86_64 and ARM64
- **Windows**: Coming soon (use WSL for now)

## 📦 Release Packages

Release packages include:

- `sfn` - The Sailfin compiler executable
- `sfn_compiler.py` - The compiled self-hosting compiler
- `examples/` - Example Sailfin programs
- `docs/` - Language documentation
- `README.md` - Project overview
- `install.sh` - Installation script

## 🔄 CI/CD Pipeline

The GitHub Actions workflow (`.github/workflows/sailfin-ci-cd.yml`) provides:

### Branch-based Releases

- **main**: Stable releases on tags (v1.0.0, etc.)
- **alpha**: Alpha pre-releases for early testing
- **beta**: Beta pre-releases for broader testing
- **rc**: Release candidate pre-releases

### Multi-Platform Builds

- Builds for Linux (x86_64), macOS (ARM64 and Intel)
- Parallel compilation and testing
- Automated release packaging and upload

### Pre-Release Management

- Automatic pre-release creation for development branches
- Cleanup of old pre-releases (keeps 3 most recent per branch)
- Timestamped version tags for development builds

## 🛠️ Development Workflow

### Creating a Release

1. **Tag a version**: `git tag v1.0.0 && git push origin v1.0.0`
2. **CI builds**: Automatic builds for all platforms
3. **Release creation**: GitHub release with binaries and install script
4. **User installation**: Users can install via `curl | bash`

### Development Branches

1. **Push to alpha/beta/rc**: Automatic pre-release creation
2. **Testing**: Download and test pre-release builds
3. **Merge to main**: Creates stable release when tagged

## 🐛 Troubleshooting

### Python Version Issues

The bootstrap compiler requires Python 3.13+. If you have an older version:

```bash
# Build will warn but continue with basic functionality
./build.sh compiler  # May work with limited features
```

### Missing Dependencies

```bash
# Install Python dependencies manually
cd bootstrap
pip install -e .
```

### Build Failures

```bash
# Clean and rebuild
./build.sh clean
./build.sh build
```

### Testing Issues

```bash
# Test individual components
./build.sh compiler  # Build only
./build.sh test       # Test only
./build.sh examples   # Test examples only
```

## 📖 Further Reading

- [Language Specification](docs/spec.md)
- [Function Documentation](docs/functions.md)
- [Array Handling](docs/arrays.md)
- [Loop Constructs](docs/loops.md)
- [Package Management](docs/package-management.md)
  ./build.sh clean # Clean build directory
  ./build.sh test # Run tests only
  ./build.sh bootstrap # Test bootstrap compiler
  ./build.sh self-hosting # Test self-hosting compilation
  ./build.sh artifacts # Create release artifacts

````

### Installation

```bash
# Install from latest release
curl -sSL https://raw.githubusercontent.com/sailfin/sailfin/main/install.sh | bash

# Install specific version
SAILFIN_VERSION=v0.1.0 curl -sSL https://raw.githubusercontent.com/sailfin/sailfin/main/install.sh | bash

# Manual installation
./install.sh --help
````

## 🎯 What Gets Built

### 1. Bootstrap Compiler (Python)

- Tests all 69 examples
- Validates Sailfin → Python compilation
- Creates standalone executable

### 2. Self-Hosting Compiler (Sailfin)

- Compiles real Sailfin compiler components:
  - `lexer.sfn` → Python lexer
  - `parser.sfn` → Python parser
  - `ast.sfn` → Python AST
  - `compiler.sfn` → Complete compiler
- Generates self-hosted compiler

### 3. Native Code Generation

- Self-hosted compiler → ARM64 assembly
- Assembly → Native executable (with clang)
- Validates complete pipeline

### 4. Release Artifacts

- Standalone `sfn` binary
- Self-hosted compiler
- Sample generated assembly
- Cross-platform builds

## 🔄 CI/CD Pipeline

### GitHub Actions Workflows

#### Main CI (`sailfin-ci.yml`)

- **Triggers**: Push to main/alpha/beta/rc, Pull requests
- **Jobs**:
  1. **test-bootstrap**: Tests Python bootstrap compiler
  2. **test-self-hosting**: Tests real compiler compilation
  3. **build-and-release**: Creates releases on main branches
  4. **build-multi-platform**: Cross-platform builds

#### Legacy Bootstrap (`bootstrap-release.yml`)

- **Triggers**: Push to release branches
- **Purpose**: Maintains existing bootstrap releases

### Build Matrix

- **Platforms**: Linux, macOS, Windows
- **Python**: 3.13
- **Architecture**: ARM64 + x64 support

## 📦 Installation Methods

### 1. One-Line Install (Recommended)

```bash
curl -sSL https://raw.githubusercontent.com/sailfin/sailfin/main/install.sh | bash
```

### 2. Manual Download

- Visit [Releases](https://github.com/sailfin/sailfin/releases)
- Download platform-specific binary
- Add to PATH

### 3. Build from Source

```bash
git clone https://github.com/sailfin/sailfin.git
cd sailfin
./build.sh
# Binary will be in build/sfn
```

## 🧪 Testing

### Automated Tests

```bash
# Run all tests
./build.sh test

# Individual test suites
cd bootstrap && python test_all_examples.py  # 69 examples
cd bootstrap && python bootstrap.py ../compiler/parser.sfn  # Real compiler
```

### Manual Testing

```bash
# Test bootstrap
echo 'fn main() -> void { print.info("Hello!"); }' > test.sfn
sfn test.sfn

# Test self-hosting
./build.sh self-hosting
```

## 🌍 Supported Platforms

| Platform | Architecture | Status  | Binary Name |
| -------- | ------------ | ------- | ----------- |
| Linux    | x64          | ✅ Full | `sfn`       |
| Linux    | ARM64        | ✅ Full | `sfn`       |
| macOS    | x64          | ✅ Full | `sfn`       |
| macOS    | ARM64        | ✅ Full | `sfn`       |
| Windows  | x64          | 🚧 Beta | `sfn.exe`   |

## 🔍 Troubleshooting

### Common Issues

#### Installation Failed

```bash
# Check platform support
uname -a

# Manual download
wget https://github.com/sailfin/sailfin/releases/latest/download/sfn
chmod +x sfn
```

#### Build Errors

```bash
# Clean and rebuild
./build.sh clean
./build.sh

# Check dependencies
python --version  # Should be 3.13+
which clang       # For native compilation
```

#### Self-Hosting Issues

```bash
# Test individual components
cd bootstrap
python bootstrap.py ../compiler/lexer.sfn
python bootstrap.py ../compiler/parser.sfn
```

### Getting Help

- **Issues**: [GitHub Issues](https://github.com/sailfin/sailfin/issues)
- **Discussions**: [GitHub Discussions](https://github.com/sailfin/sailfin/discussions)
- **Documentation**: [Language Spec](../docs/spec.md)

## 🎉 Success Verification

After successful build, you should see:

```
🎉 Sailfin Self-Hosting Build Complete!

What was accomplished:
✅ Bootstrap compiler tested with all examples
✅ Real Sailfin compiler (lexer, parser, AST) compiles successfully
✅ Self-hosting compiler generated from Sailfin source
✅ Self-hosted compiler generates working ARM64 assembly
✅ Complete pipeline: Sailfin → Bootstrap → Self-Hosted → Native Code
```
