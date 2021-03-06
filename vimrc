" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

set ignorecase  " do case insensitive search

set noswapfile  " disable swap file

" disable vi compatibility (emulation of old bugs)
set nocompatible

" use indentation of previous line
set autoindent

" use intelligent indentation for C
set smartindent

" autowrap text (t), and coments (c), don't break long
" lines in insert mode (l), no cindent
:autocmd FileType txt  set formatoptions=tcl
      \ nocindent comments&

" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces

" turn syntax highlighting on
set t_Co=256
syntax on

" Don't guess the terminal background color
set background=dark

" highlight matching braces
set showmatch
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */

" turn line numbers on
set number

" wrap lines at 80 chars.
set textwidth=75

"The next two options turn on fancy searching:
:set hlsearch  " highlight all search results
:set incsearch " show incremental search results as you type




"Proper word-wrapping in vim (like in Emacs) (2009-07-27 K.mandla blog),
"break at hyphen, space, URL: slash, hyphens
set formatoptions=l
set lbr

"remap k and j to gk, gj, for moving across wrapped lines.
nnoremap k gk
nnoremap j gj


"choose theme from ~/.vim/colors/
colorscheme zenburn
