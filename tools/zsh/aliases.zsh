alias be="bundle exec";
alias antibody-reload="antibody bundle < $ZSH_PLUGINS_SOURCE > $ZSH_PLUGINS_BUNDLE";
alias ave="opav exec";
alias av="opav";
alias aws-vault="opav";
alias fr="fzf-repl";
alias et="exa-tree";
alias listening-ports="sudo lsof -PiTCP -sTCP:LISTEN";

alias tf-browse="terraform state list | fzf --preview 'terraform state show {}'";
alias tg-browse="terragrunt state list | fzf --preview 'terragrunt state show {}'";


alias d="docker";
alias g="git";
alias k="kubectl";

alias nuke="rm -rf";
alias csv="pspg --csv --csv-header on";
alias de="docker-explore";
alias gb="gitbatch -r 5";

# Overriding unix utilities
alias ls="exa";
alias cat="bat";

alias private-session="fc -p";
