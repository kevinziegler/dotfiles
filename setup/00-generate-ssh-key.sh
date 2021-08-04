#!/usr/bin/env bash

set -euf -o pipefail;

echo "[$(basename $0)] Generating an $SSH_KEY_TYPE SSH key at $SSH_KEY";

if [[ -f "$SSH_KEY" ]]; then
    SSH_KEY_BACKUP="$SSH_KEY.bak";
    echo "Existing SSH Key found at $SSH_KEY.  Backing up to $SSH_KEY_BACKUP";
    mv "$SSH_KEY" "$SSH_KEY_BACKUP";
fi

ssh-keygen -t "$SSH_KEY_TYPE" -f "$SSH_KEY" -N "";

exit 0;
