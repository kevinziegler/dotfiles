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

" Enable status bar
set laststatus=2

" Plugins! MOAR POWER!!!!!
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" Vundle manages Vundle?!!? So meta!
Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'mileszs/ack.vim'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-endwise'
Plugin 'vim-ruby/vim-ruby'
Plugin 'lmeijvogel/vim-yaml-helper'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Plugin 'scrooloose/nerdtree'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-rvm'
Plugin 'vim-scripts/taglist.vim'
Plugin 'terryma/vim-smooth-scroll'
Plugin 'rking/ag.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'Raimondi/delimitMate'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'pangloss/vim-javascript'
Plugin 'briancollins/vim-jst'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'tmhedberg/matchit'
Plugin 'gilsondev/searchtasks.vim'
"Plugin 'Townk/vim-autoclose'
Plugin 'tpope/vim-dispatch'
Plugin 'altercation/vim-colors-solarized'
Plugin 'stephenmckinney/vim-solarized-powerline'
Plugin 'tpope/vim-surround'
Plugin 'bling/vim-airline'

""" Make it look good
set t_Co=256
set background=dark
"colorscheme Tomorrow-Night-Bright
colorscheme solarized

let g:solarized_termcolors=256
let g:Powerline_theme='short'
let g:Powerline_colorscheme='solarized256_dark'

highlight clear SignColumn
"highlight GitGutterAdd ctermfg=green
"highlight GitGutterChange ctermfg=yellow
"highlight GitGutterDelete ctermfg=red
"highlight GitGutterChangeDelete ctermfg=yellow

let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

set guifont=Monaco\ for\ Powerline:h10
set guioptions-=r
set guioptions-=L

" powerline symbols for vim-airline
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols = {}
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

""" Leader mapped hotkeys for a great good
" Quickly toggle to a light color scheme
"nmap <silent> <leader>lt :colorscheme Tomorrow<CR>:set background=light<CR>
"nmap <silent> <leader>dt:colorscheme Tomorrow-Night-Bright<CR>:set background=dark<CR>
nmap <silent> <leader>lt :set background=light<CR>
nmap <silent> <leader>dt :set background=dark<CR>

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

" Format buffer contents as JSON data.
nmap <silent> <leader>jf :%!python -m json.tool<CR>

" Toggle relative line numbers
nmap <silent> <leader>rn :exec &nu==&rnu? "se nornu!" : "se rnu!"<CR>

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

""" Highlight EJS files as HTML
au BufNewFile,BufRead *.ejs set filetype=html

function! AirlineThemePatch(palette)
  let a:palette.normal_modified.airline_c =  ['#cb4b16', '#eee8d5', 166, 254, '']
  let a:palette.insert_modified.airline_c =  ['#cb4b16', '#eee8d5', 166, 254, '']
  let a:palette.visual_modified.airline_c =  ['#cb4b16', '#eee8d5', 166, 254, '']
endfunction
let g:airline_theme_patch_func = 'AirlineThemePatch'

" lefty-friendly leader
" This has to be at the bottom for some strange reason
let mapleader = "\<tab>"
nmap <leader> \
