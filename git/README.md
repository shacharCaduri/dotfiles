# Git Configuration Usage Guide

## 🛠 Configuration Components

### 1. Environment Variable Setup
- Run the interactive environment configuration script
  ```bash
  ./git-env-setup
  ```
- This script will:
  - Prompt for Git user details
  - Configure Git environment variables
  - Create a persistent configuration file

### 2. Dotfiles Management
- `.gitconfig`: Primary Git configuration file
  - Contains aliases, color settings, and workflow configurations
  - Dynamically uses environment variables

### 3. Key Features

#### Aliases
- `g`: Quick Git command
- `gs`: Git status
- `gp`: Git pull
- `gpu`: Git push
- `gc`: Git commit
- `gco`: Git checkout

#### Advanced Workflows
- `git sync`: Switch and pull from default branch
- `git recommit`: Interactive rebase
- `git oops`: Undo last commit
- `git cleanup`: Remove merged branches

## 🚀 Customization Steps

1. Modify Environment Variables
   ```bash
   # Edit ~/.gitenv
   # Add or update variables as needed
   ```

2. Extend `.gitconfig`
   - Add personal aliases
   - Customize color schemes
   - Create context-specific configurations

## 💡 Best Practices

- Always use environment variables for sensitive information
- Keep `.gitconfig` generic and portable
- Use context-specific includes for work/personal setups

## 🔍 Troubleshooting

- Verify configurations:
  ```bash
  git config --list
  ```
- Reset to default:
  ```bash
  git config --global --unset-all user.name
  git config --global --unset-all user.email
  ```

## 📋 Recommended Workflow

1. Run `./git-env-setup`
2. Review generated configuration
3. Customize as needed
4. Commit changes to dotfiles repository
