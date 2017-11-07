SRC_ANTIGEN=/usr/local/share/antigen/antigen.zsh

if [[ -s $SRC_ANTIGEN ]]; then
    source $SRC_ANTIGEN
else
    echo "Couldn't load Antigen!  You're gonna have a bad time :-("
    echo "Run `brew install antigen` to get things working"
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

antigen theme sindresorhus/pure

antigen apply

### Aliases
alias be="bundle exec"
alias george="bundle exec"
alias chrome-no-cors="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome \
                        --disable-web-security \
                        --user-data-dir=`mktemp -d` \
                        --no-first-run"

# Load Iterm2 Shell integration
if [[ -s $HOME/.iterm2_shell_integration.zsh ]]; then
    source $HOME/.iterm2_shell_integration.zsh
fi

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Uncomment to change how often before auto-updates occur? (in days)
export UPDATE_ZSH_DAYS=26

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

source /usr/local/etc/profile.d/z.sh

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

zle -N history-fzf

function zle-keymap-select zle-line-init zle-line-finish {
    case $KEYMAP in
        vicmd)      print -n -- "\E]50;CursorShape=0\C-G";; # block cursor
        viins|main) print -n -- "\E]50;CursorShape=1\C-G";; # line cursor
    esac

    zle reset-prompt
    zle -R
}

bindkey '^r' history-fzf
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

setopt INC_APPEND_HISTORY

HISTSIZE=10000
if (( ! EUID )); then
    HISTFILE=~/.zsh_history_root
else
    HISTFILE=~/.zsh_history
fi
SAVEHIST=10000
