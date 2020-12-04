prompt_cache="${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
[[ -r $prompt_cache ]] && source $prompt_cache;

### Environment configuration
export ZSH_PLUGINS_SOURCE=$HOME/.dotfiles/zsh_plugins.txt
export ZSH_PLUGINS_BUNDLE=$HOME/.zsh_plugins.sh
export TERM="xterm-256color"
export FZF_DEFAULT_OPTS="--prompt='➜ ' --pointer='•'"
export EDITOR="emacs-client-editor"
export ALTERNATE_EDITOR="vim"
export CLICOLOR=1

if type vivid > /dev/null; then
    export LS_COLORS="$(vivid generate snazzy)"
fi

fpath+="$HOME/.dotfiles/zsh/functions"

autoloads=(
    history-fzf
    vterm_printf
    vterm_prompt_end
    source-optional
    iterm-init
    compinit-refresh
    plugin-init
    emacs-client-editor
)

path_additions=(
    /usr/local/sbin
    /usr/local/bin
    $HOME/.bin
    $HOME/go/bin
    $HOME/.emacs.d/bin
);

autoload -Uz $autoloads
export PATH=${(j-:-)path_additions}:$PATH

if [[ -o interactive ]]; then
    iterm-init
    compinit-refresh
    plugin-init "$ZSH_PLUGINS_BUNDLE" "$ZSH_PLUGINS_SOURCE"
fi

source $HOME/.dotfiles/hide-seek.zsh
source $HOME/.dotfiles/powerlevel9k.mavam.zsh
source $HOME/.dotfiles/zsh/aliases.zsh
source $HOME/.dotfiles/zsh/emacs-vterm.zsh
source $HOME/.dotfiles/zsh/history.zsh
source $HOME/.dotfiles/zsh/vi-cursor.zsh
source $HOME/.dotfiles/zsh/emacs.zsh

source-optional $HOME/.local.zsh
source-optional $HOME/.fzf.zsh
source-optional /usr/local/opt/asdf/asdf.sh
source-optional $HOME/.p10k.zsh
