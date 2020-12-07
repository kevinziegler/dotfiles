#!/bin/bash

# Configuration for SSH
SSH_KEY_TYPE="ed25519";
SSH_KEY="$HOME/.ssh/id_$SSH_KEY_TYPE";

# Configuration for Homebrew Setup & Bootstrapping
BREW_URL="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh";
BREW_BOOTSTRAP=(hub yq);
CASK_BOOTSTRAP=(1password 1password-cli);
CASK_APPLICATIONS="/Applications";

# Configuration for 1Password setup
ONEPASSWORD_ADDRESS="my.1password.com";

# Configuration for hub
GITHUB_HUB_CONFIG="$HOME/.config/hub";
GITHUB_OP_ITEM="github";

# Configuration for Gitlab
GITLAB_OP_ITEM="gitlab";
GITLAB_API_ADD_SSH_KEY="https://gitlab.com/api/v4/user/keys";

# Github repos pulled in as part of setup
GITHUB_DOTFILES_REPO="kevinziegler/dotfiles";
GITHUB_DOOM_REPO="hlissner/doom-emacs";
DOTFILES=$HOME/.dotfiles;
EMACS="$HOME/.emacs.d";

echo "Please enter signin email:";
read -p "email: " EMAIL;

echo "Setting sudo timeout to 10 minutes";
sudo sed -i.bak -E 's/(Defaults[[:space:]]+timestamp_timeout=).+/\110/' /etc/sudoers;

echo "Generating an $SSH_KEY_TYPE SSH key at $SSH_KEY";
ssh-keygen -t "$SSH_KEY_TYPE" -f "$SSH_KEY" -N ""

if ! which brew &> /dev/null; then
	echo "It looks like you need Homebrew...Installing";
	/bin/bash -c "$(curl -fsSl $BREW_URL)";
fi

brew install "${BREW_BOOTSTRAP[@]}";
brew cask install "${CASK_BOOTSTRAP[@]}";

echo "Cloning dotfiles repository";
git clone "$DOTFILES_REPOSITORY" "$DOTFILES";

echo "Setting up 1Password...";
open -a "$(brew info --cask --json=v2 "1password" | jq -r '.casks[0].artifacts[0][0]')";

echo "Waiting for you to sign into the 1Password Application...press <ENTER> to continue";
read;
eval "$(op signin "$ONEPASSWORD_ADDRESS" "$EMAIL")";

echo "Setting up hub client for Github...";
GITHUB_TOKEN=$(op get item "$GITHUB_OP_ITEM" --fields "Hub Access Token");
GITHUB_USER=$(op get item "$GITHUB_OP_ITEM" --fields "username");

yq write "$GITHUB_HUB_CONFIG" "[github.com][0].username" "$GITHUB_USER";
yq write "$GITHUB_HUB_CONFIG" "[github.com][0].oauth_token" "$GITHUB_TOKEN";
yq write "$GITHUB_HUB_CONFIG" "[github.com][0].protocol" "https";

echo "Adding Github SSH key...";
hub api user/keys \
	--field title="Generated key for $(hostname)" \
	--field key="$(ssh-keygen -y -f "$SSH_KEY")";

echo "Adding Gitlab SSH key...";
GITLAB_TOKEN=$(op get item "$GITLAB_OP_ITEM" --fields "Setup Token");

curl -X POST \
	--header "Authorization: Bearer $GITLAB_TOKEN" \
	--data-urlencode "key=$(ssh-keygen -y -f "$SSH_KEY")" \
	--data-urlencode "title=$(hostname)" \
	$GITLAB_API_ADD_SSH_KEY;

echo "Cloning dotfiles...";
hub clone "$GITHUB_DOTFILES_REPO" "$DOTFILES"; 

echo "Running brew bundle installation...";
brew bundle -f "$DOTFILES/Brewfile";

echo "Linking zshrc...";
ln -s "$DOTFILES/zshrc.zsh" "$HOME/.zshrc";
echo "Linking zshenv...";
ln -s "$DOTFILES/zsh/zshenv.zsh" "$HOME/.zshenv";
echo "Linking gitconfig...";
ln -s "$DOTFILES/gitconfig" "$HOME/.gitconfig";
echo "Linking global gitignore...";
ln -s "$DOTFILES/gitignore_global" "$HOME/.gitignore_global";
echo "Linking doom.d...";
ln -s "$DOTFILES/doom/doom.d" "$HOME/.doom.d";

echo "Setting up ZSH Plugins...";
antibody bundle < "$DOTFILES/zsh/plugins.txt" > "$HOME/.plugins.zsh";

echo "Setting up Doom Emacs...";
hub clone "$GITHUB_DOOM_REPO" "$EMACS";
"$EMACS/bin/doom" install;
