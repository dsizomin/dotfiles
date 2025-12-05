# dotfiles

Personal configuration files for my development environment.

## Contents

- **nvim/** - Neovim configuration based on LazyVim with custom plugins and settings
- **zsh/** - Zsh shell configuration with antidote plugin manager
- **tmux/** - Tmux terminal multiplexer configuration with Cyberdream theme
- **lazygit/** - LazyGit TUI git client configuration
- **git/** - Git global configuration

## Features

### Neovim
- Built on [LazyVim](https://www.lazyvim.org/)
- Custom plugin configurations for LSP, Copilot, MCP, and more
- Optimized for modern development workflows

### Zsh
- [antidote](https://github.com/mattmc3/antidote) plugin manager
- Fish-like autosuggestions and syntax highlighting
- [Pure](https://github.com/sindresorhus/pure) prompt theme
- History substring search

### Tmux
- Cyberdream color scheme
- Enhanced terminal colors with 256-color support
- Increased history limit

### Git
- Auto-rebase on pull
- Auto-stash during rebase
- Auto-setup remote on push

## Installation

Clone this repository to your home directory:

```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
```

Create symbolic links to the desired configurations:

```bash
# Neovim
ln -s ~/dotfiles/nvim ~/.config/nvim

# Zsh
ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc

# Tmux
ln -s ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf

# Git
ln -s ~/dotfiles/git/.gitconfig ~/.gitconfig

# LazyGit
ln -s ~/dotfiles/lazygit ~/.config/lazygit
```

## Requirements

- Neovim >= 0.9.0
- Git
- Zsh
- Tmux (optional)
- LazyGit (optional)

## License

MIT

