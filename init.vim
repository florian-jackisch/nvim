" Editor Settings
let mapleader = ' '
set relativenumber number
set nowrap
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab  " 4 space tabs
set splitright
set foldmethod=indent
set foldlevelstart=99
set colorcolumn=80
set cursorline
set noswapfile
let s:undoDir = "/tmp/.undodir_" . $USER
if !isdirectory(s:undoDir)
    call mkdir(s:undoDir, "", 0700)
endif
let &undodir=s:undoDir
set undofile
set hidden
set wildmode=longest,list,full

" Keyboard Mappings
noremap j gj
noremap k gk
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
" Clear highlight with ESC
nnoremap <esc> :noh<return><esc>
" Indentation with Tab and Shift-Tab
vnoremap < <gv
vnoremap > >gv
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
" cd to current file
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Neovim Settings
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

" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'wincent/terminus'           " Enhanced terminal integration
Plug 'wellle/targets.vim'         " Targets like a for arguments
Plug 'tpope/vim-unimpaired'       " Pair mappings
Plug 'junegunn/vim-easy-align'    " Align, e.g. with vipga=
Plug 'tpope/vim-commentary'
Plug 'Valloric/ListToggle'
Plug 'wincent/loupe'              " Enhanced search
Plug 'tpope/vim-abolish'          " Enhanced search and replace
Plug 'tpope/vim-dispatch' | Plug 'radenling/vim-dispatch-neovim'
Plug 'jpalardy/vim-slime'         " Send to repl with C-c, C-c
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-eunuch'           " UNIX helpers
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-vinegar'          " Improve netrw
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'          " Gutter with VCS infos
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } | Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim' | Plug 'chriskempson/base16-shell' | Plug 'lifepillar/vim-solarized8'
Plug 'sbdchd/neoformat'
Plug 'w0rp/ale'
Plug 'ncm2/ncm2' | Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-tagprefix'
Plug 'filipekiss/ncm2-look.vim'   " Complete with look dictionary
Plug 'ncm2/ncm2-vim' | Plug 'Shougo/neco-vim'
Plug 'ncm2/ncm2-ultisnips'
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'cquery-project/cquery'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' | Plug 'gisphm/vim-gitignore'
Plug 'ludovicchabant/vim-gutentags' | Plug 'majutsushi/tagbar'
Plug 'lervag/vimtex'
Plug 'Ron89/thesaurus_query.vim'
if $VIM_DEVICONS == 1
    Plug 'ryanoasis/vim-devicons'
endif
call plug#end()

" ALE
nmap <silent> [W <Plug>(ale_first)
nmap <silent> ]W <Plug>(ale_last)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
let g:ale_linters = {
            \ 'c': ['clangtidy'],
            \ 'cpp': ['clangtidy'],
            \ 'markdown': ['markdownlint', 'write-good'],
            \ 'tex': ['lacheck', 'chktex', 'proselint', 'write-good'],
            \ 'python': ['prospector', 'mypy'],
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

" Align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Autocomplete
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
set shortmess+=c
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
let g:ncm2#complete_length = [[1,2],[7,1]]
autocmd Filetype tex call ncm2#register_source({
            \ 'name' : 'vimtex-cmds',
            \ 'priority': 8,
            \ 'complete_length': -1,
            \ 'scope': ['tex'],
            \ 'matcher': {'name': 'prefix', 'key': 'word'},
            \ 'word_pattern': '\w+',
            \ 'complete_pattern': g:vimtex#re#ncm2#cmds,
            \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
            \ })
autocmd Filetype tex call ncm2#register_source({
            \ 'name' : 'vimtex-labels',
            \ 'priority': 8,
            \ 'complete_length': -1,
            \ 'scope': ['tex'],
            \ 'matcher': {'name': 'combine',
            \             'matchers': [
            \               {'name': 'substr', 'key': 'word'},
            \               {'name': 'substr', 'key': 'menu'},
            \             ]},
            \ 'word_pattern': '\w+',
            \ 'complete_pattern': g:vimtex#re#ncm2#labels,
            \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
            \ })
autocmd Filetype tex call ncm2#register_source({
            \ 'name' : 'vimtex-files',
            \ 'priority': 8,
            \ 'complete_length': -1,
            \ 'scope': ['tex'],
            \ 'matcher': {'name': 'combine',
            \             'matchers': [
            \               {'name': 'abbrfuzzy', 'key': 'word'},
            \               {'name': 'abbrfuzzy', 'key': 'abbr'},
            \             ]},
            \ 'word_pattern': '\w+',
            \ 'complete_pattern': g:vimtex#re#ncm2#files,
            \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
            \ })
autocmd Filetype tex call ncm2#register_source({
            \ 'name' : 'bibtex',
            \ 'priority': 8,
            \ 'complete_length': -1,
            \ 'scope': ['tex'],
            \ 'matcher': {'name': 'combine',
            \             'matchers': [
            \               {'name': 'prefix', 'key': 'word'},
            \               {'name': 'abbrfuzzy', 'key': 'abbr'},
            \               {'name': 'abbrfuzzy', 'key': 'menu'},
            \             ]},
            \ 'word_pattern': '\w+',
            \ 'complete_pattern': g:vimtex#re#ncm2#bibtex,
            \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
            \ })
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

" Comments
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s
autocmd FileType cmake set commentstring=#\ %s

" Format
nnoremap <silent> <leader>f :Neoformat<CR>
let g:neoformat_enabled_python = ['black', 'isort']
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
autocmd FileType c,cpp vnoremap <buffer> <leader>f :py3f $HOME/.config/nvim/clang-format.py<cr>
autocmd FileType c,cpp nnoremap <buffer> <leader>f :call FormatFile()<cr>

" FZF
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

" Git
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
if has('nvim')
  let $VISUAL = 'nvr -cc split --remote-wait'
endif

" Lists
let g:lt_location_list_toggle_map = '<leader>ll'
let g:lt_quickfix_list_toggle_map = '<leader>qq'
nnoremap <leader>uu :UndotreeToggle<cr>
let g:undotree_SetFocusWhenToggle = 1

" Projects
let g:startify_change_to_dir = 0
" Create custom projections
augroup configure_projects
    autocmd!
    autocmd User ProjectionistActivate call s:custom_projections()
augroup END
function! s:custom_projections() abort
    let b:projections_test = projectionist#query('test')
    if len(b:projections_test) > 0
        nnoremap mt :execute "Dispatch ". b:projections_test[0][1]<CR>
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
autocmd FileType python let b:dispatch = 'python %'
nnoremap mm :Make<CR>
nnoremap md :Dispatch<CR>
nnoremap ms :Start<CR>
nnoremap mg :Spawn<CR>
let g:slime_target = "neovim"
let g:slime_dont_ask_default = 1
let g:slime_no_mappings = 1
xmap <leader>s <Plug>SlimeRegionSend
nmap <leader>s <Plug>SlimeMotionSend
nmap <leader>ss <Plug>SlimeLineSend
nmap <leader>st :let g:slime_default_config = {"jobid": b:terminal_job_id}<CR>

" Snippets
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsSnippetDirectories = ['$HOME/.config/nvim/UltiSnips', 'UltiSnips']
let g:UltiSnipsEnableSnipMate = 0

" Tags
let g:gutentags_cache_dir = '~/.config/nvim/gutentags_cache'
nnoremap <silent> <leader>gg :TagbarToggle<CR>

" Themes
let g:airline#extensions#tabline#enabled = 1
if $VIM_DEVICONS == 1
    let g:airline_powerline_fonts = 1
endif
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
hi clear SpellBad
hi SpellBad cterm=underline

" Thesaurus
let g:tq_language=['en', 'de']
nnoremap <Leader>tr :ThesaurusQueryReplaceCurrentWord<CR>
vnoremap <Leader>tr y:ThesaurusQueryReplace <C-r>"<CR>

" Unimpaired
let g:nremap = {"[": "ö", "]": "ä"}
let g:xremap = {"[": "ö", "]": "ä"}
let g:oremap = {"[": "ö", "]": "ä"}
nnoremap ö [
nnoremap ä ]
xnoremap ö [
xnoremap ä ]
onoremap ö [
onoremap ä ]
nmap äc <plug>(signify-next-hunk)
nmap öc <plug>(signify-prev-hunk)
