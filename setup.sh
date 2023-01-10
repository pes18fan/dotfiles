# getting OS info and updating packages
. /etc/os-release
OS=$NAME

PACKAGES="placeholder"

if [[ $OS -eq "Ubuntu" ]]; then
    sudo apt update && sudo apt upgrade
    PACKAGES="apt install"
else
    sudo pacman -Syu
    PACKAGES="pacman -S"
fi

# checking for fish and installing if its not
echo "Checking if fish is installed..."

if [[ -f /usr/bin/fish ]]; then
    echo "fish is installed!"
else
    echo "installing fish..."
    
    sudo $PACKAGES fish

    echo "fish installed."
fi

echo "Attempting to install additional utilities, one or more may fail to install."

# installing starship shell prompt
curl -sS https://starship.rs/install.sh | sh

# installing zoxide
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# installing exa
sudo $PACKAGES exa

# adding vim-plug
echo "Downloading vim-plug and necessary vim plugins..."

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# installing plugins in vim
touch dummy.out
vim -E -s dummy.out << EOF
:PlugInstall
EOF

echo "vim setup complete!"

# copying all dotfiles to home directory
cp .config /home/.config
cp -s .vim /home/.vim
cp -s .vimrc /home/.vimrc

echo "Setup complete! Please change your default shell to fish."