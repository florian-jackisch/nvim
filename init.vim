" General Settings
" ================

" Leader shall be comma
" ---------------------
let mapleader = ','
let maplocalleader = '_'

" Edit settings
" -------------
set relativenumber
set number
set nowrap
" Tabs shall be 4 spaces
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
" Easier moving in tabs and windows
if has("macunix")
    nnoremap º <C-w>j
    nnoremap ∆ <C-w>k
    nnoremap ª <C-w>h
    nnoremap @ <C-w>l
else
    nnoremap <a-j> <C-w>j
    nnoremap <a-k> <C-w>k
    nnoremap <a-h> <C-w>h
    nnoremap <a-l> <C-w>l
endif
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
set splitright " open new vsplit right
" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk
" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv
" Allow using the repeat operator with a visual selection (!)
" " http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>
" Ctrl+C/V/X
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+
" Quickly open/reload vim
nnoremap <leader>ve :edit $MYVIMRC<CR>
nnoremap <leader>vs :source $MYVIMRC<CR>
" Enable folding with space
set foldmethod=indent
set foldlevelstart=99
nnoremap <space> za
" Mark unnecessary whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
" 80 columns is the target width
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif
" Disable search highlight after search with <CR>
nnoremap <CR> :noh<CR><CR>
" Incremental search and replace
set inccommand=nosplit
set cursorline
" Terminal window ESC and navigation
tnoremap <Esc> <C-\><C-n>
if has("macunix")
    nnoremap º <C-w>j
    nnoremap ∆ <C-w>k
    nnoremap ª <C-w>h
    nnoremap @ <C-w>l
else
    nnoremap <a-j> <C-w>j
    nnoremap <a-k> <C-w>k
    nnoremap <a-h> <C-w>h
    nnoremap <a-l> <C-w>l
    tnoremap <a-j> <C-\><C-n><C-w>j
    tnoremap <a-k> <C-\><C-n><C-w>k
    tnoremap <a-h> <C-\><C-n><C-w>h
    tnoremap <a-l> <C-\><C-n><C-w>l
endif


" Plugins
" =======
call plug#begin()

" tpope default vim settings
Plug 'tpope/vim-sensible'

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

" CtrlP
Plug 'ctrlpvim/ctrlp.vim'
" Search in directory, buffer, and most recently used
let g:ctrlp_cmd = 'CtrlPMixed'
" Search only in buffers
nnoremap <C-b> :CtrlPBuffer<CR>
nnoremap <C-g> :CtrlPTag<CR>

" vim-airline
Plug 'vim-airline/vim-airline'
"let g:airline_powerline_fonts = 1

" Undotree
Plug 'mbbill/undotree'
nnoremap <leader>u :UndotreeToggle<cr>
let g:undotree_SetFocusWhenToggle=1

" Surround
Plug 'tpope/vim-surround'

" NERDCommenter
Plug 'tpope/vim-commentary'

" Create closing braces
Plug 'spf13/vim-autoclose'
let g:autoclose_vim_commentmode = 1

" Git plugin
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

" Ack
Plug 'mileszs/ack.vim'
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" YCM
Plug 'Valloric/YouCompleteMe'
Plug 'rdnetto/YCM-Generator'

" Snippet engine
Plug 'SirVer/ultisnips'
" Snippets
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsEditSplit="vertical"

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

" Exchange with cx
Plug 'tommcdo/vim-exchange'

" Repeat for plugins
Plug 'tpope/vim-repeat'

" For doxygen support
Plug 'vim-scripts/DoxygenToolkit.vim'

" QML syntax hightlighting
Plug 'calincru/qml.vim'

" Go
Plug 'fatih/vim-go'
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
" Treat geany files like go files
au BufNewFile,BufRead *.geany set filetype=go

" Rust
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
au FileType rust nmap <leader>r :RustRun<CR>
set hidden
let g:rustfmt_autosave = 1

" Python
" PEP 8 indentation
Plug 'vim-scripts/indentpython.vim'
" PEP 8 checking
Plug 'nvie/vim-flake8'
" Pretty python
let python_highlight_all=1
au FileType python setlocal formatprg=autopep8\ -

" XML
Plug 'alvan/vim-closetag'
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.xml"

" Linting
Plug 'w0rp/ale'
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Automatic tag creation (disabled because it causes freezes)
Plug 'ludovicchabant/vim-gutentags'

"" Tagbar
Plug 'majutsushi/tagbar'
nnoremap <silent> <leader>r :TagbarToggle<CR>

" Stop complaining that swap files can be deleted
Plug 'gioele/vim-autoswap'

" Rainbow paranthesis
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1

" Color scheme
Plug 'cryptomilk/gruvbox'

" Improved folding
Plug 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview=1

" Open neovim terminal with :T <command>
" Map to ,tt with :Tmap <command>
" Send to REPL with TREPLSendFile, TREPLSend
Plug 'kassio/neoterm'
let g:neoterm_automap_keys = ',b'
nnoremap <silent> <f10> :TREPLSendFile<cr>
nnoremap <silent> <f9> :TREPLSendLine<cr>
vnoremap <silent> <f9> :TREPLSendSelection<cr>
nnoremap <silent> <leader>t :call neoterm#toggle()<cr>

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

" Tabular
" Call `Tabularize /<search expression>` to align at the search expression
Plug 'godlygeek/tabular'

" Handy combinations with `[` and `]`
" b - buffer
" q - quickfix
" f - file in directory
" y - en/decode C strings
" ob - background
" oi - ignorecase
" os - spell
" ow - wrap
Plug 'tpope/vim-unimpaired'

call plug#end()

" Color scheme
"set termguicolors " true color
set background=dark
let g:gruvbox_italic=1
colorscheme gruvbox
