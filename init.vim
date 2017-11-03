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
" Enable folding by syntax
set foldmethod=syntax
set foldlevelstart=99
" 80 columns is the target width
set colorcolumn=80
" Highlight the current line
set cursorline
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
" Toggle wrapping and linebreak
nnoremap gw :set wrap! <bar> :set linebreak!<CR>
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
  tnoremap <Esc> <C-\><C-n>
endif

" Plugins
" =======
if exists('*minpac#init')
  call minpac#init()

  " tpope plugins
  call minpac#add('tpope/vim-commentary')
  call minpac#add('tpope/vim-dispatch')
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('tpope/vim-repeat')
  call minpac#add('tpope/vim-sensible')
  call minpac#add('tpope/vim-sleuth')
  call minpac#add('tpope/vim-surround')
  call minpac#add('tpope/vim-unimpaired')

  " Editor plugins
  call minpac#add('airblade/vim-rooter')
  call minpac#add('gioele/vim-autoswap')
  call minpac#add('junegunn/vim-easy-align')
  call minpac#add('sbdchd/neoformat')
  call minpac#add('spf13/vim-autoclose')
  call minpac#add('tmhedberg/SimpylFold')
  call minpac#add('tommcdo/vim-exchange')

  " UI plugins
  call minpac#add('Valloric/ListToggle')
  call minpac#add('Xuyuanp/nerdtree-git-plugin')
  call minpac#add('airblade/vim-gitgutter')
  call minpac#add('ivalkeen/nerdtree-execute')
  call minpac#add('junegunn/fzf', { 'do': '~/.fzf/install --all' })
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('junegunn/goyo.vim')
  call minpac#add('majutsushi/tagbar')
  call minpac#add('mbbill/undotree')
  call minpac#add('scrooloose/nerdtree')
  call minpac#add('vim-airline/vim-airline')
  call minpac#add('vim-airline/vim-airline-themes')

  " Code completion
  call minpac#add('Valloric/YouCompleteMe', {'do': 'cd ~/.config/nvim/pack/minpac/start/YouCompleteMe; python3 ./install.py --clang-completer'})
  call minpac#add('SirVer/ultisnips')
  call minpac#add('ludovicchabant/vim-gutentags')
  call minpac#add('w0rp/ale')

  " Languages
  call minpac#add('fatih/vim-go')
  call minpac#add('lervag/vimtex')
  call minpac#add('metakirby5/codi.vim')
  call minpac#add('racer-rust/vim-racer')
  call minpac#add('rust-lang/rust.vim')
  call minpac#add('sheerun/vim-polyglot')

  " Design
  call minpac#add('lifepillar/vim-solarized8', {'type': 'opt'})
  call minpac#add('saghul/vim-colortoggle')
  if $USE_NERDFONT && !has('gui_running')
    call minpac#add('ryanoasis/vim-devicons')
  endif

  " Neovim
  if has("nvim")
    call minpac#add('kassio/neoterm')
    call minpac#add('radenling/vim-dispatch-neovim')
  endif
endif

command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update()
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()

" Plugin settings
" ---------------

" Comments for C++ and CMake
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s
autocmd FileType cmake set commentstring=#\ %s

" Dispatch
nmap <leader>c :Make<cr>

" Git
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gr :Gread<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>ge :Gedit<CR>

" Always show the gutter
autocmd BufEnter * sign define dummy
autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')

" NERDTree
nnoremap <leader>ee :NERDTreeToggle<CR>
nnoremap <leader>ef :NERDTreeFind<CR>
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1

" Undotree
nnoremap <leader>uu :UndotreeToggle<cr>
let g:undotree_SetFocusWhenToggle=1

" Tagbar
nnoremap <silent> <leader>gg :TagbarToggle<CR>

" Toggle the quick and location list
let g:lt_location_list_toggle_map = '<leader>ll'
let g:lt_quickfix_list_toggle_map = '<leader>qq'

" Airline
let g:airline#extensions#tabline#enabled = 1

" FZF
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

" Neoformat
nnoremap <silent> <leader>f :Neoformat<CR>
let g:neoformat_enabled_c = ['clang-format']
let g:neoformat_c_clangformat = {
            \ 'exe': 'clang-format',
            \ 'args': ['-style=file'],
            \ }
let g:neoformat_basic_format_trim = 1

" Align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Snippets
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsEditSplit="vertical"

" Completion
let g:ycm_complete_in_comments = 1
let g:ycm_server_python_interpreter = 'python3'
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_global_ycm_extra_conf = '~/.config/nvim/.ycm_extra_conf.py'

" Ale
let g:ale_linters = {
\   'c': ['clangtidy'],
\   'cpp': ['clangtidy'],
\   'python': ['pylint'],
\}

" Tags
let g:gutentags_cache_dir = '~/.config/nvim/gutentags_cache_dir'

" Color scheme
let g:default_background_type = 'light'
let g:dark_colorscheme = 'solarized8_dark'
let g:light_colorscheme = 'solarized8_light'
nmap <leader>b :ToggleBg<CR>

" Fonts
if $USE_NERDFONT && !has('gui_running')
  let g:airline_powerline_fonts = 1
endif

" Neovim plugins
if has("nvim")
  nnoremap <silent> <leader>tt :Ttoggle<cr>
  nnoremap <silent> <leader>tr :Topen <bar> normal ,tt<cr>
  nnoremap <silent> <leader>ts :TREPLSendLine<cr>
  vnoremap <silent> <leader>ts :TREPLSendSelection<cr>
  nnoremap <silent> <leader>tf :TREPLSendFile<cr>
endif
