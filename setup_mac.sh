#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Install Homebrew if not present
if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew update && brew upgrade

# CLI essentials
# https://github.com/ajeetdsouza/zoxide
# https://github.com/junegunn/fzf
# https://github.com/sharkdp/fd
# https://github.com/BurntSushi/ripgrep
# https://github.com/sharkdp/bat
# https://github.com/eza-community/eza
brew install \
    stow \
    btop \
    zoxide fzf fd ripgrep bat \
    eza \
    jq yq \
    git curl wget \
    lazygit lazydocker \
    ipinfo \
    hurl \
    tealdeer

# PROGRAMMING

# Rust
if ! command -v rustup &>/dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
fi

# Go
brew install go

# Neovim (latest)
brew install neovim

# Node (needed for LunarVim — install via brew to avoid npm permission issues)
brew install node

# LunarVim
# https://www.lunarvim.org/docs/installation
LV_BRANCH='release-1.4/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.4/neovim-0.9/utils/installer/install.sh) --yes

# Starship prompt
# https://starship.rs
brew install starship

# Helper: install cask without failing if already present
install_cask() {
    brew install --cask "$1" 2>/dev/null || \
    brew install --cask --force "$1" 2>/dev/null || \
    echo "  ⚠︎  skipped $1 (already installed or error)"
}

# APPS (brew cask — equivalent to winget essentials)
for cask in ghostty keepassxc google-drive docker vlc visual-studio-code tailscale parsec; do
    install_cask "$cask"
done

# Nice-to-have
for cask in alt-tab rectangle; do
    install_cask "$cask"
done

# DOTFILES

echo "Linking dotfiles..."

link() {
    local src="$1"
    local dest="$2"
    mkdir -p "$(dirname "$dest")"
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        echo "  ↩︎  Backing up $dest → $dest.bak"
        mv "$dest" "$dest.bak"
    fi
    ln -sf "$src" "$dest"
    echo "  ✓  $dest"
}

link "$DOTFILES_DIR/zsh/.zshrc"        "$HOME/.zshrc"
link "$DOTFILES_DIR/zsh/starship.toml" "$HOME/.config/starship.toml"
link "$DOTFILES_DIR/ghostty/config"    "$HOME/Library/Application Support/com.mitchellh.ghostty/config"

# OH MY ZSH

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

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

# ipinfo shell completion
ipinfo completion install

brew cleanup

echo ""
echo "================================"
echo "         SETUP SUMMARY"
echo "================================"
echo ""
echo "CLI tools:"
for cmd in stow btop zoxide fzf fd rg bat eza jq yq lazygit lazydocker ipinfo hurl tldr; do
    if command -v $cmd &>/dev/null; then
        echo "  ✓  $cmd $(${cmd} --version 2>/dev/null | head -1 || true)"
    else
        echo "  ✗  $cmd (not found)"
    fi
done

echo ""
echo "Languages & runtimes:"
for cmd in rustc go node nvim lvim; do
    if command -v $cmd &>/dev/null; then
        echo "  ✓  $cmd $($cmd --version 2>/dev/null | head -1 || true)"
    else
        echo "  ✗  $cmd (not found)"
    fi
done

echo ""
echo "Dotfile symlinks:"
for f in "$HOME/.zshrc" "$HOME/.config/starship.toml" "$HOME/Library/Application Support/com.mitchellh.ghostty/config"; do
    if [ -L "$f" ]; then
        echo "  ✓  $f"
    else
        echo "  ✗  $f (not symlinked)"
    fi
done

echo ""
echo "================================"
echo "Done! Restart terminal or run: source ~/.zshrc"
echo "================================"
