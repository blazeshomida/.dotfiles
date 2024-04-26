#! /bin/bash

function find_commit {
  local commit_hash
  local query=$1
  commit_hash=$(
    git log --oneline --color="always" --format="%C(magenta)%h %C(cyan)%s" |
      fzf --ansi --nth="2.." --query="$query" \
        --cycle --prompt='Search for a commit: ' \
        --padding='2' \
        --preview-label='[ Git Commit Preview ]' \
        --preview='git show {1} --no-patch | 
            bat --color="always" --style="grid,snip" && 
            git show {1} --format="" | 
            diff-so-fancy'
  ) &&
    echo "Selected commit: $commit_hash" | sed -Ee 's/ :[a-zA-Z]+://g' &&
    echo "$commit_hash" | awk '{print $1}' | pbcopy
}
