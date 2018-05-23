" vim:fdm=marker foldlevel=0

" Editor Settings {{{
" Leader
let mapleader = ' '
" Relative line numbers
set relativenumber number
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
" Resize the window easily
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

" Plugins Without Settings {{{
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
xmap ä ]
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
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-vinegar'
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
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gu :Git pull<CR>
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
" Clang format is slow when called through neoformat
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
nmap <silent> ]W <Plug>(ale_last)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
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
Plug 'Valloric/YouCompleteMe'
let g:ycm_python_binary_path = 'python3'
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_error_symbol = '✖'
let g:ycm_warning_symbol = '⚠'
let g:ycm_complete_in_comments = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_key_detailed_diagnostics = '<leader>ld'
nnoremap <leader>lg :YcmCompleter GoTo<CR>
nnoremap <leader>lt :YcmCompleter GetType<CR>
nnoremap <leader>lh :YcmCompleter GetDoc<CR>
nnoremap <leader>lf :YcmCompleter FixIt<CR>
" }}}

" Snippets {{{
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
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
" Fold python
Plug 'tmhedberg/SimpylFold'
" Fold C++
Plug 'LucHermitte/VimFold4C'
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

" Writing Tools {{{
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
nnoremap <Leader>tr :ThesaurusQueryReplaceCurrentWord<CR>
vnoremap <Leader>tr y:ThesaurusQueryReplace <C-r>"<CR>
" }}}

" LaTeX {{{
Plug 'matze/vim-tex-fold'
" }}}

" Markdown {{{
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
set background=light
colorscheme solarized8
" }}}
