#!/bin/bash

source ./applications/headless/apt_packages.sh
source ./utils.sh

main() {
  check_configure_git
  install_packages
  asdf_configure
  clone_repositories
  install_nerdfonts
  zsh_configurations
  tmux_configurations
  p10k_configuration

  echo "Configuration complete. Run "source ~/.zshrc" and "source ~/.tmux.conf" to apply changes."
}

main
