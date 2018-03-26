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
" Enable persistent undo (for the current session)
let s:undoDir = "/tmp/.undodir_" . $USER
if !isdirectory(s:undoDir)
    call mkdir(s:undoDir, "", 0700)
endif
let &undodir=s:undoDir
set undofile

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
endif

" Plugins
call plug#begin('~/.config/nvim/plugged')

" Plugins without settings
Plug 'jiangmiao/auto-pairs'      " Insert brackets etc.
Plug 'tpope/vim-eunuch'          " :Delete etc.
Plug 'tpope/vim-repeat'          " Repeat surround etc.
Plug 'tpope/vim-sleuth'          " Detect indentation
Plug 'tpope/vim-surround'        " Surround words
Plug 'tpope/vim-obsession'       " Record session
Plug 'mhinz/vim-startify'        " Start screen
Plug 'easymotion/vim-easymotion' " EasyMotion
Plug 'sheerun/vim-polyglot'      " Better syntax for many languages

" File explorer
Plug 'tpope/vim-vinegar'     " Fixes for netrw
let g:netrw_liststyle = 1

" Find the root directory and `cwd` to project dir
Plug 'airblade/vim-rooter'
let g:rooter_patterns = ['.projections.json', '.git/', '.svn/']

" Disable highlighting after search
Plug 'junegunn/vim-slash'
" Place the current match at the center
noremap <plug>(slash-after) zz

" Comments
Plug 'tpope/vim-commentary'
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s
autocmd FileType cmake set commentstring=#\ %s

" Git
Plug 'tpope/vim-fugitive' | Plug 'mhinz/vim-signify'
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gr :Gread<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
let g:signify_vcs_list = [ 'git', 'svn' ]

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
nnoremap <C-p> :Files<CR>
nnoremap <C-h> :History<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <C-g> :BTags<CR>
let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-s': 'vsplit' } " default ctrl-v conflicts with visual block mode
" FZF ignores first keys if height is enabled
let $FZF_DEFAULT_OPTS .= ' --no-height'
" Close FZF with ESC even though terminal mode leaves with ESC
autocmd! FileType fzf tnoremap <buffer> <ESC> <C-c>

" Format
Plug 'sbdchd/neoformat' | Plug 'fisadev/vim-isort'
nnoremap <silent> <leader>f :Neoformat<CR>
let g:neoformat_enabled_c = ['clang-format']
function! FormatFile()
  let l:lines="all"
  py3f $HOME/.config/nvim/clang-format.py
endfunction
map <C-K> :py3f $HOME/.config/nvim/clang-format.py<cr>
imap <C-K> <c-o>:py3f $HOME/.config/nvim/clang-format.py<cr>
map <C-F> :call FormatFile()<cr>
let g:neoformat_cmake_cmakeformat = {
    \ 'exe': 'cmake-format'
    \ }
let g:neoformat_enabled_cmake = ['cmakeformat']
let g:neoformat_basic_format_trim = 1
let g:vim_isort_python_version = 'python3'

" Toggle Lists with <leader>l and <leader>g
Plug 'Valloric/ListToggle'
let g:lt_location_list_toggle_map = '<leader>ll'
let g:lt_quickfix_list_toggle_map = '<leader>qq'

" Tags
Plug 'majutsushi/tagbar' | Plug 'ludovicchabant/vim-gutentags'
nnoremap <silent> <leader>g :TagbarToggle<CR>
let g:gutentags_cache_dir = '~/.config/nvim/gutentags_cache_dir'

" Undotree
Plug 'mbbill/undotree'
nnoremap <leader>u :UndotreeToggle<cr>
let g:undotree_SetFocusWhenToggle = 1

" Ale linting
Plug 'w0rp/ale'
nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
nmap <silent> ]W <Plug>(ale_last)
let g:ale_linters = {
    \ 'c': ['clangtidy'],
    \ 'cpp': ['clangtidy'],
    \ 'python': ['pylint', 'isort']
    \ }
let g:ale_fixers = {
    \ 'python': ['pylint', 'isort']
    \ }
let g:ale_cpp_clangtidy_checks = [
    \ 'cppcoreguidelines-*',
    \ 'misc-*',
    \ 'modernize-*',
    \ 'performance-*',
    \ 'readability-*',
    \ 'bugprone-*',
    \ 'clang-analyzer-'
    \ ]
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_file_type_changed = 0
let g:ale_sign_warning = '•'
let g:ale_sign_error = '•'
let g:ale_sign_column_always = 1

" " Autocompletion
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
imap <c-space> <Plug>(asyncomplete_force_refresh)

" LSP
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
nmap <leader>ld :LspDefinition<cr>
nmap <leader>lh :LspHover<cr>
nmap <leader>lf :LspReferences<cr>
nmap <leader>lr :LspRename<cr>
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_signs_error = {'text': '•'}
let g:lsp_signs_warning = {'text': '•'}
let g:lsp_signs_hint = {'text': '•'}

" Snippets
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' | Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories = ['$HOME/.config/nvim/UltiSnips', 'UltiSnips']

" Dispatch and Projectionist
Plug 'tpope/vim-dispatch' | Plug 'radenling/vim-dispatch-neovim' | Plug 'tpope/vim-projectionist'
nnoremap <leader>m :Make<cr>
nnoremap <leader>d :Dispatch<cr>
nnoremap <leader>s :Start<cr>

" Airline
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1

" Vim pencil
Plug 'reedes/vim-pencil'
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType text         call pencil#init()
augroup END
nnoremap <silent> Q gqap
xnoremap <silent> Q gq
nnoremap <silent> <leader>Q vapJgqap

" Color schemes, switch with F8
Plug 'lifepillar/vim-solarized8'

call plug#end()

" Color scheme settings
set termguicolors
colorscheme solarized8

" Completion sources
call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'whitelist': ['*'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ }))
if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif
if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
elseif executable('cquery')
   au User lsp_setup call lsp#register_server({
      \ 'name': 'cquery',
      \ 'cmd': {server_info->['cquery']},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
      \ 'initialization_options': { 'cacheDirectory': '/tmp/cquery_cache' },
      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
      \ })
endif
if has('python3')
    call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
        \ 'name': 'ultisnips',
        \ 'whitelist': ['*'],
        \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
        \ }))
endif

