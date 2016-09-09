" General Settings
" ================

" Leader shall be comma
" ---------------------
let mapleader = ','

" Edit settings
" -------------
set relativenumber
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

" Create closing bracket
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

" YCM Generator
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}

" Snippet engine
Plug 'SirVer/ultisnips'
" Snippets
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsEditSplit="vertical"

" ClangFormat
Plug 'rhysd/vim-clang-format'
" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
autocmd FileType c,cpp,objc ClangFormatAutoEnable

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

" Python
" PEP 8 indentation
Plug 'vim-scripts/indentpython.vim'
" PEP 8 checking
Plug 'nvie/vim-flake8'
" Pretty python
let python_highlight_all=1

" Syntax highlighting
"Plug 'scrooloose/syntastic'
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

" Color scheme
Plug 'fatih/molokai'

" Improved folding
Plug 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview=1

call plug#end()

set background=dark
colorscheme molokai

