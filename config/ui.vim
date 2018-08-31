let g:airline#extensions#tabline#enabled = 1
if $VIM_DEVICONS == 1
    let g:airline_powerline_fonts = 1
endif

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
