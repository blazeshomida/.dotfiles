#! /bin/bash

function code {
  if [[ $1 == 'z' ]]; then
    command code "$HOME/.zshrc"
    exit 0
  fi
  command code "$@"
}
