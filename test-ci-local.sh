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
*)        os="unknown" ;;
esac

case "$(uname -m)" in
x86_64)  arch="x64" ;;
arm64)   arch="arm64" ;;
aarch64) arch="arm64" ;;
*)       arch="unknown" ;;
esac

echo "$os"
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
