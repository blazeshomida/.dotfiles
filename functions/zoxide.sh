#! /bin/bash

alias zx='zoxide'
alias zxa='zx add'
alias zxe='zx edit'
alias zxr='zx remove'

function zxq {
  local dir
  dir=$(zx query -lsa | fzf | awk '{print $2}') &&
    echo "Selected Directory: $dir" &&
    echo "$dir" | pbcopy
}

function zxqi {
  local dir
  dir=$(zx query -isa | awk '{print $2}') &&
    echo "Selected Directory: $dir" &&
    echo "$dir" | pbcopy
}
