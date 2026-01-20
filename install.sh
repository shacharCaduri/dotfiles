#!/bin/bash
# Modular Development Environment Setup Script
# Version: 2.0

# Fail on any error and enable debugging
set -euo pipefail

# Logging and Error Handling
log() {
    echo "[DEV-ENV-SETUP] $1"
}

error_exit() {
    log "ERROR: $1"
    exit 1
}

# Configuration Management
CONFIG_DIR="$HOME/dotfiles"
LOGS_DIR="$CONFIG_DIR/logs"
mkdir -p "$LOGS_DIR"

# Modularity: Separate Configuration
source "$CONFIG_DIR/config.sh"

# Utility Functions
detect_package_manager() {
    local MANAGERS=("apt" "brew" "pacman" "yum")
    for PM in "${MANAGERS[@]}"; do
        if command -v "$PM" &> /dev/null; then
            PACKAGE_MANAGER="$PM"
            log "Detected package manager: $PACKAGE_MANAGER"
            return 0
        fi
    done
    error_exit "No supported package manager found"
}

# Modular Installation Functions
install_system_packages() {
    log "Installing system packages..."
    case "$PACKAGE_MANAGER" in
        apt)
            sudo apt update
            sudo apt install -y \
                build-essential \
                curl \
                git \
                wget \
                software-properties-common
            ;;
        brew)
            brew update
            brew install \
                gcc \
                git \
                curl \
                wget
            ;;
        *)
            error_exit "Package installation not supported for $PACKAGE_MANAGER"
            ;;
    esac
}

install_python() {
    log "Setting up Python 3.12 environment..."
    
    # Install pyenv if not exists
    if ! command -v pyenv &> /dev/null; then
        curl https://pyenv.run | bash
    fi
    
    # Add pyenv to PATH
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv virtualenv-init -)"
    
    # Install Python 3.12
    pyenv install 3.12.0 || true
    pyenv global 3.12.0
    
    # Install Python tools
    python3 -m pip install --user \
        poetry \
        pipx \
        virtualenv
    
    python3 -m pipx ensurepath
}

# Main Execution
main() {
    # Create dotfiles structure
    mkdir -p "$CONFIG_DIR/python"
    mkdir -p "$CONFIG_DIR/cpp"
    mkdir -p "$CONFIG_DIR/rust"
    mkdir -p "$CONFIG_DIR/docker"
    
    # Detect package manager
    detect_package_manager
    
    # Run modular installations
    install_system_packages
    install_python
    
    log "Development environment setup complete!"
}

# Run main function
main
