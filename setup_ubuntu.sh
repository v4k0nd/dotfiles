sudo apt update


# essentials
sudo apt install -y stow \
                 xclip \
                 trash-cli

# PROGRAMMING
# python
sudo apt install -y python3 python3-pip python3-dev

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# need to source cargo for the current shell
. "$HOME/.cargo/env" 

# npm
sudo apt install npm # needed for neovim

# goland
sudo apt install golang # needed for yq

# neovim 4 lunarvim
# sudo apt install -y neovim  # last time this installed 0.6, too old
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
echo 'add to bashrc/zshrc:\n export PATH="$PATH:/opt/nvim-linux64/bin"'

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
cargo install eza

# alternatively lsd
# https://github.com/lsd-rs/lsd?tab=readme-ov-file#prerequisites
# sudo apt install lsd

# https://github.com/jesseduffield/lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

# https://github.com/ajeetdsouza/zoxide
sudo apt install zoxide

# https://github.com/mikefarah/yq
# sudo add-apt-repository ppa:rmescandon/yq
# sudo apt update
# sudo apt install yq -y
go install github.com/mikefarah/yq/v4@latest

# https://github.com/Orange-OpenSource/hurl?tab=readme-ov-file#cargo
cargo install hurl

# https://github.com/Byron/dua-cli
cargo install dua-cli

# https://github.com/PaulJuliusMartinez/jless
# rust toolcahin needed
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# cargo install jless  

# https://github.com/junegunn/fzf#installation
sudo apt install fzf
# https://github.com/sharkdp/fd?tab=readme-ov-file#installation
sudo apt install fd-find
# https://github.com/BurntSushi/ripgrep/blob/master/README.md#installation
sudo apt install ripgrep
# https://github.com/sharkdp/bat#on-ubuntu-using-apt
sudo apt install bat

# need ripgrep, lazygit before running this
# https://www.lunarvim.org/docs/installation#release
LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)

# 'better' man pages
# pip3 install tldr
cargo install tealdeer

# simple terminal ui for docker and docker compose
go install github.com/jesseduffield/lazydocker@latest

# stow --adopt -nvt ~ *
echo "if you make changes, use: \n\n  stow --adopt -v -n -t ~ *\n\nto update your current zshrc \n(delete -n flag to actually run it)"
echo "setup done"
