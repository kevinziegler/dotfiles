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
