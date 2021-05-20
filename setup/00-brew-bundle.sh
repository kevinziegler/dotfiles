#!/bin/bash

if [ -z $DOTFILES ]; then
    echo "No dotfiles repo specified!  Aborting!";
    exit 1;
fi

brew bundle -f "$DOTFILES/Brewfile";
