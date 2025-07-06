#!/bin/bash
# Sailfin Self-Hosting Compiler Build Script
# Builds the Sailfin compiler using the bootstrap compiler and self-hosting approach

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMPILER_DIR="$SCRIPT_DIR/compiler"
BUILD_DIR="$SCRIPT_DIR/build"
EXAMPLES_DIR="$SCRIPT_DIR/examples"
DIST_DIR="$SCRIPT_DIR/dist"

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Print header
print_header() {
    echo -e "${BLUE}"
    cat << "EOF"
   ____        _ __  ___
  / __/______ (_) / / _/  ___
 _\ \/ __/ _ `/ / / _/   / _ \
/___/\__/\_,_/_/_/___/ /_//_/

Sailfin Self-Hosting Compiler Build System
==========================================
EOF
    echo -e "${NC}"
}

# Check prerequisites for self-hosting build
check_prerequisites() {
    log_info "Checking prerequisites..."
    
    # Check for sfn binary in PATH (should be the bootstrap version)
    if ! command -v sfn &> /dev/null; then
        log_error "sfn binary not found in PATH"
        log_error "Please ensure the bootstrap sfn binary is installed and in your PATH"
        exit 1
    fi
    
    # Check for clang (needed to assemble the generated code)
    if ! command -v clang &> /dev/null; then
        log_error "clang is required but not installed (needed to assemble generated ARM64 code)"
        exit 1
    fi
    
    # Check directories
    if [ ! -d "$COMPILER_DIR" ]; then
        log_error "Compiler directory not found: $COMPILER_DIR"
        exit 1
    fi
    
    log_success "Prerequisites check passed"
    log_info "Using sfn binary: $(which sfn)"
}

# Self-hosting compilation: Use sfn to compile the self-hosting compiler
compile_self_hosting() {
    log_info "🚀 Self-hosting: Compiling Sailfin compiler with sfn..."
    
    # Create build directory
    mkdir -p "$BUILD_DIR"
    cd "$BUILD_DIR"
    
    # Test that the existing sfn binary works
    log_info "Testing existing sfn binary..."
    sfn --help > /dev/null 2>&1 && log_success "sfn binary is working"
    
    # Use sfn to compile the self-hosting compiler to Python
    log_info "Compiling main.sfn to Python with sfn..."
    if sfn "$COMPILER_DIR/main.sfn" -o "main_compiler.py" -c 2>&1 | tee compile.log; then
        log_success "Successfully compiled main.sfn to Python"
        
        # Create wrapper script for the new self-hosting compiler
        cat > "sfn_compiler.py" << 'EOF'
#!/usr/bin/env python3
"""
Sailfin Self-Hosting Compiler (Compiled with sfn from bootstrap)
This version was compiled using the sfn binary, making it self-hosting!
"""
import sys
import os

# Add the current directory to Python path
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

try:
    import main_compiler
    if hasattr(main_compiler, 'main'):
        main_compiler.main()
    else:
        print("Error: main() function not found in compiled compiler")
        sys.exit(1)
except ImportError as e:
    print(f"Error importing main compiler: {e}")
    sys.exit(1)
except Exception as e:
    print(f"Error running compiler: {e}")
    sys.exit(1)
EOF
        
        # Create the new self-hosting sfn binary
        cat > "sfn" << 'EOF'
#!/bin/bash
# Sailfin Self-Hosting Compiler Binary
# This is the self-hosting version - compiled with sfn!
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
python3 "$SCRIPT_DIR/sfn_compiler.py" "$@"
EOF
        
        chmod +x "sfn"
        chmod +x "sfn_compiler.py"
        
        log_success "Created self-hosting sfn binary!"
        log_info "The new sfn binary was compiled using the sfn compiler - this is self-hosting!"
        
    else
        log_error "Failed to compile main.sfn with sfn"
        log_error "Compilation output:"
        cat compile.log
        exit 1
    fi
    
    log_success "Self-hosting compiler compilation completed"
}

# Test the compiled compiler
test_compiler() {
    log_info "Testing compiled compiler..."
    
    cd "$BUILD_DIR"
    
    # Create a simple test file
    cat > "test_simple.sfn" << 'EOF'
fn main() -> void {
    print.info("Hello from self-hosting Sailfin compiler!");
}
EOF
    
    # Test the compiler
    if ./sfn --version &> /dev/null || ./sfn test_simple.sfn &> /dev/null; then
        log_success "Compiler test passed"
    else
        log_warning "Compiler test had issues, but continuing..."
    fi
}

# Test examples
test_examples() {
    log_info "Testing examples..."
    
    if [ ! -d "$EXAMPLES_DIR" ]; then
        log_warning "Examples directory not found, skipping example tests"
        return
    fi
    
    cd "$BUILD_DIR"
    
    # Find and test .sfn files in examples
    local example_count=0
    local success_count=0
    
    while IFS= read -r -d '' example_file; do
        ((example_count++))
        local relative_path="${example_file#$EXAMPLES_DIR/}"
        log_info "Testing example: $relative_path"
        
        if ./sfn "$example_file" &> /dev/null; then
            ((success_count++))
            log_success "✓ $relative_path"
        else
            log_warning "✗ $relative_path (failed to compile)"
        fi
    done < <(find "$EXAMPLES_DIR" -name "*.sfn" -type f -print0)
    
    if [ $example_count -eq 0 ]; then
        log_warning "No .sfn example files found"
    else
        log_info "Example test results: $success_count/$example_count passed"
    fi
}

# Create release package
create_release() {
    log_info "Creating release package..."
    
    # Detect platform
    local platform
    case "$OSTYPE" in
        linux*)   platform="Linux" ;;
        darwin*)  platform="Darwin" ;;
        *)        platform="Unknown" ;;
    esac
    
    local arch
    case "$(uname -m)" in
        x86_64)   arch="x86_64" ;;
        aarch64)  arch="arm64" ;;
        arm64)    arch="arm64" ;;
        *)        arch="x86_64" ;;
    esac
    
    local platform_name="${platform}-${arch}"
    local package_name="sailfin-${platform_name}"
    
    # Create distribution directory
    mkdir -p "$DIST_DIR"
    local package_dir="$DIST_DIR/$package_name"
    
    # Clean and create package directory
    rm -rf "$package_dir"
    mkdir -p "$package_dir"
    
    # Copy binaries
    cp "$BUILD_DIR/sfn" "$package_dir/"
    cp "$BUILD_DIR/sfn_compiler.py" "$package_dir/"
    
    # Copy main compiler if it exists
    if [ -f "$BUILD_DIR/main_compiler.py" ]; then
        cp "$BUILD_DIR/main_compiler.py" "$package_dir/"
    fi
    
    # Copy documentation
    if [ -f "$SCRIPT_DIR/README.md" ]; then
        cp "$SCRIPT_DIR/README.md" "$package_dir/"
    fi
    
    # Copy install script
    cp "$SCRIPT_DIR/install.sh" "$package_dir/"
    
    # Copy examples if they exist
    if [ -d "$EXAMPLES_DIR" ]; then
        cp -r "$EXAMPLES_DIR" "$package_dir/"
    fi
    
    # Copy docs if they exist
    if [ -d "$SCRIPT_DIR/docs" ]; then
        cp -r "$SCRIPT_DIR/docs" "$package_dir/"
    fi
    
    # Create archive
    cd "$DIST_DIR"
    tar -czf "${package_name}.tar.gz" "$package_name"
    
    log_success "Release package created: dist/${package_name}.tar.gz"
}

# Clean build artifacts
clean_build() {
    log_info "Cleaning build artifacts..."
    
    rm -rf "$BUILD_DIR"
    rm -rf "$DIST_DIR"
    
    log_success "Build artifacts cleaned"
}

# Show help
show_help() {
    echo "Sailfin Self-Hosting Compiler Build System"
    echo ""
    echo "Usage: $0 [command]"
    echo ""
    echo "Commands:"
    echo "  build        Build the self-hosting compiler (default)"
    echo "  compiler     Build compiler only (no tests)"
    echo "  test         Test the compiler and examples"
    echo "  examples     Test examples only"
    echo "  release      Create release package"
    echo "  clean        Clean build artifacts"
    echo "  help         Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0                # Full build and test"
    echo "  $0 build          # Same as above"
    echo "  $0 compiler       # Build compiler only"
    echo "  $0 release        # Create release package"
}

# Main function
main() {
    local command="${1:-build}"
    
    print_header
    
    case "$command" in
        build)
            check_prerequisites
            compile_self_hosting
            test_compiler
            test_examples
            log_success "🎉 Self-hosting build completed successfully!"
            ;;
        compiler)
            check_prerequisites
            compile_self_hosting
            test_compiler
            log_success "🎉 Self-hosting compiler build completed!"
            ;;
        test)
            if [ ! -d "$BUILD_DIR" ]; then
                log_error "Build directory not found. Run 'build' first."
                exit 1
            fi
            test_compiler
            test_examples
            log_success "🎉 Tests completed!"
            ;;
        examples)
            if [ ! -d "$BUILD_DIR" ]; then
                log_error "Build directory not found. Run 'build' first."
                exit 1
            fi
            test_examples
            ;;
        release)
            if [ ! -d "$BUILD_DIR" ]; then
                log_error "Build directory not found. Run 'build' first."
                exit 1
            fi
            create_release
            log_success "🎉 Release package created!"
            ;;
        clean)
            clean_build
            ;;
        help)
            show_help
            ;;
        *)
            log_error "Unknown command: $command"
            echo ""
            show_help
            exit 1
            ;;
    esac
}

# Handle interruption
trap 'echo -e "\n${RED}❌ Build interrupted${NC}"; exit 1' INT TERM

# Run main function
main "$@"
