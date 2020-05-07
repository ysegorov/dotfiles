" vim configuration

if !filereadable($HOME . '/.vim/autoload/plug.vim')
    silent !mkdir -p ~/.vim/autoload >/dev/null 2>&1
    silent !mkdir -p ~/.vim/plugged >/dev/null 2>&1
    silent !curl -fLo ~/.vim/autoload/plug.vim
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
                \ >/dev/null 2>&1
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set nocompatible              " be iMproved, required

call plug#begin('~/.vim/plugged')

" themes
Plug 'altercation/vim-colors-solarized'
Plug 'jnurmine/Zenburn'
Plug 'morhetz/gruvbox'
Plug 'gruvbox-material/vim', {'as': 'gruvbox-material'}
Plug 'mkarmona/colorsbox'

" syntax
Plug 'sheerun/vim-polyglot'
Plug 'vim-scripts/dbext.vim'
Plug 'aklt/plantuml-syntax'
Plug 'w0rp/ale'
Plug 'davidhalter/jedi-vim'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug '~/_dev/vim-yaggy'
" Plug 'scrooloose/syntastic'
" Plug 'nvie/vim-flake8'
" Plug 'lunaru/vim-less'
" Plug 'mustache/vim-mustache-handlebars'
" Plug 'othree/html5.vim'
" Plug 'moll/vim-node'
" Plug 'vim-scripts/JSON.vim'
" Plug 'jelera/vim-javascript-syntax'
" Plug 'raichoo/purescript-vim'
" Plug 'elixir-lang/vim-elixir'
" Plug 'python-mode/python-mode', { 'branch': 'develop' }

" utils
Plug 'tpope/vim-surround'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-projectionist'
Plug 'mileszs/ack.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'terryma/vim-expand-region'

" git
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'

call plug#end()

syntax on


runtime ftplugin/man.vim
runtime ftplugin/vim.vim
runtime ftplugin/help.vim
runtime macros/matchit.vim


set backupdir=$HOME/.cache/vim/backup//      " where to put backup file
set directory=$HOME/.cache/vim/swap//        " where to put swap files
set undodir=$HOME/.cache/vim/undo            " where to put undo files
let g:SESSION_DIR   = $HOME.'/.cache/vim/sessions'

if !isdirectory(&backupdir)
    silent call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
    silent call mkdir(&directory, "p")
endif
if !isdirectory(g:SESSION_DIR)
    silent call mkdir(g:SESSION_DIR, "p")
endif
if finddir(&undodir) == ''
    silent call mkdir(&undodir, "p")
endif

set backup                                 " make backup file and leave it around
set backupskip+=svn-commit.tmp,svn-commit.[0-9]*.tmp

if has('persistent_undo')
    set undofile            " enable persistent undo
endif


" buffer options
set hidden                  " hide buffers when they are abandoned
set autoread                " auto reload changed files
set autowrite               " automatically save before commands like :next and :make

" display options
set title                   " show file name in window title
set visualbell              " mute error bell
" set t_vb=
set linebreak               " break lines by words
set winminheight=0          " minimal window height
set winminwidth=0           " minimal window width
set scrolloff=4             " min 4 symbols bellow cursor
set sidescroll=4
set sidescrolloff=10
set showcmd                 " Show commands
set whichwrap=b,s,<,>,[,],l,h
set completeopt=menuone,longest
set infercase
set nojoinspaces
set laststatus=2            " Always show a statusline
set guicursor=
set splitbelow
set splitright
set shortmess+=I
set mousehide
set cursorline
set norelativenumber
set number

" tab options
set autoindent              " copy indent from previous line
set smartindent             " enable nice indent
set expandtab               " tab with spaces
set smarttab                " indent using shiftwidth"
set shiftwidth=4            " number of spaces to use for each step of indent
set softtabstop=4           " tab like 4 spaces
set shiftround              " drop unused spaces

" backup and swap files
set history=1000             " history length
set undolevels=1000
set viminfo+=h              " save history
set ssop-=blank             " dont save blank vindow
set ssop-=options           " dont save options

" search options
set hlsearch                " Highlight search results
set ignorecase              " Ignore case in search patterns
set smartcase               " Override the 'ignorecase' option if the search pattern contains upper case characters
set incsearch               " While typing a search command, show where the pattern

" matching characters
set showmatch               " Show matching brackets
set matchpairs+=<:>         " Make < and > match as well

" localization
set langmenu=none            " Always use english menu
set keymap=russian-jcukenwin " Alternative keymap
set iminsert=0               " English by default
set imsearch=-1              " Search keymap from insert mode
set spelllang=en,ru          " Languages
set encoding=utf-8           " Default encoding
set fileencodings=utf-8,cp1251,koi8-r,cp866
set termencoding=utf-8

" tab completion in command line mode
set wildmenu                " use wildmenu ...
set wildmode=full
set wildcharm=<TAB>
set wildignore+=.hg,.git,.svn " Version control
set wildignore+=*.DS_Store    " OSX bullshit
set wildignore+=*.o,*.obj,*.py[co],*.bak,*.exe,*.swp,*~
set wildignore+=*.jpg,*.png,*.gif,*.pdf,*.jpeg,*.tiff
set wildignore+=*.odt,*.ods,*.zip,*.bz2,*.gz,*.tgz,*.tbz2,*.7z,*.z
set wildignore+=*.doc,*.xls,*.xlsx,*.docx
set wildignore+=eggs
set wildignore+=*.egg-info
set wildignore+=node_modules
set wildignore+=env
set wildignore+=bower_components

" edit
set backspace=indent,eol,start  " Allow backspace to remove indents, newlines and old tex"
set virtualedit=block             " on virtualedit for all mode
set nrformats=                  " dont use octal and hex in number operations

" treat words with dash as a word
" search-tag as a single word for movement ops
set iskeyword+=-

set ttimeoutlen=50

set confirm
set numberwidth=1              " Keep line numbers small if it's shown

set langmap=ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>

let g:changelog_username = $USER
let mapleader = ","
let maplocalleader = " "


" color theme
set term=xterm-256color
set termguicolors
" set t_Co=256
set bg=dark
" let g:gruvbox_bold=0
" let g:gruvbox_italic=0
" let g:gruvbox_underline=0
" let g:gruvbox_undercurl=0
" let g:gruvbox_contrast_dark="hard"
" let g:gruvbox_improved_strings=0
" color gruvbox

let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_enable_italic = 0
let g:gruvbox_material_disable_italic_comment = 1
colorscheme gruvbox-material
" color xoria256
" color zenburn
" let g:solarized_italic=0
" let g:solarized_bold=0
" color solarized


" console cursor
if &term =~ "xterm\\|rxvt"
    " use an orange cursor in insert mode
    let &t_SI = "\<Esc>]12;darkred\x7"
    let &t_SR = "\<Esc>]12;darkblue\x7"
    " use a red cursor otherwise
    let &t_EI = "\<Esc>]12;red\x7"
    silent !echo -ne "\033]12;red\007"
    " reset cursor when vim exits
    autocmd VimLeave * silent !echo -ne "\033]112\007"
    " use \003]12;gray\007 for gnome-terminal
endif
if &term =~ '^xterm'
    " solid underscore
    " let &t_SI .= "\<Esc>[6 q"
    " solid block
    let &t_EI .= "\<Esc>[2 q"
    " 1 or 0 -> blinking block
    " 3 -> blinking underscore
    " Recent versions of xterm (282 or above) also support
    " 5 -> blinking vertical bar
    " 6 -> solid vertical bar
endif


" gui cursor
set gcr=a:block

" mode aware cursors
set gcr+=o:hor50-Cursor
set gcr+=n:Cursor
set gcr+=i-ci-sm:InsertCursor
set gcr+=r-cr:ReplaceCursor-hor20
set gcr+=c:CommandCursor
set gcr+=v-ve:VisualCursor

set gcr+=a:blinkon0

hi InsertCursor  ctermfg=15 guifg=#fdf6e3 ctermbg=37  guibg=#2aa198
hi VisualCursor  ctermfg=15 guifg=#fdf6e3 ctermbg=125 guibg=#d33682
hi ReplaceCursor ctermfg=15 guifg=#fdf6e3 ctermbg=65  guibg=#dc322f
" hi CommandCursor ctermfg=15 guifg=#fdf6e3 ctermbg=166 guibg=#cb4b16


" status line
" set statusline=
" set statusline+=%7*\[%n]                                  "buffernr
" set statusline+=%1*\ %<%F\                                "File+path
" set statusline+=%2*\ %y\                                  "FileType
" set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
" set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
" set statusline+=%4*\ %{&ff}\                              "FileFormat (dos/unix..)
" set statusline+=%5*\ %{&spelllang}\                       "Spellanguage?
" set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
" set statusline+=%9*\ col:%03c\                            "Colnr
" set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly? Top/bot.

"
" https://github.com/blaenk/dots/blob/master/vim/.vimrc
"
" status line function
function! Status(winnr)
    let head = ''
    let stat = ''
    let active = winnr() == a:winnr
    let buffer = winbufnr(a:winnr)

    let modified = getbufvar(buffer, '&modified')
    let readonly = getbufvar(buffer, '&ro')
    let fname = bufname(buffer)

    function! Color(active, num, content)
        if a:active
            return '%' . a:num . '*' . a:content . '%*'
        else
            return a:content
        endif
    endfunction

    " column
    let stat .= '%1*' . (col(".") / 100 >= 1 ? '%v ' : ' %2v ') . '%*'

    " file
    let stat .= Color(active, 4, active ? ' »' : ' «')
    let stat .= ' %<'

    if fname == '__Gundo__'
        let stat .= 'Gundo'
    elseif fname == '__Gundo_Preview__'
        let stat .= 'Gundo Preview'
    else
        let stat .= '%f'
    endif

    let stat .= ' ' . Color(active, 4, active ? '«' : '»')

    " file modified
    let stat .= Color(active, 2, modified ? ' +' : '')

    " read only
    let stat .= Color(active, 2, readonly ? ' ‼' : '')

    " paste
    if active && &paste
        let stat .= ' %2*' . 'P' . '%*'
    endif

    " right side
    let stat .= '%='

    " git branch
    if exists('*fugitive#head')
        let head = fugitive#head()

        if empty(head) && exists('*fugitive#detect') && !exists('b:git_dir')
        call fugitive#detect(getcwd())
        let head = fugitive#head()
        endif
    endif

    if !empty(head)
        let stat .= Color(active, 3, ' ← ') . head . ' '
    endif

    return stat
endfunction

" status line autocmd
function! SetStatus()
    for nr in range(1, winnr('$'))
        call setwinvar(nr, '&statusline', '%!Status('.nr.')')
    endfor
endfunction

augroup status
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter,BufUnload * call SetStatus()
augroup END

" status line colors
hi User1 ctermfg=33  guifg=#268bd2  ctermbg=15 guibg=#fdf6e3 gui=bold
hi User2 ctermfg=125 guifg=#d33682  ctermbg=7  guibg=#eee8d5 gui=bold
hi User3 ctermfg=64  guifg=#719e07  ctermbg=7  guibg=#eee8d5 gui=bold
hi User4 ctermfg=37  guifg=#2aa198  ctermbg=7  guibg=#eee8d5 gui=bold


" folding
if has('folding')
    set foldcolumn=0
    set foldmethod=indent   " Fold on indent
    " set foldnestmax=10
    set foldenable
    set foldlevel=999       " High default so folds are shown to start
    " set foldlevelstart=999
endif

" x-clipboard support
if has('unnamedplus')
    set clipboard+=unnamed     " enable x-clipboard
endif


" open help in a vsplit rather than a split
command! -nargs=? -complete=help Help :vertical help <args>
cabbrev h h<C-\>esubstitute(getcmdline(), '^h\>', 'Help', '')<CR>

" some gui settings
if has("gui_running")
    set guioptions=agiP
    set guioptions-=m
    set guioptions-=T
    set guioptions-=rL
    set guifont=Ubuntu\ Mono\ 8
endif

set list
set listchars=tab:⇥\ ,trail:·,extends:⋯,precedes:⋯,nbsp:~
" tab and eol symbols
if has('multi_byte')
    if version >= 700
        set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:×
    else
        set listchars=tab:»\ ,trail:·,extends:>,precedes:<,nbsp:_
    endif
endif

set nowrap


" -----------
"  functions
" -----------

" recursive vimgrep
fun! rcng#RGrep()
    let pattern = input("Search for pattern: ", expand("<cword>"))
    if pattern == ""
        return
    endif

    let cwd = getcwd()
    let startdir = input("Start searching from directory: ", cwd, "dir")
    if startdir == ""
        return
    endif

    let filepattern = input("Search in files matching pattern: ", "*.*")
    if filepattern == ""
        return
    endif

    try
        execute 'noautocmd vimgrep /'.pattern.'/gj '.startdir.'/**/'.filepattern
        botright copen
    catch /.*/
        echohl WarningMsg | echo "Not found: ".pattern | echohl None
    endtry
endfun

" restore cursor position
fun! rcng#restore_cursor()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction


" use the below highlight group when displaying bad whitespace is desired
highlight BadWhitespace ctermbg=2 guibg=#800000
highlight CursorLine cterm=None ctermbg=235 ctermfg=None guibg=#444444
highlight ColorColumn cterm=None ctermbg=235 ctermfg=None guibg=#444444

" display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.js,*.css,*.sass,*.scss match BadWhitespace /\s\+$/

augroup vimrc
au!
    " auto reload vim settins
    au! BufWritePost *.vim source ~/.vimrc

    " highlight insert mode
    " au InsertEnter * set cursorline
    " au InsertLeave * set nocursorline

    " restore cursor position
    au BufWinEnter * call rcng#restore_cursor()

    " autosave last session
    if has('mksession')
        au VimLeavePre * exe "mks! " g:SESSION_DIR.'/last.vim'
    endif

    " save current open file when window focus is lost
    au FocusLost * if &modifiable && &modified | write | endif

    au BufNewFile,BufRead *.json setf javascript
    au BufNewFile,BufRead *.handlebars,*.mustache setf mustache
    au BufNewFile,BufRead *.less setf less
    au BufNewFile,BufRead *.rs setlocal ft=rust
    au BufNewFile,BufRead *.rst setlocal textwidth=79
    au BufNewFile,BufRead *.md setlocal textwidth=79
    au BufNewFile,BufRead *.css setlocal filetype=css
    au BufNewFile,BufRead *.py,*.js,*.css,*.less,*.sass,*.scss,*.html,*.handlebars,*.rst,*.txt,*.md,*.rs,*.ex,*.exs setl colorcolumn=80
    autocmd FileType python,javascript,css,rust,elixir autocmd BufWritePre <buffer> :%s/\s\+$//e
    au FileType qf setlocal nonumber colorcolumn=
    " autocmd BufWritePost *.py call Flake8()
    au BufNewFile,BufRead *.js setlocal softtabstop=2 shiftwidth=2

    " auto close preview window
    autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
    autocmd InsertLeave * if pumvisible() == 0|pclose|endif

augroup END


" ------------
"   hot keys
" ------------

" strip trailing whitespace
map <leader>ts :%s/\s\+$//e<CR>

" F2 - save buffer
nmap <F2> :w<CR>
vmap <F2> <esc>:w<CR>i
imap <F2> <esc>:w<CR>i

" F10 - close buffer
" nmap <F10> :bd<CR>
" vmap <F10> <esc>:bd<CR>
" imap <F10> <esc>:bd<CR>

" list buffers
" nnoremap <F5> :buffers<CR>:buffer<Space>

vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
" nmap <Leader><Leader> V
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" nice scrolling if line wrap
noremap j gj
noremap k gk

nnoremap Y y$

" switch folding in current line
noremap \ za

" toggle paste mode
" noremap <silent> <Leader>p :set invpaste<CR>:set paste?<CR>

" not jump on star, only highlight
nnoremap * *N

" drop hightlight search result
noremap <leader><leader> :nohlsearch<CR>

" fast scrool
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" select all
map vA ggVG

" quickfix
nnoremap <silent> <leader>ln :cwindow<CR>:cn<CR>
nnoremap <silent> <leader>lp :cwindow<CR>:cp<CR>

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

" buffer commands
noremap <silent> <leader>bp :bp<CR>
noremap <silent> <leader>bn :bn<CR>
noremap <silent> <leader>ww :w<CR>
noremap <silent> <leader>bd :bd<CR>

" delete all buffers
nnoremap <silent> <leader>da :exec "1," . bufnr('$') . "bd"<cr>

" search the current file for the word under the cursor and display matches
nnoremap <silent> <leader>gw :call rcng#RGrep()<CR>

" open new tab
nnoremap <silent> <C-W>t :tabnew<CR>

" < >
vnoremap < <gv
vnoremap > >gv

" git blame
" vmap <Leader>gg :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" http://tammersaleh.com/posts/quick-vim-svn-blame-snippet
vmap <Leader>gs :<C-U>!svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" http://vimbits.com/bits/155
vmap <Leader>gh :<C-U>!hg annotate -udqc % \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>


" ---------
"  plugins
" ---------


" ale
let g:ale_completion_enabled = 1
nmap ]a :ALENextWrap<CR>
nmap [a :ALEPreviousWrap<CR>
nmap ]A :ALELast
nmap [A :ALEFirst


" jedi
let g:jedi#auto_vim_configuration = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#use_splits_not_buffers = "right"
let g:jedi#popup_on_dot = 1
let g:jedi#popup_select_first = 0
let g:jedi#show_call_signatures = "0"
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"


" expand region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)


" fugitive
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>ga :Gwrite<CR>
nnoremap <leader>gc :Gcommit %<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gr :Gremove<CR>
nnoremap <leader>go :Gread<CR>
nnoremap <leader>gpl :Git pull origin master<CR>
nnoremap <leader>gpp :Git push<CR>
nnoremap <leader>gpm :Git push origin master<CR>
nnoremap <leader>gl :Gitv! --all<CR>
nnoremap <leader>gL :Gitv --all<CR>

let g:Gitv_WipeAllOnClose = 1
let g:Gitv_DoNotMapCtrlKey = 1


" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_max_height = 20
" if executable('ag')
"     set grepprg=ag\ -nogroup\ --nocolor
"     let g:ctrlp_user_command = 'ag %s -l --hidden --nocolor --ignore-dir .git --ignore-dir .hg -g ""'
"     let g:ctrlp_use_caching = 0
" endif
let g:ctrlp_user_command = {
    \ 'types': {
        \ 1: ['.git', 'git --git-dir=%s/.git ls-files -oc --exclude-standard'],
        \ 2: ['.hg', 'hg --cwd %s status -numac -I . $(hg root)'],
    \ },
    \ 'fallback': 'find %s -type f'
\ }


" polyglot
" let g:polyglot_disabled = ['python', 'python-compiler']

augroup polyglot_rust
    au!
    au FileType rust inoremap <F9> <esc>:make<cr>
    au FileType rust nnoremap <F9> <esc>:make<cr>
    au FileType rust vnoremap <F9> <esc>:make<cr>
augroup END


" flake8
" let g:flake8_show_in_gutter = 1
" let g:flake8_show_quickfix = 1
" let g:flake8_show_in_file = 0


" python-mode
" let g:pymode_lint = 0
" let g:pymode_lint_on_write = 1
" let g:pymode_lint_mccabe_complexity = 10
" let g:pymode_lint_checker = "pylint,pep8,pyflakes,mccabe,pep257"
" let g:pymode_lint_hold = 0
" let g:pymode_lint_signs = 1
" let g:pymode_syntax_builtin_objs = 0
" let g:pymode_syntax_builtin_funcs = 0
" let g:pymode_rope_goto_def_newwin = "new"
" let g:pymode_syntax_builtin_funcs = 1
" let g:pymode_syntax_print_as_function = 1
" let g:pymode_virtualenv = 1
" let g:pymode_rope = 0
" let g:pymode_lint_cwindow = 0

" let g:pymode_lint_todo_symbol = 'WW'
" let g:pymode_lint_comment_symbol = 'CC'
" let g:pymode_lint_visual_symbol = 'RR'
" let g:pymode_lint_error_symbol = 'EE'
" let g:pymode_lint_info_symbol = 'II'
" let g:pymode_lint_pyflakes_symbol = 'FF'
" " au BufWritePost *.py PymodeLint


" toggle comments
nmap <Leader>c <Plug>CommentaryLine
xmap <Leader>c <Plug>Commentary

augroup plugin_commentary
    au!
    au FileType python setlocal commentstring=#%s
    au FileType mustache setlocal commentstring=<!--\ %s\ -->
    au FileType htmldjango setlocal commentstring={#\ %s\ #}
    au FileType puppet setlocal commentstring=#\ %s
augroup END


" syntastic
" let g:syntastic_error_symbol = 'EE'
" let g:syntastic_style_error_symbol = "E>"
" let g:syntastic_warning_symbol = 'WW'
" let g:syntastic_style_warning_symbol = "W>"
" let g:syntastic_auto_loc_list = 2
" let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'
" " let g:syntastic_ignore_files = ['\.py$']


" dbext
" let g:dbext_default_profile_'profilename' = 'var=value:var=value:...'
let g:dbext_default_type = 'PGSQL'
let g:dbext_default_profile_psql = 'type=PGSQL:host=localhost:port=5432:dbname=egorov:user=egorov'
let g:dbext_default_profile = 'psql'
let g:dbext_default_window_use_horiz = 0
let g:dbext_default_window_use_right = 1
let g:dbext_default_window_width = 100

augroup plugin_dbext
    au!
    au FileType sql inoremap <F9> <esc>:DBExecSQLUnderCursor<cr>
    au FileType sql nnoremap <F9> <esc>:DBExecSQLUnderCursor<cr>
    au FileType sql vnoremap <leader>. <esc>:DBExecVisualSQL<cr>
    " au FileType sql inoremap <C-M> <esc>:DBExecSQLUnderCursor<cr>
    " au FileType sql nnoremap <C-M> <esc>:DBExecSQLUnderCursor<cr>
augroup END


" local settings
if filereadable($HOME . "/.vim_local")
    source $HOME/.vim_local
endif


" project settings
set exrc     " enables the reading of .vimrc, .exrc and .gvimrc in the current directory.
set secure   " must be written at the last.  see :help 'secure'.
