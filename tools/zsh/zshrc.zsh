#!/usr/bin/env zsh

autoloads=(
    vterm_printf
    vterm_prompt_end
    source-optional
    iterm-init
    compinit-refresh
    fzf-repl
    exa-tree
    ensure
);

source_dotfiles=(
    prompt
    aliases
    emacs-vterm
    vi-cursor
    vivid
    history
);

source_optional=(
    $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh
    $HOMEBREW_PREFIX/etc/profile.d/z.sh
    $HOME/.local.zsh
    $HOME/.fzf.zsh
    $HOME/.p10k.zsh
    $HOME/.iterm2_shell_integration.zsh
);

fpath+="$DOTFILES/tools/zsh/functions";

prompt_cache="${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh";
[[ -r $prompt_cache ]] && source $prompt_cache;

autoload -Uz $autoloads;

if [[ -o interactive ]]; then
    iterm-init;
    compinit-refresh;
fi

source "$(brew --prefix antidote)/share/antidote/antidote.zsh"
antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt

for df in $source_dotfiles; do source "$DOTFILES/tools/zsh/$df.zsh"; done
for sf in $source_optional; do source-optional "$sf"; done

ensure "direnv" "skipping initialization" && eval "$(direnv hook zsh)";
ensure "mcfly" "skipping initialization" && eval "$(mcfly init zsh)";
ensure "op" "skipping initialization" && eval "$(op completion zsh)";
# ensure "kubecm" "skipping initialization" && eval "$(kubecm completion zsh)";

compdef _op op;
