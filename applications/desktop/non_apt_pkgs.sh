#!/bin/bash

echo "Installing Vivaldi"
curl -o /tmp/vivaldi-stable_7.0.3495.29-1_amd64.deb https://downloads.vivaldi.com/stable/vivaldi-stable_7.0.3495.29-1_amd64.deb
sudo dpkg -i /tmp/vivaldi-stable_7.0.3495.29-1_amd64.deb

# Upscayl
echo "Installing Upscayl"
curl -o /tmp/upscayl-2.15.0-linux.deb https://github.com/upscayl/upscayl/releases/download/v2.15.0/upscayl-2.15.0-linux.deb
sudo dpkg -i /tmp/upscayl-2.15.0-linux.deb

sudo apt install -f

# Liquorix Kernel
echo "Installing Liquorix Kernel..."

if curl -s 'https://liquorix.net/install-liquorix.sh' | sudo bash; then
  echo "Liquorix Kernel installed successfully"
else
  echo "Failed to install Liquorix Kernel"
fi
