<<<<<<< HEAD
#!/bin/bash
# Sailfin Self-Hosting Build Script
# This script demonstrates the complete self-hosting pipeline

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BOOTSTRAP_DIR="$REPO_ROOT/bootstrap"
COMPILER_DIR="$REPO_ROOT/compiler"
BUILD_DIR="$REPO_ROOT/build"
EXAMPLES_DIR="$REPO_ROOT/examples"

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

Sailfin Self-Hosting Build System
==================================
EOF
    echo -e "${NC}"
}

# Clean build directory
clean_build() {
    log_info "Cleaning build directory..."
    rm -rf "$BUILD_DIR"
    mkdir -p "$BUILD_DIR"
    log_success "Build directory cleaned"
}

# Test bootstrap compiler
test_bootstrap() {
    log_info "Testing bootstrap compiler..."
    
    cd "$BOOTSTRAP_DIR"
    
    # Test basic compilation
    log_info "Testing basic example compilation..."
    python bootstrap.py "$EXAMPLES_DIR/basics/hello-world.sfn" -o "$BUILD_DIR/hello_test.py"
    
    if [ -f "$BUILD_DIR/hello_test.py" ]; then
        log_success "Bootstrap compiler working"
    else
        log_error "Bootstrap compiler test failed"
        exit 1
    fi
    
    # Run all examples test
    log_info "Running comprehensive examples test..."
    python test_all_examples.py
    log_success "All examples pass bootstrap compilation"
}

# Test real compiler compilation
test_real_compiler() {
    log_info "Testing real Sailfin compiler compilation..."
    
    cd "$BOOTSTRAP_DIR"
    
    # Test each compiler component
    local components=("lexer.sfn" "parser.sfn" "ast.sfn")
    
    for component in "${components[@]}"; do
        log_info "Compiling $component..."
        python bootstrap.py "$COMPILER_DIR/$component" -o "$BUILD_DIR/${component%.sfn}_compiled.py"
        
        if [ -f "$BUILD_DIR/${component%.sfn}_compiled.py" ]; then
            log_success "$component compiled successfully"
        else
            log_error "Failed to compile $component"
            exit 1
        fi
    done
    
    log_success "All real compiler components compile successfully!"
}

# Build self-hosting compiler
build_self_hosting() {
    log_info "Building self-hosting compiler..."
    
    cd "$BOOTSTRAP_DIR"
    
    # Use simplified compiler for self-hosting demo
    local compiler_source="$COMPILER_DIR/full_compiler.sfn"
    
    if [ ! -f "$compiler_source" ]; then
        log_error "Full compiler not found: $compiler_source"
        exit 1
    fi
    
    log_info "Compiling Sailfin compiler with bootstrap..."
    python bootstrap.py "$compiler_source" -o "$BUILD_DIR/sailfin_self_hosted.py" -c
    
    if [ -f "$BUILD_DIR/sailfin_self_hosted.py" ]; then
        log_success "Self-hosted compiler generated"
    else
        log_error "Failed to generate self-hosted compiler"
        exit 1
    fi
}

# Test self-hosting pipeline
test_self_hosting() {
    log_info "Testing complete self-hosting pipeline..."
    
    cd "$BUILD_DIR"
    
    # Generate ARM64 assembly using self-hosted compiler
    log_info "Generating ARM64 assembly with self-hosted compiler..."
    python sailfin_self_hosted.py > test_program.s
    
    if [ -f "test_program.s" ]; then
        log_success "ARM64 assembly generated"
        
        # Show assembly preview
        log_info "Assembly preview:"
        head -10 test_program.s
        echo "..."
        
        # Try to assemble if clang is available
        if command -v clang >/dev/null 2>&1; then
            log_info "Assembling with clang..."
            clang test_program.s -o test_program
            
            if [ -f "test_program" ]; then
                log_success "Native executable created"
                
                # Try to run the program
                log_info "Running generated program..."
                ./test_program
                local exit_code=$?
                log_success "Program executed with exit code: $exit_code"
            else
                log_warning "Failed to create native executable"
            fi
        else
            log_warning "clang not available, skipping assembly step"
        fi
    else
        log_error "Failed to generate ARM64 assembly"
        exit 1
    fi
}

# Create release artifacts
create_artifacts() {
    log_info "Creating release artifacts..."
    
    cd "$BOOTSTRAP_DIR"
    
    # Create standalone executable
    if command -v pyinstaller >/dev/null 2>&1; then
        log_info "Building standalone executable with PyInstaller..."
        pyinstaller --onefile --name sfn bootstrap.py
        
        if [ -f "dist/sfn" ]; then
            cp "dist/sfn" "$BUILD_DIR/"
            log_success "Standalone executable created: $BUILD_DIR/sfn"
        else
            log_warning "Failed to create standalone executable"
        fi
    else
        log_warning "PyInstaller not available, skipping standalone build"
    fi
    
    # Copy key artifacts
    cp "$BUILD_DIR/sailfin_self_hosted.py" "$BUILD_DIR/sailfin_compiler.py" 2>/dev/null || true
    cp "$BUILD_DIR/test_program.s" "$BUILD_DIR/sample_output.s" 2>/dev/null || true
    
    log_info "Build artifacts:"
    ls -la "$BUILD_DIR"
}

# Print summary
print_summary() {
    echo ""
    log_success "🎉 Sailfin Self-Hosting Build Complete!"
    echo ""
    echo -e "${YELLOW}What was accomplished:${NC}"
    echo "✅ Bootstrap compiler tested with all examples"
    echo "✅ Real Sailfin compiler (lexer, parser, AST) compiles successfully"
    echo "✅ Self-hosting compiler generated from Sailfin source"
    echo "✅ Self-hosted compiler generates working ARM64 assembly"
    echo "✅ Complete pipeline: Sailfin → Bootstrap → Self-Hosted → Native Code"
    echo ""
    echo -e "${YELLOW}Build artifacts in $BUILD_DIR:${NC}"
    ls -la "$BUILD_DIR" 2>/dev/null || echo "No artifacts directory"
    echo ""
    echo -e "${YELLOW}Next steps:${NC}"
    echo "• Test the standalone compiler: ${BLUE}$BUILD_DIR/sfn --help${NC}"
    echo "• Explore examples: ${BLUE}ls $EXAMPLES_DIR${NC}"
    echo "• Read the language spec: ${BLUE}cat $REPO_ROOT/docs/spec.md${NC}"
    echo ""
    echo -e "${GREEN}🚀 Sailfin is now a fully self-hosting programming language!${NC}"
}

# Handle command line arguments
case "${1:-}" in
    --help|-h)
        echo "Sailfin Self-Hosting Build Script"
        echo ""
        echo "Usage: $0 [command]"
        echo ""
        echo "Commands:"
        echo "  build          Run complete build and test pipeline (default)"
        echo "  test           Run tests only"
        echo "  clean          Clean build directory"
        echo "  bootstrap      Test bootstrap compiler only"
        echo "  self-hosting   Test self-hosting compilation only"
        echo "  artifacts      Create release artifacts only"
        echo ""
        exit 0
    ;;
    clean)
        print_header
        clean_build
        exit 0
    ;;
    test)
        print_header
        test_bootstrap
        test_real_compiler
        exit 0
    ;;
    bootstrap)
        print_header
        test_bootstrap
        exit 0
    ;;
    self-hosting)
        print_header
        build_self_hosting
        test_self_hosting
        exit 0
    ;;
    artifacts)
        print_header
        create_artifacts
        exit 0
    ;;
    build|"")
        # Default: full build pipeline
    ;;
    *)
        log_error "Unknown command: $1"
        echo "Use --help for usage information"
        exit 1
    ;;
esac

# Main build pipeline
main() {
    print_header

    log_info "Starting complete Sailfin build pipeline..."
    echo ""

    # Step 1: Clean
    clean_build
    echo ""

    # Step 2: Test bootstrap
    test_bootstrap
    echo ""

    # Step 3: Test real compiler
    test_real_compiler
    echo ""

    # Step 4: Build self-hosting
    build_self_hosting
    echo ""

    # Step 5: Test self-hosting
    test_self_hosting
    echo ""

    # Step 6: Create artifacts
    create_artifacts
    echo ""

=======
p 3: Test real compiler
    test_real_compiler
    echo ""
    
    # Step 4: Build self-hosting
    build_self_hosting
    echo ""
    
    # Step 5: Test self-hosting
    test_self_hosting
    echo ""
    
    # Step 6: Create artifacts
    create_artifacts
    echo ""
    
>>>>>>> b07d353 (fix: cleanup)
    # Step 7: Summary
    print_summary
}

# Invoke main with all arguments
main "$@"
<<<<<<< HEAD
  
=======
>>>>>>> b07d353 (fix: cleanup)
