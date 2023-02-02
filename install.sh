# updating packages
sudo pacman -Syu

# installing fish
sudo pacman -S fish

echo "Attempting to install additional utilities."

# installing starship shell prompt
curl -sS https://starship.rs/install.sh | sh

# installing zoxide
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# installing exa
sudo pacman -S exa

# adding vim-plug
echo "Downloading vim-plug..."

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# copying all dotfiles to home directory
ln -s .config $HOME/.config
ln -s .vimrc $HOME/.vimrc
ln -s .tmux.conf $HOME/.tmux.conf

echo "Basic setup complete! To fully complete the setup: change your default shell to fish, use the command :PlugInstall in vim."
echo "Additionally, if you wish, install a NerdFont from https://nerdfonts.com to enhance the Starship shell prompt experience. This is entirely optional, and the prompt will not be broken if you don't."
