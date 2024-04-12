
export DOTFILES="$HOME/.dotfiles";
export ZSH_PLUGINS_SOURCE=$DOTFILES/tools/zsh/plugins.txt;
export ZSH_PLUGINS_BUNDLE=$HOME/.plugins.zsh;
export TERM="xterm-256color";
export FZF_JELLYBEANS_OPTS="--color fg:-1,bg:-1,hl:230,fg+:3,bg+:233,hl+:229 --color info:150,prompt:110,spinner:150,pointer:167,marker:174";
export FZF_DEFAULT_OPTS="--prompt='➜ ' --pointer='‣' --marker='•' --border='rounded' $FZF_JELLYBEANS_OPTS";
export EDITOR="ec";
export ALTERNATE_EDITOR="vim";
export CLICOLOR=1;
export PSPG="--style=22";
export LSP_USE_PLISTS="true";
export MANPATH="$(manpath)";

if [ -z "$HOMEBREW_PREFIX" ]; then
    if [ $(uname -m) = "x86_64" ]; then
        export HOMEBREW_PREFIX="/usr/local";
    else
        export HOMEBREW_PREFIX="/opt/homebrew";
    fi
fi

path_additions=(
    $HOME/.bin
    $HOME/go/bin
    $HOME/.cargo/bin
    $HOME/.emacs.d/bin
    $DOTFILES/bin
    $HOMEBREW_PREFIX/bin
    $HOMEBREW_PREFIX/sbin
);

export PATH=${(j-:-)path_additions}:$PATH;
