
let $VIMCACHE = '~/.local/share/nvim/'

set nocompatible

call plug#begin($VIMCACHE . 'plugged')

    Plug 'sheerun/vim-polyglot'

    Plug 'itchyny/lightline.vim'

    Plug 'arcticicestudio/nord-vim'
    Plug 'mhartington/oceanic-next'

    Plug 'dense-analysis/ale'
    " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    " Plug 'deoplete-plugins/deoplete-jedi'
    Plug 'davidhalter/jedi-vim'

    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-characterize'
    Plug 'tpope/vim-fugitive'

    Plug 'mhinz/vim-signify'

call plug#end()

set title
set visualbell
set mouse=a
set number
set numberwidth=1
set cursorline
set norelativenumber
set colorcolumn=81
set ignorecase smartcase
set infercase
set showmatch
set matchtime=8
set matchpairs+=<:>

set autoindent
set smartindent
set expandtab
set tabstop=4
set shiftwidth=0
set softtabstop=-1

set updatetime=100

set nowrap
set textwidth=80
set linebreak

set history=1000
set undolevels=1000
set undofile

set laststatus=2

set encoding=utf-8
set termencoding=utf-8

set wildmenu
" set wildmode=list:longest,full
set wildmode=full
set wildcharm=<TAB>
set wildignore+=.hg,.git,.svn
set wildignore+=*.DS_Store
set wildignore+=*.o,*.obj,*.py[co],*.bak,*.exe,*.swp,*~
set wildignore+=*.jpg,*.png,*.gif,*.pdf,*.jpeg,*.tiff
set wildignore+=*.odt,*.ods,*.zip,*.bz2,*.gz,*.tgz,*.tbz2,*.7z,*.z
set wildignore+=*.doc,*.xls,*.xlsx,*.docx
set wildignore+=eggs
set wildignore+=*.egg-info
set wildignore+=node_modules
set wildignore+=env
set wildignore+=bower_components

set termguicolors
set background=dark
colorscheme nord

set iskeyword+=-
set listchars=tab:»\ ,trail:·,extends:>,precedes:<,nbsp:_

let mapleader=","

let g:python3_host_prog='~/.local/pyenv/versions/neovim_py3/bin/python'

" ale
"    NB. flake8 must be in PATH for python linting to work
let g:ale_linters = {
\   'python': ['flake8'],
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\   'vue': ['eslint']
\}
let g:ale_fixers = {
\    'python': ['remove_trailing_lines', 'trim_whitespace', 'yapf'],
\    'javascript': ['prettier'],
\    'typescript': ['prettier'],
\    'css': ['prettier'],
\    'scss': ['prettier'],
\    'vue': ['prettier'],
\    'jsx': ['prettier'],
\    'yaml': ['prettier'],
\    'json': ['prettier'],
\    'markdown': ['prettier']
\}
let g:ale_sign_column_always = 1
let g:ale_set_loclist = 0
let g_ale_set_quickfix = 1
" Lint only when saving file
let g:ale_lint_on_text_changed = 1
let g:ale_lint_on_insert_leave = 1
" Apply auto fixes when saving file
let g:ale_fix_on_save = 1
" Do not highlight area with error (only set sign marker)
let g:ale_set_highlights = 0

" lightline
set noshowmode
let g:lightline = {
    \ 'colorscheme': 'one',
    \ 'active': {
        \ 'left': [ [ 'mode', 'paste', 'gitstatus' ],
        \           [ 'readonly', 'filename', 'modified' ] ],
        \ 'right': [ [ 'lineinfo' ],
        \            [ 'percent' ],
        \            [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
    \},
    \ 'component': {
        \ 'gitstatus': ' %{FugitiveHead()}'
    \ }
\}

" commentary
nmap <Leader>c <Plug>CommentaryLine
xmap <Leader>c <Plug>Commentary

" fugitive
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gb :Gblame<CR>

" deoplete
" let g:deoplete#enable_at_startup = 1

" jedi
let g:jedi#auto_vim_configuration = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#use_splits_not_buffers = "right"
let g:jedi#popup_on_dot = 1
let g:jedi#popup_select_first = 0
let g:jedi#show_call_signatures = "1"
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"

autocmd FileType python setlocal completeopt-=preview


" hot keys
" strip trailing whitespace
map <leader>ts :%s/\s\+$//e<CR>
" F2 - save buffer
nmap <F2> :w<CR>
vmap <F2> <esc>:w<CR>i
imap <F2> <esc>:w<CR>i


set secure
