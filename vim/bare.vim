set nocompatible
filetype plugin on

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

set path+=./**

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

set number
set incsearch

runtime macros/matchit.vim
