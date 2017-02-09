# My neovim settings

## Installing neovim
[Link](https://github.com/neovim/neovim/wiki/Installing-Neovim)

## Checking out this repository

    cd ~/.config
    git clone https://github.com/thedarksideofthemoon/nvim.git

## Install Plugin Manager

    curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

## Install the python dependencies
    pip3 install neovim

## Start nvim and install plugins

    nvim
    :PlugInstall

## Install Rust

    curl https://sh.rustup.rs -sSf | sh

Then follow the onscreen instructions (c.f. [rustup Readme](https://github.com/rust-lang-nursery/rustup.rs)).

Install racer:

    cargo install racer

Install the source code for racer:

    rustup component add rust-src

Edit your .bashrc to contain the following lines:

    # Rust
    export PATH="$HOME/.cargo/bin:$PATH"
    # For Racer
    export CARGO_HOME="$HOME/.cargo"
    export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

## Setup clang completion for deoplete

Edit your .bashrc to contain the following lines:

    # Neovim C++ autocompletion
    export LIBCLANG_PATH="/usr/local/Cellar/llvm/3.9.1/lib/libclang.dylib"
    export CLANG_INCLUDE_PATH="/usr/local/Cellar/llvm/3.9.1/include/clang"

## Install livedown

    npm install -g livedown
