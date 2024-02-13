sudo apt update

# manage dotfiles
sudo apt install stow xclip 

# COMMUNITY MAINTAINED
# exa is unmaintained use fork: eza
# https://github.com/eza-community/eza/blob/main/INSTALL.md#debian-and-ubuntu
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

# alternatively lsd
# https://github.com/lsd-rs/lsd?tab=readme-ov-file#prerequisites
# sudo apt install lsd

# https://github.com/ajeetdsouza/zoxide
sudo apt install zoxide

# https://github.com/mikefarah/yq
sudo add-apt-repository ppa:rmescandon/yq
sudo apt update
sudo apt install yq -y

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

# 'better' man pages
# pip3 install tldr

# stow --adopt -nvt ~ *
echo "if you make changes, use: \n\n  stow --adopt -v -n -t ~ *\n\nto update your current zshrc \n(delete -n flag to actually run it)"
echo "setup done"