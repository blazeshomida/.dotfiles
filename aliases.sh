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
alias gs='git status'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit'
alias gcm='git commit -m'


alias ghpr="gh pr"
alias ghprc="gh pr create"
alias ghprm="gh pr merge"


# Homebrew
alias get_brew_formula="brew leaves | cat"
alias get_brew_cask="brew ls --cask | cat"
alias get_brew="echo 'Formula' && get_brew_formula && echo '\nCask' && get_brew_cask"

alias myalias="find \$DOTFILES_DIR -type f -not -path '*/bootstrap.sh' -not -path '*/.config/*' -not -path '*/.git/*' -exec awk '/^alias/ {  gsub(/\47/, \"\42\"); print }' {} +"
alias myfunctions="find \$DOTFILES_DIR -type f  -not -path '*/bootstrap.sh' -not -path '*/.config/*' -not -path '*/.git/*' -exec awk '/^function/  {  sub(/function /,\"\"); sub(/[[:space:]]{/, \"\");  print  }' {} +"

# TODO: Still a work in progres
manf() {
  local section_line_number
  section_line_number=$(man "$1" | awk '/^[A-Z]+/ && !/\(1\)$/ {print NR " " $1}' |
    fzf --with-nth="1.." | awk '{print $1}')

  local next_section_line_number
  next_section_line_number=$(man "$1" | awk -v section_line="$section_line_number" 'NR > section_line && /^[A-Z]+/ {print NR; exit}')

  local section_distance=$((next_section_line_number - section_line_number))

  man "$1" | awk -v section_line="$section_line_number" -v section_distance="$section_distance" 'NR >= section_line && NR < section_line + section_distance {print}' | bat -l man

