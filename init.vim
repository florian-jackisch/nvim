" General Settings
" ================

" Leaders
" -------
let mapleader = '-'
let maplocalleader = '_'

" Editor settings
" ---------------
set relativenumber
set number
set nowrap
set ignorecase
set smartcase
" Tabs shall be 4 spaces
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
" Open new vsplit right
set splitright
" Enable folding with space
set foldmethod=indent
set foldlevelstart=99
" 80 columns is the target width
set colorcolumn=80
" Incremental search and replace
if has("nvim")
    set inccommand=nosplit
endif
" Highlight the current line
set cursorline

" Keyboard maps
" -------------
" Terminal window ESC
if has("nvim")
    tnoremap <Esc> <C-\><C-n>
endif
" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk
" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv
" Allow using the repeat operator with a visual selection (!)
" " http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>
" Quickly open/reload vim
nnoremap <leader>ve :edit $MYVIMRC<CR>
nnoremap <leader>vs :source $MYVIMRC<CR>
" Disable search highlight after search with <CR>
nnoremap <CR> :noh<CR><CR>

" Plugins
" =======
call plug#begin()

" Tim Pope plugins
" ----------------
" Default vim settings
Plug 'tpope/vim-sensible'
" Surround
Plug 'tpope/vim-surround'
" Comments with gc
Plug 'tpope/vim-commentary'
" Git
Plug 'tpope/vim-fugitive'
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gr :Gread<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>ge :Gedit<CR>
Plug 'airblade/vim-gitgutter'
" Repeat for plugins
Plug 'tpope/vim-repeat'
" Handy combinations with `[` and `]`
" b - buffer
" q - quickfix
" f - file in directory
" ob - background
" oi - ignorecase
" os - spell
" ow - wrap
Plug 'tpope/vim-unimpaired'
" :Make and :Dispatch
Plug 'tpope/vim-dispatch'
nmap <leader>b :Make<cr>

" UI plugins
" ----------
" NERDTree
Plug 'scrooloose/nerdtree'
map <leader>e : NERDTreeToggle<CR>
map <C-e>     : NERDTreeFind<CR>
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0
Plug 'ivalkeen/nerdtree-execute'
" Undotree
Plug 'mbbill/undotree'
nnoremap <leader>u :UndotreeToggle<cr>
let g:undotree_SetFocusWhenToggle=1
" Tagbar
Plug 'majutsushi/tagbar'
nnoremap <silent> <leader>r :TagbarToggle<CR>
" vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Open neovim terminal with :T <command>
if has("nvim")
    " Send to REPL with TREPLSendFile, TREPLSend
    Plug 'kassio/neoterm'
    " Open terminal and execute the command stored with Tmap
    nnoremap <silent> <leader>x :Topen <bar> normal ,tt<cr>
    nnoremap <silent> <f10> :TREPLSendFile<cr>
    nnoremap <silent> <f9> :TREPLSendLine<cr>
    vnoremap <silent> <f9> :TREPLSendSelection<cr>
    nnoremap <silent> <leader>t :call neoterm#toggle()<cr>
endif

" Search plugins
" --------------
" Fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
nnoremap <C-p> :Files<CR>
nnoremap <C-b> :History<CR>
nnoremap <C-t> :Tags<CR>
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Editor plugins
" --------------
" Exchange with cx
Plug 'tommcdo/vim-exchange'
" Create closing braces
Plug 'spf13/vim-autoclose'
let g:autoclose_vim_commentmode = 1
" vim-autoformat
Plug 'sbdchd/neoformat'
nnoremap <silent> <leader>f :Neoformat<CR>
" Set clang-format to search for a file
let g:neoformat_enabled_c = ['clang-format']
let g:neoformat_c_clangformat = {
            \ 'exe': 'clang-format',
            \ 'args': ['-style=file'],
            \ }
" Enable trimmming of trailing whitespace when a filetype is not found
let g:neoformat_basic_format_trim = 1
" Stop complaining that swap files can be deleted
Plug 'gioele/vim-autoswap'
" Improved folding
Plug 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview=1
" Rainbow paranthesis
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1
" Tabular - call `Tabularize /<search expression>` to align at the search expression
Plug 'godlygeek/tabular'
" Change working directory to the project root
Plug 'airblade/vim-rooter'

" Completion plugins
" ------------------
" YCM
Plug 'Valloric/YouCompleteMe'
let g:ycm_error_symbol = '⨉'
let g:ycm_warning_symbol = '⚠'
let g:ycm_complete_in_comments = 1
let g:ycm_server_python_interpreter = 'python3'
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_global_ycm_extra_conf = '~/.config/nvim/.ycm_extra_conf.py'

" Snippet engine
Plug 'SirVer/ultisnips'
" Snippets
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsEditSplit="vertical"
" Linting
if has("nvim") || version >= 800
    Plug 'w0rp/ale'
    nmap <silent> <C-k> <Plug>(ale_previous_wrap)
    nmap <silent> <C-j> <Plug>(ale_next_wrap)
endif
" Automatic tag creation
Plug 'ludovicchabant/vim-gutentags'

" Language plugins
" ----------------
" Doxygen
Plug 'vim-scripts/DoxygenToolkit.vim'
" QML
Plug 'calincru/qml.vim'
" Go
Plug 'fatih/vim-go'
" Treat geany files like go files
au BufNewFile,BufRead *.geany set filetype=go
" Rust
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
au FileType rust nmap <leader>r :RustRun<CR>
set hidden
let g:rustfmt_autosave = 1
" Python
Plug 'vim-scripts/indentpython.vim'
" XML
Plug 'alvan/vim-closetag'
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.xml"
" Markdown
Plug 'shime/vim-livedown'
" LaTeX
Plug 'lervag/vimtex'
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = [
      \ 're!\\[A-Za-z]*cite[A-Za-z]*(\[[^]]*\]){0,2}{[^}]*',
      \ 're!\\[A-Za-z]*ref({[^}]*|range{([^,{}]*(}{)?))',
      \ 're!\\hyperref\[[^]]*',
      \ 're!\\includegraphics\*?(\[[^]]*\]){0,2}{[^}]*',
      \ 're!\\(include(only)?|input){[^}]*',
      \ 're!\\\a*(gls|Gls|GLS)(pl)?\a*(\s*\[[^]]*\]){0,2}\s*\{[^}]*',
      \ 're!\\includepdf(\s*\[[^]]*\])?\s*\{[^}]*',
      \ 're!\\includestandalone(\s*\[[^]]*\])?\s*\{[^}]*',
      \ 're!\\usepackage(\s*\[[^]]*\])?\s*\{[^}]*',
      \ 're!\\documentclass(\s*\[[^]]*\])?\s*\{[^}]*',
      \ 're!\\[A-Za-z]*',
      \ ]

" Color schemes
" -------------
Plug 'chriskempson/base16-vim'

call plug#end()

" Set color scheme
" ----------------
if has("termguicolors")
    set termguicolors " true color
endif
set background=dark
colorscheme base16-tomorrow-night

