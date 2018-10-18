SRC_ANTIGEN=/usr/local/share/antigen/antigen.zsh

if [[ -o interactive ]]; then
  # Load Iterm2 Shell integration
  if [[ -s $HOME/.iterm2_shell_integration.zsh && $TERM_PROGRAM =~ iTerm ]]; then
      source $HOME/.iterm2_shell_integration.zsh
  fi

  # Load Antigen
  if [[ -s $SRC_ANTIGEN ]]; then
      source $SRC_ANTIGEN
  else
      echo "Couldn't load Antigen!  You're gonna have a bad time :-("
      echo "Run `brew install antigen` to get things working"
  fi

  antigen bundle mafredri/zsh-async
  antigen bundle zdharma/fast-syntax-highlighting
  antigen bundle zsh-users/zsh-autosuggestions
  antigen bundle zsh-users/zsh-history-substring-search
  antigen bundle brew
  antigen bundle bundler
  antigen bundle git
  antigen bundle tig
  antigen bundle gem
  antigen bundle docker
  antigen bundle jira
  antigen bundle vi-mode
  antigen bundle yarn
  antigen bundle zlsun/solarized-man
  antigen bundle eendroroy/zed-zsh
  antigen bundle $HOME/.dotfiles/pg-fzf
  # antigen bundle $HOME/bessie

  antigen theme sindresorhus/pure

  antigen apply
fi

export PATH=/usr/local/bin:\
/usr/local/sbin:/usr/sbin:\
/usr/bin:/sbin:\
/bin:\
/usr/games:\
/usr/local/games:\
$HOME/.bin:\
/$HOME/Library/Python/3.6/bin:\
$PATH

# Load nodenv by default
eval "$(nodenv init -)"

### Enable History substring search, even with VI mode
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
export PAGER=vimpager
export EDITOR=vim
export CLICOLOR=1
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

function emacsclient-cli() {
    local path_arg=".";

    # Set the path if it's provided as an arg
    if (( ${+1} )); then path_arg=$1; fi

    emacsclient -n $path_arg;
}

function _hide_and_seek_swap_files() {
    local source_file=$1;
    local target_file=$2;
    local action=$3;

    if ! [[ -e $source_file ]]; then
        echo "No such file $source_file exists.  Nothing to $action!";
        return;
    fi

    if [[ -e $target_file ]]; then
        echo "File already exists at $target_file.  Do you want to overwrite it?";
        read -q "HIDE_SEEK_FILE_REPLY?(y or n) > ";
        echo '\n';

        case $HIDE_SEEK_FILE_REPLY in
            n|no)
                echo "File $target_file exists; aborting...";
                return;
                ;;
            y|yes)
                echo "Overwriting existing $target_file with $source_file";
                ;;
        esac
    fi

    mv $source_file $target_file;

    case $action in
        'hide')
            echo "Hid $source_file at $target_file";
            ;;
        'seek')
            echo "Restored $target_file from $source_file";
            ;;
    esac
}

function hide_file() {
    local hidden_name="$1.hidden";
    _hide_and_seek_swap_files $1 $hidden_name 'hide'
}

function seek_file() {
    local hidden_name="$1.hidden";
    _hide_and_seek_swap_files $hidden_name $1 'seek'
}

### Aliases
alias be="bundle exec"
alias george="bundle exec"
alias pg="pg-fzf"
alias ec="emacsclient-cli"
alias chrome-no-cors="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome \
                        --disable-web-security \
                        --user-data-dir=`mktemp -d` \
                        --no-first-run"

if [ -f $HOME/.zsh.local ]; then
  source $HOME/.zsh.local;
fi
