#!/usr/bin/env bash

set -euf -o pipefail;

GITHUB_DOOM_D_REPO="kevinziegler/doom.d";
GITHUB_DOOM_REPO="hlissner/doom-emacs";

hub clone "$GITHUB_DOOM_D_REPO" "$HOME/.doom.d";
hub clone "$GITHUB_DOOM_REPO" "$HOME/.emacs.d";

"$HOME/.emacs.d/bin/doom" install;
emacs --eval "(all-the-icons-install-fonts t)" --kill;

exit 0;
