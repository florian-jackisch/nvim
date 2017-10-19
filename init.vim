" General Settings
" ================

" Leaders
" -------
let mapleader = ' '

" Editor settings
" ---------------
set relativenumber
set number
set nowrap
set ignorecase
set smartcase
" Tabs shall be 4 spaces
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
" Open new vsplit right
set splitright
" Enable folding with space
set foldmethod=syntax
set foldlevelstart=99
" 80 columns is the target width
set colorcolumn=80
" Incremental search and replace
if has("nvim")
    set inccommand=nosplit
endif
" Highlight the current line
set cursorline

" Keyboard maps
" -------------
" Terminal window ESC
if has("nvim")
    tnoremap <Esc> <C-\><C-n>
endif
" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk
" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv
" Allow using the repeat operator with a visual selection (!)
" " http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>
" Quickly open/reload vim
nnoremap <leader>ve :edit $MYVIMRC<CR>
nnoremap <leader>vs :source $MYVIMRC<CR>
" Disable search highlight after search with <CR>
nnoremap <CR> :noh<CR><CR>
" Toggle wrapping and linebreak
nnoremap gw :set wrap! <bar> :set linebreak!<CR>

" Plugins
" =======
call plug#begin()

" Tim Pope plugins
" ----------------
" Default vim settings
Plug 'tpope/vim-sensible'
" Surround
Plug 'tpope/vim-surround'
" Comments with gc
Plug 'tpope/vim-commentary'
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s
autocmd FileType cmake set commentstring=#\ %s
" Git
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
" Always show the gutter
autocmd BufEnter * sign define dummy
autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
" Repeat for plugins
Plug 'tpope/vim-repeat'
" Handy combinations with `[` and `]`
" b - buffer
" q - quickfix
" f - file in directory
" ob - background
" oi - ignorecase
" os - spell
" ow - wrap
Plug 'tpope/vim-unimpaired'
" Detect indentation automatically
Plug 'tpope/vim-sleuth'

" UI plugins
" ----------
" NERDTree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ivalkeen/nerdtree-execute'
nnoremap <leader>ee :NERDTreeToggle<CR>
nnoremap <leader>ef :NERDTreeFind<CR>
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
" Undotree
Plug 'mbbill/undotree'
nnoremap <leader>u :UndotreeToggle<cr>
let g:undotree_SetFocusWhenToggle=1
" Tagbar
Plug 'majutsushi/tagbar'
nnoremap <silent> <leader>gg :TagbarToggle<CR>
" vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Open neovim terminal with :T <command>
if has("nvim")
    " Send to REPL with TREPLSendFile, TREPLSend
    Plug 'kassio/neoterm'
    " Open terminal and execute the command stored with Tmap
    " Toggle the terminal
    nnoremap <silent> <leader>tt :Ttoggle<cr>
    " Run the mapped command
    nnoremap <silent> <leader>tr :Topen <bar> normal ,tt<cr>
    " Send to the REPL
    nnoremap <silent> <leader>ts :TREPLSendLine<cr>
    vnoremap <silent> <leader>ts :TREPLSendSelection<cr>
    nnoremap <silent> <leader>tf :TREPLSendFile<cr>
endif
" Toggle the quick and location list
Plug 'Valloric/ListToggle'
let g:lt_location_list_toggle_map = '<leader>ll'
let g:lt_quickfix_list_toggle_map = '<leader>qq'

" Search plugins
" --------------
" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <C-g> :Tags<CR>

" Editor plugins
" --------------
" Exchange with cx
Plug 'tommcdo/vim-exchange'
" Create closing braces
Plug 'spf13/vim-autoclose'
let g:autoclose_vim_commentmode = 1
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
" Stop complaining that swap files can be deleted
Plug 'gioele/vim-autoswap'
" Improved folding for python
Plug 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview=1
" Align with ga
Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" Change working directory to the project root
Plug 'airblade/vim-rooter'

" Completion plugins
" ------------------
" YCM
Plug 'Valloric/YouCompleteMe'
let g:ycm_complete_in_comments = 1
let g:ycm_server_python_interpreter = 'python3'
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_global_ycm_extra_conf = '~/.config/nvim/.ycm_extra_conf.py'

" Snippet engine
Plug 'SirVer/ultisnips'
" Snippets
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsEditSplit="vertical"
" Linting
Plug 'neomake/neomake'
" Use the makeprg, eg. let &makeprg = 'build -C -j ./build'
nmap <leader>c :Neomake!<cr>
" Automatically run the linter on save
autocmd! BufWritePost * Neomake
let g:neomake_cpp_enabled_makers = ['clangtidy']
let g:neomake_cpp_clangtidy_args = ['-checks=\*']
" Automatic tag creation
Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_cache_dir = '~/.config/nvim/gutentags_cache_dir'

" Language plugins
" ----------------
" Doxygen
Plug 'vim-scripts/DoxygenToolkit.vim'
" QML
Plug 'calincru/qml.vim'
" Go
Plug 'fatih/vim-go'
" Treat geany files like go files
au BufNewFile,BufRead *.geany set filetype=go
" Rust
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
au FileType rust nmap <leader>r :RustRun<CR>
set hidden
let g:rustfmt_autosave = 1
" Python
Plug 'vim-scripts/indentpython.vim'
" XML
Plug 'alvan/vim-closetag'
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.xml"
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
" C++
Plug 'octol/vim-cpp-enhanced-highlight'
" Scratchpad for multiple languages
Plug 'metakirby5/codi.vim'

" Color schemes
" -------------
" Plug 'chriskempson/base16-vim'
" let base16colorspace=256  " Access colors present in 256 colorspace
Plug 'lifepillar/vim-solarized8'

Plug 'saghul/vim-colortoggle'
let g:light_colorscheme = "solarized8_light"
let g:dark_colorscheme = "solarized8_dark"
let g:default_background_type = "light"
nmap <leader>b :ToggleBg<CR>
set termguicolors " true color

call plug#end()

