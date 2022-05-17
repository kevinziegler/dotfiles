### Custom key bindings
# bindkey '^r' history-fzf
# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down

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

# zle -N history-fzf
