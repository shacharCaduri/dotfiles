#!/usr/bin/env bash
# Zsh and Oh My Zsh Comprehensive Setup Script

set -e  # Exit immediately if a command exits with a non-zero status

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log() {
    echo -e "${GREEN}[ZSH SETUP]${NC} $1"
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Check for required tools
check_dependencies() {
    log "Checking system dependencies..."
    local dependencies=("curl" "git" "zsh")
    for dep in "${dependencies[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            warning "$dep is not installed. Attempting to install..."
            install_dependency "$dep"
        fi
    done
}

# Install dependencies based on package manager
install_dependency() {
    local package="$1"
    if command -v apt &> /dev/null; then
        sudo apt update
        sudo apt install -y "$package"
    elif command -v brew &> /dev/null; then
        brew install "$package"
    elif command -v pacman &> /dev/null; then
        sudo pacman -S --noconfirm "$package"
    else
        warning "Couldn't find a package manager to install $package"
        exit 1
    fi
}

# Install Oh My Zsh
install_oh_my_zsh() {
    log "Installing Oh My Zsh..."
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    else
        log "Oh My Zsh is already installed"
    fi
}

# Install Powerlevel10k
install_powerlevel10k() {
    log "Installing Powerlevel10k theme..."
    local p10k_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    if [ ! -d "$p10k_dir" ]; then
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$p10k_dir"
    else
        log "Powerlevel10k is already installed"
    fi
}

# Install Zsh Plugins
install_zsh_plugins() {
    log "Installing Zsh plugins..."
    local plugins_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
    
    # Autosuggestions
    if [ ! -d "$plugins_dir/zsh-autosuggestions" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions "$plugins_dir/zsh-autosuggestions"
    fi
    
    # Syntax Highlighting
    if [ ! -d "$plugins_dir/zsh-syntax-highlighting" ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$plugins_dir/zsh-syntax-highlighting"
    fi
}

# Install Additional Tools
install_dev_tools() {
    log "Installing development tools..."
    
    # Pyenv
    if ! command -v pyenv &> /dev/null; then
        curl https://pyenv.run | bash
    fi
    
    # FZF
    if ! command -v fzf &> /dev/null; then
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install --all --no-bash --no-fish
    fi
    
    # Direnv
    if ! command -v direnv &> /dev/null; then
        if command -v apt &> /dev/null; then
            sudo apt update
            sudo apt install -y direnv
        elif command -v brew &> /dev/null; then
            brew install direnv
        fi
    fi
}

# Link configuration files
link_config_files() {
    log "Linking configuration files..."
    local dotfiles_dir="${1:-$HOME/dotfiles}"
    
    # Zsh config
    ln -sf "$dotfiles_dir/shell/.zshrc" "$HOME/.zshrc"
    
    # Powerlevel10k config
    ln -sf "$dotfiles_dir/shell/.p10k.zsh" "$HOME/.p10k.zsh"
}

# Main installation function
main() {
    local dotfiles_dir="${1:-$HOME/dotfiles}"
    
    check_dependencies
    install_oh_my_zsh
    install_powerlevel10k
    install_zsh_plugins
    install_dev_tools
    link_config_files "$dotfiles_dir"
    
    log "Zsh setup complete! Please restart your terminal or run 'zsh'."
}

# Run main function with optional dotfiles directory
main "$@"
