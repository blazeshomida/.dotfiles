#! /bin/bash

# Config
alias zprofile='code $HOME/.zprofile'
alias zprofilel='source $HOME/.zprofile && clear'
alias zshrc='code $HOME/.zshrc'
alias zshrcl='source $HOME/.zshrc && clear'
alias dotfiles='code $HOME/.dotfiles'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# System
alias ls='lsd --color="always" -h'
alias l='ls'
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -la'
alias pwd='pwd | pbcopy'

alias mkdir='mkdir -p'
alias mv='mv -i'
alias rm='rm -i'
alias grep='grep --color=auto -i'
alias sudo='sudo -e'

alias cd='z' # Using zoxide (for more zoxide aliases go to functions/zoxide.sh)

# Executables
alias makex='chmod +x'
alias makex-='chmod -x'

# pnpm
alias pn="pnpm"
alias pnx="pnpm dlx"

# Git
alias g='git'
alias gs='g status'
alias ga='g add'
alias gaa='g add .'
alias gc='g commit'
alias gcm='gc -m'

# Homebrew
alias get_brew_formula="brew leaves | cat"
alias get_brew_cask="brew ls --cask | cat"
alias get_brew="echo 'Formula' && get_brew_formula && echo '\nCask' && get_brew_cask"
