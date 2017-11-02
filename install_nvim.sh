# Install the plugins
nvim +PackUpdate +qall

# Install the font
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts && curl -fLo "FuraMonoForPowerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraMono/Regular/complete/Fura%20Mono%20Regular%20Nerd%20Font%20Complete.otf
elif [[ "$unamestr" == 'Darwin' ]]; then
   brew tap caskroom/fonts
   brew cask install font-firamono-nerd-font
fi

echo "To use a font with advanced glyphs, set your terminal to use the Font FuraMonoForPowerline Nerd Font and add"
echo "    export USE_NERDFONT=1"
echo "to your bashrc."
echo "Neovim will detect the environment variable and load additional plugins after another :PlugUpdate"
