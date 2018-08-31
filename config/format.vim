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
