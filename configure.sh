#!/bin/bash

LOG_FILE="main.log"

source ./applications/headless/apt_packages.sh
source ./applications/headless/languages.sh
source ./utils.sh

main() {
  check_configure_git

  echo "Do you wish to install the following programming languages using ASDF?"
  for language in "${asdf_languages[@]}"; do
      echo "- $language"
  done
  echo -n "[Y/n]: "
  read answer

  install_packages
  asdf_configure "$answer"
  clone_repositories
  zsh_configurations
  tmux_configurations
  nvim_config
  btop_configure
  p10k_configuration

  echo "Configuration complete. Run "source ~/.zshrc" and "source ~/.tmux.conf" to apply changes."
}

main 2>&1 | tee "$LOG_FILE"
