# My neovim settings

## Installing neovim
[Link](https://github.com/neovim/neovim/wiki/Installing-Neovim)

## Checking out this repository

    cd ~/.config
    git clone https://github.com/thedarksideofthemoon/nvim.git

## Install Plugin Manager

    curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

## Start nvim and install plugins

    nvim
    :PlugInstall

## Compile YouCompleteMe

    cd ~/.config/nvim/plugged/YouCompleteMe
    # Select your completers
    ./install.py --clang-completer --omnisharp-completer --gocode-completer --tern-completer --racer-completer
