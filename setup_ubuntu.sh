sudo apt update

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

# https://github.com/sharkdp/fd?tab=readme-ov-file#installation
sudo apt install fd-find
# https://github.com/BurntSushi/ripgrep/blob/master/README.md#installation
sudo apt install ripgrep
# https://github.com/sharkdp/bat#on-ubuntu-using-apt
sudo apt install bat