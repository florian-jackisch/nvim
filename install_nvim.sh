# Install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install the plugins
nvim +PlugInstall +qall

# Link the FZF color scheme
ln -s ~/.config/nvim/fzf_gruvbox.bash ~/.fzf_gruvbox.bash
echo "Please add the following line to your .bashrc or .fzf.bash:"
echo "source $HOME/.fzf_gruvbox.bash"
