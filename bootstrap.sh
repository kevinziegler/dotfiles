#!/bin/bash

# Exported configuration
export SSH_KEY_TYPE="ed25519";
export SSH_KEY="$HOME/.ssh/id_$SSH_KEY_TYPE";

# Homebrew Setup
export BREW_URL="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh";
export BREW_BOOTSTRAP=(hub yq);
export CASK_BOOTSTRAP=(1password 1password-cli mackup);
export CASK_APPLICATIONS="/Applications";

# OnePassword Configuration
export ONEPASSWORD_ADDRESS="my.1password.com";

# Github Setup
export GH_HUB_CONFIG="$HOME/.config/hub";
export GH_OP_ITEM="github";
export GH_SSHKEY_NAME="Generated key for $(hostname)";

# Dotfiles configuration
export DOTFILES_REPO="kevinziegler/dotfiles";
export DOTFILES="$HOME/.dotfiles";

echo "Please enter setup emails:";
read -p "\tGit Email: " GIT_EMAIL;
read -p "\tOnePassword Email:" ONEPASSWORD_EMAIL;

echo "Setting sudo timeout to 10 minutes";
sudo sed -i.bak -E 's/(Defaults[[:space:]]+timestamp_timeout=).+/\110/' /etc/sudoers;

echo "Generating an $SSH_KEY_TYPE SSH key at $SSH_KEY";
ssh-keygen -t "$SSH_KEY_TYPE" -f "$SSH_KEY" -N "";

if ! which brew &> /dev/null; then
	echo "It looks like you need Homebrew...Installing";
	/bin/bash -c "$(curl -fsSl $BREW_URL)";
fi

echo "Installing boostraping utils via Homebrew"
brew install "${BREW_BOOTSTRAP[@]}";
brew cask install "${CASK_BOOTSTRAP[@]}";

echo "Setting up 1Password...";
open -a "$(brew info --cask --json=v2 "1password" | jq -r '.casks[0].artifacts[0][0]')";

echo "Waiting for you to sign into the 1Password Application...press <ENTER> to continue";
read;
eval "$(op signin "$ONEPASSWORD_ADDRESS" "$ONEPASSWORD_EMAIL")";
echo "Signed into 1Password via the command line!"

echo "Setting up hub client for Github...";
GITHUB_TOKEN=$(op get item "$GH_OP_ITEM" --fields "Hub Access Token");
GITHUB_USER=$(op get item "$GH_OP_ITEM" --fields "username");
yq write "$GH_HUB_CONFIG" "[github.com][0].username" "$GITHUB_USER";
yq write "$GH_HUB_CONFIG" "[github.com][0].oauth_token" "$GITHUB_TOKEN";
yq write "$GH_HUB_CONFIG" "[github.com][0].protocol" "https";

echo "Adding Github SSH key...";
GH_SSHKEY="$(ssh-keygen -y -f "$SSH_KEY")";
hub api user/keys --field title="$GH_SSHKEY_NAME" --field key="$GH_SSHKEY";

echo "Cloning dotfiles...";
hub clone "$DOTFILES_REPO" "$DOTFILES";

echo "Bootstrapping complete.  Running setups scripts in $DOTFILES/setup";
for script in $(ls "$DOTFILES/setup"); do
	echo "[$script] Starting";
	bash $script;
	echo "[$script] Finished";
done

echo "Setup is finished!";
