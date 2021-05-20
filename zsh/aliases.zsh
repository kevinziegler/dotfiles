alias be="bundle exec";
alias ec="emacsclient -nc";
alias antibody-reload="antibody bundle < $ZSH_PLUGINS_SOURCE > $ZSH_PLUGINS_BUNDLE";
alias ave="opav exec";
alias av="opav";
alias aws-vault="opav";
alias fr="fzf-repl";

alias tf-browse="terraform state list | fzf --preview 'terraform state show {}'";
alias tg-browse="terragrunt state list | fzf --preview 'terragrunt state show {}'";

# Overriding unit utilities
alias ls="exa";
alias cat="bat";
