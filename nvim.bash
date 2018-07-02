# Use nvim instead of vim
alias vim="nvim"
alias vi="nvim"
alias vimdiff='nvim -d'
export EDITOR=nvim

# Use vi keybindings in the terminal
set editing-mode vi
set keymap vi-command

# Make FZF work in vim terminal
[ -n "$NVIM_LISTEN_ADDRESS" ] && export FZF_DEFAULT_OPTS='--no-height'
