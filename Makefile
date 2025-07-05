# Sailfin Makefile
# Convenience wrapper around build.sh

.PHONY: all build test clean bootstrap self-hosting artifacts install help

# Default target
all: build

# Main build pipeline
build:
	@./build.sh build

# Run tests only
test:
	@./build.sh test

# Clean build directory
clean:
	@./build.sh clean

# Test bootstrap compiler
bootstrap:
	@./build.sh bootstrap

# Test self-hosting compilation
self-hosting:
	@./build.sh self-hosting

# Create release artifacts
artifacts:
	@./build.sh artifacts

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
	@echo "  all          Run complete build pipeline (default)"
	@echo "  build        Same as 'all'"
	@echo "  test         Run tests only"
	@echo "  clean        Clean build directory"
	@echo "  bootstrap    Test bootstrap compiler only"
	@echo "  self-hosting Test self-hosting compilation only"
	@echo "  artifacts    Create release artifacts"
	@echo "  install      Install Sailfin system-wide"
	@echo "  help         Show this help message"
	@echo ""
	@echo "Examples:"
	@echo "  make build       # Full build and test"
	@echo "  make test        # Run tests"
	@echo "  make install     # Install Sailfin"
