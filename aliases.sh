#! /bin/bash

# Define aliases
alias zshload='source $HOME/.zshrc'
alias zshopen='code $HOME/.zshrc'

alias ..='cd ..'
alias ...='cd ../..'

alias ls='ls --color="always"'
alias l='ls -lFh'
alias la='ls -lFhA'
alias ll='ls -lA -h'

alias get_brew_formula="brew leaves | cat"
alias get_brew_cask="brew ls --cask | cat"
alias get_brew="echo 'Formula' && get_brew_formula && echo '\nCask' && get_brew_cask"

alias pn="pnpm"
alias px="pnpm dlx"
