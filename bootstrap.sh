#! /usr/bin/env bash

# Script Configuration
DOTFILES="${HOME}/.dotfiles";
DOTFILES_REPO="https://github.com/kevinziegler/dotfiles.git";
DOTDROP="${DOTFILES}/dotdrop/dotdrop.sh";

# Set the dotdrop config file for all spawned dotdrop executions
export DOTDROP_CONFIG="${DOTFILES}/dotdrop.yaml";

# Add /usr/local/bin and /opt/homebrew/bin to the path so that anything
# installed via homebrew is available to setup scripts
export PATH=$PATH:/usr/local/bin:/opt/homebrew/bin;

function maybe-bin() {
    local bin_name="${1}";
    which "${bin_name}" &2> /dev/null;
}

function err() {
    local message="${1}";
    echo "${message}. Exiting."
    exit 1;
}

PIP="$(mabybe-bin pip || maybe-bin pip3)";

echo "=== Checking environment is ready for setup";
[ -d "${DOTFILES}" ] && err "Dotfiles directory already exists";
[ -z "${PIP}" ] && err "Could not find pip, which is needed to run dotdrop";

echo "=== Cloning Dotfiles";
git clone --recurse-submodules "${DOTFILES_REPO}" "${DOTFILES}";

echo "=== Installing Dotdrop Requirements";
"${PIP}" install -r "${DOTFILES}/dotdrop/requirements.txt";

echo "=== Applying Dotdrop Profiles";
for profile in system applications identity git zsh emacs misc; do
    ${DOTDROP} install -P ${profile};
done

echo "=== SETUP COMPLETE!";
exit 0;
