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
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_
map <Tab><Tab> <C-W>w
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
set splitright " open new vsplit right
" Terminal emulation mappings
tnoremap <Esc> <C-\><C-n>
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
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
set foldlevel=99
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

" YouCompleteMe
Plug 'Valloric/YouCompleteMe'
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:acp_enableAtStartup = 1
" enable completion from tags
let g:ycm_collect_identifiers_from_tags_files = 1
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
au FileType c,cpp,objc,python nmap gd :YcmCompleter GoTo<CR>

" YCM Generator
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
let g:ycm_python_binary_path = 'python3'

" Snippet engine
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsEditSplit="vertical"
" Snippets
Plug 'honza/vim-snippets'

" vim-autoformat
Plug 'sbdchd/neoformat'
noremap <c-i> :Neoformat<CR>
au BufWrite *.py,*.cpp,*.h,*.c,*.inl :Neoformat
" Enable trimmming of trailing whitespace when a filetype is not found
let g:neoformat_basic_format_trim = 1

" Tagbar
Plug 'majutsushi/tagbar'
nnoremap <silent> <leader>tt :TagbarToggle<CR>

" Exchange with cx
Plug 'tommcdo/vim-exchange'

" Handy Pairs
Plug 'tpope/vim-unimpaired'
nmap < [
nmap > ]
omap < [
omap > ]
xmap < [
xmap > ]

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
set hidden
let g:rustfmt_autosave = 1

" Markdown
Plug 'euclio/vim-markdown-composer'

" XML
Plug 'alvan/vim-closetag'
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.xml"

" Syntax highlighting
Plug 'neomake/neomake'
" run Neomake on the current file on every write:
autocmd! BufWritePost * Neomake

" Color scheme
Plug 'cryptomilk/gruvbox'

" Improved folding
Plug 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview=1

call plug#end()

" True color
set termguicolors
set background=dark
map <Leader>bg :let &background = (&background == "dark"? "light" : "dark")<CR>
let g:gruvbox_italic=1
colorscheme gruvbox
