" General Settings
" ================

" Leaders
" -------
let mapleader = ' '

" Editor settings
" ---------------
" Relative line numbers
set relativenumber number
" Search
set ignorecase smartcase
" Line wrapping is not the default
set nowrap
" Tabs shall be 4 spaces
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
" Open new vsplit right
set splitright
" Enable folding by syntax
set foldmethod=syntax foldlevelstart=99
" 80 columns is the target width
set colorcolumn=80
" Highlight the current line
set cursorline
" Disable swap files
set noswapfile

" Keyboard maps
" -------------
" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk
" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv
" Allow using the repeat operator with a visual selection (!)
vnoremap . :normal .<CR>
" Quickly open/reload vim
nnoremap <leader>ve :edit $MYVIMRC<CR>
nnoremap <leader>vs :source $MYVIMRC<CR>
" Disable search highlight after search with <CR>
nnoremap <CR> :noh<CR><CR>
nnoremap <silent> <up> :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <down> :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <left> :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <right> :exe "vertical resize " . (winwidth(0) * 2/3)<CR>

" Neovim settings
" ---------------
if has("nvim")
  " Incremental search and replace
  set inccommand=nosplit
  " terminal escape
  tnoremap <Esc> <c-\><C-n>
  tnoremap <c-v> <Esc><Esc>
  " Disable line numbers in the terminal
  au TermOpen * setlocal nonumber norelativenumber
  " Open terminal in new tab
  nnoremap <leader>t :tabe <bar> :term<CR>
endif

" Plugins
call plug#begin('~/.config/nvim/plugged')

" Plugins without settings
Plug 'airblade/vim-rooter'   " `cwd` to project dir
Plug 'tpope/vim-eunuch'      " :Delete etc.
Plug 'tpope/vim-repeat'      " Repeat surround etc.
Plug 'tpope/vim-sleuth'      " Detect indentation
Plug 'tpope/vim-surround'    " Surround words
Plug 'jiangmiao/auto-pairs'  " Insert brackets etc.

" Comments
Plug 'tpope/vim-commentary'
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s
autocmd FileType cmake set commentstring=#\ %s

" Git
Plug 'tpope/vim-fugitive' | Plug 'airblade/vim-gitgutter'
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gr :Gread<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>

" Unimpaired settings
Plug 'tpope/vim-unimpaired'
nmap ö [
nmap ä ]
omap ö [
omap ä ]
xmap ö [
xmap ä ]noremap <silent> <leader>ge :Gedit<CR>

" Align with ga, e.g.
Plug 'junegunn/vim-easy-align'
xmap ga <Plug>(EasyAlign)  " e.g. vipga
nmap ga <Plug>(EasyAlign)  " e.g. gaip

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } | Plug 'junegunn/fzf.vim'
nnoremap <C-p> :GFiles<CR>
nnoremap <C-s-p> :Files<CR>
nnoremap <C-h> :History<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <C-g> :Tags<CR>
let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-s': 'vsplit' } " default ctrl-v conflicts with visual block mode

" Format
Plug 'sbdchd/neoformat'
nnoremap <silent> <leader>f :Neoformat<CR>
let g:neoformat_enabled_c = ['clang-format']
let g:neoformat_c_clangformat = {
    \ 'exe': 'clang-format',
    \ 'args': ['-style=file'],
    \ }
let g:neoformat_cmake_cmakeformat = {
    \ 'exe': 'cmake-format'
    \ }
let g:neoformat_enabled_cmake = ['cmakeformat']
let g:neoformat_basic_format_trim = 1

" Toggle Lists with <leader>l and <leader>g
Plug 'Valloric/ListToggle'
let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'

" NERDTree
Plug 'scrooloose/nerdtree' | Plug 'ivalkeen/nerdtree-execute' | Plug 'Xuyuanp/nerdtree-git-plugin'
nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <c-e> :NERDTreeFind<CR>
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1

" Tags
Plug 'majutsushi/tagbar' | Plug 'ludovicchabant/vim-gutentags'
nnoremap <silent> <leader>g :TagbarToggle<CR>
let g:gutentags_cache_dir = '~/.config/nvim/gutentags_cache_dir'

" Undotree
Plug 'mbbill/undotree'
nnoremap <leader>u :UndotreeToggle<cr>
let g:undotree_SetFocusWhenToggle = 1

" Better syntax for many languages
Plug 'sheerun/vim-polyglot'

" Ale linting
Plug 'w0rp/ale'
nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
nmap <silent> ]W <Plug>(ale_last)
let g:ale_linters = {
    \ 'c': ['clangtidy'],
    \ 'cpp': ['clangtidy'],
    \ 'python': ['pylint', 'pycodestyle']
    \}
let g:ale_cpp_clangtidy_checks = [
    \ 'cppcoreguidelines-*',
    \ 'misc-*',
    \ 'modernize-*',
    \ 'performance-*',
    \ 'readability-*',
    \ 'bugprone-*',
    \ 'clang-analyzer-'
    \]
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_file_type_changed = 0
let g:ale_sign_warning = '•'
let g:ale_sign_error = '•'

" Autocompletion
Plug 'Valloric/YouCompleteMe', { 'do': 'python3 ./install.py --clang-completer' }
let g:ycm_complete_in_comments = 1
let g:ycm_error_symbol = '•'
let g:ycm_warning_symbol = '•'
let g:ycm_global_ycm_extra_conf = '$HOME/.config/nvim/.ycm_extra_conf.py'
let g:ycm_server_python_interpreter = 'python3'

" Snippets
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories = ['$HOME/.config/nvim/UltiSnips', 'UltiSnips']

" Dispatch and Projectionist
Plug 'tpope/vim-dispatch' | Plug 'tpope/vim-projectionist'
nnoremap <leader>m :Make<cr>
nnoremap <leader>d :Dispatch<cr>

" Airline
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1

" Color schemes, switch with F8
Plug 'lifepillar/vim-solarized8'
Plug 'romainl/flattened' | Plug 'xolox/vim-misc' | Plug 'xolox/vim-colorscheme-switcher'
let g:colorscheme_switcher_exclude_builtins = 1

call plug#end()

" Color scheme settings
set termguicolors
colorscheme solarized8
