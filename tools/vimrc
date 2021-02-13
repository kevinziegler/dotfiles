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
set rnu

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


call plug#begin('~/.vim/bundle')
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-endwise'
Plug 'vim-ruby/vim-ruby'
Plug 'sjl/gundo.vim'
Plug 'terryma/vim-smooth-scroll'
Plug 'rking/ag.vim'
Plug 'airblade/vim-gitgutter'
Plug 'Raimondi/delimitMate'
Plug 'pangloss/vim-javascript'
Plug 'briancollins/vim-jst'
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'bling/vim-airline'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'godlygeek/tabular'
Plug 'docunext/closetag.vim', { 'for': ['html', 'hbs'] }
Plug 'kopischke/vim-fetch'
call plug#end()


""" Faster CTRLP through AG
let g:ctrlp_use_caching = 0
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor

    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif

let g:ctrlp_working_path_mode ='ra'

""" Make it look good
set t_Co=256
" set background=dark
" colorscheme default
" colorscheme Tomorrow-Night-Bright
" colorscheme solarized

let g:Powerline_theme='short'
let g:Powerline_colorscheme='solarized256_dark'

highlight clear SignColumn
"highlight GitGutterAdd ctermfg=green
"highlight GitGutterChange ctermfg=yellow
"highlight GitGutterDelete ctermfg=red
"highlight GitGutterChangeDelete ctermfg=yellow

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

" Use starscope instead of ctags, since, you know, Ruby
"let g:easytags_cmd = '/usr/bin/starscope'
"let g:easytags_opts = ['-e=ctags']

" Use a local tag file instead of the global one
let g:easytags_dynamic_files=2

""" Ignorance is bliss
set wildignore+=*.swp,*.o,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir': '\.git$\|\.hg$\|\.svn$\',
  \ 'file': '\v\.(db|o)$'
  \ }

let g:ctrlp_match_window='results:50'

""" Highlight EJS files as HTML
au BufNewFile,BufRead *.ejs set filetype=html

function! AirlineThemePatch(palette)
  let a:palette.normal_modified.airline_c =  ['#cb4b16', '#eee8d5', 166, 254, '']
  let a:palette.insert_modified.airline_c =  ['#cb4b16', '#eee8d5', 166, 254, '']
  let a:palette.visual_modified.airline_c =  ['#cb4b16', '#eee8d5', 166, 254, '']
endfunction
let g:airline_theme_patch_func = 'AirlineThemePatch'

""" Better CTags support for Ruby:
let g:tagbar_type_ruby = {
    \ 'kinds' : [
        \ 'm:modules',
        \ 'c:classes',
        \ 'd:describes',
        \ 'C:contexts',
        \ 'f:methods',
        \ 'F:singleton methods'
    \ ]
\ }

let g:investigate_use_dash=1
let g:investigate_dash_for_ruby="r4"

" lefty-friendly leader
" This has to be at the bottom for some strange reason
let mapleader = "\<tab>"
nmap <leader> \

" Set cursor shapes for iterm.  This overrides what comes in from ZSH
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
