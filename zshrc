#
# User configuration sourced by interactive shells
#

# Source zim
if [[ -s ${ZDOTDIR:-${HOME}}/.zim/init.zsh ]]; then
  source ${ZDOTDIR:-${HOME}}/.zim/init.zsh
fi

# Load Iterm2 Shell integration
if [[ -s $HOME/.iterm2_shell_integration.zsh ]]; then
  source $HOME/.iterm2_shell_integration.zsh
fi

### Aliases
alias be="bundle exec"
alias george="bundle exec"
alias chrome-no-cors="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome \
                        --disable-web-security \
                        --user-data-dir=`mktemp -d` \
                        --no-first-run"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Uncomment to change how often before auto-updates occur? (in days)
export UPDATE_ZSH_DAYS=26

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

#source $ZSH/oh-my-zsh.sh
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh
source /usr/local/etc/profile.d/z.sh

# Customize to your needs...
export PATH=/usr/local/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:$HOME/.bin:$PATH

export PAGER=vimpager
export EDITOR=nvim

# Load nodenv by default
eval "$(nodenv init -)"

# Use Vi-style keybindings by default
bindkey -v

# Enable History substring search, even with VI mode
bindkey '^R' history-incremental-search-backward
