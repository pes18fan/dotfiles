#!/bin/bash

# function that attempts to install a package if it is not already installed
# exits the program with an error if install fails
try_install() {
    if command -v $1 &> /dev/null; then
        echo "$1 is installed. Skipping..."
    else
        echo "No $1. Installing..."
        if ! sudo $PKG_INSTALL $1; then
            echo "Failed to install $1."
            echo "Please manually install it and restart the script."
            exit 1
        fi
        echo ""
    fi
}

# change default shell
change_shell() {
    if [ -n "$FISH_VERSION" ]; then
        echo "fish is already the default shell."
    else
        echo "Changing default shell to fish..."
        chsh -s $(which fish)
    fi
    echo ""
}

echo "------------------------------ BOOTSTRAPPER ------------------------------"
echo ""

# Package manager inputs
read -p "Tell me your package manager. " PKG
read -p "What's $PKGMGR's install command? E.g. pacman -S for pacman. " PKG_INSTALL
read -p "What's $PKGMGR's update command? E.g pacman -Syu for pacman. If there
    is more than one command, for example in Ubuntu, connect them with && in the
    answer. " PKG_UPDATE

echo "Updating packages."
sudo $PKG_UPDATE
echo ""

# No need to try install git, as it is required by yadm in the first place
try_install curl
try_install fish
try_install neovim

echo "Installing additional utilities..."
sudo $PKGMGR_INSTALL ripgrep fd eza bat tmux
echo ""

# starship
curl -sS https://starship.rs/install.sh | sh

# zoxide
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh\ 
    | bash

# Previously when I used packer.nvim, I'd set nvim up around here.
# However, with lazy.nvim, the plugin bootstraps itself and all of your other
# plugins when you boot up nvim for the first time. Awesome!

change_shell

echo "Bootstrapping complete."
echo "Make sure to install a NerdFont for the best experience."
