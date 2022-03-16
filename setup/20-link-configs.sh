#!/usr/bin/env bash

set -euf -o pipefail;

function link_config {
	DOTFILE_PATH="$DOTFILES/$1";
	CONFIG_FILE="$HOME/$2";
	TARGET_DIR=$(dirname $CONFIG_FILE);

	if [ ! -d "$TARGET_DIR" ]; then
		mkdir -p "$TARGET_DIR";
	fi

	echo "Linking $CONFIG_FILE ($DOTFILE_PATH)";
	ln -s "$DOTFILE_PATH" "$CONFIG_FILE";
}

echo "Linking Configurations...";
link_config "tools/git/gitconfig" ".gitconfig";
link_config "tools/git/gitignore_global" ".gitignore_global";
link_config "system/mackup.cfg" ".mackup.cfg";
link_config "tools/alacritty/alacritty.yml" ".alacritty.yml";
link_config "tools/psqlrc" ".psqlrc";
link_config "tools/myclirc" ".myclirc";
link_config "tools/tmux.conf" ".tmux.conf";
link_config "tools/zsh/zshrc.zsh" ".zshrc";
link_config "tools/zsh/zshenv.zsh" ".zshenv";
link_config "tools/pgcli.toml" ".config/pgcli/config";

exit 0;
