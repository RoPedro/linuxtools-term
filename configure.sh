#!/bin/bash

LOG_FILE="main.log"

source ./applications/headless/apt_packages.sh
source ./utils.sh

main() {
  check_configure_git
  install_packages
  asdf_configure
  clone_repositories
  zsh_configurations
  tmux_configurations
  nvim_config
  p10k_configuration

  echo "Configuration complete. Run "source ~/.zshrc" and "source ~/.tmux.conf" to apply changes."
}

main 2>&1 | tee "$LOG_FILE"
