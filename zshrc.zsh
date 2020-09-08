if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Environment configuration
export ZSH_PLUGINS_SOURCE=$HOME/.dotfiles/zsh_plugins.txt
export ZSH_PLUGINS_BUNDLE=$HOME/.zsh_plugins.sh
export GOPATH=$HOME/go
export TERM="xterm-256color"
export FZF_DEFAULT_OPTS="--prompt='➜ ' --pointer='•'"
export EDITOR="emacsclient -c"
export ALTERNATE_EDITOR="vim"
export CLICOLOR=1

fpath+="$HOME/.dotfiles/zsh/functions"

autoload -Uz history-fzf vterm_printf vterm_prompt_end source-optional iterm-init compinit-refresh plugin-init

export PATH=/usr/local/bin:\
/usr/local/sbin:/usr/sbin:\
/usr/bin:/sbin:\
/bin:\
/usr/games:\
/usr/local/games:\
$HOME/.bin:\
$HOME/go/bin:\
$HOME/doom/.emacs.d/bin\
$PATH

if [[ -o interactive ]]; then
    iterm-init
    compinit-refresh
    plugin-init "$ZSH_PLUGINS_BUNDLE" "$ZSH_PLUGINS_SROUCE"
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
