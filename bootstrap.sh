#! /usr/bin/env bash

# Add /usr/local/bin and /opt/homebrew/bin to the path so that anything
# installed via homebrew is available to setup scripts
export PATH=$PATH:/usr/local/bin:/opt/homebrew/bin;

set -euf -o pipefail;

DOTFILES="$HOME/.dotfiles";
DOTFILES_REPO="kevinziegler/dotfiles.git";
DOTFILES_REPO_HTTPS="https://github.com/${DOTFILES_REPO}";
DOTFILES_REPO_SSH="git@github.com:${DOTFILES_REPO}";
BREW_URL="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh";
op_setup_file="onepassword-setup-link.txt";
op_setup_file_search_path="/Volumes/ESD-USB/";
op_setup_file_path=$(find "${op_setup_file_search_path}" -name "${op_setup_file}");

# Clone repository into ~/.dotfiles via HTTPS
git clone --recurse-submodules "${DOTFILES_REPO_HTTPS}" "${DOTFILES}";

# Update remote for dotfiles repo to use SSH
git -C $DOTFILES remote remove origin;
git -C $DOTFILES remote add origin "$DOTFILES_REPO_SSH";


if ! which brew &> /dev/null; then
	echo "Homebrew not found...Installing";
	/bin/bash -c "$(curl -fsSl $BREW_URL)";
fi

"$DOTFILES/dotdrop/dotdrop.sh" -c "$DOTFILES/dotdrop.bootstrap.yaml" -P bootstrap;

# First, setup 1Password so that we can access personal credentials
echo "Launching 1Password...";
open -a /Applications/1Password.app;

if [[ -z "${op_setup_file_path}" ]]; then
    echo "Could not find 1Password setup file.  Set up 1Password manually.";
else
    echo "1Password setup file found! Opening magic link.";
    open "$(cat ${op_setup_file_path})";
fi

echo "Launching Firefox, setting it as the default browser...";
/Applications/Firefox.app/Contents/MacOS/firefox \
    --setDefaultBrowser \
    "https://accounts.firefox.com/signin";

echo "Sign into your Mozilla Account.";
sleep 3;
echo "Press <ENTER> to continue when Mozilla setup is complete";
read;

echo "Sign into your Google Account.";
open "https://accounts.google.com";
sleep 3;
echo "Press <ENTER> to continue when Google Account setup is complete";
read;

echo "Launching/Signing into Google Drive.  Follow prompts to complete setup";
open -a "/Applications/Google Drive.app";
sleep 3;
echo "Press <ENTER> to continue when Google Drive setup is complete";
read;

echo "Manual Setup Steps Complete";


"$DOTFILES/dotdrop/dotdrop.sh" -c "$DOTFILES/dotdrop.yaml" -P dev_system;

exit 0;
