#!/bin/bash

packages=(
    "wget"
    "vim"
    "neovim"
    "tmux"
    "build-essential"
    "make"
    "ripgrep"
    "gh"
    "cargo"
)

# Install all packages
install_packages()
{   
    # Adding Neovim PPA
    echo "Adding Neovim PPA..."
    sudo add-apt-repository ppa:neovim-ppa/unstable -y

    sudo apt update -y

    # Install packages with error handling
    echo "Installing packages..."
    for package in "${packages[@]}"; do
        sudo apt install -y $package || {
            echo "Failed to install $package, skipping..."
        }
    done

    echo "Installed packages: ${packages[*]}"
}

# Clones repositories
clone_repositories() {
    # Clones powerlevel10k 
    if [ -d "$HOME/powerlevel10k" ]; then
        echo "Powerlevel10k directory already exists. Skipping git clone."
    else
        git clone --depth=2 https://github.com/romkatv/powerlevel10k.git "$HOME/powerlevel10k" || { echo "Failed to clone Powerlevel10k repository"; return 1; }
    fi

    # Clones zsh-autosuggestions
    if [ -d "$HOME/.zsh/zsh-autosuggestions" ]; then
        echo "Zsh-autosuggestions directory already exists. Skipping git clone."
    else
        git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.zsh/zsh-autosuggestions" || { echo "Failed to clone Zsh-autosuggestions repository"; return 1; }
    fi

    # Remove existing nvim directory before cloning
    rm -rf "$HOME/.config/nvim"
    git clone https://github.com/NvChad/starter "$HOME/.config/nvim" || { echo "Failed to clone NvChad repository"; return 1; }

    echo "Repositories cloned."
}

# Install NerdFonts
install_nerdfonts()
{
    echo "Installing NerdFonts..."

    # Create ~/.local/share/fonts if it doesn't exist
    if [ ! -d ~/.local/share/fonts ]; then
    mkdir -p ~/.local/share/fonts
    fi

    # Installs JetBrainsMono to ~/.local/share/fonts
    wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip \
    && cd ~/.local/share/fonts \
    && unzip JetBrainsMono.zip \
    && rm JetBrainsMono.zip \
    && fc-cache -fv

    echo "NerdFonts installed."
}

# Configures main shell and main theme
zsh_configurations()
{
    echo "Configuring Zsh..."

    # Powerlevel10k and Zsh-autosuggestions
    echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
    echo 'source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc

    # Adding keybindings
    echo "bindkey '^H' backward-kill-word" >> ~/.zshrc

    echo "Zsh configurations complete."
}

# Configures Tmux
tmux_configurations()
{
    echo "Configuring Tmux..."

    if [ -f ~/.tmux.conf ]; then
        echo "tmux.conf already exists. copying files"
        cat ~/FreshUbuntu/.tmux.conf >> ~/.tmux.conf
    else
        echo "Creating .tmux.conf"
        touch ~/.tmux.conf
        cat ~/FreshUbuntu/.tmux.conf >> ~/.tmux.conf
    fi
}

main()
{
    install_packages
    clone_repositories
    install_nerdfonts
    zsh_configurations
    tmux_configurations

    echo "Configuration complete. Run "source ~/.zshrc" and "source ~/.tmux.conf" to apply changes."
}

main