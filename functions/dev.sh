#!/bin/bash

DEV_DIR="$HOME/dev"

function get_dev_projects {
  zoxide query -la | grep -v -e "node_modules" -e "^$DEV_DIR$" | grep "^$DEV_DIR" | sed "s#$DEV_DIR/##g"
}

function dev_fzf {
  fzf --query="$1" --cycle \
    --preview="echo '  {}' && 
    eza --color='always' --icons='always' --git-ignore --ignore-glob='node_modules' --tree --level='2' $DEV_DIR/{} | 
    awk '(NR>1){print}' | bat --color='always' --style='grid,snip'"
}

function dev {
  if [[ -f $1 || -d $1 ]]; then
    # Argument passed is an existing file or directory, open it in VS Code
    code "$@"
  else
    # Argument passed but it does not exist, attempt to use it as a query
    local dir
    dir=$(get_dev_projects | dev_fzf "$1")
    if [[ -n "$dir" ]]; then
      code "$DEV_DIR/$dir"
    else
      echo "No directory selected."
    fi
  fi
}
