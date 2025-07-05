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
├── .github/workflows/       # CI/CD pipelines
│   ├── sailfin-ci.yml      # Main CI pipeline
│   └── bootstrap-release.yml # Legacy bootstrap release
├── bootstrap/               # Python bootstrap compiler
├── compiler/                # Self-hosting Sailfin compiler
├── examples/                # Example Sailfin programs
└── docs/                   # Documentation
```

## 🔧 Build Commands

### Complete Build Pipeline

```bash
./build.sh              # Run full build and test
./build.sh build         # Same as above
```

### Individual Components

```bash
./build.sh clean         # Clean build directory
./build.sh test          # Run tests only
./build.sh bootstrap     # Test bootstrap compiler
./build.sh self-hosting  # Test self-hosting compilation
./build.sh artifacts     # Create release artifacts
```

### Installation

```bash
# Install from latest release
curl -sSL https://raw.githubusercontent.com/sailfin/sailfin/main/install.sh | bash

# Install specific version
SAILFIN_VERSION=v0.1.0 curl -sSL https://raw.githubusercontent.com/sailfin/sailfin/main/install.sh | bash

# Manual installation
./install.sh --help
```

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
  - `full_compiler.sfn` → Complete compiler
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

This confirms Sailfin is fully self-hosting! 🚀
