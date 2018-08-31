nmap <silent> [W <Plug>(ale_first)
nmap <silent> ]W <Plug>(ale_last)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
let g:ale_linters = {
            \ 'c': ['clangtidy'],
            \ 'cpp': ['clangtidy'],
            \ 'markdown': ['markdownlint', 'write-good'],
            \ 'tex': ['lacheck', 'chktex', 'proselint', 'write-good'],
            \ 'python': ['pylint'],
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
