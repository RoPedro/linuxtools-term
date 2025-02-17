#!/bin/bash

echo "Installing Rust packages..."

sudo apt-get install curl -y
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

. "$HOME/.cargo/env"
