SRC_ANTIGEN=/usr/local/share/antigen/antigen.zsh
SRC_Z_CMD=/usr/local/etc/profile.d/z.sh

# Load Iterm2 Shell integration
if [[ -s $HOME/.iterm2_shell_integration.zsh ]]; then
    source $HOME/.iterm2_shell_integration.zsh
fi

# Load Antigen
if [[ -s $SRC_ANTIGEN ]]; then
    source $SRC_ANTIGEN
else
    echo "Couldn't load Antigen!  You're gonna have a bad time :-("
    echo "Run `brew install antigen` to get things working"
fi

if [[ -s $SRC_Z_CMD ]]; then
    source /usr/local/etc/profile.d/z.sh
else
    echo "Couldn't load z!"
fi

antigen bundle mafredri/zsh-async
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle brew
antigen bundle bundler
antigen bundle chruby
antigen bundle git
antigen bundle tig
antigen bundle gem
antigen bundle docker
antigen bundle jira
antigen bundle vi-mode
antigen bundle yarn
antigen bundle zlsun/solarized-man
antigen bundle $HOME/.dotfiles/pg-fzf

antigen theme sindresorhus/pure

antigen apply

### Aliases
alias be="bundle exec"
alias george="bundle exec"
alias pg="pg-fzf"
alias chrome-no-cors="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome \
                        --disable-web-security \
                        --user-data-dir=`mktemp -d` \
                        --no-first-run"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

export PATH=/usr/local/bin:\
/usr/local/sbin:/usr/sbin:\
/usr/bin:/sbin:\
/bin:\
/usr/games:\
/usr/local/games:\
$HOME/.bin:\
/$HOME/Library/Python/3.6/bin:\
$PATH

export PAGER=vimpager
export EDITOR=nvim
export CLICOLOR=1
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

# Load nodenv by default
eval "$(nodenv init -)"

# Enable History substring search, even with VI mode
function history-fzf() {
    local tac

    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi

    BUFFER=$(history -n 1 | eval $tac | fzf --query "$LBUFFER" --border --height=40% --reverse)
    CURSOR=$#BUFFER

    zle reset-prompt
}

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

bindkey '^r' history-fzf
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

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
