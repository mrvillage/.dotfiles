#!/bin/bash

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y wget curl clang git

# Clone dotfiles
git clone git@github.com:/mrvillage/.dotfiles.git #--recurse-submodules
mv .dotfiles/{.,}* ./
rm -rf .dotfiles

# Install Neovim
wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar xzf nvim-linux64.tar.gz
mv nvim-linux64 nvim
rm nvim-linux64.tar.gz

# Install Volta nad Node
curl https://get.volta.sh | bash
source $HOME/.bashrc
volta install node

# Lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm -rf lazygit.tar.gz lazygit

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s - --no-modify-path -y
source $HOME/.bashrc
rustup toolchain install nightly
rustup update
rustup target add wasm32-unknown-unknown --toolchain nightly

