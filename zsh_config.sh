#!/bin/bash

# Install Zsh
sudo apt-get update -y
sudo apt-get install -y zsh

chmod +x $HOME/linuxtools-term/configure.sh

# Change default shell to Zsh
sudo chsh -s $(which zsh) $USER

echo "Please log out and log back in for the changes to take effect."
