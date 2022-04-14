#!/usr/bin/env bash

set -euf -o pipefail;

GITHUB_DOOM_D_REPO="git@github.com:kevinziegler/doom.d";
GITHUB_DOOM_REPO="git@github.com:hlissner/doom-emacs";

git clone "$GITHUB_DOOM_D_REPO" "$HOME/.doom.d";
git clone "$GITHUB_DOOM_REPO" "$HOME/.emacs.d";

"$HOME/.emacs.d/bin/doom" install;
emacs --eval "(all-the-icons-install-fonts t)" --kill;

exit 0;
