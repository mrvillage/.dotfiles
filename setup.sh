#!/bin/bash

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y wget curl clang git

# Clone dotfiles
git clone git@github.com:/mrvillage/.dotfiles.git --recurse-submodules
mv .dotfiles/{.,}* ./
rm -rf .dotfiles

# Install Neovim
wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar xzf nvim-linux64.tar.gz
mv nvim-linux64 nvim
rm nvim-linux64.tar.gz

# Install Volta and Node
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
cargo install mrvillage-cli cargo-release tree-sitter-cli

# Install Java
sudo apt-get install -y openjdk-17-jdk

# Install Go
wget https://go.dev/dl/go1.22.2.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.22.2.linux-amd64.tar.gz
rm go1.22.2.linux-amd64.tar.gz

# Install R
sudo apt install --no-install-recommends software-properties-common dirmngr
gpg --keyserver keyserver.ubuntu.com --recv-key '95C0FAF38DB3CCAD0C080A7BDC78B2DDEABC47B7'
gpg --armor --export '95C0FAF38DB3CCAD0C080A7BDC78B2DDEABC47B7' | sudo tee /etc/apt/trusted.gpg.d/cran_debian_key.asc
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/debian $(lsb_release -cs)-cran40/"
sudo apt-get install r-base r-base-dev xml2

# Install Julia
curl -fsSL https://install.julialang.org | sh

# Install Zig
wget https://ziglang.org/builds/zig-linux-x86_64-0.13.0-dev.73+db890dbae.tar.xz
tar -xf zig-linux-x86_64-0.13.0-dev.73+db890dbae.tar.xz
mv zig-linux-x86_64-0.13.0-dev.73+db890dbae .zig
rm zig-linux-x86_64-0.13.0-dev.73+db890dbae.tar.xz
