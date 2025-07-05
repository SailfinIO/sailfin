# 🚢 Sailfin Programming Language

[![CI](https://github.com/sailfin/sailfin/workflows/Sailfin%20Full%20Pipeline%20CI/badge.svg)](https://github.com/sailfin/sailfin/actions)
[![Release](https://img.shields.io/github/v/release/sailfin/sailfin)](https://github.com/sailfin/sailfin/releases)
[![License](https://img.shields.io/github/license/sailfin/sailfin)](LICENSE)

**Sailfin** is a modern, statically-typed programming language with **true self-hosting compilation** to native ARM64 assembly. Sailfin can compile itself and generate working native executables.

## ✨ Key Features

- 🚀 **Self-Hosting**: Compiler written in Sailfin compiles itself
- ⚡ **Native Compilation**: Direct ARM64 assembly generation
- 🔒 **Static Typing**: Compile-time type checking with inference
- 🧩 **Modern Syntax**: Clean, readable syntax inspired by Rust and TypeScript
- 🏗️ **Powerful Type System**: Structs, interfaces, generics, and unions
- 🔄 **Memory Safety**: Compile-time mutability checking
- 📦 **Zero Dependencies**: Standalone compiler and runtime

## 🚀 Quick Start

### One-Line Installation
```bash
curl -sSL https://raw.githubusercontent.com/sailfin/sailfin/main/install.sh | bash
```

### Hello World
```sailfin
fn main() -> void {
    print.info("Hello, Sailfin! 🚢");
}
```

```bash
echo 'fn main() -> void { print.info("Hello, Sailfin! 🚢"); }' > hello.sfn
sfn hello.sfn
```

## 📖 Language Examples

### Variables and Types
```sailfin
let name: string = "Sailfin";
mut counter: number = 0;
let isActive: bool = true;
let numbers: number[] = [1, 2, 3, 4, 5];
```

### Functions
```sailfin
fn add(x: number, y: number) -> number {
    return x + y;
}

fn greet(name: string) -> string {
    return "Hello, " + name + "!";
}
```

### Structs and Methods
```sailfin
struct Person {
    name: string;
    age: number;

    fn greet(self) -> string {
        return "Hi, I'm " + self.name;
    }
}

let person: Person = new Person { name: "Alice", age: 30 };
print.info(person.greet());
```

### Control Flow
```sailfin
if age >= 18 {
    print.info("Adult");
} else {
    print.info("Minor");
}

mut i: number = 0;
while i < 5 {
    print.info("Count: " + i.toString());
    i = i + 1;
}
```

## 🛠️ Installation & Build

### Quick Install (Recommended)
```bash
# Install latest release
curl -sSL https://raw.githubusercontent.com/sailfin/sailfin/main/install.sh | bash

# Verify installation
sfn --version
```

### Build from Source
```bash
# Clone repository
git clone https://github.com/sailfin/sailfin.git
cd sailfin

# Run complete build pipeline
make build
# or
./build.sh

# Install built binary
make install
```

### Development Setup
```bash
# Test bootstrap compiler
make bootstrap

# Test self-hosting compilation
make self-hosting

# Run all tests
make test
```

## 🎯 Self-Hosting Architecture

Sailfin demonstrates true self-hosting compilation:

```
📝 Sailfin Source (.sfn)
        ↓
🐍 Bootstrap Compiler (Python)
        ↓  
🚢 Self-Hosted Compiler (Sailfin)
        ↓
🏗️ ARM64 Assembly (.s)
        ↓
⚡ Native Executable
```

### Proof of Self-Hosting
- ✅ **Bootstrap**: Python compiler handles 69/69 examples (100%)
- ✅ **Real Compiler**: All `compiler/*.sfn` files compile successfully  
- ✅ **Self-Hosting**: Sailfin compiler compiles itself
- ✅ **Native Output**: Generates working ARM64 assembly
- ✅ **Execution**: Native executables run correctly

## 📚 Documentation

- **[Language Specification](docs/spec.md)** - Complete language reference
- **[Build System](BUILD.md)** - Build and CI documentation  
- **[Examples](examples/)** - 69 working example programs
- **[Keywords](docs/keywords.md)** - Reserved words and syntax
- **[Package Management](docs/package-management.md)** - Module system

## 🗂️ Project Structure

```
sailfin/
├── 🐍 bootstrap/           # Python bootstrap compiler  
├── 🚢 compiler/            # Self-hosting Sailfin compiler
├── 📝 examples/            # Example programs (69 total)
├── 📖 docs/               # Language documentation
├── 🔧 extension/          # VS Code extension
├── ⚙️ .github/workflows/  # CI/CD pipelines
├── 🚀 install.sh          # One-line installer
├── 🏗️ build.sh           # Build system
└── 📋 Makefile           # Build convenience wrapper
```

## 🧪 Examples & Testing

Sailfin includes 69 working examples covering:

- **Basics**: Variables, functions, control flow, arrays
- **Advanced**: Generics, async/await, interfaces, unions
- **Algorithms**: Sorting, searching, data structures  
- **Concurrency**: Channels, routines, parallel processing
- **Web**: HTTP servers, REST APIs, WebSocket chat
- **I/O**: File operations, network requests

```bash
# Run all examples
cd bootstrap && python test_all_examples.py

# Test specific example
sfn examples/basics/hello-world.sfn
sfn examples/advanced/generic-structures.sfn
sfn examples/web/http-server.sfn
```

## 🌟 Why Sailfin?

1. **🎓 Educational**: Perfect for learning language implementation
2. **🔬 Research**: Demonstrates self-hosting compilation techniques  
3. **⚡ Performance**: Direct native code generation
4. **🛡️ Safety**: Compile-time error checking and memory safety
5. **🧹 Simplicity**: Clean syntax without runtime overhead
6. **🔧 Tooling**: VS Code extension with syntax highlighting

## 🤝 Contributing

We welcome contributions! See our [Contributing Guide](CONTRIBUTING.md) for details.

### Development Workflow
```bash
# Fork and clone the repository
git clone https://github.com/your-username/sailfin.git
cd sailfin

# Make changes and test
make test

# Create pull request
```

## 📊 Status

- **Language**: ✅ Feature complete for core programming
- **Compiler**: ✅ Self-hosting and generating native code
- **Examples**: ✅ 69/69 examples working (100%)
- **Documentation**: ✅ Complete language specification
- **CI/CD**: ✅ Full build and test pipeline
- **Distribution**: ✅ Cross-platform installers

## 📜 License

Sailfin is licensed under the [MIT License](LICENSE).

## 🙏 Acknowledgments

- Inspired by Rust's ownership model and TypeScript's type system
- Bootstrap implementation using Python for rapid prototyping
- ARM64 assembly generation following Apple Silicon conventions

---

<div align="center">

**🚢 Ready to set sail with Sailfin? 🚢**

[Install Now](https://raw.githubusercontent.com/sailfin/sailfin/main/install.sh) • [Examples](examples/) • [Documentation](docs/) • [VS Code Extension](extension/)

</div>
