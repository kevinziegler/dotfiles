#!/bin/bash

if [ -z $DOTFILES ]; then
    echo "No dotfiles repo specified!  Aborting!";
    exit 1;
fi

antibody bundle < "$DOTFILES/zsh/plugins.txt" > "$HOME/.plugins.zsh";
