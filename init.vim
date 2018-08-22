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
set hidden
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
" Move quickfix list to arglist (for :argdo)
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
    " Building a hash ensures we get each buffer only once
    let buffer_numbers = {}
    for quickfix_item in getqflist()
        let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
    endfor
    return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction
" Format paragraph
nnoremap <silent> Q gqap
xnoremap <silent> Q gq
nnoremap <silent> <leader>Q vapJgqap
" }}}

" Neovim Settings {{{
if has("nvim")
    " Incremental search and replace
    set inccommand=nosplit
    " Terminal escape
    tnoremap <Esc> <c-\><C-n>
    tnoremap <c-v> <Esc><Esc>
    " Disable line numbers in the terminal
    au TermOpen * setlocal nonumber norelativenumber
    " Terminal tab
    nnoremap <leader>tt :tabedit <bar> terminal<CR>
endif
" }}}

" Plugins {{{
call plug#begin('~/.config/nvim/plugged')

" Plugins Without Settings {{{
Plug 'justinmk/vim-sneak'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'wincent/terminus'
Plug 'wellle/targets.vim'
" }}}

" Unimpaired {{{
Plug 'tpope/vim-unimpaired'
let g:nremap = {"[": "ö", "]": "ä"}
let g:xremap = {"[": "ö", "]": "ä"}
let g:oremap = {"[": "ö", "]": "ä"}
nnoremap ö [
nnoremap ä ]
xnoremap ö [
xnoremap ä ]
onoremap ö [
onoremap ä ]
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
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
Plug 'tpope/vim-abolish'
" }}}

" Project Management {{{
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-vinegar'
let g:startify_change_to_dir = 0

" Create custom projections {{{
augroup configure_projects
    autocmd!
    autocmd User ProjectionistActivate call s:custom_projections()
augroup END
function! s:custom_projections() abort
    let b:projections_lint = projectionist#query('lint')
    if len(b:projections_lint) > 0
        nnoremap <leader>ml :execute "Dispatch ". b:projections_lint[0][1]<cr>
        nnoremap <leader>mL :execute "Dispatch! ". b:projections_lint[0][1]<cr>
    endif
    let b:projections_fix = projectionist#query('fix')
    if len(b:projections_fix) > 0
        nnoremap <leader>mf :execute "Dispatch ". b:projections_fix[0][1]<cr>
        nnoremap <leader>mF :execute "Dispatch! ". b:projections_fix[0][1]<cr>
    endif
    let b:projections_test = projectionist#query('test')
    if len(b:projections_test) > 0
        nnoremap <leader>mt :execute "Dispatch ". b:projections_test[0][1]<cr>
        nnoremap <leader>mT :execute "Dispatch! ". b:projections_test[0][1]<cr>
    endif
    let b:projections_run = projectionist#query('run')
    if len(b:projections_run) > 0
        nnoremap <leader>mt :execute "Dispatch ". b:projections_run[0][1]<cr>
        nnoremap <leader>mT :execute "Dispatch! ". b:projections_run[0][1]<cr>
    endif
    let b:projections_linters = projectionist#query('linters')
    if len(b:projections_linters) > 0
        let b:ale_linters = {&filetype: b:projections_linters[0][1]}
    endif
    let b:projections_fixers = projectionist#query('fixers')
    if len(b:projections_fixers) > 0
        let b:ale_fixers = {&filetype: b:projections_fixers[0][1]}
    endif
endfunction
" }}}

nnoremap <leader>mm :Make<cr>
nnoremap <leader>mM :Make!<cr>
nnoremap <leader>md :Dispatch<cr>
nnoremap <leader>mD :Dispatch!<cr>
nnoremap <leader>ms :Start<cr>
nnoremap <leader>mS :Start!<cr>
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
" Close FZF with ESC even though terminal mode leaves with ESC
autocmd! FileType fzf tnoremap <buffer> <ESC> <C-c>
" CTRL-A CTRL-Q to select all and build quickfix list
function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
endfunction
let g:fzf_action = {
            \ 'ctrl-q': function('s:build_quickfix_list'),
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }
let $FZF_DEFAULT_OPTS .= ' --no-height --bind ctrl-a:select-all'
" Get a Rg command to call ripgrep
command! -bang -nargs=* Rg
          \ call fzf#vim#grep(
          \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
          \   <bang>0 ? fzf#vim#with_preview('up:60%')
          \           : fzf#vim#with_preview('right:50%:hidden', '?'),
          \   <bang>0)
" }}}

" Undotree {{{
Plug 'mbbill/undotree'
nnoremap <leader>uu :UndotreeToggle<cr>
let g:undotree_SetFocusWhenToggle = 1
" }}}

" Lightline {{{
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1
if $VIM_DEVICONS == 1
    Plug 'ryanoasis/vim-devicons'
    let g:airline_powerline_fonts = 1
endif
" }}}

" Color Schemes {{{
Plug 'chriskempson/base16-vim'
Plug 'chriskempson/base16-shell'
Plug 'lifepillar/vim-solarized8'
" }}}

" Linting {{{
Plug 'w0rp/ale'
nmap <silent> [W <Plug>(ale_first)
nmap <silent> ]W <Plug>(ale_last)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
nmap <leader>f :ALEFix<cr>
let g:ale_linters = {
            \ 'c': ['clangtidy'],
            \ 'cpp': ['clangtidy'],
            \ 'markdown': ['markdownlint', 'write-good'],
            \ 'tex': ['lacheck', 'chktex', 'proselint', 'write-good'],
            \ 'python': ['pylint'],
            \ }
let g:ale_fixers = {
            \ 'c': ['clang-format'],
            \ 'cpp': ['clang-format'],
            \ 'markdown': ['prettier'],
            \ 'tex': ['trim_whitespace'],
            \ 'python': ['black', 'isort'],
            \ }
let g:ale_cpp_clangtidy_checks = []
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_file_type_changed = 0
let g:ale_sign_warning = '⚠'
let g:ale_sign_error = '✖'
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
" }}}

" Autocompletion {{{
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-tagprefix'
Plug 'filipekiss/ncm2-look.vim'
Plug 'ncm2/ncm2-vim' | Plug 'Shougo/neco-vim'
Plug 'ncm2/ncm2-ultisnips'
Plug 'ncm2/ncm2-markdown-subscope'
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
set shortmess+=c
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
let g:ncm2#complete_length = [[1,2],[7,1]]
" }}}

" Language client {{{
Plug 'autozimu/LanguageClient-neovim', {
            \ 'branch': 'next',
            \ 'do': 'bash install.sh',
            \ }
Plug 'cquery-project/cquery', { 'do': '$HOME/.config/nvim/build-cquery' }
let g:LanguageClient_diagnosticsList = "Disabled"
let g:LanguageClient_serverCommands = {
            \ 'python': ['pyls'],
            \ 'cpp': ['~/.config/nvim/plugged/cquery/build/cquery', '--log-file=/tmp/cq.log', '--init={"cacheDirectory":"/tmp/cquery"}'],
            \ 'c': ['~/.config/nvim/plugged/cquery/build/cquery', '--log-file=/tmp/cq.log', '--init={"cacheDirectory":"/tmp/cquery"}'],
            \ }
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
" }}}

" Snippets {{{
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'gisphm/vim-gitignore'
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsSnippetDirectories = ['$HOME/.config/nvim/UltiSnips', 'UltiSnips']
let g:UltiSnipsEnableSnipMate = 0
" }}}

" Tags {{{
Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_cache_dir = '~/.config/nvim/gutentags_cache'
Plug 'majutsushi/tagbar'
nnoremap <silent> <leader>gg :TagbarToggle<CR>
" }}}

" Syntax and Folding {{{
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['markdown']
" Fold python
Plug 'tmhedberg/SimpylFold'
" Fold C++
Plug 'LucHermitte/VimFold4C'
let g:SimpylFold_docstring_preview = 1
Plug 'matze/vim-tex-fold'
" }}}

" Writing Tools {{{
Plug 'Ron89/thesaurus_query.vim'
let g:tq_language=['en', 'de']
nnoremap <Leader>tr :ThesaurusQueryReplaceCurrentWord<CR>
vnoremap <Leader>tr y:ThesaurusQueryReplace <C-r>"<CR>
" }}}

call plug#end()
" }}}

" Color Scheme Settings {{{
hi clear SpellBad
hi SpellBad cterm=underline
if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
    if g:colors_name == 'base16-solarized-light'
        set termguicolors
        set background=light
        colorscheme solarized8
    elseif g:colors_name == 'base16-solarized-dark'
        set termguicolors
        set background=dark
        colorscheme solarized8
    endif
endif
" }}}
