#! /bin/bash

alias zx='zoxide'
alias zxa='zx add'
alias zxe='zx edit'
alias zxr='zx remove'

function zxq {
  zx query -lsa | fzf | awk '{print $2}' | pbcopy
}

function zxqi {
  zx query -isa | awk '{print $2}' | pbcopy
}
