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

install_packages()
{   
    # Adding Neovim PPA
    sudo add-apt-repository ppa:neovim-ppa/unstable -y
    sudo apt update -y

    # Install packages with error handling
    echo "Installing packages..."
    for package in "${packages[@]}"; do
        sudo apt install -y $package || {
            echo "Failed to install $package, skipping..."
        }
    done

    git clone --depth=2 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

    sleep 0.1s

    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

    sleep 0.1s

    # rm -rf makes sure that directory doesn't exist before installation
    rm -rf ~/.config/nvim
    git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 # installs NvChad

}

zsh_configurations()
{
    echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc

    sleep 0.1s

    echo 'source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc
}

tmux_configurations()
{
    if [ -e ~/.tmux.conf ]; then
        mv ~/.tmux.conf ~/.tmux.conf.old
    fi

    cp /FreshUbuntu/.tmux.conf ~/.tmux.conf

    sleep 0.1s
    
    source-file ~/.tmux.conf
}

main()
{
    install_packages
    configurations
    tmux_configurations

    sleep 0.1s


    source ~/.zshrc
}

main