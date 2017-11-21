# Link config files
ln -s $HOME/.dotfiles/psqlrc $HOME/.psqlrc
ln -s $HOME/.dotfiles/spacemacs $HOME/.spacemacs
ln -s $HOME/.dotfiles/zshrc $HOME/.zshrc
ln -s $HOME/.dotfiles/gitconfig $HOME/.gitconfig
ln -s $HOME/.dotfiles/gitignore_global $HOME/.gitignore_global

# Install homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor

brew bundle

# Setup vim plugins
curl -fLo ~/.vim/autoload/plug.vim \
     --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +PlugInstall +qall

# Setup spacemacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

# Manual steps
echo "TODO items for the human:"
echo "\t Run `all-the-icons-install-fonts` in emacs"
echo "\t Set CMD+/ command to trigger dash"
echo "\t Set CMD+SPACE to trigger alfred"
echo "\t Set shortcuts for divvy"
