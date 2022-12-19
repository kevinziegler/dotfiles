#!/usr/bin/env zsh

if [ -z "$HOMEBREW_PREFIX" ]; then
    if [ $(uname -m) = "x86_64" ]; then
        export HOMEBREW_PREFIX="/usr/local";
    else
        export HOMEBREW_PREFIX="/opt/homebrew/";
    fi
fi

autoloads=(
    vterm_printf
    vterm_prompt_end
    source-optional
    iterm-init
    compinit-refresh
    plugin-init
    fzf-repl
    exa-tree
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
    plugin-init "$ZSH_PLUGINS_BUNDLE" "$ZSH_PLUGINS_SOURCE";
fi

for df in $source_dotfiles; do source "$DOTFILES/tools/zsh/$df.zsh"; done
for sf in $source_optional; do source-optional "$sf"; done

eval "$(direnv hook zsh)";
eval "$(mcfly init zsh)";
eval "$(op completion zsh)";
eval "$(kubecm completion zsh)";

compdef _op op;
