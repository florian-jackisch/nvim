" Install vim-plug if it is not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  execute '!curl --create-dirs -fLo ~/.config/nvim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif
