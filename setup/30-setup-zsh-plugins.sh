#!/usr/bin/env bash

set -euf -o pipefail;

antibody bundle < "$DOTFILES/tools/zsh/plugins.txt" > "$HOME/.plugins.zsh";

exit 0;
