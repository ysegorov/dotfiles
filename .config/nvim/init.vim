
let $VIMCACHE = '~/.local/share/nvim/'

set nocompatible

call plug#begin($VIMCACHE . 'plugged')

    Plug 'sheerun/vim-polyglot'

    Plug 'itchyny/lightline.vim'

    Plug 'arcticicestudio/nord-vim'
    Plug 'mhartington/oceanic-next'
    " Plug 'gruvbox-material/vim', {'as': 'gruvbox-material'}
    " Plug 'lifepillar/vim-solarized8'
    " Plug 'morhetz/gruvbox'
    " Plug 'jnurmine/zenburn'
    " Plug 'mkarmona/colorsbox'

    Plug 'dense-analysis/ale'
    " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    " Plug 'deoplete-plugins/deoplete-jedi'
    Plug 'davidhalter/jedi-vim'

    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-characterize'
    Plug 'tpope/vim-fugitive'

    Plug 'mhinz/vim-signify'

    Plug 'farmergreg/vim-lastplace'

    Plug '~/dev/vim-yaggy'

call plug#end()

set title
set visualbell
set mouse=a
set number
set numberwidth=1
set signcolumn=yes
set cursorline
set norelativenumber
set colorcolumn=81
set ignorecase
set smartcase
set infercase
set hlsearch
set incsearch
set showmatch
set matchtime=8
set matchpairs+=<:>

set autoindent
set smartindent
set expandtab
set tabstop=4
set shiftwidth=0
set softtabstop=-1
set shiftround

set hidden
set updatetime=100

set scrolloff=4
set sidescrolloff=10

set nowrap
" set textwidth=80
" set linebreak

set history=1000
set undolevels=1000
set undofile

" set cmdheight=2
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

" let g:gruvbox_material_background = 'medium'
" let g:gruvbox_material_cursor = 'green'
" let g:gruvbox_material_enable_italic = 0
" let g:gruvbox_material_disable_italic_comment = 0
" let g:gruvbox_material_enable_bold = 0
" let g:gruvbox_material_lightline_disable_bold = 0
" let g:gruvbox_material_visual = 'reverse'

" let g:gruvbox_bold = '0'
" let g:gruvbox_italic = '0'
" let g:gruvbox_underline = '0'
" let g:gruvbox_undercurl = '0'
" let g:gruvbox_italicize_comments = '0'
" let g:gruvbox_invert_signs = '1'
" let g:gruvbox_improved_strings = '1'
" let g:gruvbox_improved_warnings = '1'
" let g:gruvbox_contrast_dark = 'medium'
" let g:gruvbox_contrast_light = 'soft'
" let g:gruvbox_invert_selection = '0'

let g:oceanic_next_terminal_bold = 0
let g:oceanic_next_terminal_italic = 0

set termguicolors
set background=dark
colorscheme OceanicNext

set iskeyword+=-
set listchars=tab:»\ ,trail:·,extends:>,precedes:<,nbsp:_

let mapleader=","

let g:python3_host_prog='~/.local/pyenv/versions/neovim_py3/bin/python'

" netrw
let g:netrw_dirhistmax  = 0

" ale
"    NB. flake8 must be in PATH for python linting to work
let g:ale_linters = {
\   'python': ['flake8'],
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\   'vue': ['eslint']
\}
let g:ale_fixers = {
\    '*': ['remove_trailing_lines', 'trim_whitespace'],
\    'python': ['yapf'],
\    'javascript': ['prettier'],
\    'typescript': ['prettier']
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
    \ 'colorscheme': 'oceanicnext',
    \ 'active': {
        \ 'left': [ [ 'mode', 'paste', 'gitstatus' ],
        \           [ 'readonly', 'relativepath', 'modified' ] ],
        \ 'right': [ [ 'lineinfo' ],
        \            [ 'percent' ],
        \            [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
    \},
    \ 'inactive': {
        \ 'left': [ [ 'gitstatus' ], [ 'relativepath', 'modified' ] ],
        \ 'right': [ [ 'lineinfo' ],
        \            [ 'percent' ],
        \            [ 'fileformat', 'fileencoding', 'filetype' ] ]
    \},
    \ 'component': {
        \ 'gitstatus': ' %{FugitiveHead()}'
    \ }
\}

" commentary
nmap <Leader>c <Plug>CommentaryLine
xmap <Leader>c <Plug>Commentary

" fugitive
nnoremap <leader>gs :Git status<CR>
nnoremap <leader>gd :Git diff<CR>
nnoremap <leader>gb :Git blame<CR>

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
autocmd FileType scss setlocal iskeyword+=@-@ tabstop=2
autocmd FileType javascript,css,html setlocal tabstop=2

autocmd BufNewFile,BufRead *.rst setlocal textwidth=79 linebreak
autocmd BufNewFile,BufRead *.md setlocal textwidth=79 linebreak
autocmd BufNewFile,BufRead *.handlebars,*.hbs,*.mustache setf mustache

cnoremap help vertical help


" hot keys
" strip trailing whitespace
map <leader>ts :%s/\s\+$//e<CR>

" drop hightlight search result
noremap <leader><leader> :nohlsearch<CR>

" not jump on star, only highlight
nnoremap * *N

" F2 - save buffer
nmap <F2> :w<CR>
vmap <F2> <esc>:w<CR>i
imap <F2> <esc>:w<CR>i

" keep visual selection when indenting
vnoremap < <gv
vnoremap > >gv

" yank/delete to clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
" paste from clipboard
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" window commands
nnoremap <silent> <leader>v :wincmd v<CR>
nnoremap <silent> <leader>h :wincmd h<CR>
nnoremap <silent> <leader>j :wincmd j<CR>
nnoremap <silent> <leader>k :wincmd k<CR>
nnoremap <silent> <leader>l :wincmd l<CR>
nnoremap <silent> <leader>+ :wincmd +<CR>
nnoremap <silent> <leader>- :wincmd -<CR>
nnoremap <silent> <leader>cj :wincmd j<CR>:close<CR>
nnoremap <silent> <leader>ck :wincmd k<CR>:close<CR>
nnoremap <silent> <leader>ch :wincmd h<CR>:close<CR>
nnoremap <silent> <leader>cl :wincmd l<CR>:close<CR>
nnoremap <silent> <leader>cw :close<CR>

set secure
