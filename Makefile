# Sailfin Makefile
# Primary build system for Sailfin programming language

.PHONY: all build test clean examples compiler install help

# Default target
all: build

# Main build pipeline - builds Sailfin compiler from source
build:
	@./build.sh build

# Run compiler and example tests
test:
	@./build.sh test

# Clean build directory
clean:
	@./build.sh clean

# Test all examples only
examples:
	@./build.sh examples

# Build compiler only (no tests)
compiler:
	@./build.sh compiler

# Install Sailfin (requires curl)
install:
	@echo "Installing Sailfin..."
	@curl -sSL https://raw.githubusercontent.com/sailfin/sailfin/main/install.sh | bash

# Show help
help:
	@echo "Sailfin Build System"
	@echo "==================="
	@echo ""
	@echo "Available targets:"
	@echo "  all          Build Sailfin compiler from source (default)"
	@echo "  build        Same as 'all'"
	@echo "  test         Run compiler and example tests"
	@echo "  clean        Clean build directory"
	@echo "  examples     Test all examples only"
	@echo "  compiler     Build compiler only (no tests)"
	@echo "  install      Install Sailfin system-wide"
	@echo "  help         Show this help message"
	@echo ""
	@echo "Examples:"
	@echo "  make build       # Full build and test"
	@echo "  make test        # Run tests"
	@echo "  make install     # Install Sailfin"
