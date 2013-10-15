filetype off
call pathogen#incubate()
syntax on
filetype plugin indent on

set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/

set laststatus=2
set t_Co=256

syntax enable
colorscheme elflord
set number

"Vimux keybindings
map rp :VimuxPromptCommand
map ri :VimuxInspectRunner

"Tabs are 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab

"Linemarker at column 100
set colorcolumn=100

"Tagbar hotkey
nmap <F8> :TagbarToggle<CR>

"More natural window splits
set splitbelow
set splitright
