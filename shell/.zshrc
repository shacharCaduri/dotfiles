# Comprehensive Zsh Configuration
# Author: Shachar Kaduri
# Version: 1.0

# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your dotfiles directory
export DOTFILES="$HOME/dotfiles"

# Oh My Zsh Configuration
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
  git
  github
  docker
  kubectl
  python
  pip
  poetry
  rust
  cargo
  vscode
  sudo
  copypath
  copyfile
  dirhistory
  z
  fzf
)

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh

# User Configuration
# Export PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.pyenv/bin:$PATH"

# Development Environment Setup
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(direnv hook zsh)"

# Aliases: Development
alias python=python3
alias pip=pip3
alias c=clear
alias ..='cd ..'
alias ...='cd ../..'

# Git Aliases
alias g=git
alias gs='git status'
alias gp='git pull'
alias gpu='git push'
alias gc='git commit'
alias gco='git checkout'

# Docker Aliases
alias d=docker
alias dc=docker-compose

# Utility Functions
# Quick directory navigation
md() { mkdir -p "$1" && cd "$1" }

# Find and activate Python virtual environment
venv() {
    local venv_path
    venv_path=$(find . -type d \( -name "venv" -o -name ".venv" \) -print -quit)
    if [[ -n "$venv_path" ]]; then
        source "$venv_path/bin/activate"
        echo "Activated virtual environment in $venv_path"
    else
        echo "No virtual environment found"
    fi
}

# Quick project setup
mkproject() {
    local project_name="$1"
    local project_type="${2:-python}"
    
    if [[ -z "$project_name" ]]; then
        echo "Please provide a project name"
        return 1
    fi
    
    mkdir -p "$project_name"
    cd "$project_name"
    
    case "$project_type" in
        python)
            python3 -m venv .venv
            source .venv/bin/activate
            touch README.md pyproject.toml
            echo "Created Python project: $project_name"
            ;;
        rust)
            cargo new "$project_name"
            cd "$project_name"
            echo "Created Rust project: $project_name"
            ;;
        *)
            echo "Unsupported project type. Use 'python' or 'rust'"
            return 1
            ;;
    esac
}

# Enhanced history search
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY

# FZF Configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load local customizations
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# Powerlevel10k Configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
