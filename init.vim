" General Settings
" ================

" Leader shall be comma
" ---------------------
let mapleader = ','

" Edit settings
" -------------
set relativenumber
set number
set nowrap
" Tabs shall be 4 spaces
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
" Easier moving in tabs and windows
nnoremap <a-j> <C-w>j
nnoremap <a-k> <C-w>k
nnoremap <a-h> <C-w>h
nnoremap <a-l> <C-w>l
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
set foldmethod=syntax
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

" Plugins
" =======
call plug#begin()

" tpope default vim settings
Plug 'tpope/vim-sensible'

" NERDTree
Plug 'scrooloose/nerdtree'
map <C-e> :NERDTreeToggle<CR>
map <leader>e :NERDTreeFind<CR>
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0

" CtrlP
Plug 'ctrlpvim/ctrlp.vim'
" Search in directory, buffer, and most recently used
let g:ctrlp_cmd = 'CtrlPMixed'
" Search only in buffers
nnoremap <C-b> :CtrlPBuffer<CR>

" vim-airline
Plug 'vim-airline/vim-airline'
let g:airline_powerline_fonts = 1

" Undotree
Plug 'mbbill/undotree'
nnoremap <leader>u :UndotreeToggle<cr>
let g:undotree_SetFocusWhenToggle=1

" Surround
Plug 'tpope/vim-surround'

" NERDCommenter
Plug 'scrooloose/nerdcommenter'

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

" Deoplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
" Let <Tab> also do completion
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ deoplete#mappings#manual_complete()
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
" Close the documentation window when completion is done
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Deoplete for C++
Plug 'zchee/deoplete-clang'
" Deoplete-clang supports compiler-flags local to individual projects. It will
" search the current working directory for a .clang file; if no such file is
" found it will try searching the parent directory. The format of the .clang
" file is either
"     flags = <flags>
" or
"     compilation_database = <path to compilation_database>
let g:deoplete#sources#clang#flags = [
            \ "-std=c++14"
            \ ]
let g:deoplete#sources#clang#libclang_path = $LIBCLANG_PATH
let g:deoplete#sources#clang#clang_header = $CLANG_INCLUDE_PATH

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
au BufWrite *.py,*.cpp,*.h,*.c,*.inl :Neoformat
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

" Syntax highlighting
Plug 'neomake/neomake'
" let g:neomake_cpp_enable_markers=['clang']
let g:neomake_cpp_enable_makers = ['clang']
let g:neomake_cpp_clang_args = ["-std=c++14", "-Wextra", "-Wall", "-fsanitize=undefined","-g"]
" run Neomake on the current file on every write:
autocmd! BufWritePost * Neomake
nnoremap <leader>m :Neomake!<CR>

" Automatic tag creation
Plug 'c0r73x/neotags.nvim'
let g:neotags_enabled = 1

"" Tagbar
"Plug 'majutsushi/tagbar'
"nnoremap <silent> <leader>t :TagbarOpenAutoClose<CR>

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

" Open neovim terminal with :Term (horizontal split) or :VTerm
" <Esc> - Switch to normal mode (instead of <C-\><C-n>)
" Alt+hjkl, Ctrl+arrows to navigate through windows
Plug 'vimlab/split-term.vim'

" Markdown
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    !cargo build --release
  endif
endfunction
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

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

" True color
set termguicolors
set background=dark
map <Leader>bg :let &background = (&background == "dark"? "light" : "dark")<CR>
let g:gruvbox_italic=1
colorscheme gruvbox
