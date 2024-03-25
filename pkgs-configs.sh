#!/bin/bash

packages=(
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

}

# Clone repositories
clone_repositories()
{
    # Clones powerlevel10k 
    if [ -d "~/powerlevel10k" ]; then
        echo "Directory already exists. Skipping git clone."
    else
        git clone --depth=2 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
    fi

    # Clones zsh-autosuggestions
    if [ -d "~/.zsh/zsh-autosuggestions" ]; then
        echo "Directory already exists. Skipping git clone."
    else
        git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
    fi

    # rm -rf makes sure that directory doesn't exist before installation
    rm -rf ~/.config/nvim
    git clone https://github.com/NvChad/starter ~/.config/nvim
}

# Configures main shell and main theme
zsh_configurations()
{
    echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
    echo 'source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc
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
    zsh_configurations
    tmux_configurations

    echo "Configuration complete. Run "source ~/.zshrc" and "source ~/.tmux.conf" to apply changes."
}

main