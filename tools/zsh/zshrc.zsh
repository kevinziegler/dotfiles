autoloads=(
    vterm_printf
    vterm_prompt_end
    source-optional
    iterm-init
    compinit-refresh
    plugin-init
    asdf-install
    asdf-add-plugin
    fzf-repl
    exa-tree
);

path_additions=(
    /usr/local/sbin
    /usr/local/bin
    $HOME/.bin
    $HOME/go/bin
    $HOME/.emacs.d/bin
    $HOME/.dotfiles/bin
);

source_dotfiles=(
    prompt
    aliases
    emacs-vterm
    vi-cursor
    vivid
);

source_optional=(
    $HOME/.local.zsh
    $HOME/.fzf.zsh
    /usr/local/opt/asdf/asdf.sh
    $HOME/.p10k.zsh
);

if [ -z "$HOMEBREW_PREFIX" ]; then
    if [ $(uname -m) = "x86_64" ]; then
        export HOMEBREW_PREFIX="/usr/local";
    else
        export HOMEBREW_PREFIX="/opt/homebrew/";
    fi
fi

fpath+="$DOTFILES/tools/zsh/functions";
fpath+="$HOMEBREW_PREFIX/share/zsh/site-functions";

prompt_cache="${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh";
[[ -r $prompt_cache ]] && source $prompt_cache;

autoload -Uz $autoloads;
export PATH=${(j-:-)path_additions}:$PATH;

if [[ -o interactive ]]; then
    iterm-init;
    compinit-refresh;
    plugin-init "$ZSH_PLUGINS_BUNDLE" "$ZSH_PLUGINS_SOURCE";
fi

for df in $source_dotfiles; do source "$DOTFILES/tools/zsh/$df.zsh"; done
for sf in $source_optional; do source-optional "$sf"; done

eval "$(direnv hook zsh)";
eval "$(mcfly init zsh)";
