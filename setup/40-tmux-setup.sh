#!/usr/bin/env bash

set -euf -o pipefail;

TPM_PATH="$HOME/.tmux/plugins/tpm";

mkdir -p $(dirname $TPM_PATH);
git clone https://github.com/tmux-plugins/tpm "$TPM_PATH";
tmux run-shell "$TPM_PATH/bindings/install_plugins";
