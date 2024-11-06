#!/bin/bash

source ./apt_packages.sh

# Install all packages
install_packages()
{   
    # Adding Neovim PPA
    sudo add-apt-repository ppa:neovim-ppa/unstable -y
    echo "Adding Neovim PPA..."

    sudo apt update -y

    # Install packages with error handling
    echo "Installing packages..."
    for package in "${packages[@]}"; do
        sudo apt install -y $package || {
            echo "Failed to install $package, skipping..."
        }
    done

    echo "Installed packages: ${packages[*]}"

    echo "Installing cargo packages..."
    cargo install eza
    sudo apt install bat -y
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

    # LazyVim installation 
    echo "Installing lazyvim"
    rm -rf "$HOME/.config/nvim" # Remove existing nvim directory before cloning
    git clone https://github.com/LazyVim/starter ~/.config/nvim || { echo "Failed to clone LazyVim repository"; return 1; }
    rm -rf ~/.config/nvim/.git

    # lazygit installation
    if ! command -v curl &> /dev/null; then
        echo "CURL NOT INSTALLED, LAZYGIT INSTALLATION CANCELLED."
        return 1
    else
        echo "Installing lazygit"
        LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
        curl -Lo ~/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
        tar xf ~/lazygit.tar.gz lazygit
        sudo install lazygit /usr/local/bin

        # Cleans the trash
        rm -rf ~/lazygit.tar.gz
        rm -rf ~/lazygit
    fi

    if ! command -v lazygit &> /dev/null; then
        echo "lazygit was not installed, skipping."
    fi

    echo "Repositories cloned."
}

check_configure_git() {
    # Check if Git is installed
    if ! command -v git &> /dev/null; then
        echo "Git is not installed. Please install Git to continue."
        return 1
    fi

    # Check if git config user.name is set
    if [ -z "$(git config --get user.name)" ]; then
        read -p "Git username not configured. Please enter your Git username: " username
        git config --global user.name "$username"
    fi

    # Check if git config user.email is set
    if [ -z "$(git config --get user.email)" ]; then
        read -p "Git email not configured. Please enter your Git email: " email
        git config --global user.email "$email"
    fi

    echo "Git configuration completed."
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

    # Adding path
    echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.zshrc

    # Powerlevel10k and Zsh-autosuggestions
    echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
    echo 'source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc

    # Adding aliases
    echo "Adding aliases..."
    echo "alias updateUpgrade='sudo apt update && sudo apt upgrade -y'" >> ~/.zshrc

    if ! type "eza" > /dev/null 2>&1; then
        echo "Alias 'eza' not available, skipping..."
    else
        echo "alias ls='eza'" >> ~/.zshrc
    fi

    if type "bat" > /dev/null 2>&1; then
        echo "Using 'bat' as replacement for 'cat'..."
        echo "alias cat='bat'" >> ~/.zshrc
    elif type "batcat" > /dev/null 2>&1; then
        echo "Using 'batcat' as replacement for 'cat'..."
        echo "alias cat='batcat'" >> ~/.zshrc
    else
        echo "Neither 'bat' nor 'batcat' found, skipping..."
    fi

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
        cat ~/linuxtools/.tmux.conf >> ~/.tmux.conf
    else
        echo "Creating .tmux.conf"
        touch ~/.tmux.conf
        cat ~/linuxtools/.tmux.conf >> ~/.tmux.conf
    fi
}

p10k_configuration()
{
    echo "Configuring p10k..."
    if [ -f ~/.p10k.zsh ]; then
        echo "p10.zsh already exists. copying files"
        cat ~/linuxtools/.p10k.zsh >> ~/.p10k.zsh
    else
        echo "Creating .tmux.conf"
        touch ~/.p10k.zsh
        cat ~/linuxtools/.p10k.zsh >> ~/.p10k.zsh
    fi

    # Sources p10k.zsh
    echo -e "\n[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh " >> ~/.zshrc
}

main()
{   
    install_packages
    check_configure_git
    clone_repositories
    install_nerdfonts
    zsh_configurations
    tmux_configurations
    p10k_configuration

    echo "Configuration complete. Run "source ~/.zshrc" and "source ~/.tmux.conf" to apply changes."
}

main
