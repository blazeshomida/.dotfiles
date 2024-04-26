#! /bin/bash

# This function allows the user to interactively search and select a git commit from the log.
# The selected commit hash is displayed and copied to the clipboard.
function find_commit {
  local commit_hash
  commit_hash=$(
    git log --oneline --color="always" --format="%C(yellow)%h %C(magenta)%ar %C(cyan)%s" |
      fzf --ansi --with-nth="2,3.." --nth='3..' --query="$1" \
        --cycle --no-sort --prompt='Search for a commit: ' \
        --padding='2' \
        --preview-label='[ Git Commit Preview ]' \
        --preview='git show --no-patch {1} | 
            grep -v -E "^(commit|Author|Date|Merge:)" | 
            sed -e "s/^[[:space:]]*//; /^$/d" |
            bat --color="always" --style="grid,snip" && 
            git show --format="" {1} | 
            diff-so-fancy'
  ) &&
    echo "Selected commit: $commit_hash" | sed -Ee 's/ :[a-zA-Z]+://g' &&
    echo "$commit_hash" | awk '{print $1}' | pbcopy
}
