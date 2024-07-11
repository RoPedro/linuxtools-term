#!/bin/bash

# Install Zsh
sudo apt update
sudo apt install -y zsh

chmod +x ~/FreshUbuntu/configure.sh
chmod +x ~/FreshUbuntu/retrieve_projects.sh

# Change default shell to Zsh
sudo chsh -s $(which zsh) $USER

echo "Please log out and log back in for the changes to take effect."
