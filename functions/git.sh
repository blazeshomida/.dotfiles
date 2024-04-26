#! /bin/bash

# This function allows the user to interactively search and select a git commit from the log.
# The selected commit hash is displayed and copied to the clipboard.
function find_commit {
  local commit_hash
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
