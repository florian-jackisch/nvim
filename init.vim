" vim: fdm=marker

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

Plug 'justinmk/vim-sneak'         " Search with s
Plug 'jiangmiao/auto-pairs'       " Auto close pairs
Plug 'tpope/vim-repeat'           " Enable more repetitions
Plug 'tpope/vim-surround'         " Surround with s
Plug 'wincent/terminus'           " Enhanced terminal integration
Plug 'wellle/targets.vim'         " Targets like a for arguments
Plug 'tpope/vim-unimpaired'       " Pair mappings
Plug 'junegunn/vim-easy-align'    " Align, e.g. with vipga=
Plug 'tpope/vim-commentary'       " Comment mappings
Plug 'Valloric/ListToggle'        " Open quickfix and location list
Plug 'wincent/loupe'              " Enhanced search
Plug 'tpope/vim-abolish'          " Enhanced search and replace
Plug 'tpope/vim-dispatch' | Plug 'radenling/vim-dispatch-neovim'
                                  " Run dispatch in nvim terminal
Plug 'mhinz/vim-startify'         " Start page
Plug 'tpope/vim-eunuch'           " UNIX helpers
Plug 'tpope/vim-projectionist'    " Use projections.json files
Plug 'tpope/vim-vinegar'          " Improve netrw
Plug 'tpope/vim-fugitive'         " Git UI
Plug 'mhinz/vim-signify'          " Gutter with VCS infos
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } | Plug 'junegunn/fzf.vim'
                                  " FZF search executable
Plug 'mbbill/undotree'            " Undo UI
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
                                  " Modeline
Plug 'chriskempson/base16-vim' | Plug 'chriskempson/base16-shell'
                                  " Multiple themes
Plug 'lifepillar/vim-solarized8'  " Solarized theme
Plug 'sbdchd/neoformat'           " Format code with <leader>f
Plug 'w0rp/ale'                   " Async linting
Plug 'ncm2/ncm2' | Plug 'roxma/nvim-yarp'
                                  " Autocomplete
Plug 'ncm2/ncm2-bufword'          " Complete buffers
Plug 'ncm2/ncm2-path'             " Complete path
Plug 'ncm2/ncm2-tagprefix'        " Complete tags
Plug 'filipekiss/ncm2-look.vim'   " Complete with look dictionary
Plug 'ncm2/ncm2-vim' | Plug 'Shougo/neco-vim'
                                  " Complete vim
Plug 'ncm2/ncm2-ultisnips'        " Complete snippets
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
                                  " Language server
Plug 'cquery-project/cquery', { 'do': '$HOME/.config/nvim/build-cquery' }
                                  " C++ language server
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' | Plug 'gisphm/vim-gitignore'
                                  " Snippets
Plug 'ludovicchabant/vim-gutentags' | Plug 'majutsushi/tagbar'
                                  " Tags
Plug 'sheerun/vim-polyglot'       " Multiple languages
Plug 'lervag/vimtex'              " LaTeX
Plug 'matze/vim-tex-fold'         " LaTeX folding
Plug 'Ron89/thesaurus_query.vim'  " Thesaurus
if $VIM_DEVICONS == 1
    Plug 'ryanoasis/vim-devicons' " Pretty icons
endif

call plug#end()

source ~/.config/nvim/config/align.vim
source ~/.config/nvim/config/autocomplete.vim
source ~/.config/nvim/config/comments.vim
source ~/.config/nvim/config/format.vim
source ~/.config/nvim/config/fzf.vim
source ~/.config/nvim/config/git.vim
source ~/.config/nvim/config/languages.vim
source ~/.config/nvim/config/languages.vim
source ~/.config/nvim/config/lint.vim
source ~/.config/nvim/config/lists.vim
source ~/.config/nvim/config/projects.vim
source ~/.config/nvim/config/snippets.vim
source ~/.config/nvim/config/tags.vim
source ~/.config/nvim/config/ui.vim
source ~/.config/nvim/config/unimpaired.vim
" }}}

