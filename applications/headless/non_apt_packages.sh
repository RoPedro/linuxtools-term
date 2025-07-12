#!/bin/bash

cargo install eza

# Docker installation
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Installing Docker..."
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update

    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin 

    sudo groupadd docker || echo "Docker group already exists, skipping..."
    sudo usermod -aG docker $USER
    echo "Docker installed successfully. Please log out and log back in to apply group changes."
else
    echo "Docker is already installed."
fi

# Fastfetch installation
if ! command -v fastfetch &> /dev/null; then
    echo "Fastfetch is not installed. Installing Fastfetch..."
    wget https://github.com/fastfetch-cli/fastfetch/releases/download/2.47.0/fastfetch-linux-amd64.deb

    sudo dpkg -i fastfetch-linux-amd64.deb
    rm fastfetch-linux-amd64.deb
    echo "Fastfetch installed successfully."
else
    echo "Fastfetch is already installed."
fi