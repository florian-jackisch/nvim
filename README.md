# My config for vim8 and neovim

## Installation

Clone the repository into the neovim config directory:

```bash
git clone https://github.com/florian-jackisch/nvim.git ~/.config/nvim --recursive
```

Install with the script `install_vim.sh` or `install_nvim.sh`.

This will install the font `FuraMono Nerd Font`.
If you want to use this font with advanced glyphs, set your terminal to use this font.
Additionally, add

```bash
export USE_NERDFONT=1
```

to your `~/.bashrc` and `:PlugUpdate` (n)vim.
