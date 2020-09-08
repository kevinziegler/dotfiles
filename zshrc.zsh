if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export TERM="xterm-256color"

export FZF_DEFAULT_OPTS="--prompt='➜ ' --pointer='•'"

ZSH_PLUGINS_SOURCE=$HOME/.dotfiles/zsh_plugins.txt
ZSH_PLUGINS_BUNDLE=$HOME/.zsh_plugins.sh
source $HOME/.dotfiles/hide-seek.zsh
source $HOME/.dotfiles/powerlevel9k.mavam.zsh

export PATH=/usr/local/bin:\
/usr/local/sbin:/usr/sbin:\
/usr/bin:/sbin:\
/bin:\
/usr/games:\
/usr/local/games:\
$HOME/.bin:\
/$HOME/Library/Python/3.6/bin:\
/$HOME/go/bin:\
$PATH

if [[ -o interactive ]]; then
    # Load Iterm2 Shell integration
    if [[ -s $HOME/.iterm2_shell_integration.zsh && $TERM_PROGRAM =~ iTerm ]]; then
        source $HOME/.iterm2_shell_integration.zsh
    fi

    autoload -Uz compinit
    if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
      compinit
    else
      compinit -C
    fi

    if [[ ! -a $ZSH_PLUGINS_BUNDLE ]]; then
        echo "WARNING: Couldn't find antibody bundle.  Regenerating..."
        antibody bundle < $ZSH_PLUGINS_SOURCE > $ZSH_PLUGINS_BUNDLE
    fi

    source $ZSH_PLUGINS_BUNDLE
fi

export GOPATH=$HOME/go
export PATH="$HOME/.jenv/bin:$PATH"

eval "$(nodenv init -)"
eval "$(rbenv init -)"
eval "$(jenv init -)"

### Enable History substring search, even with VI mode
function history-fzf() {
    local tac

    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi

    BUFFER=$(                                                     \
        history -n 1                                              \
        | eval $tac                                               \
        | fzf --query "$LBUFFER" --border --height=40% --reverse
    )

    CURSOR=$#BUFFER

    zle reset-prompt
}

### Change cursor based on vi mode
function zle-keymap-select zle-line-init zle-line-finish {
    case $KEYMAP in
        vicmd)      print -n -- "\E]50;CursorShape=0\C-G";; # block cursor
        viins|main) print -n -- "\E]50;CursorShape=1\C-G";; # line cursor
    esac

    zle reset-prompt
    zle -R
}

zle -N history-fzf
zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

### Custom key bindings
bindkey '^r' history-fzf
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

### History Settings
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

HISTSIZE=10000
if (( ! EUID )); then
    HISTFILE=~/.zsh_history_root
else
    HISTFILE=~/.zsh_history
fi
SAVEHIST=10000

### Environment configuration
export EDITOR="emacsclient -c"
export ALTERNATE_EDITOR="vim"
export CLICOLOR=1

### Aliases
alias be="bundle exec"
alias ec="emacsclient -nc"
alias hide-mycnf="hide_file $HOME/.my.cnf"
alias seek-mycnf="seek_file $HOME/.my.cnf"
alias antibody-reload="antibody bundle < $ZSH_PLUGINS_SOURCE > $ZSH_PLUGINS_BUNDLE"
alias ave="opav exec"
alias av="opav"

if [ -f $HOME/.zsh.local ]; then
  source $HOME/.zsh.local;
fi

export PATH="/usr/local/opt/postgresql@11/bin:$PATH"
export PATH=$PATH:"$HOME/doom/.emacs.d/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ "$INSIDE_EMACS" = 'vterm' ]]; then
    alias clear='vterm_printf "51;Evterm-clear-scrollback";tput clear'
fi

function vterm_printf(){
    if [ -n "$TMUX" ]; then
        # Tell tmux to pass the escape sequences through
        # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}

vterm_prompt_end() {
    vterm_printf "51;A$(whoami)@$(hostname):$(pwd)";
}

setopt PROMPT_SUBST
PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'
