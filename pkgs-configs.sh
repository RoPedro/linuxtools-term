PACKAGES_TO_INSTALL= "git vim neovim tmux build-essential make ripgrep chromium-browser gh"

install_packages()
{
    sudo apt update && sudo apt upgrade -y
    sudo add-apt-repository ppa:neovim-ppa/unstable -y
    sudo apt update -y
    sudo apt install -y $PACKAGES_TO_INSTALL
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k 
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

    # rm -rf makes sure that directory doesn't exist before installation
    rm -rf ~/.config/nvim && git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

}

zsh_configurations()
{
    echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
    echo 'source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc
}

tmux_configurations()
{
    if [ -e ~/.tmux.conf ]; then
        mv ~/.tmux.conf ~/.tmux.conf.old
    fi

    cp /FreshUbuntu/.tmux.conf ~/.tmux.conf
}

main()
{
    install_packages
    configurations
    tmux_configurations

    source-file
    source ~/.zshrc
}

main