# LinuxTools-Term

## Disclaimer
This repository focuses on installing necessary development tools and customization for Ubuntu/derivatives environments. The installed packages are **completely opinionated and hardcoded for my use case**. I'm not planning on making it general purpose - the GitHub upload is more of a backup than anything else.

## What it does
This script installs essential packages for development, configures terminal shortcuts, and applies pre-existing configuration files for customized or "riced" applications. linuxtools-term is intended for use in headless environments, such as Ubuntu Server machines accessed via SSH.

## Installation

### Prerequisites
Ensure you have Git:
```bash
sudo apt install git
```

### Steps
1. Clone the repository:
```bash
git clone https://github.com/RoPedro/linuxtools-term $HOME/linuxtools-term &&
cd $HOME/linuxtools-term
```

2. Run the first script to install zsh:
```bash
./zsh_config.sh
```

3. **Restart your session:**
   - **WSL2**: Close terminal and reopen, or run `wsl --shutdown` with admin privileges
   - **Native Linux**: Logout and login, or run `exec zsh`

4. Type "2" in the zsh prompt before proceeding

5. Run the configuration script:
```bash
./configure.sh
```
You'll need sudo privileges and to input a username and email for git.

6. Load the new changes:
```bash
source ~/.zshrc
```

7. **Optional**: Install a Nerd Font like [MesloLGS NF](https://github.com/romkatv/powerlevel10k/blob/master/font.md) to properly render the terminal with powerlevel10k.

## Features

### Shell
- **Default shell**: zsh with powerlevel10k theme
- **Plugins**: zsh-autosuggestions and zsh-syntax-highlighting
- **Customization**: Run `p10k configure` to reconfigure the theme

### Packages
Packages are located in the `/applications` directory.

### Dotfiles
Opinionated dotfiles for configurations are located in `/dotfiles`.

### Neovim (LazyVim)
- **Version**: Neovim unstable with Lua plugin support
- **Distribution**: [LazyVim](https://github.com/LazyVim/LazyVim) for IDE-like interface

### Tmux
Terminal multiplexer with Vim-like keybindings:
- **Leader key**: `Ctrl + s` (instead of `Ctrl + b`)
- **Pane navigation**: `Leader + h/j/k/l` (left/down/up/right)
- **Reload**: `Leader + r`

*Credits to [TypeCraft](https://youtu.be/H70lULWJeig) for configuration inspiration.*

### Containers
Docker is installed by default and with groups correctly configured. Running with sudo is not needed.

### LazyGit
- **Purpose**: TUI for Git operations
- **Usage**: Check [documentation](https://github.com/jesseduffield/lazygit) and cheat sheet

### ASDF Version Manager (Work in progress, not currently installing for testing purposes.)
- **Languages**: Installs latest versions of:
  1. C (build-essential)
  2. Node.js
  3. Python
  4. Ruby

### Enhanced CLI Tools
- **bat/batcat**: Replaces `cat` with syntax highlighting
- **eza**: Replaces `ls` with enhanced features
- **btop**: Alternative to top/htop
- **ncdu**: NCurses Disk Usage for checking disk space

## Aliases

| Alias    | Command                     | Description                 |
|----------|-----------------------------|---------------------------|
| ls       | eza (stylized)              | Enhanced ls                |
| lsa      | ls -a                       | Show all files            |
| ltree    | eza (tree mode)             | Tree view                 |
| lta      | ltree -a                    | Tree view with hidden     |
| neofetch | fastfetch                   | System overview           |
| nv       | nvim                        | Neovim shortcut           |
| lzg      | lazygit                     | LazyGit shortcut          |
| bat      | batcat                      | Syntax highlighting cat   |
| catp     | batcat -p                   | Plain text cat            |
| uptupg   | update, upgrade, autoremove | System maintenance        |
| ncdu     | ncdu (transparent bg)       | Disk usage analyzer       |
| prj      | cd $HOME/projects           | Navigate to projects      |

## Terminal Keybindings
Windows-like keybindings for CMD/PowerShell users. Full list available in `/dotfiles/zsh-keybindings`. Inspired by [Manjaro](https://manjaro.org/) terminal keybindings.

## Theming Philosophy
**No background colors** - enables use of transparent terminals or background images with all TUI applications.

## Roadmap
- [x] More terminal keybindings inspired by Manjaro
- [x] ASDF version manager
- [x] More programming languages (C++, Python, Ruby, JavaScript)
- [ ] lazydocker

## Note
This script is actively maintained and may undergo major changes. Check the repository regularly for updates.