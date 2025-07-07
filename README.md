# This repository is currently archived due to a lack of interest in maintaining the desktop functionalities, my focus will be moved to CLI only setup. My work will be continued in [linuxtools-term](https://github.com/RoPedro/linuxtools-term) 

# Alpha 2!
linuxtools now comes with the installation of graphical packages in case running it detects x11 or wayland.

## Disclaimer: This repository focus on installing the necessary development tools and customization to a Ubuntu/derivatives enviroment. The installed packages are **completely opinionated and hardcoded for my usecase**, I'm not planning on making  it general purpose, the GitHub upload is more of a backup than anything else.

## What it does?
The script aims to install essential packages for development, configuring terminal shortcuts, and use pre-existing configuration files for applications that are tipically customized or riced, if x11 or wayland is detected, desktop applications like terminal emulators and web browsers will also be insatlled.

## Installation
Install Git:
```bash
sudo apt install git
```

Clone the repository:
```bash
git clone https://github.com/RoPedro/linuxtools $HOME/linuxtools &&
cd $HOME/linuxtools
```

Run the first script to install zsh:
```bash
.zsh_config.sh
```

**If running on WSL2, close the terminal and open again to simulate a logout, if that doesn't work, on a admin powershell, run `wsl --shutdown` and open it again.**
In native Linux you can just logout and login.
After the logout, it's recommended to type 2 in the zsh prompt before proceeding.

Next, run:
```bash
./configure.sh
```
you'll need sudo privileges and input a usename and email, then you can leave it running.

Lastly, run:
```bash
source ~/.zshrc
```
to load the new changes.

Additionaly, use a Nerd Font like [MesloLGS NF](https://github.com/romkatv/powerlevel10k/blob/master/font.md)to render your terminal since [powerlevel10k](https://github.com/romkatv/powerlevel10k) is installed.

## Shell
The default shell is zsh using powerlevel10k to give a nice theme, [powerlevel10k](https://github.com/romkatv/powerlevel10k) is modular enough so you can reconfigure the theme without breaking `.zshrc`, just run `p10k configure` if you don't like the default.

The shell will also have zsh-autosuggestions and zsh-syntax-highlighting installed.

## Packages
Packages are located in `/applications` directory, there are headless and desktop packages, the script will detect automatically if it's running on tty or x11/wayland to install desktop packages.

## Dotfiles
The script contains opinionated dotfiles for configurations located in `/dotfiles`, continue reading for further information on what's added and changed.

## Neovim (LazyVim)
[Neovim](https://github.com/neovim/neovim) unstable is installed, this means that we can use [Lua](https://www.lua.org/) plugins, so we are taking for granted [LazyVim](https://github.com/LazyVim/LazyVim) distro for an IDE-like interface.

## Tmux
Tmux is possibly the most popular terminal multiplexer out there (it's literally in it's name). Here, the dotfiles make some interesting changes to make it Vim-like. First, the **Leader** key is now `CTRL + s` instead of `CTRL + b`, and to change panes we are now using `Leader + h/j/k/l(Left, down, up, right)`, also, if you install new plugins, you can now press `Leader + r` to reload tmux. Credits to this [typecraft](https://youtu.be/H70lULWJeig) video for some aspects of the configuration.

## Podman
The chosen container application, runs rootless by default and it is daemonless, it comes with a alias to run podman commands using the docker syntax. The alias would need to be removed alongside with Podman if you prefer to use docker.

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

## Fonts
The script installs JetBrains Nerd Font, which is very nice to work on tools like VSCode and other text editors when writing code due to the reskin of operators like `==`, `->`, `#{}`, etc.

## Other utilities
- btop is installed as an alternative to top and htop, no aliases is provided by default.
- ncdu (NCurses Disk Usage) as a TUI to check disk space is an easier way.

## Aliases
| Alias    | Translates to:              |
|----------|-----------------------------|
| ls       | eza (stylized)              |
| lsa      | ls -a                       |
| ltree    | eza (tree mode)             |
| lta      | ltree -a                    |
| nv       | nvim                        |
| lzg      | lazygit                     |
| bat      | batcat                      |
| catp     | batcat -p (plain)           |
| uptupg   | update, upgrade, autoremove |
| ncdu     | ncdu (transparent bg)       |

## Terminal keybindings
There's a multitude of new keybindings to make navigating through terminal text more Windows-Like, for those used with CMD and PowerShell. The keybindings are listed at `/dotfiles/zsh-keybindings` and are inspired by [Manjaro](https://manjaro.org/) terminal keybindings.

## Theming
The philosophy for the appearance of the environment is very simple: *No background colors.* This makes it possible to use all the preinstalled TUI applications with a transparent terminal, or with background image.

## New features
This script is not definitive and I'm definitely updating, don't be surprised if you enter access the repository and there's a major change, but for now, I have a (kinda) organized roadmap for what's coming:

1. ~~More terminal keybindings inspired by Manjaro~~;
2. ~~asdf version manager~~;
3. ~~More programming languages (C++, Python, Ruby and Javascript)~~;
4. ~~Full support for native Linux installations with packages like VSCode, Bitwarden and discord (While maintaining WSL2 support);~~
5. lazydocker, if ported for podman.
6. Fork for Ubuntu Server, stripping down development tools and adding useful packages for homelabbing.
