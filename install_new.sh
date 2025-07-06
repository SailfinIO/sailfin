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

# Logging functions
log_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

log_success() {
    echo -e "${GREEN}✅${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

log_error() {
    echo -e "${RED}❌${NC} $1"
}

# Platform detection
detect_platform() {
    local os
    local arch
    
    case "$OSTYPE" in
        linux*)   os="Linux" ;;
        darwin*)  os="Darwin" ;;
        cygwin*)  os="Windows" ;;
        msys*)    os="Windows" ;;
        win32*)   os="Windows" ;;
        *)        os="unknown" ;;
    esac
    
    case "$(uname -m)" in
        x86_64)   arch="x86_64" ;;
        aarch64)  arch="arm64" ;;
        arm64)    arch="arm64" ;;
        *)        arch="x86_64" ;;
    esac
    
    if [ "$os" = "unknown" ]; then
        log_error "Unsupported operating system: $OSTYPE"
        exit 1
    fi
    
    if [ "$os" = "Windows" ]; then
        log_error "Windows support coming soon! Please use WSL for now."
        exit 1
    fi
    
    echo "${os}-${arch}"
}

# Get latest version from GitHub API
get_latest_version() {
    if [ "$VERSION" = "latest" ]; then
        local api_url="https://api.github.com/repos/$REPO/releases/latest"
        local version_info
        
        version_info=$(curl -s "$api_url" | grep '"tag_name"' | cut -d'"' -f4)
        
        if [ -z "$version_info" ] || [ "$version_info" = "null" ]; then
            log_warning "Could not fetch latest version, using 'latest'"
            echo "latest"
        else
            echo "$version_info"
        fi
    else
        echo "$VERSION"
    fi
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install Sailfin
install_sailfin() {
    local platform
    local version
    local download_url
    local temp_dir
    
    platform=$(detect_platform)
    version=$(get_latest_version)
    
    log_info "Installing Sailfin $version for $platform..."
    
    # Create temporary directory
    temp_dir=$(mktemp -d)
    cd "$temp_dir"
    
    # Download
    download_url="https://github.com/$REPO/releases/download/$version/sailfin-$platform.tar.gz"
    log_info "Downloading from: $download_url"
    
    if ! curl -L "$download_url" -o sailfin.tar.gz; then
        log_error "Failed to download Sailfin"
        log_info "URL: $download_url"
        exit 1
    fi
    
    # Extract
    log_info "Extracting archive..."
    tar -xzf sailfin.tar.gz
    
    # Install
    log_info "Installing to $INSTALL_DIR..."
    mkdir -p "$INSTALL_DIR"
    
    # Copy files (files are extracted directly from the archive)
    if [ -f "sfn" ]; then
        cp sfn "$INSTALL_DIR/"
        chmod +x "$INSTALL_DIR/sfn"
    else
        log_error "sfn binary not found in archive"
        exit 1
    fi
    
    if [ -f "sfn_compiler.py" ]; then
        cp sfn_compiler.py "$INSTALL_DIR/"
    fi
    
    # Clean up
    cd - > /dev/null
    rm -rf "$temp_dir"
    
    log_success "Sailfin installed successfully"
}

# Verify installation
verify_installation() {
    log_info "Verifying installation..."
    
    if [ ! -f "$INSTALL_DIR/$BINARY_NAME" ]; then
        log_error "Installation failed: $BINARY_NAME not found in $INSTALL_DIR"
        exit 1
    fi
    
    if [ ! -x "$INSTALL_DIR/$BINARY_NAME" ]; then
        log_error "Installation failed: $BINARY_NAME is not executable"
        exit 1
    fi
    
    # Test the binary
    local version_output
    version_output=$("$INSTALL_DIR/$BINARY_NAME" --version 2>/dev/null || echo "Sailfin Development Build")
    log_success "Sailfin version: $version_output"
}

# Check PATH
check_path() {
    if ! echo "$PATH" | grep -q "$INSTALL_DIR"; then
        log_warning "$INSTALL_DIR is not in your PATH"
        echo ""
        echo "Add this to your shell profile (~/.bashrc, ~/.zshrc, etc.):"
        echo "  export PATH=\"$INSTALL_DIR:\$PATH\""
        echo ""
        echo "Or run this command:"
        echo "  echo 'export PATH=\"$INSTALL_DIR:\$PATH\"' >> ~/.bashrc"
        echo "  source ~/.bashrc"
        echo ""
    else
        log_success "$INSTALL_DIR is in your PATH"
    fi
}

# Show success message
show_success() {
    echo ""
    log_success "🎉 Sailfin Self-Hosting Compiler installed successfully!"
    echo ""
    echo -e "${BLUE}Try these commands:${NC}"
    echo -e "  ${YELLOW}sfn --help${NC}                     # Show help"
    echo -e "  ${YELLOW}echo 'fn main() { print(\"Hello!\"); }' > hello.sfn && sfn hello.sfn${NC}  # Quick test"
    echo ""
    echo -e "${BLUE}Example usage:${NC}"
    echo -e "  ${YELLOW}# Create a simple program${NC}"
    echo -e "  ${YELLOW}echo 'fn main() -> void { print.info(\"Hello, Sailfin!\"); }' > hello.sfn${NC}"
    echo -e "  ${YELLOW}sfn hello.sfn${NC}"
    echo ""
    echo -e "${BLUE}🚢 Welcome to Sailfin - the self-hosting programming language!${NC}"
}

# Handle help
show_help() {
    echo "Sailfin Self-Hosting Compiler Installer"
    echo ""
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  --version VERSION    Install specific version (default: latest)"
    echo "  --install-dir DIR    Install to specific directory (default: ~/.local/bin)"
    echo "  --help               Show this help message"
    echo ""
    echo "Environment variables:"
    echo "  SAILFIN_VERSION      Version to install (default: latest)"
    echo ""
    echo "Examples:"
    echo "  $0                           # Install latest version"
    echo "  $0 --version v1.0.0          # Install specific version"
    echo "  $0 --install-dir /usr/local/bin  # Install system-wide"
}

# Handle command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --version)
            VERSION="$2"
            shift 2
        ;;
        --install-dir)
            INSTALL_DIR="$2"
            shift 2
        ;;
        --help)
            show_help
            exit 0
        ;;
        *)
            log_error "Unknown option: $1"
            echo "Use --help for usage information"
            exit 1
        ;;
    esac
done

# Main installation flow
main() {
    log_info "Starting Sailfin installation..."
    echo ""
    
    # Check dependencies
    if ! command_exists curl; then
        log_error "curl is required but not installed"
        exit 1
    fi
    
    if ! command_exists tar; then
        log_error "tar is required but not installed"
        exit 1
    fi
    
    # Install
    install_sailfin
    
    # Verify
    verify_installation
    
    # Check PATH
    check_path
    
    # Success
    show_success
}

# Handle interruption
trap 'echo -e "\n${RED}❌ Installation interrupted${NC}"; exit 1' INT TERM

# Run main installation
main "$@"
