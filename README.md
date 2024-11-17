# DISCLAIMER: Those scripts considers a Ubuntu installation under Windows WSL2, some aspects supports native installations, but anything directory dependant, probably needs modifications.

This repository focus on installing the necessary development tools and customization to a Ubuntu/derivatives enviroment. The installed packages are **completely opinionated and hardcoded for my usecase**, I'm not planning on making  it general purpose, the GitHub upload is more of a backup than anything else.
The scripts could contain errors, so take everything as a reference more than anything else.

## What it does?
The script aims to install essential packages for development, configuring terminal shortcuts, and use pre-existing configuration files for applications that are tipically customized or riced.

## Installation
Still a work in progress, but as of now, first run:
```bash
sudo apt update && sudo apt upgrade
```
to upate your system.

Now git clone linux tools and inside the repository run:
```bash
.zsh_config.sh
```
to install zsh and change the default bash.

**If running on WSL2, close the terminal and open again to simulate a logout, if that doesn't work, on a admin powershell, run `wsl --shutdown` and open it again**

**In native Linux you can just logout and login**
Now, run `./configure.sh`, eventually, it will prompt for your git user and email, after that, it's safe to let the script finish.
Don't forget to run: `source ~/.zshrc` after installation or reopening your terminal, also, use a nerd font like [MesloLGS NF](https://github.com/romkatv/powerlevel10k/blob/master/font.md)to render your terminal since [powerlevel10k](https://github.com/romkatv/powerlevel10k) is installed.

## Shell
The default shell is zsh using powerlevel10k to give a nice theme, [powerlevel10k](https://github.com/romkatv/powerlevel10k) is modular enough so you can reconfigure the theme without breaking `.zshrc`, just run `p10k configure` if you don't like the default.

This script also comes with zsh-autosuggestions, a nice autocomplete tool that fetches from the shell history.

## Packages
Packages are located in `/applications` directory, as of now, it only install terminal tools, since the script is tailored for Microsoft WSL2.

## Dotfiles
The script contains opinionated dotfiles for configurations located in `/dotfiles`, continue reading for further information on what's added and changed.

## Neovim (LazyVim)
One of the installed packages is [Neovim](https://github.com/neovim/neovim) (PPA unstable version), this means that we can install [Lua](https://www.lua.org/) plugins, but instead of managing plugins from scratch, we are taking for granted [LazyVim](https://github.com/LazyVim/LazyVim) and installing it for a powerful and visually appealing Vim editor, no changes made, default installation is enough for my case, make sure to check their documentation to see what's new.

## Tmux
Tmux is possibly the most popular terminal multiplexer out there (it's literally in it's name). Here, the dotfiles make some interesting changes to make it Vim-like. First, the **Leader** key is now `CTRL + s` instead of `CTRL + b`, and to change panes we are now using `Leader + h/j/k/l(Left, down, up, right)`, also, if you install new plugins, you can now press `Leader + r` to reload tmux. Credits to this [typecraft](https://youtu.be/H70lULWJeig) video for some aspects of the configuration.

## LazyGit
Typing commands are boring and sometimes can be automated by a nice TUI, that's what [LazyGit](https://github.com/jesseduffield/lazygit) does, nothing changed here, but it's installed, so have fun and make sure to check their documentation and cheat sheet for enhanced productivity.

## ASDF
ASDF core is installed alongside the main languages I am interested in. The installed languages are listed below and are always installed on their latest version available when the script is run, you can always install different versions if you need.

## Programming languages
1. C (build-essential);
2. NodeJS;
3. Python;
4. Ruby.

## Bat and Eza
Instead of using the default unix `cat`, we have [bat/batcat](https://github.com/sharkdp/bat) installed, same thing for [eza](https://github.com/eza-community/eza), taking the place of `ls`

## Aliases
New aliases were added:

- `cat` translates to `bat`;
- `ls` translates to `eza`;
- `updateUpgrade` translates to `sudo apt update && sudo apt upgrade`.

## Terminal keybindings
There's a multitude of new keybindings to make navigating through terminal text more Windows-Like, for those used with CMD and PowerShell. The keybindings are listed at `/dotfiles/zsh-keybindings` and they're sourced on `.zshrc`

## New features
This script is not definitive and I'm definitely updating, don't be surprised if you enter access the repository and there's a major change, but for now, I have a (kinda) organized roadmap for what's coming:

1. ~~More terminal keybindings inspired by Manjaro~~;
2. ~~asdf version manager~~;
3. More programming languages (C++, Python, Ruby and Javascript);
4. Full support for native Linux installations with packages like VSCode, Bitwarden and discord (While maintaining WSL2 support).
