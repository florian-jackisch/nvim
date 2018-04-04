# My Neovim Settings

## Installation

1.  Clone this repository into `~/config`.
1.  Install [vim-plug](https://github.com/junegunn/vim-plug).
    ```bash
    sh ./dl-vim-plug.sh
    ```
1.  `PlugUpdate` to install all plugins.
1.  Optional 1: You can use
    [vim-devicons](https://github.com/ryanoasis/vim-devicons) if you use
    one of the [nerd-fonts](https://github.com/ryanoasis/nerd-fonts). After you
    setup your terminal, source `devicons.bash`.
1.  Optional 2: Install language servers for
    [python](https://github.com/palantir/python-language-server) and C++
    (either clangd or [cquery](https://github.com/cquery-project/cquery)).
1.  Optional 3:
    [vim-markdown-composer](https://github.com/euclio/vim-markdown-composer)
    needs to compile a binary using `rust`. You might want to install a new
    version of `rust` with `rustup`:
    ```bash
    curl https://sh.rustup.rs -sSf | sh
    ```
1.  Optional 4: You might want some formatters:
    * [yapf](https://github.com/google/yapf) and
      [isort](https://github.com/timothycrosley/isort) for python
    * [latexindent](https://github.com/cmhughes/latexindent.pl) for LaTeX
    * [cmake_format](https://github.com/cheshirekow/cmake_format) for CMake
    * [prettier](https://github.com/prettier/prettier) for Markdown
