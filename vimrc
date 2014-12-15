""" Behavioral Tweaks

" Out with the old, in with the new
set nocompatible

set shell=/bin/bash

" Spiceworks style guidlines
set tabstop=2
set shiftwidth=2
set expandtab

" Incremental searching
set incsearch

" Who can live without line numbers. This should be on by default grumble
" grumble grumble...
set number

" These split styles feel more natural
set splitbelow
set splitright

" Highlight where we /should/ stop typing.  Clean code FTW!
set colorcolumn=81
highlight ColorColumn ctermbg=7

" Highlight the current cursor line
set cursorline

" Show possible completions above the commpand line
set wildmenu

" Softwrap lines, don't break words
set wrap
set linebreak
set nolist

" Magic, apparently
filetype plugin on
filetype indent on
syntax on

" Allow use of the mouse from within vim
set mouse=a
set ttymouse=xterm2

" Resize splits as vim's window is resized
au VimResized * exe "normal! \<c-w>="

" MOAR POWER(line)
source /usr/local/lib/python2.7/site-packages/powerline/bindings/vim/plugin/powerline.vim
set laststatus=2

" Plugins! MOAR POWER!!!!!
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" Vundle manages Vundle?!!? So meta!
Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/syntastic'
Bundle 'mileszs/ack.vim'
Bundle 'majutsushi/tagbar'
Bundle 'tpope/vim-endwise'
Bundle 'vim-ruby/vim-ruby'
Bundle 'lmeijvogel/vim-yaml-helper'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Bundle 'scrooloose/nerdtree'
Bundle 'sjl/gundo.vim'
Bundle 'tpope/vim-rvm'
Bundle 'vim-scripts/taglist.vim'
Bundle 'terryma/vim-smooth-scroll'
Bundle 'rking/ag.vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'Raimondi/delimitMate'
Bundle 'Xuyuanp/nerdtree-git-plugin'
Bundle 'pangloss/vim-javascript'
Bundle 'briancollins/vim-jst'
Bundle 'jistr/vim-nerdtree-tabs'
"Bundle 'Townk/vim-autoclose'

""" Make it look good
set t_Co=256
set background=dark
colorscheme Tomorrow-Night-Bright

let g:solarized_termcolrs=256

let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

set guifont=Monaco\ for\ Powerline:h10
set guioptions-=r
set guioptions-=L

""" Leader mapped hotkeys for a great good
" Quickly toggle to a light color scheme
nmap <silent> <leader>l :colorscheme Tomorrow<CR>:set background=light<CR>
nmap <silent> <leader>d :colorscheme Tomorrow-Night-Bright<CR>:set background=dark<CR>

" Favorite CtrlP modes, at easy access
nmap <silent> <leader>pp :CtrlP<CR>
nmap <silent> <leader>pt :CtrlPTag<CR>

" Quickly run current buffer as a test.
nmap <silent> <leader>rtu :w<CR> :Rake test:unit TEST=%<CR>
nmap <silent> <leader>rtf :w<CR> :Rake test:functionals TEST=%<CR>
nmap <silent> <leader>rti :w<CR> :Rake test:integration TEST=%<CR>

" Miscellaneous other shortcuts
nmap <silent> <leader>t :TagbarToggle<CR>
nmap <silent> <leader>e :NERDTreeTabsToggle<CR>
nmap <silent> <leader>g :GundoToggle<CR>

let g:nerdtree_tabs_open_on_gui_startup=0

" Easier navigation of splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Scroll by visual lines
nnoremap j gj
nnoremap k gk

" Smooth scroll plugins 
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

""" Ignorance is bliss
set wildignore+=*.swp,*.o,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir': '\.git$\|\.hg$\|\.svn$\',
  \ 'file': '\v\.(db|o)$'
  \ }

" lefty-friendly leader
" This has to be at the bottom for some strange reason
let mapleader = "\<tab>"
nmap <leader> \
