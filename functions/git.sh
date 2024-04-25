#! /bin/bash

function fcommit {
  local commit_hash
  commit_hash=$(git log --oneline | fzf) &&
    echo "Selected commit: $commit_hash" &&
    echo "$commit_hash" | awk '{print $1}' | pbcopy
}
