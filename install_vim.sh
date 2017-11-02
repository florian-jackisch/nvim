# Symlink vimrc
ln -s ~/.config/nvim/init.vim ~/.vimrc
mkdir -p ~/.vim
ln -s ~/.config/nvim/UltiSnips ~/.vim
ln -s ~/.config/nvim/spell ~/.vim

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install the plugins
nvim +PlugInstall +qall
nvim +PlugUpgrade +PlugUpdate +PromptlineSnapshot ~/.shell_prompt.sh airline +qall

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
echo "Vim will detect the environment variable and load additional plugins after another :PlugUpdate"
echo ""
echo "You might also want to use the airline prompt in your terminal. To do so, add"
echo "    source ~/.shell_prompt.sh"
echo "to your bashrc."
