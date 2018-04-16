" vim:fdm=marker foldlevel=0

" Leaders {{{
let mapleader = ' '
" }}}

" Editor Settings {{{
" Relative line numbers
set relativenumber number
" Line wrapping is not the default
set nowrap
" Tabs shall be 4 spaces
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
" Open new vsplit right
set splitright
" Enable folding by syntax
set foldmethod=manual foldlevelstart=99
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
" }}}

" Keyboard Mappings {{{
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
" }}}

" Neovim Settings {{{
if has("nvim")
    " Incremental search and replace
    set inccommand=nosplit
    " terminal escape
    tnoremap <Esc> <c-\><C-n>
    tnoremap <c-v> <Esc><Esc>
    " Disable line numbers in the terminal
    au TermOpen * setlocal nonumber norelativenumber
endif
" }}}

" Plugins {{{
call plug#begin('~/.config/nvim/plugged')

" Core Plugins {{{
Plug 'easymotion/vim-easymotion'
Plug 'jiangmiao/auto-pairs'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'wincent/terminus'
" }}}

" Unimpaired {{{
Plug 'tpope/vim-unimpaired'
nmap ö [
nmap ä ]
omap ö [
omap ä ]
xmap ö [
xmap ä ]noremap <silent> <leader>ge :Gedit<CR>
" }}}

" Align {{{
Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

" Comments {{{
Plug 'tpope/vim-commentary'
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s
autocmd FileType cmake set commentstring=#\ %s
" }}}

" Toggle Lists {{{
Plug 'Valloric/ListToggle'
let g:lt_location_list_toggle_map = '<leader>ll'
let g:lt_quickfix_list_toggle_map = '<leader>qq'
" }}}

" Searching {{{
Plug 'wincent/loupe'
Plug 'junegunn/vim-slash'
Plug 'tpope/vim-abolish'
" }}}

" Project Management {{{
Plug 'tpope/vim-vinegar'
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-obsession'
let g:netrw_liststyle = 1
let g:rooter_patterns = ['.projections.json', '.git/', '.svn/']
nnoremap <leader>m :Make<cr>
nnoremap <leader>M :Make!<cr>
nnoremap <leader>d :Dispatch<cr>
nnoremap <leader>D :Dispatch!<cr>
nnoremap <leader>s :Start<cr>
nnoremap <leader>S :Start!<cr>
" }}}

" Git {{{
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
" }}}

" FZF {{{
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
" }}}

" Undotree {{{
Plug 'mbbill/undotree'
nnoremap <leader>u :UndotreeToggle<cr>
let g:undotree_SetFocusWhenToggle = 1
" }}}

" Airline {{{
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
" }}}

" Color Schemes {{{
Plug 'lifepillar/vim-solarized8'
Plug 'morhetz/gruvbox'
let g:gruvbox_contrast_light='hard'
let g:gruvbox_italic = 1
nnoremap <silent> [oh :call gruvbox#hls_show()<CR>
nnoremap <silent> ]oh :call gruvbox#hls_hide()<CR>
nnoremap <silent> coh :call gruvbox#hls_toggle()<CR>
nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?
" }}}

" Format {{{
Plug 'sbdchd/neoformat'
nnoremap <silent> <leader>f :Neoformat<CR>
let g:neoformat_enabled_python = ['yapf', 'isort']
let g:neoformat_enabled_latex = ['latexindent']
let g:neoformat_enabled_cmake = ['cmake_format']
let g:neoformat_enabled_markdown = ['prettier']
let g:neoformat_run_all_formatters = 1
let g:neoformat_basic_format_trim = 1
let g:neoformat_basic_format_align = 1
function! FormatFile()
    let l:lines="all"
    py3f $HOME/.config/nvim/clang-format.py
endfunction
autocmd FileType c,cpp vnoremap <leader>f :py3f $HOME/.config/nvim/clang-format.py<cr>
autocmd FileType c,cpp nnoremap <leader>f :call FormatFile()<cr>
" }}}

" Linting {{{
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
let g:ale_sign_warning = '⚠'
let g:ale_sign_error = '✖'
let g:ale_sign_column_always = 1
" }}}

" Autocompletion {{{
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'    " Buffer completion
Plug 'prabirshrestha/asyncomplete-file.vim'      " Path completion
Plug 'prabirshrestha/asyncomplete-ultisnips.vim' " Snippet completion
Plug 'prabirshrestha/asyncomplete-tags.vim'      " Tag completion
Plug 'Shougo/neco-syntax'                        " Vim completion
Plug 'prabirshrestha/asyncomplete-necosyntax.vim'
Plug 'prabirshrestha/asyncomplete-necovim.vim'
Plug 'prabirshrestha/async.vim'                  " LSP completion
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'cquery-project/cquery', { 'do': './waf configure build' }
Plug 'pdavydov108/vim-lsp-cquery'
let g:asyncomplete_remove_duplicates = 1
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
set completeopt+=preview
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
imap <c-space> <Plug>(asyncomplete_force_refresh)
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '⚠'}
" }}}

" Snippets {{{
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories = ['$HOME/.config/nvim/UltiSnips', 'UltiSnips']
" }}}

" Tags {{{
Plug 'ludovicchabant/vim-gutentags', { 'tag': 'v1.0.0' }
Plug 'majutsushi/tagbar'
nnoremap <silent> <leader>gg :TagbarToggle<CR>
let g:gutentags_cache_dir = '~/.config/nvim/gutentags_cache_dir'
" }}}

" Syntax and Folding {{{
Plug 'sheerun/vim-polyglot'
Plug 'tmhedberg/SimpylFold'  " Python folding
Plug 'LucHermitte/VimFold4C' " C++ folding
let g:polyglot_disabled = ['latex']
let g:SimpylFold_docstring_preview = 1
" }}}

" Python {{{
Plug 'roxma/python-support.nvim'
let g:python_support_python2_require = 0
let g:python_support_python3_venv = 0
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]), 'isort')
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]), 'yapf')
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]), 'pylint')
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]), 'python-language-server')
" }}}

" Writing {{{

" Writing Tools {
Plug 'reedes/vim-wordy'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'Ron89/thesaurus_query.vim'
Plug 'rhysd/vim-grammarous'
nnoremap <leader>w :NextWordy<space><cr>
nnoremap <silent> Q gqap
xnoremap <silent> Q gq
nnoremap <silent> <leader>Q vapJgqap
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
let g:tq_language=['en', 'de']
" }

" LaTeX {
Plug 'lervag/vimtex'
" }

" Markdown {
if executable('cargo')
    function! BuildComposer(info)
        if a:info.status != 'unchanged' || a:info.force
            if has('nvim')
                !cargo build --release
            else
                !cargo build --release --no-default-features --features json-rpc
            endif
        endif
    endfunction
    Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
endif
" }

" }}}

" Devicons (needs to be loaded last) {{{
if !empty($DEVICONS)
    Plug 'ryanoasis/vim-devicons'
    let g:airline_powerline_fonts = 1
endif
" }}}

call plug#end()
" }}}

" Color Scheme Settings {{{
set termguicolors
set background=dark
colorscheme gruvbox
" }}}

" Completion Providers {{{
" Buffers {{{
call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
            \ 'name': 'buffer',
            \ 'whitelist': ['*'],
            \ 'blacklist': ['go'],
            \ 'completor': function('asyncomplete#sources#buffer#completor'),
            \ }))
""" }}}
" Files {{{
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
            \ 'name': 'file',
            \ 'whitelist': ['*'],
            \ 'priority': 10,
            \ 'completor': function('asyncomplete#sources#file#completor')
            \ }))
""" }}}
" Snippets {{{
if has('python3')
    call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
                \ 'name': 'ultisnips',
                \ 'whitelist': ['*'],
                \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
                \ }))
endif
""" }}}
" {{{ Vim
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#necosyntax#get_source_options({
            \ 'name': 'necosyntax',
            \ 'whitelist': ['*'],
            \ 'completor': function('asyncomplete#sources#necosyntax#completor'),
            \ }))
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#necovim#get_source_options({
            \ 'name': 'necovim',
            \ 'whitelist': ['vim'],
            \ 'completor': function('asyncomplete#sources#necovim#completor'),
            \ }))
" }}}
" Tags {{{
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#tags#get_source_options({
            \ 'name': 'tags',
            \ 'whitelist': ['c'],
            \ 'completor': function('asyncomplete#sources#tags#completor'),
            \ 'config': {
            \    'max_file_size': 50000000,
            \  },
            \ }))
" }}}
" LSP {{{
" C++ {{{
au User lsp_setup call lsp#register_server({
            \ 'name': 'cquery',
            \ 'cmd': {server_info->['cquery']},
            \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
            \ 'initialization_options': { 'cacheDirectory': '/tmp/cquery_cache' },
            \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
            \ })
" }}}
" Python {{{
if executable('pyls')
    au User lsp_setup call lsp#register_server({
                \ 'name': 'pyls',
                \ 'cmd': {server_info->['pyls']},
                \ 'whitelist': ['python'],
                \ })
endif
" }}}
" }}}
" }}}
