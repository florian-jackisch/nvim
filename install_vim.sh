# Symlink vimrc
ln -s ~/.config/nvim/init.vim ~/.vimrc
mkdir -p ~/.vim
ln -s ~/.config/nvim/UltiSnips ~/.vim
ln -s ~/.config/nvim/spell ~/.vim

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install the plugins
vim +PlugInstall +qall

# Link the color scheme
ln -s ~/.config/nvim/fzf_gruvbox.bash ~/.fzf_gruvbox.bash
echo "Please add the following line to your .bashrc or .fzf.bash:"
echo "source $HOME/.fzf_gruvbox.bash"
