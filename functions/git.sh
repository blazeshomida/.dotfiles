#! /bin/bash

function find_commit {
  local commit_hash
  local query=$1
  commit_hash=$(
    git log --oneline |
      grep -v -e "Merge" |
      fzf --preview-label='[ Git Commit Preview ]' --preview='git show {1} --summary | bat --color="always" --style="changes" && git show --format= {1} | grep -v -E "^(diff --git a|---|\+\+\+|index)" | bat --color="always" --style="changes" --language="diff"' --with-nth='2..' --preview-window='right' --query="$query"
  ) &&
    echo "Selected commit: $commit_hash" | sed -Ee 's/ :[a-zA-Z]+://g' &&
    echo "$commit_hash" | awk '{print $1}' | pbcopy
}
