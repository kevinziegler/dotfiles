filetype off
call pathogen#incubate()
syntax on
filetype plugin indent on

set t_Co=256

syntax enable
"set background=dark
"colorscheme solarized
colorscheme elflord
set number

"Vimux keybindings
map rp :VimuxPromptCommand
map ri :VimuxInspectRunner

set tabstop=4
set shiftwidth=4
set expandtab
