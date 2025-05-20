#!/bin/bash
set -e

# Update package list and upgrade installed packages
sudo apt update && sudo apt upgrade -y

# https://github.com/ajeetdsouza/zoxide
# https://github.com/junegunn/fzf#installation
# https://github.com/sharkdp/fd?tab=readme-ov-file#installation
# https://github.com/BurntSushi/ripgrep/blob/master/README.md#installation
# https://github.com/sharkdp/bat#on-ubuntu-using-apt

echo "deb [trusted=yes] https://ppa.ipinfo.net/ /" | sudo tee "/etc/apt/sources.list.d/ipinfo.ppa.list"
sudo apt update

sudo apt install -y \
                stow xclip trash-cli btop \
                python3 python3-pip python3-dev \
                zoxide fzf fd-find ripgrep bat \
                build-essential curl wget git jq \
                ipinfo

ipinfo completion install

# PROGRAMMING

# Install Rust and update PATH
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
echo 'source "$HOME/.cargo/env"' >> ~/.bashrc
echo 'source "$HOME/.cargo/env"' >> ~/.zshrc
# need to source cargo for the current shell
source "$HOME/.cargo/env"

# setup prompt
curl -sS https://starship.rs/install.sh | sh
cp zsh/starship.toml ~/.config/starship.toml

# goland
# sudo apt install golang -y  # needed for yq
GO_VERSION="1.23.3"
if [ ! -d "/usr/local/go" ]; then
    wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
    echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
    echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.zshrc
    export PATH=$PATH:/usr/local/go/bin
    rm go${GO_VERSION}.linux-amd64.tar.gz
fi

# neovim 4 lunarvim
# sudo apt install -y neovim  # last time this installed 0.6, too old
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
echo 'add to bashrc/zshrc:\n export PATH="$PATH:/opt/nvim-linux64/bin"'
# sudo add-apt-repository ppa:neovim-ppa/stable -y
# sudo apt update
# sudo apt install -y neovim

# COMMUNITY MAINTAINED
# exa is unmaintained use fork: eza

# IF rust not installed
# https://github.com/eza-community/eza/blob/main/INSTALL.md#debian-and-ubuntu
# sudo mkdir -p /etc/apt/keyrings
# wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
# echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
# sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
# sudo apt update
# sudo apt install -y eza

# https://github.com/eza-community/eza/blob/main/INSTALL.md#cargo-cratesio
# https://github.com/Orange-OpenSource/hurl?tab=readme-ov-file#cargo
# https://github.com/Byron/dua-cli
# 'better' man pages / pip3 install tldr
cargo install eza hurl dua-cli tealdeer

# alternatively lsd
# https://github.com/lsd-rs/lsd?tab=readme-ov-file#prerequisites
# sudo apt install lsd

# https://github.com/jesseduffield/lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
# sudo add-apt-repository ppa:lazygit-team/release -y
# sudo apt update
# sudo apt install -y lazygit


# https://github.com/mikefarah/yq
sudo snap install yq


# https://github.com/PaulJuliusMartinez/jless
# cargo install jless  

# need ripgrep, lazygit before running this
# https://www.lunarvim.org/docs/installation#release
LV_BRANCH='release-1.4/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.4/neovim-0.9/utils/installer/install.sh)

# simple terminal ui for docker and docker compose
go install github.com/jesseduffield/lazydocker@latest


# Install Oh My Zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Clone Oh My Zsh plugins
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi

if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
fi

# stow --adopt -nvt ~ *
echo "if you make changes, use: \n\n  stow --adopt -v -n -t ~ *\n\nto update your current zshrc \n(delete -n flag to actually run it)"

# Clean up
sudo apt autoremove -y
sudo apt clean

echo "setup done"
