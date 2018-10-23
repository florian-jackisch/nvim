let g:startify_change_to_dir = 0

" Create custom projections {{{
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
" }}}

autocmd FileType python let b:dispatch = 'python %'

" Mappings
nnoremap mm :Make<CR>
nnoremap md :Dispatch<CR>
nnoremap ms :Start<CR>
nnoremap mg :Spawn<CR>
