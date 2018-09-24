" ncm2
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

" Language client
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
