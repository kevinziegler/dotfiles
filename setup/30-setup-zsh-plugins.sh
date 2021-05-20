set -euf -o pipefail;

antibody bundle < "$DOTFILES/zsh/plugins.txt" > "$HOME/.plugins.zsh";

exit 0;
