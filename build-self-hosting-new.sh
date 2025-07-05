#!/bin/bash
# Sailfin Self-Hosting Compiler Installer
# curl -sSL https://github.com/sailfin/sailfin/releases/latest/download/install.sh | bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
REPO="sailfin/sailfin"
BINARY_NAME="sfn"
INSTALL_DIR="$HOME/.local/bin"
VERSION="${SAILFIN_VERSION:-latest}"

echo -e "${BLUE}"
cat << "EOF"
  _________      .__.__   _____.__
 /   _____/____  |__|  |_/ ____\__| ____
 \_____  \\__  \ |  |  |\   __\|  |/    \
 /        \/ __ \|  |  |_|  |  |  |   |  \
/_______  (____  /__|____/__|  |__|___|  /
        \/     \/                      \/

🚢 Sailfin Self-Hosting Compiler Installer
=========================================
EOF
echo -e "${NC}"

# Platform detection
detect_platform() {
    local os
    local arch
    
    case "$OSTYPE" in
        linux*)   os="linux" ;;
        darwin*)  os="macos" ;;
        cygwin*)  os="windows" ;;
        msys*)    os="windows" ;;
        win32*)   os="windows" ;;
        *)        os="unknown" ;;
    esac
    
    case "$(uname -m)" in
        x86_64)   arch="x64" ;;
        aarch64)  arch="arm64" ;;
        arm64)    arch="arm64" ;;
        *)        arch="x64" ;;
    esac
    
    if [ "$os" = "unknown" ]; then
        echo -e "${RED}❌ Unsupported operating system: $OSTYPE${NC}"
        exit 1
    fi
    
    if [ "$os" = "windows" ]; then
        echo -e "${RED}❌ Windows support coming soon! Please use WSL for now.${NC}"
        exit 1
    fi
    
    echo "${os}-${arch}"
}

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

# Check if command exists
command_exists() {
command -v "$1" >/dev/null 2>&1
}

# Download release asset
download_release() {
local platform="$1"
local download_url
local asset_name

if [ "$VERSION" = "latest" ]; then
log_info "Fetching latest release information..."
local api_url="https://api.github.com/repos/$REPO/releases/latest"
local release_info

if command_exists curl; then
release_info=$(curl -s "$api_url")
elif command_exists wget; then
release_info=$(wget -qO- "$api_url")
else
log_error "Neither curl nor wget is available. Please install one of them."
exit 1
fi

# Extract download URL for the platform
case "$platform" in
"Linux")
    asset_name="sailfin-Linux"
;;
"macOS")
    asset_name="sailfin-macOS"
;;
"Windows")
    asset_name="sailfin-Windows"
;;
*)
    log_error "Unsupported platform: $platform"
    exit 1
;;
esac

download_url=$(echo "$release_info" | grep -o "https://github.com/${REPO}/releases/download/[^\"]*${asset_name}[^\"]*" | head -1)

if [ -z "$download_url" ]; then
log_warning "No pre-built binary found for $platform. Falling back to universal binary."
download_url=$(echo "$release_info" | grep -o "https://github.com/$REPO/releases/download/[^\"]*sfn[^\"]*" | head -1)
fi
else
download_url="https://github.com/$REPO/releases/download/$VERSION/sailfin-$platform"
fi

if [ -z "$download_url" ]; then
log_error "Could not find download URL for Sailfin $VERSION on $platform"
exit 1
fi

log_info "Downloading from: $download_url"

# Create install directory
mkdir -p "$INSTALL_DIR"

# Download the binary
local temp_file="$(mktemp)"
if command_exists curl; then
curl -L -o "$temp_file" "$download_url"
elif command_exists wget; then
wget -O "$temp_file" "$download_url"
fi

# Install the binary
mv "$temp_file" "$INSTALL_DIR/$BINARY_NAME"
chmod +x "$INSTALL_DIR/$BINARY_NAME"
}

# Add to PATH
add_to_path() {
local shell_rc=""

case "$SHELL" in
*/bash) shell_rc="$HOME/.bashrc" ;;
*/zsh)  shell_rc="$HOME/.zshrc" ;;
*/fish) shell_rc="$HOME/.config/fish/config.fish" ;;
*)      shell_rc="$HOME/.profile" ;;
esac

if [ ! -f "$shell_rc" ]; then
touch "$shell_rc"
fi

if ! grep -q "$INSTALL_DIR" "$shell_rc"; then
log_info "Adding $INSTALL_DIR to PATH in $shell_rc"
echo "" >> "$shell_rc"
echo "# Added by Sailfin installer" >> "$shell_rc"
echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >> "$shell_rc"
log_success "Added $INSTALL_DIR to PATH"
else
log_info "$INSTALL_DIR already in PATH"
fi
}

# Verify installation
verify_installation() {
if [ -x "$INSTALL_DIR/$BINARY_NAME" ]; then
log_success "Sailfin installed successfully!"
log_info "Binary location: $INSTALL_DIR/$BINARY_NAME"

# Test the binary
if "$INSTALL_DIR/$BINARY_NAME" --version >/dev/null 2>&1; then
local version_output=$("$INSTALL_DIR/$BINARY_NAME" --version 2>/dev/null || echo "Sailfin Development Build")
log_success "Installation verified: $version_output"
else
log_info "Binary installed (version check not available in this build)"
fi

return 0
else
log_error "Installation failed: binary not found at $INSTALL_DIR/$BINARY_NAME"
return 1
fi
}

# Print usage instructions
print_usage() {
    cat << EOF

${GREEN}🎉 Sailfin Installation Complete!${NC}

${YELLOW}Getting Started:${NC}
1. Restart your terminal or run: ${BLUE}source ~/.bashrc${NC} (or your shell's rc file)
2. Create a hello.sfn file:
   ${BLUE}echo 'fn main() -> void { print.info("Hello, Sailfin!"); }' > hello.sfn${NC}
3. Compile and run:
   ${BLUE}sfn hello.sfn${NC}

${YELLOW}Documentation:${NC}
• Examples: https://github.com/sailfin/sailfin/tree/main/examples
• Language Guide: https://github.com/sailfin/sailfin/blob/main/docs/spec.md
• VS Code Extension: Search "Sailfin" in VS Code marketplace

${YELLOW}Self-Hosting Compiler:${NC}
Sailfin can compile itself! Check out the compiler source code at:
https://github.com/sailfin/sailfin/tree/main/compiler

${YELLOW}Need Help?${NC}
• Report issues: https://github.com/sailfin/sailfin/issues
• Discussions: https://github.com/sailfin/sailfin/discussions

EOF
}

# Main installation process
main() {
echo -e "${BLUE}"
    cat << "EOF"
   ____        _ __  ___
  / __/______ (_) / / _/  ___
 _\ \/ __/ _ `/ / / _/   / _ \
/___/\__/\_,_/_/_/___/ /_//_/

Sailfin Programming Language Installer
EOF
echo -e "${NC}"

log_info "Starting Sailfin installation..."

# Detect platform
local platform
platform=$(detect_platform)
log_info "Detected platform: $platform"

if [ "$platform" = "unknown" ]; then
log_error "Unsupported platform. Please visit https://github.com/sailfin/sailfin/releases for manual installation."
exit 1
fi

# Check dependencies
if ! command_exists curl && ! command_exists wget; then
log_error "Neither curl nor wget is available. Please install one of them and try again."
exit 1
fi

# Download and install
download_release "$platform"

# Add to PATH
add_to_path

# Verify installation
if verify_installation; then
print_usage
else
log_error "Installation verification failed"
exit 1
fi
}

# Handle command line arguments
case "${1:-}" in
--help|-h)
echo "Sailfin Programming Language Installer"
echo ""
echo "Usage: $0 [options]"
echo ""
echo "Options:"
echo "  --help, -h      Show this help message"
echo "  --version, -v   Install specific version (default: latest)"
echo ""
echo "Environment Variables:"
echo "  SAILFIN_VERSION Set specific version to install"
echo ""
echo "Examples:"
echo "  $0              # Install latest version"
echo "  SAILFIN_VERSION=v0.1.0 $0  # Install specific version"
exit 0
;;
--version|-v)
VERSION="$2"
shift 2
;;
"")
# Default behavior, continue to main
;;
*)
log_error "Unknown option: $1"
echo "Use --help for usage information"
exit 1
;;
esac

# Run main installation
main "$@"
    
    # Check if we're in CI and need to download official compiler
    if [ -n "$CI" ] || [ -n "$GITHUB_ACTIONS" ]; then
        # Try to download latest release
        log_info "CI environment detected, downloading latest Sailfin release..."
        
        # Create dist directory if it doesn't exist
        mkdir -p "$DIST_DIR"
        
        # Download latest release (adjust URL as needed)
        # For now, we'll build using bootstrap since this is the first self-hosting build
        log_warning "Official release not yet available, will build using bootstrap"
        return 1
    fi
    return 1
}

# Build self-hosting compiler using bootstrap (initial build only)
build_compiler_bootstrap() {
    log_info "Building self-hosting compiler using bootstrap..."
    
    cd "$BOOTSTRAP_DIR"
    
    # Check if bootstrap dependencies are installed
    if [ ! -d "venv" ] && [ ! -f ".venv/bin/activate" ]; then
        log_info "Installing bootstrap dependencies..."
        if command -v poetry &> /dev/null; then
            poetry install --no-interaction
        else
            python -m pip install -r requirements.txt 2>/dev/null || true
        fi
    fi
    
    # Build the self-hosting compiler
    log_info "Compiling self-hosting Sailfin compiler..."
    python bootstrap.py "$COMPILER_DIR/compiler.sfn" -o "$BUILD_DIR/sfn_compiler.py"
    
    # Create wrapper script for the compiler
    cat > "$BUILD_DIR/sfn" << 'EOF'
#!/bin/bash
# Sailfin Self-Hosting Compiler Wrapper
python "$(dirname "$0")/sfn_compiler.py" "$@"
EOF
    chmod +x "$BUILD_DIR/sfn"
    
    cd "$REPO_ROOT"
    log_success "Self-hosting compiler built successfully"
}

# Build using existing self-hosting compiler
build_compiler_selfhosted() {
    local sfn_binary="$1"
    log_info "Building using self-hosting Sailfin compiler: $sfn_binary"
    
    # Build the compiler using itself
    "$sfn_binary" "$COMPILER_DIR/compiler.sfn" -o "$BUILD_DIR/sfn_compiler_new.py"
    
    # Create new wrapper
    cat > "$BUILD_DIR/sfn_new" << 'EOF'
#!/bin/bash
# Sailfin Self-Hosting Compiler Wrapper
python "$(dirname "$0")/sfn_compiler_new.py" "$@"
EOF
    chmod +x "$BUILD_DIR/sfn_new"
    
    # Replace old compiler with new one
    mv "$BUILD_DIR/sfn_new" "$BUILD_DIR/sfn"
    mv "$BUILD_DIR/sfn_compiler_new.py" "$BUILD_DIR/sfn_compiler.py"
    
    log_success "Self-hosting compiler rebuilt using itself"
}

# Build the Sailfin compiler
build_compiler() {
    log_info "Building Sailfin self-hosting compiler..."
    
    mkdir -p "$BUILD_DIR"
    mkdir -p "$DIST_DIR"
    
    # Try to use existing self-hosting compiler first
    if check_selfhosting_capability; then
        # Find the compiler binary
        local sfn_binary=""
        if [ -f "$DIST_DIR/sfn" ]; then
            sfn_binary="$DIST_DIR/sfn"
        elif [ -f "$BUILD_DIR/sfn" ]; then
            sfn_binary="$BUILD_DIR/sfn"
        elif [ -f "./sfn" ]; then
            sfn_binary="./sfn"
        fi
        
        build_compiler_selfhosted "$sfn_binary"
    else
        # Try to download official compiler (for CI)
        if ! download_official_compiler; then
            # Fall back to bootstrap build
            build_compiler_bootstrap
        fi
    fi
    
    # Copy to dist for distribution
    cp "$BUILD_DIR/sfn" "$DIST_DIR/sfn"
    cp "$BUILD_DIR/sfn_compiler.py" "$DIST_DIR/sfn_compiler.py"
    
    log_success "Sailfin compiler built and ready for distribution"
}

# Test the compiler
test_compiler() {
    log_info "Testing Sailfin compiler..."
    
    if [ ! -f "$BUILD_DIR/sfn" ]; then
        log_error "Compiler not found. Run build first."
        exit 1
    fi
    
    # Test basic compilation
    local test_file="$EXAMPLES_DIR/basics/hello-world.sfn"
    if [ -f "$test_file" ]; then
        log_info "Testing compiler with hello-world example..."
        "$BUILD_DIR/sfn" "$test_file" > /dev/null
        log_success "Compiler test passed"
    else
        log_warning "Test file not found: $test_file"
    fi
}

# Test all examples
test_examples() {
    log_info "Testing all examples..."
    
    cd "$BOOTSTRAP_DIR"
    python test_all_examples.py
    cd "$REPO_ROOT"
    
    log_success "All examples tested"
}

# Create release package
create_release() {
    log_info "Creating release package..."
    
    if [ ! -f "$DIST_DIR/sfn" ]; then
        log_error "Compiler not found in dist. Run build first."
        exit 1
    fi
    
    # Create release directory
    local release_dir="$BUILD_DIR/sailfin-release"
    rm -rf "$release_dir"
    mkdir -p "$release_dir"
    
    # Copy binaries
    cp "$DIST_DIR/sfn" "$release_dir/"
    cp "$DIST_DIR/sfn_compiler.py" "$release_dir/"
    
    # Copy documentation
    cp "$REPO_ROOT/README.md" "$release_dir/"
    cp -r "$REPO_ROOT/docs" "$release_dir/" 2>/dev/null || true
    cp -r "$REPO_ROOT/examples" "$release_dir/" 2>/dev/null || true
    
    # Create install script
    cat > "$release_dir/install.sh" << 'EOF'
#!/bin/bash
# Sailfin Installer
set -e

echo "Installing Sailfin..."

# Copy to /usr/local/bin or ~/.local/bin
if [ -w "/usr/local/bin" ]; then
    cp sfn /usr/local/bin/
    cp sfn_compiler.py /usr/local/bin/
    echo "Installed to /usr/local/bin/"
else
    mkdir -p "$HOME/.local/bin"
    cp sfn "$HOME/.local/bin/"
    cp sfn_compiler.py "$HOME/.local/bin/"
    echo "Installed to $HOME/.local/bin/"
    echo "Add $HOME/.local/bin to your PATH if not already added"
fi

echo "Sailfin installed successfully!"
echo "Try: sfn --help"
EOF
    chmod +x "$release_dir/install.sh"
    
    # Create tarball
    cd "$BUILD_DIR"
    tar -czf "sailfin-$(uname -s)-$(uname -m).tar.gz" sailfin-release
    cd "$REPO_ROOT"
    
    log_success "Release package created: $BUILD_DIR/sailfin-$(uname -s)-$(uname -m).tar.gz"
}

# Main build function
main_build() {
    clean_build
    build_compiler
    test_compiler
    create_release
    
    log_success "Build completed successfully!"
    echo ""
    echo -e "${BLUE}🎉 Sailfin Self-Hosting Build Complete!${NC}"
    echo ""
    echo -e "${YELLOW}Compiler available at:${NC} $BUILD_DIR/sfn"
    echo -e "${YELLOW}Release package:${NC} $BUILD_DIR/sailfin-$(uname -s)-$(uname -m).tar.gz"
    echo ""
    echo -e "${GREEN}🚀 Sailfin is now fully self-hosting!${NC}"
}

# Handle command line arguments
case "${1:-}" in
    --help|-h)
        echo "Sailfin Self-Hosting Build System"
        echo ""
        echo "Usage: $0 [command]"
        echo ""
        echo "Commands:"
        echo "  build          Build Sailfin compiler and create release (default)"
        echo "  compiler       Build compiler only"
        echo "  test           Test compiler and examples"
        echo "  examples       Test all examples only"
        echo "  release        Create release package"
        echo "  clean          Clean build directory"
        echo ""
        exit 0
    ;;
    clean)
        print_header
        clean_build
        exit 0
    ;;
    compiler)
        print_header
        build_compiler
        exit 0
    ;;
    test)
        print_header
        test_compiler
        test_examples
        exit 0
    ;;
    examples)
        print_header
        test_examples
        exit 0
    ;;
    release)
        print_header
        create_release
        exit 0
    ;;
    build|"")
        print_header
        main_build
        exit 0
    ;;
    *)
        log_error "Unknown command: $1"
        echo "Use --help for usage information"
        exit 1
    ;;
esac
