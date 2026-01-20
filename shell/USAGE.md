# Shell Configuration Usage Guide

## 🚀 Quick Start

### Installation
```bash
# Run the shell setup script
./install-zsh
```

## 🔧 Configuration Components

### 1. Zsh Configuration (`.zshrc`)
- Powerlevel10k prompt
- Oh My Zsh plugins
- Custom aliases and functions
- Development environment integrations

### 2. Key Features

#### Aliases
- `c`: Clear screen
- `..`: Navigate up one directory
- `...`: Navigate up two directories

#### Development Shortcuts
- `venv`: Automatically find and activate virtual environments
- `mkproject`: Quickly create new projects
  ```bash
  # Create a Python project
  mkproject myproject python
  
  # Create a Rust project
  mkproject myproject rust
  ```

## 💡 Customization

### Adding Plugins
1. Edit `.zshrc`
2. Add plugins to the `plugins` array
3. Restart terminal or run `source ~/.zshrc`

### Creating Custom Functions
- Add functions directly to `.zshrc`
- Use `source ~/.zshrc` to reload

## 🛠 Development Tools Integration

- Pyenv for Python version management
- Direnv for environment-specific configurations
- FZF for fuzzy finding
- Poetry for Python dependency management

## 🔍 Troubleshooting

- Verify configuration:
  ```bash
  echo $SHELL  # Should show /bin/zsh
  zsh --version
  ```
- Reset to default configuration:
  ```bash
  cp ~/dotfiles/shell/.zshrc ~/.zshrc
  ```

## 📋 Recommended Workflow

1. Run `./install-zsh`
2. Customize `.zshrc`
3. Add personal aliases and functions
4. Commit changes to dotfiles repository

## 🌈 Advanced Customization

- Use `~/.zshrc.local` for machine-specific configurations
- Leverage Powerlevel10k for prompt customization
- Explore Oh My Zsh plugin ecosystem
