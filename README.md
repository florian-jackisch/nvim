# My config for vim8 and neovim

## Installation

### Clone
Clone the repository into the neovim config directory:

```bash
git clone https://github.com/florian-jackisch/nvim.git ~/.config/nvim --recursive
```

### (Optional) Install Fira Mono
If you want to use the Fira Mono font, call the `install_fira_mono.sh` script.
This will install the font `FuraMono Nerd Font`.  If you want to use this font
with advanced glyphs, set your terminal to use this font.  Additionally, add

```bash
export USE_NERDFONT=1
```

to your `~/.bashrc`.

### (Optional) Link vim8
If you want to use vim8, call the `link_vim8.sh` script.

### Install packages
Inside (n)vim, call the `:PackUpdate` command.  This will install all the
packages.  The compilation of YouCompleteMe may take a while, but you can
always compile it later with the `build_ycm.sh` script.
