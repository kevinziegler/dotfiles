#!/usr/bin/env bash

set -euf -o pipefail;

BREW_URL="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh";

if ! which brew &> /dev/null; then
	echo "Homebrew not found...Installing";
	/bin/bash -c "$(curl -fsSl $BREW_URL)";
fi

brew bundle -f "$DOTFILES/Brewfile";

exit 0;
